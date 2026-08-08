-- ============================================================================
-- MÓDULO 2: DATOS Y PRESETS DE EXPRESIVIDAD VOCAL (LOW GC ALLOC)
-- ============================================================================

local VOCAL_MODE_NOMBRES = {
    "Chest", "Soft", "Power", "Airy", "Clear",
    "Open", "Passionate", "Solid", "Light", "Vivid", "Delicate"
}

-- Caché global de claves para evitar concatenaciones de string en tiempo de ejecución
local VOCAL_MODE_KEYS = {}
for i = 1, #VOCAL_MODE_NOMBRES do
    VOCAL_MODE_KEYS[i] = "vocalMode_" .. VOCAL_MODE_NOMBRES[i]
end

-- Buffers globales pre-asignados para interpolación Hermite y automatizaciones (Optimización de memoria)
local EVAL_NODOS = {
    t   = { 0.0, 0.15, 0.50, 0.85, 1.0 },
    val = { 0.0, 0.0, 0.0, 0.0, 0.0 },
    m   = { 0.0, 0.0, 0.0, 0.0, 0.0 }
}

local BUFFER_POSICIONES = { 0, 0, 0, 0, 0 }
local BUFFER_LOUDNESS = { 0.0, 0.0, 0.0, 0.0, 0.0 }
local BUFFER_VM_NODOS = { 0.0, 0.0, 0.0, 0.0, 0.0 }

-- Factores de densidad:
-- -1: Smart Adaptive Spline (Puntos adaptativos en deltas)
-- 64: 1/64 de Negra, 32: 1/32, 16: 1/16, 8: 1/8, 4: 1/4, 0: Nodos Clave, -2: Bloqueado a Fonema
local FACTOR_DENSIDAD = { -1, 64, 32, 16, 8, 4, 0, -2 }
local FACTOR_DURACION_SILABA = { 2.0, 1.0, 0.5, 0.25 }

