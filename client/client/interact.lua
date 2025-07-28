RegisterCommand("interact", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    print("Interagiert bei Position:", coords)
    -- Beispiel: Öffne Interaktionsmenü oder überprüfe Zonen
end, false)
