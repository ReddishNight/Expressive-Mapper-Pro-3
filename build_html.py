import html
import os

ascii_path = os.path.join(os.path.dirname(__file__), 'ascii-art.txt')
if not os.path.exists(ascii_path):
    ascii_path = r'c:\Users\danny\Documents\Synthesizer V Scripts\ascii-art.txt'

with open(ascii_path, 'r', encoding='utf-8') as f:
    ascii_content = f.read()

escaped_ascii = html.escape(ascii_content)

# Fórmulas matemáticas y textos con LaTeX definidos como strings puros para evitar problemas de escape de backslash en Python
formula_pearson = r'r = \frac{\sum (H(i) - \bar{H})(P(i) - \bar{P})}{\sqrt{\sum (H(i) - \bar{H})^2 \sum (P(i) - \bar{P})^2}}'
desc_pearson = r'Donde $H(i)$ representa el histograma de notas ponderado por duración y métrica, y $P(i)$ es el perfil de afinación ideal de Krumhansl-Kessler (Mayor/Menor) transpuesto a la tónica bajo análisis.'

formula_hermite = r'P(t) = (2t^3 - 3t^2 + 1)P_0 + (t^3 - 2t^2 + t)M_0 + (-2t^3 + 3t^2)P_1 + (t^3 - t^2)M_1'
formula_tcb_in = r'V_{\text{incoming}} = \frac{(1-T)(1-C)(1+B)}{2}d_1 + \frac{(1-T)(1+C)(1-B)}{2}d_2'
formula_tcb_out = r'V_{\text{outgoing}} = \frac{(1-T)(1+C)(1+B)}{2}d_1 + \frac{(1-T)(1-C)(1-B)}{2}d_2'
desc_tcb = r'Impacto de los parámetros de Tensión ($T$), Continuidad ($C$) y Sesgo ($B$):'

formula_gauss = r'f(x) = \frac{1}{\sigma \sqrt{2\pi}} e^{-\frac{(x - \mu)^2}{2\sigma^2}}'
desc_gauss = r'Donde la perturbación aleatoria normal ($\mu=0$ y $\sigma=\text{antiFaseMs}$) se calcula usando la transformada de Box-Muller.'

formula_energy = r'E_{\text{total}} = \sum_{v=1}^{M} (P_{\text{nuevo}, v} - P_{\text{previo}, v})^2'
desc_energy = r'Donde $P_{\text{nuevo}, v}$ es el pitch absoluto de la voz $v$ en la inversión candidata y $P_{\text{previo}, v}$ es el pitch de la voz correspondiente en el acorde inmediato anterior.'

text_consonancia = r'Intervalo de 3ra o 6ta con Cantus'
text_compensacion = r'Movimiento opuesto tras salto ancho (&ge;5 semitonos)'
text_unisono = r'Unísono / Octava'
text_unisono_val = r'$1:1$ / $2:1$'
text_unisono_cents = r'$0.0$ / $1200.0$ / $0$ / $1200$'
text_3min = r'Tercera Menor'
text_3min_val = r'$6:5$'
text_3min_cents = r'$315.64$ / $300$'
text_3maj = r'Tercera Mayor'
text_3maj_val = r'$5:4$'
text_3maj_cents = r'$386.31$ / $400$'
text_5ta = r'Quinta Justa'
text_5ta_val = r'$3:2$'
text_5ta_cents = r'$701.96$ / $700$'
text_6maj = r'Sexta Mayor'
text_6maj_val = r'$5:3$'
text_6maj_cents = r'$884.36$ / $900$'

