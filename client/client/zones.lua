-- Öffnet und steuert das NUI-Menü für das Jagdinterface

RegisterNetEvent("hunter:openMenu")
AddEventHandler("hunter:openMenu", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openMenu",
        level = 0,
        stats = {}, -- optional dynamisch
        xp = 0
    })
end)

RegisterNUICallback("closeMenu", function(_, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

-- client/zones.lua

local huntingZones = {
    {
        name = "Mount Chiliad",
        center = vector3(1500.0, 4500.0, 50.0),
        radius = 500.0,
        animals = { "deer", "boar", "rabbit" }
    },
    {
        name = "Great Chaparral",
        center = vector3(-100.0, 3000.0, 40.0),
        radius = 400.0,
        animals = { "coyote", "mountain_lion" }
    }
}

function isPlayerInZone(zone)
    local playerCoords = GetEntityCoords(PlayerPedId())
    return #(playerCoords - zone.center) <= zone.radius
end

function getNearestZone()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for _, zone in pairs(huntingZones) do
        if #(playerCoords - zone.center) <= zone.radius then
            return zone
        end
    end
    return nil
end

-- Beispiel-Trigger:
-- Citizen.CreateThread(function()
--     while true do
--         Wait(5000)
--         local zone = getNearestZone()
--         if zone then
--             print("Du bist in der Zone:", zone.name)
--         end
--     end
-- end)

-- client/zones.lua

local huntingZones = {
    {
        name = "Waldgebiet Nord",
        coords = vector3(-500.0, 2000.0, 200.0),
        radius = 150.0
    },
    {
        name = "Hügelgebiet Süd",
        coords = vector3(300.0, 1200.0, 150.0),
        radius = 100.0
    }
}

for _, zone in ipairs(huntingZones) do
    TriggerEvent("bt-target:addZone", {
        name = zone.name,
        coords = zone.coords,
        radius = zone.radius,
        debugPoly = false,
        options = {
            {
                event = "hunter:startHunt",
                icon = "fas fa-binoculars",
                label = "Jagd starten"
            }
        },
        job = {"all"},
        distance = 3.0
    })
end

-- client/zones.lua

local huntingZones = {
    {
        name = "Mount Chiliad",
        center = vector3(1400.0, 4000.0, 60.0),
        radius = 300.0
    },
    {
        name = "Paleto Forest",
        center = vector3(-130.0, 4400.0, 60.0),
        radius = 250.0
    }
}

function IsPlayerInHuntingZone()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _, zone in pairs(huntingZones) do
        if #(playerCoords - zone.center) < zone.radius then
            return true
        end
    end

    return false
end

-- Beispiel: Nutze die Funktion zur Einschränkung
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if not IsPlayerInHuntingZone() then
            -- TriggerClientEvent oder Hinweis einfügen
            print("Nicht in einer Jagdzone.")
        end
    end
end)

Citizen.CreateThread(function()
    for _, zone in pairs(HuntingZones) do
        local blip = AddBlipForRadius(zone.coords, zone.radius)
        SetBlipColour(blip, 5)
        SetBlipAlpha(blip, 128)
    end
end)
