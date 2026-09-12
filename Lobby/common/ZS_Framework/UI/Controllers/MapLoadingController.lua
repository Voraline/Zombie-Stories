local u2 = require("../../Data/PlayerDatabase")
local u3 = {}
local u4 = nil

function u3.SetLoadingScreen(p1) -- Line: 7 -- upvalues: u4 (ref), u2 (val)
    if u4 then
        u4:doCleanup()
    end
    if not p1 then
        return
    end
    u4 = u2.Scope:innerScope()
    local v1 = u4:New("ScreenGui")
    local v2 = {
        Name = "MapLoadingScreen",
        Parent = u2.PlayerGui,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.None,
        DisplayOrder = 10,
    }
    local v3 = u4
    local Children = v3.Children
    local v4 = {}
    local v5 = u4:New("Frame")
    local v6 = {BackgroundColor3 = Color3.fromRGB(0, 0, 0), Size = UDim2.new(1, 0, 1, 0)}
    local v7 = u4
    local Children_2 = v7.Children
    v6[Children_2] = {
        u4:New("TextLabel")({
            Text = "LOADING MAP",
            BackgroundTransparency = 1,
            TextScaled = true,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.new(0.5, 0, 0.25, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Font = Enum.Font.GothamBold,
        }),
    }
    v4[1] = v5(v6)
    v2[Children] = v4
    v1(v2)
end

if workspace:GetAttribute("MapLoading") then
    u3.SetLoadingScreen(true)
end
;(workspace:GetAttributeChangedSignal("MapLoading")):Connect(function() -- Line: 51 -- upvalues: u3 (val)
    u3.SetLoadingScreen(workspace:GetAttribute("MapLoading"))
end)
return u3