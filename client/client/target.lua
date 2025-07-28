-- Zielmarkierung für Tiere

function highlightAnimal(animal)
    SetEntityGlow(animal, true) -- SetEntityGlow ist ein Platzhalter für natives Highlighting
end

RegisterNetEvent("hunter:highlightAnimal")
AddEventHandler("hunter:highlightAnimal", function(animalNetId)
    local entity = NetworkGetEntityFromNetworkId(animalNetId)
    if DoesEntityExist(entity) then
        highlightAnimal(entity)
    end
end)

local targets = {}

RegisterNetEvent("hunter:addTarget")
AddEventHandler("hunter:addTarget", function(entity, options)
    targets[entity] = options
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local hit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())

        if hit and targets[entity] then
            ShowHelpNotification("Drücke ~INPUT_CONTEXT~ zum Interagieren")

            if IsControlJustPressed(0, 38) then -- E-Taste
                local options = targets[entity]
                if options and options.action then
                    options.action()
                end
            end
        end
    end
end)

function ShowHelpNotification(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

client_scripts {
    'client/target.lua'
}

-- target.lua

local huntingTargets = {
    {
        name = "deer_target",
        coords = vector3(2345.76, 5823.45, 50.12),
        size = 1.5,
        action = function()
            TriggerEvent("hunting:targetHit", "deer")
        end
    },
    {
        name = "boar_target",
        coords = vector3(2350.82, 5820.01, 50.35),
        size = 1.5,
        action = function()
            TriggerEvent("hunting:targetHit", "boar")
        end
    }
}

Citizen.CreateThread(function()
    for _, target in pairs(huntingTargets) do
        exports['ox_target']:addBoxZone({
            name = target.name,
            coords = target.coords,
            size = vec3(target.size, target.size, 2.0),
            rotation = 0.0,
            debug = false,
            options = {
                {
                    name = "interact",
                    icon = "fa-solid fa-crosshairs",
                    label = "Ziel treffen",
                    onSelect = target.action
                }
            }
        })
    end
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("huntingClaimReward", vector3(-678.45, 5837.23, 17.33), 1.5, 1.5, {
        name="huntingClaimReward",
        heading=45.0,
        debugPoly=false,
        minZ=16.0,
        maxZ=18.5,
    }, {
        options = {
            {
                type = "client",
                event = "hunting:claimReward",
                icon = "fa-solid fa-sack-dollar",
                label = "Belohnung abholen",
            }
        },
        distance = 2.0
    })
end)

RegisterNetEvent("hunting:claimReward")
AddEventHandler("hunting:claimReward", function()
    local animalType = "deer" -- Beispielwert, kannst du dynamisch machen
    TriggerServerEvent("hunting:reward", animalType)
end)

local targets = {
    {
        label = "Mit Händler sprechen",
        icon = "fas fa-store",
        coords = vector3(-679.84, 5832.41, 17.33),
        event = "hunter:client:openShop"
    },
    {
        label = "Mission starten",
        icon = "fas fa-list",
        coords = vector3(-683.0, 5827.5, 17.33),
        event = "hunter:client:startMission"
    }
}

CreateThread(function()
    for _, target in pairs(targets) do
        exports['qb-target']:AddBoxZone(target.label, target.coords, 1.5, 1.5, {
            name = target.label,
            heading = 0,
            debugPoly = false,
            minZ = target.coords.z - 1.0,
            maxZ = target.coords.z + 1.0
        }, {
            options = {
                {
                    type = "client",
                    event = target.event,
                    icon = target.icon,
                    label = target.label
                }
            },
            distance = 2.0
        })
    end
end)

-- Beispiel-Target für einen NPC (z.B. Jagdanbieter)
exports.ox_target:addBoxZone({
    coords = vec3(-679.4, 5839.2, 17.3),
    size = vec3(2.0, 2.0, 2.0),
    rotation = 0.0,
    debug = false,
    options = {
        {
            name = "start_hunt",
            icon = "fas fa-dog",
            label = "Jagd starten",
            onSelect = function()
                TriggerEvent("hunter:startHunt")
            end
        },
        {
            name = "buy_ammo",
            icon = "fas fa-bolt",
            label = "Munition kaufen",
            onSelect = function()
                TriggerEvent("hunter:buyAmmo")
            end
        }
    }
})

-- client/target.lua

local targetModels = {
    "a_c_deer",
    "a_c_boar",
    "a_c_coyote",
    "a_c_rabbit_01"
}

for _, model in ipairs(targetModels) do
    exports['qtarget']:AddTargetModel(model, {
        options = {
            {
                icon = "fas fa-bullseye",
                label = "Ziel markieren",
                action = function(entity)
                    print("Ziel anvisiert: " .. tostring(entity))
                end
            }
        },
        distance = 3.0
    })
end
