local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = v1.common:WaitForChild("SharedResources")
local v_u_3 = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v_u_4 = script:WaitForChild("Sounds")
local v_u_5 = script:WaitForChild("Attachments")
local v6 = v_u_5:WaitForChild("WeaponStats")
local v7 = v_u_5.Exit
local v_u_8 = v_u_5.ProsCons
local v_u_9 = v_u_8.Pros.List.TextTemplate
v_u_9.Parent = nil
local v_u_10 = v_u_5.PurchaseMod
local v_u_11 = v_u_5:WaitForChild("Nodes")
local v_u_12 = v_u_11:WaitForChild("Template")
v_u_12.Parent = nil
v_u_12.Visible = true
local v_u_13 = v_u_5.Attachments
local v_u_14 = v_u_13.ScrollingFrame
local v_u_15 = v_u_13.Scrollbar
local v_u_16 = v_u_14.Template
v_u_16.Parent = nil
local v17 = v_u_5.Progression
local v_u_18 = v17.LevelLabel
local v_u_19 = v17.XPBarFrame.FillSliceFrame
local v_u_20 = v17.XPBarFrame.LowerXPLabel
local v_u_21 = v_u_19.UpperXPLabel
local _ = script.Parent.WeaponModding
local v_u_22 = workspace.CurrentCamera
local v23 = game.ReplicatedStorage.common
game:GetService("TweenService")
local v_u_24 = game:GetService("RunService")
local v_u_25 = game:GetService("TextService")
local v_u_26 = game.ReplicatedStorage.common:WaitForChild("Remotes"):WaitForChild("DataRemote")
local v27 = game.ReplicatedStorage:FindFirstChild("place")
if v27 then
	v27 = v27:FindFirstChild("RedEvents")
end
local v28 = require(script.Parent:WaitForChild("MiscFunctions"))
local v_u_29 = require(script:WaitForChild("GuiTransparency"))
local v_u_30 = require(v_u_2.Attachments:WaitForChild("AttachmentSystem"))
local v_u_31 = require(v_u_2.Attachments.AttachmentSystem.AttachmentsRoot)
local v_u_32 = require(script:WaitForChild("WeaponStatsUI"))(v6)
local v_u_33 = require(v1.common:WaitForChild("WepConfig"))
local v_u_34 = require(v23.ScrollBar)
local v_u_35 = require(v23.ItemData)
local v_u_36 = require(v23:WaitForChild("LevelInfo"))
local v37 = require(v23.Signal)
local v_u_38 = require(v23:WaitForChild("NPCs_Shared"):WaitForChild("Utils"):WaitForChild("DamageFalloffUtil"))
local v_u_39 = v28.drawLine
local v_u_40 = v28.clickEvent
local v_u_41 = v27 and v27:FindFirstChild("ModificationEvent")
if v_u_41 then
	v_u_41 = require(v27.ModificationEvent)
end
local v_u_42 = nil
local v_u_43 = false
local v_u_44 = {}
local v_u_45 = false
local v_u_46 = nil
local v_u_47 = nil
local v_u_48 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local v_u_49 = {}
local v_u_50 = {}
local v_u_51 = {}
local v_u_52 = {}
local v_u_53 = {}
local v_u_54 = {}
local v_u_55 = nil
local v_u_56 = {}
local v_u_57 = {}
local v_u_58 = {}
local v_u_59 = {}
local v_u_60 = {}
local v_u_61 = nil
local v_u_62 = nil
local v_u_63 = nil
local v_u_64 = nil
local v_u_65 = nil
local v_u_66 = false
local v_u_67 = nil
local v_u_68 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("8f8f8f")), ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHex("98ffa1")) })
local v_u_69 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("8f8f8f")), ColorSequenceKeypoint.new(0.4, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromHex("8fe7ff")) })
local v_u_70 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.53, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new()) })
local v_u_71 = {}
local v72 = v_u_40(v7)
local v_u_73 = v37.new()
v72:Connect(function()
	-- upvalues: (copy) v_u_73
	removePreviewAttachments()
	closePurchaseModPrompt()
	v_u_73:Fire()
end)
v_u_71.ExitPressed = v_u_73
v_u_71.OptionGroupChanged = v37.new()
function v_u_71.init() -- name: init end
function v_u_71.exitMod() -- name: exitMod
	-- upvalues: (copy) v_u_5
	v_u_5.Parent = script
end
function v_u_71.loadGui(p74, p75, p76, p77, p78, p79) -- name: loadGui
	-- upvalues: (ref) v_u_44, (ref) v_u_43, (ref) v_u_45, (ref) v_u_42, (copy) v_u_26, (ref) v_u_62, (copy) v_u_35, (ref) v_u_57, (ref) v_u_58, (ref) v_u_65, (copy) v_u_33, (copy) v_u_32, (copy) v_u_36, (copy) v_u_18, (copy) v_u_19, (copy) v_u_20, (copy) v_u_21, (ref) v_u_49, (copy) v_u_31, (copy) v_u_50, (copy) v_u_51, (copy) v_u_52, (copy) v_u_53, (copy) v_u_54, (ref) v_u_63, (ref) v_u_61, (ref) v_u_56, (copy) v_u_30, (ref) v_u_55, (ref) v_u_46, (ref) v_u_47, (copy) v_u_5, (copy) v_u_3
	v_u_44 = p77 or {}
	v_u_43 = p78 or false
	v_u_45 = false
	if v_u_43 then
		v_u_42 = {
			["Progression"] = {
				["ZBucks"] = 999999,
				["Weapons"] = nil,
				["Weapons"] = {}
			}
		}
	else
		local v80 = false
		local v81 = 0
		while not v80 and v81 < 3 do
			v81 = v81 + 1
			v80 = pcall(function()
				-- upvalues: (ref) v_u_42, (ref) v_u_26
				v_u_42 = v_u_26:InvokeServer("GetData")
			end)
			if not v80 then
				task.wait(0.2)
			end
		end
		if not (v80 and v_u_42) then
			v_u_42 = {
				["Progression"] = {
					["ZBucks"] = 999999,
					["Weapons"] = nil,
					["Weapons"] = {}
				}
			}
			v_u_43 = true
		end
	end
	v_u_62 = p74
	local v82 = v_u_35:GetItemIdFromName(v_u_62)
	v_u_57 = {}
	v_u_58 = {}
	v_u_65 = deepCopy(v_u_33:GetWeaponConfig(p74))
	v_u_32:SetBaseStats(v_u_65)
	v_u_32:UpdateDisplay()
	local v83 = v_u_42.Progression.Weapons[v82]
	local v84, v85
	if v83 then
		v84 = v83[1]
		v85 = v83[2]
	else
		v84 = 0
		v85 = 0
	end
	local v86 = v_u_36:RequiredXp(v84)
	local v87 = ("%d/%d XP"):format(v85, v86)
	v_u_18.Text = "LEVEL " .. v84
	v_u_19.Size = UDim2.new(v85 / v86, 0, 1, 0)
	v_u_20.Text = v87
	v_u_21.Text = v87
	if p76 then
		v_u_49 = p76
	else
		v_u_49 = v_u_31.new(v_u_65)
	end
	for _, v88 in v_u_50 do
		v88:Destroy()
	end
	for _, v89 in v_u_51 do
		v89:Destroy()
	end
	for _, v90 in v_u_52 do
		v90:Destroy()
	end
	table.clear(v_u_50)
	table.clear(v_u_51)
	table.clear(v_u_52)
	table.clear(v_u_53)
	table.clear(v_u_54)
	v_u_63 = nil
	v_u_61 = nil
	v_u_56 = {}
	local v91 = p75:FindFirstChild("GlobalParts")
	if v91 then
		local v92 = v91:FindFirstChild("BasePoints")
		if v92 then
			local v93 = v92:GetChildren()
			for _, v94 in v93 do
				local v95 = v_u_49:GetNodeIDFromName(v94.Name)
				MakeGui(v94, p75, v95, v_u_49, false)
			end
			if #v93 > 0 and p75.Parent then
				local v96 = v_u_54[1]
				v_u_65 = deepCopy(v_u_33:GetWeaponConfig(p75.Name))
				local v97, v98 = v_u_30.DressWeapon(p75.Name, v_u_49, v_u_65.AttachmentNodeData, p75, v96):timeout(10):await()
				if not v97 then
					warn("[WeaponModding] DressWeapon timed out or failed (" .. "loadGui populate" .. "):\n" .. tostring(v98))
				end
				v_u_32:UpdateStats(v_u_65)
				v_u_32:UpdateDisplay()
			end
		end
	end
	for v99 in v_u_44 do
		local v100 = v_u_53[v99]
		if v100 then
			v100.Visible = false
		end
	end
	v_u_55 = p79
	if p79 then
		v_u_46(p75)
		for v101, v102 in p79 do
			v_u_47(v101, v102.members, p75)
		end
	end
	local v103 = v_u_49:GetDisplayName(p74)
	v_u_5.Header.TextLabel.Text = string.upper(v103) .. " ATTACHMENTS"
	setMode("Nodes")
	v_u_5.Parent = v_u_3
