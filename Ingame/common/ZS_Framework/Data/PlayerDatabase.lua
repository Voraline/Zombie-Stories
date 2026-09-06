local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local v1 = Fusion.scoped(Fusion)
local v2 = require("@game/ReplicatedStorage/common/Signal")
local v3 = {
    PlayerGui = v1:Value(nil),
    Loaded = v1:Value(false),
    EnableCursor = v1:Value(0),
    State = {},
    Data = {},
    Game = {},
}
v3.LocalState = {PlayerGui = v3.PlayerGui}
v3.QuitSignal = v2.new()
v3.UIOpenSignal = v2.new()
v3.Signals = {
    Quit = v3.QuitSignal,
    UIOpen = v3.UIOpenSignal,
    StatusMessage = v2.new(),
    BannerMessage = v2.new(),
    CloseSummary = v2.new(),
}
v3.QuestList = {}
v3.Scope = v1
return v3