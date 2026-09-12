local u39
local v1 = {}
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")
local u18 = require("@game/ReplicatedStorage/common/PlayerHandler")
local Net = (game:GetService("ReplicatedStorage").common:WaitForChild("Remotes")):WaitForChild("Net")
if not RunService:IsClient() then
    u39 = nil
else
    u39 = require("@game/ReplicatedStorage/common/zap")
end
local u40 = nil
local Resources = script:WaitForChild("Resources")
local DashGui = script:WaitForChild("DashGui")
local ColorCorrection = Resources.ColorCorrection
local AmbientReverb = SoundService.AmbientReverb
local common = game.ReplicatedStorage.common
local u57 = nil
local u58 = nil
local u59 = false
local u60 = false
local u61 = 0
local u66 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
v1.DrawSpeed = 2
v1.HolsterSpeed = 2
v1.Ammo = 0
v1.StoredAmmo = 0
v1.FireMode = "Misc"
v1.IsDeployable = true
v1.RefillableDeployable = true
v1.IsOffHand = true
v1.HideFromHotbar = true
v1.CannotSwapTo = true
local u78 = nil
if not RunService:IsClient() then
    local u128 = require("@game/ServerStorage/common/WepHandler")
    Net.OnServerEvent:Connect(function(p1, p2, p3) -- Line: 115 -- upvalues: u18 (val), Net (val), u128 (val)
        if p2 == "ActivateFocus" then
            local v1 = u18:WaitForPlayerState(p1)
            if v1 then
                v1.IsFocused = p3
                Net:FireClient(p1, "ActivateFocus", p3)
                if not p3 and p1:GetAttribute("InTestRange") then
                    task.delay(0.5, function() -- Line: 124 -- upvalues: u128 (upval), p1 (val)
                        local v1 = u128
                        local v2 = p1
                        v1:FillFocus(v2, 100)
                    end)
                end
            end
        end
    end)
else
    DashGui = DashGui:Clone()
    DashGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ColorCorrection = ColorCorrection:Clone()
    ColorCorrection.Parent = game.Lighting
    u58 = Instance.new("Folder")
    u58.Name = "FocusFolder"
    u58.Parent = game.ReplicatedStorage
    u40 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
    u39.FocusDeactivated.On(function() -- Line: 82
        -- upvalues: u59 (ref), u78 (ref), DashGui (ref), Resources (val), SoundService (val), TweenService (val)
        -- upvalues: ColorCorrection (ref), u66 (val), AmbientReverb (ref), u57 (ref), u40 (ref)
        if u59 and u78 then
            local u2 = u78
            DashGui.On.Value = false
            Resources.Focus:Stop()
            local v1 = SoundService
            local v2 = Resources
            local FocusEnd = v2.FocusEnd
            v1:PlayLocalSound(FocusEnd)
            v1 = TweenService
            v2 = ColorCorrection
            local v3 = u66
            local v4 = {TintColor = Color3.new(1, 1, 1)}
            v1:Create(v2, v3, v4):Play()
            SoundService.AmbientReverb = AmbientReverb
            u59 = false
            u2.Busy = false
            u57 = nil
            u40:FocusActivated(false)
            task.delay(0.5, function() -- Line: 100 -- upvalues: u2 (val)
                if u2.Viewmodel and u2.Viewmodel.FocusModel then
                    u2.Viewmodel.FocusModel.Parent = u2.Viewmodel.Model
                end
                if u2.Viewmodel then
                    u2.Viewmodel:StopAnimation("Deploy")
                    u2.Viewmodel:PlayAnimation("Equip")
                end
            end)
        end
    end)
end
v1.Deployable = true

