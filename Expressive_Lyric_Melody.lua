--[[
===============================================================================
  Expressive Lyric & Melody - Synthesizer V Studio Pro 2 Panel
  Autor: Nyoru.X
  Versión: v3.6.2 (SidePanelSection)
===============================================================================
--]]

function getClientInfo()
    return {
        name = "Expressive Lyric & Melody",
        author = "Nyoru.X",
        versionNumber = 3,
        minEditorVersion = 131330,
        type = "SidePanelSection"
    }
end

function getScriptTitle()
    return "Expressive Lyric & Melody"
end

function getScriptVersion()
    return 3
end

function getScriptSide()
    return "SVClient"
end

function getMinEditorVersion()
    return 131330
end
--[[
  Expressive Panel 1 (Lyric & Melody) Localization Dictionary
--]]

local I18N_DATA = {
    [0] = { -- Español
        title = "Mapeador Expresivo Pro 3",
        presetLabel = "2. Estilo Vocal / Preset",
        presetChoices = {
            "[Recomendado] Estándar Universal (Balanceado)",
            "[Sesión Previa] Cargar configuración guardada",
            "Personalizado...",
            "Belting Operático Potente",
            "Melancólico / Triste",
            "Whisper / Susurro Íntimo",
            "Synth-Pop / Vocalo Clásico",
            "Rock / Agresivo Grit",
            "Dark Ambient / Terror Psicológico",
            "Jazz / Soul Expresivo",
            "J-Pop Idol High Energy",
            "Coral Estándar (Balanceado)",
            "Artcore Kinetic Orchestral",
            "Breakcore Glitchy Kinetic",
            "Amenbreak Chop Loop",
            "Amencore Hardcore Speed",
            "Gabber / Speedcore Stab",
            "Neurofunk Techstep Bass",
            "Eurobeat Hi-NRG Fast",
            "Future Bass Kawaii Swell",
            "Cyberpunk Midtempo Heavy",
            "Chiptune 8-Bit Retro",
            "Hardstyle Raw Screamer",
            "Uplifting Trance Anthem"
        },
                targetNotesModeLabel = "Destino de la Generación",
        targetNotesModeChoices = { "Añadir en Playhead (Nuevas notas)", "Reemplazar todo en Playhead (Pruebas)", "Reemplazar en notas seleccionadas" },
        intensidadLabel = "3. Intensidad del Efecto (%)",
        letraLabel = "Letra de entrada:",
        letraDefault = "pa pa pa /y aa/ ma ka fi iss firr",
        basePitchLabel = "Nota MIDI Base",
        soloFonemasLabel = "Modo Chops (Staccato & Gate)",
        modoMelodiaLabel = "Contorno Melódico",
        modoMelodiaChoices = {
            "Arco Prosódico Cantado (Orgánico)",
            "Pentatónico R&B/Pop (Hooks)",
            "Onda Armónica Fluida (Sine)",
            "Glitch Kinético (Caótico)",
            "Plano Expresivo (Intonación)",
            "Arpegio Ascendente",
            "Arpegio Descendente",
            "Paso de Escala Aleatorio",
            "Saltos Consonantes"
        },
        modoRitmoLabel = "Patrón Rítmico",
        modoRitmoChoices = {
            "Pop Sincopado (1/4)",
            "Micro-Chop Kinético (1/16)",
            "Legato Swell (1/2)",
            "Driving Hardcore (3illo)",
            "Plano Estándar"
        },
        escalaLabel = "Escala Armónica",
        escalaChoices = {
            "Pentatónica Mayor",
            "Pentatónica Menor",
            "Mayor Natural (Jónica)",
            "Menor Natural (Eólica)",
            "Dórica",
            "Frigia",
            "Lidia",
            "Mixolidia",
            "Menor Armónica",
            "Cromática Total"
        },
        errContextTitle = "Error de Contexto",
        errContextMsg = "Por favor, selecciona una pista activa en el editor antes de ejecutar.",
        errNoNotesTitle = "Error de Estructura",
        errNoNotesMsg = "No se encontraron grupos o notas válidas para procesar.",
        errNoSyllablesTitle = "Aviso",
        errNoSyllablesMsg = "No has ingresado sílabas de texto válidas para la generación.",
        confirmTitle = "Confirmar Operación",
        confirmMsgGenerar = "¿Deseas generar notas a partir de %d sílabas en %s%d usando el preset '%s' al %d%%?",
        completedTitle = "Mapeador Expresivo Pro 3",
        completedMsg = "¡Operación completada exitosamente!\nÍtems procesados/creados: %d\nPreset/Config: %s\nIntensidad: %d%%\nGrupos/Pistas procesados: %d\nDeshacer Atómico registrado (Ctrl+Z para revertir).",
        vistaSeccionChoices = {
            "Modo Rápido (EasyLyric & Melodía)",
            "Expresión Vocal (Curvas Hermite)",
            "Armonías Vocales (Coros SATB)",
            "Acordes & Contrapunto Algorítmico"
        },
        ayudaGuiaSyllable = "  (-) Dividir sílabas",
        ayudaGuiaPhoneme = "  (/) Fonemas directos",
        ayudaGuiaSlur = "  (_) Nota ligada",
        ayudaGuiaInflection = "  (\\) Inflexión de tono",
        ayudaGuiaTimeMark = "  (%) Marcas de tiempo (%10.5s)"
    },
    [1] = { -- English
        title = "Expressive Mapper Pro 3",
        presetLabel = "2. Vocal Style / Preset",
        presetChoices = {
            "[Recommended] Universal Standard (Balanced)",
            "[Previous Session] Load saved configuration",
            "Custom...",
            "Powerful Operatic Belting",
            "Melancholy / Sad",
            "Intimate Whisper",
            "Synth-Pop / Classic Vocalo",
            "Rock / Aggressive Grit",
            "Dark Ambient / Psychological Terror",
            "Expressive Jazz / Soul",
            "High Energy J-Pop Idol",
            "Standard Choir (Balanced)",
            "Kinetic Orchestral Artcore",
            "Glitchy Kinetic Breakcore",
            "Chop Loop Amenbreak",
            "Hardcore Speed Amencore",
            "Speedcore Stab Gabber",
            "Techstep Bass Neurofunk",
            "Hi-NRG Fast Eurobeat",
            "Kawaii Swell Future Bass",
            "Heavy Midtempo Cyberpunk",
            "8-Bit Retro Chiptune",
            "Raw Screamer Hardstyle",
            "Anthem Uplifting Trance"
        },
                targetNotesModeLabel = "Generation Destination",
        targetNotesModeChoices = { "Append at Playhead (New Notes)", "Replace at Playhead (Testing)", "Replace Selected Notes" },
        intensidadLabel = "3. Effect Intensity (%)",
        letraLabel = "Input lyrics:",
        letraDefault = "pa pa pa /y aa/ ma ka fi iss firr",
        basePitchLabel = "Base MIDI Note",
        soloFonemasLabel = "Chops Mode (Staccato & Gate)",
        modoMelodiaLabel = "Melodic Contour",
        modoMelodiaChoices = {
            "Prosodic Sung Arch (Organic)",
            "Pentatonic R&B/Pop (Hooks)",
            "Fluid Harmonic Wave (Sine)",
            "Kinetic Glitch (Chaotic)",
            "Flat Expressive (Speech)",
            "Ascending Arpeggio",
            "Descending Arpeggio",
            "Random Scale Step",
            "Consonant Leaps"
        },
        modoRitmoLabel = "Rhythmic Pattern",
        modoRitmoChoices = {
            "Syncopated Pop (1/4)",
            "Kinetic Micro-Chop (1/16)",
            "Legato Swell (1/2)",
            "Driving Hardcore (Triplet)",
            "Standard Flat"
        },
        escalaLabel = "Harmonic Scale",
        escalaChoices = {
            "Major Pentatonic",
            "Minor Pentatonic",
            "Natural Major (Ionian)",
            "Natural Minor (Aeolian)",
            "Dorian",
            "Phrygian",
            "Lydian",
            "Mixolydian",
            "Harmonic Minor",
            "Full Chromatic"
        },
        errContextTitle = "Context Error",
        errContextMsg = "Please select an active track in the editor before running.",
        errNoNotesTitle = "Structure Error",
        errNoNotesMsg = "No valid groups or notes found to process.",
        errNoSyllablesTitle = "Notice",
        errNoSyllablesMsg = "No valid syllables entered for generation.",
        confirmTitle = "Confirm Operation",
        confirmMsgGenerar = "Will generate notes from %d syllables starting at %s%d with preset '%s' at %d%%.\nContinue?",
        completedTitle = "Expressive Mapper Pro 3",
        completedMsg = "Operation completed successfully.\nItems processed/created: %d\nPreset/Config: %s\nIntensity: %d%%\nGroups/Tracks processed: %d\nAtomic undo registered (Ctrl+Z to revert).",
        vistaSeccionChoices = {
            "Quick Mode (EasyLyric & Melody)",
            "Vocal Expression (Hermite Curves)",
            "Vocal Harmonies (SATB Choir)",
            "Chords & Algorithmic Counterpoint"
        },
        ayudaGuiaSyllable = "  - (-) Syllable split",
        ayudaGuiaPhoneme = "  - (/) Raw phonemes",
        ayudaGuiaSlur = "  - (_) Note slur",
        ayudaGuiaInflection = "  - (\\) Pitch inflection",
        ayudaGuiaTimeMark = "  - (%) Time markers (%10.5s)"
    },
    [2] = { -- Japanese
        title = "表現力マッパー Pro 3",
        presetLabel = "2. ボーカルスタイル / プリセット",
        presetChoices = {
            "【推奨】ユニバーサルスタンダード（バランス型）",
            "【前回セッション】保存された設定をロード",
            "カスタム...",
            "力強いオペラ風ベルティング",
            "哀愁 / 悲しい",
            "親密なウィスパー",
            "シンセポップ / クラシックボーカロ",
            "ロック / アグレッシブグリット",
            "ダークアンビエント / 精神的ホラー",
            "表現力豊かなジャズ / ソウル",
            "ハイエナジー J-Pop アイドル",
            "標準合唱（バランス型）",
            "キネティックオーケストラアートコア",
            "グリッチキネティックブレイクコア",
            "チョップループアメンブレイク",
            "ハードコアスピードアメンコア",
            "スピードコアスタブガバ",
            "テックステップベースニューロファンク",
            "ハイエナジーファストユーロビート",
            "カワイイスウェルフューチャーベース",
            "ヘビーミドルテンポサイバーパンク",
            "8ビットレトロチップチューン",
            "ロースクリーマーハードスタイル",
            "アンセムアップリフティングトランス"
        },
                targetNotesModeLabel = "生成先ターゲット",
        targetNotesModeChoices = { "Playheadに追加（新規ノート）", "Playhead位置を置換（テスト用）", "選択されたノートを置換" },
        intensidadLabel = "3. エフェクト強度 (%)",
        letraLabel = "入力歌詞:",
        letraDefault = "ko-n-ni-chi-ha /y aa/ _ ko-re-ha cho-ppu \\",
        basePitchLabel = "基準 MIDI ノート",
        soloFonemasLabel = "チョップモード (直接音素)",
        modoMelodiaLabel = "メロディ輪郭",
        modoMelodiaChoices = {
            "プロソディ歌唱アーチ (自然)",
            "ペンタトニック R&B/Pop",
            "流麗ハーモニックウェーブ",
            "キネティックグリッチ (カオス)",
            "フラットエクスプレッシブ",
            "アルペジオ上昇",
            "アルペジオ下降",
            "ランダムスケールステップ",
            "協調的跳躍"
        },
        modoRitmoLabel = "リズムパターン",
        modoRitmoChoices = {
            "シンコペーション Pop (1/4)",
            "キネティックマイクロチョップ (1/16)",
            "レガートスウェル (1/2)",
            "ドライビングハードコア (3連)",
            "フラット標準"
        },
        escalaLabel = "和声スケール",
        escalaChoices = {
            "メジャーペンタトニック",
            "マイナーペンタトニック",
            "自然長音階 (イオニアン)",
            "自然短音階 (エオリアン)",
            "ドリアン",
            "フリジアン",
            "リディアン",
            "ミクソリディアン",
            "和声的短音階",
            "フルクロマチック"
        },
        errContextTitle = "コンテキストエラー",
        errContextMsg = "実行する前にエディタでアクティブなトラックを選択してください。",
        errNoNotesTitle = "構造エラー",
        errNoNotesMsg = "処理対象の有効なグループまたはノートが見つかりません。",
        errNoSyllablesTitle = "通知",
        errNoSyllablesMsg = "生成のための有効な音節が入力されていません。",
        confirmTitle = "操作の確認",
        confirmMsgGenerar = "%d音節から%s%dを基準にプリセット'%s'（%d%%）でノートを生成します。\n続行しますか？",
        completedTitle = "表現力マッパー Pro 3",
        completedMsg = "処理が正常に完了しました！\n処理/生成アイテム数: %d\nプリセット/設定: %s\n強度: %d%%\n処理グループ/トラック数: %d\nAtomic Undo 登録完了（Ctrl+Z で元に戻せます）。",
        vistaSeccionChoices = {
            "クイックモード (EasyLyric & メロディ)",
            "ボーカル表現 (エルミート曲線)",
            "ボーカルハーモニー (SATBコーラス)",
            "コード & アルゴリズム対位法"
        },
        ayudaGuiaSyllable = "  - (-) 音節分割",
        ayudaGuiaPhoneme = "  - (/) 直接音素",
        ayudaGuiaSlur = "  - (_) スラー",
        ayudaGuiaInflection = "  - (v) 音程変化"
    }
}

