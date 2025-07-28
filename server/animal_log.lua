local trackLog = {}

RegisterNetEvent("hunter:trackAnimal")
AddEventHandler("hunter:trackAnimal", function(animal, coords)
    table.insert(trackLog, {
        animal = animal,
        coords = coords,
        timestamp = os.time()
    })
    print("Animal tracked: " .. animal .. " at " .. json.encode(coords))
end)
