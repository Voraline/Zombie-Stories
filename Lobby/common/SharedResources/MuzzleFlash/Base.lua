local v1 = {}

local function changeHue(p1, p2) -- Line: 5
    local X
    if not p2 then
        return p1
    end
    local v1, v2, v3 = p1:ToHSV()
    local fromHSV = Color3.fromHSV
    if p2.X == 0 then
        X = v1
    else
        X = p2.X
        if not X then
            X = v1
        end
    end
    local v4 = math.clamp(X, 0, 1)
    local v5 = v2 + p2.Y
    local v6 = math.clamp(v5, 0, 1)
    local v7 = v3 + p2.Z
    return fromHSV(v4, v6, (math.clamp(v7, 0, 1)))
end

local function changeColorSequenceHue(p1, p2) -- Line: 14
    local Value, X, fromHSV, v1, v2, v3, v4, v5, v6, v7, v8
    if not p2 then
        return p1
    end
    local v9 = {}
    local v10 = p2
    for i, v in ipairs(p1.Keypoints) do
        Value = v.Value
        if not v10 then
            v8 = Value
        else
            v1, v2, v3 = Value:ToHSV()
            fromHSV = Color3.fromHSV
            if v10.X == 0 then
                X = v1
            else
                X = v10.X
                if not X then
                    X = v1
                end
            end
            v4 = math.clamp(X, 0, 1)
            v6 = v2 + v10.Y
            v5 = math.clamp(v6, 0, 1)
            v7 = v3 + v10.Z
            v8 = fromHSV(v4, v5, (math.clamp(v7, 0, 1)))
        end
        v2 = ColorSequenceKeypoint.new(v.Time, v8)
        table.insert(v9, v2)
    end
    return ColorSequence.new({unpack(v9)})
end

function v1.Emit(p1, p2) -- Line: 29 -- upvalues: changeColorSequenceHue (val)
    local MuzzleTimesShot, v1, v2
    local MuzzleModuleFX = p2.BarrelAttachment.MuzzleModuleFX
    if not p2.MuzzleEffects then
        local Color, X, fromHSV, v3, v4, v5, v6, v7, v8, v9, v10
        p2.MuzzleEffects = MuzzleModuleFX:GetChildren()
        local Attribute = p2.Model:GetAttribute("HSVChanges")
        local MuzzleEffects_2 = p2.MuzzleEffects
        v1 = nil
        v2 = nil
        for i, j in MuzzleEffects_2, v1, v2 do
            if j:IsA("Light") then
                j.Parent = j.Parent.Parent
                Color = j.Color
                if not Attribute then
                    v10 = Color
                else
                    v3, v4, v5 = Color:ToHSV()
                    fromHSV = Color3.fromHSV
                    if Attribute.X == 0 then
                        X = v3
                    else
                        X = Attribute.X
                        if not X then
                            X = v3
                        end
                    end
                    v6 = math.clamp(X, 0, 1)
                    v8 = v4 + Attribute.Y
                    v7 = math.clamp(v8, 0, 1)
                    v9 = v5 + Attribute.Z
                    v10 = fromHSV(v6, v7, (math.clamp(v9, 0, 1)))
                end
                j.Color = v10
            elseif j:IsA("ParticleEmitter") or j:IsA("Beam") or j:IsA("Trail") then
                j.Color = changeColorSequenceHue(j.Color, Attribute)
            end
        end
    end
    if not p2.MuzzleTimesShot then
        p2.MuzzleTimesShot = 0
    end
    p2.MuzzleTimesShot = p2.MuzzleTimesShot + 1
    local v11 = math.random(1, 100)
    local MuzzleEffects_3 = p2.MuzzleEffects
    v1 = nil
    v2 = nil
    for k, n in MuzzleEffects_3, v1, v2 do
        if n.Name:sub(1, 7) == "FlashFX" then
            if not n:IsA("Beam") then
                MuzzleTimesShot = p2.MuzzleTimesShot
                if not (math.random(3, 6) <= MuzzleTimesShot) or n.Name:sub(1, 7) ~= "FlashFX" then
                    n.Enabled = true
                else
                    p2.MuzzleTimesShot = 0
                end
            elseif n.Name:sub(1, 7) == "FlashFX" then
                if n:IsA("Beam") and v11 <= 25 then
                    n.Enabled = true
                end
            elseif n.Name:sub(1, 5) == "Smoke" and n:IsA("Beam") and v11 <= 25 then
                n.Enabled = true
            end
        elseif n.Name:sub(1, 5) ~= "Smoke" then
            if n.Name:sub(1, 7) == "FlashFX" then
                if n:IsA("Beam") and v11 <= 25 then
                    n.Enabled = true
                end
            elseif n.Name:sub(1, 5) == "Smoke" and n:IsA("Beam") and v11 <= 25 then
                n.Enabled = true
            end
        elseif not n:IsA("Beam") then
            MuzzleTimesShot = p2.MuzzleTimesShot
            if not (math.random(3, 6) <= MuzzleTimesShot) or n.Name:sub(1, 7) ~= "FlashFX" then
                n.Enabled = true
            else
                p2.MuzzleTimesShot = 0
            end
        elseif n.Name:sub(1, 7) == "FlashFX" then
            if n:IsA("Beam") and v11 <= 25 then
                n.Enabled = true
            end
        elseif n.Name:sub(1, 5) == "Smoke" and n:IsA("Beam") and v11 <= 25 then
            n.Enabled = true
        end
    end
    local MuzzleEffects = p2.MuzzleEffects
    task.delay(0.03333333333333333, function() -- Line: 66 -- upvalues: MuzzleEffects (val), p2 (val), MuzzleModuleFX (val)
        local v1 = MuzzleEffects
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Name:sub(1, 7) == "FlashFX" or j.Name:sub(1, 5) == "Smoke" then
                j.Enabled = false
            end
        end
        v1 = os.clock()
        p2.LastShot = v1
        if not MuzzleModuleFX.Parent then
            return
        end
        local Trail = MuzzleModuleFX.Trail
        Trail.Enabled = false
        task.wait(0.3)
        if p2.LastShot == v1 then
            Trail.Enabled = true
            task.wait(1.25)
            if p2.LastShot == v1 then
                Trail.Enabled = false
            end
        end
    end)
end

return v1