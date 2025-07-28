-- Haupt-Clientlogik für das Jagdsystem

local isInHuntingZone = false
local currentZone = nil
local playerXP = 0
local huntingLevel = 1

RegisterNetEvent("hunter:notify")
AddEventHandler("hunter:notify", function(msg)
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

RegisterNetEvent("hunter:updateXP")
AddEventHandler("hunter:updateXP", function(xp)
    playerXP = xp
    huntingLevel = math.floor(xp / 100) + 1
end)

RegisterNetEvent("hunting:targetHit", function(animalType)
    if animalType == "deer" then
        GrantLoot("deer")
        lib.notify({ title = "Jagd", description = "Du hast ein Reh getroffen!", type = "success" })
    elseif animalType == "boar" then
        GrantLoot("boar")
        lib.notify({ title = "Jagd", description = "Du hast ein Wildschwein getroffen!", type = "success" })
    else
        lib.notify({ title = "Fehler", description = "Unbekanntes Tier getroffen.", type = "error" })
    end
end)

function GrantLoot(animalType)
    local reward = 0
    local item = nil

    if animalType == "deer" then
        reward = 100
        item = "deer_pelt"
    elseif animalType == "boar" then
        reward = 150
        item = "boar_pelt"
    end

    if item then
        TriggerServerEvent("hunter:animalKilled", animalType, reward, item)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - vector3(-1085.3, 4947.4, 218.3))
        if dist < 2.0 then
            DrawText3D(-1085.3, 4947.4, 218.3, "[E] Tier verkaufen")
            if IsControlJustReleased(0, 38) then
                TriggerEvent("hunter:openMenu")
            end
        end
    end
end)

RegisterNetEvent("hunter:openMenu", function()
    lib.registerContext({
        id = 'hunter_sell_menu',
        title = 'Jagdverkauf',
        options = {
            {
                title = '🦌 Reh verkaufen',
                description = 'Verkaufe ein Reh',
                icon = 'paw',
                onSelect = function()
                    TriggerServerEvent('hunter:sell', 'deer')
                end
            },
            {
                title = '🐗 Wildschwein verkaufen',
                description = 'Verkaufe ein Wildschwein',
                icon = 'hippo',
                onSelect = function()
                    TriggerServerEvent('hunter:sell', 'boar')
                end
            },
            {
                title = '📦 Alles verkaufen',
                description = 'Verkaufe dein gesamtes Jagdgut',
                icon = 'box',
                onSelect = function()
                    TriggerServerEvent('hunter:sellAll')
                end
            }
        }
    })

    lib.showContext('hunter_sell_menu')
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
    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 75)
end
