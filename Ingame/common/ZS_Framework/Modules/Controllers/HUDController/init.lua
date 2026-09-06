local Enabled
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local common = ReplicatedStorage.common
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local Resources = script:WaitForChild("Resources")
local deselect = Resources:FindFirstChild("deselect")
local select = Resources:FindFirstChild("select")
local HUD = Resources:WaitForChild("HUD")
local Weapons = HUD:WaitForChild("Weapons")
Weapons.AnchorPoint = Vector2.new(0.5, 1)
local UIScale = Instance.new("UIScale")
UIScale.Parent = HUD
local Template = Weapons:WaitForChild("Template")
local Utils = script:WaitForChild("Utils")
local HUDElements = script:WaitForChild("HUDElements")
local Settings = require(common.Settings)
local peek = require(game:GetService("ReplicatedStorage").Packages.Fusion).peek
local ItemData = require(common:WaitForChild("ItemData"))
local WepConfig = require(common:WaitForChild("WepConfig"))
local HUDService = require(common:WaitForChild("HUDService"))
local HUDService_2 = common:WaitForChild("HUDService")
local BottomStack = require(HUDService_2:WaitForChild("BottomStack"))
local BindUtil = require(common.BindUtil)
local u114 = require("./CameraController")
local ViewportModel = require(Utils.ViewportModel)
local WeaponNameUtil = require(common.ZS_Framework.Modules.Utils.WeaponNameUtil)
local u124 = nil
local Fade = require(HUDElements:WaitForChild("Fade"))
local HealthUI = require(HUDElements:WaitForChild("HealthUI"))
local StaminaDisplay = require(HUDElements:WaitForChild("StaminaDisplay"))
local DPadSelectionUI = require(HUDElements:WaitForChild("DPadSelectionUI"))
local Objectives = require(HUDElements:WaitForChild("Objectives"))
local MobileControls = require(HUDElements:WaitForChild("MobileControls"))
local AmmoDisplay = require(HUDElements:WaitForChild("AmmoDisplay"))
local ProgressionPopups = require(HUDElements:WaitForChild("ProgressionPopups"))
local Crosshair = require(HUDElements:WaitForChild("Crosshair"))
local BossHealth = require(HUDElements:WaitForChild("BossHealth"))
local ActiveModifierIcons = require(HUDElements:WaitForChild("ActiveModifierIcons"))
local TurkeyHuntBoostIndicators = require(HUDElements:WaitForChild("TurkeyHuntBoostIndicators"))
local AbilityDisplay = require(HUDElements:WaitForChild("AbilityDisplay"))
local SecondWindUI = require(HUDElements:WaitForChild("SecondWindUI"))
local ControlHints = require(common:WaitForChild("ControlHints"))
local u215 = {}
local u216 = nil
local u217 = nil
local u218 = {}
local u272 = false
local function hasWeaponBarButtons() -- Line: 65 -- upvalues: Weapons (val)
    for i, j in Weapons:GetChildren() do
        if j:IsA("Frame") then
            return true
        end
    end
    return false
end
local function weaponBarContentHeight() -- Line: 74 -- upvalues: Weapons (val)
    local v1 = 0
    for i, j in Weapons:GetChildren() do
        if j:IsA("Frame") then
            v1 = math.max(v1, j.AbsoluteSize.Y)
        end
    end
    if 0 < v1 then
        return v1
    end
    return Weapons.AbsoluteSize.Y
end
local u229 = BottomStack.Register({
    Name = "WeaponBar",
    Layer = BottomStack.Layers.Hotbar,
    Reserve = function() -- Line: 87 -- upvalues: weaponBarContentHeight (val)
        local Y
        local CurrentCamera = workspace.CurrentCamera
        if not CurrentCamera then
            Y = 0
        else
            Y = CurrentCamera.ViewportSize.Y
        end
        return 0.015 * Y + weaponBarContentHeight()
    end,
    Bottom = function() -- Line: 92
        local Y
        local CurrentCamera = workspace.CurrentCamera
        if not CurrentCamera then
            Y = 0
        else
            Y = CurrentCamera.ViewportSize.Y
        end
        return 0.015 * Y
    end,
    Apply = function() end,
})
local function updateWeaponBarStack() -- Line: 99 -- upvalues: u229 (val), u272 (ref), HUD (val), Weapons (val)
    local v1 = u229
    local Enabled = u272
    if Enabled then
        Enabled = HUD.Enabled
        if Enabled then
            for i, j in Weapons:GetChildren() do
                if j:IsA("Frame") then
                    Enabled = true
                    v1:SetOccupying(Enabled)
                    return
                end
            end
            Enabled = false
        end
    end
    v1:SetOccupying(Enabled)
