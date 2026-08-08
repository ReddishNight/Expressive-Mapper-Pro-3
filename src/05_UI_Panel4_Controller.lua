-- ============================================================================
-- MÓDULO 5: CONTROLADOR PRINCIPAL E INTERFAZ DE USUARIO
-- ============================================================================

local NOTAS_NOMBRES_ARRAY = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" }

-- Índice del preset "Personalizado" en la lista (0-indexed, posición 2)
local PRESET_PERSONALIZADO_IDX = 2

local function obtenerNombreNotaMidi(pitchMidi)
    local noteVal = pitchMidi % 12
    local octave = math.floor(pitchMidi / 12) - 1
    local name = NOTAS_NOMBRES_ARRAY[noteVal + 1] or "C"
    return name, octave
end

-- ============================================================================
-- SISTEMA DE PERSISTENCIA DE CONFIGURACIÓN Y PREFERENCIAS DEL USUARIO
-- ============================================================================

local function obtenerRutaConfigUsuario()
    local appData = os.getenv("APPDATA")
    if appData and appData ~= "" then
        return appData .. "\\Dreamtonics\\Synthesizer V Studio 2\\scripts\\mapeador_user_config.json"
    end
    return "mapeador_user_config.json"
end

local function deserializarJSONSimple(jsonStr)
    local t = {}
    if not jsonStr or jsonStr == "" then return t end
    for k, v in string.gmatch(jsonStr, '"([^"]+)"%s*:%s*([^,}]+)') do
        v = string.match(v, '^%s*(.-)%s*$')
        if v == "true" then
            t[k] = true
        elseif v == "false" then
            t[k] = false
        elseif string.sub(v, 1, 1) == '"' and string.sub(v, -1) == '"' then
            local s = string.sub(v, 2, -2)
            s = string.gsub(s, '\\"', '"')
            s = string.gsub(s, '\\\\', '\\')
            s = string.gsub(s, '\\n', '\n')
            t[k] = s
        else
            local num = tonumber(v)
            if num ~= nil then t[k] = num else t[k] = v end
        end
    end
    return t
end

local function normalizarConfiguracionIdioma(config)
    if config then
        config.idiomaUI = nil
    end
    return config
end

