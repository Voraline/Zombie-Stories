local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u12 = require("../../UI/Components/Arcade/ArcadeSpectate")
return {
    summary = "A wide window with a title and close button.",
    fusion = Fusion,
    controls = {Visible = true},
    story = function(p1) -- Line: 14 -- upvalues: u12 (val)
        local scope = p1.scope
        u12({
            scope = scope,
            target = p1.target,
            Spectating = scope:Value("thebigkannye"),
            OnClickLeft = function() -- Line: 21
                print("Left click")
            end,
            OnClickRight = function() -- Line: 24
                print("Right click")
            end,
            OnClickServerBrowser = function() -- Line: 27
                print("Server browser clicked")
            end,
            OnClickLobby = function() -- Line: 30
                print("Lobby clicked")
            end,
        })
    end,
}