end
local PropertyChangedSignal = Weapons:GetPropertyChangedSignal("AbsoluteSize")
PropertyChangedSignal:Connect(function() -- Line: 103 -- upvalues: u229 (val)
    u229:Invalidate()
end)
local u239 = {Inaccuracy = 0, ReloadOffset = Vector2.new(0, 0), IsVisible = true}
local function applyWeaponBarVisibility() -- Line: 113 -- upvalues: HUD (val), u239 (val), u218 (val), u229 (val), u272 (ref), Weapons (val)
    local IsVisible = u239.IsVisible
    if IsVisible then
        IsVisible = #u218 == 0
    end
    HUD.Enabled = IsVisible
    local v1 = u229
    local Enabled = u272
    if Enabled then
        Enabled = HUD.Enabled
        if Enabled then
            for i, j in Weapons:GetChildren() do
                if j:IsA("Frame") then
                    Enabled = true
                    v1:SetOccupying(Enabled)
                    return
                end
            end
            Enabled = false
        end
    end
    v1:SetOccupying(Enabled)
end
function u239.Init(p1) -- Line: 118 -- upvalues: u124 (ref), HUDService (val), Fade (val), HealthUI (val), StaminaDisplay (val), DPadSelectionUI (val), Objectives (val), MobileControls (val), AmmoDisplay (val), ProgressionPopups (val), Crosshair (val), BossHealth (val), ActiveModifierIcons (val), TurkeyHuntBoostIndicators (val), AbilityDisplay (val), SecondWindUI (val), ControlHints (val), Template (val), u217 (ref), u239 (val), u216 (ref), BindUtil (val), Settings (val), HUD (val), PlayerGui (val)
    u124 = require("./LocalPlayerController")
    game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
    HUDService:AddElement("Fade", Fade)
    HUDService:AddElement("HealthUI", HealthUI)
    HUDService:AddElement("StaminaDisplay", StaminaDisplay)
    HUDService:AddElement("DPadSelection", DPadSelectionUI)
    HUDService:AddElement("Objectives", Objectives)
    HUDService:AddElement("MobileControls", MobileControls)
    HUDService:AddElement("AmmoDisplay", AmmoDisplay)
    HUDService:AddElement("ProgressionPopups", ProgressionPopups)
    HUDService:AddElement("Crosshair", Crosshair)
    HUDService:AddElement("BossHealth", BossHealth)
    HUDService:AddElement("ActiveModifierIcons", ActiveModifierIcons)
    HUDService:AddElement("TurkeyHuntBoostIndicators", TurkeyHuntBoostIndicators)
    HUDService:AddElement("AbilityDisplay", AbilityDisplay)
    HUDService:AddElement("SecondWindUI", SecondWindUI)
    HUDService:AddElement("ControlHints", ControlHints)
    HUDService:ShowElement("ActiveModifierIcons")
    HUDService:ShowElement("TurkeyHuntBoostIndicators")
    HUDService:ShowElement("AbilityDisplay")
    Template.Parent = nil
    u217 = require("./WeaponController")
    ControlHints:Init(u217, u124)
    HUDService:ShowElement("ControlHints")
    u217.EquippedSlot:Connect(function(p1) -- Line: 155 -- upvalues: u239 (upval)
        u239:EquippedSlot(p1)
    end)
    u217.WeaponEquipped:Connect(function(p1) -- Line: 158 -- upvalues: u239 (upval)
        u239:WeaponEquipped(p1)
    end)
    u217.WeaponUnequipped:Connect(function() -- Line: 161 -- upvalues: u239 (upval)
        u239:WeaponUnequipped()
    end)
    u217.InventoryChanged:Connect(function(p1) -- Line: 164 -- upvalues: u239 (upval)
        u239:InventoryUpdated(p1)
    end)
    u217.TargetChanged:Connect(function(p1) -- Line: 167 -- upvalues: Crosshair (upval)
        if p1 then
            Crosshair:UpdateCrosshairColor(Color3.new(1, 0.509804, 0.509804))
            return
        end
        Crosshair:UpdateCrosshairColor(Color3.new(1, 1, 1))
    end)
    u217.InaccuracyUpdated:Connect(function() -- Line: 174 -- upvalues: Crosshair (upval), u216 (upval), u239 (upval), u124 (upval)
        Crosshair:UpdateCrosshair(u216, u239.ReloadOffset)
        local v1 = true
        if not u216 then
            if u216 and u216.Viewmodel then
                Crosshair:HitmarkerUpdateLense(nil)
            end
        elseif not u216.Aiming then
            if u216 and u216.Viewmodel then
                Crosshair:HitmarkerUpdateLense(nil)
            end
        elseif not u124.ThirdPerson then
            v1 = false
            if u216 and u216.Viewmodel then
                Crosshair:HitmarkerUpdateLense(u216.Viewmodel.Reticle)
            end
        elseif u216 and u216.Viewmodel then
            Crosshair:HitmarkerUpdateLense(nil)
        end
        Crosshair:SetCrossVisible(v1)
    end)
    require("../Classes/Weapon").HitEntity:Connect(function(p1, p2) -- Line: 191 -- upvalues: Crosshair (upval)
        local v1
        if p1 == "Kill" then
            v1 = Color3.new(1, 0, 0)
            Crosshair:EmitHitmarker(v1, nil, p2)
            return
        end
        if p1 == "Headshot" then
            v1 = Color3.new(1, 0.666667, 0)
            Crosshair:EmitHitmarker(v1, nil, p2)
            return
        end
        if p1 == "ArmorBreak" then
            v1 = Color3.new(0, 0.65098, 1)
            Crosshair:EmitHitmarker(v1, "BrokeArmor", p2)
            return
        end
        if p1 == "HitArmor" then
            Crosshair:EmitHitmarker(nil, "HitArmor", p2)
            return
        end
        if p1 == "Flesh" then
            Crosshair:EmitHitmarker(nil, nil, p2)
        end
    end)
    local u176 = false
    local u179 = BindUtil.getInputMethod()
    local function updateMobileVisibility() -- Line: 207 -- upvalues: u176 (ref), u179 (ref), HUDService (upval)
        if u176 then
            HUDService:HideElement("MobileControls")
            return
        end
        if u179 == "Touch" then
            HUDService:ShowElement("MobileControls")
            return
        end
        HUDService:HideElement("MobileControls")
    end
    Settings.OpenChanged:Connect(function(p1) -- Line: 215 -- upvalues: u176 (ref), u179 (ref), HUDService (upval)
        u176 = p1
        if u176 then
            HUDService:HideElement("MobileControls")
            return
        end
        if u179 == "Touch" then
            HUDService:ShowElement("MobileControls")
            return
        end
        HUDService:HideElement("MobileControls")
    end)
    BindUtil.InputMethodChanged:Connect(function(p1) -- Line: 220 -- upvalues: u179 (ref), u176 (ref), HUDService (upval)
        u179 = p1
        if u176 then
            HUDService:HideElement("MobileControls")
            return
        end
        if u179 == "Touch" then
            HUDService:ShowElement("MobileControls")
            return
        end
        HUDService:HideElement("MobileControls")
    end)
    if game.UserInputService.TouchEnabled then
        task.wait(5)
        HUDService:ShowElement("MobileControls")
    end
    HUD.Parent = PlayerGui