local function disable(p1) -- Line: 135
    -- upvalues: u59 (ref), DashGui (ref), Resources (val), SoundService (val), TweenService (val)
    -- upvalues: ColorCorrection (ref), u66 (val), AmbientReverb (ref), Net (val), u40 (ref)
    print("[Focus:disable] Starting disable - Weapon.Busy:", p1.Busy, "FocusActive:", u59)
    DashGui.On.Value = false
    Resources.Focus:Stop()
    local v1 = SoundService
    local v2 = Resources
    local FocusEnd = v2.FocusEnd
    v1:PlayLocalSound(FocusEnd)
    v1 = TweenService
    v2 = ColorCorrection
    local v3 = u66
    local v4 = {TintColor = Color3.new(1, 1, 1)}
    v1:Create(v2, v3, v4):Play()
    SoundService.AmbientReverb = AmbientReverb
    Net:FireServer("ActivateFocus", false)
    u40:FocusActivated(false)
    u59 = false
    p1.Busy = false
    print("[Focus:disable] FocusActive and Weapon.Busy set to false - Focus can be re-used")
    task.wait(0.5)
    if p1.Viewmodel and p1.Viewmodel.FocusModel then
        p1.Viewmodel.FocusModel.Parent = p1.Viewmodel.Model
    end
    p1.Viewmodel:StopAnimation("Deploy")
    p1.Viewmodel:PlayAnimation("Equip")
    print("[Focus:disable] Animation cleanup complete")
end

function v1.Use(p1, p2) -- Line: 162
    -- upvalues: u60 (ref), u57 (ref), u39 (val), u78 (ref), u59 (ref), u61 (ref), u40 (ref), DashGui (ref)
    -- upvalues: Resources (val), SoundService (val), TweenService (val), ColorCorrection (ref), u66 (val)
    -- upvalues: AmbientReverb (ref), u58 (ref)
    if p2.Busy or u60 or p2.Ammo <= 0 then
        return
    end
    local u7 = tick()
    u57 = u7
    p2.Busy = true
    u60 = true
    task.defer(function() -- Line: 180
        -- upvalues: u57 (upval), u7 (val), p2 (val), u60 (upval), u39 (upval), u78 (upval), u59 (upval), u61 (upval)
        -- upvalues: u40 (upval), DashGui (upval), Resources (upval), SoundService (upval), TweenService (upval)
        -- upvalues: ColorCorrection (upval), u66 (upval), AmbientReverb (upval), u58 (upval)
        if u57 ~= u7 then
            p2.Busy = false
            return
        end
        p2.Viewmodel:StopAnimation("Equip")
        p2.Viewmodel:PlayAnimation("Deploy", nil, nil, 1)
        local FocusModel = nil
        if p2.Viewmodel.Model then
            FocusModel = p2.Viewmodel.FocusModel
            if not FocusModel then
                p2.Viewmodel.FocusModel = p2.Viewmodel.Model.Weapon
                FocusModel = p2.Viewmodel.FocusModel
            end
        end
        local ParticleEmitter = FocusModel.MedSprayMesh.ParticleEmitter
        local Sound = FocusModel.MedSprayMesh.Sound
        ParticleEmitter.Enabled = true
        Sound:Play()
        task.wait(1)
        if u57 ~= u7 then
            if u57 == nil then
                u60 = false
                ParticleEmitter.Enabled = false
                Sound:Stop()
                p2.Viewmodel:StopAnimation("Deploy")
                p2.Busy = false
            end
            return
        end
        u60 = false
        if not u39.ActivateFocus.Call() then
            ParticleEmitter.Enabled = false
            Sound:Stop()
            p2.Viewmodel:StopAnimation("Deploy")
            p2.Busy = false
            u57 = nil
            return
        end
        u78 = p2
        ParticleEmitter.Enabled = false
        Sound:Stop()
        local v1 = p2
        v1.Ammo = v1.Ammo - 1
        p2:UpdateAmmo()
        u59 = true
        u61 = os.clock()
        u40:FocusActivated(true)
        DashGui.On.Value = true
        Resources.Focus:Play()
        v1 = SoundService
        local v2 = Resources
        local FocusActive = v2.FocusActive
        v1:PlayLocalSound(FocusActive)
        task.delay(0.2, function() -- Line: 255 -- upvalues: SoundService (upval), Resources (upval)
            local v1 = SoundService
            local v2 = Resources
            local FocusActive2 = v2.FocusActive2
            v1:PlayLocalSound(FocusActive2)
        end)
        v1 = TweenService
        v2 = ColorCorrection
        local v3 = u66
        local v4 = {TintColor = Color3.fromRGB(202, 197, 255)}
        v1:Create(v2, v3, v4):Play()
        AmbientReverb = SoundService.AmbientReverb
        SoundService.AmbientReverb = "Hangar"
        FocusModel.Parent = u58
        task.delay(1.2, function() -- Line: 273 -- upvalues: ParticleEmitter (val), Sound (val)
            ParticleEmitter.Enabled = false
            Sound:Stop()
        end)
    end)
