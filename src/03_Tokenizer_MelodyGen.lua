-- ============================================================================
-- MÓDULO 3: TOKENIZADOR MULTILINGÜE Y GENERADOR MELÓDICO PROSÓDICO (ES, EN, JA)
-- ============================================================================

local ESCALAS = ESCALAS_AVANZADAS or {
    [0] = { 0, 2, 4, 7, 9 },       -- Pentatónica Mayor
    [1] = { 0, 3, 5, 7, 10 },      -- Pentatónica Menor
    [2] = { 0, 2, 4, 5, 7, 9, 11 },-- Mayor Natural
    [3] = { 0, 2, 3, 5, 7, 8, 10 } -- Menor Natural
}

--- Auto-detección de tonalidad mediante correlación estadística de Krumhansl-Kessler
local function detectarTonalidad(noteGroup)
    if not noteGroup then return 0, 2 end -- Default: C Mayor

    local numNotas = noteGroup:getNumNotes()
    if numNotas == 0 then return 0, 2 end

    local hist = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    local totalDur = 0

    for i = 1, numNotas do
        local n = noteGroup:getNote(i)
        if n then
            local pc = n:getPitch() % 12
            local dur = n:getDuration()
            local onset = n:getOnset()
            -- Ponderación métrica: notas en tiempos fuertes (tiempos 1 y 3 en 4/4) tienen mayor peso estadístico (1.5x)
            local multMetrico = 1.0
            if onset and SV and SV.QUARTER then
                if (onset % (SV.QUARTER * 2)) == 0 then
                    multMetrico = 1.5
                end
            end
            local pesoEfectivo = dur * multMetrico
            hist[pc + 1] = hist[pc + 1] + pesoEfectivo
            totalDur = totalDur + pesoEfectivo
        end
    end

    if totalDur == 0 then return 0, 2 end

    local meanHist = 0
    for i = 1, 12 do meanHist = meanHist + hist[i] end
    meanHist = meanHist / 12.0

    local perfilMayor = (PERFILES_KRUMHANSL and PERFILES_KRUMHANSL.mayor) or { 6.35, 2.23, 3.48, 2.33, 4.38, 4.09, 2.52, 5.19, 2.39, 3.66, 2.29, 2.88 }
    local perfilMenor = (PERFILES_KRUMHANSL and PERFILES_KRUMHANSL.menor) or { 6.33, 2.68, 3.52, 5.38, 2.60, 3.53, 2.54, 4.75, 3.98, 2.69, 3.34, 3.17 }

    local meanProfMaj = 0
    local meanProfMin = 0
    for i = 1, 12 do
        meanProfMaj = meanProfMaj + perfilMayor[i]
        meanProfMin = meanProfMin + perfilMenor[i]
    end
    meanProfMaj = meanProfMaj / 12.0
    meanProfMin = meanProfMin / 12.0

    local mejorTonica = 0
    local mejorEscala = 2
    local maxCorr = -9999.0

    for root = 0, 11 do
        -- Correlación Mayor
        local corrMayor = 0.0
        local sumHistSqMaj = 0.0
        local sumProfSqMaj = 0.0

        for i = 1, 12 do
            local pcIdx = ((i - 1 + root) % 12) + 1
            local diffH = hist[pcIdx] - meanHist
            local diffP = perfilMayor[i] - meanProfMaj
            corrMayor = corrMayor + (diffH * diffP)
            sumHistSqMaj = sumHistSqMaj + (diffH * diffH)
            sumProfSqMaj = sumProfSqMaj + (diffP * diffP)
        end

        local denomMaj = math.sqrt(sumHistSqMaj * sumProfSqMaj)
        if denomMaj > 0 then corrMayor = corrMayor / denomMaj end

        if corrMayor > maxCorr then
            maxCorr = corrMayor
            mejorTonica = root
            mejorEscala = 2
        end

        -- Correlación Menor
        local corrMenor = 0.0
        local sumHistSqMin = 0.0
        local sumProfSqMin = 0.0

        for i = 1, 12 do
            local pcIdx = ((i - 1 + root) % 12) + 1
            local diffH = hist[pcIdx] - meanHist
            local diffP = perfilMenor[i] - meanProfMin
            corrMenor = corrMenor + (diffH * diffP)
            sumHistSqMin = sumHistSqMin + (diffH * diffH)
            sumProfSqMin = sumProfSqMin + (diffP * diffP)
        end

        local denomMin = math.sqrt(sumHistSqMin * sumProfSqMin)
        if denomMin > 0 then corrMenor = corrMenor / denomMin end

        if corrMenor > maxCorr then
            maxCorr = corrMenor
            mejorTonica = root
            mejorEscala = 3
        end
    end

    return mejorTonica, mejorEscala
