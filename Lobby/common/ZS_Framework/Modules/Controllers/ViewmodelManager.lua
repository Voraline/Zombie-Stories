local RunService = game:GetService("RunService")
local Value = Enum.RenderPriority.Last.Value
local v1 = {
    Equipped = {},
    ArmAssignments = {},
    Initialized = false,
    RenderStepBound = false,
    Equip = function(p1, p2, p3, p4) -- Line: 47
        if p2 and p2.Viewmodel then
            local v1 = {
                State = "Hidden",
                Weapon = p2,
                Viewmodel = p2.Viewmodel,
                ArmRequest = p3 or "Both",
                Priority = p4 or 10,
                GrantedArms = {Right = false, Left = false},
            }
            p1.Equipped[p2] = v1
            if p2.Viewmodel.ManagedByManager ~= nil then
                p2.Viewmodel.ManagedByManager = true
            end
            p1:ResolveArmConflicts()
            p1:EnsureRenderStep()
            return
        end
        warn("[ViewmodelManager] Cannot equip weapon without viewmodel")
    end,
    Unequip = function(p1, p2) -- Line: 80
        local v1 = p1.Equipped[p2]
        if not v1 then
            return
        end
        if p1.ArmAssignments.Right == p2 then
            p1.ArmAssignments.Right = nil
        end
        if p1.ArmAssignments.Left == p2 then
            p1.ArmAssignments.Left = nil
        end
        if v1.Viewmodel and v1.Viewmodel.ManagedByManager ~= nil then
            v1.Viewmodel.ManagedByManager = false
        end
        p1.Equipped[p2] = nil
        p1:ResolveArmConflicts()
        if next(p1.Equipped) == nil then
            p1:UnbindRenderStep()
        end
    end,
    SetPriority = function(p1, p2, p3) -- Line: 114
        local v1 = p1.Equipped[p2]
        if not v1 then
            warn("[ViewmodelManager] Cannot set priority - weapon not equipped")
            return
        end
        v1.Priority = p3
        p1:ResolveArmConflicts()
    end,
    SetArmRequest = function(p1, p2, p3) -- Line: 128
        local v1 = p1.Equipped[p2]
        if not v1 then
            warn("[ViewmodelManager] Cannot set arm request - weapon not equipped")
            return
        end
        v1.ArmRequest = p3
        p1:ResolveArmConflicts()
    end,
    GetState = function(p1, p2) -- Line: 144
        local State
        local v1 = p1.Equipped[p2]
        if not v1 then
            State = nil
        else
            State = v1.State
            if not State then
                State = nil
            end
        end
        return State
    end,
    GetGrantedArms = function(p1, p2) -- Line: 152
        local GrantedArms
        local v1 = p1.Equipped[p2]
        if not v1 then
            GrantedArms = nil
        else
            GrantedArms = v1.GrantedArms
            if not GrantedArms then
                GrantedArms = nil
            end
        end
        return GrantedArms
    end,
    IsArmAvailable = function(p1, p2) -- Line: 160
        local v1 = p1.ArmAssignments[p2] == nil
        return v1
    end,
    GetWeaponWithArm = function(p1, p2) -- Line: 167
        return p1.ArmAssignments[p2]
    end,
    GetEquippedWeapons = function(p1) -- Line: 173
        local v1 = {}
        local Equipped = p1.Equipped
        local v2 = nil
        local v3 = nil
        for i, j in Equipped, v2, v3 do
            table.insert(v1, i)
        end
        return v1
    end,
    GetEntry = function(p1, p2) -- Line: 184
        return p1.Equipped[p2]
    end,
    ResolveArmConflicts = function(self) -- Line: 192
        local ArmRequest, ArmRequest_2, v1
        self.ArmAssignments = {}
        local SortedByPriority = self:GetSortedByPriority()
        for i, v in ipairs(SortedByPriority) do
            ArmRequest_2 = v.ArmRequest
            v1 = self:TryGrantArms(ArmRequest_2)
            v.GrantedArms = v1
            v.PreviousState = v.State
            ArmRequest = v.ArmRequest
            v.State = self:ComputeState(ArmRequest, v1)
        end
    end,
    GetSortedByPriority = function(self) -- Line: 210
        local v1 = {}
        local Equipped = self.Equipped
        local v2 = nil
        local v3 = nil
        for i, j in Equipped, v2, v3 do
            table.insert(v1, j)
        end
        table.sort(v1, function(p1, p2) -- Line: 216
            local Priority = p1.Priority
            local v1 = p2.Priority < Priority
            return v1
        end)
        return v1
    end,
    TryGrantArms = function(self, p2) -- Line: 226
        local v1 = {Right = false, Left = false}
        if p2 == "Both" then
            if self.ArmAssignments.Right == nil and self.ArmAssignments.Left == nil then
                v1.Right = true
                v1.Left = true
                return v1
            end
            if self.ArmAssignments.Right == nil then
                v1.Right = true
                return v1
            end
            if self.ArmAssignments.Left ~= nil then
                return v1
            end
            v1.Left = true
            return v1
        end
        if p2 == "Right" then
            if self.ArmAssignments.Right ~= nil then
                return v1
            end
            v1.Right = true
            return v1
        end
        if p2 == "Left" then
            if self.ArmAssignments.Left ~= nil then
                return v1
            end
            v1.Left = true
            return v1
        end
        if p2 == "Either" then
            if self.ArmAssignments.Right == nil then
                v1.Right = true
                return v1
            end
            if self.ArmAssignments.Left == nil then
                v1.Left = true
            end
        end
        return v1
    end,
    ComputeState = function(p1, p2, p3) -- Line: 275
        local Right = p3.Right
        local Left = p3.Left
        local v1 = Right or Left
        if p2 == "Both" then
            if Right and Left then
                return "Full"
            end
            if v1 then
                return "OneHanded"
            end
            return "Lowered"
        end
        if p2 == "Right" then
            if Right then
                return "Full"
            end
            return "Lowered"
        end
        if p2 == "Left" then
            if Left then
                return "Full"
            end
            return "Lowered"
        end
        if p2 ~= "Either" then
            return "Hidden"
        end
        if v1 then
            return "Full"
        end
        return "Lowered"
    end,
}

