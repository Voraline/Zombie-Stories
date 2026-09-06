local Players = game:GetService("Players")
local Fusion = require(game:GetService("ReplicatedStorage").Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
return function(p1) -- Line: 22 -- upvalues: Children (val), OnEvent (val), Players (val)
    local scope = p1.scope
    local v1 = scope:Computed(function(a1) -- Line: 26 -- upvalues: p1 (val)
        local IsOpen = p1.IsOpen
        if IsOpen == nil then
            return true
        end
        return not a1(IsOpen)
    end)
    local v2 = scope:New("ScreenGui")
    local v3 = {Name = "SkillTreeToggleGui", ZIndexBehavior = Enum.ZIndexBehavior.Sibling, ResetOnSpawn = false}
    local v4 = {}
    local v5 = scope:New("TextButton")
    local v6 = {
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
    v6[Activated] = function() -- Line: 60 -- upvalues: p1 (val)
        if p1.OnOpen then
            p1.OnOpen()
        end
    end
    local v7 = {}
    local v8 = scope:New("UICorner")
    v8 = v8({Name = "UICorner"})
    local v9 = scope:New("UIPadding")
    v9 = v9({Name = "UIPadding", PaddingBottom = UDim.new(0.1, 0), PaddingLeft = UDim.new(0.1, 0), PaddingRight = UDim.new(0.1, 0)})
    local v10 = scope:New("UIStroke")
    v10 = v10({Name = "UIStroke", Thickness = 1.5})
    local v11 = scope:New("UIStroke")
    local v12 = {Name = "UIStroke2", Thickness = 1.5, Transparency = 0.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border}
    v7[1] = v8
    v7[2] = v9
    v7[3] = v10
    v7[4] = v11(v12)
    v6[Children] = v7
    v4[1] = v5(v6)
    v3[Children] = v4
    v2 = v2(v3)
    v2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    return v2
end