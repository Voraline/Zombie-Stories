local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local scoped = Fusion.scoped
local peek = Fusion.peek
require("@game/ReplicatedStorage/common/HUDService")
local u31 = require("@game/ReplicatedStorage/common/PlayerHandler")
local u34 = require("@game/ReplicatedStorage/common/NPCs_Shared/Utils/ClassMirror")
local u37 = require("@self/HurtOverlay")
local v1 = require("@self/Components/HealthUI")
local v2 = scoped(Fusion)
local u47 = v2:Value(1)
local u51 = v2:Value("100 / 100")
local v3 = Color3.fromRGB(178, 255, 161)
local u59 = v2:Value(v3)
local v4 = Color3.fromRGB(39, 53, 66)
local u67 = v2:Value(v4)
local new = NumberSequence.new
local v5 = {}
local v6 = NumberSequenceKeypoint.new(0, 1)
local v7 = NumberSequenceKeypoint.new(0.01, 0)
local v8 = NumberSequenceKeypoint.new(0.02, 1)
v5[1] = v6
v5[2] = v7
v5[3] = v8
v5[4] = NumberSequenceKeypoint.new(1, 1)
local v9 = new(v5)
local u89 = v2:Value(v9)
local new_2 = NumberSequence.new
v6 = {}
v7 = NumberSequenceKeypoint.new(0, 1)
v8 = NumberSequenceKeypoint.new(0.5, 1)
v6[1] = v7
v6[2] = v8
v6[3] = NumberSequenceKeypoint.new(1, 0)
v5 = new_2(v6)
local u107 = v2:Value(v5)
local u111 = v2:Value(true)
local u115 = v2:Value(0)
local u119 = v2:Value(false)
local u123 = v2:Value(false)
local u127 = v2:Value(0.5)
local u128 = {}
local v10 = v2:New("Sound")
u128.Alert = v10({
    Name = "ShieldAlert",
    Volume = 1,
    Looped = true,
    SoundId = "rbxassetid://5201662731",
    Parent = SoundService,
})
v10 = v2:New("Sound")
u128.Recharge = v10({Name = "ShieldRecharge", Volume = 1, SoundId = "rbxassetid://187933025", Parent = SoundService})
v10 = v2:New("Sound")
u128.Broken = v10({Name = "ShieldBroken", Volume = 1, SoundId = "rbxassetid://5201662997", Parent = SoundService})
v10 = v2:New("Sound")
u128.Damaged = v10({Name = "ShieldDamaged", Volume = 1, SoundId = "rbxassetid://5201682882", Parent = SoundService})
v10 = v1({
    scope = v2,
    healthPercentage = u47,
    healthText = u51,
    healthColor = u59,
    playerFrameColor = u67,
    overlineTransparency = u89,
    underlineTransparency = u107,
    shieldPercentage = u115,
    shieldVisible = u119,
    shieldBroken = u123,
    shieldBgTransparency = u127,
})
local screenGui = v10.screenGui
local playerFrame = v10.playerFrame
local u162 = script.Figure:Clone()
local OtherPlayers = script.OtherPlayers
local Player = OtherPlayers:WaitForChild("Player")
Player.Visible = false
local u170 = {}
local LocalPlayer = Players.LocalPlayer
local u174 = u31:WaitForPlayerState(LocalPlayer)
local u175 = 1
local u176 = false
local u177 = {}
u177.Low = Color3.fromRGB(255, 148, 148)
u177.Medium = Color3.fromRGB(255, 249, 158)
u177.High = Color3.fromRGB(178, 255, 161)
local u193 = "Downed"
local u194 = 30
local u195 = 100
local u196 = {
    Assault = "rbxassetid://4458718282",
    Medic = "rbxassetid://2706886795",
    Sniper = "rbxassetid://4458692655",
    Support = "rbxassetid://2706886028",
    Arcade = "rbxassetid://112766246588072",
}
;(v2:Observer(u111)):onChange(function() -- Line: 120 -- upvalues: screenGui (val), peek (val), u111 (val)
    screenGui.Enabled = peek(u111)
end)
local format = string.format
local HP = u174.HP
local v11 = math.ceil(HP)
local MaxHP = u174.MaxHP
local v12 = format("%d / %d", v11, (math.ceil(MaxHP)))
u51:set(v12)
local u217 = {IsShowing = true}

