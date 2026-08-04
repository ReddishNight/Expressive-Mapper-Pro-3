--[[
===============================================================================
  Mapeador Expresivo Pro 3 - Synthesizer V Studio Pro 2
  Lenguaje: Lua 5.4 / LuaJIT (Entorno SynthV Studio Pro 2)
  Autor: Nyoru.X
  Versión Script: 3.6.1 (Entonación Justa, TCB Splines, Contrapunto Fux & Voice Leading Minimal Energy)
  Compatibilidad Estricta: Synthesizer V Studio 2 PRO v2.2.1+
  Build Objetivado: Mar 2 2026 13:09:42 (editorVersion >= 67072)

  Descripción:
    Motor modular definitivo de expresividad vocal, generación melódica prosódica, automatización Hermite/TCB,
    armonía vocal con Entonación Justa (Just Intonation), contrapunto algorítmico fuxiano estricto
    y progresiones de acordes con Voice Leading de matriz de energía mínima.
    Arquitectura orientada a datos (Data-Oriented Design) con 0 GC Alloc en runtime.

  Funcionalidades Principales:
    - Modo 0: Generación prosódica RAE multilingüe (diptongos, hiatos, curvas emocionales de entonación).
    - Modo 1: Automatización Hermite / Kochanek-Bartels (TCB) Splines con micro-expresión fonémica y RDP.
    - Modo 2: Armonías Vocales con Entonación Justa (-14c en 3ra Maj, +16c en 3ra Min) y formantes por registro.
    - Modo 3: Contrapunto Fuxiano Estricto (5 Especies con retardos, compensación de saltos y clímax único).
    - Modo 4: Progresiones de acordes con Voice Leading Minimal Energy (\sum \Delta pitch^2) y Micro-swing.
===============================================================================
--]]

-- ============================================================================
-- METADATOS DEL SCRIPT
-- ============================================================================

function getClientInfo()
    return {
        name = "Mapeador Expresivo Pro 3 (SynthV Studio 2 PRO v2.2.1)",
        author = "Nyoru.X",
        versionNumber = 3,
        minEditorVersion = 67072
    }
end

function getScriptTitle()
    return "Mapeador Expresivo Pro 3 (SynthV Studio 2 PRO v2.2.1)"
end

function getScriptVersion()
    return 3
end

function getScriptSide()
    return "SVClient"
end

function getMinEditorVersion()
    return 67072
end
