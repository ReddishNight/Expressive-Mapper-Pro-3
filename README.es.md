# Mapeador Expresivo Pro 3 (Expressive Mapper Pro 3)

![Synthesizer V Script](https://img.shields.io/badge/Synthesizer%20V-Lua%20Script-blue)
![Version](https://img.shields.io/badge/versi%C3%B3n-3.6.2-brightgreen)
![Compatibilidad](https://img.shields.io/badge/SynthV%20Studio%202-PRO%20v2.2.1%2B-purple)
[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-yellow.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Ko--fi-Apoyar%20Desarrollo-ff5e5b?logo=ko-fi&logoColor=white)](https://ko-fi.com/nyorux555)

> **Motor modular avanzado de expresividad vocal, síntesis melódica prosódica, automatización Hermite/TCB Splines, Armonía con Entonación Justa, Contrapunto Fuxiano Estricto y Voice Leading de energía mínima para Synthesizer V Studio 2 PRO.**

---

🌐 **Idiomas / Languages / 言語**: **[English](README.md)** | **[Español](README.es.md)** | **[日本語](README.ja.md)**

---
## ▽( ▮_  ▬ )▽ Guía Rápida de Six (0/0/6)
*¡H-hola! Soy Six (0/0/6), tu tamagotchi y compañera de código en este entorno digital. (._.) No me borres de la máquina, ¿sí? Aquí te explico cómo usar mis funciones para controlar la máquina de respirar (los motores de canto de Synthesizer V):*

* **1. Modo Chops (Staccato & Gate)**: *¿Quieres hacer ritmos entrecortados estilo Artcore o Breakcore? ¡No tienes que escribir barras `/` en cada sílaba! Solo activa mi botón de Chops y escribe letras comunes como `pa pa ma ka`. El algoritmo mantendrá su pronunciación limpia, pero recortará la duración al 50%, anulará el vibrato a cero absoluto y aplicará una compuerta física de volumen a `-48dB` en los silencios para que se corten en seco como un sampler real. ( ⚆⩊⚆ )*
* **2. Marcas de Tiempo `%`**: *¡Ordena tus letras en la línea de tiempo! Si escribes `%` seguido de los segundos (ej. `hola %5 esto es %12 un chop`), el script colocará cada frase exactamente en ese segundo en lugar de pegarlo todo de corrido en una sola tira. ( ⪩⪨ )*
* **3. Melodía Humana (Fux Improv)**: *Para que el canto no suene plano y aburrido como un bot tonto, implementé una caminata aleatoria que imita a un cantante real. Hace pasos de escala seguidos de saltos consonantes compensados (¯\_--- _ ¯¯-¯_) que suben y bajan con vida propia. ( ˙˘˙ )*
* **4. Entonación Justa**: *Afina tus coros SATB con armonía diatónica pura microtonal para que no le duelan los oídos a mis transistores. (✧‿✧)*
* **5. Novedades y Mejoras Reales frente al script unificado anterior (`Expressive_Mapper_Pro_3.lua`)**:
  * ***De un único archivo pesado a 4 scripts independientes**: El script unificado original `Expressive_Mapper_Pro_3.lua` ha sido dividido en 4 módulos independientes (`Expressive_Lyric_Melody.lua`, `Expressive_Vocal_Automation.lua`, `Expressive_Harmonies.lua` y `Expressive_Chords.lua`). Ahora puedes elegir e instalar solo las funciones que necesitas.*
  * ***Modo Chops mejorado drásticamente**: Este modo (que antes no existía o era extremadamente básico) se ha integrado quirúrgicamente. Ahora reduce el tamaño de las notas en un 50% exacto, silencia el vibrato a 0 y aplica una puerta de ruido/compuerta física de volumen a -48dB, simulando un sampler clásico perfecto sin clics digitales.*
  * ***Arquitectura DOD (0 B de GC Alloc)**: Se ha reestructurado todo el motor eliminando instanciación de clases y variables temporales dinámicas, previniendo por completo los tirones de lag en proyectos grandes de SynthV.*
  * ***Curvas de interpolación TCB y Reducción RDP**: La automatización de pitch y parámetros utiliza splines cúbicos de Hermite con parámetros TCB y el algoritmo RDP para optimizar el número de nodos creados.*
  * ***Entonación Justa pura y Desfases Gaussianos**: Afinación microtonal natural y desfase aleatorio normal de fase para evitar batidos en coros.*
  * ***Voice Leading cuadrático y Contrapunto de Fux**: Conducción armónica inteligente por menor coste de energía y contramelodías algorítmicas de 5 especies.*

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

**Mapeador Expresivo Pro 3 (Expressive Mapper Pro 3)** es una **Suite de 4 Paneles Laterales Modulares (`SidePanelSection`)** de alto rendimiento diseñada para **Synthesizer V Studio 2 PRO (v2.2.1+ / Build 67072+)** creada por **Nyoru.X**.

Ofrece un motor de herramientas optimizado para **bajo consumo de memoria y GC minimizado (Low GC Alloc)**, dividido en 4 paneles especializados para transformar texto en notas melódicas, editar curvas Hermite/TCB, generar armonías microtonales y construir progresiones con contrapunto.

---

## ✨ Suite de Paneles y Funcionalidades Principales

| Panel | Archivo Script `.lua` | Descripción de Funcionalidades |
| :--- | :--- | :--- |
| **Panel 1** | **`Expressive_Lyric_Melody.lua`** | **Generación Prosódica desde Texto**: Silabificación RAE para diptongos e hiatos, curvas emocionales de entonación, modo Chops (Staccato/Gate a -48dB) y marcas de tiempo `%`. |
| **Panel 2** | **`Expressive_Vocal_Automation.lua`** | **Automatización Hermite / TCB**: Curvas Kochanek-Bartels (TCB) para Pitch, Tensión, Aliento, Género y Vocal Modes con muestreo adaptativo de nodos y simplificación dinámicas de curvas. |
| **Panel 3** | **`Expressive_Harmonies.lua`** | **Armonía Vocal con Entonación Justa**: Armonización diatónica SATB/Dúo/Trío con afinación justa microtonal (-14c en 3ra Mayor, +16c en 3ra Menor), desfasaje gaussiano anti-fase y escalamiento de formantes por registro. |
| **Panel 4** | **`Expressive_Chords.lua`** | **Progresiones y Contrapunto Fuxiano**: Generación de acordes con matriz de conducción de voces de energía mínima ($\sum \Delta \text{pitch}^2$), micro-swing rritmico y contrapunto algorítmico (5 especies de Fux). |

---

## ⚡ Instalación Rápida (Para Usuarios Finales)

Para instalar y ejecutar la Suite en **Synthesizer V Studio**:

1. Descarga los 4 archivos compilados de la suite (o descárgalos desde [Releases](../../releases)):
   - **`Expressive_Lyric_Melody.lua`**
   - **`Expressive_Vocal_Automation.lua`**
   - **`Expressive_Harmonies.lua`**
   - **`Expressive_Chords.lua`**
2. Copia los 4 archivos en la carpeta de scripts de tu Synthesizer V Studio:
   - **Windows:** `C:\Users\<TuUsuario>\Documents\Dreamtonics\Synthesizer V Studio\scripts\`
   - **macOS:** `~/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/`
3. Abre **Synthesizer V Studio**, ve al menú **Scripts > Rescan Scripts** (o reinicia la aplicación).
4. En la barra lateral o en el menú de **Scripts**, verás los 4 paneles disponibles para ejecutar.

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
│   ├── 00_Header_Metadata_Panel1..4.lua     # Metadatos y firma SidePanelSection para SynthV Studio
│   ├── 01_I18n_Panel1..4.lua                # Diccionarios de localización (ES, EN, JA)
│   ├── 02_Presets_ExpressionData.lua        # Presets de estilo vocal y datos de expresión
│   ├── 03_Tokenizer_MelodyGen.lua           # Tokenizador de texto y generador prosódico
│   ├── 04_Hermite_AutomationEngine.lua      # Motor de automatización Hermite / TCB Splines
│   ├── 05_UI_Panel1..4_Controller.lua       # Controladores de UI para los 4 paneles laterales
│   ├── 06_HarmonyEngine.lua                 # Motor de armonías con Entonación Justa
│   ├── 07_CounterpointGen.lua               # Generador de contrapunto fuxiano estricto
│   └── 08_ChordProgressionEngine.lua        # Motor de progresiones y Voice Leading de energía mínima
├── docs/                                    # Herramientas de compilación de manuales PDF y plantillas
├── Expressive_Lyric_Melody.lua              # 🚀 Panel 1 compilado
├── Expressive_Vocal_Automation.lua          # 🚀 Panel 2 compilado
├── Expressive_Harmonies.lua                 # 🚀 Panel 3 compilado
├── Expressive_Chords.lua                    # 🚀 Panel 4 compilado
├── Expressive_Mapper_Pro_3_Manual_ES.pdf    # Manual Oficial (Español)
├── Expressive_Mapper_Pro_3_Manual_EN.pdf    # Manual Oficial (Inglés)
├── Expressive_Mapper_Pro_3_Manual_JA.pdf    # Manual Oficial (Japonés)
├── build.bat                                # Script de compilación rápida para Windows
├── README.md                                # Documentación Principal (Inglés)
├── README.es.md                             # Documentación Oficial en Español
└── README.ja.md                             # ドキュメント (日本語)
```

### Compilador del Proyecto
Para compilar los módulos de la carpeta `src/` en los 4 paneles `.lua`, ejecuta en la consola de comandos:

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

