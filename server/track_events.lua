RegisterNetEvent("hunter:logTrack")
AddEventHandler("hunter:logTrack", function(animal, coords)
    print(("[TrackLog] %s spotted at %s"):format(animal, json.encode(coords)))
end)
