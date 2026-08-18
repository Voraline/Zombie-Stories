local v_u_1 = require("../../Data/PlayerDatabase")
local v_u_2 = {}
local v_u_3 = nil
function v_u_2.SetLoadingScreen(p4) -- name: SetLoadingScreen
	-- upvalues: (ref) v_u_3, (copy) v_u_1
	if v_u_3 then
		v_u_3:doCleanup()
	end
	if p4 then
		v_u_3 = v_u_1.Scope:innerScope()
		local v5 = v_u_3:New("ScreenGui")
		local v6 = {
			["Name"] = "MapLoadingScreen",
			["Parent"] = v_u_1.PlayerGui,
			["IgnoreGuiInset"] = true,
			["ScreenInsets"] = Enum.ScreenInsets.None,
			["DisplayOrder"] = 10
		}
		local v7 = v_u_3.Children
		local v8 = {}
		local v9 = v_u_3:New("Frame")
		local v10 = {
			["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
			["Size"] = UDim2.new(1, 0, 1, 0),
			[v_u_3.Children] = { v_u_3:New("TextLabel")({
					["Text"] = "LOADING MAP",
					["TextColor3"] = nil,
					["BackgroundTransparency"] = 1,
					["Size"] = nil,
					["Position"] = nil,
					["AnchorPoint"] = nil,
					["Font"] = nil,
					["TextScaled"] = true,
					["TextColor3"] = Color3.fromRGB(255, 255, 255),
					["Size"] = UDim2.new(0.5, 0, 0.25, 0),
					["Position"] = UDim2.new(0.5, 0, 0.5, 0),
					["AnchorPoint"] = Vector2.new(0.5, 0.5),
					["Font"] = Enum.Font.GothamBold
				}) }
		}
		__set_list(v8, 1, {v9(v10)})
		v6[v7] = v8
		v5(v6)
	end
end
if workspace:GetAttribute("MapLoading") then
	v_u_2.SetLoadingScreen(true)
end
workspace:GetAttributeChangedSignal("MapLoading"):Connect(function()
	-- upvalues: (copy) v_u_2
	v_u_2.SetLoadingScreen(workspace:GetAttribute("MapLoading"))
end)
return v_u_2