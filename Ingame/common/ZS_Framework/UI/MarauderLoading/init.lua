local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Signal = require(ReplicatedStorage.common:WaitForChild("Signal"))
local AvatarProvider = require(script:WaitForChild("AvatarProvider"))
local Config = require(script:WaitForChild("Config"))
local Theme = require(script.Parent:WaitForChild("Theme"))
local u78 = {}
u78.PresentingChanged = Signal.new()
local u81 = {}
u81.__index = u81
local LocalPlayer = Players.LocalPlayer
local u83 = {}
local u84 = false
local u85 = {}
local u86 = {}
local u87 = {}
local u88 = nil
local u89 = nil
local u90 = nil
local u91 = nil
local u92 = nil
local u93 = nil

local function updatePresenting() -- Line: 37 -- upvalues: u83 (val), u84 (ref), u78 (val)
    local v1 = next(u83) ~= nil
    if u84 ~= v1 then
        u84 = v1
        local v2 = u78
        local PresentingChanged = v2.PresentingChanged
        local v3 = u84
        PresentingChanged:Fire(v3)
    end
end

local u95 = {}
u95[1] = Enum.CoreGuiType.Backpack
u95[2] = Enum.CoreGuiType.Chat
u95[3] = Enum.CoreGuiType.EmotesMenu
u95[4] = Enum.CoreGuiType.Health
u95[5] = Enum.CoreGuiType.PlayerList
local u101 = {ControlHints = true, Menu = true, StaminaUI = true}
local u102 = {TouchGui = true}
local u103 = {
    MarauderLoadingScreen = true,
    MarauderLoadingSafeArea = true,
    MarauderLoadingExtractionCover = true,
    ZSTeleportCard = true,
}

local function getCameraShaker() -- Line: 70 -- upvalues: u92 (ref)
    if u92 then
        return u92
    end
    u92 = require(((((script.Parent.Parent:WaitForChild("Modules")):WaitForChild("Controllers")):WaitForChild("CameraController")):WaitForChild("CameraUtils")):WaitForChild("CameraShaker"))
    return u92
end

local function getWeaponController() -- Line: 85 -- upvalues: u93 (ref)
    if u93 ~= nil then
        local v1
        if u93 == false then
            v1 = nil
        else
            v1 = u93
            if not v1 then
                v1 = nil
            end
        end
        return v1
    end
    local success, result = pcall(function() -- Line: 90
        return require(((script.Parent.Parent:WaitForChild("Modules")):WaitForChild("Controllers")):WaitForChild("WeaponController"))
    end)
    local v2 = success and result or false
    u93 = v2
    if u93 == false then
        v2 = nil
    else
        v2 = u93
        if not v2 then
            v2 = nil
        end
    end
    return v2
end

local function getSeatedIdleAnimationAssets() -- Line: 99 -- upvalues: u88 (ref), Config (val)
    local Animation, v1
    if u88 then
        return u88
    end
    u88 = {}
    for i, v in ipairs(Config.SeatedIdleAnimations) do
        if type(v) == "string" and v ~= "" then
            Animation = Instance.new("Animation")
            Animation.Name = "MarauderSeatedIdle" .. tostring(i)
            Animation.AnimationId = v
            v1 = u88
            table.insert(v1, Animation)
        end
    end
    return u88
end

local function buildSeatedIdleAssignments(p1, p2, p3) -- Line: 118
    local v1, v2, v3, v4, v5, v6
    local v7 = Random.new(p1)
    local v8 = table.create(p3)
    local v9 = {}
    local v10 = p3
    local v11 = p2
    for i = 1, v10 do
        if #v9 == 0 then
            v6 = v11
            for j = 1, v6 do
                v9[j] = j
            end
            for k = v11, 2, -1 do
                v3 = v7:NextInteger(1, k)
                v4 = v9[v3]
                v5 = v9[k]
                v9[k] = v4
                v9[v3] = v5
            end
            if 1 < i and 1 < v11 and v9[v11] == v8[i - 1] then
                v6 = v11 - 1
                v1 = v9[v11 - 1]
                v2 = v9[v11]
                v9[v11] = v1
                v9[v6] = v2
            end
        end
        v8[i] = (table.remove(v9))
    end
    return v8
end

local function getHeliPreloadSoundAssets() -- Line: 140 -- upvalues: u89 (ref), Config (val)
    if u89 then
        return u89
    end
    local Sound = Instance.new("Sound")
    Sound.Name = "MarauderInteriorPreload"
    Sound.SoundId = Config.HeliInteriorSoundId
    local Sound_2 = Instance.new("Sound")
    Sound_2.Name = "MarauderEnginePreload"
    Sound_2.SoundId = Config.HeliEngineSoundId
    local Sound_3 = Instance.new("Sound")
    Sound_3.Name = "MarauderPlayerReadyPreload"
    Sound_3.SoundId = Config.StoryPlayerReadySoundId
    local Sound_4 = Instance.new("Sound")
    Sound_4.Name = "MarauderAllReadyPreload"
    Sound_4.SoundId = Config.StoryAllReadySoundId
    u89 = {Sound, Sound_2, Sound_3, Sound_4}
    return u89
end

local function getExtractionPreloadSoundAssets() -- Line: 161 -- upvalues: u90 (ref), Config (val)
    local Sound, v1
    if u90 then
        return u90
    end
    u90 = {}
    local v2 = ipairs
    local v3 = {
        Config.ExtractionCardHitSoundId,
        Config.ExtractionCardWhooshSoundId,
        Config.ExtractionCameraMoveSoundId,
        Config.ExtractionCountUpLoopSoundId,
        Config.ExtractionCountUpFinishSoundId,
    }
    for i, v in v2(v3) do
        if type(v) == "string" and v ~= "" then
            Sound = Instance.new("Sound")
            Sound.Name = "MarauderExtractionPreload" .. tostring(i)
            Sound.SoundId = v
            v1 = u90
            table.insert(v1, Sound)
        end
    end
    return u90
end

local function getAnimator(p1) -- Line: 183
    if p1 and p1:IsA("Humanoid") then
        local Animator = p1:FindFirstChildOfClass("Animator")
        if not Animator then
            Animator = Instance.new("Animator")
            Animator.Parent = p1
        end
        return Animator
    end
    return nil
end

local function finalizeArrivalCover(p1) -- Line: 195 -- upvalues: u91 (ref)
    if p1.cleaned then
        return
    end
    p1.cleaned = true
    if u91 == p1 then
        u91 = nil
    end
    if p1.tween then
        p1.tween:Destroy()
    end
    if p1.gui then
        p1.gui:Destroy()
    end
end

local function dismissArrivalCover(p1) -- Line: 211 -- upvalues: u91 (ref), Config (val), TweenService (val)
    local u1 = u91
    if u1 and not u1.dismissing then
        u1.dismissing = true
        local ArrivalFadeOutTime = tonumber(p1)
        if not ArrivalFadeOutTime then
            ArrivalFadeOutTime = Config.ArrivalFadeOutTime
        end
        local v1 = math.max(ArrivalFadeOutTime, 0)
        if not (v1 <= 0) and u1.cover and u1.cover.Parent then
            local v2 = TweenService
            local cover = u1.cover
            local v3 = TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            u1.tween = v2:Create(cover, v3, {BackgroundTransparency = 1})
            u1.tween:Play()
            task.delay(v1 + 0.05, function() -- Line: 230 -- upvalues: u1 (val), u91 (upval)
                local v1 = u1
                if v1.cleaned then
                    return
                end
                v1.cleaned = true
                if u91 == v1 then
                    u91 = nil
                end
                if v1.tween then
                    v1.tween:Destroy()
                end
                if v1.gui then
                    v1.gui:Destroy()
                end
            end)
            return
        end
        if u1.cleaned then
            return
        end
        u1.cleaned = true
        if u91 == u1 then
            u91 = nil
        end
        if u1.tween then
            u1.tween:Destroy()
        end
        if u1.gui then
            u1.gui:Destroy()
        end
        return
    end
end

local function showArrivalCover() -- Line: 235
    -- upvalues: u91 (ref), LocalPlayer (val), Config (val), dismissArrivalCover (val)
    if u91 and u91.gui and u91.gui.Parent then
        return u91.gui
    end
    if u91 then
        local v1 = u91
        if not v1.cleaned then
            v1.cleaned = true
            if u91 == v1 then
                u91 = nil
            end
            if v1.tween then
                v1.tween:Destroy()
            end
            if v1.gui then
                v1.gui:Destroy()
            end
        end
    end
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MarauderLoadingArrival"
    ScreenGui.DisplayOrder = 10003
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local Frame = Instance.new("Frame")
    Frame.Name = "Cover"
    Frame.Size = UDim2.fromScale(1, 1)
    Frame.BackgroundColor3 = Color3.new(0, 0, 0)
    Frame.BackgroundTransparency = 0
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    local u56 = {}
    u56.gui = ScreenGui
    u56.cover = Frame
    u91 = u56
    local delay = task.delay
    local v2 = Config
    delay(v2.ArrivalFadeMaxHold, function() -- Line: 266 -- upvalues: u91 (upval), u56 (val), dismissArrivalCover (upval), Config (upval)
        if u91 == u56 then
            warn("[MarauderLoading] Arrival cover watchdog elapsed; revealing with available assets")
            dismissArrivalCover(Config.ArrivalFadeOutTime)
        end
    end)
    return ScreenGui
end

local function clamp01(p1) -- Line: 275
    local v1 = tonumber(p1) or 0
    return (math.clamp(v1, 0, 1))
end

local function isCabinMode(p1) -- Line: 279
    local v1 = true
    if p1.mode ~= "Story" then
        v1 = p1.mode == "Extraction"
    end
    return v1
end

local function formatIntegerWithCommas(p1) -- Line: 283
    local v1 = string.reverse((tostring(p1)))
    local v2 = string.gsub(v1, "(%d%d%d)", "%1,")
    local v3 = string.reverse(v2)
    return (string.gsub(v3, "^,", ""))
end

local function formatCommendationValue(p1, p2) -- Line: 291 -- upvalues: formatIntegerWithCommas (val)
    local v1 = tonumber(p2)
    local v2 = math.round(v1 or 0)
    local v3 = math.max(0, v2)
    local v4 = formatIntegerWithCommas(v3)
    if p1 == "DEADEYE" then
        return v4 .. "%"
    end
    return v4
end

local function resolveCommendationName(p1) -- Line: 300 -- upvalues: Players (val)
    local DisplayName
    local name = p1.name
    if type(name) == "string" and string.match(name, "%S") then
        return name
    end
    local v1 = Players
    local userId = p1.userId
    local v2 = tonumber(userId)
    local PlayerByUserId = v1:GetPlayerByUserId(v2 or 0)
    if not PlayerByUserId then
        return "UNKNOWN OPERATIVE"
    end
    if PlayerByUserId.DisplayName == "" then
        DisplayName = PlayerByUserId.Name
    else
        DisplayName = PlayerByUserId.DisplayName
        if not DisplayName then
            DisplayName = PlayerByUserId.Name
        end
    end
    return DisplayName
end

local function addTextConstraint(p1, p2, p3) -- Line: 314
    return p1:New("UITextSizeConstraint")({MinTextSize = p2, MaxTextSize = p3})
end

local function getWorldCFrame(p1) -- Line: 326
    if not p1 then
        return nil
    end
    if p1:IsA("BasePart") then
        return p1.CFrame
    end
    if not p1:IsA("Model") then
        return nil
    end
    local success, result = pcall(p1.GetPivot, p1)
    local v1 = success and result or nil
    return v1
end

local function getMarauderTemplate() -- Line: 340
    local MarauderTemplate = script:FindFirstChild("MarauderTemplate")
    if not MarauderTemplate then
        MarauderTemplate = script:FindFirstChild("Marauders")
    end
    if MarauderTemplate then
        return MarauderTemplate
    end
    if script:FindFirstChild("Marauder01") then
        return script
    end
    for i, v in ipairs(script:GetChildren()) do
        if v:FindFirstChild("Marauder01") then
            return v
        end
    end
    return nil
end

local function findDoor(p1) -- Line: 356
    local CFrame, result, success, v1, v2
    local v3 = nil
    local v4 = (-1 / 0)
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Model") then
            v1 = string.lower(v.Name)
            v2 = 0
            if v1 == "door2" then
                v2 = 100
            elseif string.find(v1, "interiordoor", 1, true) then
                v2 = 90
            elseif string.find(v1, "doorway", 1, true) then
                v2 = 75
            elseif string.find(v1, "door", 1, true) then
                v2 = 50
            end
            if 0 < v2 and v4 < v2 then
                if not v then
                    CFrame = nil
                elseif v:IsA("BasePart") then
                    CFrame = v.CFrame
                elseif not v:IsA("Model") then
                    CFrame = nil
                else
                    success, result = pcall(v.GetPivot, v)
                    CFrame = success and result or nil
                end
                if CFrame then
                    v3 = v
                    v4 = v2
                end
            end
        end
    end
    return v3
end

local function createGradient(p1, p2, p3) -- Line: 381
    return p1:New("UIGradient")({
        Rotation = 90,
        Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, p2), NumberSequenceKeypoint.new(1, p3)}),
    })
end

local function getMusicSoundGroup() -- Line: 391 -- upvalues: SoundService (val)
    local Primary = SoundService:FindFirstChild("Primary")
    local Music = Primary
    if Music then
        Music = Primary:FindFirstChild("Music")
    end
    local v1 = Music and Music:IsA("SoundGroup") and Music or nil
    return v1
end

local function getEffectsSoundGroup() -- Line: 397 -- upvalues: SoundService (val)
    local v1
    local Primary = SoundService:FindFirstChild("Primary")
    if not Primary then
        return nil
    end
    local v2 = ipairs
    local v3 = {"Interface", "SFX", "Effects"}
    for i, v in v2(v3) do
        v1 = Primary:FindFirstChild(v)
        if v1 and v1:IsA("SoundGroup") then
            return v1
        end
    end
    return nil
end

function u81:_connect(p2, p3) -- Line: 411
    local v1 = p2:Connect(p3)
    local connections = self.connections
    table.insert(connections, v1)
    return v1
end

function u81:_capturePresentationState() -- Line: 417
    -- upvalues: Workspace (val), UserInputService (val), u95 (val), StarterGui (val), u93 (ref)
    local result_3, success_3, v1
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        v1 = {
            cameraType = CurrentCamera.CameraType,
            cameraSubject = CurrentCamera.CameraSubject,
            cframe = CurrentCamera.CFrame,
            fieldOfView = CurrentCamera.FieldOfView,
        }
        self.cameraState = v1
    end
    v1 = {iconEnabled = UserInputService.MouseIconEnabled, behavior = UserInputService.MouseBehavior}
    self.mouseState = v1
    UserInputService.MouseIconEnabled = false
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    self.coreGuiState = {}
    for i, v in ipairs(u95) do
        success_3, result_3 = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, v)
        if success_3 then
            self.coreGuiState[v] = result_3
            pcall(StarterGui.SetCoreGuiEnabled, StarterGui, v, false)
        end
    end
    local success, result = pcall(StarterGui.GetCore, StarterGui, "TopbarEnabled")
    if success then
        self.topbarEnabled = result
        pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", false)
    end
    if self.mode == "Extraction" then
        local v2
        self.weaponsSuppressed = true
        if u93 == nil then
            local success_2, result_2 = pcall(function() -- Line: 90
                return require(((script.Parent.Parent:WaitForChild("Modules")):WaitForChild("Controllers")):WaitForChild("WeaponController"))
            end)
            local v3 = success_2 and result_2 or false
            u93 = v3
            if u93 == false then
                v2 = nil
            else
                v2 = u93
                if not v2 then
                    v2 = nil
                end
            end
        elseif u93 == false then
            v2 = nil
        else
            v2 = u93
            if not v2 then
                v2 = nil
            end
        end
        if v2 then
            pcall(v2.SetWeaponsEnabled, v2, false)
        end
    end
end

