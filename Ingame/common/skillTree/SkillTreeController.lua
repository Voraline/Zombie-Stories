local UserInputService = game:GetService("UserInputService")
local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)
require("./SkillTreeRenderer")
local u19 = require("./SkillTreeCamera")
local u20 = {}
u20.__index = u20
function u20.new(p1, p2) -- Line: 46 -- upvalues: u20 (val), Fusion (val)
    local u5 = setmetatable({}, u20)
    u5.renderer = p1
    u5.camera = p2
    u5.selectedSkillId = nil
    u5.isAnimating = false
    u5.animatingSkillId = nil
    u5.currentAnimationId = 0
    u5.connections = {}
    u5.onBuyCallback = nil
    u5.scope = Fusion.scoped(Fusion)
    u5.selectedSkillValue = u5.scope:Value(nil)
    function p1.onSkillClicked(p1) -- Line: 66 -- upvalues: u5 (val)
        u5:onSkillClicked(p1)
    end
    u5:setupClickAwayDetection()
    return u5
end
function u20:onSkillClicked(p2) -- Line: 79
    local selectedSkillId
    self.renderer:clearHoverStates()
    if self.animatingSkillId == p2 then
        return
    end
    if self.selectedSkillId == p2 then
        self:deselectSkill()
        return
    end
    selectedSkillId = self.selectedSkillId
    if not selectedSkillId then
        selectedSkillId = self.animatingSkillId
    end
    if selectedSkillId then
        self:resetCardInstant(selectedSkillId)
    end
    self:selectSkill(p2)
end
function u20:selectSkill(p2) -- Line: 107
    self.selectedSkillId = p2
    self.selectedSkillValue:set(p2)
    self.renderer:setSkillSelected(p2, true)
    self.renderer:setSkillTierAlwaysOnTop(p2, false)
    self:tweenCameraToSkill(p2)
    self:flipCard(p2, true)
end
function u20:resetCardInstant(p2) -- Line: 127 -- upvalues: u19 (val)
    local v1 = self.renderer:getSquare(p2)
    if not v1 then
        return
    end
    self.currentAnimationId = self.currentAnimationId + 1
    self.isAnimating = false
    if self.animatingSkillId == p2 then
        self.animatingSkillId = nil
    end
    self.renderer:setSkillShowDescription(p2, false)
    self.renderer:setSkillSelected(p2, false)
    self.renderer:setSkillTierAlwaysOnTop(p2, true)
    local v2 = u19.getSkillWorldPosition(p2)
    if v2 then
        v1:PivotTo(CFrame.new(v2))
    end
end
function u20:deselectSkill(p2) -- Line: 157
    local selectedSkillId
    self.renderer:clearHoverStates()
    if not self.selectedSkillId then
        if p2 then
            p2()
        end
        return
    end
    selectedSkillId = self.selectedSkillId
    self.selectedSkillId = nil
    self.selectedSkillValue:set(nil)
    self.renderer:setSkillSelected(selectedSkillId, false)
    self.renderer:setSkillTierAlwaysOnTop(selectedSkillId, true)
    self:flipCard(selectedSkillId, false, p2)
end
function u20:tweenCameraToSkill(p2) -- Line: 183 -- upvalues: u19 (val)
    local v1 = u19.getSkillWorldPosition(p2)
    if not v1 then
        return
    end
    local targetPosition = self.camera.targetPosition
    local u12 = Vector3.new(v1.X, targetPosition.Y, v1.Z)
    local u13 = 0
    task.spawn(function() -- Line: 195 -- upvalues: u13 (ref), self (val), targetPosition (val), u12 (val)
        local v1
        while u13 < 0.3 do
            u13 = u13 + task.wait()
            v1 = 1 - (1 - math.min(u13 / 0.3, 1)) ^ 2
            self.camera.targetPosition = targetPosition:Lerp(u12, v1)
        end
    end)
