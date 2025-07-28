function FormatAnimalName(model)
    local map = {
        a_c_deer = "Hirsch",
        a_c_boar = "Wildschwein"
    }
    return map[model] or model
end
