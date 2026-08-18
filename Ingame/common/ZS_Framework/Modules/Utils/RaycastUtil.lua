local v_u_1 = game:GetService("Workspace")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Players")
local v_u_4 = v_u_1:WaitForChild("Ignore")
v2.common:WaitForChild("Remotes")
local _ = v2.common
local v_u_5 = v_u_1.CurrentCamera
local v_u_6 = script.Parent.Parent:WaitForChild("Controllers")
local v_u_7 = require(v_u_6:WaitForChild("LocalPlayerController"))
local v_u_8 = nil
local v_u_9 = Random.new(os.clock())
local v_u_10 = v_u_3.LocalPlayer
v_u_10:GetMouse()
local v_u_11 = {}
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = game:GetService("GuiService"):GetGuiInset()
local v_u_16 = RaycastParams.new()
v_u_16.FilterType = Enum.RaycastFilterType.Blacklist
v_u_16.FilterDescendantsInstances = v_u_11
v_u_16.IgnoreWater = true
local v_u_17 = RaycastParams.new()
v_u_17.FilterType = Enum.RaycastFilterType.Blacklist
v_u_17.FilterDescendantsInstances = v_u_12
v_u_17.IgnoreWater = true
v_u_17.RespectCanCollide = true
local v_u_18 = RaycastParams.new()
v_u_18.FilterType = Enum.RaycastFilterType.Blacklist
v_u_18.FilterDescendantsInstances = v_u_13
v_u_18.IgnoreWater = true
v_u_18.RespectCanCollide = true
local v74 = {
	["GetRaycastParams"] = function(_) -- name: GetRaycastParams
		-- upvalues: (copy) v_u_16
		return v_u_16
	end,
	["GetAltRaycastParams"] = function(_) -- name: GetAltRaycastParams
		-- upvalues: (copy) v_u_17
		return v_u_17
	end,
	["GetCollisionRaycastParams"] = function(_) -- name: GetCollisionRaycastParams
		-- upvalues: (copy) v_u_18
		return v_u_18
	end,
	["GetAltFilter"] = function() -- name: GetAltFilter
		-- upvalues: (copy) v_u_17
		return v_u_17.FilterDescendantsInstances
	end,
	["GetCenterDirection"] = function() -- name: GetCenterDirection
		-- upvalues: (copy) v_u_5, (ref) v_u_8, (copy) v_u_6, (copy) v_u_15
		local v19 = v_u_5.CFrame
		local v20 = v_u_5
		if not v_u_8 then
			v_u_8 = require(v_u_6:WaitForChild("CameraController"))
		end
		v20.CFrame = v_u_8.AimCFrame
		local v21 = Vector2.new(v_u_5.ViewportSize.X / 2, v_u_5.ViewportSize.Y / 2)
		local v22 = v_u_5:ScreenPointToRay(v21.X - v_u_15.X, v21.Y - v_u_15.Y)
		v_u_5.CFrame = v19
		return v22.Direction
	end,
	["CustomRayDirection"] = function(p23, p24, p25) -- name: CustomRayDirection
		-- upvalues: (copy) v_u_17, (copy) v_u_16
		local v26 = workspace
		local v27
		if p25 then
			v27 = v_u_17
		else
			v27 = v_u_16
		end
		return v26:Raycast(p23, p24, v27) or {
			["Position"] = p23 + p24
		}
	end,
	["CustomRay"] = function(p28, p29, p30) -- name: CustomRay
		-- upvalues: (copy) v_u_17, (copy) v_u_16
		local v31 = p29 - p28
		local v32 = workspace
		local v33
		if p30 then
			v33 = v_u_17
		else
			v33 = v_u_16
		end
		return v32:Raycast(p28, v31, v33) or {
			["Position"] = p28 + v31
		}
	end,
	["CollisionRayDirection"] = function(p34, p35) -- name: CollisionRayDirection
		-- upvalues: (copy) v_u_18
		return workspace:Raycast(p34, p35, v_u_18) or {
			["Position"] = p34 + p35
		}
	end,
	["CollisionRay"] = function(p36, p37) -- name: CollisionRay
		-- upvalues: (copy) v_u_18
		local v38 = p37 - p36
		return workspace:Raycast(p36, v38, v_u_18) or {
			["Position"] = p36 + v38
		}
	end,
	["CastBaseRay"] = function(p39) -- name: CastBaseRay
		-- upvalues: (copy) v_u_5, (copy) v_u_15, (copy) v_u_17, (copy) v_u_16
		local v40 = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
		local v41 = v_u_5:ScreenPointToRay(v40.X - v_u_15.X, v40.Y - v_u_15.Y).Direction * 50
		local v42 = workspace
		local v43 = v_u_5.CFrame.Position
		local v44
		if p39 then
			v44 = v_u_17
		else
			v44 = v_u_16
		end
		return v42:Raycast(v43, v41, v44) or {
			["Position"] = v_u_5.CFrame.Position + v41
		}
	end,
	["CastNoneRay"] = function() -- name: CastNoneRay
		-- upvalues: (copy) v_u_5, (ref) v_u_8, (copy) v_u_6, (copy) v_u_15
		local v45 = v_u_5.CFrame
		if not v_u_8 then
			v_u_8 = require(v_u_6:WaitForChild("CameraController"))
		end
		local v46 = v_u_8.AimCFrame
		v_u_5.CFrame = v46
		local v47 = Vector2.new(v_u_5.ViewportSize.X / 2, v_u_5.ViewportSize.Y / 2)
		local v48 = v_u_5:ScreenPointToRay(v47.X - v_u_15.X, v47.Y - v_u_15.Y)
		v_u_5.CFrame = v45
		local v49 = v48.Direction * 50
		return {
			["Position"] = v46.Position + v49
		}
	end,
	["CastRay"] = function(p50, p51, p52) -- name: CastRay
		-- upvalues: (copy) v_u_5, (ref) v_u_8, (copy) v_u_6, (copy) v_u_15, (ref) v_u_11, (copy) v_u_16
		local v53 = v_u_5.CFrame
		if not v_u_8 then
			v_u_8 = require(v_u_6:WaitForChild("CameraController"))
		end
		local v54 = v_u_8.AimCFrame
		v_u_5.CFrame = v54
		local v55 = Vector2.new(v_u_5.ViewportSize.X / 2, v_u_5.ViewportSize.Y / 2)
		local v56 = v_u_5:ScreenPointToRay(v55.X - v_u_15.X, v55.Y - v_u_15.Y).Direction
		if p52 and p52.Magnitude > 0.0001 then
			v56 = v56 + v54.RightVector.Unit * p52.X + v54.UpVector.Unit * p52.Y
		end
		v_u_5.CFrame = v53
		local v57 = p50.Inaccuracy / 6
		local v58 = math.rad(v57)
		local v59 = rand(v58)
		local v60 = rand(v58)
		local v61 = rand
		local v62 = (v56 + Vector3.new(v59, v60, v61(v58))) * 5000
		if p51 then
			local v63 = {}
			for _, v64 in v_u_11 do
				table.insert(v63, v64)
			end
			for _, v65 in p51 do
				table.insert(v63, v65)
			end
			v_u_16.FilterDescendantsInstances = v63
		end
		local v66 = workspace:Raycast(v54.Position, v62, v_u_16)
		v_u_16.FilterDescendantsInstances = v_u_11
		return v66 or {
			["Position"] = v54.Position + v62
		}
	end,
	["StandardCast"] = function(p67, p68, p69) -- name: StandardCast
		-- upvalues: (ref) v_u_11, (copy) v_u_16
		if p69 then
			local v70 = {}
			for _, v71 in v_u_11 do
				table.insert(v70, v71)
			end
			for _, v72 in p69 do
				table.insert(v70, v72)
			end
			v_u_16.FilterDescendantsInstances = v70
		end
		local v73 = workspace:Raycast(p67, p68, v_u_16)
		v_u_16.FilterDescendantsInstances = v_u_11
		return v73
	end
}
function rand(p75) -- name: rand
	-- upvalues: (copy) v_u_9
	return v_u_9:NextNumber(-p75, p75)
