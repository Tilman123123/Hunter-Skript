local sellPrices = {
    ["deer_pelt"] = 300,
    ["boar_meat"] = 200,
    ["bear_claw"] = 500,
    ["rabbit_foot"] = 120,
    ["fox_fur"] = 250,
    ["coyote_tail"] = 180
}

RegisterNetEvent("hunter:sellItem", function(item)
    local src = source
    local player = GetPlayerIdentifier(src)
    local price = sellPrices[item]

    if price then
        -- Beispiel: Item entfernen & Geld geben
        TriggerEvent("inventory:removeItem", src, item, 1, function(success)
            if success then
                TriggerEvent("esx:addMoney", src, price)
                print(("Item %s verkauft für %s$ an %s"):format(item, price, player))
            else
                print("[Fehler] Spieler hat Item nicht.")
            end
        end)
    else
        print("[Warnung] Unbekannter Verkaufsgegenstand:", item)
    end
end)

-- server/sell.lua

RegisterNetEvent('hunter:sellItems', function()
    local src = source
    local Player = GetPlayerFromId(src) -- Passe das ggf. an dein Framework an
    local total = 0

    -- Beispielinventar-Check: (dies muss angepasst werden an dein Framework!)
    local inventory = exports["inventory"]:getInventory(src)

    for _, item in pairs(inventory) do
        if item.name == "meat" then
            total = total + (item.amount * 10)
        elseif item.name == "pelt" then
            total = total + (item.amount * 20)
        end
    end

    if total > 0 then
        -- Belohnung auszahlen
        -- Passe das an dein Zahlungssystem an!
        TriggerEvent("bank:addMoney", src, total)
        TriggerClientEvent("chat:addMessage", src, {
            args = { "Verkauf", "Du hast deine Jagdbeute für $" .. total .. " verkauft!" }
        })
    else
        TriggerClientEvent("chat:addMessage", src, {
            args = { "Verkauf", "Du hast nichts zu verkaufen." }
        })
    end
end)

-- server/sell.lua

RegisterNetEvent("hunter:sellItems")
AddEventHandler("hunter:sellItems", function()
    local src = source
    local xPlayer = GetPlayerFromId(src)
    local total = 0

    for animal, data in pairs(Config.Rewards) do
        local amount = xPlayer.getInventoryItem(animal).count
        if amount > 0 then
            local reward = data.price * amount
            total += reward
            xPlayer.removeInventoryItem(animal, amount)
        end
    end

    if total > 0 then
        xPlayer.addMoney(total)
        TriggerClientEvent('ox_lib:notify', src, { type = 'success', description = "Du hast deine Beute für $" .. total .. " verkauft!" })
    else
        TriggerClientEvent('ox_lib:notify', src, { type = 'error', description = "Du hast keine Beute zum Verkaufen." })
    end
end)
