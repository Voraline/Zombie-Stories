local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = v_u_2.Packages
local v_u_4 = require(v3.Fusion)
local v_u_5 = require(v_u_2.common.Assets.assets)
local v_u_6 = require(v_u_2.common.skillTree.config.SkillConfig)
local v_u_7 = v_u_6.layout
local v_u_8 = require(v_u_2.common.skillTree.ui.SkillSquareGui.SkillSquareGui)
local v_u_9 = require(v_u_2.common.skillTree.ui.BoundingBoxOverlay.BoundingBoxOverlay)
local v_u_10 = require("./SkillTreeCamera").getTreeOrigin()
local v_u_11 = Vector2.new(4, 1)
local function v_u_19(p12) -- name: getSkillIcon
	-- upvalues: (copy) v_u_5
	local v13 = v_u_5.Images
	if v13 then
		v13 = v_u_5.Images.SkillTree
	end
	if not v13 then
		return nil
	end
	local v14 = p12:lower()
	for v15, v16 in v13 do
		if type(v16) == "string" and v15:lower() == v14 then
			return v16
		end
		if type(v16) == "table" then
			for v17, v18 in v16 do
				if v17:lower() == v14 then
					return v18
				end
			end
		end
	end
	return nil
end
local v_u_20 = {}
v_u_20.__index = v_u_20
function v_u_20.new() -- name: new
	-- upvalues: (copy) v_u_20, (copy) v_u_4
	local v21 = v_u_20
	local v22 = setmetatable({}, v21)
	v22.scope = v_u_4.scoped(v_u_4)
	v22.squares = {}
	v22.skillStates = {}
	v22.tierStates = {}
	v22.branchStates = {}
	v22.skillBoundingBoxes = {}
	v22.tierBoundingBoxes = {}
	v22.branchBoundingBoxes = {}
	v22.connectionLines = {}
	v22.skillConnectionLines = {}
	v22.branchConnectionLines = {}
	v22.tierConnectionLines = {}
	v22.container = Instance.new("Model")
	v22.container.Name = "SkillTreeSquares"
	v22.guiContainer = nil
	v22.onSkillClicked = nil
	return v22
end
function v_u_20.gridToWorld(p23, p24) -- name: gridToWorld
	-- upvalues: (copy) v_u_10
	local v25 = -p23 * 65
	local v26 = p24 * 65
	return v_u_10 + Vector3.new(v25, 0, v26)
end
function v_u_20.createSkillBoundingBox(p27, p28, p29) -- name: createSkillBoundingBox
	local v30 = Instance.new("Part")
	v30.Name = p28 .. "_BoundingBox"
	v30.Size = Vector3.new(50, 1, 50)
	v30.Position = p29 + Vector3.new(0, 6, 0)
	v30.Anchored = true
	v30.CanCollide = false
	v30.Transparency = 1
	v30.CastShadow = false
	local v31 = Instance.new("SurfaceGui")
	v31.Name = "LockOverlay"
	v31.Face = Enum.NormalId.Top
	v31.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	v31.Parent = v30
	p27.skillBoundingBoxes[p28] = v30
	return v30
