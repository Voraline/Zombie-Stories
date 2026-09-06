local Generate
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local peek = require(ReplicatedStorage.Packages.Fusion).peek
local HUDService = require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local u26 = require("@game/ReplicatedStorage/common/Settings")
local v1 = require("@game/ReplicatedStorage/common/BindUtil")
require("@game/ReplicatedStorage/common/Signal")
local NVGs = require(script.Parent.Parent.Parent.Parent.Classes.Viewmodel.ViewmodelUtils:WaitForChild("NVGs"))
local u49 = require("@game/ReplicatedStorage/common/HintSystem")
local Remotes = game.ReplicatedStorage.common:WaitForChild("Remotes")
local Net = Remotes:WaitForChild("Net")
local Remotes_2 = game.ReplicatedStorage.common:WaitForChild("Remotes")
Remotes_2:WaitForChild("DataRemote")
local Sounds = script.Sounds
local ButtonTemplate = require(script.ButtonTemplate)
local Edit = require(script.Edit)
local Parent = script.Parent.Parent.Parent
local u89 = nil
local u90 = nil
local u91 = nil
local u92 = nil
local Folder = Instance.new("Folder")
local PlayerScripts = game.Players.LocalPlayer:WaitForChild("PlayerScripts")
local ControlScript = PlayerScripts:WaitForChild("ControlScript")
require(ControlScript:WaitForChild("MasterControl"))
local UserInputService = game:GetService("UserInputService")
local u118 = {}
local u119 = {}
local u120 = nil
local u121 = false
local u122 = false
local u123 = nil
local u124 = nil
local u125 = nil
local u126 = nil
local u127 = {IsShowing = false, EditData = {}}
local v2 = {}
u127.PresetData = v2
local function createTouchButton(p1, p2, p3) -- Line: 55 -- upvalues: u92 (ref), ButtonTemplate (val)
    local v1 = u92.TouchControlFrame.JumpButton:Clone()
    if not (v1:FindFirstChildWhichIsA("UIScale")) then
        Instance.new("UIScale").Parent = v1
    end
    v1.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
    v1.Name = p1
    v1.ImageRectOffset = Vector2.new(0, 0)
    v1.ImageRectSize = Vector2.new(146, 146)
    v1.ImageTransparency = 0.5
    v1.ImageColor3 = Color3.fromRGB(199, 223, 255)
    local v2 = ButtonTemplate.TextLabel:Clone()
    v2.Text = p3
    v2.Visible = false
    v2.Parent = v1
    local v3 = ButtonTemplate.ImageLabel:Clone()
    v3.Image = p2
    v3.Parent = v1
    return v1, v3, v2
end
local function touchPosToScreenPos(p1) -- Line: 77 -- upvalues: GuiService (val)
    return UDim2.new(p1.X.Scale, p1.X.Offset, p1.Y.Scale, p1.Y.Offset + GuiService.TopbarInset.Height * (1 - p1.Y.Scale))
end
local function getFrameCenterInTouchGui(p1) -- Line: 83 -- upvalues: GuiService (val)
    local AbsoluteSize
    if not p1 or p1.AbsoluteSize.X == 0 then
        return nil
    end
    local AbsolutePosition = p1.AbsolutePosition
    AbsoluteSize = p1.AbsoluteSize
    return UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2 - GuiService.TopbarInset.Height)
