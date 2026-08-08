@echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion

set "DEST_DIR=%APPDATA%\Dreamtonics\Synthesizer V Studio 2\scripts"
set "DEST_FILE=%DEST_DIR%\Expressive_Mapper_Pro_3.lua"
set "LOCAL_FILE=%~dp0Expressive_Mapper_Pro_3.lua"
set "SRC_DIR=%~dp0src"

echo ===============================================================================
echo   Compilador de Mapeador Expresivo Pro 3 - Synthesizer V Studio Pro 2
echo ===============================================================================

if not exist "%DEST_DIR%" (
    echo [*] Creando directorio de destino de Synthesizer V...
    mkdir "%DEST_DIR%"
)

echo [*] Compilando Panel 1: Expressive Lyric ^& Melody...
type "%SRC_DIR%\00_Header_Metadata_Panel1.lua" "%SRC_DIR%\01_I18n_Panel1.lua" "%SRC_DIR%\02_Presets_ExpressionData.lua" "%SRC_DIR%\03_Tokenizer_MelodyGen.lua" "%SRC_DIR%\04_Hermite_AutomationEngine.lua" "%SRC_DIR%\05_UI_Panel1_Controller.lua" > "%DEST_DIR%\Expressive_Lyric_Melody.lua"
copy /Y "%DEST_DIR%\Expressive_Lyric_Melody.lua" "%~dp0Expressive_Lyric_Melody.lua" > NUL

echo [*] Compilando Panel 2: Expressive Vocal Automation...
type "%SRC_DIR%\00_Header_Metadata_Panel2.lua" "%SRC_DIR%\01_I18n_Panel2.lua" "%SRC_DIR%\02_Presets_ExpressionData.lua" "%SRC_DIR%\03_Tokenizer_MelodyGen.lua" "%SRC_DIR%\04_Hermite_AutomationEngine.lua" "%SRC_DIR%\05_UI_Panel2_Controller.lua" > "%DEST_DIR%\Expressive_Vocal_Automation.lua"
copy /Y "%DEST_DIR%\Expressive_Vocal_Automation.lua" "%~dp0Expressive_Vocal_Automation.lua" > NUL

echo [*] Compilando Panel 3: Expressive Harmonies...
type "%SRC_DIR%\00_Header_Metadata_Panel3.lua" "%SRC_DIR%\01_I18n_Panel3.lua" "%SRC_DIR%\02_Presets_ExpressionData.lua" "%SRC_DIR%\03_Tokenizer_MelodyGen.lua" "%SRC_DIR%\04_Hermite_AutomationEngine.lua" "%SRC_DIR%\06_HarmonyEngine.lua" "%SRC_DIR%\05_UI_Panel3_Controller.lua" > "%DEST_DIR%\Expressive_Harmonies.lua"
copy /Y "%DEST_DIR%\Expressive_Harmonies.lua" "%~dp0Expressive_Harmonies.lua" > NUL

echo [*] Compilando Panel 4: Expressive Chords ^& Counterpoint...
type "%SRC_DIR%\00_Header_Metadata_Panel4.lua" "%SRC_DIR%\01_I18n_Panel4.lua" "%SRC_DIR%\02_Presets_ExpressionData.lua" "%SRC_DIR%\03_Tokenizer_MelodyGen.lua" "%SRC_DIR%\04_Hermite_AutomationEngine.lua" "%SRC_DIR%\06_HarmonyEngine.lua" "%SRC_DIR%\07_CounterpointGen.lua" "%SRC_DIR%\08_ChordProgressionEngine.lua" "%SRC_DIR%\05_UI_Panel4_Controller.lua" > "%DEST_DIR%\Expressive_Chords.lua"
copy /Y "%DEST_DIR%\Expressive_Chords.lua" "%~dp0Expressive_Chords.lua" > NUL

if errorlevel 1 (
    echo [ERROR] Ocurrio un error al compilar los modulos.
    exit /b 1
)

REM Eliminar el megascript unificado anterior para evitar conflictos de menu
if exist "%DEST_DIR%\Expressive_Mapper_Pro_3.lua" del "%DEST_DIR%\Expressive_Mapper_Pro_3.lua"
if exist "%~dp0Expressive_Mapper_Pro_3.lua" del "%~dp0Expressive_Mapper_Pro_3.lua"

echo [OK] Los 4 paneles laterales se compilaron y desplegaron exitosamente.
echo ===============================================================================

