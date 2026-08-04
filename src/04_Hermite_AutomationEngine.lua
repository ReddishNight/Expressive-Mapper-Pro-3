-- ============================================================================
-- MÓDULO 4: MOTOR DE AUTOMATIZACIÓN E INTERPOLACIÓN HERMITE (0 GC ALLOC)
-- ============================================================================

local function limitarValor(val, minVal, maxVal)
    if val < minVal then return minVal end
    if val > maxVal then return maxVal end
    return val
end

local function evaluarHermite(t, p0, p1, m0, m1)
    local t2 = t * t
    local t3 = t2 * t
    local h00 = 2.0 * t3 - 3.0 * t2 + 1.0
    local h10 = t3 - 2.0 * t2 + t
    local h01 = -2.0 * t3 + 3.0 * t2
    local h11 = t3 - t2
    return h00 * p0 + h10 * m0 + h01 * p1 + h11 * m1
end

--- Cálculo de tangentes con modelo Kochanek-Bartels (TCB: Tension, Continuity, Bias)
local function calcularTangentesNodos(tensionTCB, continuityTCB, biasTCB)
    local val = EVAL_NODOS.val
    local t = EVAL_NODOS.t
    local m = EVAL_NODOS.m

    local T = tensionTCB or 0.0
    local C = continuityTCB or 0.0
    local B = biasTCB or 0.0

    m[1] = (val[2] - val[1]) / (t[2] - t[1])
    m[5] = (val[5] - val[4]) / (t[5] - t[4])

    for k = 2, 4 do
        local dt1 = t[k] - t[k - 1]
        local dt2 = t[k + 1] - t[k]
        local d1 = (dt1 > 0.0001) and ((val[k] - val[k - 1]) / dt1) or 0.0
        local d2 = (dt2 > 0.0001) and ((val[k + 1] - val[k]) / dt2) or 0.0

        -- Tangentes TCB para evitar sobredisparo (overshoot) y oscilaciones
        local mIncoming = ((1.0 - T) * (1.0 - C) * (1.0 + B) * d1 + (1.0 - T) * (1.0 + C) * (1.0 - B) * d2) * 0.5
        local mOutgoing = ((1.0 - T) * (1.0 + C) * (1.0 + B) * d1 + (1.0 - T) * (1.0 - C) * (1.0 - B) * d2) * 0.5

        m[k] = (mIncoming + mOutgoing) * 0.5
    end
end

local function muestrearCurvaHermite(u)
    if u <= 0.0 then return EVAL_NODOS.val[1] end
    if u >= 1.0 then return EVAL_NODOS.val[5] end

    local t = EVAL_NODOS.t
    local val = EVAL_NODOS.val
    local m = EVAL_NODOS.m

    local k = 1
    if u >= t[4] then
        k = 4
    elseif u >= t[3] then
        k = 3
    elseif u >= t[2] then
        k = 2
    end

    local t0 = t[k]
    local t1 = t[k + 1]
    local dt = t1 - t0
    local localU = (u - t0) / dt

    return evaluarHermite(localU, val[k], val[k + 1], m[k] * dt, m[k + 1] * dt)
end

local function obtenerRangoParametro(paramObj)
    if not paramObj then
        return -1.0, 1.0, 0.0
    end

    local def = paramObj:getDefinition()
    if def then
        local minVal = -1.0
        local maxVal = 1.0
        local defVal = 0.0

        if def.range then
            if def.range[1] ~= nil then minVal = def.range[1] end
            if def.range[2] ~= nil then maxVal = def.range[2] end
        end
        if def.defaultValue ~= nil then
            defVal = def.defaultValue
        end

        return minVal, maxVal, defVal
    end

    return -1.0, 1.0, 0.0
end

local function obtenerToleranciaSimplificacion(paramObj)
    if not paramObj then return 0.002 end
    local minVal, maxVal = obtenerRangoParametro(paramObj)
    local rango = math.abs(maxVal - minVal)
    -- Tolerancia dinámicamente escalada al 0.2% del rango del parámetro (ej. 4.8 cents en pitchDelta)
    return math.max(0.001, rango * 0.002)
end

local function obtenerTempoEnBlick(timeAxis, blickPos)
    -- Iterar tempo marks para encontrar el BPM vigente en blickPos
    local numMarks = timeAxis:getAllTempoMarks()
    if numMarks and #numMarks > 0 then
        local bpmActual = 120.0
        for i = 1, #numMarks do
            local mark = numMarks[i]
            if mark and mark.position ~= nil then
                if mark.position <= blickPos then
                    bpmActual = mark.bpm or 120.0
                else
                    break
                end
            end
        end
        return bpmActual
    end
    return 120.0
end

