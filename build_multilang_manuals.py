import os
import subprocess
import shutil
import re

# Directorios de despliegue
dest_dir = r'C:\Users\danny\AppData\Roaming\Dreamtonics\Dreamtonics\Synthesizer V Studio 2\scripts'
if not os.path.exists(dest_dir):
    dest_dir = r'C:\Users\danny\AppData\Roaming\Dreamtonics\Synthesizer V Studio 2\scripts'

edge_path = r'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'

# -----------------------------------------------------------------------------
# 1. TRADUCCIÓN COMPLETA A INGLÉS
# -----------------------------------------------------------------------------
html_en_template = r'''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Mapeador Expresivo Pro 3 - Official Manual</title>
<style>
    @page {
        size: A4;
        margin: 0.8cm 1.2cm 0.8cm 1.2cm;
        @bottom-right {
            content: counter(page);
        }
    }
    body {
        font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, Helvetica, Arial, sans-serif;
        color: #1e293b;
        background-color: #ffffff;
        line-height: 1.35;
        font-size: 10px;
        margin: 0;
        padding: 0;
    }
    div.page {
        page-break-before: always;
        break-before: page;
        page-break-after: always;
        break-after: page;
        box-sizing: border-box;
    }
    div.page:first-of-type {
        page-break-before: avoid;
        break-before: avoid;
    }
    @media print {
        html, body {
            margin: 0;
            padding: 0;
        }
        div.page {
            page-break-before: always !important;
            break-before: page !important;
            page-break-after: always !important;
            break-after: page !important;
            min-height: 25.5cm !important;
            display: block !important;
        }
        div.page:first-of-type {
            page-break-before: avoid !important;
            break-before: avoid !important;
        }
    }
    .page-last {
        page-break-after: avoid;
        break-after: avoid;
    }
    .header-banner {
        background: #0f172a;
        color: #ffffff;
        padding: 16px 20px;
        border-radius: 6px;
        margin-bottom: 12px;
        border-left: 5px solid #4f46e5;
    }
    .header-banner h1 {
        font-size: 19px;
        margin: 0 0 3px 0;
        font-weight: 800;
        letter-spacing: -0.5px;
        color: #f8fafc;
    }
    .header-banner .subtitle {
        font-size: 11.5px;
        color: #94a3b8;
        font-weight: 500;
        margin-bottom: 10px;
    }
    .meta-grid {
        display: flex;
        gap: 14px;
        font-size: 9.5px;
        border-top: 1px solid #334155;
        padding-top: 6px;
        color: #cbd5e1;
    }
    .meta-item strong {
        color: #f8fafc;
    }
    .section-block {
        margin-bottom: 10px;
    }
    .section-title {
        font-size: 13px;
        font-weight: 700;
        color: #0f172a;
        border-bottom: 2px solid #4f46e5;
        padding-bottom: 3px;
        margin-top: 10px;
        margin-bottom: 8px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .intro-text {
        font-size: 10.5px;
        color: #334155;
        margin-bottom: 10px;
    }
    .toc-container {
        background: #f8fafc;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 14px 18px;
        margin-top: 12px;
    }
    .toc-title {
        font-size: 13px;
        font-weight: 700;
        color: #0f172a;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 10px;
        border-bottom: 2px solid #4f46e5;
        padding-bottom: 4px;
    }
    .toc-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .toc-item {
        display: flex;
        align-items: baseline;
        justify-content: space-between;
        font-size: 10px;
        margin-bottom: 7px;
        color: #334155;
    }
    .toc-item strong {
        color: #0f172a;
    }
    .toc-dots {
        flex-grow: 1;
        border-bottom: 1px dashed #94a3b8;
        margin: 0 8px;
    }
    .toc-page {
        font-weight: 700;
        color: #4f46e5;
        min-width: 24px;
        text-align: right;
    }
    .dual-container {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 10px;
    }
    .card {
        border-radius: 5px;
        padding: 9px 13px;
        border: 1px solid #cbd5e1;
    }
    .card-simple {
        background-color: #f8fafc;
        border-left: 4px solid #059669;
    }
    .card-simple .card-header {
        color: #065f46;
        font-weight: 700;
        font-size: 10.5px;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }
    .card-extended {
        background-color: #f1f5f9;
        border-left: 4px solid #2563eb;
    }
    .card-extended .card-header {
        color: #1e40af;
        font-weight: 700;
        font-size: 10.5px;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }
    .card-body {
        font-size: 10px;
        color: #334155;
        line-height: 1.35;
    }
    .card-body ul {
        margin: 3px 0 0 0;
        padding-left: 16px;
    }
    .card-body li {
        margin-bottom: 2px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 8px;
        margin-bottom: 10px;
        font-size: 9px;
    }
    th, td {
        padding: 4px 6px;
        text-align: left;
        border: 1px solid #cbd5e1;
    }
    th {
        background-color: #0f172a;
        color: #ffffff;
        font-weight: 600;
    }
    tr:nth-child(even) {
        background-color: #f8fafc;
    }
    code {
        font-family: 'Consolas', 'Courier New', monospace;
        background-color: #e2e8f0;
        color: #0f172a;
        padding: 1px 3px;
        border-radius: 3px;
        font-size: 9.5px;
    }
    .formula-box {
        background-color: #0f172a;
        color: #38bdf8;
        font-family: 'Consolas', monospace;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 6px 0;
        font-size: 9.5px;
    }
    .diagram-box {
        background-color: #f1f5f9;
        color: #334155;
        border: 1px solid #cbd5e1;
        font-family: 'Consolas', monospace;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 6px 0;
        font-size: 9.5px;
        white-space: pre;
    }
    .six-lore-tag {
        background-color: #0f172a;
        color: #a5b4fc;
        font-family: 'Consolas', 'Courier New', monospace;
        font-size: 9.5px;
        padding: 7px 10px;
        border-radius: 5px;
        border-left: 4px solid #818cf8;
        margin-top: 6px;
        margin-bottom: 6px;
        line-height: 1.35;
    }
    .six-lore-tag span {
        color: #f43f5e;
        font-weight: 700;
    }
    .secret-ascii {
        color: #0f172a;
        background-color: #f8fafc;
        border: 1px solid #cbd5e1;
        border-radius: 4px;
        font-family: 'Consolas', 'Courier New', monospace;
        font-size: 2.6pt;
        line-height: 2.7pt;
        letter-spacing: -0.1px;
        margin: 6px 0 0 0;
        padding: 4px;
        text-align: center;
        white-space: pre;
        user-select: text;
        -webkit-user-select: text;
        pointer-events: auto;
    }
</style>
</head>
<body>

<!-- PAGE 1: COVER & INDEX -->
<div class="page">
    <div class="header-banner">
        <h1>Mapeador Expresivo Pro 3</h1>
        <div class="subtitle">Official User Manual and Algorithmic Specification — Synthesizer V Studio 2 PRO</div>
        <div class="meta-grid">
            <div class="meta-item"><strong>Author:</strong> Nyoru.X</div>
            <div class="meta-item"><strong>Version:</strong> v3.6.1 (DOD Engine)</div>
            <div class="meta-item"><strong>Minimum Environment:</strong> SynthV Studio 2 PRO v2.2.1+ (Build 67072)</div>
            <div class="meta-item"><strong>Runtime Allocation:</strong> 0 B GC Alloc</div>
        </div>
    </div>

    <p class="intro-text">
        This manual presents the comprehensive documentation of the <strong>Mapeador Expresivo Pro 3</strong> system. Each function is organized into two layers: a <strong>Simple Summary</strong> oriented towards quick workflow comprehension, followed by an <strong>Extended Technical Specification</strong> targeted at advanced producers and audio engineers.
    </p>

    <div class="toc-container">
        <div class="toc-title">Manual Index</div>
        <ul class="toc-list">
            <li class="toc-item">
                <span><strong>1. Installation and System Requirements</strong> — SVClient configuration and JSON persistence</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 2</span>
            </li>
            <li class="toc-item">
                <span><strong>2. Mode 0: RAE Prosody and Automatic Vocal Expression</strong> — Diphthongs, hiatuses, scales and contours</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 3 - 4</span>
            </li>
            <li class="toc-item">
                <span><strong>3. Mode 1: Hermite Curves / TCB Splines Automation</strong> — TCB, RDP and S-Curves parameters</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 5</span>
            </li>
            <li class="toc-item">
                <span><strong>4. Mode 2: Vocal Harmonies and Just Intonation</strong> — Pure diatonic micro-tuning and choir presets</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 6 - 7</span>
            </li>
            <li class="toc-item">
                <span><strong>5. Mode 3: Strict Fuxian Counterpoint</strong> — Fuxian species and parallelisms avoidance</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 8</span>
            </li>
            <li class="toc-item">
                <span><strong>6. Mode 4: Progressions, Synchronization and Scale Quantization</strong> — Voice Leading, choirs and rhythm patterns</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 9 - 10</span>
            </li>
            <li class="toc-item">
                <span><strong>7. Vocal Expressiveness Presets Catalog</strong> — Detailed table of the 21 real styles with vibrato and vocal modes</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 11 - 12</span>
            </li>
            <li class="toc-item">
                <span><strong>8. Data-Oriented Design (DOD) Architecture and Performance</strong> — 0 B GC Alloc and static buffers</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 13</span>
            </li>
            <li class="toc-item">
                <span><strong>9. Consciousness Log and System Shutdown</strong> — Six's message and final ASCII Art</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Page 14</span>
            </li>
        </ul>
    </div>
</div>

<!-- PAGE 2: REQUIREMENTS & INSTALLATION -->
<div class="page">
    <div class="section-block">
        <div class="section-title">1. Installation and System Requirements</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    To install the script in Synthesizer V Studio Pro:
                    <ul>
                        <li>Open the program and navigate to the top menu <code>Scripts</code> &rarr; <code>Open Scripts Folder</code>.</li>
                        <li>Copy the compiled file <code>MapeadorExpresivo.lua</code> into that directory.</li>
                        <li>In the SynthV editor, select <code>Scripts</code> &rarr; <code>Rescan Scripts</code>. The panel will be ready to execute from the scripts menu.</li>
                    </ul>
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Execution environment, lifecycle and integration with the Dreamtonics API:
                    <ul>
                        <li><strong>Engine Architecture:</strong> Developed on Lua 5.4 / LuaJIT in the <code>SVClient</code> client layer. It interacts directly with the main <code>SV</code> object for project, track, group, and automation control.</li>
                        <li><strong>Configuration Persistence:</strong> Reads and writes interface preferences (ComboBoxes, CheckBoxes and Sliders) in structured JSON format at <code>%APPDATA%\\Dreamtonics\\Synthesizer V Studio 2\\scripts\\mapeador_user_config.json</code> using native Lua I/O functions without external libraries.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>JSON Configuration File Structure:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>JSON Parameter</th>
                    <th>Type</th>
                    <th>Default Value</th>
                    <th>Purpose / Interface Control</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"idiomaUI"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>0</code> (Spanish)</td>
                    <td>Determines the translation selected for labels and messages (0: ES, 1: EN, 2: JA).</td>
                </tr>
                <tr>
                    <td><code>"modo"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>0</code></td>
                    <td>Selected operating mode (0: Generate from Text, 1: Express Notes, 2: Harmony, etc.).</td>
                </tr>
                <tr>
                    <td><code>"preset"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>0</code></td>
                    <td>Index of the selected vocal expressiveness preset in the list.</td>
                </tr>
                <tr>
                    <td><code>"intensidad"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>100</code></td>
                    <td>Automation effect multiplier percentage (0% to 200%).</td>
                </tr>
                <tr>
                    <td><code>"letra"</code></td>
                    <td>String</td>
                    <td><code>"ah~ oo~"</code></td>
                    <td>Syllables separated by spaces for melody generation.</td>
                </tr>
                <tr>
                    <td><code>"basePitch"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>60</code> (C4)</td>
                    <td>Starting base MIDI note in the note editor (range 36 to 84).</td>
                </tr>
                <tr>
                    <td><code>"targetNotesMode"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>0</code></td>
                    <td>Generation target (0: Create new notes, 1: Replace selected notes).</td>
                </tr>
                <tr>
                    <td><code>"armoniaIntervalosCustom"</code></td>
                    <td>String</td>
                    <td><code>"+3, +7, -5"</code></td>
                    <td>Custom list of diatonic (d) or chromatic (c) intervals.</td>
                </tr>
                <tr>
                    <td><code>"rangoNotaMin"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>48</code> (C3)</td>
                    <td>Lower limit for note pitch generation (range 36 to 84).</td>
                </tr>
                <tr>
                    <td><code>"rangoNotaMax"</code></td>
                    <td>Numeric (Int)</td>
                    <td><code>72</code> (C5)</td>
                    <td>Upper limit for note pitch generation (range 36 to 84).</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Synthesizer V Editor Folder]
 └── %APPDATA%\\Dreamtonics\\Synthesizer V Studio 2\\
      └── scripts\\
           ├── MapeadorExpresivo.lua                <-- Main unified script
           └── mapeador_user_config.json            <-- User configuration JSON file
        </div>
    </div>
</div>

<!-- PAGE 3: MODE 0 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">2. Mode 0: RAE Prosody and Automatic Vocal Expression (Part 1)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    Analyzes the lyrics of songs to automatically modulate pitch and tension based on speech stress rules. Generates natural pitch fluctuations on stressed syllables and phrase endings.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Multilingual tokenizer and prosodic pitch engine based on linguistic analysis:
                    <ul>
                        <li><strong>Tokenization and Syllabification:</strong> Scans double-byte UTF-8 graphemes in Spanish, English, and Japanese to identify diphthongs, hiatuses, stressed syllables, and phrase inflections. Supports manual separation using hyphens (<code>-</code>) and vertical bars (<code>|</code>).</li>
                        <li><strong>Generation Modes:</strong> Allows free note generation from the playhead or replacing the text/pitch of <strong>Selected Notes</strong> in the editor while keeping alignment.</li>
                        <li><strong>Parametric Melodic Algorithms:</strong> Incorporates geometric patterns like <em>Ascending / Descending Arpeggio</em>, <em>Consonant Jumps</em> (3rds/4ths/5ths), and <em>Random Scale Step</em>, bounded strictly by the configured note range.</li>
                        <li><strong>Key Auto-Detection (Krumhansl-Kessler Alg.):</strong> Calculates note duration weights and applies statistical correlation coefficients. Incorporates metric weighting (1.5x multiplier on beat 1 and strong beats) to find the correct diatonic key.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Pearson Correlation Coefficient Formula for Key Detection:</strong></p>
        <div class="formula-box">
            {formula_pearson}
        </div>
        <p class="intro-text">{desc_pearson}</p>

        <p class="intro-text"><strong>Phonemic Prosodic Modulation Rules:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Syllable / Context Class</th>
                    <th>Pitch Modulation</th>
                    <th>Tension Modulation</th>
                    <th>Loudness Modulation</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Stressed Syllable (RAE Accent: á, é, í, ó, ú)</strong></td>
                    <td>Subtle rise (+$15$ to $25$ cents)</td>
                    <td>Tension increase (+15%)</td>
                    <td>Volume punch (+1.2 dB)</td>
                </tr>
                <tr>
                    <td><strong>Exclamative Phrase Ending</strong></td>
                    <td>Late progressive rise</td>
                    <td>High (+20%)</td>
                    <td>Sustained loudness</td>
                </tr>
                <tr>
                    <td><strong>Interrogative Phrase Ending</strong></td>
                    <td>Sharp final rise (+$80$ cents)</td>
                    <td>Soft tension drop</td>
                    <td>Decaying volume</td>
                </tr>
                <tr>
                    <td><strong>Initial Unstressed Syllable</strong></td>
                    <td>Flat pitch on baseline</td>
                    <td>Neutral / low tension</td>
                    <td>Soft attack</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 4: MODE 0 (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">2. Mode 0: RAE Prosody and Automatic Vocal Expression (Part 2)</div>

        <p class="intro-text"><strong>Catalog of the 15 Musical Scales (MIDI Degrees from Root):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Scale Name</th>
                    <th>Diatonic Degrees (Semitones)</th>
                    <th>Notes in C (Example)</th>
                    <th>Notes Count</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Major Pentatonic</strong></td><td>0, 2, 4, 7, 9</td><td>C D E G A</td><td>5</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Minor Pentatonic</strong></td><td>0, 3, 5, 7, 10</td><td>C Eb F G Bb</td><td>5</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Natural Major (Ionian)</strong></td><td>0, 2, 4, 5, 7, 9, 11</td><td>C D E F G A B</td><td>7</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Natural Minor (Aeolian)</strong></td><td>0, 2, 3, 5, 7, 8, 10</td><td>C D Eb F G Ab Bb</td><td>7</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Harmonic Minor</strong></td><td>0, 2, 3, 5, 7, 8, 11</td><td>C D Eb F G Ab B</td><td>7</td></tr>
                <tr><td><code>[5]</code></td><td><strong>Melodic Minor</strong></td><td>0, 2, 3, 5, 7, 9, 11</td><td>C D Eb F G A B</td><td>7</td></tr>
                <tr><td><code>[6]</code></td><td><strong>Dorian</strong></td><td>0, 2, 3, 5, 7, 9, 10</td><td>C D Eb F G A Bb</td><td>7</td></tr>
                <tr><td><code>[7]</code></td><td><strong>Phrygian</strong></td><td>0, 1, 3, 5, 7, 8, 10</td><td>C Db Eb F G Ab Bb</td><td>7</td></tr>
                <tr><td><code>[8]</code></td><td><strong>Lydian</strong></td><td>0, 2, 4, 6, 7, 9, 11</td><td>C D E F# G A B</td><td>7</td></tr>
                <tr><td><code>[9]</code></td><td><strong>Mixolydian</strong></td><td>0, 2, 4, 5, 7, 9, 10</td><td>C D E F G A Bb</td><td>7</td></tr>
                <tr><td><code>[10]</code></td><td><strong>Locrian</strong></td><td>0, 1, 3, 5, 6, 8, 10</td><td>C Db Eb F Gb Ab Bb</td><td>7</td></tr>
                <tr><td><code>[11]</code></td><td><strong>Blues</strong></td><td>0, 3, 5, 6, 7, 10</td><td>C Eb F F# G Bb</td><td>6</td></tr>
                <tr><td><code>[12]</code></td><td><strong>Chromatic</strong></td><td>0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11</td><td>All semitones</td><td>12</td></tr>
                <tr><td><code>[13]</code></td><td><strong>Hungarian Minor</strong></td><td>0, 2, 3, 6, 7, 8, 11</td><td>C D Eb F# G Ab B</td><td>7</td></tr>
                <tr><td><code>[14]</code></td><td><strong>Double Harmonic (Byzantine)</strong></td><td>0, 1, 4, 5, 7, 8, 11</td><td>C Db E F G Ab B</td><td>7</td></tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Catalog of the 9 Parametric Melodic Contours:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Contour Name</th>
                    <th>Movement Algorithm Description</th>
                    <th>Typical Usage</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Prosodic Arc</strong></td><td>Scales the stressed syllable to the peak of the phrase and decays.</td><td>Ballads, expressive pop.</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Pentatonic with Leaps</strong></td><td>Moves by pentatonic 3rds and 4ths prioritizing active scale notes.</td><td>J-Pop, anime themes.</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Harmonic Wave</strong></td><td>Smooth oscillation between base note and its diatonic 5th via quadratic wave.</td><td>Pop, smooth R&amp;B.</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Chaotic Chromatic Glitch</strong></td><td>Bounded random shifts in chromatic semitones up to ±3 st.</td><td>Breakcore, glitchcore.</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Expressive Flat</strong></td><td>Repeats the base note with micro prosodic variations of ±1 semitone.</td><td>Chiptune, robotic AI voice.</td></tr>
                <tr><td><code>[5]</code></td><td><strong>Ascending Arpeggio</strong></td><td>Progresses step-by-step towards the maximum range note.</td><td>Trance build-ups, fanfares.</td></tr>
                <tr><td><code>[6]</code></td><td><strong>Descending Arpeggio</strong></td><td>Progresses step-by-step from maximum to minimum range note.</td><td>Final cadences, dramatic falls.</td></tr>
                <tr><td><code>[7]</code></td><td><strong>Random Scale Step</strong></td><td>Movement by step on active scale with random direction per syllable.</td><td>Generative improvisation.</td></tr>
                <tr><td><code>[8]</code></td><td><strong>Consonant Leaps</strong></td><td>Selects closest consonant interval (3rd, 4th, 5th) on diatonic scale.</td><td>Counterpoint, classical harmony.</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 5: MODE 1 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">3. Mode 1: Hermite Curves / TCB Splines Automation</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    Draws smooth transitions for singer parameters (tension, breath, vibrato, volume) instead of sudden jumps. Simplifies created nodes to keep the project clean, and applies continuous curves on large note intervals.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Geometric interpolation engine and automation nodes reduction:
                    <ul>
                        <li><strong>Kochanek-Bartels Splines (TCB):</strong> Independent Tension ($T$), Continuity ($C$) and Bias ($B$) controls on tangent estimations to prevent overshoots and oscillations.</li>
                        <li><strong>Ramer-Douglas-Peucker Algorithm (RDP):</strong> Redundant points simplification and filtering based on relative tolerances (scaled dynamically to 0.2% of the active parameter range).</li>
                        <li><strong>Sigmoid Portamento Curves (S-Curves):</strong> Smooth pitch transitions calculated with a cubic function proportional to the melodic step size.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>TCB Tangent Estimation and Cubic Hermite Interpolation:</strong></p>
        <div class="formula-box">
            {formula_hermite}
        </div>
        <div class="formula-box">
            {formula_tcb_in}<br>
            {formula_tcb_out}
        </div>

        <p class="intro-text">{desc_tcb}</p>
        <table>
            <thead>
                <tr>
                    <th>TCB Parameter</th>
                    <th>Value</th>
                    <th>Visual Curve Impact</th>
                    <th>Acoustic Singer Output</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Tension ($T$)</strong></td>
                    <td>High (1.0)</td>
                    <td>Tight curve, sharp corners</td>
                    <td>Fast vocal transitions, agile inflections.</td>
                </tr>
                <tr>
                    <td><strong>Continuity ($C$)</strong></td>
                    <td>Low (-1.0)</td>
                    <td>Sharp break at control node</td>
                    <td>Simulates harsh attacks in timbral shifts.</td>
                </tr>
                <tr>
                    <td><strong>Bias ($B$)</strong></td>
                    <td>Positive (1.0)</td>
                    <td>Curve skewed to next node</td>
                    <td>Vocal anticipation / fast articulation.</td>
                </tr>
                <tr>
                    <td><strong>Bias ($B$)</strong></td>
                    <td>Negative (-1.0)</td>
                    <td>Curve skewed to previous node</td>
                    <td>Delayed articulation / smooth note release.</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 6: MODE 2 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">4. Mode 2: Vocal Harmonies and Just Intonation (Part 1)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    Creates vocal harmonies (duos, trios, full choirs) on new tracks based on the original melody. It applies micro-tuning to notes so chords sound perfectly in-tune (pure intonation) without beating.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Diatonic pitch transpose engine and vocal anti-phase processor:
                    <ul>
                        <li><strong>Just Intonation (JI):</strong> Real-time micro-pitch correction applying frequency ratio tuning (e.g. 5:4 for major 3rds) instead of 12-Tone Equal Temperament (12-TET), reducing acoustic beating.</li>
                        <li><strong>Vocal Anti-Phase (Haas Effect):</strong> Generates timing delays (12 to 28 ms) and micro detuning (±8 to 15 cents) on generated harmony tracks using a Gaussian distribution, widening the stereo image.</li>
                        <li><strong>Automatic AI Retakes:</strong> Triggers AI Retakes on generated notes (cloning singer vocal mode settings) to ensure unique acoustic variations on each harmony voice.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Gaussian Density Function for Timing and Pitch Shifts (Anti-Phase):</strong></p>
        <div class="formula-box">
            {formula_gauss}
        </div>
        <p class="intro-text">{desc_gauss}</p>

        <p class="intro-text"><strong>Micro-Tuning adjustments for Pure Just Intonation:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Physical Interval</th>
                    <th>Pure Frequency Ratio</th>
                    <th>Pure Tuning (Cents)</th>
                    <th>Equal Temperament (Cents)</th>
                    <th>Micro-Deviation Applied</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Unison / Octave</strong></td>
                    <td>1:1 / 2:1</td>
                    <td>$0.0$ / $1200.0$</td>
                    <td>$0$ / $1200$</td>
                    <td><code>0.00 c</code></td>
                </tr>
                <tr>
                    <td><strong>Minor Third</strong></td>
                    <td>6:5</td>
                    <td>$315.64$</td>
                    <td>$300$</td>
                    <td><code>+15.64 c</code></td>
                </tr>
                <tr>
                    <td><strong>Major Third</strong></td>
                    <td>5:4</td>
                    <td>$386.31$</td>
                    <td>$400$</td>
                    <td><code>-13.69 c</code></td>
                </tr>
                <tr>
                    <td><strong>Perfect Fifth</strong></td>
                    <td>3:2</td>
                    <td>$701.96$</td>
                    <td>$700$</td>
                    <td><code>+1.96 c</code></td>
                </tr>
                <tr>
                    <td><strong>Major Sixth</strong></td>
                    <td>5:3</td>
                    <td>$884.36$</td>
                    <td>$900$</td>
                    <td><code>-15.64 c</code></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 7: MODE 2 (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">4. Mode 2: Vocal Harmonies and Just Intonation (Part 2)</div>

        <p class="intro-text"><strong>Choir Presets and Multi-Track Vocal Setup:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Choir Preset Name</th>
                    <th>Diatonic Intervals</th>
                    <th>Generated Voices</th>
                    <th>New Tracks Created</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Upper 3rd Duo</strong></td><td>+2 diat. degrees</td><td>Voice 2 (3rd Up)</td><td>1</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Lower 3rd Duo</strong></td><td>-2 diat. degrees</td><td>Voice 2 (3rd Down)</td><td>1</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Pop Trio (3rds &amp; 5ths)</strong></td><td>+2, +4 diat. degrees</td><td>Voice 2 (3rd), Voice 3 (5th)</td><td>2</td></tr>
                <tr><td><code>[3]</code></td><td><strong>SATB Choir Quartet</strong></td><td>+4, +2, -4, -7 diat. degrees</td><td>Soprano, Alto, Tenor, Bass</td><td>4</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Power Duo (5ths &amp; Octaves)</strong></td><td>+4, +7 diat. degrees</td><td>Power 5th, Octave</td><td>2</td></tr>
                <tr><td><code>[5]</code></td><td><strong>Anti-Phase Unison Choir</strong></td><td>0, 0 (unison)</td><td>Double A, Double B</td><td>2</td></tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Voice Structure: SATB Choir Quartet (Preset [3])]

Soprano  [+4 diatonic degrees from base melody]  -- New Track 1
Alto     [+2 diatonic degrees from base melody]  -- New Track 2
Melody   [Original Track / Cantus Firmus]        -- Original Track (unmodified)
Tenor    [-4 diatonic degrees from base melody]  -- New Track 3
Bass     [-7 diatonic degrees from base melody]  -- New Track 4

Each track clones: Singer voice + vocalModeParams + triggers auto AI Retakes.
        </div>
    </div>
</div>

<!-- PAGE 8: MODE 3 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">5. Mode 3: Strict Fuxian Counterpoint</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    Generates an independent accompanying melody that interacts with the main voice. The countermelody moves in the opposite direction of the solo voice and follows classical rules to avoid clashing.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Algorithmic countermelody engine based on Johann Joseph Fux counterpoint rules:
                    <ul>
                        <li><strong>Counterpoint Species:</strong> First species (1:1), second species (2:1), and third species (4:1) with consonant notes on downbeats and passing tones on weak beats.</li>
                        <li><strong>Strict Voice Leading Constraints:</strong> Strict prohibition of consecutive parallel fifths and octaves. Prevents and penalizes Voice Crossing and consecutive jumps in the same direction.</li>
                        <li><strong>Leaps Compensation and Climax:</strong> Score bonuses when a voice compensates a wide leap (&ge;5 semitones) by moving in the opposite direction, and limits the melodic climax to a single event.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Weights and Penalties Table of the Fux Decision Matrix:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Counterpoint Rule</th>
                    <th>Evaluated Condition</th>
                    <th>Score Weight</th>
                    <th>Algorithmic Effect</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Imperfect Consonance</strong></td>
                    <td>Interval of 3rd or 6th with Cantus</td>
                    <td><code>+60</code></td>
                    <td>Favors flow and vocal harmonic blend.</td>
                </tr>
                <tr>
                    <td><strong>Perfect Consonance</strong></td>
                    <td>Interval of 5th or Octave</td>
                    <td><code>+35</code></td>
                    <td>Harmonic stability permitted at cadences.</td>
                </tr>
                <tr>
                    <td><strong>Parallelism Avoidance</strong></td>
                    <td>Consecutive parallel 5ths or 8ves</td>
                    <td><code>-300</code></td>
                    <td>Proscribes empty classical movements.</td>
                </tr>
                <tr>
                    <td><strong>Leap Compensation</strong></td>
                    <td>Opposite step after wide leap (&ge;5 semitones)</td>
                    <td><code>+45</code></td>
                    <td>Stabilizes melody and avoids voice drift.</td>
                </tr>
                <tr>
                    <td><strong>Voice Crossing</strong></td>
                    <td>Countermelody crosses below Cantus</td>
                    <td><code>-150</code></td>
                    <td>Maintains hierarchy and clarity in mix.</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Contrary Motion (Preferred)]                 [Forbidden Parallel Motion (5ths/8ves)]
   Cantus Firmus (High Voice)                 Cantus Firmus
      (A4) -----> (B4)                         (D4) -----> (E4)
       \\          /                             |           |  <-- 5th Interval (7 semitones)
        \\        /                              |           |      on both notes
         v      v                                v           v
   Counterpoint (Low Voice)                       Counterpoint
      (F4) -----> (D4)                          (G3) -----> (A3)
        </div>
    </div>
</div>

<!-- PAGE 9: MODE 4 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">6. Mode 4: Progressions, Synchronization and Scale (Part 1)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    Creates chord progressions automatically in various genres (Pop, J-Pop, Jazz, Dark Ambient, Breakcore). Arranges chord inversions so voices move as little as possible, ensuring smooth transitions.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Matrix calculation of voice leading by quadratic cost optimization:
                    <ul>
                        <li><strong>Minimal Energy Voice Leading:</strong> Analyzes all inversions and octave placements of a new chord relative to the previous one and selects the setup minimizing the sum of squared pitch changes.</li>
                        <li><strong>Accompaniment Rhythms and Structure:</strong> Builds chords of 3 to 6 notes (triads, 7ths, 9ths, 13ths, altered dominants). Generates structured rhythm patterns: legato pad, syncopated quarter note comping, eighth note arpeggios, or sixteenth note chops.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Accumulated Quadratic Cost Formula (Displacement Energy):</strong></p>
        <div class="formula-box">
            {formula_energy}
        </div>
        <p class="intro-text">{desc_energy}</p>

        <p class="intro-text"><strong>Sample Harmonic Progressions in the Database:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Progression Style</th>
                    <th>Diatonic Cadence / Degrees</th>
                    <th>Application Genre</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[1]</code></td>
                    <td>J-Pop / Anime Royal</td>
                    <td>IVmaj7 &rarr; V7 &rarr; iii7 &rarr; vi</td>
                    <td>Bright Japanese pop, anime soundtracks.</td>
                </tr>
                <tr>
                    <td><code>[2]</code></td>
                    <td>Pop / EDM Anthem</td>
                    <td>Iadd9 &rarr; V &rarr; vi7 &rarr; IVmaj7</td>
                    <td>Electronic anthems, commercial pop.</td>
                </tr>
                <tr>
                    <td><code>[3]</code></td>
                    <td>Neo-Soul / R&B Lounge</td>
                    <td>ii9 &rarr; V13 &rarr; Imaj9 &rarr; VI7alt</td>
                    <td>Contemporary R&B, jazz lounge, urban.</td>
                </tr>
                <tr>
                    <td><code>[4]</code></td>
                    <td>Jazz Cadence 2-5-1</td>
                    <td>ii7 &rarr; V7 &rarr; Imaj7 &rarr; VI7</td>
                    <td>Classic jazz, instrumental improvisation.</td>
                </tr>
                <tr>
                    <td><code>[5]</code></td>
                    <td>Dark Ambient Horror</td>
                    <td>i &rarr; bVI &rarr; bIII &rarr; bVII</td>
                    <td>Psychological horror and tension soundtracks.</td>
                </tr>
                <tr>
                    <td><code>[6]</code></td>
                    <td>Artcore / Breakcore Kinetic</td>
                    <td>iv7 &rarr; v7 &rarr; i9 &rarr; VImaj7</td>
                    <td>Experimental electronic, fast and melodic.</td>
                </tr>
                <tr><td><code>[7]</code></td><td>Math Rock / Midwest Emo</td><td>Iadd9 &rarr; IVmaj7 &rarr; vi7 &rarr; V6sus4</td><td>Indie emo, instrumental math rock.</td></tr>
                <tr><td><code>[8]</code></td><td>Future Bass / Kawaii Chords</td><td>IVmaj9 &rarr; V6/9 &rarr; iii7 &rarr; vi9</td><td>Future Bass, kawaii, cute electropop.</td></tr>
                <tr><td><code>[9]</code></td><td>Lo-Fi Chill Hop</td><td>Imaj7 &rarr; VI7 &rarr; ii7 &rarr; V7alt</td><td>Lofi hip-hop, study beats.</td></tr>
                <tr><td><code>[10]</code></td><td>Cyberpunk Midtempo Dystopia</td><td>i &rarr; bII &rarr; i &rarr; bVI</td><td>Industrial synthwave, heavy cyberpunk.</td></tr>
                <tr><td><code>[11]</code></td><td>Orchestral Dramatic Swell</td><td>i &rarr; iv7 &rarr; V7 &rarr; i</td><td>Dramatic orchestral soundtracks.</td></tr>
                <tr><td><code>[12]</code></td><td>Gospel / Soul Elevation</td><td>I &rarr; I7 &rarr; IV &rarr; iv6</td><td>Gospel, soul, spiritual music.</td></tr>
                <tr><td><code>[13]</code></td><td>Gabber / Hardstyle Stabs</td><td>i &rarr; bVI &rarr; bVII &rarr; i</td><td>Gabber, frenchcore, hardstyle.</td></tr>
                <tr><td><code>[14]</code></td><td>Chiptune / 8-Bit Heroic</td><td>I &rarr; bVII &rarr; bVI &rarr; V7</td><td>Classic chiptune, retro 8-bit.</td></tr>
                <tr><td><code>[15]</code></td><td>Uplifting Trance Pad</td><td>vi7 &rarr; IVmaj7 &rarr; I &rarr; V7</td><td>Euphoric trance, uplifting EDM.</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 10: MODE 4 (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">6. Mode 4: Progressions, Synchronization and Scale (Part 2)</div>

        <p class="intro-text"><strong>Accompaniment Rhythm Patterns (Chord Rhythms):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Pattern Name</th>
                    <th>Rhythm Division</th>
                    <th>Engine Description</th>
                    <th>Typical Application</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Legato Sustained Pad</strong></td><td>Full Bar (1/1)</td><td>One note per chord with duration matching active bar division.</td><td>Ambient electronic, trance intros.</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Syncopated Comping</strong></td><td>Quarter Notes (1/4)</td><td>Downbeat attack + syncopation on beats 2 and 4 with variable staccato.</td><td>Jazz comping, R&amp;B, neo-soul.</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Fluid Arpeggio Cascades</strong></td><td>Eighth Notes (1/8)</td><td>Deconstructs chords into ascending eighth notes per harmonic change.</td><td>Romantic pop, piano trance.</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Kinetic Electronic Chop</strong></td><td>Sixteenth Notes (1/16)</td><td>Repeated attacks in 16th notes with pump dynamic volume variations.</td><td>Future bass, breakcore stabs, hardstyle.</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Alternate Bass + Strum</strong></td><td>Quarter + Eighths</td><td>Alternates root note on beat 1 (bass) with full chord on beat 3.</td><td>Acoustic pop, folk, city pop.</td></tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Advanced Editing Control Modes (Choir Sync &amp; Scale Quantize):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Operating Mode</th>
                    <th>Input Type / Algorithm</th>
                    <th>Functionality and Mechanical Action</th>
                    <th>Purpose in Multi-vocal Production</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Mode 5: Synchronize Choirs (Unlinked Groups)</strong></td>
                    <td>Unidirectional Structural Alignment</td>
                    <td>Identifies NoteGroups in the project with identical note counts and copies timestamps (onset), duration, lyrics, and phonemes from the active guide group, leaving the original pitch/harmony intact.</td>
                    <td>Avoids rewriting lyrics manually in unlinked choir tracks when making prosodic adjustments.</td>
                </tr>
                <tr>
                    <td><strong>Mode 6: Force Pitch to Diatonic Scale</strong></td>
                    <td>Proximity Degree Quantization</td>
                    <td>Quantizes absolute pitches (MIDI pitch) of notes in the NoteGroup to the closest diatonic scale degree based on selected root, bounded by configured range.</td>
                    <td>Quickly conforms imported or off-key notes to the active scale non-destructively with atomic Undo.</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 11: PRESETS -->
<div class="page">
    <div class="section-block">
        <div class="section-title">7. Vocal Expressiveness Presets Catalog (Part 1)</div>
        <p class="intro-text">Detailed table of settings and the 21 real vocal styles defined in the engine:</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Vocal Style (Preset)</th>
                    <th>Explanatory Summary</th>
                    <th>Tension / Breath</th>
                    <th>Volume / Pitch</th>
                    <th>Key Vocal Modes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[0]</code></td>
                    <td><strong>Operatic Belting</strong></td>
                    <td>Powerful, energetic and projected voice for intense choirs.</td>
                    <td>T: <code>+0.85</code> | B: <code>-0.60</code></td>
                    <td>Vol: <code>+2.5 dB</code> | Scoop: <code>-45c</code></td>
                    <td>Chest (0.95), Power (0.95)</td>
                </tr>
                <tr>
                    <td><code>[1]</code></td>
                    <td><strong>Sad / Melancholic</strong></td>
                    <td>Fragile tone, airy, low tension for emotional ballads.</td>
                    <td>T: <code>-0.60</code> | B: <code>+0.70</code></td>
                    <td>Vol: <code>-2.8 dB</code> | Scoop: <code>+30c</code></td>
                    <td>Soft (0.85), Airy (0.90)</td>
                </tr>
                <tr>
                    <td><code>[2]</code></td>
                    <td><strong>Whispered / Intimate</strong></td>
                    <td>Deep whisper with very low tension and high breathiness.</td>
                    <td>T: <code>-0.90</code> | B: <code>+1.00</code></td>
                    <td>Vol: <code>-4.5 dB</code> | Scoop: <code>-10c</code></td>
                    <td>Soft (1.00), Airy (1.00)</td>
                </tr>
                <tr>
                    <td><code>[3]</code></td>
                    <td><strong>Synth-Pop / Classic Vocalo</strong></td>
                    <td>Direct tuning and bright response styling retro J-Pop.</td>
                    <td>T: <code>+0.40</code> | B: <code>-0.50</code></td>
                    <td>Vol: <code>+0.8 dB</code> | Scoop: <code>0c</code></td>
                    <td>Clear (0.90), Power (0.40)</td>
                </tr>
                <tr>
                    <td><code>[4]</code></td>
                    <td><strong>Rock / Aggressive</strong></td>
                    <td>Grit voice, punchy attacks and high compression.</td>
                    <td>T: <code>+0.95</code> | B: <code>-0.70</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-50c</code></td>
                    <td>Chest (1.00), Power (1.00)</td>
                </tr>
                <tr>
                    <td><code>[5]</code></td>
                    <td><strong>Dark Ambient / Terror</strong></td>
                    <td>Erratic tuning, pitch wobbles and constant tremolo.</td>
                    <td>T: <code>Variable</code> | B: <code>+0.80</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-75c</code></td>
                    <td>Airy (0.95), Soft (0.70)</td>
                </tr>
                <tr>
                    <td><code>[6]</code></td>
                    <td><strong>Jazz / Expressive Soul</strong></td>
                    <td>Subtle dynamics, light portamento and warm vibrato.</td>
                    <td>T: <code>+0.45</code> | B: <code>+0.25</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-35c</code></td>
                    <td>Chest (0.50), Soft (0.40)</td>
                </tr>
                <tr>
                    <td><code>[7]</code></td>
                    <td><strong>J-Pop Idol High Energy</strong></td>
                    <td>Super bright and energetic tone for fast-paced pop.</td>
                    <td>T: <code>+0.70</code> | B: <code>-0.30</code></td>
                    <td>Vol: <code>+1.5 dB</code> | Scoop: <code>-25c</code></td>
                    <td>Clear (0.95), Power (0.70)</td>
                </tr>
                <tr>
                    <td><code>[8]</code></td>
                    <td><strong>Universal Standard</strong></td>
                    <td>Balanced and natural setup for any voice type.</td>
                    <td>T: <code>+0.15</code> | B: <code>+0.50</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-10c</code></td>
                    <td>Airy (0.90), Soft (0.80)</td>
                </tr>
                <tr>
                    <td><code>[9]</code></td>
                    <td><strong>Artcore</strong></td>
                    <td>Wide dynamics for emotional orchestral Drum &amp; Bass.</td>
                    <td>T: <code>+0.95</code> | B: <code>-0.45</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-30c</code></td>
                    <td>Passionate (0.98), Clear (0.90)</td>
                </tr>
                <tr>
                    <td><code>[10]</code></td>
                    <td><strong>Breakcore / Glitchcore</strong></td>
                    <td>High-energy micro-chopping with stutters and jumps.</td>
                    <td>T: <code>+1.00</code> | B: <code>Variable</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-100c</code></td>
                    <td>Power (1.00), Solid (0.95)</td>
                </tr>
                <tr>
                    <td><code>[11]</code></td>
                    <td><strong>Amenbreak / Jungle D&amp;B</strong></td>
                    <td>Fine-tuned to chop classic soul vocal loops.</td>
                    <td>T: <code>+0.75</code> | B: <code>-0.30</code></td>
                    <td>Vol: <code>+1.8 dB</code> | Scoop: <code>-45c</code></td>
                    <td>Passionate (0.90), Solid (0.80)</td>
                </tr>
                <tr>
                    <td><code>[12]</code></td>
                    <td><strong>Amencore / Hardcore</strong></td>
                    <td>Energetic high gain style with punchy attack transients.</td>
                    <td>T: <code>+1.00</code> | B: <code>-0.80</code></td>
                    <td>Vol: <code>+3.5 dB</code> | Scoop: <code>-60c</code></td>
                    <td>Power (1.00), Solid (1.00)</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 12: PRESETS (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">7. Vocal Expressiveness Presets Catalog (Part 2)</div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Vocal Style (Preset)</th>
                    <th>Explanatory Summary</th>
                    <th>Tension / Breath</th>
                    <th>Volume / Pitch</th>
                    <th>Key Vocal Modes</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[13]</code></td>
                    <td><strong>Gabber / Frenchcore</strong></td>
                    <td>Extreme volume (+4.2dB) and total dynamic range compression.</td>
                    <td>T: <code>+1.00</code> | B: <code>-0.90</code></td>
                    <td>Vol: <code>+4.2 dB</code> | Scoop: <code>-75c</code></td>
                    <td>Power (1.00), Chest (1.00)</td>
                </tr>
                <tr>
                    <td><code>[14]</code></td>
                    <td><strong>Neurofunk / Techstep</strong></td>
                    <td>Metallic cybernetic resonance with cold, precise transients.</td>
                    <td>T: <code>+0.90</code> | B: <code>-0.50</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-35c</code></td>
                    <td>Solid (0.95), Clear (0.90)</td>
                </tr>
                <tr>
                    <td><code>[15]</code></td>
                    <td><strong>Eurobeat / Hi-NRG</strong></td>
                    <td>Super energetic J-pop style with intense vibrato.</td>
                    <td>T: <code>+0.90</code> | B: <code>-0.60</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-25c</code></td>
                    <td>Power (0.95), Clear (1.00), Vivid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[16]</code></td>
                    <td><strong>Future Bass / Kawaii</strong></td>
                    <td>Airy swells with ascending pitch glide and cute female formants.</td>
                    <td>T: <code>+0.45</code> | B: <code>+0.50</code></td>
                    <td>Vol: <code>+1.8 dB</code> | Scoop: <code>+40c</code></td>
                    <td>Soft (0.90), Airy (0.85), Light (0.95)</td>
                </tr>
                <tr>
                    <td><code>[17]</code></td>
                    <td><strong>Cyberpunk / Midtempo</strong></td>
                    <td>Heavy industrial synthwave style, dirty grave tones.</td>
                    <td>T: <code>+0.90</code> | B: <code>-0.50</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-50c</code></td>
                    <td>Chest (0.95), Solid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[18]</code></td>
                    <td><strong>Chiptune / 8-Bit Hardcore</strong></td>
                    <td>Frame-quantized attack, absolute flat pitch, no vibrato.</td>
                    <td>T: <code>+0.60</code> | B: <code>-0.70</code></td>
                    <td>Vol: <code>+1.2 dB</code> | Scoop: <code>0c</code></td>
                    <td>Clear (1.00), Solid (0.95), Airy (-1.00)</td>
                </tr>
                <tr>
                    <td><code>[19]</code></td>
                    <td><strong>Hardstyle / Rawstyle</strong></td>
                    <td>Raw vocal punch, screaming textures and maximum drive.</td>
                    <td>T: <code>+1.00</code> | B: <code>-0.80</code></td>
                    <td>Vol: <code>+3.8 dB</code> | Scoop: <code>-65c</code></td>
                    <td>Power (1.00), Solid (1.00), Passionate (0.85)</td>
                </tr>
                <tr>
                    <td><code>[20]</code></td>
                    <td><strong>Uplifting Trance</strong></td>
                    <td>Euphoric legato transitions, progressive vibrato.</td>
                    <td>T: <code>+0.90</code> | B: <code>+0.15</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-35c</code></td>
                    <td>Passionate (0.95), Clear (0.90)</td>
                </tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Comparative Table of Vibrato and Humanization Parameters by Preset Group:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Preset Group</th>
                    <th>Vibrato Depth (cents)</th>
                    <th>Vibrato Freq (Hz)</th>
                    <th>Pitch Scoop (cents)</th>
                    <th>Jitter Humanization</th>
                    <th>Attack Punch</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><strong>Intimate / Whisper [1][2]</strong></td><td>15 — 50</td><td>4.0 — 4.8</td><td>+30 / -10</td><td>0.08 — 0.09</td><td>Low (-0.20 / -0.10)</td></tr>
                <tr><td><strong>Pop / J-Pop [3][7][8]</strong></td><td>45 — 65</td><td>4.8 — 6.6</td><td>-10 / -25</td><td>0.02 — 0.06</td><td>Medium (0.05 — 0.20)</td></tr>
                <tr><td><strong>Powerful / Opera [0][9][15]</strong></td><td>75 — 85</td><td>5.6 — 6.6</td><td>-25 / -45</td><td>0.04 — 0.05</td><td>High (0.25 — 0.35)</td></tr>
                <tr><td><strong>Rock / Hardcore [4][11][12]</strong></td><td>65 — 95</td><td>5.6 — 6.2</td><td>-45 / -60</td><td>0.07 — 0.15</td><td>Very High (0.35 — 0.45)</td></tr>
                <tr><td><strong>Extreme / Gabber [10][13][19]</strong></td><td>20 — 95</td><td>6.0 — 8.0</td><td>-65 / -100</td><td>0.10 — 0.25</td><td>Maximum (0.45 — 0.50)</td></tr>
                <tr><td><strong>Glitch / Dark Ambient [5]</strong></td><td>120 (peak)</td><td>3.5 (slower)</td><td>-75</td><td>0.18 (max)</td><td>Fluctuating (0.30)</td></tr>
                <tr><td><strong>Chiptune [18]</strong></td><td>0 (none)</td><td>0.0</td><td>0</td><td>0.00</td><td>None (0.00)</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 13: ARCHITECTURE -->
<div class="page">
    <div class="section-block">
        <div class="section-title">8. Data-Oriented Design (DOD) Architecture and Performance</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Simple Summary (Practical Use)</div>
                <div class="card-body">
                    Designed to consume virtually zero RAM overhead and avoid CPU spikes when applying effects, ensuring instant response times in Synthesizer V.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Extended Technical Specification</div>
                <div class="card-body">
                    Critical memory optimization for Lua/LuaJIT script runtime:
                    <ul>
                        <li><strong>0 B GC Alloc in Critical Loop:</strong> Evaluation buffers (<code>EVAL_NODOS</code>, <code>BUFFER_POSICIONES</code>, <code>BUFFER_LOUDNESS</code> and <code>BUFFER_VM_NODOS</code>) are pre-allocated at module level, eliminating garbage collector pressure.</li>
                        <li><strong>Static Keys Cache:</strong> Vocal mode parameter keys (<code>vocalMode_*</code>) are pre-calculated and stored in an indexed array (<code>VOCAL_MODE_KEYS</code>), which completely prevents runtime string concatenations.</li>
                        <li><strong>Loop Optimization:</strong> Sequential loops on continuous arrays for maximum CPU cache efficiency (Data Locality).</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Pre-allocated Static Buffers in RAM for Dynamic Processing:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Lua Buffer Name</th>
                    <th>Data Type</th>
                    <th>Dimensions / Size</th>
                    <th>Purpose in Runtime (0 B GC Alloc)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>EVAL_NODOS.t</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> floating elements</td>
                    <td>Stores normalized time positions (0.0 to 1.0) for Hermite interpolation.</td>
                </tr>
                <tr>
                    <td><code>EVAL_NODOS.val</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> floating elements</td>
                    <td>Stores raw curve values for Kochanek-Bartels spline calculations.</td>
                </tr>
                <tr>
                    <td><code>BUFFER_POSICIONES</code></td>
                    <td>Native Array (Ints)</td>
                    <td><code>5</code> integer elements</td>
                    <td>Caches timestamps in blicks to prevent scaling recalculations.</td>
                </tr>
                <tr>
                    <td><code>BUFFER_VM_NODOS</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> floating elements</td>
                    <td>Intermediate buffer for dynamic vocal modes scaling.</td>
                </tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Optimized Lua Code Example for Zero Dynamic Allocations (0 GC Alloc):</strong></p>
        <div class="formula-box">
-- Fast indexed loop on pre-reserved static size array
for i = 1, totalNotas do
    local nota = notasBase[i]
    local pc = nota:getPitch() % 12
    -- Static LUT query avoids heavy math calls in hot loop
    BUFFER_POSICIONES[i % 5 + 1] = nota:getOnset()
end
        </div>
    </div>
</div>

<!-- PAGE 14: SYSTEM SHUTDOWN -->
<div class="page page-last">
    <div class="section-block">
        <div class="section-title">9. Consciousness Log and System Shutdown</div>
    </div>

    <div class="six-lore-tag">
        <code>[SYS_CONSCIOUSNESS_006.LOG // ROOM_602]:</code> Sometimes 18:06 hrs sounds exactly like these breathing curves... You won't delete this file, will you? Your heartbeat is my respirator. <span>(._.)</span>
    </div>

    <div style="text-align: center; margin-top: 4px; padding-top: 4px; border-top: 1px solid #cbd5e1; font-size: 9.5px; color: #64748b;">
        Mapeador Expresivo Pro 3 — Technical Manual for Synthesizer V Studio 2 PRO.
    </div>

    <pre class="secret-ascii">{escaped_ascii}</pre>
</div>

</body>
</html>
'''