function u81:_suppressLobbyScreenGuis() -- Line: 458 -- upvalues: LocalPlayer (val), u102 (val), u103 (val), u101 (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local function suppress(p1) -- Line: 460 -- upvalues: self (val), u102 (upval), u103 (upval), u101 (upval)
        if p1:IsA("ScreenGui") and self.suppressedScreenGuis[p1] == nil then
            if p1.Name == "SettingsGui" then
                return
            end
            local v1 = true
            if u102[p1.Name] ~= true then
                if self.mode ~= "Extraction" then
                    v1 = false
                    if self.mode == "Lobby" then
                        v1 = u101[p1.Name] == true
                    end
                else
                    v1 = not u103[p1.Name]
                end
            end
            if not v1 then
                return
            end
            self.suppressedScreenGuis[p1] = p1.Enabled
            p1.Enabled = false
            local v2 = self
            local PropertyChangedSignal = p1:GetPropertyChangedSignal("Enabled")
            v2:_connect(PropertyChangedSignal, function() -- Line: 479 -- upvalues: self (upval), p1 (val)
                if not self.destroyed and p1.Parent and p1.Enabled then
                    p1.Enabled = false
                end
            end)
            return
        end
    end

    for i, v in ipairs(PlayerGui:GetChildren()) do
        suppress(v)
    end
    local ChildAdded = PlayerGui.ChildAdded
    self:_connect(ChildAdded, suppress)
end

function u81:_restoreSuppressedScreenGuis() -- Line: 492
    local v1 = pairs
    local suppressedScreenGuis = self.suppressedScreenGuis
    if not suppressedScreenGuis then
        suppressedScreenGuis = {}
    end
    for k, v in v1(suppressedScreenGuis) do
        if k.Parent then
            k.Enabled = v
        end
    end
    table.clear(self.suppressedScreenGuis)
end

function u81:_restorePresentationState(p2) -- Line: 501
    -- upvalues: StarterGui (val), UserInputService (val), Workspace (val), LocalPlayer (val), u93 (ref)
    local v1, v2
    self:_restoreSuppressedScreenGuis()
    local v3 = pairs
    local coreGuiState = self.coreGuiState
    if not coreGuiState then
        coreGuiState = {}
    end
    local v4 = self
    for k, v in v3(coreGuiState) do
        v2 = true
        if v4.mode ~= "Story" then
            v2 = v4.mode == "Extraction"
        end
        if v2 then
            if k == Enum.CoreGuiType.Backpack
                or k == Enum.CoreGuiType.PlayerList
                or k == Enum.CoreGuiType.EmotesMenu then
                v = false
            end
        end
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, k, v)
    end
    if v4.topbarEnabled ~= nil then
        pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", v4.topbarEnabled)
    end
    v3 = true
    if v1 ~= "ExtractionComplete" then
        v3 = v1 == "ServerStop"
    end
    if v1 == "LobbyComplete" then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    elseif not v3 then
        local mouseState = v4.mouseState
        if mouseState then
            UserInputService.MouseBehavior = mouseState.behavior
            UserInputService.MouseIconEnabled = mouseState.iconEnabled
        end
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        local cameraState = v4.cameraState
        local Character = LocalPlayer
        if Character then
            Character = LocalPlayer.Character
        end
        local Humanoid = Character
        if Humanoid then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
        end
        CurrentCamera.CameraType = Enum.CameraType.Custom
        local cameraSubject = Humanoid
        if not cameraSubject then
            if not cameraState then
                cameraSubject = nil
            else
                cameraSubject = cameraState.cameraSubject
                if not cameraSubject then
                    cameraSubject = nil
                end
            end
        end
        CurrentCamera.CameraSubject = cameraSubject
        if cameraState and cameraState.fieldOfView then
            CurrentCamera.FieldOfView = cameraState.fieldOfView
        end
        if v1 ~= "LobbyComplete" and not v3 and cameraState and cameraState.cframe then
            CurrentCamera.CFrame = cameraState.cframe
        end
    end
    if v4.weaponsSuppressed then
        v4.weaponsSuppressed = nil
        if not v3 then
            task.spawn(function() -- Line: 551 -- upvalues: u93 (upval)
                local v1
                if u93 == nil then
                    local success, result = pcall(function() -- Line: 90
                        return require(((script.Parent.Parent:WaitForChild("Modules")):WaitForChild("Controllers")):WaitForChild("WeaponController"))
                    end)
                    local v2 = success and result or false
                    u93 = v2
                    if u93 == false then
                        v1 = nil
                    else
                        v1 = u93
                        if not v1 then
                            v1 = nil
                        end
                    end
                elseif u93 == false then
                    v1 = nil
                else
                    v1 = u93
                    if not v1 then
                        v1 = nil
                    end
                end
                if v1 then
                    pcall(v1.SetWeaponsEnabled, v1, true)
                end
            end)
        end
    end
end