end
function Generate(p1) -- Line: 95 -- upvalues: u122 (ref), u89 (ref), Parent (val), u90 (ref), u91 (ref), u92 (ref), u121 (ref), u118 (ref), u120 (ref), u127 (val), Folder (val), u119 (val), createTouchButton (val), u124 (ref), Sounds (val), u49 (val), NVGs (val), peek (val), u26 (val), Generate (val), GuiService (val), HUDService (val), u126 (ref), u125 (ref), Edit (val), UserInputService (val), Net (val), u123 (ref)
    local v1
    if not u122 then
        u89 = require(Parent.LocalPlayerController)
        u90 = require(Parent.WeaponController)
        u91 = require(Parent.CameraController)
        local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        u92 = PlayerGui:WaitForChild("TouchGui")
        u92.DisplayOrder = 1
    end
    if not p1 then
        local AbsolutePosition, AbsoluteSize, new, u112, u113, u1312, u1313, u172, u173, u200, u475, u476, u477, u555, v2, v3
        if u127.EditData then
            for k, v in pairs(u127.EditData) do
                if typeof(v[2]) ~= "UDim2" and typeof(v[2]) == "table" then
                    v3 = v[2]
                    u127.EditData[k] = {v[1], UDim2.new(v3[1], v3[2], v3[3], v3[4])}
                end
            end
        end
        local TouchControlFrame = u92:WaitForChild("TouchControlFrame")
        local JumpButton = TouchControlFrame:WaitForChild("JumpButton")
        local PropertyChangedSignal = JumpButton:GetPropertyChangedSignal("Visible")
        PropertyChangedSignal:Connect(function() -- Line: 130 -- upvalues: JumpButton (val)
            if JumpButton.Visible then
                return
            end
            JumpButton.Visible = true
        end)
        if not u119.JumpButton then
            u119.JumpButton = JumpButton.Position
        end
        JumpButton.Position = u119.JumpButton
        local UIScale = JumpButton:FindFirstChild("UIScale")
        if UIScale then
            UIScale.Scale = 1
        else
            Instance.new("UIScale").Parent = JumpButton
        end
        u112, u113 = createTouchButton("SprintButton", "rbxassetid://6380639022", "Run: Off")
        u124 = u112
        local ThumbstickFrame = u92.TouchControlFrame.ThumbstickFrame
        if not u119.ThumbstickFrame then
            u119.ThumbstickFrame = ThumbstickFrame.Position
        end
        if ThumbstickFrame.Parent:FindFirstChild("RealThumbStick") then
            ThumbstickFrame:Destroy()
            ThumbstickFrame = ThumbstickFrame.Parent.RealThumbStick
            ThumbstickFrame.Name = "ThumbstickFrame"
        end
        local v4 = ThumbstickFrame
        local v5 = nil
        if not p1 then
            ThumbstickFrame.Visible = ThumbstickFrame.Visible
        else
            v5 = ThumbstickFrame:Clone()
            v5.Parent = ThumbstickFrame.Parent
            v4.Visible = false
            v4.Name = "RealThumbStick"
        end
        ThumbstickFrame.Position = u119.ThumbstickFrame
        local UIScale_2 = ThumbstickFrame:FindFirstChild("UIScale")
        if UIScale_2 then
            UIScale_2.Scale = 1
        else
            Instance.new("UIScale").Parent = ThumbstickFrame
        end
        u172, u173 = createTouchButton("CrouchButton", "rbxassetid://6377495066", "Crouch: Off")
        local Position = u172.Position
        u172.Position = Position + UDim2.new(0, JumpButton.Size.X.Offset * 0.5 - 15, 0, -JumpButton.Size.Y.Offset)
        u119.CrouchButton = u172.Position
        u172.Parent = Folder
        u172.Visible = true
        if not p1 then
            u200 = 0
            local u201 = false
            u172.MouseButton1Down:Connect(function() -- Line: 191 -- upvalues: u201 (ref)
                u201 = true
            end)
            u172.MouseButton1Up:Connect(function() -- Line: 194 -- upvalues: u201 (ref), u200 (ref), u89 (upval), u173 (val)
                if u201 then
                    u201 = false
                    if u200 < 0.25 then
                        u89.CrouchPressed = not u89.CrouchPressed
                        if not u89.CrouchPressed then
                            u173.Image = "rbxassetid://6377495066"
                        end
                    end
                end
                u200 = 0
            end)
            task.spawn(function() -- Line: 208 -- upvalues: u172 (val), u201 (ref), u200 (ref), u89 (upval)
                while u172.Parent do
                    if u201 then
                        u200 = u200 + task.wait()
                        if 0.25 <= u200 then
                            u89.PronePressed = not u89.PronePressed
                            u201 = false
                        end
                    end
                end
            end)
        end
        u200 = createTouchButton("NVGButton", "rbxassetid://6381369551", "NVGs")
        local v6 = createTouchButton("ThirdPersonButton", "rbxassetid://13646515215", "View")
        v6.Position = UDim2.new(0, 0, 0, 0)
        u119.ThirdPersonButton = v6.Position
        v6.Parent = Folder
        v6.Visible = true
        if not p1 then
            new = 0
            v6.MouseButton1Down:connect(function() -- Line: 241 -- upvalues: Sounds (upval), u89 (upval), new (ref)
                Sounds.Tap:Play()
                u89.TPPressed = true
                new = os.clock()
            end)
            v6.MouseButton1Up:connect(function() -- Line: 246 -- upvalues: u89 (upval), new (ref), u49 (upval)
                u89.TPPressed = false
                local v1 = os.clock() - new
                if v1 < 0.33 and not u89.ThirdPerson then
                    u49:Show("Hold this button to go into third person")
                end
            end)
        end
        new = UDim2.new(0, v6.Size.X.Offset, 0, 0)
        u200.Position = new
        new = u119
        new.NVGButton = u200.Position
        u200.Parent = Folder
        u200.Visible = true
        if not p1 then
            u200.MouseButton1Click:connect(function() -- Line: 260 -- upvalues: NVGs (upval)
                NVGs.ToggleActivate()
            end)
        end
        new = createTouchButton("EditButton", "rbxassetid://18582762591", "Edit")
        new.Position = UDim2.new(0, v6.Size.X.Offset * 2, 0, 0)
        u119.EditButton = new.Position
        new.Parent = Folder
        local v7 = p1
        if not v7 then
            v7 = peek(u26.Controls.ShowEditButton)
        end
        new.Visible = v7
        if not p1 then
            new.MouseButton1Click:connect(function() -- Line: 274 -- upvalues: Sounds (upval), Generate (upval)
                Sounds.Tap:Play()
                Generate(true)
            end)
        end
        v7 = UDim2.fromOffset(0, GuiService.TopbarInset.Height)
        local v8 = UDim2.fromScale(0.85, 0.4) + v7
        local v9 = UDim2.fromScale(0.75, 0.4) + v7
        local Element = HUDService:GetElement("StaminaDisplay")
        if Element then
            local MainFrame = Element:GetMainFrame()
            if MainFrame then
                local v10
                if not MainFrame then
                    v10 = nil
                elseif MainFrame.AbsoluteSize.X ~= 0 then
                    AbsolutePosition = MainFrame.AbsolutePosition
                    AbsoluteSize = MainFrame.AbsoluteSize
                    v10 = UDim2.fromOffset(AbsolutePosition.X + AbsoluteSize.X / 2, AbsolutePosition.Y + AbsoluteSize.Y / 2 - GuiService.TopbarInset.Height)
                end
                v8 = v10 or v8
            end
        end
        local Element_2 = HUDService:GetElement("AbilityDisplay")
        if Element_2 and Element_2.GetMainFrame then
            local MainFrame_2 = Element_2:GetMainFrame()
            if MainFrame_2 then
                local v11
                if not MainFrame_2 then
                    v11 = nil
                elseif MainFrame_2.AbsoluteSize.X ~= 0 then
                    local AbsolutePosition_2 = MainFrame_2.AbsolutePosition
                    local AbsoluteSize_2 = MainFrame_2.AbsoluteSize
                    v11 = UDim2.fromOffset(AbsolutePosition_2.X + AbsoluteSize_2.X / 2, AbsolutePosition_2.Y + AbsoluteSize_2.Y / 2 - GuiService.TopbarInset.Height)
                end
                v9 = v11 or v9
            end
        end
        v9 = v9 + v7
        v8 = v8 + v7
        local v12 = createTouchButton("StaminaButton", "", "Stamina")
        v12.AnchorPoint = Vector2.new(0.5, 0.5)
        v12.Position = v8
        v12.ImageLabel.Visible = false
        v12.TextLabel.Visible = true
        u119.StaminaButton = v8
        v12.Parent = Folder
        v12.Visible = p1
        local v13 = createTouchButton("AbilityButton", "", "Ability")
        v13.AnchorPoint = Vector2.new(0.5, 0.5)
        v13.Position = v9
        v13.ImageLabel.Visible = false
        v13.TextLabel.Visible = true
        u119.AbilityButton = v9
        v13.Parent = Folder
        v13.Visible = p1
        local StaminaButton = u127.EditData.StaminaButton
        if StaminaButton then
            if typeof(StaminaButton[2]) ~= "table" then
                v12.Position = StaminaButton[2]
            else
                v12.Position = unpack(StaminaButton[2])
            end
            v12.UIScale.Scale = StaminaButton[1]
        end
        local AbilityButton = u127.EditData.AbilityButton
        if AbilityButton then
            if typeof(AbilityButton[2]) ~= "table" then
                v13.Position = AbilityButton[2]
            else
                v13.Position = unpack(AbilityButton[2])
            end
            v13.UIScale.Scale = AbilityButton[1]
        end
        u475, u476, u477 = createTouchButton("AimButton", "rbxassetid://6380722466", "Aim: Off")
        u475.Position = u475.Position + UDim2.new(0, -JumpButton.Size.X.Offset * 0.5 - 15, 0, -JumpButton.Size.Y.Offset)
        u119.AimButton = u475.Position
        u475.Parent = Folder
        u475.Visible = true
        if not p1 then
            u475.MouseButton1Click:connect(function() -- Line: 349 -- upvalues: u477 (val), u90 (upval), u476 (val), u89 (upval), u112 (val)
                if u477.Text == "Aim: On" then
                    u90.SecondaryAttackDown = false
                    u477.Text = "Aim: Off"
                    u476.Image = "rbxassetid://6380722466"
                    return
                end
                u90.SecondaryAttackDown = true
                u89.SprintPressed = false
                u89.AutoRun = false
                u112.TextLabel.Text = "Run: Off"
                u112.ImageLabel.Image = "rbxassetid://6380639022"
                u477.Text = "Aim: On"
                u476.Image = "rbxassetid://6380744738"
            end)
        end
        local v14 = peek(u26.Controls.MobileSelectionMode)
        local v15 = if v14 ~= 2 then v14 == 3 else true
        v2, _, u555 = createTouchButton("SwapButton", "rbxassetid://6380772911", "Swap")
        v2.Position = u475.Position + UDim2.new(0, 0, 0, -JumpButton.Size.Y.Offset)
        u119.SwapButton = v2.Position
        v2.Parent = Folder
        v2.Visible = v15
        if not p1 then
            v2.MouseButton1Down:connect(function() -- Line: 378 -- upvalues: peek (upval), u26 (upval), HUDService (upval)
                if peek(u26.Controls.MobileSelectionMode) == 3 then
                    HUDService.Elements.DPadSelection:HoldingMobile()
                end
            end)
            v2.MouseButton1Up:connect(function() -- Line: 383 -- upvalues: peek (upval), u26 (upval), HUDService (upval)
                if peek(u26.Controls.MobileSelectionMode) == 3 then
                    HUDService.Elements.DPadSelection:StopHoldingMobile()
                end
            end)
            v2.MouseButton1Click:connect(function() -- Line: 388 -- upvalues: peek (upval), u26 (upval), u90 (upval)
                if peek(u26.Controls.MobileSelectionMode) == 2 then
                    u90:ClassicWeaponSwap()
                end
            end)
        end
        u112.Position = u475.Position + UDim2.new(0, JumpButton.Size.X.Offset, 0, -JumpButton.Size.Y.Offset)
        u119.SprintButton = u112.Position
        u112.Parent = Folder
        u112.Visible = true
        if not p1 then
            local function sprintToggle() -- Line: 401 -- upvalues: u555 (val), u89 (upval), u113 (val), u90 (upval), u475 (val)
                if u555.Text == "Run: On" then
                    u89.SprintPressed = false
                    u89.AutoRun = false
                    u555.Text = "Run: Off"
                    u113.Image = "rbxassetid://6380639022"
                    return
                end
                u89.SprintPressed = true
                u90.SecondaryAttackDown = false
                u475.TextLabel.Text = "Aim: Off"
                u555.Text = "Run: On"
                u113.Image = "rbxassetid://6380639117"
                u475.ImageLabel.Image = "rbxassetid://6380722466"
            end
            local u639 = nil
            u112.InputBegan:Connect(function(p1) -- Line: 420 -- upvalues: u126 (upval), u125 (upval), u639 (ref)
                if p1 == u126 then
                    u639 = true
                elseif p1 == u125 then
                    u639 = true
                end
            end)
            u112.MouseLeave:Connect(function() -- Line: 432 -- upvalues: u639 (ref)
                u639 = false
            end)
            u112.MouseButton1Up:Connect(function() -- Line: 436 -- upvalues: u639 (ref), u89 (upval), u555 (val), u113 (val), u90 (upval), u475 (val)
                if not u639 then
                    return
                end
                if not u89.AutoRun then
                    u89.AutoRun = true
                    if u89.SprintPressed then
                        return
                    end
                    if u555.Text == "Run: On" then
                        u89.SprintPressed = false
                        u89.AutoRun = false
                        u555.Text = "Run: Off"
                        u113.Image = "rbxassetid://6380639022"
                        return
                    end
                    u89.SprintPressed = true
                    u90.SecondaryAttackDown = false
                    u475.TextLabel.Text = "Aim: Off"
                    u555.Text = "Run: On"
                    u113.Image = "rbxassetid://6380639117"
                    u475.ImageLabel.Image = "rbxassetid://6380722466"
                    return
                end
                if not u89.AutoRun then
                    return
                end
                u89.AutoRun = false
                if u555.Text == "Run: On" then
                    u89.SprintPressed = false
                    u89.AutoRun = false
                    u555.Text = "Run: Off"
                    u113.Image = "rbxassetid://6380639022"
                    return
                end
                u89.SprintPressed = true
                u90.SecondaryAttackDown = false
                u475.TextLabel.Text = "Aim: Off"
                u555.Text = "Run: On"
                u113.Image = "rbxassetid://6380639117"
                u475.ImageLabel.Image = "rbxassetid://6380722466"
            end)
            u112.MouseButton1Click:connect(function() -- Line: 454 -- upvalues: u555 (val), u89 (upval), u113 (val), u90 (upval), u475 (val)
                if u555.Text == "Run: On" then
                    u89.SprintPressed = false
                    u89.AutoRun = false
                    u555.Text = "Run: Off"
                    u113.Image = "rbxassetid://6380639022"
                    return
                end
                u89.SprintPressed = true
                u90.SecondaryAttackDown = false
                u475.TextLabel.Text = "Aim: Off"
                u555.Text = "Run: On"
                u113.Image = "rbxassetid://6380639117"
                u475.ImageLabel.Image = "rbxassetid://6380722466"
            end)
        end
        local v16 = createTouchButton("ShootButton", "rbxassetid://6380700475", "Shoot")
        v16.Position = v16.Position + UDim2.new(0, -JumpButton.Size.X.Offset, 0, 0)
        v16.Parent = Folder
        v16.Visible = true
        v16.Active = false
        u119.ShootButton = v16.Position
        local ShootButton = u127.EditData.ShootButton
        if ShootButton then
            if typeof(ShootButton[2]) ~= "table" then
                v16.Position = ShootButton[2]
            else
                v16.Position = unpack(ShootButton[2])
            end
            v16.UIScale.Scale = ShootButton[1]
        end
        local SprintButton = u127.EditData.SprintButton
        if SprintButton then
            if typeof(SprintButton[2]) ~= "table" then
                u112.Position = SprintButton[2]
            else
                u112.Position = unpack(SprintButton[2])
            end
            u112.UIScale.Scale = SprintButton[1]
        end
        local SwapButton = u127.EditData.SwapButton
        if SwapButton then
            if typeof(SwapButton[2]) ~= "table" then
                v2.Position = SwapButton[2]
            else
                v2.Position = unpack(SwapButton[2])
            end
            v2.UIScale.Scale = SwapButton[1]
        end
        local AimButton = u127.EditData.AimButton
        if AimButton then
            if typeof(AimButton[2]) ~= "table" then
                u475.Position = AimButton[2]
            else
                u475.Position = unpack(AimButton[2])
            end
            u475.UIScale.Scale = AimButton[1]
        end
        local NVGButton = u127.EditData.NVGButton
        if NVGButton then
            if typeof(NVGButton[2]) ~= "table" then
                u200.Position = NVGButton[2]
            else
                u200.Position = unpack(NVGButton[2])
            end
            u200.UIScale.Scale = NVGButton[1]
        end
        local ThirdPersonButton = u127.EditData.ThirdPersonButton
        if ThirdPersonButton then
            if typeof(ThirdPersonButton[2]) ~= "table" then
                v6.Position = ThirdPersonButton[2]
            else
                v6.Position = unpack(ThirdPersonButton[2])
            end
            v6.UIScale.Scale = ThirdPersonButton[1]
        end
        local JumpButton_2 = u127.EditData.JumpButton
        if JumpButton_2 then
            if typeof(JumpButton_2[2]) ~= "table" then
                JumpButton.Position = JumpButton_2[2]
            else
                JumpButton.Position = unpack(JumpButton_2[2])
            end
            JumpButton.UIScale.Scale = JumpButton_2[1]
        end
        local EditButton = u127.EditData.EditButton
        if EditButton then
            if typeof(EditButton[2]) ~= "table" then
                new.Position = EditButton[2]
            else
                new.Position = unpack(EditButton[2])
            end
            new.UIScale.Scale = EditButton[1]
        end
        if ThumbstickFrame:FindFirstChild("ModifiedPosition") then
            ThumbstickFrame.ModifiedPosition:Destroy()
        end
        local Frame = Instance.new("Frame")
        Frame.Position = ThumbstickFrame.Position
        Frame.Name = "ModifiedPosition"
        Frame.Visible = false
        Frame.Parent = ThumbstickFrame
        local ThumbstickFrame_2 = u127.EditData.ThumbstickFrame
        if ThumbstickFrame_2 then
            if typeof(ThumbstickFrame_2[2]) ~= "table" then
                Frame.Position = ThumbstickFrame_2[2]
                ThumbstickFrame.Position = ThumbstickFrame_2[2]
            else
                Frame.Position = unpack(ThumbstickFrame_2[2])
                ThumbstickFrame.Position = unpack(ThumbstickFrame_2[2])
            end
            ThumbstickFrame.UIScale.Scale = ThumbstickFrame_2[1]
        end
        local CrouchButton = u127.EditData.CrouchButton
        if CrouchButton then
            if typeof(CrouchButton[2]) ~= "table" then
                u172.Position = CrouchButton[2]
            else
                u172.Position = unpack(CrouchButton[2])
            end
            u172.UIScale.Scale = CrouchButton[1]
        end
        if not p1 then
            local v17
            v17, u1312, u1313 = pairs({
                v16,
                u112,
                v2,
                u475,
                u172,
                u200,
                v6,
                JumpButton,
            })
            for k2, i in pairs(u1312) do
                if i then
                    i.Active = false
                end
            end
        else
            local v18, v19
            v3 = v5
            local v20 = {
                v16,
                u112,
                v2,
                u475,
                u172,
                u200,
                v6,
                new,
                v12,
                v13,
                JumpButton,
                v3,
            }
            local u1462 = Edit:Clone()
            u1462.Parent = game.Players.LocalPlayer.PlayerGui
            local Frame_2 = u1462.Frame
            local v21 = UDim2.new(0, 405, 0, 50)
            Frame_2:TweenSize(v21, "Out", "Quad", 0.25, true)
            local Options = u1462.Options
            v21 = UDim2.new(0, 306, 0, 50)
            Options:TweenSize(v21, "Out", "Quad", 0.25, true)
            local Presets = u1462.Presets
            v21 = UDim2.new(0, 306, 0, 70)
            Presets:TweenSize(v21, "Out", "Quad", 0.25, true)
            u1312 = nil
            u1313 = nil
            k2 = nil
            i = nil
            local u1316 = nil
            local u1317 = nil
            local u1318 = nil
            local u1319 = {}
            for k3, j in pairs(v20) do
                if j then
                    j.Active = true
                    j.BackgroundTransparency = 0.5
                    j.BackgroundColor3 = Color3.new(0.5, 0, 0)
                    if j == v3 then
                        u1319[#u1319 + 1] = j.InputBegan:connect(function(p1) -- Line: 618 -- upvalues: u1312 (ref), Sounds (upval), j (val), u1318 (ref), u1316 (ref), u1462 (val)
                            if u1312 == nil then
                                p1.Changed:Connect(function() -- Line: 620 -- upvalues: p1 (val), u1312 (upval), Sounds (upval), j (upval), u1318 (upval), u1316 (upval), u1462 (upval)
                                    if p1.UserInputState == Enum.UserInputState.End and u1312 == nil then
                                        game.SoundService:PlayLocalSound(Sounds.Select)
                                        j.BackgroundColor3 = Color3.new(0, 0.75, 0)
                                        u1312 = j
                                        u1318 = j.Position
                                        u1316 = j.UIScale.Scale
                                        u1462.Frame.TextLabel.Text = "Editing " .. j.Name
                                        local v1 = UDim2.new(0, 405, 0, 150)
                                        u1462.Frame:TweenSize(v1, "Out", "Quad", 0.25, true)
                                        v1 = UDim2.new(0, 306, 0, 0)
                                        u1462.Options:TweenSize(v1, "Out", "Quad", 0.25, true)
                                        v1 = UDim2.new(0, 306, 0, 0)
                                        u1462.Presets:TweenSize(v1, "Out", "Quad", 0.25, true)
                                    end
                                end)
                            end
                        end)
                    else
                        u1319[#u1319 + 1] = j.MouseButton1Click:connect(function() -- Line: 604 -- upvalues: u1312 (ref), Sounds (upval), j (val), u1318 (ref), u1316 (ref), u1462 (val)
                            if u1312 == nil then
                                game.SoundService:PlayLocalSound(Sounds.Select)
                                j.BackgroundColor3 = Color3.new(0, 0.75, 0)
                                u1312 = j
                                u1318 = j.Position
                                u1316 = j.UIScale.Scale
                                u1462.Frame.TextLabel.Text = "Editing " .. j.Name
                                local v1 = UDim2.new(0, 405, 0, 150)
                                u1462.Frame:TweenSize(v1, "Out", "Quad", 0.25, true)
                                v1 = UDim2.new(0, 306, 0, 0)
                                u1462.Options:TweenSize(v1, "Out", "Quad", 0.25, true)
                                v1 = UDim2.new(0, 306, 0, 0)
                                u1462.Presets:TweenSize(v1, "Out", "Quad", 0.25, true)
                            end
                        end)
                    end
                end
            end
            local function positionIntersectsGuiObject(p1, p2) -- Line: 640
                if p1.X >= p2.AbsolutePosition.X + p2.AbsoluteSize.X or p2.AbsolutePosition.X >= p1.X or p1.Y >= p2.AbsolutePosition.Y + p2.AbsoluteSize.Y then
                    return false
                end
                if p2.AbsolutePosition.Y < p1.Y then
                    return true
                end
                return false
            end
            UserInputService.InputBegan:connect(function(p1, p2) -- Line: 651 -- upvalues: u1312 (ref), i (ref), u1313 (ref), k2 (ref), u1317 (ref)
                if u1312 then
                    local v1
                    local Position = p1.Position
                    local v2 = u1312
                    if Position.X >= v2.AbsolutePosition.X + v2.AbsoluteSize.X then
                        v1 = false
                    elseif v2.AbsolutePosition.X >= Position.X then
                        v1 = false
                    elseif Position.Y >= v2.AbsolutePosition.Y + v2.AbsoluteSize.Y then
                        v1 = false
                    else
                        v1 = not (v2.AbsolutePosition.Y >= Position.Y)
                    end
                    if v1 then
                        i = true
                        u1313 = p1
                        k2 = p1.Position
                        u1317 = u1312.Position
                        p1.Changed:Connect(function() -- Line: 657 -- upvalues: p1 (val), i (upval)
                            if p1.UserInputState == Enum.UserInputState.End then
                                i = false
                            end
                        end)
                    end
                end
            end)
            local function update(p1) -- Line: 664 -- upvalues: k2 (ref), u1312 (ref), u1317 (ref)
                local v1 = p1.Position - k2
                u1312.Position = UDim2.new(u1317.X.Scale, u1317.X.Offset + v1.X, u1317.Y.Scale, u1317.Y.Offset + v1.Y)
            end
            UserInputService.InputChanged:connect(function(p1, p2) -- Line: 669 -- upvalues: u1313 (ref), i (ref), k2 (ref), u1312 (ref), u1317 (ref)
                if p1 == u1313 and i then
                    local v1 = p1.Position - k2
                    u1312.Position = UDim2.new(u1317.X.Scale, u1317.X.Offset + v1.X, u1317.Y.Scale, u1317.Y.Offset + v1.Y)
                end
            end)
            local function ended() -- Line: 674 -- upvalues: u1462 (val)
                local v1 = UDim2.new(0, 306, 0, 50)
                u1462.Options:TweenSize(v1, "Out", "Quad", 0.25, true)
                v1 = UDim2.new(0, 306, 0, 70)
                u1462.Presets:TweenSize(v1, "Out", "Quad", 0.25, true)
                v1 = UDim2.new(0, 405, 0, 50)
                u1462.Frame:TweenSize(v1, "Out", "Quad", 0.25, true)
                u1462.Frame.TextLabel.Text = "Tap on a button to edit"
            end
            local u1353 = false
            u1462.Options.Save.MouseButton1Click:connect(function() -- Line: 682 -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), i (ref), u1312 (ref), u120 (upval), u118 (upval), u127 (upval), JumpButton (val), Folder (upval), u121 (upval), u1319 (val), Net (upval)
                if not u1462.Frame.Save.Text == "Sure?" then
                    u1353 = false
                end
                if not u1353 then
                    game.SoundService:PlayLocalSound(Sounds.Tap)
                    u1353 = true
                    u1462.Options.Save.Text = "Sure?"
                    local v1 = 0
                    while true do
                        v1 = v1 + task.wait()
                        if 1.5 <= v1 or u1353 == false then
                            break
                        end
                    end
                    if u1462.Parent then
                        u1462.Options.Save.Text = "Save"
                    end
                    u1353 = false
                    return
                end
                if not i and not u1312 and u1462.Options.Save.Text == "Sure?" then
                    game.SoundService:PlayLocalSound(Sounds.Save)
                    u120 = nil
                    for k, v in pairs(u118) do
                        u127.EditData[k] = v
                    end
                    JumpButton.BackgroundTransparency = 1
                    Folder:ClearAllChildren()
                    u1462:Destroy()
                    u121 = false
                    for k2, i2 in pairs(u1319) do
                        i2:Disconnect()
                    end
                    table.clear(u1319)
                    u127:MakeButtons()
                    Net:FireServer("MobileEditData", u127.EditData)
                end
            end)
            u1462.Options.Reset.MouseButton1Click:connect(function() -- Line: 722 -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), i (ref), u1312 (ref), u120 (upval), u127 (upval), JumpButton (val), Folder (upval), u121 (upval), u1319 (val), Net (upval)
                if not u1462.Options.Reset.Text == "Sure?" then
                    u1353 = false
                end
                if not u1353 then
                    game.SoundService:PlayLocalSound(Sounds.Tap)
                    u1353 = true
                    u1462.Options.Reset.Text = "Sure?"
                    local v1 = 0
                    while true do
                        v1 = v1 + task.wait()
                        if 1.5 <= v1 or u1353 == false then
                            break
                        end
                    end
                    if not u1462.Parent then
                        return
                    end
                    u1462.Options.Reset.Text = "Reset"
                    u1353 = false
                    return
                end
                if not i and not u1312 and u1462.Options.Reset.Text == "Sure?" then
                    game.SoundService:PlayLocalSound(Sounds.Error)
                    u120 = nil
                    u127.EditData = {}
                    JumpButton.BackgroundTransparency = 1
                    Folder:ClearAllChildren()
                    u1462:Destroy()
                    u121 = false
                    for k, v in pairs(u1319) do
                        v:Disconnect()
                    end
                    table.clear(u1319)
                    u127:MakeButtons()
                    Net:FireServer("MobileEditData", u127.EditData)
                end
            end)
            u1462.Options.Cancel.MouseButton1Click:connect(function() -- Line: 760 -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), i (ref), u1312 (ref), u120 (upval), u127 (upval), JumpButton (val), Folder (upval), u121 (upval), u1319 (val)
                if not u1462.Frame.Cancel.Text == "Sure?" then
                    u1353 = false
                end
                if not u1353 then
                    game.SoundService:PlayLocalSound(Sounds.Tap)
                    u1353 = true
                    u1462.Options.Cancel.Text = "Sure?"
                    local v1 = 0
                    while true do
                        v1 = v1 + task.wait()
                        if 1.5 <= v1 or u1353 == false then
                            break
                        end
                    end
                    if u1462.Parent then
                        u1462.Options.Cancel.Text = "Cancel"
                    end
                    u1353 = false
                    return
                end
                if not i and not u1312 and u1462.Options.Cancel.Text == "Sure?" then
                    game.SoundService:PlayLocalSound(Sounds.Error)
                    if u120 then
                        u127.EditData = u120
                    end
                    u120 = nil
                    JumpButton.BackgroundTransparency = 1
                    Folder:ClearAllChildren()
                    u1462:Destroy()
                    u121 = false
                    for k, v in pairs(u1319) do
                        v:Disconnect()
                    end
                    table.clear(u1319)
                    u127:MakeButtons()
                end
            end)
            u1462.Frame.Reset.MouseButton1Click:connect(function() -- Line: 798 -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), i (ref), u1312 (ref), u119 (upval), u118 (upval), ended (val)
                if not u1462.Frame.Reset.Text == "Sure?" then
                    u1353 = false
                end
                if u1353 then
                    if not i and u1312 and u1462.Frame.Reset.Text == "Sure?" then
                        game.SoundService:PlayLocalSound(Sounds.Error)
                        u1312.BackgroundColor3 = Color3.new(0.5, 0, 0)
                        u1312.UIScale.Scale = 1
                        u1312.Position = u119[u1312.Name]
                        u118[u1312.Name] = {1, u119[u1312.Name]}
                        u1312 = nil
                        ended()
                    end
                    return
                end
                game.SoundService:PlayLocalSound(Sounds.Tap)
                u1353 = true
                u1462.Frame.Reset.Text = "Sure?"
                local v1 = 0
                while true do
                    v1 = v1 + task.wait()
                    if 1.5 <= v1 or u1353 == false then
                        break
                    end
                end
                if not u1462.Parent then
                    return
                end
                u1462.Frame.Reset.Text = "Reset"
                u1353 = false
            end)
            u1462.Frame.Save.MouseButton1Click:connect(function() -- Line: 826 -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), i (ref), u1312 (ref), u118 (upval), ended (val)
                if not u1462.Frame.Save.Text == "Sure?" then
                    u1353 = false
                end
                if u1353 then
                    if not i and u1312 and u1462.Frame.Save.Text == "Sure?" then
                        game.SoundService:PlayLocalSound(Sounds.Save)
                        u1312.BackgroundColor3 = Color3.new(0.5, 0, 0)
                        u118[u1312.Name] = {u1312.UIScale.Scale, u1312.Position}
                        u1312 = nil
                        ended()
                    end
                    return
                end
                game.SoundService:PlayLocalSound(Sounds.Tap)
                u1353 = true
                u1462.Frame.Save.Text = "Sure?"
                local v1 = 0
                while true do
                    v1 = v1 + task.wait()
                    if 1.5 <= v1 or u1353 == false then
                        break
                    end
                end
                if not u1462.Parent then
                    return
                end
                u1462.Frame.Save.Text = "Save"
                u1353 = false
            end)
            u1462.Frame.Cancel.MouseButton1Click:connect(function() -- Line: 852 -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), i (ref), u1312 (ref), u1316 (ref), u1318 (ref), ended (val)
                if not u1462.Frame.Cancel.Text == "Sure?" then
                    u1353 = false
                end
                if u1353 then
                    if not i and u1312 and u1462.Frame.Cancel.Text == "Sure?" then
                        game.SoundService:PlayLocalSound(Sounds.Error)
                        u1312.BackgroundColor3 = Color3.new(0.5, 0, 0)
                        u1312.UIScale.Scale = u1316
                        u1312.Position = u1318
                        u1312 = nil
                        ended()
                    end
                    return
                end
                game.SoundService:PlayLocalSound(Sounds.Tap)
                u1353 = true
                u1462.Frame.Cancel.Text = "Sure?"
                local v1 = 0
                while true do
                    v1 = v1 + task.wait()
                    if 1.5 <= v1 or u1353 == false then
                        break
                    end
                end
                if not u1462.Parent then
                    return
                end
                u1462.Frame.Cancel.Text = "Cancel"
                u1353 = false
            end)
            local u1400 = {}
            u1462.Frame.Incr.InputBegan:connect(function(p1) -- Line: 881 -- upvalues: u1312 (ref), i (ref), u1400 (val), Sounds (upval)
                if u1312 and not i and not (u1400[u1312.Name]) then
                    local u36 = true
                    local u8 = nil
                    while u36 do
                        if not u1312 then
                            break
                        end
                        game.SoundService:PlayLocalSound(Sounds.Tap)
                        if u1312 then
                            u1312.UIScale.Scale = u1312.UIScale.Scale + 0.05 * (task.wait() * 60)
                        end
                    end
                end
            end)
            u1462.Frame.Dec.InputBegan:connect(function(p1) -- Line: 900 -- upvalues: u1312 (ref), i (ref), u1400 (val), Sounds (upval)
                if u1312 and not i and not (u1400[u1312.Name]) then
                    local v1
                    local u39 = true
                    local u8 = nil
                    while u39 do
                        if not u1312 then
                            break
                        end
                        game.SoundService:PlayLocalSound(Sounds.Tap)
                        if u1312 then
                            v1 = u1312.UIScale.Scale - 0.05 * (task.wait() * 60)
                            u1312.UIScale.Scale = math.max(v1, 0.05)
                        end
                    end
                end
            end)
            local function getPresetLabel(p1) -- Line: 919 -- upvalues: u127 (upval)
                local v1 = u127.PresetData[tostring(p1)]
                if not v1 then
                    return "Preset " .. p1 .. " (Empty)"
                end
                if next(v1) then
                    return "Preset " .. p1
                end
                return "Preset " .. p1 .. " (Empty)"
            end
            local v22 = 3
            local v23 = 1
            for k4 = 1, v22, v23 do
                local u1427 = u1462.Presets["Preset" .. k4]
                v19 = u127.PresetData[tostring(k4)]
                if not v19 then
                    v18 = "Preset " .. k4 .. " (Empty)"
                elseif next(v19) then
                    v18 = "Preset " .. k4
                end
                u1427.Text = v18
                local u1448 = nil
                local u1449 = false
                u1427.MouseButton1Down:Connect(function() -- Line: 932 -- upvalues: u1448 (ref), u1449 (ref), Sounds (upval), u127 (upval), u118 (upval), k4 (val), Net (upval), u1427 (val)
                    u1448 = os.clock()
                    u1449 = true
                    task.delay(0.6, function() -- Line: 935 -- upvalues: u1449 (upval), u1448 (upval), Sounds (upval), u127 (upval), u118 (upval), k4 (upval), Net (upval), u1427 (upval)
                        if u1449 and u1448 then
                            u1449 = false
                            game.SoundService:PlayLocalSound(Sounds.Save)
                            local v1 = table.clone(u127.EditData)
                            for k, v in pairs(u118) do
                                v1[k] = v
                            end
                            u127.PresetData[tostring(k4)] = v1
                            Net:FireServer("MobilePresetSave", {slot = k4, data = v1})
                            u1427.Text = "Saved!"
                            task.delay(1, function() -- Line: 947 -- upvalues: u1427 (upval), k4 (upval), u127 (upval)
                                if u1427.Parent then
                                    local v1
                                    local v2 = u1427
                                    local v3 = k4
                                    local v4 = u127.PresetData[tostring(v3)]
                                    if not v4 then
                                        v1 = "Preset " .. v3 .. " (Empty)"
                                    elseif not (next(v4)) then
                                        v1 = "Preset " .. v3 .. " (Empty)"
                                    else
                                        v1 = "Preset " .. v3
                                    end
                                    v2.Text = v1
                                end
                            end)
                        end
                    end)
                end)
                u1427.MouseButton1Up:Connect(function() -- Line: 955 -- upvalues: u1449 (ref), u1448 (ref), u127 (upval), k4 (val), Sounds (upval), JumpButton (val), Folder (upval), u1462 (val), u121 (upval), u1319 (val), Generate (upval)
                    if u1449 and u1448 then
                        local v1 = os.clock() - u1448
                        if v1 < 0.6 then
                            u1449 = false
                            u1448 = nil
                            v1 = u127.PresetData[tostring(k4)]
                            if not v1 then
                                game.SoundService:PlayLocalSound(Sounds.Error)
                            elseif not (next(v1)) then
                                game.SoundService:PlayLocalSound(Sounds.Error)
                            else
                                local v2, v3, v4, v5
                                game.SoundService:PlayLocalSound(Sounds.Tap)
                                u127.EditData = {}
                                for k, v in pairs(v1) do
                                    if typeof(v[2]) ~= "table" then
                                        u127.EditData[k] = v
                                    else
                                        v5 = {}
                                        v2 = v[2][1]
                                        v3 = v[2][2]
                                        v4 = v[2][3]
                                        v5[1] = v[1]
                                        v5[2] = UDim2.new(v2, v3, v4, v[2][4])
                                        u127.EditData[k] = v5
                                    end
                                end
                                JumpButton.BackgroundTransparency = 1
                                Folder:ClearAllChildren()
                                u1462:Destroy()
                                u121 = false
                                for k2, i in pairs(u1319) do
                                    i:Disconnect()
                                end
                                table.clear(u1319)
                                Generate(true)
                            end
                        end
                    end
                    u1449 = false
                    u1448 = nil
                end)
            end
        end
        u123 = v16
        return u92, v16
    else
        if u121 then
            return
        end
        u121 = true
        v1 = {}
        u118 = v1
        if not u120 then
            if not u127.EditData then
                v1 = {}
            else
                v1 = table.clone(u127.EditData)
            end
            u120 = v1
        end
        Folder:ClearAllChildren()
    end