function u217.Show(p1) -- Line: 132 -- upvalues: u111 (val), u217 (val)
    u111:set(true)
    u217.IsShowing = true
end

function u217.Hide(p1) -- Line: 138 -- upvalues: u111 (val), u217 (val)
    u111:set(false)
    u217.IsShowing = false
end

local function DownedTheme() -- Line: 144 -- upvalues: u67 (val), u59 (val)
    local v1 = u67
    local v2 = Color3.fromRGB(66, 26, 26)
    v1:set(v2)
    v1 = u59
    v2 = Color3.fromRGB(255, 78, 78)
    v1:set(v2)
end

local function AliveTheme() -- Line: 149 -- upvalues: u67 (val), u59 (val)
    local v1 = u67
    local v2 = Color3.fromRGB(39, 53, 66)
    v1:set(v2)
    v1 = u59
    v2 = Color3.fromRGB(178, 255, 161)
    v1:set(v2)
end

local function ReviveTheme() -- Line: 154 -- upvalues: u67 (val), u59 (val)
    local v1 = u67
    local v2 = Color3.fromRGB(66, 66, 66)
    v1:set(v2)
    v1 = u59
    v2 = Color3.fromRGB(255, 255, 255)
    v1:set(v2)
end

local function setCirclePercentage(p1) -- Line: 160 -- upvalues: u47 (val)
    u47:set(p1)
end

