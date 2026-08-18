local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("Workspace")
local v_u_5 = v1.LocalPlayer
local v_u_6 = require(v2.Packages.Fusion)
require("@game/ReplicatedStorage/common/HUDService")
local v_u_7 = v_u_6.scoped
local v_u_8 = v_u_6.peek
local v_u_9 = {
	["Live"] = true
}
local v10 = {}
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = false
local v_u_19 = nil
local v_u_20 = {}
local v_u_21 = 0
local function v_u_25(p22) -- name: formatTime
	local v23 = math.ceil(p22 or 0)
	local v24 = math.max(0, v23)
	return string.format("%ds", v24)
end
local function v_u_32() -- name: updateBoostStates
	-- upvalues: (ref) v_u_13, (copy) v_u_4, (copy) v_u_9, (ref) v_u_14, (ref) v_u_15, (copy) v_u_25, (copy) v_u_5, (ref) v_u_16, (ref) v_u_17, (copy) v_u_8
	if v_u_13 then
		local v26 = v_u_4:GetAttribute("TurkeyHuntState")
		if v26 then
			v26 = v_u_9[v26] == true
		end
		local v27
		if v26 then
			v27 = v_u_4:GetAttribute("TurkeyHuntInstantKill") == true
		else
			v27 = v26
		end
		v_u_14:set(v27)
		if v27 then
			v_u_15:set(v_u_25(v_u_4:GetAttribute("TurkeyHuntInstantKillTimeLeft")))
		else
			v_u_15:set("0s")
		end
		local v28 = v_u_5
		if v28 then
			v28 = v_u_5:GetAttribute("TurkeyHuntWalkSpeedBoostExpires")
		end
		local v29
		if typeof(v28) == "number" then
			local v30
			if v_u_4.GetServerTimeNow then
				v30 = v_u_4:GetServerTimeNow()
			else
				v30 = os.clock()
			end
			v29 = v28 - v30
		else
			v29 = 0
		end
		local v31
		if v26 then
			v31 = v29 > 0
		else
			v31 = v26
		end
		v_u_16:set(v31)
		if v31 then
			v_u_17:set(v_u_25(v29))
		else
			v_u_17:set("0s")
		end
		if v26 then
			v26 = v_u_8(v_u_14) or v_u_8(v_u_16)
		end
		v_u_13:set(v26)
	end
end
local function v_u_36(p33) -- name: createIconElement
	-- upvalues: (ref) v_u_11, (copy) v_u_6
	local v34 = v_u_11:New("Frame")
	local v35 = {
		["Name"] = p33.Name,
		["BackgroundTransparency"] = 1,
		["Size"] = UDim2.fromOffset(48, 48),
		["Visible"] = p33.VisibleState,
		[v_u_6.Children] = { v_u_11:New("ImageLabel")({
				["Name"] = "Icon",
				["BackgroundTransparency"] = 1,
				["Image"] = nil,
				["Size"] = nil,
				["ZIndex"] = 2,
				["Image"] = p33.Image,
				["Size"] = UDim2.fromScale(1, 1)
			}), v_u_11:New("TextLabel")({
				["Name"] = "Timer",
				["AnchorPoint"] = nil,
				["BackgroundTransparency"] = 0.35,
				["BackgroundColor3"] = nil,
				["TextColor3"] = nil,
				["Font"] = nil,
				["TextScaled"] = true,
				["Size"] = nil,
				["Position"] = nil,
				["ZIndex"] = 3,
				["Visible"] = nil,
				["Text"] = nil,
				["TextStrokeTransparency"] = 0.5,
				["AnchorPoint"] = Vector2.new(0.5, 1),
				["BackgroundColor3"] = Color3.new(0, 0, 0),
				["TextColor3"] = Color3.new(1, 1, 1),
				["Font"] = Enum.Font.GothamBold,
				["Size"] = UDim2.new(0.85, 0, 0.35, 0),
				["Position"] = UDim2.new(0.5, 0, 1, 0),
				["Visible"] = p33.VisibleState,
				["Text"] = p33.TextState
			}) }
	}
	return v34(v35)
