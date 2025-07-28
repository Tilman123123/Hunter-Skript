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

local display = false

RegisterCommand("togglehuntui", function()
    display = not display
    SetNuiFocus(display, display)
    SendNUIMessage({
        type = "ui",
        display = display
    })
end)

RegisterNUICallback("exit", function()
    display = false
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "ui", display = false })
end)

-- Beispiel: Update Punkte im UI
RegisterNetEvent("hunt:updatePoints", function(points)
    SendNUIMessage({
        type = "updatePoints",
        points = points
    })
end)

-- Einfache Hilfe-Benachrichtigung anzeigen
function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

-- Beispiel: Benachrichtigung beim Beginn der Jagd
function NotifyHuntStarted()
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("Die Jagd hat begonnen! Viel Glück.")
    EndTextCommandThefeedPostTicker(false, false)
end

-- Beispiel: Benachrichtigung bei Beute
function NotifyAnimalTagged(animalType)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName("Du hast ein " .. animalType .. " erlegt!")
    EndTextCommandThefeedPostTicker(false, false)
end

-- client/ui.lua

local function showNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, true)
end

RegisterNetEvent("hunter:showNotification")
AddEventHandler("hunter:showNotification", function(msg)
    showNotification(msg)
end)

-- Beispiel-Aufruf (Testzweck)
-- showNotification("Willkommen im Jagdgebiet!")

RegisterNetEvent("hunter:sellMenu", function()
    local items = {
        {label = "Hirschfell", item = "deer_pelt"},
        {label = "Wildschweinfleisch", item = "boar_meat"},
        {label = "Bärenklaue", item = "bear_claw"},
        {label = "Kaninchenpfote", item = "rabbit_foot"},
        {label = "Fuchsfell", item = "fox_fur"},
        {label = "Kojotenschwanz", item = "coyote_tail"}
    }

    local elements = {}
    for _, i in pairs(items) do
        table.insert(elements, {
            title = i.label,
            description = "Verkaufen",
            onSelect = function()
                TriggerServerEvent("hunter:sellItem", i.item)
            end
        })
    end

    lib.registerContext({
        id = 'sell_menu',
        title = 'Verkaufe Jagdbeute',
        options = elements
    })

    lib.showContext('sell_menu')
end)
