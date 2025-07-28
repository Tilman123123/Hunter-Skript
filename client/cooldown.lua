local lastHuntTime = 0
local cooldown = 30 -- Sekunden

function CanHunt()
    return (os.time() - lastHuntTime) >= cooldown
end

function StartCooldown()
    lastHuntTime = os.time()
end
