local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage").Packages
local v3 = require(v2.Fusion)
local v_u_4 = v3.Children
local v_u_5 = v3.OnEvent
return function(p_u_6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_1
	local v7 = p_u_6.scope
	local v10 = v7:Computed(function(p8)
		-- upvalues: (copy) p_u_6
		local v9 = p_u_6.IsOpen
		return v9 == nil and true or not p8(v9)
	end)
	local v11 = v7:New("ScreenGui")
	local v12 = {
		["Name"] = "SkillTreeToggleGui",
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["ResetOnSpawn"] = false
	}
	local v13 = v_u_4
	local v14 = {}
	local v15 = v7:New("TextButton")
	local v16 = {
		["Name"] = "TextButton",
		["BackgroundColor3"] = Color3.fromRGB(49, 183, 255),
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["BorderSizePixel"] = 0,
		["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
		["Position"] = UDim2.fromScale(0.0121, 0.468),
		["Size"] = UDim2.fromOffset(200, 50),
		["Text"] = "Open Skill Tree",
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextScaled"] = true,
		["TextSize"] = 14,
		["TextWrapped"] = true,
		["Visible"] = v10,
		[v_u_5("Activated")] = function()
			-- upvalues: (copy) p_u_6
			if p_u_6.OnOpen then
				p_u_6.OnOpen()
			end
		end,
		[v_u_4] = {
			v7:New("UICorner")({
				["Name"] = "UICorner"
			}),
			v7:New("UIPadding")({
				["Name"] = "UIPadding",
				["PaddingBottom"] = nil,
				["PaddingLeft"] = nil,
				["PaddingRight"] = nil,
				["PaddingBottom"] = UDim.new(0.1, 0),
				["PaddingLeft"] = UDim.new(0.1, 0),
				["PaddingRight"] = UDim.new(0.1, 0)
			}),
			v7:New("UIStroke")({
				["Name"] = "UIStroke",
				["Thickness"] = 1.5
			}),
			v7:New("UIStroke")({
				["Name"] = "UIStroke2",
				["ApplyStrokeMode"] = nil,
				["Thickness"] = 1.5,
				["Transparency"] = 0.5,
				["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
			})
		}
	}
	__set_list(v14, 1, {v15(v16)})
	v12[v13] = v14
	local v17 = v11(v12)
	v17.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
	return v17
end