end
local function applyCustomPositions() -- Line: 1005 -- upvalues: HUDService (val), u127 (val), touchPosToScreenPos (val), peek (val), u26 (val)
    local Element = HUDService:GetElement("StaminaDisplay")
    local Element_2 = HUDService:GetElement("AbilityDisplay")
    local StaminaButton = u127.EditData.StaminaButton
    if Element then
        if not StaminaButton then
            Element:SetCustomPosition(nil)
        else
            local v1 = StaminaButton[2]
            if typeof(v1) == "table" then
                v1 = UDim2.new(v1[1], v1[2], v1[3], v1[4])
            end
            Element:SetCustomPosition(touchPosToScreenPos(v1))
        end
        Element:SetDynamicStaminaEnabled(peek(u26.Controls.DynamicStaminaUI))
        if not StaminaButton then
            Element:SetUIScale(1)
        else
            Element:SetUIScale(StaminaButton[1] or 1)
        end
    end
    local AbilityButton = u127.EditData.AbilityButton
    if not Element_2 then
        return
    end
    if not AbilityButton then
        Element_2:SetCustomPosition(nil)
    else
        local v2 = AbilityButton[2]
        if typeof(v2) == "table" then
            v2 = UDim2.new(v2[1], v2[2], v2[3], v2[4])
        end
        Element_2:SetCustomPosition(touchPosToScreenPos(v2))
    end
    if AbilityButton then
        Element_2:SetUIScale(AbilityButton[1] or 1)
        return
    end
    Element_2:SetUIScale(1)
