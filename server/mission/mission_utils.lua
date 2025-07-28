MissionUtils = {}

function MissionUtils.notifyPlayer(playerId, message, type)
    if GetResourceState("ox_lib") == "started" then
        TriggerClientEvent("ox_lib:notify", playerId, {
            title = "Jagdmission",
            description = message,
            type = type or "info"
        })
    else
        TriggerClientEvent("chat:addMessage", playerId, {
            color = {255, 140, 0},
            multiline = true,
            args = {"[Hunter Mission]", message}
        })
    end
end

function MissionUtils.giveReward(playerId, amount)
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            xPlayer.addMoney(amount)
            print(("[Jagd] Spieler %s erhielt $%s Belohnung."):format(playerId, amount))
        end
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player then
            Player.Functions.AddMoney("cash", amount)
            print(("[Jagd] Spieler %s erhielt $%s Belohnung."):format(playerId, amount))
        end
    else
        print("[WARNUNG] Kein Framework erkannt – Geld wurde nicht ausgezahlt.")
    end
end

return MissionUtils
