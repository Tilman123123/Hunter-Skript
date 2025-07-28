-- server/database_handler.lua

RegisterNetEvent('hunter:server:saveStats', function(stats)
    local src = source
    -- Replace with your database logic
    print(("Saving stats for player %s: %s kills, $%s earned"):format(src, stats.kills, stats.money))
end)

RegisterNetEvent('hunter:server:loadStats', function()
    local src = source
    -- Replace with your DB logic (e.g., MySQL query)
    local exampleStats = {
        kills = 5,
        money = 600
    }
    TriggerClientEvent('hunter:client:setStats', src, exampleStats)
end)

-- XP speichern
function DatabaseHandler.setXP(playerId, xp)
    local identifier = getIdentifier(playerId)
    if not identifier then return end

    MySQL.Async.execute('UPDATE hunter_players SET xp = @xp WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['@xp'] = xp
    })
end

-- XP abrufen
function DatabaseHandler.getXP(playerId, cb)
    local identifier = getIdentifier(playerId)
    if not identifier then cb(0) return end

    MySQL.Async.fetchScalar('SELECT xp FROM hunter_players WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        cb(result or 0)
    end)
end

-- server/database_handler.lua

local db = {}

-- Funktion zum Einfügen eines erlegten Tieres
function db.insertHuntedAnimal(identifier, animalType, reward, dropItem)
    local sql = [[
        INSERT INTO hunted_animals (identifier, animal_type, reward, drop_item)
        VALUES (?, ?, ?, ?)
    ]]
    MySQL.Async.execute(sql, {identifier, animalType, reward, dropItem})
end

-- Funktion zum Abrufen der letzten erlegten Tiere eines Spielers
function db.getRecentHunts(identifier, cb)
    local sql = [[
        SELECT * FROM hunted_animals WHERE identifier = ? ORDER BY timestamp DESC LIMIT 10
    ]]
    MySQL.Async.fetchAll(sql, {identifier}, function(result)
        cb(result)
    end)
end

return db

local db = {}

-- Verbindung zur DB herstellen (Beispiel mit oxmysql)
function db.saveKill(playerId, animalType, reward, dropItem)
    local query = [[
        INSERT INTO hunter_kills (player_id, animal_type, reward_amount, drop_item)
        VALUES (?, ?, ?, ?)
    ]]
    
    exports.oxmysql:insert(query, {
        playerId,
        animalType,
        reward,
        dropItem or nil
    }, function(id)
        print("📦 Kill gespeichert mit ID:", id)
    end)
end

return db
