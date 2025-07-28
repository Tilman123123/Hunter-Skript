local spawnLocations = {
    vector3(430.0, 5540.0, 800.0),
    vector3(-170.0, 6420.0, 30.0)
}

function SpawnRandomAnimal()
    local model = "a_c_deer"
    local coords = spawnLocations[math.random(#spawnLocations)]
    TriggerClientEvent("hunt:spawnAnimal", -1, model, coords)
end

RegisterNetEvent("hunt:spawnAnimal")
AddEventHandler("hunt:spawnAnimal", function(model, coords)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
    local ped = CreatePed(28, model, coords.x, coords.y, coords.z, 0.0, true, false)
end)