local function serializarJSONSimple(t)
    local parts = {}
    for k, v in pairs(t) do
        local valStr = ""
        if type(v) == "boolean" then
            valStr = v and "true" or "false"
        elseif type(v) == "number" then
            valStr = tostring(v)
        elseif type(v) == "string" then
            local cleanStr = string.gsub(v, '\\', '\\\\')
            cleanStr = string.gsub(cleanStr, '"', '\\"')
            cleanStr = string.gsub(cleanStr, '\n', '\\n')
            valStr = '"' .. cleanStr .. '"'
        end
        if valStr ~= "" then
            parts[#parts + 1] = '"' .. tostring(k) .. '": ' .. valStr
        end
    end
    return "{\n  " .. table.concat(parts, ",\n  ") .. "\n}"
end

local function guardarConfiguracionUsuario(answers)
    if not answers then return end
    pcall(function()
        answers = normalizarConfiguracionIdioma(answers)
        local ruta = obtenerRutaConfigUsuario()
        local f = io.open(ruta, "w")
        if f then
            local jsonContent = serializarJSONSimple(answers)
            f:write(jsonContent)
            f:close()
        end
    end)
end

local function cargarConfiguracionUsuario()
    local config = {}
    pcall(function()
        local ruta = obtenerRutaConfigUsuario()
        local f = io.open(ruta, "r")
        if f then
            local content = f:read("*a")
            f:close()
            if content and content ~= "" then
                config = deserializarJSONSimple(content)
            end
        end
    end)
    return normalizarConfiguracionIdioma(config)
end

--- Mostrar diálogo de preset personalizado y retornar tabla de configuración
local function mostrarDialogoPresetPersonalizado(tr, cfgGuardada)
    local defT = (cfgGuardada and tonumber(cfgGuardada.customTension)) or 0
    local defB = (cfgGuardada and tonumber(cfgGuardada.customBreath)) or 0
    local defV = (cfgGuardada and tonumber(cfgGuardada.customVolume)) or 0
    local defG = (cfgGuardada and tonumber(cfgGuardada.customGender)) or 0
    local defVc = (cfgGuardada and tonumber(cfgGuardada.customVoicing)) or 70
    local defTb = (cfgGuardada and tonumber(cfgGuardada.customTimbre)) or 0

    local dialogoCustom = {
        title = tr.presetChoices and (tr.presetChoices[PRESET_PERSONALIZADO_IDX + 1] or "Custom") or "Custom",
        message = "",
        buttons = "OkCancel",
        widgets = {
            {
                name = "customTension",
                type = "Slider",
                label = tr.customTensionLabel or "Tension",
                format = "%.2f",
                minValue = -100,
                maxValue = 100,
                interval = 5,
                default = defT
            },
            {
                name = "customBreath",
                type = "Slider",
                label = tr.customBreathLabel or "Breathiness",
                format = "%.2f",
                minValue = -100,
                maxValue = 100,
                interval = 5,
                default = defB
            },
            {
                name = "customVolume",
                type = "Slider",
                label = tr.customVolumeLabel or "Volume (dB)",
                format = "%.1f",
                minValue = -60,
                maxValue = 60,
                interval = 5,
                default = defV
            },
            {
                name = "customGender",
                type = "Slider",
                label = tr.customGenderLabel or "Gender",
                format = "%.2f",
                minValue = -100,
                maxValue = 100,
                interval = 5,
                default = defG
            },
            {
                name = "customVoicing",
                type = "Slider",
                label = tr.customVoicingLabel or "Voicing",
                format = "%.2f",
                minValue = 0,
                maxValue = 100,
                interval = 5,
                default = defVc
            },
            {
                name = "customTimbre",
                type = "Slider",
                label = tr.customTimbreLabel or "Timbre",
                format = "%.2f",
                minValue = -100,
                maxValue = 100,
                interval = 5,
                default = defTb
            }
        }
    }

    local resultado = SV:showCustomDialog(dialogoCustom)
    if not resultado.status then
        return nil
    end

    local ans = resultado.answers or {}
    if cfgGuardada then
        cfgGuardada.customTension = ans.customTension or 0
        cfgGuardada.customBreath  = ans.customBreath or 0
        cfgGuardada.customVolume  = ans.customVolume or 0
        cfgGuardada.customGender  = ans.customGender or 0
        cfgGuardada.customVoicing = ans.customVoicing or 70
        cfgGuardada.customTimbre  = ans.customTimbre or 0
    end

    local t = (ans.customTension or 0) / 100.0
    local b = (ans.customBreath or 0) / 100.0
    local v = (ans.customVolume or 0) / 10.0
    local g = (ans.customGender or 0) / 100.0
    local vc = (ans.customVoicing or 70) / 100.0
    local tb = (ans.customTimbre or 0) / 100.0

    return {
        tension   = { t, t * 0.9, t * 0.85, t * 0.9, t * 0.7 },
        aliento   = { b, b * 0.9, b * 0.85, b * 0.9, b * 0.7 },
        volumen   = { v * 0.8, v, v * 1.1, v, v * 0.5 },
        genero    = { g, g, g, g, g },
        voicing   = { vc, vc, vc, vc, vc * 0.9 },
        timbre    = { tb, tb, tb, tb, tb },
        vibrato   = { 0.0, 0.2, 0.7, 1.0, 0.8 },
        vocalModeTarget = {},
        scoopCents = -20.0, vbrDepthCents = 50.0, vbrFreqHz = 5.5, expPadX = 0.0, expPadY = 0.0
    }
end


-- ============================================================================
-- DECLARACIÓN DE VARIABLES LOCALES PARA EL PANEL LATERAL (SidePanelSection)
-- ============================================================================
local valVistaSeccion, valIdiomaUI, valModo, valPreset, valIntensidad, valDensityStep
local valModoRitmo, valModoMelodia, valEscalaMelodica, valTonica, valAutoDetectKey
local valModoArmonia, valPresetCoral, valAntiFaseMs, valAntiFaseCents
local valEspecieContrapunto, valProgresionAcordes, valRitmoAcordes, valLetra, valBasePitch
local valNoteDuration, valTargetNotesMode, valArmoniaIntervalosCustom, valRangoNotaMin, valRangoNotaMax
local valEnableJustIntonation, valEnableVocalModes, valEnableDetune, valEnableExpPad
local valEnableSmartVibrato, valMergeMode, valLimpiarPrevios, valAdaptarTempo
local valCompensarGanancia, valProcesarTodosGrupos, valHumanizacion, valRegistro, valFonema
local valCustomTension, valCustomBreath, valCustomVolume, valCustomGender, valCustomVoicing, valCustomTimbre


local valIdiomaUI, valPanel4Modo, valEspecieContrapunto, valProgresionAcordes, valRitmoAcordes, valEscalaMelodica, valTonica, valAutoDetectKey
local statusText = ""
local panelWidgets = nil

local function leerValorWidget(widget, fallback)
    if widget and type(widget.getValue) == "function" then
        local v = widget:getValue()
        if v ~= nil then
            return v
        end
    end
    return fallback
end

local function refrescarEstadoPanel4()
    statusText = ""
    local currentCfg = cargarConfiguracionUsuario()
    if panelWidgets then
        currentCfg.panel4Modo = tonumber(panelWidgets.panel4Modo:getValue() or currentCfg.panel4Modo) or currentCfg.panel4Modo or 1
        currentCfg.especieContrapunto = tonumber(panelWidgets.especieContrapunto:getValue() or currentCfg.especieContrapunto) or currentCfg.especieContrapunto or 0
        currentCfg.progresionAcordes = tonumber(panelWidgets.progresionAcordes:getValue() or currentCfg.progresionAcordes) or currentCfg.progresionAcordes or 0
        currentCfg.ritmoAcordes = tonumber(panelWidgets.ritmoAcordes:getValue() or currentCfg.ritmoAcordes) or currentCfg.ritmoAcordes or 0
        currentCfg.escalaMelodica = tonumber(panelWidgets.escalaMelodica:getValue() or currentCfg.escalaMelodica) or currentCfg.escalaMelodica or 2
        currentCfg.tonica = tonumber(panelWidgets.tonica:getValue() or currentCfg.tonica) or currentCfg.tonica or 0
        currentCfg.autoDetectKey = panelWidgets.autoDetectKey:getValue() == true
        guardarConfiguracionUsuario(currentCfg)
    end
    SV:refreshSidePanel()
end

local function asegurarWidgetsPanel4(cfg)
    local idiomaInicial = _G.idiomaDetectado or 0

    if not panelWidgets then
        panelWidgets = {
            idiomaUI = SV:create("WidgetValue"),
            panel4Modo = SV:create("WidgetValue"),
            especieContrapunto = SV:create("WidgetValue"),
            progresionAcordes = SV:create("WidgetValue"),
            ritmoAcordes = SV:create("WidgetValue"),
            escalaMelodica = SV:create("WidgetValue"),
            tonica = SV:create("WidgetValue"),
            autoDetectKey = SV:create("WidgetValue"),
            runButton = SV:create("WidgetValue")
        }
        panelWidgets.idiomaUI:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.panel4Modo:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.especieContrapunto:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.progresionAcordes:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.ritmoAcordes:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.escalaMelodica:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.tonica:setValueChangeCallback(refrescarEstadoPanel4)
        panelWidgets.autoDetectKey:setValueChangeCallback(refrescarEstadoPanel4)

        panelWidgets.runButton:setValueChangeCallback(function()
            ejecutarOperacionPrincipal()
        end)

        panelWidgets.idiomaUI:setValue(idiomaInicial)
        panelWidgets.panel4Modo:setValue(cfg.panel4Modo ~= nil and tonumber(cfg.panel4Modo) or 1)
        panelWidgets.especieContrapunto:setValue(cfg.especieContrapunto ~= nil and tonumber(cfg.especieContrapunto) or 0)
        panelWidgets.progresionAcordes:setValue(cfg.progresionAcordes ~= nil and tonumber(cfg.progresionAcordes) or 0)
        panelWidgets.ritmoAcordes:setValue(cfg.ritmoAcordes ~= nil and tonumber(cfg.ritmoAcordes) or 0)
        panelWidgets.escalaMelodica:setValue(cfg.escalaMelodica ~= nil and tonumber(cfg.escalaMelodica) or 2)
        panelWidgets.tonica:setValue(cfg.tonica ~= nil and tonumber(cfg.tonica) or 0)
        panelWidgets.autoDetectKey:setValue(cfg.autoDetectKey == nil and true or (cfg.autoDetectKey == true))
    end

    return panelWidgets
end

function getSidePanelSectionState()
    local cfg = cargarConfiguracionUsuario()
    local idiomaInicial = _G.idiomaDetectado or 0

    local widgets = asegurarWidgetsPanel4(cfg)

    valIdiomaUI = idiomaInicial
    valPanel4Modo = tonumber(leerValorWidget(widgets.panel4Modo, cfg.panel4Modo ~= nil and tonumber(cfg.panel4Modo) or 1)) or 1
    valEspecieContrapunto = tonumber(leerValorWidget(widgets.especieContrapunto, cfg.especieContrapunto ~= nil and tonumber(cfg.especieContrapunto) or 0)) or 0
    valProgresionAcordes = tonumber(leerValorWidget(widgets.progresionAcordes, cfg.progresionAcordes ~= nil and tonumber(cfg.progresionAcordes) or 0)) or 0
    valRitmoAcordes = tonumber(leerValorWidget(widgets.ritmoAcordes, cfg.ritmoAcordes ~= nil and tonumber(cfg.ritmoAcordes) or 0)) or 0
    valEscalaMelodica = tonumber(leerValorWidget(widgets.escalaMelodica, cfg.escalaMelodica ~= nil and tonumber(cfg.escalaMelodica) or 2)) or 2
    valTonica = tonumber(leerValorWidget(widgets.tonica, cfg.tonica ~= nil and tonumber(cfg.tonica) or 0)) or 0
    valAutoDetectKey = leerValorWidget(widgets.autoDetectKey, cfg.autoDetectKey == nil and true or (cfg.autoDetectKey == true))

    local tr = I18N_DATA[valIdiomaUI] or I18N_DATA[0]
    
    local valEsc = widgets.escalaMelodica:getValue()
    if not valEsc or valEsc < 0 or valEsc >= (tr.escalaChoices and #tr.escalaChoices or 15) then
        widgets.escalaMelodica:setValue(2)
        valEscalaMelodica = 2
    end
    local valTon = widgets.tonica:getValue()
    if not valTon or valTon < 0 or valTon >= 12 then
        widgets.tonica:setValue(0)
        valTonica = 0
    end

    local modoP4 = valPanel4Modo
    
    local choicesModoP4 = { "Contrapunto Fuxiano", "Progresión de Acordes", "Sincronizar Grupos de Coros", "Forzar Afinación Diatónica" }
    if valIdiomaUI == 1 then
        choicesModoP4 = { "Fuxian Counterpoint", "Chord Progression", "Synchronize Choir Groups", "Snap to Diatonic Scale" }
    elseif valIdiomaUI == 2 then
        choicesModoP4 = { "対位法 (Fuxian)", "コード進行", "コーラスグループ同期", "スケールへのピッチ補正" }
    end

    local rows = {
        { type = "Label", text = tr.vistaSeccionChoices[4] or "Counterpoint & Chord Progression" },
        {
            type = "Container",
            columns = {
                { type = "Label", text = "Algoritmo / Selector" },
                { type = "ComboBox", choices = choicesModoP4, value = widgets.panel4Modo }
            }
        }
    }

    if modoP4 == 0 or modoP4 == 1 or modoP4 == 3 then
        local NOTAS_NOMBRES_ARRAY = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" }
        table.insert(rows, {
            type = "Container",
            columns = {
                { type = "Label", text = tr.autoDetectKeyLabel or "Auto-Detectar Tonalidad" },
                { type = "CheckBox", text = tr.autoDetectKeyLabel or "Auto-Detectar Tonalidad", value = widgets.autoDetectKey }
            }
        })
        table.insert(rows, {
            type = "Container",
            columns = {
                { type = "Label", text = tr.tonicaLabel or "Tónica" },
                { type = "ComboBox", choices = NOTAS_NOMBRES_ARRAY, value = widgets.tonica }
            }
        })
        table.insert(rows, {
            type = "Container",
            columns = {
                { type = "Label", text = tr.escalaLabel or "Escala Armónica" },
                { type = "ComboBox", choices = tr.escalaChoices, value = widgets.escalaMelodica }
            }
        })
    end

    if modoP4 == 0 then
        -- Contrapunto (Modo 3)
        table.insert(rows, {
            type = "Container",
            columns = {
                { type = "Label", text = tr.especieContrapuntoLabel or "Especie" },
                { type = "ComboBox", choices = tr.especieContrapuntoChoices, value = widgets.especieContrapunto }
            }
        })
    elseif modoP4 == 1 then
        -- Acordes (Modo 4)
        table.insert(rows, {
            type = "Container",
            columns = {
                { type = "Label", text = tr.progresionAcordesLabel or "Progresión" },
                { type = "ComboBox", choices = tr.progresionAcordesChoices, value = widgets.progresionAcordes }
            }
        })
        table.insert(rows, {
            type = "Container",
            columns = {
                { type = "Label", text = tr.ritmoAcordesLabel or "Patrón Rítmico" },
                { type = "ComboBox", choices = tr.ritmoAcordesChoices, value = widgets.ritmoAcordes }
            }
        })
    end

    table.insert(rows, {
        type = "Container",
        columns = {
            {
                type = "Button",
                text = tr.applyButtonLabel or "Aplicar",
                value = widgets.runButton,
                width = 1.0
            }
        }
    })

    if statusText and statusText ~= "" then
        table.insert(rows, {
            type = "Label",
            text = statusText
        })
    end

    return {
        title = "Chords & Counterpoint",
        rows = rows
    }
end

function ejecutarOperacionPrincipal()
    local cfg = cargarConfiguracionUsuario()
    local p4m = valPanel4Modo or (panelWidgets and panelWidgets.panel4Modo and panelWidgets.panel4Modo:getValue()) or 1
    if panelWidgets then
        p4m = tonumber(panelWidgets.panel4Modo:getValue() or p4m) or p4m
        cfg.panel4Modo = p4m
        cfg.especieContrapunto = tonumber(panelWidgets.especieContrapunto:getValue() or cfg.especieContrapunto) or cfg.especieContrapunto or 0
        cfg.progresionAcordes = tonumber(panelWidgets.progresionAcordes:getValue() or cfg.progresionAcordes) or cfg.progresionAcordes or 0
        cfg.ritmoAcordes = tonumber(panelWidgets.ritmoAcordes:getValue() or cfg.ritmoAcordes) or cfg.ritmoAcordes or 0
        cfg.escalaMelodica = tonumber(panelWidgets.escalaMelodica:getValue() or cfg.escalaMelodica) or cfg.escalaMelodica or 2
        cfg.tonica = tonumber(panelWidgets.tonica:getValue() or cfg.tonica) or cfg.tonica or 0
        cfg.autoDetectKey = panelWidgets.autoDetectKey:getValue() == true
    end
    
    local modoReal = 4
    if p4m == 0 then modoReal = 3
    elseif p4m == 1 then modoReal = 4
    elseif p4m == 2 then modoReal = 5
    elseif p4m == 3 then modoReal = 6
    end
    cfg.modo = modoReal

    local cfg_final = {
        modo = modoReal,
        panel4Modo = p4m,
        especieContrapunto = cfg.especieContrapunto,
        progresionAcordes = cfg.progresionAcordes,
        ritmoAcordes = cfg.ritmoAcordes,
        escalaMelodica = cfg.escalaMelodica,
        tonica = cfg.tonica,
        autoDetectKey = cfg.autoDetectKey,
        intensidad = 100,
        preset = 0,
        valHumanizacion = 100,
        valRegistro = 100,
        valFonema = 100
    }
    guardarConfiguracionUsuario(cfg_final)
    local cfg = cfg_final

    -- Mapear variables para compatibilidad con el backend
    local modoOperacion       = cfg.modo
    local presetIndex         = cfg.preset
    local valIntensidad       = cfg.intensidad
    local valIntensidadVal    = cfg.intensidad
    local factorIntensidad    = valIntensidadVal / 100.0
    local densityChoice       = 0
    local modoRitmoIdx        = 0
    local modoMelodiaIdx      = 0
    local escalaIdx           = 2
    local tonicaIdx           = 0
    local autoDetectKey       = true
    local modoArmoniaIdx      = 0
    local presetCoralIdx      = 0
    local antiFaseMs          = 12
    local antiFaseCents       = 10
    local especieContrapuntoIdx = cfg.especieContrapunto
    local progresionAcordesIdx  = cfg.progresionAcordes
    local ritmoAcordesIdx       = cfg.ritmoAcordes
    local activarVocalModes   = true
    local activarDetune       = true
    local activarExpPad       = true
    local activarSmartVibrato = true
    local mergeMode           = false
    local limpiarPrevios      = true
    local adaptarTempo        = true
    local compensarGanancia   = false
    local procesarTodosGrupos = false
    local factorHumanizeMult  = 1.0
    local factorRegisterMult  = 1.0
    local factorPhonemeMult   = 1.0
    local letraRaw            = ""
    local basePitch           = 60
    local durationIndex       = 1
    local targetNotesMode     = 0
    local armoniaIntervalosCustom = "+3, +7, -5"
    local rangoNotaMin        = 48
    local rangoNotaMax        = 72
    local enableJustIntonation = true
    local vistaSeccion        = 3
    local langIdx                   = _G.idiomaDetectado or 0
    local tr                        = I18N_DATA[langIdx] or I18N_DATA[0]

    local modoOperacion       = cfg.modo
    local presetIndex         = cfg.preset
    local valIntensidadVal    = cfg.intensidad
    local factorIntensidad    = valIntensidadVal / 100.0
    local densityChoice       = cfg.densityStep or 0
    local modoRitmoIdx        = cfg.modoRitmo
    local modoMelodiaIdx      = cfg.modoMelodia
    local escalaIdx           = cfg.escalaMelodica
    local tonicaIdx           = cfg.tonica
    local autoDetectKey       = (cfg.autoDetectKey ~= false)

    local modoArmoniaIdx      = cfg.modoArmonia
    local presetCoralIdx      = cfg.presetCoral
    local antiFaseMs          = cfg.antiFaseMs
    local antiFaseCents       = cfg.antiFaseCents

    local especieContrapuntoIdx = cfg.especieContrapunto
    local progresionAcordesIdx  = cfg.progresionAcordes
    local ritmoAcordesIdx       = cfg.ritmoAcordes

    local activarVocalModes   = (cfg.enableVocalModes ~= false)
    local activarDetune       = (cfg.enableDetune ~= false)
    local activarExpPad       = (cfg.enableExpPad ~= false)
    local activarSmartVibrato = (cfg.enableSmartVibrato ~= false)
    local mergeMode           = (cfg.mergeMode == true)
    local limpiarPrevios      = (cfg.limpiarPrevios ~= false)
    local adaptarTempo        = (cfg.adaptarTempo ~= false)
    local compensarGanancia   = (cfg.compensarGanancia == true)
    local procesarTodosGrupos = (cfg.procesarTodosGrupos == true)
    local factorHumanizeMult  = (cfg.valHumanizacion ~= nil and tonumber(cfg.valHumanizacion) or 100) / 100.0
    local factorRegisterMult  = (cfg.valRegistro ~= nil and tonumber(cfg.valRegistro) or 100) / 100.0
    local factorPhonemeMult   = (cfg.valFonema ~= nil and tonumber(cfg.valFonema) or 100) / 100.0
    local letraRaw            = cfg.letra or tr.letraDefault

    local basePitch           = cfg.basePitch or 60
    if basePitch < 36 or basePitch > 84 then basePitch = 60 end
    local durationIndex       = cfg.noteDuration or 1

    local targetNotesMode     = cfg.targetNotesMode or 0
    local armoniaIntervalosCustom = cfg.armoniaIntervalosCustom or "+3, +7, -5"
    local rangoNotaMin        = cfg.rangoNotaMin or 48
    local rangoNotaMax        = cfg.rangoNotaMax or 72
    local enableJustIntonation = (cfg.enableJustIntonation == true)
    local vistaSeccion        = cfg.vistaSeccion or 0


    local proyecto = SV:getProject()
    local timeAxis = proyecto:getTimeAxis()
    local editorPrincipal = SV:getMainEditor()
    local pistaActual = editorPrincipal:getCurrentTrack()

    if not pistaActual then
        statusText = "[Error] " .. (tr.errContextMsg or "No active track")
        SV:refreshSidePanel()
        return
    end

    local groupRefActivo = editorPrincipal:getCurrentGroup() or pistaActual:getGroupReference(1)
    local noteGroupActivo = groupRefActivo and groupRefActivo:getTarget()

    -- Auto-detectar tonalidad con Krumhansl-Kessler si está activado
    if autoDetectKey and noteGroupActivo then
        local tDet, eDet = detectarTonalidad(noteGroupActivo)
        tonicaIdx = tDet
        escalaIdx = eDet
    end

    -- Obtener o construir preset de expresión
    local configPreset = nil
    if presetIndex == 0 then
        -- [Por Defecto] Estándar Universal (Preset 8 balanceado)
        configPreset = PRESET_EXPRESION[8]
    elseif presetIndex == 1 then
        -- [Última Sesión] Cargar Configuración Guardada Anterior
        if cfg and cfg.customTension ~= nil then
            local t = (tonumber(cfg.customTension) or 0) / 100.0
            local b = (tonumber(cfg.customBreath) or 0) / 100.0
            local v = (tonumber(cfg.customVolume) or 0) / 10.0
            local g = (tonumber(cfg.customGender) or 0) / 100.0
            local vc = (tonumber(cfg.customVoicing) or 70) / 100.0
            local tb = (tonumber(cfg.customTimbre) or 0) / 100.0
            configPreset = {
                tension   = { t, t * 0.9, t * 0.85, t * 0.9, t * 0.7 },
                aliento   = { b, b * 0.9, b * 0.85, b * 0.9, b * 0.7 },
                volumen   = { v * 0.8, v, v * 1.1, v, v * 0.5 },
                genero    = { g, g, g, g, g },
                voicing   = { vc, vc, vc, vc, vc * 0.9 },
                timbre    = { tb, tb, tb, tb, tb },
                vibrato   = { 0.0, 0.2, 0.7, 1.0, 0.8 },
                vocalModeTarget = {},
                pitchSensitivity = 0.50, phonemeSensitivity = 0.50, humanizeJitter = 0.05,
                attackPunch = 0.0, releaseBreath = 0.0,
                scoopCents = -20.0, vbrDepthCents = 50.0, vbrFreqHz = 5.5, expPadX = 0.0, expPadY = 0.0
            }
        else
            configPreset = PRESET_EXPRESION[8]
        end
    elseif presetIndex == PRESET_PERSONALIZADO_IDX then
        configPreset = mostrarDialogoPresetPersonalizado(tr, cfg)
        if not configPreset then
            
            return
        end
    else
        local idxExpr = presetIndex - 3
        if PRESET_EXPRESION[idxExpr] then
            configPreset = PRESET_EXPRESION[idxExpr]
        else
            configPreset = PRESET_EXPRESION[8]
        end
    end

    -- Confirmación pre-ejecución
    local nomNota, octNota = obtenerNombreNotaMidi(basePitch)
    local nomPreset = tr.presetChoices and (tr.presetChoices[presetIndex + 1] or tr.presetChoices[1]) or "Estándar"
    local confirmMsg = ""

    if modoOperacion == 0 then
        local silabasPreview = extraerSilabas(letraRaw, langIdx)
        local numSilabasPreview = 0
        for si = 1, #silabasPreview do
            local s = silabasPreview[si]
            if s ~= "_" and s ~= "," and s ~= "." and s ~= "、" and s ~= "。" then
                numSilabasPreview = numSilabasPreview + 1
            end
        end
        confirmMsg = string.format(tr.confirmMsgGenerar, numSilabasPreview, nomNota, octNota, nomPreset, valIntensidad)
    elseif modoOperacion == 1 then
        confirmMsg = string.format(tr.confirmMsgExpresar, nomPreset, valIntensidad)
    elseif modoOperacion == 2 then
        local nomArm = tr.modoArmoniaChoices[modoArmoniaIdx + 1] or "3ra"
        confirmMsg = string.format(tr.confirmMsgArmonia, nomArm)
    elseif modoOperacion == 3 then
        local nomContra = tr.especieContrapuntoChoices[especieContrapuntoIdx + 1] or "1ra Especie"
        confirmMsg = string.format(tr.confirmMsgContrapunto, nomContra)
    elseif modoOperacion == 4 then
        local nomProg = tr.progresionAcordesChoices[progresionAcordesIdx + 1] or "Pop"
        confirmMsg = string.format(tr.confirmMsgProgresion, nomProg)
    elseif modoOperacion == 5 then
        confirmMsg = tr.confirmMsgSincronizar
    elseif modoOperacion == 6 then
        local nomEscala = tr.escalaChoices[escalaIdx + 1] or "Mayor"
        local nomTonica = NOTAS_NOMBRES_ARRAY[tonicaIdx + 1] or "C"
        confirmMsg = string.format(tr.confirmMsgForzar, nomEscala, nomTonica)
    end

    if rangoNotaMin >= rangoNotaMax then
        statusText = tr.idiomaUI == 0 and "[Error] Rango de nota mínimo debe ser menor que el máximo." or "[Error] Minimum note range must be lower than maximum."
        SV:refreshSidePanel()
        return
    end

    -- Registro de Undo Atómico
    proyecto:newUndoRecord()

    local blickStepDensity = -1
    local densityIdx = densityChoice + 1
    if densityIdx >= 1 and densityIdx <= #FACTOR_DENSIDAD then
        local factorVal = FACTOR_DENSIDAD[densityIdx]
        if factorVal > 0 then
            blickStepDensity = math.floor(SV.QUARTER / factorVal)
        else
            blickStepDensity = factorVal
        end
    end

    local offsetLoudnessDb = 0.0
    if compensarGanancia then
        local mixer = pistaActual:getMixer()
        if mixer then
            offsetLoudnessDb = -mixer:getGainDecibel()
        end
    end
    if modoOperacion == 2 then
        if not groupRefActivo then
            statusText = "[Error] " .. (tr.errNoNotesMsg or "No notes found")
            SV:refreshSidePanel()
            return
        end

        local totalArmonias = generarPistasArmonia(proyecto, pistaActual, groupRefActivo, tonicaIdx, escalaIdx, modoArmoniaIdx, presetCoralIdx, antiFaseMs, antiFaseCents, factorIntensidad, configPreset, timeAxis, armoniaIntervalosCustom, enableJustIntonation)
        statusText = string.format(tr.completedMsg, (totalArmonias or 0), (nomPreset or ""), (valIntensidad or 0), 1)
        SV:refreshSidePanel()
        return

    elseif modoOperacion == 3 then
        if not groupRefActivo then
            statusText = "[Error] " .. (tr.errNoNotesMsg or "No notes found")
            SV:refreshSidePanel()
            return
        end

        local totalContra = generarPistaContrapunto(proyecto, pistaActual, groupRefActivo, especieContrapuntoIdx, tonicaIdx, escalaIdx, factorIntensidad, configPreset, timeAxis)
        statusText = string.format(tr.completedMsg, (totalContra or 0), (nomPreset or ""), (valIntensidad or 0), 1)
        SV:refreshSidePanel()
        return

    elseif modoOperacion == 4 then
        local totalAcordes = generarProgresionAcordes(proyecto, pistaActual, progresionAcordesIdx, tonicaIdx, escalaIdx, ritmoAcordesIdx, factorIntensidad, configPreset, timeAxis, groupRefActivo)
        statusText = string.format(tr.completedMsg, (totalAcordes or 0), (nomPreset or ""), (valIntensidad or 0), 1)
        SV:refreshSidePanel()
        return

    elseif modoOperacion == 5 then
        if not groupRefActivo then
            statusText = "[Error] " .. (tr.errNoNotesMsg or "No notes found")
            SV:refreshSidePanel()
            return
        end

        local grupoGuiaTarget = groupRefActivo:getTarget()
        local numNotasGuia = grupoGuiaTarget:getNumNotes()
        if numNotasGuia == 0 then
            statusText = "[Error] " .. (tr.errNoNotesMsg or "No notes found")
            SV:refreshSidePanel()
            return
        end

        local notasGuia = {}
        for ni = 1, numNotasGuia do
            notasGuia[ni] = grupoGuiaTarget:getNote(ni)
        end
        table.sort(notasGuia, function(a, b) return a:getOnset() < b:getOnset() end)

        local totalGruposSincronizados = 0
        local totalPistas = proyecto:getNumTracks()

        for ti = 1, totalPistas do
            local track = proyecto:getTrack(ti)
            if track then
                local numGroups = track:getNumGroups()
                for gi = 1, numGroups do
                    local gRef = track:getGroupReference(gi)
                    if gRef and gRef:getTarget() ~= grupoGuiaTarget then
                        local targetGroup = gRef:getTarget()
                        local numNotasDest = targetGroup:getNumNotes()
                        if numNotasDest == numNotasGuia then
                            local notasDest = {}
                            for ni = 1, numNotasDest do
                                notasDest[ni] = targetGroup:getNote(ni)
                            end
                            table.sort(notasDest, function(a, b) return a:getOnset() < b:getOnset() end)

                            for ni = 1, numNotasGuia do
                                local nGuia = notasGuia[ni]
                                local nDest = notasDest[ni]
                                nDest:setLyrics(nGuia:getLyrics())
                                nDest:setTimeRange(nGuia:getOnset(), nGuia:getDuration())
                                nDest:setPhonemes(nGuia:getPhonemes())
                            end
                            totalGruposSincronizados = totalGruposSincronizados + 1
                        end
                    end
                end
            end
        end

        statusText = string.format("Sincronización completada. Grupos: %d", totalGruposSincronizados)
        SV:refreshSidePanel()
        return

    elseif modoOperacion == 6 then
        if not groupRefActivo then
            statusText = "[Error] " .. (tr.errNoNotesMsg or "No notes found")
            SV:refreshSidePanel()
            return
        end

        local targetGroup = groupRefActivo:getTarget()
        local numNotas = targetGroup:getNumNotes()
        if numNotas == 0 then
            statusText = "[Error] " .. (tr.errNoNotesMsg or "No notes found")
            SV:refreshSidePanel()
            return
        end

        local tonica = tonicaIdx
        local escalaIndices = ESCALAS_AVANZADAS[escalaIdx] or { 0, 2, 4, 5, 7, 9, 11 }
        local totalNotasCorregidas = 0

        for ni = 1, numNotas do
            local nota = targetGroup:getNote(ni)
            local pitchActual = nota:getPitch()
            
            local semitonoRel = (pitchActual - tonica) % 12
            if semitonoRel < 0 then semitonoRel = semitonoRel + 12 end
            local octava = math.floor((pitchActual - tonica) / 12)

            -- Buscar el grado más cercano en la escala diatónica
            local minDiff = 999
            local gradoCercano = escalaIndices[1]
            for i = 1, #escalaIndices do
                local diff = math.abs(semitonoRel - escalaIndices[i])
                if diff < minDiff then
                    minDiff = diff
                    gradoCercano = escalaIndices[i]
                end
            end

            local nuevoPitch = (octava * 12) + tonica + gradoCercano
            
            -- Acotar al rango de nota configurado
            if nuevoPitch < rangoNotaMin then nuevoPitch = rangoNotaMin end
            if nuevoPitch > rangoNotaMax then nuevoPitch = rangoNotaMax end

            if nuevoPitch ~= pitchActual then
                nota:setPitch(nuevoPitch)
                totalNotasCorregidas = totalNotasCorregidas + 1
            end
        end

        statusText = string.format("Forzado completado. Notas corregidas: %d", totalNotasCorregidas)
        SV:refreshSidePanel()
        return
    end

    -- MODOS 0 Y 1: GENERACIÓN DE NOTAS / EXPRESIVIDAD EN NOTAS EXISTENTES
    local gruposAProcesar = {}
    if procesarTodosGrupos then
        local numGrupos = pistaActual:getNumGroups()
        for gi = 1, numGrupos do
            local gRef = pistaActual:getGroupReference(gi)
            if gRef then
                gruposAProcesar[#gruposAProcesar + 1] = gRef
            end
        end
    else
        gruposAProcesar[1] = groupRefActivo
    end

    local numGruposAProcesar = #gruposAProcesar
    if numGruposAProcesar == 0 then
        SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
        return
    end

    local totalNotasProcesadas = 0
    local totalVocalModesAplicados = 0

    for gi = 1, numGruposAProcesar do
        local groupRef = gruposAProcesar[gi]
        local noteGroup = groupRef:getTarget()
        if not noteGroup then goto continuar_grupo end

        local notasObjetivo = {}

        if modoOperacion == 0 then
            local durIdx = durationIndex + 1
            local factorDur = FACTOR_DURACION_SILABA[durIdx] or 1.0
            local stepBlick = math.floor(SV.QUARTER * factorDur)
            local reproductor = SV:getPlayback()

            if targetNotesMode == 1 then
                -- Reemplazar letra y pitch en las notas seleccionadas actuales
                local seleccion = editorPrincipal:getSelection()
                if seleccion:hasSelectedNotes() then
                    local notasSel = seleccion:getSelectedNotes()
                    table.sort(notasSel, function(a, b) return a:getOnset() < b:getOnset() end)
                    local silabas = extraerSilabas(letraRaw, langIdx)
                    local escala = ESCALAS_AVANZADAS[escalaIdx] or ESCALAS_AVANZADAS[2]
                    local numNotasEscala = #escala

                    local idxNotaSelect = 1
                    for si = 1, #silabas do
                        local token = silabas[si]
                        if token ~= "_" and token ~= "," and token ~= "." and token ~= "、" and token ~= "。" then
                            if idxNotaSelect <= #notasSel then
                                local notaAEditar = notasSel[idxNotaSelect]
                                local letraLimpia = string.gsub(token, "%s+", "")
                                if letraLimpia == "" then letraLimpia = "la" end
                                notaAEditar:setLyrics(letraLimpia)

                                -- Calcular pitch de acuerdo al contorno y límites
                                -- (Para simplificar, usamos una heurística rápida similar para las notas seleccionadas)
                                local pitchTarget = basePitch
                                if modoMelodiaIdx == 5 or modoMelodiaIdx == 6 or modoMelodiaIdx == 7 or modoMelodiaIdx == 8 then
                                    if modoMelodiaIdx == 5 then -- Ascendente
                                        local numOctavasPosibles = math.floor((rangoNotaMax - rangoNotaMin) / 12)
                                        local noteInOctaveIdx = ((idxNotaSelect - 1) % numNotasEscala) + 1
                                        local octaveOffsetIdx = math.floor((idxNotaSelect - 1) / numNotasEscala) % (numOctavasPosibles + 1)
                                        pitchTarget = rangoNotaMin + escala[noteInOctaveIdx] + (octaveOffsetIdx * 12)
                                    elseif modoMelodiaIdx == 6 then -- Descendente
                                        local numOctavasPosibles = math.floor((rangoNotaMax - rangoNotaMin) / 12)
                                        local noteInOctaveIdx = numNotasEscala - ((idxNotaSelect - 1) % numNotasEscala)
                                        local octaveOffsetIdx = numOctavasPosibles - (math.floor((idxNotaSelect - 1) / numNotasEscala) % (numOctavasPosibles + 1))
                                        pitchTarget = rangoNotaMin + escala[noteInOctaveIdx] + (octaveOffsetIdx * 12)
                                    elseif modoMelodiaIdx == 7 then
                                        pitchTarget = (idxNotaSelect > 1) and notasSel[idxNotaSelect - 1]:getPitch() + math.random(-2, 2) or basePitch
                                    else
                                        pitchTarget = (idxNotaSelect > 1) and notasSel[idxNotaSelect - 1]:getPitch() + ({3, 4, 5, 7, -3, -4, -5, -7})[math.random(1, 8)] or basePitch
                                    end
                                else
                                    pitchTarget = basePitch
                                end

                                local pitchFinal = cuantizarAEscala(pitchTarget, basePitch, escala)
                                if pitchFinal < rangoNotaMin then
                                    pitchFinal = rangoNotaMin + ((pitchFinal - rangoNotaMin) % 12)
                                elseif pitchFinal > rangoNotaMax then
                                    pitchFinal = rangoNotaMax - (math.abs(rangoNotaMax - pitchFinal) % 12)
                                end
                                notaAEditar:setPitch(pitchFinal)

                                notasObjetivo[#notasObjetivo + 1] = notaAEditar
                                idxNotaSelect = idxNotaSelect + 1
                            end
                        end
                    end
                end

                if #notasObjetivo == 0 then
                    SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
                    
                    return
                end
            else
                -- Crear nuevas notas desde el playhead
                notasObjetivo = generarNotasDesdeTexto(letraRaw, basePitch, stepBlick, modoMelodiaIdx, escalaIdx, modoRitmoIdx, langIdx, noteGroup, reproductor, rangoNotaMin, rangoNotaMax)
                if #notasObjetivo == 0 then
                    SV:showMessageBox(tr.errNoSyllablesTitle, tr.errNoSyllablesMsg)
                    
                    return
                end
            end
        else
            if gi == 1 and not procesarTodosGrupos then
                local seleccion = editorPrincipal:getSelection()
                if seleccion:hasSelectedNotes() then
                    local notasSel = seleccion:getSelectedNotes()
                    for ni = 1, #notasSel do
                        notasObjetivo[ni] = notasSel[ni]
                    end
                end
            end

            if #notasObjetivo == 0 then
                for ni = 1, noteGroup:getNumNotes() do
                    notasObjetivo[ni] = noteGroup:getNote(ni)
                end
            end
        end

        local totalNotas = #notasObjetivo
        if totalNotas == 0 then goto continuar_grupo end

        table.sort(notasObjetivo, function(a, b) return a:getOnset() < b:getOnset() end)

        local tensionParam    = noteGroup:getParameter("tension")
        local breathParam     = noteGroup:getParameter("breathiness")
        local genderParam     = noteGroup:getParameter("gender")
        local loudnessParam   = noteGroup:getParameter("loudness")
        local pitchDeltaParam = noteGroup:getParameter("pitchDelta")
        local vibratoParam    = noteGroup:getParameter("vibratoEnv")
        local voicingParam    = noteGroup:getParameter("voicing")
        local toneShiftParam  = noteGroup:getParameter("toneShift")

        local vocalModesActivos = {}
        if activarVocalModes then
            for vmi = 1, #VOCAL_MODE_NOMBRES do
                local vmParam = noteGroup:getParameter(VOCAL_MODE_KEYS[vmi])
                if vmParam then
                    vocalModesActivos[#vocalModesActivos + 1] = {
                        nombre = VOCAL_MODE_NOMBRES[vmi],
                        nombreMin = string.lower(VOCAL_MODE_NOMBRES[vmi]),
                        param = vmParam
                    }
                end
            end
        end

        local numVocalModesActivos = #vocalModesActivos
        local sumTargetPos = 0.0
        for vmi = 1, numVocalModesActivos do
            local valTarget = configPreset.vocalModeTarget[vocalModesActivos[vmi].nombreMin] or 0.0
            if valTarget > 0.0 then sumTargetPos = sumTargetPos + valTarget end
        end
        local factorNormVM = (sumTargetPos > 1.0) and (1.0 / sumTargetPos) or 1.0

        local fonemasComputados = nil
        if SV.getPhonemesForGroup then
            pcall(function() fonemasComputados = SV:getPhonemesForGroup(groupRef) end)
        end

        for i = 1, totalNotas do
            local nota = notasObjetivo[i]
            local onset = nota:getOnset()
            local duration = nota:getDuration()
            local endBlick = onset + duration

            local secOnset = timeAxis:getSecondsFromBlick(onset)
            local secEnd = timeAxis:getSecondsFromBlick(endBlick)
            local durSec = secEnd - secOnset

            local factorEscalaDur = 1.0
            if durSec < 0.12 then
                local diffDur = (0.12 - durSec) / 0.04
                factorEscalaDur = math.exp(-(diffDur * diffDur))
            end

            local bpmLocal = 120.0
            if adaptarTempo then bpmLocal = obtenerTempoEnBlick(timeAxis, onset) end
            local fTempo = adaptarTempo and factorTempo(bpmLocal) or 1.0

            local notaPrev = (i > 1) and notasObjetivo[i - 1] or nil
            local notaNext = (i < totalNotas) and notasObjetivo[i + 1] or nil

            local esInicioFrase = true
            local esFinFrase = true
            local saltoSemitonos = 0
            local umbralBrecha = math.floor(SV.QUARTER / 8)

            if notaPrev then
                if (onset - notaPrev:getEnd()) <= umbralBrecha then
                    esInicioFrase = false
                    saltoSemitonos = nota:getPitch() - notaPrev:getPitch()
                end
            end

            if notaNext then
                if (notaNext:getOnset() - endBlick) <= umbralBrecha then
                    esFinFrase = false
                end
            end

            local esConsonanteAtaque = false
            local vowelOnsetBlick = nil

            if fonemasComputados and #fonemasComputados > 0 then
                for fIdx = 1, #fonemasComputados do
                    local fInfo = fonemasComputados[fIdx]
                    if fInfo and fInfo.blickPosition then
                        if fInfo.blickPosition >= onset and fInfo.blickPosition < endBlick then
                            local phName = string.lower(fInfo.phoneme or "")
                            if string.match(phName, "^[ptksfhkc]") or string.match(phName, "sh") or string.match(phName, "ch") then
                                esConsonanteAtaque = true
                            end
                            if not vowelOnsetBlick and (string.match(phName, "^[aeiou]") or string.match(phName, "^[áéíóú]") or string.match(phName, "ax") or string.match(phName, "aa") or string.match(phName, "ae") or string.match(phName, "ih") or string.match(phName, "eh") or string.match(phName, "iy") or string.match(phName, "ow") or string.match(phName, "uw")) then
                                vowelOnsetBlick = fInfo.blickPosition
                            end
                        end
                    end
                end
            end

            if limpiarPrevios and not mergeMode then
                if tensionParam then tensionParam:remove(onset, endBlick) end
                if breathParam then breathParam:remove(onset, endBlick) end
                if genderParam then genderParam:remove(onset, endBlick) end
                if loudnessParam then loudnessParam:remove(onset, endBlick) end
                if pitchDeltaParam then pitchDeltaParam:remove(onset, endBlick) end
                if vibratoParam then vibratoParam:remove(onset, endBlick) end
                if voicingParam then voicingParam:remove(onset, endBlick) end
                if toneShiftParam then toneShiftParam:remove(onset, endBlick) end

                for vmi = 1, numVocalModesActivos do
                    vocalModesActivos[vmi].param:remove(onset, endBlick)
                end
            end

            if activarDetune and configPreset.scoopCents ~= 0.0 then
                local detuneCents = 0
                if math.abs(saltoSemitonos) >= 2 then
                    detuneCents = math.floor(limitarValor(saltoSemitonos * -3.0 * factorIntensidad * factorEscalaDur, -100.0, 100.0))
                elseif esInicioFrase then
                    detuneCents = math.floor(limitarValor(configPreset.scoopCents * factorIntensidad * fTempo * factorEscalaDur, -100.0, 100.0))
                end
                if detuneCents ~= 0 then nota:setDetune(detuneCents) end
            end

            if activarExpPad then
                local attr = nota:getAttributes()
                if attr then
                    attr.expValueX = limitarValor((configPreset.expPadX or 0.0) * factorIntensidad, -1.0, 1.0)
                    attr.expValueY = limitarValor((configPreset.expPadY or 0.0) * factorIntensidad, -1.0, 1.0)
                    nota:setAttributes(attr)
                end
            end

            local pitchMidi = nota:getPitch()

            aplicarEnvolventeHermite(tensionParam, configPreset.tension, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, esInicioFrase, esFinFrase, false, false, false, fonemasComputados, false, vowelOnsetBlick, true, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
            aplicarEnvolventeHermite(breathParam, configPreset.aliento, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, esInicioFrase, esFinFrase, true, false, esConsonanteAtaque, fonemasComputados, false, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)

            if loudnessParam then
                BUFFER_LOUDNESS[1] = configPreset.volumen[1] + offsetLoudnessDb
                BUFFER_LOUDNESS[2] = configPreset.volumen[2] + offsetLoudnessDb
                BUFFER_LOUDNESS[3] = configPreset.volumen[3] + offsetLoudnessDb
                BUFFER_LOUDNESS[4] = configPreset.volumen[4] + offsetLoudnessDb
                BUFFER_LOUDNESS[5] = configPreset.volumen[5] + offsetLoudnessDb
                aplicarEnvolventeHermite(loudnessParam, BUFFER_LOUDNESS, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, esInicioFrase, esFinFrase, false, true, false, fonemasComputados, false, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
            end

            aplicarEnvolventeHermite(genderParam, configPreset.genero, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, esInicioFrase, esFinFrase, false, false, false, fonemasComputados, false, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
            aplicarEnvolventeHermite(voicingParam, configPreset.voicing, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, esInicioFrase, esFinFrase, false, false, false, fonemasComputados, false, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
            aplicarEnvolventeHermite(toneShiftParam, configPreset.timbre, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, esInicioFrase, esFinFrase, false, false, false, fonemasComputados, false, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)

            if numVocalModesActivos > 0 then
                for vmi = 1, numVocalModesActivos do
                    local infoModo = vocalModesActivos[vmi]
                    local valTargetRaw = configPreset.vocalModeTarget[infoModo.nombreMin] or 0.0
                    if valTargetRaw ~= 0.0 then
                        local valTarget = (valTargetRaw > 0.0) and (valTargetRaw * factorNormVM) or math.max(-1.0, valTargetRaw)
                        BUFFER_VM_NODOS[1] = valTarget
                        BUFFER_VM_NODOS[2] = valTarget
                        BUFFER_VM_NODOS[3] = valTarget
                        BUFFER_VM_NODOS[4] = valTarget
                        BUFFER_VM_NODOS[5] = valTarget * 0.8
                        aplicarEnvolventeHermite(infoModo.param, BUFFER_VM_NODOS, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, false, false, false, false, false, fonemasComputados, false, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
                        totalVocalModesAplicados = totalVocalModesAplicados + 1
                    end
                end
            end

            if pitchDeltaParam then
                if not esInicioFrase and math.abs(saltoSemitonos) >= 2 then
                    aplicarPortamentoSCurve(pitchDeltaParam, onset, duration, saltoSemitonos, factorIntensidad, mergeMode)
                elseif configPreset.scoopCents ~= 0.0 and esInicioFrase then
                    local startScoop = (vowelOnsetBlick and vowelOnsetBlick > onset) and vowelOnsetBlick or onset
                    local valScoop = limitarValor(configPreset.scoopCents * factorIntensidad * fTempo * factorEscalaDur, -1200.0, 1200.0)
                    local t1 = startScoop + math.floor(duration * 0.15)
                    if not mergeMode then
                        pitchDeltaParam:add(startScoop, valScoop)
                        pitchDeltaParam:add(t1, 0.0)
                    else
                        local existOnset = pitchDeltaParam:get(startScoop) or 0.0
                        pitchDeltaParam:add(startScoop, (existOnset + valScoop) * 0.5)
                        pitchDeltaParam:add(t1, 0.0)
                    end
                    if pitchDeltaParam.simplify then
                        pitchDeltaParam:simplify(startScoop, t1, obtenerToleranciaSimplificacion(pitchDeltaParam))
                    end
                end
            end

            if activarSmartVibrato and vibratoParam and durSec >= 0.30 then
                aplicarEnvolventeHermite(vibratoParam, configPreset.vibrato, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, false, false, false, false, false, fonemasComputados, true, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
            end

            totalNotasProcesadas = totalNotasProcesadas + 1
        end

        ::continuar_grupo::
    end

    local resumen = string.format(tr.completedMsg, (totalNotasProcesadas or 0), (nomPreset or ""), (valIntensidad or 0), (numGruposAProcesar or 0))
    statusText = resumen
    SV:refreshSidePanel()
end