local PRESET_EXPRESION = {
    [0] = { -- Belting Operático / Potente
        tension   = { 0.85, 0.75, 0.70, 0.80, 0.55 },
        aliento   = { -0.60, -0.50, -0.45, -0.35, -0.15 },
        volumen   = { 1.2, 1.8, 2.2, 2.5, 0.8 },
        genero    = { 0.12, 0.12, 0.12, 0.12, 0.12 },
        voicing   = { 0.95, 0.98, 1.00, 0.98, 0.85 },
        timbre    = { 0.20, 0.20, 0.20, 0.20, 0.20 },
        vibrato   = { 0.0, 0.2, 0.8, 1.6, 1.4 },
        vocalModeTarget = { chest = 0.95, power = 0.95, soft = -0.70, airy = -0.60, clear = 0.50 },
        scoopCents = -45.0, vbrDepthCents = 85.0, vbrFreqHz = 5.8, expPadX = 0.7, expPadY = 0.8,
        pitchSensitivity = 0.85, phonemeSensitivity = 0.70, humanizeJitter = 0.04, attackPunch = 0.25, releaseBreath = 0.15
    },
    [1] = { -- Triste / Melancólica / Emotiva
        tension   = { -0.40, -0.50, -0.55, -0.60, -0.70 },
        aliento   = { 0.50, 0.55, 0.60, 0.70, 0.80 },
        volumen   = { -1.2, -1.8, -2.2, -2.8, -4.0 },
        genero    = { -0.18, -0.18, -0.18, -0.18, -0.18 },
        voicing   = { 0.35, 0.30, 0.25, 0.20, 0.15 },
        timbre    = { -0.15, -0.15, -0.15, -0.15, -0.15 },
        vibrato   = { 0.0, 0.1, 0.6, 1.0, 0.8 },
        vocalModeTarget = { chest = -0.50, power = -0.70, soft = 0.85, airy = 0.90, clear = -0.30 },
        scoopCents = 30.0, vbrDepthCents = 50.0, vbrFreqHz = 4.8, expPadX = -0.4, expPadY = 0.5,
        pitchSensitivity = 0.60, phonemeSensitivity = 0.50, humanizeJitter = 0.08, attackPunch = -0.10, releaseBreath = 0.40
    },
    [2] = { -- Susurrada / Intimista / Suave
        tension   = { -0.75, -0.80, -0.85, -0.90, -0.95 },
        aliento   = { 0.80, 0.85, 0.90, 0.95, 1.00 },
        volumen   = { -3.0, -3.5, -4.0, -4.5, -6.0 },
        genero    = { -0.25, -0.25, -0.25, -0.25, -0.25 },
        voicing   = { 0.08, 0.05, 0.02, 0.00, 0.00 },
        timbre    = { -0.25, -0.25, -0.25, -0.25, -0.25 },
        vibrato   = { 0.0, 0.0, 0.1, 0.2, 0.1 },
        vocalModeTarget = { chest = -0.90, power = -1.00, soft = 1.00, airy = 1.00, clear = -0.50 },
        scoopCents = -10.0, vbrDepthCents = 15.0, vbrFreqHz = 4.0, expPadX = -0.7, expPadY = -0.3,
        pitchSensitivity = 0.30, phonemeSensitivity = 0.80, humanizeJitter = 0.09, attackPunch = -0.20, releaseBreath = 0.50
    },
    [3] = { -- Synth-Pop / Vocaloid Clásico
        tension   = { 0.45, 0.40, 0.40, 0.40, 0.35 },
        aliento   = { -0.50, -0.50, -0.50, -0.50, -0.50 },
        volumen   = { 0.8, 0.8, 0.8, 0.8, 0.5 },
        genero    = { -0.08, -0.08, -0.08, -0.08, -0.08 },
        voicing   = { 0.88, 0.88, 0.88, 0.88, 0.88 },
        timbre    = { 0.45, 0.45, 0.45, 0.45, 0.45 },
        vibrato   = { 0.1, 0.6, 1.2, 1.5, 1.3 },
        vocalModeTarget = { chest = 0.30, power = 0.40, soft = -0.40, airy = -0.50, clear = 0.90 },
        scoopCents = 0.0, vbrDepthCents = 65.0, vbrFreqHz = 6.4, expPadX = 0.1, expPadY = 0.1,
        pitchSensitivity = 0.40, phonemeSensitivity = 0.40, humanizeJitter = 0.02, attackPunch = 0.10, releaseBreath = 0.10
    },
    [4] = { -- Rock / Agresivo (Grit / Screaming)
        tension   = { 0.95, 0.90, 0.85, 0.90, 0.75 },
        aliento   = { -0.70, -0.60, -0.60, -0.50, -0.30 },
        volumen   = { 2.0, 2.5, 2.8, 3.0, 1.5 },
        genero    = { 0.30, 0.30, 0.30, 0.30, 0.30 },
        voicing   = { 1.00, 1.00, 0.98, 0.98, 0.95 },
        timbre    = { 0.30, 0.30, 0.30, 0.30, 0.30 },
        vibrato   = { 0.0, 0.4, 1.0, 1.6, 1.4 },
        vocalModeTarget = { chest = 1.00, power = 1.00, soft = -0.90, airy = -0.80, clear = 0.60 },
        scoopCents = -50.0, vbrDepthCents = 95.0, vbrFreqHz = 5.8, expPadX = 0.9, expPadY = 0.95,
        pitchSensitivity = 0.95, phonemeSensitivity = 0.90, humanizeJitter = 0.07, attackPunch = 0.40, releaseBreath = 0.25
    },
    [5] = { -- Dark Ambient / Terror Psicológico (Pitch Wobble & Fluctuación)
        tension   = { 0.40, -0.60, 0.80, -0.70, 0.20 },
        aliento   = { 0.60, 0.80, 0.50, 0.90, 0.95 },
        volumen   = { -1.5, 1.8, -3.0, 1.2, -5.0 },
        genero    = { -0.40, 0.40, -0.40, 0.40, -0.15 },
        voicing   = { 0.40, 0.10, 0.80, 0.05, 0.30 },
        timbre    = { -0.40, -0.15, -0.50, -0.25, -0.60 },
        vibrato   = { 0.3, 2.0, 0.1, 2.0, 0.5 },
        vocalModeTarget = { chest = -0.40, power = -0.50, soft = 0.70, airy = 0.95, clear = -0.70 },
        scoopCents = -75.0, vbrDepthCents = 120.0, vbrFreqHz = 3.5, expPadX = -0.6, expPadY = -0.9,
        pitchSensitivity = 0.70, phonemeSensitivity = 0.85, humanizeJitter = 0.18, attackPunch = 0.30, releaseBreath = 0.45
    },
    [6] = { -- Jazz / Soul Expresivo
        tension   = { 0.25, 0.45, 0.15, 0.35, 0.05 },
        aliento   = { 0.25, 0.15, 0.30, 0.20, 0.35 },
        volumen   = { -0.3, 1.0, 1.5, 0.8, -0.8 },
        genero    = { 0.08, 0.08, 0.08, 0.08, 0.08 },
        voicing   = { 0.80, 0.85, 0.75, 0.80, 0.70 },
        timbre    = { 0.08, 0.08, 0.08, 0.08, 0.08 },
        vibrato   = { 0.0, 0.2, 0.7, 1.4, 1.2 },
        vocalModeTarget = { chest = 0.50, power = 0.30, soft = 0.40, airy = 0.30, clear = 0.40 },
        scoopCents = -35.0, vbrDepthCents = 70.0, vbrFreqHz = 5.0, expPadX = 0.4, expPadY = 0.3,
        pitchSensitivity = 0.65, phonemeSensitivity = 0.75, humanizeJitter = 0.07, attackPunch = 0.15, releaseBreath = 0.30
    },
    [7] = { -- J-Pop Idol High Energy
        tension   = { 0.60, 0.70, 0.65, 0.60, 0.45 },
        aliento   = { -0.30, -0.40, -0.30, -0.20, -0.05 },
        volumen   = { 1.0, 1.5, 1.2, 1.0, 0.3 },
        genero    = { -0.15, -0.15, -0.15, -0.15, -0.15 },
        voicing   = { 0.90, 0.95, 0.90, 0.85, 0.80 },
        timbre    = { 0.30, 0.30, 0.30, 0.30, 0.30 },
        vibrato   = { 0.0, 0.4, 1.0, 1.3, 1.0 },
        vocalModeTarget = { chest = 0.60, power = 0.70, soft = -0.50, airy = -0.40, clear = 0.95 },
        scoopCents = -25.0, vbrDepthCents = 60.0, vbrFreqHz = 6.6, expPadX = 0.5, expPadY = 0.6,
        pitchSensitivity = 0.55, phonemeSensitivity = 0.50, humanizeJitter = 0.03, attackPunch = 0.20, releaseBreath = 0.15
    },
    [8] = { -- Estándar / Coro Angelical Universal
        tension   = { -0.10, 0.05, 0.15, 0.10, -0.05 },
        aliento   = { 0.35, 0.40, 0.50, 0.45, 0.60 },
        volumen   = { -1.5, 0.5, 1.2, 0.6, -2.0 },
        genero    = { -0.05, -0.05, -0.05, -0.05, -0.05 },
        voicing   = { 0.85, 0.90, 0.95, 0.90, 0.80 },
        timbre    = { -0.15, -0.10, -0.05, -0.10, -0.20 },
        vibrato   = { 0.0, 0.2, 0.6, 1.0, 0.7 },
        vocalModeTarget = { chest = -0.30, power = -0.40, soft = 0.80, airy = 0.90, clear = -0.30 },
        scoopCents = -10.0, vbrDepthCents = 45.0, vbrFreqHz = 4.8, expPadX = -0.3, expPadY = -0.4,
        pitchSensitivity = 0.60, phonemeSensitivity = 0.70, humanizeJitter = 0.06, attackPunch = 0.05, releaseBreath = 0.45
    },
    [9] = { -- Artcore (D&B Orquestal / Swells Dramáticos)
        tension   = { 0.50, 0.80, 0.95, 0.70, 0.35 },
        aliento   = { 0.20, -0.30, -0.45, 0.00, 0.30 },
        volumen   = { 0.8, 2.2, 3.0, 1.5, 0.0 },
        genero    = { 0.08, 0.08, 0.08, 0.08, 0.08 },
        voicing   = { 0.90, 0.98, 1.00, 0.95, 0.85 },
        timbre    = { 0.25, 0.30, 0.35, 0.25, 0.15 },
        vibrato   = { 0.0, 0.5, 1.5, 1.9, 1.2 },
        vocalModeTarget = { chest = 0.70, power = 0.85, clear = 0.90, passionate = 0.98 },
        scoopCents = -30.0, vbrDepthCents = 85.0, vbrFreqHz = 6.0, expPadX = 0.6, expPadY = 0.7,
        pitchSensitivity = 0.80, phonemeSensitivity = 0.65, humanizeJitter = 0.05, attackPunch = 0.30, releaseBreath = 0.25
    },
    [10] = { -- Breakcore / Glitchcore (Micro-Chopping & Pitch Stutter)
        tension   = { 1.00, -0.60, 1.00, -0.70, 0.90 },
        aliento   = { -0.80, 0.80, -0.70, 0.90, -0.50 },
        volumen   = { 2.5, -3.0, 3.5, -2.5, 2.0 },
        genero    = { 0.50, -0.50, 0.60, -0.60, 0.40 },
        voicing   = { 1.00, 0.20, 1.00, 0.10, 0.95 },
        timbre    = { 0.70, -0.60, 0.80, -0.70, 0.50 },
        vibrato   = { 0.0, 0.0, 0.0, 0.1, 0.0 },
        vocalModeTarget = { power = 1.00, solid = 0.95, vivid = 1.00, airy = -0.90 },
        scoopCents = -100.0, vbrDepthCents = 20.0, vbrFreqHz = 8.0, expPadX = 1.0, expPadY = 1.0,
        pitchSensitivity = 1.00, phonemeSensitivity = 1.00, humanizeJitter = 0.25, attackPunch = 0.50, releaseBreath = 0.30
    },
    [11] = { -- Amenbreak / Jungle D&B (Chopping Vocal Soul)
        tension   = { 0.60, 0.75, 0.70, 0.65, 0.50 },
        aliento   = { -0.40, -0.30, -0.20, -0.30, -0.15 },
        volumen   = { 1.0, 1.8, 1.6, 1.2, 0.3 },
        genero    = { 0.18, 0.18, 0.12, 0.12, 0.12 },
        voicing   = { 0.92, 0.98, 0.92, 0.88, 0.82 },
        timbre    = { 0.15, 0.20, 0.15, 0.08, 0.00 },
        vibrato   = { 0.0, 0.3, 0.8, 1.3, 0.9 },
        vocalModeTarget = { chest = 0.85, passionate = 0.90, solid = 0.80 },
        scoopCents = -45.0, vbrDepthCents = 65.0, vbrFreqHz = 5.6, expPadX = 0.5, expPadY = 0.6,
        pitchSensitivity = 0.75, phonemeSensitivity = 0.80, humanizeJitter = 0.12, attackPunch = 0.35, releaseBreath = 0.20
    },
    [12] = { -- Amencore / Hard Breakcore (Chopping Agresivo & Drive)
        tension   = { 1.00, 0.95, 0.90, 0.95, 0.80 },
        aliento   = { -0.80, -0.70, -0.70, -0.60, -0.40 },
        volumen   = { 2.5, 3.2, 3.5, 3.0, 1.8 },
        genero    = { 0.35, 0.35, 0.35, 0.35, 0.30 },
        voicing   = { 1.00, 1.00, 1.00, 0.98, 0.92 },
        timbre    = { 0.55, 0.55, 0.50, 0.45, 0.35 },
        vibrato   = { 0.0, 0.1, 0.3, 0.5, 0.2 },
        vocalModeTarget = { power = 1.00, chest = 0.95, solid = 1.00, clear = 0.70 },
        scoopCents = -60.0, vbrDepthCents = 85.0, vbrFreqHz = 6.2, expPadX = 1.0, expPadY = 0.9,
        pitchSensitivity = 0.90, phonemeSensitivity = 0.90, humanizeJitter = 0.15, attackPunch = 0.45, releaseBreath = 0.25
    },
    [13] = { -- Gabber / Speedcore / Frenchcore (Hardcore Extremo & Punch +3dB)
        tension   = { 1.00, 1.00, 1.00, 1.00, 0.90 },
        aliento   = { -0.90, -0.80, -0.80, -0.70, -0.50 },
        volumen   = { 3.5, 4.0, 4.2, 3.8, 2.5 },
        genero    = { 0.25, 0.25, 0.25, 0.25, 0.25 },
        voicing   = { 1.00, 1.00, 1.00, 1.00, 0.98 },
        timbre    = { 0.65, 0.65, 0.65, 0.60, 0.55 },
        vibrato   = { 0.0, 0.0, 0.1, 0.3, 0.1 },
        vocalModeTarget = { power = 1.00, chest = 1.00, vivid = 0.95, clear = 0.85 },
        scoopCents = -75.0, vbrDepthCents = 95.0, vbrFreqHz = 7.0, expPadX = 1.0, expPadY = 1.0,
        pitchSensitivity = 0.95, phonemeSensitivity = 0.95, humanizeJitter = 0.10, attackPunch = 0.50, releaseBreath = 0.20
    },
    [14] = { -- Neurofunk / Techstep (Resonancia Metálica Ciber)
        tension   = { 0.80, 0.90, 0.85, 0.92, 0.70 },
        aliento   = { -0.50, -0.60, -0.40, -0.50, -0.30 },
        volumen   = { 1.5, 2.5, 2.2, 2.6, 1.0 },
        genero    = { -0.15, -0.15, -0.15, -0.15, -0.15 },
        voicing   = { 0.98, 0.98, 0.95, 0.98, 0.90 },
        timbre    = { 0.40, 0.48, 0.52, 0.48, 0.38 },
        vibrato   = { 0.0, 0.2, 0.5, 0.8, 0.4 },
        vocalModeTarget = { solid = 0.95, clear = 0.90, power = 0.80, soft = -0.60 },
        scoopCents = -35.0, vbrDepthCents = 60.0, vbrFreqHz = 5.4, expPadX = 0.8, expPadY = 0.7,
        pitchSensitivity = 0.70, phonemeSensitivity = 0.85, humanizeJitter = 0.08, attackPunch = 0.30, releaseBreath = 0.25
    },
    [15] = { -- Eurobeat / Hi-NRG (Super Eurobeat / Alta Energía)
        tension   = { 0.90, 0.85, 0.85, 0.90, 0.75 },
        aliento   = { -0.60, -0.50, -0.50, -0.40, -0.25 },
        volumen   = { 2.0, 2.5, 2.8, 3.0, 1.5 },
        genero    = { -0.12, -0.12, -0.12, -0.12, -0.12 },
        voicing   = { 0.98, 1.00, 1.00, 0.98, 0.90 },
        timbre    = { 0.35, 0.40, 0.40, 0.35, 0.30 },
        vibrato   = { 0.0, 0.5, 1.4, 2.0, 1.6 },
        vocalModeTarget = { power = 0.95, clear = 1.00, vivid = 1.00, chest = 0.70 },
        scoopCents = -25.0, vbrDepthCents = 75.0, vbrFreqHz = 6.6, expPadX = 0.8, expPadY = 0.85,
        pitchSensitivity = 0.85, phonemeSensitivity = 0.60, humanizeJitter = 0.04, attackPunch = 0.35, releaseBreath = 0.15
    },
    [16] = { -- Future Bass / Kawaii (Airy Swells, Pitch Glide & Formante Tierno)
        tension   = { 0.25, 0.45, 0.55, 0.35, 0.15 },
        aliento   = { 0.40, 0.50, 0.40, 0.60, 0.70 },
        volumen   = { 0.2, 1.5, 1.8, 1.0, -0.8 },
        genero    = { -0.35, -0.40, -0.40, -0.35, -0.30 },
        voicing   = { 0.75, 0.85, 0.90, 0.80, 0.65 },
        timbre    = { -0.25, -0.20, -0.15, -0.25, -0.30 },
        vibrato   = { 0.0, 0.4, 1.0, 1.5, 1.2 },
        vocalModeTarget = { soft = 0.90, airy = 0.85, vivid = 0.80, light = 0.95 },
        scoopCents = 40.0, vbrDepthCents = 55.0, vbrFreqHz = 5.2, expPadX = -0.5, expPadY = 0.6,
        pitchSensitivity = 0.60, phonemeSensitivity = 0.70, humanizeJitter = 0.06, attackPunch = 0.15, releaseBreath = 0.35
    },
    [17] = { -- Cyberpunk / Midtempo (Synthwave Industrial Pesado)
        tension   = { 0.85, 0.90, 0.80, 0.90, 0.70 },
        aliento   = { -0.50, -0.40, -0.50, -0.40, -0.20 },
        volumen   = { 1.5, 2.4, 2.6, 2.4, 1.0 },
        genero    = { 0.30, 0.30, 0.25, 0.25, 0.20 },
        voicing   = { 0.98, 0.98, 0.92, 0.98, 0.88 },
        timbre    = { 0.30, 0.35, 0.35, 0.30, 0.25 },
        vibrato   = { 0.0, 0.2, 0.5, 0.8, 0.6 },
        vocalModeTarget = { chest = 0.95, power = 0.90, solid = 1.00, soft = -0.80 },
        scoopCents = -50.0, vbrDepthCents = 65.0, vbrFreqHz = 5.2, expPadX = 0.8, expPadY = 0.8,
        pitchSensitivity = 0.80, phonemeSensitivity = 0.80, humanizeJitter = 0.07, attackPunch = 0.35, releaseBreath = 0.20
    },
    [18] = { -- Chiptune / 8-Bit Hardcore (Ataque Cuantizado & 0 Vibrato)
        tension   = { 0.60, 0.60, 0.60, 0.60, 0.60 },
        aliento   = { -0.70, -0.70, -0.70, -0.70, -0.70 },
        volumen   = { 1.2, 1.2, 1.2, 1.2, 1.0 },
        genero    = { 0.0, 0.0, 0.0, 0.0, 0.0 },
        voicing   = { 1.00, 1.00, 1.00, 1.00, 1.00 },
        timbre    = { 0.60, 0.60, 0.60, 0.60, 0.60 },
        vibrato   = { 0.0, 0.0, 0.0, 0.0, 0.0 },
        vocalModeTarget = { clear = 1.00, solid = 0.95, airy = -1.00 },
        scoopCents = 0.0, vbrDepthCents = 0.0, vbrFreqHz = 0.0, expPadX = 0.0, expPadY = 0.0,
        pitchSensitivity = 0.00, phonemeSensitivity = 0.10, humanizeJitter = 0.00, attackPunch = 0.00, releaseBreath = 0.00
    },
    [19] = { -- Hardstyle / Rawstyle (Punch Vocal Raw Screaming)
        tension   = { 1.00, 0.95, 0.95, 1.00, 0.85 },
        aliento   = { -0.80, -0.70, -0.70, -0.60, -0.40 },
        volumen   = { 3.0, 3.5, 3.8, 3.2, 2.2 },
        genero    = { 0.25, 0.25, 0.25, 0.25, 0.20 },
        voicing   = { 1.00, 1.00, 1.00, 1.00, 0.95 },
        timbre    = { 0.50, 0.50, 0.45, 0.50, 0.40 },
        vibrato   = { 0.0, 0.3, 0.7, 1.2, 0.8 },
        vocalModeTarget = { power = 1.00, chest = 0.95, solid = 1.00, passionate = 0.85 },
        scoopCents = -65.0, vbrDepthCents = 80.0, vbrFreqHz = 6.0, expPadX = 0.95, expPadY = 0.95,
        pitchSensitivity = 0.95, phonemeSensitivity = 0.90, humanizeJitter = 0.10, attackPunch = 0.45, releaseBreath = 0.25
    },
    [20] = { -- Uplifting Trance (Legato Eufórico & Vibrato Progresivo)
        tension   = { 0.40, 0.70, 0.90, 0.80, 0.45 },
        aliento   = { 0.15, 0.05, -0.15, 0.05, 0.25 },
        volumen   = { 0.5, 1.8, 2.6, 2.0, 0.8 },
        genero    = { -0.05, -0.05, -0.05, -0.05, -0.05 },
        voicing   = { 0.85, 0.92, 0.98, 0.92, 0.85 },
        timbre    = { 0.20, 0.25, 0.30, 0.25, 0.15 },
        vibrato   = { 0.0, 0.6, 1.6, 2.2, 1.8 },
        vocalModeTarget = { passionate = 0.95, clear = 0.90, soft = 0.35, airy = 0.25 },
        scoopCents = -35.0, vbrDepthCents = 85.0, vbrFreqHz = 5.8, expPadX = 0.6, expPadY = 0.75,
        pitchSensitivity = 0.75, phonemeSensitivity = 0.55, humanizeJitter = 0.05, attackPunch = 0.20, releaseBreath = 0.30
    }
}

