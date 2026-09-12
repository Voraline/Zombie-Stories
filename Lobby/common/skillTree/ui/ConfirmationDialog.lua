local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
require(ReplicatedStorage.Packages.Fusion)
local UIKit = require(ReplicatedStorage.common.ZS_Framework.UI.UIKit)
local Theme = require(ReplicatedStorage.common.ZS_Framework.UI.Theme)
return function(p1) -- Line: 18 -- upvalues: Players (val), UIKit (val), Theme (val)
    local u3 = p1:innerScope()
    local u7 = u3:Value(false)
    local u11 = u3:Value("")
    local u15 = u3:Value("")
    local u16 = nil
    local v1 = u3:New("ScreenGui")({
        Name = "ConfirmationDialog",
        DisplayOrder = 25,
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    local v2 = UIKit
    local Modal = v2.Modal
    local v3 = {
        Name = "SkillTreeConfirmation",
        scope = u3,
        Parent = v1,
        Open = u7,
        Title = u11,
        Text = u15,
        TextColor = Theme.Menu.TextMuted,
        Size = UDim2.fromOffset(430, 0),
    }
    local v4 = {}
    local v5 = {
        Text = "YES",
        Color = Theme.Menu.Positive,
        TextColor = Theme.Menu.Text,
        StrokeColor = Theme.Menu.NavigationColors.Play.Accent,
        BackgroundColor = Theme.Menu.NavigationColors.Play.Fill,
        GradientColor = Theme.Menu.NavigationColors.Play.Gradient,
        OnClick = function() -- Line: 51 -- upvalues: u16 (ref)
            local v1 = u16
            u16 = nil
            if v1 then
                v1()
            end
        end,
    }
    local v6 = {
        Text = "NO",
        Color = Theme.Colors.CloseButton,
        TextColor = Theme.Menu.Text,
        StrokeColor = Theme.Menu.NavigationColors.Cancel.Accent,
        BackgroundColor = Theme.Menu.NavigationColors.Cancel.Fill,
        GradientColor = Theme.Menu.NavigationColors.Cancel.Gradient,
        OnClick = function() -- Line: 66 -- upvalues: u16 (ref)
            u16 = nil
        end,
    }
    v4[1] = v5
    v4[2] = v6
    v3.Buttons = v4

    function v3.OnClose() -- Line: 71 -- upvalues: u16 (ref)
        u16 = nil
    end

    Modal(v3)
    return {
        show = function(p1, p2, p3, p4) -- Line: 77 -- upvalues: u11 (val), u15 (val), u16 (ref), u7 (val)
            u11:set(p2)
            u15:set(p3)
            u16 = p4
            u7:set(true)
        end,
        destroy = function(p1) -- Line: 83 -- upvalues: u3 (val)
            u3:doCleanup()
        end,
    }
end