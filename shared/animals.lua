-- shared/animals.lua

Animals = {
    deer = {
        label = "Hirsch",
        model = "a_c_deer",
        reward = 50,
        drop = "venison"
    },
    boar = {
        label = "Wildschwein",
        model = "a_c_boar",
        reward = 40,
        drop = "boarmeat"
    },
    rabbit = {
        label = "Kaninchen",
        model = "a_c_rabbit_01",
        reward = 20,
        drop = "rabbitmeat"
    },
    coyote = {
        label = "Kojote",
        model = "a_c_coyote",
        reward = 30,
        drop = "coyotefur"
    },
    mountain_lion = {
        label = "Berglöwe",
        model = "a_c_mtlion",
        reward = 100,
        drop = "lionfur"
    }
}

-- shared/animals.lua

return {
    {
        name = "deer",
        label = "Hirsch",
        model = "a_c_deer",
        reward = 100
    },
    {
        name = "boar",
        label = "Wildschwein",
        model = "a_c_boar",
        reward = 120
    },
    {
        name = "bear",
        label = "Bär",
        model = "a_c_bear",
        reward = 300
    }
}

-- shared/animals.lua

AnimalsList = {
    {
        model = "a_c_deer",
        reward = 50,
        meat = 2,
        pelt = 1
    },
    {
        model = "a_c_boar",
        reward = 35,
        meat = 3,
        pelt = 0
    },
    {
        model = "a_c_cow",
        reward = 40,
        meat = 4,
        pelt = 0
    }
}