end
function v_u_71.getAttached() -- name: getAttached
	-- upvalues: (ref) v_u_49, (copy) v_u_35, (ref) v_u_62
	return v_u_49:Serialize(), v_u_35:GetItemIdFromName(v_u_62)
end
function setMode(p104) -- name: setMode
	-- upvalues: (copy) v_u_32, (copy) v_u_13, (copy) v_u_8, (ref) v_u_45, (copy) v_u_11, (ref) v_u_63, (copy) v_u_5, (ref) v_u_62
	v_u_32:UpdatePlacement(p104)
	v_u_13.Visible = p104 ~= "Nodes"
	local v105 = v_u_8
	local v106
	if p104 == "Nodes" then
		v106 = false
	else
		v106 = not v_u_45
	end
	v105.Visible = v106
	v_u_11.Visible = p104 == "Nodes"
	if p104 == "Attachments" and v_u_63 then
		v_u_5.Header.TextLabel.Text = string.upper(v_u_63.Name)
	else
		v_u_5.Header.TextLabel.Text = string.upper(v_u_62) .. " ATTACHMENTS"
	end
end
function setAttachmentButtonSelected(p107, p108) -- name: setAttachmentButtonSelected
	-- upvalues: (copy) v_u_69, (copy) v_u_68, (copy) v_u_70
	if p108 then
		if p107.Parent.Name == "NONE" or not p107.LockedFrame.Visible then
			p107.UIGradient.Color = v_u_68
		else
			p107.UIGradient.Color = v_u_69
			p107.LockedFrame.LinePattern.TileSize = UDim2.new(0.1, 0, 0.0852, 0)
		end
		if p107.Parent.Name == "NONE" then
			p107.ImageLabel.Position = UDim2.new(0.5, 0, 0.426, 0)
		else
			p107.TextLine1.Position = UDim2.new(0.5, 0, 0.682, 0)
			p107.TextLine2.Position = UDim2.new(0.5, 0, 0.792, 0)
			p107.TextLine1.Size = UDim2.new(0.86, 0, 0.1278, 0)
			p107.TextLine2.Size = UDim2.new(0.86, 0, 0.1278, 0)
			p107.ImageLabel.Position = UDim2.new(0.5, 0, 0.0852, 0)
			p107.LockedFrame.LockLabel.Position = UDim2.new(0.5, 0, 0.0852, 0)
			p107.LockedFrame.LockLabel.Size = UDim2.new(0.17, 0, 0.145, 0)
			p107.LockedFrame.LevelLabel.Position = UDim2.new(0.5, 0, 0.426, 0)
			p107.LockedFrame.PriceLabel.Position = UDim2.new(0.5, 0, 0.6816, 0)
		end
		p107.Size = UDim2.new(0.947, 0, 1, 0)
	else
		if p107.Parent.Name ~= "NONE" and p107.LockedFrame.Visible then
			p107.LockedFrame.LinePattern.TileSize = UDim2.new(0.1, 0, 0.1, 0)
		end
		p107.UIGradient.Color = v_u_70
		if p107.Parent.Name == "NONE" then
			p107.ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		else
			p107.TextLine1.Position = UDim2.new(0.5, 0, 0.8, 0)
			p107.TextLine2.Position = UDim2.new(0.5, 0, 0.93, 0)
			p107.TextLine1.Size = UDim2.new(0.86, 0, 0.15, 0)
			p107.TextLine2.Size = UDim2.new(0.86, 0, 0.15, 0)
			p107.ImageLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
			p107.LockedFrame.LockLabel.Position = UDim2.new(0.5, 0, 0.1, 0)
			p107.LockedFrame.LockLabel.Size = UDim2.new(0.17, 0, 0.17, 0)
			p107.LockedFrame.LevelLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			p107.LockedFrame.PriceLabel.Position = UDim2.new(0.5, 0, 0.8, 0)
		end
		p107.Size = UDim2.new(0.947, 0, 0.852, 0)
	end
	p107.SelectionFrame.Visible = p108
end
function setSelectionFrameAppearance(p109, p110) -- name: setSelectionFrameAppearance
	local v111 = p109:WaitForChild("SelectionFrame")
	local v112 = nil
	local v113 = nil
	if p110 == "equip" then
		v112 = Color3.fromRGB(152, 255, 161)
		v113 = "EQUIP"
	elseif p110 == "unlock" then
		v112 = Color3.fromRGB(143, 231, 255)
		v113 = "UNLOCK"
	end
	v111:WaitForChild("SliceTop"):WaitForChild("Frame").BackgroundColor3 = v112
	v111:WaitForChild("SliceBottom"):WaitForChild("Frame").BackgroundColor3 = v112
	v111:WaitForChild("SliceBottom"):WaitForChild("TextLabel").Text = v113
end
function setProsCons(p114) -- name: setProsCons
	-- upvalues: (copy) v_u_8, (copy) v_u_9
	for _, v115 in pairs({ "Pros", "Cons" }) do
		local v116 = v_u_8[v115].List
		for _, v117 in pairs(v116:GetChildren()) do
			if v117.Name ~= "UIListLayout" then
				v117:Destroy()
			end
		end
		for _, v118 in pairs(p114[v115] or {}) do
			local v119 = v_u_9:Clone()
			v119.Text = (v115 == "Pros" and "<font color=\"#75ff75\">+</font> " or "<font color=\"#ff6363\">-</font>  ") .. v118
			v119.Name = "TEMP"
			v119.Visible = true
			v119.Parent = v116
		end
	end
