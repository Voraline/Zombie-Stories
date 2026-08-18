local v1 = game:GetService("ReplicatedStorage").Packages
local v_u_2 = require(v1.Fusion)
local v_u_3 = v_u_2.Children
local v_u_4 = v_u_2.OnEvent
local v_u_5 = {
	[0] = Color3.fromRGB(189, 189, 189),
	[1] = Color3.fromRGB(102, 216, 111),
	[2] = Color3.fromRGB(58, 147, 255),
	[3] = Color3.fromRGB(255, 153, 51),
	[4] = Color3.fromRGB(144, 47, 255)
}
local v_u_6 = {
	[0] = Color3.fromRGB(76, 76, 76),
	[1] = Color3.fromRGB(41, 86, 44),
	[2] = Color3.fromRGB(23, 59, 102),
	[3] = Color3.fromRGB(102, 61, 20),
	[4] = Color3.fromRGB(58, 19, 102)
}
local v_u_7 = Color3.fromRGB(255, 255, 255)
local v_u_8 = Color3.fromRGB(129, 211, 255)
return function(p_u_9)
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
	local v_u_10 = p_u_9.scope
	local v12 = v_u_10:Computed(function(p11)
		-- upvalues: (copy) p_u_9
		return ("%*/%*"):format(p11(p_u_9.CurrentRank), (p11(p_u_9.MaxRank)))
	end)
	local v_u_15 = v_u_10:Computed(function(p13)
		-- upvalues: (copy) p_u_9
		local v14 = p_u_9.ShowDescription
		if v14 == nil then
			return false
		else
			return p13(v14)
		end
	end)
	local v17 = v_u_10:Computed(function(p16)
		-- upvalues: (copy) v_u_15
		return not p16(v_u_15)
	end)
	local v20 = v_u_10:Computed(function(p18)
		-- upvalues: (copy) p_u_9
		local v19 = p_u_9.IsPurchasable
		if v19 == nil then
			return false
		else
			return not p18(v19)
		end
	end)
	local v_u_22 = v_u_10:Computed(function(p21)
		-- upvalues: (copy) p_u_9
		return p21(p_u_9.CurrentRank) >= 1
	end)
	local v_u_25 = v_u_10:Computed(function(p23)
		-- upvalues: (copy) p_u_9
		local v24 = p_u_9.IsSelected
		if v24 == nil then
			return false
		else
			return p23(v24)
		end
	end)
	local v_u_28 = v_u_10:Computed(function(p26)
		-- upvalues: (copy) p_u_9
		local v27 = p_u_9.IsHovered
		if v27 == nil then
			return false
		else
			return p26(v27)
		end
	end)
	local v31 = v_u_10:Computed(function(p29)
		-- upvalues: (copy) p_u_9, (copy) v_u_22, (ref) v_u_5, (ref) v_u_6
		local v30 = p_u_9.Tier and (p29(p_u_9.Tier) or 0) or 0
		if p29(v_u_22) then
			return v_u_5[v30] or v_u_5[0]
		else
			return v_u_6[v30] or v_u_6[0]
		end
	end)
	local v33 = v_u_10:Computed(function(p32)
		-- upvalues: (copy) v_u_25, (ref) v_u_7, (copy) v_u_22, (copy) p_u_9, (ref) v_u_5, (ref) v_u_8
		if p32(v_u_25) then
			return v_u_7
		elseif p32(v_u_22) then
			return v_u_5[p_u_9.Tier and p32(p_u_9.Tier) or 0] or v_u_8
		else
			return v_u_8
		end
	end)
	local v35 = v_u_10:Spring(v_u_10:Computed(function(p34)
		-- upvalues: (copy) v_u_25, (copy) v_u_28, (copy) v_u_22
		return (p34(v_u_25) or p34(v_u_28)) and 100 or (p34(v_u_22) and 50 or 0)
	end), 25, 0.8)
	local v_u_36 = v_u_10:Value(1)
	local v_u_37 = v_u_2.peek(p_u_9.CurrentRank)
	v_u_10:Observer(p_u_9.CurrentRank):onBind(function()
		-- upvalues: (ref) v_u_2, (copy) p_u_9, (ref) v_u_37, (copy) v_u_36
		local v38 = v_u_2.peek(p_u_9.CurrentRank)
		if v_u_37 < v38 then
			task.spawn(function()
				-- upvalues: (ref) v_u_36
				local v39 = 0
				while v39 < 0.5 do
					v39 = v39 + task.wait()
					local v40 = v39 / 0.5
					local v41 = math.min(v40, 1) * 3.141592653589793 / 2
					v_u_36:set(math.cos(v41) * 1 + 1)
				end
				v_u_36:set(1)
			end)
		end
		v_u_37 = v38
	end)
	local function v42() -- name: createUIGradient
		-- upvalues: (copy) v_u_10
		return v_u_10:New("UIGradient")({
			["Name"] = "UIGradient",
			["Color"] = nil,
			["Rotation"] = 45,
			["Color"] = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 125, 125)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) })
		})
	end
	local v_u_43 = v_u_10:New("Sound")({
		["Name"] = "RBLX UI Swipe (SFX)",
		["SoundId"] = "rbxassetid://10128766965"
	})
	local v_u_44 = v_u_10:New("Sound")({
		["Name"] = "RBLX UI Back (SFX)",
		["SoundId"] = "rbxassetid://10066914500"
	})
	local v_u_45 = false
	v_u_10:Observer(v_u_15):onBind(function()
		-- upvalues: (ref) v_u_2, (copy) v_u_15, (ref) v_u_45, (copy) v_u_43, (copy) v_u_44
		local v46 = v_u_2.peek(v_u_15)
		if v_u_45 then
			if v46 then
				v_u_43:Play()
			else
				v_u_44:Play()
			end
		else
			v_u_45 = true
			return
		end
	end)
	local v47 = v_u_10:New("SurfaceGui")
	local v48 = {
		["Name"] = "SkillGui",
		["Face"] = Enum.NormalId.Top,
		["ClipsDescendants"] = false,
		["LightInfluence"] = 0,
		["Brightness"] = v_u_36,
		["SizingMode"] = Enum.SurfaceGuiSizingMode.PixelsPerStud,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["Adornee"] = p_u_9.Adornee,
		["ResetOnSpawn"] = false
	}
	local v49 = v_u_3
	local v50 = {}
	local v51 = v_u_10:New("TextButton")({
		["Name"] = "ClickDetector",
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(1, 1),
		["Text"] = "",
		["ZIndex"] = 10,
		[v_u_4("Activated")] = function()
			-- upvalues: (copy) p_u_9
			if p_u_9.OnClick then
				p_u_9.OnClick()
			end
		end,
		[v_u_4("MouseEnter")] = function()
			-- upvalues: (copy) p_u_9
			if p_u_9.OnHoverEnter then
				p_u_9.OnHoverEnter()
			end
		end,
		[v_u_4("MouseLeave")] = function()
			-- upvalues: (copy) p_u_9
			if p_u_9.OnHoverLeave then
				p_u_9.OnHoverLeave()
			end
		end
	})
	local v52 = v_u_10:New("Frame")
	local v53 = {
		["Name"] = "Frame",
		["BackgroundColor3"] = v31,
		["BackgroundTransparency"] = 0,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(1, 1),
		["Visible"] = v17,
		[v_u_3] = {
			v42(),
			v_u_44,
			v_u_10:New("ImageLabel")({
				["Name"] = "ImageLabel",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["Position"] = nil,
				["Size"] = nil,
				["ScaleType"] = nil,
				["Image"] = nil,
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["Position"] = UDim2.fromScale(0.5, 0.4),
				["Size"] = UDim2.fromScale(0.7, 0.7),
				["ScaleType"] = Enum.ScaleType.Fit,
				["Image"] = p_u_9.Icon or "rbxassetid://3187426822"
			}),
			v_u_10:New("TextLabel")({
				["Name"] = "SkillName",
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["Position"] = UDim2.fromScale(0.5, 0.7),
				["Size"] = UDim2.fromScale(0.8, 0.3),
				["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold),
				["Text"] = p_u_9.SkillName,
				["TextColor3"] = Color3.new(1, 1, 1),
				["TextScaled"] = true,
				["RichText"] = true,
				["ZIndex"] = 2,
				[v_u_3] = { v_u_10:New("UIStroke")({
						["Name"] = "UIStroke",
						["StrokeSizingMode"] = "ScaledSize",
						["Thickness"] = 0.06
					}) }
			}),
			v_u_10:New("TextLabel")({
				["Name"] = "UpgradeLevel",
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["Position"] = UDim2.fromScale(0, 0.87),
				["Size"] = UDim2.fromScale(1, 0.2),
				["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold),
				["Text"] = v12,
				["TextColor3"] = Color3.new(1, 1, 1),
				["TextScaled"] = true,
				["RichText"] = true,
				["ZIndex"] = 2,
				[v_u_3] = { v_u_10:New("UIStroke")({
						["Name"] = "UIStroke",
						["StrokeSizingMode"] = "ScaledSize",
						["Thickness"] = 0.06
					}) }
			}),
			v_u_10:New("Frame")({
				["Name"] = "Locked",
				["BackgroundColor3"] = nil,
				["BackgroundTransparency"] = 0.2,
				["BorderColor3"] = nil,
				["BorderSizePixel"] = 0,
				["Size"] = nil,
				["Visible"] = nil,
				["ZIndex"] = 5,
				["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
				["BorderColor3"] = Color3.fromRGB(0, 0, 0),
				["Size"] = UDim2.fromScale(1, 1),
				["Visible"] = v20
			})
		}
	}
	local v54 = v52(v53)
	local v55 = v_u_10:New("Frame")
	local v56 = {
		["Name"] = "DescFrame",
		["BackgroundColor3"] = v31,
		["BackgroundTransparency"] = 0,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(1, 1),
		["Visible"] = v_u_15,
		[v_u_3] = {
			v42(),
			v_u_43,
			v_u_10:New("ImageLabel")({
				["Name"] = "ImageLabel",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["Image"] = nil,
				["ImageColor3"] = nil,
				["ImageTransparency"] = 0.7,
				["Position"] = nil,
				["ScaleType"] = nil,
				["Size"] = nil,
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["Image"] = p_u_9.Icon or "rbxassetid://3187426822",
				["ImageColor3"] = Color3.fromRGB(0, 0, 0),
				["Position"] = UDim2.fromScale(0.5, 0.15),
				["ScaleType"] = Enum.ScaleType.Fit,
				["Size"] = UDim2.fromScale(0.2, 0.2)
			}),
			v_u_10:New("TextLabel")({
				["Name"] = "SkillName",
				["AnchorPoint"] = Vector2.new(0.5, 0.5),
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				["Position"] = UDim2.fromScale(0.5, 0.15),
				["RichText"] = true,
				["Size"] = UDim2.fromScale(0.8, 0.3),
				["Text"] = p_u_9.SkillName,
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextScaled"] = true,
				["ZIndex"] = 2,
				[v_u_3] = { v_u_10:New("UIStroke")({
						["Name"] = "UIStroke",
						["StrokeSizingMode"] = "ScaledSize",
						["Thickness"] = 0.06
					}) }
			}),
			v_u_10:New("TextLabel")({
				["Name"] = "UpgradeLevel",
				["AnchorPoint"] = Vector2.new(0, 0.5),
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				["Position"] = UDim2.fromScale(0, 0.3),
				["RichText"] = true,
				["Size"] = UDim2.fromScale(1, 0.2),
				["Text"] = v12,
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextScaled"] = true,
				["ZIndex"] = 2,
				[v_u_3] = { v_u_10:New("UIStroke")({
						["Name"] = "UIStroke",
						["StrokeSizingMode"] = "ScaledSize",
						["Thickness"] = 0.06
					}) }
			}),
			v_u_10:New("TextLabel")({
				["Name"] = "Description",
				["AnchorPoint"] = Vector2.new(0.5, 0),
				["BackgroundTransparency"] = 1,
				["BorderSizePixel"] = 0,
				["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
				["Position"] = UDim2.fromScale(0.5, 0.35),
				["RichText"] = true,
				["Size"] = UDim2.fromScale(1, 0.6),
				["Text"] = p_u_9.Description or "",
				["TextColor3"] = Color3.fromRGB(255, 255, 255),
				["TextScaled"] = true,
				["ZIndex"] = 2,
				[v_u_3] = { v_u_10:New("UIStroke")({
						["Name"] = "UIStroke",
						["StrokeSizingMode"] = "ScaledSize",
						["Thickness"] = 0.06
					}) }
			}),
			v_u_10:New("UIPadding")({
				["Name"] = "UIPadding",
				["PaddingLeft"] = nil,
				["PaddingRight"] = nil,
				["PaddingLeft"] = UDim.new(0.03, 0),
				["PaddingRight"] = UDim.new(0.03, 0)
			})
		}
	}
	local v57 = v55(v56)
	local v58 = v_u_10:New("Frame")
	local v59 = {
		["Name"] = "Outline",
		["BackgroundColor3"] = Color3.fromRGB(255, 255, 255),
		["BackgroundTransparency"] = 1,
		["BorderColor3"] = Color3.fromRGB(0, 0, 0),
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(1, 1),
		["ZIndex"] = 6,
		[v_u_3] = { v_u_10:New("UIStroke")({
				["Name"] = "UIStroke",
				["Color"] = nil,
				["LineJoinMode"] = nil,
				["Thickness"] = nil,
				["Color"] = v33,
				["LineJoinMode"] = Enum.LineJoinMode.Bevel,
				["Thickness"] = v35
			}) }
	}
	__set_list(v50, 1, {v51, v54, v57, v58(v59)})
	v48[v49] = v50
	return v47(v48)
end