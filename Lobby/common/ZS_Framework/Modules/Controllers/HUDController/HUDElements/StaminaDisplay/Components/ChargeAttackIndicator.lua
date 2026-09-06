local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
return function(p1) -- Line: 11
    local scope = p1.scope
    local v1 = scope:Computed(function(a1) -- Line: 14 -- upvalues: p1 (val)
        if a1(p1.showReady) then
            return (UDim2.fromScale(0.5, 0.5))
        end
        return (UDim2.fromScale(1, 1))
    end)
    local v2 = scope:Computed(function(a1) -- Line: 18 -- upvalues: p1 (val)
        if a1(p1.showReady) then
            return 0
        end
        return 1
    end)
    local v3 = scope:Computed(function(a1) -- Line: 22 -- upvalues: p1 (val)
        if a1(p1.showReady) then
            return (Color3.fromRGB(255, 137, 101))
        end
        return (Color3.fromRGB(255, 255, 255))
    end)
    local v4 = scope:Spring(v1, 15, 0.6)
    local v5 = scope:Spring(v2, 20, 1)
    local v6 = scope:Spring(v3, 20, 1)
    local v7 = scope:New("ImageLabel")
    return v7({
        Name = "ChargeAttack",
        Image = "rbxassetid://14503290950",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
        AnchorPoint = Vector2.new(0.5, 0.5),
        ImageColor3 = v6,
        ImageTransparency = v5,
        Position = UDim2.fromScale(1.25, 0.5),
        ScaleType = Enum.ScaleType.Fit,
        Size = v4,
    })
end