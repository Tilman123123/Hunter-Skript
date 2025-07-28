local availableMissions = {}

RegisterNetEvent("hunter:requestMission")
AddEventHandler("hunter:requestMission", function()
    local src = source
    local mission = availableMissions[1] -- simplified for demo
    if mission then
        TriggerClientEvent("hunter:startMission", src, mission)
    end
end)

function loadMissions()
    table.insert(availableMissions, require("server/missions/mission_01"))
end

loadMissions()