end


local NOTAS_NOMBRE = {
    C=0, ["C#"]=1, DB=1, D=2, ["D#"]=3, EB=3, E=4, F=5,
    ["F#"]=6, GB=6, G=7, ["G#"]=8, AB=8, A=9, ["A#"]=10, BB=10, B=11
}

-- Tabla de vocales acentuadas UTF-8 (cada carácter son 2 bytes en UTF-8)
-- á=\195\161, é=\195\169, í=\195\173, ó=\195\179, ú=\195\186
-- Á=\195\129, É=\195\137, Í=\195\141, Ó=\195\147, Ú=\195\154
local VOCALES_ACENTUADAS_UTF8 = {
    ["\195\161"] = true, -- á
    ["\195\169"] = true, -- é
    ["\195\173"] = true, -- í
    ["\195\179"] = true, -- ó
    ["\195\186"] = true, -- ú
    ["\195\129"] = true, -- Á
    ["\195\137"] = true, -- É
    ["\195\141"] = true, -- Í
    ["\195\147"] = true, -- Ó
    ["\195\154"] = true, -- Ú
}

local VOCALES_ES = {
    a = true, e = true, i = true, o = true, u = true,
    A = true, E = true, I = true, O = true, U = true,
}

local function notaStringAMidi(notaStr)
    local nombre, octava = string.match(notaStr, "^([A-Ga-g][#b]?)(%d+)$")
    if nombre and octava then
        nombre = string.upper(nombre)
        local base = NOTAS_NOMBRE[nombre]
        if base then
            -- Convención SynthV: C4 = 60, C-1 = 0 → (octava + 1) * 12
            return (tonumber(octava) + 1) * 12 + base
        end
    end
    return nil
end

local function cuantizarAEscala(pitchMidi, basePitch, escalaIndices)
    local rel = pitchMidi - basePitch
    local octava = math.floor(rel / 12)
    local semitonoMod = rel % 12
    if semitonoMod < 0 then semitonoMod = semitonoMod + 12 end

    local numElem = #escalaIndices
    local mejorNota = escalaIndices[1]
    local minDiff = math.abs(semitonoMod - mejorNota)

    for idx = 2, numElem do
        local notaEscala = escalaIndices[idx]
        local diff = math.abs(semitonoMod - notaEscala)
        if diff < minDiff then
            minDiff = diff
            mejorNota = notaEscala
        end
    end

    return basePitch + (octava * 12) + mejorNota
end

--- Detectar si un token UTF-8 contiene una vocal acentuada española
local function contieneTildeUTF8(token)
    -- Recorrer grafemas UTF-8 de 2 bytes (rango \195\128 a \195\191)
    local i = 1
    local len = #token
    while i <= len do
        local byte1 = string.byte(token, i)
        if byte1 >= 194 and byte1 <= 244 and i + 1 <= len then
            local grafema = string.sub(token, i, i + 1)
            if VOCALES_ACENTUADAS_UTF8[grafema] then
                return true
            end
            -- Avanzar según longitud UTF-8
            if byte1 >= 240 then
                i = i + 4
            elseif byte1 >= 224 then
                i = i + 3
            else
                i = i + 2
            end
        else
            i = i + 1
        end
    end
    return false
end

