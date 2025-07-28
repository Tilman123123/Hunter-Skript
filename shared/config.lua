Config = {}

-- Jagd-Settings
Config.HuntingZones = {
    {
        name = "Mount Chiliad",
        coords = vector3(1500.0, 4400.0, 44.0),
        radius = 250.0,
        animalTypes = { "deer", "boar", "mountainlion" },
    },
    {
        name = "Paleto Forest",
        coords = vector3(-200.0, 6200.0, 31.0),
        radius = 300.0,
        animalTypes = { "deer", "boar" },
    }
}

-- Verkaufspreise
Config.AnimalPrices = {
    deer = 150,
    boar = 100,
    mountainlion = 250
}

-- Waffen für Jagd erlaubt
Config.AllowedWeapons = {
    [`weapon_musket`] = true,
    [`weapon_sniperrifle`] = true
}

-- XP / Level System
Config.XPPerKill = 10
Config.Levels = {
    [1] = { xp = 0, bonus = 0 },
    [2] = { xp = 100, bonus = 5 },
    [3] = { xp = 250, bonus = 10 },
    [4] = { xp = 500, bonus = 15 },
    [5] = { xp = 1000, bonus = 25 }
}

-- Verkaufspunkt
Config.SellLocation = vector3(-569.34, 292.44, 79.18)

-- Tiere für NPC-Spawn
Config.Animals = {
    "a_c_deer",
    "a_c_boar",
    "a_c_mtlion"
}

-- Belohnungen
Config.Rewards = {
    deer = "meat_deer",
    boar = "meat_boar",
    mountainlion = "meat_mlion"
}

Config.XP = {
    maxLevel = 10,
    xpPerLevel = 100
}

Config.AnimalRewards = {
    ["deer"] = 250,
    ["boar"] = 180,
    ["rabbit"] = 50,
    ["coyote"] = 200,
    ["mountainlion"] = 300
}
