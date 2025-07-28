-- Helper-Funktionen für das Hunterscript

local Helper = {}

-- Funktion zum zufälligen Auswählen eines Eintrags aus einer Liste
function Helper.getRandomFromList(list)
    if not list or #list == 0 then return nil end
    return list[math.random(1, #list)]
end

-- Funktion zum Formatieren von Zeit (Sekunden zu Minuten:Sekunden)
function Helper.formatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remaining = seconds % 60
    return string.format("%02d:%02d", minutes, remaining)
end

-- Funktion zur Berechnung der Distanz zwischen zwei Vektoren
function Helper.calculateDistance(vec1, vec2)
    local dx = vec1.x - vec2.x
    local dy = vec1.y - vec2.y
    local dz = vec1.z - vec2.z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

-- Funktion zur Protokollierung von Debug-Nachrichten
function Helper.debugPrint(msg)
    print("[HunterDebug] " .. tostring(msg))
end

return Helper