local u225 = 0
RunService.RenderStepped:Connect(function(p1) -- Line: 165
    -- upvalues: screenGui (val), u174 (val), u225 (ref), u175 (ref), u107 (val), u89 (val), u193 (ref), u67 (val)
    -- upvalues: u59 (val), u47 (val), u51 (val), u195 (ref), u194 (ref)
    local v1
    if not screenGui.Enabled then
        return
    end
    local MaxHP = u174.MaxHP
    u225 = u225 + p1 * u175
    local v2 = u225 % 1
    local v3 = (v2 - 0.5) % 1
    local v4 = v2 < 0.5
    local v5 = {}
    local new = NumberSequenceKeypoint.new
    local v6 = v2 - 0.5
    local v7 = math.max(v6, 0)
    if not v4 then
        v6 = 1
    else
        v6 = 0.5 / v2
    end
    local v8 = new(v7, v6)
    v7 = NumberSequenceKeypoint.new(v2, 0)
    local new_2 = NumberSequenceKeypoint.new
    local v9 = v2 + 0.01
    v6 = new_2(math.min(v9, 1), 1)
    local new_3 = NumberSequenceKeypoint.new
    if not v4 then
        v1 = 1
    else
        v1 = v2 / 0.5
    end
    v5[1] = v8
    v5[2] = v7
    v5[3] = v6
    v5[4] = new_3(1, v1)
    v8 = {}
    v7 = NumberSequenceKeypoint.new(0, 1)
    local new_4 = NumberSequenceKeypoint.new
    v9 = v2 - 0.01
    v6 = new_4(math.max(v9, 0), 1)
    local v10 = NumberSequenceKeypoint.new(v2, 0)
    local new_5 = NumberSequenceKeypoint.new
    local v11 = v2 + 0.01
    v9 = new_5(math.min(v11, 1), 0)
    local new_6 = NumberSequenceKeypoint.new
    local v12 = v2 + 0.02
    v11 = math.min(v12, 1)
    v1 = new_6(v11, 1)
    v8[1] = v7
    v8[2] = v6
    v8[3] = v10
    v8[4] = v9
    v8[5] = v1
    v8[6] = NumberSequenceKeypoint.new(1, 1)
    if not v4 then
        v9 = NumberSequenceKeypoint.new(0, 1)
        table.insert(v5, 1, v9)
    else
        v9 = NumberSequenceKeypoint.new(v3, 1)
        table.insert(v5, 4, v9)
    end
    v7 = u107
    v10 = NumberSequence.new(v5)
    v7:set(v10)
    v7 = u89
    v10 = NumberSequence.new(v8)
    v7:set(v10)
    if u174.InSwanSong then
        if u193 ~= "SwanSong" then
            u193 = "SwanSong"
            v7 = u67
            v10 = Color3.fromRGB(66, 66, 66)
            v7:set(v10)
            v7 = u59
            v10 = Color3.fromRGB(255, 255, 255)
            v7:set(v10)
        end
        v9 = u174
        v10 = v9.SwanSongEndTime - (workspace:GetServerTimeNow())
        v7 = math.max(0, v10)
        v6 = v7 / 4
        u47:set(v6)
        v6 = u51
        v9 = string.format("%.1f", v7)
        v6:set(v9)
    elseif not u174.IsDowned or not u174.StatusEffects.Downed then
        if not u174.IsDowned and u193 ~= "Alive" then
            u193 = "Alive"
            v7 = u67
            v10 = Color3.fromRGB(39, 53, 66)
            v7:set(v10)
            v7 = u59
            v10 = Color3.fromRGB(178, 255, 161)
            v7:set(v10)
            v7 = u174.HP / u174.MaxHP
            u47:set(v7)
        end
    elseif not (0 < u174.StatusEffects.Downed.ReviveProgress) then
        if u174.StatusEffects.Downed.ReviveProgress <= 0 and u193 ~= "Downed" then
            u193 = "Downed"
            v7 = u67
            v10 = Color3.fromRGB(66, 26, 26)
            v7:set(v10)
            v7 = u59
            v10 = Color3.fromRGB(255, 78, 78)
            v7:set(v10)
        end
    elseif u193 ~= "Revive" then
        u193 = "Revive"
        v7 = u67
        v10 = Color3.fromRGB(66, 66, 66)
        v7:set(v10)
        v7 = u59
        v10 = Color3.fromRGB(255, 255, 255)
        v7:set(v10)
    elseif u174.StatusEffects.Downed.ReviveProgress <= 0 and u193 ~= "Downed" then
        u193 = "Downed"
        v7 = u67
        v10 = Color3.fromRGB(66, 26, 26)
        v7:set(v10)
        v7 = u59
        v10 = Color3.fromRGB(255, 78, 78)
        v7:set(v10)
    end
    if u174.IsDowned and u174.StatusEffects.Downed then
        if 0 < u174.StatusEffects.Downed.ReviveProgress then
            v7 = u174.StatusEffects.Downed.ReviveProgress / 1
            u47:set(v7)
            v9 = u174
            v6 = v9.StatusEffects.Downed.ReviveProgress / 1 * 100
            v7 = math.ceil(v6)
            if v7 ~= 100 then
                v6 = u51
                v9 = v7 .. "%"
                v6:set(v9)
                return
            end
            v6 = u51
            local v13 = u195
            v11 = v13 / MaxHP * 100
            v1 = math.ceil(v11)
            v9 = tostring(v1)
            v6:set(v9)
            return
        end
        v7 = u174
        local Duration = v7.StatusEffects.Downed.Duration
        if u194 < Duration then
            u194 = u174.StatusEffects.Downed.Duration
        end
        v7 = u174.StatusEffects.Downed.Duration / u194
        u47:set(v7)
        v7 = u51
        v1 = u174
        local Duration_2 = v1.StatusEffects.Downed.Duration
        v9 = math.ceil(Duration_2)
        v10 = tostring(v9)
        v7:set(v10)
    end
end)
u174.Damaged:Connect(function(p1, p2, p3) -- Line: 255 -- upvalues: u34 (val), Players (val), RunService (val)
    if p3 then
        local LiveDamagePos = u34:GetLiveDamagePos(p3)
        if LiveDamagePos then
            local u12 = script.HurtArrow:Clone()
            if p3.arrowColor then
                u12.lockdir.ImageColor3 = p3.arrowColor
            end
            u12.Parent = Players.LocalPlayer.PlayerGui
            local u20 = nil
            local u23 = os.clock() + 1
            local v1 = RunService
            v1 = v1.RenderStepped:connect(function(p1) -- Line: 266
                -- upvalues: u34 (upval), p3 (val), LiveDamagePos (ref), u12 (val), Players (upval), u23 (val)
                -- upvalues: u20 (ref)
                local v1 = u34
                local v2 = p3
                local LiveDamagePos_2, LiveDamagePos_3 = v1:GetLiveDamagePos(v2)
                if LiveDamagePos_3 then
                    LiveDamagePos = LiveDamagePos_2
                end
                local lockdir = u12.lockdir
                local v3 = {Players.LocalPlayer.Character:GetPivot().Position, LiveDamagePos}
                local v4 = v3[2]
                local Y = v3[2].Y
                local v5 = v4 - Vector3.new(0, Y, 0)
                local v6 = v3[1]
                local Y_2 = v3[1].Y
                local unit = (v5 - (v6 - Vector3.new(0, Y_2, 0))).unit
                local Z = workspace.Camera.CFrame.lookVector.Z
                local X = workspace.Camera.CFrame.lookVector.X
                local v7 = math.atan2(Z, X)
                v4 = math.deg(v7) * -1
                local Z_2 = unit.Z
                local X_2 = unit.X
                v7 = math.atan2(Z_2, X_2)
                lockdir.Rotation = v4 + math.deg(v7)
                v4 = os.clock()
                if u23 < v4 then
                    lockdir.ImageTransparency = lockdir.ImageTransparency + p1
                    if 1 <= lockdir.ImageTransparency then
                        u20:Disconnect()
                        u12:Destroy()
                        u20 = nil
                    end
                end
            end)
        end
    end
end)
u174.HealthChanged:Connect(function(p1, p2) -- Line: 292
    -- upvalues: u174 (val), u195 (ref), u177 (val), u51 (val), u59 (val), u175 (ref), u47 (val), u37 (val), u176 (ref)
    local Low
    local MaxHP = u174.MaxHP
    local v1 = p2 - p1
    u195 = p1
    if p1 <= MaxHP * 0.4 then
        Low = u177.Low
    elseif not (p1 <= MaxHP * 0.6) then
        Low = u177.High
    else
        Low = u177.Medium
    end
    local v2 = u51
    local v3 = string.format("%d / %d", math.ceil(p1), (math.ceil(MaxHP)))
    v2:set(v3)
    u59:set(Low)
    u175 = (1 - p1 / MaxHP) * 2 + 1
    v2 = p1 / MaxHP
    u47:set(v2)
    if 0 < v1 then
        u37.DamageTaken(p1)
    elseif v1 < -1 and not u176 then
        u37.Healed(p1)
    end
    if p1 <= 0 then
        u176 = true
        return
    end
    u176 = false
end)
local u241 = 0
local u242 = false
local u243 = nil