end
local function v_u_57() -- name: initialize
	-- upvalues: (ref) v_u_18, (ref) v_u_11, (copy) v_u_7, (copy) v_u_6, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_13, (copy) v_u_5, (ref) v_u_12, (copy) v_u_36, (copy) v_u_20, (copy) v_u_4, (copy) v_u_32, (ref) v_u_19, (copy) v_u_3, (ref) v_u_21
	if not v_u_18 then
		v_u_11 = v_u_7(v_u_6)
		v_u_14 = v_u_11:Value(false)
		v_u_15 = v_u_11:Value("0s")
		v_u_16 = v_u_11:Value(false)
		v_u_17 = v_u_11:Value("0s")
		v_u_13 = v_u_11:Value(false)
		local v37 = v_u_5:WaitForChild("PlayerGui")
		v_u_12 = v_u_11:New("ScreenGui")({
			["Name"] = "TurkeyHuntBoostIndicators",
			["Parent"] = nil,
			["IgnoreGuiInset"] = true,
			["ResetOnSpawn"] = false,
			["DisplayOrder"] = 5,
			["ZIndexBehavior"] = nil,
			["Parent"] = v37,
			["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
		})
		local v38 = v_u_11:New("Frame")
		local v39 = {
			["Name"] = "BoostContainer",
			["Parent"] = v_u_12,
			["AnchorPoint"] = Vector2.new(0.5, 0),
			["Position"] = UDim2.new(0.5, 0, 0, 150),
			["BackgroundTransparency"] = 1,
			["AutomaticSize"] = Enum.AutomaticSize.XY,
			["Size"] = UDim2.fromOffset(48, 48),
			["Visible"] = v_u_13,
			["ZIndex"] = 10
		}
		local v40 = v_u_6.Children
		local v41 = {}
		local v42 = {
			["Name"] = "InstaKillIcon",
			["Image"] = "rbxassetid://79847861071198",
			["VisibleState"] = nil,
			["TextState"] = nil,
			["VisibleState"] = v_u_14,
			["TextState"] = v_u_15
		}
		local v43 = {
			["Name"] = "WalkSpeedIcon",
			["Image"] = "rbxassetid://14549056586",
			["VisibleState"] = nil,
			["TextState"] = nil,
			["VisibleState"] = v_u_16,
			["TextState"] = v_u_17
		}
		__set_list(v41, 1, {v_u_11:New("UIListLayout")({
	["FillDirection"] = Enum.FillDirection.Horizontal,
	["Padding"] = UDim.new(0, 8),
	["HorizontalAlignment"] = Enum.HorizontalAlignment.Center,
	["VerticalAlignment"] = Enum.VerticalAlignment.Top,
	["SortOrder"] = Enum.SortOrder.LayoutOrder
}), v_u_36(v42), v_u_36(v43)})
		v39[v40] = v41
		v38(v39)
		local v44 = v_u_20
		local v45 = v_u_4:GetAttributeChangedSignal("TurkeyHuntState")
		local function v46()
			-- upvalues: (ref) v_u_32
			v_u_32()
		end
		table.insert(v44, v45:Connect(v46))
		local v47 = v_u_20
		local v48 = v_u_4:GetAttributeChangedSignal("TurkeyHuntInstantKill")
		local function v49()
			-- upvalues: (ref) v_u_32
			v_u_32()
		end
		table.insert(v47, v48:Connect(v49))
		local v50 = v_u_20
		local v51 = v_u_4:GetAttributeChangedSignal("TurkeyHuntInstantKillTimeLeft")
		local function v52()
			-- upvalues: (ref) v_u_32
			v_u_32()
		end
		table.insert(v50, v51:Connect(v52))
		if v_u_5 then
			local v53 = v_u_20
			local v54 = v_u_5:GetAttributeChangedSignal("TurkeyHuntWalkSpeedBoostExpires")
			local function v55()
				-- upvalues: (ref) v_u_32
				v_u_32()
			end
			table.insert(v53, v54:Connect(v55))
		end
		v_u_19 = v_u_3.Heartbeat:Connect(function(p56)
			-- upvalues: (ref) v_u_21, (ref) v_u_32
			v_u_21 = v_u_21 + p56
			if v_u_21 >= 0.15 then
				v_u_21 = 0
				v_u_32()
			end
		end)
		v_u_32()
		v_u_18 = true
	end
end
function v10.Show(_) -- name: Show
	-- upvalues: (ref) v_u_18, (copy) v_u_57, (copy) v_u_32
	if v_u_18 then
		v_u_32()
	else
		v_u_57()
	end
end
function v10.Hide(_) -- name: Hide
	-- upvalues: (ref) v_u_13
	if v_u_13 then
		v_u_13:set(false)
	end
end
return v10