end
function v_u_20.createTierBoundingBox(p32, p33, p34, p35) -- name: createTierBoundingBox
	-- upvalues: (copy) v_u_7, (copy) v_u_20, (copy) v_u_10, (copy) v_u_6, (copy) v_u_9
	if #p35 == 0 then
		return nil
	end
	local v36 = (1 / 0)
	local v37 = (-1 / 0)
	local v38 = (1 / 0)
	local v39 = (-1 / 0)
	for _, v40 in p35 do
		local v41 = v_u_7.getPosition(v40)
		if v41 then
			local v42 = v_u_20.gridToWorld(v41.row, v41.column)
			local v43 = v42.X - 25
			v36 = math.min(v36, v43)
			local v44 = v42.X + 25
			v37 = math.max(v37, v44)
			local v45 = v42.Z - 25
			v38 = math.min(v38, v45)
			local v46 = v42.Z + 25
			v39 = math.max(v39, v46)
		end
	end
	local v47 = v36 - 1
	local v48 = v37 + 1
	local v49 = v38 - 1
	local v50 = v39 + 1
	local v51 = v48 - v47
	local v52 = v50 - v49
	local v53 = (v47 + v48) / 2
	local v54 = (v49 + v50) / 2
	local v55 = p33 == "Core"
	local v56 = v55 and v_u_10.Y - 8 or v_u_10.Y - 5
	local v57 = Instance.new("Part")
	v57.Name = ("%*_Tier%*_BoundingBox"):format(p33, p34)
	v57.Size = Vector3.new(v51, 1, v52)
	v57.Position = Vector3.new(v53, v56, v54)
	v57.Anchored = true
	v57.CanCollide = false
	v57.Transparency = 1
	v57.CastShadow = false
	v57.CFrame = v57.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
	local v58 = ("%*_Tier%*"):format(p33, p34)
	local v59
	if p34 >= 2 then
		local v60 = v_u_6.getTierRequiredCount(p33, p34 - 1)
		v59 = ("Upgrade %* Tier %* skill%*"):format(v60, p34 - 1, v60 > 1 and "s" or "")
	else
		v59 = ""
	end
	local v61
	if v55 then
		v61 = nil
	else
		v61 = p32.scope:Value(true)
	end
	local v62 = {
		["locked"] = p32.scope:Value(true),
		["requiresText"] = p32.scope:Value(v59),
		["alwaysOnTop"] = v61
	}
	p32.tierStates[v58] = v62
	local v63 = v_u_9
	local v64 = {
		["scope"] = nil,
		["Locked"] = nil,
		["CornerRadius"] = 128,
		["StrokeThickness"] = 50,
		["RequiresText"] = nil,
		["ShowLockIcon"] = nil,
		["AlwaysOnTop"] = nil,
		["Adornee"] = nil,
		["scope"] = p32.scope,
		["Locked"] = v62.locked,
		["RequiresText"] = v62.requiresText,
		["ShowLockIcon"] = not v55
	}
	if v55 then
		v61 = false
	end
	v64.AlwaysOnTop = v61
	v64.Adornee = v57
	v63(v64).Parent = p32.guiContainer
	p32.tierBoundingBoxes[v58] = v57
	return v57
end
function v_u_20.createAllTierBoundingBoxes(p65) -- name: createAllTierBoundingBoxes
	-- upvalues: (copy) v_u_7
	for v66, v67 in v_u_7.combatTiers do
		local v68 = p65:createTierBoundingBox("Combat", v66, v67)
		if v68 then
			v68.Parent = p65.container
		end
	end
	for v69, v70 in v_u_7.survivalTiers do
		local v71 = p65:createTierBoundingBox("Survival", v69, v70)
		if v71 then
			v71.Parent = p65.container
		end
	end
	local v72 = p65:createTierBoundingBox("Core", 0, v_u_7.coreTiers[1])
	if v72 then
		v72.Parent = p65.container
	end
end
function v_u_20.createBranchBoundingBox(p73, p74, p75) -- name: createBranchBoundingBox
	-- upvalues: (copy) v_u_7, (copy) v_u_20, (copy) v_u_10, (copy) v_u_6, (copy) v_u_9
	local v76 = {}
	for _, v77 in p75 do
		for _, v78 in v77 do
			table.insert(v76, v78)
		end
	end
	if #v76 == 0 then
		return nil
	end
	local v79 = (1 / 0)
	local v80 = (-1 / 0)
	local v81 = (1 / 0)
	local v82 = (-1 / 0)
	for _, v83 in v76 do
		local v84 = v_u_7.getPosition(v83)
		if v84 then
			local v85 = v_u_20.gridToWorld(v84.row, v84.column)
			local v86 = v85.X - 25
			v79 = math.min(v79, v86)
			local v87 = v85.X + 25
			v80 = math.max(v80, v87)
			local v88 = v85.Z - 25
			v81 = math.min(v81, v88)
			local v89 = v85.Z + 25
			v82 = math.max(v82, v89)
		end
	end
	local v90 = v79 - 6
	local v91 = v80 + 6
	local v92 = v81 - 6
	local v93 = v82 + 6
	local v94 = v91 - v90
	local v95 = v93 - v92
	local v96 = (v90 + v91) / 2
	local v97 = (v92 + v93) / 2
	local v98 = Instance.new("Part")
	v98.Name = ("%*_BoundingBox"):format(p74)
	v98.Size = Vector3.new(v94, 1, v95)
	local v99 = v_u_10.Y - 8
	v98.Position = Vector3.new(v96, v99, v97)
	v98.Anchored = true
	v98.CanCollide = false
	v98.Transparency = 1
	v98.CastShadow = false
	v98.CFrame = v98.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
	local v100 = {
		["locked"] = p73.scope:Value(true)
	}
	p73.branchStates[p74] = v100
	local v101 = ""
	local v102 = v_u_7.coreTiers[1]
	if p74 == "Combat" then
		local v103 = v_u_6.getSkill(v102[3])
		v101 = ("Unlock %* to access the Combat tree"):format(v103 and v103.name or "Core 3")
	elseif p74 == "Survival" then
		local v104 = v_u_6.getSkill(v102[2])
		v101 = ("Unlock %* to access the Survival tree"):format(v104 and v104.name or "Core 2")
	end
	v_u_9({
		["scope"] = nil,
		["Locked"] = nil,
		["CornerRadius"] = 255,
		["StrokeThickness"] = 100,
		["RequiresText"] = nil,
		["ZOffset"] = 25,
		["TextMaxSize"] = nil,
		["Adornee"] = nil,
		["scope"] = p73.scope,
		["Locked"] = v100.locked,
		["RequiresText"] = v101,
		["TextMaxSize"] = Vector2.new(5000, 1000),
		["Adornee"] = v98
	}).Parent = p73.guiContainer
	p73.branchBoundingBoxes[p74] = v98
	return v98