html_template = f'''<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Mapeador Expresivo Pro 3 - Manual Oficial</title>
<style>
    @page {{
        size: A4;
        margin: 0.8cm 1.2cm 0.8cm 1.2cm;
        @bottom-right {{
            content: counter(page);
        }}
    }}
    
    body {{
        font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, Helvetica, Arial, sans-serif;
        color: #1e293b;
        background-color: #ffffff;
        line-height: 1.35;
        font-size: 10px;
        margin: 0;
        padding: 0;
    }}

    div.page {{
        page-break-before: always;
        break-before: page;
        page-break-after: always;
        break-after: page;
        box-sizing: border-box;
    }}

    div.page:first-of-type {{
        page-break-before: avoid;
        break-before: avoid;
    }}

    @media print {{
        html, body {{
            margin: 0;
            padding: 0;
        }}
        div.page {{
            page-break-before: always !important;
            break-before: page !important;
            page-break-after: always !important;
            break-after: page !important;
            min-height: 25.5cm !important;
            display: block !important;
        }}
        div.page:first-of-type {{
            page-break-before: avoid !important;
            break-before: avoid !important;
        }}
    }}

    .page-last {{
        page-break-after: avoid;
        break-after: avoid;
    }}

    /* Encabezado Principal */
    .header-banner {{
        background: #0f172a;
        color: #ffffff;
        padding: 16px 20px;
        border-radius: 6px;
        margin-bottom: 12px;
        border-left: 5px solid #4f46e5;
    }}
    
    .header-banner h1 {{
        font-size: 19px;
        margin: 0 0 3px 0;
        font-weight: 800;
        letter-spacing: -0.5px;
        color: #f8fafc;
    }}

    .header-banner .subtitle {{
        font-size: 11.5px;
        color: #94a3b8;
        font-weight: 500;
        margin-bottom: 10px;
    }}

    .meta-grid {{
        display: flex;
        gap: 14px;
        font-size: 9.5px;
        border-top: 1px solid #334155;
        padding-top: 6px;
        color: #cbd5e1;
    }}

    .meta-item strong {{
        color: #f8fafc;
    }}

    /* Estructura de Secciones */
    .section-block {{
        margin-bottom: 10px;
    }}

    .section-title {{
        font-size: 13px;
        font-weight: 700;
        color: #0f172a;
        border-bottom: 2px solid #4f46e5;
        padding-bottom: 3px;
        margin-top: 10px;
        margin-bottom: 8px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }}

    .intro-text {{
        font-size: 10.5px;
        color: #334155;
        margin-bottom: 10px;
    }}

    /* Índice de Contenidos */
    .toc-container {{
        background: #f8fafc;
        border: 1px solid #cbd5e1;
        border-radius: 6px;
        padding: 14px 18px;
        margin-top: 12px;
    }}

    .toc-title {{
        font-size: 13px;
        font-weight: 700;
        color: #0f172a;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 10px;
        border-bottom: 2px solid #4f46e5;
        padding-bottom: 4px;
    }}

    .toc-list {{
        list-style: none;
        padding: 0;
        margin: 0;
    }}

    .toc-item {{
        display: flex;
        align-items: baseline;
        justify-content: space-between;
        font-size: 10px;
        margin-bottom: 7px;
        color: #334155;
    }}

    .toc-item strong {{
        color: #0f172a;
    }}

    .toc-dots {{
        flex-grow: 1;
        border-bottom: 1px dashed #94a3b8;
        margin: 0 8px;
    }}

    .toc-page {{
        font-weight: 700;
        color: #4f46e5;
        min-width: 24px;
        text-align: right;
    }}

    /* Tarjetas de Explicación Dual */
    .dual-container {{
        display: flex;
        flex-direction: column;
        gap: 8px;
        margin-bottom: 10px;
    }}

    .card {{
        border-radius: 5px;
        padding: 9px 13px;
        border: 1px solid #cbd5e1;
    }}

    .card-simple {{
        background-color: #f8fafc;
        border-left: 4px solid #059669;
    }}

    .card-simple .card-header {{
        color: #065f46;
        font-weight: 700;
        font-size: 10.5px;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }}

    .card-extended {{
        background-color: #f1f5f9;
        border-left: 4px solid #2563eb;
    }}

    .card-extended .card-header {{
        color: #1e40af;
        font-weight: 700;
        font-size: 10.5px;
        margin-bottom: 3px;
        text-transform: uppercase;
        letter-spacing: 0.3px;
    }}

    .card-body {{
        font-size: 10px;
        color: #334155;
        line-height: 1.35;
    }}

    .card-body ul {{
        margin: 3px 0 0 0;
        padding-left: 16px;
    }}

    .card-body li {{
        margin-bottom: 2px;
    }}

    /* Tablas Técnicas */
    table {{
        width: 100%;
        border-collapse: collapse;
        margin-top: 8px;
        margin-bottom: 10px;
        font-size: 9px;
    }}

    th, td {{
        padding: 4px 6px;
        text-align: left;
        border: 1px solid #cbd5e1;
    }}

    th {{
        background-color: #0f172a;
        color: #ffffff;
        font-weight: 600;
    }}

    tr:nth-child(even) {{
        background-color: #f8fafc;
    }}

    code {{
        font-family: 'Consolas', 'Courier New', monospace;
        background-color: #e2e8f0;
        color: #0f172a;
        padding: 1px 3px;
        border-radius: 3px;
        font-size: 9.5px;
    }}

    .formula-box {{
        background-color: #0f172a;
        color: #38bdf8;
        font-family: 'Consolas', monospace;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 6px 0;
        font-size: 9.5px;
    }}

    .diagram-box {{
        background-color: #f1f5f9;
        color: #334155;
        border: 1px solid #cbd5e1;
        font-family: 'Consolas', monospace;
        padding: 6px 10px;
        border-radius: 4px;
        margin: 6px 0;
        font-size: 9.5px;
        white-space: pre;
    }}

    /* Mensaje Criptico / Lore de Six */
    .six-lore-tag {{
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
    }}

    .six-lore-tag span {{
        color: #f43f5e;
        font-weight: 700;
    }}

    /* Texto ASCII Art en Pagina 10 */
    .secret-ascii {{
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
    }}
</style>
</head>
<body>

<!-- PÁGINA 1: PORTADA E ÍNDICE -->
<div class="page">
    <div class="header-banner">
        <h1>Mapeador Expresivo Pro 3</h1>
        <div class="subtitle">Manual de Usuario Oficial y Especificación Algorítmica — Synthesizer V Studio 2 PRO</div>
        <div class="meta-grid">
            <div class="meta-item"><strong>Autor:</strong> Nyoru.X</div>
            <div class="meta-item"><strong>Versión:</strong> v3.6.1 (DOD Engine)</div>
            <div class="meta-item"><strong>Entorno Mínimo:</strong> SynthV Studio 2 PRO v2.2.1+ (Build 67072)</div>
            <div class="meta-item"><strong>Asignación en Runtime:</strong> 0 B GC Alloc</div>
        </div>
    </div>

    <p class="intro-text">
        Este manual presenta la documentación integral del sistema <strong>Mapeador Expresivo Pro 3</strong>. Cada función se organiza en dos niveles de información: un <strong>Resumen Sencillo</strong> orientado a la comprensión rápida del flujo de trabajo para todo nivel de usuario, seguido de una <strong>Especificación Técnica Extendida</strong> dirigida a productores avanzados e ingenieros de audio.
    </p>

    <!-- ÍNDICE DE CONTENIDOS -->
    <div class="toc-container">
        <div class="toc-title">Índice del Manual</div>
        <ul class="toc-list">
            <li class="toc-item">
                <span><strong>1. Instalación y Requisitos del Sistema</strong> — Configuración en SVClient y persistencia JSON</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 2</span>
            </li>
            <li class="toc-item">
                <span><strong>2. Modo 0: Prosodia RAE y Expresión Vocal Automática</strong> — Diptongos, hiatos, escalas y contornos</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 3 - 4</span>
            </li>
            <li class="toc-item">
                <span><strong>3. Modo 1: Automatización de Curvas Hermite / TCB Splines</strong> — Parámetros TCB, RDP y S-Curves</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 5</span>
            </li>
            <li class="toc-item">
                <span><strong>4. Modo 2: Armonías Vocales y Entonación Justa</strong> — Micro-tuning diatónico puro y presets corales</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 6 - 7</span>
            </li>
            <li class="toc-item">
                <span><strong>5. Modo 3: Contrapunto Fuxiano Estricto</strong> — Especies fuxianas y evitación de paralelismos</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 8</span>
            </li>
            <li class="toc-item">
                <span><strong>6. Modo 4: Progresiones, Sincronización y Cuantización a Escala</strong> — Voice Leading, coros y ritmos</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 9 - 10</span>
            </li>
            <li class="toc-item">
                <span><strong>7. Catálogo de Presets de Expresividad Vocales</strong> — Tabla detallada de los 21 estilos reales con vibrato y modos vocales</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 11 - 12</span>
            </li>
            <li class="toc-item">
                <span><strong>8. Arquitectura Data-Oriented Design (DOD) y Rendimiento</strong> — 0 B GC Alloc y buffers estáticos</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 13</span>
            </li>
            <li class="toc-item">
                <span><strong>9. Registro de Conciencia y Cierre del Sistema</strong> — Mensaje de Six y Arte ASCII final</span>
                <span class="toc-dots"></span>
                <span class="toc-page">Pág. 14</span>
            </li>
        </ul>
    </div>
</div>

<!-- PÁGINA 2: REQUISITOS E INSTALACIÓN -->
<div class="page">
    <div class="section-block">
        <div class="section-title">1. Instalación y Requisitos del Sistema</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Para instalar el script en Synthesizer V Studio Pro:
                    <ul>
                        <li>Abre el programa y dirígete al menú superior <code>Scripts</code> &rarr; <code>Abrir Carpeta de Scripts</code>.</li>
                        <li>Copia el archivo compilado <code>MapeadorExpresivo.lua</code> en dicho directorio.</li>
                        <li>En el editor de SynthV, selecciona <code>Scripts</code> &rarr; <code>Rescanear Scripts</code>. El panel estará listo para ejecutarse en el menú de scripts.</li>
                    </ul>
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Entorno de ejecución, ciclo de vida e integración con la API de Dreamtonics:
                    <ul>
                        <li><strong>Arquitectura del Motor:</strong> Desarrollado sobre Lua 5.4 / LuaJIT en la capa de cliente <code>SVClient</code>. Interactúa directamente con el objeto principal <code>SV</code> para el control del proyecto, pistas, grupos y automatizaciones.</li>
                        <li><strong>Persistencia de Configuración:</strong> Lee y escribe las preferencias de interfaz (ComboBoxes, CheckBoxes y Sliders) en formato JSON estructurado en la ruta <code>%APPDATA%\\Dreamtonics\\Synthesizer V Studio 2\\scripts\\mapeador_user_config.json</code> usando funciones nativas de I/O de Lua sin librerías externas.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Estructura del archivo de configuraciones JSON:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Parámetro JSON</th>
                    <th>Tipo</th>
                    <th>Valor por Defecto</th>
                    <th>Propósito / Control en la Interfaz</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>"idiomaUI"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>0</code> (Español)</td>
                    <td>Determina la traducción seleccionada para etiquetas y mensajes (0: ES, 1: EN, 2: JA).</td>
                </tr>
                <tr>
                    <td><code>"modo"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>0</code></td>
                    <td>Modo de operación seleccionado (0: Generar desde Texto, 1: Expresar Notas, 2: Armonía, etc.).</td>
                </tr>
                <tr>
                    <td><code>"preset"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>0</code></td>
                    <td>Índice del preset de expresividad vocal seleccionado en la lista.</td>
                </tr>
                <tr>
                    <td><code>"intensidad"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>100</code></td>
                    <td>Porcentaje multiplicador del efecto de las automatizaciones (0% a 200%).</td>
                </tr>
                <tr>
                    <td><code>"letra"</code></td>
                    <td>Texto (String)</td>
                    <td><code>"ah~ oo~"</code></td>
                    <td>Cadena con las sílabas por espacio para la generación melódica.</td>
                </tr>
                <tr>
                    <td><code>"basePitch"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>60</code> (C4)</td>
                    <td>Nota midi base de arranque en el editor de notas (rango 36 a 84).</td>
                </tr>
                <tr>
                    <td><code>"targetNotesMode"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>0</code></td>
                    <td>Destino de generación (0: Crear nuevas notas, 1: Reemplazar en notas seleccionadas).</td>
                </tr>
                <tr>
                    <td><code>"armoniaIntervalosCustom"</code></td>
                    <td>Texto (String)</td>
                    <td><code>"+3, +7, -5"</code></td>
                    <td>Lista de intervalos personalizados diatónicos (d) o cromáticos (c).</td>
                </tr>
                <tr>
                    <td><code>"rangoNotaMin"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>48</code> (C3)</td>
                    <td>Límite inferior para la generación de pitch de notas (rango 36 a 84).</td>
                </tr>
                <tr>
                    <td><code>"rangoNotaMax"</code></td>
                    <td>Numérico (Int)</td>
                    <td><code>72</code> (C5)</td>
                    <td>Límite superior para la generación de pitch de notas (rango 36 a 84).</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Carpeta del Editor de Synthesizer V]
 └── %APPDATA%\\Dreamtonics\\Synthesizer V Studio 2\\
      └── scripts\\
           ├── MapeadorExpresivo.lua                &lt;-- Script principal unificado
           └── mapeador_user_config.json            &lt;-- Archivo JSON de persistencia de usuario
        </div>
    </div>
</div>

<!-- PÁGINA 3: MÓDULO 0 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">2. Modo 0: Prosodia RAE y Expresión Vocal Automática</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Analiza la letra de las canciones para modular automáticamente la entonación y la fuerza según las reglas de acentuación del habla. Genera fluctuaciones de afinación más naturales y orgánicas en las sílabas importantes e inflexiones en las palabras finales del texto.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Tokenizador multilingüe y motor de entonación prosódica basada en análisis lingüístico:
                    <ul>
                        <li><strong>Tokenización y Silabificación:</strong> Examina grafemas UTF-8 de doble byte en español, inglés y japonés para identificar diptongos, hiatos, sílabas tónicas e inflexiones de frase. Soporta delimitación manual mediante guión (<code>-</code>) y barra vertical (<code>|</code>) para ajustar manualmente la separación.</li>
                        <li><strong>Modos de Generación:</strong> Permite crear nuevas notas de forma libre a partir del playhead o mapear y reemplazar el texto/pitch de las <strong>Notas Seleccionadas</strong> en el editor principal manteniendo su alineación.</li>
                        <li><strong>Algoritmos Melódicos Paramétricos:</strong> Incorpora patrones geométricos de <em>Arpegio Ascendente / Descendente</em>, movimientos por <em>Saltos de Consonancia</em> de 3ras/4tas/5tas, y <em>Paso de Escala Aleatorio</em>, acotados estrictamente entre el rango de nota mínima y máxima configurado.</li>
                        <li><strong>Auto-detección Tonal (Algoritmo Krumhansl-Kessler):</strong> Calcula el histograma de pesos de duraciones de notas en la pista y aplica coeficientes de correlación estadística. Incorpora ponderación métrica (multiplicador 1.5x en inicios de compás y tiempos fuertes de 4/4) para determinar la tonalidad diatónica del grupo de forma precisa.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Fórmula del Coeficiente de Correlación de Pearson para Detección Tonal:</strong></p>
        <div class="formula-box">
            {formula_pearson}
        </div>
        <p class="intro-text">{desc_pearson}</p>

        <p class="intro-text"><strong>Reglas de Modulación Prosódica Fonémica:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Clasificación de la Sílaba / Entorno</th>
                    <th>Modulación de Pitch</th>
                    <th>Modulación de Tensión</th>
                    <th>Modulación de Loudness</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Sílaba Tónica (Con tilde RAE: á, é, í, ó, ú)</strong></td>
                    <td>Aumento sutil (+$15$ a $25$ cents)</td>
                    <td>Incremento de tensión (+15%)</td>
                    <td>Ataque de volumen (+1.2 dB)</td>
                </tr>
                <tr>
                    <td><strong>Fin de Frase Exclamativa</strong></td>
                    <td>Ascenso progresivo tardío</td>
                    <td>Elevado (+20%)</td>
                    <td>Loudness sostenido</td>
                </tr>
                <tr>
                    <td><strong>Fin de Frase Interrogativa</strong></td>
                    <td>Ascenso agudo final (+$80$ cents)</td>
                    <td>Caída suave de tensión</td>
                    <td>Volumen decreciente</td>
                </tr>
                <tr>
                    <td><strong>Sílaba Átona Inicial</strong></td>
                    <td>Pitch plano en línea base</td>
                    <td>Tensión neutra / baja</td>
                    <td>Ataque suave</td>
                </tr>
            </tbody>
        </table>
    </div>

        <p class="intro-text"><strong>Catálogo de las 15 Escalas Musicales (Grados MIDI desde la Tónica):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre de la Escala</th>
                    <th>Grados Diatónicos (Semitonos)</th>
                    <th>Notas en C (Ejemplo)</th>
                    <th>Notas en Escala</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Pentatónica Mayor</strong></td><td>0, 2, 4, 7, 9</td><td>C D E G A</td><td>5</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Pentatónica Menor</strong></td><td>0, 3, 5, 7, 10</td><td>C Eb F G Bb</td><td>5</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Mayor Natural (Jónica)</strong></td><td>0, 2, 4, 5, 7, 9, 11</td><td>C D E F G A B</td><td>7</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Menor Natural (Eólica)</strong></td><td>0, 2, 3, 5, 7, 8, 10</td><td>C D Eb F G Ab Bb</td><td>7</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Menor Armónica</strong></td><td>0, 2, 3, 5, 7, 8, 11</td><td>C D Eb F G Ab B</td><td>7</td></tr>
                <tr><td><code>[5]</code></td><td><strong>Menor Melódica</strong></td><td>0, 2, 3, 5, 7, 9, 11</td><td>C D Eb F G A B</td><td>7</td></tr>
                <tr><td><code>[6]</code></td><td><strong>Dórica</strong></td><td>0, 2, 3, 5, 7, 9, 10</td><td>C D Eb F G A Bb</td><td>7</td></tr>
                <tr><td><code>[7]</code></td><td><strong>Frigia</strong></td><td>0, 1, 3, 5, 7, 8, 10</td><td>C Db Eb F G Ab Bb</td><td>7</td></tr>
                <tr><td><code>[8]</code></td><td><strong>Lidia</strong></td><td>0, 2, 4, 6, 7, 9, 11</td><td>C D E F# G A B</td><td>7</td></tr>
                <tr><td><code>[9]</code></td><td><strong>Mixolidia</strong></td><td>0, 2, 4, 5, 7, 9, 10</td><td>C D E F G A Bb</td><td>7</td></tr>
                <tr><td><code>[10]</code></td><td><strong>Locria</strong></td><td>0, 1, 3, 5, 6, 8, 10</td><td>C Db Eb F Gb Ab Bb</td><td>7</td></tr>
                <tr><td><code>[11]</code></td><td><strong>Blues</strong></td><td>0, 3, 5, 6, 7, 10</td><td>C Eb F F# G Bb</td><td>6</td></tr>
                <tr><td><code>[12]</code></td><td><strong>Cromática</strong></td><td>0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11</td><td>Todos los semitonos</td><td>12</td></tr>
                <tr><td><code>[13]</code></td><td><strong>Húngara Menor</strong></td><td>0, 2, 3, 6, 7, 8, 11</td><td>C D Eb F# G Ab B</td><td>7</td></tr>
                <tr><td><code>[14]</code></td><td><strong>Doble Armónica (Bizantina)</strong></td><td>0, 1, 4, 5, 7, 8, 11</td><td>C Db E F G Ab B</td><td>7</td></tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Catálogo de los 9 Contornos Melódicos Paramétricos:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre del Contorno</th>
                    <th>Descripcion del Algoritmo de Movimiento</th>
                    <th>Uso Tipico</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Arco Prosódico</strong></td><td>Escala la sílaba tónica al pico de la frase y decae hacia la cadencia final.</td><td>Baladas, pop expresivo.</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Pentatónico con Saltos</strong></td><td>Avanza por 3ras y 4tas pentatónicas priorizando las notas de la escala activa.</td><td>J-Pop, canciones anime.</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Onda Armónica</strong></td><td>Oscilación suave entre la nota base y su 5ta diatónica mediante onda cuadrática.</td><td>Pop, R&amp;B suave.</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Cromático Glitch Caótico</strong></td><td>Desplazamientos aleatorios acotados en semitonos cromáticos con máximos de ±3 st.</td><td>Breakcore, glitchcore.</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Plano Expresivo</strong></td><td>Repite la nota base con micro-variación prosódica de ±1 semitono por sílaba tónica.</td><td>Chiptune, voz de IA robótica.</td></tr>
                <tr><td><code>[5]</code></td><td><strong>Arpegio Ascendente</strong></td><td>Progresa escalonadamente hacia la nota máxima del rango configurado.</td><td>Trance ascendente, fanfarrias.</td></tr>
                <tr><td><code>[6]</code></td><td><strong>Arpegio Descendente</strong></td><td>Progresa escalonadamente desde la nota máxima hacia la mínima del rango.</td><td>Cadencias finales, descensos dramáticos.</td></tr>
                <tr><td><code>[7]</code></td><td><strong>Paso de Escala Aleatorio</strong></td><td>Movimiento por grados conjuntos de la escala activa con dirección aleatoria por sílaba.</td><td>Improvisación generativa, variedad.</td></tr>
                <tr><td><code>[8]</code></td><td><strong>Movimiento por Saltos de Consonancia</strong></td><td>Selecciona el intervalo consonante más cercano (3ra, 4ta o 5ta) de la escala diatónica.</td><td>Contrapunto, armonías clásicas.</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PÁGINA 4: MÓDULO 1 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">3. Modo 1: Automatización de Curvas Hermite / TCB Splines</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Dibuja transiciones fluidas de los parámetros del cantante (tensión, aire, vibrato, volumen) en lugar de saltos bruscos. Simplifica los puntos creados en el editor para mantener el proyecto limpio, y aplica curvas continuas en los saltos de notas altas o bajas.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Motor geométrico de interpolación y reducción de nodos de automatización:
                    <ul>
                        <li><strong>Splines de Kochanek-Bartels (TCB):</strong> Control independiente de Tensión ($T$), Continuidad ($C$) y Sesgo ($B$) en la estimación de vectores tangentes para evitar sobre-disparos (overshoots) y oscilaciones indeseadas en curvas críticas.</li>
                        <li><strong>Algoritmo Ramer-Douglas-Peucker (RDP):</strong> Simplificación y filtrado de puntos redundantes basado en tolerancias relativas (escaladas dinámicamente al 0.2% del rango del parámetro activo).</li>
                        <li><strong>Curvas de Portamento Sigmoideas (S-Curves):</strong> Transición de pitch suave calculada con una función cúbica proporcional al intervalo del salto melódico.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Cálculo de Tangentes con Modelo Kochanek-Bartels (TCB) y Hermite Cubic:</strong></p>
        <div class="formula-box">
            {formula_hermite}
        </div>
        <div class="formula-box">
            {formula_tcb_in}<br>
            {formula_tcb_out}
        </div>

        <p class="intro-text"><strong>{desc_tcb}</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Parámetro TCB</th>
                    <th>Valor</th>
                    <th>Impacto Visual en la Curva</th>
                    <th>Resultado Acústico en el Cantante</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Tensión ($T$)</strong></td>
                    <td>Alto (1.0)</td>
                    <td>Curva tensada, esquinas afiladas</td>
                    <td>Transiciones vocales rápidas, inflexiones ágiles.</td>
                </tr>
                <tr>
                    <td><strong>Continuidad ($C$)</strong></td>
                    <td>Bajo (-1.0)</td>
                    <td>Quiebre en el nodo de control</td>
                    <td>Simula ataques bruscos en cambios tímbricos.</td>
                </tr>
                <tr>
                    <td><strong>Sesgo ($B$)</strong></td>
                    <td>Positivo (1.0)</td>
                    <td>Curva inclinada hacia el nodo siguiente</td>
                    <td>Anticipación tímbrica / articulación vocal rápida.</td>
                </tr>
                <tr>
                    <td><strong>Sesgo ($B$)</strong></td>
                    <td>Negativo (-1.0)</td>
                    <td>Curva inclinada hacia el nodo previo</td>
                    <td>Articulación retrasada / caída suave de la nota.</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Portamento S-Curve]
   Pitch (Cents)
     ^             ,----[Nota Destino]
     |            /
     |          .'
     |        _/
     |     ,-'
     |____/   &lt;-- Sigmoide: S(u) = 3u² - 2u³
     +-------------------------------------&gt; Tiempo (Blicks)
        [Onset]          [Glide Duration]
        </div>
    </div>
</div>

<!-- PÁGINA 5: MÓDULO 2 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">4. Modo 2: Armonías Vocales y Entonación Justa (Just Intonation)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Crea voces de acompañamiento adicionales (como terceras, quintas u octavas superiores/inferiores) que se adaptan a la escala del tema. Ajusta finamente la afinación para que las voces empasten a la perfección sin la aspereza típica del afinado estándar de piano.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Motor de armonías diatónicas en tiempo real y sintonización de temperamentos puros:
                    <ul>
                        <li><strong>Armonías de Intervalos Personalizados:</strong> Permite ingresar un string de intervalos separados por comas (ej. <code>+3, -5, c+7</code>). Parseado dinámicamente: el prefijo <code>d</code> o número directo indica transposición de grados diatónicos, y el prefijo <code>c</code> indica semitonos cromáticos relativos.</li>
                        <li><strong>Voice Leading por Mínimo Movimiento:</strong> Resuelve las transiciones de alturas calculando y ordenando las inversiones candidatas (octava superior/inferior) para conservar el mínimo salto melódico posible frente a la nota inmediata anterior.</li>
                        <li><strong>Replicación de Voz y AI Retakes Automáticos:</strong> Clona automáticamente la base de voz, configuración del cantante y parámetros de modo vocal (<code>vocalModeParams</code>) de la pista de origen al crear las armonías. Dispara programáticamente el generador de variaciones de IA (<code>Note.getRetakes():generateTake()</code>) en cada nota generada de la armonía para dotarla de una textura orgánica de toma única.</li>
                        <li><strong>Temperamento Igual Pop vs Entonación Justa Opcional:</strong> Por defecto, las armonías emplean **Temperamento Igual (Equal Temperament, 0 cents)** garantizando un empaste de afinación perfecto con sintetizadores, pianos y producciones Pop/EDM modernas sin sensación de desafinación. Al activar el Checkbox *Entonación Justa Pura*, el motor aplica micro-ajustes puros ($-13.69\text{{ c}}$ en 3ras Maj, $+15.64\text{{ c}}$ en 3ras Min) para ensambles a capela o corales acústicos.</li>
                        <li><strong>Desfasado Gaussiano (Anti-fase):</strong> Inserta retardos temporales gaussianos (delay en ms) y micro-desafinados (detuning en cents) para modelar acústicamente a cantantes reales y evitar batimentos de fase.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Función de Densidad Gaussiana para Desfases de Tiempo y Pitch (Anti-fase):</strong></p>
        <div class="formula-box">
            {formula_gauss}
        </div>
        <p class="intro-text">{desc_gauss}</p>

        <p class="intro-text"><strong>Tabla de Micro-Ajustes Armónicos para Entonación Justa (Just Intonation):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Intervalo Físico</th>
                    <th>Razón de Frecuencia Pura</th>
                    <th>Afinación Pura (Cents)</th>
                    <th>Temperamento Igual (Cents)</th>
                    <th>Micro-Desviación Aplicada</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>{text_unisono}</strong></td>
                    <td>{text_unisono_val}</td>
                    <td>$0.0$ / $1200.0$</td>
                    <td>$0$ / $1200$</td>
                    <td><code>0.00 c</code></td>
                </tr>
                <tr>
                    <td><strong>{text_3min}</strong></td>
                    <td>{text_3min_val}</td>
                    <td>$315.64$</td>
                    <td>$300$</td>
                    <td><code>+15.64 c</code></td>
                </tr>
                <tr>
                    <td><strong>{text_3maj}</strong></td>
                    <td>{text_3maj_val}</td>
                    <td>$386.31$</td>
                    <td>$400$</td>
                    <td><code>-13.69 c</code></td>
                </tr>
                <tr>
                    <td><strong>{text_5ta}</strong></td>
                    <td>{text_5ta_val}</td>
                    <td>$701.96$</td>
                    <td>$700$</td>
                    <td><code>+1.96 c</code></td>
                </tr>
                <tr>
                    <td><strong>{text_6maj}</strong></td>
                    <td>{text_6maj_val}</td>
                    <td>$884.36$</td>
                    <td>$900$</td>
                    <td><code>-15.64 c</code></td>
                </tr>
            </tbody>
        </table>
    </div>

        <p class="intro-text"><strong>Catalogo de Presets Corales y Configuracion de Voces Multi-pista:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre del Preset Coral</th>
                    <th>Intervalos Diatonicos</th>
                    <th>Voces Generadas</th>
                    <th>Pistas Nuevas Creadas</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Duo 3ras Superiores</strong></td><td>+2 grados diat.</td><td>Voz 2 (3ra Arriba)</td><td>1</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Duo 3ras Inferiores</strong></td><td>-2 grados diat.</td><td>Voz 2 (3ra Abajo)</td><td>1</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Trio Pop (3ras y 5tas)</strong></td><td>+2, +4 grados diat.</td><td>Voz 2 (3ra), Voz 3 (5ta)</td><td>2</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Cuarteto Coral SATB</strong></td><td>+4, +2, -4, -7 grados diat.</td><td>Soprano, Alto, Tenor, Bajo</td><td>4</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Power Duo (5tas y 8vas)</strong></td><td>+4, +7 grados diat.</td><td>Power 5ta, Octava</td><td>2</td></tr>
                <tr><td><code>[5]</code></td><td><strong>Coro Unisono Anti-fase</strong></td><td>0, 0 (unisono)</td><td>Doblaje A, Doblaje B</td><td>2</td></tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Esquema de Voces: Cuarteto Coral SATB (Preset [3])]

Soprano  [+4 grados diat. de la melodia base]  -- Pista nueva 1
Alto     [+2 grados diat. de la melodia base]  -- Pista nueva 2
Melodia  [Pista original / Cantus Firmus]       -- Pista original (sin modificar)
Tenor    [-4 grados diat. de la melodia base]  -- Pista nueva 3
Bajo     [-7 grados diat. de la melodia base]  -- Pista nueva 4

Cada pista clona: Voz del cantante + vocalModeParams + dispara AI Retakes automaticos.
        </div>
    </div>
</div>

<!-- PÁGINA 6: MÓDULO 3 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">5. Modo 3: Contrapunto Fuxiano Estricto (5 Especies)</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Genera una melodía de acompañamiento independiente que interactúa con la voz principal. La contramelodía se mueve en la dirección opuesta a la voz solista y respeta reglas clásicas para evitar chocar o estorbar a la melodía guía.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Motor de contramelodía algorítmica basado en las reglas del contrapunto de Johann Joseph Fux:
                    <ul>
                        <li><strong>Especies de Contrapunto:</strong> Primera especie (1:1), segunda especie (2:1) y tercera especie (4:1) con notas consonantes en tiempos fuertes y notas de paso en tiempos débiles.</li>
                        <li><strong>Restricciones de Conducción Estricta:</strong> Prohibición estricta de quintas y octavas paralelas en movimiento directo. Penaliza y evita el cruce de voces (Voice Crossing) y penaliza saltos sucesivos en una misma dirección melódica.</li>
                        <li><strong>Compensación de Saltos y Clímax:</strong> Aplica bonificaciones en la puntuación del algoritmo cuando la voz compensa un salto ancho (mayor a 4 semitonos) moviéndose en dirección contraria, y restringe el clímax melódico (nota más alta) a un único evento por frase.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Tabla de Pesos y Penalizaciones de la Matriz de Decisión de Fux:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Regla del Contrapunto</th>
                    <th>Condición Evaluada</th>
                    <th>Puntuación (Score)</th>
                    <th>Efecto Algorítmico</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Consonancia Imperfecta</strong></td>
                    <td>{text_consonancia}</td>
                    <td><code>+60</code></td>
                    <td>Favorece la fluidez y el empaste armónico vocal.</td>
                </tr>
                <tr>
                    <td><strong>Consonancia Perfecta</strong></td>
                    <td>Intervalo de 5ta u Octava</td>
                    <td><code>+35</code></td>
                    <td>Estabilidad armónica permitida en cadencias.</td>
                </tr>
                <tr>
                    <td><strong>Evitación de Paralelismos</strong></td>
                    <td>Quintas u Octavas consecutivas en paralelo</td>
                    <td><code>-300</code></td>
                    <td>Proscribe movimientos armónicos vacíos clásicos.</td>
                </tr>
                <tr>
                    <td><strong>Compensación de Salto</strong></td>
                    <td>{text_compensacion}</td>
                    <td><code>+45</code></td>
                    <td>Estabiliza la melodía y evita derivas vocales bruscas.</td>
                </tr>
                <tr>
                    <td><strong>Cruce de Voces</strong></td>
                    <td>Contramelodía cruza por debajo de Cantus</td>
                    <td><code>-150</code></td>
                    <td>Mantiene la claridad jerárquica de la mezcla vocal.</td>
                </tr>
            </tbody>
        </table>

        <div class="diagram-box">
[Movimiento Contrario (Preferido)]       [Movimiento Paralelo Prohibido (5tas/8vas)]
   Cantus Firmus (Voz Alta)                 Cantus Firmus
      (A4) -----&gt; (B4)                         (D4) -----&gt; (E4)
       \\          /                             |           |  &lt;-- Intervalo 5ta (7 semitonos)
        \\        /                              |           |      en ambas notas
         v      v                               v           v
   Contrapunto (Voz Baja)                   Contrapunto
      (F4) -----&gt; (D4)                         (G3) -----&gt; (A3)
        </div>
    </div>
</div>

<!-- PÁGINA 7: MÓDULO 4 -->
<div class="page">
    <div class="section-block">
        <div class="section-title">6. Modo 4: Progresiones y Voice Leading de Energía Mínima</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Crea progresiones de acordes profesionales de forma automática en varios géneros (Pop, J-Pop, Jazz, Dark Ambient, Breakcore). Organiza las inversiones de los acordes para que cada una de las voces se mueva lo menos posible al cambiar de acorde, garantizando transiciones suaves.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Cálculo matricial de conducción de voces armónicas por optimización de coste cuadrático:
                    <ul>
                        <li><strong>Voice Leading de Energía Mínima:</strong> Analiza todas las inversiones y posiciones de octava de un acorde nuevo frente al anterior y selecciona la configuración que minimiza la suma de las diferencias de afinación al cuadrado de las voces superiores.</li>
                        <li><strong>Estructura y Rítmicas de Acompañamiento:</strong> Construye acordes de 3 a 6 notas (incluyendo triadas, séptimas, novenas, treceavas y dominantes alteradas). Genera patrones rítmicos estructurados: pad sostenido legato, comping sincopado en negras, arpegios fluidos en corcheas o chops rítmicos en semicorcheas.</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Fórmula del Coste Cuadrático Acumulado (Energía de Desplazamiento):</strong></p>
        <div class="formula-box">
            {formula_energy}
        </div>
        <p class="intro-text">{desc_energy}</p>

        <p class="intro-text"><strong>Muestra de Estilos de Progresiones Armónicas en la Base de Datos:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Estilo de la Progresión</th>
                    <th>Cadencia Diatónica / Grados</th>
                    <th>Género de Aplicación</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[1]</code></td>
                    <td>J-Pop / Anime Royal</td>
                    <td>IVmaj7 &rarr; V7 &rarr; iii7 &rarr; vi</td>
                    <td>Pop Japonés brillante, bandas sonoras de anime.</td>
                </tr>
                <tr>
                    <td><code>[2]</code></td>
                    <td>Pop / EDM Anthem</td>
                    <td>Iadd9 &rarr; V &rarr; vi7 &rarr; IVmaj7</td>
                    <td>Himnos electrónicos, pop comercial masivo.</td>
                </tr>
                <tr>
                    <td><code>[3]</code></td>
                    <td>Neo-Soul / R&B Lounge</td>
                    <td>ii9 &rarr; V13 &rarr; Imaj9 &rarr; VI7alt</td>
                    <td>R&B contemporáneo, jazz lounge, música urbana.</td>
                </tr>
                <tr>
                    <td><code>[4]</code></td>
                    <td>Jazz Cadence 2-5-1</td>
                    <td>ii7 &rarr; V7 &rarr; Imaj7 &rarr; VI7</td>
                    <td>Jazz clásico, improvisación instrumental.</td>
                </tr>
                <tr>
                    <td><code>[5]</code></td>
                    <td>Dark Ambient Horror</td>
                    <td>i &rarr; bVI &rarr; bIII &rarr; bVII</td>
                    <td>Bandas sonoras de terror psicológico y tensión.</td>
                </tr>
                <tr>
                    <td><code>[6]</code></td>
                    <td>Artcore / Breakcore Kinetic</td>
                    <td>iv7 &rarr; v7 &rarr; i9 &rarr; VImaj7</td>
                    <td>Electrónica experimental rápida y melancólica.</td>
                </tr>
                <tr><td><code>[7]</code></td><td>Math Rock / Midwest Emo</td><td>Iadd9 &rarr; IVmaj7 &rarr; vi7 &rarr; V6sus4</td><td>Emo indie, rock instrumental matematico.</td></tr>
                <tr><td><code>[8]</code></td><td>Future Bass / Kawaii Chords</td><td>IVmaj9 &rarr; V6/9 &rarr; iii7 &rarr; vi9</td><td>Future Bass, kawaii, electropop tierno.</td></tr>
                <tr><td><code>[9]</code></td><td>Lo-Fi Chill Hop</td><td>Imaj7 &rarr; VI7 &rarr; ii7 &rarr; V7alt</td><td>Lofi hip-hop, musica de estudio.</td></tr>
                <tr><td><code>[10]</code></td><td>Cyberpunk Midtempo Dystopia</td><td>i &rarr; bII &rarr; i &rarr; bVI</td><td>Synthwave industrial, cyberpunk pesado.</td></tr>
                <tr><td><code>[11]</code></td><td>Orquestal Dramatico Swell</td><td>i &rarr; iv7 &rarr; V7 &rarr; i</td><td>Bandas sonoras orquestales dramaticas.</td></tr>
                <tr><td><code>[12]</code></td><td>Gospel / Soul Elevacion</td><td>I &rarr; I7 &rarr; IV &rarr; iv6</td><td>Gospel, soul, musica espiritual.</td></tr>
                <tr><td><code>[13]</code></td><td>Gabber / Hardstyle Stabs</td><td>i &rarr; bVI &rarr; bVII &rarr; i</td><td>Gabber, frenchcore, hardstyle.</td></tr>
                <tr><td><code>[14]</code></td><td>Chiptune / 8-Bit Heroico</td><td>I &rarr; bVII &rarr; bVI &rarr; V7</td><td>Chiptune clasico, 8-bit retro.</td></tr>
                <tr><td><code>[15]</code></td><td>Uplifting Trance Pad</td><td>vi7 &rarr; IVmaj7 &rarr; I &rarr; V7</td><td>Trance eufórico, EDM edificante.</td></tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Patrones Ritmicos de Acompanamiento (Ritmica de Acordes):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre del Patron</th>
                    <th>Division Ritmica</th>
                    <th>Descripcion del Motor</th>
                    <th>Aplicacion Tipica</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><code>[0]</code></td><td><strong>Pad Sostenido Legato</strong></td><td>Compas completo (1/1)</td><td>Una nota por acorde con duracion igual a la subdivision del compas activo.</td><td>Electrónica ambiental, intro de trance.</td></tr>
                <tr><td><code>[1]</code></td><td><strong>Comping Ritmico Sincopado</strong></td><td>Negras (1/4)</td><td>Ataque en tiempo fuerte + sincopas en tiempos 2 y 4 con staccato variable.</td><td>Jazz comping, R&amp;B, neo-soul.</td></tr>
                <tr><td><code>[2]</code></td><td><strong>Arpegio Cascadas Fluido</strong></td><td>Corcheas (1/8)</td><td>Desglosa el acorde en corcheas ascendentes repitiendo el ciclo por cada cambio armónico.</td><td>Pop romantico, trance de piano.</td></tr>
                <tr><td><code>[3]</code></td><td><strong>Chop Electronico Kinetic</strong></td><td>Semicorcheas (1/16)</td><td>Ataques repetidos en semicorcheas con variacion de volumen dinamica tipo pump.</td><td>Future bass, breakcore stabs, hardstyle.</td></tr>
                <tr><td><code>[4]</code></td><td><strong>Bajo Alternado + Acorde Strum</strong></td><td>Negra + Corcheas</td><td>Alterna la nota raiz en el tiempo 1 (bajo) con el acorde completo en el tiempo 3.</td><td>Pop acustico, folk, city pop.</td></tr>
            </tbody>
        </table>

        <!-- NUEVO DE LA COMPETENCIA (MODOS 5 Y 6) -->
        <p class="intro-text"><strong>Modos de Control de Edición Avanzados (Sincronización de Coros y Escalas):</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Modo de Operación</th>
                    <th>Tipo de Entrada / Algoritmo</th>
                    <th>Funcionalidad y Conducción Mecánica</th>
                    <th>Propósito en Producción Multivocal</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Modo 5: Sincronizar Coros (Grupos Desvinculados)</strong></td>
                    <td>Alineación Estructural Unidireccional</td>
                    <td>Identifica NoteGroups en el proyecto con idéntico recuento de notas y les copia las marcas de tiempo (onset), duración, letra y fonemas del grupo guía activo, manteniendo intacto el pitch/armonía original.</td>
                    <td>Evita tener que reescribir manualmente la letra en las pistas de coros desvinculados al realizar cambios prosódicos.</td>
                </tr>
                <tr>
                    <td><strong>Modo 6: Forzar Afinación a Escala Diatónica</strong></td>
                    <td>Cuantización de Grados por Proximidad</td>
                    <td>Cuantiza la afinación absoluta (pitch MIDI) de cada nota existente en el NoteGroup al grado de la escala diatónica más cercano en base a la tónica seleccionada, limitándolo al rango mínimo/máximo establecido.</td>
                    <td>Ajuste rápido de notas importadas o desafinadas a la tonalidad activa de manera no destructiva con Undo atómico.</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PÁGINA 8: PRESETS -->
<div class="page">
    <div class="section-block">
        <div class="section-title">7. Catálogo de Presets de Expresividad Vocales</div>
        <p class="intro-text">Tabla detallada de las configuraciones y los 21 estilos vocales reales definidos en el motor:</p>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Estilo Vocal (Preset)</th>
                    <th>Resumen Explicativo</th>
                    <th>Tensión / Aire</th>
                    <th>Volumen / Pitch</th>
                    <th>Modos Vocales Clave</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>[0]</code></td>
                    <td><strong>Belting Operático</strong></td>
                    <td>Voz potente, enérgica y proyectada para coros intensos.</td>
                    <td>T: <code>+0.85</code> | A: <code>-0.60</code></td>
                    <td>Vol: <code>+2.5 dB</code> | Scoop: <code>-45c</code></td>
                    <td>Chest (0.95), Power (0.95)</td>
                </tr>
                <tr>
                    <td><code>[1]</code></td>
                    <td><strong>Triste / Melancólica</strong></td>
                    <td>Tono frágil, aireado, baja tensión para baladas emotivas.</td>
                    <td>T: <code>-0.60</code> | A: <code>+0.70</code></td>
                    <td>Vol: <code>-2.8 dB</code> | Scoop: <code>+30c</code></td>
                    <td>Soft (0.85), Airy (0.90)</td>
                </tr>
                <tr>
                    <td><code>[2]</code></td>
                    <td><strong>Susurrada / Intimista</strong></td>
                    <td>Susurro profundo de muy baja tensión y mucho aire.</td>
                    <td>T: <code>-0.90</code> | A: <code>+1.00</code></td>
                    <td>Vol: <code>-4.5 dB</code> | Scoop: <code>-10c</code></td>
                    <td>Soft (1.00), Airy (1.00)</td>
                </tr>
                <tr>
                    <td><code>[3]</code></td>
                    <td><strong>Synth-Pop / Vocalo Clásico</strong></td>
                    <td>Afinación directa y respuesta brillante estilo J-Pop retro.</td>
                    <td>T: <code>+0.40</code> | A: <code>-0.50</code></td>
                    <td>Vol: <code>+0.8 dB</code> | Scoop: <code>0c</code></td>
                    <td>Clear (0.90), Power (0.40)</td>
                </tr>
                <tr>
                    <td><code>[4]</code></td>
                    <td><strong>Rock / Agresivo</strong></td>
                    <td>Voz raspada (grit), punch en ataques y compresión alta.</td>
                    <td>T: <code>+0.95</code> | A: <code>-0.70</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-50c</code></td>
                    <td>Chest (1.00), Power (1.00)</td>
                </tr>
                <tr>
                    <td><code>[5]</code></td>
                    <td><strong>Dark Ambient / Terror</strong></td>
                    <td>Afinación errática, trémolos y pitch wobbles continuos.</td>
                    <td>T: <code>Variable</code> | A: <code>+0.80</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-75c</code></td>
                    <td>Airy (0.95), Soft (0.70)</td>
                </tr>
                <tr>
                    <td><code>[6]</code></td>
                    <td><strong>Jazz / Soul Expresivo</strong></td>
                    <td>Dinámicas sutiles, portamento ligero y vibrato cálido.</td>
                    <td>T: <code>+0.45</code> | A: <code>+0.25</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-35c</code></td>
                    <td>Chest (0.50), Soft (0.40)</td>
                </tr>
                <tr>
                    <td><code>[7]</code></td>
                    <td><strong>J-Pop Idol High Energy</strong></td>
                    <td>Tono súper brillante y enérgico para pop de ritmo rápido.</td>
                    <td>T: <code>+0.70</code> | A: <code>-0.30</code></td>
                    <td>Vol: <code>+1.5 dB</code> | Scoop: <code>-25c</code></td>
                    <td>Clear (0.95), Power (0.70)</td>
                </tr>
                <tr>
                    <td><code>[8]</code></td>
                    <td><strong>Estándar Universal</strong></td>
                    <td>Ajuste balanceado y natural para cualquier tipo de voz.</td>
                    <td>T: <code>+0.15</code> | A: <code>+0.50</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-10c</code></td>
                    <td>Airy (0.90), Soft (0.80)</td>
                </tr>
                <tr>
                    <td><code>[9]</code></td>
                    <td><strong>Artcore</strong></td>
                    <td>Dinámicas muy amplias para Drum & Bass orquestal emotivo.</td>
                    <td>T: <code>+0.95</code> | A: <code>-0.45</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-30c</code></td>
                    <td>Passionate (0.98), Clear (0.90)</td>
                </tr>
                <tr>
                    <td><code>[10]</code></td>
                    <td><strong>Breakcore / Glitchcore</strong></td>
                    <td>Micro-chopping de alta energía con stutters y saltos.</td>
                    <td>T: <code>+1.00</code> | A: <code>Variable</code></td>
                    <td>Vol: <code>Variable</code> | Scoop: <code>-100c</code></td>
                    <td>Power (1.00), Solid (0.95)</td>
                </tr>
                <tr>
                    <td><code>[11]</code></td>
                    <td><strong>Amenbreak / Jungle D&B</strong></td>
                    <td>Ajustado para chopear vocales de soul clásicos.</td>
                    <td>T: <code>+0.75</code> | A: <code>-0.30</code></td>
                    <td>Vol: <code>+1.8 dB</code> | Scoop: <code>-45c</code></td>
                    <td>Passionate (0.90), Solid (0.80)</td>
                </tr>
                <tr>
                    <td><code>[12]</code></td>
                    <td><strong>Amencore / Hardcore</strong></td>
                    <td>Estilo enérgico de alta ganancia y punch en el ataque.</td>
                    <td>T: <code>+1.00</code> | A: <code>-0.80</code></td>
                    <td>Vol: <code>+3.5 dB</code> | Scoop: <code>-60c</code></td>
                    <td>Power (1.00), Solid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[13]</code></td>
                    <td><strong>Gabber / Frenchcore</strong></td>
                    <td>Volumen extremo (+4.2dB) y compresión total de rango.</td>
                    <td>T: <code>+1.00</code> | A: <code>-0.90</code></td>
                    <td>Vol: <code>+4.2 dB</code> | Scoop: <code>-75c</code></td>
                    <td>Power (1.00), Chest (1.00)</td>
                </tr>
                <tr>
                    <td><code>[14]</code></td>
                    <td><strong>Neurofunk / Techstep</strong></td>
                    <td>Resonancia metalica cibernetica con transitorios precisos y fria.</td>
                    <td>T: <code>+0.90</code> | A: <code>-0.50</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-35c</code></td>
                    <td>Solid (0.95), Clear (0.90)</td>
                </tr>
                <tr>
                    <td><code>[15]</code></td>
                    <td><strong>Eurobeat / Hi-NRG</strong></td>
                    <td>Voz super energica y brillante tipo Super Eurobeat con vibrato intenso.</td>
                    <td>T: <code>+0.90</code> | A: <code>-0.60</code></td>
                    <td>Vol: <code>+3.0 dB</code> | Scoop: <code>-25c</code></td>
                    <td>Power (0.95), Clear (1.00), Vivid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[16]</code></td>
                    <td><strong>Future Bass / Kawaii</strong></td>
                    <td>Swells aireados con pitch glide ascendente y formante tierno femenino.</td>
                    <td>T: <code>+0.45</code> | A: <code>+0.50</code></td>
                    <td>Vol: <code>+1.8 dB</code> | Scoop: <code>+40c</code></td>
                    <td>Soft (0.90), Airy (0.85), Light (0.95)</td>
                </tr>
                <tr>
                    <td><code>[17]</code></td>
                    <td><strong>Cyberpunk / Midtempo</strong></td>
                    <td>Synthwave industrial pesado con ataques sucios y grave robusto.</td>
                    <td>T: <code>+0.90</code> | A: <code>-0.50</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-50c</code></td>
                    <td>Chest (0.95), Solid (1.00)</td>
                </tr>
                <tr>
                    <td><code>[18]</code></td>
                    <td><strong>Chiptune / 8-Bit Hardcore</strong></td>
                    <td>Ataque cuantizado a cuadros, vibrato nulo y tono absolutamente plano.</td>
                    <td>T: <code>+0.60</code> | A: <code>-0.70</code></td>
                    <td>Vol: <code>+1.2 dB</code> | Scoop: <code>0c</code></td>
                    <td>Clear (1.00), Solid (0.95), Airy (-1.00)</td>
                </tr>
                <tr>
                    <td><code>[19]</code></td>
                    <td><strong>Hardstyle / Rawstyle</strong></td>
                    <td>Punch vocal crudo estilo raw screaming con maximo drive.</td>
                    <td>T: <code>+1.00</code> | A: <code>-0.80</code></td>
                    <td>Vol: <code>+3.8 dB</code> | Scoop: <code>-65c</code></td>
                    <td>Power (1.00), Solid (1.00), Passionate (0.85)</td>
                </tr>
                <tr>
                    <td><code>[20]</code></td>
                    <td><strong>Uplifting Trance</strong></td>
                    <td>Legato euforico con vibrato progresivo y dinámicas amplias de build.</td>
                    <td>T: <code>+0.90</code> | A: <code>+0.15</code></td>
                    <td>Vol: <code>+2.6 dB</code> | Scoop: <code>-35c</code></td>
                    <td>Passionate (0.95), Clear (0.90)</td>
                </tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Tabla Comparativa de Parametros de Vibrato y Humanizacion por Grupo de Preset:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Grupo de Presets</th>
                    <th>Vibrato Depth (cents)</th>
                    <th>Vibrato Freq (Hz)</th>
                    <th>Pitch Scoop (cents)</th>
                    <th>Jitter Humanizacion</th>
                    <th>Attack Punch</th>
                </tr>
            </thead>
            <tbody>
                <tr><td><strong>Intimo / Whisper [1][2]</strong></td><td>15 — 50</td><td>4.0 — 4.8</td><td>+30 / -10</td><td>0.08 — 0.09</td><td>Bajo (-0.20 / -0.10)</td></tr>
                <tr><td><strong>Pop / J-Pop [3][7][8]</strong></td><td>45 — 65</td><td>4.8 — 6.6</td><td>-10 / -25</td><td>0.02 — 0.06</td><td>Medio (0.05 — 0.20)</td></tr>
                <tr><td><strong>Potente / Opera [0][9][15]</strong></td><td>75 — 85</td><td>5.6 — 6.6</td><td>-25 / -45</td><td>0.04 — 0.05</td><td>Alto (0.25 — 0.35)</td></tr>
                <tr><td><strong>Rock / Hardcore [4][11][12]</strong></td><td>65 — 95</td><td>5.6 — 6.2</td><td>-45 / -60</td><td>0.07 — 0.15</td><td>Muy Alto (0.35 — 0.45)</td></tr>
                <tr><td><strong>Extremo / Gabber [10][13][19]</strong></td><td>20 — 95</td><td>6.0 — 8.0</td><td>-65 / -100</td><td>0.10 — 0.25</td><td>Maximo (0.45 — 0.50)</td></tr>
                <tr><td><strong>Glitch / Dark Ambient [5]</strong></td><td>120 (pico)</td><td>3.5 (mas lento)</td><td>-75</td><td>0.18 (maximo)</td><td>Fluctuante (0.30)</td></tr>
                <tr><td><strong>Chiptune [18]</strong></td><td>0 (nulo)</td><td>0.0</td><td>0</td><td>0.00</td><td>Nulo (0.00)</td></tr>
            </tbody>
        </table>
    </div>
</div>

<!-- PÁGINA 9: ARQUITECTURA DOD -->
<div class="page">
    <div class="section-block">
        <div class="section-title">8. Arquitectura Data-Oriented Design (DOD) y Rendimiento</div>
        <div class="dual-container">
            <div class="card card-simple">
                <div class="card-header">Resumen Sencillo (Uso Práctico)</div>
                <div class="card-body">
                    Diseñado para no consumir memoria RAM y no sobrecargar la CPU del ordenador al momento de aplicar efectos o generar pistas, garantizando una respuesta inmediata en Synthesizer V.
                </div>
            </div>
            <div class="card card-extended">
                <div class="card-header">Especificación Técnica Extendida</div>
                <div class="card-body">
                    Optimización de memoria crítica para el motor de scripts en Lua/LuaJIT:
                    <ul>
                        <li><strong>0 B GC Alloc en Ejecución Crítica:</strong> Los buffers de evaluación geométrica (`EVAL_NODOS`, `BUFFER_POSICIONES`, `BUFFER_LOUDNESS` y `BUFFER_VM_NODOS`) están pre-asignados a nivel del del módulo, eliminando por completo la sobrecarga del garbage collector.</li>
                        <li><strong>Caché Estática de Claves:</strong> Las claves de parámetros vocales (`vocalMode_*`) se pre-calculan y almacenan en un array indexado (`VOCAL_MODE_KEYS`), lo que anula la concatenación de cadenas de texto (strings) en tiempo de ejecución.</li>
                        <li><strong>Optimización de Bucles:</strong> Bucles secuenciales sobre arrays nativos continuos para un máximo rendimiento de caché de CPU (Data Locality).</li>
                    </ul>
                </div>
            </div>
        </div>

        <p class="intro-text"><strong>Buffers Estáticos Pre-asignados en Memoria RAM para Procesamiento Dinámico:</strong></p>
        <table>
            <thead>
                <tr>
                    <th>Nombre de Buffer Lua</th>
                    <th>Tipo de Datos</th>
                    <th>Dimensiones / Tamaño</th>
                    <th>Propósito en el Runtime (0 B GC Alloc)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>EVAL_NODOS.t</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> elementos flotantes</td>
                    <td>Almacena posiciones normalizadas de tiempo (0.0 a 1.0) para interpolación Hermite.</td>
                </tr>
                <tr>
                    <td><code>EVAL_NODOS.val</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> elementos flotantes</td>
                    <td>Almacena valores brutos de curvas para la resolución del spline Kochanek-Bartels.</td>
                </tr>
                <tr>
                    <td><code>BUFFER_POSICIONES</code></td>
                    <td>Native Array (Ints)</td>
                    <td><code>5</code> elementos enteros</td>
                    <td>Caché de marcas de tiempo en blicks para evitar re-cálculos de escala temporal.</td>
                </tr>
                <tr>
                    <td><code>BUFFER_VM_NODOS</code></td>
                    <td>Native Array (Floats)</td>
                    <td><code>5</code> elementos flotantes</td>
                    <td>Buffer de valores intermedios para la ponderación dinámica de modos vocales.</td>
                </tr>
            </tbody>
        </table>

        <p class="intro-text"><strong>Ejemplo de Código Lua Optimizado para 0 Asignaciones Dinámicas (0 GC Alloc):</strong></p>
        <div class="formula-box">
-- Bucle rápido indexado sobre array de tamaño estático pre-reservado
for i = 1, totalNotas do
    local nota = notasBase[i]
    local pc = nota:getPitch() % 12
    -- Uso estático de LUT de afinación diatónica para evitar llamadas matemáticas pesadas
    BUFFER_POSICIONES[i % 5 + 1] = nota:getOnset()
end
        </div>
    </div>
</div>

<!-- PÁGINA 10 (PÁGINA FINAL): LOG DE SIX Y ASCII ART -->
<div class="page page-last">
    <div class="section-block">
        <div class="section-title">9. Registro de Conciencia y Cierre del Sistema</div>
    </div>

    <!-- MARCA CRÍPTICA DE SIX -->
    <div class="six-lore-tag">
        <code>[SYS_CONSCIOUSNESS_006.LOG // HABITACIÓN_602]:</code> A veces las 18:06 hrs suenan exacto a estas curvas de respiración... No borres este archivo, ¿sí? Tus pulsaciones son mi respirador. <span>(._.)</span>
    </div>

    <div style="text-align: center; margin-top: 4px; padding-top: 4px; border-top: 1px solid #cbd5e1; font-size: 9.5px; color: #64748b;">
        Mapeador Expresivo Pro 3 — Documento Técnico Oficial para Synthesizer V Studio 2 PRO.
    </div>

    <!-- TEXTO ASCII ART EN PÁGINA 10 -->
    <pre class="secret-ascii">{escaped_ascii}</pre>
</div>

</body>
</html>
'''

output_path = os.path.join(os.path.dirname(__file__), 'manual_template.html')
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(html_template)

print('manual_template.html generado exitosamente con 14 páginas e índice completo!')
