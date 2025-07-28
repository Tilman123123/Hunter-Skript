Config = {}

-- Jagdgebiete / Zonen
Config.HuntingZones = {
    {
        name = "Mount Chiliad",
        coords = vector3(1500.0, 4400.0, 44.0),
        radius = 250.0,
        animalTypes = { "deer", "boar", "bear" }
    },
    {
        name = "Paleto Forest",
        coords = vector3(-200.0, 6200.0, 31.0),
        radius = 300.0,
        animalTypes = { "deer", "boar" }
    }
}

-- Tiere & Verkaufspreise
Config.Rewards = {
    deer =     { price = 300, item = "deer_pelt" },
    boar =     { price = 250, item = "boar_meat" },
    bear =     { price = 600, item = "bear_claw" },
    rabbit =   { price = 120, item = "rabbit_foot" },
    fox =      { price = 280, item = "fox_fur" },
    coyote =   { price = 220, item = "coyote_tail" },
    hen =      { price = 90,  item = "hen_feather" },
    cow =      { price = 350, item = "cow_hide" },
    goat =     { price = 240, item = "goat_horn" }
}

-- Missionen (für mission.lua)
Config.Missions = {
    {
        name = "Rehjagd",
        animal = "deer",
        required = 2,
        rewardMin = 5000,
        rewardMax = 8000
    },
    {
        name = "Wildschweinaktion",
        animal = "boar",
        required = 3,
        rewardMin = 6000,
        rewardMax = 8500
    },
    {
        name = "Bärenjagd",
        animal = "bear",
        required = 1,
        rewardMin = 9000,
        rewardMax = 12500
    }
}

-- Waffen erlaubt für die Jagd
Config.AllowedWeapons = {
    [`weapon_musket`] = true,
    [`weapon_sniperrifle`] = true
}

-- XP / Level-System
Config.XPPerKill = 10
Config.Levels = {
    [1] = { xp = 0,    bonus = 0 },
    [2] = { xp = 100,  bonus = 5 },
    [3] = { xp = 250,  bonus = 10 },
    [4] = { xp = 500,  bonus = 15 },
    [5] = { xp = 1000, bonus = 25 }
}

-- Verkaufspunkt (NPC, Marker, etc.)
Config.SellLocation = vector3(-1085.3, 4947.4, 218.3)

-- Modellnamen für NPC-Spawn
Config.Animals = {
    "a_c_deer",
    "a_c_boar",
    "a_c_mtlion",
    "a_c_rabbit_01",
    "a_c_coyote",
    "a_c_fox",
    "a_c_chickenhawk",
    "a_c_hen",
    "a_c_cow",
    "a_c_goat"
}
