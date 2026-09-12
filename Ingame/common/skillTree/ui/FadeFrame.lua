local Players = game:GetService("Players")
local Packages = (game:GetService("ReplicatedStorage")).Packages
local Fusion = require(Packages.Fusion)
local Children = Fusion.Children
return function(p1) -- Line: 29 -- upvalues: Children (val), Players (val), Fusion (val)
    local scope = p1.scope
    local u5 = scope:Value(1)
    local u6 = 0
    local v1 = scope:New("ScreenGui")
    local v2 = {
        Name = "FadeFrame",
        DisplayOrder = 100,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    local v3 = Children
    v2[v3] = {
        scope:New("Frame")({
            Name = "Overlay",
            BorderSizePixel = 0,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = u5,
            Size = UDim2.fromScale(1, 1),
        }),
    }
    v1 = v1(v2)
    v1.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    return {
        gui = v1,
        transparency = u5,
        fadeIn = function(p1, p2, p3) -- Line: 64 -- upvalues: u6 (ref), Fusion (upval), u5 (val)
            u6 = u6 + 1
            local u5_2 = u6
            local u6_2 = p2 or 0.4
            local u10 = Fusion.peek(u5)
            local u11 = 0
            task.spawn(function() -- Line: 72 -- upvalues: u11 (ref), u6_2 (val), u5_2 (val), u6 (upval), u5 (upval), u10 (val), p3 (val)
                local v1, v2, v3, v4, v5, v6
                while u11 < u6_2 do
                    v1 = task.wait()
                    if u5_2 ~= u6 then
                        return
                    end
                    u11 = u11 + v1
                    v2 = u11 / u6_2
                    v2 = 1 - (1 - math.min(v2, 1)) ^ 2
                    v3 = u5
                    v5 = u10
                    v6 = u10
                    v4 = v5 + (0 - v6) * v2
                    v3:set(v4)
                end
                if u5_2 ~= u6 then
                    return
                end
                u5:set(0)
                if p3 then
                    p3()
                end
            end)
        end,
        fadeOut = function(p1, p2, p3) -- Line: 99 -- upvalues: u6 (ref), Fusion (upval), u5 (val)
            u6 = u6 + 1
            local u5_2 = u6
            local u6_2 = p2 or 0.4
            local u10 = Fusion.peek(u5)
            local u11 = 0
            task.spawn(function() -- Line: 107 -- upvalues: u11 (ref), u6_2 (val), u5_2 (val), u6 (upval), u5 (upval), u10 (val), p3 (val)
                local v1, v2, v3, v4, v5, v6
                while u11 < u6_2 do
                    v1 = task.wait()
                    if u5_2 ~= u6 then
                        return
                    end
                    u11 = u11 + v1
                    v2 = u11 / u6_2
                    v2 = 1 - (1 - math.min(v2, 1)) ^ 2
                    v3 = u5
                    v5 = u10
                    v6 = u10
                    v4 = v5 + (1 - v6) * v2
                    v3:set(v4)
                end
                if u5_2 ~= u6 then
                    return
                end
                u5:set(1)
                if p3 then
                    p3()
                end
            end)
        end,
        setTransparency = function(p1, p2) -- Line: 133 -- upvalues: u6 (ref), u5 (val)
            u6 = u6 + 1
            u5:set(p2)
        end,
    }
end