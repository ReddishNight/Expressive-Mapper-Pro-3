--[[
  Expressive Panel 4 (Chords & Counterpoint) Localization Dictionary
--]]

local I18N_DATA = {
    [0] = { -- Español
        title = "Mapeador Expresivo Pro 3",
        especieContrapuntoLabel = "13. Especie del Contrapunto",
        especieContrapuntoChoices = {
            "1ra Especie (Nota contra nota - 1:1)",
            "2da Especie (2 notas contra 1 - 2:1)",
            "3ra Especie (4 notas contra 1 - 4:1)",
            "4ta Especie (Síncopas / Retardos - Suspensiones)",
            "5ta Especie (Florido / Mixto - Ornamentado)",
            "Contrapunto Libre (Rítmico / Improv)"
        },
        progresionAcordesLabel = "14. Estilo de Progresión",
        progresionAcordesChoices = {
            "1. J-Pop / Anime Royal (IVmaj7 - V7 - iii7 - vi)",
            "2. Pop / EDM Anthem (Iadd9 - V - vi7 - IVmaj7)",
            "3. Neo-Soul / R&B Lounge (ii9 - V13 - Imaj9 - VI7alt)",
            "4. Jazz Cadencia 2-5-1 (ii7 - V7 - Imaj7 - VI7)",
            "5. Dark Ambient Horror (i - bVI - bIII - bVII)",
            "6. Artcore / Breakcore Kinetic (iv7 - v7 - i9 - VImaj7)",
            "7. City Pop / 80s Funk (IVmaj7 - III7 - vi7 - II7)",
            "8. Math Rock / Midwest Emo (Iadd9 - IVmaj7 - vi7 - V6)",
            "9. Future Bass / Kawaii Chords (IVmaj9 - V6/9 - iii7 - vi9)",
            "10. Lo-Fi Chill Hop (Imaj7 - VI7 - ii7 - V7alt)",
            "11. Cyberpunk Midtempo Dystopia (i - bII - i - bVI)",
            "12. Orquestal Dramático Swell (i - iv7 - V7 - i)",
            "13. Gospel / Soul Elevación (I - I7 - IV - iv6)",
            "14. Gabber / Hardstyle Stabs (i - bVI - bVII - i)",
            "15. Chiptune / 8-Bit Heroico (I - bVII - bVI - V7)",
            "16. Uplifting Trance Pad (vi7 - IVmaj7 - I - V)"
        },
        ritmoAcordesLabel = "15. Ritmo del Acompañamiento",
        ritmoAcordesChoices = {
            "1. Pad Sustenido (Legato)",
            "2. Acompañamiento Síncopado (Negras - 1/4)",
            "3. Arpegio Fluido Cascadas (Corcheas - 1/8)",
            "4. Chop Electrónico Kinético (Semicorcheas - 1/16)",
            "5. Bajo + Rasgueo Alternado"
        },
        errContextTitle = "Error de Contexto",
        errContextMsg = "Por favor, selecciona una pista activa en el editor antes de ejecutar.",
        errNoNotesTitle = "Error de Estructura",
        errNoNotesMsg = "No se encontraron grupos o notas válidas para procesar.",
        confirmTitle = "Confirmar Operación",
        confirmMsgContrapunto = "¿Deseas generar una contramelodía (%s) en una pista nueva?",
        confirmMsgProgresion = "¿Deseas generar una progresión de acordes (%s)?",
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
        especieContrapuntoLabel = "13. Counterpoint Species",
        especieContrapuntoChoices = {
            "1st Species (Note against note - 1:1)",
            "2nd Species (2 notes against 1 - 2:1)",
            "3rd Species (4 notes against 1 - 4:1)",
            "4th Species (Suspensions / Syncopations)",
            "5th Species (Florid / Mixed Counterpoint)",
            "Free Counterpoint (Rhythmic / Improv)"
        },
        progresionAcordesLabel = "14. Progression Style",
        progresionAcordesChoices = {
            "1. Royal J-Pop / Anime (IVmaj7 - V7 - iii7 - vi)",
            "2. Pop / EDM Anthem (Iadd9 - V - vi7 - IVmaj7)",
            "3. Neo-Soul / R&B Lounge (ii9 - V13 - Imaj9 - VI7alt)",
            "4. Jazz 2-5-1 Cadence (ii7 - V7 - Imaj7 - VI7)",
            "5. Dark Ambient Horror (i - bVI - bIII - bVII)",
            "6. Kinetic Artcore / Breakcore (iv7 - v7 - i9 - VImaj7)",
            "7. City Pop / 80s Funk (IVmaj7 - III7 - vi7 - II7)",
            "8. Midwest Emo / Math Rock (Iadd9 - IVmaj7 - vi7 - V6)",
            "9. Kawaii Chords / Future Bass (IVmaj9 - V6/9 - iii7 - vi9)",
            "10. Lo-Fi Chill Hop (Imaj7 - VI7 - ii7 - V7alt)",
            "11. Cyberpunk Midtempo Dystopia (i - bII - i - bVI)",
            "12. Dramatic Orchestral Swell (i - iv7 - V7 - i)",
            "13. Gospel / Soul Elevation (I - I7 - IV - iv6)",
            "14. Hardstyle / Gabber Stabs (i - bVI - bVII - i)",
            "15. 8-Bit Heroic Chiptune (I - bVII - bVI - V7)",
            "16. Uplifting Trance Pad (vi7 - IVmaj7 - I - V)"
        },
        ritmoAcordesLabel = "15. Accompaniment Rhythm",
        ritmoAcordesChoices = {
            "1. Sustained Pad (Legato)",
            "2. Syncopated Chords (Quarter Notes - 1/4)",
            "3. Fluid Arpeggios (Eighth Notes - 1/8)",
            "4. Kinetic Electronic Chop (16th Notes - 1/16)",
            "5. Alternating Bass + Strum"
        },
        errContextTitle = "Context Error",
        errContextMsg = "Please select an active track in the editor before running.",
        errNoNotesTitle = "Structure Error",
        errNoNotesMsg = "No valid groups or notes found to process.",
        confirmTitle = "Confirm Operation",
        confirmMsgContrapunto = "Do you want to generate a countermelody (%s) in a new track?",
        confirmMsgProgresion = "Do you want to generate a chord progression (%s)?",
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
        especieContrapuntoLabel = "13. 対位法の種類",
        especieContrapuntoChoices = {
            "第1類 (ノート対ノート - 1:1)",
            "第2類 (1対2ノート - 2:1)",
            "第3類 (1対4ノート - 4:1)",
            "第4類 (シンコペーション / 懸垂音 - 2:1)",
            "第5類 (華麗対位法 / 複合装飾)",
            "自由対位法 (リズム / インプロ)"
        },
        progresionAcordesLabel = "14. コード進行スタイル",
        progresionAcordesChoices = {
            "1. 王道 J-Pop / アニメ (IVmaj7 - V7 - iii7 - vi)",
            "2. ポップス / EDM アンセム (Iadd9 - V - vi7 - IVmaj7)",
            "3. ネオソウル / R&B ラウンジ (ii9 - V13 - Imaj9 - VI7alt)",
            "4. ジャズ 2-5-1 ケーデンス (ii7 - V7 - Imaj7 - VI7)",
            "5. ダークアンビエントホラー (i - bVI - bIII - bVII)",
            "6. キネティックアートコア / ブレイクコア (iv7 - v7 - i9 - VImaj7)",
            "7. シティポップ / 80s ファンク (IVmaj7 - III7 - vi7 - II7)",
            "8. ミッドウェストエモ / マスロック (Iadd9 - IVmaj7 - vi7 - V6)",
            "9. カワイイコード / フューチャーベース (IVmaj9 - V6/9 - iii7 - vi9)",
            "10. ローファイチルホップ (Imaj7 - VI7 - ii7 - V7alt)",
            "11. サイバーパンクミドルテンボディストピア (i - bII - i - bVI)",
            "12. ドラマチックオーケストラスウェル (i - iv7 - V7 - i)",
            "13. ゴスペル / ソウルエレベーション (I - I7 - IV - iv6)",
            "14. ハードスタイル / ガバスタブ (i - bVI - bVII - i)",
            "15. 8ビットヒーローチップチューン (I - bVII - bVI - V7)",
            "16. アップリフティングトランスパッド (vi7 - IVmaj7 - I - V)"
        },
        ritmoAcordesLabel = "15. 伴奏リズムパターン",
        ritmoAcordesChoices = {
            "1. 持続パッド (レガート)",
            "2. シンコペーション伴奏 (4分音符 - 1/4)",
            "3. 流麗なアルペジオ (8分音符 - 1/8)",
            "4. キネティック電子チョップ (16分音符 - 1/16)",
            "5. 交互ベース + ストローク"
        },
        errContextTitle = "コンテキストエラー",
        errContextMsg = "実行する antes de エディタでアクティブなトラックを選択してください。",
        errNoNotesTitle = "構造エラー",
        errNoNotesMsg = "処理対象の有効なグループまたはノートが見つかりません。",
        confirmTitle = "操作の確認",
        confirmMsgContrapunto = "新しいトラックに対位法メロディ（%s）を生成しますか？",
        confirmMsgProgresion = "コード進行（%s）を生成しますか？",
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
