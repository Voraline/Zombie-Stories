local v1 = game:GetService("ReplicatedStorage")
v1.common:WaitForChild("SharedResources"):WaitForChild("Attachments")
local v2 = v1.common
local v_u_3 = require("@self/PaletteSystem")
require("@self/AttachmentsRoot")
local v_u_4 = require(v2:WaitForChild("WepConfig"))
local v_u_5 = require(v2:WaitForChild("Promise"))
local v_u_6 = os.clock()
local v_u_7 = {}
local v_u_8 = Instance.new("Folder")
local v_u_9 = {}
local v19 = {
	["DressWeapon"] = function(_, p10, p11, p12, p13, p14) -- name: DressWeapon
		-- upvalues: (copy) v_u_9, (ref) v_u_6
		if p12 then
			local v15 = p12:FindFirstChild("Attachments")
			if v15 then
				v15:Destroy()
			end
			local v16 = p12:FindFirstChild("GlobalParts")
			local v17 = v16 and v16:FindFirstChild("CustomPoints")
			if v17 then
				v17:Destroy()
			end
			Instance.new("Folder", p12).Name = "Attachments"
			Instance.new("Folder", v16).Name = "CustomPoints"
		end
		table.clear(v_u_9)
		local v18 = os.clock()
		v_u_6 = v18
		return processAttachmentQueue(p10:GetNodes(), p11, v18, p12, p13, p14)
	end
}
function processAttachmentQueue(p_u_20, p_u_21, p_u_22, p_u_23, p_u_24, p_u_25) -- name: processAttachmentQueue
	-- upvalues: (copy) v_u_5
	return v_u_5.new(function(p_u_26, _, p27)
		-- upvalues: (copy) p_u_20, (copy) p_u_21, (copy) p_u_22, (copy) p_u_23, (copy) p_u_24, (copy) p_u_25
		local v_u_28 = {}
		for v29, v30 in p_u_20 do
			table.insert(v_u_28, {
				["nodeID"] = nil,
				["nodeData"] = nil,
				["subNodePartsSnapshot"] = nil,
				["depth"] = 0,
				["nodeID"] = v29,
				["nodeData"] = v30
			})
		end
		local v_u_31 = 0
		local v_u_32 = 1
		local v_u_33 = false
		local v_u_34 = false
		local v_u_35 = false
		p27(function()
			-- upvalues: (ref) v_u_35
			v_u_35 = true
		end)
		local function v_u_47()
			-- upvalues: (ref) v_u_34, (ref) v_u_35, (ref) v_u_32, (copy) v_u_28, (ref) p_u_21, (ref) v_u_31, (ref) p_u_22, (ref) p_u_23, (ref) p_u_24, (ref) p_u_25, (ref) v_u_33, (copy) p_u_26, (ref) v_u_47
			if v_u_34 then
				return
			end
			v_u_34 = true
			while true do
				if v_u_35 or v_u_32 > #v_u_28 then
					v_u_34 = false
					return
				end
				local v_u_36 = v_u_28[v_u_32]
				v_u_32 = v_u_32 + 1
				local v_u_37 = v_u_36.nodeData.ConnectedAttachment
				if v_u_37 then
					if v_u_36.depth > 50 then
						warn("[AttachmentSystem] Max attachment nesting depth (" .. 50 .. ") exceeded -- skipping further sub-attachments.")
					else
						local v38 = v_u_37:GetAttachmentData()
						local v39 = nil
						if v_u_36.subNodePartsSnapshot then
							for _, v40 in v_u_36.subNodePartsSnapshot do
								if v40.Name == p_u_21[v_u_36.nodeID].Name then
									v39 = v40
									break
								end
							end
						end
						v_u_31 = v_u_31 + 1
						attachSingleNode(v_u_37, v38, p_u_21, p_u_22, p_u_23, p_u_21[v_u_36.nodeID].Name, v39, p_u_24, p_u_25, function()
							-- upvalues: (ref) v_u_35
							return v_u_35
						end):andThen(function(p41, p42)
							-- upvalues: (ref) v_u_35, (copy) v_u_37, (ref) v_u_28, (copy) v_u_36
							if p41 and not v_u_35 then
								for v43, v44 in v_u_37:GetNodes() do
									local v45 = v_u_28
									local v46 = {
										["nodeID"] = v43,
										["nodeData"] = v44,
										["subNodePartsSnapshot"] = p42,
										["depth"] = v_u_36.depth + 1
									}
									table.insert(v45, v46)
								end
							end
						end):finally(function()
							-- upvalues: (ref) v_u_31, (ref) v_u_33, (ref) v_u_32, (ref) v_u_28, (ref) p_u_26, (ref) v_u_35, (ref) v_u_47
							v_u_31 = v_u_31 - 1
							if v_u_33 and (v_u_31 <= 0 and v_u_32 > #v_u_28) then
								p_u_26()
							end
							if not v_u_35 then
								v_u_47()
							end
						end)
					end
				end
			end
		end
		v_u_47()
		v_u_33 = true
		if v_u_33 and (v_u_31 <= 0 and #v_u_28 < v_u_32) then
			p_u_26()
		end
	end)
end
function attachSingleNode(p_u_48, p_u_49, _, p_u_50, p_u_51, p_u_52, p_u_53, p_u_54, p_u_55, p_u_56) -- name: attachSingleNode
	-- upvalues: (copy) v_u_5, (ref) v_u_6, (copy) v_u_9, (copy) v_u_4, (copy) v_u_3
	if not p_u_49 then
		return v_u_5.resolve()
	end
	local v_u_57
	if p_u_51 then
		v_u_57 = p_u_51.Attachments
	else
		v_u_57 = p_u_51
	end
	local v58, v_u_59 = getAttachmentFolder(p_u_49.Name):await()
	if p_u_56 and p_u_56() then
		return v_u_5.resolve()
	end
	if v58 then
		return v_u_5.new(function(p60, _, _)
			-- upvalues: (ref) v_u_6, (copy) p_u_50, (copy) p_u_55, (copy) p_u_56, (copy) p_u_51, (copy) p_u_49, (copy) v_u_59, (ref) p_u_53, (copy) p_u_52, (ref) v_u_9, (copy) p_u_48, (ref) v_u_4, (ref) v_u_3, (copy) v_u_57, (copy) p_u_54
			if v_u_6 == p_u_50 or p_u_55 then
				if p_u_56 and p_u_56() then
					p60()
				else
					local v61
					if p_u_51 then
						v61 = GetReplacementModel(p_u_51):FindFirstChild(p_u_49.Name)
					else
						v61 = nil
					end
					if not v61 and (v_u_59 and v_u_59:FindFirstChildOfClass("Model")) then
						v61 = v_u_59:FindFirstChildOfClass("Model"):Clone()
					end
					local v62 = nil
					local v63 = nil
					if p_u_51 and v61 then
						if not v61.PrimaryPart then
							v61.PrimaryPart = v61:FindFirstChild("AttachmentPoint") or v61:FindFirstChildOfClass("BasePart")
							warn("No existing PrimaryPart for " .. v61.Name)
						end
						p_u_53 = p_u_53 or nil
						local v64 = not p_u_53 and p_u_51:FindFirstChild("GlobalParts")
						if v64 then
							local v65 = v64:FindFirstChild("CustomPoints")
							local v66 = v65
							if v66 then
								v66 = v65:FindFirstChild(p_u_52)
							end
							if not p_u_53 then
								p_u_53 = v66 or p_u_51.GlobalParts.BasePoints:FindFirstChild(p_u_52)
							end
						end
						if p_u_53 then
							local v67 = v61:Clone()
							local v68 = v67.PrimaryPart
							for _, v69 in v67:GetDescendants() do
								if v69:IsA("BasePart") then
									v69.CastShadow = false
									if v69 ~= v68 then
										local v70 = Instance.new("WeldConstraint")
										v70.Part0 = v68
										v70.Part1 = v69
										v70.Parent = v69
										v69.Anchored = false
									end
								end
							end
							if p_u_49.BaseModule then
								v62 = getAttachmentFolder(p_u_49.BaseModule):expect():FindFirstChildOfClass("Model"):Clone()
								v67.Parent = v62
								local v71 = Instance.new("Weld")
								v71.Part0 = v62.SwingingPart
								v71.Part1 = v67.PrimaryPart
								v71.Parent = v67
							else
								v62 = v67
							end
							v_u_9[p_u_48] = script.Highlight:Clone()
							v_u_9[p_u_48].Parent = v62
							v62:ScaleTo(findScale(p_u_53, v62.PrimaryPart))
							v62:PivotTo(p_u_53.CFrame)
							local v72 = Instance.new("Weld")
							v72.Part0 = v62.PrimaryPart
							v72.Part1 = p_u_53
							v72.Parent = v62
							if not v_u_4:IsStock(p_u_51.Name) and v_u_59.Parent.Name ~= "Charm" then
								v_u_3(p_u_51, v62)
							end
							v62.Parent = v_u_57
							local v_u_73 = {
								p_u_51,
								p_u_53.Name,
								p_u_49.Name,
								v62
							}
							local v_u_74 = v_u_4:GetWeaponConfig(p_u_51.Name)
							local v75 = not (v_u_74.AttachedAttachment and v_u_74.AttachedAttachment(unpack(v_u_73)) or v_u_74.AttachedAttachment)
							if v75 then
								v75 = not v_u_74.DontRunDefaultAttachedAttachment
							end
							if v75 then
								AttachedAttachment(unpack(v_u_73))
							end
							if v_u_74.SkipAttachmentModel and v_u_74.SkipAttachmentModel[p_u_52] then
								for _, v76 in v62:GetDescendants() do
									if v76:IsA("BasePart") then
										v76.Transparency = 1
									end
								end
							end
							local v77 = v62:FindFirstChild("CustomPoints")
							if v77 then
								local v78 = p_u_51:FindFirstChild("GlobalParts")
								if v78 then
									local v79 = v78:FindFirstChild("CustomPoints")
									if v79 then
										for _, v80 in v77:GetChildren() do
											local v81 = Instance.new("Weld")
											v81.Part0 = v62.PrimaryPart
											v81.Part1 = v80
											v81.C0 = v81.Part0.CFrame:Inverse() * v81.Part1.CFrame
											v81.Parent = v80
											v80.Parent = v79
										end
									end
								end
							end
							local v_u_82 = nil
							v_u_82 = v62.Destroying:Connect(function()
								-- upvalues: (ref) v_u_82, (copy) v_u_74, (ref) v_u_73
								v_u_82:Disconnect()
								v_u_82 = nil
								local v83
								if v_u_74.DetachedAttachment then
									local v84 = v_u_73
									v83 = v_u_74.DetachedAttachment(unpack(v84))
									if not v83 then
										goto l2
									end
								else
									::l2::
									v83 = not v_u_74.DetachedAttachment
									if v83 then
										v83 = not v_u_74.DontRunDefaultDetachedAttachment
									end
								end
								if v83 then
									local v85 = v_u_73
									DetachedAttachment(unpack(v85))
								end
								v_u_73 = nil
							end)
							v63 = v62:FindFirstChild("NodeParts")
							if v63 then
								v63 = v63:GetChildren()
							end
							v61 = v62
						else
							warn("NO VALID NODEPART TO WELD TO.")
						end
					elseif p_u_51 then
						p_u_53 = p_u_53 or nil
						local v86 = not p_u_53 and p_u_51:FindFirstChild("GlobalParts")
						if v86 then
							local v87 = v86:FindFirstChild("CustomPoints")
							local v88 = v87
							if v88 then
								v88 = v87:FindFirstChild(p_u_52)
							end
							if not p_u_53 then
								p_u_53 = v88 or p_u_51.GlobalParts.BasePoints:FindFirstChild(p_u_52)
							end
						end
						local v_u_89 = v_u_4:GetWeaponConfig(p_u_51.Name)
						if p_u_53 and v_u_89.AttachedAttachment then
							local v_u_90 = { p_u_51, p_u_53.Name, p_u_49.Name }
							local v91 = v_u_90
							v_u_89.AttachedAttachment(unpack(v91))
							local v_u_92 = nil
							v_u_92 = v_u_57.Destroying:Connect(function()
								-- upvalues: (ref) v_u_92, (copy) v_u_89, (ref) v_u_90
								v_u_92:Disconnect()
								v_u_92 = nil
								local v93
								if v_u_89.DetachedAttachment then
									local v94 = v_u_90
									v93 = v_u_89.DetachedAttachment(unpack(v94))
									if not v93 then
										goto l2
									end
								else
									::l2::
									v93 = not v_u_89.DetachedAttachment
									if v93 then
										v93 = not v_u_89.DontRunDefaultDetachedAttachment
									end
								end
								if v93 then
									local v95 = v_u_90
									DetachedAttachment(unpack(v95))
								end
								v_u_90 = nil
							end)
						end
					end
					local v96
					if v_u_59 then
						getAttachmentFolder(v_u_59.Parent.Name .. "_Shared"):expect()
						v96 = v_u_59:FindFirstChild("AttachmentModule")
						if not v96 then
							local v97 = getAttachmentFolder(v_u_59.Parent.Name .. "_Shared"):expect()
							v96 = v97
							if v96 then
								v96 = v97:FindFirstChild("AttachmentModule")
							end
						end
						if not v96 and p_u_49.SharedModule then
							local v98 = getAttachmentFolder(p_u_49.SharedModule):expect()
							v96 = v98
							if v96 then
								v96 = v98:FindFirstChild("AttachmentModule")
							end
						end
					else
						v96 = nil
					end
					local v_u_99
					if p_u_54 then
						v_u_99 = p_u_54(p_u_48, v62, v96, v_u_9)
					else
						v_u_99 = nil
					end
					if p_u_51 and (v96 and (v_u_99 and v_u_99.SettingChanges)) then
						p_u_51:WaitForChild("KeyParts", 5)
						local v_u_100 = p_u_51.KeyParts:FindFirstChild("Barrel")
						if v_u_100 and v_u_99.SettingChanges.BarrelAttachment then
							for _, v101 in v_u_100:GetChildren() do
								if v101:IsA("Attachment") then
									for _, v102 in v101:GetChildren() do
										v102.Parent = v_u_99.SettingChanges.BarrelAttachment
									end
								else
									v101.Parent = v_u_99.SettingChanges.BarrelAttachment
								end
							end
							local v_u_103 = nil
							v_u_103 = v61.Destroying:connect(function()
								-- upvalues: (ref) v_u_103, (copy) v_u_100, (ref) v_u_99
								v_u_103:Disconnect()
								v_u_103 = nil
								local v104 = v_u_100:FindFirstChildOfClass("Attachment")
								for _, v105 in v_u_99.SettingChanges.BarrelAttachment:GetChildren() do
									v105.Parent = v104 or v_u_100
								end
							end)
						end
					end
					p60(v62, v63)
				end
			else
				p60()
				return
			end
		end)
	end
	warn("Failed to get folder for", p_u_49.Name)
	return v_u_5.resolve()
end
function GetReplacementModel(p106) -- name: GetReplacementModel
	-- upvalues: (copy) v_u_7, (copy) v_u_8
	local v_u_107 = v_u_7[p106] or (p106:FindFirstChild("AttReplaceModels") or v_u_8)
	if not v_u_7[p106] then
		v_u_7[p106] = v_u_107
		if v_u_107 ~= v_u_8 then
			p106.Destroying:Connect(function()
				-- upvalues: (copy) v_u_107
				v_u_107:Destroy()
			end)
		end
		v_u_107.Parent = nil
	end
	if not p106:FindFirstChild("Attachments") then
		Instance.new("Folder", p106).Name = "Attachments"
	end
	return v_u_107
end
function AttachedAttachment(p108, p109, p110, p111, _) -- name: AttachedAttachment
	local v112 = p108:FindFirstChild("Weapon")
	if v112 then
		local v113 = { v112:FindFirstChild(p109 .. "_Hide"), (v112:FindFirstChild(p109 .. "_Show")) }
		for v114, v115 in pairs(v113) do
			for _, v116 in pairs(v115:GetDescendants()) do
				if v116:IsA("BasePart") or (v116:IsA("Texture") or v116:IsA("Decal")) then
					v116.Transparency = v114 == 1 and 1 or 0
				elseif v116:IsA("Beam") or (v116:IsA("ParticleEmitter") or v116:IsA("Trail")) then
					v116.Enabled = false
				end
			end
		end
		for _, v117 in v112:GetChildren() do
			if v117:IsA("Model") then
				local v118 = v117:GetAttribute("VisibilityRule")
				local v119 = v117:GetAttribute("VisibilityTarget")
				if v118 and (v119 and v119 == p109) then
					if v118 == "Hide" then
						for _, v120 in v117:GetDescendants() do
							if v120:IsA("BasePart") or (v120:IsA("Decal") or v120:IsA("Texture")) then
								if v120:GetAttribute("VisibilityOrigTransparency") == nil then
									v120:SetAttribute("VisibilityOrigTransparency", v120.Transparency)
								end
								v120.Transparency = 1
							elseif v120:IsA("Beam") or v120:IsA("ParticleEmitter") then
								if v120:GetAttribute("VisibilityOrigEnabled") == nil then
									v120:SetAttribute("VisibilityOrigEnabled", v120.Enabled)
								end
								v120.Enabled = false
							end
						end
					elseif v118 == "Show" then
						for _, v121 in v117:GetDescendants() do
							if v121:IsA("BasePart") or (v121:IsA("Decal") or v121:IsA("Texture")) then
								v121.Transparency = v121:GetAttribute("VisibilityOrigTransparency") or 0
							elseif v121:IsA("Beam") or v121:IsA("ParticleEmitter") then
								local v122 = v121:GetAttribute("VisibilityOrigEnabled")
								v121.Enabled = v122 == nil and true or v122
							end
						end
					elseif v118 == "Replace" and v117:GetAttribute("ReplaceAttachment") == p110 then
						if p111 and (p111.PrimaryPart and v117.PrimaryPart) then
							local v123 = v117:GetAttribute("_ReplaceOffset") or CFrame.new()
							v117.PrimaryPart.Anchored = false
							local v124 = Instance.new("Weld")
							v124.Name = "ReplaceNodeWeld"
							v124.Part0 = v117.PrimaryPart
							v124.Part1 = p111.PrimaryPart
							v124.C1 = v123
							v124.Parent = v117
						end
						if p111 then
							for _, v125 in p111:GetDescendants() do
								if v125:IsA("BasePart") or (v125:IsA("Decal") or v125:IsA("Texture")) then
									v125:SetAttribute("ReplacedTransparency", v125.Transparency)
									v125.Transparency = 1
								elseif v125:IsA("Beam") or v125:IsA("ParticleEmitter") then
									v125:SetAttribute("ReplacedEnabled", v125.Enabled)
									v125.Enabled = false
								end
							end
						end
						for _, v126 in v117:GetDescendants() do
							if v126:IsA("BasePart") or (v126:IsA("Decal") or v126:IsA("Texture")) then
								v126.Transparency = v126:GetAttribute("VisibilityOrigTransparency") or 0
							elseif v126:IsA("Beam") or v126:IsA("ParticleEmitter") then
								local v127 = v126:GetAttribute("VisibilityOrigEnabled")
								v126.Enabled = v127 == nil and true or v127
							end
						end
						local v128 = p111 and p111:FindFirstChildWhichIsA("Highlight")
						if v128 then
							v128.Adornee = v117
						end
						local v129 = v117:FindFirstChild("AimPart", true)
						if v129 and v129:IsA("BasePart") then
							local v130 = p108:FindFirstChild("KeyParts")
							if v130 then
								v130 = v130:FindFirstChild("Aimpart")
							end
							if v130 then
								v130:SetAttribute("OrigAimpartCFrame", v130.CFrame)
								v130.CFrame = v129.CFrame
							end
						end
					end
				end
			end
		end
	end
end
function DetachedAttachment(p131, p132, p133, p134, _) -- name: DetachedAttachment
	local v135 = p131:FindFirstChild("Weapon")
	if v135 then
		local v136 = { v135:FindFirstChild(p132 .. "_Hide"), (v135:FindFirstChild(p132 .. "_Show")) }
		for v137, v138 in pairs(v136) do
			for _, v139 in pairs(v138:GetDescendants()) do
				if v139:IsA("BasePart") or (v139:IsA("Texture") or v139:IsA("Decal")) then
					v139.Transparency = v137 == 1 and (v139:GetAttribute("Transparency") or 0) or 1
				end
			end
		end
		for _, v140 in v135:GetChildren() do
			if v140:IsA("Model") then
				local v141 = v140:GetAttribute("VisibilityRule")
				local v142 = v140:GetAttribute("VisibilityTarget")
				if v141 and (v142 and v142 == p132) then
					if v141 == "Hide" then
						for _, v143 in v140:GetDescendants() do
							if v143:IsA("BasePart") or (v143:IsA("Decal") or v143:IsA("Texture")) then
								v143.Transparency = v143:GetAttribute("VisibilityOrigTransparency") or 0
								v143:SetAttribute("VisibilityOrigTransparency", nil)
							elseif v143:IsA("Beam") or v143:IsA("ParticleEmitter") then
								local v144 = v143:GetAttribute("VisibilityOrigEnabled")
								v143.Enabled = v144 == nil and true or v144
								v143:SetAttribute("VisibilityOrigEnabled", nil)
							end
						end
					elseif v141 == "Show" then
						for _, v145 in v140:GetDescendants() do
							if v145:IsA("BasePart") or (v145:IsA("Decal") or v145:IsA("Texture")) then
								v145.Transparency = 1
							elseif v145:IsA("Beam") or v145:IsA("ParticleEmitter") then
								v145.Enabled = false
							end
						end
					elseif v141 == "Replace" and v140:GetAttribute("ReplaceAttachment") == p133 then
						local v146 = v140:FindFirstChild("ReplaceNodeWeld")
						if v146 then
							v146:Destroy()
						end
						if v140.PrimaryPart then
							v140.PrimaryPart.Anchored = true
						end
						local v147 = p134 and p134:FindFirstChildWhichIsA("Highlight")
						if v147 then
							v147.Adornee = nil
						end
						for _, v148 in v140:GetDescendants() do
							if v148:IsA("BasePart") or (v148:IsA("Decal") or v148:IsA("Texture")) then
								v148.Transparency = 1
							elseif v148:IsA("Beam") or v148:IsA("ParticleEmitter") then
								v148.Enabled = false
							end
						end
						if p134 then
							for _, v149 in p134:GetDescendants() do
								if v149:IsA("BasePart") or (v149:IsA("Decal") or v149:IsA("Texture")) then
									local v150 = v149:GetAttribute("ReplacedTransparency")
									if v150 ~= nil then
										v149.Transparency = v150
										v149:SetAttribute("ReplacedTransparency", nil)
									end
								elseif v149:IsA("Beam") or v149:IsA("ParticleEmitter") then
									local v151 = v149:GetAttribute("ReplacedEnabled")
									if v151 ~= nil then
										v149.Enabled = v151
										v149:SetAttribute("ReplacedEnabled", nil)
									end
								end
							end
						end
						local v152 = p131:FindFirstChild("KeyParts")
						if v152 then
							v152 = v152:FindFirstChild("Aimpart")
						end
						if v152 then
							local v153 = v152:GetAttribute("OrigAimpartCFrame")
							if v153 then
								v152.CFrame = v153
								v152:SetAttribute("OrigAimpartCFrame", nil)
							end
						end
					end
				end
			end
		end
	end
end
function getAttachmentFolder(p_u_154) -- name: getAttachmentFolder
	-- upvalues: (copy) v_u_5, (copy) v_u_4
	return v_u_5.new(function(p155, _, _)
		-- upvalues: (ref) v_u_4, (copy) p_u_154
		p155(v_u_4:GetAttachmentFolder(p_u_154))
	end)
end
function findScale(p156, p157) -- name: findScale
	return p156.Size.Magnitude / p157.Size.Magnitude
end
function scaleModelWithJoints(p158, p159) -- name: scaleModelWithJoints
	for _, v160 in ipairs(p158:GetDescendants()) do
		if v160:IsA("BasePart") then
			v160.Size = v160.Size * p159
			local v161 = v160.Position - p158:GetPrimaryPartCFrame().p
			local v162 = v160.CFrame - v160.Position
			v160.CFrame = CFrame.new(p158:GetPrimaryPartCFrame().p + v161 * p159) * v162
		elseif v160:IsA("JointInstance") then
			local v163 = v160.C0.p * p159
			local v164, v165, v166 = v160.C0:ToEulerAnglesXYZ()
			local v167 = v160.C1.p * p159
			local v168, v169, v170 = v160.C1:ToEulerAnglesXYZ()
			v160.C0 = CFrame.new(v163) * CFrame.Angles(v164, v165, v166)
			v160.C1 = CFrame.new(v167) * CFrame.Angles(v168, v169, v170)
		end
	end
end
return v19