end

function v1.ServerUse(p1, p2, p3) -- Line: 283 -- upvalues: u18 (val), Net (val)
    local Ammo = p3.Ammo
    if not Ammo or (Ammo[1] or 0) <= 0 then
        return
    end
    Ammo[1] = Ammo[1] - 1
    local u13 = u18:WaitForPlayerState(p2)
    Net:FireClient(p2, "ActivateFocus", true)
    u13.IsFocused = true
    task.delay(20, function() -- Line: 298 -- upvalues: u13 (val), Net (upval), p2 (val)
        if u13.IsFocused then
            local v1 = Net
            local v2 = p2
            v1:FireClient(v2, "ActivateFocus", false)
            u13.IsFocused = false
        end
    end)
end

function v1.Reset(p1, p2) -- Line: 307 -- upvalues: u57 (ref), u59 (ref), disable (val)
    u57 = nil
    if u59 then
        task.defer(disable, p2)
    end
end

function v1.IsActivating(p1) -- Line: 315 -- upvalues: u60 (ref)
    return u60
end

function v1.IsFullyActivated(p1) -- Line: 320 -- upvalues: u59 (ref)
    return u59
end

function v1.GetRemainingTime(p1) -- Line: 325 -- upvalues: u59 (ref), u61 (ref)
    if not u59 then
        return 0
    end
    local v1 = 20 - (os.clock() - u61)
    return (math.max(0, v1))
end

function v1.GetDuration(p1) -- Line: 334
    return 20
end

function v1.CancelPreActivation(p1, p2) -- Line: 340 -- upvalues: u59 (ref), u57 (ref), u60 (ref)
    if u59 or u57 == nil then
        return false
    end
    u57 = nil
    u60 = false
    p2.Busy = false
    return true
end

function v1.ServerReset(p1, p2, p3) -- Line: 356 -- upvalues: u18 (val), Net (val), u57 (ref)
    local v1 = u18:WaitForPlayerState(p2)
    Net:FireClient(p2, "ActivateFocus", false)
    v1.IsFocused = false
    u57 = nil
end

function v1.AmmoChanged(p1, p2) -- Line: 363
    print("AmmoChanged called!")
end

v1.EquippedWalkspeedChange = 0
v1.HolsteredWalkspeedChange = 0
v1.EquippedWalkspeedMultiplier = 1
v1.HolsteredWalkspeedMultiplier = 1
v1.DrawAnimation = "Equip"
v1.DrawAnimationTime = nil
v1.KeyFrameSounds = {
    Open = {SoundId = "9117307583", Volume = 0.5},
    Close = {SoundId = "9113579415", Volume = 0.5},
}
v1.DeploySFX = nil
v1.ArmIgnores = {["Right Arm"] = true, ["Right Shoulder"] = true}
v1.Offset = CFrame.new()
v1.SprintOffset = CFrame.new()
v1.AttachmentNodeData = require("@game/ReplicatedStorage/common/SharedResources/Attachments/Platforms/Base")
return v1