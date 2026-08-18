local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v3 = v2.scoped(v2)
local v4 = require("@game/ReplicatedStorage/common/Signal")
local v5 = {
	["PlayerGui"] = v3:Value(nil),
	["Loaded"] = v3:Value(false),
	["EnableCursor"] = v3:Value(0),
	["State"] = {},
	["Data"] = {},
	["Game"] = {}
}
v5.LocalState = {
	["PlayerGui"] = v5.PlayerGui
}
v5.QuitSignal = v4.new()
v5.UIOpenSignal = v4.new()
v5.Signals = {
	["Quit"] = v5.QuitSignal,
	["UIOpen"] = v5.UIOpenSignal,
	["StatusMessage"] = v4.new(),
	["BannerMessage"] = v4.new(),
	["CloseSummary"] = v4.new()
}
v5.QuestList = {}
v5.Scope = v3
return v5