function getTranslations(langCode)
    local code = string.lower(langCode or "")
    if string.find(code, "en") then
        _G.idiomaDetectado = 1
        return I18N_DATA[1]
    elseif string.find(code, "ja") or string.find(code, "jp") then
        _G.idiomaDetectado = 2
        return I18N_DATA[2]
    else
        _G.idiomaDetectado = 0
        return I18N_DATA[0]
    end
end
-- ============================================================================
-- MÓDULO 2: DATOS Y PRESETS DE EXPRESIVIDAD VOCAL (LOW GC ALLOC)
-- ============================================================================

local VOCAL_MODE_NOMBRES = {
    "Chest", "Soft", "Power", "Airy", "Clear",
    "Open", "Passionate", "Solid", "Light", "Vivid", "Delicate"
}

-- Caché global de claves para evitar concatenaciones de string en tiempo de ejecución
local VOCAL_MODE_KEYS = {}
for i = 1, #VOCAL_MODE_NOMBRES do
    VOCAL_MODE_KEYS[i] = "vocalMode_" .. VOCAL_MODE_NOMBRES[i]
end

-- Buffers globales pre-asignados para interpolación Hermite y automatizaciones (Optimización de memoria)
local EVAL_NODOS = {
    t   = { 0.0, 0.15, 0.50, 0.85, 1.0 },
    val = { 0.0, 0.0, 0.0, 0.0, 0.0 },
    m   = { 0.0, 0.0, 0.0, 0.0, 0.0 }
}

local BUFFER_POSICIONES = { 0, 0, 0, 0, 0 }
local BUFFER_LOUDNESS = { 0.0, 0.0, 0.0, 0.0, 0.0 }
local BUFFER_VM_NODOS = { 0.0, 0.0, 0.0, 0.0, 0.0 }

-- Factores de densidad:
-- -1: Smart Adaptive Spline (Puntos adaptativos en deltas)
-- 64: 1/64 de Negra, 32: 1/32, 16: 1/16, 8: 1/8, 4: 1/4, 0: Nodos Clave, -2: Bloqueado a Fonema
local FACTOR_DENSIDAD = { -1, 64, 32, 16, 8, 4, 0, -2 }
local FACTOR_DURACION_SILABA = { 2.0, 1.0, 0.5, 0.25 }

