RegisterServerEvent("hunt:notifyKill")
AddEventHandler("hunt:notifyKill", function(animal)
    local src = source
    print(("Player %s killed: %s"):format(src, animal))
end)
