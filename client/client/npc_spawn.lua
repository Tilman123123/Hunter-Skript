-- client/npc_spawn.lua
-- Vollständiger NPC-Script für das Jagdsystem (mit ox_target)

local npcs = {
    {
        model = "a_m_m_farmer_01",
        coords = vector3(-1085.3, 4947.4, 218.3),
        heading = 90.0,
        scenario = "WORLD_HUMAN_CLIPBOARD",
        label = "Jagdmenü öffnen",
        icon = "fa-solid fa-paw",
        event = "hunter:openMenu",
        server = false
    },
    {
        model = "cs_hunter",
        coords = vector3(-678.45, 5837.23, 17.33),
        heading = 45.0,
        scenario = nil,
        label = "Missionen ansehen",
        icon = "fa-solid fa-binoculars",
        event = "hunter:openMissions",
        server = false
    },
    {
        model = "cs_old_man2",
        coords = vector3(-556.3, 5328.7, 73.6),
        heading = 65.0,
        scenario = nil,
        label = "Beute verkaufen",
        icon = "fas fa-dollar-sign",
        event = "hunter:sellItems",
        server = true
    }
}

CreateThread(function()
    for _, npc in pairs(npcs) do
        RequestModel(npc.model)
        while not HasModelLoaded(npc.model) do
            Wait(50)
        end

        local ped = CreatePed(4, npc.model, npc.coords.x, npc.coords.y, npc.coords.z - 1.0, npc.heading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        if npc.scenario then
            TaskStartScenarioInPlace(ped, npc.scenario, 0, true)
        end

        exports.ox_target:addLocalEntity(ped, {
            {
                label = npc.label,
                icon = npc.icon,
                onSelect = function()
                    if npc.server then
                        TriggerServerEvent(npc.event)
                    else
                        TriggerEvent(npc.event)
                    end
                end
            }
        })
    end
end)
