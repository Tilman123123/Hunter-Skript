-- client/hunting_logic.lua

-- Diese Datei erkennt getötete Tiere und löst Events aus

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local peds = GetGamePool('CPed')

        for _, ped in pairs(peds) do
            if DoesEntityExist(ped) and IsEntityDead(ped) and not IsPedAPlayer(ped) then
                local model = GetEntityModel(ped)
                local dist = #(GetEntityCoords(ped) - coords)

                if dist < 25.0 then
                    if model == GetHashKey("a_c_deer") then
                        TriggerEvent("hunting:targetHit", "deer")
                    elseif model == GetHashKey("a_c_boar") then
                        TriggerEvent("hunting:targetHit", "boar")
                    elseif model == GetHashKey("a_c_rabbit_01") then
                        TriggerEvent("hunting:targetHit", "rabbit")
                    elseif model == GetHashKey("a_c_coyote") then
                        TriggerEvent("hunting:targetHit", "coyote")
                    elseif model == GetHashKey("a_c_mtlion") then
                        TriggerEvent("hunting:targetHit", "bear")
                    elseif model == GetHashKey("a_c_fox") then
                        TriggerEvent("hunting:targetHit", "fox")
                    elseif model == GetHashKey("a_c_chickenhawk") or model == GetHashKey("a_c_hen") then
                        TriggerEvent("hunting:targetHit", "hen")
                    elseif model == GetHashKey("a_c_cow") then
                        TriggerEvent("hunting:targetHit", "cow")
                    elseif model == GetHashKey("a_c_goat") then
                        TriggerEvent("hunting:targetHit", "goat")
                    end

                    SetEntityAsNoLongerNeeded(ped)
                end
            end
        end
    end
end)
