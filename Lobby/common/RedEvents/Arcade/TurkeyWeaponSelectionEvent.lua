return require(game.ReplicatedStorage.Packages.Red).SharedEvent("TurkeyWeaponSelection", function(p1) -- Line: 3
    if typeof(p1) ~= "table" then
        return nil
    end
    return p1
end)