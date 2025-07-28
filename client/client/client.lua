-- client/client.lua
-- Jagdsystem: alle Tiere, XP, Verkauf, Loot

local isInHuntingZone = false
local currentZone = nil
local playerXP = 0
local huntingLevel = 1

local animalData = {
    deer =   { label = "Reh",         reward = 300, item = "deer_pelt",     xp = 40 },
    boar =   { label = "Wildschwein", reward = 250, item = "boar_meat",     xp = 35 },
    bear =   { label = "Bär",         reward = 600, item = "bear_claw",     xp = 80 },
    rabbit = { label = "Hase",        reward = 120, item = "rabbit_foot",   xp = 20 },
    fox =    { label = "Fuchs",       reward = 280, item = "fox_fur",       xp = 30 },
    coyote = { label = "Kojote",      reward = 220, item = "coyote_tail",   xp = 28 },
    hen =    { label = "Huhn",        reward = 90,  item = "hen_feather",   xp = 15 },
    cow =    { label = "Kuh",         reward = 350, item = "cow_hide",      xp = 45 },
    goat =   { label = "Ziege",       reward = 240, item = "goat_horn",     xp = 32 }
}

RegisterNetEvent("hunter:notify", function(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, true)
end)

AddEventHandler("hunter:enteredZone", function(zoneName)
    isInHuntingZone = true
    currentZone = zoneName
    TriggerEvent("hunter:notify", "Du hast das Jagdgebiet " .. zoneName .. " betreten.")
end)

AddEventHandler("hunter:leftZone", function()
    isInHuntingZone = false
    currentZone = nil
    TriggerEvent("hunter:notify", "Du hast das Jagdgebiet verlassen.")
end)

RegisterCommand("sammeln", function()
    if isInHuntingZone then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local animal = GetClosestPed(coords.x, coords.y, coords.z, 5.0, true, false, false, false, true)
        if animal ~= 0 then
            ClearPedTasksImmediately(ped)
            TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
            Wait(5000)
            ClearPedTasksImmediately(ped)
            TriggerServerEvent("hunter:collectAnimal", currentZone)
        else
            TriggerEvent("hunter:notify", "Kein Tier in der Nähe zum Sammeln.")
        end
    else
        TriggerEvent("hunter:notify", "Du bist in keinem Jagdgebiet.")
    end
end)

RegisterNetEvent("hunter:updateXP", function(xp)
    playerXP = xp
    huntingLevel = math.floor(xp / 100) + 1
end)

RegisterNetEvent("hunting:targetHit", function(animalType)
    local data = animalData[animalType]
    if data then
        GrantLoot(animalType)
        lib.notify({
            title = "Jagd",
            description = "Du hast ein " .. data.label .. " getroffen!",
            type = "success"
        })
    else
        lib.notify({
            title = "Fehler",
            description = "Unbekanntes Tier getroffen.",
            type = "error"
        })
    end
end)

function GrantLoot(animalType)
    local data = animalData[animalType]
    if data then
        TriggerServerEvent("hunter:animalKilled", animalType, data.reward, data.item)
        TriggerServerEvent("hunter:addXP", data.xp)
    end
end

-- Verkaufsmenü
RegisterNetEvent("hunter:openMenu", function()
    local options = {}

    for animal, data in pairs(animalData) do
        table.insert(options, {
            title = data.label .. " verkaufen",
            description = "Verkaufe dein " .. data.label,
            icon = 'paw',
            onSelect = function()
                TriggerServerEvent('hunter:sell', animal)
            end
        })
    end

    table.insert(options, {
        title = '📦 Alles verkaufen',
        description = 'Verkaufe dein gesamtes Jagdgut',
        icon = 'box',
        onSelect = function()
            TriggerServerEvent('hunter:sellAll')
        end
    })

    lib.registerContext({
        id = 'hunter_sell_menu',
        title = 'Jagdverkauf',
        options = options
    })

    lib.showContext('hunter_sell_menu')
end)

-- Verkaufszone & Blip
Citizen.CreateThread(function()
    local pos = vector3(-1085.3, 4947.4, 218.3)

    -- Verkaufsmenü (wenn kein ox_target)
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - pos)
        if dist < 2.0 then
            DrawText3D(pos.x, pos.y, pos.z, "[E] Tier verkaufen")
            if IsControlJustReleased(0, 38) then
                TriggerEvent("hunter:openMenu")
            end
        end
    end
end)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-1085.3, 4947.4, 218.3)
    SetBlipSprite(blip, 141)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.9)
    SetBlipColour(blip, 5)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Jagdgebiet")
    EndTextCommandSetBlipName(blip)
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = string.len(text) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 75)
end
