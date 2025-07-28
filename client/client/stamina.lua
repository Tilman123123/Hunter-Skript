local stamina = 100

function ReduceStamina(amount)
    stamina = math.max(0, stamina - amount)
    print("Aktuelle Ausdauer:", stamina)
end