local PRESET_EXPRESION = {
    [0] = { -- Belting Operático / Potente
        tension   = { 0.85, 0.75, 0.70, 0.80, 0.55 },
        aliento   = { -0.60, -0.50, -0.45, -0.35, -0.15 },
        volumen   = { 1.2, 1.8, 2.2, 2.5, 0.8 },
        genero    = { 0.12, 0.12, 0.12, 0.12, 0.12 },
        voicing   = { 0.95, 0.98, 1.00, 0.98, 0.85 },
        timbre    = { 0.20, 0.20, 0.20, 0.20, 0.20 },
        vibrato   = { 0.0, 0.2, 0.8, 1.6, 1.4 },
        vocalModeTarget = { chest = 0.95, power = 0.95, soft = -0.70, airy = -0.60, clear = 0.50 },
        scoopCents = -45.0, vbrDepthCents = 85.0, vbrFreqHz = 5.8, expPadX = 0.7, expPadY = 0.8,
        pitchSensitivity = 0.85, phonemeSensitivity = 0.70, humanizeJitter = 0.04, attackPunch = 0.25, releaseBreath = 0.15
    },
    [1] = { -- Triste / Melancólica / Emotiva
        tension   = { -0.40, -0.50, -0.55, -0.60, -0.70 },
        aliento   = { 0.50, 0.55, 0.60, 0.70, 0.80 },
        volumen   = { -1.2, -1.8, -2.2, -2.8, -4.0 },
        genero    = { -0.18, -0.18, -0.18, -0.18, -0.18 },
        voicing   = { 0.35, 0.30, 0.25, 0.20, 0.15 },
        timbre    = { -0.15, -0.15, -0.15, -0.15, -0.15 },
        vibrato   = { 0.0, 0.1, 0.6, 1.0, 0.8 },
        vocalModeTarget = { chest = -0.50, power = -0.70, soft = 0.85, airy = 0.90, clear = -0.30 },
        scoopCents = 30.0, vbrDepthCents = 50.0, vbrFreqHz = 4.8, expPadX = -0.4, expPadY = 0.5,
        pitchSensitivity = 0.60, phonemeSensitivity = 0.50, humanizeJitter = 0.08, attackPunch = -0.10, releaseBreath = 0.40
    },
    [2] = { -- Susurrada / Intimista / Suave
        tension   = { -0.75, -0.80, -0.85, -0.90, -0.95 },
        aliento   = { 0.80, 0.85, 0.90, 0.95, 1.00 },
        volumen   = { -3.0, -3.5, -4.0, -4.5, -6.0 },
        genero    = { -0.25, -0.25, -0.25, -0.25, -0.25 },
        voicing   = { 0.08, 0.05, 0.02, 0.00, 0.00 },
        timbre    = { -0.25, -0.25, -0.25, -0.25, -0.25 },
        vibrato   = { 0.0, 0.0, 0.1, 0.2, 0.1 },
        vocalModeTarget = { chest = -0.90, power = -1.00, soft = 1.00, airy = 1.00, clear = -0.50 },
        scoopCents = -10.0, vbrDepthCents = 15.0, vbrFreqHz = 4.0, expPadX = -0.7, expPadY = -0.3,
        pitchSensitivity = 0.30, phonemeSensitivity = 0.80, humanizeJitter = 0.09, attackPunch = -0.20, releaseBreath = 0.50
    },
    [3] = { -- Synth-Pop / Vocaloid Clásico
        tension   = { 0.45, 0.40, 0.40, 0.40, 0.35 },
        aliento   = { -0.50, -0.50, -0.50, -0.50, -0.50 },
        volumen   = { 0.8, 0.8, 0.8, 0.8, 0.5 },
        genero    = { -0.08, -0.08, -0.08, -0.08, -0.08 },
        voicing   = { 0.88, 0.88, 0.88, 0.88, 0.88 },
        timbre    = { 0.45, 0.45, 0.45, 0.45, 0.45 },
        vibrato   = { 0.1, 0.6, 1.2, 1.5, 1.3 },
        vocalModeTarget = { chest = 0.30, power = 0.40, soft = -0.40, airy = -0.50, clear = 0.90 },
        scoopCents = 0.0, vbrDepthCents = 65.0, vbrFreqHz = 6.4, expPadX = 0.1, expPadY = 0.1,
        pitchSensitivity = 0.40, phonemeSensitivity = 0.40, humanizeJitter = 0.02, attackPunch = 0.10, releaseBreath = 0.10
    },
    [4] = { -- Rock / Agresivo (Grit / Screaming)
        tension   = { 0.95, 0.90, 0.85, 0.90, 0.75 },
        aliento   = { -0.70, -0.60, -0.60, -0.50, -0.30 },
        volumen   = { 2.0, 2.5, 2.8, 3.0, 1.5 },
        genero    = { 0.30, 0.30, 0.30, 0.30, 0.30 },
        voicing   = { 1.00, 1.00, 0.98, 0.98, 0.95 },
        timbre    = { 0.30, 0.30, 0.30, 0.30, 0.30 },
        vibrato   = { 0.0, 0.4, 1.0, 1.6, 1.4 },
        vocalModeTarget = { chest = 1.00, power = 1.00, soft = -0.90, airy = -0.80, clear = 0.60 },
        scoopCents = -50.0, vbrDepthCents = 95.0, vbrFreqHz = 5.8, expPadX = 0.9, expPadY = 0.95,
        pitchSensitivity = 0.95, phonemeSensitivity = 0.90, humanizeJitter = 0.07, attackPunch = 0.40, releaseBreath = 0.25
    },
    [5] = { -- Dark Ambient / Terror Psicológico (Pitch Wobble & Fluctuación)
        tension   = { 0.40, -0.60, 0.80, -0.70, 0.20 },
        aliento   = { 0.60, 0.80, 0.50, 0.90, 0.95 },
        volumen   = { -1.5, 1.8, -3.0, 1.2, -5.0 },
        genero    = { -0.40, 0.40, -0.40, 0.40, -0.15 },
        voicing   = { 0.40, 0.10, 0.80, 0.05, 0.30 },
        timbre    = { -0.40, -0.15, -0.50, -0.25, -0.60 },
        vibrato   = { 0.3, 2.0, 0.1, 2.0, 0.5 },
        vocalModeTarget = { chest = -0.40, power = -0.50, soft = 0.70, airy = 0.95, clear = -0.70 },
        scoopCents = -75.0, vbrDepthCents = 120.0, vbrFreqHz = 3.5, expPadX = -0.6, expPadY = -0.9,
        pitchSensitivity = 0.70, phonemeSensitivity = 0.85, humanizeJitter = 0.18, attackPunch = 0.30, releaseBreath = 0.45
    },
    [6] = { -- Jazz / Soul Expresivo
        tension   = { 0.25, 0.45, 0.15, 0.35, 0.05 },
        aliento   = { 0.25, 0.15, 0.30, 0.20, 0.35 },
        volumen   = { -0.3, 1.0, 1.5, 0.8, -0.8 },
        genero    = { 0.08, 0.08, 0.08, 0.08, 0.08 },
        voicing   = { 0.80, 0.85, 0.75, 0.80, 0.70 },
        timbre    = { 0.08, 0.08, 0.08, 0.08, 0.08 },
        vibrato   = { 0.0, 0.2, 0.7, 1.4, 1.2 },
        vocalModeTarget = { chest = 0.50, power = 0.30, soft = 0.40, airy = 0.30, clear = 0.40 },
        scoopCents = -35.0, vbrDepthCents = 70.0, vbrFreqHz = 5.0, expPadX = 0.4, expPadY = 0.3,
        pitchSensitivity = 0.65, phonemeSensitivity = 0.75, humanizeJitter = 0.07, attackPunch = 0.15, releaseBreath = 0.30
    },
    [7] = { -- J-Pop Idol High Energy
        tension   = { 0.60, 0.70, 0.65, 0.60, 0.45 },
        aliento   = { -0.30, -0.40, -0.30, -0.20, -0.05 },
        volumen   = { 1.0, 1.5, 1.2, 1.0, 0.3 },
        genero    = { -0.15, -0.15, -0.15, -0.15, -0.15 },
        voicing   = { 0.90, 0.95, 0.90, 0.85, 0.80 },
        timbre    = { 0.30, 0.30, 0.30, 0.30, 0.30 },
        vibrato   = { 0.0, 0.4, 1.0, 1.3, 1.0 },
        vocalModeTarget = { chest = 0.60, power = 0.70, soft = -0.50, airy = -0.40, clear = 0.95 },
        scoopCents = -25.0, vbrDepthCents = 60.0, vbrFreqHz = 6.6, expPadX = 0.5, expPadY = 0.6,
        pitchSensitivity = 0.55, phonemeSensitivity = 0.50, humanizeJitter = 0.03, attackPunch = 0.20, releaseBreath = 0.15
    },
    [8] = { -- Estándar / Coro Angelical Universal
        tension   = { -0.10, 0.05, 0.15, 0.10, -0.05 },
        aliento   = { 0.35, 0.40, 0.50, 0.45, 0.60 },
        volumen   = { -1.5, 0.5, 1.2, 0.6, -2.0 },
        genero    = { -0.05, -0.05, -0.05, -0.05, -0.05 },
        voicing   = { 0.85, 0.90, 0.95, 0.90, 0.80 },
        timbre    = { -0.15, -0.10, -0.05, -0.10, -0.20 },
        vibrato   = { 0.0, 0.2, 0.6, 1.0, 0.7 },
        vocalModeTarget = { chest = -0.30, power = -0.40, soft = 0.80, airy = 0.90, clear = -0.30 },
        scoopCents = -10.0, vbrDepthCents = 45.0, vbrFreqHz = 4.8, expPadX = -0.3, expPadY = -0.4,
        pitchSensitivity = 0.60, phonemeSensitivity = 0.70, humanizeJitter = 0.06, attackPunch = 0.05, releaseBreath = 0.45
    },
    [9] = { -- Artcore (D&B Orquestal / Swells Dramáticos)
        tension   = { 0.50, 0.80, 0.95, 0.70, 0.35 },
        aliento   = { 0.20, -0.30, -0.45, 0.00, 0.30 },
        volumen   = { 0.8, 2.2, 3.0, 1.5, 0.0 },
        genero    = { 0.08, 0.08, 0.08, 0.08, 0.08 },
        voicing   = { 0.90, 0.98, 1.00, 0.95, 0.85 },
        timbre    = { 0.25, 0.30, 0.35, 0.25, 0.15 },
        vibrato   = { 0.0, 0.5, 1.5, 1.9, 1.2 },
        vocalModeTarget = { chest = 0.70, power = 0.85, clear = 0.90, passionate = 0.98 },
        scoopCents = -30.0, vbrDepthCents = 85.0, vbrFreqHz = 6.0, expPadX = 0.6, expPadY = 0.7,
        pitchSensitivity = 0.80, phonemeSensitivity = 0.65, humanizeJitter = 0.05, attackPunch = 0.30, releaseBreath = 0.25
    },
    [10] = { -- Breakcore / Glitchcore (Micro-Chopping & Pitch Stutter)
        tension   = { 1.00, -0.60, 1.00, -0.70, 0.90 },
        aliento   = { -0.80, 0.80, -0.70, 0.90, -0.50 },
        volumen   = { 2.5, -3.0, 3.5, -2.5, 2.0 },
        genero    = { 0.50, -0.50, 0.60, -0.60, 0.40 },
        voicing   = { 1.00, 0.20, 1.00, 0.10, 0.95 },
        timbre    = { 0.70, -0.60, 0.80, -0.70, 0.50 },
        vibrato   = { 0.0, 0.0, 0.0, 0.1, 0.0 },
        vocalModeTarget = { power = 1.00, solid = 0.95, vivid = 1.00, airy = -0.90 },
        scoopCents = -100.0, vbrDepthCents = 20.0, vbrFreqHz = 8.0, expPadX = 1.0, expPadY = 1.0,
        pitchSensitivity = 1.00, phonemeSensitivity = 1.00, humanizeJitter = 0.25, attackPunch = 0.50, releaseBreath = 0.30
    },
    [11] = { -- Amenbreak / Jungle D&B (Chopping Vocal Soul)
        tension   = { 0.60, 0.75, 0.70, 0.65, 0.50 },
        aliento   = { -0.40, -0.30, -0.20, -0.30, -0.15 },
        volumen   = { 1.0, 1.8, 1.6, 1.2, 0.3 },
        genero    = { 0.18, 0.18, 0.12, 0.12, 0.12 },
        voicing   = { 0.92, 0.98, 0.92, 0.88, 0.82 },
        timbre    = { 0.15, 0.20, 0.15, 0.08, 0.00 },
        vibrato   = { 0.0, 0.3, 0.8, 1.3, 0.9 },
        vocalModeTarget = { chest = 0.85, passionate = 0.90, solid = 0.80 },
        scoopCents = -45.0, vbrDepthCents = 65.0, vbrFreqHz = 5.6, expPadX = 0.5, expPadY = 0.6,
        pitchSensitivity = 0.75, phonemeSensitivity = 0.80, humanizeJitter = 0.12, attackPunch = 0.35, releaseBreath = 0.20
    },
    [12] = { -- Amencore / Hard Breakcore (Chopping Agresivo & Drive)
        tension   = { 1.00, 0.95, 0.90, 0.95, 0.80 },
        aliento   = { -0.80, -0.70, -0.70, -0.60, -0.40 },
        volumen   = { 2.5, 3.2, 3.5, 3.0, 1.8 },
        genero    = { 0.35, 0.35, 0.35, 0.35, 0.30 },
        voicing   = { 1.00, 1.00, 1.00, 0.98, 0.92 },
        timbre    = { 0.55, 0.55, 0.50, 0.45, 0.35 },
        vibrato   = { 0.0, 0.1, 0.3, 0.5, 0.2 },
        vocalModeTarget = { power = 1.00, chest = 0.95, solid = 1.00, clear = 0.70 },
        scoopCents = -60.0, vbrDepthCents = 85.0, vbrFreqHz = 6.2, expPadX = 1.0, expPadY = 0.9,
        pitchSensitivity = 0.90, phonemeSensitivity = 0.90, humanizeJitter = 0.15, attackPunch = 0.45, releaseBreath = 0.25
    },
    [13] = { -- Gabber / Speedcore / Frenchcore (Hardcore Extremo & Punch +3dB)
        tension   = { 1.00, 1.00, 1.00, 1.00, 0.90 },
        aliento   = { -0.90, -0.80, -0.80, -0.70, -0.50 },
        volumen   = { 3.5, 4.0, 4.2, 3.8, 2.5 },
        genero    = { 0.25, 0.25, 0.25, 0.25, 0.25 },
        voicing   = { 1.00, 1.00, 1.00, 1.00, 0.98 },
        timbre    = { 0.65, 0.65, 0.65, 0.60, 0.55 },
        vibrato   = { 0.0, 0.0, 0.1, 0.3, 0.1 },
        vocalModeTarget = { power = 1.00, chest = 1.00, vivid = 0.95, clear = 0.85 },
        scoopCents = -75.0, vbrDepthCents = 95.0, vbrFreqHz = 7.0, expPadX = 1.0, expPadY = 1.0,
        pitchSensitivity = 0.95, phonemeSensitivity = 0.95, humanizeJitter = 0.10, attackPunch = 0.50, releaseBreath = 0.20
    },
    [14] = { -- Neurofunk / Techstep (Resonancia Metálica Ciber)
        tension   = { 0.80, 0.90, 0.85, 0.92, 0.70 },
        aliento   = { -0.50, -0.60, -0.40, -0.50, -0.30 },
        volumen   = { 1.5, 2.5, 2.2, 2.6, 1.0 },
        genero    = { -0.15, -0.15, -0.15, -0.15, -0.15 },
        voicing   = { 0.98, 0.98, 0.95, 0.98, 0.90 },
        timbre    = { 0.40, 0.48, 0.52, 0.48, 0.38 },
        vibrato   = { 0.0, 0.2, 0.5, 0.8, 0.4 },
        vocalModeTarget = { solid = 0.95, clear = 0.90, power = 0.80, soft = -0.60 },
        scoopCents = -35.0, vbrDepthCents = 60.0, vbrFreqHz = 5.4, expPadX = 0.8, expPadY = 0.7,
        pitchSensitivity = 0.70, phonemeSensitivity = 0.85, humanizeJitter = 0.08, attackPunch = 0.30, releaseBreath = 0.25
    },
    [15] = { -- Eurobeat / Hi-NRG (Super Eurobeat / Alta Energía)
        tension   = { 0.90, 0.85, 0.85, 0.90, 0.75 },
        aliento   = { -0.60, -0.50, -0.50, -0.40, -0.25 },
        volumen   = { 2.0, 2.5, 2.8, 3.0, 1.5 },
        genero    = { -0.12, -0.12, -0.12, -0.12, -0.12 },
        voicing   = { 0.98, 1.00, 1.00, 0.98, 0.90 },
        timbre    = { 0.35, 0.40, 0.40, 0.35, 0.30 },
        vibrato   = { 0.0, 0.5, 1.4, 2.0, 1.6 },
        vocalModeTarget = { power = 0.95, clear = 1.00, vivid = 1.00, chest = 0.70 },
        scoopCents = -25.0, vbrDepthCents = 75.0, vbrFreqHz = 6.6, expPadX = 0.8, expPadY = 0.85,
        pitchSensitivity = 0.85, phonemeSensitivity = 0.60, humanizeJitter = 0.04, attackPunch = 0.35, releaseBreath = 0.15
    },
    [16] = { -- Future Bass / Kawaii (Airy Swells, Pitch Glide & Formante Tierno)
        tension   = { 0.25, 0.45, 0.55, 0.35, 0.15 },
        aliento   = { 0.40, 0.50, 0.40, 0.60, 0.70 },
        volumen   = { 0.2, 1.5, 1.8, 1.0, -0.8 },
        genero    = { -0.35, -0.40, -0.40, -0.35, -0.30 },
        voicing   = { 0.75, 0.85, 0.90, 0.80, 0.65 },
        timbre    = { -0.25, -0.20, -0.15, -0.25, -0.30 },
        vibrato   = { 0.0, 0.4, 1.0, 1.5, 1.2 },
        vocalModeTarget = { soft = 0.90, airy = 0.85, vivid = 0.80, light = 0.95 },
        scoopCents = 40.0, vbrDepthCents = 55.0, vbrFreqHz = 5.2, expPadX = -0.5, expPadY = 0.6,
        pitchSensitivity = 0.60, phonemeSensitivity = 0.70, humanizeJitter = 0.06, attackPunch = 0.15, releaseBreath = 0.35
    },
    [17] = { -- Cyberpunk / Midtempo (Synthwave Industrial Pesado)
        tension   = { 0.85, 0.90, 0.80, 0.90, 0.70 },
        aliento   = { -0.50, -0.40, -0.50, -0.40, -0.20 },
        volumen   = { 1.5, 2.4, 2.6, 2.4, 1.0 },
        genero    = { 0.30, 0.30, 0.25, 0.25, 0.20 },
        voicing   = { 0.98, 0.98, 0.92, 0.98, 0.88 },
        timbre    = { 0.30, 0.35, 0.35, 0.30, 0.25 },
        vibrato   = { 0.0, 0.2, 0.5, 0.8, 0.6 },
        vocalModeTarget = { chest = 0.95, power = 0.90, solid = 1.00, soft = -0.80 },
        scoopCents = -50.0, vbrDepthCents = 65.0, vbrFreqHz = 5.2, expPadX = 0.8, expPadY = 0.8,
        pitchSensitivity = 0.80, phonemeSensitivity = 0.80, humanizeJitter = 0.07, attackPunch = 0.35, releaseBreath = 0.20
    },
    [18] = { -- Chiptune / 8-Bit Hardcore (Ataque Cuantizado & 0 Vibrato)
        tension   = { 0.60, 0.60, 0.60, 0.60, 0.60 },
        aliento   = { -0.70, -0.70, -0.70, -0.70, -0.70 },
        volumen   = { 1.2, 1.2, 1.2, 1.2, 1.0 },
        genero    = { 0.0, 0.0, 0.0, 0.0, 0.0 },
        voicing   = { 1.00, 1.00, 1.00, 1.00, 1.00 },
        timbre    = { 0.60, 0.60, 0.60, 0.60, 0.60 },
        vibrato   = { 0.0, 0.0, 0.0, 0.0, 0.0 },
        vocalModeTarget = { clear = 1.00, solid = 0.95, airy = -1.00 },
        scoopCents = 0.0, vbrDepthCents = 0.0, vbrFreqHz = 0.0, expPadX = 0.0, expPadY = 0.0,
        pitchSensitivity = 0.00, phonemeSensitivity = 0.10, humanizeJitter = 0.00, attackPunch = 0.00, releaseBreath = 0.00
    },
    [19] = { -- Hardstyle / Rawstyle (Punch Vocal Raw Screaming)
        tension   = { 1.00, 0.95, 0.95, 1.00, 0.85 },
        aliento   = { -0.80, -0.70, -0.70, -0.60, -0.40 },
        volumen   = { 3.0, 3.5, 3.8, 3.2, 2.2 },
        genero    = { 0.25, 0.25, 0.25, 0.25, 0.20 },
        voicing   = { 1.00, 1.00, 1.00, 1.00, 0.95 },
        timbre    = { 0.50, 0.50, 0.45, 0.50, 0.40 },
        vibrato   = { 0.0, 0.3, 0.7, 1.2, 0.8 },
        vocalModeTarget = { power = 1.00, chest = 0.95, solid = 1.00, passionate = 0.85 },
        scoopCents = -65.0, vbrDepthCents = 80.0, vbrFreqHz = 6.0, expPadX = 0.95, expPadY = 0.95,
        pitchSensitivity = 0.95, phonemeSensitivity = 0.90, humanizeJitter = 0.10, attackPunch = 0.45, releaseBreath = 0.25
    },
    [20] = { -- Uplifting Trance (Legato Eufórico & Vibrato Progresivo)
        tension   = { 0.40, 0.70, 0.90, 0.80, 0.45 },
        aliento   = { 0.15, 0.05, -0.15, 0.05, 0.25 },
        volumen   = { 0.5, 1.8, 2.6, 2.0, 0.8 },
        genero    = { -0.05, -0.05, -0.05, -0.05, -0.05 },
        voicing   = { 0.85, 0.92, 0.98, 0.92, 0.85 },
        timbre    = { 0.20, 0.25, 0.30, 0.25, 0.15 },
        vibrato   = { 0.0, 0.6, 1.6, 2.2, 1.8 },
        vocalModeTarget = { passionate = 0.95, clear = 0.90, soft = 0.35, airy = 0.25 },
        scoopCents = -35.0, vbrDepthCents = 85.0, vbrFreqHz = 5.8, expPadX = 0.6, expPadY = 0.75,
        pitchSensitivity = 0.75, phonemeSensitivity = 0.55, humanizeJitter = 0.05, attackPunch = 0.20, releaseBreath = 0.30
    }
}