--- Detección de acentuación prosódica según idioma (ES, EN, JA)
local function analizarProsodiaSilaba(token, idiomaIdx, indiceNota, totalCantadas, esPregunta, esExclamacion)
    local esTonica = false
    local deltaPitchProsodico = 0
    local multDurProsodico = 1.0

    if idiomaIdx == 0 then -- Español
        -- Detección robusta de tilde en vocal española via bytes UTF-8
        if contieneTildeUTF8(token) then
            esTonica = true
        else
            local tokenLower = string.lower(token)
            -- Heurística: si termina en vocal, n, o s → palabra grave (penúltima tónica)
            if string.match(tokenLower, "[aeiou][ns]?$") then
                esTonica = (indiceNota % 2 == 1)
            else
                -- Palabras agudas (última sílaba acentuada)
                esTonica = true
            end
        end

        if esTonica then
            deltaPitchProsodico = 3
            multDurProsodico = 1.25
        end

        -- Inflexión prosódica al final de frase según puntuación (? / ! / declarativa)
        if indiceNota == totalCantadas then
            if esPregunta then
                deltaPitchProsodico = deltaPitchProsodico + 3
                multDurProsodico = multDurProsodico * 1.15
            elseif esExclamacion then
                deltaPitchProsodico = deltaPitchProsodico + 2
                multDurProsodico = multDurProsodico * 1.20
            else
                deltaPitchProsodico = deltaPitchProsodico - 2
            end
        end

    elseif idiomaIdx == 1 then -- Inglés
        local tokenLower = string.lower(token)
        -- Alternancia de acento iámbico/trocaico (sílabas fuertes)
        if (indiceNota % 2 == 1) or string.match(tokenLower, "ing$") or string.match(tokenLower, "tion$") then
            esTonica = true
            deltaPitchProsodico = 2
            multDurProsodico = 1.20
        else
            deltaPitchProsodico = -1
            multDurProsodico = 0.85
        end

        if indiceNota == totalCantadas then
            if esPregunta then
                deltaPitchProsodico = deltaPitchProsodico + 3
                multDurProsodico = multDurProsodico * 1.15
            elseif esExclamacion then
                deltaPitchProsodico = deltaPitchProsodico + 2
            end
        end

    elseif idiomaIdx == 2 then -- Japonés (Pitch Accent Moraico)
        -- Patrón de Pitch Accent (Heiban / Atamadaka drop)
        if indiceNota == 1 then
            deltaPitchProsodico = 0 -- Mora inicial
        elseif indiceNota == 2 then
            deltaPitchProsodico = 2 -- Subida de onset en Heiban
        elseif (indiceNota % 4 == 0) then
            deltaPitchProsodico = -3 -- Caída de acento en Nakadaka
        end

        if indiceNota == totalCantadas and esPregunta then
            deltaPitchProsodico = deltaPitchProsodico + 3
        end

        multDurProsodico = 1.00 -- Tempo moraico constante en Japonés
    end

    return deltaPitchProsodico, multDurProsodico
end

local VOCALES_ABIERTAS = {
    a=true, e=true, o=true, A=true, E=true, O=true,
    ["\195\161"] = true, -- á
    ["\195\169"] = true, -- é
    ["\195\179"] = true, -- ó
    ["\195\129"] = true, -- Á
    ["\195\137"] = true, -- É
    ["\195\147"] = true, -- Ó
}

local VOCALES_CERRADAS_ATONAS = {
    i=true, u=true, I=true, U=true,
    ["\195\188"] = true, -- ü
    ["\195\156"] = true, -- Ü
}

local VOCALES_CERRADAS_TONICAS = {
    ["\195\173"] = true, -- í
    ["\195\186"] = true, -- ú
    ["\195\141"] = true, -- Í
    ["\195\154"] = true, -- Ú
}

local CLUSTERS_INSEPARABLES = {
    bl=true, br=true, cl=true, cr=true, dr=true, fl=true, fr=true, gl=true, gr=true, pl=true, pr=true, tr=true,
    ch=true, ll=true, rr=true, qu=true, gu=true,
    BL=true, BR=true, CL=true, CR=true, DR=true, FL=true, FR=true, GL=true, GR=true, PL=true, PR=true, TR=true,
    CH=true, LL=true, RR=true, QU=true, GU=true
}

