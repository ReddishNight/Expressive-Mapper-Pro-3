-- ============================================================================
-- MÓDULO 6: MOTOR DE ARMONÍAS VOCALES Y VOICE LEADING (0 GC ALLOC)
-- ============================================================================

local function generarGaussianNoise(mean, stdDev)
    local u1 = math.random()
    if u1 < 0.00001 then u1 = 0.00001 end
    local u2 = math.random()
    local z0 = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
    return mean + z0 * stdDev
end

--- Buscar el índice y grado de una nota en una escala dada la tónica
local function buscarGradoEnEscala(pitch, tonica, escalaIndices)
    local semitonoRel = (pitch - tonica) % 12
    if semitonoRel < 0 then semitonoRel = semitonoRel + 12 end
    local octava = math.floor((pitch - tonica) / 12)

    local numElem = #escalaIndices
    local idxEncontrado = 1
    local minDiff = 999

    for i = 1, numElem do
        local diff = math.abs(semitonoRel - escalaIndices[i])
        if diff < minDiff then
            minDiff = diff
            idxEncontrado = i
        end
    end

    return idxEncontrado, octava
end

--- Transponer un pitch MIDI por grados diatónicos dentro de una escala
local function transponerPorGradosEscala(pitch, deltaGrados, tonica, escalaIndices)
    local numNotasEscala = #escalaIndices
    if numNotasEscala == 0 then return pitch + deltaGrados end

    local idxActual, octava = buscarGradoEnEscala(pitch, tonica, escalaIndices)
    local idxTarget = idxActual + deltaGrados

    local octavaShift = 0
    while idxTarget > numNotasEscala do
        idxTarget = idxTarget - numNotasEscala
        octavaShift = octavaShift + 1
    end
    while idxTarget < 1 do
        idxTarget = idxTarget + numNotasEscala
        octavaShift = octavaShift - 1
    end

    local pitchBase = tonica + (octava + octavaShift) * 12 + escalaIndices[idxTarget]
    return pitchBase
end

--- Aplicar Voice Leading por Mínimo Movimiento
--- Reordena los pitches de destino para minimizar saltos melódicos bruscos respecto a la nota previa
local function optimizarVoiceLeading(pitchPrevio, pitchCandidatoDirecto, deltaGrados, tonica, escalaIndices)
    if pitchPrevio == nil or pitchPrevio == 0 then
        return pitchCandidatoDirecto
    end

    local distDirecta = math.abs(pitchCandidatoDirecto - pitchPrevio)
    if distDirecta <= 5 then
        return pitchCandidatoDirecto
    end

    -- Probar octava inferior y superior para minimizar salto
    local candBajo = pitchCandidatoDirecto - 12
    local candAlto = pitchCandidatoDirecto + 12

    local distBajo = math.abs(candBajo - pitchPrevio)
    local distAlto = math.abs(candAlto - pitchPrevio)

    if distBajo < distDirecta and distBajo < distAlto then
        return candBajo
    elseif distAlto < distDirecta then
        return candAlto
    end

    return pitchCandidatoDirecto
end

--- Generar conjunto de voces armónicas para una nota base
--- Soporta presets corales (SATB, Dúo, Trío) y transposición interválica
local function generarVocesArmonicasNota(pitchBase, deltaGrados, tonica, escalaIndices, presetCoralConfig)
    local pitchesVoces = {}

    if presetCoralConfig and presetCoralConfig.intervalos then
        local numVoces = #presetCoralConfig.intervalos
        for i = 1, numVoces do
            local dG = presetCoralConfig.intervalos[i]
            pitchesVoces[i] = transponerPorGradosEscala(pitchBase, dG, tonica, escalaIndices)
        end
    else
        pitchesVoces[1] = transponerPorGradosEscala(pitchBase, deltaGrados, tonica, escalaIndices)
    end

    return pitchesVoces
end

