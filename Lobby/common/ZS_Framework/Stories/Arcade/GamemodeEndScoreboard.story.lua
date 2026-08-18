local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2.Packages.Fusion)
local v_u_4 = require("../../UI/Components/Arcade/GamemodeEndScoreboard")
return {
	["fusion"] = nil,
	["controls"] = nil,
	["summary"] = "A wide window with a title and close button.",
	["story"] = nil,
	["fusion"] = v3,
	["controls"] = {
		["Visible"] = true
	},
	["story"] = function(p5) -- name: story
		-- upvalues: (copy) v_u_1, (copy) v_u_4
		local v_u_6 = p5.scope:Value("")
		task.spawn(function()
			-- upvalues: (copy) v_u_6, (ref) v_u_1
			v_u_6:set(v_u_1:GetUserThumbnailAsync(1583746009, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100))
		end)
		local v7 = {
			{
				["Name"] = "thebigkannye",
				["Score"] = 100,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye2",
				["Score"] = 90,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye3",
				["Score"] = 80,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye4",
				["Score"] = 50,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye5",
				["Score"] = 40,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye5",
				["Score"] = 40,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye5",
				["Score"] = 40,
				["Image"] = nil,
				["Image"] = v_u_6
			},
			{
				["Name"] = "thebigkannye5",
				["Score"] = 40,
				["Image"] = nil,
				["Image"] = v_u_6
			}
		}
		p5.Players = v7
		v_u_4(p5)
	end
}