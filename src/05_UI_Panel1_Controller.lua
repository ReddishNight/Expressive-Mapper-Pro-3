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


local valIdiomaUI, valPreset, valIntensidad, valLetra, valBasePitch, valSoloFonemas
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

local function asegurarWidgetsPanel1(cfg)
    local idiomaInicial = _G.idiomaDetectado or 0
    if cfg.idiomaUI ~= nil then
        idiomaInicial = tonumber(cfg.idiomaUI) or 0
    end

    if not panelWidgets then
        panelWidgets = {
            idiomaUI = SV:create("WidgetValue"),
            preset = SV:create("WidgetValue"),
            intensidad = SV:create("WidgetValue"),
            letra = SV:create("WidgetValue"),
            separatorMode = SV:create("WidgetValue"),
            separatorCustom = SV:create("WidgetValue"),
            basePitch = SV:create("WidgetValue"),
            soloFonemas = SV:create("WidgetValue"),
            modoMelodia = SV:create("WidgetValue"),
            modoRitmo = SV:create("WidgetValue"),
            escalaMelodica = SV:create("WidgetValue"),
            targetNotesMode = SV:create("WidgetValue"),
            runButton = SV:create("WidgetValue")
        }
        panelWidgets.runButton:setValueChangeCallback(function()
            ejecutarOperacionPrincipal()
        end)
    end

    panelWidgets.idiomaUI:setValue(tonumber(cfg.idiomaUI) or idiomaInicial)
    panelWidgets.preset:setValue(cfg.preset ~= nil and tonumber(cfg.preset) or 0)
    panelWidgets.intensidad:setValue(cfg.intensidad ~= nil and tonumber(cfg.intensidad) or 100)
    panelWidgets.letra:setValue(cfg.letra ~= nil and tostring(cfg.letra) or "")
    panelWidgets.separatorMode:setValue(cfg.separatorMode ~= nil and tostring(cfg.separatorMode) or "auto")
    panelWidgets.separatorCustom:setValue(cfg.separatorCustom ~= nil and tostring(cfg.separatorCustom) or "")
    panelWidgets.basePitch:setValue(cfg.basePitch ~= nil and tonumber(cfg.basePitch) or 60)
    panelWidgets.soloFonemas:setValue(cfg.soloFonemas == true)
    panelWidgets.modoMelodia:setValue(cfg.modoMelodia ~= nil and tonumber(cfg.modoMelodia) or 0)
    panelWidgets.modoRitmo:setValue(cfg.modoRitmo ~= nil and tonumber(cfg.modoRitmo) or 0)
    panelWidgets.escalaMelodica:setValue(cfg.escalaMelodica ~= nil and tonumber(cfg.escalaMelodica) or 2)
    panelWidgets.targetNotesMode:setValue(cfg.targetNotesMode ~= nil and tonumber(cfg.targetNotesMode) or 0)

    return panelWidgets
end