function v1:ResolveArmConflicts() -- Line: 316
    local ArmRequest, GrantedArms, State, Viewmodel, v1
    self.ArmAssignments = {}
    local SortedByPriority = self:GetSortedByPriority()
    local v2 = self
    for i, v in ipairs(SortedByPriority) do
        v1 = {Right = false, Left = false}
        ArmRequest = v.ArmRequest
        if ArmRequest ~= "Both" then
            if ArmRequest ~= "Right" then
                if ArmRequest ~= "Left" then
                    if ArmRequest == "Either" then
                        if v2.ArmAssignments.Right == nil then
                            v1.Right = true
                            v2.ArmAssignments.Right = v.Weapon
                        elseif v2.ArmAssignments.Left == nil then
                            v1.Left = true
                            v2.ArmAssignments.Left = v.Weapon
                        end
                    end
                elseif v2.ArmAssignments.Left == nil then
                    v1.Left = true
                    v2.ArmAssignments.Left = v.Weapon
                end
            elseif v2.ArmAssignments.Right == nil then
                v1.Right = true
                v2.ArmAssignments.Right = v.Weapon
            end
        elseif v2.ArmAssignments.Right ~= nil then
            if v2.ArmAssignments.Right == nil then
                v1.Right = true
                v2.ArmAssignments.Right = v.Weapon
            elseif v2.ArmAssignments.Left == nil then
                v1.Left = true
                v2.ArmAssignments.Left = v.Weapon
            end
        elseif v2.ArmAssignments.Left == nil then
            v1.Right = true
            v1.Left = true
            v2.ArmAssignments.Right = v.Weapon
            v2.ArmAssignments.Left = v.Weapon
        elseif v2.ArmAssignments.Right == nil then
            v1.Right = true
            v2.ArmAssignments.Right = v.Weapon
        elseif v2.ArmAssignments.Left == nil then
            v1.Left = true
            v2.ArmAssignments.Left = v.Weapon
        end
        v.GrantedArms = v1
        v.PreviousState = v.State
        v.State = v2:ComputeState(ArmRequest, v1)
        Viewmodel = v.Viewmodel
        if Viewmodel and Viewmodel.ApplyManagerState then
            State = v.State
            GrantedArms = v.GrantedArms
            Viewmodel:ApplyManagerState(State, GrantedArms)
        end
    end
end

function v1:EnsureRenderStep() -- Line: 380 -- upvalues: RunService (val), Value (val)
    if self.RenderStepBound then
        return
    end
    self.RenderStepBound = true
    local v1 = RunService
    local v2 = Value - 1
    v1:BindToRenderStep("ViewmodelManager", v2, function(p1) -- Line: 386 -- upvalues: self (val)
        self:Update(p1)
    end)
end

function v1:UnbindRenderStep() -- Line: 392 -- upvalues: RunService (val)
    if not self.RenderStepBound then
        return
    end
    self.RenderStepBound = false
    RunService:UnbindFromRenderStep("ViewmodelManager")
end

function v1:Update(p2) -- Line: 403
    local GrantedArms, State, Viewmodel
    local Equipped = self.Equipped
    local v1 = nil
    local v2 = nil
    for i, j in Equipped, v1, v2 do
        Viewmodel = j.Viewmodel
        if Viewmodel and Viewmodel.ApplyManagerState then
            State = j.State
            GrantedArms = j.GrantedArms
            Viewmodel:ApplyManagerState(State, GrantedArms)
        end
    end
end

function v1.Init(p1) -- Line: 420
    if p1.Initialized then
        return
    end
    p1.Initialized = true
end

return v1