end
function u20:flipCard(p2, p3, p4) -- Line: 212 -- upvalues: u19 (val)
    local Pivot
    local u8 = self.renderer:getSquare(p2)
    if not u8 then
        if p4 then
            p4()
        end
        return
    end
    self.currentAnimationId = self.currentAnimationId + 1
    local currentAnimationId = self.currentAnimationId
    self.isAnimating = true
    self.animatingSkillId = p2
    local v1 = u19.getSkillWorldPosition(p2)
    if not v1 then
        Pivot = u8:GetPivot()
    else
        Pivot = CFrame.new(v1)
        if not Pivot then
            Pivot = u8:GetPivot()
        end
    end
    u8:PivotTo(Pivot)
    local u32 = false
    local u33 = 0
    task.spawn(function() -- Line: 246 -- upvalues: u33 (ref), self (val), currentAnimationId (val), u8 (val), Pivot (val), u32 (ref), p2 (val), p3 (val), p4 (val)
        local v1, v2, v3
        while u33 < 0.4 do
            if self.currentAnimationId ~= currentAnimationId then
                return
            end
            u33 = u33 + task.wait()
            v2 = u33 / 0.4
            v1 = math.min(v2, 1)
            if v1 >= 0.5 then
                v2 = 1 - (v1 * -2 + 2) ^ 2 / 2
            else
                v2 = v1 * 2 * v1
            end
            v3 = CFrame.fromAxisAngle(Vector3.new(1, 0, 0), v2 * 6.283185307179586)
            u8:PivotTo(Pivot * v3)
            if not u32 and 0.2 <= u33 then
                u32 = true
                self.renderer:setSkillShowDescription(p2, p3)
            end
        end
        if self.currentAnimationId ~= currentAnimationId then
            return
        end
        u8:PivotTo(Pivot)
        self.renderer:setSkillShowDescription(p2, p3)
        self.isAnimating = false
        self.animatingSkillId = nil
        if p4 then
            p4()
        end
    end)
end
function u20:setupClickAwayDetection() -- Line: 302 -- upvalues: UserInputService (val)
    local v1 = UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 303 -- upvalues: self (val)
        if p1.UserInputType ~= Enum.UserInputType.MouseButton1 or p2 then
            return
        end
        if self.selectedSkillId and not self.isAnimating then
            self:deselectSkill()
        end
    end)
    table.insert(self.connections, v1)
end
function u20.getSelectedSkill(p1) -- Line: 327
    return p1.selectedSkillId
end
function u20.isFlipping(p1) -- Line: 334
    return p1.isAnimating
end
function u20.getScope(p1) -- Line: 341
    return p1.scope
end
function u20.getSelectedSkillValue(p1) -- Line: 348
    return p1.selectedSkillValue
end
function u20.getSelectedSkillRankComputed(p1) -- Line: 356
    return p1.scope:Computed(function(a1) -- Line: 357 -- upvalues: p1 (val)
        local v1 = a1(p1.selectedSkillValue)
        if not v1 then
            return 0
        end
        local v2 = p1.renderer:getSkillState(v1)
        if not v2 then
            return 0
        end
        return a1(v2.currentRank)
    end)
end
function u20.setOnBuyCallback(p1, p2) -- Line: 375
    p1.onBuyCallback = p2
end
function u20.handleBuy(p1) -- Line: 382
    if p1.selectedSkillId and p1.onBuyCallback then
        p1.onBuyCallback(p1.selectedSkillId)
    end
end
function u20.handleExit(p1) -- Line: 391
    p1:deselectSkill()
end
function u20.destroy(p1) -- Line: 398
    local connections = p1.connections
    local v1 = nil
    local v2 = nil
    for i, j in connections, v1, v2 do
        j:Disconnect()
    end
    p1.connections = {}
    p1.renderer.onSkillClicked = nil
    p1.scope:doCleanup()
end
return u20