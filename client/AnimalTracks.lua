local tracks = {}

function SpawnTrack(pos)
    local id = AddBlipForCoord(pos)
    SetBlipSprite(id, 141)
    SetBlipColour(id, 5)
    SetBlipScale(id, 0.5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Tier-Spur")
    EndTextCommandSetBlipName(id)
    table.insert(tracks, id)
end

function ClearTracks()
    for _, id in ipairs(tracks) do
        RemoveBlip(id)
    end
    tracks = {}
end
