local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = require("../../UI/Components/Arcade/ArcadeSpectate")
return {
	["fusion"] = nil,
	["controls"] = nil,
	["summary"] = "A wide window with a title and close button.",
	["story"] = nil,
	["fusion"] = v2,
	["controls"] = {
		["Visible"] = true
	},
	["story"] = function(p4) -- name: story
		-- upvalues: (copy) v_u_3
		local v5 = p4.scope
		v_u_3({
			["scope"] = v5,
			["target"] = p4.target,
			["Spectating"] = v5:Value("thebigkannye"),
			["OnClickLeft"] = function() -- name: OnClickLeft
				print("Left click")
			end,
			["OnClickRight"] = function() -- name: OnClickRight
				print("Right click")
			end,
			["OnClickServerBrowser"] = function() -- name: OnClickServerBrowser
				print("Server browser clicked")
			end,
			["OnClickLobby"] = function() -- name: OnClickLobby
				print("Lobby clicked")
			end
		})
	end
}