end
function v_u_20.createAllBranchBoundingBoxes(p105) -- name: createAllBranchBoundingBoxes
	-- upvalues: (copy) v_u_7
	local v106 = p105:createBranchBoundingBox("Combat", v_u_7.combatTiers)
	if v106 then
		v106.Parent = p105.container
	end
	local v107 = p105:createBranchBoundingBox("Survival", v_u_7.survivalTiers)
	if v107 then
		v107.Parent = p105.container
	end
end
function v_u_20.createLine(p108, p109, p110, p111, p112, p113) -- name: createLine
	-- upvalues: (copy) v_u_11
	local v114 = Instance.new("Attachment")
	v114.Name = "LineStart"
	v114.Parent = p109
	local v115 = Instance.new("Attachment")
	v115.Name = "LineEnd"
	v115.Parent = p111
	local v116 = p110.X
	local v117 = p109.Position.Y
	local v118 = p110.Z
	v114.WorldPosition = Vector3.new(v116, v117, v118)
	local v119 = p112.X
	local v120 = p111.Position.Y
	local v121 = p112.Z
	v115.WorldPosition = Vector3.new(v119, v120, v121)
	local v122 = Instance.new("RopeConstraint")
	v122.Name = "ConnectionLine"
	v122.Attachment0 = v114
	v122.Attachment1 = v115
	v122.Visible = true
	v122.Thickness = v_u_11.X
	v122.Color = BrickColor.new(p113 or Color3.fromRGB(100, 100, 100))
	v122.Parent = p109
	local v123 = p108.connectionLines
	table.insert(v123, v122)
	return v122
end
function v_u_20.getTierCenter(p124, p125, p126) -- name: getTierCenter
	local v127 = ("%*_Tier%*"):format(p125, p126)
	local v128 = p124.tierBoundingBoxes[v127]
	if v128 then
		return v128.Position
	else
		return nil
	end
end
function v_u_20.getTierEdge(p129, p130, p131, p132) -- name: getTierEdge
	local v133 = ("%*_Tier%*"):format(p130, p131)
	local v134 = p129.tierBoundingBoxes[v133]
	if not v134 then
		return nil
	end
	local v135 = v134.Position
	local v136 = v134.Size
	if p132 == "left" then
		local v137 = -v136.Z / 2
		return v135 + Vector3.new(0, 0, v137)
	end
	if p132 == "right" then
		local v138 = v136.Z / 2
		return v135 + Vector3.new(0, 0, v138)
	end
	if p132 == "top" then
		local v139 = v136.X / 2
		return v135 + Vector3.new(v139, 0, 0)
	end
	if p132 ~= "bottom" then
		return v135
	end
	local v140 = -v136.X / 2
	return v135 + Vector3.new(v140, 0, 0)
end
function v_u_20.getBranchEdge(p141, p142, p143) -- name: getBranchEdge
	local v144 = p141.branchBoundingBoxes[p142]
	if not v144 then
		return nil
	end
	local v145 = v144.Position
	local v146 = v144.Size
	if p143 == "left" then
		local v147 = -v146.Z / 2
		return v145 + Vector3.new(0, 0, v147)
	end
	if p143 == "right" then
		local v148 = v146.Z / 2
		return v145 + Vector3.new(0, 0, v148)
	end
	if p143 == "top" then
		local v149 = v146.X / 2
		return v145 + Vector3.new(v149, 0, 0)
	end
	if p143 ~= "bottom" then
		return v145
	end
	local v150 = -v146.X / 2
	return v145 + Vector3.new(v150, 0, 0)
