local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = v2.Packages
local v_u_4 = require(v3.Fusion)
local v_u_5 = v_u_4.Children
local v_u_6 = v_u_4.OnEvent
local v_u_7 = require(v2.common.skillTree.config.EconomyConfig)
local function v_u_14(p8) -- name: commaFormat
	local v9 = math.floor(p8)
	local v10 = tostring(v9)
	local v11 = #v10
	if v11 <= 3 then
		return v10
	end
	local v12 = ""
	for v13 = 1, v11 do
		if v13 > 1 and (v11 - v13 + 1) % 3 == 0 then
			v12 = v12 .. ","
		end
		v12 = v12 .. v10:sub(v13, v13)
	end
	return v12
end
local v_u_15 = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local function v_u_20(p16, p17) -- name: makeActionButton
	-- upvalues: (copy) v_u_15, (copy) v_u_6, (copy) v_u_5
	local v18 = p16:New("TextButton")
	local v19 = {
		["Name"] = p17.Name,
		["BackgroundColor3"] = p17.BackgroundColor3,
		["BorderSizePixel"] = 0,
		["FontFace"] = v_u_15,
		["Size"] = UDim2.new(1, 0, 0, 42),
		["Text"] = p17.Text,
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextScaled"] = true,
		["TextWrapped"] = true,
		["LayoutOrder"] = p17.LayoutOrder,
		["Visible"] = p17.Visible,
		[v_u_6("Activated")] = p17.OnActivated,
		[v_u_5] = {
			p16:New("UICorner")({
				["CornerRadius"] = UDim.new(0, 6)
			}),
			p16:New("UIPadding")({
				["PaddingBottom"] = UDim.new(0.1, 0),
				["PaddingLeft"] = UDim.new(0.05, 0),
				["PaddingRight"] = UDim.new(0.05, 0)
			}),
			p16:New("UIStroke")({
				["Thickness"] = 1.5
			}),
			p16:New("UIStroke")({
				["ApplyStrokeMode"] = nil,
				["Thickness"] = 1.5,
				["Transparency"] = 0.5,
				["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
			})
		}
	}
	return v18(v19)
end
return function(p_u_21)
	-- upvalues: (copy) v_u_14, (copy) v_u_7, (copy) v_u_1, (copy) v_u_5, (copy) v_u_15, (copy) v_u_20, (copy) v_u_4, (copy) v_u_6
	local v22 = p_u_21.scope
	local v_u_23 = v22:Value(false)
	local v28 = v22:Computed(function(p24)
		-- upvalues: (copy) p_u_21, (ref) v_u_14
		local v25 = p24(p_u_21.SP)
		local v26 = p24(p_u_21.SPSpent)
		local v27 = p24(p_u_21.SPCap)
		return ("SP: %*  |  Invested: %* / %*"):format(v_u_14(v25), v_u_14(v26), (v_u_14(v27)))
	end)
	local v_u_33 = v22:Computed(function(p29)
		-- upvalues: (copy) p_u_21, (ref) v_u_7
		local v30 = p29(p_u_21.XPBar)
		local v31 = v_u_7.SP_XP_PER_SP
		if v31 <= 0 then
			return 0
		end
		local v32 = v30 / v31
		return math.clamp(v32, 0, 1)
	end)
	local v37 = v22:Computed(function(p34)
		-- upvalues: (copy) p_u_21, (ref) v_u_14
		local v35 = p34(p_u_21.DailyEarned)
		local v36 = p34(p_u_21.DailyEarnCap)
		return ("Daily: %* / %* SP"):format(v_u_14(v35), (v_u_14(v36)))
	end)
	local v39 = v22:Computed(function(p38)
		-- upvalues: (copy) p_u_21, (ref) v_u_14
		return ("Z$: %*"):format((v_u_14((p38(p_u_21.ZBucks)))))
	end)
	local v42 = v22:Computed(function(p40)
		-- upvalues: (copy) p_u_21, (ref) v_u_7, (ref) v_u_14
		local v41 = p40(p_u_21.PrestigeLevel)
		return ("Prestige (%* Z$)"):format((v_u_14((v_u_7.getPrestigeZBucksCost(v41)))))
	end)
	local v43 = ("Respec (%* Z$)"):format((v_u_14(v_u_7.RESPEC_ZBUCKS_COST)))
	local v44 = "\226\128\162 Play games to earn Skill XP based on your combat score. There is a daily cap.\n" .. ("\226\128\162 Some daily quests award SP (%* of 4 dailies)\n"):format(v_u_7.DAILY_QUESTS_WITH_SP) .. "\226\128\162 One weekly quest awards SP\n\226\128\162 Quests don\'t count towards the daily cap\n\226\128\162 Prestige to increase your SP cap and earn an XP bonus\n\226\128\162 To unlock Prestige, reach max SP points and spend them all"
	local v45 = v22:New("ScreenGui")
	local v46 = {
		["Name"] = "SkillTreeButtonsGui",
		["Parent"] = v_u_1.LocalPlayer:WaitForChild("PlayerGui"),
		["ResetOnSpawn"] = false,
		["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling,
		["Enabled"] = false
	}
	local v47 = v_u_5
	local v48 = {}
	local v49 = v22:New("TextLabel")
	local v50 = {
		["Name"] = "BetaLabel",
		["AnchorPoint"] = Vector2.new(0.5, 0),
		["BackgroundColor3"] = Color3.fromRGB(255, 80, 80),
		["BackgroundTransparency"] = 0.2,
		["BorderSizePixel"] = 0,
		["FontFace"] = v_u_15,
		["Position"] = UDim2.fromScale(0.5, 0.01),
		["Size"] = UDim2.fromScale(0.4, 0.035),
		["Text"] = "BETA \226\128\148 Progress will be reset on release. Z$ will also be refunded.",
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextScaled"] = true,
		["TextWrapped"] = true,
		["Visible"] = v_u_7.IS_BETA,
		[v_u_5] = { v22:New("UICorner")({
				["CornerRadius"] = UDim.new(0.3, 0)
			}), v22:New("UIPadding")({
				["PaddingLeft"] = UDim.new(0.05, 0),
				["PaddingRight"] = UDim.new(0.05, 0)
			}), v22:New("UISizeConstraint")({
				["MinSize"] = Vector2.new(200, 20),
				["MaxSize"] = Vector2.new(500, 40)
			}) }
	}
	local v51 = v49(v50)
	local v52 = v22:New("Frame")
	local v53 = {
		["Name"] = "EconomyPanel",
		["AnchorPoint"] = Vector2.new(0, 0),
		["BackgroundColor3"] = Color3.fromRGB(20, 20, 30),
		["BackgroundTransparency"] = 0.3,
		["BorderSizePixel"] = 0,
		["Position"] = UDim2.fromScale(0.01, 0.05),
		["Size"] = UDim2.fromScale(0.22, 0.25)
	}
	local v54 = v_u_5
	local v55 = {}
	local v56 = v22:New("UISizeConstraint")({
		["MinSize"] = Vector2.new(240, 130),
		["MaxSize"] = Vector2.new(400, 220)
	})
	local v57 = v22:New("UICorner")({
		["CornerRadius"] = UDim.new(0, 8)
	})
	local v58 = v22:New("UIPadding")({
		["PaddingBottom"] = UDim.new(0.04, 0),
		["PaddingLeft"] = UDim.new(0.04, 0),
		["PaddingRight"] = UDim.new(0.04, 0),
		["PaddingTop"] = UDim.new(0.04, 0)
	})
	local v59 = v22:New("UIListLayout")({
		["SortOrder"] = Enum.SortOrder.LayoutOrder,
		["Padding"] = UDim.new(0.02, 0)
	})
	local v69 = v22:New("TextLabel")({
		["Name"] = "PrestigeLevel",
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["LayoutOrder"] = 0,
		["Size"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextXAlignment"] = nil,
		["FontFace"] = v_u_15,
		["Size"] = UDim2.fromScale(1, 0.12),
		["Text"] = v22:Computed(function(p60)
			-- upvalues: (copy) p_u_21, (ref) v_u_7
			local v61 = p60(p_u_21.PrestigeLevel)
			local v62 = v61 * v_u_7.XP_BOOST_PER_PRESTIGE
			local v63 = v_u_7.MAX_XP_BOOST
			local v64 = math.min(v62, v63) * 100 + 0.5
			local v65 = math.floor(v64)
			local v66 = (p60(p_u_21.XPBonusMult) - 1) * 100 + 0.5
			local v67 = math.floor(v66)
			local v68
			if v61 == 0 then
				v68 = ("Prestige: None (%*%% XP)"):format(v65)
			else
				v68 = ("Prestige: %* (+%*%% XP)"):format(v61, v65)
			end
			if v67 > 0 then
				v68 = v68 .. (" (+%*%%)"):format(v67)
			end
			return v68
		end),
		["TextColor3"] = Color3.fromRGB(180, 100, 255),
		["TextXAlignment"] = Enum.TextXAlignment.Left
	})
	local v70 = v22:New("TextLabel")({
		["Name"] = "SPCounter",
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["LayoutOrder"] = 1,
		["Size"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextXAlignment"] = nil,
		["FontFace"] = v_u_15,
		["Size"] = UDim2.fromScale(1, 0.14),
		["Text"] = v28,
		["TextColor3"] = Color3.fromRGB(38, 175, 255),
		["TextXAlignment"] = Enum.TextXAlignment.Left
	})
	local v71 = v22:New("Frame")
	local v72 = {
		["Name"] = "XPBarBG",
		["BackgroundColor3"] = Color3.fromRGB(40, 40, 50),
		["BorderSizePixel"] = 0,
		["LayoutOrder"] = 2,
		["Size"] = UDim2.fromScale(1, 0.09)
	}
	local v73 = v_u_5
	local v74 = {}
	local v75 = v22:New("UICorner")({
		["CornerRadius"] = UDim.new(0.5, 0)
	})
	local v76 = v22:New("Frame")
	local v78 = {
		["Name"] = "XPBarFill",
		["BackgroundColor3"] = Color3.fromRGB(38, 175, 255),
		["BorderSizePixel"] = 0,
		["Size"] = v22:Computed(function(p77)
			-- upvalues: (copy) v_u_33
			return UDim2.fromScale(p77(v_u_33), 1)
		end),
		[v_u_5] = { v22:New("UICorner")({
				["CornerRadius"] = UDim.new(0.5, 0)
			}) }
	}
	__set_list(v74, 1, {v75, v76(v78)})
	v72[v73] = v74
	__set_list(v55, 1, {v56, v57, v58, v59, v69, v70, v71(v72), v22:New("TextLabel")({
	["Name"] = "XPLabel",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["LayoutOrder"] = 3,
	["Size"] = nil,
	["Text"] = nil,
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = v_u_15,
	["Size"] = UDim2.fromScale(1, 0.12),
	["Text"] = v22:Computed(function(p79)
		-- upvalues: (copy) p_u_21, (ref) v_u_14, (ref) v_u_7
		local v80 = p79(p_u_21.XPBar)
		local v81 = p79(p_u_21.AtSPCap)
		local v82 = p79(p_u_21.AtDailyCap)
		if v81 then
			return ("Skill XP: %* / %* (Max)"):format(v_u_14(v80), (v_u_14(v_u_7.SP_XP_PER_SP)))
		elseif v82 then
			return ("Skill XP: %* / %* (Daily Max)"):format(v_u_14(v80), (v_u_14(v_u_7.SP_XP_PER_SP)))
		else
			return ("Skill XP: %* / %*"):format(v_u_14(v80), (v_u_14(v_u_7.SP_XP_PER_SP)))
		end
	end),
	["TextColor3"] = Color3.fromRGB(180, 180, 200),
	["TextXAlignment"] = Enum.TextXAlignment.Left
}), v22:New("TextLabel")({
	["Name"] = "DailyProgress",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["LayoutOrder"] = 4,
	["Size"] = nil,
	["Text"] = nil,
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = v_u_15,
	["Size"] = UDim2.fromScale(1, 0.12),
	["Text"] = v37,
	["TextColor3"] = Color3.fromRGB(180, 180, 200),
	["TextXAlignment"] = Enum.TextXAlignment.Left
}), v22:New("TextLabel")({
	["Name"] = "ZBucksBalance",
	["BackgroundTransparency"] = 1,
	["FontFace"] = nil,
	["LayoutOrder"] = 5,
	["Size"] = nil,
	["Text"] = nil,
	["TextColor3"] = nil,
	["TextScaled"] = true,
	["TextXAlignment"] = nil,
	["FontFace"] = v_u_15,
	["Size"] = UDim2.fromScale(1, 0.12),
	["Text"] = v39,
	["TextColor3"] = Color3.fromRGB(17, 255, 77),
	["TextXAlignment"] = Enum.TextXAlignment.Left
})})
	v53[v54] = v55
	local v83 = v52(v53)
	local v84 = v22:New("Frame")
	local v85 = {
		["Name"] = "ActionButtons",
		["AnchorPoint"] = Vector2.new(1, 0),
		["BackgroundTransparency"] = 1,
		["Position"] = UDim2.fromScale(0.99, 0.03),
		["Size"] = UDim2.fromScale(0.14, 0.28),
		[v_u_5] = {
			v22:New("UISizeConstraint")({
				["MinSize"] = Vector2.new(150, 0),
				["MaxSize"] = Vector2.new(220, 250)
			}),
			v22:New("UIListLayout")({
				["SortOrder"] = Enum.SortOrder.LayoutOrder,
				["FillDirection"] = Enum.FillDirection.Vertical,
				["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
				["Padding"] = UDim.new(0, 6)
			}),
			v_u_20(v22, {
				["Name"] = "Close",
				["Text"] = "Exit",
				["BackgroundColor3"] = nil,
				["LayoutOrder"] = 1,
				["OnActivated"] = nil,
				["BackgroundColor3"] = Color3.fromRGB(255, 135, 135),
				["OnActivated"] = p_u_21.OnExit
			}),
			v_u_20(v22, {
				["Name"] = "Respec",
				["Text"] = nil,
				["BackgroundColor3"] = nil,
				["LayoutOrder"] = 2,
				["Visible"] = nil,
				["OnActivated"] = nil,
				["Text"] = v43,
				["BackgroundColor3"] = Color3.fromRGB(255, 200, 100),
				["Visible"] = p_u_21.RespecVisible,
				["OnActivated"] = p_u_21.OnRespec
			}),
			v_u_20(v22, {
				["Name"] = "Prestige",
				["Text"] = nil,
				["BackgroundColor3"] = nil,
				["LayoutOrder"] = 3,
				["Visible"] = nil,
				["OnActivated"] = nil,
				["Text"] = v42,
				["BackgroundColor3"] = Color3.fromRGB(180, 100, 255),
				["Visible"] = p_u_21.CanPrestige,
				["OnActivated"] = p_u_21.OnPrestige
			}),
			v_u_20(v22, {
				["Name"] = "Help",
				["Text"] = "?  How to Earn SP",
				["BackgroundColor3"] = nil,
				["LayoutOrder"] = 4,
				["OnActivated"] = nil,
				["BackgroundColor3"] = Color3.fromRGB(100, 160, 255),
				["OnActivated"] = function() -- name: OnActivated
					-- upvalues: (copy) v_u_23, (ref) v_u_4
					v_u_23:set(not v_u_4.peek(v_u_23))
				end
			})
		}
	}
	local v86 = v84(v85)
	local v87 = v22:New("Frame")
	local v89 = {
		["Name"] = "HelpOverlay",
		["BackgroundColor3"] = Color3.fromRGB(0, 0, 0),
		["BackgroundTransparency"] = 0.5,
		["BorderSizePixel"] = 0,
		["Size"] = UDim2.fromScale(1, 1),
		["Visible"] = v_u_23,
		["ZIndex"] = 10,
		[v_u_6("InputBegan")] = function(p88)
			-- upvalues: (copy) v_u_23
			if p88.UserInputType == Enum.UserInputType.MouseButton1 or p88.UserInputType == Enum.UserInputType.Touch then
				v_u_23:set(false)
			end
		end
	}
	local v90 = v_u_5
	local v91 = {}
	local v92 = v22:New("Frame")
	local v93 = {
		["Name"] = "HelpPanel",
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["BackgroundColor3"] = Color3.fromRGB(20, 20, 30),
		["BackgroundTransparency"] = 0.1,
		["BorderSizePixel"] = 0,
		["Position"] = UDim2.fromScale(0.5, 0.5),
		["Size"] = UDim2.fromScale(0.35, 0.4),
		["ZIndex"] = 11
	}
	local v94 = v_u_5
	local v95 = {}
	local v96 = v22:New("UISizeConstraint")({
		["MinSize"] = Vector2.new(300, 220),
		["MaxSize"] = Vector2.new(550, 350)
	})
	local v97 = v22:New("UICorner")({
		["CornerRadius"] = UDim.new(0, 10)
	})
	local v98 = v22:New("UIStroke")({
		["Color"] = nil,
		["Thickness"] = 2,
		["Color"] = Color3.fromRGB(100, 160, 255)
	})
	local v99 = v22:New("UIPadding")({
		["PaddingBottom"] = UDim.new(0.06, 0),
		["PaddingLeft"] = UDim.new(0.06, 0),
		["PaddingRight"] = UDim.new(0.06, 0),
		["PaddingTop"] = UDim.new(0.06, 0)
	})
	local v100 = v22:New("UIListLayout")({
		["SortOrder"] = Enum.SortOrder.LayoutOrder,
		["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
		["Padding"] = UDim.new(0.03, 0)
	})
	local v101 = v22:New("TextLabel")({
		["Name"] = "Title",
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["LayoutOrder"] = 1,
		["Size"] = nil,
		["Text"] = "How to Earn Skill Points (SP)",
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["ZIndex"] = 11,
		["FontFace"] = v_u_15,
		["Size"] = UDim2.fromScale(1, 0.15),
		["TextColor3"] = Color3.fromRGB(38, 175, 255)
	})
	local v102 = v22:New("TextLabel")({
		["Name"] = "Body",
		["BackgroundTransparency"] = 1,
		["FontFace"] = nil,
		["LayoutOrder"] = 2,
		["Size"] = nil,
		["Text"] = nil,
		["TextColor3"] = nil,
		["TextScaled"] = true,
		["TextWrapped"] = true,
		["TextXAlignment"] = nil,
		["TextYAlignment"] = nil,
		["ZIndex"] = 11,
		["FontFace"] = v_u_15,
		["Size"] = UDim2.fromScale(1, 0.55),
		["Text"] = v44,
		["TextColor3"] = Color3.fromRGB(210, 210, 220),
		["TextXAlignment"] = Enum.TextXAlignment.Left,
		["TextYAlignment"] = Enum.TextYAlignment.Top
	})
	local v103 = v22:New("TextButton")
	local v104 = {
		["Name"] = "CloseHelp",
		["BackgroundColor3"] = Color3.fromRGB(100, 160, 255),
		["BorderSizePixel"] = 0,
		["FontFace"] = v_u_15,
		["LayoutOrder"] = 3,
		["Size"] = UDim2.fromScale(0.4, 0.15),
		["Text"] = "Got it",
		["TextColor3"] = Color3.fromRGB(255, 255, 255),
		["TextScaled"] = true,
		["ZIndex"] = 11,
		[v_u_6("Activated")] = function()
			-- upvalues: (copy) v_u_23
			v_u_23:set(false)
		end,
		[v_u_5] = { v22:New("UICorner")({
				["CornerRadius"] = UDim.new(0, 6)
			}) }
	}
	__set_list(v95, 1, {v96, v97, v98, v99, v100, v101, v102, v103(v104)})
	v93[v94] = v95
	__set_list(v91, 1, {v92(v93)})
	v89[v90] = v91
	__set_list(v48, 1, {v51, v83, v86, v87(v89)})
	v46[v47] = v48
	local v_u_105 = v45(v46)
	v_u_105:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (copy) v_u_105, (copy) v_u_23
		if not v_u_105.Enabled then
			v_u_23:set(false)
		end
	end)
	return v_u_105
end