--- Generar pista de armonía completa a partir de un NoteGroup base
local function generarPistasArmonia(proyecto, pistaBase, groupRefBase, tonica, escalaIdx, modoArmoniaIdx, presetCoralIdx, antiFaseMs, antiFaseCents, fIntensidad, configPreset, timeAxis, intervalosCustomStr, enableJustIntonation)
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

    -- Definir intervalos según el modo de armonía seleccionado
    -- Modos: 0: 3ra Arriba, 1: 3ra Abajo, 2: 5ta Arriba, 3: 6ta Arriba, 4: Octava Abajo, 5: Preset Coral, 6: Intervalos Personalizados
    local intervalosPorModo = {
        [0] = { { tipo = "d", val = 2 } },       -- 3ra Arriba
        [1] = { { tipo = "d", val = -2 } },      -- 3ra Abajo
        [2] = { { tipo = "d", val = 4 } },       -- 5ta Arriba
        [3] = { { tipo = "d", val = 5 } },       -- 6ta Arriba
        [4] = { { tipo = "d", val = -7 } },      -- Octava Abajo
    }

    local listaIntervalos = {}
    if modoArmoniaIdx == 6 and intervalosCustomStr and intervalosCustomStr ~= "" then
        -- Parsear intervalos personalizados (ej. "+3, -5, c+7")
        for token in string.gmatch(intervalosCustomStr, "[^,]+") do
            token = string.gsub(token, "%s+", "")
            local tipo = "d" -- Por defecto diatónico
            if string.match(token, "^c") then
                tipo = "c"
                token = string.sub(token, 2)
            elseif string.match(token, "^d") then
                tipo = "d"
                token = string.sub(token, 2)
            end
            local val = tonumber(token)
            if val then
                listaIntervalos[#listaIntervalos + 1] = { tipo = tipo, val = val }
            end
        end
    end

    if #listaIntervalos == 0 then
        local configPresetCoral = PRESETS_CORALES[presetCoralIdx] or PRESETS_CORALES[0]
        local listaDefault = intervalosPorModo[modoArmoniaIdx]
        if modoArmoniaIdx == 5 or not listaDefault then
            -- Mapear intervalos del preset coral a la estructura diatónica por defecto
            for i = 1, #configPresetCoral.intervalos do
                listaIntervalos[i] = { tipo = "d", val = configPresetCoral.intervalos[i] }
            end
        else
            listaIntervalos = listaDefault
        end
    end

    local numVoces = #listaIntervalos
    local pistasCreadas = 0
    local notasTotalCreadas = 0

    for vIdx = 1, numVoces do
        local intInfo = listaIntervalos[vIdx]
        local nombreVoz = "Armonía " .. (intInfo.val >= 0 and "+" or "") .. intInfo.val .. (intInfo.tipo == "c" and " (Cromático)" or " (Diatónico)")

        local nuevaPista = SV:create("Track")
        nuevaPista:setName(pistaBase:getName() .. " - " .. nombreVoz)

        proyecto:addTrack(nuevaPista)
        pistasCreadas = pistasCreadas + 1

        -- Replicar la base de voz (cantante y vocalModeParams) del grupo guía original
        local settingsVozGuia = groupRefBase:getVoice()

        -- Crear NoteGroup y NoteGroupReference con el flujo correcto de la API
        local nuevoGroupRef = SV:create("NoteGroup")
        proyecto:addNoteGroup(nuevoGroupRef)
        local mainRef = SV:create("NoteGroupReference")
        mainRef:setTarget(nuevoGroupRef)
        
        -- Copiar la base de voz
        if settingsVozGuia then
            mainRef:setVoice(settingsVozGuia)
        end
        
        nuevaPista:addGroupReference(mainRef)

        -- Caché de parámetros de la nueva pista
        local tensionParam    = nuevoGroupRef:getParameter("tension")
        local breathParam     = nuevoGroupRef:getParameter("breathiness")
        local genderParam     = nuevoGroupRef:getParameter("gender")
        local loudnessParam   = nuevoGroupRef:getParameter("loudness")
        local pitchDeltaParam = nuevoGroupRef:getParameter("pitchDelta")
        local vibratoParam    = nuevoGroupRef:getParameter("vibratoEnv")

        -- Anti-fase específica para esta voz usando una semilla determinista basada en el onset de la primera nota
        local seedVoz = vIdx * 12345 + (notasBase[1] and notasBase[1]:getOnset() or 0)
        math.randomseed(seedVoz)

        local offsetGenderVoz = (vIdx % 2 == 1) and (0.08 * fIntensidad) or (-0.08 * fIntensidad)
        local offsetBreathVoz = 0.05 * fIntensidad
        local pitchPrevioVoz = nil

        for i = 1, totalNotas do
            local notaOriginal = notasBase[i]
            local onsetOrg = notaOriginal:getOnset()
            local durOrg = notaOriginal:getDuration()
            local pitchOrg = notaOriginal:getPitch()

            -- Anti-fase timing delay gaussiano (convertido de ms a blicks)
            local bpmLocal = 120.0
            if timeAxis then
                bpmLocal = obtenerTempoEnBlick(timeAxis, onsetOrg)
            end
            local msPerBlick = (60000.0 / bpmLocal) / SV.QUARTER
            local delayMs = (antiFaseMs > 0) and generarGaussianNoise(0, antiFaseMs) or 0
            local delayBlicks = math.floor(delayMs / msPerBlick)

            local onsetHarm = math.max(0, onsetOrg + delayBlicks)
            local durHarm = durOrg

            -- Anti-fase micro-detune en cents
            local detuneCentsHarm = (antiFaseCents > 0) and math.floor(generarGaussianNoise(0, antiFaseCents)) or 0

            -- Transposición diatónica o cromática en la escala
            local pitchHarmTarget
            if intInfo.tipo == "c" then
                pitchHarmTarget = pitchOrg + intInfo.val
            else
                pitchHarmTarget = transponerPorGradosEscala(pitchOrg, intInfo.val, tonica, escalaIndices)
            end
            local pitchHarm = optimizarVoiceLeading(pitchPrevioVoz, pitchHarmTarget, intInfo.val, tonica, escalaIndices)
            pitchHarm = math.max(24, math.min(96, pitchHarm)) -- C1 a C7 rango seguro vocal
            pitchPrevioVoz = pitchHarm

            -- Entonación Justa (Just Intonation) vs Temperamento Igual Pop
            local detuneJustIntonation = 0
            if enableJustIntonation then
                local diffSemitonos = math.abs(pitchHarm - pitchOrg) % 12
                if diffSemitonos == 4 then -- 3ra Mayor
                    detuneJustIntonation = -14
                elseif diffSemitonos == 3 then -- 3ra Menor
                    detuneJustIntonation = 16
                elseif diffSemitonos == 7 then -- 5ta Justa
                    detuneJustIntonation = 2
                elseif diffSemitonos == 9 then -- 6ta Mayor
                    detuneJustIntonation = -16
                elseif diffSemitonos == 8 then -- 6ta Menor
                    detuneJustIntonation = 14
                end
            end

            -- Crear nota de armonía
            local nuevaNotaHarm = SV:create("Note")
            nuevaNotaHarm:setTimeRange(onsetHarm, durHarm)
            nuevaNotaHarm:setPitch(pitchHarm)
            nuevaNotaHarm:setLyrics(notaOriginal:getLyrics())
            local detuneTotal = detuneCentsHarm + detuneJustIntonation
            if detuneTotal ~= 0 then
                pcall(function()
                    nuevaNotaHarm:setDetune(detuneTotal)
                end)
            end

            nuevoGroupRef:addNote(nuevaNotaHarm)
            notasTotalCreadas = notasTotalCreadas + 1

            -- Generar automáticamente AI Retakes en la nota si la versión del editor lo soporta
            pcall(function()
                local retakes = nuevaNotaHarm:getRetakes()
                if retakes then
                    retakes:generateTake()
                    -- Activar el take recién generado
                    local numTakes = retakes:getNumTakes()
                    if numTakes > 0 then
                        retakes:setActiveTake(numTakes - 1)
                    end
                end
            end)

            -- Formant Shift por registro: agudos comprimen formantes (+gender), graves expanden (-gender)
            local registerGenderShift = (pitchHarm > 72) and 0.12 or ((pitchHarm < 48) and -0.12 or 0.0)

            -- Aplicar automatizaciones expresivas diferenciadas para anti-fase
            local endBlickHarm = onsetHarm + durHarm
            if tensionParam then
                tensionParam:add(onsetHarm, (configPreset.tension[1] + 0.05) * fIntensidad)
                tensionParam:add(endBlickHarm, configPreset.tension[5] * fIntensidad)
            end
            if breathParam then
                breathParam:add(onsetHarm, (configPreset.aliento[1] + offsetBreathVoz) * fIntensidad)
            end
            if genderParam then
                genderParam:add(onsetHarm, (configPreset.genero[1] + offsetGenderVoz + registerGenderShift) * fIntensidad)
            end
        end
    end

    return notasTotalCreadas
end
