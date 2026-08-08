--[[
  Expressive Panel 2 (Vocal Expression) Localization Dictionary
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
        intensidadLabel = "3. Intensidad del Efecto (%)",
        densityLabel = "4. Resolución del Spline",
        densityChoices = {
            "Smart Spline (Adaptativo)",
            "Ultra Alta (1/64 de compás)",
            "Alta (1/32 de compás)",
            "Estándar (1/16 de compás)",
            "Media (1/8 de compás)",
            "Baja (1/4 de compás)",
            "Solo Nodos Clave",
            "Paso de Fonema"
        },
        customTensionLabel = "Tensión Personalizada",
        customBreathLabel = "Tensión de Aire",
        customVolumeLabel = "Volumen Personalizado (dB)",
        customGenderLabel = "Género / Formante",
        customVoicingLabel = "Voicing / Fonación",
        customTimbreLabel = "Timbre / Color",
        mergeModeLabel = "Modo Fusión (No Destructivo)",
        limpiarPreviosLabel = "Limpiar automatizaciones previas",
        errContextTitle = "Error de Contexto",
        errContextMsg = "Por favor, selecciona una pista activa en el editor antes de ejecutar.",
        errNoNotesTitle = "Error de Estructura",
        errNoNotesMsg = "No se encontraron grupos o notas válidas para procesar.",
        confirmTitle = "Confirmar Operación",
        confirmMsgExpresar = "¿Deseas aplicar la expresividad del preset '%s' al %d%% sobre las notas seleccionadas?",
        completedTitle = "Mapeador Expresivo Pro 3",
        completedMsg = "¡Operación completada exitosamente!\nÍtems procesados/creados: %d\nPreset/Config: %s\nIntensidad: %d%%\nGrupos/Pistas procesados: %d\nDeshacer Atómico registrado (Ctrl+Z para revertir).",
        vistaSeccionChoices = {
            "Modo Rápido (EasyLyric & Melodía)",
            "Expresión Vocal (Curvas Hermite)",
            "Armonías Vocales (Coros SATB)",
            "Acordes & Contrapunto Algorítmico"
        }
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
        intensidadLabel = "3. Effect Intensity (%)",
        densityLabel = "4. Spline Resolution",
        densityChoices = {
            "Smart Spline (Adaptive)",
            "Ultra High (1/64 measure)",
            "High (1/32 measure)",
            "Standard (1/16 measure)",
            "Medium (1/8 measure)",
            "Low (1/4 measure)",
            "Key Nodes Only",
            "Phoneme Step"
        },
        customTensionLabel = "Custom Tension",
        customBreathLabel = "Custom Breathiness",
        customVolumeLabel = "Custom Volume (dB)",
        customGenderLabel = "Custom Gender/Formant",
        customVoicingLabel = "Custom Voicing",
        customTimbreLabel = "Custom Timbre",
        mergeModeLabel = "Merge Mode (Non-Destructive)",
        limpiarPreviosLabel = "Clear Previous Automations",
        errContextTitle = "Context Error",
        errContextMsg = "Please select an active track in the editor before running.",
        errNoNotesTitle = "Structure Error",
        errNoNotesMsg = "No valid groups or notes found to process.",
        errNoSyllablesTitle = "Notice",
        errNoSyllablesMsg = "No valid syllables entered for generation.",
        confirmTitle = "Confirm Operation",
        confirmMsgExpresar = "Do you want to apply the expression preset '%s' at %d%% to the selected notes?",
        completedTitle = "Expressive Mapper Pro 3",
        completedMsg = "Operation completed successfully.\nItems processed/created: %d\nPreset/Config: %s\nIntensity: %d%%\nGroups/Tracks processed: %d\nAtomic undo registered (Ctrl+Z to revert).",
        vistaSeccionChoices = {
            "Quick Mode (EasyLyric & Melody)",
            "Vocal Expression (Hermite Curves)",
            "Vocal Harmonies (SATB Choir)",
            "Chords & Algorithmic Counterpoint"
        }
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
        intensidadLabel = "3. エフェクト強度 (%)",
        densityLabel = "4. スプライン解像度",
        densityChoices = {
            "スマートスプライン (適応型)",
            "極高 (1/64 小節)",
            "高 (1/32 小節)",
            "標準 (1/16 小節)",
            "中 (1/8 小節)",
            "低 (1/4 小節)",
            "キーノードのみ",
            "音素ステップ"
        },
        customTensionLabel = "カスタムテンション",
        customBreathLabel = "カスタムブレス",
        customVolumeLabel = "カスタムボリューム (dB)",
        customGenderLabel = "カスタムジェンダー",
        customVoicingLabel = "カスタムボイシング",
        customTimbreLabel = "カスタムティンバー",
        mergeModeLabel = "マージモード (非破壊)",
        limpiarPreviosLabel = "範囲内の既存オートメーションを消去",
        errContextTitle = "コンテキストエラー",
        errContextMsg = "実行する前にエディタでアクティブなトラックを選択してください。",
        errNoNotesTitle = "構造エラー",
        errNoNotesMsg = "処理対象の有効なグループまたはノートが見つかりません。",
        confirmTitle = "操作の確認",
        confirmMsgExpresar = "選択したノートに対してプリセット'%s'（%d%%）で表現力オートメーションを適用しますか？",
        completedTitle = "表現力マッパー Pro 3",
        completedMsg = "処理が正常に完了しました！\n処理/生成アイテム数: %d\nプリセット/設定: %s\n強度: %d%%\n処理グループ/トラック数: %d\nAtomic Undo 登録完了（Ctrl+Z で元に戻せます）。",
        vistaSeccionChoices = {
            "クイックモード (EasyLyric & メロディ)",
            "ボーカル表現 (エルミート曲線)",
            "ボーカルハーモニー (SATBコーラス)",
            "コード & アルゴリズム対位法"
        }
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
