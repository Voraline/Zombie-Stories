workspace:WaitForChild("Ignore")
local u5 = {}
CFrame.new()
local u8 = nil
local u9 = {}
local u10 = nil
local u15 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
local v1 = {
    NewWeapon = function(p1) -- Line: 19 -- upvalues: u8 (ref), u5 (val), u9 (ref)
        u8 = p1
        if p1 and p1.Model then
            local v1 = u5[p1]
            if not v1 then
                v1 = {}
            end
            u5[p1] = v1
        end
        if p1 then
            local v2 = u5[p1]
            if not v2 then
                v2 = {}
            end
            u9 = v2
        end
    end,
    SetActiveViewmodel = function(p1) -- Line: 32 -- upvalues: u10 (ref), u5 (val)
        u10 = p1
        if p1 then
            local v1 = u5[p1]
            if not v1 then
                v1 = {}
            end
            u5[p1] = v1
        end
    end,
    GetViewmodelRotations = function(p1) -- Line: 40 -- upvalues: u5 (val)
        local v1 = u5[p1]
        if not v1 then
            v1 = {}
        end
        return v1
    end,
    UpdateRotation = function(p1, p2, p3, p4) -- Line: 44 -- upvalues: u10 (ref), u5 (val), u15 (val), u9 (ref)
        local v1, v2
        if not u10 then
            v1 = {}
            v2 = p2
            if not v2 then
                v2 = u15
            end
            v1[1] = v2
            v1[2] = p3
            v1[3] = p4
            u9[p1] = v1
            return
        end
        v2 = u5[u10]
        if not v2 then
            v2 = {}
        end
        u5[u10] = v2
        v1 = {}
        v2 = p2
        if not v2 then
            v2 = u15
        end
        v1[1] = v2
        v1[2] = p3
        v1[3] = p4
        u5[u10][p1] = v1
    end,
    UpdateGlobalRotation = function(p1, p2, p3, p4) -- Line: 57 -- upvalues: u9 (ref), u15 (val)
        local v1 = {}
        local v2 = p2
        if not v2 then
            v2 = u15
        end
        v1[1] = v2
        v1[2] = p3
        v1[3] = p4
        u9[p1] = v1
    end,
    GetRotation = function(p1) -- Line: 61 -- upvalues: u10 (ref), u5 (val), u9 (ref)
        local v1
        if not u10 then
            if not (u9[p1]) then
                v1 = CFrame.new()
            else
                v1 = u9[p1][2]
                if not v1 then
                    v1 = CFrame.new()
                end
            end
            return v1
        elseif u5[u10] then
            local v2
            v1 = u5[u10][p1]
            if not v1 then
                v2 = CFrame.new()
            else
                v2 = v1[2]
                if not v2 then
                    v2 = CFrame.new()
                end
            end
            return v2
        end
    end,
}
local function null(p1) -- Line: 70
    local v1 = if p1 <= 0.0001 then -0.0001 <= p1 else false
    return v1
end
function v1.Update(p1, p2, p3, p4, p5, p6, p7) -- Line: 74 -- upvalues: u8 (ref), u5 (val), u9 (ref)
    local v1
    local u8 = p7
    if not u8 then
        u8 = u8
    end
    local v2 = false
    if not p7 then
        local v3, v4, v5
        local Model = u8
        if Model then
            Model = u8.Model
        end
        if Model ~= p2 then
            return
        end
        v1 = u9
        if not u8 or not v1 then
            return
        end
        local function ProcessRotation(p1, a2, a3) -- Line: 100 -- upvalues: u8 (val), p5 (val), p3 (val), p6 (val), p4 (val), p2 (val)
            local CFrame, v1
            local Aimpart = u8.Aimpart
            local AimOffset = u8.Config.AimOffset
            if not AimOffset then
                AimOffset = CFrame.new()
            end
            local v2 = a2[3]
            if not (a2[1]) then
                table.clear(a3[p1])
                a3[p1] = nil
                return
            end
            if a2[1] == "Barrel" then
                v1 = u8.Barrel
            elseif a2[1] ~= "Aimpart" then
                v1 = a2[1]
            else
                v1 = Aimpart
            end
            if not v1 then
                table.clear(a3[p1])
                a3[p1] = nil
                return
            end
            if typeof(v1) ~= "Instance" then
                CFrame = p5 * v1
            elseif v1.Parent then
                CFrame = v1.CFrame
            end
            if p3 and not v2 and Aimpart then
                CFrame = CFrame:Lerp(Aimpart.CFrame * AimOffset * p6, p4.Position)
            end
            local v3 = CFrame:toObjectSpace(p2.PrimaryPart.CFrame)
            local v4 = (CFrame * a2[2]):toWorldSpace(v3)
            if (v4.p - CFrame.new().Position).Magnitude < 0.001 then
                local v5, v6, v7
                v5, v6, v7 = v4:ToAxisAngle()
                local v8 = math.abs(v5)
                if v8 < 0.001 then
                    v8 = math.abs(v6)
                    if v8 < 0.001 then
                        v8 = math.abs(v7)
                        if v8 < 0.001 then
                            v4 = CFrame.new()
                        end
                    end
                end
            end
            p2.PrimaryPart.CFrame = v4
        end
        v3 = v1
        v4 = nil
        v5 = nil
        for i, j in v3, v4, v5 do
            ProcessRotation(i, j, v1)
        end
        if v2 then
            v3 = u9
            v4 = nil
            v5 = nil
            for k, n in v3, v4, v5 do
                if not (v1[k]) then
                    ProcessRotation(k, n, u9)
                end
            end
        end
        return
    elseif u5[p7] then
        v1 = u5[p7]
        v2 = true
    end
end
return v1