end
function v_u_20.createAllConnectionLines(p151) -- name: createAllConnectionLines
	-- upvalues: (copy) v_u_10, (copy) v_u_7, (copy) v_u_20
	local v152 = v_u_10.Y + -4
	local v153 = Color3.fromRGB(0, 0, 0)
	local v154 = Color3.fromRGB(0, 0, 0)
	local v155 = v_u_7.coreTiers[1]
	local v156 = v_u_7.getPosition(v155[2])
	local v157 = v_u_7.getPosition(v155[3])
	local v158 = p151:getTierBoundingBox("Core", 0)
	local v159 = p151:getBranchBoundingBox("Combat")
	local v160 = p151:getBranchBoundingBox("Survival")
	local v161 = p151:getTierEdge("Core", 0, "left")
	local v162 = p151:getBranchEdge("Survival", "right")
	if v161 and (v162 and (v156 and (v158 and v160))) then
		local v163 = v_u_20.gridToWorld(v156.row, v156.column).X
		local v164 = v161.Z
		local v165 = Vector3.new(v163, v152, v164)
		local v166 = v162.X
		local v167 = v162.Z
		local v168 = p151:createLine(v158, v165, v160, Vector3.new(v166, v152, v167), v154)
		p151.branchConnectionLines.Survival = v168
	end
	local v169 = p151:getTierEdge("Core", 0, "right")
	local v170 = p151:getBranchEdge("Combat", "left")
	if v169 and (v170 and (v157 and (v158 and v159))) then
		local v171 = v_u_20.gridToWorld(v157.row, v157.column).X
		local v172 = v169.Z
		local v173 = Vector3.new(v171, v152, v172)
		local v174 = v170.X
		local v175 = v170.Z
		local v176 = p151:createLine(v158, v173, v159, Vector3.new(v174, v152, v175), v153)
		p151.branchConnectionLines.Combat = v176
	end
	for v177 = 1, #v_u_7.survivalTiers - 1 do
		local v178 = p151:getTierBoundingBox("Survival", v177)
		local v179 = p151:getTierBoundingBox("Survival", v177 + 1)
		local v180 = p151:getTierEdge("Survival", v177, "left")
		local v181 = p151:getTierEdge("Survival", v177 + 1, "right")
		if v180 and (v181 and (v178 and v179)) then
			local v182 = v180.X
			local v183 = v180.Z
			local v184 = Vector3.new(v182, v152, v183)
			local v185 = v181.X
			local v186 = v181.Z
			local v187 = p151:createLine(v178, v184, v179, Vector3.new(v185, v152, v186), v154)
			p151.tierConnectionLines[("Survival_Tier%*_to_Tier%*"):format(v177, v177 + 1)] = v187
		end
	end
	for v188 = 1, #v_u_7.combatTiers - 1 do
		local v189 = p151:getTierBoundingBox("Combat", v188)
		local v190 = p151:getTierBoundingBox("Combat", v188 + 1)
		local v191 = p151:getTierEdge("Combat", v188, "right")
		local v192 = p151:getTierEdge("Combat", v188 + 1, "left")
		if v191 and (v192 and (v189 and v190)) then
			local v193 = v191.X
			local v194 = v191.Z
			local v195 = Vector3.new(v193, v152, v194)
			local v196 = v192.X
			local v197 = v192.Z
			local v198 = p151:createLine(v189, v195, v190, Vector3.new(v196, v152, v197), v153)
			p151.tierConnectionLines[("Combat_Tier%*_to_Tier%*"):format(v188, v188 + 1)] = v198
		end
	end
end
function v_u_20.createSkillConnectionLines(p199) -- name: createSkillConnectionLines
	-- upvalues: (copy) v_u_7
	local v200 = Color3.fromRGB(0, 0, 0)
	local v201 = v_u_7.coreTiers[1]
	for v202 = 1, #v201 - 1 do
		local v203 = v201[v202]
		local v204 = v201[v202 + 1]
		local v205 = p199.squares[v203]
		local v206 = p199.squares[v204]
		if v205 then
			v205 = v205:FindFirstChild("Top")
		end
		if v206 then
			v206 = v206:FindFirstChild("Top")
		end
		if v205 and v206 then
			local v207 = v205.Position
			local v208 = v205.Size
			local v209 = v206.Position
			local v210 = v206.Size
			local v211 = v207.X - v208.X / 2
			local v212 = v207.Y
			local v213 = v207.Z
			local v214 = Vector3.new(v211, v212, v213)
			local v215 = v209.X + v210.X / 2
			local v216 = v209.Y
			local v217 = v209.Z
			local v218 = p199:createLine(v205, v214, v206, Vector3.new(v215, v216, v217), v200)
			p199.skillConnectionLines[v203] = v218
		end
	end
