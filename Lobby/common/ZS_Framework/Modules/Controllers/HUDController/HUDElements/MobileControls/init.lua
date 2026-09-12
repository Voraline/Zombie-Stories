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
local Net = (game.ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("Net")
;(game.ReplicatedStorage.common:WaitForChild("Remotes")):WaitForChild("DataRemote")
local Sounds = script.Sounds
local ButtonTemplate = require(script.ButtonTemplate)
local Edit = require(script.Edit)
local Parent = script.Parent.Parent.Parent
local LocalPlayer = game.Players.LocalPlayer
local u89 = nil
local u90 = nil
local u91 = nil
local u92 = nil
local Folder = Instance.new("Folder")
require(((game.Players.LocalPlayer:WaitForChild("PlayerScripts")):WaitForChild("ControlScript")):WaitForChild("MasterControl"))
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
local u127 = {IsShowing = false, EditData = {}, PresetData = {}}

local function createTouchButton(p1, p2, p3) -- Line: 55 -- upvalues: u92 (ref), ButtonTemplate (val)
    local v1 = u92.TouchControlFrame.JumpButton:Clone()
    if not v1:FindFirstChildWhichIsA("UIScale") then
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
    local v1 = GuiService
    local Height = v1.TopbarInset.Height
    return UDim2.new(p1.X.Scale, p1.X.Offset, p1.Y.Scale, p1.Y.Offset + Height * (1 - p1.Y.Scale))
end

local function getFrameCenterInTouchGui(p1) -- Line: 83 -- upvalues: GuiService (val)
    if p1 and p1.AbsoluteSize.X ~= 0 then
        local AbsolutePosition = p1.AbsolutePosition
        local AbsoluteSize = p1.AbsoluteSize
        local v1 = AbsolutePosition.X + AbsoluteSize.X / 2
        local v2 = AbsolutePosition.Y + AbsoluteSize.Y / 2
        local v3 = GuiService
        local Height = v3.TopbarInset.Height
        return UDim2.fromOffset(v1, v2 - Height)
    end
    return nil
end

function Generate(p1) -- Line: 95
    -- upvalues: u122 (ref), u89 (ref), Parent (val), u90 (ref), u91 (ref), u92 (ref), u121 (ref), u118 (ref)
    -- upvalues: u120 (ref), u127 (val), Folder (val), u119 (val), createTouchButton (val), u124 (ref), Sounds (val)
    -- upvalues: u49 (val), NVGs (val), peek (val), u26 (val), Generate (val), GuiService (val), HUDService (val)
    -- upvalues: u126 (ref), u125 (ref), Edit (val), UserInputService (val), Net (val), u123 (ref)
    local u555, v1, v2, v3, v4, v5, v6, v7, v8
    if not u122 then
        u89 = require(Parent.LocalPlayerController)
        u90 = require(Parent.WeaponController)
        u91 = require(Parent.CameraController)
        u92 = (game.Players.LocalPlayer:WaitForChild("PlayerGui")):WaitForChild("TouchGui")
        u92.DisplayOrder = 1
    end
    if p1 then
        if u121 then
            return
        end
        u121 = true
        local v9 = {}
        u118 = v9
        if not u120 then
            if not u127.EditData then
                v9 = {}
            else
                v9 = table.clone(u127.EditData)
            end
            u120 = v9
        end
        Folder:ClearAllChildren()
    end
    if u127.EditData then
        local EditData, v10
        for k, v in pairs(u127.EditData) do
            v10 = v[2]
            if typeof(v10) ~= "UDim2" then
                v10 = v[2]
                if typeof(v10) == "table" then
                    v7 = v[2]
                    v10 = u127
                    EditData = v10.EditData
                    v8 = {v[1], UDim2.new(v7[1], v7[2], v7[3], v7[4])}
                    EditData[k] = v8
                end
            end
        end
    end
    local JumpButton = (u92:WaitForChild("TouchControlFrame")):WaitForChild("JumpButton")
    ;(JumpButton:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 130 -- upvalues: JumpButton (val)
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
    local u112, u113 = createTouchButton("SprintButton", "rbxassetid://6380639022", "Run: Off")
    u124 = u112
    local ThumbstickFrame = u92.TouchControlFrame.ThumbstickFrame
    local Visible = ThumbstickFrame.Visible
    if not u119.ThumbstickFrame then
        u119.ThumbstickFrame = ThumbstickFrame.Position
    end
    if ThumbstickFrame.Parent:FindFirstChild("RealThumbStick") then
        local RealThumbStick = ThumbstickFrame.Parent.RealThumbStick
        ThumbstickFrame:Destroy()
        ThumbstickFrame = RealThumbStick
        ThumbstickFrame.Name = "ThumbstickFrame"
    end
    v8 = ThumbstickFrame
    local v11 = nil
    if not p1 then
        ThumbstickFrame.Visible = Visible
    else
        v11 = ThumbstickFrame:Clone()
        v11.Parent = ThumbstickFrame.Parent
        v8.Visible = false
        v8.Name = "RealThumbStick"
    end
    ThumbstickFrame.Position = u119.ThumbstickFrame
    local UIScale_2 = ThumbstickFrame:FindFirstChild("UIScale")
    if UIScale_2 then
        UIScale_2.Scale = 1
    else
        Instance.new("UIScale").Parent = ThumbstickFrame
    end
    local u172, u173 = createTouchButton("CrouchButton", "rbxassetid://6377495066", "Crouch: Off")
    local Position = u172.Position
    local new = UDim2.new
    local v12 = JumpButton.Size.X.Offset * 0.5 - 15
    u172.Position = Position + new(0, v12, 0, -JumpButton.Size.Y.Offset)
    u119.CrouchButton = u172.Position
    u172.Parent = Folder
    u172.Visible = true
    if not p1 then
        local u200 = 0
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
            local v1
            while u172.Parent do
                v1 = task.wait()
                if u201 then
                    u200 = u200 + v1
                    if 0.25 <= u200 then
                        u89.PronePressed = not u89.PronePressed
                        u201 = false
                    end
                end
            end
        end)
    end
    local v13 = createTouchButton("NVGButton", "rbxassetid://6381369551", "NVGs")
    local LocalPlayer = game.Players.LocalPlayer
    local v14 = createTouchButton("ThirdPersonButton", "rbxassetid://13646515215", "View")
    v14.Position = UDim2.new(0, 0, 0, 0)
    u119.ThirdPersonButton = v14.Position
    v14.Parent = Folder
    v14.Visible = true
    if not p1 then
        local u241 = 0
        v14.MouseButton1Down:connect(function() -- Line: 241 -- upvalues: Sounds (upval), u89 (upval), u241 (ref)
            Sounds.Tap:Play()
            u89.TPPressed = true
            u241 = os.clock()
        end)
        v14.MouseButton1Up:connect(function() -- Line: 246 -- upvalues: u89 (upval), u241 (ref), u49 (upval)
            u89.TPPressed = false
            if os.clock() - u241 < 0.33 and not u89.ThirdPerson then
                u49:Show("Hold this button to go into third person")
            end
        end)
    end
    v13.Position = UDim2.new(0, v14.Size.X.Offset, 0, 0)
    u119.NVGButton = v13.Position
    v13.Parent = Folder
    v13.Visible = true
    if not p1 then
        v13.MouseButton1Click:connect(function() -- Line: 260 -- upvalues: NVGs (upval)
            NVGs.ToggleActivate()
        end)
    end
    local v15 = createTouchButton("EditButton", "rbxassetid://18582762591", "Edit")
    v15.Position = UDim2.new(0, v14.Size.X.Offset * 2, 0, 0)
    u119.EditButton = v15.Position
    v15.Parent = Folder
    local v16 = p1
    if not v16 then
        v16 = peek(u26.Controls.ShowEditButton)
    end
    v15.Visible = v16
    if not p1 then
        v15.MouseButton1Click:connect(function() -- Line: 274 -- upvalues: Sounds (upval), Generate (upval)
            Sounds.Tap:Play()
            Generate(true)
        end)
    end
    v16 = UDim2.fromOffset(0, GuiService.TopbarInset.Height)
    local v17 = UDim2.fromScale(0.85, 0.4) + v16
    local v18 = UDim2.fromScale(0.75, 0.4) + v16
    local Element = HUDService:GetElement("StaminaDisplay")
    if Element then
        local MainFrame = Element:GetMainFrame()
        if MainFrame then
            local v19
            if not MainFrame then
                v19 = nil
            elseif MainFrame.AbsoluteSize.X ~= 0 then
                local AbsolutePosition = MainFrame.AbsolutePosition
                local AbsoluteSize = MainFrame.AbsoluteSize
                v1 = AbsolutePosition.X + AbsoluteSize.X / 2
                v2 = AbsolutePosition.Y + AbsoluteSize.Y / 2
                v3 = GuiService
                local Height = v3.TopbarInset.Height
                v19 = UDim2.fromOffset(v1, v2 - Height)
            else
                v19 = nil
            end
            v17 = v19 or v17
        end
    end
    local Element_2 = HUDService:GetElement("AbilityDisplay")
    if Element_2 and Element_2.GetMainFrame then
        local MainFrame_2 = Element_2:GetMainFrame()
        if MainFrame_2 then
            local v20
            if not MainFrame_2 then
                v20 = nil
            elseif MainFrame_2.AbsoluteSize.X ~= 0 then
                local AbsolutePosition_2 = MainFrame_2.AbsolutePosition
                local AbsoluteSize_2 = MainFrame_2.AbsoluteSize
                v2 = AbsolutePosition_2.X + AbsoluteSize_2.X / 2
                v3 = AbsolutePosition_2.Y + AbsoluteSize_2.Y / 2
                v4 = GuiService
                local Height_2 = v4.TopbarInset.Height
                v20 = UDim2.fromOffset(v2, v3 - Height_2)
            else
                v20 = nil
            end
            v18 = v20 or v18
        end
    end
    v18 = v18 + v16
    v17 = v17 + v16
    local v21 = createTouchButton("StaminaButton", "", "Stamina")
    v21.AnchorPoint = Vector2.new(0.5, 0.5)
    v21.Position = v17
    v21.ImageLabel.Visible = false
    v21.TextLabel.Visible = true
    u119.StaminaButton = v17
    v21.Parent = Folder
    v21.Visible = p1
    local v22 = createTouchButton("AbilityButton", "", "Ability")
    v22.AnchorPoint = Vector2.new(0.5, 0.5)
    v22.Position = v18
    v22.ImageLabel.Visible = false
    v22.TextLabel.Visible = true
    u119.AbilityButton = v18
    v22.Parent = Folder
    v22.Visible = p1
    local StaminaButton = u127.EditData.StaminaButton
    if StaminaButton then
        local v23 = StaminaButton[2]
        if typeof(v23) ~= "table" then
            v21.Position = StaminaButton[2]
        else
            v23 = StaminaButton[2]
            v21.Position = unpack(v23)
        end
        v21.UIScale.Scale = StaminaButton[1]
    end
    local AbilityButton = u127.EditData.AbilityButton
    if AbilityButton then
        v1 = AbilityButton[2]
        if typeof(v1) ~= "table" then
            v22.Position = AbilityButton[2]
        else
            v1 = AbilityButton[2]
            v22.Position = unpack(v1)
        end
        v22.UIScale.Scale = AbilityButton[1]
    end
    local u475, u476, u477 = createTouchButton("AimButton", "rbxassetid://6380722466", "Aim: Off")
    local Position_2 = u475.Position
    local new_3 = UDim2.new
    local v24 = -JumpButton.Size.X.Offset * 0.5 - 15
    u475.Position = Position_2 + new_3(0, v24, 0, -JumpButton.Size.Y.Offset)
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
    v3 = peek(u26.Controls.MobileSelectionMode)
    v4 = true
    if v3 ~= 2 then
        v4 = v3 == 3
    end
    v5, _, u555 = createTouchButton("SwapButton", "rbxassetid://6380772911", "Swap")
    v5.Position = u475.Position + UDim2.new(0, 0, 0, -JumpButton.Size.Y.Offset)
    u119.SwapButton = v5.Position
    v5.Parent = Folder
    v5.Visible = v4
    if not p1 then
        v5.MouseButton1Down:connect(function() -- Line: 378 -- upvalues: peek (upval), u26 (upval), HUDService (upval)
            if peek(u26.Controls.MobileSelectionMode) == 3 then
                HUDService.Elements.DPadSelection:HoldingMobile()
            end
        end)
        v5.MouseButton1Up:connect(function() -- Line: 383 -- upvalues: peek (upval), u26 (upval), HUDService (upval)
            if peek(u26.Controls.MobileSelectionMode) == 3 then
                HUDService.Elements.DPadSelection:StopHoldingMobile()
            end
        end)
        v5.MouseButton1Click:connect(function() -- Line: 388 -- upvalues: peek (upval), u26 (upval), u90 (upval)
            if peek(u26.Controls.MobileSelectionMode) == 2 then
                u90:ClassicWeaponSwap()
            end
        end)
    end
    local Position_4 = u475.Position
    u112.Position = Position_4 + UDim2.new(0, JumpButton.Size.X.Offset, 0, -JumpButton.Size.Y.Offset)
    u119.SprintButton = u112.Position
    u112.Parent = Folder
    u112.Visible = true
    if not p1 then
        local function sprintToggle() -- Line: 401
            -- upvalues: u555 (val), u89 (upval), u113 (val), u90 (upval), u475 (val)
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
            if p1 == u126 or p1 == u125 then
                u639 = true
            end
        end)
        u112.MouseLeave:Connect(function() -- Line: 432 -- upvalues: u639 (ref)
            u639 = false
        end)
        u112.MouseButton1Up:Connect(function() -- Line: 436 -- upvalues: u639 (ref), u89 (upval), u555 (val), u113 (val), u90 (upval), u475 (val)
            if u639 then
                if not u89.AutoRun then
                    u89.AutoRun = true
                    if not u89.SprintPressed then
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
                elseif u89.AutoRun then
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
                end
            end
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
    local v25 = createTouchButton("ShootButton", "rbxassetid://6380700475", "Shoot")
    local Position_5 = v25.Position
    local new_4 = UDim2.new
    local v26 = -JumpButton.Size.X.Offset
    v25.Position = Position_5 + new_4(0, v26, 0, 0)
    v25.Parent = Folder
    v25.Visible = true
    v25.Active = false
    u119.ShootButton = v25.Position
    local ShootButton = u127.EditData.ShootButton
    if ShootButton then
        local v27 = ShootButton[2]
        if typeof(v27) ~= "table" then
            v25.Position = ShootButton[2]
        else
            v27 = ShootButton[2]
            v25.Position = unpack(v27)
        end
        v25.UIScale.Scale = ShootButton[1]
    end
    local SprintButton = u127.EditData.SprintButton
    if SprintButton then
        local v28 = SprintButton[2]
        if typeof(v28) ~= "table" then
            u112.Position = SprintButton[2]
        else
            v28 = SprintButton[2]
            u112.Position = unpack(v28)
        end
        u112.UIScale.Scale = SprintButton[1]
    end
    local SwapButton = u127.EditData.SwapButton
    if SwapButton then
        v26 = SwapButton[2]
        if typeof(v26) ~= "table" then
            v5.Position = SwapButton[2]
        else
            v26 = SwapButton[2]
            v5.Position = unpack(v26)
        end
        v5.UIScale.Scale = SwapButton[1]
    end
    local AimButton = u127.EditData.AimButton
    if AimButton then
        local v29 = AimButton[2]
        if typeof(v29) ~= "table" then
            u475.Position = AimButton[2]
        else
            v29 = AimButton[2]
            u475.Position = unpack(v29)
        end
        u475.UIScale.Scale = AimButton[1]
    end
    local NVGButton = u127.EditData.NVGButton
    if NVGButton then
        local v30 = NVGButton[2]
        if typeof(v30) ~= "table" then
            v13.Position = NVGButton[2]
        else
            v30 = NVGButton[2]
            v13.Position = unpack(v30)
        end
        v13.UIScale.Scale = NVGButton[1]
    end
    local ThirdPersonButton = u127.EditData.ThirdPersonButton
    if ThirdPersonButton then
        local v31 = ThirdPersonButton[2]
        if typeof(v31) ~= "table" then
            v14.Position = ThirdPersonButton[2]
        else
            v31 = ThirdPersonButton[2]
            v14.Position = unpack(v31)
        end
        v14.UIScale.Scale = ThirdPersonButton[1]
    end
    local JumpButton_2 = u127.EditData.JumpButton
    if JumpButton_2 then
        local v32 = JumpButton_2[2]
        if typeof(v32) ~= "table" then
            JumpButton.Position = JumpButton_2[2]
        else
            v32 = JumpButton_2[2]
            JumpButton.Position = unpack(v32)
        end
        JumpButton.UIScale.Scale = JumpButton_2[1]
    end
    local EditButton = u127.EditData.EditButton
    if EditButton then
        v6 = EditButton[2]
        if typeof(v6) ~= "table" then
            v15.Position = EditButton[2]
        else
            v6 = EditButton[2]
            v15.Position = unpack(v6)
        end
        v15.UIScale.Scale = EditButton[1]
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
        local v33 = ThumbstickFrame_2[2]
        if typeof(v33) ~= "table" then
            Frame.Position = ThumbstickFrame_2[2]
            ThumbstickFrame.Position = ThumbstickFrame_2[2]
        else
            v33 = ThumbstickFrame_2[2]
            Frame.Position = unpack(v33)
            v33 = ThumbstickFrame_2[2]
            ThumbstickFrame.Position = unpack(v33)
        end
        ThumbstickFrame.UIScale.Scale = ThumbstickFrame_2[1]
    end
    local CrouchButton = u127.EditData.CrouchButton
    if CrouchButton then
        local v34 = CrouchButton[2]
        if typeof(v34) ~= "table" then
            u172.Position = CrouchButton[2]
        else
            v34 = CrouchButton[2]
            u172.Position = unpack(v34)
        end
        u172.UIScale.Scale = CrouchButton[1]
    end
    if not p1 then
        v6 = {v25, u112, v5, u475, u172, v13, v14, JumpButton}
        for k2, i in pairs(v6) do
            if i then
                i.Active = false
            end
        end
    else
        local v35, v36, v37, v38
        v7 = v11
        v6 = {v25, u112, v5, u475, u172, v13, v14, v15, v21, v22, JumpButton, v7}
        local u1462 = Edit:Clone()
        u1462.Parent = game.Players.LocalPlayer.PlayerGui
        local Frame_2 = u1462.Frame
        local v39 = UDim2.new(0, 405, 0, 50)
        Frame_2:TweenSize(v39, "Out", "Quad", 0.25, true)
        local Options = u1462.Options
        v39 = UDim2.new(0, 306, 0, 50)
        Options:TweenSize(v39, "Out", "Quad", 0.25, true)
        local Presets = u1462.Presets
        v39 = UDim2.new(0, 306, 0, 70)
        Presets:TweenSize(v39, "Out", "Quad", 0.25, true)
        local u1312 = nil
        local u1313 = nil
        local u1314 = nil
        local u1315 = nil
        local u1316 = nil
        local u1317 = nil
        local u1318 = nil
        local u1319 = {}
        for k3, j in pairs(v6) do
            if j then
                j.Active = true
                j.BackgroundTransparency = 0.5
                j.BackgroundColor3 = Color3.new(0.5, 0, 0)
                if j == v7 then
                    v35 = #u1319 + 1
                    v36 = j.InputBegan
                    u1319[v35] = (v36:connect(function(p1) -- Line: 618 -- upvalues: u1312 (ref), Sounds (upval), j (val), u1318 (ref), u1316 (ref), u1462 (val)
                        if u1312 == nil then
                            p1.Changed:Connect(function() -- Line: 620
                                -- upvalues: p1 (val), u1312 (upval), Sounds (upval), j (upval), u1318 (upval)
                                -- upvalues: u1316 (upval), u1462 (upval)
                                if p1.UserInputState == Enum.UserInputState.End and u1312 == nil then
                                    local SoundService = game.SoundService
                                    local v1 = Sounds
                                    local Select = v1.Select
                                    SoundService:PlayLocalSound(Select)
                                    j.BackgroundColor3 = Color3.new(0, 0.75, 0)
                                    u1312 = j
                                    u1318 = j.Position
                                    u1316 = j.UIScale.Scale
                                    u1462.Frame.TextLabel.Text = "Editing " .. j.Name
                                    local v2 = u1462
                                    local Frame = v2.Frame
                                    v1 = UDim2.new(0, 405, 0, 150)
                                    Frame:TweenSize(v1, "Out", "Quad", 0.25, true)
                                    v2 = u1462
                                    local Options = v2.Options
                                    v1 = UDim2.new(0, 306, 0, 0)
                                    Options:TweenSize(v1, "Out", "Quad", 0.25, true)
                                    v2 = u1462
                                    local Presets = v2.Presets
                                    v1 = UDim2.new(0, 306, 0, 0)
                                    Presets:TweenSize(v1, "Out", "Quad", 0.25, true)
                                end
                            end)
                        end
                    end))
                else
                    v35 = #u1319 + 1
                    v36 = j.MouseButton1Click
                    u1319[v35] = (v36:connect(function() -- Line: 604 -- upvalues: u1312 (ref), Sounds (upval), j (val), u1318 (ref), u1316 (ref), u1462 (val)
                        if u1312 == nil then
                            local SoundService = game.SoundService
                            local v1 = Sounds
                            local Select = v1.Select
                            SoundService:PlayLocalSound(Select)
                            j.BackgroundColor3 = Color3.new(0, 0.75, 0)
                            u1312 = j
                            u1318 = j.Position
                            u1316 = j.UIScale.Scale
                            u1462.Frame.TextLabel.Text = "Editing " .. j.Name
                            local v2 = u1462
                            local Frame = v2.Frame
                            v1 = UDim2.new(0, 405, 0, 150)
                            Frame:TweenSize(v1, "Out", "Quad", 0.25, true)
                            v2 = u1462
                            local Options = v2.Options
                            v1 = UDim2.new(0, 306, 0, 0)
                            Options:TweenSize(v1, "Out", "Quad", 0.25, true)
                            v2 = u1462
                            local Presets = v2.Presets
                            v1 = UDim2.new(0, 306, 0, 0)
                            Presets:TweenSize(v1, "Out", "Quad", 0.25, true)
                        end
                    end))
                end
            end
        end

        local function positionIntersectsGuiObject(p1, p2) -- Line: 640
            if p1.X < p2.AbsolutePosition.X + p2.AbsoluteSize.X then
                local X = p1.X
                if p2.AbsolutePosition.X < X and p1.Y < p2.AbsolutePosition.Y + p2.AbsoluteSize.Y then
                    local Y = p1.Y
                    if p2.AbsolutePosition.Y < Y then
                        return true
                    end
                end
            end
            return false
        end

        local v40 = UserInputService
        v40.InputBegan:connect(function(p1, p2) -- Line: 651 -- upvalues: u1312 (ref), u1315 (ref), u1313 (ref), u1314 (ref), u1317 (ref)
            if u1312 then
                local v1
                local Position = p1.Position
                local v2 = u1312
                if not (Position.X < v2.AbsolutePosition.X + v2.AbsoluteSize.X) then
                    v1 = false
                else
                    local X = Position.X
                    if not (v2.AbsolutePosition.X < X)
                        or not (Position.Y < v2.AbsolutePosition.Y + v2.AbsoluteSize.Y) then
                        v1 = false
                    else
                        local Y = Position.Y
                        v1 = not not (v2.AbsolutePosition.Y < Y)
                    end
                end
                if v1 then
                    u1315 = true
                    u1313 = p1
                    u1314 = p1.Position
                    u1317 = u1312.Position
                    p1.Changed:Connect(function() -- Line: 657 -- upvalues: p1 (val), u1315 (upval)
                        if p1.UserInputState == Enum.UserInputState.End then
                            u1315 = false
                        end
                    end)
                end
            end
        end)

        local function update(p1) -- Line: 664 -- upvalues: u1314 (ref), u1312 (ref), u1317 (ref)
            local v1 = p1.Position - u1314
            local v2 = u1312
            local new = UDim2.new
            local v3 = u1317
            v2.Position = new(v3.X.Scale, u1317.X.Offset + v1.X, u1317.Y.Scale, u1317.Y.Offset + v1.Y)
        end

        local v41 = UserInputService
        v41.InputChanged:connect(function(p1, p2) -- Line: 669 -- upvalues: u1313 (ref), u1315 (ref), u1314 (ref), u1312 (ref), u1317 (ref)
            if p1 == u1313 and u1315 then
                local v1 = p1.Position - u1314
                local v2 = u1312
                local new = UDim2.new
                local v3 = u1317
                v2.Position = new(v3.X.Scale, u1317.X.Offset + v1.X, u1317.Y.Scale, u1317.Y.Offset + v1.Y)
            end
        end)

        local function ended() -- Line: 674 -- upvalues: u1462 (val)
            local v1 = u1462
            local Options = v1.Options
            local v2 = UDim2.new(0, 306, 0, 50)
            Options:TweenSize(v2, "Out", "Quad", 0.25, true)
            v1 = u1462
            local Presets = v1.Presets
            v2 = UDim2.new(0, 306, 0, 70)
            Presets:TweenSize(v2, "Out", "Quad", 0.25, true)
            v1 = u1462
            local Frame = v1.Frame
            v2 = UDim2.new(0, 405, 0, 50)
            Frame:TweenSize(v2, "Out", "Quad", 0.25, true)
            u1462.Frame.TextLabel.Text = "Tap on a button to edit"
        end

        local u1353 = false
        u1462.Options.Save.MouseButton1Click:connect(function() -- Line: 682
            -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), u1315 (ref), u1312 (ref), u120 (upval), u118 (upval)
            -- upvalues: u127 (upval), JumpButton (val), Folder (upval), u121 (upval), u1319 (val), Net (upval)
            local v1, v2
            if not u1462.Frame.Save.Text == "Sure?" then
                u1353 = false
            end
            if not u1353 then
                local SoundService = game.SoundService
                v2 = Sounds
                local Tap = v2.Tap
                SoundService:PlayLocalSound(Tap)
                u1353 = true
                u1462.Options.Save.Text = "Sure?"
                v1 = 0
                repeat
                    v1 = v1 + task.wait()
                until 1.5 <= v1 or u1353 == false
                if u1462.Parent then
                    u1462.Options.Save.Text = "Save"
                end
                u1353 = false
                return
            end
            if not u1315 and not u1312 and u1462.Options.Save.Text == "Sure?" then
                local SoundService_2 = game.SoundService
                v2 = Sounds
                local Save = v2.Save
                SoundService_2:PlayLocalSound(Save)
                u120 = nil
                for k, v in pairs(u118) do
                    u127.EditData[k] = v
                end
                JumpButton.BackgroundTransparency = 1
                Folder:ClearAllChildren()
                u1462:Destroy()
                u121 = false
                for k2, i in pairs(u1319) do
                    i:Disconnect()
                end
                table.clear(u1319)
                u127:MakeButtons()
                v1 = Net
                local v3 = u127
                local EditData = v3.EditData
                v1:FireServer("MobileEditData", EditData)
            end
        end)
        u1462.Options.Reset.MouseButton1Click:connect(function() -- Line: 722
            -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), u1315 (ref), u1312 (ref), u120 (upval), u127 (upval)
            -- upvalues: JumpButton (val), Folder (upval), u121 (upval), u1319 (val), Net (upval)
            local v1, v2
            if not u1462.Options.Reset.Text == "Sure?" then
                u1353 = false
            end
            if not u1353 then
                local SoundService = game.SoundService
                v2 = Sounds
                local Tap = v2.Tap
                SoundService:PlayLocalSound(Tap)
                u1353 = true
                u1462.Options.Reset.Text = "Sure?"
                v1 = 0
                repeat
                    v1 = v1 + task.wait()
                until 1.5 <= v1 or u1353 == false
                if not u1462.Parent then
                    return
                end
                u1462.Options.Reset.Text = "Reset"
                u1353 = false
                return
            end
            if not u1315 and not u1312 and u1462.Options.Reset.Text == "Sure?" then
                local SoundService_2 = game.SoundService
                v2 = Sounds
                local Error = v2.Error
                SoundService_2:PlayLocalSound(Error)
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
                v1 = Net
                local v3 = u127
                local EditData = v3.EditData
                v1:FireServer("MobileEditData", EditData)
            end
        end)
        u1462.Options.Cancel.MouseButton1Click:connect(function() -- Line: 760
            -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), u1315 (ref), u1312 (ref), u120 (upval), u127 (upval)
            -- upvalues: JumpButton (val), Folder (upval), u121 (upval), u1319 (val)
            local v1
            if not u1462.Frame.Cancel.Text == "Sure?" then
                u1353 = false
            end
            if not u1353 then
                local SoundService = game.SoundService
                v1 = Sounds
                local Tap = v1.Tap
                SoundService:PlayLocalSound(Tap)
                u1353 = true
                u1462.Options.Cancel.Text = "Sure?"
                local v2 = 0
                repeat
                    v2 = v2 + task.wait()
                until 1.5 <= v2 or u1353 == false
                if u1462.Parent then
                    u1462.Options.Cancel.Text = "Cancel"
                end
                u1353 = false
                return
            end
            if not u1315 and not u1312 and u1462.Options.Cancel.Text == "Sure?" then
                local SoundService_2 = game.SoundService
                v1 = Sounds
                local Error = v1.Error
                SoundService_2:PlayLocalSound(Error)
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
        u1462.Frame.Reset.MouseButton1Click:connect(function() -- Line: 798
            -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), u1315 (ref), u1312 (ref), u119 (upval), u118 (upval)
            -- upvalues: ended (val)
            local v1, v2
            if not u1462.Frame.Reset.Text == "Sure?" then
                u1353 = false
            end
            if u1353 then
                if not u1315 and u1312 and u1462.Frame.Reset.Text == "Sure?" then
                    local SoundService_2 = game.SoundService
                    v2 = Sounds
                    local Error = v2.Error
                    SoundService_2:PlayLocalSound(Error)
                    u1312.BackgroundColor3 = Color3.new(0.5, 0, 0)
                    u1312.UIScale.Scale = 1
                    u1312.Position = u119[u1312.Name]
                    v1 = u118
                    local v3 = u1312
                    local Name = v3.Name
                    v1[Name] = {1, u119[u1312.Name]}
                    u1312 = nil
                    ended()
                end
                return
            end
            local SoundService = game.SoundService
            v2 = Sounds
            local Tap = v2.Tap
            SoundService:PlayLocalSound(Tap)
            u1353 = true
            u1462.Frame.Reset.Text = "Sure?"
            v1 = 0
            repeat
                v1 = v1 + task.wait()
            until 1.5 <= v1 or u1353 == false
            if not u1462.Parent then
                return
            end
            u1462.Frame.Reset.Text = "Reset"
            u1353 = false
        end)
        u1462.Frame.Save.MouseButton1Click:connect(function() -- Line: 826
            -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), u1315 (ref), u1312 (ref), u118 (upval), ended (val)
            local v1, v2
            if not u1462.Frame.Save.Text == "Sure?" then
                u1353 = false
            end
            if u1353 then
                if not u1315 and u1312 and u1462.Frame.Save.Text == "Sure?" then
                    local SoundService_2 = game.SoundService
                    v2 = Sounds
                    local Save = v2.Save
                    SoundService_2:PlayLocalSound(Save)
                    u1312.BackgroundColor3 = Color3.new(0.5, 0, 0)
                    v1 = u118
                    local v3 = u1312
                    local Name = v3.Name
                    v1[Name] = {u1312.UIScale.Scale, u1312.Position}
                    u1312 = nil
                    ended()
                end
                return
            end
            local SoundService = game.SoundService
            v2 = Sounds
            local Tap = v2.Tap
            SoundService:PlayLocalSound(Tap)
            u1353 = true
            u1462.Frame.Save.Text = "Sure?"
            v1 = 0
            repeat
                v1 = v1 + task.wait()
            until 1.5 <= v1 or u1353 == false
            if not u1462.Parent then
                return
            end
            u1462.Frame.Save.Text = "Save"
            u1353 = false
        end)
        u1462.Frame.Cancel.MouseButton1Click:connect(function() -- Line: 852
            -- upvalues: u1462 (val), u1353 (ref), Sounds (upval), u1315 (ref), u1312 (ref), u1316 (ref), u1318 (ref)
            -- upvalues: ended (val)
            local v1
            if not u1462.Frame.Cancel.Text == "Sure?" then
                u1353 = false
            end
            if u1353 then
                if not u1315 and u1312 and u1462.Frame.Cancel.Text == "Sure?" then
                    local SoundService_2 = game.SoundService
                    v1 = Sounds
                    local Error = v1.Error
                    SoundService_2:PlayLocalSound(Error)
                    u1312.BackgroundColor3 = Color3.new(0.5, 0, 0)
                    u1312.UIScale.Scale = u1316
                    u1312.Position = u1318
                    u1312 = nil
                    ended()
                end
                return
            end
            local SoundService = game.SoundService
            v1 = Sounds
            local Tap = v1.Tap
            SoundService:PlayLocalSound(Tap)
            u1353 = true
            u1462.Frame.Cancel.Text = "Sure?"
            local v2 = 0
            repeat
                v2 = v2 + task.wait()
            until 1.5 <= v2 or u1353 == false
            if not u1462.Parent then
                return
            end
            u1462.Frame.Cancel.Text = "Cancel"
            u1353 = false
        end)
        local u1400 = {}
        u1462.Frame.Incr.InputBegan:connect(function(p1) -- Line: 881 -- upvalues: u1312 (ref), u1315 (ref), u1400 (val), Sounds (upval)
            if u1312 and not u1315 and not u1400[u1312.Name] then
                local SoundService, Tap, v1
                local u36 = true
                local u8 = nil
                local v2 = p1.Changed:Connect(function() -- Line: 884 -- upvalues: p1 (val), u36 (ref), u8 (ref)
                    if p1.UserInputState == Enum.UserInputState.End then
                        u36 = false
                        u8:Disconnect()
                    end
                end)
                while u36 do
                    if not u1312 then
                        break
                    end
                    v2 = task.wait()
                    SoundService = game.SoundService
                    v1 = Sounds
                    Tap = v1.Tap
                    SoundService:PlayLocalSound(Tap)
                    if u1312 then
                        u1312.UIScale.Scale = u1312.UIScale.Scale + 0.05 * (v2 * 60)
                    end
                end
            end
        end)
        u1462.Frame.Dec.InputBegan:connect(function(p1) -- Line: 900 -- upvalues: u1312 (ref), u1315 (ref), u1400 (val), Sounds (upval)
            if u1312 and not u1315 and not u1400[u1312.Name] then
                local SoundService, Tap, UIScale, v1, v2
                local u39 = true
                local u8 = nil
                local v3 = p1.Changed:Connect(function() -- Line: 903 -- upvalues: p1 (val), u39 (ref), u8 (ref)
                    if p1.UserInputState == Enum.UserInputState.End then
                        u39 = false
                        u8:Disconnect()
                    end
                end)
                while u39 do
                    if not u1312 then
                        break
                    end
                    v3 = task.wait()
                    v1 = game
                    SoundService = v1.SoundService
                    v2 = Sounds
                    Tap = v2.Tap
                    SoundService:PlayLocalSound(Tap)
                    if u1312 then
                        v1 = u1312
                        UIScale = v1.UIScale
                        v2 = u1312.UIScale.Scale - 0.05 * (v3 * 60)
                        UIScale.Scale = math.max(v2, 0.05)
                    end
                end
            end
        end)

        function v35(p1) -- Line: 919 -- upvalues: u127 (upval)
            local v1 = u127.PresetData[tostring(p1)]
            if v1 and next(v1) then
                return "Preset " .. p1
            end
            return "Preset " .. p1 .. " (Empty)"
        end

        for k4 = 1, 3 do
            local u1427 = u1462.Presets["Preset" .. k4]
            v38 = u127.PresetData[tostring(k4)]
            if not v38 or not next(v38) then
                v37 = "Preset " .. k4 .. " (Empty)"
            else
                v37 = "Preset " .. k4
            end
            u1427.Text = v37
            local u1448 = nil
            local u1449 = false
            u1427.MouseButton1Down:Connect(function() -- Line: 932
                -- upvalues: u1448 (ref), u1449 (ref), Sounds (upval), u127 (upval), u118 (upval), k4 (val), Net (upval)
                -- upvalues: u1427 (val)
                u1448 = os.clock()
                u1449 = true
                task.delay(0.6, function() -- Line: 935
                    -- upvalues: u1449 (upval), u1448 (upval), Sounds (upval), u127 (upval), u118 (upval), k4 (upval)
                    -- upvalues: Net (upval), u1427 (upval)
                    if u1449 and u1448 then
                        u1449 = false
                        local SoundService = game.SoundService
                        local v1 = Sounds
                        local Save = v1.Save
                        SoundService:PlayLocalSound(Save)
                        local v2 = table.clone(u127.EditData)
                        for k, v in pairs(u118) do
                            v2[k] = v
                        end
                        local v3 = u127
                        local PresetData = v3.PresetData
                        local v4 = k4
                        PresetData[tostring(v4)] = v2
                        v3 = Net
                        local v5 = {slot = k4, data = v2}
                        v3:FireServer("MobilePresetSave", v5)
                        u1427.Text = "Saved!"
                        task.delay(1, function() -- Line: 947 -- upvalues: u1427 (upval), k4 (upval), u127 (upval)
                            if u1427.Parent then
                                local v1
                                local v2 = u1427
                                local v3 = k4
                                local v4 = u127.PresetData[tostring(v3)]
                                if not v4 or not next(v4) then
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
            u1427.MouseButton1Up:Connect(function() -- Line: 955
                -- upvalues: u1449 (ref), u1448 (ref), u127 (upval), k4 (val), Sounds (upval), JumpButton (val)
                -- upvalues: Folder (upval), u1462 (val), u121 (upval), u1319 (val), Generate (upval)
                if u1449 and u1448 then
                    local v1 = os.clock() - u1448
                    if v1 < 0.6 then
                        u1449 = false
                        u1448 = nil
                        local v2 = u127
                        local PresetData = v2.PresetData
                        local v3 = k4
                        v1 = PresetData[tostring(v3)]
                        if not v1 or not next(v1) then
                            local SoundService_2 = game.SoundService
                            v3 = Sounds
                            local Error = v3.Error
                            SoundService_2:PlayLocalSound(Error)
                        else
                            local EditData, new, v4, v5, v6, v7, v8, v9
                            local SoundService = game.SoundService
                            v3 = Sounds
                            local Tap = v3.Tap
                            SoundService:PlayLocalSound(Tap)
                            u127.EditData = {}
                            for k, v in pairs(v1) do
                                v8 = v[2]
                                if typeof(v8) ~= "table" then
                                    u127.EditData[k] = v
                                else
                                    v7 = u127
                                    EditData = v7.EditData
                                    v8 = {}
                                    v9 = v[1]
                                    new = UDim2.new
                                    v4 = v[2][1]
                                    v5 = v[2][2]
                                    v6 = v[2][3]
                                    v8[1] = v9
                                    v8[2] = new(v4, v5, v6, v[2][4])
                                    EditData[k] = v8
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
    u123 = v25
    return u92, v25
end

local function applyCustomPositions() -- Line: 1005
    -- upvalues: HUDService (val), u127 (val), touchPosToScreenPos (val), peek (val), u26 (val)
    local Element = HUDService:GetElement("StaminaDisplay")
    local Element_2 = HUDService:GetElement("AbilityDisplay")
    local StaminaButton = u127.EditData.StaminaButton
    if Element then
        local v1
        if not StaminaButton then
            Element:SetCustomPosition(nil)
        else
            local v2 = StaminaButton[2]
            if typeof(v2) == "table" then
                v2 = UDim2.new(v2[1], v2[2], v2[3], v2[4])
            end
            v1 = touchPosToScreenPos
            v1 = v1(v2)
            Element:SetCustomPosition(v1)
        end
        local v3 = peek
        v1 = u26
        v3 = v3(v1.Controls.DynamicStaminaUI)
        Element:SetDynamicStaminaEnabled(v3)
        if not StaminaButton then
            Element:SetUIScale(1)
        else
            v1 = StaminaButton[1]
            Element:SetUIScale(v1 or 1)
        end
    end
    local AbilityButton = u127.EditData.AbilityButton
    if Element_2 then
        local v4
        if not AbilityButton then
            Element_2:SetCustomPosition(nil)
        else
            local v5 = AbilityButton[2]
            if typeof(v5) == "table" then
                v5 = UDim2.new(v5[1], v5[2], v5[3], v5[4])
            end
            v4 = touchPosToScreenPos
            v4 = v4(v5)
            Element_2:SetCustomPosition(v4)
        end
        if AbilityButton then
            v4 = AbilityButton[1]
            Element_2:SetUIScale(v4 or 1)
            return
        end
        Element_2:SetUIScale(1)
    end
end

function u127.MakeButtons(p1) -- Line: 1051
    -- upvalues: u127 (val), Generate (val), Folder (val), applyCustomPositions (val), u122 (ref), u125 (ref), u91 (ref)
    -- upvalues: u126 (ref), u90 (ref), UserInputService (val), u123 (ref)
    u127.Hidden = false
    local u4 = Generate()
    Folder.Parent = u4
    applyCustomPositions()
    if not u122 then
        u122 = true
        local PlayerGui = game.Players.LocalPlayer.PlayerGui
        local DynamicThumbstickFrame = u4.TouchControlFrame.DynamicThumbstickFrame
        local ThumbstickStart = DynamicThumbstickFrame.ThumbstickStart
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
            local v2 = false
            local X = p1.X
            if AbsolutePosition.X <= X then
                v2 = false
                local Y = p1.Y
                if AbsolutePosition.Y <= Y then
                    v2 = false
                    if p1.X <= v1.X then
                        v2 = p1.Y <= v1.Y
                    end
                end
            end
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
            if not u4.TouchControlFrame.DynamicThumbstickFrame.Visible
                or not DynamicThumbstickFrame
                or not TouchGui.Enabled then
                return false
            end
            local AbsolutePosition = DynamicThumbstickFrame.AbsolutePosition
            local v1 = AbsolutePosition + DynamicThumbstickFrame.AbsoluteSize
            local v2 = false
            local X = p1.X
            if AbsolutePosition.X <= X then
                v2 = false
                local Y = p1.Y
                if AbsolutePosition.Y <= Y then
                    v2 = false
                    if p1.X <= v1.X then
                        v2 = p1.Y <= v1.Y
                    end
                end
            end
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
            if not (0.5235987755982988 < v1) then
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

        local function OnTouchChanged(p1, p2) -- Line: 1186
            -- upvalues: u125 (upval), u29 (val), u47 (ref), u48 (val), u49 (val), u31 (ref), u32 (ref), u33 (ref)
            -- upvalues: u34 (ref), u30 (ref), u91 (upval)
            local v1, v2, v3, v4
            if p1 == u125 then
                return
            end
            if u29[p1] == nil then
                u29[p1] = p2
                if not p2 then
                    u47 = p1
                    v2 = u48
                    table.insert(v2, p1)
                    u49[p1] = {}
                    u31 = nil
                    u32 = nil
                    u33 = nil
                    u34 = false
                    u30 = u30 + 1
                end
            end
            if not (1 <= u30) then
                u31 = nil
                u32 = nil
                u33 = nil
                u34 = false
            elseif u29[p1] == false then
                local v5
                if u47 ~= p1 then
                    if not u49[p1][1] then
                        v1 = u49[p1]
                        v1[1] = p1.Position
                    end
                    if not u49[p1][2] then
                        v1 = u49[p1]
                        v1[2] = u49[p1][1]
                    end
                    v1 = p1.Position - u49[p1][2]
                    u91.X = (u91.X - v1.X / 150 * 1) % 6.283185307179586
                    v2 = u91
                    local v6 = u91.Y - v1.Y / 150 * 1
                    v5 = math.max(v6, -1.4)
                    v2.Y = math.min(v5, 1.4)
                    v2 = u49[p1]
                    v2[2] = p1.Position
                else
                    if not u49[p1][1] then
                        v1 = u49[p1]
                        v1[1] = p1.Position
                    end
                    if not u49[p1][2] then
                        v1 = u49[p1]
                        v1[2] = u49[p1][1]
                    end
                    v1 = p1.Position - u49[p1][2]
                    local Sensitivity = u91:GetSensitivity()
                    v3 = u91:GetMagnificationSensitivity() * Sensitivity
                    v1 = Vector2.new(v1.X * v3, v1.Y * UserSettings().GameSettings:GetCameraYInvertValue() * v3)
                    u91.X = (u91.X - v1.X / 150 * 1) % 6.283185307179586
                    v5 = u91
                    local v7 = u91.Y - v1.Y / 150 * 1
                    v4 = math.max(v7, -1.4)
                    v5.Y = math.min(v4, 1.4)
                    v5 = u49[p1]
                    v5[2] = p1.Position
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
            if startingDiff and pinchBeginZoom then
                v4 = startingDiff
                v3 = magnitude / (math.max(0.01, v4))
                math.clamp(v3, 0.1, 10)
                return
            end
            startingDiff = magnitude
            pinchBeginZoom = 0.5
        end

        local u51 = nil
        local u52 = nil

        local function touchBegan(p1, p2) -- Line: 1300
            -- upvalues: u125 (upval), isInDynamicThumbstickArea (val), u126 (upval), isInThumbstickArea (val)
            local v1 = p1.UserInputType == Enum.UserInputType.Touch
            assert(v1)
            v1 = p1.UserInputState == Enum.UserInputState.Begin
            assert(v1)
            if u125 == nil and isInDynamicThumbstickArea(p1.Position) and not p2 then
                u125 = p1
                return
            end
            if u126 == nil and isInThumbstickArea(p1.Position) then
                u126 = p1
                return
            end
        end

        local function OnTouchEnded(p1, p2) -- Line: 1318
            -- upvalues: u52 (ref), u51 (ref), u90 (upval), u29 (val), u30 (ref), u31 (ref), u32 (ref), u33 (ref)
            -- upvalues: u34 (ref), u48 (val), u49 (val), u47 (ref), u125 (upval), u126 (upval)
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
                if u47 == p1 and 1 <= #u48 then
                    u31 = nil
                    u32 = nil
                    u33 = nil
                    u34 = false
                    u47 = u48[#u48]
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
            if p1.X < p2.AbsolutePosition.X + p2.AbsoluteSize.X then
                local X = p1.X
                if p2.AbsolutePosition.X < X and p1.Y < p2.AbsolutePosition.Y + p2.AbsoluteSize.Y then
                    local Y = p1.Y
                    if p2.AbsolutePosition.Y < Y then
                        return true
                    end
                end
            end
            return false
        end

        local v1 = UserInputService
        v1.InputBegan:connect(function(p1, p2) -- Line: 1375 -- upvalues: u123 (upval), u51 (ref), u52 (ref), u90 (upval), touchBegan (val)
            if p1.UserInputType == Enum.UserInputType.Touch and u123 then
                local v1
                local Position = p1.Position
                local v2 = u123
                if not (Position.X < v2.AbsolutePosition.X + v2.AbsoluteSize.X) then
                    v1 = false
                else
                    local X = Position.X
                    if not (v2.AbsolutePosition.X < X)
                        or not (Position.Y < v2.AbsolutePosition.Y + v2.AbsoluteSize.Y) then
                        v1 = false
                    else
                        local Y = Position.Y
                        v1 = not not (v2.AbsolutePosition.Y < Y)
                    end
                end
                if v1 and not u51 and u123.Visible then
                    u51 = true
                    u52 = p1
                    u90.MobileShootDown = true
                    p1.Changed:Connect(function() -- Line: 1386 -- upvalues: p1 (val), u51 (upval), u52 (upval), u90 (upval)
                        if p1.UserInputState == Enum.UserInputState.End and u51 and u52 == p1 then
                            u51 = false
                            u90.MobileShootDown = false
                        end
                    end)
                    return
                end
            end
            if p1.UserInputType == Enum.UserInputType.Touch then
                touchBegan(p1, p2)
            end
        end)
        v1 = UserInputService
        v1.InputChanged:connect(function(p1, p2) -- Line: 1417 -- upvalues: OnTouchChanged (val)
            if p1.UserInputType == Enum.UserInputType.Touch then
                OnTouchChanged(p1, p2)
            end
        end)
        v1 = UserInputService
        v1.InputEnded:connect(function(p1, p2) -- Line: 1422 -- upvalues: OnTouchEnded (val)
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
if game.UserInputService.TouchEnabled and not u92 then
    local TouchGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("TouchGui")
end
u26.SettingsChanged:Connect(function(p1) -- Line: 1465
    -- upvalues: u122 (ref), u121 (ref), Folder (val), u127 (val), HUDService (val), peek (val), u26 (val)
    if p1 and p1[1] == "Controls" then
        if p1[2] ~= "MobileSelectionMode" then
            if p1[2] == "DynamicStaminaUI" then
                local Element = HUDService:GetElement("StaminaDisplay")
                if Element then
                    local v1 = peek
                    local v2 = u26
                    v1 = v1(v2.Controls.DynamicStaminaUI)
                    Element:SetDynamicStaminaEnabled(v1)
                    return
                end
            elseif p1[2] == "ShowEditButton" and u122 and not u121 then
                local EditButton = Folder:FindFirstChild("EditButton")
                if EditButton then
                    EditButton.Visible = peek(u26.Controls.ShowEditButton)
                end
            end
        elseif u122 and not u121 then
            Folder:ClearAllChildren()
            u127:MakeButtons()
            return
        end
    end
end)

function u127.EnterEditMode(p1) -- Line: 1488 -- upvalues: u122 (ref), u121 (ref), Generate (val)
    if u122 and not u121 then
        Generate(true)
    end
end

return u127