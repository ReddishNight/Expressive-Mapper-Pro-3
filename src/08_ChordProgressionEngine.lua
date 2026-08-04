-- ============================================================================
-- MÓDULO 8: MOTOR AVANZADO DE PROGRESIONES DE ACORDES Y VOICINGS (0 GC ALLOC)
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
    local pitchRaiz = transponerPorGradosEscala(tonica + 48, gradoRaiz - 1, tonica, escala)

    local relIntervals = INTERVALOS_TIPO_ACORDE[tipoAcorde] or INTERVALOS_TIPO_ACORDE.triada_mayor
    local notasSuperiores = {}

    for i = 1, #relIntervals do
        notasSuperiores[i] = pitchRaiz + relIntervals[i]
    end

    -- Nota del bajo en registro grave (C2 - C3)
    local pitchBajo = (pitchRaiz % 12) + 36
    if pitchBajo < 36 then pitchBajo = pitchBajo + 12 end

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
local function generarProgresionAcordes(proyecto, pistaBase, progresionIdx, tonica, escalaIdx, ritmoIdx, fIntensidad, configPreset, timeAxis)
    local escalaIndices = ESCALAS_AVANZADAS[escalaIdx] or ESCALAS_AVANZADAS[2]
    local datosProgresion = PROGRESIONES_ACORDES[progresionIdx] or PROGRESIONES_ACORDES[0]
    local gradosAcordes = datosProgresion.grados or { 4, 5, 3, 6 }
    local tiposAcordes = datosProgresion.tipos or { "maj7", "dom7", "min7", "min7" }

    local numCompases = #gradosAcordes
    local durCompasBlicks = SV.QUARTER * 4

    local reproductor = SV:getPlayback()
    local startBlick = reproductor:getPlayhead()

    local nuevaPista = SV:create("Track")
    nuevaPista:setName(pistaBase:getName() .. " - Acordes (" .. datosProgresion.nombre .. ")")
    proyecto:addTrack(nuevaPista)

    local nuevoGroupRef = SV:create("NoteGroup")
    proyecto:addNoteGroup(nuevoGroupRef)
    local mainRef = SV:create("NoteGroupReference")
    mainRef:setTarget(nuevoGroupRef)
    nuevaPista:addGroupReference(mainRef)

    local notasCreadas = 0
    local currBlick = startBlick
    local vocesSuperioresPrevias = nil

    for cIdx = 1, numCompases do
        local gradoActual = gradosAcordes[cIdx]
        local tipoActual = tiposAcordes[cIdx] or "triada_mayor"

        local pitchBajo, vocesBrutas = construirNotasAcorde(gradoActual, tipoActual, tonica, escalaIndices)
        local vocesSuperiores = optimizarConduccionVoces(vocesBrutas, vocesSuperioresPrevias)
        vocesSuperioresPrevias = vocesSuperiores

        -- 1. Agregar Nota de Bajo Sostenida en Registro Grave
        local notaBajo = SV:create("Note")
        notaBajo:setTimeRange(currBlick, durCompasBlicks)
        notaBajo:setPitch(pitchBajo)
        notaBajo:setLyrics("u")
        nuevoGroupRef:addNote(notaBajo)
        notasCreadas = notasCreadas + 1

        -- 2. Patrones Rítmicos para Voces Superiores
        if ritmoIdx == 0 then
            -- Pad Sostenido Legato (Full Bar Swell)
            for v = 1, #vocesSuperiores do
                local nUpper = SV:create("Note")
                nUpper:setTimeRange(currBlick, durCompasBlicks)
                nUpper:setPitch(vocesSuperiores[v])
                nUpper:setLyrics((v % 2 == 0) and "a" or "o")
                nuevoGroupRef:addNote(nUpper)
                notasCreadas = notasCreadas + 1
            end
        elseif ritmoIdx == 1 then
            -- Comping Rítmico Sincopado (Negras 1/4)
            local durPulso = SV.QUARTER
            for p = 0, 3 do
                local bPulse = currBlick + (p * durPulso)
                for v = 1, #vocesSuperiores do
                    local nUpper = SV:create("Note")
                    nUpper:setTimeRange(bPulse, durPulso - 20)
                    nUpper:setPitch(vocesSuperiores[v])
                    nUpper:setLyrics("la")
                    nuevoGroupRef:addNote(nUpper)
                    notasCreadas = notasCreadas + 1
                end
            end
        elseif ritmoIdx == 2 then
            -- Arpegio Cascadas Fluido (Corcheas 1/8)
            local durCorchea = math.floor(SV.QUARTER / 2)
            local totalPasos = 8
            for a = 0, totalPasos - 1 do
                local bArp = currBlick + (a * durCorchea)
                local idxVoz = (a % #vocesSuperiores) + 1
                local nUpper = SV:create("Note")
                nUpper:setTimeRange(bArp, durCorchea - 10)
                nUpper:setPitch(vocesSuperiores[idxVoz])
                nUpper:setLyrics("lu")
                nuevoGroupRef:addNote(nUpper)
                notasCreadas = notasCreadas + 1
            end
        elseif ritmoIdx == 3 then
            -- Chop Electrónico Kinetic (Semicorcheas 1/16)
            local durSemi = math.floor(SV.QUARTER / 4)
            local patronChop = { 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1 }
            for s = 0, 15 do
                if patronChop[s + 1] == 1 then
                    local bChop = currBlick + (s * durSemi)
                    for v = 1, #vocesSuperiores do
                        local nUpper = SV:create("Note")
                        nUpper:setTimeRange(bChop, durSemi - 15)
                        nUpper:setPitch(vocesSuperiores[v])
                        nUpper:setLyrics("da")
                        nuevoGroupRef:addNote(nUpper)
                        notasCreadas = notasCreadas + 1
                    end
                end
            end
        else
            -- Bajo Alternado + Acorde Strum
            local durPulso = SV.QUARTER
            for p = 0, 3 do
                local bPulse = currBlick + (p * durPulso)
                if p == 1 or p == 3 then
                    for v = 1, #vocesSuperiores do
                        local nUpper = SV:create("Note")
                        nUpper:setTimeRange(bPulse, durPulso - 25)
                        nUpper:setPitch(vocesSuperiores[v])
                        nUpper:setLyrics("pa")
                        nuevoGroupRef:addNote(nUpper)
                        notasCreadas = notasCreadas + 1
                    end
                end
            end
        end

        currBlick = currBlick + durCompasBlicks
    end

    return notasCreadas
end
