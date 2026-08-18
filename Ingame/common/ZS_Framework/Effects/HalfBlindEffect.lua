local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion)
require("@game/ReplicatedStorage/common/NPCRegistry")
local v_u_3 = require(v1.common.ZS_Shared.Data.GameState)
local v_u_4 = require("../Data/PlayerDatabase")
local v_u_5, v_u_6 = require(v1.Packages.Bin)()
local v_u_7 = math.random(1, 2)
local function v12() -- name: toggleHalfblind
	-- upvalues: (copy) v_u_3, (copy) v_u_6, (copy) v_u_2, (copy) v_u_5, (copy) v_u_4, (copy) v_u_7
	local v8 = v_u_3.Data.Variables.HalfBlindEnabled
	v_u_6()
	if v8 then
		local v_u_9 = v_u_2.scoped(v_u_2)
		v_u_5(function()
			-- upvalues: (copy) v_u_9
			v_u_9:doCleanup()
		end)
		local v10 = v_u_9:New("ScreenGui")
		local v11 = {
			["Parent"] = v_u_4.PlayerGui,
			["IgnoreGuiInset"] = true,
			["ScreenInsets"] = Enum.ScreenInsets.None,
			["ResetOnSpawn"] = false,
			["DisplayOrder"] = -10,
			[v_u_9.Children] = { v_u_9:New("Frame")({
					["Size"] = nil,
					["Position"] = nil,
					["BackgroundColor3"] = nil,
					["BackgroundTransparency"] = 0,
					["Size"] = UDim2.new(0.5, 0, 1, 0),
					["Position"] = v_u_7 == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0.5, 0, 0, 0),
					["BackgroundColor3"] = Color3.new(0, 0, 0)
				}) }
		}
		v10(v11)
	end
end
v12()
v_u_3.Signals.Variables.HalfBlindEnabled:Connect(v12)
return {}