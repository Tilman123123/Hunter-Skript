-- server/mission.lua

local missions = {
    [1] = {animal = "deer", amount = 3, reward = 300},
    [2] = {animal = "boar", amount = 2, reward = 200},
    [3] = {animal = "bear", amount = 1, reward = 500}
}

RegisterNetEvent("hunter:server:requestMission", function()
    local src = source
    local mission = missions[math.random(1, #missions)]
    TriggerClientEvent("hunter:client:receiveMission", src, mission)
end)

RegisterNetEvent("hunter:server:completeMission", function(missionId)
    local src = source
    local reward = missions[missionId].reward
    AddMoney(src, reward)
    TriggerClientEvent("hunter:client:notifyReward", src, missions[missionId].animal, reward)
end)
