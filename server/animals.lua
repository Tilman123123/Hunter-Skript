-- server/animals.lua

local spawnedAnimals = {}

RegisterNetEvent('hunter:server:registerAnimalKill', function(animalType, zone)
    local src = source
    local reward = GetAnimalReward(animalType)
    if reward then
        AddMoney(src, reward)
        LogKill(src, animalType, zone)
        TriggerClientEvent('hunter:client:notifyReward', src, animalType, reward)
    end
end)

function GetAnimalReward(animal)
    local rewards = {
        deer = 120,
        boar = 90,
        rabbit = 50,
        bear = 200
    }
    return rewards[animal]
end

function AddMoney(src, amount)
    -- Replace with your framework logic (ESX/QBCore)
    print(('Give %s $%s'):format(src, amount))
end

function LogKill(src, animal, zone)
    print(('Player %s killed %s in %s'):format(src, animal, zone))
end

local db = require("server.database_handler")

RegisterNetEvent("hunter:animalKilled")
AddEventHandler("hunter:animalKilled", function(animalType, reward, dropItem)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.getIdentifier()

    db.insertHuntedAnimal(identifier, animalType, reward, dropItem)

    print(("[HUNTER] %s hat ein %s erlegt."):format(identifier, animalType))
end)
