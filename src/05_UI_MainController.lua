-- ============================================================================
-- MÓDULO 5: CONTROLADOR PRINCIPAL Y INTERFAZ DE USUARIO (0 GC ALLOC)
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
            t[k] = string.sub(v, 2, -2)
        else
            local num = tonumber(v)
            if num ~= nil then t[k] = num else t[k] = v end
        end
    end
    return t
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
    return config
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
        title = tr.presetChoices[PRESET_PERSONALIZADO_IDX + 1] or "Custom",
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

function main()
    local cfg = cargarConfiguracionUsuario()

    local idiomaInicial = 0
    if cfg.idiomaUI ~= nil then
        idiomaInicial = tonumber(cfg.idiomaUI) or 0
    elseif SV and SV.getHostLanguage then
        pcall(function()
            local hostLang = string.lower(SV:getHostLanguage() or "")
            if string.find(hostLang, "en") then
                idiomaInicial = 1
            elseif string.find(hostLang, "ja") or string.find(hostLang, "jp") then
                idiomaInicial = 2
            elseif string.find(hostLang, "es") then
                idiomaInicial = 0
            end
        end)
    end

    local idiomaActual = idiomaInicial
    local textoEjemploModificado = (cfg.letra ~= nil and cfg.letra ~= "")

    local dialogo = {
        title = "",
        message = "",
        buttons = "OkCancel",
        widgets = {
            {
                name = "vistaSeccion",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.vistaSeccion ~= nil and tonumber(cfg.vistaSeccion) or 0
            },
            {
                name = "idiomaUI",
                type = "ComboBox",
                label = "",
                choices = { "Español", "English", "日本語" },
                default = cfg.idiomaUI ~= nil and tonumber(cfg.idiomaUI) or idiomaActual
            },
            {
                name = "modo",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.modo ~= nil and tonumber(cfg.modo) or 0
            },
            {
                name = "preset",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.preset ~= nil and tonumber(cfg.preset) or 0
            },
            {
                name = "intensidad",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.intensidad ~= nil and tonumber(cfg.intensidad) or 100
            },
            {
                name = "densityStep",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.densityStep ~= nil and tonumber(cfg.densityStep) or 0
            },
            {
                name = "modoRitmo",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.modoRitmo ~= nil and tonumber(cfg.modoRitmo) or 2
            },
            {
                name = "modoMelodia",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.modoMelodia ~= nil and tonumber(cfg.modoMelodia) or 0
            },
            {
                name = "escalaMelodica",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.escalaMelodica ~= nil and tonumber(cfg.escalaMelodica) or 2
            },
            {
                name = "tonica",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.tonica ~= nil and tonumber(cfg.tonica) or 0
            },
            {
                name = "autoDetectKey",
                type = "CheckBox",
                label = "",
                default = (cfg.autoDetectKey == nil or cfg.autoDetectKey == true)
            },
            {
                name = "modoArmonia",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.modoArmonia ~= nil and tonumber(cfg.modoArmonia) or 0
            },
            {
                name = "presetCoral",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.presetCoral ~= nil and tonumber(cfg.presetCoral) or 0
            },
            {
                name = "antiFaseMs",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 0,
                maxValue = 50,
                interval = 2,
                default = cfg.antiFaseMs ~= nil and tonumber(cfg.antiFaseMs) or 12
            },
            {
                name = "antiFaseCents",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 0,
                maxValue = 50,
                interval = 2,
                default = cfg.antiFaseCents ~= nil and tonumber(cfg.antiFaseCents) or 10
            },
            {
                name = "especieContrapunto",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.especieContrapunto ~= nil and tonumber(cfg.especieContrapunto) or 0
            },
            {
                name = "progresionAcordes",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.progresionAcordes ~= nil and tonumber(cfg.progresionAcordes) or 0
            },
            {
                name = "ritmoAcordes",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.ritmoAcordes ~= nil and tonumber(cfg.ritmoAcordes) or 0
            },
            {
                name = "letra",
                type = "TextArea",
                label = "",
                default = cfg.letra ~= nil and tostring(cfg.letra) or ""
            },
            {
                name = "basePitch",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 36,
                maxValue = 84,
                interval = 1,
                default = cfg.basePitch ~= nil and tonumber(cfg.basePitch) or 60
            },
            {
                name = "noteDuration",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.noteDuration ~= nil and tonumber(cfg.noteDuration) or 0
            },
            {
                name = "enableVocalModes",
                type = "CheckBox",
                label = "",
                default = (cfg.enableVocalModes == nil or cfg.enableVocalModes == true)
            },
            {
                name = "enableDetune",
                type = "CheckBox",
                label = "",
                default = (cfg.enableDetune == nil or cfg.enableDetune == true)
            },
            {
                name = "enableExpPad",
                type = "CheckBox",
                label = "",
                default = (cfg.enableExpPad == nil or cfg.enableExpPad == true)
            },
            {
                name = "enableSmartVibrato",
                type = "CheckBox",
                label = "",
                default = (cfg.enableSmartVibrato == nil or cfg.enableSmartVibrato == true)
            },
            {
                name = "mergeMode",
                type = "CheckBox",
                label = "",
                default = (cfg.mergeMode == true)
            },
            {
                name = "limpiarPrevios",
                type = "CheckBox",
                label = "",
                default = (cfg.limpiarPrevios == nil or cfg.limpiarPrevios == true)
            },
            {
                name = "adaptarTempo",
                type = "CheckBox",
                label = "",
                default = (cfg.adaptarTempo == nil or cfg.adaptarTempo == true)
            },
            {
                name = "compensarGanancia",
                type = "CheckBox",
                label = "",
                default = (cfg.compensarGanancia == true)
            },
            {
                name = "procesarTodosGrupos",
                type = "CheckBox",
                label = "",
                default = (cfg.procesarTodosGrupos == true)
            },
            {
                name = "valHumanizacion",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.valHumanizacion ~= nil and tonumber(cfg.valHumanizacion) or 100
            },
            {
                name = "valRegistro",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.valRegistro ~= nil and tonumber(cfg.valRegistro) or 100
            },
            {
                name = "valFonema",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.valFonema ~= nil and tonumber(cfg.valFonema) or 100
            },
            {
                name = "targetNotesMode",
                type = "ComboBox",
                label = "",
                choices = {},
                default = cfg.targetNotesMode ~= nil and tonumber(cfg.targetNotesMode) or 0
            },
            {
                name = "armoniaIntervalosCustom",
                type = "TextBox",
                label = "",
                default = cfg.armoniaIntervalosCustom ~= nil and tostring(cfg.armoniaIntervalosCustom) or "+3, +7, -5"
            },
            {
                name = "rangoNotaMin",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 36,
                maxValue = 84,
                interval = 1,
                default = cfg.rangoNotaMin ~= nil and tonumber(cfg.rangoNotaMin) or 48
            },
            {
                name = "rangoNotaMax",
                type = "Slider",
                label = "",
                format = "%.0f",
                minValue = 36,
                maxValue = 84,
                interval = 1,
                default = cfg.rangoNotaMax ~= nil and tonumber(cfg.rangoNotaMax) or 72
            },
            {
                name = "enableJustIntonation",
                type = "CheckBox",
                label = "",
                default = (cfg.enableJustIntonation == true) -- Por defecto FALSE (Equal Temperament Pop)
            }
        }
    }

    local resp = {}

    while true do
        local tr = I18N_DATA[idiomaActual] or I18N_DATA[0]

        -- Definir la lista base de widgets completa
        local widgetsCompletos = {
            {
                name = "vistaSeccion",
                type = "ComboBox",
                label = tr.vistaSeccionLabel,
                choices = tr.vistaSeccionChoices,
                default = cfg.vistaSeccion or 0
            },
            {
                name = "idiomaUI",
                type = "ComboBox",
                label = tr.idiomaLabel,
                choices = { "Español", "English", "日本語" },
                default = idiomaActual
            },
            {
                name = "modo",
                type = "ComboBox",
                label = tr.modoLabel,
                choices = tr.modoChoices,
                default = cfg.modo or 0
            },
            {
                name = "preset",
                type = "ComboBox",
                label = tr.presetLabel,
                choices = tr.presetChoices,
                default = cfg.preset or 0
            },
            {
                name = "intensidad",
                type = "Slider",
                label = tr.intensidadLabel,
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.intensidad or 100
            },
            {
                name = "densityStep",
                type = "ComboBox",
                label = tr.densityLabel,
                choices = tr.densityChoices,
                default = cfg.densityStep or 0
            },
            {
                name = "modoRitmo",
                type = "ComboBox",
                label = tr.modoRitmoLabel,
                choices = tr.modoRitmoChoices,
                default = cfg.modoRitmo or 2
            },
            {
                name = "modoMelodia",
                type = "ComboBox",
                label = tr.modoMelodiaLabel,
                choices = tr.modoMelodiaChoices,
                default = cfg.modoMelodia or 0
            },
            {
                name = "escalaMelodica",
                type = "ComboBox",
                label = tr.escalaLabel,
                choices = tr.escalaChoices,
                default = cfg.escalaMelodica or 2
            },
            {
                name = "tonica",
                type = "ComboBox",
                label = tr.tonicaLabel,
                choices = tr.tonicaChoices,
                default = cfg.tonica or 0
            },
            {
                name = "autoDetectKey",
                type = "CheckBox",
                label = tr.autoDetectKeyLabel,
                text = tr.autoDetectKeyLabel,
                default = (cfg.autoDetectKey == nil or cfg.autoDetectKey == true)
            },
            {
                name = "modoArmonia",
                type = "ComboBox",
                label = tr.modoArmoniaLabel,
                choices = tr.modoArmoniaChoices,
                default = cfg.modoArmonia or 0
            },
            {
                name = "presetCoral",
                type = "ComboBox",
                label = tr.presetCoralLabel,
                choices = tr.presetCoralChoices,
                default = cfg.presetCoral or 0
            },
            {
                name = "antiFaseMs",
                type = "Slider",
                label = tr.antiFaseMsLabel,
                format = "%.0f",
                minValue = 0,
                maxValue = 50,
                interval = 2,
                default = cfg.antiFaseMs or 12
            },
            {
                name = "antiFaseCents",
                type = "Slider",
                label = tr.antiFaseCentsLabel,
                format = "%.0f",
                minValue = 0,
                maxValue = 50,
                interval = 2,
                default = cfg.antiFaseCents or 10
            },
            {
                name = "especieContrapunto",
                type = "ComboBox",
                label = tr.especieContrapuntoLabel,
                choices = tr.especieContrapuntoChoices,
                default = cfg.especieContrapunto or 0
            },
            {
                name = "progresionAcordes",
                type = "ComboBox",
                label = tr.progresionAcordesLabel,
                choices = tr.progresionAcordesChoices,
                default = cfg.progresionAcordes or 0
            },
            {
                name = "ritmoAcordes",
                type = "ComboBox",
                label = tr.ritmoAcordesLabel,
                choices = tr.ritmoAcordesChoices,
                default = cfg.ritmoAcordes or 0
            },
            {
                name = "letra",
                type = "TextArea",
                label = tr.letraLabel,
                default = textoEjemploModificado and cfg.letra or tr.letraDefault
            },
            {
                name = "basePitch",
                type = "Slider",
                label = tr.basePitchLabel,
                format = "%.0f",
                minValue = 36,
                maxValue = 84,
                interval = 1,
                default = cfg.basePitch or 60
            },
            {
                name = "noteDuration",
                type = "ComboBox",
                label = tr.noteDurLabel,
                choices = tr.durChoices,
                default = cfg.noteDuration or 0
            },
            {
                name = "enableVocalModes",
                type = "CheckBox",
                label = tr.enableVocalModes,
                text = tr.enableVocalModes,
                default = (cfg.enableVocalModes == nil or cfg.enableVocalModes == true)
            },
            {
                name = "enableDetune",
                type = "CheckBox",
                label = tr.enableDetune,
                text = tr.enableDetune,
                default = (cfg.enableDetune == nil or cfg.enableDetune == true)
            },
            {
                name = "enableExpPad",
                type = "CheckBox",
                label = tr.enableExpPad,
                text = tr.enableExpPad,
                default = (cfg.enableExpPad == nil or cfg.enableExpPad == true)
            },
            {
                name = "enableSmartVibrato",
                type = "CheckBox",
                label = tr.enableSmartVibrato,
                text = tr.enableSmartVibrato,
                default = (cfg.enableSmartVibrato == nil or cfg.enableSmartVibrato == true)
            },
            {
                name = "mergeMode",
                type = "CheckBox",
                label = tr.mergeMode,
                text = tr.mergeMode,
                default = (cfg.mergeMode == true)
            },
            {
                name = "limpiarPrevios",
                type = "CheckBox",
                label = tr.limpiarPrevios,
                text = tr.limpiarPrevios,
                default = (cfg.limpiarPrevios == nil or cfg.limpiarPrevios == true)
            },
            {
                name = "adaptarTempo",
                type = "CheckBox",
                label = tr.adaptarTempo,
                text = tr.adaptarTempo,
                default = (cfg.adaptarTempo == nil or cfg.adaptarTempo == true)
            },
            {
                name = "compensarGanancia",
                type = "CheckBox",
                label = tr.compensarGanancia,
                text = tr.compensarGanancia,
                default = (cfg.compensarGanancia == true)
            },
            {
                name = "procesarTodosGrupos",
                type = "CheckBox",
                label = tr.procesarTodosGrupos,
                text = tr.procesarTodosGrupos,
                default = (cfg.procesarTodosGrupos == true)
            },
            {
                name = "valHumanizacion",
                type = "Slider",
                label = tr.humanizeLabel,
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.valHumanizacion or 100
            },
            {
                name = "valRegistro",
                type = "Slider",
                label = tr.registerScaleLabel,
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.valRegistro or 100
            },
            {
                name = "valFonema",
                type = "Slider",
                label = tr.phonemeModLabel,
                format = "%.0f",
                minValue = 0,
                maxValue = 200,
                interval = 5,
                default = cfg.valFonema or 100
            },
            {
                name = "targetNotesMode",
                type = "ComboBox",
                label = tr.targetNotesModeLabel,
                choices = tr.targetNotesModeChoices,
                default = cfg.targetNotesMode or 0
            },
            {
                name = "armoniaIntervalosCustom",
                type = "TextBox",
                label = tr.armoniaIntervalosCustomLabel,
                default = cfg.armoniaIntervalosCustom or "+3, +7, -5"
            },
            {
                name = "rangoNotaMin",
                type = "Slider",
                label = tr.rangoNotaMinLabel,
                format = "%.0f",
                minValue = 36,
                maxValue = 84,
                interval = 1,
                default = cfg.rangoNotaMin or 48
            },
            {
                name = "rangoNotaMax",
                type = "Slider",
                label = tr.rangoNotaMaxLabel,
                format = "%.0f",
                minValue = 36,
                maxValue = 84,
                interval = 1,
                default = cfg.rangoNotaMax or 72
            },
            {
                name = "enableJustIntonation",
                type = "CheckBox",
                label = tr.enableJustIntonation,
                text = tr.enableJustIntonation,
                default = (cfg.enableJustIntonation == true)
            }
        }

        -- Filtrar widgets dinámicamente según la sección UX activa (vistaSeccion)
        local seccionUX = cfg.vistaSeccion or 0
        local widgetsFiltrados = {}
        
        -- Los dos primeros widgets siempre van (UX Filtro de Vista y Selección de Idioma)
        widgetsFiltrados[1] = widgetsCompletos[1]
        widgetsFiltrados[2] = widgetsCompletos[2]
        
        if seccionUX == 0 then
            -- MODO RÁPIDO (EasyLyric: Letras, Notas, Tempo, Modo, Generación Directa)
            table.insert(widgetsFiltrados, widgetsCompletos[3])  -- modo
            table.insert(widgetsFiltrados, widgetsCompletos[19]) -- letra (TextArea)
            table.insert(widgetsFiltrados, widgetsCompletos[20]) -- basePitch
            table.insert(widgetsFiltrados, widgetsCompletos[21]) -- noteDuration
            table.insert(widgetsFiltrados, widgetsCompletos[34]) -- targetNotesMode (Destino)
        elseif seccionUX == 1 then
            -- EXPRESIÓN VOCAL Y CURVAS HERMITE (Presets, Intensidad, Detune, XY Pad)
            table.insert(widgetsFiltrados, widgetsCompletos[3])  -- modo
            table.insert(widgetsFiltrados, widgetsCompletos[4])  -- preset
            table.insert(widgetsFiltrados, widgetsCompletos[5])  -- intensidad
            table.insert(widgetsFiltrados, widgetsCompletos[6])  -- densityStep (Resolución Spline)
            table.insert(widgetsFiltrados, widgetsCompletos[22]) -- enableVocalModes
            table.insert(widgetsFiltrados, widgetsCompletos[23]) -- enableDetune
            table.insert(widgetsFiltrados, widgetsCompletos[24]) -- enableExpPad
            table.insert(widgetsFiltrados, widgetsCompletos[25]) -- enableSmartVibrato
        elseif seccionUX == 2 then
            -- ARMONÍA, COROS Y AFINACIÓN TEMPERADA (Armonías, Coral, Antifase ms/cents, Just Intonation)
            table.insert(widgetsFiltrados, widgetsCompletos[3])  -- modo
            table.insert(widgetsFiltrados, widgetsCompletos[12]) -- modoArmonia (Tipo de Armonía)
            table.insert(widgetsFiltrados, widgetsCompletos[13]) -- presetCoral
            table.insert(widgetsFiltrados, widgetsCompletos[14]) -- antiFaseMs
            table.insert(widgetsFiltrados, widgetsCompletos[15]) -- antiFaseCents
            table.insert(widgetsFiltrados, widgetsCompletos[35]) -- armoniaIntervalosCustom (TextBox)
            table.insert(widgetsFiltrados, widgetsCompletos[38]) -- enableJustIntonation (CheckBox)
        elseif seccionUX == 3 then
            -- CONTRAPUNTO Y PROGRESIÓN DE ACORDES (Fux Species, Progresión de Acordes, Ritmos)
            table.insert(widgetsFiltrados, widgetsCompletos[3])  -- modo
            table.insert(widgetsFiltrados, widgetsCompletos[16]) -- especieContrapunto
            table.insert(widgetsFiltrados, widgetsCompletos[17]) -- progresionAcordes
            table.insert(widgetsFiltrados, widgetsCompletos[18]) -- ritmoAcordes
        elseif seccionUX == 4 then
            -- PARÁMETROS AVANZADOS Y RANGO DE NOTAS (Humanización, Registro, Fonemas, Merge, Rangos Min/Max)
            table.insert(widgetsFiltrados, widgetsCompletos[3])  -- modo
            table.insert(widgetsFiltrados, widgetsCompletos[26]) -- mergeMode
            table.insert(widgetsFiltrados, widgetsCompletos[27]) -- limpiarPrevios
            table.insert(widgetsFiltrados, widgetsCompletos[28]) -- adaptarTempo
            table.insert(widgetsFiltrados, widgetsCompletos[29]) -- compensarGanancia
            table.insert(widgetsFiltrados, widgetsCompletos[30]) -- procesarTodosGrupos
            table.insert(widgetsFiltrados, widgetsCompletos[31]) -- valHumanizacion (Slider)
            table.insert(widgetsFiltrados, widgetsCompletos[32]) -- valRegistro (Slider)
            table.insert(widgetsFiltrados, widgetsCompletos[33]) -- valFonema (Slider)
            table.insert(widgetsFiltrados, widgetsCompletos[36]) -- rangoNotaMin (Slider)
            table.insert(widgetsFiltrados, widgetsCompletos[37]) -- rangoNotaMax (Slider)
        end

        local dialogoDinamico = {
            title = tr.title,
            message = tr.message,
            buttons = "OkCancel",
            widgets = widgetsFiltrados
        }

        local resultado = SV:showCustomDialog(dialogoDinamico)
        if not resultado.status then
            SV:finish()
            return
        end

        resp = resultado.answers or {}
        
        -- Guardar y sincronizar respuestas hacia la configuración de sesión
        for kw, vw in pairs(resp) do
            cfg[kw] = vw
        end
        guardarConfiguracionUsuario(cfg)

        local seleccionadoLang = resp.idiomaUI or idiomaActual
        local seleccionSeccion = resp.vistaSeccion or 0
        local seleccionModo = resp.modo or 0

        if seleccionadoLang ~= idiomaActual or seleccionSeccion ~= (cfg.vistaSeccion or 0) or seleccionModo ~= (cfg.modo or 0) then
            idiomaActual = seleccionadoLang
            cfg.vistaSeccion = seleccionSeccion
            cfg.modo = seleccionModo
        else
            break
        end
    end

    local langIdx                   = resp.idiomaUI or idiomaActual
    local tr                        = I18N_DATA[langIdx] or I18N_DATA[0]

    local modoOperacion       = resp.modo or 0
    local presetIndex         = resp.preset or 0
    local valIntensidad       = resp.intensidad or 100
    local factorIntensidad    = valIntensidad / 100.0
    local densityChoice       = resp.densityStep or 0
    local modoRitmoIdx        = resp.modoRitmo or 0
    local modoMelodiaIdx      = resp.modoMelodia or 0
    local escalaIdx           = resp.escalaMelodica or 2
    local tonicaIdx           = resp.tonica or 0
    local autoDetectKey       = (resp.autoDetectKey ~= false)

    local modoArmoniaIdx      = resp.modoArmonia or 0
    local presetCoralIdx      = resp.presetCoral or 0
    local antiFaseMs          = resp.antiFaseMs or 12
    local antiFaseCents       = resp.antiFaseCents or 10

    local especieContrapuntoIdx = resp.especieContrapunto or 0
    local progresionAcordesIdx  = resp.progresionAcordes or 0
    local ritmoAcordesIdx       = resp.ritmoAcordes or 0

    local activarVocalModes   = (resp.enableVocalModes ~= false)
    local activarDetune       = (resp.enableDetune ~= false)
    local activarExpPad       = (resp.enableExpPad ~= false)
    local activarSmartVibrato = (resp.enableSmartVibrato ~= false)
    local mergeMode           = (resp.mergeMode == true)
    local limpiarPrevios      = (resp.limpiarPrevios ~= false)
    local adaptarTempo        = (resp.adaptarTempo ~= false)
    local compensarGanancia   = (resp.compensarGanancia == true)
    local procesarTodosGrupos = (resp.procesarTodosGrupos == true)
    local factorHumanizeMult  = (resp.valHumanizacion ~= nil and tonumber(resp.valHumanizacion) or 100) / 100.0
    local factorRegisterMult  = (resp.valRegistro ~= nil and tonumber(resp.valRegistro) or 100) / 100.0
    local factorPhonemeMult   = (resp.valFonema ~= nil and tonumber(resp.valFonema) or 100) / 100.0
    local letraRaw            = resp.letra or tr.letraDefault

    local basePitch           = resp.basePitch or 60
    if basePitch < 36 or basePitch > 84 then basePitch = 60 end
    local durationIndex       = resp.noteDuration or 1

    local targetNotesMode     = resp.targetNotesMode or 0
    local armoniaIntervalosCustom = resp.armoniaIntervalosCustom or "+3, +7, -5"
    local rangoNotaMin        = resp.rangoNotaMin or 48
    local rangoNotaMax        = resp.rangoNotaMax or 72
    local enableJustIntonation = (resp.enableJustIntonation == true)
    local vistaSeccion        = resp.vistaSeccion or 0

    local proyecto = SV:getProject()
    local timeAxis = proyecto:getTimeAxis()
    local editorPrincipal = SV:getMainEditor()
    local pistaActual = editorPrincipal:getCurrentTrack()

    if not pistaActual then
        SV:showMessageBox(tr.errContextTitle, tr.errContextMsg)
        SV:finish()
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
            SV:finish()
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
    local nomPreset = tr.presetChoices[presetIndex + 1] or tr.presetChoices[1]
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
        SV:showMessageBox(tr.errContextTitle, tr.idiomaUI == 0 and "Rango de nota minimo debe ser menor que el maximo." or "Minimum note range must be lower than maximum.")
        SV:finish()
        return
    end

    local confirmResult = SV:showOkCancelBox(tr.confirmTitle, confirmMsg)
    if not confirmResult then
        SV:finish()
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
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            SV:finish()
            return
        end

        local totalArmonias = generarPistasArmonia(proyecto, pistaActual, groupRefActivo, tonicaIdx, escalaIdx, modoArmoniaIdx, presetCoralIdx, antiFaseMs, antiFaseCents, factorIntensidad, configPreset, timeAxis, armoniaIntervalosCustom, enableJustIntonation)
        local resumenArm = string.format(tr.completedMsg, totalArmonias, nomPreset, valIntensidad, 1)
        SV:showMessageBox(tr.completedTitle, resumenArm)
        SV:finish()
        return

    elseif modoOperacion == 3 then
        if not groupRefActivo then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            SV:finish()
            return
        end

        local totalContra = generarPistaContrapunto(proyecto, pistaActual, groupRefActivo, especieContrapuntoIdx, tonicaIdx, escalaIdx, factorIntensidad, configPreset, timeAxis)
        local resumenContra = string.format(tr.completedMsg, totalContra, nomPreset, valIntensidad, 1)
        SV:showMessageBox(tr.completedTitle, resumenContra)
        SV:finish()
        return

    elseif modoOperacion == 4 then
        local totalAcordes = generarProgresionAcordes(proyecto, pistaActual, progresionAcordesIdx, tonicaIdx, escalaIdx, ritmoAcordesIdx, factorIntensidad, configPreset, timeAxis)
        local resumenProg = string.format(tr.completedMsg, totalAcordes, nomPreset, valIntensidad, 1)
        SV:showMessageBox(tr.completedTitle, resumenProg)
        SV:finish()
        return

    elseif modoOperacion == 5 then
        if not groupRefActivo then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            SV:finish()
            return
        end

        local grupoGuiaTarget = groupRefActivo:getTarget()
        local numNotasGuia = grupoGuiaTarget:getNumNotes()
        if numNotasGuia == 0 then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            SV:finish()
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

        local resumenSinc = string.format("Operación de sincronización completada.\nGrupos sincronizados con éxito: %d", totalGruposSincronizados)
        SV:showMessageBox(tr.completedTitle, resumenSinc)
        SV:finish()
        return

    elseif modoOperacion == 6 then
        if not groupRefActivo then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            SV:finish()
            return
        end

        local targetGroup = groupRefActivo:getTarget()
        local numNotas = targetGroup:getNumNotes()
        if numNotas == 0 then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            SV:finish()
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

        local resumenForzar = string.format("Operación de forzado de afinación completada.\nNotas corregidas a la escala diatónica: %d", totalNotasCorregidas)
        SV:showMessageBox(tr.completedTitle, resumenForzar)
        SV:finish()
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
        SV:finish()
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
                    SV:finish()
                    return
                end
            else
                -- Crear nuevas notas desde el playhead
                notasObjetivo = generarNotasDesdeTexto(letraRaw, basePitch, stepBlick, modoMelodiaIdx, escalaIdx, modoRitmoIdx, langIdx, noteGroup, reproductor, rangoNotaMin, rangoNotaMax)
                if #notasObjetivo == 0 then
                    SV:showMessageBox(tr.errNoSyllablesTitle, tr.errNoSyllablesMsg)
                    SV:finish()
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

    local resumen = string.format(tr.completedMsg, totalNotasProcesadas, nomPreset, valIntensidad, numGruposAProcesar)
    SV:showMessageBox(tr.completedTitle, resumen)
    SV:finish()
end
