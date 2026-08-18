local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = require("../../UI/Controllers/ServerListController")
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
		v_u_3.new({
			["target"] = p4.target,
			["scope"] = v5
		})
	end
}