end
function v_u_20.createSkillState(p219, p220) -- name: createSkillState
	-- upvalues: (copy) v_u_6, (copy) v_u_7
	local v221 = v_u_6.getSkill(p220)
	local v222
	if v221 then
		v222 = v221.name or p220
	else
		v222 = p220
	end
	local v223 = v221 and (v221.maxRank or 5) or 5
	local v224 = v221 and (v221.description or "") or ""
	local v225 = (v221 and v221.branch == "Core" or not v221) and 0 or (v221.tier or 0)
	local v226 = v221 and (v221.branch == "Core" and p220 == v_u_7.coreTiers[1][1]) and true or false
	local v227 = {
		["currentRank"] = p219.scope:Value(0),
		["maxRank"] = v223,
		["name"] = v222,
		["description"] = v224,
		["tier"] = v225,
		["showDescription"] = p219.scope:Value(false),
		["isPurchasable"] = p219.scope:Value(v226),
		["isSelected"] = p219.scope:Value(false),
		["isHovered"] = p219.scope:Value(false)
	}
	p219.skillStates[p220] = v227
	return v227
end
function v_u_20.createSurfaceGui(p_u_228, p229, p_u_230) -- name: createSurfaceGui
	-- upvalues: (copy) v_u_8, (copy) v_u_19
	local v_u_231 = p_u_228.skillStates[p_u_230] or p_u_228:createSkillState(p_u_230)
	v_u_8({
		["scope"] = p_u_228.scope,
		["SkillName"] = v_u_231.name,
		["CurrentRank"] = v_u_231.currentRank,
		["MaxRank"] = v_u_231.maxRank,
		["Description"] = v_u_231.description,
		["Icon"] = v_u_19(p_u_230),
		["ShowDescription"] = v_u_231.showDescription,
		["IsPurchasable"] = v_u_231.isPurchasable,
		["IsSelected"] = v_u_231.isSelected,
		["IsHovered"] = v_u_231.isHovered,
		["Tier"] = v_u_231.tier,
		["Adornee"] = p229,
		["OnClick"] = function() -- name: OnClick
			-- upvalues: (copy) p_u_228, (copy) p_u_230
			if p_u_228.onSkillClicked then
				p_u_228.onSkillClicked(p_u_230)
			end
		end,
		["OnHoverEnter"] = function() -- name: OnHoverEnter
			-- upvalues: (copy) v_u_231
			v_u_231.isHovered:set(true)
		end,
		["OnHoverLeave"] = function() -- name: OnHoverLeave
			-- upvalues: (copy) v_u_231
			v_u_231.isHovered:set(false)
		end
	}).Parent = p_u_228.guiContainer
end
function v_u_20.createSquare(p232, p233) -- name: createSquare
	-- upvalues: (copy) v_u_2, (copy) v_u_7, (copy) v_u_20
	local v234 = v_u_2.common:FindFirstChild("skillTree")
	if not v234 then
		warn("skillTree folder not found in ReplicatedStorage")
		return nil
	end
	local v235 = v234:FindFirstChild("skillSquare")
	if not v235 then
		warn("skillSquare template not found")
		return nil
	end
	local v236 = v_u_7.getPosition(p233)
	if not v236 then
		warn((("No position found for skill: %*"):format(p233)))
		return nil
	end
	p232:createSkillState(p233)
	local v237 = v235:Clone()
	v237.Name = p233
	local v238 = v_u_20.gridToWorld(v236.row, v236.column)
	v237:PivotTo(CFrame.new(v238))
	local v239 = v237:FindFirstChild("Top")
	local v240 = v237:FindFirstChild("Bottom")
	if v239 then
		v239.CastShadow = false
		v239.Material = Enum.Material.Metal
		v239.Color = Color3.fromRGB(91, 93, 105)
		p232:createSurfaceGui(v239, p233)
	end
	if v240 then
		v240.CastShadow = false
		v240.Material = Enum.Material.Metal
		v240.Color = Color3.fromRGB(17, 17, 17)
	end
	return v237
