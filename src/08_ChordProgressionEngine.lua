-- ============================================================================
-- MÓDULO 8: MOTOR AVANZADO DE PROGRESIONES DE ACORDES Y VOICINGS (MINIMAL ENERGY & MICRO-SWING)
-- ============================================================================

local INTERVALOS_TIPO_ACORDE = {
    triada_mayor = { 0, 4, 7 },
    triada_menor = { 0, 3, 7 },
    maj7         = { 0, 4, 7, 11 },
    min7         = { 0, 3, 7, 10 },
    dom7         = { 0, 4, 7, 10 },
    maj9         = { 0, 4, 7, 11, 14 },
    min9         = { 0, 3, 7, 10, 14 },
    dom9         = { 0, 4, 7, 10, 14 },
    dom13        = { 0, 4, 7, 10, 14, 21 },
    add9         = { 0, 4, 7, 14 },
    sus4         = { 0, 5, 7 },
    sus2         = { 0, 2, 7 },
    dim7         = { 0, 3, 6, 9 },
    dom7alt      = { 0, 4, 6, 10, 13 }
}

--- Construir las notas en pitch absoluto para un grado y tipo de acorde
local function construirNotasAcorde(gradoRaiz, tipoAcorde, tonica, escalaIndices)
    local escala = escalaIndices or { 0, 2, 4, 5, 7, 9, 11 }
    -- Subir la raiz a octava 5 (tonica + 60, ej. C4 = 60) para adaptarse perfectamente a voces femeninas (Teto/Mai)
    local pitchRaiz = transponerPorGradosEscala(tonica + 60, gradoRaiz - 1, tonica, escala)

    local relIntervals = INTERVALOS_TIPO_ACORDE[tipoAcorde] or INTERVALOS_TIPO_ACORDE.triada_mayor
    local notasSuperiores = {}

    for i = 1, #relIntervals do
        notasSuperiores[i] = pitchRaiz + relIntervals[i]
    end

    -- Nota del bajo en registro comodo de contralto/baritono (C3 - B3, rango 48-59)
    local pitchBajo = (pitchRaiz % 12) + 48
    if pitchBajo < 48 then pitchBajo = pitchBajo + 12 end

    return pitchBajo, notasSuperiores
end

