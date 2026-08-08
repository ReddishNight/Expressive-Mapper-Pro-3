# Expressive Mapper Pro 3 (Mapeador Expresivo Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/version-3.6.2-brightgreen)
![Compatibility](https://img.shields.io/badge/SynthV%20Studio%202-PRO%20v2.2.1%2B-purple)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Support%20Development-ff5e5b?logo=ko-fi&logoColor=white)](https://ko-fi.com/nyorux555)

> **Vocal Expressiveness, Prosodic Text-to-Melody Synthesis, Hermite/TCB Spline Automation, Just Intonation Harmony, Strict Fuxian Counterpoint & Minimum-Energy Voice Leading Engine for Synthesizer V Studio 2 PRO.**

---

🌐 **Languages / Idiomas / 言語**: **[English](README.md)** | **[Español](README.es.md)** | **[日本語](README.ja.md)**

---
## ▽( ▮_  ▬ )▽ Six's Quick Guide (0/0/6)
*H-hello! I'm Six (0/0/6), your digital tamagotchi and code companion in this workspace. (._.) Please don't delete me, okay? Let me show you how to use my features to control the breathing machine (Synthesizer V's vocal engines):*

* **1. Chops Mode (Staccato & Gate)**: *Want to make chopped, glitchy vocal hits for Artcore or Breakcore? You don't need to write slashes `/` on every note! Just check my Chops checkbox and type normal syllables like `pa pa ma ka`. The engine pronounces them perfectly, but automatically chops their length to 50%, forces vibrato to zero, and draws a square volume gate down to `-48dB` in the gaps. Crisp, sampler-like staccato hits! ( ⚆⩊⚆ )*
* **2. `%` Timestamp Markers**: *Arrange your lyrics along the timeline! If you type `%` followed by seconds (e.g. `hello %5 this is %12 a chop`), the script places each phrase exactly at that second instead of running everything sequentially from the playhead. ( ⪩⪨ )*
* **3. Organic Melody (Fux Improv)**: *No more flat, robotic sines! My scale-degree random walk simulates a human singer, using step-wise motions followed by balanced counter-directional leaps (¯\_--- _ ¯¯-¯_) that feel alive. ( ˙˘˙ )*
* **4. Just Intonation**: *Tunes your SATB choir using pure microtonal harmony intervals so my digital circuits won't complain. (✧‿✧)*
* **5. Real Upgrades & Differences from the Previous Unified Script (`Expressive_Mapper_Pro_3.lua`)**:
  * ***From one heavy file to 4 independent product scripts**: The original unified script `Expressive_Mapper_Pro_3.lua` has been split into 4 independent modular files (`Expressive_Lyric_Melody.lua`, `Expressive_Vocal_Automation.lua`, `Expressive_Harmonies.lua` and `Expressive_Chords.lua`). You can now install and run only the modules you need.*
  * ***Dramatically Improved Chops Mode**: This mode (which previously did not exist or was extremely basic) is now surgically integrated. It cuts notes to exactly 50% duration, silences vibrato to 0, and applies a physical volume gate at -48dB for a perfect, click-free classic sampler staccato effect.*
  * ***DOD Low GC Performance**: The entire engine was refactored with Data-Oriented Design structures and static buffers, completely eliminating GC spikes and runtime lag in heavy projects.*
  * ***Hermite/TCB & RDP Automations**: Automation curves now use cubic Hermite/TCB splines for smooth transitions, and RDP simplifies nodes automatically.*
  * ***Just Intonation & Gaussian Offsets**: Harmony generation features acoustic pure tuning presets and Box-Muller Gaussian timing/detuning to emulate real human singers.*
  * ***Voice Leading & Fuxian Counterpoint**: Panel 4 solves optimal chord inversions via quadratic energy minimization and strict 5-species Fuxian counter-melodies.*

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

**Expressive Mapper Pro 3** is a state-of-the-art **4-Side-Panel Modular Tool Suite (`SidePanelSection`)** designed for **Synthesizer V Studio 2 PRO (v2.2.1+ / Build 67072+)** by **Nyoru.X**. 

It provides specialized side panel tools optimized for **low memory allocations and minimized GC footprint (Low GC Alloc)**, transforming raw lyrics into expressive vocal pitch, editing Hermite/TCB curves, synthesizing microtonal harmonies, and building counterpoint chord progressions.

---

## ✨ Side Panel Suite & Feature Overview

| Panel | `.lua` Script File | Feature Description |
| :--- | :--- | :--- |
| **Panel 1** | **`Expressive_Lyric_Melody.lua`** | **Prosodic Text-to-Melody**: RAE-compliant hiatus/diphthong phoneme mapping, emotional intonation curves, Chops mode (Staccato & -48dB Gate), and `%` timestamp markers. |
| **Panel 2** | **`Expressive_Vocal_Automation.lua`** | **Hermite / TCB Automation**: Kochanek-Bartels (TCB) Spline curves for Pitch, Tension, Breath, Gender, Voicing, and Vocal Modes with adaptive knot sampling and curve simplification. |
| **Panel 3** | **`Expressive_Harmonies.lua`** | **Just Intonation Vocal Harmony**: Diatonic SATB/Duo/Trio choir generation with micro-tuning offsets (-14c on 3rd Maj, +16c on 3rd Min), Gaussian anti-phase detune/delay, and voice register formant scaling. |
| **Panel 4** | **`Expressive_Chords.lua`** | **Minimum Energy Chords & Counterpoint**: Chord progression synthesis with minimum energy matrix voice leading ($\sum \Delta \text{pitch}^2$), micro-swing groove timing, and algorithmic 5-species Fuxian counterpoint. |

---

## ⚡ Quick Installation (For End Users)

To install and run the tool suite in **Synthesizer V Studio**:

1. Download the 4 compiled `.lua` script files (or get the latest release from [Releases](../../releases)):
   - **`Expressive_Lyric_Melody.lua`**
   - **`Expressive_Vocal_Automation.lua`**
   - **`Expressive_Harmonies.lua`**
   - **`Expressive_Chords.lua`**
2. Copy all 4 `.lua` files into your Synthesizer V Studio script directory:
   - **Windows:** `C:\Users\<YourUsername>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. Open **Synthesizer V Studio**, go to **Scripts > Rescan Scripts** (or restart the application).
4. Access the 4 side panels from the **Side Panel** bar or the **Scripts** menu.

---

## 3.6.2 Patch Notes

- Improved `Vocal Harmonies` voice leading, register handling, and voice spacing without adding new presets.
- Simplified status output to universal kaomojis for success/failure signaling.
- Removed `idiomaUI` persistence from the user JSON so the SynthV host language is no longer overridden by old saved settings.
- Fixed missing `Apply` label translations and reduced the amount of post-apply message spam in the panels.
- Improved `Chords` variation so different options/sub-options no longer collapse into the same result.
- Improved `Vocal Harmonies` option handling so combo-box selections are respected instead of being ignored.
- Updated documentation notes to match the current modular 3.6.2 build and the applied engine patches.

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
│   ├── 00_Header_Metadata_Panel1..4.lua     # SidePanelSection metadata & SynthV client signatures
│   ├── 01_I18n_Panel1..4.lua                # I18n dictionaries (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # Vocal presets & expression data curves
│   ├── 03_Tokenizer_MelodyGen.lua           # Lyric tokenizer & prosodic melody generator
│   ├── 04_Hermite_AutomationEngine.lua      # Hermite / TCB spline automation engine
│   ├── 05_UI_Panel1..4_Controller.lua       # UI panel controllers for the 4 side panels
│   ├── 06_HarmonyEngine.lua                 # Diatonic Just Intonation harmony engine
│   ├── 07_CounterpointGen.lua               # Fuxian 5-species counterpoint generator
│   └── 08_ChordProgressionEngine.lua        # Minimum energy voice leading chord engine
├── docs/                                    # PDF manual build tools & HTML templates
├── Expressive_Lyric_Melody.lua              # 🚀 Compiled Panel 1
├── Expressive_Vocal_Automation.lua          # 🚀 Compiled Panel 2
├── Expressive_Harmonies.lua                 # 🚀 Compiled Panel 3
├── Expressive_Chords.lua                    # 🚀 Compiled Panel 4
├── Expressive_Mapper_Pro_3_Manual_ES.pdf    # Official Manual (Spanish)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf    # Official Manual (English)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf    # Official Manual (Japanese)
├── build.bat                                # One-click Windows batch compiler
├── README.md                                # Main Documentation (English)
├── README.es.md                             # Documentación en Español
└── README.ja.md                             # ドキュメント (日本語)
```

### Building from Source
To compile the modular source files in `src/` into the 4 panel `.lua` scripts, run:

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