end
local v_u_76 = {}
local v_u_77 = {}
local v_u_78 = 0
local v_u_79 = {}
local v_u_80 = {}
local v_u_81 = {}
local v_u_82 = nil
local v_u_83 = false
local function v_u_84() -- name: requestRefresh
	-- upvalues: (ref) v_u_83, (ref) v_u_82
	if not v_u_83 then
		v_u_83 = true
		task.defer(function()
			-- upvalues: (ref) v_u_83, (ref) v_u_82
			v_u_83 = false
			if v_u_82 then
				v_u_82()
			end
		end)
	end
end
local function v_u_89() -- name: rebuildFriendlyResolverOrder
	-- upvalues: (ref) v_u_77, (copy) v_u_76
	v_u_77 = {}
	for _, v85 in pairs(v_u_76) do
		local v86 = v_u_77
		table.insert(v86, v85)
	end
	table.sort(v_u_77, function(p87, p88)
		if p87.priority == p88.priority then
			return p87.sequence < p88.sequence
		else
			return p87.priority > p88.priority
		end
	end)
end
local function v_u_95(p90, p91) -- name: evaluateFriendlyResolvers
	-- upvalues: (ref) v_u_77
	for _, v92 in ipairs(v_u_77) do
		local v93, v94 = pcall(v92.fn, p90, p91)
		if v93 and v94 ~= nil then
			return v94
		end
	end