end
function u239.SetVisible(p1, p2) -- Line: 233 -- upvalues: u239 (val), HUD (val), u218 (val), u229 (val), u272 (ref), Weapons (val), HUDService (val)
    u239.IsVisible = p2
    local IsVisible = u239.IsVisible
    if IsVisible then
        IsVisible = #u218 == 0
    end
    HUD.Enabled = IsVisible
    local v1 = u229
    local Enabled = u272
    if Enabled then
        Enabled = HUD.Enabled
        if Enabled then
            for i, j in Weapons:GetChildren() do
                if j:IsA("Frame") then
                    Enabled = true
                    v1:SetOccupying(Enabled)
                    HUDService:SetAllVisibility(p2)
                    return
                end
            end
            Enabled = false
        end
    end
    v1:SetOccupying(Enabled)
    HUDService:SetAllVisibility(p2)
end
function u239.SetWeaponBarSuppressed(p1, p2, p3) -- Line: 239 -- upvalues: u218 (val), HUD (val), u239 (val), u229 (val), u272 (ref), Weapons (val)
    local v1 = table.find(u218, p2)
    if not p3 then
        if not p3 and v1 then
            table.remove(u218, v1)
        end
    elseif not v1 then
        table.insert(u218, p2)
    end
    local IsVisible = u239.IsVisible
    if IsVisible then
        IsVisible = #u218 == 0
    end
    HUD.Enabled = IsVisible
    local v2 = u229
    local Enabled = u272
    if Enabled then
        Enabled = HUD.Enabled
        if Enabled then
            for i, j in Weapons:GetChildren() do
                if j:IsA("Frame") then
                    Enabled = true
                    v2:SetOccupying(Enabled)
                    return
                end
            end
            Enabled = false
        end
    end
    v2:SetOccupying(Enabled)
end
function u239.MobileActive(p1) -- Line: 250 -- upvalues: AmmoDisplay (val)
    AmmoDisplay:MobileActive()
end
function u239.MobileInactive(p1) -- Line: 254 -- upvalues: AmmoDisplay (val)
    AmmoDisplay:MobileInactive()
end
function u239.InventoryUpdated(p1, p2) -- Line: 258 -- upvalues: u215 (ref)
    u215 = p2
    if not u215 then
        u215 = {}
    end
    UpdateBarIcons()
end
function u239.EquippedSlot(p1, p2) -- Line: 266 -- upvalues: deselect (val), select (val), DPadSelectionUI (val)
    if p2 then
        if select then
            select:Play()
        end
    elseif deselect then
        deselect:Play()
    end
    updateWeaponBarEquipped(p2)
    DPadSelectionUI:UpdateSelected(p2)