-- ============================================================================
-- ESCALAS MÚSICALES AVANZADAS (15 ESCALAS)
-- ============================================================================
local ESCALAS_AVANZADAS = {
    [0]  = { 0, 2, 4, 7, 9 },                    -- Pentatónica Mayor
    [1]  = { 0, 3, 5, 7, 10 },                   -- Pentatónica Menor
    [2]  = { 0, 2, 4, 5, 7, 9, 11 },             -- Mayor Natural (Jónica)
    [3]  = { 0, 2, 3, 5, 7, 8, 10 },             -- Menor Natural (Eólica)
    [4]  = { 0, 2, 3, 5, 7, 8, 11 },             -- Menor Armónica
    [5]  = { 0, 2, 3, 5, 7, 9, 11 },             -- Menor Melódica
    [6]  = { 0, 2, 3, 5, 7, 9, 10 },             -- Dórica
    [7]  = { 0, 1, 3, 5, 7, 8, 10 },             -- Frigia
    [8]  = { 0, 2, 4, 6, 7, 9, 11 },             -- Lidia
    [9]  = { 0, 2, 4, 5, 7, 9, 10 },             -- Mixolidia
    [10] = { 0, 1, 3, 5, 6, 8, 10 },             -- Locria
    [11] = { 0, 3, 5, 6, 7, 10 },                -- Blues
    [12] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }, -- Cromática
    [13] = { 0, 2, 3, 6, 7, 8, 11 },             -- Húngara Menor
    [14] = { 0, 1, 4, 5, 7, 8, 11 },             -- Doble Armónica (Bizantina)
}

-- ============================================================================
-- PERFILES DE PITCH CLASS DE KRUMHANSL-KESSLER (AUTO-DETECCIÓN DE TONALIDAD)
-- ============================================================================
local PERFILES_KRUMHANSL = {
    -- Tonalidad Mayor: C, C#, D, D#, E, F, F#, G, G#, A, A#, B
    mayor = { 6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88 },
    -- Tonalidad Menor: C, C#, D, D#, E, F, F#, G, G#, A, A#, B
    menor = { 6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17 }
}

-- ============================================================================
-- PROGRESIONES DE ACORDES PREDEFINIDAS
-- ============================================================================
local PROGRESIONES_ACORDES = {
    [0]  = { nombre = "J-Pop / Anime Royal", grados = { 4, 5, 3, 6 }, tipos = { "maj7", "dom7", "min7", "min7" } },
    [1]  = { nombre = "Pop / EDM Anthem", grados = { 1, 5, 6, 4 }, tipos = { "add9", "triada_mayor", "min7", "maj7" } },
    [2]  = { nombre = "Neo-Soul / R&B Lounge", grados = { 2, 5, 1, 6 }, tipos = { "min9", "dom13", "maj9", "dom7alt" } },
    [3]  = { nombre = "Jazz Cadencia 2-5-1", grados = { 2, 5, 1, 6 }, tipos = { "min7", "dom7", "maj7", "dom7" } },
    [4]  = { nombre = "Dark Ambient Horror", grados = { 1, 6, 3, 7 }, tipos = { "triada_menor", "maj7", "maj7", "dom7" } },
    [5]  = { nombre = "Artcore / Breakcore Kinetic", grados = { 4, 5, 1, 6 }, tipos = { "min7", "min7", "min9", "maj7" } },
    [6]  = { nombre = "City Pop / 80s Funk", grados = { 4, 3, 6, 2 }, tipos = { "maj7", "dom7", "min7", "dom7" } },
    [7]  = { nombre = "Math Rock / Midwest Emo", grados = { 1, 4, 6, 5 }, tipos = { "add9", "maj7", "min7", "sus4" } },
    [8]  = { nombre = "Future Bass / Kawaii Chords", grados = { 4, 5, 3, 6 }, tipos = { "maj9", "dom9", "min7", "min9" } },
    [9]  = { nombre = "Lo-Fi Chill Hop", grados = { 1, 6, 2, 5 }, tipos = { "maj7", "dom7", "min7", "dom7alt" } },
    [10] = { nombre = "Cyberpunk Midtempo Dystopia", grados = { 1, 2, 1, 6 }, tipos = { "triada_menor", "triada_mayor", "triada_menor", "maj7" } },
    [11] = { nombre = "Orquestal Dramático Swell", grados = { 1, 4, 5, 1 }, tipos = { "triada_menor", "min7", "dom7", "triada_menor" } },
    [12] = { nombre = "Gospel / Soul Elevación", grados = { 1, 1, 4, 4 }, tipos = { "triada_mayor", "dom7", "triada_mayor", "triada_menor" } },
    [13] = { nombre = "Gabber / Hardstyle Stabs", grados = { 1, 6, 7, 1 }, tipos = { "triada_menor", "triada_mayor", "triada_mayor", "triada_menor" } },
    [14] = { nombre = "Chiptune / 8-Bit Heroico", grados = { 1, 7, 6, 5 }, tipos = { "triada_mayor", "triada_mayor", "triada_mayor", "dom7" } },
    [15] = { nombre = "Uplifting Trance Pad", grados = { 6, 4, 1, 5 }, tipos = { "min7", "maj7", "triada_mayor", "dom7" } }
}

-- ============================================================================
-- PRESETS CORALES Y ARMONÍAS MULTI-VOZ
-- ============================================================================
local PRESETS_CORALES = {
    [0] = { nombre = "Dúo 3ras Superiores", intervalos = { 2 }, nombresVoces = { "Voz 2 (3ra Arriba)" } },
    [1] = { nombre = "Dúo 3ras Inferiores", intervalos = { -2 }, nombresVoces = { "Voz 2 (3ra Abajo)" } },
    [2] = { nombre = "Trío Pop (3ras y 5tas)", intervalos = { 2, 4 }, nombresVoces = { "Voz 2 (3ra)", "Voz 3 (5ta)" } },
    [3] = { nombre = "Cuarteto Coral SATB", intervalos = { 4, 2, -4, -7 }, nombresVoces = { "Soprano", "Alto", "Tenor", "Bajo" } },
    [4] = { nombre = "Power Duo (5tas y 8vas)", intervalos = { 4, 7 }, nombresVoces = { "Power 5ta", "Octava" } },
    [5] = { nombre = "Coro Unísono Anti-fase", intervalos = { 0, 0 }, nombresVoces = { "Doblaje A", "Doblaje B" } }
}


-- Limitar un valor dentro de un rango minimo y maximo
local function limitarValor(val, minVal, maxVal)
    if val < minVal then return minVal end
    if val > maxVal then return maxVal end
    return val
end

-- Calcular factor de escala de tiempo en base al tempo BPM
local function factorTempo(bpm)
    if bpm <= 0 then return 1.0 end
    return 120.0 / bpm
end

-- Obtener tempo BPM en una posición de blicks específica
local function obtenerTempoEnBlick(timeAxis, blickPos)
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

-- ============================================================================
-- MÓDULO 3: TOKENIZADOR MULTILINGÜE Y GENERADOR MELÓDICO PROSÓDICO (ES, EN, JA)
-- ============================================================================

local ESCALAS = ESCALAS_AVANZADAS or {
    [0] = { 0, 2, 4, 7, 9 },       -- Pentatónica Mayor
    [1] = { 0, 3, 5, 7, 10 },      -- Pentatónica Menor
    [2] = { 0, 2, 4, 5, 7, 9, 11 },-- Mayor Natural
    [3] = { 0, 2, 3, 5, 7, 8, 10 } -- Menor Natural
}