local function factorTempo(bpm)
    if bpm <= 0.0 then return 1.0 end
    return 120.0 / bpm
end

local function aplicarPortamentoSCurve(pitchDeltaParam, onset, duration, saltoSemitonos, factorIntensidad, mergeMode)
    if not pitchDeltaParam or math.abs(saltoSemitonos) < 2 then return end

    local valInitial = -saltoSemitonos * 100.0 * factorIntensidad
    valInitial = limitarValor(valInitial, -1200.0, 1200.0)

    -- Duración del glissando en blicks proporcional a la magnitud del salto e intervalo
    local maxDurBlick = math.floor(duration * 0.45)
    local calcDurBlick = math.max(math.floor(SV.QUARTER / 8), math.floor(math.abs(saltoSemitonos) * 18))
    local durGlide = math.min(maxDurBlick, calcDurBlick)
    if durGlide < 10 then return end

    local numPuntos = 6
    for pIdx = 0, numPuntos do
        local u = pIdx / numPuntos
        -- Curva en S sigmoidal (Hermite cubic) S(u) = 3*u^2 - 2*u^3
        local sVal = 3.0 * u * u - 2.0 * u * u * u
        local posBlick = onset + math.floor(durGlide * u)
        local valGlide = valInitial * (1.0 - sVal)

        if mergeMode then
            local exist = pitchDeltaParam:get(posBlick) or 0.0
            valGlide = (exist + valGlide) * 0.5
        end

        pitchDeltaParam:add(posBlick, valGlide)
    end

    if pitchDeltaParam.simplify then
        pitchDeltaParam:simplify(onset, onset + durGlide, obtenerToleranciaSimplificacion(pitchDeltaParam))
    end
end

--- Cálculo de desviación de registro (Pitch Height Scaling) (0 GC Alloc)
local function calcularFactorRegistro(pitchMidi, basePitch, pitchSens, factorUI)
    if not pitchMidi then return 0.0 end
    local deltaOctaves = (pitchMidi - (basePitch or 60)) / 12.0
    local sens = pitchSens or 0.5
    local uiMult = factorUI or 1.0
    return limitarValor(deltaOctaves * 0.25 * sens * uiMult, -1.0, 1.0)
end

--- Cálculo de modulación por fonema (Phoneme-Class Awareness) (0 GC Alloc)
local function calcularModulacionFonema(fonemaStr, phonemeSens, factorUI)
    if not fonemaStr or fonemaStr == "" then return 0.0, 0.0, 0.0 end
    local fLow = string.lower(fonemaStr)
    local tensDelta = 0.0
    local breathDelta = 0.0
    local loudDelta = 0.0

    if string.match(fLow, "^[ptkbdg]") then
        tensDelta = 0.15
        breathDelta = 0.25
        loudDelta = 0.5
    elseif string.match(fLow, "^[sfhvc]") or string.match(fLow, "sh") or string.match(fLow, "ch") or string.match(fLow, "z") then
        tensDelta = -0.10
        breathDelta = 0.40
        loudDelta = -0.3
    elseif string.match(fLow, "^[mnlr]") or string.match(fLow, "ng") then
        tensDelta = -0.05
        breathDelta = 0.10
        loudDelta = 0.0
    elseif string.match(fLow, "^[aeoáéó]") or string.match(fLow, "aa") or string.match(fLow, "ae") or string.match(fLow, "ow") then
        tensDelta = 0.10
        breathDelta = -0.15
        loudDelta = 0.8
    elseif string.match(fLow, "^[iuíú]") or string.match(fLow, "iy") or string.match(fLow, "uw") or string.match(fLow, "ih") then
        tensDelta = 0.05
        breathDelta = -0.05
        loudDelta = 0.2
    end

    local mult = (phonemeSens or 0.5) * (factorUI or 1.0)
    return tensDelta * mult, breathDelta * mult, loudDelta * mult
end

--- Jitter de humanización orgánico y determinista (0 GC Alloc)
local function calcularJitterDeterministico(idxNota, blickPos, jitterSens, factorUI)
    local nIdx = idxNota or 1
    local bPos = blickPos or 0
    local rawHash = math.sin(nIdx * 12.9898 + bPos * 0.007823) * 43758.5453
    local frac = rawHash - math.floor(rawHash)
    local jitterNorm = (frac - 0.5) * 2.0
    local sens = jitterSens or 0.05
    local uiMult = factorUI or 1.0
    return jitterNorm * sens * uiMult
end