end
local function v_u_98(p96, p97) -- name: attachAttributeTracker
	-- upvalues: (copy) v_u_81, (copy) v_u_84
	v_u_81[p96] = v_u_81[p96] or {}
	if v_u_81[p96][p97] then
		v_u_81[p96][p97]:Disconnect()
	end
	v_u_81[p96][p97] = p96:GetAttributeChangedSignal(p97):Connect(v_u_84)
end
local function v_u_101(p99) -- name: bindPlayer
	-- upvalues: (copy) v_u_80, (copy) v_u_84, (copy) v_u_79, (copy) v_u_98
	if v_u_80[p99] then
		v_u_80[p99]:Disconnect()
	end
	v_u_80[p99] = p99.CharacterAdded:Connect(v_u_84)
	for v100 in pairs(v_u_79) do
		v_u_98(p99, v100)
	end
end
local function v_u_105(p102) -- name: cleanupPlayer
	-- upvalues: (copy) v_u_80, (copy) v_u_81
	if v_u_80[p102] then
		v_u_80[p102]:Disconnect()
		v_u_80[p102] = nil
	end
	if v_u_81[p102] then
		for v103, v104 in pairs(v_u_81[p102]) do
			v104:Disconnect()
			v_u_81[p102][v103] = nil
		end
		v_u_81[p102] = nil
	end
end
function v74.RegisterFriendlyResolver(p_u_106, p107, p108) -- name: RegisterFriendlyResolver
	-- upvalues: (ref) v_u_78, (copy) v_u_76, (copy) v_u_89, (ref) v_u_83, (ref) v_u_82
	local v109
	if typeof(p_u_106) == "string" then
		v109 = p_u_106 ~= ""
	else
		v109 = false
	end
	assert(v109, "Resolver id must be a non-empty string")
	local v110 = typeof(p107) == "function"
	assert(v110, "Resolver must be a function")
	v_u_78 = v_u_78 + 1
	v_u_76[p_u_106] = {
		["id"] = p_u_106,
		["fn"] = p107,
		["priority"] = p108 or 0,
		["sequence"] = v_u_78
	}
	v_u_89()
	if not v_u_83 then
		v_u_83 = true
		task.defer(function()
			-- upvalues: (ref) v_u_83, (ref) v_u_82
			v_u_83 = false
			if v_u_82 then
				v_u_82()
			end
		end)
	end
	return function()
		-- upvalues: (ref) v_u_76, (copy) p_u_106, (ref) v_u_89, (ref) v_u_83, (ref) v_u_82
		if v_u_76[p_u_106] then
			v_u_76[p_u_106] = nil
			v_u_89()
			if v_u_83 then
				return
			end
			v_u_83 = true
			task.defer(function()
				-- upvalues: (ref) v_u_83, (ref) v_u_82
				v_u_83 = false
				if v_u_82 then
					v_u_82()
				end
			end)
		end
	end
end
function v74.UnregisterFriendlyResolver(p111) -- name: UnregisterFriendlyResolver
	-- upvalues: (copy) v_u_76, (copy) v_u_89, (ref) v_u_83, (ref) v_u_82
	if v_u_76[p111] then
		v_u_76[p111] = nil
		v_u_89()
		if v_u_83 then
			return
		end
		v_u_83 = true
		task.defer(function()
			-- upvalues: (ref) v_u_83, (ref) v_u_82
			v_u_83 = false
			if v_u_82 then
				v_u_82()
			end
		end)
	end
end
function v74.RegisterFriendlyAttribute(p112) -- name: RegisterFriendlyAttribute
	-- upvalues: (copy) v_u_79, (copy) v_u_3, (copy) v_u_98, (ref) v_u_83, (ref) v_u_82
	local v113
	if typeof(p112) == "string" then
		v113 = p112 ~= ""
	else
		v113 = false
	end
	assert(v113, "Attribute name must be a non-empty string")
	if v_u_79[p112] then
		return
	else
		v_u_79[p112] = true
		for _, v114 in ipairs(v_u_3:GetPlayers()) do
			v_u_98(v114, p112)
		end
		if not v_u_83 then
			v_u_83 = true
			task.defer(function()
				-- upvalues: (ref) v_u_83, (ref) v_u_82
				v_u_83 = false
				if v_u_82 then
					v_u_82()
				end
			end)
		end
	end
end
function v74.UnregisterFriendlyAttribute(p115) -- name: UnregisterFriendlyAttribute
	-- upvalues: (copy) v_u_79, (copy) v_u_3, (copy) v_u_81, (ref) v_u_83, (ref) v_u_82
	if v_u_79[p115] then
		v_u_79[p115] = nil
		for _, v116 in ipairs(v_u_3:GetPlayers()) do
			local v117 = v_u_81[v116]
			if v117 then
				if v117[p115] then
					v117[p115]:Disconnect()
					v117[p115] = nil
				end
				if next(v117) == nil then
					v_u_81[v116] = nil
				end
			end
		end
		if not v_u_83 then
			v_u_83 = true
			task.defer(function()
				-- upvalues: (ref) v_u_83, (ref) v_u_82
				v_u_83 = false
				if v_u_82 then
					v_u_82()
				end
			end)
		end
	else
		return
	end
