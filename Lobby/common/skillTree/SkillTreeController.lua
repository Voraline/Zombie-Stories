local v_u_1 = game:GetService("UserInputService")
local v2 = game:GetService("ReplicatedStorage").Packages
local v_u_3 = require(v2.Fusion)
require("./SkillTreeRenderer")
local v_u_4 = require("./SkillTreeCamera")
local v_u_5 = {}
v_u_5.__index = v_u_5
function v_u_5.new(p6, p7) -- name: new
	-- upvalues: (copy) v_u_5, (copy) v_u_3
	local v8 = v_u_5
	local v_u_9 = setmetatable({}, v8)
	v_u_9.renderer = p6
	v_u_9.camera = p7
	v_u_9.selectedSkillId = nil
	v_u_9.isAnimating = false
	v_u_9.animatingSkillId = nil
	v_u_9.currentAnimationId = 0
	v_u_9.connections = {}
	v_u_9.onBuyCallback = nil
	v_u_9.scope = v_u_3.scoped(v_u_3)
	v_u_9.selectedSkillValue = v_u_9.scope:Value(nil)
	function p6.onSkillClicked(p10)
		-- upvalues: (copy) v_u_9
		v_u_9:onSkillClicked(p10)
	end
	v_u_9:setupClickAwayDetection()
	return v_u_9
end
function v_u_5.onSkillClicked(p11, p12) -- name: onSkillClicked
	if p11.animatingSkillId == p12 then
		return
	elseif p11.selectedSkillId == p12 then
		p11:deselectSkill()
	else
		local v13 = p11.selectedSkillId or p11.animatingSkillId
		if v13 then
			p11:resetCardInstant(v13)
		end
		p11:selectSkill(p12)
	end
end
function v_u_5.selectSkill(p14, p15) -- name: selectSkill
	p14.selectedSkillId = p15
	p14.selectedSkillValue:set(p15)
	p14.renderer:setSkillSelected(p15, true)
	p14.renderer:setSkillTierAlwaysOnTop(p15, false)
	p14:tweenCameraToSkill(p15)
	p14:flipCard(p15, true)
end
function v_u_5.resetCardInstant(p16, p17) -- name: resetCardInstant
	-- upvalues: (copy) v_u_4
	local v18 = p16.renderer:getSquare(p17)
	if v18 then
		p16.currentAnimationId = p16.currentAnimationId + 1
		p16.isAnimating = false
		if p16.animatingSkillId == p17 then
			p16.animatingSkillId = nil
		end
		p16.renderer:setSkillShowDescription(p17, false)
		p16.renderer:setSkillSelected(p17, false)
		p16.renderer:setSkillTierAlwaysOnTop(p17, true)
		local v19 = v_u_4.getSkillWorldPosition(p17)
		if v19 then
			v18:PivotTo(CFrame.new(v19))
		end
	end
end
function v_u_5.deselectSkill(p20, p21) -- name: deselectSkill
	if p20.selectedSkillId then
		local v22 = p20.selectedSkillId
		p20.selectedSkillId = nil
		p20.selectedSkillValue:set(nil)
		p20.renderer:setSkillSelected(v22, false)
		p20.renderer:setSkillTierAlwaysOnTop(v22, true)
		p20:flipCard(v22, false, p21)
	elseif p21 then
		p21()
	end
end
function v_u_5.tweenCameraToSkill(p_u_23, p24) -- name: tweenCameraToSkill
	-- upvalues: (copy) v_u_4
	local v25 = v_u_4.getSkillWorldPosition(p24)
	if v25 then
		local v_u_26 = p_u_23.camera.targetPosition
		local v27 = v25.X
		local v28 = v_u_26.Y
		local v29 = v25.Z
		local v_u_30 = Vector3.new(v27, v28, v29)
		local v_u_31 = 0
		task.spawn(function()
			-- upvalues: (ref) v_u_31, (copy) p_u_23, (copy) v_u_26, (copy) v_u_30
			while v_u_31 < 0.3 do
				v_u_31 = v_u_31 + task.wait()
				local v32 = v_u_31 / 0.3
				local v33 = 1 - (1 - math.min(v32, 1)) ^ 2
				p_u_23.camera.targetPosition = v_u_26:Lerp(v_u_30, v33)
			end
		end)
	end
