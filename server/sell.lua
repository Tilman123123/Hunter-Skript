-- server/sell.lua

local Rewards = {
    ["deer_pelt"]    = { min = 300,  max = 1000 },
    ["boar_pelt"]    = { min = 400,  max = 1100 },
    ["bear_pelt"]    = { min = 600,  max = 1500 },
    ["rabbit_pelt"]  = { min = 100,  max = 300 },
    ["fox_pelt"]     = { min = 200,  max = 600 },
    ["coyote_pelt"]  = { min = 250,  max = 700 },
    ["hen_pelt"]     = { min = 80,   max = 350 },
    ["cow_pelt"]     = { min = 800,  max = 1600 },
    ["goat_pelt"]    = { min = 400,  max = 900 }
}

RegisterNetEvent("hunter:sellItems", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local total = 0

    for item, range in pairs(Rewards) do
        local count = xPlayer.getInventoryItem(item)?.count or 0
        if count > 0 then
            local unitPrice = math.random(range.min, range.max)
            local reward = count * unitPrice
            xPlayer.removeInventoryItem(item, count)
            total += reward
        end
    end

    if total > 0 then
        xPlayer.addMoney(total)
        TriggerClientEvent("ox_lib:notify", src, {
            type = "success",
            description = ("Du hast deine Beute für $%s verkauft!"):format(total)
        })
    else
        TriggerClientEvent("ox_lib:notify", src, {
            type = "error",
            description = "Du hast nichts zum Verkaufen."
        })
    end
end)
