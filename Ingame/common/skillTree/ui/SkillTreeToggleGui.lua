local Players = game:GetService("Players")
local Packages = (game:GetService("ReplicatedStorage")).Packages
local Fusion = require(Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
return function(p1) -- Line: 22 -- upvalues: Children (val), OnEvent (val), Players (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(p1_2) -- Line: 26 -- upvalues: p1 (val)
        local IsOpen = p1.IsOpen
        if IsOpen == nil then
            return true
        end
        return not p1_2(IsOpen)
    end)
    local v2 = scope:New("ScreenGui")
    local v3 = {Name = "SkillTreeToggleGui", ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false}
    local v4 = Children
    local v5 = {}
    local v6 = scope:New("TextButton")
    local v7 = {
        Name = "TextButton",
        BackgroundColor3 = Color3.fromRGB(49, 183, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
        Position = UDim2.fromScale(0.0121, 0.468),
        Size = UDim2.fromOffset(200, 50),
        Text = "Open Skill Tree",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        Visible = v1,
    }
    local Activated = OnEvent("Activated")

    v7[Activated] = function() -- Line: 60 -- upvalues: p1 (val)
        if p1.OnOpen then
            p1.OnOpen()
        end
    end

    local v8 = Children
    local v9 = {}
    local v10 = scope:New("UICorner")({Name = "UICorner"})
    local v11 = scope:New("UIPadding")({
        Name = "UIPadding",
        PaddingBottom = UDim.new(0.1, 0),
        PaddingLeft = UDim.new(0.1, 0),
        PaddingRight = UDim.new(0.1, 0),
    })
    local v12 = scope:New("UIStroke")({Name = "UIStroke", Thickness = 1.5})
    local v13 = scope:New("UIStroke")
    local v14 = {
        Name = "UIStroke2",
        Thickness = 1.5,
        Transparency = 0.5,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }
    v9[1] = v10
    v9[2] = v11
    v9[3] = v12
    v9[4] = v13(v14)
    v7[v8] = v9
    v5[1] = v6(v7)
    v3[v4] = v5
    v2 = v2(v3)
    v2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    return v2
end