-- server/xp.lua

local playerXPData = {}

RegisterNetEvent("hunter:addXP", function(amount)
    local src = source
    if not playerXPData[src] then playerXPData[src] = 0 end

    playerXPData[src] += amount
    local xp = playerXPData[src]

    TriggerClientEvent("hunter:updateXP", src, xp)

    print(("XP +%s für Spieler %s (gesamt: %s XP)"):format(amount, src, xp))
end)

AddEventHandler("playerDropped", function()
    local src = source
    playerXPData[src] = nil
end)
