-- ============================================================================
-- MÓDULO 7: GENERADOR DE CONTRAMELODÍA Y CONTRAPUNTO ALGORÍTMICO (5 ESPECIES FUXIANAS)
-- ============================================================================

--- Intervalos consonantes en semitonos (3ra menor/mayor, 5ta justa, 6ta menor/mayor, 8va)
local CONSONANCIAS = {
    [3] = true, [4] = true, [7] = true, [8] = true, [9] = true, [12] = true,
    [-3] = true, [-4] = true, [-7] = true, [-8] = true, [-9] = true, [-12] = true
}

--- Verificar si la distancia entre dos notas es un paralelismo prohibido (5ta o 8va)
local function esParalelismoProhibido(pitchCantus1, pitchCantus2, pitchContra1, pitchContra2)
    if pitchCantus1 == nil or pitchCantus2 == nil or pitchContra1 == nil or pitchContra2 == nil then
        return false
    end

    local diff1 = math.abs(pitchContra1 - pitchCantus1) % 12
    local diff2 = math.abs(pitchContra2 - pitchCantus2) % 12

    -- 5ta justa (7 semitonos) u Octava (0/12 semitonos)
    local esQuinta1 = (diff1 == 7)
    local esQuinta2 = (diff2 == 7)
    local esOctava1 = (diff1 == 0)
    local esOctava2 = (diff2 == 0)

    if (esQuinta1 and esQuinta2) or (esOctava1 and esOctava2) then
        -- Ocurre paralelismo si ambas voces se mueven en la misma dirección
        local dirCantus = pitchCantus2 - pitchCantus1
        local dirContra = pitchContra2 - pitchContra1
        if (dirCantus > 0 and dirContra > 0) or (dirCantus < 0 and dirContra < 0) then
            return true
        end
    end

    return false
end

--- Seleccionar mejor pitch para contrapunto aplicando movimiento contrario, consonancia y reglas de Fux
local function seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
    local escala = escalaIndices or ESCALAS_AVANZADAS[2]
    local deltaCantus = (pitchCantusPrev ~= nil) and (pitchCantus - pitchCantusPrev) or 0

    -- Preferencia por movimiento contrario: si cantus sube, contrapunto baja
    local deltaDiatonicoPreferido = -2
    if deltaCantus < 0 then
        deltaDiatonicoPreferido = 2
    elseif deltaCantus == 0 then
        deltaDiatonicoPreferido = preferenciaArriba and 2 or -2
    end

    -- Probar transposiciones en grados (3ra, 6ta, 5ta, 4ta, 8va)
    local candidatosGrados = { deltaDiatonicoPreferido, deltaDiatonicoPreferido + (deltaDiatonicoPreferido > 0 and 1 or -1), 2, -2, 4, -4, 3, -3, 5, -5 }

    local mejorPitch = nil
    local mejorScore = -99999

    for i = 1, #candidatosGrados do
        local dG = candidatosGrados[i]
        local pitchCand = (pitchContraPrev ~= nil) and transponerPorGradosEscala(pitchContraPrev, dG, tonica, escala) or (pitchCantus + (preferenciaArriba and 7 or -7))

        local diff = math.abs(pitchCand - pitchCantus)
        local diffMod = diff % 12
        local score = 0

        -- Priorizar consonancias imperfectas (3ras, 6tas) para fluidez vocal
        if diffMod == 3 or diffMod == 4 or diffMod == 8 or diffMod == 9 then
            score = score + 60
        elseif diffMod == 7 or diffMod == 0 then
            score = score + 35
        else
            score = score - 30
        end

        -- Evitar cruce de voces (Voice Crossing)
        if preferenciaArriba and pitchCand <= pitchCantus then
            score = score - 150
        elseif (not preferenciaArriba) and pitchCand >= pitchCantus then
            score = score - 150
        end

        -- Regla Fuxian de Compensación de Saltos: si la nota anterior saltó > 4 semitones, obligar a moverse en sentido opuesto
        if pitchContraPrev ~= nil and pitchContraAntePrev ~= nil then
            local saltoPrevio = pitchContraPrev - pitchContraAntePrev
            if math.abs(saltoPrevio) >= 5 then
                local movActual = pitchCand - pitchContraPrev
                if (saltoPrevio > 0 and movActual < 0) or (saltoPrevio < 0 and movActual > 0) then
                    score = score + 45 -- Bonificación por compensar el salto
                else
                    score = score - 80 -- Penalización por encadenar saltos en la misma dirección
                end
            end
        end

        -- Regla del Clímax Melódico Único: penalizar múltiples picos con el mismo pitch máximo
        if maxPitchRegistrado and pitchCand >= maxPitchRegistrado then
            score = score - 40
        end

        -- Penalizar saltos excesivos respecto a la nota previa de contrapunto
        if pitchContraPrev ~= nil then
            local saltoContra = math.abs(pitchCand - pitchContraPrev)
            score = score - (saltoContra * 5)
        end

        -- Evitar paralelismo directo de 5tas u 8vas con cantus
        if pitchCantusPrev ~= nil and pitchContraPrev ~= nil then
            if esParalelismoProhibido(pitchCantusPrev, pitchCantus, pitchContraPrev, pitchCand) then
                score = score - 300
            end
        end

        if score > mejorScore then
            mejorScore = score
            mejorPitch = pitchCand
        end
    end

    return mejorPitch or (pitchCantus + (preferenciaArriba and 4 or -4))
