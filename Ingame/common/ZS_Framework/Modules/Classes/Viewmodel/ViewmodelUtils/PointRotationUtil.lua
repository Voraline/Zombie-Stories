workspace:WaitForChild("Ignore")
local u5 = {}
CFrame.new()
local u8 = nil
local u9 = {}
local u10 = nil
local u15 = CFrame.new(0.588401794, -0.546500206, -4.0329895)
local v1 = {
    NewWeapon = function(p1) -- Line: 19 -- upvalues: u8 (ref), u5 (val), u9 (ref)
        local v1
        u8 = p1
        if p1 and p1.Model then
            v1 = u5
            local v2 = u5[p1]
            if not v2 then
                v2 = {}
            end
            v1[p1] = v2
        end
        if p1 then
            v1 = u5[p1]
            if not v1 then
                v1 = {}
            end
            u9 = v1
        end
    end,
    SetActiveViewmodel = function(p1) -- Line: 32 -- upvalues: u10 (ref), u5 (val)
        u10 = p1
        if p1 then
            local v1 = u5
            local v2 = u5[p1]
            if not v2 then
                v2 = {}
            end
            v1[p1] = v2
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
        local v1, v2, v3
        if not u10 then
            v1 = u9
            v2 = {}
            v3 = p2
            if not v3 then
                v3 = u15
            end
            v2[1] = v3
            v2[2] = p3
            v2[3] = p4
            v1[p1] = v2
            return
        end
        v1 = u5
        v2 = u10
        v3 = u5[u10]
        if not v3 then
            v3 = {}
        end
        v1[v2] = v3
        v1 = u5[u10]
        v2 = {}
        v3 = p2
        if not v3 then
            v3 = u15
        end
        v2[1] = v3
        v2[2] = p3
        v2[3] = p4
        v1[p1] = v2
    end,
    UpdateGlobalRotation = function(p1, p2, p3, p4) -- Line: 57 -- upvalues: u9 (ref), u15 (val)
        local v1 = u9
        local v2 = {}
        local v3 = p2
        if not v3 then
            v3 = u15
        end
        v2[1] = v3
        v2[2] = p3
        v2[3] = p4
        v1[p1] = v2
    end,
    GetRotation = function(p1) -- Line: 61 -- upvalues: u10 (ref), u5 (val), u9 (ref)
        local v1
        if u10 and u5[u10] then
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
        if not u9[p1] then
            v1 = CFrame.new()
        else
            v1 = u9[p1][2]
            if not v1 then
                v1 = CFrame.new()
            end
        end
        return v1
    end,
}

local function null(p1) -- Line: 70
    local v1 = false
    if p1 <= 0.0001 then
        v1 = -0.0001 <= p1
    end
    return v1
end

