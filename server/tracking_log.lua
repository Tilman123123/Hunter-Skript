local trackingLogs = {}

RegisterNetEvent("hunter:logTrack")
AddEventHandler("hunter:logTrack", function(position)
    table.insert(trackingLogs, {
        source = source,
        pos = position,
        time = os.time()
    })
    print(("Player %d tracked at %s"):format(source, json.encode(position)))
end)