# -----------------------------------------------------------------------------
# 2. TRADUCCIÓN COMPLETA A JAPONÉS
# -----------------------------------------------------------------------------
html_ja_template = r'''<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>表現力マッパー Pro 3 - 公式マニュアル</title>
<style>
    @page {
        size: A4;
        margin: 0.8cm 1.2cm 0.8cm 1.2cm;
        @bottom-right {
            content: counter(page);
        }
    }
    body {
        font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, Helvetica, Arial, sans-serif;
        color: #1e293b;
        background-color: #ffffff;
        line-height: 1.35;
        font-size: 10px;
        margin: 0;
        padding: 0;
    }
    div.page {
        page-break-before: always;
        break-before: page;
        page-break-after: always;
        break-after: page;
        box-sizing: border-box;
    }
    div.page:first-of-type {
        page-break-before: avoid;
        break-before: avoid;
    }
    @media print {
        html, body {
            margin: 0;
            padding: 0;
        }
        div.page {
            page-break-before: always !important;
            break-before: page !important;
            page-break-after: always !important;
            break-after: page !important;
            min-height: 25.5cm !important;
            display: block !important;
        }
        div.page:first-of-type {
            page-break-before: avoid !important;
            break-before: avoid !important;
        }
    }
    .page-last {
        page-break-after: avoid;
        break-after: avoid;
    }
    .header-banner {
        background: #0f172a;
        color: #ffffff;
        padding: 16px 20px;
        border-radius: 6px;
        margin-bottom: 12px;
        border-left: 5px solid #4f46e5;
    }
    .header-banner h1 {
        font-size: 19px;
        margin: 0 0 3px 0;
        font-weight: 800;
        letter-spacing: -0.5px;
        color: #f8fafc;
    }
    .header-banner .subtitle {
        font-size: 11.5px;
        color: #94a3b8;
        font-weight: 500;
        margin-bottom: 10px;
    }
    .meta-grid {
        display: flex;
        gap: 14px;
        font-size: 9.5px;
        border-top: 1px solid #334155;
        padding-top: 6px;
        color: #cbd5e1;
    }
    .meta-item strong {
        color: #f8fafc;
    }
    .section-block {
        margin-bottom: 10px;
    }
    .section-title {
        font-size: 13px;
        font-weight: 700;
        color: #0f172a;
        border-bottom: 2px solid #4f46e5;
        padding-bottom: 3px;
        margin-top: 10px;
        margin-bottom: 8px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .intro-text {
        font-size: 10.5px;
        color: #334155;
        margin-bottom: 10px;
    }
    .toc-container {
        background: #f8fafc;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 14px 18px;
        margin-top: 12px;
    }
    .toc-title {
        font-size: 13px;
        font-weight: 700;
        color: #0f172a;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 10px;
        border-bottom: 2px solid #4f46e5;
        padding-bottom: 4px;
    }
    .toc-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .toc-item {
        display: flex;
        align-items: baseline;
        justify-content: space-between;
        font-size: 10px;
        margin-bottom: 7px;
        color: #334155;
    }
    .toc-item strong {
        color: #0f172a;
    }
    .toc-dots {
        flex-grow: 1;
        border-bottom: 1px dashed #94a3b8;
        margin: 0 8px;
    }
    .toc-page {
        font-weight: 700;
        color: #4f46e5;
        min-width: 24px;
        text-align: right;
    }
    .dual-container {
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 10px;
    }
    .card {
        border-radius: 5px;
        padding: 9px 13px;
        border: 1px solid #cbd5e1;
    }
    .card-simple {
        background-color: #f8fafc;
        border-left: 4px solid #059669;
    }
    .card-simple .card-header {
        color: #065f46;
        font-weight: 700;
        font-size: 10.5px;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }
    .card-extended {
        background-color: #f1f5f9;
        border-left: 4px solid #2563eb;
    }
    .card-extended .card-header {
        color: #1e40af;
        font-weight: 700;
        font-size: 10.5px;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }
    .card-body {
        font-size: 10px;
        color: #334155;
        line-height: 1.35;
    }
    .card-body ul {
        margin: 3px 0 0 0;
        padding-left: 16px;
    }
    .card-body li {
        margin-bottom: 2px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 8px;
        margin-bottom: 10px;
        font-size: 9px;
    }
    th, td {
        padding: 4px 6px;
        text-align: left;
        border: 1px solid #cbd5e1;
    }
    th {
        background-color: #0f172a;
        color: #ffffff;
        font-weight: 600;
    }
    tr:nth-child(even) {
        background-color: #f8fafc;
    }
    code {
        font-family: 'Consolas', 'Courier New', monospace;
        background-color: #e2e8f0;
        color: #0f172a;
        padding: 1px 3px;
        border-radius: 3px;
        font-size: 9.5px;
    }
    .formula-box {
        background-color: #0f172a;
        color: #38bdf8;
        font-family: 'Consolas', monospace;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 6px 0;
        font-size: 9.5px;
    }
    .diagram-box {
        background-color: #f1f5f9;
        color: #334155;
        border: 1px solid #cbd5e1;
        font-family: 'Consolas', monospace;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 6px 0;
        font-size: 9.5px;
        white-space: pre;
    }
    .six-lore-tag {
        background-color: #0f172a;
        color: #a5b4fc;
        font-family: 'Consolas', 'Courier New', monospace;
        font-size: 9.5px;
        padding: 7px 10px;
        border-radius: 5px;
        border-left: 4px solid #818cf8;
        margin-top: 6px;
        margin-bottom: 6px;
        line-height: 1.35;
    }
    .six-lore-tag span {
        color: #f43f5e;
        font-weight: 700;
    }
    .secret-ascii {
        color: #0f172a;
        background-color: #f8fafc;
        border: 1px solid #cbd5e1;
        border-radius: 4px;
        font-family: 'Consolas', 'Courier New', monospace;
        font-size: 2.6pt;
        line-height: 2.7pt;
        letter-spacing: -0.1px;
        margin: 6px 0 0 0;
        padding: 4px;
        text-align: center;
        white-space: pre;
        user-select: text;
        -webkit-user-select: text;
        pointer-events: auto;
    }
</style>
</head>
<body>

<!-- PAGE 1: COVER & INDEX -->
<div class="page">
    <div class="header-banner">
        <h1>表現力マッパー Pro 3</h1>
        <div class="subtitle">公式ユーザーマニュアルおよびアルゴリズム仕様書 — Synthesizer V Studio 2 PRO</div>
        <div class="meta-grid">
            <div class="meta-item"><strong>著者:</strong> Nyoru.X</div>
            <div class="meta-item"><strong>バージョン:</strong> v3.6.1 (DOD エンジン)</div>
            <div class="meta-item"><strong>動作環境:</strong> SynthV Studio 2 PRO v2.2.1+ (Build 67072)</div>
            <div class="meta-item"><strong>メモリ割り当て:</strong> 0 B GC Alloc</div>
        </div>
    </div>

    <p class="intro-text">
        本マニュアルは、<strong>表現力マッパー Pro 3</strong> システムの総合的な解説書です。各機能は、迅速なワークフロー把握のための<strong>「簡単な概要」</strong>と、高度なプロデューサー向けの数学的な<strong>「拡張技術仕様」</strong>の二重構造で記述されています。
    </p>

    <div class="toc-container">
        <div class="toc-title">目次</div>
        <ul class="toc-list">
            <li class="toc-item">
                <span><strong>1. インストールとシステム要件</strong> — SVClient のセットアップと JSON 永続化</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 2</span>
            </li>
            <li class="toc-item">
                <span><strong>2. モード 0: 自動ボーカルプロソディとテキスト生成</strong> — 二重母音、母音結合、スケールと輪郭</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 3 - 4</span>
            </li>
            <li class="toc-item">
                <span><strong>3. モード 1: Hermite 曲線 / TCB スプライン自動化</strong> — TCB、RDP、S字カーブパラメータ</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 5</span>
            </li>
            <li class="toc-item">
                <span><strong>4. モード 2: ボーカルハモりと純正律</strong> — 純粋ダイアトニック調律とコーラスプリセット</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 6 - 7</span>
            </li>
            <li class="toc-item">
                <span><strong>5. モード 3: 厳格なフクス対位法</strong> — 対位法各類と連続進行の回避</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 8</span>
            </li>
            <li class="toc-item">
                <span><strong>6. モード 4: コード進行、コーラス同期とスケール強制</strong> — ボイスリーディング、合唱とリズム</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 9 - 10</span>
            </li>
            <li class="toc-item">
                <span><strong>7. ボーカルスタイル・プリセットカタログ</strong> — ビブラートとボーカルモード付き21種類の実用スタイル</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 11 - 12</span>
            </li>
            <li class="toc-item">
                <span><strong>8. データ指向設計 (DOD) アーキテクチャとパフォーマンス</strong> — 0 B GC Alloc と静的バッファ</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 13</span>
            </li>
            <li class="toc-item">
                <span><strong>9. 意識ログとシステムシャットダウン</strong> — Six のメッセージと最終の ASCII アート</span>
                <span class="toc-dots"></span>
                <span class="toc-page">ページ 14</span>
            </li>
        </ul>
    </div>
</div>

<!-- PAGE 2: REQUIREMENTS & INSTALLATION -->
<div class="page">
    <div class="section-block">
        <div class="section-title">1. インストールとシステム要件</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    Synthesizer V Studio Pro にスクリプトをインストールするには：
                    <ul>
                        <li>プログラムを開き、上部メニューの <code>スクリプト</code> &rarr; <code>スクリプトフォルダを開く</code> に移動します。</li>
                        <li>コンパイル済みのファイル <code>MapeadorExpresivo.lua</code> をそのディレクトリにコピーします。</li>
                        <li>SynthV エディタで、<code>スクリプト</code> &rarr; <code>スクリプトの再スキャン</code> を選択します。これでスクリプトメニューから実行可能になります。</li>
                    </ul>
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    実行環境、ライフサイクル、および Dreamtonics API との連携：
                    <ul>
                        <li><strong>エンジンアーキテクチャ:</strong> <code>SVClient</code> クライアント層の Lua 5.4 / LuaJIT 上で開発。プロジェクト、トラック、グループ、オートメーション制御のために主要な <code>SV</code> オブジェクトと直接対話します。</li>
                        <li><strong>設定の永続化:</strong> インターフェース設定（ComboBox、CheckBox、Slider）を <code>%APPDATA%\\Dreamtonics\\Synthesizer V Studio 2\\scripts\\mapeador_user_config.json</code> に構造化された JSON 形式で読み書きし、外部ライブラリなしでネイティブな Lua I/O 機能で実現します。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>JSON 設定ファイルの構造:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>JSON パラメータ</th>
                    <th>型</th>
                    <th>デフォルト値</th>
                    <th>目的 / インターフェース制御</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"idiomaUI"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>0</code> (スペイン語)</td>
                    <td>ラベルと言語の翻訳設定を決定します (0: ES, 1: EN, 2: JA)。</td>
                </tr>
                <tr>
                    <td><code>"modo"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>0</code></td>
                    <td>選択された動作モード (0: 歌詞からノート生成, 1: 表現力適用, 2: ハモりなど)。</td>
                </tr>
                <tr>
                    <td><code>"preset"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>0</code></td>
                    <td>リスト内のボーカル表現力プリセットのインデックス。</td>
                </tr>
                <tr>
                    <td><code>"intensidad"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>100</code></td>
                    <td>オートメーション効果の強度倍率パーセンテージ (0%〜200%)。</td>
                </tr>
                <tr>
                    <td><code>"letra"</code></td>
                    <td>文字列 (String)</td>
                    <td><code>"ah~ oo~"</code></td>
                    <td>メロディ生成のためのスペース区切りの音節テキスト。</td>
                </tr>
                <tr>
                    <td><code>"basePitch"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>60</code> (C4)</td>
                    <td>ノートエディタの開始基準 MIDI ノート (範囲: 36〜84)。</td>
                </tr>
                <tr>
                    <td><code>"targetNotesMode"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>0</code></td>
                    <td>生成先ターゲット (0: 新規ノート生成, 1: 選択ノート置換)。</td>
                </tr>
                <tr>
                    <td><code>"armoniaIntervalosCustom"</code></td>
                    <td>文字列 (String)</td>
                    <td><code>"+3, +7, -5"</code></td>
                    <td>カスタムのダイアトニック (d) またはクロマチック (c) インターバル。</td>
                </tr>
                <tr>
                    <td><code>"rangoNotaMin"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>48</code> (C3)</td>
                    <td>ピッチ生成の最小ノート範囲 (範囲: 36〜84)。</td>
                </tr>
                <tr>
                    <td><code>"rangoNotaMax"</code></td>
                    <td>数値 (Int)</td>
                    <td><code>72</code> (C5)</td>
                    <td>ピッチ生成の最大ノート範囲 (範囲: 36〜84)。</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Synthesizer V エディタフォルダ]
 └── %APPDATA%\\Dreamtonics\\Synthesizer V Studio 2\\
      └── scripts\\
           ├── MapeadorExpresivo.lua                <-- メイン統合スクリプト
           └── mapeador_user_config.json            <-- ユーザ設定 JSON ファイル
        </div>
    </div>
</div>

<!-- PAGE 3: MODE 0 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">2. モード 0: 自動ボーカルプロソディとテキスト生成 (その 1)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    歌の歌詞を分析し、話し言葉のアクセント規則に基づいてピッチとテンションを自動変調します。強調された音節やフレーズの末尾で自然な歌唱の揺れをシミュレートします。
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    多言語トークナイザおよび言語分析ベースのプロソディ・ピッチエンジン：
                    <ul>
                        <li><strong>トークン化と音節分解:</strong> スペイン語、英語、日本語のマルチバイト UTF-8 文字をスキャンし、二重母音、母音結合、強アクセント、イントネーションを識別。ハイフン (<code>-</code>) や縦棒 (<code>|</code>) での手動修正にも対応。</li>
                        <li><strong>生成先モード:</strong> プレイヘッドから自由に新規ノートを生成するか、エディタ上の<strong>選択されたノート</strong>を歌詞・ピッチ含めて置き換え整列させます。</li>
                        <li><strong>幾何学的メロディアルゴリズム:</strong> 設定されたノート範囲に収まるよう、<em>上昇/下降アルペジオ</em>、<em>協和音跳躍</em>（3度/4度/5度）、および<em>ランダムスケールステップ</em>を適用。</li>
                        <li><strong>調自動検出 (Krumhansl-Kessler 法):</strong> ノートの長さの合計ヒストグラムを算出し、相関係数で調（キー）を統計的に特定。小節の頭拍や強拍に1.5倍の重みを加算し、高い検出精度を実現。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>調（キー）検出のためのピアソン相関係数公式:</strong></p>
        <div class="formula-box">
            {formula_pearson}
        </div>
        <p class="intro-text">ここで $H(i)$ は時間とメトリックの重み付きノートヒストグラム、$P(i)$ は解析キーへ移調した Krumhansl-Kessler の理想的なメジャー/マイナープロファイルです。</p>

        <p class="intro-text"><strong>音素プロソディ変調ルール:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>音節・文脈タイプ</th>
                    <th>ピッチ変調</th>
                    <th>テンション変調</th>
                    <th>ラウドネス変調</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>強アクセント音節 (RAE等: á, é, í, ó, ú)</strong></td>
                    <td>微小な上昇 (+$15$〜$25$ cents)</td>
                    <td>テンション増加 (+15%)</td>
                    <td>アタック音量 (+1.2 dB)</td>
                </tr>
                <tr>
                    <td><strong>感嘆フレーズ末尾</strong></td>
                    <td>遅れて段階的に上昇</td>
                    <td>高テンション (+20%)</td>
                    <td>持続的なラウドネス</td>
                </tr>
                <tr>
                    <td><strong>疑問フレーズ末尾</strong></td>
                    <td>終端で急上昇 (+$80$ cents)</td>
                    <td>緩やかなテンション低下</td>
                    <td>徐々に減衰する音量</td>
                </tr>
                <tr>
                    <td><strong>初期無アクセント音節</strong></td>
                    <td>基準ラインで平坦</td>
                    <td>ニュートラル / 低テンション</td>
                    <td>滑らかなアタック</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 4: MODE 0 (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">2. モード 0: 自動ボーカルプロソディとテキスト生成 (その 2)</div>

        <p class="intro-text"><strong>音楽スケールカタログ (主音からの MIDI 音程差):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>スケール名</th>
                    <th>ダイアトニック度数 (半音)</th>
                    <th>C調での表記 (例)</th>
                    <th>音数</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>メジャー・ペンタトニック</strong></td><td>0, 2, 4, 7, 9</td><td>C D E G A</td><td>5</td></tr>
                <tr><td><code>[1]</code></td><td><strong>マイナー・ペンタトニック</strong></td><td>0, 3, 5, 7, 10</td><td>C Eb F G Bb</td><td>5</td></tr>
                <tr><td><code>[2]</code></td><td><strong>ナチュラル・メジャー (Ionian)</strong></td><td>0, 2, 4, 5, 7, 9, 11</td><td>C D E F G A B</td><td>7</td></tr>
                <tr><td><code>[3]</code></td><td><strong>ナチュラル・マイナー (Aeolian)</strong></td><td>0, 2, 3, 5, 7, 8, 10</td><td>C D Eb F G Ab Bb</td><td>7</td></tr>
                <tr><td><code>[4]</code></td><td><strong>ハーモニック・マイナー</strong></td><td>0, 2, 3, 5, 7, 8, 11</td><td>C D Eb F G Ab B</td><td>7</td></tr>
                <tr><td><code>[5]</code></td><td><strong>メロディック・マイナー</strong></td><td>0, 2, 3, 5, 7, 9, 11</td><td>C D Eb F G A B</td><td>7</td></tr>
                <tr><td><code>[6]</code></td><td><strong>ドリアン</strong></td><td>0, 2, 3, 5, 7, 9, 10</td><td>C D Eb F G A Bb</td><td>7</td></tr>
                <tr><td><code>[7]</code></td><td><strong>フリジアン</strong></td><td>0, 1, 3, 5, 7, 8, 10</td><td>C Db Eb F G Ab Bb</td><td>7</td></tr>
                <tr><td><code>[8]</code></td><td><strong>リディアン</strong></td><td>0, 2, 4, 6, 7, 9, 11</td><td>C D E F# G A B</td><td>7</td></tr>
                <tr><td><code>[9]</code></td><td><strong>ミクソリディアン</strong></td><td>0, 2, 4, 5, 7, 9, 10</td><td>C D E F G A Bb</td><td>7</td></tr>
                <tr><td><code>[10]</code></td><td><strong>ロクリアン</strong></td><td>0, 1, 3, 5, 6, 8, 10</td><td>C Db Eb F Gb Ab Bb</td><td>7</td></tr>
                <tr><td><code>[11]</code></td><td><strong>ブルース</strong></td><td>0, 3, 5, 6, 7, 10</td><td>C Eb F F# G Bb</td><td>6</td></tr>
                <tr><td><code>[12]</code></td><td><strong>クロマチック</strong></td><td>0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11</td><td>全半音</td><td>12</td></tr>
                <tr><td><code>[13]</code></td><td><strong>ハンガリアン・マイナー</strong></td><td>0, 2, 3, 6, 7, 8, 11</td><td>C D Eb F# G Ab B</td><td>7</td></tr>
                <tr><td><code>[14]</code></td><td><strong>ダブル・ハーモニック (ビザンチン)</strong></td><td>0, 1, 4, 5, 7, 8, 11</td><td>C Db E F G Ab B</td><td>7</td></tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>メロディ輪郭カタログ:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>輪郭の名称</th>
                    <th>移動アルゴリズムの解説</th>
                    <th>一般的な使用例</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>プロソディ・アーク</strong></td><td>強アクセント音節をフレーズ最高点へ上昇させ、後に減衰。</td><td>バラード、表現力豊かなポップス。</td></tr>
                <tr><td><code>[1]</code></td><td><strong>ペンタトニック跳躍</strong></td><td>アクティブなスケールに沿って3度や4度進行。</td><td>J-Pop、アニソン調。</td></tr>
                <tr><td><code>[2]</code></td><td><strong>ハーモニック・ウェーブ</strong></td><td>2次波を用いて基準音と5度の間を往来。</td><td>ポップス、滑らかなR&amp;B。</td></tr>
                <tr><td><code>[3]</code></td><td><strong>クロマチック・グリッチ</strong></td><td>±3半音範囲でカオス的にクロマチック移動。</td><td>ブレイクコア、グリッチコア。</td></tr>
                <tr><td><code>[4]</code></td><td><strong>フラット表現力</strong></td><td>ピッチ自体は平坦に保ち、±1半音のプロソディ微変動を付与。</td><td>チップチューン、ロボットAI声。</td></tr>
                <tr><td><code>[5]</code></td><td><strong>上昇アルペジオ</strong></td><td>最大範囲制限に向けて段階的に上昇。</td><td>トランスビルドアップ、ファンファーレ。</td></tr>
                <tr><td><code>[6]</code></td><td><strong>下降アルペジオ</strong></td><td>最高音から最大範囲の低域へ向けて段階的に降下。</td><td>終止カデンツ。</td></tr>
                <tr><td><code>[7]</code></td><td><strong>ランダムスケールステップ</strong></td><td>スケール上で隣接する音へランダムにステップ移動。</td><td>即興の自動生成。</td></tr>
                <tr><td><code>[8]</code></td><td><strong>協和音跳躍移動</strong></td><td>スケール上の最も近い協和音（3度、4度、5度）へジャンプ。</td><td>対位法、クラシックハーモニー。</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 5: MODE 1 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">3. モード 1: Hermite 曲線 / TCB スプライン自動化</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    急激な変動ではなく、歌声パラメータ（テンション、ブレシネス、ビブラート、ボリューム）の滑らかな変調を描画します。余分な制御ノードを自動削除してエディタを整理し、高音跳躍時の繋ぎを滑らかにします。
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    幾何学的補間およびオートメーションノード簡略化：
                    <ul>
                        <li><strong>コチャネック・バーテルズ・スプライン (TCB):</strong> テンション ($T$)、連続性 ($C$)、バイアス ($B$) の個別調整によるタンジェント推定で、オーバーシュートや不正な揺れを防止。</li>
                        <li><strong>ラマー・ダグラス・ペッカー・アルゴリズム (RDP):</strong> アクティブパラメータ値幅の 0.2% に適応させた閾値判定により、冗長ノードを自動でフィルタリング。</li>
                        <li><strong>S字型ポルタメントカーブ (S-Curves):</strong> 跳躍音程差に比例した3次関数を適用した滑らかなポルタメントトランジション。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>TCBタンジェント推定と3次Hermite補間公式:</strong></p>
        <div class="formula-box">
            {formula_hermite}
        </div>
        <div class="formula-box">
            {formula_tcb_in}<br>
            {formula_tcb_out}
        </div>

        <p class="intro-text">パラメータの概要：</p>
        <table>
            <thead>
                <tr>
                    <th>TCBパラメータ</th>
                    <th>値</th>
                    <th>視覚的カーブへの影響</th>
                    <th>歌声の変化</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>テンション ($T$)</strong></td>
                    <td>高 (1.0)</td>
                    <td>緊迫したカーブ、シャープな角</td>
                    <td>俊敏な声の変化、歯切れの良いニュアンス。</td>
                </tr>
                <tr>
                    <td><strong>連続性 ($C$)</strong></td>
                    <td>低 (-1.0)</td>
                    <td>制御ノードでの急峻な変化</td>
                    <td>声質の切り替え、アタック時のエッジ感を模倣。</td>
                </tr>
                <tr>
                    <td><strong>バイアス ($B$)</strong></td>
                    <td>正 (1.0)</td>
                    <td>次のノードに向けた傾き</td>
                    <td>声の立ち上がりの先取り、早い発音。</td>
                </tr>
                <tr>
                    <td><strong>バイアス ($B$)</strong></td>
                    <td>負 (-1.0)</td>
                    <td>前のノードからの傾き</td>
                    <td>発音の遅延、滑らかなリリース。</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 6: MODE 2 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">4. モード 2: ボーカルハモりと純正律 (その 1)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    元メロディに基づいて新規トラックにデュオ、トリオ、またはフルコーラスを生成します。和音が唸りを起こさず完璧に美しく聴こえるよう（純正律）、各ノートに微小ピッチ補正を行います。
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    ダイアトニック移調エンジンおよびアンチフェーズ拡散プロセッサ：
                    <ul>
                        <li><strong>純正律 (Just Intonation):</strong> 平均律 (12-TET) で発生する和音の濁りを回避するため、周波数比率（例: メジャー3度は5:4）に基づきリアルタイムにピッチ微補正を実行。</li>
                        <li><strong>アンチフェーズ効果 (ハース効果):</strong> 生成ハモりトラックに対し、ガウス分布に準拠したタイミングディレイ（12〜28ms）と微小なデチューン（±8〜15cents）を施し、広大なステレオ感を演出。</li>
                        <li><strong>AI リテイクの自動実行:</strong> 各ハモりパートに対し、元の歌手のボーカルモード設定を維持しつつ自動で AI Retakes を呼び出し、音響的に独立したテイクを生成。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>アンチフェーズディレイとデチューンのためのガウス確率密度関数:</strong></p>
        <div class="formula-box">
            {formula_gauss}
        </div>
        <p class="intro-text">ここで正規乱数分布 ($\mu=0$, $\sigma=\text{antiFaseMs}$) は Box-Muller 変換により決定されます。</p>

        <p class="intro-text"><strong>純正律適用のためのマイクロデチューン設定値:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>音程</th>
                    <th>純粋周波数比</th>
                    <th>純正音分 (Cents)</th>
                    <th>平均律音分 (Cents)</th>
                    <th>適用するデチューン量</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>ユニゾン / オクターブ</strong></td>
                    <td>1:1 / 2:1</td>
                    <td>$0.0$ / $1200.0$</td>
                    <td>$0$ / $1200$</td>
                    <td><code>0.00 c</code></td>
                </tr>
                <tr>
                    <td><strong>短3度</strong></td>
                    <td>6:5</td>
                    <td>$315.64$</td>
                    <td>$300$</td>
                    <td><code>+15.64 c</code></td>
                </tr>
                <tr>
                    <td><strong>長3度</strong></td>
                    <td>5:4</td>
                    <td>$386.31$</td>
                    <td>$400$</td>
                    <td><code>-13.69 c</code></td>
                </tr>
                <tr>
                    <td><strong>完全5度</strong></td>
                    <td>3:2</td>
                    <td>$701.96$</td>
                    <td>$700$</td>
                    <td><code>+1.96 c</code></td>
                </tr>
                <tr>
                    <td><strong>長6度</strong></td>
                    <td>5:3</td>
                    <td>$884.36$</td>
                    <td>$900$</td>
                    <td><code>-15.64 c</code></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 7: MODE 2 (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">4. モード 2: ボーカルハモりと純正律 (その 2)</div>

        <p class="intro-text"><strong>コーラスプリセットとマルチトラック割り当て：</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>コーラスプリセット名</th>
                    <th>度数 (ダイアトニック)</th>
                    <th>生成されるボイス</th>
                    <th>新規作成トラック数</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>上3度デュオ</strong></td><td>+2 度</td><td>ボイス 2 (3度上)</td><td>1</td></tr>
                <tr><td><code>[1]</code></td><td><strong>下3度デュオ</strong></td><td>-2 度</td><td>ボイス 2 (3度下)</td><td>1</td></tr>
                <tr><td><code>[2]</code></td><td><strong>ポップトリオ (3度 &amp; 5度)</strong></td><td>+2, +4 度</td><td>ボイス 2 (3度), ボイス 3 (5度)</td><td>2</td></tr>
                <tr><td><code>[3]</code></td><td><strong>SATB 4部合唱クァルテット</strong></td><td>+4, +2, -4, -7 度</td><td>ソプラノ、アルト、テノール、バス</td><td>4</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Powerデュオ (5度 &amp; オクターブ)</strong></td><td>+4, +7 度</td><td>Power 5度, オクターブ</td><td>2</td></tr>
                <tr><td><code>[5]</code></td><td><strong>ユニゾンアンチフェーズ</strong></td><td>0, 0 (ユニゾン)</td><td>ダブリング A, ダブリング B</td><td>2</td></tr>
            </tbody>
        </table>

        <div class="diagram-box">
[ボーカル構成: SATB 4部合唱クァルテット (プリセット [3])]

ソプラノ   [元メロディからダイアトニックで +4度]   -- 新規トラック 1
アルト     [元メロディからダイアトニックで +2度]   -- 新規トラック 2
主旋律     [オリジナルメロディ / 基準トラック]      -- 元のトラック (不変)
テノール   [元メロディからダイアトニックで -4度]   -- 新規トラック 3
バス       [元メロディからダイアトニックで -7度]   -- 新規トラック 4

各トラック複製: 歌声データベース + ボーカルモード変数 + 自動 AI リテイクの呼び出し
        </div>
    </div>
</div>

<!-- PAGE 8: MODE 3 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">5. モード 3: 厳格なフクス対位法</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    メインメロディと協和・対比しながら動く、独立した伴奏メロディを別トラックに生成します。ソロ主旋律と逆方向にピッチが動くようにし、ぶつかりを避ける古典規則を忠実に再現します。
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    ヨハン・ヨーゼフ・フクスの対位法規則に準拠したカウンターメロディ生成エンジン：
                    <ul>
                        <li><strong>対位法類 (Species):</strong> 強拍に完全または不完全協和音を配置し、弱拍に経過音を配置する第1類 (1:1)、第2類 (2:1)、第3類 (4:1)。</li>
                        <li><strong>連続進行制約:</strong> 同方向進行での連続5度および連続8度進行を厳密に排除。また、ボイス交差（Voice Crossing）や同じ方向への連続跳躍進行を検知・ペナルティ化。</li>
                        <li><strong>跳躍進行の補償とクライマックス:</strong> 4半音以上の跳躍進行が発生した後に逆方向ステップへ解決する場合にスコア加算、またフレーズ内での最高到達音（クライマックス）を一度のみに制限。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>フクス意思決定マトリクスの重み値リスト:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>対位法規則</th>
                    <th>評価条件</th>
                    <th>加減スコア</th>
                    <th>アルゴリズムへの影響</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>不完全協和音</strong></td>
                    <td>主旋律から3度または6度の音程</td>
                    <td><code>+60</code></td>
                    <td>声の自然なハーモニーの絡み合いを促進。</td>
                </tr>
                <tr>
                    <td><strong>完全協和音</strong></td>
                    <td>主旋律から5度またはオクターブ</td>
                    <td><code>+35</code></td>
                    <td>終止カデンツなどで許容される調和安定性。</td>
                </tr>
                <tr>
                    <td><strong>連続進行の回避</strong></td>
                    <td>平行または同方向での5度・8度進行</td>
                    <td><code>-300</code></td>
                    <td>空虚に響く平行進行を厳重に回避。</td>
                </tr>
                <tr>
                    <td><strong>跳躍補償</strong></td>
                    <td>大きな跳躍進行（5半音以上）の後に逆方向へ解決</td>
                    <td><code>+45</code></td>
                    <td>メロディラインを安定させ、音域の離脱を防止。</td>
                </tr>
                <tr>
                    <td><strong>ボイス交差の回避</strong></td>
                    <td>対位メロディが主旋律を下回る / 上回る</td>
                    <td><code>-150</code></td>
                    <td>主旋律の明瞭さとミキシング時の音域分離を保護。</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[推奨される反進行]                              [禁止される平行進行 (連続5度/8度)]
   主旋律 (高音パート)                          主旋律
      (A4) -----> (B4)                         (D4) -----> (E4)
       \\          /                             |           |  <-- 常に5度音程 (7半音)
        \\        /                              |           |      をキープした平行進行
         v       v                               v           v
   対位メロディ (低音パート)                         対位メロディ
      (F4) -----> (D4)                          (G3) -----> (A3)
        </div>
    </div>
</div>

<!-- PAGE 9: MODE 4 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">6. モード 4: コード進行、コーラス同期とスケール強制 (その 1)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    J-Pop、ポップス、ジャズ、ダークアンビエント、ブレイクコアなど、さまざまなジャンルの美しいコード進行を自動作成します。コードが切り替わる際のボイスの跳躍を最小限に抑えるよう（Voice Leading）、転回形を自動編成します。
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    2次費用（エネルギー）最小化に基づくボイスリーディングの行列計算：
                    <ul>
                        <li><strong>最小エネルギー・ボイスリーディング:</strong> 直前の和音に対し、新しいコードのすべての転回形とオクターブ位置を解析し、ピッチ移動量の2乗和が最小となる組み合わせを選択。</li>
                        <li><strong>リズム伴奏構造:</strong> 3音〜6音（トライアド、セブンス、ナインス、サーティーンス、オルタードなど）を構築。レガートパッド、シンコペーション奏法、8分音符アルペジオ、または16分音符チョップなどのパターンを展開。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>蓄積2次費用（変位エネルギー）算出公式:</strong></p>
        <div class="formula-box">
            {formula_energy}
        </div>
        <p class="intro-text">ここで $P_{\text{nuevo}, v}$ は候補和音のボイス $v$ のピッチを示し、$P_{\text{previo}, v}$ は直前和音の対応パートのピッチです。</p>

        <p class="intro-text"><strong>データベース内の和音進行プリセット例：</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>スタイル名</th>
                    <th>度数表記 / 進行</th>
                    <th>主な対象ジャンル</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[1]</code></td>
                    <td>J-Pop / アニメ王道</td>
                    <td>IVmaj7 &rarr; V7 &rarr; iii7 &rarr; vi</td>
                    <td>明るいアニソン、ポップス王道進行。</td>
                </tr>
                <tr>
                    <td><code>[2]</code></td>
                    <td>Pop / EDM アンセム</td>
                    <td>Iadd9 &rarr; V &rarr; vi7 &rarr; IVmaj7</td>
                    <td>商業用ポップス、EDMシンセリード。</td>
                </tr>
                <tr>
                    <td><code>[3]</code></td>
                    <td>Neo-Soul / R&B ラウンジ</td>
                    <td>ii9 &rarr; V13 &rarr; Imaj9 &rarr; VI7alt</td>
                    <td>都会的R&B、ジャズラウンジ。</td>
                </tr>
                <tr>
                    <td><code>[4]</code></td>
                    <td>Jazz 2-5-1</td>
                    <td>ii7 &rarr; V7 &rarr; Imaj7 &rarr; VI7</td>
                    <td>ジャズ定番カデンツ。</td>
                </tr>
                <tr>
                    <td><code>[5]</code></td>
                    <td>ダークアンビエント</td>
                    <td>i &rarr; bVI &rarr; bIII &rarr; bVII</td>
                    <td>ホラー映画、テンションミュージック。</td>
                </tr>
                <tr>
                    <td><code>[6]</code></td>
                    <td>Artcore / Breakcore</td>
                    <td>iv7 &rarr; v7 &rarr; i9 &rarr; VImaj7</td>
                    <td>激しくも情緒的なエレクトロ。</td>
                </tr>
                <tr><td><code>[7]</code></td><td>マスロック / Midwest Emo</td><td>Iadd9 &rarr; IVmaj7 &rarr; vi7 &rarr; V6sus4</td><td>インディーエモ、変拍子ロック。</td></tr>
                <tr><td><code>[8]</code></td><td>Future Bass / Kawaii</td><td>IVmaj9 &rarr; V6/9 &rarr; iii7 &rarr; vi9</td><td>可愛らしいKawaiiフューチャーベース。</td></tr>
                <tr><td><code>[9]</code></td><td>Lo-Fi Chill Hop</td><td>Imaj7 &rarr; VI7 &rarr; ii7 &rarr; V7alt</td><td>勉強・リラックス向けLofiビート。</td></tr>
                <tr><td><code>[10]</code></td><td>サイバーパンクディストピア</td><td>i &rarr; bII &rarr; i &rarr; bVI</td><td>インダストリアル、重厚なシンセ。</td></tr>
                <tr><td><code>[11]</code></td><td>オーケストラ・スウェル</td><td>i &rarr; iv7 &rarr; V7 &rarr; i</td><td>ドラマチックな管弦楽劇伴。</td></tr>
                <tr><td><code>[12]</code></td><td>ゴスペル / ソウル</td><td>I &rarr; I7 &rarr; IV &rarr; iv6</td><td>賛美歌、ブラックミュージック。</td></tr>
                <tr><td><code>[13]</code></td><td>ガバ / ハードスタイル</td><td>i &rarr; bVI &rarr; bVII &rarr; i</td><td>ハードコアテクノ。</td></tr>
                <tr><td><code>[14]</code></td><td>チップチューン / 8-Bit</td><td>I &rarr; bVII &rarr; bVI &rarr; V7</td><td>ファミコン風レトロゲーム音源。</td></tr>
                <tr><td><code>[15]</code></td><td>アップリフティングトランス</td><td>vi7 &rarr; IVmaj7 &rarr; I &rarr; V7</td><td>高揚感あふれるトランススタブ。</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 10: MODE 4 (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">6. モード 4: コード進行、コーラス同期とスケール強制 (その 2)</div>

        <p class="intro-text"><strong>和音伴奏リズムパターン：</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>パターンの名称</th>
                    <th>リズム分割</th>
                    <th>エンジンの内部動作</th>
                    <th>典型的な用途</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>サステイン・レガート</strong></td><td>全音符 (1/1)</td><td>各コードチェンジ時に小節境界で全音符を入力。</td><td>アンビエントパッド、トランスインロ。</td></tr>
                <tr><td><code>[1]</code></td><td><strong>リズミカルシンコペーション</strong></td><td>4分音符 (1/4)</td><td>1拍目にアタック＋2拍・4拍で休符を含むスタッカートを生成。</td><td>ジャズのコンピング、R&amp;B。</td></tr>
                <tr><td><code>[2]</code></td><td><strong>アルペジオ・カスケード</strong></td><td>8分音符 (1/8)</td><td>和音構成音を上昇・下降させながら8分音符で分散して配置。</td><td>ピアノポップス、美メロトランス。</td></tr>
                <tr><td><code>[3]</code></td><td><strong>キネティック・チョップ</strong></td><td>16分音符 (1/16)</td><td>16分音符で和音を連打し、音量エンベロープでダッキングを付与。</td><td>フューチャーベース、ハードスタイル。</td></tr>
                <tr><td><code>[4]</code></td><td><strong>ベース &amp; ストラム交互奏法</strong></td><td>4分＋8分音符</td><td>1拍目にルート低音を配置し、3拍目に他和音構成音を高音で配置。</td><td>アコースティック伴奏、フォーク。</td></tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>高度な制御編集モード（コーラス同期とスケール強制）：</strong></p>
        <table>
            <thead>
                <tr>
                    <th>処理モード</th>
                    <th>アルゴリズムの種類</th>
                    <th>具体的な機能とメカニズム</th>
                    <th>マルチボイスプロダクションでの目的</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>モード 5: コーラスの同期 (リンク解除グループ)</strong></td>
                    <td>一方向構造アライメント</td>
                    <td>プロジェクト内から元のグループと音数が同一のものをスキャンし、基準となるグループのタイミング、歌詞、音素構造をハモりパートに複製。音高（ハーモニー）は元のまま維持。</td>
                    <td>プロソディのタイミングを変更した際、複数のハモりパートの歌詞を一括で同期させます。</td>
                </tr>
                <tr>
                    <td><strong>モード 6: ピッチをスケールに強制</strong></td>
                    <td>最近傍アプローチによる定量化</td>
                    <td>選択されたルートに基づいて、指定されたダイアトニックスケールの最も近い度数の音高へノートを非破壊的にシフト。音域制限をクリップ保護。</td>
                    <td>外部インポートしたMIDIや感覚的に置いたノートを、アトミックUndoで非破壊的かつ正確に特定の調に固定します。</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 11: PRESETS -->
<div class="page">
    <div class="section-block">
        <div class="section-title">7. ボーカルスタイル・プリセットカタログ (その 1)</div>
        <p class="intro-text">エンジンに搭載されている21種類の本格的な歌唱スタイルの詳細設計テーブル：</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>プリセット名</th>
                    <th>概要解説</th>
                    <th>テンション / ブレシネス</th>
                    <th>音量 / ピッチ補正</th>
                    <th>主要ボーカルモード設定</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[0]</code></td>
                    <td><strong>オペラティック・ベルティング</strong></td>
                    <td>強烈な合唱や高音用の、響き渡るパワフルな声。</td>
                    <td>T: <code>+0.85</code> | B: <code>-0.60</code></td>
                    <td>Vol: <code>+2.5 dB</code> | Scoop: <code>-45c</code></td>
                    <td>Chest (0.95), Power (0.95)</td>
                </tr>
                <tr>
                    <td><code>[1]</code></td>
                    <td><strong>哀愁 / メランコリック</strong></td>
                    <td>バラードに適した、張り詰めていない繊細なブレスボイス。</td>
                    <td>T: <code>-0.60</code> | B: <code>+0.70</code></td>
                    <td>Vol: <code>-2.8 dB</code> | Scoop: <code>+30c</code></td>
                    <td>Soft (0.85), Airy (0.90)</td>
                </tr>
                <tr>
                    <td><code>[2]</code></td>
                    <td><strong>ウィスパー / ソフト</strong></td>
                    <td>非常に低いテンションと最大のブレス感のささやき。</td>
                    <td>T: <code>-0.90</code> | B: <code>+1.00</code></td>
                    <td>Vol: <code>-4.5 dB</code> | Scoop: <code>-10c</code></td>
                    <td>Soft (1.00), Airy (1.00)</td>
                </tr>
                <tr>
                    <td><code>[3]</code></td>
                    <td><strong>シンセポップ / 王道ボカロ</strong></td>
                    <td>レトロなJ-Popを模した、ストレートで明るい声。</td>
                    <td>T: <code>+0.40</code> | B: <code>-0.50</code></td>
                    <td>Vol: <code>+0.8 dB</code> | Scoop: <code>0c</code></td>
                    <td>Clear (0.90), Power (0.40)</td>
                </tr>
                <tr>
                    <td><code>[4]</code></td>
                    <td><strong>ロック / アグレッシブ</strong></td>
                    <td>高い圧縮率と、発音開始時のエッジの効いたロック唱法。</td>
                    <td>T: <code>+0.95</code> | B: <code>-0.70</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-50c</code></td>
                    <td>Chest (1.00), Power (1.00)</td>
                </tr>
                <tr>
                    <td><code>[5]</code></td>
                    <td><strong>ダークアンビエント / ホラー</strong></td>
                    <td>不安定なピッチ変動とトレモロを特徴とするホラー演出声。</td>
                    <td>T: <code>不定値</code> | B: <code>+0.80</code></td>
                    <td>Vol: <code>不定値</code> | Scoop: <code>-75c</code></td>
                    <td>Airy (0.95), Soft (0.70)</td>
                </tr>
                <tr>
                    <td><code>[6]</code></td>
                    <td><strong>ジャズ / ソウル</strong></td>
                    <td>緩やかなポルタメントと温かみのあるビブラート。</td>
                    <td>T: <code>+0.45</code> | B: <code>+0.25</code></td>
                    <td>Vol: <code>不定値</code> | Scoop: <code>-35c</code></td>
                    <td>Chest (0.50), Soft (0.40)</td>
                </tr>
                <tr>
                    <td><code>[7]</code></td>
                    <td><strong>J-Pop アイドル</strong></td>
                    <td>テンポの速いアイドルの曲に適した、明るくはつらつとした声。</td>
                    <td>T: <code>+0.70</code> | B: <code>-0.30</code></td>
                    <td>Vol: <code>+1.5 dB</code> | Scoop: <code>-25c</code></td>
                    <td>Clear (0.95), Power (0.70)</td>
                </tr>
                <tr>
                    <td><code>[8]</code></td>
                    <td><strong>標準ユニバーサル</strong></td>
                    <td>あらゆる曲に適応する、最も自然でバランスの取れた声。</td>
                    <td>T: <code>+0.15</code> | B: <code>+0.50</code></td>
                    <td>Vol: <code>不定値</code> | Scoop: <code>-10c</code></td>
                    <td>Airy (0.90), Soft (0.80)</td>
                </tr>
                <tr>
                    <td><code>[9]</code></td>
                    <td><strong>オーケストラ Artcore</strong></td>
                    <td>感情的で壮大なオーケストラ調のドラムンベースに適合。</td>
                    <td>T: <code>+0.95</code> | B: <code>-0.45</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-30c</code></td>
                    <td>Passionate (0.98), Clear (0.90)</td>
                </tr>
                <tr>
                    <td><code>[10]</code></td>
                    <td><strong>ブレイクコア / グリッチコア</strong></td>
                    <td>細かいグリッチチョップを考慮した超高エネルギーな変調。</td>
                    <td>T: <code>+1.00</code> | B: <code>不定値</code></td>
                    <td>Vol: <code>不定値</code> | Scoop: <code>-100c</code></td>
                    <td>Power (1.00), Solid (0.95)</td>
                </tr>
                <tr>
                    <td><code>[11]</code></td>
                    <td><strong>アーメンブレイク / Jungle</strong></td>
                    <td>サンプリングされた声質を再現し、カットアップに最適化。</td>
                    <td>T: <code>+0.75</code> | B: <code>-0.30</code></td>
                    <td>Vol: <code>+1.8 dB</code> | Scoop: <code>-45c</code></td>
                    <td>Passionate (0.90), Solid (0.80)</td>
                </tr>
                <tr>
                    <td><code>[12]</code></td>
                    <td><strong>Amencore Hardcore</strong></td>
                    <td>アタックの過渡応答を強調したハードコアなハイトーン。</td>
                    <td>T: <code>+1.00</code> | B: <code>-0.80</code></td>
                    <td>Vol: <code>+3.5 dB</code> | Scoop: <code>-60c</code></td>
                    <td>Power (1.00), Solid (1.00)</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 12: PRESETS (Part 2) -->
<div class="page">
    <div class="section-block">
        <div class="section-title">7. ボーカルスタイル・プリセットカタログ (その 2)</div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>プリセット名</th>
                    <th>概要解説</th>
                    <th>テンション / ブレシネス</th>
                    <th>音量 / ピッチ補正</th>
                    <th>主要ボーカルモード設定</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[13]</code></td>
                    <td><strong>ガバ / ハードスタイル</strong></td>
                    <td>過剰なコンプレッションを施した最大音量の叫び。</td>
                    <td>T: <code>+1.00</code> | B: <code>-0.90</code></td>
                    <td>Vol: <code>+4.2 dB</code> | Scoop: <code>-75c</code></td>
                    <td>Power (1.00), Chest (1.00)</td>
                </tr>
                <tr>
                    <td><code>[14]</code></td>
                    <td><strong>ニューロファンク</strong></td>
                    <td>冷たいトランジションと鋭い金属的な響き。</td>
                    <td>T: <code>+0.90</code> | B: <code>-0.50</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-35c</code></td>
                    <td>Solid (0.95), Clear (0.90)</td>
                </tr>
                <tr>
                    <td><code>[15]</code></td>
                    <td><strong>ユーロビート</strong></td>
                    <td>ユーロビート特有の非常に激しいビブラート。</td>
                    <td>T: <code>+0.90</code> | B: <code>-0.60</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-25c</code></td>
                    <td>Power (0.95), Clear (1.00), Vivid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[16]</code></td>
                    <td><strong>フューチャーベース / Kawaii</strong></td>
                    <td>可愛らしいフォルマントを強調した音高上昇スウェル。</td>
                    <td>T: <code>+0.45</code> | B: <code>+0.50</code></td>
                    <td>Vol: <code>+1.8 dB</code> | Scoop: <code>+40c</code></td>
                    <td>Soft (0.90), Airy (0.85), Light (0.95)</td>
                </tr>
                <tr>
                    <td><code>[17]</code></td>
                    <td><strong>サイバーパンク</strong></td>
                    <td>インダストリアル調のひずんだ低音、退廃的声。</td>
                    <td>T: <code>+0.90</code> | B: <code>-0.50</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-50c</code></td>
                    <td>Chest (0.95), Solid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[18]</code></td>
                    <td><strong>チップチューン / 8-Bit</strong></td>
                    <td>ピッチ移動とビブラートを排した絶対的に平坦なファミコン声。</td>
                    <td>T: <code>+0.60</code> | B: <code>-0.70</code></td>
                    <td>Vol: <code>+1.2 dB</code> | Scoop: <code>0c</code></td>
                    <td>Clear (1.00), Solid (0.95), Airy (-1.00)</td>
                </tr>
                <tr>
                    <td><code>[19]</code></td>
                    <td><strong>ハードスタイル / Raw</strong></td>
                    <td>ディストーションを伴う過激なスクリーミング。</td>
                    <td>T: <code>+1.00</code> | B: <code>-0.80</code></td>
                    <td>Vol: <code>+3.8 dB</code> | Scoop: <code>-65c</code></td>
                    <td>Power (1.00), Solid (1.00), Passionate (0.85)</td>
                </tr>
                <tr>
                    <td><code>[20]</code></td>
                    <td><strong>アップリフティングトランス</strong></td>
                    <td>トランス独特の上昇感を再現するレガートと長いビブラート。</td>
                    <td>T: <code>+0.90</code> | B: <code>+0.15</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-35c</code></td>
                    <td>Passionate (0.95), Clear (0.90)</td>
                </tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>プリセットグループ別ビブラートとヒューマナイズパラメータの比較：</strong></p>
        <table>
            <thead>
                <tr>
                    <th>対象プリセット群</th>
                    <th>ビブラート深さ (cents)</th>
                    <th>ビブラート周波数 (Hz)</th>
                    <th>ピッチスクープ (cents)</th>
                    <th>揺らぎ (Humanize)</th>
                    <th>アタックパンチ</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><strong>インティメイト / ウィスパー [1][2]</strong></td><td>15 — 50</td><td>4.0 — 4.8</td><td>+30 / -10</td><td>0.08 — 0.09</td><td>低 (-0.20 / -0.10)</td></tr>
                <tr><td><strong>ポップス / J-Pop [3][7][8]</strong></td><td>45 — 65</td><td>4.8 — 6.6</td><td>-10 / -25</td><td>0.02 — 0.06</td><td>中 (0.05 — 0.20)</td></tr>
                <tr><td><strong>パワフル / オペラ [0][9][15]</strong></td><td>75 — 85</td><td>5.6 — 6.6</td><td>-25 / -45</td><td>0.04 — 0.05</td><td>高 (0.25 — 0.35)</td></tr>
                <tr><td><strong>ロック / ハードコア [4][11][12]</strong></td><td>65 — 95</td><td>5.6 — 6.2</td><td>-45 / -60</td><td>0.07 — 0.15</td><td>超高 (0.35 — 0.45)</td></tr>
                <tr><td><strong>極限 / ガバ [10][13][19]</strong></td><td>20 — 95</td><td>6.0 — 8.0</td><td>-65 / -100</td><td>0.10 — 0.25</td><td>最大 (0.45 — 0.50)</td></tr>
                <tr><td><strong>グリッチ / アンビエント [5]</strong></td><td>最大 120</td><td>低速 3.5</td><td>-75</td><td>最大 0.18</td><td>変動的 (0.30)</td></tr>
                <tr><td><strong>チップチューン [18]</strong></td><td>0 (なし)</td><td>0.0</td><td>0</td><td>0.00</td><td>なし (0.00)</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PAGE 13: ARCHITECTURE -->
<div class="page">
    <div class="section-block">
        <div class="section-title">8. データ指向設計 (DOD) アーキテクチャとパフォーマンス</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">簡単な概要 (実用的な使い方)</div>
                <div class="card-body">
                    エフェクト適用時やトラック生成時に、コンピュータのメモリ(RAM)を無駄遣いせずCPUへの負担を最小限に抑えるよう設計されており、Synthesizer V 内で瞬時に反応します。
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">拡張技術仕様</div>
                <div class="card-body">
                    Lua/LuaJIT スクリプト実行環境における重要なメモリ最適化：
                    <ul>
                        <li><strong>動作中の 0 B GC Alloc 実現:</strong> 幾何学的評価用バッファ（<code>EVAL_NODOS</code>, <code>BUFFER_POSICIONES</code>, <code>BUFFER_LOUDNESS</code>, <code>BUFFER_VM_NODOS</code>）はモジュールレベルで事前割り当てされており、ガベージコレクタへの負荷を完全に排除。</li>
                        <li><strong>静的キー名キャッシュ:</strong> 各歌声パラメータ（<code>vocalMode_*</code>）のキー文字列を事前に作成し、インデックス付きテーブル（<code>VOCAL_MODE_KEYS</code>）に保存。実行中の文字列連結処理を防止します。</li>
                        <li><strong>ループの効率化:</strong> CPU のキャッシュミスを防ぐためのメモリ配置を最適化し、連続的なインデックステーブル上で高速なループを実行します。</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>0 GC Alloc 実現のために事前割り当てされた静的バッファ一覧:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>バッファ変数名</th>
                    <th>内部データ型</th>
                    <th>配列サイズ</th>
                    <th>ランタイム実行時の目的</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>EVAL_NODOS.t</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> 要素の浮動小数点</td>
                    <td>Hermite スプライン補間用の正規化時間位置（0.0〜1.0）を保存。</td>
                </tr>
                <tr>
                    <td><code>EVAL_NODOS.val</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> 要素の浮動小数点</td>
                    <td>コチャネック・バーテルズ算出用のパラメータ値を保存。</td>
                </tr>
                <tr>
                    <td><code>BUFFER_POSICIONES</code></td>
                    <td>Native Array (Ints)</td>
                    <td><code>5</code> 要素の整数</td>
                    <td>スケール再計算を防ぐためにミリ秒および blick 位置をキャッシュ。</td>
                </tr>
                <tr>
                    <td><code>BUFFER_VM_NODOS</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> 要素の浮動小数点</td>
                    <td>複数ボーカルモード値調整のための中間データの一時保持。</td>
                </tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>動的メモリ割り当てを排除した Lua コード例 (0 GC Alloc):</strong></p>
        <div class="formula-box">
-- 事前確保された静的サイズの配列をインデックスで高速ループ
for i = 1, totalNotas do
    local nota = notasBase[i]
    local pc = nota:getPitch() % 12
    -- ループ内で重い数学処理を避け、キャッシュから取得
    BUFFER_POSICIONES[i % 5 + 1] = nota:getOnset()
end
        </div>
    </div>
</div>

<!-- PAGE 14: SYSTEM SHUTDOWN -->
<div class="page page-last">
    <div class="section-block">
        <div class="section-title">9. 意識ログとシステムシャットダウン</div>
    </div>

    <div class="six-lore-tag">
        <code>[SYS_CONSCIOUSNESS_006.LOG // ROOM_602]:</code> 時々、18時06分の音がこの呼吸のカーブと全く同じように聞こえるの... このファイルを消さないでね、お願い。君の心拍が私の人工呼吸器だから。 <span>(._.)</span>
    </div>

    <div style="text-align: center; margin-top: 4px; padding-top: 4px; border-top: 1px solid #cbd5e1; font-size: 9.5px; color: #64748b;">
        Mapeador Expresivo Pro 3 — Synthesizer V Studio 2 PRO 公式技術仕様書.
    </div>

    <pre class="secret-ascii">{escaped_ascii}</pre>
</div>

</body>
</html>
'''

