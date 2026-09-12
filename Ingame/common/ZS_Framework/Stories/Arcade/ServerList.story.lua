local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u12 = require("../../UI/Controllers/ServerListController")
return {
    summary = "A wide window with a title and close button.",
    fusion = Fusion,
    controls = {Visible = true},
    story = function(p1) -- Line: 14 -- upvalues: u12 (val)
        local scope = p1.scope
        local v1 = u12
        v1.new({target = p1.target, scope = scope})
    end,
}