end
function v_u_20.render(p241, p242) -- name: render
	-- upvalues: (copy) v_u_1, (copy) v_u_6
	p241:clear()
	local v243 = v_u_1.LocalPlayer
	if v243 then
		p241.guiContainer = v243:WaitForChild("PlayerGui")
	end
	p241:createAllBranchBoundingBoxes()
	p241:createAllTierBoundingBoxes()
	p241:createAllConnectionLines()
	local v244 = v_u_6.getAllSkillIds()
	for _, v245 in v244 do
		local v246 = p241:createSquare(v245)
		if v246 then
			v246.Parent = p241.container
			p241.squares[v245] = v246
		end
	end
	p241:createSkillConnectionLines()
	p241.container.Parent = p242 or workspace
	print((("Rendered %* skill squares with bounding boxes"):format(#v244)))
end
local v_u_247 = {}
function v_u_20.clear(p248) -- name: clear
	-- upvalues: (copy) v_u_247
	for _, v249 in p248.squares do
		v249:Destroy()
	end
	for _, v250 in p248.tierBoundingBoxes do
		v250:Destroy()
	end
	for _, v251 in p248.branchBoundingBoxes do
		v251:Destroy()
	end
	for _, v252 in p248.connectionLines do
		v252:Destroy()
	end
	p248.guiContainer = nil
	p248.squares = {}
	p248.skillStates = {}
	p248.tierStates = {}
	p248.branchStates = {}
	p248.skillBoundingBoxes = {}
	p248.tierBoundingBoxes = {}
	p248.branchBoundingBoxes = {}
	p248.connectionLines = {}
	p248.skillConnectionLines = {}
	p248.branchConnectionLines = {}
	p248.tierConnectionLines = {}
	table.clear(v_u_247)
end
function v_u_20.getSquare(p253, p254) -- name: getSquare
	return p253.squares[p254]
end
local function v_u_271(p255, p256) -- name: updateSkillPurchasability
	-- upvalues: (copy) v_u_7, (copy) v_u_247, (copy) v_u_6
	local v257
	if p256 == "Combat" then
		v257 = v_u_7.combatTiers
	else
		v257 = v_u_7.survivalTiers
	end
	for v258, v259 in v257 do
		local v260
		if v258 == 1 then
			local v261 = v_u_7.coreTiers[1]
			local v262
			if p256 == "Survival" then
				v262 = v261[2]
			else
				v262 = v261[3]
			end
			v260 = (v_u_247[v262] or 0) >= 1
		else
			local v263 = v_u_6.getTierRequiredCount(p256, v258 - 1)
			local v264 = v258 - 1
			local v265
			if p256 == "Combat" then
				v265 = v_u_7.combatTiers
			else
				v265 = v_u_7.survivalTiers
			end
			local v266 = v265[v264]
			local v267
			if v266 then
				v267 = 0
				for _, v268 in v266 do
					v267 = v267 + (v_u_247[v268] or 0)
				end
			else
				v267 = 0
			end
			if v263 <= v267 then
				v260 = true
			else
				v260 = false
			end
		end
		for _, v269 in v259 do
			local v270 = p255.skillStates[v269]
			if v270 then
				v270.isPurchasable:set(v260)
			end
		end
	end
end
local function v_u_278(p272) -- name: updateCorePurchasability
	-- upvalues: (copy) v_u_7, (copy) v_u_247
	local v273 = v_u_7.coreTiers[1]
	for v274, v275 in v273 do
		local v276 = p272.skillStates[v275]
		if v276 then
			if v274 == 1 then
				v276.isPurchasable:set(true)
			else
				local v277 = v_u_247[v273[v274 - 1]] or 0
				v276.isPurchasable:set(v277 >= 1)
			end
		end
	end
end
local function v_u_304(p279, p280) -- name: updateTierStates
	-- upvalues: (copy) v_u_7, (copy) v_u_4, (copy) v_u_6, (copy) v_u_247, (copy) v_u_11
	local v281
	if p280 == "Combat" then
		v281 = v_u_7.combatTiers
	else
		v281 = v_u_7.survivalTiers
	end
	for v282 = 2, #v281 do
		local v283 = ("%*_Tier%*"):format(p280, v282)
		local v284 = p279.tierStates[v283]
		if v284 then
			local v285 = v_u_4.peek(v284.locked)
			local v286 = v_u_6.getTierRequiredCount(p280, v282 - 1)
			local v287 = v282 - 1
			local v288
			if p280 == "Combat" then
				v288 = v_u_7.combatTiers
			else
				v288 = v_u_7.survivalTiers
			end
			local v289 = v288[v287]
			local v290
			if v289 then
				v290 = 0
				for _, v291 in v289 do
					v290 = v290 + (v_u_247[v291] or 0)
				end
			else
				v290 = 0
			end
			local v292 = v286 - v290
			local v293 = math.max(0, v292)
			local v294 = v293 == 0
			local v295 = v285 and v294
			if v294 then
				v284.locked:set(false)
				v284.requiresText:set("")
				if v284.alwaysOnTop then
					v284.alwaysOnTop:set(false)
				end
			else
				v284.locked:set(true)
				v284.requiresText:set((("Upgrade %* Tier %* skill%*"):format(v293, v282 - 1, v293 > 1 and "s" or "")))
				if v284.alwaysOnTop then
					v284.alwaysOnTop:set(true)
				end
			end
			local v296 = ("%*_Tier%*_to_Tier%*"):format(p280, v282 - 1, v282)
			local v_u_297 = p279.tierConnectionLines[v296]
			if v_u_297 then
				v_u_297.Color = BrickColor.new(v294 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0))
				if v295 then
					local v_u_298 = v_u_11.X
					local v_u_299 = v_u_298 * 3
					local v_u_300 = 0
					task.spawn(function()
						-- upvalues: (ref) v_u_300, (copy) v_u_298, (copy) v_u_299, (copy) v_u_297
						while v_u_300 < 0.3 do
							v_u_300 = v_u_300 + task.wait()
							local v301 = v_u_300 / 0.3
							local v302 = math.min(v301, 1) * 3.141592653589793
							local v303 = math.sin(v302)
							v_u_297.Thickness = v_u_298 + (v_u_299 - v_u_298) * v303
						end
						v_u_297.Thickness = v_u_298
					end)
				end
			end
		end
	end
end
function v_u_20.setSkillRank(p305, p306, p307) -- name: setSkillRank
	-- upvalues: (copy) v_u_247, (copy) v_u_11, (copy) v_u_7, (copy) v_u_6, (copy) v_u_304, (copy) v_u_271, (copy) v_u_278
	local v308
	if (v_u_247[p306] or 0) < 1 then
		v308 = p307 >= 1
	else
		v308 = false
	end
	v_u_247[p306] = p307
	local v309 = p305.skillStates[p306]
	if v309 then
		v309.currentRank:set(p307)
	end
	local v_u_310 = p305.skillConnectionLines[p306]
	if v_u_310 then
		if p307 >= 1 then
			v_u_310.Color = BrickColor.new(Color3.fromRGB(255, 255, 255))
			if v308 then
				local v_u_311 = v_u_11.X
				local v_u_312 = v_u_311 * 3
				local v_u_313 = 0
				task.spawn(function()
					-- upvalues: (ref) v_u_313, (copy) v_u_311, (copy) v_u_312, (copy) v_u_310
					while v_u_313 < 0.3 do
						v_u_313 = v_u_313 + task.wait()
						local v314 = v_u_313 / 0.3
						local v315 = math.min(v314, 1) * 3.141592653589793
						local v316 = math.sin(v315)
						v_u_310.Thickness = v_u_311 + (v_u_312 - v_u_311) * v316
					end
					v_u_310.Thickness = v_u_311
				end)
			end
		else
			v_u_310.Color = BrickColor.new(Color3.fromRGB(0, 0, 0))
		end
	end
	local v317 = v_u_7.coreTiers[1]
	if p306 == v317[2] then
		local v318 = p307 >= 1
		local v319 = p305.branchStates.Survival
		if v319 then
			v319.locked:set(not v318)
		end
		local v320 = p305.tierStates.Survival_Tier1
		if v320 then
			v320.locked:set(not v318)
			if v320.alwaysOnTop then
				v320.alwaysOnTop:set(not v318)
			end
		end
		local v_u_321 = p305.branchConnectionLines.Survival
		if v_u_321 then
			v_u_321.Color = BrickColor.new(v318 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0))
			if v308 and v318 then
				local v_u_322 = v_u_11.X
				local v_u_323 = v_u_322 * 3
				local v_u_324 = 0
				task.spawn(function()
					-- upvalues: (ref) v_u_324, (copy) v_u_322, (copy) v_u_323, (copy) v_u_321
					while v_u_324 < 0.3 do
						v_u_324 = v_u_324 + task.wait()
						local v325 = v_u_324 / 0.3
						local v326 = math.min(v325, 1) * 3.141592653589793
						local v327 = math.sin(v326)
						v_u_321.Thickness = v_u_322 + (v_u_323 - v_u_322) * v327
					end
					v_u_321.Thickness = v_u_322
				end)
			end
		end
	elseif p306 == v317[3] then
		local v328 = p307 >= 1
		local v329 = p305.branchStates.Combat
		if v329 then
			v329.locked:set(not v328)
		end
		local v330 = p305.tierStates.Combat_Tier1
		if v330 then
			v330.locked:set(not v328)
			if v330.alwaysOnTop then
				v330.alwaysOnTop:set(not v328)
			end
		end
		local v_u_331 = p305.branchConnectionLines.Combat
		if v_u_331 then
			v_u_331.Color = BrickColor.new(v328 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 0, 0))
			if v308 and v328 then
				local v_u_332 = v_u_11.X
				local v_u_333 = v_u_332 * 3
				local v_u_334 = 0
				task.spawn(function()
					-- upvalues: (ref) v_u_334, (copy) v_u_332, (copy) v_u_333, (copy) v_u_331
					while v_u_334 < 0.3 do
						v_u_334 = v_u_334 + task.wait()
						local v335 = v_u_334 / 0.3
						local v336 = math.min(v335, 1) * 3.141592653589793
						local v337 = math.sin(v336)
						v_u_331.Thickness = v_u_332 + (v_u_333 - v_u_332) * v337
					end
					v_u_331.Thickness = v_u_332
				end)
			end
		end
	end
	local v338 = v_u_6.getSkill(p306)
	if v338 then
		if v338.branch == "Combat" then
			v_u_304(p305, "Combat")
			v_u_271(p305, "Combat")
			return
		end
		if v338.branch == "Survival" then
			v_u_304(p305, "Survival")
			v_u_271(p305, "Survival")
			return
		end
		if v338.branch == "Core" then
			v_u_278(p305)
			v_u_271(p305, "Combat")
			v_u_271(p305, "Survival")
		end
	end
