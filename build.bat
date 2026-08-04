@echo off
chcp 65001 > NUL
setlocal enabledelayedexpansion

set "DEST_DIR=C:\Users\danny\AppData\Roaming\Dreamtonics\Synthesizer V Studio 2\scripts"
set "DEST_FILE=%DEST_DIR%\MapeadorExpresivo.lua"
set "LOCAL_FILE=%~dp0MapeadorExpresivo.lua"
set "SRC_DIR=%~dp0src"

echo ===============================================================================
echo   Compilador de Mapeador Expresivo Pro 3 - Synthesizer V Studio Pro 2
echo ===============================================================================

if not exist "%DEST_DIR%" (
    echo [*] Creando directorio de destino de Synthesizer V...
    mkdir "%DEST_DIR%"
)

echo [*] Uniendo modulos Lua...
type "%SRC_DIR%\00_Header_Metadata.lua" "%SRC_DIR%\01_I18n_Localization.lua" "%SRC_DIR%\02_Presets_ExpressionData.lua" "%SRC_DIR%\03_Tokenizer_MelodyGen.lua" "%SRC_DIR%\04_Hermite_AutomationEngine.lua" "%SRC_DIR%\06_HarmonyEngine.lua" "%SRC_DIR%\07_CounterpointGen.lua" "%SRC_DIR%\08_ChordProgressionEngine.lua" "%SRC_DIR%\05_UI_MainController.lua" > "%DEST_FILE%"


if errorlevel 1 (
    echo [ERROR] Ocurrio un error al compilar los modulos.
    exit /b 1
)

copy /Y "%DEST_FILE%" "%LOCAL_FILE%" > NUL

echo [OK] Script compilado exitosamente.
echo [OUT] Desplegado en: %DEST_FILE%
echo [OUT] Copia local en: %LOCAL_FILE%
echo ===============================================================================