end
function u239.WeaponUnequipped(p1) -- Line: 276 -- upvalues: u216 (ref), Crosshair (val), AmmoDisplay (val)
    u216 = nil
    Crosshair:SetType("dot")
    AmmoDisplay:WeaponUnequipped()
end
function u239.WeaponEquipped(p1, p2) -- Line: 282 -- upvalues: u216 (ref), Crosshair (val), AmmoDisplay (val)
    u216 = p2
    Crosshair:SetType("cross")
    AmmoDisplay:WeaponEquipped(p2)
end
function u239.UpdateStamina(p1, p2) -- Line: 288 -- upvalues: StaminaDisplay (val)
    StaminaDisplay:SetPercentage(p2 / 100)
end
function UpdateBarIcons() -- Line: 293 -- upvalues: HUD (val), DPadSelectionUI (val), u215 (ref), Template (val), Weapons (val), u229 (val), WepConfig (val), ViewportModel (val), ItemData (val), WeaponNameUtil (val), BindUtil (val), peek (val), Settings (val), u217 (ref), u272 (ref)
    local Enabled, HideFromHotbar, PropertyChangedSignal, TextButton, WeaponId, v1, v2
    for i, j in HUD.Weapons:GetChildren() do
        if not (j:IsA("UIListLayout")) then
            j:Destroy()
        end
    end
    DPadSelectionUI:ResetInventory()
    local v3 = u215
    local v4 = nil
    local v5 = nil
    for k, n in v3, v4, v5 do
        if not n.Config then
            local u96 = Template:Clone()
            u96.NumberLabel.Text = n.HotbarSlot
            u96.LayoutOrder = n.HotbarSlot * 100 + k
            u96.Name = n.Slot
            u96.Parent = Weapons
            PropertyChangedSignal = u96:GetPropertyChangedSignal("AbsoluteSize")
            PropertyChangedSignal:Connect(function() -- Line: 317 -- upvalues: u229 (upval)
                u229:Invalidate()
            end)
            WeaponId = n.WeaponId
            if not WeaponId then
                u96.ViewportFrame:ClearAllChildren()
                u96.Fill.UIStroke.Color = ItemData.RarityColors.Stock.Main
                u96.Fill.BackgroundColor3 = ItemData.RarityColors.Stock.Back
                u96.NameLabel.TextColor3 = ItemData.RarityColors.Stock.Main
                u96.NameLabel.Text = "Empty"
            else
                v1 = WepConfig:StreamViewmodel(WeaponId)
                v1:andThen(function(p1) -- Line: 322 -- upvalues: u96 (val), ViewportModel (upval), ItemData (upval), n (val), WeaponNameUtil (upval), DPadSelectionUI (upval)
                    if not u96.Parent then
                        return
                    end
                    local v1 = p1:Clone()
                    resolveWeldPositions(v1)
                    cleanVModel(v1)
                    local ViewportFrame = u96.ViewportFrame
                    ViewportFrame:ClearAllChildren()
                    local Camera = Instance.new("Camera")
                    Camera.FieldOfView = 70
                    Camera.Parent = u96.ViewportFrame
                    ViewportFrame.CurrentCamera = Camera
                    local v2 = ViewportModel.new(ViewportFrame, Camera)
                    v2:SetModel(v1)
                    Camera.CFrame = v2:GetMinimumFitCFrame(CFrame.Angles(0, 1.5707963267948966, 0))
                    v1.Parent = u96:WaitForChild("ViewportFrame")
                    u96.Fill.UIStroke.Color = ItemData.RarityColors[n.Rarity].Main
                    u96.Fill.BackgroundColor3 = ItemData.RarityColors[n.Rarity].Back
                    u96.NameLabel.TextColor3 = ItemData.RarityColors[n.Rarity].Main
                    u96.NameLabel.Text = WeaponNameUtil.GetDisplayName(n.Name, n.Config)
                    DPadSelectionUI:AddItem(n, u96)
                end)
            end
            u96.Visible = true
            n.WeaponButton = u96
            TextButton = Instance.new("TextButton")
            TextButton.Name = "TapButton"
            TextButton.Size = UDim2.new(1, 0, 1, 0)
            TextButton.BackgroundTransparency = 1
            TextButton.Text = ""
            TextButton.TextTransparency = 1
            TextButton.ZIndex = 10
            v2 = if BindUtil.getInputMethod() == "Touch" then peek(Settings.Controls.MobileSelectionMode) == 1 else false
            TextButton.Visible = v2
            TextButton.Parent = u96
            TextButton.MouseButton1Click:Connect(function() -- Line: 372 -- upvalues: u217 (upval), n (val)
                u217:SwapWeapon(n.HotbarSlot)
            end)
        else
            HideFromHotbar = n.Config.HideFromHotbar
            if type(HideFromHotbar) == "function" then
                HideFromHotbar = HideFromHotbar(n.Config, n)
            end
        end
    end
    for m, i5 in Weapons:GetChildren() do
        if i5:IsA("Frame") then
            v3 = true
            if not v3 then
                u272 = false
            end
            v3 = u229
            Enabled = u272
            if Enabled then
                Enabled = HUD.Enabled
                if Enabled then
                    for i6, i7 in Weapons:GetChildren() do
                        if i7:IsA("Frame") then
                            Enabled = true
                            v3:SetOccupying(Enabled)
                            task.defer(function() -- Line: 380 -- upvalues: u229 (upval)
                                u229:Invalidate()
                            end)
                            return
                        end
                    end
                    Enabled = false
                end
            end
            v3:SetOccupying(Enabled)
            task.defer(function() -- Line: 380 -- upvalues: u229 (upval)
                u229:Invalidate()
            end)
            return
        end
    end
    v3 = false
