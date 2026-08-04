# Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/version-3.0-brightgreen)

Mapeador Expresivo Pro 3 es un script avanzado para **Synthesizer V Studio** diseñado para automatizar dinámicas vocales, curvas de expresión (pitch, tensión, volumen, aliento), síntesis melódica, contrapunto y progresiones armónicas de nivel profesional.

---

## ⚡ Instalación Rápida (Para Usuarios Finales)

Para instalar y usar el script en **Synthesizer V Studio**:

1. Descarga el archivo compilado: **[`MapeadorExpresivo.lua`](MapeadorExpresivo.lua)** (o accede a la sección de [Releases](../../releases)).
2. Copia `MapeadorExpresivo.lua` en la carpeta de scripts de tu Synthesizer V Studio:
   - **Windows:** `C:\Users\<TuUsuario>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. En Synthesizer V Studio, ve al menú **Scripts** y selecciona **Rescan Scripts** (o reinicia la aplicación).

---

## 📘 Manuales Oficiales (PDF)

Disponibles en el repositorio en tres idiomas:
- 🇲🇽 **[Manual Oficial en Español (PDF)](Mapeador_Expresivo_Pro_3_Manual_ES.pdf)**
- 🇺🇸 **[Official Manual in English (PDF)](Mapeador_Expresivo_Pro_3_Manual_EN.pdf)**
- 🇯🇵 **[公式マニュアル (日本語 PDF)](Mapeador_Expresivo_Pro_3_Manual_JA.pdf)**

---

## 🛠️ Estructura del Proyecto

```text
Expressive-Mapper-Pro-3/
├── src/                               # Código fuente modular (00_Header a 08_ChordProgression)
├── docs/                              # Herramientas de generación de documentación y plantillas
├── Mapeador_Expresivo_Pro_3_Manual_ES.pdf # Manual oficial (Español)
├── Mapeador_Expresivo_Pro_3_Manual_EN.pdf # Manual oficial (Inglés)
├── Mapeador_Expresivo_Pro_3_Manual_JA.pdf # Manual oficial (Japonés)
├── MapeadorExpresivo.lua              # 🚀 Script ejecutable compilado final
├── build.bat                          # Script de compilación rápida (.bat)
└── README.md                          # Documentación del repositorio
```

### Compilar desde el código fuente
Para compilar los módulos de `src/` en el archivo final `MapeadorExpresivo.lua`:
```powershell
build.bat
```
