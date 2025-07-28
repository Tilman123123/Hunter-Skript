MissionUtils = {}

function MissionUtils.notifyPlayer(playerId, message)
    TriggerClientEvent("chat:addMessage", playerId, {
        color = {255, 140, 0},
        multiline = true,
        args = {"[Hunter Mission]", message}
    })
end

function MissionUtils.giveReward(playerId, amount)
    -- Insert your logic here (e.g., add money)
    print(("Reward %s to player %s"):format(amount, playerId))
end
