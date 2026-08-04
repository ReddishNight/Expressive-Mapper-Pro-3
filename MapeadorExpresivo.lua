--[[
===============================================================================
  Mapeador Expresivo Pro 3 - Synthesizer V Studio Pro 2
  Lenguaje: Lua 5.4 / LuaJIT (Entorno SynthV Studio Pro 2)
  Autor: Nyoru.X
  Versión Script: 3.6.1 (Entonación Justa, TCB Splines, Contrapunto Fux & Voice Leading Minimal Energy)
  Compatibilidad Estricta: Synthesizer V Studio 2 PRO v2.2.1+
  Build Objetivado: Mar 2 2026 13:09:42 (editorVersion >= 67072)

  Descripción:
    Motor modular definitivo de expresividad vocal, generación melódica prosódica, automatización Hermite/TCB,
    armonía vocal con Entonación Justa (Just Intonation), contrapunto algorítmico fuxiano estricto
    y progresiones de acordes con Voice Leading de matriz de energía mínima.
    Arquitectura orientada a datos (Data-Oriented Design) con 0 GC Alloc en runtime.

  Funcionalidades Principales:
    - Modo 0: Generación prosódica RAE multilingüe (diptongos, hiatos, curvas emocionales de entonación).
    - Modo 1: Automatización Hermite / Kochanek-Bartels (TCB) Splines con micro-expresión fonémica y RDP.
    - Modo 2: Armonías Vocales con Entonación Justa (-14c en 3ra Maj, +16c en 3ra Min) y formantes por registro.
    - Modo 3: Contrapunto Fuxiano Estricto (5 Especies con retardos, compensación de saltos y clímax único).
    - Modo 4: Progresiones de acordes con Voice Leading Minimal Energy (\sum \Delta pitch^2) y Micro-swing.
===============================================================================
--]]

-- ============================================================================
-- METADATOS DEL SCRIPT
-- ============================================================================

function getClientInfo()
    return {
        name = "Mapeador Expresivo Pro 3 (SynthV Studio 2 PRO v2.2.1)",
        author = "Nyoru.X",
        versionNumber = 3,
        minEditorVersion = 67072
    }
end

function getScriptTitle()
    return "Mapeador Expresivo Pro 3 (SynthV Studio 2 PRO v2.2.1)"
end

function getScriptVersion()
    return 3
end

function getScriptSide()
    return "SVClient"
end

function getMinEditorVersion()
    return 67072
end
--[[
  Mapeador Expresivo Pro 3 - Idiomas e Internacionalización (I18n)
  Lenguaje: Lua 5.4 / LuaJIT (Entorno SynthV Studio Pro 2)
  Autor: Nyoru.X
  Licencia: Propia / Cerrada (Uso y Modificación Permitida para Anti-Note)
  
  Este archivo contiene el diccionario de idiomas completo (ES, EN, JA) para la
  interfaz de usuario dinámica del Mapeador Expresivo Pro 3.
--]]