function getSidePanelSectionState()
    local cfg = cargarConfiguracionUsuario()
    local idiomaInicial = _G.idiomaDetectado or 0

    local widgets = asegurarWidgetsPanel1(cfg)

    valIdiomaUI = idiomaInicial
    valPreset = tonumber(leerValorWidget(widgets.preset, cfg.preset ~= nil and tonumber(cfg.preset) or 0)) or 0
    valIntensidad = tonumber(leerValorWidget(widgets.intensidad, cfg.intensidad ~= nil and tonumber(cfg.intensidad) or 100)) or 100
    valLetra = tostring(leerValorWidget(widgets.letra, cfg.letra ~= nil and tostring(cfg.letra) or "")) or ""
    valBasePitch = tonumber(leerValorWidget(widgets.basePitch, cfg.basePitch ~= nil and tonumber(cfg.basePitch) or 60)) or 60
    valSoloFonemas = widgets.soloFonemas
    local valSeparatorMode = tostring(leerValorWidget(widgets.separatorMode, cfg.separatorMode or "auto")) or "auto"
    local valSeparatorCustom = tostring(leerValorWidget(widgets.separatorCustom, cfg.separatorCustom or "")) or ""

    local tr = I18N_DATA[valIdiomaUI] or I18N_DATA[0]
    local rows = {
        { type = "Label", text = tr.vistaSeccionChoices[1] or "EasyLyric: Letra & Melodía" },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.targetNotesModeLabel or "Destino de la Generación" },
                { type = "ComboBox", choices = tr.targetNotesModeChoices or { "Añadir en Playhead (Nuevas notas)", "Reemplazar todo en Playhead (Pruebas)", "Reemplazar en notas seleccionadas" }, value = widgets.targetNotesMode }
            }
        },

        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.letraLabel or "Letra a Generar" },
                { type = "TextArea", value = widgets.letra, width = 1.0 }
            }
        },
        {
            type = "Label",
            text = tr.ayudaGuiaSyllable or "  (-) Separar sílabas"
        },
        {
            type = "Label",
            text = tr.ayudaGuiaPhoneme or "  (/) Fonemas directos"
        },
        {
            type = "Label",
            text = tr.ayudaGuiaSlur or "  (_) Nota ligada / Slur"
        },
        {
            type = "Label",
            text = tr.ayudaGuiaInflection or "  (\\) Inflexión de tono al final"
        },
        {
            type = "Label",
            text = tr.ayudaGuiaTimeMark or "  (%) Marcas de tiempo (%10.5s)"
        },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.modoMelodiaLabel or "Contorno Melódico" },
                { type = "ComboBox", choices = tr.modoMelodiaChoices, value = widgets.modoMelodia }
            }
        },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.modoRitmoLabel or "Patrón Rítmico" },
                { type = "ComboBox", choices = tr.modoRitmoChoices, value = widgets.modoRitmo }
            }
        },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.escalaLabel or "Escala Armónica" },
                { type = "ComboBox", choices = tr.escalaChoices, value = widgets.escalaMelodica }
            }
        },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.intensidadLabel or "Intensidad (%)" },
                { type = "Slider", text = tr.intensidadLabel or "Intensidad (%)", minValue = 0, maxValue = 200, interval = 5, value = widgets.intensidad }
            }
        },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.basePitchLabel or "MIDI Base (Quick Mode)" },
                { type = "Slider", text = tr.basePitchLabel or "MIDI Base (Quick Mode)", minValue = 36, maxValue = 84, interval = 1, value = widgets.basePitch }
            }
        },
        {
            type = "Container",
            columns = {
                { type = "Label", text = tr.soloFonemasLabel or "Chops (Fonemas Puros)" },
                { type = "CheckBox", text = tr.soloFonemasLabel or "Chops (Fonemas Puros)", value = widgets.soloFonemas }
            }
        },
        {
            type = "Container",
            columns = {
                {
                    type = "Button",
                    text = tr.applyButtonLabel or "Aplicar",
                    value = widgets.runButton,
                    width = 1.0
                }
            }
        }
    }

    return {
        title = "Lyric & Melody",
        rows = rows
    }
end

-- Parsear letra con marcas de tiempo estilo %10 (segundos)
local function obtenerFinUltimaNotaEnPista(pista)
    if not pista then return 0 end
    local maxEndBlick = 0
    local numRefs = pista:getNumGroups()
    for ri = 1, numRefs do
        local r = pista:getGroupReference(ri)
        if r and r:getTarget() then
            local g = r:getTarget()
            local offset = r:getTimeOffset() or 0
            local numNotes = g:getNumNotes()
            for ni = 1, numNotes do
                local n = g:getNote(ni)
                if n then
                    local endPos = offset + n:getOnset() + n:getDuration()
                    if endPos > maxEndBlick then
                        maxEndBlick = endPos
                    end
                end
            end
        end
    end
    return maxEndBlick
end