end
function v_u_20.setSkillShowDescription(p339, p340, p341) -- name: setSkillShowDescription
	local v342 = p339.skillStates[p340]
	if v342 then
		v342.showDescription:set(p341)
	end
end
function v_u_20.setSkillSelected(p343, p344, p345) -- name: setSkillSelected
	local v346 = p343.skillStates[p344]
	if v346 then
		v346.isSelected:set(p345)
	end
end
function v_u_20.getSkillState(p347, p348) -- name: getSkillState
	return p347.skillStates[p348]
end
function v_u_20.getSkillBoundingBox(p349, p350) -- name: getSkillBoundingBox
	return p349.skillBoundingBoxes[p350]
end
function v_u_20.getTierBoundingBox(p351, p352, p353) -- name: getTierBoundingBox
	local v354 = ("%*_Tier%*"):format(p352, p353)
	return p351.tierBoundingBoxes[v354]
end
function v_u_20.getBranchBoundingBox(p355, p356) -- name: getBranchBoundingBox
	return p355.branchBoundingBoxes[p356]
end
function v_u_20.setTierLocked(p357, p358, p359, p360) -- name: setTierLocked
	local v361 = ("%*_Tier%*"):format(p358, p359)
	local v362 = p357.tierStates[v361]
	if v362 then
		v362.locked:set(p360)
	end
