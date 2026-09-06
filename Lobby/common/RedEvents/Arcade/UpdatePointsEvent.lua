local Red = require(game.ReplicatedStorage.Packages.Red)
require(game.ReplicatedStorage.Packages.Guard)
return Red.SharedSignalEvent("UpdatePointsEvent", function(p1) -- Line: 4
    return p1
end)