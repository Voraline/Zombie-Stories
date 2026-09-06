local TweenService = game:GetService("TweenService")
local AmmoUI = script.AmmoUI
local Ammo = AmmoUI.Ammo
local ZS_Framework = game:GetService("ReplicatedStorage").common.ZS_Framework
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local WeaponController = require(ZS_Framework.Modules.Controllers.WeaponController)
local Objectives = require(ZS_Framework.Modules.Controllers.HUDController.HUDElements.Objectives)
local WeaponNameUtil = require(ZS_Framework.Modules.Utils.WeaponNameUtil)
local u44 = {}
local u45 = {}
local u46 = nil
local u47 = false
local u48 = 0
local u49 = {}
u49["Pump Action"] = "PUMP"
u49["Bolt Action"] = "BOLT"
u49.Auto = "AUTO"
u49["Semi-Auto"] = "SEMI"
u49.Burst = "BURST"
u49.Melee = "MELEE"
u49.Misc = "MISC"
AmmoUI.Parent = game.Players.LocalPlayer.PlayerGui
local u61 = {IsShowing = true}
function u61.Show(p1) -- Line: 38 -- upvalues: AmmoUI (val), u61 (val)
    AmmoUI.Enabled = true
    u61.IsShowing = true
end
function u61.Hide(p1) -- Line: 44 -- upvalues: AmmoUI (val), u61 (val)
    AmmoUI.Enabled = false
    u61.IsShowing = false
end
function u61.MobileActive(p1) -- Line: 49 -- upvalues: u47 (ref), u46 (ref), u61 (val)
    u47 = true
    if u46 then
        u61:WeaponEquipped(u46)
    end
end
function u61.MobileInactive(p1) -- Line: 56 -- upvalues: u47 (ref)
    u47 = false
end
function u61.Reloaded(p1) -- Line: 60 -- upvalues: u44 (val)
    local v1
    local v2 = u44
    local v3 = nil
    local v4 = nil
    for i, j in v2, v3, v4 do
        if 13 > i then
            v1 = 0
        else
            v1 = 1
        end
        j.ImageTransparency = v1
    end
    UpdateAmmoBar(true)
end
function u61.UpdateFireMode(p1) -- Line: 67 -- upvalues: u46 (ref), Ammo (val), u49 (val)
    if u46 then
        Ammo.FireMode.Text = u49[u46.FireMode]
    end
end
function u61.WeaponEquipped(p1, p2) -- Line: 73 -- upvalues: u46 (ref), u61 (val), u47 (ref), Ammo (val), u48 (ref)
    local v1
    u46 = p2
    u61:ResetAmmoBar()
    if u47 then
        Ammo.AnchorPoint = Vector2.new(1, 0)
        v1 = UDim2.new(0.99, 0, 0, u48 + 90)
        Ammo:TweenPosition(v1, "Out", "Quad", 0.25, true)
        return
    end
    Ammo.AnchorPoint = Vector2.new(1, 1)
    v1 = UDim2.new(0.99, 0, 0.99, 0)
    Ammo:TweenPosition(v1, "Out", "Quad", 0.25, true)
end
function u61.WeaponUnequipped(p1) -- Line: 85 -- upvalues: u46 (ref), u47 (ref), Ammo (val)
    local v1
    u46 = nil
    if u47 then
        Ammo.AnchorPoint = Vector2.new(1, 0)
        v1 = UDim2.new(0.99, 0, -0.4, 0)
        Ammo:TweenPosition(v1, "Out", "Quad", 0.25, true)
        return
    end
    Ammo.AnchorPoint = Vector2.new(1, 1)
    v1 = UDim2.new(0.99, 0, 1.36, 0)
    Ammo:TweenPosition(v1, "Out", "Quad", 0.25, true)
