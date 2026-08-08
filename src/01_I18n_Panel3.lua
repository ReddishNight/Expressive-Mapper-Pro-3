--[[
  Expressive Panel 3 (Vocal Harmonies) Localization Dictionary
--]]

local I18N_DATA = {
    [0] = { -- Español
        title = "Mapeador Expresivo Pro 3",
        autoDetectKeyLabel = "Auto-detectar Tonalidad (Krumhansl)",
        tonicaLabel = "Tónica de la Escala (Root)",
        escalaLabel = "Escala Armónica",
        modoArmoniaLabel = "9. Tipo de Armonía Vocal",
        modoArmoniaChoices = {
            "Tercera Arriba (Dúo)",
            "Tercera Abajo (Dúo)",
            "Quinta Arriba (Dúo)",
            "Sexta Arriba (Dúo)",
            "Octava Abajo",
            "Presets Corales Multi-voz",
            "Intervalo Personalizado"
        },
        presetCoralLabel = "10. Preset Coral",
        presetCoralChoices = {
            "Dúo 3ras Superiores",
            "Dúo 3ras Inferiores",
            "Trío Pop (3ras y 5tas)",
            "Cuarteto Coral SATB",
            "Power Duo (5tas y 8vas)",
            "Coro Unísono Anti-fase"
        },
        antiFaseMsLabel = "11. Delay de Anti-fase (ms)",
        antiFaseCentsLabel = "12. Detune de Anti-fase (cents)",
        armoniaIntervalosCustomLabel = "Intervalos Personalizados",
        enableJustIntonation = "Entonación Justa (Just Intonation)",
        errContextTitle = "Error de Contexto",
        errContextMsg = "Por favor, selecciona una pista activa en el editor antes de ejecutar.",
        errNoNotesTitle = "Error de Estructura",
        errNoNotesMsg = "No se encontraron grupos o notas válidas para procesar.",
        confirmTitle = "Confirmar Operación",
        confirmMsgArmonia = "¿Deseas generar armonía vocal (%s) sobre las notas existentes?",
        completedTitle = "Mapeador Expresivo Pro 3",
        completedMsg = "(≧◡≦)",
        vistaSeccionChoices = {
            "Modo Rápido (EasyLyric & Melodía)",
            "Expresión Vocal (Curvas Hermite)",
            "Armonías Vocales (Coros SATB)",
            "Acordes & Contrapunto Algorítmico"
        },
        escalaChoices = {
            "Pentatónica Mayor",
            "Pentatónica Menor",
            "Mayor Natural (Jónica)",
            "Menor Natural (Eólica)",
            "Menor Armónica",
            "Menor Melódica",
            "Dórica",
            "Frigia",
            "Lidia",
            "Mixolidia",
            "Locria",
            "Blues",
            "Cromática",
            "Menor Húngara",
            "Doble Armónica (Bizantina)"
        },
        tonicaChoices = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" },
        applyButtonLabel = "Aplicar",
        trackHarmName = "Armonía %s"
    },
    [1] = { -- English
        title = "Expressive Mapper Pro 3",
        autoDetectKeyLabel = "Auto-Detect Key (Krumhansl)",
        tonicaLabel = "Scale Tonic (Root Note)",
        escalaLabel = "Harmonic Scale",
        modoArmoniaLabel = "9. Vocal Harmony Type",
        modoArmoniaChoices = {
            "Third Above (Duet)",
            "Third Below (Duet)",
            "Fifth Above (Duet)",
            "Sixth Above (Duet)",
            "Octave Below",
            "Multi-voice Choir Presets",
            "Custom Interval"
        },
        presetCoralLabel = "10. Choir Preset",
        presetCoralChoices = {
            "Upper 3rds Duet",
            "Lower 3rds Duet",
            "Pop Trio (3rds & 5ths)",
            "SATB Choir Quartet",
            "Power Duo (5ths & 8ths)",
            "Anti-phase Unison Choir"
        },
        antiFaseMsLabel = "11. Anti-phase Delay (ms)",
        antiFaseCentsLabel = "12. Anti-phase Detune (cents)",
        armoniaIntervalosCustomLabel = "Custom Intervals",
        enableJustIntonation = "Enable Just Intonation",
        errContextTitle = "Context Error",
        errContextMsg = "Please select an active track in the editor before running.",
        errNoNotesTitle = "Structure Error",
        errNoNotesMsg = "No valid groups or notes found to process.",
        confirmTitle = "Confirm Operation",
        confirmMsgArmonia = "Do you want to generate vocal harmony (%s) over the existing notes?",
        completedTitle = "Expressive Mapper Pro 3",
        completedMsg = "(≧◡≦)",
        vistaSeccionChoices = {
            "Quick Mode (EasyLyric & Melody)",
            "Vocal Expression (Hermite Curves)",
            "Vocal Harmonies (SATB Choir)",
            "Chords & Algorithmic Counterpoint"
        },
        escalaChoices = {
            "Major Pentatonic",
            "Minor Pentatonic",
            "Natural Major (Ionian)",
            "Natural Minor (Aeolian)",
            "Harmonic Minor",
            "Melodic Minor",
            "Dorian",
            "Phrygian",
            "Lydian",
            "Mixolydian",
            "Locrian",
            "Blues",
            "Chromatic",
            "Hungarian Minor",
            "Double Harmonic (Byzantine)"
        },
        tonicaChoices = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" },
        applyButtonLabel = "Apply",
        trackHarmName = "Harmony %s"
    },
    [2] = { -- Japanese
        title = "表現力マッパー Pro 3",
        autoDetectKeyLabel = "キー自動検出 (Krumhansl)",
        tonicaLabel = "主音 (ルート音)",
        escalaLabel = "調性スケール",
        modoArmoniaLabel = "9. ハーモニーの種類",
        modoArmoniaChoices = {
            "3度上 (デュエット)",
            "3度下 (デュエット)",
            "5度上 (デュエット)",
            "6度上 (デュエット)",
            "オクターブ下",
            "マルチボイス合唱プリセット",
            "カスタム音程"
        },
        presetCoralLabel = "10. 合唱プリセット",
        presetCoralChoices = {
            "上部3度デュエット",
            "下部3度デュエット",
            "ポップス三重唱 (3度 & 5度)",
            "SATB混声四部合唱",
            "パワーデュオ (5度 & 8度)",
            "逆相ユニゾンコーラス"
        },
        antiFaseMsLabel = "11. 逆相ディレイ (ms)",
        antiFaseCentsLabel = "12. 逆相デチューン (cents)",
        armoniaIntervalosCustomLabel = "カスタム音程設定",
        enableJustIntonation = "純正律を有効化",
        errContextTitle = "コンテキストエラー",
        errContextMsg = "実行する前にエディタでアクティブなトラックを選択してください。",
        errNoNotesTitle = "構造エラー",
        errNoNotesMsg = "処理対象の有効なグループまたはノートが見つかりません。",
        confirmTitle = "操作の確認",
        confirmMsgArmonia = "既存のノートに対してハーモニー（%s）を生成しますか？",
        completedTitle = "表現力マッパー Pro 3",
        completedMsg = "(≧◡≦)",
        vistaSeccionChoices = {
            "クイックモード (EasyLyric & メロディ)",
            "ボーカル表現 (エルミート曲線)",
            "ボーカルハーモニー (SATBコーラス)",
            "コード & アルゴリズム対位法"
        },
        escalaChoices = {
            "メジャーペンタトニック",
            "マイナーペンタトニック",
            "自然長音階 (アイオニアン)",
            "自然短音階 (エオリアン)",
            "和声的短音階",
            "旋律的短音階",
            "ドリアン",
            "フリジアン",
            "リディアン",
            "ミクソリディアン",
            "ロクリアン",
            "ブルース",
            "クロマチック",
            "ハンガリー短音階",
            "ダブルハーモニック (ビザンチン)"
        },
        tonicaChoices = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" },
        applyButtonLabel = "適用",
        trackHarmName = "ハーモニー %s"
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
