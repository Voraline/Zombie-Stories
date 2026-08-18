local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("UserInputService")
local v4 = game:GetService("ReplicatedStorage")
local v_u_5 = require(v4.Packages.Fusion)
local v_u_6 = require(v4.common.ZS_Shared.Data.GameState)
local v_u_7 = require(v4.common.ZS_Shared.Data.ModifierData)
local v_u_8 = require(v4.common.ZS_Shared.Modifiers.ModifierUtil)
local v_u_9 = require(v4.common.ZS_Shared.Modifiers.ModifierTooltip)
require("@game/ReplicatedStorage/common/HUDService")
local v_u_10 = v_u_5.scoped
local v_u_11 = {
	["IsShowing"] = false
}
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = true
local function v_u_22(p18) -- name: createModifierIcon
	-- upvalues: (copy) v_u_7, (copy) v_u_8, (copy) v_u_3, (ref) v_u_12
	print("ActiveModifierIcons: Creating icon for", p18)
	if not v_u_7[p18] then
		print("ActiveModifierIcons: No modifier data found for", p18)
		return nil
	end
	local v19 = v_u_8.GetModifierIcon(p18)
	if not v19 then
		print("ActiveModifierIcons: No icon found for", p18)
		return nil
	end
	local v20 = v_u_3.TouchEnabled
	if v20 then
		v20 = not v_u_3.KeyboardEnabled
	end
	local v21 = v20 and 16 or 32
	print("ActiveModifierIcons: Creating icon with ID", v19, "for", p18, "size:", v21)
	return v_u_12:New("ImageButton")({
		["Name"] = nil,
		["Size"] = nil,
		["BackgroundTransparency"] = 1,
		["BorderSizePixel"] = 0,
		["Image"] = nil,
		["ScaleType"] = nil,
		["ImageTransparency"] = 0,
		["Name"] = p18,
		["Size"] = UDim2.fromOffset(v21, v21),
		["Image"] = v19,
		["ScaleType"] = Enum.ScaleType.Fit
	})
end
local function v_u_28() -- name: updatePosition
	-- upvalues: (ref) v_u_14, (copy) v_u_1
	if v_u_14 then
		local v23 = v_u_1.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("HealthUI")
		local v24 = v_u_14.AbsoluteSize.Y + 16
		if v23 and v23.Enabled then
			local v25 = v23:FindFirstChild("Frame")
			if v25 then
				local v26 = v25.AbsolutePosition
				local v27 = v25.AbsoluteSize
				v_u_14.Position = UDim2.new(0, v26.X + v27.X + 8, 1, -v24)
			else
				print("ActiveModifierIcons: HealthUI Frame not found")
			end
		else
			v_u_14.Position = UDim2.new(0, 20, 1, -v24)
			return
		end
	else
		return
	end