end
function u127.MakeButtons(p1) -- Line: 1051 -- upvalues: u127 (val), Generate (val), Folder (val), applyCustomPositions (val), u122 (ref), u125 (ref), u91 (ref), u126 (ref), u90 (ref), UserInputService (val), u123 (ref)
    u127.Hidden = false
    local u4 = Generate()
    Folder.Parent = u4
    applyCustomPositions()
    if not u122 then
        u122 = true
        local DynamicThumbstickFrame = u4.TouchControlFrame.DynamicThumbstickFrame
        DynamicThumbstickFrame.Size = UDim2.new(0.35, 0, 0.5, 0)
        DynamicThumbstickFrame.Position = UDim2.new(0, 0, 0.5, 0)
        local u29 = {}
        local u30 = 0
        local u31 = nil
        local u32 = nil
        local u33 = nil
        local u34 = nil
        local function GetCameraLookVector() -- Line: 1085
            local lookVector
            if not game.Workspace.CurrentCamera then
                lookVector = Vector3.new(0, 0, 1)
            else
                lookVector = game.Workspace.CurrentCamera.CFrame.lookVector
                if not lookVector then
                    lookVector = Vector3.new(0, 0, 1)
                end
            end
            return lookVector
        end
        Vector2.new(0, 0)
        Vector2.new(0.029688050576423545, 0.010602875205865551)
        local function isInThumbstickArea(p1) -- Line: 1107 -- upvalues: u4 (val)
            local PlayerGui = game.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local TouchGui = PlayerGui
            if TouchGui then
                TouchGui = PlayerGui:FindFirstChild("TouchGui")
            end
            local TouchControlFrame = TouchGui
            if TouchControlFrame then
                TouchControlFrame = TouchGui:FindFirstChild("TouchControlFrame")
            end
            local ThumbstickFrame = TouchControlFrame
            if ThumbstickFrame then
                ThumbstickFrame = TouchControlFrame:FindFirstChild("ThumbstickFrame")
            end
            if not u4.TouchControlFrame.ThumbstickFrame.Visible or not ThumbstickFrame or not TouchGui.Enabled then
                return false
            end
            local AbsolutePosition = ThumbstickFrame.AbsolutePosition
            local v1 = AbsolutePosition + ThumbstickFrame.AbsoluteSize
            local v2 = if AbsolutePosition.X <= p1.X then if AbsolutePosition.Y <= p1.Y then if p1.X <= v1.X then p1.Y <= v1.Y else false else false else false
            return v2
        end
        local function isInDynamicThumbstickArea(p1) -- Line: 1134 -- upvalues: u4 (val)
            local PlayerGui = game.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
            local TouchGui = PlayerGui
            if TouchGui then
                TouchGui = PlayerGui:FindFirstChild("TouchGui")
            end
            local TouchControlFrame = TouchGui
            if TouchControlFrame then
                TouchControlFrame = TouchGui:FindFirstChild("TouchControlFrame")
            end
            local DynamicThumbstickFrame = TouchControlFrame
            if DynamicThumbstickFrame then
                DynamicThumbstickFrame = TouchControlFrame:FindFirstChild("DynamicThumbstickFrame")
            end
            if not u4.TouchControlFrame.DynamicThumbstickFrame.Visible or not DynamicThumbstickFrame or not TouchGui.Enabled then
                return false
            end
            local AbsolutePosition = DynamicThumbstickFrame.AbsolutePosition
            local v1 = AbsolutePosition + DynamicThumbstickFrame.AbsoluteSize
            local v2 = if AbsolutePosition.X <= p1.X then if AbsolutePosition.Y <= p1.Y then if p1.X <= v1.X then p1.Y <= v1.Y else false else false else false
            return v2
        end
        local function AdjustTouchSensitivity(p1, p2) -- Line: 1161
            local CurrentCamera = game.Workspace.CurrentCamera
            if CurrentCamera then
                CurrentCamera = game.Workspace.CurrentCamera.CFrame
            end
            if not CurrentCamera then
                return p2
            end
            local v1 = CurrentCamera:ToEulerAnglesYXZ()
            local v2 = 2.1
            if 0.5235987755982988 >= v1 then
                if v1 < -0.2617993877991494 and 0 < p1.Y then
                    v2 = 2.1 - (1 - (1 - (v1 - -0.2617993877991494) / -1.1344640137963142) ^ 3) * 1.6
                end
            elseif p1.Y < 0 then
                v2 = 2.1 - (1 - (1 - (v1 - 0.5235987755982988) / 0.8726646259971648) ^ 3) * 1.6
            elseif v1 < -0.2617993877991494 and 0 < p1.Y then
                v2 = 2.1 - (1 - (1 - (v1 - -0.2617993877991494) / -1.1344640137963142) ^ 3) * 1.6
            end
            return Vector2.new(p2.X, p2.Y * v2)
        end
        local u47 = nil
        local u48 = {}
        local u49 = {}
        local function OnTouchChanged(p1, p2) -- Line: 1186 -- upvalues: u125 (upval), u29 (val), u47 (ref), u48 (val), u49 (val), u31 (ref), u32 (ref), u33 (ref), u34 (ref), u30 (ref), u91 (upval)
            local v1
            if p1 == u125 then
                return
            end
            if u29[p1] == nil then
                u29[p1] = p2
                if not p2 then
                    u47 = p1
                    table.insert(u48, p1)
                    u49[p1] = {}
                    u31 = nil
                    u32 = nil
                    u33 = nil
                    u34 = false
                    u30 = u30 + 1
                end
            end
            if 1 > u30 then
                u31 = nil
                u32 = nil
                u33 = nil
                u34 = false
            elseif u29[p1] == false then
                local v2
                if u47 ~= p1 then
                    if not (u49[p1][1]) then
                        v1 = u49[p1]
                        v1[1] = p1.Position
                    end
                    if not (u49[p1][2]) then
                        v1 = u49[p1]
                        v1[2] = u49[p1][1]
                    end
                    v1 = p1.Position - u49[p1][2]
                    u91.X = (u91.X - v1.X / 150 * 1) % 6.283185307179586
                    v2 = math.max(u91.Y - v1.Y / 150 * 1, -1.4)
                    u91.Y = math.min(v2, 1.4)
                    local v3 = u49[p1]
                    v3[2] = p1.Position
                else
                    if not (u49[p1][1]) then
                        v1 = u49[p1]
                        v1[1] = p1.Position
                    end
                    if not (u49[p1][2]) then
                        v1 = u49[p1]
                        v1[2] = u49[p1][1]
                    end
                    v1 = p1.Position - u49[p1][2]
                    local v4 = u91:GetMagnificationSensitivity() * u91:GetSensitivity()
                    v1 = Vector2.new(v1.X * v4, v1.Y * UserSettings().GameSettings:GetCameraYInvertValue() * v4)
                    u91.X = (u91.X - v1.X / 150 * 1) % 6.283185307179586
                    local v5 = math.max(u91.Y - v1.Y / 150 * 1, -1.4)
                    u91.Y = math.min(v5, 1.4)
                    v2 = u49[p1]
                    v2[2] = p1.Position
                end
            end
            if u30 ~= 2 then
                startingDiff = nil
                pinchBeginZoom = nil
                return
            end
            v1 = {}
            for k, v in pairs(u29) do
                if not v then
                    table.insert(v1, k)
                end
            end
            if #v1 ~= 2 then
                return
            end
            local magnitude = (v1[1].Position - v1[2].Position).magnitude
            if not startingDiff then
                startingDiff = magnitude
                pinchBeginZoom = 0.5
                return
            end
            if pinchBeginZoom then
                math.clamp(magnitude / math.max(0.01, startingDiff), 0.1, 10)
                return
            end
            startingDiff = magnitude
            pinchBeginZoom = 0.5
        end
        local u51 = nil
        local u52 = nil
        local function touchBegan(p1, p2) -- Line: 1300 -- upvalues: u125 (upval), isInDynamicThumbstickArea (val), u126 (upval), isInThumbstickArea (val)
            local v1 = p1.UserInputType == Enum.UserInputType.Touch
            assert(v1)
            v1 = p1.UserInputState == Enum.UserInputState.Begin
            assert(v1)
            if u125 ~= nil or not (isInDynamicThumbstickArea(p1.Position)) then
                if u126 == nil then
                    if not (isInThumbstickArea(p1.Position)) then
                        return
                    end
                    u126 = p1
                    return
                end
                return
            end
            if not p2 then
                u125 = p1
                return
            end
            if u126 ~= nil or not (isInThumbstickArea(p1.Position)) then
                return
            end
            u126 = p1
        end
        local function OnTouchEnded(p1, p2) -- Line: 1318 -- upvalues: u52 (ref), u51 (ref), u90 (upval), u29 (val), u30 (ref), u31 (ref), u32 (ref), u33 (ref), u34 (ref), u48 (val), u49 (val), u47 (ref), u125 (upval), u126 (upval)
            if p1 == u52 and u51 then
                u51 = false
                u90.MobileShootDown = false
            end
            if u29[p1] == false then
                if u30 == 1 then
                    u31 = nil
                    u32 = nil
                    u33 = nil
                    u34 = false
                elseif u30 == 2 then
                    startingDiff = nil
                    pinchBeginZoom = nil
                end
            end
            if u29[p1] ~= nil and u29[p1] == false then
                u30 = u30 - 1
                local v1 = table.find(u48, p1)
                if v1 then
                    table.remove(u48, v1)
                    u49[p1] = nil
                end
                if u47 == p1 then
                    local v2 = #u48
                    if 1 <= v2 then
                        u31 = nil
                        u32 = nil
                        u33 = nil
                        u34 = false
                        u47 = u48[#u48]
                    end
                end
            end
            u29[p1] = nil
            if p1 == u125 then
                u125 = nil
            end
            if p1 == u126 then
                u126 = nil
            end
        end
        local function positionIntersectsGuiObject(p1, p2) -- Line: 1363
            if p1.X >= p2.AbsolutePosition.X + p2.AbsoluteSize.X or p2.AbsolutePosition.X >= p1.X or p1.Y >= p2.AbsolutePosition.Y + p2.AbsoluteSize.Y then
                return false
            end
            if p2.AbsolutePosition.Y < p1.Y then
                return true
            end
            return false
        end
        UserInputService.InputBegan:connect(function(p1, p2) -- Line: 1375 -- upvalues: u123 (upval), u51 (ref), u52 (ref), u90 (upval), touchBegan (val)
            local v1
            if p1.UserInputType ~= Enum.UserInputType.Touch or not u123 then
                if p1.UserInputType == Enum.UserInputType.Touch then
                    touchBegan(p1, p2)
                end
                return
            end
            local Position = p1.Position
            local v2 = u123
            if Position.X >= v2.AbsolutePosition.X + v2.AbsoluteSize.X then
                v1 = false
            elseif v2.AbsolutePosition.X < Position.X and Position.Y < v2.AbsolutePosition.Y + v2.AbsoluteSize.Y and v2.AbsolutePosition.Y < Position.Y then
                v1 = true
            end
            if not v1 or u51 or not u123.Visible then
                if p1.UserInputType == Enum.UserInputType.Touch then
                    touchBegan(p1, p2)
                end
                return
            end
            u51 = true
            u52 = p1
            u90.MobileShootDown = true
            p1.Changed:Connect(function() -- Line: 1386 -- upvalues: p1 (val), u51 (upval), u52 (upval), u90 (upval)
                if p1.UserInputState == Enum.UserInputState.End and u51 and u52 == p1 then
                    u51 = false
                    u90.MobileShootDown = false
                end
            end)
        end)
        UserInputService.InputChanged:connect(function(p1, p2) -- Line: 1417 -- upvalues: OnTouchChanged (val)
            if p1.UserInputType == Enum.UserInputType.Touch then
                OnTouchChanged(p1, p2)
            end
        end)
        UserInputService.InputEnded:connect(function(p1, p2) -- Line: 1422 -- upvalues: OnTouchEnded (val)
            if p1.UserInputType == Enum.UserInputType.Touch then
                OnTouchEnded(p1, p2)
            end
        end)
    end
end
function u127.HideCreatedButtons(p1) -- Line: 1430 -- upvalues: u127 (val), Folder (val)
    u127.Hidden = true
    Folder.Parent = nil
end
function u127.Show(p1) -- Line: 1436 -- upvalues: u92 (ref), u122 (ref), u127 (val)
    if u92 then
        if not u122 then
            u127:MakeButtons()
        end
        u92.Enabled = true
    end
    u127.IsShowing = true
end
function u127.Hide(p1) -- Line: 1447 -- upvalues: u92 (ref), u127 (val)
    if u92 then
        u92.Enabled = false
    end
    u127.IsShowing = false
end
v1.InputMethodChanged:Connect(function(p1) -- Line: 1454 -- upvalues: u92 (ref)
    if p1 == "Touch" and not u92 then
        u92 = game.Players.LocalPlayer.PlayerGui:WaitForChild("TouchGui")
    end
end)
if game.UserInputService.TouchEnabled then end
u26.SettingsChanged:Connect(function(p1) -- Line: 1465 -- upvalues: u122 (ref), u121 (ref), Folder (val), u127 (val), HUDService (val), peek (val), u26 (val)
    if not p1 or p1[1] ~= "Controls" then
        return
    end
    if p1[2] == "MobileSelectionMode" then
        if not u122 or u121 then
            return
        end
        Folder:ClearAllChildren()
        u127:MakeButtons()
        return
    end
    if p1[2] == "DynamicStaminaUI" then
        local Element = HUDService:GetElement("StaminaDisplay")
        if not Element then
            return
        end
        Element:SetDynamicStaminaEnabled(peek(u26.Controls.DynamicStaminaUI))
        return
    end
    if p1[2] == "ShowEditButton" and u122 and not u121 then
        local EditButton = Folder:FindFirstChild("EditButton")
        if EditButton then
            EditButton.Visible = peek(u26.Controls.ShowEditButton)
        end
    end
end)
function u127.EnterEditMode(p1) -- Line: 1488 -- upvalues: u122 (ref), u121 (ref), Generate (val)
    if u122 and not u121 then
        Generate(true)
    end
end
return u127