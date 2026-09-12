local Red = require(game.ReplicatedStorage.Packages.Red)
local Guard = require(game.ReplicatedStorage.Packages.Guard)
local u17 = Guard.Or(Guard.String, Guard.List(Guard.String))
return {
    CustomHit = Red.SharedEvent("CustomHit", function(p1) -- Line: 7
        return p1
    end),
    PreloadWeapon = Red.SharedEvent("PreloadWeapon", function(p1) -- Line: 11 -- upvalues: u17 (val)
        return u17(p1)
    end),
    UpdateAmmo = Red.SharedEvent("UpdateAmmo", function(p1) -- Line: 15
        return p1
    end),
    Reloading = Red.SharedEvent("Reloading", function(p1) -- Line: 19
        return p1
    end),
    CancelReload = Red.Function("CancelReload", function(p1) -- Line: 23
        return p1
    end),
    ReloadingFunction = Red.Function("ReloadingFunction", function(p1) -- Line: 27
        return p1
    end, function(p1) -- Line: 29
        return p1
    end),
    SetLoadout = Red.SharedEvent("SetLoadout", function(p1) -- Line: 33
        return p1
    end),
    RequestLoadout = Red.Function("RequestLoadout", function() end, function(p1) -- Line: 39
        return p1
    end),
    RequestPendingTeleport = Red.Function("RequestPendingTeleport", function() end, function(p1) -- Line: 45
        return p1
    end),
    RollbackHP = Red.SharedEvent("RollbackHP", function(p1) -- Line: 49
        return p1
    end),
    LookAngle = Red.SharedEvent("LookAngle", function(p1) -- Line: 53
        return p1
    end),
    Shoot = Red.SharedEvent("Shoot", function(p1) -- Line: 57
        return p1
    end),
    MeleeSwing = Red.SharedEvent("MeleeSwing", function(p1) -- Line: 61
        return p1
    end),
    MeleeReg = Red.SharedEvent("MeleeReg", function(p1) -- Line: 65
        return p1
    end),
    HitReplication = Red.SharedEvent("HitReplication", function(p1) -- Line: 69
        return p1
    end),
    Equipped = Red.SharedEvent("Equipped", function(p1) -- Line: 73 -- upvalues: Guard (val)
        return Guard.Optional(Guard.Or(Guard.String, Guard.Number))(p1)
    end),
    CharacterLoaded = Red.SharedEvent("CharacterLoaded", function() end),
    WeaponUse = Red.SharedEvent("WeaponUse", function(p1) -- Line: 81
        return p1
    end),
    OffHandUse = Red.SharedEvent("OffHandUse", function(p1) -- Line: 85
        return p1
    end),
}