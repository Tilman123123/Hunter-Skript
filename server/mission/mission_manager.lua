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

-- mission-manager.lua (ganz unten einfügen)

local Rewards = require('server.rewards')

-- Missionserfolg → Belohnung ausgeben
function MissionManager.finishMission(playerId, missionId)
    local mission = MissionManager.activeMissions[playerId]
    if not mission or mission.id ~= missionId then
        print("[HUNTER] Fehler beim Beenden der Mission für Spieler " .. tostring(playerId))
        return
    end

    -- Beispiel-Belohnung
    local reward = {
        money = 1000,
        item = "meat",
        itemCount = 3,
        xp = 50
    }

    Rewards.giveReward(playerId, reward)
    MissionManager.activeMissions[playerId] = nil

    TriggerClientEvent('hunter:missionComplete', playerId)
    print("[HUNTER] Mission abgeschlossen für Spieler " .. tostring(playerId))
end
ja