end
function u61.ResetAmmoBar(p1) -- Line: 96 -- upvalues: u46 (ref), Ammo (val), u49 (val), WeaponNameUtil (val), u44 (val), u45 (val)
    if u46 then
        local v1, v2
        Ammo.FireMode.Text = u49[u46.FireMode]
        local WeaponName = Ammo.Header.WeaponName
        local Config = u46.Config
        if Config.IsShotgun then
            v1 = "rbxassetid://4524757275"
        elseif Config.IsAPistol then
            v1 = "rbxassetid://5947844444"
        elseif not Config.UsePistolIcon then
            v1 = "rbxassetid://4524673573"
        end
        WeaponName.Text = WeaponNameUtil.GetDisplayName(u46.Name, Config)
        local v3 = u44
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            if Config.Ammo < 13 then
                v2 = 0
            elseif 13 <= i then
                v2 = 1
            end
            j.ImageTransparency = v2
            j.Image = v1
        end
        v3 = u45
        v4 = nil
        v5 = nil
        for k, n in v3, v4, v5 do
            n.Image = v1
            if Config.Ammo < k then
                v2 = 1
            elseif 13 > k then
                v2 = 0.75
            end
            n.ImageTransparency = v2
        end
    end
    UpdateAmmoBar(true)
end
function u61.UpdateAmmo(p1, p2) -- Line: 128 -- upvalues: u46 (ref), Ammo (val)
    local v1, v2, v3, v4
    if not u46 then
        return
    end
    local Ammo_2 = u46.Ammo
    local StoredAmmo = u46.StoredAmmo
    local v5 = string.sub(Ammo_2, -1)
    local v6 = string.sub(StoredAmmo, -1)
    local v7 = math.floor(Ammo_2 % 1000 / 100)
    local v8 = math.floor(Ammo_2 % 100 / 10)
    local v9 = math.floor(StoredAmmo / 1000)
    local v10 = math.floor(StoredAmmo % 1000 / 100)
    local v11 = math.floor(StoredAmmo % 100 / 10)
    local v12 = {}
    v12[Ammo.Mag.Digit1] = v5
    local Digit2 = Ammo.Mag.Digit2
    if 10 > Ammo_2 then
        v1 = ""
    else
        v1 = v8 .. " "
    end
    v12[Digit2] = v1
    local Digit3 = Ammo.Mag.Digit3
    if 100 > Ammo_2 then
        v1 = ""
    else
        v1 = v7 .. "  "
    end
    v12[Digit3] = v1
    v12[Ammo.Stored.Digit1] = v6
    local Digit2_2 = Ammo.Stored.Digit2
    if 10 > StoredAmmo then
        v1 = ""
    else
        v1 = v11 .. " "
    end
    v12[Digit2_2] = v1
    local Digit3_2 = Ammo.Stored.Digit3
    if 100 > StoredAmmo then
        v1 = ""
    else
        v1 = v10 .. "  "
    end
    v12[Digit3_2] = v1
    local Digit4 = Ammo.Stored.Digit4
    if 1000 > StoredAmmo then
        v1 = ""
    else
        v1 = v9 .. "  "
    end
    v12[Digit4] = v1
    local v13 = v12
    v1 = nil
    local v14 = nil
    for i, j in v13, v1, v14 do
        v2 = i.Parent.Anim[i.Name]
        if j ~= i.Text then
            v2.Text = i.Text
            v2.Position = UDim2.new(0, 0, 1, 0)
            i.Position = UDim2.new(0, 0, 0, 0)
        end
        if not u46.Config.IsMelee then
            v3 = j
        else
            v3 = ""
        end
        i.Text = v3
        v4 = UDim2.new(0, 0, 1, 0)
        i:TweenPosition(v4, "Out", "Quad", 0.1, true)
        v4 = UDim2.new(0, 0, 2, 0)
        v2:TweenPosition(v4, "Out", "Quad", 0.1, true)
    end
    UpdateAmmoBar(p2)