-- ============================================================================
-- ESCALAS MÚSICALES AVANZADAS (15 ESCALAS)
-- ============================================================================
local ESCALAS_AVANZADAS = {
    [0]  = { 0, 2, 4, 7, 9 },                    -- Pentatónica Mayor
    [1]  = { 0, 3, 5, 7, 10 },                   -- Pentatónica Menor
    [2]  = { 0, 2, 4, 5, 7, 9, 11 },             -- Mayor Natural (Jónica)
    [3]  = { 0, 2, 3, 5, 7, 8, 10 },             -- Menor Natural (Eólica)
    [4]  = { 0, 2, 3, 5, 7, 8, 11 },             -- Menor Armónica
    [5]  = { 0, 2, 3, 5, 7, 9, 11 },             -- Menor Melódica
    [6]  = { 0, 2, 3, 5, 7, 9, 10 },             -- Dórica
    [7]  = { 0, 1, 3, 5, 7, 8, 10 },             -- Frigia
    [8]  = { 0, 2, 4, 6, 7, 9, 11 },             -- Lidia
    [9]  = { 0, 2, 4, 5, 7, 9, 10 },             -- Mixolidia
    [10] = { 0, 1, 3, 5, 6, 8, 10 },             -- Locria
    [11] = { 0, 3, 5, 6, 7, 10 },                -- Blues
    [12] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }, -- Cromática
    [13] = { 0, 2, 3, 6, 7, 8, 11 },             -- Húngara Menor
    [14] = { 0, 1, 4, 5, 7, 8, 11 },             -- Doble Armónica (Bizantina)
}

