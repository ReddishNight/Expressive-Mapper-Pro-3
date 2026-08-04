# Mapeador Expresivo Pro 3 (Expressive Mapper Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/versi%C3%B3n-3.6.1-brightgreen)
![Compatibilidad](https://img.shields.io/badge/SynthV%20Studio%202-PRO%20v2.2.1%2B-purple)
[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-yellow.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Apoyar%20Desarrollo-ff5e5b?logo=ko-fi&logoColor=white)](https://ko-fi.com/nyorux555)

> **Motor modular avanzado de expresividad vocal, síntesis melódica prosódica, automatización Hermite/TCB Splines, Armonía con Entonación Justa, Contrapunto Fuxiano Estricto y Voice Leading de energía mínima para Synthesizer V Studio 2 PRO.**

---

🌐 **Idiomas / Languages / 言語**: **[English](README.md)** | **[Español](README.es.md)** | **[日本語](README.ja.md)**

---

## ☕ Apoyo y Donaciones Voluntarias

Si **Mapeador Expresivo Pro 3** te ayuda a ahorrar tiempo, mejora tus producciones en Synthesizer V o te impulsa a crear nueva música, ¡puedes apoyar el desarrollo voluntariamente!

<p align="center">
  <a href="https://ko-fi.com/nyorux555" target="_blank">
    <img src="https://storage.ko-fi.com/cdn/kofi2.png?v=3" alt="Cómprame un café en Ko-fi" height="48">
  </a>
</p>

> 💖 **[Apoyar a Nyoru.X en Ko-fi](https://ko-fi.com/nyorux555)**  
> Tu contribución voluntaria permite mantener el desarrollo activo, añadir nuevas funciones y brindar soporte técnico gratuito para toda la comunidad.

---

## 🚀 Descripción General

**Mapeador Expresivo Pro 3** es un script modular de alto rendimiento diseñado para **Synthesizer V Studio 2 PRO (v2.2.1+ / Build 67072+)** creado por **Nyoru.X**.

Ofrece una arquitectura orientada a datos (Data-Oriented Design) con **0 asignaciones de memoria (GC Alloc = 0 Bytes en runtime)**, capaz de transformar sílabas de texto en notas melódicas expresivas y aplicar automatizaciones avanzadas de pitch, tensión, volumen, aliento, género, voicing y vocal modes.

---

## ✨ Funcionalidades Principales y Modos de Operación

| Modo | Nombre | Descripción de Funcionalidades |
| :--- | :--- | :--- |
| **Modo 0** | **Generación Prosódica desde Texto** | Generación de notas y melodías prosódicas RAE con curvas emocionales de entonación, mapeo de diptongos e hiatos, y acentuación fonémica. |
| **Modo 1** | **Automatización Hermite / TCB** | Curvas de automatización Kochanek-Bartels (TCB) para Pitch, Tensión, Aliento, Género y Vocal Modes con simplificación de nodos por algoritmo Ramer-Douglas-Peucker (RDP). |
| **Modo 2** | **Armonía Vocal con Entonación Justa** | Armonización diatónica para dúos y coros con afinación justa microtonal (-14c en 3ra Mayor, +16c en 3ra Menor) y escalamiento de formantes por registro. |
| **Modo 3** | **Contrapunto Fuxiano Estricto** | Generador algorítmico de contramelodías (5 especies de Fux) con resolución de retardos, compensación de saltos armónicos y clímax único obligatorio. |
| **Modo 4** | **Progresiones con Voice Leading Mínimo** | Generador de progresiones de acordes con matriz de conducción de voces de energía mínima ($\sum \Delta \text{pitch}^2$) y micro-swing configurable. |

---

## ⚡ Instalación Rápida (Para Usuarios Finales)

Si solo deseas instalar y ejecutar el script en **Synthesizer V Studio**:

1. Descarga el archivo compilado: **[`Expressive_Mapper_Pro_3.lua`](Expressive_Mapper_Pro_3.lua)** (o descarga la última versión desde [Releases](../../releases)).
2. Copia `Expressive_Mapper_Pro_3.lua` en la carpeta de scripts de tu Synthesizer V Studio:
   - **Windows:** `C:\Users\<TuUsuario>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. Abre **Synthesizer V Studio**, ve al menú **Scripts > Rescan Scripts** (o reinicia la aplicación).
4. Selecciona las notas o la pista objetivo y ejecuta `Mapeador Expresivo Pro 3` desde el menú de **Scripts**.

---

## 📘 Manuales Oficiales en PDF

El proyecto cuenta con manuales detallados en formato PDF multilenguaje:

- 🌎 **[Manual Oficial en Español (PDF)](Expressive_Mapper_Pro_3_Manual_ES.pdf)**
- 🇺🇸 **[Official Manual in English (PDF)](Expressive_Mapper_Pro_3_Manual_EN.pdf)**
- 🇯🇵 **[公式マニュアル (日本語 PDF)](Expressive_Mapper_Pro_3_Manual_JA.pdf)**

---

## 🛠️ Estructura del Proyecto y Código Fuente

```text
Expressive-Mapper-Pro-3/
├── src/                                     # Código fuente modular en Lua
│   ├── 00_Header_Metadata.lua               # Metadatos del script y firma para SynthV Studio
│   ├── 01_I18n_Localization.lua             # Diccionario completo de idiomas (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # Presets de estilo vocal y datos de expresión
│   ├── 03_Tokenizer_MelodyGen.lua           # Tokenizador de texto y generador prosódico
│   ├── 04_Hermite_AutomationEngine.lua      # Motor de automatización Hermite / TCB Splines
│   ├── 05_UI_MainController.lua             # Controlador de interfaz de usuario dinámica
│   ├── 06_HarmonyEngine.lua                 # Motor de armonías con Entonación Justa
│   ├── 07_CounterpointGen.lua               # Generador de contrapunto fuxiano estricto
│   └── 08_ChordProgressionEngine.lua        # Motor de progresiones y Voice Leading de energía mínima
├── docs/                                    # Herramientas de compilación de manuales PDF y plantillas
├── Expressive_Mapper_Pro_3_Manual_ES.pdf   # Manual Oficial (Español)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf   # Manual Oficial (Inglés)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf   # Manual Oficial (Japonés)
├── Expressive_Mapper_Pro_3.lua              # 🚀 Script ejecutable compilado final
├── build.bat                                # Script de compilación rápida para Windows
├── README.md                                # Documentación Principal (Inglés)
├── README.es.md                             # Documentación Oficial en Español
└── README.ja.md                             # ドキュメント (日本語)
```

### Compilador del Proyecto
Para compilar los módulos de la carpeta `src/` en el script ejecutable `Expressive_Mapper_Pro_3.lua`, ejecuta en la consola de comandos:

```powershell
build.bat
```

---

## 📄 Créditos y Licencia

- **Autor:** Nyoru.X
- **Donaciones / Ko-fi:** [Ko-fi.com/nyorux555](https://ko-fi.com/nyorux555)
- **Licencia:** [Licencia MIT](LICENSE)
- **Entorno:** Lua 5.4 / LuaJIT (Synthesizer V Studio 2 PRO API)
- **Versión Mínima del Editor:** Build 67072+ (v2.2.1+)