local I18N_DATA = {
    [0] = { -- Español (Default)
        title = "Mapeador Expresivo Pro 3",
        message = "--- Configuración de Expresividad, Armonía y Melodías ---",
        modoLabel = "1. Modo de Operación",
        modoChoices = {
            "Generar notas desde texto",
            "Aplicar expresividad a notas existentes",
            "Generar armonía vocal (dúo/coro)",
            "Generar contramelodía (Contrapunto)",
            "Generar progresión de acordes",
            "Sincronizar grupos de coros",
            "Forzar afinación a escala diatónica"
        },
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
        modoRitmoLabel = "5. Patrón Rítmico",
        modoRitmoChoices = {
            "Pop / J-Pop Sincopado",
            "Chop Kinetic Micro",
            "Legato Emocional",
            "Driving Hardcore Heavy",
            "Cuantización Plana Estándar"
        },
        modoMelodiaLabel = "6. Contorno Melódico",
        modoMelodiaChoices = {
            "Arco Expresivo Prosódico",
            "Salto Pentatónico Expresivo",
            "Onda Armónica",
            "Glitch Cromático Caótico",
            "Plano Expresivo",
            "Arpegio Ascendente",
            "Arpegio Descendente",
            "Paso de Escala Aleatorio",
            "Saltos de Consonancia"
        },
        escalaLabel = "7. Escala Melódica",
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
        tonicaLabel = "8. Tónica de la Escala (Root)",
        tonicaChoices = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" },
        autoDetectKeyLabel = "Auto-detectar Tonalidad (Krumhansl)",
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
        especieContrapuntoLabel = "13. Especie del Contrapunto",
        especieContrapuntoChoices = {
            "1ra Especie (Nota contra nota - 1:1)",
            "2da Especie (2 notas contra 1 - 2:1)",
            "3ra Especie (4 notas contra 1 - 4:1)",
            "Contrapunto Libre (Florido / Adornado)"
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
        letraLabel = "16. Texto / Sílabas de Entrada (ej: la-la-la)",
        letraHelp = nil,
        letraDefault = "ah~ oo~ ee~ ah~ uu~ ah~",
        basePitchLabel = "17. Nota MIDI Base",
        noteDurLabel = "18. Duración Base",
        durChoices = { "Blanca (1/2)", "Negra (1/4)", "Corchea (1/8)", "Semicorchea (1/16)" },
        enableVocalModes = "Automatizar Vocal Modes (vocalMode_*)",
        enableDetune = "Curvas de Detune y Micro-Afinación",
        enableExpPad = "XY Pad de Expresividad Integrada",
        enableSmartVibrato = "Envolvente de Vibrato Inteligente",
        mergeMode = "Modo Fusión (No Destructivo)",
        limpiarPrevios = "Limpiar automatizaciones previas",
        adaptarTempo = "Ajustar longitud de nodos al tempo BPM",
        compensarGanancia = "Compensar ganancia de volumen por preset",
        procesarTodosGrupos = "Procesar todos los grupos del track",
        idiomaLabel = "Idioma / Language",
        errContextTitle = "Error de Contexto",
        errContextMsg = "Por favor, selecciona una pista activa en el editor antes de ejecutar.",
        errNoNotesTitle = "Error de Estructura",
        errNoNotesMsg = "No se encontraron grupos o notas válidas para procesar.",
        errNoSyllablesTitle = "Aviso",
        errNoSyllablesMsg = "No has ingresado sílabas de texto válidas para la generación.",
        confirmTitle = "Confirmar Operación",
        confirmMsgGenerar = "¿Deseas generar notas a partir de %d sílabas en %s%d usando el preset '%s' al %d%%?",
        confirmMsgExpresar = "¿Deseas aplicar la expresividad del preset '%s' al %d%% sobre las notas seleccionadas?",
        confirmMsgArmonia = "¿Deseas generar armonía vocal (%s) sobre las notas existentes?",
        confirmMsgContrapunto = "¿Deseas generar una contramelodía (%s) en una pista nueva?",
        confirmMsgProgresion = "¿Deseas generar una progresión de acordes (%s)?",
        confirmMsgSincronizar = "¿Deseas sincronizar los grupos de coros no enlazados tomando como referencia el grupo guía activo?",
        confirmMsgForzar = "¿Deseas forzar las notas del grupo a la escala diatónica '%s' en '%s'?",
        completedTitle = "Mapeador Expresivo Pro 3",
        completedMsg = "¡Operación completada exitosamente!\nÍtems procesados/creados: %d\nPreset/Config: %s\nIntensidad: %d%%\nGrupos/Pistas procesados: %d\nDeshacer Atómico registrado (Ctrl+Z para revertir).",
        customTensionLabel = "Tensión Personalizada (-1.0 a 1.0)",
        customBreathLabel = "Tensión de Aire (-1.0 a 1.0)",
        customVolumeLabel = "Volumen Personalizado (dB) (-6.0 a 6.0)",
        customGenderLabel = "Género Personalizado (-1.0 a 1.0)",
        customVoicingLabel = "Voicing Personalizado (0.0 a 1.0)",
        customTimbreLabel = "Timbre / Desplazamiento Tonal (-1.0 a 1.0)",
        humanizeLabel = "19. Humanización Orgánica Vocálica (%)",
        registerScaleLabel = "20. Escalamiento de Registro (%)",
        phonemeModLabel = "21. Modulación Tipo de Fonema (%)",
        armoniaIntervalosCustomLabel = "23. Intervalos Personalizados (ej: +3, +7, -5)",
        armoniaIntervalosCustomHelp = "Separar por comas. Ej: +3, +7, -5 o d3, d5, c-5 (d=diatónico, c=cromático)",
        rangoNotaMinLabel = "24. Límite de Nota Mínimo",
        rangoNotaMaxLabel = "25. Límite de Nota Máximo",
        targetNotesModeLabel = "22. Destino de la Generación",
        targetNotesModeChoices = { "Crear notas nuevas", "Reemplazar en notas seleccionadas" },
        vistaSeccionLabel = "0. Sección de Panel (Filtro de UX)",
        vistaSeccionChoices = {
            "Modo Rápido (EasyLyric: Letra y Melodía)",
            "Expresión Vocal y Curvas Hermite",
            "Armonía, Coros y Afinación Temperada",
            "Contrapunto y Progresiones de Acordes",
            "Parámetros Avanzados y Rangos de Notas"
        },
        enableJustIntonation = "Activar Afinación Justa Diatónica (Off = Temperamento Igual POP)"
    },
    [1] = { -- Inglés
        title = "Expressive Mapper Pro 3",
        message = "--- Vocal Expressiveness, Harmony & Melody Settings ---",
        modoLabel = "1. Operating Mode",
        modoChoices = {
            "Generate notes from text",
            "Apply expressiveness to existing notes",
            "Generate vocal harmony (duo/choir)",
            "Generate countermelody (Counterpoint)",
            "Generate chord progression",
            "Synchronize choir groups",
            "Force pitch to diatonic scale"
        },
        presetLabel = "2. Vocal Style / Preset",
        presetChoices = {
            "[Recommended] Universal Standard (Balanced)",
            "[Previous Session] Load saved configuration",
            "Custom...",
            "Powerful Operatic Belting",
            "Melancholic / Sad",
            "Whisper / Intimate Soft",
            "Synth-Pop / Classic Vocalo",
            "Rock / Aggressive Grit",
            "Dark Ambient / Psychological Terror",
            "Jazz / Expressive Soul",
            "J-Pop Idol High Energy",
            "Standard Coral (Balanced)",
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
        intensidadLabel = "3. Effect Intensity (%)",
        densityLabel = "4. Spline Resolution",
        densityChoices = {
            "Smart Spline (Adaptive)",
            "Ultra High (1/64 Note)",
            "High (1/32 Note)",
            "Standard (1/16 Note)",
            "Medium (1/8 Note)",
            "Low (1/4 Note)",
            "Key Nodes Only",
            "Phoneme Transition"
        },
        modoRitmoLabel = "5. Rhythmic Pattern",
        modoRitmoChoices = {
            "Syncopated Pop / J-Pop",
            "Chop Kinetic Micro",
            "Emotional Legato",
            "Driving Hardcore Heavy",
            "Standard Quantized Flat"
        },
        modoMelodiaLabel = "6. Melodic Contour",
        modoMelodiaChoices = {
            "Expressive Prosodic Arc",
            "Expressive Pentatonic Leap",
            "Harmonic Wave",
            "Chaotic Chromatic Glitch",
            "Expressive Flat",
            "Ascending Arpeggio",
            "Descending Arpeggio",
            "Random Scale Step",
            "Consonant Leaps"
        },
        escalaLabel = "7. Melodic Scale",
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
        tonicaLabel = "8. Scale Root (Tonic)",
        tonicaChoices = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" },
        autoDetectKeyLabel = "Auto-detect Key (Krumhansl)",
        modoArmoniaLabel = "9. Vocal Harmony Type",
        modoArmoniaChoices = {
            "Third Up (Duo)",
            "Third Down (Duo)",
            "Fifth Up (Duo)",
            "Sixth Up (Duo)",
            "Octave Down",
            "Multi-voice Choir Presets",
            "Custom Interval"
        },
        presetCoralLabel = "10. Choir Preset",
        presetCoralChoices = {
            "Upper 3rd Duo",
            "Lower 3rd Duo",
            "Pop Trio (3rds & 5ths)",
            "SATB Choir Quartet",
            "Power Duo (5ths & Octaves)",
            "Anti-Phase Unison Choir"
        },
        antiFaseMsLabel = "11. Anti-Phase Delay (ms)",
        antiFaseCentsLabel = "12. Anti-Phase Detune (cents)",
        especieContrapuntoLabel = "13. Counterpoint Species",
        especieContrapuntoChoices = {
            "1st Species (Note against note - 1:1)",
            "2nd Species (2 notes against 1 - 2:1)",
            "3rd Species (4 notes against 1 - 4:1)",
            "Free Counterpoint (Florid / Adorned)"
        },
        progresionAcordesLabel = "14. Chord Progression Style",
        progresionAcordesChoices = {
            "1. J-Pop / Anime Royal (IVmaj7 - V7 - iii7 - vi)",
            "2. Pop / EDM Anthem (Iadd9 - V - vi7 - IVmaj7)",
            "3. Neo-Soul / R&B Lounge (ii9 - V13 - Imaj9 - VI7alt)",
            "4. Jazz Cadence 2-5-1 (ii7 - V7 - Imaj7 - VI7)",
            "5. Dark Ambient Horror (i - bVI - bIII - bVII)",
            "6. Artcore / Breakcore Kinetic (iv7 - v7 - i9 - VImaj7)",
            "7. City Pop / 80s Funk (IVmaj7 - III7 - vi7 - II7)",
            "8. Math Rock / Midwest Emo (Iadd9 - IVmaj7 - vi7 - V6)",
            "9. Future Bass / Kawaii Chords (IVmaj9 - V6/9 - iii7 - vi9)",
            "10. Lo-Fi Chill Hop (Imaj7 - VI7 - ii7 - V7alt)",
            "11. Cyberpunk Midtempo Dystopia (i - bII - i - bVI)",
            "12. Orchestral Dramatic Swell (i - iv7 - V7 - i)",
            "13. Gospel / Soul Elevation (I - I7 - IV - iv6)",
            "14. Gabber / Hardstyle Stabs (i - bVI - bVII - i)",
            "15. Chiptune / 8-Bit Heroic (I - bVII - bVI - V7)",
            "16. Uplifting Trance Pad (vi7 - IVmaj7 - I - V)"
        },
        ritmoAcordesLabel = "15. Accompaniment Rhythm",
        ritmoAcordesChoices = {
            "1. Sustained Legato Pad (Full Bar)",
            "2. Syncopated Rhythmic Comping (1/4 Notes)",
            "3. Cascading Arpeggiator (1/8 Notes)",
            "4. Kinetic Electronic Chop (1/16 Notes)",
            "5. Alternating Bass + Strum"
        },
        letraLabel = "16. Input Text / Lyrics (Ex. ah~ oo~)",
        letraHelp = nil,
        letraDefault = "ah~ oo~ ee~ ah~ uu~ ah~",
        basePitchLabel = "17. Base MIDI Note (C4 = 60)",
        noteDurLabel = "18. Base Note Duration",
        durChoices = { "Half (1/2)", "Quarter (1/4)", "Eighth (1/8)", "Sixteenth (1/16)" },
        enableVocalModes = "Automate Vocal Modes (vocalMode_*)",
        enableDetune = "Micro-Detune & Pitch Scoops",
        enableExpPad = "Expression XY Pad (ExpPad)",
        enableSmartVibrato = "Smart Vibrato Envelope",
        mergeMode = "Non-Destructive Merge Mode",
        limpiarPrevios = "Clear Previous Automations",
        adaptarTempo = "Sync to Project Tempo (BPM)",
        compensarGanancia = "Compensate Track Volume Gain",
        procesarTodosGrupos = "Process All Track Groups",
        idiomaLabel = "Interface Language",
        errContextTitle = "Context Error",
        errContextMsg = "Please select an active track in the editor before running.",
        errNoNotesTitle = "Structure Error",
        errNoNotesMsg = "No valid groups or notes found to process.",
        errNoSyllablesTitle = "Notice",
        errNoSyllablesMsg = "No valid syllables entered for generation.",
        confirmTitle = "Confirm Operation",
        confirmMsgGenerar = "Will generate notes from %d syllables starting at %s%d with preset '%s' at %d%%.\nContinue?",
        confirmMsgExpresar = "Will apply expressiveness to existing notes with preset '%s' at %d%%.\nContinue?",
        confirmMsgArmonia = "Will generate vocal harmony (%s) over existing notes.\nContinue?",
        confirmMsgContrapunto = "Will generate countermelody (%s) over track notes.\nContinue?",
        confirmMsgProgresion = "Will generate chord progression (%s).\nContinue?",
        confirmMsgSincronizar = "Will synchronize unlinked choir groups using the active group as a reference.\nContinue?",
        confirmMsgForzar = "Will force existing pitches to the diatonic scale '%s' in '%s'.\nContinue?",
        completedTitle = "Expressive Mapper Pro 3",
        completedMsg = "Operation completed successfully.\nItems processed/created: %d\nPreset/Config: %s\nIntensity: %d%%\nGroups/Tracks processed: %d\nAtomic undo registered (Ctrl+Z to revert).",
        customTensionLabel = "Custom Tension (-1.0 to 1.0)",
        customBreathLabel = "Custom Breathiness (-1.0 to 1.0)",
        customVolumeLabel = "Custom Volume (dB) (-6.0 to 6.0)",
        customGenderLabel = "Custom Gender (-1.0 to 1.0)",
        customVoicingLabel = "Custom Voicing (0.0 to 1.0)",
        customTimbreLabel = "Timbre / Tone Shift (-1.0 to 1.0)",
        humanizeLabel = "19. Organic Vocal Humanization (%)",
        registerScaleLabel = "20. Pitch Register Scaling (%)",
        phonemeModLabel = "21. Phoneme-Class Modulation (%)",
        armoniaIntervalosCustomLabel = "23. Custom Intervals (e.g. +3, +7, -5)",
        armoniaIntervalosCustomHelp = "Use commas to separate. E.g. +3, +7, -5 or d3, d5, c-5 (d=diatonic, c=chromatic)",
        rangoNotaMinLabel = "24. Minimum Note Range",
        rangoNotaMaxLabel = "25. Maximum Note Range",
        targetNotesModeLabel = "22. Generation Destination",
        targetNotesModeChoices = { "Create New Notes", "Replace Selected Notes" },
        vistaSeccionLabel = "0. Panel View Section (UX Filter)",
        vistaSeccionChoices = {
            "Quick Mode (EasyLyric: Lyrics & Melody)",
            "Vocal Expression & Hermite Curves",
            "Harmonies, Choir & Tuning Temperament",
            "Counterpoint & Chord Progressions",
            "Advanced Settings & Note Ranges"
        },
        enableJustIntonation = "Enable Pure Just Intonation (Off = Pop Equal Temperament)"
    },
    [2] = { -- Japonés
        title = "表現力マッパー Pro 3",
        message = "--- ボーカル表現力・ハモり・メロディ設定 ---",
        modoLabel = "1. 動作モード",
        modoChoices = {
            "テキストからノート生成",
            "既存ノートに表現力を適用",
            "ボーカルハモり生成 (デュオ/合唱)",
            "対主旋律 (カウンターメロディ) 生成",
            "コード進行生成",
            "コーラス同期 / グループの同期",
            "既存ノートのピッチをスケールに強制"
        },
        presetLabel = "2. ボーカルスタイル / プリセット",
        presetChoices = {
            "[推奨] 標準ユニバーサル (万能バランス)",
            "[前回セッション] 保存した設定を読み込む",
            "カスタム...",
            "オペラティック・ベルティング",
            "哀愁 / メランコリック",
            "ウィスパー / ソフト",
            "シンセポップ / 王道ボカロ",
            "ロック / アグレッシブ",
            "ダークアンビエント / ホラー",
            "ジャズ / エクスプレッシブソウル",
            "J-Pop アイドルハイエナジー",
            "標準バランス (コーラス)",
            "オーケストラ Artcore",
            "ブレイクコア / グリッチコア",
            "アーメンブレイク / Jungle",
            "Amencore Hardcore",
            "ガバ / スピードコア",
            "ニューロファンク / テックステップ",
            "ユーロビート / Hi-NRG",
            "フューチャーベース / カワイイ",
            "サイバーパンク ミッドテンポ",
            "チップチューン / 8-Bit",
            "ハードスタイル / ロースタイル",
            "アップリフティング・トランス"
        },
        intensidadLabel = "3. エフェクト強度 (%)",
        densityLabel = "4. オートメーション解像度",
        densityChoices = {
            "Smart Spline (適応型)",
            "超高 (1/64)",
            "高 (1/32)",
            "標準 (1/16)",
            "中 (1/8)",
            "低 (1/4)",
            "キーノードのみ",
            "音素単位"
        },
        modoRitmoLabel = "5. リズムパターン",
        modoRitmoChoices = {
            "Pop / J-Pop シンコペーション",
            "キネティック・マイクロチョップ",
            "エモーショナル・レガート",
            "ドライビング・ハードコア",
            "標準量子化"
        },
        modoMelodiaLabel = "6. メロディライン",
        modoMelodiaChoices = {
            "エモーショナル・プロソディ・アーク",
            "表現力ペンタトニック跳躍",
            "ハーモニック・ウェーブ",
            "クロマチック・グリッチ",
            "フラット表現力",
            "上昇アルペジオ",
            "下降アルペジオ",
            "ランダムスケールステップ",
            "協和音跳躍移動"
        },
        escalaLabel = "7. メロディスケール",
        escalaChoices = {
            "メジャー・ペンタトニック",
            "マイナー・ペンタトニック",
            "ナチュラル・メジャー",
            "ナチュラル・マイナー",
            "ハーモニック・マイナー",
            "メロディック・マイナー",
            "ドリアン",
            "フリジアン",
            "リディアン",
            "ミクソリディアン",
            "ロクリアン",
            "ブルース",
            "クロマチック",
            "ハンガリアン・マイナー",
            "ダブル・ハーモニック (ビザンチン)"
        },
        tonicaLabel = "8. スケール主音 (Root)",
        tonicaChoices = { "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B" },
        autoDetectKeyLabel = "キー自動検出 (Krumhansl)",
        modoArmoniaLabel = "9. ハモりタイプ",
        modoArmoniaChoices = {
            "3度上",
            "3度下",
            "5度上",
            "6度上",
            "オクターブ下",
            "マルチボイス合唱プリセット",
            "カスタムインターバル"
        },
        presetCoralLabel = "10. コーラスプリセット",
        presetCoralChoices = {
            "上3度デュオ",
            "下3度デュオ",
            "Popトリオ (3度 & 5度)",
            "SATB 4部合唱クァルテット",
            "Powerデュオ (5度 & オクターブ)",
            "ユニゾンアンチフェーズコーラス"
        },
        antiFaseMsLabel = "11. Delay de Anti-fase (ms)",
        antiFaseCentsLabel = "12. Detune de Anti-fase (cents)",
        especieContrapuntoLabel = "13. 对位法类 (Counterpoint)",
        especieContrapuntoChoices = {
            "第1類 (1:1 音対音)",
            "第2類 (2:1 2音対1音)",
            "第3類 (4:1 4音対1音)",
            "自由対位法 / 装飾"
        },
        progresionAcordesLabel = "14. コード進行スタイル",
        progresionAcordesChoices = {
            "1. J-Pop / アニメ王道 (IVmaj7 - V7 - iii7 - vi)",
            "2. Pop / EDM アンセム (Iadd9 - V - vi7 - IVmaj7)",
            "3. Neo-Soul / R&B ラウンジ (ii9 - V13 - Imaj9 - VI7alt)",
            "4. Jazz 2-5-1 カデンツ (ii7 - V7 - Imaj7 - VI7)",
            "5. ダークアンビエント (i - bVI - bIII - bVII)",
            "6. Artcore / Breakcore キネティック (iv7 - v7 - i9 - VImaj7)",
            "7. シティポップ / 80s ファンク (IVmaj7 - III7 - vi7 - II7)",
            "8. マスロック / Midwest Emo (Iadd9 - IVmaj7 - vi7 - V6)",
            "9. Future Bass / カワイイコード (IVmaj9 - V6/9 - iii7 - vi9)",
            "10. Lo-Fi Chill Hop (Imaj7 - VI7 - ii7 - V7alt)",
            "11. サイバーパンク ディストピア (i - bII - i - bVI)",
            "12. オーケストラ・スウェル (i - iv7 - V7 - i)",
            "13. ゴスペル / ソウル (I - I7 - IV - iv6)",
            "14. ガバ / ハードスタイル (i - bVI - bVII - i)",
            "15. チップチューン / 8-Bit (I - bVII - bVI - V7)",
            "16. アップリフティング・トランス (vi7 - IVmaj7 - I - V)"
        },
        ritmoAcordesLabel = "15. 伴奏リズム",
        ritmoAcordesChoices = {
            "1. サステイン・レガート (Pad / 全音符)",
            "2. リズミカル・シンコペーション (4分音符 1/4)",
            "3. アルペジオ・カスケード (8分音符 1/8)",
            "4. キネティック・チョップ (16分音符 1/16)",
            "5. ベース & ストラム (交互奏法)"
        },
        letraLabel = "16. 入力テキスト / 歌詞 (例: アー~ オー~)",
        letraHelp = nil,
        letraDefault = "アー~ オー~ イー~ アー~ ウー~ アー~",
        basePitchLabel = "17. 基準 MIDI ノート",
        noteDurLabel = "18. 基準音節長",
        durChoices = { "2分音符 (1/2)", "4分音符 (1/4)", "8分音符 (1/8)", "16分音符 (1/16)" },
        enableVocalModes = "ボーカルモードの自動化 (vocalMode_*)",
        enableDetune = "ピッチスクープ / マイクロディチューン",
        enableExpPad = "エクスプレッション XY パッド",
        enableSmartVibrato = "スマートビブラートエンベロープ",
        mergeMode = "非破壊マージ (Merge)",
        limpiarPrevios = "範囲内の既存オートメーションを消去",
        adaptarTempo = "プロジェクトテンポ (BPM) に同期",
        compensarGanancia = "トラックゲインに応じて補正",
        procesarTodosGrupos = "トラック内の全グループを処理",
        idiomaLabel = "Idioma / Language",
        errContextTitle = "コンテキストエラー",
        errContextMsg = "実行する前にエディタでアクティブなトラックを選択してください。",
        errNoNotesTitle = "構造エラー",
        errNoNotesMsg = "処理対象の有効なグループまたはノートが見つかりません。",
        errNoSyllablesTitle = "通知",
        errNoSyllablesMsg = "生成のための有効な音節が入力されていません。",
        confirmTitle = "操作の確認",
        confirmMsgGenerar = "%d音節から%s%dを基準にプリセット'%s'（%d%%）でノートを生成します。\n続行しますか？",
        confirmMsgExpresar = "プリセット'%s'（%d%%）で既存ノートに表現力を適用します。\n続行しますか？",
        confirmMsgArmonia = "既存ノート上にボーカルハモり（%s）を生成します。\n続行しますか？",
        confirmMsgContrapunto = "トラック上にカウンターメロディ（%s）を生成します。\n続行しますか？",
        confirmMsgProgresion = "コード進行（%s）を生成します。\n続行しますか？",
        confirmMsgSincronizar = "アクティブなグループを参照して、リンクされていないコーラスグループを同期します。\n続行しますか？",
        confirmMsgForzar = "既存ノートのピッチをスケール '%s' (主音 '%s') に強制します。\n続行しますか？",
        completedTitle = "表現力マッパー Pro 3",
        completedMsg = "処理が正常に完了しました！\n処理/生成アイテム数: %d\nプリセット/設定: %s\n強度: %d%%\n処理グループ/トラック数: %d\nAtomic Undo 登録完了（Ctrl+Z で元に戻せます）。",
        customTensionLabel = "カスタムテンション (-1.0〜1.0)",
        customBreathLabel = "カスタムブレシネス (-1.0〜1.0)",
        customVolumeLabel = "カスタム音量 (dB) (-6.0〜6.0)",
        customGenderLabel = "カスタムジェンダー (-1.0〜1.0)",
        customVoicingLabel = "カスタムボイシング (0.0〜1.0)",
        customTimbreLabel = "音色 / トーンシフト (-1.0〜1.0)",
        humanizeLabel = "19. 有機的ボーカルヒューマナイズ (%)",
        registerScaleLabel = "20. ピッチレジスタ感度 (%)",
        phonemeModLabel = "21. 音素クラス変調 (%)",
        armoniaIntervalosCustomLabel = "23. カスタムインターバル (例: +3, +7, -5)",
        armoniaIntervalosCustomHelp = "カンマ区切り。例: +3, +7, -5 または d3, d5, c-5 (d=ダイアトニック, c=クロマチック)",
        rangoNotaMinLabel = "24. 最小ノート範囲",
        rangoNotaMaxLabel = "25. 最大ノート範囲",
        targetNotesModeLabel = "22. 生成先ターゲット",
        targetNotesModeChoices = { "新規ノートを生成", "選択されたノートを置換" },
        vistaSeccionLabel = "0. パネル表示セクション (UXフィルター)",
        vistaSeccionChoices = {
            "クイックモード (EasyLyric: 歌詞 & メロディ)",
            "ボーカル表現力 & Hermiteカーブ",
            "ハモり・コーラス & 調律・平均律",
            "対位法 & コード進行",
            "詳細設定 & ノート範囲"
        },
        enableJustIntonation = "純正律を有効化 (オフ = POP向け平均律)"
    }
}
-- ============================================================================
-- MÓDULO 2: DATOS Y PRESETS DE EXPRESIVIDAD VOCAL (0 GC ALLOC)
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

-- Buffers globales pre-asignados para interpolación Hermite y automatizaciones (0 GC Alloc)
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

    return deltaPitchProsodico, multDurProsodico
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
    raul = { "Ra-", "úl" }
}

--- Auto-silabificador avanzado para español con reglas RAE (0 GC Alloc en buffers estáticos)
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
local function extraerSilabas(texto, idiomaIdx)
    local silabas = {}

    -- Reemplazar barras verticales con guiones para unificar la separación manual
    local textoNormalizado = string.gsub(texto, "|", "-")
    local tieneSeparadores = string.find(textoNormalizado, "%-") ~= nil

    if tieneSeparadores then
        -- Modo tradicional / manual: separar por guiones/barras y espacios
        local textoLimpio = string.gsub(textoNormalizado, "%-", " ")
        for palabra in string.gmatch(textoLimpio, "%S+") do
            if string.find(palabra, "[\224-\239]") then
                for char in string.gmatch(palabra, "[%z\1-\127\194-\244][\128-\191]*") do
                    silabas[#silabas + 1] = char
                end
            else
                silabas[#silabas + 1] = palabra
            end
        end
    else
        -- Modo auto-tokenización: separar por palabras y luego silabificar
        for palabra in string.gmatch(textoNormalizado, "%S+") do
            -- Detectar marcadores especiales: pausas, holds, etc.
            if palabra == "_" or palabra == "," or palabra == "." or palabra == "、" or palabra == "。" then
                silabas[#silabas + 1] = palabra
            elseif string.find(palabra, "[\224-\239]") then
                -- Japonés: cada grafema es una mora/sílaba
                for char in string.gmatch(palabra, "[%z\1-\127\194-\244][\128-\191]*") do
                    silabas[#silabas + 1] = char
                end
            elseif idiomaIdx == 0 then
                -- Español: auto-silabificación en legato continuo
                local silabasPalabra = silabificarEspanol(palabra)
                for si = 1, #silabasPalabra do
                    silabas[#silabas + 1] = silabasPalabra[si]
                end
            else
                -- Inglés u otros: cada palabra es una sílaba en legato continuo
                silabas[#silabas + 1] = palabra
            end
        end

        -- Eliminar pausa final sobrante si existe
        if #silabas > 0 and silabas[#silabas] == "_" then
            silabas[#silabas] = nil
        end
    end

    return silabas
end

--- Convertir una sílaba española/latina a fonemas universales de Synthesizer V (0 GC Alloc)
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

local function generarNotasDesdeTexto(letraRaw, basePitch, stepBlickBase, modoMelodiaIdx, escalaIdx, modoRitmoIdx, idiomaIdx, noteGroup, reproductor, rangoMin, rangoMax)
    local silabas = extraerSilabas(letraRaw, idiomaIdx)
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
    local currentBlick = reproductor:getPlayhead()
    local notasCreadas = {}
    local pitchPrevio = basePitch

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

        -- Silencio o pausa (_, ,, ., 、, 。)
        if token == "_" or token == "," or token == "." or token == "、" or token == "。" then
            currentBlick = currentBlick + stepBlickBase
        else
            indiceNota = indiceNota + 1

            -- Analizar prosodia por idioma
            local deltaPitchProsodico, multDurProsodico = analizarProsodiaSilaba(token, idiomaIdx, indiceNota, totalCantadas, esPregunta, esExclamacion)

            -- Modulador Rítmico de Duración
            local multRitmo = 1.0
            if modoRitmoIdx == 0 then -- Pop Sincopado
                if (indiceNota % 4 == 1) then multRitmo = 1.5
                elseif (indiceNota % 4 == 2) then multRitmo = 0.75
                elseif (indiceNota % 4 == 3) then multRitmo = 1.25
                else multRitmo = 0.50 end
            elseif modoRitmoIdx == 1 then -- Micro-Chop Kinético (Breakcore / Glitchcore)
                if (indiceNota % 3 == 0) then multRitmo = 0.25 -- 1/32 chop
                elseif (indiceNota % 2 == 0) then multRitmo = 0.50 -- 1/16 chop
                else multRitmo = 0.75 end
            elseif modoRitmoIdx == 2 then -- Legato Emotivo Swell (Artcore / Trance)
                if (indiceNota % 2 == 1) then multRitmo = 2.0
                else multRitmo = 1.5 end
            elseif modoRitmoIdx == 3 then -- Driving Hardcore (Gabber / Rock)
                if (indiceNota % 3 == 0) then multRitmo = 0.66 -- Tresillo
                else multRitmo = 0.75 end
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

            local durBlick = math.max(math.floor(SV.QUARTER / 16), math.floor(stepBlickBase * multDurProsodico * multRitmo))
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

            -- Símbolos de inflexión (+, ++, -, --, ^, v)
            if not pitchTarget then
                if string.find(token, "%+%+") or string.find(token, "%^%^") then
                    pitchTarget = pitchPrevio + 4
                    token = string.gsub(token, "%+%+", "")
                    token = string.gsub(token, "%^%^", "")
                elseif string.find(token, "%+") or string.find(token, "%^") then
                    pitchTarget = pitchPrevio + 2
                    token = string.gsub(token, "%+", "")
                    token = string.gsub(token, "%^", "")
                elseif string.find(token, "%-%-") or string.find(token, "vv") then
                    pitchTarget = pitchPrevio - 4
                    token = string.gsub(token, "%-%-", "")
                    token = string.gsub(token, "vv", "")
                elseif string.find(token, "%-") or string.find(token, "v") then
                    pitchTarget = pitchPrevio - 2
                    token = string.gsub(token, "%-", "")
                    token = string.gsub(token, "v", "")
                end
            end

            -- Generador Melódico Prosódico Avanzado
            if not pitchTarget then
                if modoMelodiaIdx == 0 then
                    -- Arco Prosódico Emotivo
                    local progress = (totalCantadas > 1) and ((indiceNota - 1) / (totalCantadas - 1)) or 0.5
                    local deltaArc = math.sin(progress * math.pi) * 6.0
                    pitchTarget = basePitch + math.floor(deltaArc + deltaPitchProsodico + 0.5)
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

            local nuevaNota = SV:create("Note")
            nuevaNota:setTimeRange(currentBlick, durBlick)
            nuevaNota:setPitch(pitchFinal)

            local letraLimpia = string.gsub(token, "%s+", "")
            if letraLimpia == "" then letraLimpia = "la" end
            nuevaNota:setLyrics(letraLimpia)

            noteGroup:addNote(nuevaNota)
            notasCreadas[#notasCreadas + 1] = nuevaNota

            pitchPrevio = pitchFinal
            currentBlick = currentBlick + durBlick
        end
    end

    return notasCreadas
end
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
-- ============================================================================
-- MÓDULO 7: GENERADOR DE CONTRAMELODÍA Y CONTRAPUNTO ALGORÍTMICO (0 GC ALLOC)
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

    local nuevaPista = SV:create("Track")
    local nombreEspecie = { [0] = "1ra Especie (1:1)", [1] = "2da Especie (2:1)", [2] = "3ra Especie (4:1)", [3] = "Libre (Rítmico)" }
    nuevaPista:setName(pistaBase:getName() .. " - Contramelodía " .. (nombreEspecie[especieIdx] or ""))

    proyecto:addTrack(nuevaPista)

    -- Crear NoteGroup y NoteGroupReference con el flujo correcto de la API
    local nuevoGroupRef = SV:create("NoteGroup")
    proyecto:addNoteGroup(nuevoGroupRef)
    local mainRef = SV:create("NoteGroupReference")
    mainRef:setTarget(nuevoGroupRef)
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
        else
            -- 3ra Especie / Libre: 4 notas por nota base (4:1) o patrón ornamental
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
        end
    end

    return notasCreadas
end
-- ============================================================================
-- MÓDULO 8: MOTOR AVANZADO DE PROGRESIONES DE ACORDES Y VOICINGS (0 GC ALLOC)
-- ============================================================================

local INTERVALOS_TIPO_ACORDE = {
    triada_mayor = { 0, 4, 7 },
    triada_menor = { 0, 3, 7 },
    maj7         = { 0, 4, 7, 11 },
    min7         = { 0, 3, 7, 10 },
    dom7         = { 0, 4, 7, 10 },
    maj9         = { 0, 4, 7, 11, 14 },
    min9         = { 0, 3, 7, 10, 14 },
    dom9         = { 0, 4, 7, 10, 14 },
    dom13        = { 0, 4, 7, 10, 14, 21 },
    add9         = { 0, 4, 7, 14 },
    sus4         = { 0, 5, 7 },
    sus2         = { 0, 2, 7 },
    dim7         = { 0, 3, 6, 9 },
    dom7alt      = { 0, 4, 6, 10, 13 }
}

--- Construir las notas en pitch absoluto para un grado y tipo de acorde
local function construirNotasAcorde(gradoRaiz, tipoAcorde, tonica, escalaIndices)
    local escala = escalaIndices or { 0, 2, 4, 5, 7, 9, 11 }
    local pitchRaiz = transponerPorGradosEscala(tonica + 48, gradoRaiz - 1, tonica, escala)

    local relIntervals = INTERVALOS_TIPO_ACORDE[tipoAcorde] or INTERVALOS_TIPO_ACORDE.triada_mayor
    local notasSuperiores = {}

    for i = 1, #relIntervals do
        notasSuperiores[i] = pitchRaiz + relIntervals[i]
    end

    -- Nota del bajo en registro grave (C2 - C3)
    local pitchBajo = (pitchRaiz % 12) + 36
    if pitchBajo < 36 then pitchBajo = pitchBajo + 12 end

    return pitchBajo, notasSuperiores
end

--- Algoritmo de Conducción de Voces de Energía Mínima (Minimal Energy Voice Leading)
local function optimizarConduccionVoces(notasNuevas, notasPrevias)
    if not notasPrevias or #notasPrevias == 0 then
        return notasNuevas
    end

    local numVoces = #notasNuevas
    local mejorInversion = {}
    local menorEnergia = 99999999

    -- Probar giros de inversión y desplazamientos de octava para minimizar la energía total de desplazamiento \sum (\Delta pitch)^2
    for inv = 0, numVoces - 1 do
        local candidato = {}
        for v = 1, numVoces do
            local idx = ((v - 1 + inv) % numVoces) + 1
            local octShift = math.floor((v - 1 + inv) / numVoces) * 12
            candidato[v] = notasNuevas[idx] + octShift
        end

        local energiaTotal = 0
        local limiteComparacion = math.min(#candidato, #notasPrevias)
        for c = 1, limiteComparacion do
            local diff = candidato[c] - notasPrevias[c]
            energiaTotal = energiaTotal + (diff * diff)
        end

        if energiaTotal < menorEnergia then
            menorEnergia = energiaTotal
            mejorInversion = candidato
        end
    end

    return mejorInversion
end

--- Generar notas y pistas para una progresión de acordes profesional
local function generarProgresionAcordes(proyecto, pistaBase, progresionIdx, tonica, escalaIdx, ritmoIdx, fIntensidad, configPreset, timeAxis)
    local escalaIndices = ESCALAS_AVANZADAS[escalaIdx] or ESCALAS_AVANZADAS[2]
    local datosProgresion = PROGRESIONES_ACORDES[progresionIdx] or PROGRESIONES_ACORDES[0]
    local gradosAcordes = datosProgresion.grados or { 4, 5, 3, 6 }
    local tiposAcordes = datosProgresion.tipos or { "maj7", "dom7", "min7", "min7" }

    local numCompases = #gradosAcordes
    local durCompasBlicks = SV.QUARTER * 4

    local reproductor = SV:getPlayback()
    local startBlick = reproductor:getPlayhead()

    local nuevaPista = SV:create("Track")
    nuevaPista:setName(pistaBase:getName() .. " - Acordes (" .. datosProgresion.nombre .. ")")
    proyecto:addTrack(nuevaPista)

    local nuevoGroupRef = SV:create("NoteGroup")
    proyecto:addNoteGroup(nuevoGroupRef)
    local mainRef = SV:create("NoteGroupReference")
    mainRef:setTarget(nuevoGroupRef)
    nuevaPista:addGroupReference(mainRef)

    local notasCreadas = 0
    local currBlick = startBlick
    local vocesSuperioresPrevias = nil

    for cIdx = 1, numCompases do
        local gradoActual = gradosAcordes[cIdx]
        local tipoActual = tiposAcordes[cIdx] or "triada_mayor"

        local pitchBajo, vocesBrutas = construirNotasAcorde(gradoActual, tipoActual, tonica, escalaIndices)
        local vocesSuperiores = optimizarConduccionVoces(vocesBrutas, vocesSuperioresPrevias)
        vocesSuperioresPrevias = vocesSuperiores

        -- 1. Agregar Nota de Bajo Sostenida en Registro Grave
        local notaBajo = SV:create("Note")
        notaBajo:setTimeRange(currBlick, durCompasBlicks)
        notaBajo:setPitch(pitchBajo)
        notaBajo:setLyrics("u")
        nuevoGroupRef:addNote(notaBajo)
        notasCreadas = notasCreadas + 1

        -- 2. Patrones Rítmicos para Voces Superiores
        if ritmoIdx == 0 then
            -- Pad Sostenido Legato (Full Bar Swell)
            for v = 1, #vocesSuperiores do
                local nUpper = SV:create("Note")
                nUpper:setTimeRange(currBlick, durCompasBlicks)
                nUpper:setPitch(vocesSuperiores[v])
                nUpper:setLyrics((v % 2 == 0) and "a" or "o")
                nuevoGroupRef:addNote(nUpper)
                notasCreadas = notasCreadas + 1
            end
        elseif ritmoIdx == 1 then
            -- Comping Rítmico Sincopado (Negras 1/4)
            local durPulso = SV.QUARTER
            for p = 0, 3 do
                local bPulse = currBlick + (p * durPulso)
                for v = 1, #vocesSuperiores do
                    local nUpper = SV:create("Note")
                    nUpper:setTimeRange(bPulse, durPulso - 20)
                    nUpper:setPitch(vocesSuperiores[v])
                    nUpper:setLyrics("la")
                    nuevoGroupRef:addNote(nUpper)
                    notasCreadas = notasCreadas + 1
                end
            end
        elseif ritmoIdx == 2 then
            -- Arpegio Cascadas Fluido (Corcheas 1/8)
            local durCorchea = math.floor(SV.QUARTER / 2)
            local totalPasos = 8
            for a = 0, totalPasos - 1 do
                local bArp = currBlick + (a * durCorchea)
                local idxVoz = (a % #vocesSuperiores) + 1
                local nUpper = SV:create("Note")
                nUpper:setTimeRange(bArp, durCorchea - 10)
                nUpper:setPitch(vocesSuperiores[idxVoz])
                nUpper:setLyrics("lu")
                nuevoGroupRef:addNote(nUpper)
                notasCreadas = notasCreadas + 1
            end
        elseif ritmoIdx == 3 then
            -- Chop Electrónico Kinetic (Semicorcheas 1/16)
            local durSemi = math.floor(SV.QUARTER / 4)
            local patronChop = { 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1 }
            for s = 0, 15 do
                if patronChop[s + 1] == 1 then
                    local bChop = currBlick + (s * durSemi)
                    for v = 1, #vocesSuperiores do
                        local nUpper = SV:create("Note")
                        nUpper:setTimeRange(bChop, durSemi - 15)
                        nUpper:setPitch(vocesSuperiores[v])
                        nUpper:setLyrics("da")
                        nuevoGroupRef:addNote(nUpper)
                        notasCreadas = notasCreadas + 1
                    end
                end
            end
        else
            -- Bajo Alternado + Acorde Strum
            local durPulso = SV.QUARTER
            for p = 0, 3 do
                local bPulse = currBlick + (p * durPulso)
                if p == 1 or p == 3 then
                    for v = 1, #vocesSuperiores do
                        local nUpper = SV:create("Note")
                        nUpper:setTimeRange(bPulse, durPulso - 25)
                        nUpper:setPitch(vocesSuperiores[v])
                        nUpper:setLyrics("pa")
                        nuevoGroupRef:addNote(nUpper)
                        notasCreadas = notasCreadas + 1
                    end
                end
            end
        end

        currBlick = currBlick + durCompasBlicks
    end

    return notasCreadas
end
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