end

--- Generar pista de contramelodía a partir de una pista / grupo base
local function generarPistaContrapunto(proyecto, pistaBase, groupRefBase, especieIdx, tonica, escalaIdx, fIntensidad, configPreset, timeAxis)
    local escalaIndices = ESCALAS_AVANZADAS[escalaIdx] or ESCALAS_AVANZADAS[2]
    local noteGroup = groupRefBase:getTarget()
    if not noteGroup then return 0 end

    local totalNotas = noteGroup:getNumNotes()
    if totalNotas == 0 then return 0 end

    local notasBase = {}
    for i = 1, totalNotas do
        notasBase[i] = noteGroup:getNote(i)
    end

    table.sort(notasBase, function(a, b) return a:getOnset() < b:getOnset() end)

    local nombreEspecie = {
        [0] = "1ra Especie (1:1)",
        [1] = "2da Especie (2:1)",
        [2] = "3ra Especie (4:1)",
        [3] = "4ta Especie (Síncopas)",
        [4] = "5ta Especie (Florido)",
        [5] = "Libre (Rítmico)"
    }
    local langIdx = _G.idiomaDetectado or 0
    local tr = I18N_DATA[langIdx] or I18N_DATA[0]
    local nombrePistaContra = string.format(tr.trackContraName or "Contramelodía %s", (nombreEspecie[especieIdx] or ""))
    
    local nuevaPista = nil
    local totalP = proyecto:getNumTracks()
    for i = 1, totalP do
        local t = proyecto:getTrack(i)
        if t:getName() == nombrePistaContra then
            nuevaPista = t
            break
        end
    end
    if not nuevaPista then
        nuevaPista = SV:create("Track")
        nuevaPista:setName(nombrePistaContra)
        proyecto:addTrack(nuevaPista)
    end

    -- Obtener offset y rango visual del grupo guía original
    local sourceOffset = groupRefBase:getTimeOffset()
    local sourceOnset  = groupRefBase:getOnset()
    local sourceDur    = groupRefBase:getDuration()

    -- Crear NoteGroup y NoteGroupReference con el flujo correcto de la API
    local nuevoGroupRef = SV:create("NoteGroup")
    proyecto:addNoteGroup(nuevoGroupRef)
    local mainRef = SV:create("NoteGroupReference")
    mainRef:setTarget(nuevoGroupRef)
    mainRef:setTimeOffset(sourceOffset)
    mainRef:setTimeRange(sourceOnset, sourceDur)
    nuevaPista:addGroupReference(mainRef)

    local tensionParam  = nuevoGroupRef:getParameter("tension")
    local breathParam   = nuevoGroupRef:getParameter("breathiness")
    local pitchDeltaParam = nuevoGroupRef:getParameter("pitchDelta")

    local pitchCantusPrev = nil
    local pitchContraPrev = nil
    local pitchContraAntePrev = nil
    local maxPitchRegistrado = nil
    local preferenciaArriba = true -- Alternable o configurable para evitar monotonía de dirección
    local notasCreadas = 0
    local pitchSincopaRetenido = nil

    for i = 1, totalNotas do
        local notaCantus = notasBase[i]
        local onset = notaCantus:getOnset()
        local duration = notaCantus:getDuration()
        local pitchCantus = notaCantus:getPitch()

        if especieIdx == 0 then
            -- 1ra Especie: Nota contra Nota (1:1)
            local pitchContra = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)

            local nuevaNota = SV:create("Note")
            nuevaNota:setTimeRange(onset, duration)
            nuevaNota:setPitch(pitchContra)
            nuevaNota:setLyrics("lu")

            nuevoGroupRef:addNote(nuevaNota)
            notasCreadas = notasCreadas + 1

            if pitchContraPrev then
                pitchContraAntePrev = pitchContraPrev
            end
            if not maxPitchRegistrado or pitchContra > maxPitchRegistrado then
                maxPitchRegistrado = pitchContra
            end
            pitchCantusPrev = pitchCantus
            pitchContraPrev = pitchContra

        elseif especieIdx == 1 then
            -- 2da Especie: 2 notas de contrapunto por cada nota base (2:1)
            local durHalf = math.floor(duration / 2)
            if durHalf >= math.floor(SV.QUARTER / 8) then
                local pitchContra1 = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local pitchContra2 = transponerPorGradosEscala(pitchContra1, (i % 2 == 0) and 1 or -1, tonica, escalaIndices)

                local nota1 = SV:create("Note")
                nota1:setTimeRange(onset, durHalf)
                nota1:setPitch(pitchContra1)
                nota1:setLyrics("tu")

                local nota2 = SV:create("Note")
                nota2:setTimeRange(onset + durHalf, duration - durHalf)
                nota2:setPitch(pitchContra2)
                nota2:setLyrics("ra")

                nuevoGroupRef:addNote(nota1)
                nuevoGroupRef:addNote(nota2)
                notasCreadas = notasCreadas + 2

                pitchContraAntePrev = pitchContra1
                if not maxPitchRegistrado or pitchContra2 > maxPitchRegistrado then
                    maxPitchRegistrado = pitchContra2
                end
                pitchCantusPrev = pitchCantus
                pitchContraPrev = pitchContra2
            else
                local pitchContra = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local nuevaNota = SV:create("Note")
                nuevaNota:setTimeRange(onset, duration)
                nuevaNota:setPitch(pitchContra)
                nuevaNota:setLyrics("lu")
                nuevoGroupRef:addNote(nuevaNota)
                notasCreadas = notasCreadas + 1

                if pitchContraPrev then
                    pitchContraAntePrev = pitchContraPrev
                end
                if not maxPitchRegistrado or pitchContra > maxPitchRegistrado then
                    maxPitchRegistrado = pitchContra
                end
                pitchCantusPrev = pitchCantus
                pitchContraPrev = pitchContra
            end
        elseif especieIdx == 2 then
            -- 3ra Especie: 4 notas por nota base (4:1)
            local durQuarter = math.floor(duration / 4)
            if durQuarter >= math.floor(SV.QUARTER / 16) then
                local pitchCurr = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local deltas3ra = { 0, 1, 2, 1 }
                for q = 0, 3 do
                    local nOnset = onset + q * durQuarter
                    local nDur = (q == 3) and (duration - 3 * durQuarter) or durQuarter
                    local pStep = transponerPorGradosEscala(pitchCurr, deltas3ra[q + 1], tonica, escalaIndices)

                    local notaSub = SV:create("Note")
                    notaSub:setTimeRange(nOnset, nDur)
                    notaSub:setPitch(pStep)
                    notaSub:setLyrics((q == 0) and "da" or "di")

                    nuevoGroupRef:addNote(notaSub)
                    notasCreadas = notasCreadas + 1
                end
                pitchContraAntePrev = pitchCurr
                pitchCantusPrev = pitchCantus
                pitchContraPrev = transponerPorGradosEscala(pitchCurr, deltas3ra[4], tonica, escalaIndices)
            else
                local pitchContra = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local nuevaNota = SV:create("Note")
                nuevaNota:setTimeRange(onset, duration)
                nuevaNota:setPitch(pitchContra)
                nuevaNota:setLyrics("lu")
                nuevoGroupRef:addNote(nuevaNota)
                notasCreadas = notasCreadas + 1

                if pitchContraPrev then
                    pitchContraAntePrev = pitchContraPrev
                end
                if not maxPitchRegistrado or pitchContra > maxPitchRegistrado then
                    maxPitchRegistrado = pitchContra
                end
                pitchCantusPrev = pitchCantus
                pitchContraPrev = pitchContra
            end
        elseif especieIdx == 3 then
            -- 4ta Especie: Síncopas / Retardos (Suspensiones ligadas que resuelven descendentemente)
            local durHalf = math.floor(duration / 2)
            if durHalf >= math.floor(SV.QUARTER / 8) then
                local pitchPreparacion = pitchSincopaRetenido or seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                -- Retardo disonante/consonante en tiempo fuerte que resuelve 1 grado abajo paso a paso
                local pitchResolucion = transponerPorGradosEscala(pitchPreparacion, -1, tonica, escalaIndices)

                local notaRetardo = SV:create("Note")
                notaRetardo:setTimeRange(onset, durHalf)
                notaRetardo:setPitch(pitchPreparacion)
                notaRetardo:setLyrics("so")

                local notaResolucion = SV:create("Note")
                notaResolucion:setTimeRange(onset + durHalf, duration - durHalf)
                notaResolucion:setPitch(pitchResolucion)
                notaResolucion:setLyrics("la")

                nuevoGroupRef:addNote(notaRetardo)
                nuevoGroupRef:addNote(notaResolucion)
                notasCreadas = notasCreadas + 2

                pitchSincopaRetenido = pitchResolucion
                pitchContraAntePrev = pitchPreparacion
                pitchCantusPrev = pitchCantus
                pitchContraPrev = pitchResolucion
            else
                local pitchContra = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local nuevaNota = SV:create("Note")
                nuevaNota:setTimeRange(onset, duration)
                nuevaNota:setPitch(pitchContra)
                nuevaNota:setLyrics("lu")
                nuevoGroupRef:addNote(nuevaNota)
                notasCreadas = notasCreadas + 1

                pitchCantusPrev = pitchCantus
                pitchContraPrev = pitchContra
            end
        elseif especieIdx == 4 then
            -- 5ta Especie: Contrapunto Florido / Mixto (Mezcla ornamental de especies con síncopas y bordaduras)
            local patronFlorido = (i % 3)
            if patronFlorido == 0 then
                -- Figura rítmica de 3ra especie con bordadura ornamental (4:1)
                local durQ = math.floor(duration / 4)
                if durQ >= math.floor(SV.QUARTER / 16) then
                    local pBase = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                    local deltasFlorido = { 0, 1, -1, 0 }
                    for q = 0, 3 do
                        local nO = onset + q * durQ
                        local nD = (q == 3) and (duration - 3 * durQ) or durQ
                        local pFlor = transponerPorGradosEscala(pBase, deltasFlorido[q + 1], tonica, escalaIndices)
                        local nSub = SV:create("Note")
                        nSub:setTimeRange(nO, nD)
                        nSub:setPitch(pFlor)
                        nSub:setLyrics((q % 2 == 0) and "flo" or "ri")
                        nuevoGroupRef:addNote(nSub)
                        notasCreadas = notasCreadas + 1
                    end
                    pitchContraPrev = pBase
                else
                    local pContra = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                    local nF = SV:create("Note")
                    nF:setTimeRange(onset, duration)
                    nF:setPitch(pContra)
                    nF:setLyrics("flo")
                    nuevoGroupRef:addNote(nF)
                    notasCreadas = notasCreadas + 1
                    pitchContraPrev = pContra
                end
            elseif patronFlorido == 1 then
                -- Síncopa con retardo ligado de 4ta especie (2:1)
                local durH = math.floor(duration / 2)
                local pPre = pitchContraPrev or seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local pRes = transponerPorGradosEscala(pPre, -1, tonica, escalaIndices)
                local n1 = SV:create("Note")
                n1:setTimeRange(onset, durH)
                n1:setPitch(pPre)
                n1:setLyrics("syn")
                local n2 = SV:create("Note")
                n2:setTimeRange(onset + durH, duration - durH)
                n2:setPitch(pRes)
                n2:setLyrics("co")
                nuevoGroupRef:addNote(n1)
                nuevoGroupRef:addNote(n2)
                notasCreadas = notasCreadas + 2
                pitchContraPrev = pRes
            else
                -- Blanca con salto consonante y resolución (2da Especie 2:1)
                local durH = math.floor(duration / 2)
                local pC1 = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
                local pC2 = transponerPorGradosEscala(pC1, 2, tonica, escalaIndices)
                local n1 = SV:create("Note")
                n1:setTimeRange(onset, durH)
                n1:setPitch(pC1)
                n1:setLyrics("me")
                local n2 = SV:create("Note")
                n2:setTimeRange(onset + durH, duration - durH)
                n2:setPitch(pC2)
                n2:setLyrics("los")
                nuevoGroupRef:addNote(n1)
                nuevoGroupRef:addNote(n2)
                notasCreadas = notasCreadas + 2
                pitchContraPrev = pC2
            end
            pitchCantusPrev = pitchCantus
        else
            -- Contrapunto Libre (Rítmico / Improv)
            local pitchContra = seleccionarPitchContrapunto(pitchCantus, pitchCantusPrev, pitchContraPrev, pitchContraAntePrev, tonica, escalaIndices, preferenciaArriba, maxPitchRegistrado)
            local nuevaNota = SV:create("Note")
            nuevaNota:setTimeRange(onset, duration)
            nuevaNota:setPitch(pitchContra)
            nuevaNota:setLyrics("lu")
            nuevoGroupRef:addNote(nuevaNota)
            notasCreadas = notasCreadas + 1

            if pitchContraPrev then
                pitchContraAntePrev = pitchContraPrev
            end
            if not maxPitchRegistrado or pitchContra > maxPitchRegistrado then
                maxPitchRegistrado = pitchContra
            end
            pitchCantusPrev = pitchCantus
            pitchContraPrev = pitchContra
        end
    end

    return notasCreadas
end