end
local function v_u_44() -- name: updateIcons
	-- upvalues: (ref) v_u_14, (copy) v_u_3, (copy) v_u_6, (ref) v_u_15, (ref) v_u_17, (copy) v_u_22, (copy) v_u_9, (copy) v_u_7, (copy) v_u_28
	print("ActiveModifierIcons: updateIcons() called")
	if v_u_14 then
		local v29 = v_u_14:FindFirstChild("UIGridLayout")
		if v29 then
			local v30 = v_u_3.TouchEnabled
			if v30 then
				v30 = not v_u_3.KeyboardEnabled
			end
			local v31 = v30 and 16 or 32
			v29.CellSize = UDim2.fromOffset(v31, v31)
			v29.FillDirectionMaxCells = 8
		end
		for _, v32 in pairs(v_u_14:GetChildren()) do
			if v32:IsA("GuiObject") and v32.Name ~= "UIGridLayout" then
				v32:Destroy()
			end
		end
		if v_u_6.Data.IsLobby then
			print("ActiveModifierIcons: Not in story place, hiding")
			v_u_15:set(false)
			return
		elseif v_u_17 then
			local v33 = v_u_6.Data.ActiveModifiers or {}
			print("ActiveModifierIcons: Active modifiers:", v33)
			print("ActiveModifierIcons: Number of active modifiers:", v33 and (#v33 or "nil") or "nil")
			if v33 and next(v33) ~= nil then
				local v34 = 0
				local v35 = false
				for v_u_36, v37 in pairs(v33) do
					print("ActiveModifierIcons: Processing modifier", v_u_36, "active:", v37)
					if v37 then
						local v38 = v_u_22(v_u_36)
						if v38 then
							v38.Parent = v_u_14
							v34 = v34 + 1
							v_u_9.bindHover(v38, function()
								-- upvalues: (ref) v_u_7, (copy) v_u_36
								return v_u_7[v_u_36]
							end)
							v35 = true
						end
					end
				end
				local v39 = print
				local v40 = "ActiveModifierIcons: Created"
				local v41 = "icons, hasValidIcons:"
				local v42 = "(mobile:"
				local v43 = v_u_3.TouchEnabled
				if v43 then
					v43 = not v_u_3.KeyboardEnabled
				end
				v39(v40, v34, v41, v35, v42, v43, ")")
				v_u_15:set(v35)
				print("ActiveModifierIcons: Set visibility to", v35)
				v_u_28()
			else
				print("ActiveModifierIcons: No active modifiers, hiding")
				v_u_15:set(false)
			end
		else
			print("ActiveModifierIcons: HUD controller not visible, hiding")
			v_u_15:set(false)
			return
		end
	else
		print("ActiveModifierIcons: mainFrame is nil, exiting")
		return
	end
end
local function v_u_49() -- name: initialize
	-- upvalues: (copy) v_u_6, (ref) v_u_12, (copy) v_u_10, (copy) v_u_5, (copy) v_u_9, (ref) v_u_15, (ref) v_u_16, (copy) v_u_1, (ref) v_u_13, (copy) v_u_3, (ref) v_u_14, (copy) v_u_44, (copy) v_u_2, (copy) v_u_28
	print("ActiveModifierIcons: initialize() called")
	if v_u_6.Data.IsLobby then
		print("ActiveModifierIcons: Not in story place, skipping initialization")
	else
		print("ActiveModifierIcons: Creating Fusion scope...")
		v_u_12 = v_u_10(v_u_5)
		print("ActiveModifierIcons: Initializing tooltip system...")
		v_u_9.init()
		print("ActiveModifierIcons: Creating reactive states...")
		v_u_15 = v_u_12:Value(false)
		v_u_16 = v_u_12:Value(v_u_6.Data.ActiveModifiers or {})
		print("ActiveModifierIcons: Creating UI...")
		local v45 = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
		v_u_13 = v_u_12:New("ScreenGui")({
			["Name"] = "ActiveModifierIconsGui",
			["Parent"] = nil,
			["ResetOnSpawn"] = false,
			["IgnoreGuiInset"] = true,
			["ZIndexBehavior"] = nil,
			["Parent"] = v45,
			["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
		})
		print("ActiveModifierIcons: Created ScreenGui")
		local v46 = v_u_3.TouchEnabled
		if v46 then
			v46 = not v_u_3.KeyboardEnabled
		end
		local v47 = v46 and 16 or 32
		v_u_14 = v_u_12:New("Frame")({
			["Name"] = "ActiveModifierIcons",
			["Parent"] = v_u_13,
			["Visible"] = v_u_15,
			["Size"] = UDim2.fromOffset(200, v47),
			["Position"] = UDim2.new(0, 20, 1, -(v47 + 16)),
			["BackgroundTransparency"] = 1,
			["AutomaticSize"] = Enum.AutomaticSize.XY,
			[v_u_5.Children] = { v_u_12:New("UIGridLayout")({
					["Name"] = "UIGridLayout",
					["CellSize"] = nil,
					["CellPadding"] = nil,
					["FillDirection"] = nil,
					["HorizontalAlignment"] = nil,
					["VerticalAlignment"] = nil,
					["SortOrder"] = nil,
					["StartCorner"] = nil,
					["FillDirectionMaxCells"] = nil,
					["CellSize"] = UDim2.fromOffset(v47, v47),
					["CellPadding"] = UDim2.fromOffset(4, 4),
					["FillDirection"] = Enum.FillDirection.Horizontal,
					["HorizontalAlignment"] = Enum.HorizontalAlignment.Left,
					["VerticalAlignment"] = Enum.VerticalAlignment.Bottom,
					["SortOrder"] = Enum.SortOrder.LayoutOrder,
					["StartCorner"] = Enum.StartCorner.BottomLeft,
					["FillDirectionMaxCells"] = 8
				}) }
		})
		print("ActiveModifierIcons: Created main frame")
		if v_u_6.Signals.ActiveModifiers then
			print("ActiveModifierIcons: Connecting to ActiveModifiers signal")
			v_u_6.Signals.ActiveModifiers:Connect(function(p48)
				-- upvalues: (ref) v_u_16, (ref) v_u_44
				print("ActiveModifierIcons: Signal received, new modifiers:", p48)
				v_u_16:set(p48)
				v_u_44()
			end)
		else
			print("ActiveModifierIcons: WARNING - GameState.Signals.ActiveModifiers not found!")
		end
		print("ActiveModifierIcons: Connecting to RunService.Heartbeat for positioning")
		v_u_2.Heartbeat:Connect(v_u_28)
		print("ActiveModifierIcons: Performing initial updates...")
		v_u_44()
		v_u_28()
		print("ActiveModifierIcons: Initialization complete!")
	end
end
local v_u_50 = false
function v_u_11.Show(_) -- name: Show
	-- upvalues: (ref) v_u_50, (copy) v_u_6, (copy) v_u_49, (ref) v_u_12, (ref) v_u_17, (copy) v_u_11, (copy) v_u_44
	print("ActiveModifierIcons:Show() called, initialized:", v_u_50)
	if not (v_u_50 or v_u_6.Data.IsLobby) then
		print("ActiveModifierIcons: Initializing...")
		v_u_49()
		v_u_50 = true
	end
	if v_u_12 then
		v_u_17 = true
		v_u_11.IsShowing = true
		print("ActiveModifierIcons: Show() - calling updateIcons()")
		v_u_44()
	else
		print("ActiveModifierIcons: Scope is nil, cannot show")
	end
end
function v_u_11.Hide(_) -- name: Hide
	-- upvalues: (ref) v_u_17, (ref) v_u_15, (copy) v_u_11
	print("ActiveModifierIcons:Hide() called")
	v_u_17 = false
	if v_u_15 then
		v_u_15:set(false)
	end
	v_u_11.IsShowing = false
end
return v_u_11