--- Algoritmo de Conducción de Voces de Energía Mínima (Minimal Energy Voice Leading)
local function optimizarConduccionVoces(notasNuevas, notasPrevias)
    if not notasPrevias or #notasPrevias == 0 then
        return notasNuevas
    end

    local numVoces = #notasNuevas
    local mejorInversion = {}
    local menorEnergia = 99999999

    -- Probar giros de inversión y desplazamientos de octava para minimizar la energía total de desplazamiento \sum (\Delta pitch)^2
    for inv = 0, numVoces - 1 do
        local candidato = {}
        for v = 1, numVoces do
            local idx = ((v - 1 + inv) % numVoces) + 1
            local octShift = math.floor((v - 1 + inv) / numVoces) * 12
            candidato[v] = notasNuevas[idx] + octShift
        end

        local energiaTotal = 0
        local limiteComparacion = math.min(#candidato, #notasPrevias)
        for c = 1, limiteComparacion do
            local diff = candidato[c] - notasPrevias[c]
            energiaTotal = energiaTotal + (diff * diff)
        end

        if energiaTotal < menorEnergia then
            menorEnergia = energiaTotal
            mejorInversion = candidato
        end
    end

    return mejorInversion
end

--- Generar notas y pistas para una progresión de acordes profesional
local function generarProgresionAcordes(proyecto, pistaBase, progresionIdx, tonica, escalaIdx, ritmoIdx, fIntensidad, configPreset, timeAxis, groupRefBase)
    local escalaIndices = ESCALAS_AVANZADAS[escalaIdx] or ESCALAS_AVANZADAS[2]
    local datosProgresion = PROGRESIONES_ACORDES[progresionIdx] or PROGRESIONES_ACORDES[0]
    local gradosAcordes = datosProgresion.grados or { 4, 5, 3, 6 }
    local tiposAcordes = datosProgresion.tipos or { "maj7", "dom7", "min7", "min7" }

    local numCompases = #gradosAcordes
    local durCompasBlicks = SV.QUARTER * 4

    local startBlick = 0
    if groupRefBase then
        startBlick = groupRefBase:getOnset()
        local groupDur = groupRefBase:getDuration()
        if groupDur > 0 then
            durCompasBlicks = math.max(SV.QUARTER / 2, math.floor(groupDur / numCompases))
        end
    else
        local reproductor = SV:getPlayback()
        startBlick = reproductor:getPlayhead()
    end
    local totalChordBlicks = numCompases * durCompasBlicks

    local function obtenerOCrearPista(nombrePista)
        local totalP = proyecto:getNumTracks()
        for i = 1, totalP do
            local t = proyecto:getTrack(i)
            if t:getName() == nombrePista then
                return t
            end
        end
        local tNueva = SV:create("Track")
        tNueva:setName(nombrePista)
        proyecto:addTrack(tNueva)
        return tNueva
    end

    local langIdx = _G.idiomaDetectado or 0
    local tr = I18N_DATA[langIdx] or I18N_DATA[0]

    -- Obtener o crear pista para el Bajo
    local nombreBajo = tr.trackBassName or "Acordes Bajo"
    local pistaBajo = obtenerOCrearPista(nombreBajo)
    local groupBajo = SV:create("NoteGroup")
    proyecto:addNoteGroup(groupBajo)
    local refBajo = SV:create("NoteGroupReference")
    refBajo:setTarget(groupBajo)
    refBajo:setTimeOffset(startBlick)
    refBajo:setTimeRange(startBlick, totalChordBlicks)
    pistaBajo:addGroupReference(refBajo)

    -- Determinar el máximo número de voces superiores
    local maxVocesSuperiores = 3
    for cIdx = 1, numCompases do
        local tipoActual = tiposAcordes[cIdx] or "triada_mayor"
        local relInt = INTERVALOS_TIPO_ACORDE[tipoActual] or { 0, 4, 7 }
        if #relInt > maxVocesSuperiores then
            maxVocesSuperiores = #relInt
        end
    end

    -- Obtener o crear pistas para las voces superiores
    local pistasVoces = {}
    local groupsVoces = {}
    for v = 1, maxVocesSuperiores do
        local nombreVoz = string.format(tr.trackVoiceName or "Acordes Voz %d", v)
        local pV = obtenerOCrearPista(nombreVoz)
        local gV = SV:create("NoteGroup")
        proyecto:addNoteGroup(gV)
        local rV = SV:create("NoteGroupReference")
        rV:setTarget(gV)
        rV:setTimeOffset(startBlick)
        rV:setTimeRange(startBlick, totalChordBlicks)
        pV:addGroupReference(rV)
        pistasVoces[v] = pV
        groupsVoces[v] = gV
    end

    local notasCreadas = 0
    local currBlick = 0 -- Posición relativa a startBlick dentro del grupo
    local vocesSuperioresPrevias = nil
    local swingAmount = factorSwing or 0.20 -- 20% micro-swing por defecto

    for cIdx = 1, numCompases do
        local gradoActual = gradosAcordes[cIdx]
        local tipoActual = tiposAcordes[cIdx] or "triada_mayor"

        local pitchBajo, vocesBrutas = construirNotasAcorde(gradoActual, tipoActual, tonica, escalaIndices)
        local vocesSuperiores = optimizarConduccionVoces(vocesBrutas, vocesSuperioresPrevias)
        vocesSuperioresPrevias = vocesSuperiores

        -- 1. Agregar Nota de Bajo
        local notaBajo = SV:create("Note")
        notaBajo:setTimeRange(currBlick, durCompasBlicks)
        notaBajo:setPitch(pitchBajo)
        notaBajo:setLyrics("u")
        groupBajo:addNote(notaBajo)
        notasCreadas = notasCreadas + 1

        -- 2. Patrones Rítmicos para Voces Superiores con Micro-Swing
        if ritmoIdx == 0 then
            -- Pad Sostenido Legato
            for v = 1, #vocesSuperiores do
                local nUpper = SV:create("Note")
                nUpper:setTimeRange(currBlick, durCompasBlicks)
                nUpper:setPitch(vocesSuperiores[v])
                nUpper:setLyrics((v % 2 == 0) and "a" or "o")
                if groupsVoces[v] then
                    groupsVoces[v]:addNote(nUpper)
                end
                notasCreadas = notasCreadas + 1
            end
        elseif ritmoIdx == 1 then
            -- Comping Sincopado (Negras con micro-swing en tiempos 2 y 4)
            local durPulso = SV.QUARTER
            for p = 0, 3 do
                local offbeatShift = (p % 2 == 1) and math.floor(durPulso * swingAmount * 0.5) or 0
                local bPulse = currBlick + (p * durPulso) + offbeatShift
                for v = 1, #vocesSuperiores do
                    local nUpper = SV:create("Note")
                    nUpper:setTimeRange(bPulse, durPulso - 20)
                    nUpper:setPitch(vocesSuperiores[v])
                    nUpper:setLyrics("la")
                    if groupsVoces[v] then
                        groupsVoces[v]:addNote(nUpper)
                    end
                    notasCreadas = notasCreadas + 1
                end
            end
        elseif ritmoIdx == 2 then
            -- Arpegio Cascadas (Corcheas 1/8 con micro-swing en corcheas débiles)
            local durCorchea = math.floor(SV.QUARTER / 2)
            local totalPasos = 8
            for a = 0, totalPasos - 1 do
                local swingShift = (a % 2 == 1) and math.floor(durCorchea * swingAmount) or 0
                local bArp = currBlick + (a * durCorchea) + swingShift
                local idxVoz = (a % #vocesSuperiores) + 1
                local nUpper = SV:create("Note")
                nUpper:setTimeRange(bArp, durCorchea - 10)
                nUpper:setPitch(vocesSuperiores[idxVoz])
                nUpper:setLyrics("lu")
                if groupsVoces[idxVoz] then
                    groupsVoces[idxVoz]:addNote(nUpper)
                end
                notasCreadas = notasCreadas + 1
            end
        elseif ritmoIdx == 3 then
            -- Chop Semicorcheas con micro-swing kinético
            local durSemi = math.floor(SV.QUARTER / 4)
            local patronChop = { 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1 }
            for s = 0, 15 do
                if patronChop[s + 1] == 1 then
                    local swingShift = (s % 2 == 1) and math.floor(durSemi * swingAmount * 0.8) or 0
                    local bChop = currBlick + (s * durSemi) + swingShift
                    for v = 1, #vocesSuperiores do
                        local nUpper = SV:create("Note")
                        nUpper:setTimeRange(bChop, durSemi - 15)
                        nUpper:setPitch(vocesSuperiores[v])
                        nUpper:setLyrics("da")
                        if groupsVoces[v] then
                            groupsVoces[v]:addNote(nUpper)
                        end
                        notasCreadas = notasCreadas + 1
                    end
                end
            end
        else
            -- Bajo Alternado + Strum con micro-swing en acentos
            local durPulso = SV.QUARTER
            for p = 0, 3 do
                local swingShift = (p % 2 == 1) and math.floor(durPulso * swingAmount * 0.5) or 0
                local bPulse = currBlick + (p * durPulso) + swingShift
                if p == 1 or p == 3 then
                    for v = 1, #vocesSuperiores do
                        local nUpper = SV:create("Note")
                        nUpper:setTimeRange(bPulse, durPulso - 25)
                        nUpper:setPitch(vocesSuperiores[v])
                        nUpper:setLyrics("pa")
                        if groupsVoces[v] then
                            groupsVoces[v]:addNote(nUpper)
                        end
                        notasCreadas = notasCreadas + 1
                    end
                end
            end
        end

        currBlick = currBlick + durCompasBlicks
    end

    return notasCreadas
end