end
function init() -- Line: 171 -- upvalues: Ammo (val), u44 (val), u45 (val), WeaponController (val), u61 (val), Objectives (val), u47 (ref), u48 (ref), u46 (ref)
    local v1
    local v2 = 14
    local v3 = 1
    for i = 1, v2, v3 do
        v1 = Ammo.BulletsClip.Bullets.Template:Clone()
        v1.Name = i
        v1.Visible = true
        v1.LayoutOrder = i
        v1.Parent = Ammo.BulletsClip.Bullets
        if 13 <= i then
            v1.ImageTransparency = 1
        end
        table.insert(u44, v1)
    end
    v2 = Ammo.BulletsClip.Bullets:Clone()
    v2.Name = "BulletsBG"
    v2.Position = UDim2.new(0, 0, 0, 0)
    v2.Parent = Ammo.BulletsClip
    for j, k in v2:GetChildren() do
        if tonumber(k.Name) then
            table.insert(u45, k)
            k.ImageTransparency = 0.75
            if k.Name == "13" then
                k.ImageTransparency = 1
            end
        end
    end
    local u58 = nil
    Ammo.MouseButton1Down:Connect(function() -- Line: 198 -- upvalues: u58 (ref), WeaponController (upval)
        u58 = true
        task.spawn(function() -- Line: 200 -- upvalues: u58 (upval), WeaponController (upval)
            local v1 = 0
            while u58 do
                if v1 >= 0.25 then
                    break
                end
                v1 = v1 + task.wait()
            end
            if v1 < 0.25 then
                WeaponController:Reload()
                return
            end
            WeaponController:CycleFiremode()
        end)
    end)
    Ammo.MouseButton1Up:Connect(function() -- Line: 213 -- upvalues: u58 (ref)
        u58 = false
    end)
    WeaponController.FireModeChanged:Connect(function(p1) -- Line: 217 -- upvalues: u61 (upval)
        u61:UpdateFireMode()
    end)
    WeaponController.AmmoChanged:Connect(function(p1) -- Line: 220 -- upvalues: u61 (upval)
        u61:UpdateAmmo()
    end)
    WeaponController.Reloaded:Connect(function() -- Line: 223 -- upvalues: u61 (upval)
        u61:Reloaded()
    end)
    local GuiList = Objectives:GetGuiList()
    local PropertyChangedSignal = GuiList:GetPropertyChangedSignal("AbsoluteSize")
    PropertyChangedSignal:Connect(function() -- Line: 228 -- upvalues: u47 (upval), u48 (upval), GuiList (val), u46 (upval), u61 (upval)
        if u47 then
            u48 = GuiList.AbsoluteSize.Y
            if u46 then
                u61:WeaponEquipped(u46)
            end
        end
    end)
end
function UpdateAmmoBar(p1) -- Line: 238 -- upvalues: u46 (ref), Ammo (val), TweenService (val)
    local v1, v2, v3, v4
    if not u46 then
        return
    end
    local Ammo_2 = u46.Ammo
    local v5 = Ammo.BulletsClip.AbsoluteSize.Y / Ammo.BulletsClip.AbsoluteSize.X
    local v6 = v5 + Ammo.BulletsClip.Bullets.UIListLayout.Padding.Scale
    if Ammo_2 >= 13 then
        v2 = -0 * v6
        Ammo.BulletsClip.Bullets.Position = UDim2.new(v2, 0, 0, 0)
        if not p1 then
            v2 = UDim2.new(-1 * v6, 0, 0, 0)
            Ammo.BulletsClip.Bullets:TweenPosition(v2, "Out", "Quad", 0.1, true)
            v5 = Ammo.BulletsClip.Bullets["1"]
            v5.ImageTransparency = 0
            v2 = Ammo.BulletsClip.Bullets["1"]
            v3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(v2, v3, {ImageTransparency = 1}):Play()
            v1 = Ammo.BulletsClip.Bullets["13"]
            v1.ImageTransparency = 1
            v3 = Ammo.BulletsClip.Bullets["13"]
            v4 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(v3, v4, {ImageTransparency = 0}):Play()
        end
        return
    end
    if Ammo.BulletsClip.Bullets["14"].ImageTransparency == 1 then
        v5 = Ammo.BulletsClip.Bullets["13"]
        v5.ImageTransparency = 0
        if p1 then
            v5 = Ammo.BulletsClip.Bullets["14"]
            v5.ImageTransparency = 0
        else
            v2 = Ammo.BulletsClip.Bullets["14"]
            v3 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(v2, v3, {ImageTransparency = 0}):Play()
        end
    end
    v5 = 14 - Ammo_2
    if p1 then
        Ammo.BulletsClip.Bullets.Position = UDim2.new(-v5 * v6, 0, 0, 0)
        v1 = Ammo.BulletsClip.Bullets[v5]
        v1.ImageTransparency = 1
        return
    end
    v3 = UDim2.new(-v5 * v6, 0, 0, 0)
    Ammo.BulletsClip.Bullets:TweenPosition(v3, "Out", "Quad", 0.1, true)
    v1 = Ammo.BulletsClip.Bullets[v5]
    v1.ImageTransparency = 0
    v3 = Ammo.BulletsClip.Bullets[v5]
    v4 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(v3, v4, {ImageTransparency = 1}):Play()
end
init()
u61:WeaponUnequipped()
return u61