-- ============================================================================
-- PERFILES DE PITCH CLASS DE KRUMHANSL-KESSLER (AUTO-DETECCIÓN DE TONALIDAD)
-- ============================================================================
local PERFILES_KRUMHANSL = {
    -- Tonalidad Mayor: C, C#, D, D#, E, F, F#, G, G#, A, A#, B
    mayor = { 6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88 },
    -- Tonalidad Menor: C, C#, D, D#, E, F, F#, G, G#, A, A#, B
    menor = { 6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17 }
}

-- ============================================================================
-- PROGRESIONES DE ACORDES PREDEFINIDAS
-- ============================================================================
local PROGRESIONES_ACORDES = {
    [0]  = { nombre = "J-Pop / Anime Royal", grados = { 4, 5, 3, 6 }, tipos = { "maj7", "dom7", "min7", "min7" } },
    [1]  = { nombre = "Pop / EDM Anthem", grados = { 1, 5, 6, 4 }, tipos = { "add9", "triada_mayor", "min7", "maj7" } },
    [2]  = { nombre = "Neo-Soul / R&B Lounge", grados = { 2, 5, 1, 6 }, tipos = { "min9", "dom13", "maj9", "dom7alt" } },
    [3]  = { nombre = "Jazz Cadencia 2-5-1", grados = { 2, 5, 1, 6 }, tipos = { "min7", "dom7", "maj7", "dom7" } },
    [4]  = { nombre = "Dark Ambient Horror", grados = { 1, 6, 3, 7 }, tipos = { "triada_menor", "maj7", "maj7", "dom7" } },
    [5]  = { nombre = "Artcore / Breakcore Kinetic", grados = { 4, 5, 1, 6 }, tipos = { "min7", "min7", "min9", "maj7" } },
    [6]  = { nombre = "City Pop / 80s Funk", grados = { 4, 3, 6, 2 }, tipos = { "maj7", "dom7", "min7", "dom7" } },
    [7]  = { nombre = "Math Rock / Midwest Emo", grados = { 1, 4, 6, 5 }, tipos = { "add9", "maj7", "min7", "sus4" } },
    [8]  = { nombre = "Future Bass / Kawaii Chords", grados = { 4, 5, 3, 6 }, tipos = { "maj9", "dom9", "min7", "min9" } },
    [9]  = { nombre = "Lo-Fi Chill Hop", grados = { 1, 6, 2, 5 }, tipos = { "maj7", "dom7", "min7", "dom7alt" } },
    [10] = { nombre = "Cyberpunk Midtempo Dystopia", grados = { 1, 2, 1, 6 }, tipos = { "triada_menor", "triada_mayor", "triada_menor", "maj7" } },
    [11] = { nombre = "Orquestal Dramático Swell", grados = { 1, 4, 5, 1 }, tipos = { "triada_menor", "min7", "dom7", "triada_menor" } },
    [12] = { nombre = "Gospel / Soul Elevación", grados = { 1, 1, 4, 4 }, tipos = { "triada_mayor", "dom7", "triada_mayor", "triada_menor" } },
    [13] = { nombre = "Gabber / Hardstyle Stabs", grados = { 1, 6, 7, 1 }, tipos = { "triada_menor", "triada_mayor", "triada_mayor", "triada_menor" } },
    [14] = { nombre = "Chiptune / 8-Bit Heroico", grados = { 1, 7, 6, 5 }, tipos = { "triada_mayor", "triada_mayor", "triada_mayor", "dom7" } },
    [15] = { nombre = "Uplifting Trance Pad", grados = { 6, 4, 1, 5 }, tipos = { "min7", "maj7", "triada_mayor", "dom7" } },
    [16] = { nombre = "Canon de Pachelbel (8 Acordes)", grados = { 1, 5, 6, 3, 4, 1, 4, 5 }, tipos = { "triada_mayor", "triada_mayor", "triada_menor", "triada_menor", "triada_mayor", "triada_mayor", "triada_mayor", "triada_mayor" } },
    [17] = { nombre = "Pop Rock Clásico (8 Acordes)", grados = { 1, 5, 6, 4, 1, 5, 6, 4 }, tipos = { "triada_mayor", "triada_mayor", "triada_menor", "triada_mayor", "triada_mayor", "triada_mayor", "triada_menor", "triada_mayor" } },
    [18] = { nombre = "Jazz Cadencia Standard (3 Acordes)", grados = { 2, 5, 1 }, tipos = { "min7", "dom7", "maj7" } },
    [19] = { nombre = "Épico Tráiler Oscuro (2 Acordes)", grados = { 1, 6 }, tipos = { "triada_menor", "maj7" } },
    [20] = { nombre = "Melancolía Neoclásica (6 Acordes)", grados = { 6, 4, 1, 5, 6, 3 }, tipos = { "triada_menor", "triada_mayor", "triada_mayor", "triada_mayor", "triada_menor", "triada_menor" } }
}

-- ============================================================================
-- PRESETS CORALES Y ARMONÍAS MULTI-VOZ
-- ============================================================================
local PRESETS_CORALES = {
    [0] = { nombre = "Dúo 3ras Superiores", intervalos = { 2 }, nombresVoces = { "Voz 2 (3ra Arriba)" } },
    [1] = { nombre = "Dúo 3ras Inferiores", intervalos = { -2 }, nombresVoces = { "Voz 2 (3ra Abajo)" } },
    [2] = { nombre = "Trío Pop (3ras y 5tas)", intervalos = { 2, 4 }, nombresVoces = { "Voz 2 (3ra)", "Voz 3 (5ta)" } },
    [3] = { nombre = "Cuarteto Coral SATB", intervalos = { 4, 2, -4, -7 }, nombresVoces = { "Soprano", "Alto", "Tenor", "Bajo" } },
    [4] = { nombre = "Power Duo (5tas y 8vas)", intervalos = { 4, 7 }, nombresVoces = { "Power 5ta", "Octava" } },
    [5] = { nombre = "Coro Unísono Anti-fase", intervalos = { 0, 0 }, nombresVoces = { "Doblaje A", "Doblaje B" } }
}