end
local u259 = os.clock()
function updateWeaponBarEquipped(p1, p2) -- Line: 389 -- upvalues: u259 (ref), u272 (ref), u229 (val), HUD (val), Weapons (val), TweenService (val), BindUtil (val), peek (val), Settings (val)
    local u3 = os.clock()
    u259 = u3
    if p2 ~= true then
        u272 = true
        local v1 = u229
        local Enabled = u272
        if Enabled then
            Enabled = HUD.Enabled
            if Enabled then
                local v2, v3, v4, v5
                for i, j in Weapons:GetChildren() do
                    if j:IsA("Frame") then
                        Enabled = true
                        v1:SetOccupying(Enabled)
                        v5 = UDim2.new(0.5, 0, 0.985, 0)
                        Weapons:TweenPosition(v5, "Out", "Sine", 0.33, true)
                        v4 = 0
                        for k, n in Weapons:GetChildren() do
                            if n:IsA("Frame") then
                                if not p1 then
                                    v2 = UDim2.new((k - 1) * 0.3333333333333333, 0, 1, 0)
                                    n:TweenPosition(v2, "Out", "Sine", 0.2, true)
                                    v2 = UDim2.new(0.3183333333333333, 0, 20, 0)
                                    n:TweenSize(v2, "Out", "Sine", 0.2, true)
                                    v3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    TweenService:Create(n.Cover, v3, {BackgroundTransparency = 0.2}):Play()
                                elseif n.Name ~= tostring(p1) then
                                    v4 = v4 + 0.29 + 0.015
                                    v2 = UDim2.new(0.29, 0, 20, 0)
                                    n:TweenSize(v2, "Out", "Sine", 0.2, true)
                                    v3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    TweenService:Create(n.Cover, v3, {BackgroundTransparency = 0.2}):Play()
                                else
                                    v4 = v4 + 0.39 + 0.015
                                    v2 = UDim2.new(0.39, 0, 20, 0)
                                    n:TweenSize(v2, "Out", "Sine", 0.2, true)
                                    v3 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                                    TweenService:Create(n.Cover, v3, {BackgroundTransparency = 1}):Play()
                                end
                            end
                        end
                        coroutine.resume(coroutine.create(function() -- Line: 425 -- upvalues: BindUtil (upval), peek (upval), Settings (upval), u259 (upval), u3 (val), u272 (upval), u229 (upval), HUD (upval), Weapons (upval)
                            task.wait(2)
                            local v1 = if BindUtil.getInputMethod() == "Touch" then peek(Settings.Controls.MobileSelectionMode) == 1 else false
                            if u259 == u3 and not v1 then
                                local v2
                                u272 = false
                                local v3 = u229
                                local Enabled = u272
                                if Enabled then
                                    Enabled = HUD.Enabled
                                    if Enabled then
                                        for i, j in Weapons:GetChildren() do
                                            if j:IsA("Frame") then
                                                Enabled = true
                                                v3:SetOccupying(Enabled)
                                                v2 = UDim2.new(0.5, 0, 1.245, 0)
                                                Weapons:TweenPosition(v2, "In", "Sine", 0.33, true)
                                                return
                                            end
                                        end
                                        Enabled = false
                                    end
                                end
                                v3:SetOccupying(Enabled)
                                v2 = UDim2.new(0.5, 0, 1.245, 0)
                                Weapons:TweenPosition(v2, "In", "Sine", 0.33, true)
                            end
                        end))
                        return
                    end
                end
                Enabled = false
            end
        end
    end