end
function v74.NotifyFriendlyStateChanged() -- name: NotifyFriendlyStateChanged
	-- upvalues: (ref) v_u_83, (ref) v_u_82
	if not v_u_83 then
		v_u_83 = true
		task.defer(function()
			-- upvalues: (ref) v_u_83, (ref) v_u_82
			v_u_83 = false
			if v_u_82 then
				v_u_82()
			end
		end)
	end
end
v_u_82 = function()
	-- upvalues: (copy) v_u_10, (ref) v_u_14, (copy) v_u_3, (copy) v_u_95, (ref) v_u_11, (copy) v_u_4, (copy) v_u_7, (ref) v_u_12, (copy) v_u_1, (ref) v_u_13, (copy) v_u_16, (copy) v_u_17, (copy) v_u_18
	local v118 = v_u_10
	if v118 then
		v_u_14 = {}
		local v119 = {}
		for _, v120 in v_u_3:GetPlayers() do
			if v120 ~= v118 and v120.Character then
				local v121
				if v118 and v120 then
					v121 = v_u_95(v118, v120)
					if v121 == nil then
						v121 = v120.TeamColor == v118.TeamColor
					end
				else
					v121 = true
				end
				if v121 then
					local v122 = v120.Character
					table.insert(v119, v122)
					local v123 = v_u_14
					local v124 = v120.Character
					table.insert(v123, v124)
				end
			end
		end
		local v125 = workspace:FindFirstChild("NPCRaycastCollide")
		v_u_11 = {
			v_u_4,
			v125,
			v_u_7.character,
			unpack(v119)
		}
		v_u_12 = {
			v_u_4,
			v125,
			v_u_7.character,
			v_u_1:FindFirstChild("Zombies"),
			unpack(v119)
		}
		v_u_13 = {
			v125,
			v_u_7.character,
			v_u_1:FindFirstChild("Zombies"),
			unpack(v119)
		}
		v_u_16.FilterDescendantsInstances = v_u_11
		v_u_17.FilterDescendantsInstances = v_u_12
		v_u_18.FilterDescendantsInstances = v_u_13
	end
end
local function v129() -- name: setupPlayerBindings
	-- upvalues: (copy) v_u_3, (copy) v_u_101, (ref) v_u_83, (ref) v_u_82, (copy) v_u_105
	for _, v126 in ipairs(v_u_3:GetPlayers()) do
		v_u_101(v126)
	end
	v_u_3.PlayerAdded:Connect(function(p127)
		-- upvalues: (ref) v_u_101, (ref) v_u_83, (ref) v_u_82
		v_u_101(p127)
		if not v_u_83 then
			v_u_83 = true
			task.defer(function()
				-- upvalues: (ref) v_u_83, (ref) v_u_82
				v_u_83 = false
				if v_u_82 then
					v_u_82()
				end
			end)
		end
	end)
	v_u_3.PlayerRemoving:Connect(function(p128)
		-- upvalues: (ref) v_u_105, (ref) v_u_83, (ref) v_u_82
		v_u_105(p128)
		if not v_u_83 then
			v_u_83 = true
			task.defer(function()
				-- upvalues: (ref) v_u_83, (ref) v_u_82
				v_u_83 = false
				if v_u_82 then
					v_u_82()
				end
			end)
		end
	end)
end
if v_u_7.character then
	v_u_11[2] = v_u_7.character
	v_u_12[2] = v_u_7.character
	v_u_16.FilterDescendantsInstances = v_u_11
	v_u_17.FilterDescendantsInstances = v_u_12
end
v_u_7.CharacterChanged:Connect(function(p130)
	-- upvalues: (ref) v_u_11, (ref) v_u_12, (copy) v_u_16, (copy) v_u_17, (ref) v_u_83, (ref) v_u_82
	if p130 then
		v_u_11[2] = p130
		v_u_12[2] = p130
		v_u_16.FilterDescendantsInstances = v_u_11
		v_u_17.FilterDescendantsInstances = v_u_12
		if v_u_83 then
			return
		end
		v_u_83 = true
		task.defer(function()
			-- upvalues: (ref) v_u_83, (ref) v_u_82
			v_u_83 = false
			if v_u_82 then
				v_u_82()
			end
		end)
	end
end)
v129()
if not v_u_83 then
	v_u_83 = true
	task.defer(function()
		-- upvalues: (ref) v_u_83, (ref) v_u_82
		v_u_83 = false
		if v_u_82 then
			v_u_82()
		end
	end)
end
return v74