local function parsearTextoConMarcasTiempo(texto, playheadBlicks, timeAxis)
    local segmentos = {}
    local pattern = "%%(%d+%.?%d*)"
    
    local starts = {}
    local values = {}
    local matches = 0
    
    local s, e, val = string.find(texto, pattern, 1)
    while s do
        matches = matches + 1
        starts[matches] = s
        values[matches] = tonumber(val)
        s, e, val = string.find(texto, pattern, e + 1)
    end
    
    if matches == 0 then
        table.insert(segmentos, { blick = playheadBlicks, texto = texto })
        return segmentos
    end
    
    if starts[1] > 1 then
        local textoPrevio = string.sub(texto, 1, starts[1] - 1)
        textoPrevio = textoPrevio:gsub("^%s*(.-)%s*$", "%1")
        if #textoPrevio > 0 then
            table.insert(segmentos, { blick = playheadBlicks, texto = textoPrevio })
        end
    end
    
    for i = 1, matches do
        local startPos = starts[i]
        local segs = values[i]
        local blickPos = math.floor(timeAxis:getBlickFromSeconds(segs))
        
        local endPos = (i < matches) and (starts[i + 1] - 1) or #texto
        local _, endMarkPos = string.find(texto, "%%" .. tostring(segs), startPos)
        if not endMarkPos then
            _, endMarkPos = string.find(texto, "%%" .. string.format("%.1f", segs), startPos)
        end
        endMarkPos = endMarkPos or startPos
        
        local textoSegmento = string.sub(texto, endMarkPos + 1, endPos)
        textoSegmento = textoSegmento:gsub("^%s*(.-)%s*$", "%1")
        
        table.insert(segmentos, { blick = blickPos, texto = textoSegmento })
    end
    
    return segmentos
end

function ejecutarOperacionPrincipal()
    local cfg = cargarConfiguracionUsuario()
    cfg.modo = 0 -- MODO 0: Generar notas desde texto

    if panelWidgets then
        cfg.idiomaUI = tonumber(panelWidgets.idiomaUI:getValue() or cfg.idiomaUI) or cfg.idiomaUI
        cfg.preset = tonumber(panelWidgets.preset:getValue() or cfg.preset) or cfg.preset
        cfg.intensidad = tonumber(panelWidgets.intensidad:getValue() or cfg.intensidad) or cfg.intensidad
        cfg.letra = tostring(panelWidgets.letra:getValue() or cfg.letra)
        cfg.basePitch = tonumber(panelWidgets.basePitch:getValue() or cfg.basePitch) or cfg.basePitch
        cfg.soloFonemas = panelWidgets.soloFonemas:getValue() == true
        cfg.modoMelodia = tonumber(panelWidgets.modoMelodia:getValue() or cfg.modoMelodia) or cfg.modoMelodia
        cfg.modoRitmo = tonumber(panelWidgets.modoRitmo:getValue() or cfg.modoRitmo) or cfg.modoRitmo
        cfg.escalaMelodica = tonumber(panelWidgets.escalaMelodica:getValue() or cfg.escalaMelodica) or cfg.escalaMelodica
        cfg.separatorMode = tostring(panelWidgets.separatorMode:getValue() or cfg.separatorMode) or cfg.separatorMode
        cfg.separatorCustom = tostring(panelWidgets.separatorCustom:getValue() or cfg.separatorCustom) or cfg.separatorCustom
    end

    guardarConfiguracionUsuario(cfg)

    -- Mapear variables para compatibilidad con el backend
    local modoOperacion       = cfg.modo
    local presetIndex         = cfg.preset
    local valIntensidadVal    = cfg.intensidad
    local factorIntensidad    = valIntensidadVal / 100.0
    local densityChoice       = 0
    local modoRitmoIdx        = cfg.modoRitmo or 0
    local modoMelodiaIdx      = cfg.modoMelodia or 0
    local escalaIdx           = cfg.escalaMelodica or 2
    local tonicaIdx           = 0
    local autoDetectKey       = false
    local modoArmoniaIdx      = 0
    local presetCoralIdx      = 0
    local antiFaseMs          = 12
    local antiFaseCents       = 10
    local especieContrapuntoIdx = 0
    local progresionAcordesIdx  = 0
    local ritmoAcordesIdx       = 0
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
    local letraRaw            = cfg.letra
    local basePitch           = cfg.basePitch
    local durationIndex       = 1
    local targetNotesMode     = 0
    local armoniaIntervalosCustom = "+3, +7, -5"
    local rangoNotaMin        = 48
    local rangoNotaMax        = 72
    local enableJustIntonation = true
    local vistaSeccion        = 0