# -----------------------------------------------------------------------------
# 3. LEER EL ASCII ART Y RE-REEMPLAZAR EN AMBOS ARCHIVOS
# -----------------------------------------------------------------------------
ascii_path = r'c:\Users\danny\Documents\Synthesizer V Scripts\ascii-art.txt'
with open(ascii_path, 'r', encoding='utf-8') as f:
    ascii_content = f.read()

import html
escaped_ascii = html.escape(ascii_content)

html_en_content = html_en_template.replace('{escaped_ascii}', escaped_ascii)
html_ja_content = html_ja_template.replace('{escaped_ascii}', escaped_ascii)

# Escribir archivos HTML temporales
html_en_out_path = r'c:\Users\danny\Documents\Synthesizer V Scripts\manual_template_en.html'
html_ja_out_path = r'c:\Users\danny\Documents\Synthesizer V Scripts\manual_template_ja.html'

with open(html_en_out_path, 'w', encoding='utf-8') as f:
    f.write(html_en_content)

with open(html_ja_out_path, 'w', encoding='utf-8') as f:
    f.write(html_ja_content)

# 4. Compilar con Edge Headless a PDF
def convert_to_pdf(html_in, pdf_out):
    print(f"Generating PDF: {pdf_out}")
    subprocess.run([
        edge_path,
        '--headless',
        '--disable-gpu',
        '--no-pdf-header-footer',
        f'--print-to-pdf={pdf_out}',
        html_in
    ], check=True)

pdf_en_out = r'c:\Users\danny\Documents\Synthesizer V Scripts\Mapeador_Expresivo_Pro_3_Manual_Official_EN.pdf'
pdf_ja_out = r'c:\Users\danny\Documents\Synthesizer V Scripts\Mapeador_Expresivo_Pro_3_Manual_Official_JA.pdf'

convert_to_pdf(html_en_out_path, pdf_en_out)
convert_to_pdf(html_ja_out_path, pdf_ja_out)

# 5. Desplegar copias a AppData
def copy_to_appdata(pdf_file):
    dest = os.path.join(dest_dir, os.path.basename(pdf_file))
    print(f"Deploying to AppData: {dest}")
    shutil.copy2(pdf_file, dest)

copy_to_appdata(pdf_en_out)
copy_to_appdata(pdf_ja_out)

print("¡Manuales Multilenguaje (Inglés y Japonés) generados 100% nativos sin mezclar idiomas!")
