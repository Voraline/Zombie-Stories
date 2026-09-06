local v1 = {}
local function changeHue(p1, p2) -- Line: 5
    local X, v1, v2, v3
    if not p2 then
        return p1
    end
    v1, v2, v3 = p1:ToHSV()
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
    local v5 = math.clamp(v2 + p2.Y, 0, 1)
    local v6 = v3 + p2.Z
    return fromHSV(v4, v5, (math.clamp(v6, 0, 1)))
end
local function changeColorSequenceHue(p1, p2) -- Line: 14
    local Value, X, fromHSV, v1, v2, v3, v4, v5, v6, v7
    if not p2 then
        return p1
    end
    local v8 = {}
    local v9 = p2
    for i, v in ipairs(p1.Keypoints) do
        Value = v.Value
        if not v9 then
            v7 = Value
        else
            v1, v2, v3 = Value:ToHSV()
            fromHSV = Color3.fromHSV
            if v9.X == 0 then
                X = v1
            else
                X = v9.X
            end
            v4 = math.clamp(X, 0, 1)
            v5 = math.clamp(v2 + v9.Y, 0, 1)
            v6 = v3 + v9.Z
            v7 = fromHSV(v4, v5, (math.clamp(v6, 0, 1)))
        end
        table.insert(v8, ColorSequenceKeypoint.new(v.Time, v7))
    end
    return ColorSequence.new({unpack(v8)})
end
function v1.Emit(p1, p2) -- Line: 29 -- upvalues: changeColorSequenceHue (val)
    local MuzzleEffects, MuzzleTimesShot, u194, v1, v2
    local MuzzleModuleFX = p2.BarrelAttachment.MuzzleModuleFX
    if p2.MuzzleEffects then
        u194 = p2
    else
        local Color, X, fromHSV, v3, v4, v5, v6, v7, v8, v9
        p2.MuzzleEffects = MuzzleModuleFX:GetChildren()
        local Attribute = p2.Model:GetAttribute("HSVChanges")
        local MuzzleEffects_2 = p2.MuzzleEffects
        v1 = nil
        v2 = nil
        u194 = p2
        for i, j in MuzzleEffects_2, v1, v2 do
            if j:IsA("Light") then
                j.Parent = j.Parent.Parent
                Color = j.Color
                if not Attribute then
                    v9 = Color
                else
                    v3, v4, v5 = Color:ToHSV()
                    fromHSV = Color3.fromHSV
                    if Attribute.X == 0 then
                        X = v3
                    else
                        X = Attribute.X
                    end
                    v6 = math.clamp(X, 0, 1)
                    v7 = math.clamp(v4 + Attribute.Y, 0, 1)
                    v8 = v5 + Attribute.Z
                    v9 = fromHSV(v6, v7, (math.clamp(v8, 0, 1)))
                end
                j.Color = v9
            elseif j:IsA("ParticleEmitter") then
                j.Color = changeColorSequenceHue(j.Color, Attribute)
            elseif not (j:IsA("Beam")) and not (j:IsA("Trail")) then
            end
        end
    end
    if not u194.MuzzleTimesShot then
        u194.MuzzleTimesShot = 0
    end
    u194.MuzzleTimesShot = u194.MuzzleTimesShot + 1
    local v10 = math.random(1, 100)
    local MuzzleEffects_3 = u194.MuzzleEffects
    v1 = nil
    v2 = nil
    for k, n in MuzzleEffects_3, v1, v2 do
        if n.Name:sub(1, 7) == "FlashFX" then
            if not (n:IsA("Beam")) then
                MuzzleTimesShot = u194.MuzzleTimesShot
                if math.random(3, 6) > MuzzleTimesShot then
                    n.Enabled = true
                elseif n.Name:sub(1, 7) == "FlashFX" then
                    u194.MuzzleTimesShot = 0
                end
            elseif n.Name:sub(1, 7) == "FlashFX" then
                if n:IsA("Beam") and v10 <= 25 then
                    n.Enabled = true
                end
            elseif n.Name:sub(1, 5) ~= "Smoke" then
            end
        elseif n.Name:sub(1, 5) ~= "Smoke" then
        end
    end
    MuzzleEffects = u194.MuzzleEffects
    task.delay(0.03333333333333333, function() -- Line: 66 -- upvalues: MuzzleEffects (val), u194 (val), MuzzleModuleFX (val)
        local v1 = MuzzleEffects
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if j.Name:sub(1, 7) == "FlashFX" then
                j.Enabled = false
            elseif j.Name:sub(1, 5) ~= "Smoke" then
            end
        end
        v1 = os.clock()
        u194.LastShot = v1
        if not MuzzleModuleFX.Parent then
            return
        end
        local Trail = MuzzleModuleFX.Trail
        Trail.Enabled = false
        task.wait(0.3)
        if u194.LastShot == v1 then
            Trail.Enabled = true
            task.wait(1.25)
            if u194.LastShot == v1 then
                Trail.Enabled = false
            end
        end
    end)
end
return v1