local v1 = {}
function v1:LoadAnimation(p2) -- Line: 3
    local HitboxModelPointer = self:WaitForChild("HitboxModelPointer")
    local Value = HitboxModelPointer.Value
    if not Value then
        while not Value do
            Value = HitboxModelPointer.Value
            task.wait()
        end
    end
    local HP = Value:WaitForChild("HP")
    local NPCHumanoid = self:WaitForChild("NPCHumanoid")
    local u30 = p2:LoadAnimation(script.Animations.Walk)
    u30.Priority = Enum.AnimationPriority.Idle
    local u37 = p2:LoadAnimation(script.Animations.Idle)
    u37.Priority = Enum.AnimationPriority.Core
    local u44 = p2:LoadAnimation(script.Animations.Death)
    u44.Priority = Enum.AnimationPriority.Action
    local Stunned = script.Animations.Stunned
    local u51 = p2:LoadAnimation(Stunned)
    u51.Priority = Enum.AnimationPriority.Movement
    local u57 = nil
    local u63 = NPCHumanoid.Running:Connect(function(p1) -- Line: 33 -- upvalues: HP (val), NPCHumanoid (val), u30 (val), u37 (val)
        if 0.2 >= p1 or 0 >= HP.Value then
            u30:Stop()
            u37:Play()
            return
        end
        local v1 = math.min(p1, NPCHumanoid.WalkSpeed)
        if u30.IsPlaying ~= false then
            u30:AdjustSpeed(v1 / NPCHumanoid.WalkSpeed)
        else
            u30:Play(0.1, 1, v1 / NPCHumanoid.WalkSpeed)
        end
        u37:Stop()
    end)
    local u69 = NPCHumanoid.Jumping:Connect(function() -- Line: 49 -- upvalues: HP (val), u30 (val)
        if 0 < HP.Value then
            u30:Stop()
        end
    end)
    local u75 = HP.Changed:Connect(function(p1) -- Line: 56 -- upvalues: u44 (val)
        if p1 <= 0 then
            u44:Play()
            return
        end
        u44:Stop()
    end)
    local u81 = Value.AttributeChanged:Connect(function(p1) -- Line: 63 -- upvalues: Value (ref), u51 (val)
        if Value:GetAttribute("Stunned") then
            u51:Play()
            return
        end
        u51:Stop()
    end)
    local HumanoidRootPart = self:WaitForChild("HumanoidRootPart")
    local PropertyChangedSignal = HumanoidRootPart:GetPropertyChangedSignal("Parent")
end
return v1