function v1.Update(p1, p2, p3, p4, p5, p6, p7) -- Line: 74 -- upvalues: u8 (ref), u5 (val), u9 (ref)
    local ProcessRotation, v1, v2, v3, v4
    local u8_2 = p7
    if not u8_2 then
        u8_2 = u8
    end
    local v5 = false
    if p7 and u5[p7] then
        v4 = u5[p7]
        v5 = true
        if u8_2 and v4 then
            function ProcessRotation(p1, p2_2, p3_2) -- Line: 100
                -- upvalues: u8_2 (val), p5 (val), p3 (val), p6 (val), p4 (val), p2 (val)
                local CFrame_2, v1, v2, v3
                local Barrel = u8_2.Barrel
                local Aimpart = u8_2.Aimpart
                local AimOffset = u8_2.Config.AimOffset
                if not AimOffset then
                    AimOffset = CFrame.new()
                end
                local v4 = p2_2[3]
                if not p2_2[1] then
                    table.clear(p3_2[p1])
                    p3_2[p1] = nil
                    return
                end
                if p2_2[1] == "Barrel" then
                    v3 = Barrel
                elseif p2_2[1] ~= "Aimpart" then
                    v3 = p2_2[1]
                else
                    v3 = Aimpart
                end
                if not v3 then
                    table.clear(p3_2[p1])
                    p3_2[p1] = nil
                    return
                end
                if typeof(v3) ~= "Instance" or not v3.Parent then
                    CFrame_2 = p5 * v3
                else
                    CFrame_2 = v3.CFrame
                end
                if p3 and not v4 and Aimpart then
                    v1 = Aimpart.CFrame * AimOffset * p6
                    v2 = p4
                    local Position = v2.Position
                    CFrame_2 = CFrame_2:Lerp(v1, Position)
                end
                v1 = p2
                local CFrame_3 = v1.PrimaryPart.CFrame
                local v5 = CFrame_2:toObjectSpace(CFrame_3)
                v1 = (CFrame_2 * p2_2[2]):toWorldSpace(v5)
                if (v1.p - CFrame.new().Position).Magnitude < 0.001 then
                    local v6, v7
                    v2, v6, v7 = v1:ToAxisAngle()
                    if (math.abs(v2)) < 0.001 and (math.abs(v6)) < 0.001 and (math.abs(v7)) < 0.001 then
                        v1 = CFrame.new()
                    end
                end
                p2.PrimaryPart.CFrame = v1
            end

            v1 = v4
            v2 = nil
            v3 = nil
            for i, j in v1, v2, v3 do
                ProcessRotation(i, j, v4)
            end
            if v5 then
                v1 = u9
                v2 = nil
                v3 = nil
                for k, n in v1, v2, v3 do
                    if not v4[k] then
                        ProcessRotation(k, n, u9)
                    end
                end
            end
            return
        end
        return
    end
    local Model = u8
    if Model then
        Model = u8.Model
    end
    if Model ~= p2 then
        return
    end
    v4 = u9
    if u8_2 and v4 then
        function ProcessRotation(p1, p2_2, p3_2) -- Line: 100
            -- upvalues: u8_2 (val), p5 (val), p3 (val), p6 (val), p4 (val), p2 (val)
            local CFrame_2, v1, v2, v3
            local Barrel = u8_2.Barrel
            local Aimpart = u8_2.Aimpart
            local AimOffset = u8_2.Config.AimOffset
            if not AimOffset then
                AimOffset = CFrame.new()
            end
            local v4 = p2_2[3]
            if not p2_2[1] then
                table.clear(p3_2[p1])
                p3_2[p1] = nil
                return
            end
            if p2_2[1] == "Barrel" then
                v3 = Barrel
            elseif p2_2[1] ~= "Aimpart" then
                v3 = p2_2[1]
            else
                v3 = Aimpart
            end
            if not v3 then
                table.clear(p3_2[p1])
                p3_2[p1] = nil
                return
            end
            if typeof(v3) ~= "Instance" or not v3.Parent then
                CFrame_2 = p5 * v3
            else
                CFrame_2 = v3.CFrame
            end
            if p3 and not v4 and Aimpart then
                v1 = Aimpart.CFrame * AimOffset * p6
                v2 = p4
                local Position = v2.Position
                CFrame_2 = CFrame_2:Lerp(v1, Position)
            end
            v1 = p2
            local CFrame_3 = v1.PrimaryPart.CFrame
            local v5 = CFrame_2:toObjectSpace(CFrame_3)
            v1 = (CFrame_2 * p2_2[2]):toWorldSpace(v5)
            if (v1.p - CFrame.new().Position).Magnitude < 0.001 then
                local v6, v7
                v2, v6, v7 = v1:ToAxisAngle()
                if (math.abs(v2)) < 0.001 and (math.abs(v6)) < 0.001 and (math.abs(v7)) < 0.001 then
                    v1 = CFrame.new()
                end
            end
            p2.PrimaryPart.CFrame = v1
        end

        v1 = v4
        v2 = nil
        v3 = nil
        for m, i5 in v1, v2, v3 do
            ProcessRotation(m, i5, v4)
        end
        if v5 then
            v1 = u9
            v2 = nil
            v3 = nil
            for i6, i7 in v1, v2, v3 do
                if not v4[i6] then
                    ProcessRotation(i6, i7, u9)
                end
            end
        end
        return
    end
end

return v1