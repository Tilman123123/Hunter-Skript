-- Blips für Jagdzonen auf der Karte
local huntingZones = {
    { name = "Jagdgebiet Nord", x = 2345.2, y = 5678.3, z = 45.2 },
    { name = "Jagdgebiet Süd", x = -123.4, y = 983.2, z = 32.4 }
}

CreateThread(function()
    for _, zone in ipairs(huntingZones) do
        local blip = AddBlipForCoord(zone.x, zone.y, zone.z)
        SetBlipSprite(blip, 442) -- Jagd-Symbol
        SetBlipColour(blip, 2)
        SetBlipScale(blip, 0.9)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(zone.name)
        EndTextCommandSetBlipName(blip)
    end
end)

local blips = {
    {
        title = "Jagdgebiet",
        colour = 25,
        id = 141,
        coords = vector3(-679.15, 5837.31, 17.33)
    },
    {
        title = "Jagdhändler",
        colour = 5,
        id = 431,
        coords = vector3(-679.84, 5832.41, 17.33)
    },
    {
        title = "Missionstafel",
        colour = 3,
        id = 613,
        coords = vector3(-683.0, 5827.5, 17.33)
    }
}

CreateThread(function()
    for _, info in pairs(blips) do
        local blip = AddBlipForCoord(info.coords)
        SetBlipSprite(blip, info.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, info.colour)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(blip)
    end
end)

-- client/blips.lua

CreateThread(function()
    local huntingZones = {
        { x = -815.95, y = 5404.24, z = 34.1, label = "Jagdgebiet: Paleto" },
        { x = 1642.73, y = 3846.29, z = 34.9, label = "Jagdgebiet: Sandy Shores" },
        { x = -1804.21, y = 4566.12, z = 3.1, label = "Jagdgebiet: Küste" }
    }

    for _, zone in pairs(huntingZones) do
        local blip = AddBlipForCoord(zone.x, zone.y, zone.z)
        SetBlipSprite(blip, 141) -- Jagd-Icon
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 31)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(zone.label)
        EndTextCommandSetBlipName(blip)
    end
end)

-- client/blips.lua

CreateThread(function()
    local blip = AddBlipForCoord(-814.91, 5400.34, 34.1)
    SetBlipSprite(blip, 442) -- Symbol für Jagdgebiet
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Jagdgebiet")
    EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(2000.0, 3000.0, 50.0)
    SetBlipSprite(blip, 141)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Jagdgebiet")
    EndTextCommandSetBlipName(blip)
end)
