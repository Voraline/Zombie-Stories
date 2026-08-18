local v1 = game:GetService("ReplicatedStorage")
require(v1.Packages.Fusion)
local v_u_2 = require(v1.common.fusion_utils)
return function(p_u_3)
	-- upvalues: (copy) v_u_2
	local v4 = p_u_3.scope:innerScope(v_u_2)
	local v5 = v4:usePx()
	local v_u_6 = v5(1)
	v5(2)
	local v7 = v4:New("Frame")({
		["Parent"] = nil,
		["Size"] = nil,
		["BackgroundTransparency"] = 1,
		["Parent"] = p_u_3.target,
		["Size"] = UDim2.new(1, 0, 1, 0)
	})
	local v_u_8 = {}
	local v9 = v4:Value(UDim2.new(0.5, 0, 1, 0))
	v_u_8[1] = v9
	local v10 = v4:New("Frame")
	local v11 = {
		["Parent"] = v7,
		["Size"] = UDim2.new(0.5, 0, 0.1, 0),
		["Position"] = v4:Spring(v9, 30, 1),
		["AnchorPoint"] = Vector2.new(0.5, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
	}
	local v12 = v4.Children
	local v13 = {}
	local v14 = v4:New("UIStroke")({
		["Color"] = nil,
		["Thickness"] = nil,
		["ApplyStrokeMode"] = nil,
		["Transparency"] = 0.75,
		["Color"] = Color3.fromRGB(0, 0, 0),
		["Thickness"] = v_u_6,
		["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
	})
	local v15 = v4:New("TextLabel")
	local v16 = {
		["Text"] = "RESULTS",
		["TextScaled"] = true,
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["Size"] = UDim2.new(1, 0, 1, 0),
		["BackgroundTransparency"] = 1,
		["Font"] = Enum.Font.GothamBold,
		[v4.Children] = { v4:New("UIStroke")({
				["Thickness"] = v_u_6
			}) }
	}
	__set_list(v13, 1, {v14, v15(v16), v4:New("UIGradient")({
	["Color"] = nil,
	["Rotation"] = 90,
	["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#00089c")), ColorSequenceKeypoint.new(1, Color3.fromHex("#00056f")) })
})})
	v11[v12] = v13
	v10(v11)
	local v18 = v4:Computed(function(p17)
		-- upvalues: (copy) v_u_6
		return UDim.new(0, p17(v_u_6) * 6)
	end)
	for v19, v20 in p_u_3.Players do
		local v21 = v4:Value(UDim2.new(0.5, 0, 1, 0))
		v_u_8[v19 + 1] = v21
		local v22
		if v19 == 1 then
			v22 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#fbbc0d")), ColorSequenceKeypoint.new(1, Color3.fromHex("#f9d205")) })
		elseif v19 == 2 then
			v22 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#d4d4d4")), ColorSequenceKeypoint.new(1, Color3.fromHex("#c3bdbd")) })
		elseif v19 == 3 then
			v22 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#de8606")), ColorSequenceKeypoint.new(1, Color3.fromHex("#c97700")) })
		else
			v22 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)), ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50)) })
		end
		local v23 = v4:New("Frame")
		local v24 = {
			["Parent"] = v7,
			["Size"] = UDim2.new(0.5, 0, 0.08, 0),
			["Position"] = v4:Spring(v21, 30, 1),
			["AnchorPoint"] = Vector2.new(0.5, 0)
		}
		local v25 = v4.Children
		local v26 = {}
		local v27 = v4:New("UIStroke")({
			["Color"] = nil,
			["Thickness"] = nil,
			["ApplyStrokeMode"] = nil,
			["Transparency"] = 0.75,
			["Color"] = Color3.fromRGB(0, 0, 0),
			["Thickness"] = v_u_6,
			["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
		})
		local v28 = v4:New("UIGradient")({
			["Color"] = nil,
			["Rotation"] = 90,
			["Color"] = v22
		})
		local v29 = v4:New("UIPadding")({
			["PaddingTop"] = v18,
			["PaddingBottom"] = v18,
			["PaddingLeft"] = v18,
			["PaddingRight"] = v18
		})
		local v30 = v4:New("ImageLabel")
		local v31 = {
			["Image"] = v20.Image,
			["Size"] = UDim2.new(1, 0, 1, 0),
			["AnchorPoint"] = Vector2.new(0, 0.5),
			["Position"] = UDim2.new(0, 0, 0.5, 0),
			["BackgroundTransparency"] = 0.75,
			["ImageColor3"] = Color3.fromRGB(255, 255, 255),
			["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
		}
		local v32 = v4.Children
		local v33 = {}
		local v34 = v4:New("UIAspectRatioConstraint")({
			["AspectRatio"] = 1
		})
		local v35 = v4:New("UIStroke")({
			["Color"] = nil,
			["Thickness"] = nil,
			["ApplyStrokeMode"] = nil,
			["Transparency"] = 0.5,
			["Color"] = Color3.fromRGB(0, 0, 0),
			["Thickness"] = v_u_6,
			["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
		})
		local v36 = v4:New("TextLabel")
		local v37 = {
			["Text"] = string.upper(v20.Name),
			["TextXAlignment"] = Enum.TextXAlignment.Left,
			["TextScaled"] = true,
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["Position"] = UDim2.new(1.2, 0, 0.5, 0),
			["AnchorPoint"] = Vector2.new(0, 0.5),
			["Size"] = UDim2.new(5, 0, 3, 0),
			["BackgroundTransparency"] = 1,
			["Font"] = Enum.Font.GothamBold,
			[v4.Children] = { v4:New("UIStroke")({
					["Thickness"] = nil,
					["Transparency"] = 0.5,
					["Thickness"] = v_u_6
				}) }
		}
		__set_list(v33, 1, {v34, v35, v36(v37)})
		v31[v32] = v33
		local v38 = v30(v31)
		local v39 = v4:New("TextLabel")
		local v40 = {
			["Text"] = v20.Score,
			["TextXAlignment"] = Enum.TextXAlignment.Center,
			["TextScaled"] = true,
			["TextColor3"] = Color3.fromRGB(255, 255, 255),
			["Position"] = UDim2.new(1, 0, 0.5, 0),
			["AnchorPoint"] = Vector2.new(1, 0.5),
			["Size"] = UDim2.new(0.1, 0, 1, 0),
			["BackgroundTransparency"] = 1,
			["Font"] = Enum.Font.GothamBold,
			[v4.Children] = { v4:New("UIStroke")({
					["Thickness"] = nil,
					["Transparency"] = 0.5,
					["Thickness"] = v_u_6
				}) }
		}
		__set_list(v26, 1, {v27, v28, v29, v38, v39(v40)})
		v24[v25] = v26
		v23(v24)
	end
	task.delay(0.01, function()
		-- upvalues: (copy) v_u_8, (copy) p_u_3
		for v41, v42 in v_u_8 do
			local v43 = v41 > 1 and 0.02 or 0
			if p_u_3.PlaySound then
				p_u_3.PlaySound("Enter")
			end
			v42:set(UDim2.new(0.5, 0, 0.05 + (v41 - 1) * 0.1 + v43, 0))
			task.wait(0.15)
		end
	end)
	return v7, function() -- name: closingScoreboard
		-- upvalues: (copy) v_u_8, (copy) p_u_3
		for _, v44 in v_u_8 do
			v44:set(UDim2.new(0.5, 0, -0.15, 0))
			if p_u_3.PlaySound then
				p_u_3.PlaySound("Leave")
			end
			task.wait(0.15)
		end
	end
end