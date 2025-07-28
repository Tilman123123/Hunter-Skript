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

-- Wenn Spieler eine Jagdzone betritt
AddEventHandler("hunter:enteredZone", function(zoneName)
    isInHuntingZone = true
    currentZone = zoneName
    TriggerEvent("hunter:notify", "Du hast das Jagdgebiet " .. zoneName .. " betreten.")
end)

-- Wenn Spieler die Zone verlässt
AddEventHandler("hunter:leftZone", function()
    isInHuntingZone = false
    currentZone = nil
    TriggerEvent("hunter:notify", "Du hast das Jagdgebiet verlassen.")
end)

-- Interaktion mit erlegten Tieren
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

-- XP-System (vereinfachtes Beispiel)
RegisterNetEvent("hunter:updateXP")
AddEventHandler("hunter:updateXP", function(xp)
    playerXP = xp
    huntingLevel = math.floor(xp / 100) + 1
end)

TriggerServerEvent("hunter:giveReward", "deer")

-- Event bei Treffer eines Tiers (von target.lua ausgelöst)
RegisterNetEvent("hunting:targetHit", function(animalType)
    if animalType == "deer" then
        TriggerServerEvent("hunting:reward", "deer")
        lib.notify({ title = "Jagd", description = "Du hast ein Reh getroffen!", type = "success" })
    elseif animalType == "boar" then
        TriggerServerEvent("hunting:reward", "boar")
        lib.notify({ title = "Jagd", description = "Du hast ein Wildschwein getroffen!", type = "success" })
    else
        lib.notify({ title = "Fehler", description = "Unbekanntes Tier getroffen.", type = "error" })
    end
end)

function NotifyServerOfKill(animalType, reward, dropItem)
    TriggerServerEvent("hunter:animalKilled", animalType, reward, dropItem)
end

-- Beispiel: Nach einem Abschuss
TriggerServerEvent("hunter:animalKilled", "deer", 150, "deer_pelt")

-- Nach Erfolg (z. B. beim Missionsende oder Tierabschuss)
TriggerServerEvent("hunter:giveReward", "deer")

function NotifyTrackFound(animal)
    TriggerEvent("hunter:showTrackNotification", animal)
    SendNUIMessage({ type = "showAnimalUI", animal = animal })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPlayerNearAnimal() then
            local animalCoords = GetTrackedAnimalCoords()
            DrawAnimalMarker(animalCoords)
        end
    end
end)

RegisterCommand("sell", function()
    -- Beispielverkauf (später über Target etc. automatisieren)
    SellAnimal("a_c_deer")
end, false)

print("Name: " .. FormatAnimalName("a_c_deer"))

function NotifyKill(animal)
    TriggerServerEvent("hunt:notifyKill", animal)
end

if CanHunt() then
    -- Hunt starten
    StartCooldown()
else
    print("Warte, bevor du erneut jagen kannst.")
end

print("Cooldown ist gesetzt auf: " .. HUNT_COOLDOWN .. " Sekunden")

ShowProgress("Tier wird verarbeitet...", 5)

GrantLoot("deer") -- Beispiel
