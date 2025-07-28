function DrawAnimalMarker(coords)
    DrawMarker(1, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.0, 0, 255, 0, 100, false, true, 2, false, nil, nil, false)
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        DrawMarker(1, 450.0, 5560.0, 800.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 100, false, true, 2, false, nil, nil, false)
    end
end)

local huntMarker = vector3(2000.0, 3000.0, 50.0)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        DrawMarker(1, huntMarker.x, huntMarker.y, huntMarker.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 0, 100, false, true, 2, nil, nil, false)
    end
end)
