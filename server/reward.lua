-- server/reward.lua

local XP_PER_KILL = 10

RegisterNetEvent("hunter:server:grantXP", function()
    local src = source
    -- Add XP logic here
    print(("Granted %s XP to %s"):format(XP_PER_KILL, src))
end)

RegisterNetEvent("hunter:server:rewardItem", function(animal)
    local src = source
    local item = GetItemFromAnimal(animal)
    if item then
        -- Give item (e.g., pelt)
        print(("Gave player %s item: %s"):format(src, item))
    end
end)

function GetItemFromAnimal(animal)
    local items = {
        deer = "deer_pelt",
        boar = "boar_tusk",
        rabbit = "rabbit_hide",
        bear = "bear_pelt"
    }
    return items[animal]
end

-- server/rewards.lua

local Rewards = {}

-- Auszahlung von Geld
function Rewards.giveMoney(playerId, amount)
    if amount > 0 then
        TriggerEvent('esx:addMoney', playerId, amount)
    end
end

-- Auszahlung von Items
function Rewards.giveItem(playerId, itemName, count)
    if itemName and count > 0 then
        TriggerEvent('esx:addInventoryItem', playerId, itemName, count)
    end
end

-- Auszahlung von XP (optional, falls du ein XP-System nutzt)
function Rewards.giveXP(playerId, xp)
    TriggerEvent('hunter:addXP', playerId, xp)
end

-- Kombinierte Belohnung für Mission
function Rewards.giveReward(playerId, reward)
    Rewards.giveMoney(playerId, reward.money or 0)
    Rewards.giveItem(playerId, reward.item, reward.itemCount or 0)
    Rewards.giveXP(playerId, reward.xp or 0)
end

return Rewards

-- XP geben
if reward.xp then
    DatabaseHandler.getXP(playerId, function(currentXP)
        local newXP = currentXP + reward.xp
        DatabaseHandler.setXP(playerId, newXP)
        print("[HUNTER] Spieler " .. tostring(playerId) .. " hat jetzt " .. newXP .. " XP.")
    end)
end

RegisterNetEvent("hunter:giveReward")
AddEventHandler("hunter:giveReward", function(animalType)
    local src = source
    local rewardAmount = Config.AnimalRewards[animalType] or 0

    if rewardAmount > 0 then
        -- Beispiel: Spieler erhält Geld
        AddMoneyToPlayer(src, rewardAmount)
        TriggerClientEvent("esx:showNotification", src, "Du hast $" .. rewardAmount .. " erhalten für: " .. animalType)
    else
        print("[WARNUNG] Kein Reward für Tier: " .. tostring(animalType))
    end
end)

function AddMoneyToPlayer(src, amount)
    -- Nutze dein Framework (z. B. ESX oder QBCore)
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer then
        xPlayer.addMoney(amount)
    end
end

MySQL.Async.execute("INSERT INTO hunter_rewards (identifier, animal, reward) VALUES (@identifier, @animal, @reward)", {
    ["@identifier"] = xPlayer.identifier,
    ["@animal"] = animalType,
    ["@reward"] = rewardAmount
})

RegisterServerEvent("hunting:reward")
AddEventHandler("hunting:reward", function(animalType)
    local src = source
    local reward = 0

    if animalType == "deer" then
        reward = 150
    elseif animalType == "boar" then
        reward = 200
    end

    if reward > 0 then
        -- Beispiel: Gib dem Spieler Geld
        AddMoney(src, reward)
        TriggerClientEvent("lib:notify", src, {
            title = "Jagd",
            description = "Du hast $" .. reward .. " erhalten.",
            type = "success"
        })
    else
        print("[WARNUNG] Unbekannter Tier-Typ für Belohnung: " .. tostring(animalType))
    end
end)

-- Hilfsfunktion für Geld (kann angepasst werden)
function AddMoney(playerId, amount)
    -- Hier mit deinem Framework ersetzen!
    -- z. B. ESX.GetPlayerFromId(playerId).addMoney(amount)
    print("Dem Spieler " .. playerId .. " wurde $" .. amount .. " gutgeschrieben.")
end

local rewardConfig = {
    ["deer"] = {money = 150, item = "deer_pelt"},
    ["boar"] = {money = 100, item = "boar_meat"},
    ["bear"] = {money = 250, item = "bear_claw"},
    ["rabbit"] = {money = 50, item = "rabbit_foot"},
    ["fox"] = {money = 120, item = "fox_fur"},
    ["coyote"] = {money = 90, item = "coyote_tail"}
}

RegisterNetEvent("hunter:giveReward", function(animalType)
    local src = source
    local player = GetPlayerIdentifier(src)

    local reward = rewardConfig[animalType]
    if reward then
        -- Beispiel: Geld geben
        TriggerEvent("esx:addMoney", src, reward.money)
        -- Beispiel: Item geben
        TriggerEvent("inventory:addItem", src, reward.item, 1)

        print(("Belohnung ausgezahlt an %s: %s$ & %s"):format(player, reward.money, reward.item))
    else
        print("[Warnung] Unbekannter Tier-Typ bei Belohnung:", animalType)
    end
end)

-- server/reward.lua

local baseReward = 150

local animalRewards = {
    ["deer"] = 150,
    ["boar"] = 200,
    ["mountainlion"] = 300,
    ["rabbit"] = 100,
    ["coyote"] = 120,
    ["bird"] = 80
}

RegisterNetEvent("hunting:giveReward")
AddEventHandler("hunting:giveReward", function(animalType)
    local src = source
    local reward = animalRewards[animalType] or baseReward
    AddMoneyToPlayer(src, reward)
    TriggerClientEvent("hunting:notify", src, ("Du hast %s$ für das Tier erhalten."):format(reward))
end)

function AddMoneyToPlayer(playerId, amount)
    -- Hier kannst du dein Framework-spezifisches AddMoney-Event aufrufen
    -- z.B. TriggerEvent("esx:addMoney", playerId, amount)
    print(("Spieler %s erhält %s$"):format(playerId, amount))
end