--- Auto-detección de tonalidad mediante correlación estadística de Krumhansl-Kessler
local function detectarTonalidad(noteGroup)
    if not noteGroup then return 0, 2 end -- Default: C Mayor

    local numNotas = noteGroup:getNumNotes()
    if numNotas == 0 then return 0, 2 end

    local hist = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local totalDur = 0

    for i = 1, numNotas do
        local n = noteGroup:getNote(i)
        if n then
            local pc = n:getPitch() % 12
            local dur = n:getDuration()
            local onset = n:getOnset()
            -- Ponderación métrica: notas en tiempos fuertes (tiempos 1 y 3 en 4/4) tienen mayor peso estadístico (1.5x)
            local multMetrico = 1.0
            if onset and SV and SV.QUARTER then
                if (onset % (SV.QUARTER * 2)) == 0 then
                    multMetrico = 1.5
                end
            end
            local pesoEfectivo = dur * multMetrico
            hist[pc + 1] = hist[pc + 1] + pesoEfectivo
            totalDur = totalDur + pesoEfectivo
        end
    end

    if totalDur == 0 then return 0, 2 end

    local meanHist = 0
    for i = 1, 12 do meanHist = meanHist + hist[i] end
    meanHist = meanHist / 12.0

    local perfilMayor = (PERFILES_KRUMHANSL and PERFILES_KRUMHANSL.mayor) or { 6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88 }
    local perfilMenor = (PERFILES_KRUMHANSL and PERFILES_KRUMHANSL.menor) or { 6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17 }

    local meanProfMaj = 0
    local meanProfMin = 0
    for i = 1, 12 do
        meanProfMaj = meanProfMaj + perfilMayor[i]
        meanProfMin = meanProfMin + perfilMenor[i]
    end
    meanProfMaj = meanProfMaj / 12.0
    meanProfMin = meanProfMin / 12.0

    local mejorTonica = 0
    local mejorEscala = 2
    local maxCorr = -9999.0

    for root = 0, 11 do
        -- Correlación Mayor
        local corrMayor = 0.0
        local sumHistSqMaj = 0.0
        local sumProfSqMaj = 0.0

        for i = 1, 12 do
            local pcIdx = ((i - 1 + root) % 12) + 1
            local diffH = hist[pcIdx] - meanHist
            local diffP = perfilMayor[i] - meanProfMaj
            corrMayor = corrMayor + (diffH * diffP)
            sumHistSqMaj = sumHistSqMaj + (diffH * diffH)
            sumProfSqMaj = sumProfSqMaj + (diffP * diffP)
        end

        local denomMaj = math.sqrt(sumHistSqMaj * sumProfSqMaj)
        if denomMaj > 0 then corrMayor = corrMayor / denomMaj end

        if corrMayor > maxCorr then
            maxCorr = corrMayor
            mejorTonica = root
            mejorEscala = 2
        end

        -- Correlación Menor
        local corrMenor = 0.0
        local sumHistSqMin = 0.0
        local sumProfSqMin = 0.0

        for i = 1, 12 do
            local pcIdx = ((i - 1 + root) % 12) + 1
            local diffH = hist[pcIdx] - meanHist
            local diffP = perfilMenor[i] - meanProfMin
            corrMenor = corrMenor + (diffH * diffP)
            sumHistSqMin = sumHistSqMin + (diffH * diffH)
            sumProfSqMin = sumProfSqMin + (diffP * diffP)
        end

        local denomMin = math.sqrt(sumHistSqMin * sumProfSqMin)
        if denomMin > 0 then corrMenor = corrMenor / denomMin end

        if corrMenor > maxCorr then
            maxCorr = corrMenor
            mejorTonica = root
            mejorEscala = 3
        end
    end

    return mejorTonica, mejorEscala
end


local NOTAS_NOMBRE = {
    C=0, ["C#"]=1, DB=1, D=2, ["D#"]=3, EB=3, E=4, F=5,
    ["F#"]=6, GB=6, G=7, ["G#"]=8, AB=8, A=9, ["A#"]=10, BB=10, B=11
}

-- Tabla de vocales acentuadas UTF-8 (cada carácter son 2 bytes en UTF-8)
-- á=\195\161, é=\195\169, í=\195\173, ó=\195\179, ú=\195\186
-- Á=\195\129, É=\195\137, Í=\195\141, Ó=\195\147, Ú=\195\154
local VOCALES_ACENTUADAS_UTF8 = {
    ["\195\161"] = true, -- á
    ["\195\169"] = true, -- é
    ["\195\173"] = true, -- í
    ["\195\179"] = true, -- ó
    ["\195\186"] = true, -- ú
    ["\195\129"] = true, -- Á
    ["\195\137"] = true, -- É
    ["\195\141"] = true, -- Í
    ["\195\147"] = true, -- Ó
    ["\195\154"] = true, -- Ú
}

local VOCALES_ES = {
    a = true, e = true, i = true, o = true, u = true,
    A = true, E = true, I = true, O = true, U = true,
}

local function notaStringAMidi(notaStr)
    local nombre, octava = string.match(notaStr, "^([A-Ga-g][#b]?)(%d+)$")
    if nombre and octava then
        nombre = string.upper(nombre)
        local base = NOTAS_NOMBRE[nombre]
        if base then
            -- Convención SynthV: C4 = 60, C-1 = 0 → (octava + 1) * 12
            return (tonumber(octava) + 1) * 12 + base
        end
    end
    return nil
end

local function cuantizarAEscala(pitchMidi, basePitch, escalaIndices)
    local rel = pitchMidi - basePitch
    local octava = math.floor(rel / 12)
    local semitonoMod = rel % 12
    if semitonoMod < 0 then semitonoMod = semitonoMod + 12 end

    local numElem = #escalaIndices
    local mejorNota = escalaIndices[1]
    local minDiff = math.abs(semitonoMod - mejorNota)

    for idx = 2, numElem do
        local notaEscala = escalaIndices[idx]
        local diff = math.abs(semitonoMod - notaEscala)
        if diff < minDiff then
            minDiff = diff
            mejorNota = notaEscala
        end
    end

    return basePitch + (octava * 12) + mejorNota
end

--- Detectar si un token UTF-8 contiene una vocal acentuada española
local function contieneTildeUTF8(token)
    -- Recorrer grafemas UTF-8 de 2 bytes (rango \195\128 a \195\191)
    local i = 1
    local len = #token
    while i <= len do
        local byte1 = string.byte(token, i)
        if byte1 >= 194 and byte1 <= 244 and i + 1 <= len then
            local grafema = string.sub(token, i, i + 1)
            if VOCALES_ACENTUADAS_UTF8[grafema] then
                return true
            end
            -- Avanzar según longitud UTF-8
            if byte1 >= 240 then
                i = i + 4
            elseif byte1 >= 224 then
                i = i + 3
            else
                i = i + 2
            end
        else
            i = i + 1
        end
    end
    return false
end

--- Detección de acentuación prosódica según idioma (ES, EN, JA)
local function analizarProsodiaSilaba(token, idiomaIdx, indiceNota, totalCantadas, esPregunta, esExclamacion)
    local esTonica = false
    local deltaPitchProsodico = 0
    local multDurProsodico = 1.0

    if idiomaIdx == 0 then -- Español
        -- Detección robusta de tilde en vocal española via bytes UTF-8
        if contieneTildeUTF8(token) then
            esTonica = true
        else
            local tokenLower = string.lower(token)
            -- Heurística: si termina en vocal, n, o s → palabra grave (penúltima tónica)
            if string.match(tokenLower, "[aeiou][ns]?$") then
                esTonica = (indiceNota % 2 == 1)
            else
                -- Palabras agudas (última sílaba acentuada)
                esTonica = true
            end
        end

        if esTonica then
            deltaPitchProsodico = 3
            multDurProsodico = 1.25
        end

        -- Inflexión prosódica al final de frase según puntuación (? / ! / declarativa)
        if indiceNota == totalCantadas then
            if esPregunta then
                deltaPitchProsodico = deltaPitchProsodico + 3
                multDurProsodico = multDurProsodico * 1.15
            elseif esExclamacion then
                deltaPitchProsodico = deltaPitchProsodico + 2
                multDurProsodico = multDurProsodico * 1.20
            else
                deltaPitchProsodico = deltaPitchProsodico - 2
            end
        end

    elseif idiomaIdx == 1 then -- Inglés
        local tokenLower = string.lower(token)
        -- Alternancia de acento iámbico/trocaico (sílabas fuertes)
        if (indiceNota % 2 == 1) or string.match(tokenLower, "ing$") or string.match(tokenLower, "tion$") then
            esTonica = true
            deltaPitchProsodico = 2
            multDurProsodico = 1.20
        else
            deltaPitchProsodico = -1
            multDurProsodico = 0.85
        end

        if indiceNota == totalCantadas then
            if esPregunta then
                deltaPitchProsodico = deltaPitchProsodico + 3
                multDurProsodico = multDurProsodico * 1.15
            elseif esExclamacion then
                deltaPitchProsodico = deltaPitchProsodico + 2
            end
        end

    elseif idiomaIdx == 2 then -- Japonés (Pitch Accent Moraico)
        -- Patrón de Pitch Accent (Heiban / Atamadaka drop)
        if indiceNota == 1 then
            deltaPitchProsodico = 0 -- Mora inicial
        elseif indiceNota == 2 then
            deltaPitchProsodico = 2 -- Subida de onset en Heiban
        elseif (indiceNota % 4 == 0) then
            deltaPitchProsodico = -3 -- Caída de acento en Nakadaka
        end

        if indiceNota == totalCantadas and esPregunta then
            deltaPitchProsodico = deltaPitchProsodico + 3
        end

        multDurProsodico = 1.00 -- Tempo moraico constante en Japonés
    end

    return deltaPitchProsodico, multDurProsodico, esTonica
end

local VOCALES_ABIERTAS = {
    a=true, e=true, o=true, A=true, E=true, O=true,
    ["\195\161"] = true, -- á
    ["\195\169"] = true, -- é
    ["\195\179"] = true, -- ó
    ["\195\129"] = true, -- Á
    ["\195\137"] = true, -- É
    ["\195\147"] = true, -- Ó
}

local VOCALES_CERRADAS_ATONAS = {
    i=true, u=true, I=true, U=true,
    ["\195\188"] = true, -- ü
    ["\195\156"] = true, -- Ü
}

local VOCALES_CERRADAS_TONICAS = {
    ["\195\173"] = true, -- í
    ["\195\186"] = true, -- ú
    ["\195\141"] = true, -- Í
    ["\195\154"] = true, -- Ú
}

local CLUSTERS_INSEPARABLES = {
    bl=true, br=true, cl=true, cr=true, dr=true, fl=true, fr=true, gl=true, gr=true, pl=true, pr=true, tr=true,
    ch=true, ll=true, rr=true, qu=true, gu=true,
    BL=true, BR=true, CL=true, CR=true, DR=true, FL=true, FR=true, GL=true, GR=true, PL=true, PR=true, TR=true,
    CH=true, LL=true, RR=true, QU=true, GU=true
}

-- Diccionario de excepciones de silabificación para nombres propios y términos ambiguos
local EXCEPCIONES_SILABAS_ES = {
    luis = { "Luis" },
    marte = { "Mar-", "te" },
    juan = { "Juan" },
    dios = { "Dios" },
    rey = { "Rey" },
    san = { "San" },
    guia = { "Guí-", "a" },
    mario = { "Ma-", "rio" },
    jaime = { "Jai-", "me" },
    paula = { "Pau-", "la" },
    raul = { "Ra-", "úl" },
    maria = { "Ma-", "rí-", "a" },
    sofia = { "So-", "fí-", "a" },
    lucia = { "Lu-", "cí-", "a" },
    diego = { "Die-", "go" },
    miguel = { "Mi-", "guel" },
    angel = { "Án-", "gel" },
    jose = { "Jo-", "sé" },
    jesus = { "Je-", "sús" },
    teatro = { "Te-", "a-", "tro" },
    poesia = { "Po-", "e-", "sí-", "a" },
    caotico = { "Ca-", "ó-", "ti-", "co" },
    heroe = { "Hé-", "ro-", "e" },
    linea = { "Lí-", "ne-", "a" },
    aereo = { "A-", "é-", "re-", "o" }
}

-- Diccionario de excepciones de hiatos y nombres propios comunes en inglés
local EXCEPCIONES_SILABAS_EN = {
    create = { "cre-", "ate" },
    giant = { "gi-", "ant" },
    lion = { "li-", "on" },
    chaos = { "cha-", "os" },
    poet = { "po-", "et" },
    neon = { "ne-", "on" },
    real = { "re-", "al" },
    ruin = { "ru-", "in" },
    idea = { "i-", "de-", "a" },
    science = { "sci-", "ence" },
    quiet = { "qui-", "et" },
    violet = { "vi-", "o-", "let" },
    video = { "vi-", "de-", "o" },
    casual = { "ca-", "su-", "al" },
    theater = { "the-", "a-", "ter" }
}

-- Normalizador de variantes de teclado Romaji japonés (IME)
local function normalizarRomajiJapones(palabra)
    local p = string.lower(palabra)
    p = string.gsub(p, "ti", "chi")
    p = string.gsub(p, "tu", "tsu")
    p = string.gsub(p, "si", "shi")
    p = string.gsub(p, "hu", "fu")
    return p
end