end
function MakeGui(p_u_120, p_u_121, p_u_122, p_u_123, p124) -- name: MakeGui
	-- upvalues: (ref) v_u_49, (copy) v_u_35, (ref) v_u_62, (copy) v_u_12, (copy) v_u_50, (copy) v_u_14, (copy) v_u_51, (copy) v_u_13, (copy) v_u_15, (copy) v_u_34, (copy) v_u_52, (copy) v_u_53, (ref) v_u_56, (ref) v_u_60, (ref) v_u_65, (copy) v_u_38, (copy) v_u_54, (copy) v_u_4, (ref) v_u_57, (copy) v_u_33, (copy) v_u_30, (copy) v_u_32, (ref) v_u_42, (copy) v_u_5, (ref) v_u_43, (copy) v_u_16, (copy) v_u_25, (copy) v_u_36, (copy) v_u_59, (copy) v_u_40, (ref) v_u_64, (ref) v_u_63, (ref) v_u_61, (copy) v_u_71, (ref) v_u_67, (ref) v_u_58, (copy) v_u_29, (copy) v_u_48, (copy) v_u_24, (copy) v_u_22, (copy) v_u_39, (copy) v_u_11
	local v_u_125 = v_u_49:GetAttachmentNodeData()
	local v_u_126 = v_u_35:GetItemIdFromName(v_u_62)
	local v_u_127 = v_u_12:Clone()
	local v128 = v_u_50
	table.insert(v128, v_u_127)
	v_u_127.Name = p_u_120.Name
	local v129 = v_u_127:WaitForChild("Frame")
	local v130 = v129:WaitForChild("TopLabel")
	local v_u_131 = v129:WaitForChild("BottomLabel")
	local v_u_132 = v129:WaitForChild("ImageLabel")
	local v_u_133 = v129:WaitForChild("Point")
	local v_u_134 = v_u_14:Clone()
	local v135 = v_u_51
	table.insert(v135, v_u_134)
	v_u_134.Parent = v_u_13
	local v136 = v_u_15:Clone()
	local v_u_137 = v_u_34.new(v136, v_u_134, "X")
	local v138 = v_u_52
	table.insert(v138, v_u_137)
	v136.Parent = v_u_13
	v130.Text = p_u_120.Name
	v_u_131.Text = "NONE"
	local v139 = p_u_123:GetNodes()[p_u_122]
	if v139 then
		v139 = v139.ConnectedAttachment
	end
	if v139 then
		local v140 = v139:GetAttachmentIndex()
		local v141 = v_u_125[p_u_122]
		if v141 then
			v141 = v_u_125[p_u_122].PotentialAttachments[v140]
		end
		if v141 then
			v_u_131.Text = string.upper(v141.Alias or v141.Name)
			v_u_132.Image = not v141.Image and "rbxassetid://4923293939" or v141.Image
		end
	end
	v_u_53[p_u_120.Name] = v_u_127
	local v_u_142 = {}
	for _, v143 in v_u_125[v_u_49:GetNodeIDFromName(p_u_120.Name)].PotentialAttachments or {} do
		table.insert(v_u_142, v143)
	end
	v_u_142[0] = {
		["Name"] = "NONE"
	}
	local function v_u_148(p144) -- name: destroyNodePartTree
		-- upvalues: (ref) v_u_56, (copy) v_u_148
		for _, v145 in p144.NodeParts do
			v145:Destroy()
		end
		v_u_56[p144.Object.Parent][p144.Object:GetNodeID()] = nil
		local v146 = v_u_56[p144.Object]
		if v146 then
			for _, v147 in v146 do
				v_u_148(v147)
			end
		end
	end
	local function v_u_170(p149, p150, p151, p152) -- name: AttachAttachment
		-- upvalues: (copy) p_u_122, (copy) p_u_123, (copy) v_u_125, (ref) v_u_131, (ref) v_u_132, (ref) v_u_60, (ref) v_u_56, (copy) v_u_148, (copy) p_u_120, (copy) p_u_121, (ref) v_u_65, (ref) v_u_38
		p149:GetAttachmentNodeData()
		local v153 = p149:GetNodeID()
		if v153 == p_u_122 and p149.Parent == p_u_123 then
			local v154 = p149:GetAttachmentIndex()
			local v155 = v_u_125[v153].PotentialAttachments[v154]
			local v156 = string.upper(v155.Alias or v155.Name)
			local v157 = not v155.Image and "rbxassetid://4923293939" or v155.Image
			v_u_131.Text = v156
			v_u_132.Image = v157
		end
		v_u_60 = p152
		local v158 = v_u_56[p149.Parent]
		if v158 then
			local v159 = v158[p149:GetNodeID()]
			if v159 and v159.Object ~= p149 then
				v_u_148(v159)
			end
		else
			v158 = {}
			v_u_56[p149.Parent] = v158
		end
		if p150 then
			local v160 = p150:FindFirstChild("NodeParts")
			if v160 then
				local v161 = v158[p149:GetNodeID()]
				if not v161 then
					v161 = {
						["Object"] = p149,
						["NodeParts"] = {}
					}
					v158[p149:GetNodeID()] = v161
				end
				for _, v162 in v160:GetChildren() do
					if not v161.NodeParts[v162.Name] then
						local v163 = p_u_120
						local v164 = Instance.new("Weld")
						v164.Name = "ExpansionWeld"
						v164.Part0 = v163
						v164.Part1 = v162
						v164.C0 = CFrame.new()
						v164.C1 = v162.CFrame:toObjectSpace(v163.CFrame)
						v164.Parent = v162
						v162.Parent = p_u_121.KeyParts
						v162.Name = v162:GetAttribute("NodeName") or v162.Name
						v161.NodeParts[v162.Name] = v162
						local v165 = p149:GetNodeIDFromName(v162.Name)
						MakeGui(v162, p_u_121, v165, p149, false)
					end
				end
			end
		end
		local v166
		if p151 then
			local v167 = {
				["Model"] = p_u_121
			}
			v166 = require(p151).new(p150, v_u_65, v167)
			if v166.SettingChanges then
				for v168, v169 in v166.SettingChanges do
					if v168 == "Damage" and (v_u_65.DamageDropoff and not v166.SettingChanges.DamageDropoff) then
						v_u_65.DamageDropoff = v_u_38.RescaleDropoff(v_u_65.DamageDropoff, v_u_65.Damage, v169)
					end
					v_u_65[v168] = v169
				end
			end
		else
			v166 = nil
		end
		return v166
	end
	local v171 = v_u_54
	table.insert(v171, v_u_170)
	local function v_u_184(p172, p173, p174) -- name: selectAttachment
		-- upvalues: (ref) v_u_4, (ref) v_u_57, (copy) p_u_123, (copy) p_u_122, (copy) v_u_142, (copy) v_u_184, (ref) v_u_56, (copy) v_u_148, (ref) v_u_65, (ref) v_u_33, (copy) p_u_121, (ref) v_u_30, (ref) v_u_49, (copy) v_u_170, (ref) v_u_32, (ref) v_u_131, (ref) v_u_132
		local v175 = string.upper(p173.Alias or p173.Name)
		v_u_4.Att:GetChildren()[math.random(1, 3)]:Play()
		if p174 then
			local v176 = v_u_57[p_u_123]
			if not v176 then
				v176 = {}
				v_u_57[p_u_123] = v176
			end
			if not v176[p_u_122] then
				local v177 = p_u_123:GetNodes()[p_u_122]
				local v178 = not (v177 and v177.ConnectedAttachment) and 0 or v177.ConnectedAttachment:GetAttachmentIndex()
				v176[p_u_122] = {
					["OriginalAttachmentIndex"] = v178,
					["OriginalProperties"] = v_u_142[v178],
					["SelectFunction"] = v_u_184
				}
			end
		else
			local v179 = v_u_57[p_u_123]
			if v179 then
				v179[p_u_122] = nil
			end
		end
		p_u_123:SetNodeAttachment(p_u_122, p172)
		if not p_u_123:GetNodes()[p_u_122].ConnectedAttachment then
			local v180 = v_u_56[p_u_123]
			if v180 and v180[p_u_122] then
				v_u_148(v180[p_u_122])
			end
		end
		v_u_65 = deepCopy(v_u_33:GetWeaponConfig(p_u_121.Name))
		if p_u_121.Parent then
			p_u_121.Attachments:ClearAllChildren()
			local v181, v182 = v_u_30.DressWeapon(p_u_121.Name, v_u_49, v_u_65.AttachmentNodeData, p_u_121, v_u_170):timeout(10):await()
			if not v181 then
				warn("[WeaponModding] DressWeapon timed out or failed (" .. "selectAttachment" .. "):\n" .. tostring(v182))
			end
			v_u_32:UpdateStats(v_u_65)
			v_u_32:UpdateDisplay()
			local v183 = not p173.Image and "rbxassetid://4923293939" or p173.Image
			v_u_131.Text = v175
			v_u_132.Image = v183
		end
	end
	local v185 = v_u_42.Progression.Weapons[v_u_126]
	local v186 = not v185 and {} or deserializeUnlockedAttachments(v185[3])
	local v187 = v_u_5.AbsoluteSize
	local v_u_188 = {}
	for v_u_189, v_u_190 in v_u_142 do
		local v191 = v_u_190.UnlockLevel or 999
		local v_u_192 = string.upper(v_u_190.Alias or v_u_190.Name)
		local v193 = false
		local v_u_194 = nil
		local v195, v_u_196
		if v_u_192 == "NONE" then
			v195 = v_u_134:WaitForChild("NONE")
			v_u_196 = true
		elseif v_u_43 then
			v195 = v_u_16:Clone()
			v195.LayoutOrder = v191
			v_u_196 = true
		else
			v_u_196 = table.find(v186, v_u_190.ID) and true or v193
			v195 = v_u_16:Clone()
			v195.LayoutOrder = v191
		end
		local v_u_197 = v195:WaitForChild("ImageButton")
		if v_u_192 ~= "NONE" then
			local v198 = v_u_197:WaitForChild("ImageLabel")
			if v_u_190.Image then
				v198.Image = v_u_190.Image
				v198:WaitForChild("DropShadow").Image = v_u_190.Image
			end
			local v199 = v_u_197:WaitForChild("TextLine1")
			local v200 = v_u_197:WaitForChild("TextLine2")
			local v201 = v187.Y * v_u_13.Size.Y.Scale
			local v202 = v201 * v_u_16.Size.X.Scale * v_u_197.Size.X.Scale
			local v203 = v201 * v_u_16.Size.Y.Scale * v_u_197.Size.Y.Scale
			local v204 = v202 * v199.Size.X.Scale
			local v205 = math.floor(v204)
			local v206 = v203 * v199.Size.Y.Scale
			local v207 = math.floor(v206)
			local v208 = string.split(trim(v_u_192), " ")
			if #v208 > 1 and v205 < v_u_25:GetTextSize(v_u_192, v207, v199.Font, Vector2.new((1 / 0), v207)).X then
				local v209 = table.clone(v208)
				local v210 = #v208
				while v205 < v_u_25:GetTextSize(wordsToSentence(v209), v207, v199.Font, Vector2.new((1 / 0), v207)).X and v210 ~= 1 do
					table.remove(v209, v210)
					v210 = v210 - 1
				end
				for _ = 1, v210 do
					table.remove(v208, 1)
				end
				v199.Text = wordsToSentence(v209)
				v200.Text = wordsToSentence(v208)
			else
				v199.Text = ""
				v200.Text = v_u_192
			end
			if v_u_196 then
				setSelectionFrameAppearance(v_u_197, "equip")
			else
				v_u_197:WaitForChild("LockedFrame").Visible = true
				local v211 = not v185 and 0 or v185[1]
				if v_u_190.FixedPrice then
					v_u_194 = v_u_190.FixedPrice
				else
					v_u_194 = v_u_36:AttachmentUnlockCost(v211, v191)
				end
				local v212 = v_u_197.LockedFrame:WaitForChild("LevelLabel")
				local v_u_213 = v_u_197.LockedFrame:WaitForChild("PriceLabel")
				if v_u_190.PurchaseOnly then
					v212.Text = "LEVEL N/A"
				else
					v212.Text = "LEVEL " .. v191
				end
				if v211 < v191 then
					v212.TextColor3 = Color3.fromRGB(255, 92, 92)
				else
					v212.TextColor3 = Color3.new(1, 1, 1)
				end
				if v_u_194 == 0 then
					v_u_213.Text = "FREE"
				else
					v_u_213.Text = v_u_194 .. " Z$"
				end
				local function v_u_214() -- name: updatePriceColor
					-- upvalues: (ref) v_u_194, (ref) v_u_42, (copy) v_u_213, (copy) v_u_197
					if v_u_194 > v_u_42.Progression.ZBucks then
						v_u_213.TextColor3 = Color3.fromRGB(255, 92, 92)
					else
						v_u_197.LockedFrame.PriceLabel.TextColor3 = Color3.new(1, 1, 1)
					end
				end
				v_u_59[v_u_214] = true
				v_u_197.Destroying:Connect(function()
					-- upvalues: (ref) v_u_59, (copy) v_u_214
					v_u_59[v_u_214] = nil
				end)
				setSelectionFrameAppearance(v_u_197, "unlock")
			end
		end
		v195.Visible = true
		v195.Name = v_u_190.Name
		v195.Parent = v_u_134
		local v215, v216, v217 = v_u_40(v_u_197)
		v_u_188[#v_u_188 + 1] = v215:Connect(function()
			-- upvalues: (ref) v_u_64, (copy) v_u_197, (ref) v_u_196, (ref) v_u_4, (ref) v_u_63, (ref) v_u_61, (ref) v_u_71, (ref) v_u_194, (ref) v_u_42, (ref) v_u_67, (copy) v_u_190, (copy) v_u_126, (copy) v_u_192, (copy) v_u_184, (copy) v_u_189
			if v_u_64 == v_u_197 then
				if v_u_196 then
					setMode("Nodes")
					v_u_4.close:Play()
					v_u_63 = nil
					v_u_61 = nil
					v_u_71.HoveringOver = nil
					closePurchaseModPrompt()
					return
				end
				if v_u_194 and v_u_194 <= v_u_42.Progression.ZBucks then
					if v_u_67 and v_u_67.ModID == v_u_190.ID then
						closePurchaseModPrompt()
					else
						openPurchaseModPrompt(v_u_126, v_u_190.ID, v_u_192, v_u_194)
					end
				end
			else
				if v_u_64 then
					setAttachmentButtonSelected(v_u_64, false)
				end
				v_u_64 = v_u_197
				setAttachmentButtonSelected(v_u_197, true)
				setProsCons(v_u_190)
				v_u_184(v_u_189, v_u_190, not v_u_196)
			end
		end)
		v_u_188[#v_u_188 + 1] = v216:Connect(function()
			-- upvalues: (ref) v_u_61, (copy) v_u_190
			v_u_61 = v_u_190
		end)
		v_u_188[#v_u_188 + 1] = v217:Connect(function()
			-- upvalues: (ref) v_u_61, (copy) v_u_190, (copy) p_u_123, (copy) p_u_122
			if v_u_61 == v_u_190 then
				local v218 = p_u_123:GetNodes()[p_u_122]
				if v218 and (v218.ConnectedAttachment and v218.ConnectedAttachment:GetAttachmentIndex() ~= 0) then
					v_u_61 = v218.ConnectedAttachment:GetAttachmentData()
				end
			end
		end)
		if v_u_192 ~= "NONE" then
			local function v219() -- name: unlockMod
				-- upvalues: (ref) v_u_196, (copy) v_u_197, (ref) v_u_64, (copy) v_u_184, (copy) v_u_189, (copy) v_u_190
				if not v_u_196 then
					v_u_196 = true
					v_u_197:WaitForChild("LockedFrame").Visible = false
					setSelectionFrameAppearance(v_u_197, "equip")
					if v_u_64 == v_u_197 then
						setAttachmentButtonSelected(v_u_197, true)
						v_u_184(v_u_189, v_u_190, false)
					end
				end
			end
			if not v_u_58[v_u_190.ID] then
				v_u_58[v_u_190.ID] = {}
			end
			v_u_58[v_u_190.ID][v_u_197] = v219
			v_u_197.Destroying:Connect(function()
				-- upvalues: (ref) v_u_58, (copy) v_u_190, (copy) v_u_197
				v_u_58[v_u_190.ID][v_u_197] = nil
			end)
		end
	end
	local function v220() -- name: updateCanvasSize
		-- upvalues: (ref) v_u_134, (ref) v_u_5
		v_u_134.CanvasSize = UDim2.new(0, v_u_134.UIListLayout.AbsoluteContentSize.X - v_u_5.AbsoluteSize.Y * 0.01, 0, 0)
	end
	v_u_134:WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v220)
	v_u_134.CanvasSize = UDim2.new(0, v_u_134.UIListLayout.AbsoluteContentSize.X - v_u_5.AbsoluteSize.Y * 0.01, 0, 0)
	if p124 then
		v_u_65 = deepCopy(v_u_33:GetWeaponConfig(p_u_121.Name))
		local v221, v222 = v_u_30.DressWeapon(p_u_121.Name, v_u_49, v_u_65.AttachmentNodeData, p_u_121, v_u_170):timeout(10):await()
		if not v221 then
			warn("[WeaponModding] DressWeapon timed out or failed (" .. "MakeGui runDress" .. "):\n" .. tostring(v222))
		end
		v_u_32:UpdateStats(v_u_65)
		v_u_32:UpdateDisplay()
	end
	local v_u_223 = nil
	local v_u_224 = nil
	local v_u_225 = nil
	local v_u_226 = nil
	local v_u_227 = script.Square:Clone()
	v_u_227.Parent = v_u_5
	v_u_29:SetTransparency(v_u_227, 1, v_u_48)
	v_u_188[#v_u_188 + 1] = v_u_24.RenderStepped:Connect(function()
		-- upvalues: (copy) p_u_120, (ref) v_u_22, (ref) v_u_223, (ref) v_u_39, (ref) v_u_133, (ref) v_u_5, (copy) v_u_227, (ref) v_u_226, (ref) v_u_29, (ref) v_u_71, (ref) v_u_127, (ref) v_u_224, (ref) v_u_225, (ref) v_u_48, (ref) v_u_63, (copy) p_u_123, (copy) p_u_122, (ref) v_u_60
		local v228, _ = v_u_22:WorldToScreenPoint(p_u_120.Position)
		v_u_223 = v_u_39(v_u_133.AbsolutePosition, Vector2.new(v228.X, v228.Y), v_u_5, v_u_223)
		v_u_227.Position = UDim2.new(0, v228.X, 0, v228.Y)
		if not v_u_226 then
			v_u_226 = true
			v_u_29:SetTransparency(v_u_223, 1, TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
			v_u_223.BackgroundTransparency = 1
		end
		if v_u_71.HoveringOver == v_u_127 or v_u_224 then
			if v_u_224 and (not v_u_225 and v_u_71.HoveringOver == v_u_127) then
				v_u_224 = false
				v_u_225 = true
				v_u_29:Revert(v_u_227, v_u_48)
				v_u_29:Revert(v_u_223, v_u_48)
			end
		else
			v_u_224 = true
			v_u_225 = false
			v_u_29:SetTransparency(v_u_223, 1, v_u_48)
			v_u_29:SetTransparency(v_u_227, 1, v_u_48)
		end
		if v_u_63 ~= nil and v_u_63 == v_u_127 then
			v_u_223.BackgroundTransparency = 1
		end
		local v229 = p_u_123:GetNodes()[p_u_122]
		local v230
		if v229 then
			v230 = v229.ConnectedAttachment
		else
			v230 = nil
		end
		if v_u_71.HoveringOver == v_u_127 then
			if v_u_60[v230] then
				v_u_60[v230].Enabled = true
				return
			end
		elseif v_u_60[v230] then
			v_u_60[v230].Enabled = false
		end
	end)
	local v231, v232, v233 = v_u_40(v_u_127)
	v_u_188[#v_u_188 + 1] = v231:Connect(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_51, (ref) v_u_52, (copy) p_u_123, (copy) p_u_120, (ref) v_u_134, (ref) v_u_63, (ref) v_u_127, (ref) v_u_137, (ref) v_u_64, (ref) v_u_71, (ref) v_u_61
		v_u_4.click:Play()
		for _, v234 in v_u_51 do
			v234.Visible = false
		end
		for _, v235 in v_u_52 do
			v235:SetVisible(false)
		end
		local v236 = p_u_123:GetAttachmentFromNodeName(p_u_120.Name)
		local v237 = (not v236 or v236:GetAttachmentIndex() == 0) and {
			["Name"] = "NONE"
		} or v236:GetAttachmentData()
		v_u_134.Visible = v_u_63 ~= v_u_127
		v_u_137:SetVisible(v_u_134.Visible)
		local v238 = v_u_134:FindFirstChild(v237.Name)
		if v238 then
			v_u_64 = v238.ImageButton
			setAttachmentButtonSelected(v_u_64, true)
		end
		if v_u_134.Visible then
			v_u_71.HoveringOver = v_u_127
			v_u_4.open:Play()
			v_u_63 = v_u_127
			v_u_61 = v237
		else
			v_u_4.close:Play()
			v_u_63 = nil
			v_u_61 = nil
		end
		setMode(v_u_134.Visible and "Attachments" or "Nodes")
	end)
	v_u_188[#v_u_188 + 1] = v232:Connect(function()
		-- upvalues: (ref) v_u_63, (ref) v_u_71, (ref) v_u_127
		if not v_u_63 then
			v_u_71.HoveringOver = v_u_127
		end
	end)
	v_u_188[#v_u_188 + 1] = v233:Connect(function()
		-- upvalues: (ref) v_u_63, (ref) v_u_71, (ref) v_u_127
		if not v_u_63 then
			if v_u_71.HoveringOver == v_u_127 then
				v_u_71.HoveringOver = nil
			end
		end
	end)
	v_u_127.Parent = v_u_11
	v_u_11.CanvasSize = UDim2.new(0, 0, 0, v_u_11.UIListLayout.AbsoluteContentSize.Y)
	local function v_u_240() -- name: CleanUp
		-- upvalues: (ref) v_u_127, (ref) v_u_134, (ref) v_u_223, (copy) v_u_227, (copy) v_u_188
		if v_u_127 then
			v_u_127:Destroy()
		end
		if v_u_134 then
			v_u_134:Destroy()
		end
		if v_u_223 then
			v_u_223:Destroy()
		end
		if v_u_227 then
			v_u_227:Destroy()
		end
		for _, v239 in pairs(v_u_188) do
			v239:Disconnect()
		end
		table.clear(v_u_188)
	end
	v_u_188[#v_u_188 + 1] = p_u_121.Destroying:Connect(function()
		-- upvalues: (copy) v_u_240
		v_u_240()
	end)
	v_u_188[#v_u_188 + 1] = p_u_120.Destroying:Connect(function()
		-- upvalues: (copy) v_u_240
		v_u_240()
	end)
	local v241 = p_u_120:FindFirstChild("ExpansionWeld")
	if v241 then
		v_u_188[#v_u_188 + 1] = v241.Part0.Destroying:Connect(function()
			-- upvalues: (copy) v_u_240, (copy) p_u_120
			v_u_240()
			p_u_120:Destroy()
		end)
		v_u_188[#v_u_188 + 1] = v241.Part1.Destroying:Connect(function()
			-- upvalues: (copy) v_u_240
			v_u_240()
		end)
		v_u_188[#v_u_188 + 1] = v241.Destroying:Connect(function()
			-- upvalues: (copy) v_u_240, (copy) p_u_120
			v_u_240()
			p_u_120:Destroy()
		end)
	end
end
local v_u_242 = {}
v_u_46 = function(p243)
	-- upvalues: (ref) v_u_242
	v_u_242 = {}
	local v244 = p243:FindFirstChild("GlobalParts")
	if v244 then
		v244 = v244:FindFirstChild("BasePoints")
	end
	local v245 = p243:FindFirstChild("Weapon")
	local v246 = p243:FindFirstChild("Handle") or p243.PrimaryPart
	if v244 and (v245 and v246) then
		local v247 = {}
		for _, v248 in v245:GetChildren() do
			if v248:IsA("Model") then
				local v249 = v248:FindFirstChildWhichIsA("BasePart", true)
				if not (v249 and v249:GetAttribute("OptionGroupHidden")) then
					for v250, v251 in v248:GetAttributes() do
						if string.sub(v250, 1, 13) == "NodeOverride_" then
							local v252 = string.sub(v250, 14)
							local v253 = string.split(tostring(v251), ",")
							if #v253 == 3 then
								local v254 = v253[1]
								local v255 = tonumber(v254) or 0
								local v256 = v253[2]
								local v257 = tonumber(v256) or 0
								local v258 = v253[3]
								local v259 = tonumber(v258) or 0
								v247[v252] = Vector3.new(v255, v257, v259)
							end
						end
					end
				end
			end
		end
		for _, v260 in v244:GetChildren() do
			if v260:IsA("BasePart") then
				local v261 = v246.CFrame:ToObjectSpace(v260.CFrame)
				local v262 = v247[v260.Name]
				if v262 then
					v_u_242[v260.Name] = CFrame.new(v261.Position - v262) * v261.Rotation
				else
					v_u_242[v260.Name] = v261
				end
			end
		end
	end
end
local function v_u_297(p263)
	-- upvalues: (ref) v_u_242
	if next(v_u_242) then
		local v264 = p263:FindFirstChild("GlobalParts")
		if v264 then
			v264 = v264:FindFirstChild("BasePoints")
		end
		local v265 = p263:FindFirstChild("Weapon")
		local v266 = p263:FindFirstChild("Handle") or p263.PrimaryPart
		if v264 and (v265 and v266) then
			local v_u_267 = p263:FindFirstChild("KeyParts")
			local v268 = {}
			local function v275(p269, p270) -- name: moveBasePoint
				-- upvalues: (copy) v_u_267
				local v271 = nil
				for _, v272 in p269:GetJoints() do
					if v272:IsA("JointInstance") and v_u_267 then
						local v273
						if v272.Part0 == p269 then
							v273 = v272.Part1
						elseif v272.Part1 == p269 then
							v273 = v272.Part0
						else
							v273 = nil
						end
						if v273 and v273:IsDescendantOf(v_u_267) then
							v272:Destroy()
							v271 = v273
							break
						end
					end
				end
				p269.CFrame = p270
				if v271 then
					local v274 = Instance.new("Weld")
					v274.Part0 = v271
					v274.Part1 = p269
					v274.C0 = CFrame.new()
					v274.C1 = p269.CFrame:toObjectSpace(v271.CFrame)
					v274.Parent = v271
				end
			end
			for _, v276 in v265:GetChildren() do
				if v276:IsA("Model") then
					local v277 = v276:FindFirstChildWhichIsA("BasePart", true)
					if not (v277 and v277:GetAttribute("OptionGroupHidden")) then
						for v278, v279 in v276:GetAttributes() do
							if string.sub(v278, 1, 13) == "NodeOverride_" then
								local v280 = string.sub(v278, 14)
								local v281 = string.split(tostring(v279), ",")
								if #v281 == 3 then
									local v282 = v281[1]
									local v283 = tonumber(v282) or 0
									local v284 = v281[2]
									local v285 = tonumber(v284) or 0
									local v286 = v281[3]
									local v287 = tonumber(v286) or 0
									v268[v280] = Vector3.new(v283, v285, v287)
								end
							end
						end
					end
				end
			end
			for v288, v292 in v_u_242 do
				local v290 = v264:FindFirstChild(v288)
				if v290 and v290:IsA("BasePart") then
					local v291 = v268[v288]
					if v291 then
						local v292 = CFrame.new(v292.Position + v291) * v292.Rotation
						print("[NodeOverride] Override for node:", v288, "offset:", v291)
					end
					v275(v290, v266.CFrame * v292)
					if v291 then
						for _, v293 in v290:GetJoints() do
							if v293:IsA("JointInstance") then
								local v294
								if v293.Part0 == v290 then
									v294 = v293.Part1
								elseif v293.Part1 == v290 then
									v294 = v293.Part0
								else
									v294 = nil
								end
								if v294 and not (v_u_267 and v294:IsDescendantOf(v_u_267)) then
									local v295 = v294:FindFirstAncestorOfClass("Model")
									if v295 and v295.PrimaryPart then
										print("[NodeOverride] Re-welding attachment:", v295.Name, "to node:", v288)
										v293:Destroy()
										v295:PivotTo(v290.CFrame)
										local v296 = Instance.new("Weld")
										v296.Part0 = v295.PrimaryPart
										v296.Part1 = v290
										v296.Parent = v295
									end
								end
							end
						end
					end
				end
			end
		end
	else
		return
	end
end
local function v_u_313(p298, p299)
	-- upvalues: (ref) v_u_44, (copy) v_u_53, (ref) v_u_63, (ref) v_u_49, (ref) v_u_65, (copy) v_u_33, (copy) v_u_30, (copy) v_u_54, (copy) v_u_32
	local v300 = v_u_44
	v_u_44 = p298
	for v301 in v300 do
		if not p298[v301] then
			local v302 = v_u_53[v301]
			if v302 then
				v302.Visible = true
			end
		end
	end
	local v303 = false
	for v304 in p298 do
		if not v300[v304] then
			local v305 = v_u_53[v304]
			if v305 then
				v305.Visible = false
				if v_u_63 == v305 then
					v_u_63 = nil
					setMode("Nodes")
				end
			end
			local v306 = v_u_49:GetNodeIDFromName(v304)
			if v306 then
				local v307 = v_u_49:GetNodes()[v306]
				if v307 and v307.ConnectedAttachment then
					v_u_49:SetNodeAttachment(v306, 0)
					v303 = true
					if v305 then
						local v308 = v305:FindFirstChild("Frame")
						if v308 then
							v308 = v305.Frame:FindFirstChild("BottomLabel")
						end
						if v308 then
							v308.Text = "NONE"
						end
						local v309 = v305:FindFirstChild("Frame")
						if v309 then
							v309 = v305.Frame:FindFirstChild("ImageLabel")
						end
						if v309 then
							v309.Image = ""
						end
					end
				end
			end
		end
	end
	if v303 and (p299 and p299.Parent) then
		v_u_65 = deepCopy(v_u_33:GetWeaponConfig(p299.Name))
		p299.Attachments:ClearAllChildren()
		local v311, v312 = v_u_30.DressWeapon(p299.Name, v_u_49, v_u_65.AttachmentNodeData, p299, function(...)
			-- upvalues: (ref) v_u_54
			for _, v310 in v_u_54 do
				v310(...)
			end
		end):timeout(10):await()
		if not v311 then
			warn("[WeaponModding] DressWeapon timed out or failed (" .. "needsRedress" .. "):\n" .. tostring(v312))
		end
		v_u_32:UpdateStats(v_u_65)
		v_u_32:UpdateDisplay()
	end
end
v_u_47 = function(p_u_314, p_u_315, p_u_316)
	-- upvalues: (copy) v_u_12, (copy) v_u_50, (copy) v_u_2, (copy) v_u_5, (copy) v_u_29, (copy) v_u_48, (copy) v_u_14, (copy) v_u_51, (copy) v_u_13, (copy) v_u_15, (copy) v_u_34, (copy) v_u_52, (copy) v_u_16, (copy) v_u_40, (ref) v_u_64, (copy) v_u_4, (ref) v_u_63, (ref) v_u_45, (ref) v_u_297, (copy) v_u_71, (ref) v_u_55, (ref) v_u_313, (copy) v_u_24, (copy) v_u_22, (copy) v_u_39, (copy) v_u_11
	local v_u_317 = v_u_12:Clone()
	local v318 = v_u_50
	table.insert(v318, v_u_317)
	v_u_317.Name = p_u_314
	v_u_317.LayoutOrder = 1000
	local v319 = v_u_317:WaitForChild("Frame")
	local v320 = v319:WaitForChild("TopLabel")
	local v_u_321 = v319:WaitForChild("BottomLabel")
	local v322 = v319:WaitForChild("ImageLabel")
	local v_u_323 = v319:WaitForChild("Point")
	local v324 = nil
	for _, v325 in p_u_315 do
		if v325.isActive then
			v324 = v325.name
			break
		end
	end
	if not v324 and #p_u_315 > 0 then
		v324 = p_u_315[1].name
		p_u_315[1].isActive = true
	end
	v320.Text = p_u_314
	v_u_321.Text = not v324 and "" or string.upper(v324)
	v322.Image = ""
	local function v_u_329(p326) -- name: findMemberModel
		-- upvalues: (copy) p_u_316, (copy) p_u_314
		local v327 = p_u_316:FindFirstChild("Weapon")
		if not v327 then
			return nil
		end
		for _, v328 in v327:GetChildren() do
			if v328:IsA("Model") and (v328:GetAttribute("OptionGroup") == p_u_314 and v328.Name == p326) then
				return v328
			end
		end
		return nil
	end
	local v_u_330
	if v324 then
		v_u_330 = v_u_329(v324)
	else
		v_u_330 = nil
	end
	local v_u_331 = v_u_2.Attachments.AttachmentSystem.Highlight:Clone()
	v_u_331.Enabled = false
	if v_u_330 then
		v_u_331.Adornee = v_u_330
	end
	v_u_331.Parent = p_u_316
	local v_u_332 = nil
	local v_u_333 = nil
	local v_u_334 = nil
	local v_u_335 = nil
	local v_u_336 = script.Square:Clone()
	v_u_336.Parent = v_u_5
	v_u_29:SetTransparency(v_u_336, 1, v_u_48)
	local v_u_337 = v_u_14:Clone()
	local v338 = v_u_51
	table.insert(v338, v_u_337)
	local v339 = v_u_337:FindFirstChild("NONE")
	if v339 then
		v339:Destroy()
	end
	v_u_337.Parent = v_u_13
	local v340 = v_u_15:Clone()
	local v_u_341 = v_u_34.new(v340, v_u_337, "X")
	local v342 = v_u_52
	table.insert(v342, v_u_341)
	v340.Parent = v_u_13
	local v_u_343 = {}
	for v344, v_u_345 in p_u_315 do
		local v346 = v_u_16:Clone()
		v346.LayoutOrder = v344
		v346.Visible = true
		v346.Name = v_u_345.name
		local v_u_347 = v346:WaitForChild("ImageButton")
		local v348 = v_u_347:WaitForChild("TextLine1")
		local v349 = v_u_347:WaitForChild("TextLine2")
		local v350 = v_u_347:WaitForChild("ImageLabel")
		v348.Text = ""
		v349.Text = string.upper(v_u_345.name)
		v350.Visible = false
		v_u_347:WaitForChild("LockedFrame").Visible = false
		setSelectionFrameAppearance(v_u_347, "equip")
		v346.Parent = v_u_337
		local v351 = v_u_40(v_u_347)
		v_u_343[#v_u_343 + 1] = v351:Connect(function()
			-- upvalues: (ref) v_u_64, (copy) v_u_347, (ref) v_u_4, (ref) v_u_63, (ref) v_u_45, (copy) p_u_316, (copy) p_u_314, (copy) v_u_345, (ref) v_u_297, (copy) v_u_321, (ref) v_u_330, (copy) v_u_329, (copy) v_u_331, (copy) p_u_315, (ref) v_u_71, (ref) v_u_55, (ref) v_u_313
			if v_u_64 == v_u_347 then
				setMode("Nodes")
				v_u_4.close:Play()
				v_u_63 = nil
				v_u_45 = false
			else
				if v_u_64 then
					setAttachmentButtonSelected(v_u_64, false)
				end
				v_u_64 = v_u_347
				setAttachmentButtonSelected(v_u_347, true)
				v_u_4.Att:GetChildren()[math.random(1, 3)]:Play()
				local v352 = p_u_316:FindFirstChild("Weapon")
				if v352 then
					for _, v353 in v352:GetChildren() do
						if v353:IsA("Model") and v353:GetAttribute("OptionGroup") == p_u_314 then
							local v354 = v353.Name == v_u_345.name
							for _, v355 in v353:GetDescendants() do
								if v355:IsA("BasePart") or (v355:IsA("Decal") or v355:IsA("Texture")) then
									if v354 then
										v355:SetAttribute("OptionGroupHidden", nil)
										local v356 = v355:GetAttribute("OrigTransparency")
										v355.Transparency = v356 == nil and 0 or v356
									elseif not v355:GetAttribute("OptionGroupHidden") then
										v355:SetAttribute("OptionGroupHidden", true)
										if v355:GetAttribute("OrigTransparency") == nil then
											v355:SetAttribute("OrigTransparency", v355.Transparency)
										end
										v355.Transparency = 1
									end
								elseif v355:IsA("Beam") or v355:IsA("ParticleEmitter") then
									if v354 then
										v355:SetAttribute("OptionGroupHidden", nil)
										local v357 = v355:GetAttribute("OrigEnabled")
										v355.Enabled = v357 == nil and true or v357
									elseif not v355:GetAttribute("OptionGroupHidden") then
										v355:SetAttribute("OptionGroupHidden", true)
										v355:SetAttribute("OrigEnabled", v355.Enabled)
										v355.Enabled = false
									end
								end
							end
						end
					end
				end
				v_u_297(p_u_316)
				v_u_321.Text = string.upper(v_u_345.name)
				v_u_330 = v_u_329(v_u_345.name)
				v_u_331.Adornee = v_u_330
				for _, v358 in p_u_315 do
					v358.isActive = v358.id == v_u_345.id
				end
				v_u_71.OptionGroupChanged:Fire(p_u_314, v_u_345.id, v_u_345.name)
				if v_u_55 then
					local v359 = {}
					for _, v360 in v_u_55 do
						for _, v361 in v360.members do
							if v361.isActive and v361.lockedNodes then
								for _, v362 in v361.lockedNodes do
									v359[v362] = true
								end
							end
						end
					end
					v_u_313(v359, p_u_316)
				end
			end
		end)
	end
	local function v363() -- name: updateCanvasSize
		-- upvalues: (copy) v_u_337, (ref) v_u_5
		v_u_337.CanvasSize = UDim2.new(0, v_u_337.UIListLayout.AbsoluteContentSize.X - v_u_5.AbsoluteSize.Y * 0.01, 0, 0)
	end
	v_u_337:WaitForChild("UIListLayout"):GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v363)
	v_u_337.CanvasSize = UDim2.new(0, v_u_337.UIListLayout.AbsoluteContentSize.X - v_u_5.AbsoluteSize.Y * 0.01, 0, 0)
	v_u_343[#v_u_343 + 1] = v_u_24.RenderStepped:Connect(function()
		-- upvalues: (ref) v_u_330, (ref) v_u_22, (ref) v_u_332, (ref) v_u_39, (copy) v_u_323, (ref) v_u_5, (copy) v_u_336, (ref) v_u_335, (ref) v_u_29, (ref) v_u_71, (copy) v_u_317, (ref) v_u_333, (ref) v_u_334, (ref) v_u_48, (ref) v_u_63, (copy) v_u_331
		if v_u_330 then
			local v364, _ = v_u_330:GetBoundingBox()
			local v365, _ = v_u_22:WorldToScreenPoint(v364.Position)
			v_u_332 = v_u_39(v_u_323.AbsolutePosition, Vector2.new(v365.X, v365.Y), v_u_5, v_u_332)
			v_u_336.Position = UDim2.new(0, v365.X, 0, v365.Y)
			if not v_u_335 then
				v_u_335 = true
				v_u_29:SetTransparency(v_u_332, 1, TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
				v_u_332.BackgroundTransparency = 1
			end
			if v_u_71.HoveringOver == v_u_317 or v_u_333 then
				if v_u_333 and (not v_u_334 and v_u_71.HoveringOver == v_u_317) then
					v_u_333 = false
					v_u_334 = true
					v_u_29:Revert(v_u_336, v_u_48)
					v_u_29:Revert(v_u_332, v_u_48)
				end
			else
				v_u_333 = true
				v_u_334 = false
				v_u_29:SetTransparency(v_u_332, 1, v_u_48)
				v_u_29:SetTransparency(v_u_336, 1, v_u_48)
			end
			if v_u_63 ~= nil and v_u_63 == v_u_317 then
				v_u_332.BackgroundTransparency = 1
			end
			if v_u_71.HoveringOver == v_u_317 then
				v_u_331.Enabled = true
			else
				v_u_331.Enabled = false
			end
		else
			return
		end
	end)
	local v366, v367, v368 = v_u_40(v_u_317)
	v_u_343[#v_u_343 + 1] = v366:Connect(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_51, (ref) v_u_52, (copy) v_u_337, (ref) v_u_63, (copy) v_u_317, (copy) v_u_341, (copy) p_u_315, (ref) v_u_64, (ref) v_u_71, (ref) v_u_45
		v_u_4.click:Play()
		for _, v369 in v_u_51 do
			v369.Visible = false
		end
		for _, v370 in v_u_52 do
			v370:SetVisible(false)
		end
		v_u_337.Visible = v_u_63 ~= v_u_317
		v_u_341:SetVisible(v_u_337.Visible)
		if v_u_337.Visible then
			for _, v371 in p_u_315 do
				if v371.isActive then
					local v372 = v_u_337:FindFirstChild(v371.name)
					v_u_64 = v372 and v372:FindFirstChild("ImageButton")
					if v_u_64 then
						setAttachmentButtonSelected(v_u_64, true)
					end
					break
				end
			end
		end
		if v_u_337.Visible then
			v_u_71.HoveringOver = v_u_317
			v_u_4.open:Play()
			v_u_63 = v_u_317
			v_u_45 = true
		else
			v_u_4.close:Play()
			v_u_63 = nil
			v_u_45 = false
		end
		setMode(v_u_337.Visible and "Attachments" or "Nodes")
	end)
	v_u_343[#v_u_343 + 1] = v367:Connect(function()
		-- upvalues: (ref) v_u_63, (ref) v_u_71, (copy) v_u_317
		if not v_u_63 then
			v_u_71.HoveringOver = v_u_317
		end
	end)
	v_u_343[#v_u_343 + 1] = v368:Connect(function()
		-- upvalues: (ref) v_u_63, (ref) v_u_71, (copy) v_u_317
		if not v_u_63 then
			if v_u_71.HoveringOver == v_u_317 then
				v_u_71.HoveringOver = nil
			end
		end
	end)
	v_u_317.Parent = v_u_11
	v_u_11.CanvasSize = UDim2.new(0, 0, 0, v_u_11.UIListLayout.AbsoluteContentSize.Y)
	v_u_343[#v_u_343 + 1] = p_u_316.Destroying:Connect(function() -- name: CleanUp
		-- upvalues: (copy) v_u_317, (copy) v_u_337, (ref) v_u_332, (copy) v_u_336, (copy) v_u_331, (copy) v_u_343
		if v_u_317 then
			v_u_317:Destroy()
		end
		if v_u_337 then
			v_u_337:Destroy()
		end
		if v_u_332 then
			v_u_332:Destroy()
		end
		if v_u_336 then
			v_u_336:Destroy()
		end
		if v_u_331 then
			v_u_331:Destroy()
		end
		for _, v373 in v_u_343 do
			v373:Disconnect()
		end
		table.clear(v_u_343)
	end)
end
function removePreviewAttachments() -- name: removePreviewAttachments
	-- upvalues: (ref) v_u_57
	for _, v374 in v_u_57 do
		for _, v375 in v374 do
			v375.SelectFunction(v375.OriginalAttachmentIndex, v375.OriginalProperties)
		end
	end
end
function deepCopy(p376) -- name: deepCopy
	local v377 = {}
	for v378, v380 in pairs(p376) do
		if type(v380) == "table" then
			local v380 = deepCopy(v380)
		end
		v377[v378] = v380
	end
	return v377
end
function wordsToSentence(p381) -- name: wordsToSentence
	local v382 = ""
	for v383, v384 in p381 do
		v382 = v382 .. v384
		if v383 < #p381 then
			v382 = v382 .. " "
		end
	end
	return v382
end
function trim(p385) -- name: trim
	return p385:gsub("^%s+", "", 1):gsub("%s+$", "", 1)
end
function updatePlayerData(p386) -- name: updatePlayerData
	-- upvalues: (ref) v_u_42, (copy) v_u_59
	v_u_42 = p386
	for v387 in v_u_59 do
		v387()
	end
end
function openPurchaseModPrompt(p388, p389, p390, p391) -- name: openPurchaseModPrompt
	-- upvalues: (ref) v_u_66, (copy) v_u_10, (ref) v_u_42, (ref) v_u_67
	if v_u_66 then
		closePurchaseModPrompt()
	end
	v_u_66 = true
	v_u_10.NameLabel.Text = p390
	v_u_10.BalanceLabel.Text = ("YOUR BALANCE: %d Z$"):format(v_u_42.Progression.ZBucks)
	v_u_10.InfoLabel.Text = ("UNLOCK FOR %d Z$"):format(p391)
	v_u_67 = {
		["WeaponID"] = p388,
		["ModID"] = p389
	}
	v_u_10.Visible = true
end
v_u_40(v_u_10.UnlockButton):Connect(function()
	-- upvalues: (ref) v_u_67, (copy) v_u_41
	if v_u_67 and v_u_41 then
		v_u_41:FireServer({
			["Type"] = "PurchaseMod",
			["WeaponID"] = nil,
			["ModID"] = nil,
			["WeaponID"] = v_u_67.WeaponID,
			["ModID"] = v_u_67.ModID
		})
		closePurchaseModPrompt()
	end
end)
function closePurchaseModPrompt() -- name: closePurchaseModPrompt
	-- upvalues: (ref) v_u_67, (copy) v_u_10, (ref) v_u_66
	v_u_67 = nil
	v_u_10.Visible = false
	v_u_66 = false
end
function deserializeUnlockedAttachments(p392) -- name: deserializeUnlockedAttachments
	return not p392 and {} or string.split(p392, ",")
end
v_u_40(v_u_10.CancelButton):Connect(closePurchaseModPrompt)
if v_u_41 then
	v_u_41:SetClientListener(function(p393)
		-- upvalues: (ref) v_u_42, (copy) v_u_35, (ref) v_u_62, (ref) v_u_58
		if p393.Type and p393.Type == "ModUnlocked" then
			v_u_42.Progression = p393.NewProgression
			updatePlayerData(v_u_42)
			if v_u_35:GetItemIdFromName(v_u_62) == p393.WeaponID and v_u_58[p393.ModID] then
				for _, v394 in v_u_58[p393.ModID] do
					v394()
				end
			end
		end
	end)
end
return v_u_71