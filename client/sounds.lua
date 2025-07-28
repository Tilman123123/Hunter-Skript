-- Einfacher Sound-Trigger (z.B. bei Abschuss oder Level-Up)

function playHuntSound(soundName)
    SendNUIMessage({
        type = "playSound",
        sound = soundName
    })
end

RegisterNetEvent("hunter:playSound")
AddEventHandler("hunter:playSound", function(sound)
    playHuntSound(sound)
end)

local function playHuntSound(soundName)
    SendNUIMessage({
        action = "playSound",
        sound = soundName
    })
end

RegisterNetEvent("hunter:playGunshot")
AddEventHandler("hunter:playGunshot", function()
    playHuntSound("gunshot")
end)

RegisterNetEvent("hunter:playHuntTheme")
AddEventHandler("hunter:playHuntTheme", function()
    playHuntSound("hunt_theme_1")
end)
