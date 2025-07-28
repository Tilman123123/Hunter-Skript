local isTracking = false
local lastClue = nil

function StartTracking()
    if isTracking then return end
    isTracking = true
    ShowNotification("~g~Tracking gestartet. Folge den Spuren!")

    Citizen.CreateThread(function()
        while isTracking do
            Citizen.Wait(5000)
            local coords = GetEntityCoords(PlayerPedId())
            local foundClue = TryToFindClue(coords)

            if foundClue then
                lastClue = foundClue
                ShowClue(foundClue)
            end
        end
    end)
end

function StopTracking()
    isTracking = false
    ShowNotification("~r~Tracking beendet.")
end

function TryToFindClue(playerCoords)
    -- Dummy-Funktion: hier kannst du Logik hinzufügen
    local chance = math.random(1, 100)
    if chance > 70 then
        return {
            coords = vec3(playerCoords.x + math.random(-10,10), playerCoords.y + math.random(-10,10), playerCoords.z),
            type = "footprint"
        }
    end
    return nil
end

function ShowClue(clue)
    if clue.type == "footprint" then
        ShowNotification("~b~Du hast eine Fußspur entdeckt!")
        -- Optional: Hier z.B. ein Marker anzeigen
    end
end

function ShowNotification(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(false, false)
end

local trackingActive = false
local currentTrack = nil

RegisterCommand("track", function()
    trackingActive = not trackingActive
    if trackingActive then
        print("Tracking started...")
        StartTracking()
    else
        print("Tracking stopped.")
    end
end)

function StartTracking()
    -- Beispielhafte Position
    local trackPositions = {
        vector3(2547.0, 4217.2, 41.0),
        vector3(2550.2, 4214.8, 41.2),
        vector3(2553.1, 4211.5, 41.4)
    }

    for _, pos in ipairs(trackPositions) do
        if not trackingActive then break end
        DrawTrackMark(pos)
        Wait(1000)
    end
end

function DrawTrackMark(pos)
    local markerId = AddBlipForCoord(pos)
    SetBlipSprite(markerId, 442)
    SetBlipColour(markerId, 1)
    SetBlipScale(markerId, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Spur")
    EndTextCommandSetBlipName(markerId)
end
