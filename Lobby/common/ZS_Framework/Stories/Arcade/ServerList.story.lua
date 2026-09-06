local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u12 = require("../../UI/Controllers/ServerListController")
return {
    summary = "A wide window with a title and close button.",
    fusion = Fusion,
    controls = {Visible = true},
    story = function(p1) -- Line: 14 -- upvalues: u12 (val)
        u12.new({target = p1.target, scope = p1.scope})
    end,
}