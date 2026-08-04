# Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/version-3.0-brightgreen)

Mapeador Expresivo Pro 3 es un script avanzado para **Synthesizer V Studio** diseñado para automatizar dinámicas, curvas de expresión (pitch, tensión, volumen, aliento, etc.), síntesis melódica, contrapunto y progresiones armónicas de nivel profesional.

---

## ⚡ Instalación Rápida (Para Usuarios Finales)

Si solo deseas instalar y usar el script en **Synthesizer V Studio**:

1. Descarga el archivo ejecutable compilado: **[`MapeadorExpresivo.lua`](https://github.com/ReddishNight/Expressive-Mapper-Pro-3/raw/main/MapeadorExpresivo.lua)** (o accede a la sección de [Releases](../../releases)).
2. Copia el archivo `MapeadorExpresivo.lua` en la carpeta de scripts de tu Synthesizer V Studio:
   - **Windows:** `C:\Users\<TuUsuario>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. En Synthesizer V Studio, abre el menú **Scripts** y selecciona **Rescan Scripts** (o reinicia la aplicación).

---

## 📘 Manuales Oficiales (PDF)

Disponibles en el repositorio en múltiples idiomas:
- 🇲🇽 [Manual Oficial en Español](Mapeador_Expresivo_Pro_3_Manual_Oficial.pdf)
- 🇺🇸 [Official Manual in English](Mapeador_Expresivo_Pro_3_Manual_Official_EN.pdf)
- 🇯🇵 [公式マニュアル (日本語)](Mapeador_Expresivo_Pro_3_Manual_Official_JA.pdf)

---

## 🛠️ Estructura del Código Fuente (Para Desarrolladores)

El código fuente del proyecto está modularizado dentro de la carpeta `src/`:

- `src/00_Header_Metadata.lua`: Metadatos y firma del script para Synthesizer V.
- `src/01_I18n_Localization.lua`: Sistema de internacionalización (ES, EN, JA, ZH).
- `src/02_Presets_ExpressionData.lua`: Datos de expresión y presets musicales.
- `src/03_Tokenizer_MelodyGen.lua`: Tokenizador y generador de melodías.
- `src/04_Hermite_AutomationEngine.lua`: Motor de automatización e interpolación Hermite.
- `src/05_UI_MainController.lua`: Controlador de interfaz de usuario y diálogos.
- `src/06_HarmonyEngine.lua`: Motor de armonía.
- `src/07_CounterpointGen.lua`: Generador de contrapunto.
- `src/08_ChordProgressionEngine.lua`: Motor de progresiones armónicas.

### Compilador del Proyecto
Para compilar los módulos de `src/` en el archivo final `MapeadorExpresivo.lua`, ejecuta en la consola:
```powershell
build.bat
```
O mediante el script de Python:
```powershell
python build_html.py
```