end
function v_u_5.flipCard(p_u_34, p_u_35, p_u_36, p_u_37) -- name: flipCard
	-- upvalues: (copy) v_u_4
	local v_u_38 = p_u_34.renderer:getSquare(p_u_35)
	if v_u_38 then
		p_u_34.currentAnimationId = p_u_34.currentAnimationId + 1
		local v_u_39 = p_u_34.currentAnimationId
		p_u_34.isAnimating = true
		p_u_34.animatingSkillId = p_u_35
		local v40 = v_u_4.getSkillWorldPosition(p_u_35)
		local v_u_41 = v40 and CFrame.new(v40) or v_u_38:GetPivot()
		v_u_38:PivotTo(v_u_41)
		local v_u_42 = false
		local v_u_43 = 0
		task.spawn(function()
			-- upvalues: (ref) v_u_43, (copy) p_u_34, (copy) v_u_39, (copy) v_u_38, (copy) v_u_41, (ref) v_u_42, (copy) p_u_35, (copy) p_u_36, (copy) p_u_37
			while v_u_43 < 0.4 do
				local v44 = task.wait()
				if p_u_34.currentAnimationId ~= v_u_39 then
					return
				end
				v_u_43 = v_u_43 + v44
				local v45 = v_u_43 / 0.4
				local v46 = math.min(v45, 1)
				local v47
				if v46 < 0.5 then
					v47 = v46 * 2 * v46
				else
					v47 = 1 - (v46 * -2 + 2) ^ 2 / 2
				end
				local v48 = v47 * 6.283185307179586
				v_u_38:PivotTo(v_u_41 * CFrame.fromAxisAngle(Vector3.new(1, 0, 0), v48))
				if not v_u_42 and v_u_43 >= 0.2 then
					v_u_42 = true
					p_u_34.renderer:setSkillShowDescription(p_u_35, p_u_36)
				end
			end
			if p_u_34.currentAnimationId == v_u_39 then
				v_u_38:PivotTo(v_u_41)
				p_u_34.renderer:setSkillShowDescription(p_u_35, p_u_36)
				p_u_34.isAnimating = false
				p_u_34.animatingSkillId = nil
				if p_u_37 then
					p_u_37()
				end
			end
		end)
	elseif p_u_37 then
		p_u_37()
	end
end
function v_u_5.setupClickAwayDetection(p_u_49) -- name: setupClickAwayDetection
	-- upvalues: (copy) v_u_1
	local v52 = v_u_1.InputBegan:Connect(function(p50, p51)
		-- upvalues: (copy) p_u_49
		if p50.UserInputType == Enum.UserInputType.MouseButton1 then
			if not p51 then
				if p_u_49.selectedSkillId and not p_u_49.isAnimating then
					p_u_49:deselectSkill()
				end
			end
		else
			return
		end
	end)
	local v53 = p_u_49.connections
	table.insert(v53, v52)
end
function v_u_5.getSelectedSkill(p54) -- name: getSelectedSkill
	return p54.selectedSkillId
end
function v_u_5.isFlipping(p55) -- name: isFlipping
	return p55.isAnimating
end
function v_u_5.getScope(p56) -- name: getScope
	return p56.scope
end
function v_u_5.getSelectedSkillValue(p57) -- name: getSelectedSkillValue
	return p57.selectedSkillValue
end
function v_u_5.getSelectedSkillRankComputed(p_u_58) -- name: getSelectedSkillRankComputed
	return p_u_58.scope:Computed(function(p59)
		-- upvalues: (copy) p_u_58
		local v60 = p59(p_u_58.selectedSkillValue)
		if not v60 then
			return 0
		end
		local v61 = p_u_58.renderer:getSkillState(v60)
		return not v61 and 0 or p59(v61.currentRank)
	end)
end
function v_u_5.setOnBuyCallback(p62, p63) -- name: setOnBuyCallback
	p62.onBuyCallback = p63
end
function v_u_5.handleBuy(p64) -- name: handleBuy
	if p64.selectedSkillId and p64.onBuyCallback then
		p64.onBuyCallback(p64.selectedSkillId)
	end
end
function v_u_5.handleExit(p65) -- name: handleExit
	p65:deselectSkill()
end
function v_u_5.destroy(p66) -- name: destroy
	for _, v67 in p66.connections do
		v67:Disconnect()
	end
	p66.connections = {}
	p66.renderer.onSkillClicked = nil
	p66.scope:doCleanup()
end
return v_u_5