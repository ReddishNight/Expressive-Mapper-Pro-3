# Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/version-3.6.1-brightgreen)
![Compatibility](https://img.shields.io/badge/SynthV%20Studio%202-PRO%20v2.2.1%2B-purple)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Support%20Development-ff5e5b?logo=ko-fi&logoColor=white)](https://ko-fi.com/nyorux555)

> **Vocal Expressiveness, Prosodic Text-to-Melody Synthesis, Hermite/TCB Spline Automation, Just Intonation Harmony, Strict Fuxian Counterpoint & Minimum-Energy Voice Leading Engine for Synthesizer V Studio 2 PRO.**

---

🌐 **Languages / Idiomas / 言語**: **[English](README.md)** | **[Español](README.es.md)** | **[日本語](README.ja.md)**

---

## ☕ Support & Donations

If **Expressive Mapper Pro 3** saves you time, improves your Synthesizer V workflow, or helps you create amazing music, consider supporting ongoing development!

<p align="center">
  <a href="https://ko-fi.com/nyorux555" target="_blank">
    <img src="https://storage.ko-fi.com/cdn/kofi2.png?v=3" alt="Buy Me a Coffee at Ko-fi" height="48">
  </a>
</p>

> 💖 **[Support Nyoru.X on Ko-fi](https://ko-fi.com/nyorux555)**  
> Your voluntary contributions help keep updates, new features, and technical support free for everyone!

---

## 🚀 Overview

**Expressive Mapper Pro 3** is a state-of-the-art modular script designed for **Synthesizer V Studio 2 PRO (v2.2.1+ / Build 67072+)** by **Nyoru.X**. 

It provides an end-to-end data-oriented engine capable of transforming raw lyrics into expressive vocal pitch, tension, volume, breath, and vocal mode automations with **zero runtime GC allocations**.

---

## ✨ Key Features & Operating Modes

| Mode | Name | Feature Description |
| :--- | :--- | :--- |
| **Mode 0** | **Prosodic Note Generation** | RAE-compliant prosodic text-to-melody synthesis with emotional intonation curves, hiatus/diphthong phoneme mapping, and accentuation logic. |
| **Mode 1** | **Hermite / TCB Automation** | Kochanek-Bartels (TCB) Spline curves for Pitch, Tension, Breath, Gender, Voicing, and Vocal Modes with Ramer-Douglas-Peucker (RDP) node optimization. |
| **Mode 2** | **Just Intonation Vocal Harmony** | Diatonic Just Intonation choir/duo generation with micro-tuning offsets (-14c on 3rd Maj, +16c on 3rd Min) and voice register formant scaling. |
| **Mode 3** | **Strict Fuxian Counterpoint** | Algorithmic countermelody generator adhering to strict 5-species Fuxian counterpoint rules (delay resolution, jump compensation, unique climax). |
| **Mode 4** | **Minimum Energy Chord Generator** | Chord progression synthesis powered by a minimum energy matrix voice leading algorithm ($\sum \Delta \text{pitch}^2$) with customizable micro-swing. |

---

## ⚡ Quick Installation (For End Users)

If you only want to install and run the script in **Synthesizer V Studio**:

1. Download the compiled executable script: **[`Expressive_Mapper_Pro_3.lua`](Expressive_Mapper_Pro_3.lua)** (or get the latest release from [Releases](../../releases)).
2. Copy `Expressive_Mapper_Pro_3.lua` into your Synthesizer V Studio script directory:
   - **Windows:** `C:\Users\<YourUsername>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. Open **Synthesizer V Studio**, go to **Scripts > Rescan Scripts** (or restart the application).
4. Select target notes or track, and run `Mapeador Expresivo Pro 3` from the **Scripts** menu.

---

## 📘 Official PDF Manuals

Comprehensive multi-page PDF documentation is available in three languages:

- 🌎 **[Official Spanish Manual (PDF)](Expressive_Mapper_Pro_3_Manual_ES.pdf)**
- 🇺🇸 **[Official English Manual (PDF)](Expressive_Mapper_Pro_3_Manual_EN.pdf)**
- 🇯🇵 **[Official Japanese Manual (PDF)](Expressive_Mapper_Pro_3_Manual_JA.pdf)**

---

## 🛠️ Repository & Source Code Architecture

```text
Expressive-Mapper-Pro-3/
├── src/                                     # Modular Lua source code
│   ├── 00_Header_Metadata.lua               # Script metadata & SynthV client signature
│   ├── 01_I18n_Localization.lua             # Full I18n dictionary (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # Vocal presets & expression data curves
│   ├── 03_Tokenizer_MelodyGen.lua           # Lyric tokenizer & prosodic melody generator
│   ├── 04_Hermite_AutomationEngine.lua      # Hermite / TCB spline automation engine
│   ├── 05_UI_MainController.lua             # Dynamic UI dialogs & execution orchestrator
│   ├── 06_HarmonyEngine.lua                 # Diatonic Just Intonation harmony engine
│   ├── 07_CounterpointGen.lua               # Fuxian 5-species counterpoint generator
│   └── 08_ChordProgressionEngine.lua        # Minimum energy voice leading chord engine
├── docs/                                    # PDF manual build tools & HTML templates
├── Expressive_Mapper_Pro_3_Manual_ES.pdf   # Official Manual (Spanish)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf   # Official Manual (English)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf   # Official Manual (Japanese)
├── Expressive_Mapper_Pro_3.lua              # 🚀 Final compiled standalone Lua script
├── build.bat                                # One-click Windows batch compiler
├── README.md                                # Main Documentation (English)
├── README.es.md                             # Documentación en Español
└── README.ja.md                             # ドキュメント (日本語)
```

### Building from Source
To compile the modular source files in `src/` into the final `Expressive_Mapper_Pro_3.lua` script, run:

```powershell
build.bat
```

---

## 📄 Credits & License

- **Author:** Nyoru.X
- **Support / Donations:** [Ko-fi.com/nyorux555](https://ko-fi.com/nyorux555)
- **License:** [MIT License](LICENSE)
- **Environment:** Lua 5.4 / LuaJIT (Synthesizer V Studio 2 PRO API)
- **Minimum Editor Version:** Build 67072+ (v2.2.1+)
