local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u17 = require("../../UI/Components/Arcade/GamemodeEndScoreboard")
return {
    summary = "A wide window with a title and close button.",
    fusion = Fusion,
    controls = {Visible = true},
    story = function(p1) -- Line: 16 -- upvalues: Players (val), u17 (val)
        local u5 = p1.scope:Value("")
        task.spawn(function() -- Line: 21 -- upvalues: u5 (val), Players (upval)
            local v1 = u5
            local v2 = Players
            local HeadShot = Enum.ThumbnailType.HeadShot
            local Size100x100 = Enum.ThumbnailSize.Size100x100
            local UserThumbnailAsync = v2:GetUserThumbnailAsync(1583746009, HeadShot, Size100x100)
            v1:set(UserThumbnailAsync)
        end)
        p1.Players = {
            {Name = "thebigkannye", Score = 100, Image = u5},
            {Name = "thebigkannye2", Score = 90, Image = u5},
            {Name = "thebigkannye3", Score = 80, Image = u5},
            {Name = "thebigkannye4", Score = 50, Image = u5},
            {Name = "thebigkannye5", Score = 40, Image = u5},
            {Name = "thebigkannye5", Score = 40, Image = u5},
            {Name = "thebigkannye5", Score = 40, Image = u5},
            {Name = "thebigkannye5", Score = 40, Image = u5},
        }
        u17(p1)
    end,
}