local function stopShieldBrokenEffect() -- Line: 332 -- upvalues: u123 (val), u127 (val), u243 (ref)
    u123:set(false)
    u127:set(0.5)
    if u243 then
        u243:Disconnect()
        u243 = nil
    end
end

local function updateShieldUI() -- Line: 341
    -- upvalues: u174 (val), u119 (val), u115 (val), u123 (val), u127 (val), u243 (ref), u241 (ref), u242 (ref)
    -- upvalues: u128 (val), SoundService (val), RunService (val), peek (val)
    local v1
    local v2 = u174.SpartanShield or 0
    local v3 = u174.SpartanShieldMax or 0
    local v4 = 0 < v3
    u119:set(v4)
    local v5 = u115
    if not v4 then
        v1 = 0
    else
        v1 = v2 / v3
    end
    v5:set(v1)
    if u174.IsDowned then
        u123:set(false)
        u127:set(0.5)
        if u243 then
            u243:Disconnect()
            u243 = nil
        end
        u241 = v2
        return
    end
    if v2 < u241 then
        u242 = true
        if not (0 < v2) then
            u123:set(true)
            u128.Broken:Play()
            local u67 = u128.Alert:Clone()
            u67.Parent = SoundService
            u67:Play()
            task.delay(1, function() -- Line: 373 -- upvalues: u67 (val)
                for i = 1, 10 do
                    u67.Volume = u67.Volume * 0.8
                    task.wait(0.05)
                end
                u67:Stop()
                u67:Destroy()
            end)
            if not u243 then
                local v6 = RunService
                u243 = v6.RenderStepped:Connect(function() -- Line: 385 -- upvalues: u174 (upval), peek (upval), u123 (upval), u127 (upval), u243 (upval)
                    if not u174.IsDowned and peek(u123) then
                        local v1 = tick() * 10 % 3 * 3.141592653589793 / 2
                        local v2 = u127
                        local v3 = ((math.sin(v1)) + 1) / 4
                        v2:set(v3)
                        return
                    end
                    u123:set(false)
                    u127:set(0.5)
                    if u243 then
                        u243:Disconnect()
                        u243 = nil
                    end
                end)
            end
        else
            u128.Damaged:Play()
        end
    elseif u241 < v2 and u242 then
        u123:set(false)
        u127:set(0.5)
        if u243 then
            u243:Disconnect()
            u243 = nil
        end
        u128.Recharge:Play()
        u242 = false
    end
    u241 = v2