end
function v_u_20.setBranchLocked(p363, p364, p365) -- name: setBranchLocked
	local v366 = p363.branchStates[p364]
	if v366 then
		v366.locked:set(p365)
	end
end
function v_u_20.getTierState(p367, p368, p369) -- name: getTierState
	local v370 = ("%*_Tier%*"):format(p368, p369)
	return p367.tierStates[v370]
end
function v_u_20.setSkillTierAlwaysOnTop(p371, p372, p373) -- name: setSkillTierAlwaysOnTop
	-- upvalues: (copy) v_u_6, (copy) v_u_4
	local v374 = v_u_6.getSkill(p372)
	if v374 then
		if v374.branch ~= "Core" then
			local v375 = ("%*_Tier%*"):format(v374.branch, v374.tier)
			local v376 = p371.tierStates[v375]
			if v376 and v376.alwaysOnTop then
				if p373 and not v_u_4.peek(v376.locked) then
					return
				end
				v376.alwaysOnTop:set(p373)
			end
		end
	else
		return
	end
end
function v_u_20.getBranchState(p377, p378) -- name: getBranchState
	return p377.branchStates[p378]
end
function v_u_20.destroy(p379) -- name: destroy
	p379:clear()
	p379.scope:doCleanup()
	p379.container:Destroy()
end
return v_u_20