--- Auto-silabificador avanzado para español con reglas RAE (Optimizado en buffers estáticos)
local function silabificarEspanol(palabra)
    local silabas = {}
    local len = #palabra
    if len == 0 then return silabas end

    local palabraLower = string.lower(palabra)
    if EXCEPCIONES_SILABAS_ES[palabraLower] then
        local exc = EXCEPCIONES_SILABAS_ES[palabraLower]
        for ei = 1, #exc do
            silabas[ei] = exc[ei]
        end
        return silabas
    end

    -- Reconstruir la palabra como secuencia de caracteres UTF-8
    local chars = {}
    local i = 1
    while i <= len do
        local byte1 = string.byte(palabra, i)
        local charLen = 1
        if byte1 >= 240 then charLen = 4
        elseif byte1 >= 224 then charLen = 3
        elseif byte1 >= 194 then charLen = 2
        end
        chars[#chars + 1] = string.sub(palabra, i, i + charLen - 1)
        i = i + charLen
    end

    local numChars = #chars
    if numChars == 0 then return silabas end

    -- Clasificar cada grafema: VA (Vocal Abierta), VC (Vocal Cerrada Átona), VT (Vocal Cerrada Tónica), C (Consonante)
    local tipos = {}
    for ci = 1, numChars do
        local ch = chars[ci]
        local chLow = string.lower(ch)
        if VOCALES_ABIERTAS[ch] or VOCALES_ABIERTAS[chLow] then
            tipos[ci] = "VA"
        elseif VOCALES_CERRADAS_TONICAS[ch] then
            tipos[ci] = "VT"
        elseif VOCALES_CERRADAS_ATONAS[ch] or VOCALES_CERRADAS_ATONAS[chLow] then
            tipos[ci] = "VC"
        else
            tipos[ci] = "C"
        end
    end

    -- Identificar posiciones donde se debe cortar la sílaba
    local cortarDespues = {}
    for ci = 1, numChars - 1 do
        cortarDespues[ci] = false
    end

    for ci = 1, numChars - 1 do
        local t1 = tipos[ci]
        local t2 = tipos[ci + 1]

        local esV1 = (t1 == "VA" or t1 == "VC" or t1 == "VT")
        local esV2 = (t2 == "VA" or t2 == "VC" or t2 == "VT")

        if esV1 and esV2 then
            -- Reglas de Diptongos e Hiatos entre dos vocales consecutivas:
            -- Hiato: Dos vocales abiertas (te-a-tro), o Abierta + Cerrada Tónica (ra-íz), o Cerrada Tónica + Abierta (dí-a)
            if (t1 == "VA" and t2 == "VA") or (t1 == "VA" and t2 == "VT") or (t1 == "VT" and t2 == "VA") or (t1 == "VT" and t2 == "VT") then
                cortarDespues[ci] = true
            end
        elseif esV1 and not esV2 then
            -- Una vocal seguida de una o más consonantes antes de la próxima vocal
            local nextVowelIdx = nil
            for k = ci + 1, numChars do
                if tipos[k] == "VA" or tipos[k] == "VC" or tipos[k] == "VT" then
                    nextVowelIdx = k
                    break
                end
            end

            if nextVowelIdx then
                local numCons = nextVowelIdx - ci - 1
                if numCons == 1 then
                    -- 1 consonante intervocálica: pasa a la siguiente sílaba (ca-sa)
                    cortarDespues[ci] = true
                elseif numCons == 2 then
                    -- 2 consonantes intervocálicas: revisar si forman grupo inseparable (tr, fl, dr, ch, rr, qu, gu...)
                    local pair = chars[ci + 1] .. chars[ci + 2]
                    local pairLow = string.lower(pair)
                    if CLUSTERS_INSEPARABLES[pair] or CLUSTERS_INSEPARABLES[pairLow] then
                        cortarDespues[ci] = true -- Ambas van con la segunda vocal (tra-ba-jo, fle-cha)
                    else
                        cortarDespues[ci + 1] = true -- Se dividen (al-to, cor-tar)
                    end
                elseif numCons == 3 then
                    -- 3 consonantes intervocálicas:
                    local pair = chars[ci + 2] .. chars[ci + 3]
                    local pairLow = string.lower(pair)
                    if CLUSTERS_INSEPARABLES[pair] or CLUSTERS_INSEPARABLES[pairLow] then
                        cortarDespues[ci + 1] = true -- 1ra va con 1ra vocal, 2da+3ra van con 2da vocal (es-plen-dor)
                    else
                        cortarDespues[ci + 2] = true -- 1ra+2da van con 1ra vocal, 3ra va con 2da vocal (cons-tan-te)
                    end
                elseif numCons >= 4 then
                    -- 4 consonantes intervocálicas: se dividen 2 y 2 (cons-truir)
                    cortarDespues[ci + 2] = true
                end
            end
        end
    end

    -- Construir las sílabas a partir de las marcas de corte
    local silabaActual = ""
    for ci = 1, numChars do
        silabaActual = silabaActual .. chars[ci]
        if cortarDespues[ci] then
            silabas[#silabas + 1] = silabaActual
            silabaActual = ""
        end
    end
    if silabaActual ~= "" then
        silabas[#silabas + 1] = silabaActual
    end

    if #silabas == 0 then
        silabas[1] = palabra
    end

    return silabas
end

--- Extraer sílabas soportando:
--- 1. Texto con guiones manuales (modo tradicional): "Can-ta-me_ u-na"
--- 2. Texto plano sin guiones (auto-tokenización): "Cántame una"
--- 3. JA (UTF-8 Kana/Romaji): caracteres individuales
--- Heurística de auto-silabificación para inglés (Optimizado en memoria)
local function silabificarIngles(palabra)
    local len = #palabra
    if len <= 3 then return { palabra } end

    local palabraLower = string.lower(palabra)
    local syllables = {}
    local chars = {}
    for i = 1, len do
        chars[i] = string.sub(palabra, i, i)
    end

    local tipos = {}
    local esVocal = { a=true, e=true, i=true, o=true, u=true, y=true }
    for i = 1, len do
        local c = string.lower(chars[i])
        if esVocal[c] then
            tipos[i] = "V"
        else
            tipos[i] = "C"
        end
    end

    -- 'e' muda al final de la palabra
    if string.sub(palabraLower, len, len) == "e" and len > 3 then
        local antepenultima = string.sub(palabraLower, len-1, len-1)
        if antepenultima ~= "l" then
            tipos[len] = "C"
        end
    end

    local cortarDespues = {}
    for i = 1, len do cortarDespues[i] = false end

    local i = 1
    while i < len do
        if tipos[i] == "V" then
            local nextVowelIdx = nil
            for k = i + 1, len do
                if tipos[k] == "V" then
                    nextVowelIdx = k
                    break
                end
            end

            if nextVowelIdx then
                local numCons = nextVowelIdx - i - 1
                if numCons == 1 then
                    cortarDespues[i] = true
                elseif numCons == 2 then
                    local pair = string.lower(chars[i+1] .. chars[i+2])
                    local digrafos = { th=true, ch=true, sh=true, ph=true, gh=true, ck=true }
                    if digrafos[pair] then
                        cortarDespues[i] = true
                    else
                        cortarDespues[i+1] = true
                    end
                elseif numCons >= 3 then
                    cortarDespues[i+1] = true
                end
                i = nextVowelIdx - 1
            end
        end
        i = i + 1
    end

    local currentSyl = ""
    for ci = 1, len do
        currentSyl = currentSyl .. chars[ci]
        if cortarDespues[ci] then
            syllables[#syllables + 1] = currentSyl
            currentSyl = ""
        end
    end
    if currentSyl ~= "" then
        syllables[#syllables + 1] = currentSyl
    end

    if #syllables == 0 then
        syllables[1] = palabra
    end

    return syllables
end

-- Tokenizador inteligente que agrupa bloques de fonemas /y aa/
local function dividirTextoEnPalabrasConFonemas(texto)
    local palabras = {}
    local startIdx = 1
    local len = #texto
    
    while startIdx <= len do
        local wordStart = string.find(texto, "%S", startIdx)
        if not wordStart then break end
        
        if string.sub(texto, wordStart, wordStart) == "/" then
            local nextSlash = string.find(texto, "/", wordStart + 1)
            if nextSlash then
                local token = string.sub(texto, wordStart, nextSlash)
                table.insert(palabras, token)
                startIdx = nextSlash + 1
            else
                local wordEnd = string.find(texto, "%s", wordStart + 1) or (len + 1)
                table.insert(palabras, string.sub(texto, wordStart, wordEnd - 1))
                startIdx = wordEnd
            end
        else
            local wordEnd = string.find(texto, "%s", wordStart + 1) or (len + 1)
            table.insert(palabras, string.sub(texto, wordStart, wordEnd - 1))
            startIdx = wordEnd
        end
    end
    
    return palabras
end

local function normalizarTextoParaLyrics(str)
    if not str then return "" end
    local s = str
    -- Normalizar vocales con tildes ortográficas en español (á, é, í, ó, ú, ü)
    s = string.gsub(s, "á", "a")
    s = string.gsub(s, "é", "e")
    s = string.gsub(s, "í", "i")
    s = string.gsub(s, "ó", "o")
    s = string.gsub(s, "ú", "u")
    s = string.gsub(s, "ü", "u")
    s = string.gsub(s, "Á", "a")
    s = string.gsub(s, "É", "e")
    s = string.gsub(s, "Í", "i")
    s = string.gsub(s, "Ó", "o")
    s = string.gsub(s, "Ú", "u")
    s = string.gsub(s, "Ü", "u")
    -- Convertir 'ñ' / 'Ñ' a 'ny' (estándar G2P del motor de Synthesizer V)
    s = string.gsub(s, "ñ", "ny")
    s = string.gsub(s, "Ñ", "ny")
    -- Mapeo directo por secuencias de bytes UTF-8
    s = string.gsub(s, "\195\161", "a")
    s = string.gsub(s, "\195\169", "e")
    s = string.gsub(s, "\195\173", "i")
    s = string.gsub(s, "\195\179", "o")
    s = string.gsub(s, "\195\186", "u")
    s = string.gsub(s, "\195\188", "u")
    s = string.gsub(s, "\195\177", "ny")
    s = string.gsub(s, "\195\145", "ny")
    return s
end

local function normalizarPuntuacionEspecial(txt)
    if not txt then return "" end
    local s = txt
    s = string.gsub(s, "\226\128\153", "'")  -- apostrofe derecho ’
    s = string.gsub(s, "\226\128\152", "'")  -- apostrofe izquierdo ‘
    s = string.gsub(s, "\226\128\156", '"')  -- comillas “
    s = string.gsub(s, "\226\128\157", '"')  -- comillas ”
    s = string.gsub(s, "\226\128\166", "...") -- puntos suspensivos …
    s = string.gsub(s, "\226\128\148", "-")  -- guion largo —
    s = string.gsub(s, "\226\128\147", "-")  -- guion corto –
    return s
end

local function esPalabraCJK(palabra)
    if string.find(palabra, "[a-zA-Z]") then
        return false
    end
    return string.find(palabra, "[\227-\233]") ~= nil
end

local function extraerSilabas(texto, idiomaIdx, separatorMode, separatorCustom, soloFonemas)
    local silabas = {}

    local textoNormalizado = normalizarPuntuacionEspecial(texto or "")
    if soloFonemas then
        for palabra in string.gmatch(textoNormalizado, "%S+") do
            silabas[#silabas + 1] = palabra
        end
        return silabas
    end
    local tieneSeparadores = false
    if separatorMode == nil or separatorMode == "auto" then
        textoNormalizado = string.gsub(textoNormalizado, "|", "-")
        tieneSeparadores = string.find(textoNormalizado, "%-") ~= nil
    elseif separatorMode == "pipe" then
        tieneSeparadores = string.find(textoNormalizado, "|", 1, true) ~= nil
    elseif separatorMode == "custom" and separatorCustom and separatorCustom ~= "" then
        tieneSeparadores = string.find(textoNormalizado, separatorCustom, 1, true) ~= nil
    else
        -- space mode: don't treat extra separators
        tieneSeparadores = false
    end

    if tieneSeparadores then
        local textoLimpio = textoNormalizado
        if separatorMode == nil or separatorMode == "auto" then
            textoLimpio = string.gsub(textoLimpio, "%-", " ")
        elseif separatorMode == "pipe" then
            textoLimpio = string.gsub(textoLimpio, "|", " ")
        elseif separatorMode == "custom" and separatorCustom and separatorCustom ~= "" then
            textoLimpio = string.gsub(textoLimpio, separatorCustom, " ")
        end
        for palabra in string.gmatch(textoLimpio, "%S+") do
            if esPalabraCJK(palabra) then
                for char in string.gmatch(palabra, "[%z\1-\127\194-\244][\128-\191]*") do
                    silabas[#silabas + 1] = char
                end
            else
                silabas[#silabas + 1] = palabra
            end
        end
    else
        local palabras = dividirTextoEnPalabrasConFonemas(textoNormalizado)
        for pi = 1, #palabras do
            local palabra = palabras[pi]
            -- Limpiar puntuación molesta pegada a palabras ("Leaving," -> "Leaving")
            local palabraSinPuntuacion = string.gsub(palabra, "^[%p%s]+", "")
            palabraSinPuntuacion = string.gsub(palabraSinPuntuacion, "[%p%s]+$", "")
            if palabraSinPuntuacion == "" then palabraSinPuntuacion = palabra end

            if palabra == "_" or palabra == "," or palabra == "." or palabra == "、" or palabra == "。" then
                silabas[#silabas + 1] = palabra
            elseif esPalabraCJK(palabraSinPuntuacion) then
                for char in string.gmatch(palabraSinPuntuacion, "[%z\1-\127\194-\244][\128-\191]*") do
                    silabas[#silabas + 1] = char
                end
            elseif idiomaIdx == 0 then
                local silabasPalabra = silabificarEspanol(palabraSinPuntuacion)
                for si = 1, #silabasPalabra do
                    silabas[#silabas + 1] = silabasPalabra[si]
                end
            elseif idiomaIdx == 1 then
                local palabraLower = string.lower(palabraSinPuntuacion)
                if EXCEPCIONES_SILABAS_EN[palabraLower] then
                    local exc = EXCEPCIONES_SILABAS_EN[palabraLower]
                    for ei = 1, #exc do
                        silabas[#silabas + 1] = exc[ei]
                    end
                else
                    -- Inglés: auto-silabificación basada en heurísticas
                    local silabasPalabra = silabificarIngles(palabraSinPuntuacion)
                    for si = 1, #silabasPalabra do
                        silabas[#silabas + 1] = silabasPalabra[si]
                    end
                end
            elseif idiomaIdx == 2 then
                -- Normalizar variantes comunes del teclado Romaji japonés (IME)
                local palabraNorm = normalizarRomajiJapones(palabraSinPuntuacion)
                if esPalabraCJK(palabraNorm) then
                    for char in string.gmatch(palabraNorm, "[%z\1-\127\194-\244][\128-\191]*") do
                        silabas[#silabas + 1] = char
                    end
                else
                    silabas[#silabas + 1] = palabraNorm
                end
            else
                silabas[#silabas + 1] = palabraSinPuntuacion
            end
        end

        -- Eliminar pausa final sobrante si existe
        if #silabas > 0 and silabas[#silabas] == "_" then
            silabas[#silabas] = nil
        end
    end

    -- Post-process: detect timing markers in form {+N} / {-N} (milliseconds relative)
    for i = 1, #silabas do
        local t = silabas[i]
        if type(t) == "string" then
            -- find patterns like {+120} or {-80}
            local offsetMs = string.match(t, "{([%+%-]?%d+)}")
            if offsetMs then
                local clean = string.gsub(t, "{[%+%-]?%d+}", "")
                clean = string.gsub(clean, "^%s+", "")
                clean = string.gsub(clean, "%s+$", "")
                silabas[i] = { text = (clean ~= "" and clean) or "", offsetMs = tonumber(offsetMs) }
            else
                -- also support {+120ms} or {+1.25s}
                local offMs2 = string.match(t, "{([%+%-]?%d+)%s*ms}")
                local offS = string.match(t, "{=?(%d+%.?%d*)s}")
                if offMs2 then
                    local clean = string.gsub(t, "{[%+%-]?%d+%s*ms}", "")
                    clean = string.gsub(clean, "^%s+", "")
                    clean = string.gsub(clean, "%s+$", "")
                    silabas[i] = { text = (clean ~= "" and clean) or "", offsetMs = tonumber(offMs2) }
                elseif offS then
                    local clean = string.gsub(t, "{=?%d+%.?%d*s}", "")
                    clean = string.gsub(clean, "^%s+", "")
                    clean = string.gsub(clean, "%s+$", "")
                    silabas[i] = { text = (clean ~= "" and clean) or "", offsetMs = tonumber(offS) * 1000 }
                end
            end
        end
    end

    return silabas
end

--- Convertir una sílaba española/latina a fonemas universales de Synthesizer V
local function convertirSilabaAFonemasEspanol(silaba)
    if not silaba or silaba == "" or silaba == "_" then return "" end
    local sLow = string.lower(silaba)

    if sLow == "aah" or sLow == "aa" or sLow == "ah" or sLow == "a" or sLow == "アー" then return "a" end
    if sLow == "ooo" or sLow == "oo" or sLow == "oh" or sLow == "o" or sLow == "オー" then return "o" end
    if sLow == "eee" or sLow == "ee" or sLow == "eh" or sLow == "e" or sLow == "イー" then return "e" end
    if sLow == "uuu" or sLow == "uu" or sLow == "ou" or sLow == "u" or sLow == "ウー" then return "u" end
    if sLow == "sanctus" or sLow == "san" then return "s a n" end
    if sLow == "ctus" or sLow == "tus" then return "k t u s" end
    if sLow == "glo" or sLow == "gloria" then return "g l o" end
    if sLow == "ria" then return "r i a" end
    if sLow == "al" then return "a l" end
    if sLow == "tu" then return "t u" end
    if sLow == "ras" then return "r a s" end
    if sLow == "co" then return "k o" end
    if sLow == "ro" then return "r o" end
    if sLow == "ce" then return "s e" end
    if sLow == "les" then return "l e s" end
    if sLow == "tial" then return "t i a l" end

    sLow = string.gsub(sLow, "que", "ke")
    sLow = string.gsub(sLow, "qui", "ki")
    sLow = string.gsub(sLow, "ca", "ka")
    sLow = string.gsub(sLow, "co", "ko")
    sLow = string.gsub(sLow, "cu", "ku")
    sLow = string.gsub(sLow, "ce", "se")
    sLow = string.gsub(sLow, "ci", "si")
    sLow = string.gsub(sLow, "za", "sa")
    sLow = string.gsub(sLow, "zo", "so")
    sLow = string.gsub(sLow, "zu", "su")
    sLow = string.gsub(sLow, "ga", "ga")
    sLow = string.gsub(sLow, "gue", "ge")
    sLow = string.gsub(sLow, "gui", "gi")
    sLow = string.gsub(sLow, "ja", "ha")
    sLow = string.gsub(sLow, "je", "he")
    sLow = string.gsub(sLow, "ji", "hi")
    sLow = string.gsub(sLow, "jo", "ho")
    sLow = string.gsub(sLow, "ju", "hu")
    sLow = string.gsub(sLow, "ll", "y")
    sLow = string.gsub(sLow, "ñ", "ny")
    sLow = string.gsub(sLow, "v", "b")

    local fonemas = ""
    local len = #sLow
    for i = 1, len do
        local c = string.sub(sLow, i, i)
        if c >= "a" and c <= "z" then
            if fonemas == "" then
                fonemas = c
            else
                fonemas = fonemas .. " " .. c
            end
        end
    end

    return fonemas
end

local function msToBlicks(ms, timeAxis)
    -- Convert ms (milliseconds) to blicks using current BPM/timeAxis
    if not timeAxis or not ms then return 0 end
    local bpm = 120.0
    local marks = timeAxis:getAllTempoMarks()
    if marks and #marks > 0 then
        -- use first mark as approximate BPM
        if marks[1] and marks[1].bpm then bpm = marks[1].bpm end
    end
    -- 1 minute = 60000 ms; quarter note duration in blicks is SV.QUARTER
    local msPerQuarter = 60000.0 / bpm
    local blicks = (ms / msPerQuarter) * SV.QUARTER
    return math.floor(blicks + 0.5)
end

local function generarNotasDesdeTexto(letraRaw, basePitch, stepBlickBase, modoMelodiaIdx, escalaIdx, modoRitmoIdx, idiomaIdx, noteGroup, reproductor, rangoMin, rangoMax, timeAxis, separatorMode, separatorCustom, soloFonemas, startBlickOverride)
    local silabas = extraerSilabas(letraRaw, idiomaIdx, separatorMode, separatorCustom, soloFonemas)
    local numSilabas = #silabas
    if numSilabas == 0 then
        return {}
    end

    rangoMin = rangoMin or 36
    rangoMax = rangoMax or 84

    local esPregunta = (string.find(letraRaw, "%?") ~= nil or string.find(letraRaw, "¿") ~= nil)
    local esExclamacion = (string.find(letraRaw, "!") ~= nil or string.find(letraRaw, "¡") ~= nil)

    local escala = ESCALAS[escalaIdx] or ESCALAS[0]
    local numNotasEscala = #escala
    local currentBlick = startBlickOverride or reproductor:getPlayhead()
    local notasCreadas = {}
    local pitchPrevio = basePitch
    _G.prevImprovGrado = 1
    _G.lastLeapDirection = 0

    local totalCantadas = 0
    for i = 1, numSilabas do
        local s = silabas[i]
        if s ~= "_" and s ~= "," and s ~= "." and s ~= "、" and s ~= "。" then
            totalCantadas = totalCantadas + 1
        end
    end

    local indiceNota = 0

    for i = 1, numSilabas do
        local token = silabas[i]
        local explicitOffsetBlick = nil
        if type(token) == "table" and token.offsetMs then
            explicitOffsetBlick = msToBlicks(token.offsetMs, timeAxis)
            -- if token.text is empty, treat as pause of that offset
            token = token.text
        end

        -- Silencio o pausa (_, ,, ., 、, 。)
        if token == "_" or token == "," or token == "." or token == "、" or token == "。" then
            currentBlick = currentBlick + stepBlickBase
        elseif token == "\\" or token == "\\\\" or token == "v" or token == "vv" or token == "^" or token == "^^" or token == "+" or token == "++" then
            -- Modificador de inflexión de tono independiente (aplica a la nota previa sin crear una nueva nota en el piano roll)
            if #notasCreadas > 0 then
                local notaPrev = notasCreadas[#notasCreadas]
                local deltaInflection = (token == "\\\\" or token == "vv" or token == "++" or token == "^^") and 4 or 2
                if token == "\\" or token == "\\\\" or token == "v" or token == "vv" then
                    deltaInflection = -deltaInflection
                end
                notaPrev:setPitch(limitarValor(notaPrev:getPitch() + deltaInflection, rangoMin, rangoMax))
            end
        else
            indiceNota = indiceNota + 1

            -- Determinar si el token es un fonema explícito (/fonema/)
            local letraLimpia = tostring(token or ""):gsub("^%s*(.-)%s*$", "%1")
            
            local esFonemaExplicito = false
            local fonemasLimpios = ""
            
            if string.sub(letraLimpia, 1, 1) == "/" and string.sub(letraLimpia, -1, -1) == "/" then
                esFonemaExplicito = true
                fonemasLimpios = string.sub(letraLimpia, 2, -2)
                letraLimpia = "." -- placeholder de Synthesizer V para fonemas explícitos
            else
                -- Limpiar modificadores de control de la letra de la nota (evita que \, v, ~, ^ leaqueen al Piano Roll)
                letraLimpia = string.gsub(letraLimpia, "\\+$", "")
                letraLimpia = string.gsub(letraLimpia, "v+$", "")
                letraLimpia = string.gsub(letraLimpia, "%^+$", "")
                letraLimpia = string.gsub(letraLimpia, "%++$", "")
                letraLimpia = string.gsub(letraLimpia, "%-+$", "")
                letraLimpia = string.gsub(letraLimpia, "~+", "")
                letraLimpia = string.gsub(letraLimpia, "%[[^%]]+%]", "")
            end

            if letraLimpia == "" then letraLimpia = "la" end

            local aplicarChopsFX = (soloFonemas == true) or esFonemaExplicito

            -- Analizar prosodia por idioma
            local deltaPitchProsodico, multDurProsodico, esTonica = analizarProsodiaSilaba(token, idiomaIdx, indiceNota, totalCantadas, esPregunta, esExclamacion)

            -- Modulador Rítmico de Duración (optimizado para canto fluido humano)
            local multRitmo = 1.0
            if modoRitmoIdx == 0 then -- Pop Sincopado
                if (indiceNota % 4 == 1) then multRitmo = 1.25
                elseif (indiceNota % 4 == 2) then multRitmo = 0.90
                elseif (indiceNota % 4 == 3) then multRitmo = 1.10
                else multRitmo = 0.85 end
            elseif modoRitmoIdx == 1 then -- Micro-Chop Kinético (Breakcore / Glitchcore)
                if (indiceNota % 3 == 0) then multRitmo = 0.35 -- 1/32 chop
                elseif (indiceNota % 2 == 0) then multRitmo = 0.60 -- 1/16 chop
                else multRitmo = 0.85 end
            elseif modoRitmoIdx == 2 then -- Legato Emotivo Swell (Artcore / Trance)
                if (indiceNota % 2 == 1) then multRitmo = 1.80
                else multRitmo = 1.40 end
            elseif modoRitmoIdx == 3 then -- Driving Hardcore (Gabber / Rock)
                if (indiceNota % 3 == 0) then multRitmo = 0.80 -- Tresillo
                else multRitmo = 0.90 end
            end

            -- Duración extendida por tildes explicitas (~)
            local numTildes = 0
            for _ in string.gmatch(token, "~") do
                numTildes = numTildes + 1
            end
            if numTildes > 0 then
                multRitmo = multRitmo * (1 + numTildes)
                token = string.gsub(token, "~", "")
            end

            local minDurBlick = aplicarChopsFX and math.floor(SV.QUARTER / 16) or math.floor(SV.QUARTER * 0.65)
            local durBlick = math.max(minDurBlick, math.floor(stepBlickBase * multDurProsodico * multRitmo))
            local pitchTarget = nil

            -- Pitch explícito [C4], [G4], etc.
            local notaExp = string.match(token, "%[([A-Ga-g][#b]?%d+)%]")
            if notaExp then
                pitchTarget = notaStringAMidi(notaExp)
                token = string.gsub(token, "%[[^%]]+%]", "")
            end

            -- Offset explícito [+N] o [-N]
            if not pitchTarget then
                local offNum = string.match(token, "%[([+-]?%d+)%]")
                if offNum then
                    pitchTarget = pitchPrevio + tonumber(offNum)
                    token = string.gsub(token, "%[[^%]]+%]", "")
                end
            end

            -- Símbolos de inflexión (\, \\, v, vv, ^, ^^, +, ++)
            if not pitchTarget then
                if string.find(token, "\\\\") or string.find(token, "vv$") or string.find(token, "%^%^") or string.find(token, "%+%+") then
                    local isDown = string.find(token, "\\\\") or string.find(token, "vv$")
                    pitchTarget = pitchPrevio + (isDown and -4 or 4)
                elseif string.find(token, "\\") or string.find(token, "v$") or string.find(token, "%^") or string.find(token, "%+") then
                    local isDown = string.find(token, "\\") or string.find(token, "v$")
                    pitchTarget = pitchPrevio + (isDown and -2 or 2)
                elseif string.find(token, "%-%-") then
                    pitchTarget = pitchPrevio - 4
                elseif string.find(token, "%-") then
                    pitchTarget = pitchPrevio - 2
                end
            end

            -- Generador Melódico Prosódico Avanzado
            if not pitchTarget then
                if modoMelodiaIdx == 0 then
                    -- Generador de Arco Vocal Prosódico Humano (Orgánico y Expresivo)
                    -- Crea un arco melódico natural que asciende hacia un pico y desciende suavemente a la tónica
                    local escala = ESCALAS[escalaIdx] or ESCALAS[2]
                    local numGrados = #escala
                    
                    local progresoFrase = (indiceNota - 1) / math.max(1, totalCantadas - 1)
                    local formaArco = math.sin(progresoFrase * math.pi) * 7.0 -- Arco de hasta 7 semitonos
                    
                    -- Adicionar variación orgánicamente
                    local microOffset = (math.sin(indiceNota * 1.3) * 2.0) + deltaPitchProsodico
                    local pitchCalculado = basePitch + math.floor(formaArco + microOffset + 0.5)
                    
                    pitchTarget = pitchCalculado
                elseif modoMelodiaIdx == 1 then
                    -- Pentatónico Expresivo con Saltos de 4tas y 5tas
                    local idxEscala = ((indiceNota - 1) % numNotasEscala) + 1
                    local saltoOctava = (indiceNota % 5 == 0) and 12 or 0
                    pitchTarget = basePitch + escala[idxEscala] + saltoOctava + deltaPitchProsodico
                elseif modoMelodiaIdx == 2 then
                    -- Onda Armónica Fluida
                    local deltaOnda = math.sin(indiceNota * 0.7) * 5.0
                    pitchTarget = basePitch + math.floor(deltaOnda + deltaPitchProsodico + 0.5)
                elseif modoMelodiaIdx == 3 then
                    -- Cromático Glitch / Caótico (Breakcore / Dark Ambient)
                    local saltoGlitch = ((indiceNota * 7) % 13) - 6
                    pitchTarget = basePitch + saltoGlitch
                elseif modoMelodiaIdx == 5 then
                    -- Arpegio Ascendente Paramétrico
                    local numOctavasPosibles = math.floor((rangoMax - rangoMin) / 12)
                    local noteInOctaveIdx = ((indiceNota - 1) % numNotasEscala) + 1
                    local octaveOffsetIdx = math.floor((indiceNota - 1) / numNotasEscala) % (numOctavasPosibles + 1)
                    pitchTarget = rangoMin + escala[noteInOctaveIdx] + (octaveOffsetIdx * 12)
                elseif modoMelodiaIdx == 6 then
                    -- Arpegio Descendente Paramétrico
                    local numOctavasPosibles = math.floor((rangoMax - rangoMin) / 12)
                    local noteInOctaveIdx = numNotasEscala - ((indiceNota - 1) % numNotasEscala)
                    local octaveOffsetIdx = numOctavasPosibles - (math.floor((indiceNota - 1) / numNotasEscala) % (numOctavasPosibles + 1))
                    pitchTarget = rangoMin + escala[noteInOctaveIdx] + (octaveOffsetIdx * 12)
                elseif modoMelodiaIdx == 7 then
                    -- Paso de Escala Aleatorio
                    local deltaStep = math.random(-2, 2)
                    pitchTarget = pitchPrevio + deltaStep
                elseif modoMelodiaIdx == 8 then
                    -- Movimiento por Saltos de Consonancia (3ra, 4ta, 5ta)
                    local consonancias = { 3, 4, 5, 7, -3, -4, -5, -7 }
                    local salto = consonancias[math.random(1, #consonancias)]
                    pitchTarget = pitchPrevio + salto
                else
                    -- Modo 4: Plano Expresivo (sin melodía, solo prosodia sutil)
                    pitchTarget = basePitch + deltaPitchProsodico
                end
            end

            -- Cuantizar y forzar límites de rango
            local pitchFinal = cuantizarAEscala(pitchTarget, basePitch, escala)
            if pitchFinal < rangoMin then
                pitchFinal = rangoMin + ((pitchFinal - rangoMin) % 12)
            elseif pitchFinal > rangoMax then
                pitchFinal = rangoMax - (math.abs(rangoMax - pitchFinal) % 12)
            end

            -- Si es chop o fonema explicito, recortar la duracion de la nota al 50% para crear silencios (staccato)
            local activeDurBlick = durBlick
            if aplicarChopsFX then
                activeDurBlick = math.max(math.floor(SV.QUARTER / 32), math.floor(durBlick * 0.5))
            end

            local nuevaNota = SV:create("Note")
            nuevaNota:setTimeRange(currentBlick, activeDurBlick)
            nuevaNota:setPitch(pitchFinal)

            -- Eliminar vibrato y oscilaciones para lograr chops limpios y definidos (estilo Artcore/Glitch)
            if aplicarChopsFX then
                nuevaNota:setAttributes({
                    dF0Vbr = 0.0,
                    dF0VbrMod = 0.0
                })
            end

            -- Aplicar compuerta de volumen (Gate) estricta para forzar silencio en los huecos (evitar release AI)
            if aplicarChopsFX then
                local loudness = noteGroup:getParameter("loudness")
                if loudness then
                    local sigBlick = explicitOffsetBlick or durBlick
                    loudness:remove(currentBlick, currentBlick + sigBlick)
                    
                    loudness:add(currentBlick, 0.0)
                    loudness:add(currentBlick + activeDurBlick - 1, 0.0)
                    loudness:add(currentBlick + activeDurBlick, -48.0)
                    loudness:add(currentBlick + sigBlick - 1, -48.0)
                end
            end

            if not esFonemaExplicito then
                letraLimpia = normalizarTextoParaLyrics(letraLimpia)
            end
            nuevaNota:setLyrics(letraLimpia)
            if esFonemaExplicito then
                nuevaNota:setPhonemes(fonemasLimpios)
            end

            if esTonica and idiomaIdx == 0 then
                -- Prosodia RAE de tildes (+20 cents de pitch y +15% de tensión en la nota)
                local pitchDelta = noteGroup:getParameter("pitchDelta")
                if pitchDelta then
                    pitchDelta:remove(currentBlick, currentBlick + activeDurBlick)
                    pitchDelta:add(currentBlick, 20.0)
                    pitchDelta:add(currentBlick + activeDurBlick - 1, 20.0)
                    pitchDelta:add(currentBlick + activeDurBlick, 0.0)
                end
                local tension = noteGroup:getParameter("tension")
                if tension then
                    tension:remove(currentBlick, currentBlick + activeDurBlick)
                    tension:add(currentBlick, 0.15)
                    tension:add(currentBlick + activeDurBlick - 1, 0.15)
                    tension:add(currentBlick + activeDurBlick, 0.0)
                end
            end

            noteGroup:addNote(nuevaNota)
            notasCreadas[#notasCreadas + 1] = nuevaNota

            pitchPrevio = pitchFinal
            if explicitOffsetBlick then
                currentBlick = currentBlick + explicitOffsetBlick
            else
                currentBlick = currentBlick + durBlick
            end
        end
    end

    return notasCreadas
end
-- ============================================================================
-- MÓDULO 4: MOTOR DE AUTOMATIZACIÓN E INTERPOLACIÓN HERMITE (LOW GC ALLOC)
-- ============================================================================

-- limitarValor removido (definido en Tokenizer_MelodyGen.lua)

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

-- obtenerTempoEnBlick removido (definido en Tokenizer_MelodyGen.lua)

local function factorTempo(bpm)
    if bpm <= 0.0 then return 1.0 end
    return 120.0 / bpm
end

local function aplicarPortamentoSCurve(pitchDeltaParam, onset, duration, saltoSemitonos, factorIntensidad, mergeMode)
    if not pitchDeltaParam or math.abs(saltoSemitonos) < 2 then return end

    -- Portamento natural sutil (máximo 80 cents para evitar saltos antinaturales de octava)
    local signo = (saltoSemitonos > 0) and -1.0 or 1.0
    local valInitial = signo * math.min(80.0, math.abs(saltoSemitonos) * 15.0) * factorIntensidad
    valInitial = limitarValor(valInitial, -100.0, 100.0)

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

--- Cálculo de desviación de registro (Pitch Height Scaling)
local function calcularFactorRegistro(pitchMidi, basePitch, pitchSens, factorUI)
    if not pitchMidi then return 0.0 end
    local deltaOctaves = (pitchMidi - (basePitch or 60)) / 12.0
    local sens = pitchSens or 0.5
    local uiMult = factorUI or 1.0
    return limitarValor(deltaOctaves * 0.25 * sens * uiMult, -1.0, 1.0)
end

--- Cálculo de modulación por fonema (Phoneme-Class Awareness)
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

--- Jitter de humanización orgánico y determinista
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