end
function resolveWeldPositions(p1) -- Line: 440
    local Handle, joint, v1, v2, v3, v4
    local KeyParts = p1:FindFirstChild("KeyParts")
    if not KeyParts then
        Handle = p1.PrimaryPart
    else
        Handle = KeyParts:FindFirstChild("Handle")
    end
    if not Handle then
        return
    end
    local v5 = {}
    for i, j in p1:GetDescendants() do
        if j:IsA("JointInstance") and j.Part0 and j.Part1 then
            if not (v5[j.Part0]) then
                v5[j.Part0] = {}
            end
            if not (v5[j.Part1]) then
                v5[j.Part1] = {}
            end
            table.insert(v5[j.Part0], {joint = j, other = j.Part1})
            table.insert(v5[j.Part1], {joint = j, other = j.Part0})
        end
    end
    local v6 = {}
    v6[Handle] = true
    local v7 = {Handle}
    local v8 = 1
    while v8 <= #v7 do
        v2 = v7[v8]
        v8 = v8 + 1
        if v5[v2] then
            v3 = v5[v2]
            v4 = nil
            v1 = nil
            for k, n in v3, v4, v1 do
                if not (v6[n.other]) then
                    joint = n.joint
                    if joint.Part0 ~= v2 then
                        n.other.CFrame = v2.CFrame * joint.C1 * joint.C0:Inverse()
                    else
                        n.other.CFrame = v2.CFrame * joint.C0 * joint.C1:Inverse()
                    end
                    v6[n.other] = true
                    table.insert(v7, n.other)
                end
            end
        end
    end
end
function cleanVModel(p1) -- Line: 484
    for i, j in p1:QueryDescendants("BasePart[Transparency = 1], #KeyParts, #GlobalParts") do
        j:Destroy()
    end
end
local u264 = BindUtil.getInputMethod()
if u264 ~= "Touch" then
    u239:MobileInactive()