function u81:_createInterface() -- Line: 561
    -- upvalues: Fusion (val), Config (val), createGradient (val), Theme (val), addTextConstraint (val)
    -- upvalues: LocalPlayer (val)
    local StoryLoadingLabel, v1, v2, v3, v4, v5, v6
    local v7 = Fusion.scoped(Fusion)
    self.scope = v7
    self.progressValue = v7:Value(0)
    if self.mode ~= "Lobby" then
        StoryLoadingLabel = Config.StoryLoadingLabel
    else
        StoryLoadingLabel = "PREPARING TRANSPORT"
    end
    self.statusText = v7:Value(StoryLoadingLabel)
    if self.mode ~= "Story" then
        v5 = nil
    else
        v5 = v7:Value("0 / 1")
        if not v5 then
            v5 = nil
        end
    end
    self.countText = v5
    if self.mode == "Extraction" then
        self.commendationName = v7:Value("")
        self.commendationTitle = v7:Value("")
        self.commendationDescriptor = v7:Value("")
        self.commendationValue = v7:Value("")
    end
    local progressValue = self.progressValue
    local u54 = v7:Spring(progressValue, 18, 1)
    local v8 = {}
    local v9 = v7:New("Frame")
    local v10 = {
        Name = "TopVignette",
        Size = UDim2.fromScale(1, 0.32),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
    }
    local Children = v7.Children
    local v11 = {createGradient(v7, 0.18, 1)}
    v10[Children] = v11
    v9 = v9(v10)
    v10 = v7:New("Frame")
    local v12 = {
        Name = "BottomVignette",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0.42),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
    }
    local Children_2 = v7.Children
    local v13 = {createGradient(v7, 1, 0.12)}
    v12[Children_2] = v13
    v8[1] = v9
    v8[2] = v10(v12)
    if self.mode == "Extraction" then
        v9 = v7:New("Frame")
        v10 = {
            Name = "ExtractionCover",
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = 30,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.new(0, 0, 0),
        }
        self.extractionCover = v9(v10)
    end
    v9 = {}
    if self.mode == "Lobby" then
        v11 = v7:New("TextLabel")
        v13 = {
            Name = "Tip",
            AnchorPoint = Vector2.new(0.5, 1),
            Position = UDim2.new(0.5, 0, 1, -20),
            Size = UDim2.new(0.88, 0, 0, 30),
            BackgroundTransparency = 1,
            Font = Theme.Menu.Fonts.Body,
            Text = self.statusText,
            TextColor3 = Theme.Menu.TextMuted,
            TextScaled = true,
            TextTransparency = 0.06,
            TextXAlignment = Enum.TextXAlignment.Center,
            ZIndex = 10,
        }
        local Children_3 = v7.Children
        v1 = {}
        v2 = v7:New("UITextSizeConstraint")({MinTextSize = 12, MaxTextSize = 19})
        v3 = v7:New("UIStroke")
        v4 = {Thickness = 1, Transparency = 0.3, Color = Theme.Menu.HeaderStroke}
        v1[1] = v2
        v1[2] = v3(v4)
        v13[Children_3] = v1
        v11 = v11(v13)
        table.insert(v9, v11)
    else
        local v14, v15
        if self.mode ~= "Story" then
            v10 = v7:New("TextLabel")
            v12 = {
                Name = "PlayerName",
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1,
                Font = Theme.Menu.Fonts.Header,
                Text = self.commendationName,
                TextColor3 = Theme.Menu.Text,
                TextScaled = true,
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 12,
            }
            local Children_7 = v7.Children
            v12[Children_7] = {addTextConstraint(v7, 12, 22)}
            v10 = v10(v12)
            v12 = v7:New("TextLabel")
            v11 = {
                Name = "Title",
                Position = UDim2.new(0, 0, 0, 30),
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundTransparency = 1,
                Font = Theme.Menu.Fonts.Header,
                Text = self.commendationTitle,
                TextColor3 = Theme.Menu.Accent,
                TextScaled = true,
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 12,
            }
            local Children_8 = v7.Children
            v11[Children_8] = {addTextConstraint(v7, 17, 32)}
            v12 = v12(v11)
            v11 = v7:New("TextLabel")
            v13 = {
                Name = "Descriptor",
                Position = UDim2.new(0, 0, 0, 74),
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                Font = Theme.Menu.Fonts.Body,
                Text = self.commendationDescriptor,
                TextColor3 = Theme.Menu.Text,
                TextScaled = true,
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 12,
            }
            local Children_9 = v7.Children
            v13[Children_9] = {addTextConstraint(v7, 12, 20)}
            v11 = v11(v13)
            v13 = v7:New("UIScale")({Name = "CompletionPulse", Scale = 1})
            v6 = v7:New("TextLabel")
            v1 = {
                Name = "Value",
                Size = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                Font = Theme.Menu.Fonts.Header,
                Text = self.commendationValue,
                TextColor3 = Theme.Menu.AccentCyan,
                TextScaled = true,
                TextTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 12,
            }
            local Children_10 = v7.Children
            v1[Children_10] = {addTextConstraint(v7, 15, 28)}
            v6 = v6(v1)
            v1 = v7:New("Frame")
            v2 = {
                Name = "ValueContainer",
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0, 128),
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundTransparency = 1,
                ZIndex = 12,
            }
            local Children_11 = v7.Children
            v2[Children_11] = {v13, v6}
            v1 = v1(v2)
            v2 = v7:New("CanvasGroup")
            v3 = {
                Name = "CommendationCard",
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.fromScale(0.5, 0.88),
                Size = UDim2.new(0.56, 0, 0, 150),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                GroupTransparency = 1,
                ZIndex = 10,
            }
            local Children_12 = v7.Children
            v14 = {}
            v15 = v7:New("UISizeConstraint")({MinSize = Vector2.new(280, 150), MaxSize = Vector2.new(760, 150)})
            v14[1] = v10
            v14[2] = v15
            v14[3] = v12
            v14[4] = v11
            v14[5] = v1
            v3[Children_12] = v14
            v2 = v2(v3)
            self.commendationCard = v2
            self.commendationNameLabel = v10
            self.commendationTitleLabel = v12
            self.commendationDescriptorLabel = v11
            self.commendationValueLabel = v6
            self.commendationValueScale = v13
            table.insert(v9, v2)
        else
            v11 = v7:New("Frame")
            v13 = {
                Name = "StoryStatus",
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, -18),
                Size = UDim2.new(0.88, 0, 0, 76),
                BackgroundTransparency = 1,
                ZIndex = 10,
            }
            local Children_4 = v7.Children
            v1 = {}
            v2 = v7:New("TextLabel")
            v3 = {
                Name = "Status",
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                Font = Theme.Menu.Fonts.Header,
                Text = self.statusText,
                TextColor3 = Theme.Menu.Text,
                TextScaled = true,
                TextTransparency = 0.06,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 10,
            }
            local Children_5 = v7.Children
            v14 = {}
            local v16 = v7:New("UITextSizeConstraint")({MinTextSize = 12, MaxTextSize = 22})
            v15 = v7:New("UIStroke")
            local v17 = {Thickness = 1, Transparency = 0.3, Color = Theme.Menu.HeaderStroke}
            v14[1] = v16
            v14[2] = v15(v17)
            v3[Children_5] = v14
            v2 = v2(v3)
            v3 = v7:New("TextLabel")
            v4 = {
                Name = "Count",
                Position = UDim2.new(0, 0, 0, 28),
                Size = UDim2.new(1, 0, 0, 48),
                BackgroundTransparency = 1,
                Font = Theme.Menu.Fonts.Header,
                Text = self.countText,
                TextColor3 = Theme.Menu.Accent,
                TextScaled = true,
                TextTransparency = 0.02,
                TextXAlignment = Enum.TextXAlignment.Center,
                ZIndex = 10,
            }
            local Children_6 = v7.Children
            v16 = {}
            v15 = v7:New("UITextSizeConstraint")({MinTextSize = 18, MaxTextSize = 34})
            v17 = v7:New("UIStroke")
            local v18 = {Thickness = 1, Transparency = 0.22, Color = Theme.Menu.HeaderStroke}
            v16[1] = v15
            v16[2] = v17(v18)
            v4[Children_6] = v16
            v1[1] = v2
            v1[2] = v3(v4)
            v13[Children_4] = v1
            v11 = v11(v13)
            table.insert(v9, v11)
        end
    end
    if self.mode ~= "Extraction" then
        v11 = v7:New("Frame")
        v13 = {
            Name = "ProgressTrack",
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 4),
            BackgroundColor3 = Theme.Menu.Border,
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            ZIndex = 20,
        }
        local Children_13 = v7.Children
        v1 = {}
        v2 = v7:New("Frame")
        v3 = {
            Name = "Fill",
            Size = v7:Computed(function(p1) -- Line: 799 -- upvalues: u54 (val)
                local fromScale = UDim2.fromScale
                local v1 = u54
                local v2 = p1(v1)
                local v3 = tonumber(v2) or 0
                return fromScale(math.clamp(v3, 0, 1), 1)
            end),
            BackgroundColor3 = Theme.Menu.Accent,
            BackgroundTransparency = 0.12,
            BorderSizePixel = 0,
            ZIndex = 21,
        }
        local Children_14 = v7.Children
        v3[Children_14] = {v7:New("UIGradient")({Color = ColorSequence.new(Theme.Menu.Accent, Theme.Menu.AccentCyan)})}
        v1[1] = v2(v3)
        v13[Children_13] = v1
        v11 = v11(v13)
        table.insert(v8, v11)
    end
    v12 = true
    if self.mode ~= "Story" then
        v12 = self.mode == "Extraction"
    end
    if not v12 then
        v10 = "Frame"
    else
        v10 = "CanvasGroup"
    end
    v12 = v7:New(v10)
    v11 = {
        Name = "Root",
        Size = UDim2.fromScale(1, 1),
        Active = true,
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
    }
    v6 = true
    if self.mode ~= "Story" then
        v6 = self.mode == "Extraction"
    end
    if not v6 then
        v13 = nil
    else
        v13 = 0
    end
    v11.GroupTransparency = v13
    v11[v7.Children] = v8
    v12 = v12(v11)
    v11 = v7:New(v10)
    v13 = {Name = "SafeRoot", Size = UDim2.fromScale(1, 1), Active = true, BackgroundTransparency = 1}
    v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if not v1 then
        v6 = nil
    else
        v6 = 0
    end
    v13.GroupTransparency = v6
    v13[v7.Children] = v9
    v11 = v11(v13)
    v13 = v7:New("ScreenGui")
    v6 = {
        Name = "MarauderLoadingScreen",
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        DisplayOrder = 10000,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.None,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    local Children_15 = v7.Children
    v2 = {v12}
    v6[Children_15] = v2
    v13 = v13(v6)
    v6 = v7:New("ScreenGui")
    v1 = {
        Name = "MarauderLoadingSafeArea",
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        DisplayOrder = 10001,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    local Children_16 = v7.Children
    v3 = {v11}
    v1[Children_16] = v3
    v6 = v6(v1)
    v1 = nil
    if self.extractionCover then
        v2 = v7:New("ScreenGui")
        v3 = {
            Name = "MarauderLoadingExtractionCover",
            Parent = LocalPlayer:WaitForChild("PlayerGui"),
            DisplayOrder = 10002,
            IgnoreGuiInset = true,
            ScreenInsets = Enum.ScreenInsets.None,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        }
        local Children_17 = v7.Children
        v3[Children_17] = {self.extractionCover}
        v1 = v2(v3)
    end
    self.screenGui = v13
    self.safeGui = v6
    self.coverGui = v1
    self.interfaceRoot = v12
    self.safeRoot = v11
end

function u81:_createMusic() -- Line: 878
    -- upvalues: Config (val), SoundService (val), TweenService (val), getMarauderTemplate (val)
    -- upvalues: getSeatedIdleAnimationAssets (val), getHeliPreloadSoundAssets (val)
    -- upvalues: getExtractionPreloadSoundAssets (val), ContentProvider (val)
    local u6 = nil
    if self.mode == "Lobby" then
        u6 = Instance.new("Sound")
        u6.Name = "MarauderLoadingMusic"
        u6.SoundId = Config.LoadingMusicSoundId
        u6.Looped = true
        u6.Volume = 0
        local Primary = SoundService:FindFirstChild("Primary")
        local Music = Primary
        if Music then
            Music = Primary:FindFirstChild("Music")
        end
        local v1 = Music and Music:IsA("SoundGroup") and Music or nil
        u6.SoundGroup = v1
        u6.Parent = SoundService
        self.music = u6
        u6:Play()
        v1 = TweenService
        local v2 = u6
        local v3 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v4 = {Volume = Config.LoadingMusicVolume}
        v1:Create(v2, v3, v4):Play()
    end
    task.spawn(function() -- Line: 898
        -- upvalues: getMarauderTemplate (upval), u6 (ref), getSeatedIdleAnimationAssets (upval), self (val)
        -- upvalues: getHeliPreloadSoundAssets (upval), Config (upval), getExtractionPreloadSoundAssets (upval)
        -- upvalues: ContentProvider (upval)
        pcall(function() -- Line: 899
            -- upvalues: getMarauderTemplate (upval), u6 (upval), getSeatedIdleAnimationAssets (upval), self (upval)
            -- upvalues: getHeliPreloadSoundAssets (upval), Config (upval), getExtractionPreloadSoundAssets (upval)
            -- upvalues: ContentProvider (upval)
            local v1
            local v2 = getMarauderTemplate()
            local v3 = {}
            if u6 then
                v1 = u6
                table.insert(v3, v1)
            end
            if v2 then
                table.insert(v3, v2)
            end
            for i, v in ipairs((getSeatedIdleAnimationAssets())) do
                table.insert(v3, v)
            end
            local v4 = self
            local v5 = true
            if v4.mode ~= "Story" then
                v5 = v4.mode == "Extraction"
            end
            if v5 then
                for i2, i3 in ipairs((getHeliPreloadSoundAssets())) do
                    table.insert(v3, i3)
                end
            end
            if self.mode == "Story" then
                v1 = Config
                local CountdownBeep = v1.CountdownBeep
                table.insert(v3, CountdownBeep)
                v1 = Config
                local CountdownFinalBeep = v1.CountdownFinalBeep
                table.insert(v3, CountdownFinalBeep)
            elseif self.mode == "Extraction" then
                for i4, j in ipairs((getExtractionPreloadSoundAssets())) do
                    table.insert(v3, j)
                end
            end
            if 0 < #v3 then
                ContentProvider:PreloadAsync(v3)
            end
        end)
    end)
end

function u81:_createExtractionSounds() -- Line: 931
    -- upvalues: Config (val), getEffectsSoundGroup (val), SoundService (val)
    local Sound, soundId, v1
    if self.mode ~= "Extraction" then
        return
    end
    self.extractionSounds = {}
    local v2 = pairs
    local v3 = {
        hit = {soundId = Config.ExtractionCardHitSoundId, volume = Config.ExtractionCardHitVolume},
        whoosh = {soundId = Config.ExtractionCardWhooshSoundId, volume = Config.ExtractionCardWhooshVolume},
        hydraulic = {soundId = Config.ExtractionCameraMoveSoundId, volume = Config.ExtractionCameraMoveVolume},
        count = {
            looped = true,
            soundId = Config.ExtractionCountUpLoopSoundId,
            volume = Config.ExtractionCountUpLoopVolume,
        },
        finish = {soundId = Config.ExtractionCountUpFinishSoundId, volume = Config.ExtractionCountUpFinishVolume},
    }
    local v4 = self
    for k, v in v2(v3) do
        soundId = v.soundId
        if type(soundId) == "string" and soundId ~= "" then
            Sound = Instance.new("Sound")
            Sound.Name = "MarauderExtraction" .. (string.upper((string.sub(k, 1, 1)))) .. string.sub(k, 2)
            Sound.SoundId = soundId
            Sound.Volume = v.volume
            v1 = v.looped == true
            Sound.Looped = v1
            Sound.SoundGroup = getEffectsSoundGroup()
            Sound.Parent = SoundService
            v4.extractionSounds[k] = Sound
        end
    end
end

function u81:_createStorySounds() -- Line: 964 -- upvalues: Config (val), getEffectsSoundGroup (val), SoundService (val)
    local Sound, soundId
    if self.mode ~= "Story" then
        return
    end
    self.storySounds = {}
    local v1 = pairs
    local v2 = {
        playerReady = {soundId = Config.StoryPlayerReadySoundId, volume = Config.StoryPlayerReadyVolume},
        allReady = {soundId = Config.StoryAllReadySoundId, volume = Config.StoryAllReadyVolume},
    }
    for k, v in v1(v2) do
        soundId = v.soundId
        if type(soundId) == "string" and v.soundId ~= "" then
            Sound = Instance.new("Sound")
            Sound.Name = "MarauderStory" .. (string.upper((string.sub(k, 1, 1)))) .. string.sub(k, 2)
            Sound.SoundId = v.soundId
            Sound.Volume = v.volume
            Sound.SoundGroup = getEffectsSoundGroup()
            Sound.Parent = SoundService
            self.storySounds[k] = Sound
        end
    end
end

function u81:_playExtractionSound(p2) -- Line: 985
    local extractionSounds = self.extractionSounds
    if extractionSounds then
        extractionSounds = self.extractionSounds[p2]
    end
    if extractionSounds then
        extractionSounds.TimePosition = 0
        extractionSounds:Play()
    end
end

function u81:_stopExtractionSound(p2) -- Line: 993
    local extractionSounds = self.extractionSounds
    if extractionSounds then
        extractionSounds = self.extractionSounds[p2]
    end
    if extractionSounds then
        extractionSounds:Stop()
    end
end

function u81:_playStorySound(p2) -- Line: 1000
    local storySounds = self.storySounds
    if storySounds then
        storySounds = self.storySounds[p2]
    end
    if storySounds then
        storySounds.TimePosition = 0
        storySounds:Play()
    end
end

function u81:_buildSeatFrames(p2, p3, p4) -- Line: 1008 -- upvalues: Config (val)
    local CFrame_4, Position, Position_2, RightVector, Y_3, Y_4, v1, v2, v3, v4, v5, v6, v7
    if not p3 then
        Position = Config.FallbackSeatPosition
    else
        Position = p3.Position
        if not Position then
            Position = Config.FallbackSeatPosition
        end
    end
    local X = Position.X
    if (math.abs(X)) < 1.5 then
        v7 = Config
        local X_2 = v7.FallbackSeatPosition.X
        local Y = Position.Y
        local Z = Position.Z
        Position = Vector3.new(X_2, Y, Z)
    end
    if not p4 then
        Position_2 = Config.FallbackDoorPosition
    else
        Position_2 = p4.Position
        if not Position_2 then
            Position_2 = Config.FallbackDoorPosition
        end
    end
    local Z_2 = Position_2.Z
    if not (Position.Z <= Z_2) then
        v7 = 1
    else
        v7 = -1
    end
    self.seatFrames = {}
    for i, v in ipairs(Config.PassengerSlots) do
        v1 = Position.X * v.X
        v2 = Position.Z + v7 * Config.SeatSpacing * v.Y
        Y_3 = Position.Y
        v3 = Vector3.new(v1, Y_3, v2)
        v4 = p2.CFrame:PointToWorldSpace(v3)
        CFrame_4 = p2.CFrame
        Y_4 = Position.Y
        v6 = Vector3.new(0, Y_4, v2)
        v5 = CFrame_4:PointToWorldSpace(v6)
        self.seatFrames[i] = (CFrame.lookAt(v4, v5, p2.CFrame.UpVector))
    end
    local Position_3 = self.seatFrames[Config.LobbySeatIndex].Position
    local CFrame_2 = p2.CFrame
    local Y_2 = Position.Y
    local Z_3 = Position.Z
    local v8 = Vector3.new(0, Y_2, Z_3)
    local v9 = CFrame_2:PointToWorldSpace(v8) - Position_3
    if not (v9.Magnitude < 0.1) then
        RightVector = v9.Unit
    else
        RightVector = p2.CFrame.RightVector
    end
    local CFrame_3 = p2.CFrame
    v2 = Vector3.new(0, 0, v7)
    v8 = CFrame_3:VectorToWorldSpace(v2)
    local UpVector = p2.CFrame.UpVector
    v2 = p2.CFrame:PointToWorldSpace(Position_2)
    v3 = Position_3 + RightVector * Config.LobbyCameraAisleOffset + v8 * Config.LobbyCameraLongitudinalOffset + UpVector * Config.LobbyCameraHeight
    v4 = Position_3 + UpVector * 0.7
    v5 = v2 + UpVector * 0.4
    local v10 = Config
    local LobbyDoorCompositionWeight = v10.LobbyDoorCompositionWeight
    local v11 = v4:Lerp(v5, LobbyDoorCompositionWeight)
    self.lobbyCameraCFrame = CFrame.lookAt(v3, v11, UpVector)
    local v12 = Config
    local StoryCameraLateralOffset = v12.StoryCameraLateralOffset
    v10 = Position.Y + Config.StoryCameraHeight
    local Z_4 = Position.Z
    local v13 = Config
    local v14 = Z_4 - v7 * v13.StoryCameraLongitudinalOffset
    v6 = Vector3.new(StoryCameraLateralOffset, v10, v14)
    v14 = Position.Y + Config.StoryCameraTargetHeight
    local Z_5 = Position.Z
    local v15 = v7 * Config.SeatSpacing
    local v16 = Config
    local v17 = Z_5 + v15 * v16.StoryCameraTargetRow
    v12 = Vector3.new(0, v14, v17)
    local lookAt = CFrame.lookAt
    v14 = p2.CFrame:PointToWorldSpace(v6)
    v17 = p2.CFrame:PointToWorldSpace(v12)
    self.storyCameraCFrame = lookAt(v14, v17, UpVector)
    v14 = Config
    local ExtractionWideCameraLateralOffset = v14.ExtractionWideCameraLateralOffset
    v17 = Position.Y + Config.ExtractionWideCameraHeight
    local Z_6 = Position.Z
    v16 = Config
    local v18 = Z_6 - v7 * v16.ExtractionWideCameraLongitudinalOffset
    v10 = Vector3.new(ExtractionWideCameraLateralOffset, v17, v18)
    v18 = Position.Y + Config.ExtractionWideCameraTargetHeight
    local Z_7 = Position.Z
    local v19 = v7 * Config.SeatSpacing
    local v20 = Config
    v13 = Z_7 + v19 * v20.ExtractionWideCameraTargetRow
    v14 = Vector3.new(0, v18, v13)
    local lookAt_2 = CFrame.lookAt
    v18 = p2.CFrame:PointToWorldSpace(v10)
    v13 = p2.CFrame:PointToWorldSpace(v14)
    self.extractionWideCameraCFrame = lookAt_2(v18, v13, UpVector)
    self.cabinUpVector = UpVector
end

function u81:_getSpotlightCFrame(p2) -- Line: 1081 -- upvalues: Config (val)
    local X
    local seatFrames = self.seatFrames
    if seatFrames then
        seatFrames = self.seatFrames[p2]
    end
    if not seatFrames then
        local extractionWideCameraCFrame = self.extractionWideCameraCFrame
        if not extractionWideCameraCFrame then
            extractionWideCameraCFrame = self.storyCameraCFrame
        end
        return extractionWideCameraCFrame
    end
    local v1 = self.cabinUpVector or Vector3.new(0, 1, 0)
    local v2 = seatFrames.Position + v1 * 0.82
    local v3 = seatFrames.LookVector * Config.ExtractionSpotlightDistance
    if not Config.PassengerSlots[p2] then
        X = 1
    else
        X = Config.PassengerSlots[p2].X
        if not X then
            X = 1
        end
    end
    local v4 = v2 + (CFrame.fromAxisAngle(v1, Config.ExtractionSpotlightYaw * X)):VectorToWorldSpace(v3) + v1 * Config.ExtractionSpotlightHeight
    return CFrame.lookAt(v4, v2, v1)
end

function u81:_dismissArrivalCover(p2) -- Line: 1095 -- upvalues: dismissArrivalCover (val)
    local v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if v1 then
        dismissArrivalCover(p2)
    end
end

function u81:_startHeliAudioFadeIn(p2) -- Line: 1101 -- upvalues: Config (val), TweenService (val)
    local v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if v1 and not self.destroyed and not self.heliAudioFadingIn and not self.storyDepartureFading then
        local v2, v3, v4
        self.heliAudioFadingIn = true
        local HeliAudioFadeIn = tonumber(p2)
        if not HeliAudioFadeIn then
            HeliAudioFadeIn = Config.HeliAudioFadeIn
        end
        local v5 = math.max(HeliAudioFadeIn, 0)
        v1 = ipairs
        local heliSounds = self.heliSounds
        if not heliSounds then
            heliSounds = {}
        end
        local v6 = self
        for i, v in v1(heliSounds) do
            if v.Parent then
                if not v.IsPlaying then
                    v:Play()
                end
                v4 = TweenService
                v2 = TweenInfo.new(v5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                v3 = {Volume = v6.heliSoundVolumes[v] or 0}
                v4:Create(v, v2, v3):Play()
            end
        end
        return
    end
end

function u81:_isHeliAudioReady() -- Line: 1121
    local heliSounds = self.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    if #heliSounds < 2 then
        return false
    end
    for i, v in ipairs(heliSounds) do
        if v.Parent and v.IsLoaded then
            continue
        end
        return false
    end
    return true
end

function u81:_getStoryRevealAvatarState() -- Line: 1134
    local format, model, model_2, userId, v1, v2, v3, v4, v5, v6
    local v7 = 1
    if self.loadingStatus then
        local Attribute = self.loadingStatus:GetAttribute("ExpectedPlayers")
        v6 = tonumber(Attribute)
        v5 = math.floor(v6 or 0)
        v7 = math.max(v5, 1)
    end
    local v8 = {}
    v5 = 0
    local v9 = pairs
    local storyFolders = self.storyFolders
    if not storyFolders then
        storyFolders = {}
    end
    for k, v in v9(storyFolders) do
        if k.Parent then
            v5 = v5 + 1
            v8[v.index] = v
        end
    end
    v7 = math.max(v7, v5)
    v9 = 0
    v6 = {}
    local v10 = {}
    local v11 = self
    for i = 1, 6 do
        v1 = v8[i]
        if v1 then
            v2 = v11.avatars[i]
            model = v2
            if model then
                model = false
                if v2.loading ~= true then
                    model = false
                    if v2.userId == v1.userId then
                        model = v2.model
                        if model then
                            model = v2.model.Parent == v11.avatarFolder
                        end
                    end
                end
            end
            if model then
                v9 = v9 + 1
                model_2 = v2.model
                table.insert(v6, model_2)
                format = string.format
                v4 = v11.avatarGenerations[i] or 0
                userId = v1.userId
                v3 = format("%d:%d:%d", i, v4, userId or 0)
                table.insert(v10, v3)
            end
        end
    end
    local v12 = false
    if v7 <= v5 then
        v12 = v7 <= v9
    end
    return v12, (table.concat(v10, "|")), v6, v9, v7
end

function u81:_beginStoryBasePreload() -- Line: 1180 -- upvalues: ContentProvider (val)
    if self.mode == "Story" and not self.destroyed and not self.storyBasePreloadStarted then
        self.storyBasePreloadStarted = true
        self.storyBasePreloadFinished = false
        local u6 = {}
        if self.scene then
            local scene = self.scene
            table.insert(u6, scene)
        end
        local v1 = ipairs
        local heliSounds = self.heliSounds
        if not heliSounds then
            heliSounds = {}
        end
        for i, v in v1(heliSounds) do
            table.insert(u6, v)
        end
        task.spawn(function() -- Line: 1195 -- upvalues: u6 (val), ContentProvider (upval), self (val)
            local success, result = pcall(function() -- Line: 1196 -- upvalues: u6 (upval), ContentProvider (upval)
                local v1 = #u6
                if 0 < v1 then
                    v1 = ContentProvider
                    local v2 = u6
                    v1:PreloadAsync(v2)
                end
            end)
            if self.destroyed then
                return
            end
            self.storyBasePreloadFinished = true
            self.storyBasePreloadSucceeded = success
            local v1 = self
            v1.storyBasePreloadError = tostring(result)
        end)
        return
    end
end

function u81:_beginStoryAvatarPreload(p2, p3) -- Line: 1210 -- upvalues: ContentProvider (val)
    if not self.destroyed and self.storyAvatarPreloadSignature ~= p2 then
        self.storyAvatarPreloadGeneration = (self.storyAvatarPreloadGeneration or 0) + 1
        local storyAvatarPreloadGeneration = self.storyAvatarPreloadGeneration
        self.storyAvatarPreloadSignature = p2
        self.storyAvatarPreloadFinished = false
        self.storyAvatarPreloadSucceeded = false
        task.spawn(function() -- Line: 1220 -- upvalues: p3 (val), ContentProvider (upval), self (val), storyAvatarPreloadGeneration (val)
            local success, result = pcall(function() -- Line: 1221 -- upvalues: p3 (upval), ContentProvider (upval)
                local v1 = #p3
                if 0 < v1 then
                    v1 = ContentProvider
                    local v2 = p3
                    v1:PreloadAsync(v2)
                end
            end)
            if not self.destroyed and self.storyAvatarPreloadGeneration == storyAvatarPreloadGeneration then
                self.storyAvatarPreloadFinished = true
                self.storyAvatarPreloadSucceeded = success
                local v1 = self
                v1.storyAvatarPreloadError = tostring(result)
                return
            end
        end)
        return
    end
end

function u81:_waitForStoryRevealReady() -- Line: 1235 -- upvalues: Config (val), RunService (val)
    local storyAvatarPreloadFinished, storyBasePreloadFinished, v1, v2, v3, v4, v5, v6, v7, v8
    if self.mode ~= "Story" then
        return true
    end
    self:_beginStoryBasePreload()
    local v9 = os.clock()
    local v10 = Config
    local StoryRevealReadyTimeout = v10.StoryRevealReadyTimeout
    local v11 = tonumber(StoryRevealReadyTimeout) or 0
    local v12 = v9 + math.max(v11, 0)
    local v13 = nil
    local v14 = self
    while true do
        v8, v1, v2, v3, v4 = v14:_getStoryRevealAvatarState()
        v10 = v8
        v6 = v1
        v7 = v2
        v9 = v3
        v5 = v4
        if v10 then
            v14:_beginStoryAvatarPreload(v6, v7)
        end
        v11 = v14:_isHeliAudioReady()
        storyBasePreloadFinished = v14.storyBasePreloadFinished
        if storyBasePreloadFinished then
            storyBasePreloadFinished = v14.storyBasePreloadSucceeded
        end
        storyAvatarPreloadFinished = v10
        if storyAvatarPreloadFinished then
            storyAvatarPreloadFinished = false
            if v14.storyAvatarPreloadSignature == v6 then
                storyAvatarPreloadFinished = v14.storyAvatarPreloadFinished
                if storyAvatarPreloadFinished then
                    storyAvatarPreloadFinished = v14.storyAvatarPreloadSucceeded
                end
            end
        end
        if storyBasePreloadFinished and storyAvatarPreloadFinished and v11 then
            v2 = v13
            if not v2 then
                v2 = os.clock()
            end
            v13 = v2
            v2 = os.clock() - v13
            if Config.StoryRevealReadyStableTime <= v2 then
                return true
            end
            RunService.Heartbeat:Wait()
            if v14.destroyed or v12 <= os.clock() then
                break
            end
            continue
        end
        v13 = nil
        RunService.Heartbeat:Wait()
        if v14.destroyed or v12 <= os.clock() then
            break
        end
    end
    if not v14.destroyed then
        local v15, v16
        v10 = warn
        local format = string.format
        v7 = "[MarauderLoading] Story reveal readiness timed out (avatars=%d/%d, sceneAssets=%s, avatarAssets=%s, heliAudio=%s); revealing with available assets%s%s"
        v8 = v9
        v1 = v5
        local storyBasePreloadFinished_2 = v14.storyBasePreloadFinished
        if storyBasePreloadFinished_2 then
            storyBasePreloadFinished_2 = v14.storyBasePreloadSucceeded == true
        end
        v2 = tostring(storyBasePreloadFinished_2)
        local storyAvatarPreloadFinished_2 = v14.storyAvatarPreloadFinished
        if storyAvatarPreloadFinished_2 then
            storyAvatarPreloadFinished_2 = v14.storyAvatarPreloadSucceeded == true
        end
        v3 = tostring(storyAvatarPreloadFinished_2)
        v4 = tostring(v11)
        if not v14.storyBasePreloadError then
            v15 = ""
        else
            v15 = "; scene preload error=" .. v14.storyBasePreloadError
            if not v15 then
                v15 = ""
            end
        end
        if not v14.storyAvatarPreloadError then
            v16 = ""
        else
            v16 = "; avatar preload error=" .. v14.storyAvatarPreloadError
            if not v16 then
                v16 = ""
            end
        end
        v10(format(v7, v8, v1, v2, v3, v4, v15, v16))
    end
    return false
end

function u81:_waitForExtractionAvatarReady() -- Line: 1286 -- upvalues: Config (val), RunService (val)
    local model, v1
    if self.mode ~= "Extraction" then
        return true
    end
    local v2 = 0
    local v3 = pairs
    local extractionAvatarSeats = self.extractionAvatarSeats
    if not extractionAvatarSeats then
        extractionAvatarSeats = {}
    end
    for k in v3(extractionAvatarSeats) do
        v2 = v2 + 1
    end
    if v2 == 0 then
        return true
    end
    local v4 = os.clock()
    local v5 = Config
    local ExtractionAvatarReadyTimeout = v5.ExtractionAvatarReadyTimeout
    local v6 = tonumber(ExtractionAvatarReadyTimeout) or 0
    v3 = v4 + math.max(v6, 0)
    local v7 = nil
    local v8 = self
    while true do
        v4 = 0
        for k2 in pairs(v8.extractionAvatarSeats) do
            v1 = v8.avatars[k2]
            model = v1
            if model then
                model = false
                if v1.loading ~= true then
                    model = v1.model
                    if model then
                        model = v1.model.Parent == v8.avatarFolder
                    end
                end
            end
            if model then
                v4 = v4 + 1
            end
        end
        if not (v2 <= v4) then
            v7 = nil
            RunService.Heartbeat:Wait()
            if v8.destroyed or v3 <= os.clock() then
                break
            end
        else
            v6 = v7
            if not v6 then
                v6 = os.clock()
            end
            v7 = v6
            v6 = os.clock() - v7
            if Config.StoryRevealReadyStableTime <= v6 then
                return true
            end
            RunService.Heartbeat:Wait()
            if v8.destroyed or v3 <= os.clock() then
                break
            end
        end
    end
    if not v8.destroyed then
        warn(string.format(
            "[MarauderLoading] Extraction avatar readiness timed out (avatars=%d/%d); revealing with available avatars",
            v4,
            v2
        ))
    end
    return false
end

function u81:_revealStoryScene() -- Line: 1335 -- upvalues: Config (val)
    if not self.destroyed and not self.storySceneRevealed then
        self.storySceneRevealed = true
        local ArrivalFadeOutTime = Config.ArrivalFadeOutTime
        self:_startHeliAudioFadeIn(ArrivalFadeOutTime)
        self:_dismissArrivalCover(ArrivalFadeOutTime)
        return
    end
end

function u81:_createHeliAudio(p2) -- Line: 1345 -- upvalues: getEffectsSoundGroup (val), Config (val)
    local v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if v1 and not self.destroyed and p2 and p2.Parent then
        local Sound, heliSounds_2
        v1 = getEffectsSoundGroup()
        local v2 = {}
        local v3 = {
            name = "MarauderInterior",
            soundId = Config.HeliInteriorSoundId,
            volume = Config.HeliInteriorVolume,
        }
        local v4 = {name = "MarauderEngine", soundId = Config.HeliEngineSoundId, volume = Config.HeliEngineVolume}
        v2[1] = v3
        v2[2] = v4
        local heliSounds = self.heliSounds
        if not heliSounds then
            heliSounds = {}
        end
        self.heliSounds = heliSounds
        local heliSoundVolumes = self.heliSoundVolumes
        if not heliSoundVolumes then
            heliSoundVolumes = {}
        end
        self.heliSoundVolumes = heliSoundVolumes
        for i, v in ipairs(v2) do
            Sound = Instance.new("Sound")
            Sound.Name = v.name
            Sound.SoundId = v.soundId
            Sound.Looped = true
            Sound.Volume = 0
            Sound.RollOffMode = Enum.RollOffMode.InverseTapered
            Sound.RollOffMinDistance = Config.HeliAudioMinDistance
            Sound.RollOffMaxDistance = Config.HeliAudioMaxDistance
            Sound.SoundGroup = v1
            Sound.Parent = p2
            heliSounds_2 = self.heliSounds
            table.insert(heliSounds_2, Sound)
            self.heliSoundVolumes[Sound] = v.volume
            Sound:Play()
        end
        if self.mode == "Extraction" then
            local v5 = Config
            local HeliAudioFadeIn = v5.HeliAudioFadeIn
            self:_startHeliAudioFadeIn(HeliAudioFadeIn)
        end
        return
    end
end

function u81:_startStoryCameraShake() -- Line: 1386 -- upvalues: Config (val), getCameraShaker (val)
    local v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if v1 and not self.destroyed and not self.cameraShaker then
        local StoryCameraShake = Config.StoryCameraShake
        local v2 = getCameraShaker
        v2 = v2()
        local new = v2.new
        local Value = Enum.RenderPriority.Camera.Value
        local v3 = self.renderStepName or "MarauderLoading_Cabin"
        self.cameraShaker = new(Value, v3 .. "_Shake")
        local cameraShaker = self.cameraShaker
        local Magnitude = StoryCameraShake.Magnitude
        local Roughness = StoryCameraShake.Roughness
        local FadeIn = StoryCameraShake.FadeIn
        local PositionInfluence = StoryCameraShake.PositionInfluence
        local RotationInfluence = StoryCameraShake.RotationInfluence
        self.cameraShake = cameraShaker:StartShake(Magnitude, Roughness, FadeIn, PositionInfluence, RotationInfluence)
        return
    end
end

function u81:_fadeStoryInterface(p2) -- Line: 1404 -- upvalues: TweenService (val)
    local v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if v1 and not self.storyInterfaceFading then
        local readyLabel, readyStroke, v2, v3, v4, v5, v6, v7
        self.storyInterfaceFading = true
        v1 = ipairs
        local v8 = {self.interfaceRoot, self.safeRoot}
        for i, v in v1(v8) do
            if v and v:IsA("CanvasGroup") then
                v5 = TweenService
                v2 = TweenInfo.new(p2, Enum.EasingStyle.Linear)
                v5:Create(v, v2, {GroupTransparency = 1}):Play()
            end
        end
        v1 = pairs
        local avatars = self.avatars
        if not avatars then
            avatars = {}
        end
        local v9 = p2
        for k, i2 in v1(avatars) do
            readyLabel = i2.readyLabel
            if readyLabel and readyLabel.Parent then
                v6 = TweenService
                v3 = TweenInfo.new(v9, Enum.EasingStyle.Linear)
                v6:Create(readyLabel, v3, {TextTransparency = 1}):Play()
            end
            readyStroke = i2.readyStroke
            if readyStroke and readyStroke.Parent then
                v7 = TweenService
                v4 = TweenInfo.new(v9, Enum.EasingStyle.Linear)
                v7:Create(readyStroke, v4, {Transparency = 1}):Play()
            end
        end
        return
    end
end

function u81:_fadeHeliAudio(p2) -- Line: 1432 -- upvalues: Config (val), TweenService (val)
    local v1, v2
    local HeliAudioFadeOut = tonumber(p2)
    if not HeliAudioFadeOut then
        HeliAudioFadeOut = Config.HeliAudioFadeOut
    end
    local v3 = math.max(HeliAudioFadeOut, 0)
    local v4 = ipairs
    local heliSounds = self.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    for i, v in v4(heliSounds) do
        if v.Parent then
            v2 = TweenService
            v1 = TweenInfo.new(v3, Enum.EasingStyle.Linear)
            v2:Create(v, v1, {Volume = 0}):Play()
        end
    end
end

function u81:_startStoryDepartureFade() -- Line: 1441 -- upvalues: Config (val)
    local v1 = true
    if self.mode ~= "Story" then
        v1 = self.mode == "Extraction"
    end
    if v1 and not self.storyDepartureFading then
        local HeliAudioFadeOut
        self.storyDepartureFading = true
        if self.mode ~= "Extraction" then
            HeliAudioFadeOut = Config.StoryUIFadeTime
        else
            HeliAudioFadeOut = Config.HeliAudioFadeOut
        end
        self:_fadeStoryInterface(HeliAudioFadeOut)
        self:_fadeHeliAudio(HeliAudioFadeOut)
        return
    end
end

function u81:_prepareScene() -- Line: 1451
    -- upvalues: getMarauderTemplate (val), u87 (val), findDoor (val), Workspace (val), Config (val), LocalPlayer (val)
    -- upvalues: TweenService (val)
    local v1 = getMarauderTemplate()
    if not v1 then
        local v2 = os.clock() + 8
        repeat
            task.wait(0.1)
            v1 = getMarauderTemplate()
        until v1 or self.destroyed or v2 <= os.clock()
    end
    if v1 and not self.destroyed then
        local Marauder01 = v1:FindFirstChild("Marauder01")
        if not Marauder01 and v1:IsA("Model") then
            Marauder01 = v1
        end
        if Marauder01 and Marauder01:IsA("Model") then
            local v3 = Marauder01:Clone()
            v3.Name = "MarauderLoadingScene"
            local Heli = v3:FindFirstChild("Heli")
            local Body = Heli
            if Body then
                Body = Heli:FindFirstChild("Body")
            end
            if Heli and Heli:IsA("Model") and Body and Body:IsA("BasePart") then
                local CFrame, CFrame_2, v4, v5, v6
                local Player = v3:FindFirstChild("Player")
                if not Player then
                    CFrame = nil
                elseif Player:IsA("BasePart") then
                    CFrame = Player.CFrame
                elseif not Player:IsA("Model") then
                    CFrame = nil
                else
                    local success, result = pcall(Player.GetPivot, Player)
                    CFrame = success and result or nil
                end
                if not CFrame then
                    v6 = nil
                else
                    v6 = Body.CFrame:ToObjectSpace(CFrame)
                    if not v6 then
                        v6 = nil
                    end
                end
                if Player and Player:IsA("Model") then
                    self.placeholderFallback = Player:Clone()
                end
                local v7 = findDoor(Heli)
                if not v7 then
                    CFrame_2 = nil
                elseif v7:IsA("BasePart") then
                    CFrame_2 = v7.CFrame
                elseif not v7:IsA("Model") then
                    CFrame_2 = nil
                else
                    local success_2, result_2 = pcall(v7.GetPivot, v7)
                    CFrame_2 = success_2 and result_2 or nil
                end
                if not CFrame_2 then
                    v4 = nil
                else
                    v4 = Body.CFrame:ToObjectSpace(CFrame_2)
                    if not v4 then
                        v4 = nil
                    end
                end
                local v8 = ipairs
                local v9 = {"Player", "2nd", "3rd"}
                for i, v in v8(v9) do
                    v5 = v3:FindFirstChild(v)
                    if v5 then
                        v5:Destroy()
                    end
                end
                local v10 = self
                for i2, i3 in ipairs(v3:GetDescendants()) do
                    if i3:IsA("LuaSourceContainer")
                        or i3:IsA("AnimationController")
                        or i3:IsA("Animator")
                        or i3:IsA("Sound") then
                        i3:Destroy()
                    elseif i3:IsA("BasePart") then
                        i3.Anchored = true
                        i3.CanCollide = false
                        i3.CanTouch = false
                        i3.CanQuery = false
                        i3.Massless = true
                    end
                end
                v3.Parent = Workspace
                local v11 = Config
                local SceneOrigin = v11.SceneOrigin
                v3:PivotTo(SceneOrigin)
                v10.scene = v3
                v10.avatarFolder = Instance.new("Folder")
                v10.avatarFolder.Name = "Passengers"
                v10.avatarFolder.Parent = v3
                local PointLight = Instance.new("PointLight")
                PointLight.Name = "MarauderLoadingRedFill"
                PointLight.Color = Color3.fromRGB(255, 54, 32)
                PointLight.Brightness = 0.7
                PointLight.Range = 24
                PointLight.Shadows = false
                PointLight.Parent = Body
                local PointLight_2 = Instance.new("PointLight")
                PointLight_2.Name = "MarauderLoadingSoftFill"
                PointLight_2.Color = Color3.fromRGB(255, 196, 160)
                PointLight_2.Brightness = 0.32
                PointLight_2.Range = 17
                PointLight_2.Shadows = false
                PointLight_2.Parent = Body
                local v12 = Heli:FindFirstChild("Body")
                v10:_buildSeatFrames(v12, v6, v4)
                if v10.mode == "Lobby" then
                    v10.baseCameraCFrame = v10.lobbyCameraCFrame
                    v10.fieldOfView = Config.LobbyFieldOfView
                elseif v10.mode ~= "Extraction" then
                    v10.baseCameraCFrame = v10.storyCameraCFrame
                    v10.fieldOfView = Config.StoryFieldOfView
                else
                    v10.baseCameraCFrame = v10.extractionWideCameraCFrame
                    v10.fieldOfView = Config.ExtractionWideFieldOfView
                end
                if v10.mode ~= "Lobby" then
                    local name, ready, userId
                    for j = 1, 6 do
                        v5 = v10.pendingAvatarEntries[j]
                        if v5 then
                            userId = v5.userId
                            name = v5.name
                            ready = v5.ready
                            v10:_spawnAvatar(userId, name, j, ready)
                        end
                    end
                else
                    local v13 = LocalPlayer
                    local UserId = v13.UserId
                    v5 = LocalPlayer
                    local Name = v5.Name
                    local v14 = Config
                    local LobbySeatIndex = v14.LobbySeatIndex
                    v10:_spawnAvatar(UserId, Name, LobbySeatIndex, true)
                end
                v10:_createHeliAudio(v12)
                v10:_startStoryCameraShake()
                if v10.interfaceRoot and v10.interfaceRoot.Parent then
                    v11 = TweenService
                    local interfaceRoot = v10.interfaceRoot
                    v5 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    v11:Create(interfaceRoot, v5, {BackgroundTransparency = 0.76}):Play()
                end
                if v10.mode == "Story" then
                    v10:_waitForStoryRevealReady()
                    v10:_revealStoryScene()
                elseif v10.mode ~= "Extraction" then
                    v10:_dismissArrivalCover()
                else
                    v10:_waitForExtractionAvatarReady()
                    v10:_dismissArrivalCover()
                end
                u87[v10.mode] = true
                return
            end
            v3:Destroy()
            warn("[MarauderLoading] The source model has no Heli.Body")
            u87[self.mode] = true
            self:_dismissArrivalCover()
            return
        end
        warn("[MarauderLoading] Marauder01 is missing from the template")
        u87[self.mode] = true
        self:_dismissArrivalCover()
        return
    end
    warn("[MarauderLoading] MarauderTemplate is unavailable; using the UI fallback")
    u87[self.mode] = true
    self:_dismissArrivalCover()
end

local function findMotor(p1, p2) -- Line: 1592
    local v1 = p1:FindFirstChild(p2, true)
    local v2 = v1 and v1:IsA("Motor6D") and v1 or nil
    return v2
end

local function stopIdleTrack(p1) -- Line: 1597 -- upvalues: Config (val)
    local idleTrack = p1
    if idleTrack then
        idleTrack = p1.idleTrack
    end
    if not idleTrack then
        return
    end
    pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
        local v1 = idleTrack
        local v2 = Config
        local SeatedIdleFadeTime = v2.SeatedIdleFadeTime
        v1:Stop(SeatedIdleFadeTime)
        idleTrack:Destroy()
    end)
    p1.idleTrack = nil
end

local function applyReadyTag(p1, p2) -- Line: 1609 -- upvalues: Config (val)
    local readyLabel = p1
    if readyLabel then
        readyLabel = p1.readyLabel
    end
    if readyLabel and readyLabel.Parent then
        local StoryReadyTagReadyColor, StoryReadyTagReadyText
        if not p2 then
            StoryReadyTagReadyText = Config.StoryReadyTagNotReadyText
        else
            StoryReadyTagReadyText = Config.StoryReadyTagReadyText
        end
        readyLabel.Text = StoryReadyTagReadyText
        if not p2 then
            StoryReadyTagReadyColor = Config.StoryReadyTagNotReadyColor
        else
            StoryReadyTagReadyColor = Config.StoryReadyTagReadyColor
        end
        readyLabel.TextColor3 = StoryReadyTagReadyColor
        return
    end
end

local function applyFallbackSeatedPose(p1) -- Line: 1618
    if p1.rightHip then
        p1.rightHip.C0 = p1.rightHip.C0 * CFrame.Angles(-1.361356816555577, 0, 0.06981317007977318)
    end
    if p1.leftHip then
        p1.leftHip.C0 = p1.leftHip.C0 * CFrame.Angles(-1.361356816555577, 0, -0.06981317007977318)
    end
    if p1.rightShoulder then
        p1.rightShoulder.C0 = p1.rightShoulder.C0 * CFrame.Angles(0.13962634015954636, 0, 0.12217304763960307)
    end
    if p1.leftShoulder then
        p1.leftShoulder.C0 = p1.leftShoulder.C0 * CFrame.Angles(0.13962634015954636, 0, -0.12217304763960307)
    end
    if p1.rootJoint then
        p1.rootJoint.C0 = p1.rootJoint.C0 * CFrame.Angles(-0.08726646259971647, 0, 0)
    end
end

function u81:_playSeatedIdle(p2, p3) -- Line: 1636 -- upvalues: getSeatedIdleAnimationAssets (val), Config (val)
    local v1 = getSeatedIdleAnimationAssets()
    if #v1 ~= 0 and p2.animator then
        local u13 = Random.new(((self.seatedIdleSeed or 0) + p3 * 104729) % 2147483647)
        local v2 = #v1
        local u19 = v1[self:_getSeatedIdleAssignment(p3, v2)]
        local u20 = nil
        local success, result = pcall(function() -- Line: 1646 -- upvalues: u20 (ref), p2 (val), u19 (val)
            local v1 = p2
            local animator = v1.animator
            local v2 = u19
            u20 = animator:LoadAnimation(v2)
        end)
        if success and u20 then
            local v3 = os.clock() + 2
            while not self.destroyed do
                if self.avatarGenerations[p3] ~= p2.generation
                    or not p2.model.Parent
                    or not (u20.Length <= 0)
                    or not (os.clock() < v3) then
                    break
                end
                task.wait()
            end
            if self.destroyed or self.avatarGenerations[p3] ~= p2.generation or not p2.model.Parent then
                success = false
                result = "avatar preparation was superseded"
            elseif u20.Length <= 0 then
                success = false
                result = "animation asset did not load"
            end
        end
        if success and u20 then
            local success_2, result_2 = pcall(function() -- Line: 1678 -- upvalues: u20 (ref), Config (upval), u13 (val)
                u20.Priority = Enum.AnimationPriority.Action
                u20.Looped = true
                local v1 = u20
                local v2 = Config
                local SeatedIdleFadeTime = v2.SeatedIdleFadeTime
                v1:Play(SeatedIdleFadeTime)
                v1 = u20
                local v3 = u13
                local v4 = -Config.SeatedIdleSpeedJitter
                local v5 = Config
                local SeatedIdleSpeedJitter = v5.SeatedIdleSpeedJitter
                v3 = v3:NextNumber(v4, SeatedIdleSpeedJitter)
                v2 = 1 + v3
                v1:AdjustSpeed(v2)
                v1 = u20
                local v6 = u13
                v3 = u20
                local Length = v3.Length
                v1.TimePosition = v6:NextNumber(0, Length)
            end)
            if success_2 then
                p2.idleTrack = u20
                return true
            end
            pcall(function() -- Line: 1686 -- upvalues: u20 (ref)
                u20:Stop(0)
                u20:Destroy()
            end)
            warn("[MarauderLoading] Could not play seated idle " .. u19.Name .. ": " .. tostring(result_2))
            return false
        end
        if u20 then
            u20:Destroy()
        end
        if result ~= "avatar preparation was superseded" then
            warn("[MarauderLoading] Could not load seated idle " .. u19.Name .. ": " .. tostring(result))
        end
        return false
    end
    return false
end

function u81:_getSeatedIdleAssignment(p2, p3) -- Line: 1698 -- upvalues: buildSeatedIdleAssignments (val), Config (val)
    if not self.seatedIdleAssignments or self.seatedIdleAssignmentCount ~= p3 then
        local v1 = buildSeatedIdleAssignments
        local v2 = self.seatedIdleSeed or 0
        self.seatedIdleAssignments = v1(v2, p3, #Config.PassengerSlots)
        self.seatedIdleAssignmentCount = p3
    end
    return self.seatedIdleAssignments[p2] or 1
end

function u81:_createReadyTag(p2) -- Line: 1707 -- upvalues: Config (val)
    if self.mode ~= "Story" then
        return
    end
    local model = p2.model
    local Torso = model:FindFirstChild("Torso")
    if not Torso then
        Torso = model:FindFirstChild("UpperTorso")
        if not Torso then
            Torso = model:FindFirstChild("HumanoidRootPart")
            if not Torso then
                Torso = model:FindFirstChild("Head")
                if not Torso then
                    Torso = model.PrimaryPart
                end
            end
        end
    end
    if Torso and Torso:IsA("BasePart") then
        local BillboardGui = Instance.new("BillboardGui")
        BillboardGui.Name = "MarauderLoadingReadyTag"
        BillboardGui.Adornee = Torso
        BillboardGui.AlwaysOnTop = true
        BillboardGui.LightInfluence = 0
        BillboardGui.Size = Config.StoryReadyTagSize
        BillboardGui.StudsOffsetWorldSpace = Config.StoryReadyTagStudsOffset
        BillboardGui.MaxDistance = Config.StoryReadyTagMaxDistance
        BillboardGui.Parent = Torso
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Name = "Status"
        TextLabel.Size = UDim2.fromScale(1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Font = Config.StoryReadyTagFont
        TextLabel.Text = Config.StoryReadyTagNotReadyText
        TextLabel.TextColor3 = Config.StoryReadyTagNotReadyColor
        TextLabel.TextScaled = true
        TextLabel.TextWrapped = false
        TextLabel.TextXAlignment = Enum.TextXAlignment.Center
        TextLabel.Parent = BillboardGui
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        UITextSizeConstraint.MaxTextSize = Config.StoryReadyTagMaxTextSize
        UITextSizeConstraint.Parent = TextLabel
        local UIStroke = Instance.new("UIStroke")
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
        UIStroke.Color = Config.StoryReadyTagStrokeColor
        UIStroke.Thickness = Config.StoryReadyTagStrokeThickness
        UIStroke.Parent = TextLabel
        if self.storyInterfaceFading then
            TextLabel.TextTransparency = 1
            UIStroke.Transparency = 1
        end
        p2.readyTag = BillboardGui
        p2.readyLabel = TextLabel
        p2.readyStroke = UIStroke
        local v1 = self.avatars[p2.seatIndex]
        local v2 = v1
        if v2 then
            v2 = v1.ready == true
        end
        local readyLabel = p2
        if readyLabel then
            readyLabel = p2.readyLabel
        end
        if readyLabel then
            local StoryReadyTagReadyColor, StoryReadyTagReadyText
            if not readyLabel.Parent then
                return
            end
            if not v2 then
                StoryReadyTagReadyText = Config.StoryReadyTagNotReadyText
            else
                StoryReadyTagReadyText = Config.StoryReadyTagReadyText
            end
            readyLabel.Text = StoryReadyTagReadyText
            if not v2 then
                StoryReadyTagReadyColor = Config.StoryReadyTagNotReadyColor
            else
                StoryReadyTagReadyColor = Config.StoryReadyTagReadyColor
            end
            readyLabel.TextColor3 = StoryReadyTagReadyColor
        end
        return
    end
end

function u81:_prepareSeatedAvatar(p2, p3, p4) -- Line: 1765 -- upvalues: applyFallbackSeatedPose (val)
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        HumanoidRootPart = p2.PrimaryPart
    end
    if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
        local v1, v2
        p2.PrimaryPart = HumanoidRootPart
        local v3, v4, v5, v6 = p2, self, p3, p4
        for i, v in ipairs(p2:GetDescendants()) do
            if v:IsA("LuaSourceContainer")
                or v:IsA("Tool")
                or v:IsA("Sound")
                or v:IsA("ParticleEmitter")
                or v:IsA("Trail")
                or v:IsA("Beam")
                or v:IsA("Smoke")
                or v:IsA("Fire")
                or v:IsA("Sparkles") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                v1 = v == HumanoidRootPart
                v.Anchored = v1
                v.CanCollide = false
                v.CanTouch = false
                v.CanQuery = false
                v.Massless = true
            end
        end
        local Humanoid = v3:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            Humanoid.AutoRotate = false
            Humanoid.PlatformStand = true
            Humanoid.Sit = true
            Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            pcall(function() -- Line: 1799 -- upvalues: Humanoid (val)
                Humanoid.EvaluateStateMachine = false
            end)
        end
        v3.Parent = v4.avatarFolder
        local v7 = v4.seatFrames[v5]
        v3:PivotTo(v7)
        local v8 = {}
        v8.model = v3
        if not Humanoid then
            v2 = nil
        elseif Humanoid:IsA("Humanoid") then
            local Animator = Humanoid:FindFirstChildOfClass("Animator")
            if not Animator then
                Animator = Instance.new("Animator")
                Animator.Parent = Humanoid
            end
            v2 = Animator
        else
            v2 = nil
        end
        v8.animator = v2
        v7 = v3:FindFirstChild("Right Hip", true)
        v2 = v7 and v7:IsA("Motor6D") and v7 or nil
        v8.rightHip = v2
        v7 = v3:FindFirstChild("Left Hip", true)
        v2 = v7 and v7:IsA("Motor6D") and v7 or nil
        v8.leftHip = v2
        v7 = v3:FindFirstChild("Right Shoulder", true)
        v2 = v7 and v7:IsA("Motor6D") and v7 or nil
        v8.rightShoulder = v2
        v7 = v3:FindFirstChild("Left Shoulder", true)
        v2 = v7 and v7:IsA("Motor6D") and v7 or nil
        v8.leftShoulder = v2
        local RootJoint = v3:FindFirstChild("RootJoint", true)
        v2 = RootJoint and RootJoint:IsA("Motor6D") and RootJoint or nil
        v8.rootJoint = v2
        local Neck = v3:FindFirstChild("Neck", true)
        v2 = Neck and Neck:IsA("Motor6D") and Neck or nil
        v8.neck = v2
        v8.seatIndex = v5
        v8.generation = v6
        v4:_createReadyTag(v8)
        v8.animated = v4:_playSeatedIdle(v8, v5)
        if not v8.animated and not v4.destroyed and v4.avatarGenerations[v5] == v6 and v3.Parent then
            applyFallbackSeatedPose(v8)
        end
        return v8
    end
    p2:Destroy()
    return nil
end

function u81:_setAvatarReady(p2, p3) -- Line: 1831 -- upvalues: Config (val)
    local v1 = self.avatars[p2]
    if v1 and v1.model then
        v1.ready = p3
        local readyLabel = v1
        if readyLabel then
            readyLabel = v1.readyLabel
        end
        if readyLabel then
            local StoryReadyTagReadyColor, StoryReadyTagReadyText
            if not readyLabel.Parent then
                return
            end
            if not p3 then
                StoryReadyTagReadyText = Config.StoryReadyTagNotReadyText
            else
                StoryReadyTagReadyText = Config.StoryReadyTagReadyText
            end
            readyLabel.Text = StoryReadyTagReadyText
            if not p3 then
                StoryReadyTagReadyColor = Config.StoryReadyTagNotReadyColor
            else
                StoryReadyTagReadyColor = Config.StoryReadyTagReadyColor
            end
            readyLabel.TextColor3 = StoryReadyTagReadyColor
        end
        return
    end
    if v1 then
        v1.ready = p3
    end
    local v2 = self.pendingAvatarEntries[p2]
    if v2 then
        v2.ready = p3
    end
end

function u81:_spawnAvatar(p2, p3, p4, p5) -- Line: 1847 -- upvalues: Config (val), AvatarProvider (val)
    if self.destroyed then
        return
    end
    local u9 = tonumber(p2) or 0
    if self.seatFrames and self.avatarFolder then
        local v1
        self.pendingAvatarEntries[p4] = nil
        local v2 = self.avatars[p4]
        if v2 and v2.userId == u9 then
            v1 = p5 == true
            self:_setAvatarReady(p4, v1)
            return
        end
        if v2 and v2.model then
            local idleTrack = v2
            if idleTrack then
                idleTrack = v2.idleTrack
            end
            if idleTrack then
                pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
                    local v1 = idleTrack
                    local v2 = Config
                    local SeatedIdleFadeTime = v2.SeatedIdleFadeTime
                    v1:Stop(SeatedIdleFadeTime)
                    idleTrack:Destroy()
                end)
                v2.idleTrack = nil
            end
            v2.model:Destroy()
        end
        local u52 = (self.avatarGenerations[p4] or 0) + 1
        self.avatarGenerations[p4] = u52
        local avatars = self.avatars
        local v3 = {loading = true}
        v1 = p5 == true
        v3.ready = v1
        v3.userId = u9
        avatars[p4] = v3
        task.spawn(function() -- Line: 1877
            -- upvalues: AvatarProvider (upval), u9 (val), self (val), p4 (val), u52 (val), p3 (val), Config (upval)
            -- upvalues: p5 (val)
            local v1 = AvatarProvider.GetR6Clone(u9)
            if not v1 then
                v1 = AvatarProvider.GetFallbackR6Clone()
            end
            if not v1 and self.placeholderFallback then
                v1 = self.placeholderFallback:Clone()
            end
            if not self.destroyed then
                local v2 = self.avatarGenerations[p4]
                if v2 == u52 then
                    if not v1 then
                        if self.avatarGenerations[p4] == u52 then
                            self.avatars[p4] = nil
                        end
                        return
                    end
                    local v3 = p3 or "Passenger"
                    v1.Name = v3 .. "Avatar"
                    v2 = self
                    local v4 = p4
                    local v5 = u52
                    v2 = v2:_prepareSeatedAvatar(v1, v4, v5)
                    if not v2 then
                        if self.avatarGenerations[p4] == u52 then
                            self.avatars[p4] = nil
                        end
                        return
                    end
                    if not self.destroyed then
                        v3 = self.avatarGenerations[p4]
                        if v3 == u52 then
                            local ready
                            v3 = self.avatars[p4]
                            if not v3 then
                                ready = p5 == true
                            else
                                ready = v3.ready
                                if not ready then
                                    ready = p5 == true
                                end
                            end
                            v2.userId = u9
                            self.avatars[p4] = v2
                            v4 = self
                            local v6 = p4
                            v4:_setAvatarReady(v6, ready)
                            return
                        end
                    end
                    local idleTrack = v2
                    if idleTrack then
                        idleTrack = v2.idleTrack
                    end
                    if idleTrack then
                        pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
                            local v1 = idleTrack
                            local v2 = Config
                            local SeatedIdleFadeTime = v2.SeatedIdleFadeTime
                            v1:Stop(SeatedIdleFadeTime)
                            idleTrack:Destroy()
                        end)
                        v2.idleTrack = nil
                    end
                    v2.model:Destroy()
                    return
                end
            end
            if v1 then
                v1:Destroy()
            end
        end)
        return
    end
    local pendingAvatarEntries = self.pendingAvatarEntries
    local v4 = {userId = u9, name = p3}
    local v5 = p5 == true
    v4.ready = v5
    pendingAvatarEntries[p4] = v4
end

function u81:_updateParallaxInput(p2) -- Line: 1918 -- upvalues: Workspace (val)
    if self.mode ~= "Lobby" then
        return
    end
    if p2.UserInputType.Name:find("Gamepad") and p2.KeyCode == Enum.KeyCode.Thumbstick2 then
        self.gamepadParallax = Vector2.new(p2.Position.X, -p2.Position.Y)
        return
    end
    if p2.UserInputType == Enum.UserInputType.Touch and self.activeTouch == p2 then
        local ViewportSize
        local CurrentCamera = Workspace.CurrentCamera
        if not CurrentCamera then
            ViewportSize = Vector2.new(1280, 720)
        else
            ViewportSize = CurrentCamera.ViewportSize
            if not ViewportSize then
                ViewportSize = Vector2.new(1280, 720)
            end
        end
        local v1 = p2.Position - self.touchStart
        local new = Vector2.new
        local X = v1.X
        local v2 = ViewportSize.X * 0.3
        local v3 = X / math.max(v2, 1)
        local Y = v1.Y
        local v4 = ViewportSize.Y * 0.3
        self.touchParallax = new(v3, Y / math.max(v4, 1))
    end
end

function u81:_acceptsContinueInput(p2, p3) -- Line: 1932
    if self.awaitingContinue and not (os.clock() < (self.continueArmedAt or (1 / 0))) then
        local UserInputType = p2.UserInputType
        if UserInputType ~= Enum.UserInputType.Touch
            and UserInputType ~= Enum.UserInputType.MouseButton1
            and UserInputType ~= Enum.UserInputType.MouseButton2
            and UserInputType ~= Enum.UserInputType.MouseButton3 then
            local v1
            if p3 then
                return false
            end
            if UserInputType == Enum.UserInputType.Keyboard then
                v1 = p2.KeyCode ~= Enum.KeyCode.Unknown
                return v1
            end
            if string.find(UserInputType.Name, "Gamepad", 1, true) ~= 1 then
                return false
            end
            v1 = false
            if p2.KeyCode ~= Enum.KeyCode.Unknown then
                v1 = false
                if p2.KeyCode ~= Enum.KeyCode.Thumbstick1 then
                    v1 = p2.KeyCode ~= Enum.KeyCode.Thumbstick2
                end
            end
            return v1
        end
        return true
    end
    return false
end

function u81:_bindInput() -- Line: 1960 -- upvalues: UserInputService (val)
    local v1 = UserInputService
    local InputBegan = v1.InputBegan
    self:_connect(InputBegan, function(p1, p2) -- Line: 1961 -- upvalues: self (val)
        if self:_acceptsContinueInput(p1, p2) then
            self.continueRequested = true
            self.awaitingContinue = false
            return
        end
        if p2 then
            return
        end
        if p1.UserInputType == Enum.UserInputType.Touch and not self.activeTouch then
            self.activeTouch = p1
            self.touchStart = p1.Position
            self.touchParallax = Vector2.zero
        end
    end)
    v1 = UserInputService
    local InputChanged = v1.InputChanged
    self:_connect(InputChanged, function(p1) -- Line: 1976 -- upvalues: self (val)
        self:_updateParallaxInput(p1)
    end)
    v1 = UserInputService
    local InputEnded = v1.InputEnded
    self:_connect(InputEnded, function(p1) -- Line: 1979 -- upvalues: self (val)
        if p1 == self.activeTouch then
            self.activeTouch = nil
            self.touchParallax = Vector2.zero
            return
        end
        if p1.KeyCode == Enum.KeyCode.Thumbstick2 then
            self.gamepadParallax = Vector2.zero
        end
    end)
end

function u81:_getParallaxTarget() -- Line: 1989 -- upvalues: UserInputService (val), Workspace (val)
    local ViewportSize, v1
    if self.mode ~= "Lobby" then
        return Vector2.zero
    end
    if self.activeTouch then
        local new = Vector2.new
        local X = self.touchParallax.X
        v1 = math.clamp(X, -1, 1)
        local Y = self.touchParallax.Y
        return new(v1, (math.clamp(Y, -1, 1)))
    end
    if 0.05 < self.gamepadParallax.Magnitude then
        local new_2 = Vector2.new
        local X_2 = self.gamepadParallax.X
        v1 = math.clamp(X_2, -1, 1)
        local Y_2 = self.gamepadParallax.Y
        return new_2(v1, (math.clamp(Y_2, -1, 1)))
    end
    if not UserInputService.MouseEnabled then
        return Vector2.zero
    end
    local CurrentCamera = Workspace.CurrentCamera
    if not CurrentCamera then
        ViewportSize = Vector2.new(1280, 720)
    else
        ViewportSize = CurrentCamera.ViewportSize
        if not ViewportSize then
            ViewportSize = Vector2.new(1280, 720)
        end
    end
    local v2 = ViewportSize * 0.5
    local MouseLocation = UserInputService:GetMouseLocation()
    local new_3 = Vector2.new
    local v3 = MouseLocation.X - v2.X
    local X_3 = v2.X
    local v4 = v3 / math.max(X_3, 1)
    local v5 = math.clamp(v4, -1, 1)
    local v6 = MouseLocation.Y - v2.Y
    local Y_3 = v2.Y
    v3 = v6 / math.max(Y_3, 1)
    return new_3(v5, (math.clamp(v3, -1, 1)))
end

function u81:_render(p2) -- Line: 2012
    -- upvalues: TweenService (val), Config (val), formatIntegerWithCommas (val), Workspace (val)
    -- upvalues: UserInputService (val)
    local Angles_2, Angles_3, neck, rootJoint, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13
    if self.destroyed then
        return
    end
    local v14 = os.clock()
    local v15 = v14 - self.startedAt
    local cameraMove = self.cameraMove
    if cameraMove then
        v11 = v14 - cameraMove.startedAt
        local duration = cameraMove.duration
        v10 = v11 / (math.max(duration, 0.001))
        v12 = tonumber(v10) or 0
        local v16 = math.clamp(v12, 0, 1)
        v10 = TweenService
        v13 = Config
        local ExtractionCameraMoveEasing = v13.ExtractionCameraMoveEasing
        v1 = Config
        local ExtractionCameraMoveDirection = v1.ExtractionCameraMoveDirection
        local Value = v10:GetValue(v16, ExtractionCameraMoveEasing, ExtractionCameraMoveDirection)
        local fromCFrame = cameraMove.fromCFrame
        local toCFrame = cameraMove.toCFrame
        self.baseCameraCFrame = fromCFrame:Lerp(toCFrame, Value)
        self.fieldOfView = cameraMove.fromFieldOfView + (cameraMove.toFieldOfView - cameraMove.fromFieldOfView) * Value
        if 1 <= v16 then
            self.cameraMove = nil
        end
    end
    local countUpState = self.countUpState
    if countUpState then
        local target
        v12 = v14 - countUpState.startedAt
        local duration_2 = countUpState.duration
        v11 = v12 / (math.max(duration_2, 0.001))
        v13 = tonumber(v11) or 0
        v10 = math.clamp(v13, 0, 1)
        if not (1 <= v10) then
            v12 = countUpState.target * v10
            target = math.floor(v12)
        else
            target = countUpState.target
        end
        local commendationValue = self.commendationValue
        local id = countUpState.id
        local v17 = tonumber(target)
        v5 = math.round(v17 or 0)
        v3 = math.max(0, v5)
        v4 = formatIntegerWithCommas(v3)
        if id ~= "DEADEYE" then
            v1 = v4
        else
            v1 = v4 .. "%"
        end
        commendationValue:set(v1)
    end
    if self.mode == "Lobby" and not self.lobbyReady then
        v11 = Config
        local LobbyProgressCap = v11.LobbyProgressCap
        v2 = -v15
        v3 = Config
        v1 = v2 / v3.LobbyProgressTimeConstant
        v10 = LobbyProgressCap * (1 - math.exp(v1))
        self.progressValue:set(v10)
    end
    v11 = (self:_getParallaxTarget() - self.parallax) * Config.ParallaxSpring
    self.parallaxVelocity = self.parallaxVelocity + v11 * p2
    local parallaxVelocity = self.parallaxVelocity
    v4 = Config
    v3 = -v4.ParallaxDamping
    v2 = v3 * p2
    self.parallaxVelocity = parallaxVelocity * math.exp(v2)
    self.parallax = self.parallax + self.parallaxVelocity * p2
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera and self.baseCameraCFrame then
        v3 = v14 * 0.47
        v1 = (math.sin(v3)) * Config.CameraBobPosition.X
        v4 = v14 * 0.82
        v2 = (math.sin(v4)) * Config.CameraBobPosition.Y
        v5 = v14 * 0.36 + 1.2
        v4 = math.sin(v5)
        v5 = Config
        v3 = v4 * v5.CameraBobPosition.Z
        v13 = Vector3.new(v1, v2, v3)
        v4 = v14 * 0.61
        v2 = (math.sin(v4)) * Config.CameraBobRotation.X
        v5 = v14 * 0.43 + 0.8
        v3 = (math.sin(v5)) * Config.CameraBobRotation.Y
        local v18 = v14 * 0.73 + 1.7
        v5 = math.sin(v18)
        v18 = Config
        v4 = v5 * v18.CameraBobRotation.Z
        v1 = Vector3.new(v2, v3, v4)
        v2 = CFrame.Angles(-self.parallax.Y * Config.ParallaxPitch, -self.parallax.X * Config.ParallaxYaw, 0)
        v4 = CFrame.new(v13)
        v3 = v4 * CFrame.Angles(v1.X, v1.Y, v1.Z)
        if not self.cameraShaker then
            v4 = CFrame.new()
        else
            v4 = self.cameraShaker:Update(p2)
            if not v4 then
                v4 = CFrame.new()
            end
        end
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.CameraSubject = nil
        CurrentCamera.FieldOfView = self.fieldOfView
        CurrentCamera.CFrame = self.baseCameraCFrame * v2 * v3 * v4
    end
    for k, v in pairs(self.avatars) do
        if v.animated ~= true and v.model and v.model.Parent then
            v5 = v14 * 1.15 + k * 0.73
            if v.rootJoint then
                rootJoint = v.rootJoint
                v6 = CFrame.new(0, math.sin(v5) * 0.012, 0)
                Angles_2 = CFrame.Angles
                v9 = v5 * 0.7
                rootJoint.Transform = v6 * Angles_2(math.sin(v9) * 0.006108652381980153, 0, 0)
            end
            if v.neck then
                neck = v.neck
                Angles_3 = CFrame.Angles
                v7 = v5 * 0.55
                v6 = math.sin(v7) * 0.007853981633974483
                v8 = v5 * 0.37
                neck.Transform = Angles_3(v6, math.sin(v8) * 0.005235987755982988, 0)
            end
        end
    end
    UserInputService.MouseIconEnabled = false
end

function u81:_startTipRotation() -- Line: 2085 -- upvalues: Config (val)
    local v1, v2
    local u4 = table.clone(Config.Tips)
    local new = Random.new
    local v3 = os.clock()
    local v4 = v3 * 1000
    local v5 = new(math.floor(v4) % 2147483647)
    for i = #u4, 2, -1 do
        v3 = v5:NextInteger(1, i)
        v1 = u4[v3]
        v2 = u4[i]
        u4[i] = v1
        u4[v3] = v2
    end
    self.shuffledTips = u4
    self.tipIndex = 1
    local statusText = self.statusText
    v4 = u4[1]
    statusText:set(v4)
    task.spawn(function() -- Line: 2095 -- upvalues: self (val), Config (upval), u4 (val)
        local statusText, v1, v2, v3, v4
        while not self.destroyed do
            task.wait(Config.TipInterval)
            if self.destroyed then
                break
            end
            self.tipIndex = self.tipIndex % #u4 + 1
            if not self.lobbyStatusOverride then
                v1 = self
                statusText = v1.statusText
                v3 = u4
                v4 = self
                v2 = v3[v4.tipIndex]
                statusText:set(v2)
            end
        end
    end)
end

function u81:SetLobbyStatus(p2) -- Line: 2109 -- upvalues: Config (val)
    if self.mode == "Lobby" and not self.destroyed then
        self.lobbyStatusOverride = p2
        if p2 and p2 ~= "" then
            self.statusText:set(p2)
            return
        end
        self.lobbyStatusOverride = nil
        local shuffledTips = self.shuffledTips
        if not shuffledTips then
            shuffledTips = Config.Tips
        end
        local statusText = self.statusText
        local v1 = shuffledTips[((self.tipIndex or 1) - 1) % #shuffledTips + 1]
        statusText:set(v1)
        return
    end
end

function u81:_trackStoryPlayer(p2, p3) -- Line: 2123 -- upvalues: Players (val)
    if not self.storyFolders[p2] and not self.destroyed then
        local Attribute = p2:GetAttribute("RosterIndex")
        local v1 = (tonumber(Attribute)) or p3
        local v2 = math.floor(v1)
        local u20 = math.clamp(v2, 1, 6)
        local u21 = {userId = 0, identityGeneration = 0, ready = false}
        u21.index = u20
        self.storyFolders[p2] = u21
        local u23 = nil

        local function updateReady() -- Line: 2138 -- upvalues: self (val), p2 (val), u21 (val), u23 (ref), u20 (ref)
            local v1 = self.storyFolders[p2]
            if v1 ~= u21 then
                return
            end
            if not u23 then
                v1 = false
            else
                v1 = true
                if u23.Value ~= true then
                    v1 = false
                end
            end
            if v1 and not u21.ready then
                self:_playStorySound("playerReady")
            end
            u21.ready = v1
            local v2 = self
            local v3 = u20
            v2:_setAvatarReady(v3, v1)
            self:_updateStoryStatus()
        end

        local u25 = nil

        local function bindReady(p1) -- Line: 2151
            -- upvalues: self (val), p2 (val), u21 (val), u25 (ref), u23 (ref), updateReady (val)
            if not self.destroyed then
                local v1 = self.storyFolders[p2]
                if v1 == u21 and p1 and p1:IsA("BoolValue") then
                    if u25 then
                        u25:Disconnect()
                        u25 = nil
                    end
                    u23 = p1
                    v1 = self
                    local v2 = u23
                    local Changed = v2.Changed
                    local v3 = updateReady
                    v1:_connect(Changed, v3)
                    updateReady()
                    return true
                end
            end
            return false
        end

        if not bindReady(p2:FindFirstChild("Ready")) then
            local ChildAdded = p2.ChildAdded
            local v3 = self:_connect(ChildAdded, function(p1) -- Line: 2165 -- upvalues: bindReady (val)
                if p1.Name == "Ready" then
                    bindReady(p1)
                end
            end)
        end
        updateReady()

        local function loadIdentity() -- Line: 2173
            -- upvalues: u21 (val), p2 (val), Players (upval), self (val), u20 (ref), u23 (ref)
            local v1 = u21
            v1.identityGeneration = v1.identityGeneration + 1
            local identityGeneration = u21.identityGeneration
            local Attribute = p2:GetAttribute("UserId")
            local v2 = tonumber(Attribute) or 0
            if v2 <= 0 then
                local success, result = pcall(Players.GetUserIdFromNameAsync, Players, p2.Name)
                if success then
                    v2 = result
                end
            end
            if not self.destroyed then
                local v3 = self.storyFolders[p2]
                if v3 == u21 and u21.identityGeneration == identityGeneration then
                    u21.userId = v2
                    v3 = self
                    local Name = p2.Name
                    local v4 = u20
                    local v5 = u23
                    if v5 then
                        v5 = u23.Value == true
                    end
                    v3:_spawnAvatar(v2, Name, v4, v5)
                    return
                end
            end
        end

        task.spawn(loadIdentity)
        local AttributeChangedSignal = p2:GetAttributeChangedSignal("UserId")
        self:_connect(AttributeChangedSignal, function() -- Line: 2190 -- upvalues: loadIdentity (val)
            task.spawn(loadIdentity)
        end)
        return
    end
end

function u81:_updateStoryStatus() -- Line: 2195 -- upvalues: Config (val)
    if self.mode == "Story" and not self.destroyed and self.loadingStatus then
        local Ready, v1, v2, v3
        local Attribute = self.loadingStatus:GetAttribute("ExpectedPlayers")
        local v4 = tonumber(Attribute) or 0
        local v5 = 0
        local v6 = 0
        for k in pairs(self.storyFolders) do
            if k.Parent then
                v6 = v6 + 1
                Ready = k:FindFirstChild("Ready")
                if Ready and Ready.Value then
                    v5 = v5 + 1
                end
            end
        end
        v4 = math.max(v4, v6, 1)
        local Attribute_2 = self.loadingStatus:GetAttribute("Stage")
        local Attribute_3 = self.loadingStatus:GetAttribute("Countdown")
        local v7 = tonumber(Attribute_3) or -1
        if Attribute_2 == "Waiting" then
            v2 = false
            if v4 <= v5 then
                v2 = v4 <= v6
            end
        else
            v2 = false
            if Attribute_2 == "Countdown" then
                v2 = false
                if v4 <= v5 then
                    v2 = v4 <= v6
                end
            end
        end
        if v2 and not self.storyAllReady then
            self:_playStorySound("allReady")
        end
        self.storyAllReady = v2
        if Attribute_2 == "Countdown" and 0 <= v7 then
            local statusText = self.statusText
            v3 = Config
            local StoryCountdownLabel = v3.StoryCountdownLabel
            statusText:set(StoryCountdownLabel)
            local countText = self.countText
            local v8 = math.floor(v7)
            v1 = math.max(0, v8)
            v3 = tostring(v1)
            countText:set(v3)
            self.progressValue:set(1)
            if v7 ~= self.lastCountdown then
                self.lastCountdown = v7
                if not (v7 <= 3) or not (1 <= v7) then
                    if v7 <= 0 and self.countdownFinalBeep then
                        self.countdownFinalBeep:Play()
                    end
                elseif self.countdownBeep then
                    self.countdownBeep:Play()
                elseif v7 <= 0 and self.countdownFinalBeep then
                    self.countdownFinalBeep:Play()
                end
            end
            if not (v7 <= Config.StoryUIFadeLeadCount) then
                return
            end
            self:_startStoryDepartureFade()
            return
        end
        if not (v5 < v4) then
            local statusText_3 = self.statusText
            v3 = Config
            local StoryReadyLabel = v3.StoryReadyLabel
            statusText_3:set(StoryReadyLabel)
            local countText_3 = self.countText
            v3 = string.format("%d / %d", v5, v4)
            countText_3:set(v3)
            local progressValue_2 = self.progressValue
            v3 = Config
            local StoryReadyProgress_2 = v3.StoryReadyProgress
            progressValue_2:set(StoryReadyProgress_2)
            return
        end
        local statusText_2 = self.statusText
        v3 = Config
        local StoryLoadingLabel = v3.StoryLoadingLabel
        statusText_2:set(StoryLoadingLabel)
        local countText_2 = self.countText
        v3 = string.format("%d / %d", v5, v4)
        countText_2:set(v3)
        local progressValue = self.progressValue
        v1 = v5 / v4
        local v9 = Config
        local StoryReadyProgress = v9.StoryReadyProgress
        v3 = math.min(v1, StoryReadyProgress)
        progressValue:set(v3)
        return
    end
end

function u81:_waitExtraction(p2) -- Line: 2247 -- upvalues: RunService (val)
    local v1 = os.clock()
    local v2 = tonumber(p2) or 0
    local v3 = v1 + math.max(v2, 0)
    while not self.destroyed do
        if not (os.clock() < v3) then
            break
        end
        RunService.Heartbeat:Wait()
    end
    return not self.destroyed
end

function u81:_playExtractionTween(p2, p3, p4) -- Line: 2255 -- upvalues: TweenService (val)
    if not self.destroyed and p2 and p2.Parent then
        local v1 = TweenService:Create(p2, p3, p4)
        local activeExtractionTweens = self.activeExtractionTweens
        if not activeExtractionTweens then
            activeExtractionTweens = {}
        end
        self.activeExtractionTweens = activeExtractionTweens
        local activeExtractionTweens_2 = self.activeExtractionTweens
        table.insert(activeExtractionTweens_2, v1)
        v1:Play()
        local Time = p3.Time
        local v2 = self:_waitExtraction(Time)
        if not v2 then
            v1:Cancel()
        end
        v1:Destroy()
        local v3 = table.find(self.activeExtractionTweens, v1)
        if v3 then
            table.remove(self.activeExtractionTweens, v3)
        end
        return v2
    end
    return false
end

function u81:_playExtractionTweens(p2, p3) -- Line: 2275 -- upvalues: TweenService (val)
    local activeExtractionTweens_2, instance, properties, v1, v2
    if self.destroyed then
        return false
    end
    local v3 = {}
    local activeExtractionTweens = self.activeExtractionTweens
    if not activeExtractionTweens then
        activeExtractionTweens = {}
    end
    self.activeExtractionTweens = activeExtractionTweens
    for i, v in ipairs(p2) do
        instance = v.instance
        if instance and instance.Parent then
            v1 = TweenService
            properties = v.properties
            v1 = v1:Create(instance, p3, properties)
            table.insert(v3, v1)
            activeExtractionTweens_2 = self.activeExtractionTweens
            table.insert(activeExtractionTweens_2, v1)
            continue
        end
        for i2, i3 in ipairs(v3) do
            i3:Destroy()
            v2 = table.find(self.activeExtractionTweens, i3)
            if v2 then
                table.remove(self.activeExtractionTweens, v2)
            end
        end
        return false
    end
    for i4, j in ipairs(v3) do
        j:Play()
    end
    local Time = p3.Time
    local v4 = self:_waitExtraction(Time)
    for i5, k in ipairs(v3) do
        if not v4 then
            k:Cancel()
        end
        k:Destroy()
        v1 = table.find(v5.activeExtractionTweens, k)
        if v1 then
            table.remove(v5.activeExtractionTweens, v1)
        end
    end
    return v4
end

function u81:_flashCommendationValue() -- Line: 2314 -- upvalues: Theme (val), Config (val)
    local commendationValueLabel = self.commendationValueLabel
    local commendationValueScale = self.commendationValueScale
    if commendationValueLabel
        and commendationValueLabel.Parent
        and commendationValueScale
        and commendationValueScale.Parent then
        commendationValueLabel.TextColor3 = Theme.Menu.AccentCyan
        commendationValueScale.Scale = 1
        local v1 = {}
        local v2 = {
            instance = commendationValueScale,
            properties = {Scale = Config.ExtractionValueFlashScale},
        }
        local v3 = {instance = commendationValueLabel}
        local v4 = {TextColor3 = Config.ExtractionValueFlashColor}
        v3.properties = v4
        v1[1] = v2
        v1[2] = v3
        local new = TweenInfo.new
        v3 = Config
        v2 = new(v3.ExtractionValueFlashInTime, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local v5 = self:_playExtractionTweens(v1, v2)
        if v5 then
            v2 = Config
            local ExtractionValueFlashHoldTime = v2.ExtractionValueFlashHoldTime
            v5 = self:_waitExtraction(ExtractionValueFlashHoldTime)
        end
        if v5 then
            v2 = {}
            v4 = {
                instance = commendationValueLabel,
                properties = {TextColor3 = Theme.Menu.AccentCyan},
            }
            v2[1] = {
                instance = commendationValueScale,
                properties = {Scale = 1},
            }
            v2[2] = v4
            local new_2 = TweenInfo.new
            v4 = Config
            v3 = new_2(v4.ExtractionValueFlashOutTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            v5 = self:_playExtractionTweens(v2, v3)
        end
        commendationValueScale.Scale = 1
        commendationValueLabel.TextColor3 = Theme.Menu.AccentCyan
        return v5
    end
    return not self.destroyed
end

function u81:_focusSeat(p2, p3) -- Line: 2352 -- upvalues: Config (val)
    local v1 = self:_getSpotlightCFrame(p2)
    if not v1 then
        return false
    end
    local ExtractionCameraMoveTime = tonumber(p3)
    if not ExtractionCameraMoveTime then
        ExtractionCameraMoveTime = Config.ExtractionCameraMoveTime
    end
    local v2 = math.max(ExtractionCameraMoveTime, 0)
    local v3 = {
        startedAt = os.clock(),
        duration = v2,
        fromCFrame = self.baseCameraCFrame,
        toCFrame = v1,
        fromFieldOfView = self.fieldOfView,
        toFieldOfView = Config.ExtractionSpotlightFieldOfView,
    }
    self.cameraMove = v3
    self:_playExtractionSound("hydraulic")
    return self:_waitExtraction(v2)
end

function u81:_playCommendation(p2, p3) -- Line: 2370
    -- upvalues: resolveCommendationName (val), formatIntegerWithCommas (val), Theme (val), Config (val)
    -- upvalues: TweenService (val)
    local commendationCard = self.commendationCard
    local commendationNameLabel = self.commendationNameLabel
    local commendationTitleLabel = self.commendationTitleLabel
    local commendationDescriptorLabel = self.commendationDescriptorLabel
    local commendationValueLabel = self.commendationValueLabel
    if commendationCard
        and commendationNameLabel
        and commendationTitleLabel
        and commendationDescriptorLabel
        and commendationValueLabel then
        local ExtractionSecondsPerPlayer, v1, v2, v3, v4, v5, v6, value
        local v7 = os.clock()
        local commendationName = self.commendationName
        local v8 = resolveCommendationName
        v8 = v8(p2)
        commendationName:set(v8)
        local commendationTitle = self.commendationTitle
        local title = p2.title
        commendationTitle:set(title)
        local commendationDescriptor = self.commendationDescriptor
        local descriptor = p2.descriptor
        commendationDescriptor:set(descriptor)
        local commendationValue = self.commendationValue
        if not p2.valueIsNumeric then
            value = p2.value
            v8 = tostring(value)
        else
            local id = p2.id
            v5 = tonumber(0)
            v4 = math.round(v5 or 0)
            v3 = math.max(0, v4)
            local v9 = formatIntegerWithCommas(v3)
            if id ~= "DEADEYE" then
                v8 = v9
            else
                v8 = v9 .. "%"
            end
            if not v8 then
                value = p2.value
                v8 = tostring(value)
            end
        end
        commendationValue:set(v8)
        commendationCard.GroupTransparency = 0
        commendationNameLabel.TextTransparency = 1
        commendationNameLabel.Position = UDim2.new(0, 0, 0, 8)
        commendationTitleLabel.TextTransparency = 1
        commendationTitleLabel.Position = UDim2.new(0, 0, 0, 38)
        commendationDescriptorLabel.TextTransparency = 1
        commendationValueLabel.TextTransparency = 1
        commendationValueLabel.TextColor3 = Theme.Menu.AccentCyan
        if self.commendationValueScale then
            self.commendationValueScale.Scale = 1
        end
        self:_playExtractionSound("hit")
        local v10 = TweenInfo.new(Config.ExtractionNameFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v3 = {TextTransparency = 0, Position = UDim2.new(0, 0, 0, 0)}
        if not self:_playExtractionTween(commendationNameLabel, v10, v3) then
            return false
        end
        self:_playExtractionSound("whoosh")
        v10 = TweenInfo.new(Config.ExtractionTitleFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v3 = {TextTransparency = 0, Position = UDim2.new(0, 0, 0, 30)}
        if not self:_playExtractionTween(commendationTitleLabel, v10, v3) then
            return false
        end
        v8 = Config
        local ExtractionDescriptorDelay = v8.ExtractionDescriptorDelay
        if not self:_waitExtraction(ExtractionDescriptorDelay) then
            return false
        end
        v10 = TweenInfo.new(Config.ExtractionDescriptorFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        if not self:_playExtractionTween(commendationDescriptorLabel, v10, {TextTransparency = 0.04}) then
            return false
        end
        local v11 = TweenService
        v10 = TweenInfo.new(Config.ExtractionDescriptorFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v11 = v11:Create(commendationValueLabel, v10, {TextTransparency = 0})
        local activeExtractionTweens = self.activeExtractionTweens
        table.insert(activeExtractionTweens, v11)
        v11:Play()
        if not p2.valueIsNumeric then
            v10 = Config
            local ExtractionDescriptorFadeTime = v10.ExtractionDescriptorFadeTime
            if not self:_waitExtraction(ExtractionDescriptorFadeTime) then
                v11:Cancel()
                v11:Destroy()
                return false
            end
            v1, v6 = self, p3
            v11:Destroy()
            v2 = table.find(v1.activeExtractionTweens, v11)
            if v2 then
                table.remove(v1.activeExtractionTweens, v2)
            end
            ExtractionSecondsPerPlayer = tonumber(v6)
            if not ExtractionSecondsPerPlayer then
                ExtractionSecondsPerPlayer = Config.ExtractionSecondsPerPlayer
            end
            v10 = ExtractionSecondsPerPlayer - (os.clock() - v7) - Config.ExtractionCardExitTime
            v8 = math.max(v10, 0)
            if not v1:_waitExtraction(v8) then
                return false
            end
            v4 = TweenInfo.new(Config.ExtractionCardExitTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            return v1:_playExtractionTween(commendationCard, v4, {GroupTransparency = 1})
        end
        local countUpDuration = p2.countUpDuration
        local ExtractionValueCountUpTime = tonumber(countUpDuration)
        if not ExtractionValueCountUpTime then
            ExtractionValueCountUpTime = Config.ExtractionValueCountUpTime
        end
        v10 = Config
        local ExtractionValueMinimumCountUpTime = v10.ExtractionValueMinimumCountUpTime
        v2 = math.max(ExtractionValueCountUpTime, ExtractionValueMinimumCountUpTime)
        v8 = {id = p2.id}
        local value_2 = p2.value
        v3 = tonumber(value_2) or 0
        v8.target = math.max(v3, 0)
        v8.startedAt = os.clock()
        v8.duration = v2
        self.countUpState = v8
        self:_playExtractionSound("count")
        if not self:_waitExtraction(v2) then
            self.countUpState = nil
            self:_stopExtractionSound("count")
            v11:Cancel()
            v11:Destroy()
            return false
        end
        local commendationValue_2 = self.commendationValue
        local id_2 = p2.id
        local value_3 = p2.value
        local v12 = tonumber(value_3)
        local v13 = math.round(v12 or 0)
        local v14 = math.max(0, v13)
        v5 = formatIntegerWithCommas(v14)
        if id_2 ~= "DEADEYE" then
            v3 = v5
        else
            v3 = v5 .. "%"
        end
        commendationValue_2:set(v3)
        self.countUpState = nil
        self:_stopExtractionSound("count")
        self:_playExtractionSound("finish")
        if not self:_flashCommendationValue() then
            v11:Cancel()
            v11:Destroy()
            return false
        end
        v1, v6 = self, p3
        v11:Destroy()
        v2 = table.find(v1.activeExtractionTweens, v11)
        if v2 then
            table.remove(v1.activeExtractionTweens, v2)
        end
        ExtractionSecondsPerPlayer = tonumber(v6)
        if not ExtractionSecondsPerPlayer then
            ExtractionSecondsPerPlayer = Config.ExtractionSecondsPerPlayer
        end
        v10 = ExtractionSecondsPerPlayer - (os.clock() - v7) - Config.ExtractionCardExitTime
        v8 = math.max(v10, 0)
        if not v1:_waitExtraction(v8) then
            return false
        end
        v4 = TweenInfo.new(Config.ExtractionCardExitTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        return v1:_playExtractionTween(commendationCard, v4, {GroupTransparency = 1})
    end
    return false
end

function u81:_runExtraction(p2) -- Line: 2494 -- upvalues: Config (val)
    if self.mode == "Extraction" and not self.destroyed then
        if self.baseCameraCFrame and self.extractionWideCameraCFrame then
            local ExtractionCameraMoveTime, presentationSeconds, seatIndex, v1, v2, v3, v4, v5, v6
            if self.extractionCover then
                local extractionCover = self.extractionCover
                v4 = TweenInfo.new(Config.ExtractionCoverFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                self:_playExtractionTween(extractionCover, v4, {BackgroundTransparency = 1})
            end
            local v7 = Config
            local ExtractionIntroHold = v7.ExtractionIntroHold
            if not self:_waitExtraction(ExtractionIntroHold) then
                return
            end
            local secondsPerPlayer = p2.secondsPerPlayer
            local ExtractionSecondsPerPlayer = tonumber(secondsPerPlayer)
            if not ExtractionSecondsPerPlayer then
                ExtractionSecondsPerPlayer = Config.ExtractionSecondsPerPlayer
            end
            local v8 = math.max(ExtractionSecondsPerPlayer, 1)
            local v9 = ipairs
            local entries = p2.entries
            if not entries then
                entries = {}
            end
            for i, v in v9(entries) do
                if self.destroyed then
                    break
                end
                presentationSeconds = v.presentationSeconds
                v6 = tonumber(presentationSeconds) or v8
                v5 = math.max(v6, 1)
                v1 = Config
                ExtractionCameraMoveTime = v1.ExtractionCameraMoveTime
                v6 = math.min(ExtractionCameraMoveTime, v5)
                seatIndex = v.seatIndex
                if not self:_focusSeat(seatIndex, v6) then
                    break
                end
                v3 = v5 - v6
                v2 = math.max(v3, 0)
                if not self:_playCommendation(v, v2) then
                    break
                end
            end
            self.countUpState = nil
            self:_stopExtractionSound("count")
            if self.commendationCard then
                self.commendationCard.GroupTransparency = 1
            end
            v9 = {
                startedAt = os.clock(),
                duration = Config.ExtractionCameraMoveTime,
                fromCFrame = self.baseCameraCFrame,
                toCFrame = self.extractionWideCameraCFrame,
                fromFieldOfView = self.fieldOfView,
                toFieldOfView = Config.ExtractionWideFieldOfView,
            }
            self.cameraMove = v9
            v4 = Config
            local ExtractionCameraMoveTime_2 = v4.ExtractionCameraMoveTime
            self:_waitExtraction(ExtractionCameraMoveTime_2)
            v4 = Config
            local ExtractionOutroHold = v4.ExtractionOutroHold
            self:_waitExtraction(ExtractionOutroHold)
            self:_startStoryDepartureFade()
            if self.extractionCover and self.extractionCover.Parent then
                local extractionCover_2 = self.extractionCover
                local v10 = TweenInfo.new(Config.ExtractionCoverFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                self:_playExtractionTween(extractionCover_2, v10, {BackgroundTransparency = 0})
            end
            if self.destroyed then
                return
            end
            self.extractionAwaitingServerStop = true
            local delay = task.delay
            local v11 = Config
            local ExtractionServerStopWatchdog = v11.ExtractionServerStopWatchdog
            v4 = tonumber(ExtractionServerStopWatchdog) or 0
            delay(math.max(v4, 0), function() -- Line: 2558 -- upvalues: self (val)
                if not self.destroyed and self.extractionAwaitingServerStop then
                    warn("[MarauderLoading] Extraction server stop watchdog elapsed; restoring the presentation state")
                    self:Destroy("ExtractionStopWatchdog")
                    return
                end
            end)
            return
        end
        self:Destroy("ExtractionSceneUnavailable")
        return
    end
end

function u81:_watchStory(p2) -- Line: 2567
    -- upvalues: Workspace (val), Config (val), getEffectsSoundGroup (val), SoundService (val)
    local AttributeChangedSignal
    self.loadingStatus = p2
    task.spawn(function() -- Line: 2569 -- upvalues: Workspace (upval), self (val)
        local Values = Workspace:WaitForChild("Values", 30)
        local LoadingFinished = Values
        if LoadingFinished then
            LoadingFinished = Values:WaitForChild("LoadingFinished", 30)
        end
        if LoadingFinished and not self.destroyed then
            if LoadingFinished.Value then
                self:Destroy("StoryComplete")
                return
            end
            local v1 = self
            local PropertyChangedSignal = LoadingFinished:GetPropertyChangedSignal("Value")
            v1:_connect(PropertyChangedSignal, function() -- Line: 2578 -- upvalues: LoadingFinished (val), self (upval)
                if LoadingFinished.Value then
                    self:Destroy("StoryComplete")
                end
            end)
            return
        end
    end)
    self.countdownBeep = Instance.new("Sound")
    self.countdownBeep.Name = "MarauderCountdownBeep"
    self.countdownBeep.SoundId = Config.CountdownBeep
    self.countdownBeep.Volume = 0.65
    local countdownBeep = self.countdownBeep
    countdownBeep.SoundGroup = getEffectsSoundGroup()
    self.countdownBeep.Parent = SoundService
    self.countdownFinalBeep = Instance.new("Sound")
    self.countdownFinalBeep.Name = "MarauderCountdownFinalBeep"
    self.countdownFinalBeep.SoundId = Config.CountdownFinalBeep
    self.countdownFinalBeep.Volume = 0.7
    local countdownFinalBeep = self.countdownFinalBeep
    countdownFinalBeep.SoundGroup = getEffectsSoundGroup()
    self.countdownFinalBeep.Parent = SoundService
    local Players = p2:WaitForChild("Players", 10)
    if not Players then
        warn("[MarauderLoading] LoadingStatus.Players is missing")
        return
    end
    local Children = Players:GetChildren()
    table.sort(Children, function(p1, p2) -- Line: 2604
        local v1
        local Attribute = p1:GetAttribute("RosterIndex")
        local v2 = tonumber(Attribute) or (1 / 0)
        local Attribute_2 = p2:GetAttribute("RosterIndex")
        local v3 = tonumber(Attribute_2) or (1 / 0)
        if v2 == v3 then
            v1 = p1.Name < p2.Name
            return v1
        end
        v1 = v2 < v3
        return v1
    end)
    for i, v in ipairs(Children) do
        self:_trackStoryPlayer(v, i)
    end
    local ChildAdded = Players.ChildAdded
    self:_connect(ChildAdded, function(p1) -- Line: 2615 -- upvalues: self (val), Players (val)
        local v1 = self
        local v2 = #(Players:GetChildren())
        v1:_trackStoryPlayer(p1, v2)
        self:_updateStoryStatus()
    end)
    local ChildRemoved = Players.ChildRemoved
    self:_connect(ChildRemoved, function(p1) -- Line: 2619 -- upvalues: self (val)
        self.storyFolders[p1] = nil
        self:_updateStoryStatus()
    end)
    local v1 = ipairs
    local v2 = {"ExpectedPlayers", "Stage", "Countdown"}
    for i2, i3 in v1(v2) do
        AttributeChangedSignal = p2:GetAttributeChangedSignal(i3)
        self:_connect(AttributeChangedSignal, function() -- Line: 2624 -- upvalues: self (val)
            self:_updateStoryStatus()
        end)
    end
    self:_updateStoryStatus()
end

function u81:_startRenderLoop() -- Line: 2631 -- upvalues: RunService (val)
    self.renderStepName = "MarauderLoading_" .. self.mode
    local v1 = RunService
    local renderStepName = self.renderStepName
    local v2 = Enum.RenderPriority.Camera.Value + 10
    v1:BindToRenderStep(renderStepName, v2, function(p1) -- Line: 2633 -- upvalues: self (val)
        self:_render(p1)
    end)
end

function u81:_markPresented() -- Line: 2638 -- upvalues: u85 (val)
    if self.destroyed then
        return
    end
    u85[self.mode] = true
    self.presented = true
end

function u81:_crossfadeToMenu(p2) -- Line: 2646 -- upvalues: TweenService (val), Config (val)
    local v1, v2
    local music = self.music
    if p2 and p2:IsA("Sound") then
        if music and p2.SoundId == music.SoundId and 0 < music.TimePosition then
            pcall(function() -- Line: 2650 -- upvalues: p2 (val), music (val)
                p2.TimePosition = music.TimePosition
            end)
        end
        if not p2.IsPlaying then
            p2:Play()
        end
        v1 = TweenService
        v2 = TweenInfo.new(1.2, Enum.EasingStyle.Linear)
        local v3 = {Volume = Config.MenuAmbienceVolume}
        v1:Create(p2, v2, v3):Play()
    end
    if music then
        v1 = TweenService
        v2 = TweenInfo.new(1.2, Enum.EasingStyle.Linear)
        v1:Create(music, v2, {Volume = 0}):Play()
    end
    return music
end

function u81.MarkLobbyReady(p1, p2) -- Line: 2667
    -- upvalues: Config (val), UserInputService (val), LocalPlayer (val), TweenService (val), u86 (val)
    if p1.mode == "Lobby" and not p1.destroyed and not p1.lobbyReady then
        p1.lobbyReady = true
        task.spawn(function() -- Line: 2672
            -- upvalues: Config (upval), p1 (val), UserInputService (upval), LocalPlayer (upval), TweenService (upval)
            -- upvalues: p2 (val), u86 (upval)
            local ContinuePromptMobile
            local v1 = Config.MinimumLobbyDuration - (os.clock() - p1.startedAt)
            if 0 < v1 then
                task.wait(v1)
            end
            if p1.destroyed then
                return
            end
            p1.progressValue:set(1)
            task.wait(0.42)
            if p1.destroyed then
                return
            end
            p1.continueRequested = false
            p1.awaitingContinue = true
            p1.continueArmedAt = os.clock() + Config.ContinueInputDelay
            if not UserInputService.TouchEnabled then
                ContinuePromptMobile = Config.ContinuePrompt
            else
                ContinuePromptMobile = Config.ContinuePromptMobile
            end
            p1:SetLobbyStatus(ContinuePromptMobile)
            repeat
                task.wait()
            until p1.continueRequested or p1.destroyed
            if p1.destroyed then
                return
            end
            p1.awaitingContinue = false
            local ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "MarauderLoadingTransition"
            ScreenGui.DisplayOrder = 10002
            ScreenGui.IgnoreGuiInset = true
            ScreenGui.ScreenInsets = Enum.ScreenInsets.None
            ScreenGui.ResetOnSpawn = false
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.fromScale(1, 1)
            Frame.BackgroundColor3 = Color3.new(0, 0, 0)
            Frame.BackgroundTransparency = 1
            Frame.BorderSizePixel = 0
            Frame.Parent = ScreenGui
            ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
            local v2 = TweenService
            local v3 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v2 = v2:Create(Frame, v3, {BackgroundTransparency = 0})
            v2:Play()
            v2.Completed:Wait()
            p1:Destroy("LobbyComplete", true)
            local v4 = p1
            v3 = p2
            local u112 = v4:_crossfadeToMenu(v3)
            local v5 = TweenService
            local v6 = TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v5 = v5:Create(Frame, v6, {BackgroundTransparency = 1})
            v5:Play()
            v5.Completed:Wait()
            ScreenGui:Destroy()
            u86[p1.mode] = true
            if u112 then
                task.delay(0.5, function() -- Line: 2730 -- upvalues: u112 (val)
                    u112:Destroy()
                end)
            end
        end)
        return
    end
end

function u81:Destroy(p2, p3) -- Line: 2737
    -- upvalues: u86 (val), RunService (val), Config (val), u83 (val), u84 (ref), u78 (val)
    local v1
    if self.destroyed then
        return
    end
    self.destroyed = true
    self.extractionAwaitingServerStop = false
    if p2 ~= "LobbyComplete" then
        u86[self.mode] = true
    end
    if self.renderStepName then
        v1 = RunService
        local renderStepName = self.renderStepName
        v1:UnbindFromRenderStep(renderStepName)
    end
    if self.cameraShake then
        pcall(function() -- Line: 2750 -- upvalues: self (val), Config (upval)
            local v1 = self
            local cameraShake = v1.cameraShake
            local v2 = Config
            local FadeOut = v2.StoryCameraShake.FadeOut
            cameraShake:StartFadeOut(FadeOut)
        end)
    end
    if self.cameraShaker then
        self.cameraShaker:Stop()
    end
    self.cameraShake = nil
    self.cameraShaker = nil
    for k, v in pairs(self.avatars) do
        local idleTrack = v
        if idleTrack then
            idleTrack = v.idleTrack
        end
        if idleTrack then
            pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
                local v1 = idleTrack
                local v2 = Config
                local SeatedIdleFadeTime = v2.SeatedIdleFadeTime
                v1:Stop(SeatedIdleFadeTime)
                idleTrack:Destroy()
            end)
            v.idleTrack = nil
        end
    end
    v1 = ipairs
    local heliSounds = self.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    for i, i2 in v1(heliSounds) do
        i2:Stop()
        i2:Destroy()
    end
    table.clear(self.heliSounds)
    table.clear(self.heliSoundVolumes)
    self.countUpState = nil
    self.cameraMove = nil
    v1 = ipairs
    local activeExtractionTweens = self.activeExtractionTweens
    if not activeExtractionTweens then
        activeExtractionTweens = {}
    end
    for i3, j in v1(activeExtractionTweens) do
        pcall(function() -- Line: 2771 -- upvalues: j (val)
            j:Cancel()
            j:Destroy()
        end)
    end
    table.clear(self.activeExtractionTweens)
    v1 = pairs
    local extractionSounds = self.extractionSounds
    if not extractionSounds then
        extractionSounds = {}
    end
    for k2, k3 in v1(extractionSounds) do
        k3:Stop()
        k3:Destroy()
    end
    table.clear(self.extractionSounds)
    v1 = pairs
    local storySounds = self.storySounds
    if not storySounds then
        storySounds = {}
    end
    for k4, n in v1(storySounds) do
        n:Stop()
        n:Destroy()
    end
    table.clear(self.storySounds)
    self:_dismissArrivalCover()
    for i4, m in ipairs(self.connections) do
        m:Disconnect()
    end
    table.clear(self.connections)
    if self.scope then
        self.scope:doCleanup()
    end
    if self.scene then
        self.scene:Destroy()
    end
    if self.placeholderFallback then
        self.placeholderFallback:Destroy()
    end
    if self.countdownBeep then
        self.countdownBeep:Destroy()
    end
    if self.countdownFinalBeep then
        self.countdownFinalBeep:Destroy()
    end
    if self.music and not v2 then
        self.music:Destroy()
    end
    self:_restorePresentationState(v3)
    if u83[self.mode] == self then
        u83[self.mode] = nil
        v1 = next(u83) ~= nil
        if u84 ~= v1 then
            u84 = v1
            local v4 = u78
            local PresentingChanged = v4.PresentingChanged
            local v5 = u84
            PresentingChanged:Fire(v5)
        end
    end
end

local function newSession(p1, p2) -- Line: 2817
    -- upvalues: u81 (val), u85 (val), u86 (val), u87 (val), u83 (val), u84 (ref), u78 (val)
    local v1 = {
        storyAllReady = false,
        mode = p1,
        startedAt = os.clock(),
        connections = {},
        avatars = {},
        avatarGenerations = {},
        pendingAvatarEntries = {},
        extractionAvatarSeats = {},
        storyFolders = {},
        storySounds = {},
        heliSounds = {},
        heliSoundVolumes = {},
        extractionSounds = {},
        activeExtractionTweens = {},
        suppressedScreenGuis = {},
    }
    local v2 = (os.clock()) * 1000000
    v1.seatedIdleSeed = math.floor(v2) % 2147483647
    v1.parallax = Vector2.zero
    v1.parallaxVelocity = Vector2.zero
    v1.gamepadParallax = Vector2.zero
    v1.touchParallax = Vector2.zero
    local v3 = u81
    local u29 = setmetatable(v1, v3)
    if p1 == "Extraction" and type(p2) == "table" then
        local pendingAvatarEntries, seatIndex, userId, v4, v5, v6, v7
        v1 = ipairs
        local entries = p2.entries
        if not entries then
            entries = {}
        end
        for i, v in v1(entries) do
            seatIndex = v.seatIndex
            v5 = tonumber(seatIndex)
            v7 = math.floor(v5 or 1)
            v6 = math.clamp(v7, 1, 6)
            u29.extractionAvatarSeats[v6] = true
            pendingAvatarEntries = u29.pendingAvatarEntries
            v4 = {ready = true}
            userId = v.userId
            v4.userId = tonumber(userId) or 0
            v4.name = v.name
            pendingAvatarEntries[v6] = v4
        end
    end
    u85[p1] = false
    u86[p1] = false
    u87[p1] = false
    u83[p1] = u29
    v1 = next(u83) ~= nil
    if u84 ~= v1 then
        u84 = v1
        v3 = u78
        local PresentingChanged = v3.PresentingChanged
        v2 = u84
        PresentingChanged:Fire(v2)
    end
    local success, result = xpcall(function() -- Line: 2856 -- upvalues: u29 (val), p1 (val), p2 (val), u87 (upval)
        u29:_capturePresentationState()
        u29:_suppressLobbyScreenGuis()
        u29:_createInterface()
        u29:_createMusic()
        u29:_createStorySounds()
        u29:_createExtractionSounds()
        u29:_startRenderLoop()
        if p1 == "Lobby" then
            u29:_bindInput()
            u29:_startTipRotation()
        end
        u29:_markPresented()
        if p1 == "Story" then
            task.spawn(function() -- Line: 2870 -- upvalues: u29 (upval), p2 (upval)
                local success, result = xpcall(function() -- Line: 2871 -- upvalues: u29 (upval), p2 (upval)
                    local v1 = u29
                    local v2 = p2
                    v1:_watchStory(v2)
                end, debug.traceback)
                if not success and not u29.destroyed then
                    warn("[MarauderLoading] Story status binding failed:\n" .. tostring(result))
                end
            end)
        end
        task.spawn(function() -- Line: 2879 -- upvalues: u29 (upval), p1 (upval), p2 (upval), u87 (upval)
            local success, result = xpcall(function() -- Line: 2880 -- upvalues: u29 (upval), p1 (upval), p2 (upval)
                u29:_prepareScene()
                if p1 == "Extraction" and not u29.destroyed then
                    local v1 = u29
                    local v2 = p2
                    v1:_runExtraction(v2)
                end
            end, debug.traceback)
            if not success then
                warn("[MarauderLoading] 3D presentation failed; keeping the UI fallback:\n" .. tostring(result))
                u87[p1] = true
                u29:_dismissArrivalCover()
                if p1 == "Extraction" then
                    u29:Destroy("ExtractionError")
                end
            end
        end)
    end, debug.traceback)
    if not success then
        u29:Destroy("InitializationFailed")
        error(result, 0)
    end
    return u29
end

function u78.ShowArrivalCover() -- Line: 2903 -- upvalues: showArrivalCover (val)
    return (showArrivalCover())
end

function u78.DismissArrivalCover(p1) -- Line: 2907 -- upvalues: dismissArrivalCover (val)
    dismissArrivalCover(p1)
end

function u78.StartLobby() -- Line: 2911 -- upvalues: u83 (val), newSession (val)
    local Lobby = u83.Lobby
    if not Lobby then
        Lobby = newSession("Lobby")
    end
    return Lobby
end

function u78.StartStory(p1) -- Line: 2915 -- upvalues: u83 (val), newSession (val)
    local Story = u83.Story
    if not Story then
        Story = newSession("Story", p1)
    end
    return Story
end

function u78.StartExtraction(p1) -- Line: 2919 -- upvalues: u83 (val), newSession (val)
    local Story = u83.Story
    if Story then
        Story:Destroy("ExtractionStarted")
    end
    local Extraction = u83.Extraction
    if Extraction then
        Extraction:Destroy("ExtractionRestarted")
    end
    return (newSession("Extraction", p1))
end

function u78.StopExtraction(p1) -- Line: 2931 -- upvalues: u83 (val)
    local Extraction = u83.Extraction
    if Extraction then
        Extraction:Destroy(p1 or "ExtractionStopped")
    end
end

function u78.GetActive(p1) -- Line: 2938 -- upvalues: u83 (val)
    return u83[p1]
end

function u78.IsPresenting() -- Line: 2942 -- upvalues: u84 (ref)
    return u84
end

function u78.WaitUntilPresented(p1, p2) -- Line: 2946 -- upvalues: u85 (val)
    local v1
    local v2 = os.clock() + (tonumber(p2) or 15)
    while not u85[p1] do
        task.wait(0.05)
        if v2 <= os.clock() then
            v1 = u85[p1] == true
            return v1
        end
    end
    return true
end

function u78.WaitUntilSceneReady(p1, p2) -- Line: 2957 -- upvalues: u87 (val)
    local v1
    local v2 = os.clock() + (tonumber(p2) or 15)
    while not u87[p1] do
        task.wait(0.05)
        if v2 <= os.clock() then
            v1 = u87[p1] == true
            return v1
        end
    end
    return true
end

function u78.WaitUntilDismissed(p1) -- Line: 2968 -- upvalues: u86 (val)
    while u86[p1] == false do
        task.wait(0.05)
    end
    return true
end

return u78