-- Diccionario de excepciones de silabificación para nombres propios y términos ambiguos
local EXCEPCIONES_SILABAS_ES = {
    luis = { "Luis" },
    marte = { "Mar-", "te" },
    juan = { "Juan" },
    dios = { "Dios" },
    rey = { "Rey" },
    san = { "San" },
    guia = { "Guí-", "a" },
    mario = { "Ma-", "rio" },
    jaime = { "Jai-", "me" },
    paula = { "Pau-", "la" },
    raul = { "Ra-", "úl" }
}

--- Auto-silabificador avanzado para español con reglas RAE (0 GC Alloc en buffers estáticos)
local function silabificarEspanol(palabra)
    local silabas = {}
    local len = #palabra
    if len == 0 then return silabas end

    local palabraLower = string.lower(palabra)
    if EXCEPCIONES_SILABAS_ES[palabraLower] then
        local exc = EXCEPCIONES_SILABAS_ES[palabraLower]
        for ei = 1, #exc do
            silabas[ei] = exc[ei]
        end
        return silabas
    end

    -- Reconstruir la palabra como secuencia de caracteres UTF-8
    local chars = {}
    local i = 1
    while i <= len do
        local byte1 = string.byte(palabra, i)
        local charLen = 1
        if byte1 >= 240 then charLen = 4
        elseif byte1 >= 224 then charLen = 3
        elseif byte1 >= 194 then charLen = 2
        end
        chars[#chars + 1] = string.sub(palabra, i, i + charLen - 1)
        i = i + charLen
    end

    local numChars = #chars
    if numChars == 0 then return silabas end

    -- Clasificar cada grafema: VA (Vocal Abierta), VC (Vocal Cerrada Átona), VT (Vocal Cerrada Tónica), C (Consonante)
    local tipos = {}
    for ci = 1, numChars do
        local ch = chars[ci]
        local chLow = string.lower(ch)
        if VOCALES_ABIERTAS[ch] or VOCALES_ABIERTAS[chLow] then
            tipos[ci] = "VA"
        elseif VOCALES_CERRADAS_TONICAS[ch] then
            tipos[ci] = "VT"
        elseif VOCALES_CERRADAS_ATONAS[ch] or VOCALES_CERRADAS_ATONAS[chLow] then
            tipos[ci] = "VC"
        else
            tipos[ci] = "C"
        end
    end

    -- Identificar posiciones donde se debe cortar la sílaba
    local cortarDespues = {}
    for ci = 1, numChars - 1 do
        cortarDespues[ci] = false
    end

    for ci = 1, numChars - 1 do
        local t1 = tipos[ci]
        local t2 = tipos[ci + 1]

        local esV1 = (t1 == "VA" or t1 == "VC" or t1 == "VT")
        local esV2 = (t2 == "VA" or t2 == "VC" or t2 == "VT")

        if esV1 and esV2 then
            -- Reglas de Diptongos e Hiatos entre dos vocales consecutivas:
            -- Hiato: Dos vocales abiertas (te-a-tro), o Abierta + Cerrada Tónica (ra-íz), o Cerrada Tónica + Abierta (dí-a)
            if (t1 == "VA" and t2 == "VA") or (t1 == "VA" and t2 == "VT") or (t1 == "VT" and t2 == "VA") or (t1 == "VT" and t2 == "VT") then
                cortarDespues[ci] = true
            end
        elseif esV1 and not esV2 then
            -- Una vocal seguida de una o más consonantes antes de la próxima vocal
            local nextVowelIdx = nil
            for k = ci + 1, numChars do
                if tipos[k] == "VA" or tipos[k] == "VC" or tipos[k] == "VT" then
                    nextVowelIdx = k
                    break
                end
            end

            if nextVowelIdx then
                local numCons = nextVowelIdx - ci - 1
                if numCons == 1 then
                    -- 1 consonante intervocálica: pasa a la siguiente sílaba (ca-sa)
                    cortarDespues[ci] = true
                elseif numCons == 2 then
                    -- 2 consonantes intervocálicas: revisar si forman grupo inseparable (tr, fl, dr, ch, rr, qu, gu...)
                    local pair = chars[ci + 1] .. chars[ci + 2]
                    local pairLow = string.lower(pair)
                    if CLUSTERS_INSEPARABLES[pair] or CLUSTERS_INSEPARABLES[pairLow] then
                        cortarDespues[ci] = true -- Ambas van con la segunda vocal (tra-ba-jo, fle-cha)
                    else
                        cortarDespues[ci + 1] = true -- Se dividen (al-to, cor-tar)
                    end
                elseif numCons == 3 then
                    -- 3 consonantes intervocálicas:
                    local pair = chars[ci + 2] .. chars[ci + 3]
                    local pairLow = string.lower(pair)
                    if CLUSTERS_INSEPARABLES[pair] or CLUSTERS_INSEPARABLES[pairLow] then
                        cortarDespues[ci + 1] = true -- 1ra va con 1ra vocal, 2da+3ra van con 2da vocal (es-plen-dor)
                    else
                        cortarDespues[ci + 2] = true -- 1ra+2da van con 1ra vocal, 3ra va con 2da vocal (cons-tan-te)
                    end
                elseif numCons >= 4 then
                    -- 4 consonantes intervocálicas: se dividen 2 y 2 (cons-truir)
                    cortarDespues[ci + 2] = true
                end
            end
        end
    end

    -- Construir las sílabas a partir de las marcas de corte
    local silabaActual = ""
    for ci = 1, numChars do
        silabaActual = silabaActual .. chars[ci]
        if cortarDespues[ci] then
            silabas[#silabas + 1] = silabaActual
            silabaActual = ""
        end
    end
    if silabaActual ~= "" then
        silabas[#silabas + 1] = silabaActual
    end

    if #silabas == 0 then
        silabas[1] = palabra
    end

    return silabas
end

--- Extraer sílabas soportando:
--- 1. Texto con guiones manuales (modo tradicional): "Can-ta-me_ u-na"
--- 2. Texto plano sin guiones (auto-tokenización): "Cántame una"
--- 3. JA (UTF-8 Kana/Romaji): caracteres individuales
local function extraerSilabas(texto, idiomaIdx)
    local silabas = {}

    -- Reemplazar barras verticales con guiones para unificar la separación manual
    local textoNormalizado = string.gsub(texto, "|", "-")
    local tieneSeparadores = string.find(textoNormalizado, "%-") ~= nil

    if tieneSeparadores then
        -- Modo tradicional / manual: separar por guiones/barras y espacios
        local textoLimpio = string.gsub(textoNormalizado, "%-", " ")
        for palabra in string.gmatch(textoLimpio, "%S+") do
            if string.find(palabra, "[\224-\239]") then
                for char in string.gmatch(palabra, "[%z\1-\127\194-\244][\128-\191]*") do
                    silabas[#silabas + 1] = char
                end
            else
                silabas[#silabas + 1] = palabra
            end
        end
    else
        -- Modo auto-tokenización: separar por palabras y luego silabificar
        for palabra in string.gmatch(textoNormalizado, "%S+") do
            -- Detectar marcadores especiales: pausas, holds, etc.
            if palabra == "_" or palabra == "," or palabra == "." or palabra == "、" or palabra == "。" then
                silabas[#silabas + 1] = palabra
            elseif string.find(palabra, "[\224-\239]") then
                -- Japonés: cada grafema es una mora/sílaba
                for char in string.gmatch(palabra, "[%z\1-\127\194-\244][\128-\191]*") do
                    silabas[#silabas + 1] = char
                end
            elseif idiomaIdx == 0 then
                -- Español: auto-silabificación en legato continuo
                local silabasPalabra = silabificarEspanol(palabra)
                for si = 1, #silabasPalabra do
                    silabas[#silabas + 1] = silabasPalabra[si]
                end
            else
                -- Inglés u otros: cada palabra es una sílaba en legato continuo
                silabas[#silabas + 1] = palabra
            end
        end

        -- Eliminar pausa final sobrante si existe
        if #silabas > 0 and silabas[#silabas] == "_" then
            silabas[#silabas] = nil
        end
    end

    return silabas
end

--- Convertir una sílaba española/latina a fonemas universales de Synthesizer V (0 GC Alloc)
local function convertirSilabaAFonemasEspanol(silaba)
    if not silaba or silaba == "" or silaba == "_" then return "" end
    local sLow = string.lower(silaba)

    if sLow == "aah" or sLow == "aa" or sLow == "ah" or sLow == "a" or sLow == "アー" then return "a" end
    if sLow == "ooo" or sLow == "oo" or sLow == "oh" or sLow == "o" or sLow == "オー" then return "o" end
    if sLow == "eee" or sLow == "ee" or sLow == "eh" or sLow == "e" or sLow == "イー" then return "e" end
    if sLow == "uuu" or sLow == "uu" or sLow == "ou" or sLow == "u" or sLow == "ウー" then return "u" end
    if sLow == "sanctus" or sLow == "san" then return "s a n" end
    if sLow == "ctus" or sLow == "tus" then return "k t u s" end
    if sLow == "glo" or sLow == "gloria" then return "g l o" end
    if sLow == "ria" then return "r i a" end
    if sLow == "al" then return "a l" end
    if sLow == "tu" then return "t u" end
    if sLow == "ras" then return "r a s" end
    if sLow == "co" then return "k o" end
    if sLow == "ro" then return "r o" end
    if sLow == "ce" then return "s e" end
    if sLow == "les" then return "l e s" end
    if sLow == "tial" then return "t i a l" end

    sLow = string.gsub(sLow, "que", "ke")
    sLow = string.gsub(sLow, "qui", "ki")
    sLow = string.gsub(sLow, "ca", "ka")
    sLow = string.gsub(sLow, "co", "ko")
    sLow = string.gsub(sLow, "cu", "ku")
    sLow = string.gsub(sLow, "ce", "se")
    sLow = string.gsub(sLow, "ci", "si")
    sLow = string.gsub(sLow, "za", "sa")
    sLow = string.gsub(sLow, "zo", "so")
    sLow = string.gsub(sLow, "zu", "su")
    sLow = string.gsub(sLow, "ga", "ga")
    sLow = string.gsub(sLow, "gue", "ge")
    sLow = string.gsub(sLow, "gui", "gi")
    sLow = string.gsub(sLow, "ja", "ha")
    sLow = string.gsub(sLow, "je", "he")
    sLow = string.gsub(sLow, "ji", "hi")
    sLow = string.gsub(sLow, "jo", "ho")
    sLow = string.gsub(sLow, "ju", "hu")
    sLow = string.gsub(sLow, "ll", "y")
    sLow = string.gsub(sLow, "ñ", "ny")
    sLow = string.gsub(sLow, "v", "b")

    local fonemas = ""
    local len = #sLow
    for i = 1, len do
        local c = string.sub(sLow, i, i)
        if c >= "a" and c <= "z" then
            if fonemas == "" then
                fonemas = c
            else
                fonemas = fonemas .. " " .. c
            end
        end
    end

    return fonemas
end

local function generarNotasDesdeTexto(letraRaw, basePitch, stepBlickBase, modoMelodiaIdx, escalaIdx, modoRitmoIdx, idiomaIdx, noteGroup, reproductor, rangoMin, rangoMax)
    local silabas = extraerSilabas(letraRaw, idiomaIdx)
    local numSilabas = #silabas
    if numSilabas == 0 then
        return {}
    end

    rangoMin = rangoMin or 36
    rangoMax = rangoMax or 84

    local esPregunta = (string.find(letraRaw, "%?") ~= nil or string.find(letraRaw, "¿") ~= nil)
    local esExclamacion = (string.find(letraRaw, "!") ~= nil or string.find(letraRaw, "¡") ~= nil)

    local escala = ESCALAS[escalaIdx] or ESCALAS[0]
    local numNotasEscala = #escala
    local currentBlick = reproductor:getPlayhead()
    local notasCreadas = {}
    local pitchPrevio = basePitch

    local totalCantadas = 0
    for i = 1, numSilabas do
        local s = silabas[i]
        if s ~= "_" and s ~= "," and s ~= "." and s ~= "、" and s ~= "。" then
            totalCantadas = totalCantadas + 1
        end
    end

    local indiceNota = 0

    for i = 1, numSilabas do
        local token = silabas[i]

        -- Silencio o pausa (_, ,, ., 、, 。)
        if token == "_" or token == "," or token == "." or token == "、" or token == "。" then
            currentBlick = currentBlick + stepBlickBase
        else
            indiceNota = indiceNota + 1

            -- Analizar prosodia por idioma
            local deltaPitchProsodico, multDurProsodico = analizarProsodiaSilaba(token, idiomaIdx, indiceNota, totalCantadas, esPregunta, esExclamacion)

            -- Modulador Rítmico de Duración
            local multRitmo = 1.0
            if modoRitmoIdx == 0 then -- Pop Sincopado
                if (indiceNota % 4 == 1) then multRitmo = 1.5
                elseif (indiceNota % 4 == 2) then multRitmo = 0.75
                elseif (indiceNota % 4 == 3) then multRitmo = 1.25
                else multRitmo = 0.50 end
            elseif modoRitmoIdx == 1 then -- Micro-Chop Kinético (Breakcore / Glitchcore)
                if (indiceNota % 3 == 0) then multRitmo = 0.25 -- 1/32 chop
                elseif (indiceNota % 2 == 0) then multRitmo = 0.50 -- 1/16 chop
                else multRitmo = 0.75 end
            elseif modoRitmoIdx == 2 then -- Legato Emotivo Swell (Artcore / Trance)
                if (indiceNota % 2 == 1) then multRitmo = 2.0
                else multRitmo = 1.5 end
            elseif modoRitmoIdx == 3 then -- Driving Hardcore (Gabber / Rock)
                if (indiceNota % 3 == 0) then multRitmo = 0.66 -- Tresillo
                else multRitmo = 0.75 end
            end

            -- Duración extendida por tildes explicitas (~)
            local numTildes = 0
            for _ in string.gmatch(token, "~") do
                numTildes = numTildes + 1
            end
            if numTildes > 0 then
                multRitmo = multRitmo * (1 + numTildes)
                token = string.gsub(token, "~", "")
            end

            local durBlick = math.max(math.floor(SV.QUARTER / 16), math.floor(stepBlickBase * multDurProsodico * multRitmo))
            local pitchTarget = nil

            -- Pitch explícito [C4], [G4], etc.
            local notaExp = string.match(token, "%[([A-Ga-g][#b]?%d+)%]")
            if notaExp then
                pitchTarget = notaStringAMidi(notaExp)
                token = string.gsub(token, "%[[^%]]+%]", "")
            end

            -- Offset explícito [+N] o [-N]
            if not pitchTarget then
                local offNum = string.match(token, "%[([+-]?%d+)%]")
                if offNum then
                    pitchTarget = pitchPrevio + tonumber(offNum)
                    token = string.gsub(token, "%[[^%]]+%]", "")
                end
            end

            -- Símbolos de inflexión (+, ++, -, --, ^, v)
            if not pitchTarget then
                if string.find(token, "%+%+") or string.find(token, "%^%^") then
                    pitchTarget = pitchPrevio + 4
                    token = string.gsub(token, "%+%+", "")
                    token = string.gsub(token, "%^%^", "")
                elseif string.find(token, "%+") or string.find(token, "%^") then
                    pitchTarget = pitchPrevio + 2
                    token = string.gsub(token, "%+", "")
                    token = string.gsub(token, "%^", "")
                elseif string.find(token, "%-%-") or string.find(token, "vv") then
                    pitchTarget = pitchPrevio - 4
                    token = string.gsub(token, "%-%-", "")
                    token = string.gsub(token, "vv", "")
                elseif string.find(token, "%-") or string.find(token, "v") then
                    pitchTarget = pitchPrevio - 2
                    token = string.gsub(token, "%-", "")
                    token = string.gsub(token, "v", "")
                end
            end

            -- Generador Melódico Prosódico Avanzado
            if not pitchTarget then
                if modoMelodiaIdx == 0 then
                    -- Arco Prosódico Emotivo
                    local progress = (totalCantadas > 1) and ((indiceNota - 1) / (totalCantadas - 1)) or 0.5
                    local deltaArc = math.sin(progress * math.pi) * 6.0
                    pitchTarget = basePitch + math.floor(deltaArc + deltaPitchProsodico + 0.5)
                elseif modoMelodiaIdx == 1 then
                    -- Pentatónico Expresivo con Saltos de 4tas y 5tas
                    local idxEscala = ((indiceNota - 1) % numNotasEscala) + 1
                    local saltoOctava = (indiceNota % 5 == 0) and 12 or 0
                    pitchTarget = basePitch + escala[idxEscala] + saltoOctava + deltaPitchProsodico
                elseif modoMelodiaIdx == 2 then
                    -- Onda Armónica Fluida
                    local deltaOnda = math.sin(indiceNota * 0.7) * 5.0
                    pitchTarget = basePitch + math.floor(deltaOnda + deltaPitchProsodico + 0.5)
                elseif modoMelodiaIdx == 3 then
                    -- Cromático Glitch / Caótico (Breakcore / Dark Ambient)
                    local saltoGlitch = ((indiceNota * 7) % 13) - 6
                    pitchTarget = basePitch + saltoGlitch
                elseif modoMelodiaIdx == 5 then
                    -- Arpegio Ascendente Paramétrico
                    local numOctavasPosibles = math.floor((rangoMax - rangoMin) / 12)
                    local noteInOctaveIdx = ((indiceNota - 1) % numNotasEscala) + 1
                    local octaveOffsetIdx = math.floor((indiceNota - 1) / numNotasEscala) % (numOctavasPosibles + 1)
                    pitchTarget = rangoMin + escala[noteInOctaveIdx] + (octaveOffsetIdx * 12)
                elseif modoMelodiaIdx == 6 then
                    -- Arpegio Descendente Paramétrico
                    local numOctavasPosibles = math.floor((rangoMax - rangoMin) / 12)
                    local noteInOctaveIdx = numNotasEscala - ((indiceNota - 1) % numNotasEscala)
                    local octaveOffsetIdx = numOctavasPosibles - (math.floor((indiceNota - 1) / numNotasEscala) % (numOctavasPosibles + 1))
                    pitchTarget = rangoMin + escala[noteInOctaveIdx] + (octaveOffsetIdx * 12)
                elseif modoMelodiaIdx == 7 then
                    -- Paso de Escala Aleatorio
                    local deltaStep = math.random(-2, 2)
                    pitchTarget = pitchPrevio + deltaStep
                elseif modoMelodiaIdx == 8 then
                    -- Movimiento por Saltos de Consonancia (3ra, 4ta, 5ta)
                    local consonancias = { 3, 4, 5, 7, -3, -4, -5, -7 }
                    local salto = consonancias[math.random(1, #consonancias)]
                    pitchTarget = pitchPrevio + salto
                else
                    -- Modo 4: Plano Expresivo (sin melodía, solo prosodia sutil)
                    pitchTarget = basePitch + deltaPitchProsodico
                end
            end

            -- Cuantizar y forzar límites de rango
            local pitchFinal = cuantizarAEscala(pitchTarget, basePitch, escala)
            if pitchFinal < rangoMin then
                pitchFinal = rangoMin + ((pitchFinal - rangoMin) % 12)
            elseif pitchFinal > rangoMax then
                pitchFinal = rangoMax - (math.abs(rangoMax - pitchFinal) % 12)
            end

            local nuevaNota = SV:create("Note")
            nuevaNota:setTimeRange(currentBlick, durBlick)
            nuevaNota:setPitch(pitchFinal)

            local letraLimpia = string.gsub(token, "%s+", "")
            if letraLimpia == "" then letraLimpia = "la" end
            nuevaNota:setLyrics(letraLimpia)

            noteGroup:addNote(nuevaNota)
            notasCreadas[#notasCreadas + 1] = nuevaNota

            pitchPrevio = pitchFinal
            currentBlick = currentBlick + durBlick
        end
    end

    return notasCreadas
end