end

;(u174:GetPropertyChangedSignal("IsDowned")):Connect(function() -- Line: 408 -- upvalues: u174 (val), u123 (val), u127 (val), u243 (ref)
    if u174.IsDowned then
        u123:set(false)
        u127:set(0.5)
        if u243 then
            u243:Disconnect()
            u243 = nil
        end
    end
end)
;(u174:GetPropertyChangedSignal("SpartanShield")):Connect(updateShieldUI)
;(u174:GetPropertyChangedSignal("SpartanShieldMax")):Connect(updateShieldUI)
;(u174:GetPropertyChangedSignal("MaxHP")):Connect(function(p1) -- Line: 419 -- upvalues: u174 (val), u51 (val), u47 (val)
    local HP = u174.HP
    local v1 = u51
    local v2 = string.format("%d / %d", math.ceil(HP), (math.ceil(p1)))
    v1:set(v2)
    v1 = HP / p1
    u47:set(v1)
end)
updateShieldUI()

local function getBodyAttachment(p1, p2) -- Line: 428
    local v1
    repeat
        v1 = p1:FindFirstChild(p2, true)
        task.wait(0.1)
    until v1 ~= nil
    return v1
end

local function placeAccessories(p1) -- Line: 437 -- upvalues: getBodyAttachment (val)
    for i, j in p1:GetChildren() do
        if j:IsA("Accessory") then
            local BasePart = j:FindFirstChildWhichIsA("BasePart")
            local Attachment = BasePart:FindFirstChildOfClass("Attachment")
            task.defer(function() -- Line: 443 -- upvalues: getBodyAttachment (upval), p1 (val), Attachment (val), BasePart (val)
                local v1 = getBodyAttachment(p1, Attachment.Name)
                local Parent = v1.Parent
                local v2 = BasePart
                v2.CFrame = Parent.CFrame * v1.CFrame * Attachment.CFrame:Inverse()
            end)
        end
    end
end