else
    u239:MobileActive()
    if peek(Settings.Controls.MobileSelectionMode) == 1 then
        local v1
        u272 = true
        Enabled = u272
        if Enabled then
            Enabled = HUD.Enabled
            if Enabled then
                for i, j in Weapons:GetChildren() do
                    if j:IsA("Frame") then
                        Enabled = true
                        u229:SetOccupying(Enabled)
                        v1 = UDim2.new(0.5, 0, 0.985, 0)
                        Weapons:TweenPosition(v1, "Out", "Sine", 0.33, true)
                        UIScale.Scale = peek(Settings.Controls.HotbarScale)
                        BindUtil.InputMethodChanged:Connect(function(p1) -- Line: 522 -- upvalues: u264 (ref), peek (val), Settings (val), Weapons (val), UIScale (val), u239 (val), u272 (ref), u229 (val), HUD (val)
                            local TapButton, v1, v2
                            u264 = p1
                            local v3 = u264 == "Touch"
                            local v4 = v3
                            if v4 then
                                v4 = peek(Settings.Controls.MobileSelectionMode) == 1
                            end
                            for i, j in Weapons:GetChildren() do
                                TapButton = j:FindFirstChild("TapButton")
                                if TapButton then
                                    TapButton.Visible = v4
                                end
                            end
                            local v5 = UIScale
                            if not v4 then
                                v1 = 1
                            else
                                v1 = peek(Settings.Controls.HotbarScale)
                            end
                            v5.Scale = v1
                            if not v3 then
                                u239:MobileInactive()
                                u272 = false
                                v5 = u229
                                local Enabled_3 = u272
                                if Enabled_3 then
                                    Enabled_3 = HUD.Enabled
                                    if Enabled_3 then
                                        for k, n in Weapons:GetChildren() do
                                            if n:IsA("Frame") then
                                                Enabled_3 = true
                                                v5:SetOccupying(Enabled_3)
                                                return
                                            end
                                        end
                                        Enabled_3 = false
                                    end
                                end
                                v5:SetOccupying(Enabled_3)
                                return
                            end
                            u239:MobileActive()
                            if not v4 then
                                u272 = false
                                v5 = u229
                                local Enabled_2 = u272
                                if Enabled_2 then
                                    Enabled_2 = HUD.Enabled
                                    if Enabled_2 then
                                        for m, i5 in Weapons:GetChildren() do
                                            if i5:IsA("Frame") then
                                                Enabled_2 = true
                                                v5:SetOccupying(Enabled_2)
                                                return
                                            end
                                        end
                                        Enabled_2 = false
                                    end
                                end
                                v5:SetOccupying(Enabled_2)
                                return
                            end
                            u272 = true
                            v5 = u229
                            local Enabled = u272
                            if Enabled then
                                Enabled = HUD.Enabled
                                if Enabled then
                                    for i6, i7 in Weapons:GetChildren() do
                                        if i7:IsA("Frame") then
                                            Enabled = true
                                            v5:SetOccupying(Enabled)
                                            v2 = UDim2.new(0.5, 0, 0.985, 0)
                                            Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
                                            return
                                        end
                                    end
                                    Enabled = false
                                end
                            end
                            v5:SetOccupying(Enabled)
                            v2 = UDim2.new(0.5, 0, 0.985, 0)
                            Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
                        end)
                        Settings.SettingsChanged:Connect(function(p1) -- Line: 555 -- upvalues: BindUtil (val), peek (val), Settings (val), UIScale (val), u229 (val)
                            if p1 and p1[1] == "Controls" and p1[2] == "HotbarScale" then
                                local v1 = BindUtil.getInputMethod() == "Touch"
                                local v2 = v1
                                if v2 then
                                    v2 = peek(Settings.Controls.MobileSelectionMode) == 1
                                end
                                if v2 then
                                    UIScale.Scale = peek(Settings.Controls.HotbarScale)
                                    u229:Invalidate()
                                end
                            end
                        end)
                        Settings.SettingsChanged:Connect(function(p1) -- Line: 567 -- upvalues: BindUtil (val), peek (val), Settings (val), Weapons (val), UIScale (val), u272 (ref), u229 (val), HUD (val)
                            local TapButton, v1, v2
                            if not p1 or p1[1] ~= "Controls" or p1[2] ~= "MobileSelectionMode" then
                                return
                            end
                            local v3 = BindUtil.getInputMethod() == "Touch"
                            if not v3 then
                                return
                            end
                            local v4 = peek(Settings.Controls.MobileSelectionMode) == 1
                            for i, j in Weapons:GetChildren() do
                                TapButton = j:FindFirstChild("TapButton")
                                if TapButton then
                                    TapButton.Visible = v4
                                end
                            end
                            if v4 then
                                UIScale.Scale = peek(Settings.Controls.HotbarScale)
                                u272 = true
                                v1 = u229
                                local Enabled = u272
                                if Enabled then
                                    Enabled = HUD.Enabled
                                    if Enabled then
                                        for m, i5 in Weapons:GetChildren() do
                                            if i5:IsA("Frame") then
                                                Enabled = true
                                                v1:SetOccupying(Enabled)
                                                v2 = UDim2.new(0.5, 0, 0.985, 0)
                                                Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
                                                return
                                            end
                                        end
                                        Enabled = false
                                    end
                                end
                                v1:SetOccupying(Enabled)
                                v2 = UDim2.new(0.5, 0, 0.985, 0)
                                Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
                                return
                            end
                            UIScale.Scale = 1
                            u272 = false
                            v1 = u229
                            local Enabled_2 = u272
                            if Enabled_2 then
                                Enabled_2 = HUD.Enabled
                                if Enabled_2 then
                                    for k, n in Weapons:GetChildren() do
                                        if n:IsA("Frame") then
                                            Enabled_2 = true
                                            v1:SetOccupying(Enabled_2)
                                            v2 = UDim2.new(0.5, 0, 1.245, 0)
                                            Weapons:TweenPosition(v2, "In", "Sine", 0.33, true)
                                            return
                                        end
                                    end
                                    Enabled_2 = false
                                end
                            end
                            v1:SetOccupying(Enabled_2)
                            v2 = UDim2.new(0.5, 0, 1.245, 0)
                            Weapons:TweenPosition(v2, "In", "Sine", 0.33, true)
                        end)
                        RunService:BindToRenderStep("HUD_UPDATE", Enum.RenderPriority.Camera.Value, function() -- Line: 593 -- upvalues: u114 (val), u239 (val)
                            local CurrentCamera = workspace.CurrentCamera
                            local v1 = CurrentCamera.CFrame.LookVector * 8000
                            local v2 = CurrentCamera:WorldToViewportPoint(u114.AimCFrame.LookVector * 8000)
                            local v3 = CurrentCamera:WorldToViewportPoint(v1)
                            u239.ReloadOffset = v2 - v3
                        end)
                        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
                        return u239
                    end
                end
                Enabled = false
            end
        end
        u229:SetOccupying(Enabled)
        v1 = UDim2.new(0.5, 0, 0.985, 0)
        Weapons:TweenPosition(v1, "Out", "Sine", 0.33, true)
        UIScale.Scale = peek(Settings.Controls.HotbarScale)
    end