local function aplicarEnvolventeHermite(paramObj, valoresNodo, factorInt,
                                        onset, duration, endBlick,
                                        blickStep, mergeMode,
                                        contextoInicio, contextoFin,
                                        esBreathiness, esLoudness, esConsonante,
                                        fonemasComputados, esVibrato, vowelOnsetBlick,
                                        esTension,
                                        pitchMidi, basePitch, configPreset,
                                        factorHumanizacion, factorRegistro, factorFonema, idxNota)
    if not paramObj then return end

    local minVal, maxVal = obtenerRangoParametro(paramObj)

    -- Ajustar onset efectivo si existe un desfase por consonante inicial (Vowel Onset Alignment)
    local activeOnset = onset
    local activeDuration = duration
    if vowelOnsetBlick and vowelOnsetBlick > onset and vowelOnsetBlick < endBlick then
        activeOnset = vowelOnsetBlick
        activeDuration = endBlick - activeOnset
    end

    if esVibrato then
        -- Onset delay (fase plana inicial) y rampa de desarrollo de profundidad de vibrato
        EVAL_NODOS.val[1] = 0.0
        EVAL_NODOS.val[2] = 0.0
        EVAL_NODOS.val[3] = valoresNodo[3] * factorInt * 0.45
        EVAL_NODOS.val[4] = valoresNodo[4] * factorInt
        EVAL_NODOS.val[5] = valoresNodo[5] * factorInt * 0.75
    else
        for idx = 1, 5 do
            EVAL_NODOS.val[idx] = valoresNodo[idx] * factorInt
        end
    end

    -- Moduladores Dinámicos: Registro, Fonema, Jitter, Attack Punch y Release Breath
    local pitchSens = configPreset and configPreset.pitchSensitivity or 0.50
    local jitSens   = configPreset and configPreset.humanizeJitter or 0.05
    local atkPunch  = configPreset and configPreset.attackPunch or 0.0
    local relBreath = configPreset and configPreset.releaseBreath or 0.0

    local regFactor = calcularFactorRegistro(pitchMidi, basePitch, pitchSens, factorRegistro)
    local jitterVal = calcularJitterDeterministico(idxNota, onset, jitSens, factorHumanizacion)

    for idx = 1, 5 do
        if esTension then
            EVAL_NODOS.val[idx] = EVAL_NODOS.val[idx] + regFactor * 0.30
        elseif esLoudness then
            EVAL_NODOS.val[idx] = EVAL_NODOS.val[idx] + regFactor * 1.50
        elseif esBreathiness then
            EVAL_NODOS.val[idx] = EVAL_NODOS.val[idx] - regFactor * 0.20
        end

        if idx >= 2 and idx <= 4 then
            EVAL_NODOS.val[idx] = EVAL_NODOS.val[idx] + jitterVal
        end
    end

    if atkPunch ~= 0.0 then
        if esTension or esLoudness then
            EVAL_NODOS.val[1] = EVAL_NODOS.val[1] + (atkPunch * factorInt)
            EVAL_NODOS.val[2] = EVAL_NODOS.val[2] + (atkPunch * 0.5 * factorInt)
        end
    end

    if contextoInicio and esBreathiness then
        EVAL_NODOS.val[1] = EVAL_NODOS.val[1] + (0.25 * factorInt)
    end
    if esConsonante and esBreathiness then
        EVAL_NODOS.val[1] = EVAL_NODOS.val[1] + (0.35 * factorInt)
        EVAL_NODOS.val[2] = EVAL_NODOS.val[2] + (0.15 * factorInt)
    end

    -- Release Curve de final de frase (relajación glótica y fade-out de aliento)
    if contextoFin then
        if esBreathiness then
            EVAL_NODOS.val[5] = EVAL_NODOS.val[5] + (0.35 * factorInt) + (relBreath * factorInt)
        end
        if esTension then
            EVAL_NODOS.val[5] = EVAL_NODOS.val[5] - (0.40 * factorInt)
        end
        if esLoudness then
            EVAL_NODOS.val[5] = EVAL_NODOS.val[5] - (1.8 * factorInt)
        end
    end

    -- Si hubo desfase por consonante de ataque, mantener punto neutro inicial en onset
    if activeOnset > onset then
        paramObj:add(onset, limitarValor(EVAL_NODOS.val[1] * 0.2, minVal, maxVal))
    end

    if blickStep == 0 then
        -- Solo Nodos Clave (5 Puntos Hermite por Nota)
        BUFFER_POSICIONES[1] = activeOnset
        BUFFER_POSICIONES[2] = activeOnset + math.floor(activeDuration * 0.15)
        BUFFER_POSICIONES[3] = activeOnset + math.floor(activeDuration * 0.50)
        BUFFER_POSICIONES[4] = activeOnset + math.floor(activeDuration * 0.85)
        BUFFER_POSICIONES[5] = endBlick

        for idx = 1, 5 do
            local valFinal = limitarValor(EVAL_NODOS.val[idx], minVal, maxVal)
            local posBlick = BUFFER_POSICIONES[idx]
            if mergeMode then
                local existente = paramObj:get(posBlick)
                if existente and existente ~= 0.0 then
                    valFinal = limitarValor((existente + valFinal) * 0.5, minVal, maxVal)
                end
            end
            paramObj:add(posBlick, valFinal)
        end
    elseif blickStep == -2 then
        -- MODO ENVOLVENTE POR FONEMA: Puntos bloqueados a consonante/vocal
        calcularTangentesNodos()

        if fonemasComputados and #fonemasComputados > 0 then
            local numFonemas = #fonemasComputados
            for fIdx = 1, numFonemas do
                local fInfo = fonemasComputados[fIdx]
                if fInfo and fInfo.blickPosition then
                    local fPos = fInfo.blickPosition
                    if fPos >= activeOnset and fPos <= endBlick then
                        local u = (fPos - activeOnset) / activeDuration
                        local valInterp = muestrearCurvaHermite(u)
                        local valFinal = limitarValor(valInterp, minVal, maxVal)

                        if mergeMode then
                            local existente = paramObj:get(fPos)
                            if existente and existente ~= 0.0 then
                                valFinal = limitarValor((existente + valFinal) * 0.5, minVal, maxVal)
                            end
                        end
                        paramObj:add(fPos, valFinal)
                    end
                end
            end
        else
            BUFFER_POSICIONES[1] = activeOnset
            BUFFER_POSICIONES[2] = activeOnset + math.floor(activeDuration * 0.15)
            BUFFER_POSICIONES[3] = activeOnset + math.floor(activeDuration * 0.50)
            BUFFER_POSICIONES[4] = activeOnset + math.floor(activeDuration * 0.85)
            BUFFER_POSICIONES[5] = endBlick

            for idx = 1, 5 do
                local valFinal = limitarValor(EVAL_NODOS.val[idx], minVal, maxVal)
                local posBlick = BUFFER_POSICIONES[idx]
                if mergeMode then
                    local existente = paramObj:get(posBlick)
                    if existente and existente ~= 0.0 then
                        valFinal = limitarValor((existente + valFinal) * 0.5, minVal, maxVal)
                    end
                end
                paramObj:add(posBlick, valFinal)
            end
        end

        local valEnd = limitarValor(EVAL_NODOS.val[5], minVal, maxVal)
        paramObj:add(endBlick, valEnd)

    elseif blickStep == -1 then
        -- MODO ADAPTATIVO INTELIGENTE (Smart DOD Spline)
        calcularTangentesNodos()
        local stepAdapt = math.max(math.floor(SV.QUARTER / 32), math.floor(activeDuration / 16))
        local currBlick = activeOnset
        local valPrev = nil

        while currBlick <= endBlick do
            local u = (currBlick - activeOnset) / activeDuration
            local valInterp = muestrearCurvaHermite(u)
            local valFinal = limitarValor(valInterp, minVal, maxVal)

            if (valPrev == nil) or (math.abs(valFinal - valPrev) > 0.005) or (currBlick == activeOnset) or (currBlick == endBlick) then
                if mergeMode then
                    local existente = paramObj:get(currBlick)
                    if existente and existente ~= 0.0 then
                        valFinal = limitarValor((existente + valFinal) * 0.5, minVal, maxVal)
                    end
                end
                paramObj:add(currBlick, valFinal)
                valPrev = valFinal
            end
            currBlick = currBlick + stepAdapt
        end
        local valEnd = limitarValor(EVAL_NODOS.val[5], minVal, maxVal)
        paramObj:add(endBlick, valEnd)

        if paramObj.simplify then
            paramObj:simplify(activeOnset, endBlick, obtenerToleranciaSimplificacion(paramObj))
        end
    else
        -- Muestra denso uniforme
        local step = math.max(1, blickStep)
        calcularTangentesNodos()
        local currBlick = activeOnset
        while currBlick <= endBlick do
            local u = (currBlick - activeOnset) / activeDuration
            local valInterp = muestrearCurvaHermite(u)
            local valFinal = limitarValor(valInterp, minVal, maxVal)

            if mergeMode then
                local existente = paramObj:get(currBlick)
                if existente and existente ~= 0.0 then
                    valFinal = limitarValor((existente + valFinal) * 0.5, minVal, maxVal)
                end
            end

            paramObj:add(currBlick, valFinal)
            currBlick = currBlick + step
        end
        local valEnd = limitarValor(EVAL_NODOS.val[5], minVal, maxVal)
        paramObj:add(endBlick, valEnd)

        if paramObj.simplify then
            paramObj:simplify(activeOnset, endBlick, obtenerToleranciaSimplificacion(paramObj))
        end
    end
end
