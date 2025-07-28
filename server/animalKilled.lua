-- server/animalKilled.lua
-- Belohnung & XP für getötete Tiere

local rewardItems = {
    deer =     { item = "deer_pelt",     xp = 40, reward = 300 },
    boar =     { item = "boar_meat",     xp = 35, reward = 250 },
    bear =     { item = "bear_claw",     xp = 80, reward = 600 },
    rabbit =   { item = "rabbit_foot",   xp = 20, reward = 120 },
    fox =      { item = "fox_fur",       xp = 30, reward = 280 },
    coyote =   { item = "coyote_tail",   xp = 28, reward = 220 },
    hen =      { item = "hen_feather",   xp = 15, reward = 90  },
    cow =      { item = "cow_hide",      xp = 45, reward = 350 },
    goat =     { item = "goat_horn",     xp = 32, reward = 240 }
}

RegisterNetEvent("hunter:animalKilled", function(animalType, reward, item)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local data = rewardItems[animalType]

    if not xPlayer or not data then
        print(("[Fehler] Tier oder Spieler ungültig: %s, %s"):format(tostring(animalType), tostring(src)))
        return
    end

    -- Item ins Inventar
    xPlayer.addInventoryItem(data.item, 1)

    -- XP geben
    TriggerEvent("hunter:addXP", data.xp)

    -- Optionale Auszahlung direkt beim Töten:
    -- xPlayer.addMoney(data.reward)

    print(("Spieler %s hat %s getötet und %s XP + 1x %s erhalten."):format(src, animalType, data.xp, data.item))
end)