end
BindUtil.InputMethodChanged:Connect(function(p1) -- Line: 522 -- upvalues: u264 (ref), peek (val), Settings (val), Weapons (val), UIScale (val), u239 (val), u272 (ref), u229 (val), HUD (val)
    local TapButton, v1, v2
    u264 = p1
    local v3 = u264 == "Touch"
    local v4 = v3
    if v4 then
        v4 = peek(Settings.Controls.MobileSelectionMode) == 1
    end
    for i, j in Weapons:GetChildren() do
        TapButton = j:FindFirstChild("TapButton")
        if TapButton then
            TapButton.Visible = v4
        end
    end
    local v5 = UIScale
    if not v4 then
        v1 = 1
    else
        v1 = peek(Settings.Controls.HotbarScale)
    end
    v5.Scale = v1
    if not v3 then
        u239:MobileInactive()
        u272 = false
        v5 = u229
        local Enabled_3 = u272
        if Enabled_3 then
            Enabled_3 = HUD.Enabled
            if Enabled_3 then
                for k, n in Weapons:GetChildren() do
                    if n:IsA("Frame") then
                        Enabled_3 = true
                        v5:SetOccupying(Enabled_3)
                        return
                    end
                end
                Enabled_3 = false
            end
        end
        v5:SetOccupying(Enabled_3)
        return
    end
    u239:MobileActive()
    if not v4 then
        u272 = false
        v5 = u229
        local Enabled_2 = u272
        if Enabled_2 then
            Enabled_2 = HUD.Enabled
            if Enabled_2 then
                for m, i5 in Weapons:GetChildren() do
                    if i5:IsA("Frame") then
                        Enabled_2 = true
                        v5:SetOccupying(Enabled_2)
                        return
                    end
                end
                Enabled_2 = false
            end
        end
        v5:SetOccupying(Enabled_2)
        return
    end
    u272 = true
    v5 = u229
    local Enabled = u272
    if Enabled then
        Enabled = HUD.Enabled
        if Enabled then
            for i6, i7 in Weapons:GetChildren() do
                if i7:IsA("Frame") then
                    Enabled = true
                    v5:SetOccupying(Enabled)
                    v2 = UDim2.new(0.5, 0, 0.985, 0)
                    Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
                    return
                end
            end
            Enabled = false
        end
    end
    v5:SetOccupying(Enabled)
    v2 = UDim2.new(0.5, 0, 0.985, 0)
    Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
end)
Settings.SettingsChanged:Connect(function(p1) -- Line: 555 -- upvalues: BindUtil (val), peek (val), Settings (val), UIScale (val), u229 (val)
    if p1 and p1[1] == "Controls" and p1[2] == "HotbarScale" then
        local v1 = BindUtil.getInputMethod() == "Touch"
        local v2 = v1
        if v2 then
            v2 = peek(Settings.Controls.MobileSelectionMode) == 1
        end
        if v2 then
            UIScale.Scale = peek(Settings.Controls.HotbarScale)
            u229:Invalidate()
        end
    end
end)
Settings.SettingsChanged:Connect(function(p1) -- Line: 567 -- upvalues: BindUtil (val), peek (val), Settings (val), Weapons (val), UIScale (val), u272 (ref), u229 (val), HUD (val)
    local TapButton, v1, v2
    if not p1 or p1[1] ~= "Controls" or p1[2] ~= "MobileSelectionMode" then
        return
    end
    local v3 = BindUtil.getInputMethod() == "Touch"
    if not v3 then
        return
    end
    local v4 = peek(Settings.Controls.MobileSelectionMode) == 1
    for i, j in Weapons:GetChildren() do
        TapButton = j:FindFirstChild("TapButton")
        if TapButton then
            TapButton.Visible = v4
        end
    end
    if v4 then
        UIScale.Scale = peek(Settings.Controls.HotbarScale)
        u272 = true
        v1 = u229
        local Enabled = u272
        if Enabled then
            Enabled = HUD.Enabled
            if Enabled then
                for m, i5 in Weapons:GetChildren() do
                    if i5:IsA("Frame") then
                        Enabled = true
                        v1:SetOccupying(Enabled)
                        v2 = UDim2.new(0.5, 0, 0.985, 0)
                        Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
                        return
                    end
                end
                Enabled = false
            end
        end
        v1:SetOccupying(Enabled)
        v2 = UDim2.new(0.5, 0, 0.985, 0)
        Weapons:TweenPosition(v2, "Out", "Sine", 0.33, true)
        return
    end
    UIScale.Scale = 1
    u272 = false
    v1 = u229
    local Enabled_2 = u272
    if Enabled_2 then
        Enabled_2 = HUD.Enabled
        if Enabled_2 then
            for k, n in Weapons:GetChildren() do
                if n:IsA("Frame") then
                    Enabled_2 = true
                    v1:SetOccupying(Enabled_2)
                    v2 = UDim2.new(0.5, 0, 1.245, 0)
                    Weapons:TweenPosition(v2, "In", "Sine", 0.33, true)
                    return
                end
            end
            Enabled_2 = false
        end
    end
    v1:SetOccupying(Enabled_2)
    v2 = UDim2.new(0.5, 0, 1.245, 0)
    Weapons:TweenPosition(v2, "In", "Sine", 0.33, true)
end)
RunService:BindToRenderStep("HUD_UPDATE", Enum.RenderPriority.Camera.Value, function() -- Line: 593 -- upvalues: u114 (val), u239 (val)
    local CurrentCamera = workspace.CurrentCamera
    local v1 = CurrentCamera.CFrame.LookVector * 8000
    local v2 = CurrentCamera:WorldToViewportPoint(u114.AimCFrame.LookVector * 8000)
    local v3 = CurrentCamera:WorldToViewportPoint(v1)
    u239.ReloadOffset = v2 - v3
end)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
return u239