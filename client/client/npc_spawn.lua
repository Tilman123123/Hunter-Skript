-- Spawnt einen Händler-NPC in der Nähe des Jagdgebiets

local npcModel = "a_m_m_farmer_01"
local npcCoords = vector3(-1085.3, 4947.4, 218.3)
local npcHeading = 90.0
local npcEntity = nil

CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(50)
    end

    npcEntity = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z - 1.0, npcHeading, false, true)
    SetEntityInvincible(npcEntity, true)
    SetBlockingOfNonTemporaryEvents(npcEntity, true)
    FreezeEntityPosition(npcEntity, true)
    TaskStartScenarioInPlace(npcEntity, "WORLD_HUMAN_CLIPBOARD", 0, true)

    exports['ox_target']:addBoxZone({
        coords = npcCoords,
        size = vec3(1.5, 1.5, 2.0),
        rotation = npcHeading,
        debug = false,
        options = {
            {
                label = "Jagdmenü öffnen",
                icon = "fa-solid fa-paw",
                onSelect = function()
                    TriggerEvent("hunter:openMenu")
                end
            }
        }
    })
end)

TriggerEvent("hunter:addTarget", spawnedPed, {
    action = function()
        print("Interagiert mit: " .. tostring(spawnedPed))
    end
})

local npcModel = `cs_hunter`
local npcCoords = vector4(-678.45, 5837.23, 17.33, 45.0) -- Position anpassen!

CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(100)
    end

    local npc = CreatePed(4, npcModel, npcCoords.x, npcCoords.y, npcCoords.z - 1, npcCoords.w, false, true)
    SetEntityAsMissionEntity(npc, true, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

local npcModel = "cs_old_man2"  -- Du kannst hier jeden passenden Ped-Namen nehmen
local spawnCoords = vector4(-679.84, 5832.41, 17.33, 90.0) -- Position und Heading

CreateThread(function()
    RequestModel(npcModel)
    while not HasModelLoaded(npcModel) do
        Wait(100)
    end

    local npc = CreatePed(4, npcModel, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.w, false, true)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

exports['target']:AddTargetEntity(npcEntity, {
    options = {
        {
            label = "Jagdbelohnung verkaufen",
            icon = "fas fa-dollar-sign",
            action = function()
                TriggerEvent("hunter:sellMenu")
            end
        }
    },
    distance = 2.0
})

-- client/npc_spawn.lua

local hunterNpcs = {
    {
        model = "cs_hunter", 
        coords = vector3(-814.91, 5400.34, 34.1), 
        heading = 90.0, 
        scenario = "WORLD_HUMAN_STAND_IMPATIENT"
    }
}

CreateThread(function()
    for _, npc in pairs(hunterNpcs) do
        RequestModel(npc.model)
        while not HasModelLoaded(npc.model) do
            Wait(50)
        end

        local ped = CreatePed(4, npc.model, npc.coords.x, npc.coords.y, npc.coords.z - 1.0, npc.heading, false, true)
        SetEntityAsMissionEntity(ped, true, true)
        TaskStartScenarioInPlace(ped, npc.scenario, 0, true)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
    end
end)

-- client/npc_spawn.lua

local sellPed = nil

Citizen.CreateThread(function()
    local model = `cs_old_man2`  -- NPC-Modell
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(100)
    end

    local pedCoords = vector3(-556.3, 5328.7, 73.6) -- Verkaufsstelle (anpassbar)
    sellPed = CreatePed(4, model, pedCoords.x, pedCoords.y, pedCoords.z - 1.0, 65.0, false, true)

    FreezeEntityPosition(sellPed, true)
    SetEntityInvincible(sellPed, true)
    SetBlockingOfNonTemporaryEvents(sellPed, true)

    exports['qtarget']:AddTargetEntity(sellPed, {
        options = {
            {
                event = "hunter:sellItems",
                icon = "fas fa-dollar-sign",
                label = "Beute verkaufen"
            }
        },
        distance = 2.0
    })
end)
