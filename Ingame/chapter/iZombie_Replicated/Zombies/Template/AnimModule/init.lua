return {
    LoadAnimation = function(self, p2) -- Line: 3
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
        local Walk = script.Animations.Walk
        local u30 = p2:LoadAnimation(Walk)
        u30.Priority = Enum.AnimationPriority.Idle
        local Idle = script.Animations.Idle
        local u37 = p2:LoadAnimation(Idle)
        u37.Priority = Enum.AnimationPriority.Core
        local Death = script.Animations.Death
        local u44 = p2:LoadAnimation(Death)
        u44.Priority = Enum.AnimationPriority.Action
        local Stunned = script.Animations.Stunned
        local u51 = p2:LoadAnimation(Stunned)
        u51.Priority = Enum.AnimationPriority.Movement
        local u57 = nil
        local u63 = NPCHumanoid.Running:Connect(function(p1) -- Line: 33 -- upvalues: HP (val), NPCHumanoid (val), u30 (val), u37 (val)
            if 0.2 < p1 and 0 < HP.Value then
                local v1
                local v2 = NPCHumanoid
                local WalkSpeed = v2.WalkSpeed
                local v3 = math.min(p1, WalkSpeed)
                if u30.IsPlaying ~= false then
                    v1 = u30
                    local v4 = NPCHumanoid
                    v2 = v3 / v4.WalkSpeed
                    v1:AdjustSpeed(v2)
                else
                    v1 = u30
                    local v5 = NPCHumanoid
                    local v6 = v3 / v5.WalkSpeed
                    v1:Play(0.1, 1, v6)
                end
                u37:Stop()
                return
            end
            u30:Stop()
            u37:Play()
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
        local v1 = (HumanoidRootPart:GetPropertyChangedSignal("Parent")):Connect(function() -- Line: 72 -- upvalues: HumanoidRootPart (val), u63 (ref), u69 (ref), u75 (ref), u81 (ref), u57 (ref)
            if not HumanoidRootPart.Parent then
                if u63 then
                    u63:Disconnect()
                    u63 = nil
                end
                if u69 then
                    u69:Disconnect()
                    u69 = nil
                end
                if u75 then
                    u75:Disconnect()
                    u75 = nil
                end
                if u81 then
                    u81:Disconnect()
                    u81 = nil
                end
                if u57 then
                    u57:Disconnect()
                    u57 = nil
                end
            end
        end)
    end,
}