task.defer(function() -- Line: 453 -- upvalues: Players (val), playerFrame (val), u162 (val), placeAccessories (val)
    local result, success, v1
    local u14 = nil
    repeat
        success, result = pcall(function() -- Line: 456 -- upvalues: u14 (ref), Players (upval)
            local UserId_2
            local v1 = Players
            local v2 = Players
            local UserId = v2.LocalPlayer.UserId
            if not (0 < (tonumber(UserId))) then
                UserId_2 = 8351982
            else
                UserId_2 = Players.LocalPlayer.UserId
            end
            u14 = v1:GetHumanoidDescriptionFromUserId(UserId_2)
        end)
        if not success then
            task.wait(1)
        end
    until v1
    local Camera = Instance.new("Camera")
    Camera.FieldOfView = 70
    Camera.CFrame = CFrame.new(
        -426.923065,
        6.61176538,
        297.054443,
        -0.888728499,
        -0.0244553108,
        0.45778212,
        -3.08100134e-05,
        0.998579323,
        0.053285595,
        -0.45843485,
        0.0473422967,
        -0.887466669
    )
    Camera.Parent = playerFrame
    playerFrame.CurrentCamera = Camera
    u162.Parent = playerFrame
    local Humanoid = u162:WaitForChild("Humanoid")
    local v2 = u14
    Humanoid:ApplyDescriptionReset(v2)
    placeAccessories(u162)
end)
task.defer(function() -- Line: 483
    -- upvalues: Players (val), OtherPlayers (val), screenGui (val), u170 (val), u177 (val), Player (val), u196 (val)
    -- upvalues: u31 (val)
    local Values = workspace:FindFirstChild("Values")
    local IsLobby = Values
    if IsLobby then
        IsLobby = Values:FindFirstChild("IsLobby")
    end
    if IsLobby and IsLobby.Value then
        return
    end
    if Players.LocalPlayer.PlayerScripts:FindFirstChild("ArcadeClient") then
        return
    end
    OtherPlayers.Parent = screenGui
    OtherPlayers.Visible = false

    local function updateOtherPlayersVisibility() -- Line: 497 -- upvalues: OtherPlayers (upval), u170 (upval)
        local v1 = OtherPlayers
        local v2 = next(u170) ~= nil
        v1.Visible = v2
    end

    local function applyHealthToBar(p1, p2, p3) -- Line: 516 -- upvalues: u177 (upval)
        local Low, v1
        local v2 = p3 or 100
        local v3 = math.clamp(p2 or v2, 0, v2)
        if v3 <= v2 * 0.4 then
            Low = u177.Low
        elseif not (v3 <= v2 * 0.6) then
            Low = u177.High
        else
            Low = u177.Medium
        end
        p1.BackgroundColor3 = Low
        if not (0 < v2) then
            v1 = 0
        else
            v1 = v3 / v2
        end
        p1.Size = UDim2.new(v1, 0, 1, 0)
    end

    local function addOtherPlayer(p1) -- Line: 534
        -- upvalues: Players (upval), u170 (upval), Player (upval), u196 (upval), OtherPlayers (upval), u31 (upval)
        -- upvalues: applyHealthToBar (val)
        if p1 ~= Players.LocalPlayer and not u170[p1] then
            local v1
            local u8 = Player:Clone()
            u8.Visible = true
            u8.Name = p1.Name
            u8.Parent = Player.Parent
            u8.Username.Text = p1.Name
            local Value = "Assault"
            local LoadingStatus = workspace:FindFirstChild("LoadingStatus")
            if LoadingStatus and LoadingStatus:FindFirstChild("Players") then
                local Players_2 = LoadingStatus.Players
                local Name = p1.Name
                v1 = Players_2:FindFirstChild(Name)
                if v1 and v1:FindFirstChild("Class") then
                    Value = v1.Class.Value
                end
            end
            u8.HealthBar.Class.Image = u196[Value] or "rbxassetid://4458718282"
            v1 = u170
            v1[p1] = {Frame = u8}
            v1 = OtherPlayers
            local v2 = next(u170) ~= nil
            v1.Visible = v2
            task.spawn(function() -- Line: 562 -- upvalues: u31 (upval), p1 (val), u170 (upval), u8 (val), applyHealthToBar (upval)
                local success, result = pcall(function() -- Line: 563 -- upvalues: u31 (upval), p1 (upval)
                    local v1 = u31
                    local v2 = p1
                    return v1:WaitForPlayerState(v2)
                end)
                if success and result and u170[p1] then
                    local HealthBarColor = u8.HealthBar.HealthBarColor
                    local v1 = u170[p1]

                    local function updateHealth(p1_2) -- Line: 574
                        -- upvalues: u170 (upval), p1 (upval), applyHealthToBar (upval), HealthBarColor (val)
                        -- upvalues: result (val)
                        if not u170[p1] then
                            return
                        end
                        applyHealthToBar(HealthBarColor, p1_2, result.MaxHP)
                    end

                    v1.healthConn = result.HealthChanged:Connect(function(p1_2) -- Line: 582
                        -- upvalues: u170 (upval), p1 (upval), applyHealthToBar (upval), HealthBarColor (val)
                        -- upvalues: result (val)
                        if not u170[p1] then
                            return
                        end
                        applyHealthToBar(HealthBarColor, p1_2, result.MaxHP)
                    end)
                    local HP = result.HP
                    if not HP then
                        HP = result.MaxHP
                        if not HP then
                            HP = 0
                        end
                    end
                    if not u170[p1] then
                        return
                    end
                    applyHealthToBar(HealthBarColor, HP, result.MaxHP)
                    return
                end
            end)
            return
        end
    end

    for i, j in Players:GetPlayers() do
        addOtherPlayer(j)
    end
    Players.PlayerAdded:Connect(addOtherPlayer)
    Players.PlayerRemoving:Connect(function(p1) -- Line: 501 -- upvalues: u170 (upval), OtherPlayers (upval)
        local v1 = u170[p1]
        if not v1 then
            return
        end
        if v1.healthConn then
            v1.healthConn:Disconnect()
        end
        v1.Frame:Destroy()
        u170[p1] = nil
        local v2 = OtherPlayers
        local v3 = next(u170) ~= nil
        v2.Visible = v3
    end)
end)
return u217