local langIdx                   = cfg.idiomaUI or 0
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
    if widgets and widgets.targetNotesMode then targetNotesMode = tonumber(widgets.targetNotesMode:getValue()) or targetNotesMode end
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
        SV:showMessageBox(tr.errContextTitle, tr.errContextMsg)
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
    local nomPreset = tr.presetChoices[presetIndex + 1] or tr.presetChoices[1]
    local confirmMsg = ""

    if modoOperacion == 0 then
        local valSeparatorMode = cfg.separatorMode or "auto"
        local valSeparatorCustom = cfg.separatorCustom or ""
        local silabasPreview = extraerSilabas(letraRaw, langIdx, valSeparatorMode, valSeparatorCustom)
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
        return
    end

    local confirmResult = SV:showOkCancelBox(tr.confirmTitle, confirmMsg)
    if not confirmResult then
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
            
            return
        end

        local totalArmonias = generarPistasArmonia(proyecto, pistaActual, groupRefActivo, tonicaIdx, escalaIdx, modoArmoniaIdx, presetCoralIdx, antiFaseMs, antiFaseCents, factorIntensidad, configPreset, timeAxis, armoniaIntervalosCustom, enableJustIntonation)
        local resumenArm = string.format(tr.completedMsg, (totalArmonias or 0), (nomPreset or ""), (valIntensidad or 0), 1)
        SV:showMessageBox(tr.completedTitle, resumenArm)
        return

    elseif modoOperacion == 3 then
        if not groupRefActivo then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            
            return
        end

        local totalContra = generarPistaContrapunto(proyecto, pistaActual, groupRefActivo, especieContrapuntoIdx, tonicaIdx, escalaIdx, factorIntensidad, configPreset, timeAxis)
        local resumenContra = string.format(tr.completedMsg, (totalContra or 0), (nomPreset or ""), (valIntensidad or 0), 1)
        SV:showMessageBox(tr.completedTitle, resumenContra)
        return

    elseif modoOperacion == 4 then
        local totalAcordes = generarProgresionAcordes(proyecto, pistaActual, progresionAcordesIdx, tonicaIdx, escalaIdx, ritmoAcordesIdx, factorIntensidad, configPreset, timeAxis)
        local resumenProg = string.format(tr.completedMsg, (totalAcordes or 0), (nomPreset or ""), (valIntensidad or 0), 1)
        SV:showMessageBox(tr.completedTitle, resumenProg)
        return

    elseif modoOperacion == 5 then
        if not groupRefActivo then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            
            return
        end

        local grupoGuiaTarget = groupRefActivo:getTarget()
        local numNotasGuia = grupoGuiaTarget:getNumNotes()
        if numNotasGuia == 0 then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            
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
        return

    elseif modoOperacion == 6 then
        if not groupRefActivo then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            
            return
        end

        local targetGroup = groupRefActivo:getTarget()
        local numNotas = targetGroup:getNumNotes()
        if numNotas == 0 then
            SV:showMessageBox(tr.errNoNotesTitle, tr.errNoNotesMsg)
            
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

            if targetNotesMode == 2 then
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
                if targetNotesMode == 1 then
                    -- Reemplazar todo en Playhead (Pruebas): eliminar grupos anteriores de EasyLyric
                    local numRefs = pistaActual:getNumGroups()
                    for ri = numRefs, 1, -1 do
                        local r = pistaActual:getGroupReference(ri)
                        if r and r:getTarget() and string.find(r:getTarget():getName(), "EasyLyric") then
                            pistaActual:removeGroupReference(ri)
                        end
                    end
                end

                -- Calcular la posición de inicio para evitar solapamientos con notas previas
                local maxEndBlick = obtenerFinUltimaNotaEnPista(pistaActual)
                local playheadBlick = reproductor:getPlayhead()
                local startBlick = (targetNotesMode == 0) and math.max(playheadBlick, maxEndBlick) or playheadBlick

                -- SIEMPRE crear un nuevo NoteGroup dedicado para cada frase para no contaminar el grupo principal de la pista (timeOffset 0)
                local nuevoGrupo = SV:create("NoteGroup")
                if targetNotesMode == 0 then
                    local secTotal = math.floor(timeAxis:getSecondsFromBlick(startBlick) + 0.5)
                    local minPart = math.floor(secTotal / 60)
                    local secPart = secTotal % 60
                    nuevoGrupo:setName(string.format("EasyLyric (%02d:%02d)", minPart, secPart))
                else
                    nuevoGrupo:setName("EasyLyric Group")
                end

                -- Parsear las marcas de tiempo %segundos de la letra
                local segmentos = parsearTextoConMarcasTiempo(letraRaw, startBlick, timeAxis)
                local totalAgregadas = 0

                for sIdx = 1, #segmentos do
                    local seg = segmentos[sIdx]
                    if #seg.texto > 0 then
                        -- Generar notas y automatizaciones con origen relativo 0 dentro del grupo
                        local relBlick = math.max(0, seg.blick - startBlick)
                        local notasSeg = generarNotasDesdeTexto(
                            seg.texto, basePitch, stepBlick, modoMelodiaIdx, escalaIdx, modoRitmoIdx, langIdx,
                            nuevoGrupo, reproductor, rangoNotaMin, rangoNotaMax, timeAxis,
                            valSeparatorMode, valSeparatorCustom, valSoloFonemas:getValue(), relBlick
                        )
                        for nIdx = 1, #notasSeg do
                            table.insert(notasObjetivo, notasSeg[nIdx])
                            totalAgregadas = totalAgregadas + 1
                        end
                    end
                end

                if totalAgregadas == 0 then
                    SV:showMessageBox(tr.errNoSyllablesTitle, tr.errNoSyllablesMsg)
                    return
                end

                -- Calcular la duración total y el primer onset interno de las notas del grupo
                local minNoteOnset = 999999999
                local maxNoteEnd = 0
                local nNotesInGroup = nuevoGrupo:getNumNotes()
                for ni = 1, nNotesInGroup do
                    local n = nuevoGrupo:getNote(ni)
                    if n then
                        local onset = n:getOnset()
                        local nEnd = onset + n:getDuration()
                        if onset < minNoteOnset then minNoteOnset = onset end
                        if nEnd > maxNoteEnd then maxNoteEnd = nEnd end
                    end
                end

                if minNoteOnset > maxNoteEnd then
                    minNoteOnset = 0
                    maxNoteEnd = math.floor(SV.QUARTER * 4)
                end

                -- Normalizar el inicio interno de las notas a 0 dentro de nuevoGrupo
                if minNoteOnset > 0 then
                    for ni = 1, nNotesInGroup do
                        local n = nuevoGrupo:getNote(ni)
                        if n then
                            n:setOnset(n:getOnset() - minNoteOnset)
                        end
                    end
                end

                local groupDur = maxNoteEnd - minNoteOnset
                local finalGroupOffset = startBlick + minNoteOnset

                -- Registrar el NoteGroup y crear el NoteGroupReference ajustando timeOffset y setTimeRange según la documentación de Synthesizer V
                proyecto:addNoteGroup(nuevoGrupo, -1)
                local ref = SV:create("NoteGroupReference")
                ref:setTarget(nuevoGrupo)
                ref:setTimeOffset(finalGroupOffset)
                ref:setTimeRange(finalGroupOffset, groupDur)
                pistaActual:addGroupReference(ref)
                editorPrincipal:setCurrentGroup(ref)

                -- Reasignar el objetivo de automatizaciones expresivas al grupo activo
                noteGroup = nuevoGrupo
                groupRef = ref
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

            -- En el Panel 1 (EasyLyric & Melodía), mantenemos la curva de Pitch Delta limpia
            -- para permitir que el motor IA de Synthesizer V renderice las notas sin desbordamientos ni gallos afónicos.
            if pitchDeltaParam and limpiarPrevios and not mergeMode then
                pitchDeltaParam:remove(onset, endBlick)
            end

            if activarSmartVibrato and vibratoParam and durSec >= 0.30 then
                aplicarEnvolventeHermite(vibratoParam, configPreset.vibrato, factorIntensidad, onset, duration, endBlick, blickStepDensity, mergeMode, false, false, false, false, false, fonemasComputados, true, vowelOnsetBlick, false, pitchMidi, basePitch, configPreset, factorHumanizeMult, factorRegisterMult, factorPhonemeMult, i)
            end

            totalNotasProcesadas = totalNotasProcesadas + 1
        end

        ::continuar_grupo::
    end

    local resumen = string.format(tr.completedMsg, (totalNotasProcesadas or 0), (nomPreset or ""), (valIntensidad or 0), (numGruposAProcesar or 0))
    SV:showMessageBox(tr.completedTitle, resumen)
    end
