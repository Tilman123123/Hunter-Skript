RegisterServerEvent("hunt:giveReward")
AddEventHandler("hunt:giveReward", function(item, count)
    print(("Spieler erhält: %dx %s"):format(count, item))
    -- Trigger Event zum Inventarsystem hier ergänzen
end)
