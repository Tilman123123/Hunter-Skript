zones = {}

function AddZone(name, coords)
    zones[name] = coords
    print("Zone hinzugefügt:", name)
end

function IsPlayerInZone(name)
    local coords = GetEntityCoords(PlayerPedId())
    local zone = zones[name]
    return #(coords - zone) < 5.0
end
