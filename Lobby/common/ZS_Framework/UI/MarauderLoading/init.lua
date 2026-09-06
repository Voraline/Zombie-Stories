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
local u78 = {PresentingChanged = Signal.new()}
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
        u78.PresentingChanged:Fire(u84)
    end
end
local u95 = {
    Enum.CoreGuiType.Backpack,
    Enum.CoreGuiType.Chat,
    Enum.CoreGuiType.EmotesMenu,
    Enum.CoreGuiType.Health,
    Enum.CoreGuiType.PlayerList,
}
local u101 = {ControlHints = true, Menu = true, StaminaUI = true}
local u102 = {TouchGui = true}
local u103 = {MarauderLoadingScreen = true, MarauderLoadingSafeArea = true, MarauderLoadingExtractionCover = true, ZSTeleportCard = true}
local function getCameraShaker() -- Line: 70 -- upvalues: u92 (ref)
    if u92 then
        return u92
    end
    local Modules = script.Parent.Parent:WaitForChild("Modules")
    local Controllers = Modules:WaitForChild("Controllers")
    local CameraController = Controllers:WaitForChild("CameraController")
    local CameraUtils = CameraController:WaitForChild("CameraUtils")
    u92 = require(CameraUtils:WaitForChild("CameraShaker"))
    return u92
end
local function getWeaponController() -- Line: 85 -- upvalues: u93 (ref)
    local v1, v2, v3
    if u93 ~= nil then
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
    v1, v2 = pcall(function() -- Line: 90
        local Modules = script.Parent.Parent:WaitForChild("Modules")
        local Controllers = Modules:WaitForChild("Controllers")
        return require(Controllers:WaitForChild("WeaponController"))
    end)
    if not v1 then
        v3 = false
    else
        v3 = v2
    end
    u93 = v3
    if u93 == false then
        v3 = nil
    else
        v3 = u93
        if not v3 then
            v3 = nil
        end
    end
    return v3
end
local function getSeatedIdleAnimationAssets() -- Line: 99 -- upvalues: u88 (ref), Config (val)
    local Animation
    if u88 then
        return u88
    end
    u88 = {}
    for i, v in ipairs(Config.SeatedIdleAnimations) do
        if type(v) == "string" and v ~= "" then
            Animation = Instance.new("Animation")
            Animation.Name = "MarauderSeatedIdle" .. tostring(i)
            Animation.AnimationId = v
            table.insert(u88, Animation)
        end
    end
    return u88
end
local function buildSeatedIdleAssignments(p1, p2, p3) -- Line: 118
    local v1, v2, v3, v4, v5
    local v6 = Random.new(p1)
    local v7 = table.create(p3)
    local v8 = {}
    local v9 = p3
    local v10 = 1
    local v11 = p2
    for i = 1, v9, v10 do
        if #v8 == 0 then
            v5 = v11
            v1 = 1
            for j = 1, v5, v1 do
                v8[j] = j
            end
            v5 = 2
            v1 = -1
            for k = v11, v5, v1 do
                v3 = v6:NextInteger(1, k)
                v4 = v8[k]
                v8[k] = v8[v3]
                v8[v3] = v4
            end
            if 1 < i and 1 < v11 and v8[v11] == v7[i - 1] then
                v2 = v8[v11]
                v8[v11] = v8[v11 - 1]
                v8[v11 - 1] = v2
            end
        end
        v7[i] = table.remove(v8)
    end
    return v7
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
    local Sound
    if u90 then
        return u90
    end
    u90 = {}
    local v1 = {
        Config.ExtractionCardHitSoundId,
        Config.ExtractionCardWhooshSoundId,
        Config.ExtractionCameraMoveSoundId,
        Config.ExtractionCountUpLoopSoundId,
        Config.ExtractionCountUpFinishSoundId,
    }
    for i, v in ipairs(v1) do
        if type(v) == "string" and v ~= "" then
            Sound = Instance.new("Sound")
            Sound.Name = "MarauderExtractionPreload" .. tostring(i)
            Sound.SoundId = v
            table.insert(u90, Sound)
        end
    end
    return u90
end
local function getAnimator(p1) -- Line: 183
    if not p1 or not (p1:IsA("Humanoid")) then
        return nil
    end
    local Animator = p1:FindFirstChildOfClass("Animator")
    if not Animator then
        Animator = Instance.new("Animator")
        Animator.Parent = p1
    end
    return Animator
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
    if not u1 then
        return
    else
        if u1.dismissing then
            return
        end
        u1.dismissing = true
        local ArrivalFadeOutTime = tonumber(p1)
        if not ArrivalFadeOutTime then
            ArrivalFadeOutTime = Config.ArrivalFadeOutTime
        end
        local v1 = math.max(ArrivalFadeOutTime, 0)
        if v1 <= 0 then
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
        else
            local cover
            if u1.cover and u1.cover.Parent then
                cover = u1.cover
                local v2 = TweenInfo.new(v1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                u1.tween = TweenService:Create(cover, v2, {BackgroundTransparency = 1})
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
        end
    end
end
local function showArrivalCover() -- Line: 235 -- upvalues: u91 (ref), LocalPlayer (val), Config (val), dismissArrivalCover (val)
    if not u91 then
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
        local u56 = {gui = ScreenGui, cover = Frame}
        u91 = u56
        task.delay(Config.ArrivalFadeMaxHold, function() -- Line: 266 -- upvalues: u91 (upval), u56 (val), dismissArrivalCover (upval), Config (upval)
            if u91 == u56 then
                warn("[MarauderLoading] Arrival cover watchdog elapsed; revealing with available assets")
                dismissArrivalCover(Config.ArrivalFadeOutTime)
            end
        end)
        return ScreenGui
    elseif u91.gui and u91.gui.Parent then
        return u91.gui
    end
end
local function clamp01(p1) -- Line: 275
    local v1 = tonumber(p1) or 0
    return (math.clamp(v1, 0, 1))
end
local function isCabinMode(p1) -- Line: 279
    local v1 = if p1.mode ~= "Story" then p1.mode == "Extraction" else true
    return v1
end
local function formatIntegerWithCommas(p1) -- Line: 283
    local v1 = string.reverse((tostring(p1)))
    local v2 = string.gsub(v1, "(%d%d%d)", "%1,")
    local v3 = string.reverse(v2)
    return (string.gsub(v3, "^,", ""))
end
local function formatCommendationValue(p1, p2) -- Line: 291 -- upvalues: formatIntegerWithCommas (val)
    local v1 = math.max(0, (math.round(tonumber(p2) or 0)))
    local v2 = formatIntegerWithCommas(v1)
    if p1 == "DEADEYE" then
        return v2 .. "%"
    end
    return v2
end
local function resolveCommendationName(p1) -- Line: 300 -- upvalues: Players (val)
    local name = p1.name
    if type(name) ~= "string" then
        local DisplayName
        local PlayerByUserId = Players:GetPlayerByUserId(tonumber(p1.userId) or 0)
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
    elseif string.match(name, "%S") then
        return name
    end
end
local function addTextConstraint(p1, p2, p3) -- Line: 314
    local v1 = p1:New("UITextSizeConstraint")
    return v1({MinTextSize = p2, MaxTextSize = p3})
end
local function getWorldCFrame(p1) -- Line: 326
    local v1, v2, v3
    if not p1 then
        return nil
    end
    if p1:IsA("BasePart") then
        return p1.CFrame
    end
    if not (p1:IsA("Model")) then
        return nil
    end
    v1, v2 = pcall(p1.GetPivot, p1)
    if not v1 then
        v3 = nil
    else
        v3 = v2
        if not v3 then
            v3 = nil
        end
    end
    return v3
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
    local CFrame, v1, v2, v3, v4
    local v5 = nil
    local v6 = (-1 / 0)
    for i, v in ipairs(p1:GetDescendants()) do
        if v:IsA("BasePart") then
            v3 = string.lower(v.Name)
            v4 = 0
            if v3 == "door2" then
                v4 = 100
            elseif string.find(v3, "interiordoor", 1, true) then
                v4 = 90
            elseif string.find(v3, "doorway", 1, true) then
                v4 = 75
            elseif string.find(v3, "door", 1, true) then
                v4 = 50
            end
            if 0 < v4 and v6 < v4 then
                if not v then
                    CFrame = nil
                elseif v:IsA("BasePart") then
                    CFrame = v.CFrame
                elseif not (v:IsA("Model")) then
                    CFrame = nil
                else
                    v1, v2 = pcall(v.GetPivot, v)
                    if not v1 then
                        CFrame = nil
                    else
                        CFrame = v2
                    end
                end
                if CFrame then
                    v5 = v
                    v6 = v4
                end
            end
        elseif not (v:IsA("Model")) then
        end
    end
    return v5
end
local function createGradient(p1, p2, p3) -- Line: 381
    local v1 = p1:New("UIGradient")
    local v2 = {Rotation = 90}
    local v3 = {}
    local v4 = NumberSequenceKeypoint.new(0, p2)
    v3[1] = v4
    v3[2] = NumberSequenceKeypoint.new(1, p3)
    v2.Transparency = NumberSequence.new(v3)
    return v1(v2)
end
local function getMusicSoundGroup() -- Line: 391 -- upvalues: SoundService (val)
    local v1
    local Primary = SoundService:FindFirstChild("Primary")
    local Music = Primary
    if Music then
        Music = Primary:FindFirstChild("Music")
    end
    if not Music then
        v1 = nil
    elseif not (Music:IsA("SoundGroup")) then
        v1 = nil
    else
        v1 = Music
        if not v1 then
            v1 = nil
        end
    end
    return v1
end
local function getEffectsSoundGroup() -- Line: 397 -- upvalues: SoundService (val)
    local v1
    local Primary = SoundService:FindFirstChild("Primary")
    if not Primary then
        return nil
    end
    local v2 = {"Interface", "SFX", "Effects"}
    for i, v in ipairs(v2) do
        v1 = Primary:FindFirstChild(v)
        if v1 and v1:IsA("SoundGroup") then
            return v1
        end
    end
    return nil
end
function u81:_connect(p2, p3) -- Line: 411
    local v1 = p2:Connect(p3)
    table.insert(self.connections, v1)
    return v1
end
function u81:_capturePresentationState() -- Line: 417 -- upvalues: Workspace (val), UserInputService (val), u95 (val), StarterGui (val), u93 (ref)
    local v1, v2, v3, v4
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        self.cameraState = {cameraType = CurrentCamera.CameraType, cameraSubject = CurrentCamera.CameraSubject, cframe = CurrentCamera.CFrame, fieldOfView = CurrentCamera.FieldOfView}
    end
    self.mouseState = {iconEnabled = UserInputService.MouseIconEnabled, behavior = UserInputService.MouseBehavior}
    UserInputService.MouseIconEnabled = false
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    self.coreGuiState = {}
    for i, v in ipairs(u95) do
        v3, v4 = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, v)
        if v3 then
            self.coreGuiState[v] = v4
            pcall(StarterGui.SetCoreGuiEnabled, StarterGui, v, false)
        end
    end
    v1, v2 = pcall(StarterGui.GetCore, StarterGui, "TopbarEnabled")
    if v1 then
        self.topbarEnabled = v2
        pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", false)
    end
    if self.mode == "Extraction" then
        local v5
        self.weaponsSuppressed = true
        if u93 == nil then
            local v6, v7
            v6, v7 = pcall(function() -- Line: 90
                local Modules = script.Parent.Parent:WaitForChild("Modules")
                local Controllers = Modules:WaitForChild("Controllers")
                return require(Controllers:WaitForChild("WeaponController"))
            end)
            if not v6 then
                v3 = false
            else
                v3 = v7
            end
            u93 = v3
            if u93 == false then
                v5 = nil
            else
                v5 = u93
                if not v5 then
                    v5 = nil
                end
            end
        elseif u93 == false then
            v5 = nil
        else
            v5 = u93
            if not v5 then
                v5 = nil
            end
        end
        if v5 then
            pcall(v5.SetWeaponsEnabled, v5, false)
        end
    end
end
function u81:_suppressLobbyScreenGuis() -- Line: 458 -- upvalues: LocalPlayer (val), u102 (val), u103 (val), u101 (val)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local function suppress(p1) -- Line: 460 -- upvalues: self (val), u102 (upval), u103 (upval), u101 (upval)
        if not (p1:IsA("ScreenGui")) or self.suppressedScreenGuis[p1] ~= nil or p1.Name == "SettingsGui" then
            return
        end
        local v1 = true
        if u102[p1.Name] ~= true then
            if self.mode ~= "Extraction" then
                v1 = if self.mode == "Lobby" then u101[p1.Name] == true else false
            else
                v1 = not u103[p1.Name]
            end
        end
        if not v1 then
            return
        end
        self.suppressedScreenGuis[p1] = p1.Enabled
        p1.Enabled = false
        local PropertyChangedSignal = p1:GetPropertyChangedSignal("Enabled")
        self:_connect(PropertyChangedSignal, function() -- Line: 479 -- upvalues: self (upval), p1 (val)
            if not self.destroyed and p1.Parent and p1.Enabled then
                p1.Enabled = false
            end
        end)
    end
    for i, v in ipairs(PlayerGui:GetChildren()) do
        suppress(v)
    end
    self:_connect(PlayerGui.ChildAdded, suppress)
end
function u81:_restoreSuppressedScreenGuis() -- Line: 492
    local suppressedScreenGuis = self.suppressedScreenGuis
    if not suppressedScreenGuis then
        suppressedScreenGuis = {}
    end
    for k, v in pairs(suppressedScreenGuis) do
        if k.Parent then
            k.Enabled = v
        end
    end
    table.clear(self.suppressedScreenGuis)
end
function u81:_restorePresentationState(p2) -- Line: 501 -- upvalues: StarterGui (val), UserInputService (val), Workspace (val), LocalPlayer (val), u93 (ref)
    local v1, v2
    self:_restoreSuppressedScreenGuis()
    local coreGuiState = self.coreGuiState
    if not coreGuiState then
        coreGuiState = {}
    end
    local v3 = self
    for k, v in pairs(coreGuiState) do
        v2 = if v3.mode ~= "Story" then v3.mode == "Extraction" else true
        if v2 then
            if k == Enum.CoreGuiType.Backpack then
                v = false
            elseif k ~= Enum.CoreGuiType.PlayerList and k ~= Enum.CoreGuiType.EmotesMenu then
            end
        end
        pcall(StarterGui.SetCoreGuiEnabled, StarterGui, k, v)
    end
    if v3.topbarEnabled ~= nil then
        pcall(StarterGui.SetCore, StarterGui, "TopbarEnabled", v3.topbarEnabled)
    end
    local v4 = if v1 ~= "ExtractionComplete" then v1 == "ServerStop" else true
    if v1 == "LobbyComplete" then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    elseif not v4 then
        local mouseState = v3.mouseState
        if mouseState then
            UserInputService.MouseBehavior = mouseState.behavior
            UserInputService.MouseIconEnabled = mouseState.iconEnabled
        end
    end
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera then
        local cameraState = v3.cameraState
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
            end
        end
        CurrentCamera.CameraSubject = cameraSubject
        if cameraState and cameraState.fieldOfView then
            CurrentCamera.FieldOfView = cameraState.fieldOfView
        end
        if v1 ~= "LobbyComplete" and not v4 and cameraState and cameraState.cframe then
            CurrentCamera.CFrame = cameraState.cframe
        end
    end
    if v3.weaponsSuppressed then
        v3.weaponsSuppressed = nil
        if not v4 then
            task.spawn(function() -- Line: 551 -- upvalues: u93 (upval)
                local v1
                if u93 == nil then
                    local v2, v3, v4
                    v2, v3 = pcall(function() -- Line: 90
                        local Modules = script.Parent.Parent:WaitForChild("Modules")
                        local Controllers = Modules:WaitForChild("Controllers")
                        return require(Controllers:WaitForChild("WeaponController"))
                    end)
                    if not v2 then
                        v4 = false
                    else
                        v4 = v3
                    end
                    u93 = v4
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
function u81:_createInterface() -- Line: 561 -- upvalues: Fusion (val), Config (val), createGradient (val), Theme (val), addTextConstraint (val), LocalPlayer (val)
    local StoryLoadingLabel, v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = Fusion.scoped(Fusion)
    self.scope = v9
    self.progressValue = v9:Value(0)
    if self.mode ~= "Lobby" then
        StoryLoadingLabel = Config.StoryLoadingLabel
    else
        StoryLoadingLabel = "PREPARING TRANSPORT"
    end
    self.statusText = v9:Value(StoryLoadingLabel)
    if self.mode ~= "Story" then
        v7 = nil
    else
        v7 = v9:Value("0 / 1")
    end
    self.countText = v7
    if self.mode == "Extraction" then
        self.commendationName = v9:Value("")
        self.commendationTitle = v9:Value("")
        self.commendationDescriptor = v9:Value("")
        self.commendationValue = v9:Value("")
    end
    local u54 = v9:Spring(self.progressValue, 18, 1)
    local v10 = {}
    local v11 = v9:New("Frame")
    local v12 = {
        Name = "TopVignette",
        Size = UDim2.fromScale(1, 0.32),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
    }
    local v13 = {createGradient(v9, 0.18, 1)}
    v12[v9.Children] = v13
    v11 = v11(v12)
    v12 = v9:New("Frame")
    local v14 = {
        Name = "BottomVignette",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.fromScale(0, 1),
        Size = UDim2.fromScale(1, 0.42),
        BackgroundColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
    }
    local v15 = {createGradient(v9, 1, 0.12)}
    v14[v9.Children] = v15
    v10[1] = v11
    v10[2] = v12(v14)
    if self.mode == "Extraction" then
        v11 = v9:New("Frame")
        self.extractionCover = v11({
            Name = "ExtractionCover",
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = 30,
            Size = UDim2.fromScale(1, 1),
            BackgroundColor3 = Color3.new(0, 0, 0),
        })
    end
    v11 = {}
    if self.mode == "Lobby" then
        v13 = v9:New("TextLabel")
        v15 = {
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
        local Children = v9.Children
        v1 = {}
        v2 = v9:New("UITextSizeConstraint")
        v2 = v2({MinTextSize = 12, MaxTextSize = 19})
        v3 = v9:New("UIStroke")
        v4 = {Thickness = 1, Transparency = 0.3, Color = Theme.Menu.HeaderStroke}
        v1[1] = v2
        v1[2] = v3(v4)
        v15[Children] = v1
        table.insert(v11, v13(v15))
    else
        local v16
        if self.mode ~= "Story" then
            v12 = v9:New("TextLabel")
            v14 = {
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
            v14[v9.Children] = {addTextConstraint(v9, 12, 22)}
            v12 = v12(v14)
            v14 = v9:New("TextLabel")
            v13 = {
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
            v13[v9.Children] = {addTextConstraint(v9, 17, 32)}
            v14 = v14(v13)
            v13 = v9:New("TextLabel")
            v15 = {
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
            v15[v9.Children] = {addTextConstraint(v9, 12, 20)}
            v13 = v13(v15)
            v15 = v9:New("UIScale")
            v15 = v15({Name = "CompletionPulse", Scale = 1})
            v8 = v9:New("TextLabel")
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
            v1[v9.Children] = {addTextConstraint(v9, 15, 28)}
            v8 = v8(v1)
            v1 = v9:New("Frame")
            v2 = {
                Name = "ValueContainer",
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0, 128),
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundTransparency = 1,
                ZIndex = 12,
            }
            v2[v9.Children] = {v15, v8}
            v1 = v1(v2)
            v2 = v9:New("CanvasGroup")
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
            local Children_5 = v9.Children
            v5 = {}
            v16 = v9:New("UISizeConstraint")
            v16 = v16({MinSize = Vector2.new(280, 150), MaxSize = Vector2.new(760, 150)})
            v5[1] = v12
            v5[2] = v16
            v5[3] = v14
            v5[4] = v13
            v5[5] = v1
            v3[Children_5] = v5
            v2 = v2(v3)
            self.commendationCard = v2
            self.commendationNameLabel = v12
            self.commendationTitleLabel = v14
            self.commendationDescriptorLabel = v13
            self.commendationValueLabel = v8
            self.commendationValueScale = v15
            table.insert(v11, v2)
        else
            v13 = v9:New("Frame")
            v15 = {
                Name = "StoryStatus",
                AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0.5, 0, 1, -18),
                Size = UDim2.new(0.88, 0, 0, 76),
                BackgroundTransparency = 1,
                ZIndex = 10,
            }
            local Children_2 = v9.Children
            v1 = {}
            v2 = v9:New("TextLabel")
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
            local Children_3 = v9.Children
            v5 = {}
            v6 = v9:New("UITextSizeConstraint")
            v6 = v6({MinTextSize = 12, MaxTextSize = 22})
            v16 = v9:New("UIStroke")
            local v17 = {Thickness = 1, Transparency = 0.3, Color = Theme.Menu.HeaderStroke}
            v5[1] = v6
            v5[2] = v16(v17)
            v3[Children_3] = v5
            v2 = v2(v3)
            v3 = v9:New("TextLabel")
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
            local Children_4 = v9.Children
            v6 = {}
            v16 = v9:New("UITextSizeConstraint")
            v16 = v16({MinTextSize = 18, MaxTextSize = 34})
            v17 = v9:New("UIStroke")
            local v18 = {Thickness = 1, Transparency = 0.22, Color = Theme.Menu.HeaderStroke}
            v6[1] = v16
            v6[2] = v17(v18)
            v4[Children_4] = v6
            v1[1] = v2
            v1[2] = v3(v4)
            v15[Children_2] = v1
            table.insert(v11, v13(v15))
        end
    end
    if self.mode ~= "Extraction" then
        v13 = v9:New("Frame")
        v15 = {
            Name = "ProgressTrack",
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 4),
            BackgroundColor3 = Theme.Menu.Border,
            BackgroundTransparency = 0.7,
            BorderSizePixel = 0,
            ZIndex = 20,
        }
        local Children_6 = v9.Children
        v1 = {}
        v2 = v9:New("Frame")
        v3 = {
            Name = "Fill",
            Size = v9:Computed(function(p1) -- Line: 799 -- upvalues: u54 (val)
                local v1 = tonumber((p1(u54))) or 0
                return UDim2.fromScale(math.clamp(v1, 0, 1), 1)
            end),
            BackgroundColor3 = Theme.Menu.Accent,
            BackgroundTransparency = 0.12,
            BorderSizePixel = 0,
            ZIndex = 21,
        }
        local Children_7 = v9.Children
        v5 = {}
        v6 = v9:New("UIGradient")
        v5[1] = v6({Color = ColorSequence.new(Theme.Menu.Accent, Theme.Menu.AccentCyan)})
        v3[Children_7] = v5
        v1[1] = v2(v3)
        v15[Children_6] = v1
        table.insert(v10, v13(v15))
    end
    v14 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v14 then
        v12 = "Frame"
    else
        v12 = "CanvasGroup"
    end
    v14 = v9:New(v12)
    v13 = {
        Name = "Root",
        Size = UDim2.fromScale(1, 1),
        Active = true,
        BackgroundColor3 = Theme.Menu.PanelInset,
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
    }
    v8 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v8 then
        v15 = nil
    else
        v15 = 0
    end
    v13.GroupTransparency = v15
    v13[v9.Children] = v10
    v14 = v14(v13)
    v13 = v9:New(v12)
    v15 = {Name = "SafeRoot", Size = UDim2.fromScale(1, 1), Active = true, BackgroundTransparency = 1}
    v1 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v1 then
        v8 = nil
    else
        v8 = 0
    end
    v15.GroupTransparency = v8
    v15[v9.Children] = v11
    v13 = v13(v15)
    v15 = v9:New("ScreenGui")
    v8 = {
        Name = "MarauderLoadingScreen",
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        DisplayOrder = 10000,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.None,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    v2 = {v14}
    v8[v9.Children] = v2
    v15 = v15(v8)
    v8 = v9:New("ScreenGui")
    v1 = {
        Name = "MarauderLoadingSafeArea",
        Parent = LocalPlayer:WaitForChild("PlayerGui"),
        DisplayOrder = 10001,
        IgnoreGuiInset = true,
        ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }
    v3 = {v13}
    v1[v9.Children] = v3
    v8 = v8(v1)
    v1 = nil
    if self.extractionCover then
        v2 = v9:New("ScreenGui")
        v3 = {
            Name = "MarauderLoadingExtractionCover",
            Parent = LocalPlayer:WaitForChild("PlayerGui"),
            DisplayOrder = 10002,
            IgnoreGuiInset = true,
            ScreenInsets = Enum.ScreenInsets.None,
            ResetOnSpawn = false,
            ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        }
        v3[v9.Children] = {self.extractionCover}
        v1 = v2(v3)
    end
    self.screenGui = v15
    self.safeGui = v8
    self.coverGui = v1
    self.interfaceRoot = v14
    self.safeRoot = v13
end
function u81:_createMusic() -- Line: 878 -- upvalues: Config (val), SoundService (val), TweenService (val), getMarauderTemplate (val), getSeatedIdleAnimationAssets (val), getHeliPreloadSoundAssets (val), getExtractionPreloadSoundAssets (val), ContentProvider (val)
    local v1
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
        if not Music then
            v1 = nil
        elseif not (Music:IsA("SoundGroup")) then
            v1 = nil
        else
            v1 = Music
            if not v1 then
                v1 = nil
            end
        end
        u6.SoundGroup = v1
        u6.Parent = SoundService
        self.music = u6
        u6:Play()
        local v2 = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(u6, v2, {Volume = Config.LoadingMusicVolume}):Play()
    end
    task.spawn(function() -- Line: 898 -- upvalues: getMarauderTemplate (upval), u6 (ref), getSeatedIdleAnimationAssets (upval), self (val), getHeliPreloadSoundAssets (upval), Config (upval), getExtractionPreloadSoundAssets (upval), ContentProvider (upval)
        pcall(function() -- Line: 899 -- upvalues: getMarauderTemplate (upval), u6 (upval), getSeatedIdleAnimationAssets (upval), self (upval), getHeliPreloadSoundAssets (upval), Config (upval), getExtractionPreloadSoundAssets (upval), ContentProvider (upval)
            local v1 = getMarauderTemplate()
            local v2 = {}
            if u6 then
                table.insert(v2, u6)
            end
            if v1 then
                table.insert(v2, v1)
            end
            for i, v in ipairs((getSeatedIdleAnimationAssets())) do
                table.insert(v2, v)
            end
            local v3 = self
            local v4 = if v3.mode ~= "Story" then v3.mode == "Extraction" else true
            if v4 then
                for i2, i3 in ipairs((getHeliPreloadSoundAssets())) do
                    table.insert(v2, i3)
                end
            end
            if self.mode == "Story" then
                table.insert(v2, Config.CountdownBeep)
                table.insert(v2, Config.CountdownFinalBeep)
            elseif self.mode == "Extraction" then
                for i4, j in ipairs((getExtractionPreloadSoundAssets())) do
                    table.insert(v2, j)
                end
            end
            if 0 < #v2 then
                ContentProvider:PreloadAsync(v2)
            end
        end)
    end)
end
function u81:_createExtractionSounds() -- Line: 931 -- upvalues: Config (val), getEffectsSoundGroup (val), SoundService (val)
    local Sound, soundId, v1, v2
    if self.mode ~= "Extraction" then
        return
    end
    self.extractionSounds = {}
    local v3 = {
        hit = {soundId = Config.ExtractionCardHitSoundId, volume = Config.ExtractionCardHitVolume},
        whoosh = {soundId = Config.ExtractionCardWhooshSoundId, volume = Config.ExtractionCardWhooshVolume},
        hydraulic = {soundId = Config.ExtractionCameraMoveSoundId, volume = Config.ExtractionCameraMoveVolume},
        count = {looped = true, soundId = Config.ExtractionCountUpLoopSoundId, volume = Config.ExtractionCountUpLoopVolume},
        finish = {soundId = Config.ExtractionCountUpFinishSoundId, volume = Config.ExtractionCountUpFinishVolume},
    }
    local v4 = self
    for k, v in pairs(v3) do
        soundId = v.soundId
        if type(soundId) == "string" and soundId ~= "" then
            Sound = Instance.new("Sound")
            v1 = string.upper((string.sub(k, 1, 1)))
            Sound.Name = "MarauderExtraction" .. v1 .. string.sub(k, 2)
            Sound.SoundId = soundId
            Sound.Volume = v.volume
            v2 = v.looped == true
            Sound.Looped = v2
            Sound.SoundGroup = getEffectsSoundGroup()
            Sound.Parent = SoundService
            v4.extractionSounds[k] = Sound
        end
    end
end
function u81:_createStorySounds() -- Line: 964 -- upvalues: Config (val), getEffectsSoundGroup (val), SoundService (val)
    local Sound, v1
    if self.mode ~= "Story" then
        return
    end
    self.storySounds = {}
    local v2 = {
        playerReady = {soundId = Config.StoryPlayerReadySoundId, volume = Config.StoryPlayerReadyVolume},
        allReady = {soundId = Config.StoryAllReadySoundId, volume = Config.StoryAllReadyVolume},
    }
    for k, v in pairs(v2) do
        if type(v.soundId) == "string" and v.soundId ~= "" then
            Sound = Instance.new("Sound")
            v1 = string.upper((string.sub(k, 1, 1)))
            Sound.Name = "MarauderStory" .. v1 .. string.sub(k, 2)
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
    local Position, Position_2, RightVector, v1, v2, v3, v4, v5
    if not p3 then
        Position = Config.FallbackSeatPosition
    else
        Position = p3.Position
    end
    local v6 = math.abs(Position.X)
    if v6 < 1.5 then
        Position = Vector3.new(Config.FallbackSeatPosition.X, Position.Y, Position.Z)
    end
    if not p4 then
        Position_2 = Config.FallbackDoorPosition
    else
        Position_2 = p4.Position
    end
    if Position.Z > Position_2.Z then
        v5 = 1
    else
        v5 = -1
    end
    self.seatFrames = {}
    for i, v in ipairs(Config.PassengerSlots) do
        v1 = Position.Z + v5 * Config.SeatSpacing * v.Y
        v2 = Vector3.new(Position.X * v.X, Position.Y, v1)
        v3 = p2.CFrame:PointToWorldSpace(v2)
        v4 = p2.CFrame:PointToWorldSpace((Vector3.new(0, Position.Y, v1)))
        self.seatFrames[i] = CFrame.lookAt(v3, v4, p2.CFrame.UpVector)
    end
    local Position_3 = self.seatFrames[Config.LobbySeatIndex].Position
    local v7 = p2.CFrame:PointToWorldSpace((Vector3.new(0, Position.Y, Position.Z))) - Position_3
    if v7.Magnitude >= 0.1 then
        RightVector = v7.Unit
    else
        RightVector = p2.CFrame.RightVector
    end
    local v8 = p2.CFrame:VectorToWorldSpace((Vector3.new(0, 0, v5)))
    local UpVector = p2.CFrame.UpVector
    v1 = p2.CFrame:PointToWorldSpace(Position_2)
    v2 = Position_3 + RightVector * Config.LobbyCameraAisleOffset + v8 * Config.LobbyCameraLongitudinalOffset + UpVector * Config.LobbyCameraHeight
    local v9 = (Position_3 + UpVector * 0.7):Lerp(v1 + UpVector * 0.4, Config.LobbyDoorCompositionWeight)
    self.lobbyCameraCFrame = CFrame.lookAt(v2, v9, UpVector)
    local v10 = Vector3.new(Config.StoryCameraLateralOffset, Position.Y + Config.StoryCameraHeight, Position.Z - v5 * Config.StoryCameraLongitudinalOffset)
    local v11 = Vector3.new(0, Position.Y + Config.StoryCameraTargetHeight, Position.Z + v5 * Config.SeatSpacing * Config.StoryCameraTargetRow)
    local v12 = p2.CFrame:PointToWorldSpace(v10)
    local v13 = p2.CFrame:PointToWorldSpace(v11)
    self.storyCameraCFrame = CFrame.lookAt(v12, v13, UpVector)
    local v14 = Vector3.new(Config.ExtractionWideCameraLateralOffset, Position.Y + Config.ExtractionWideCameraHeight, Position.Z - v5 * Config.ExtractionWideCameraLongitudinalOffset)
    v12 = Vector3.new(0, Position.Y + Config.ExtractionWideCameraTargetHeight, Position.Z + v5 * Config.SeatSpacing * Config.ExtractionWideCameraTargetRow)
    local v15 = p2.CFrame:PointToWorldSpace(v14)
    local v16 = p2.CFrame:PointToWorldSpace(v12)
    self.extractionWideCameraCFrame = CFrame.lookAt(v15, v16, UpVector)
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
    if not (Config.PassengerSlots[p2]) then
        X = 1
    else
        X = Config.PassengerSlots[p2].X
        if not X then
            X = 1
        end
    end
    local v4 = CFrame.fromAxisAngle(v1, Config.ExtractionSpotlightYaw * X)
    v4 = v2 + v4:VectorToWorldSpace(v3) + v1 * Config.ExtractionSpotlightHeight
    return CFrame.lookAt(v4, v2, v1)
end
function u81:_dismissArrivalCover(p2) -- Line: 1095 -- upvalues: dismissArrivalCover (val)
    local v1 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if v1 then
        dismissArrivalCover(p2)
    end
end
function u81:_startHeliAudioFadeIn(p2) -- Line: 1101 -- upvalues: Config (val), TweenService (val)
    local v1
    local v2 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v2 or self.destroyed or self.heliAudioFadingIn or self.storyDepartureFading then
        return
    end
    self.heliAudioFadingIn = true
    local HeliAudioFadeIn = tonumber(p2)
    if not HeliAudioFadeIn then
        HeliAudioFadeIn = Config.HeliAudioFadeIn
    end
    local v3 = math.max(HeliAudioFadeIn, 0)
    local heliSounds = self.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    local v4 = self
    for i, v in ipairs(heliSounds) do
        if v.Parent then
            if not v.IsPlaying then
                v:Play()
            end
            v1 = TweenInfo.new(v3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(v, v1, {Volume = v4.heliSoundVolumes[v] or 0}):Play()
        end
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
    local model, v1, v2, v3
    local v4 = 1
    if self.loadingStatus then
        v3 = math.floor(tonumber(self.loadingStatus:GetAttribute("ExpectedPlayers")) or 0)
        v4 = math.max(v3, 1)
    end
    local v5 = {}
    v3 = 0
    local storyFolders = self.storyFolders
    if not storyFolders then
        storyFolders = {}
    end
    for k, v in pairs(storyFolders) do
        if k.Parent then
            v3 = v3 + 1
            v5[v.index] = v
        end
    end
    v4 = math.max(v4, v3)
    local v6 = 0
    local v7 = {}
    local v8 = {}
    local v9 = 6
    local v10 = 1
    local v11 = self
    for i = 1, v9, v10 do
        v1 = v5[i]
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
                v6 = v6 + 1
                table.insert(v7, v2.model)
                table.insert(v8, string.format("%d:%d:%d", i, v11.avatarGenerations[i] or 0, v1.userId or 0))
            end
        end
    end
    v9 = if v4 <= v3 then v4 <= v6 else false
    v10 = table.concat(v8, "|")
    return v9, v10, v7, v6, v4
end
function u81:_beginStoryBasePreload() -- Line: 1180 -- upvalues: ContentProvider (val)
    if self.mode ~= "Story" or self.destroyed or self.storyBasePreloadStarted then
        return
    end
    self.storyBasePreloadStarted = true
    self.storyBasePreloadFinished = false
    local u6 = {}
    if self.scene then
        table.insert(u6, self.scene)
    end
    local heliSounds = self.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    for i, v in ipairs(heliSounds) do
        table.insert(u6, v)
    end
    task.spawn(function() -- Line: 1195 -- upvalues: u6 (val), ContentProvider (upval), self (val)
        local v1, v2
        v1, v2 = pcall(function() -- Line: 1196 -- upvalues: u6 (upval), ContentProvider (upval)
            local v1 = #u6
            if 0 < v1 then
                ContentProvider:PreloadAsync(u6)
            end
        end)
        if self.destroyed then
            return
        end
        self.storyBasePreloadFinished = true
        self.storyBasePreloadSucceeded = v1
        self.storyBasePreloadError = tostring(v2)
    end)
end
function u81:_beginStoryAvatarPreload(p2, p3) -- Line: 1210 -- upvalues: ContentProvider (val)
    if self.destroyed or self.storyAvatarPreloadSignature == p2 then
        return
    end
    self.storyAvatarPreloadGeneration = (self.storyAvatarPreloadGeneration or 0) + 1
    local storyAvatarPreloadGeneration = self.storyAvatarPreloadGeneration
    self.storyAvatarPreloadSignature = p2
    self.storyAvatarPreloadFinished = false
    self.storyAvatarPreloadSucceeded = false
    task.spawn(function() -- Line: 1220 -- upvalues: p3 (val), ContentProvider (upval), self (val), storyAvatarPreloadGeneration (val)
        local v1, v2
        v1, v2 = pcall(function() -- Line: 1221 -- upvalues: p3 (upval), ContentProvider (upval)
            local v1 = #p3
            if 0 < v1 then
                ContentProvider:PreloadAsync(p3)
            end
        end)
        if self.destroyed or self.storyAvatarPreloadGeneration ~= storyAvatarPreloadGeneration then
            return
        end
        self.storyAvatarPreloadFinished = true
        self.storyAvatarPreloadSucceeded = v1
        self.storyAvatarPreloadError = tostring(v2)
    end)
end
function u81:_waitForStoryRevealReady() -- Line: 1235 -- upvalues: Config (val), RunService (val)
    local storyAvatarPreloadFinished, storyBasePreloadFinished, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    if self.mode ~= "Story" then
        return true
    end
    self:_beginStoryBasePreload()
    local v11 = tonumber(Config.StoryRevealReadyTimeout) or 0
    local v12 = os.clock() + math.max(v11, 0)
    local v13 = nil
    local v14 = self
    while true do
        v10, v1, v2, v3, v4 = v14:_getStoryRevealAvatarState()
        v7 = v10
        v8 = v1
        v9 = v2
        v5 = v3
        v6 = v4
        if v7 then
            v14:_beginStoryAvatarPreload(v8, v9)
        end
        v11 = v14:_isHeliAudioReady()
        storyBasePreloadFinished = v14.storyBasePreloadFinished
        if storyBasePreloadFinished then
            storyBasePreloadFinished = v14.storyBasePreloadSucceeded
        end
        storyAvatarPreloadFinished = v7
        if storyAvatarPreloadFinished then
            storyAvatarPreloadFinished = false
            if v14.storyAvatarPreloadSignature == v8 then
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
            v2 = os.clock() - v2
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
    end
    if not v14.destroyed then
        local v15, v16
        v7 = warn
        local format = string.format
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
        end
        if not v14.storyAvatarPreloadError then
            v16 = ""
        else
            v16 = "; avatar preload error=" .. v14.storyAvatarPreloadError
            if not v16 then
                v16 = ""
            end
        end
        v7(format("[MarauderLoading] Story reveal readiness timed out (avatars=%d/%d, sceneAssets=%s, avatarAssets=%s, heliAudio=%s); revealing with available assets%s%s", v5, v6, v2, v3, v4, v15, v16))
    end
    return false
end
function u81:_waitForExtractionAvatarReady() -- Line: 1286 -- upvalues: Config (val), RunService (val)
    local model, v1, v2
    if self.mode ~= "Extraction" then
        return true
    end
    local v3 = 0
    local extractionAvatarSeats = self.extractionAvatarSeats
    if not extractionAvatarSeats then
        extractionAvatarSeats = {}
    end
    for k in pairs(extractionAvatarSeats) do
        v3 = v3 + 1
    end
    if v3 == 0 then
        return true
    end
    local v4 = tonumber(Config.ExtractionAvatarReadyTimeout) or 0
    local v5 = os.clock() + math.max(v4, 0)
    local v6 = nil
    local v7 = self
    while true do
        v2 = 0
        for k2 in pairs(v7.extractionAvatarSeats) do
            v1 = v7.avatars[k2]
            model = v1
            if model then
                model = false
                if v1.loading ~= true then
                    model = v1.model
                    if model then
                        model = v1.model.Parent == v7.avatarFolder
                    end
                end
            end
            if model then
                v2 = v2 + 1
            end
        end
        if v3 > v2 then
            v6 = nil
            RunService.Heartbeat:Wait()
            if v7.destroyed or v5 <= os.clock() then
                break
            end
        else
            v4 = v6
            if not v4 then
                v4 = os.clock()
            end
            v4 = os.clock() - v4
            if Config.StoryRevealReadyStableTime <= v4 then
                return true
            end
        end
    end
    if not v7.destroyed then
        warn(string.format("[MarauderLoading] Extraction avatar readiness timed out (avatars=%d/%d); revealing with available avatars", v2, v3))
    end
    return false
end
function u81:_revealStoryScene() -- Line: 1335 -- upvalues: Config (val)
    if self.destroyed or self.storySceneRevealed then
        return
    end
    self.storySceneRevealed = true
    local ArrivalFadeOutTime = Config.ArrivalFadeOutTime
    self:_startHeliAudioFadeIn(ArrivalFadeOutTime)
    self:_dismissArrivalCover(ArrivalFadeOutTime)
end
function u81:_createHeliAudio(p2) -- Line: 1345 -- upvalues: getEffectsSoundGroup (val), Config (val)
    local Sound
    local v1 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v1 or self.destroyed or not p2 or not p2.Parent then
        return
    end
    v1 = getEffectsSoundGroup()
    local v2 = {}
    local v3 = {name = "MarauderEngine", soundId = Config.HeliEngineSoundId, volume = Config.HeliEngineVolume}
    v2[1] = {name = "MarauderInterior", soundId = Config.HeliInteriorSoundId, volume = Config.HeliInteriorVolume}
    v2[2] = v3
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
        table.insert(self.heliSounds, Sound)
        self.heliSoundVolumes[Sound] = v.volume
        Sound:Play()
    end
    if self.mode == "Extraction" then
        self:_startHeliAudioFadeIn(Config.HeliAudioFadeIn)
    end
end
function u81:_startStoryCameraShake() -- Line: 1386 -- upvalues: Config (val), getCameraShaker (val)
    local v1 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v1 or self.destroyed or self.cameraShaker then
        return
    end
    local StoryCameraShake = Config.StoryCameraShake
    self.cameraShaker = getCameraShaker().new(Enum.RenderPriority.Camera.Value, (self.renderStepName or "MarauderLoading_Cabin") .. "_Shake")
    self.cameraShake = self.cameraShaker:StartShake(StoryCameraShake.Magnitude, StoryCameraShake.Roughness, StoryCameraShake.FadeIn, StoryCameraShake.PositionInfluence, StoryCameraShake.RotationInfluence)
end
function u81:_fadeStoryInterface(p2) -- Line: 1404 -- upvalues: TweenService (val)
    local readyLabel, readyStroke, v1, v2, v3
    local v4 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v4 or self.storyInterfaceFading then
        return
    end
    self.storyInterfaceFading = true
    local v5 = {self.interfaceRoot, self.safeRoot}
    for i, v in ipairs(v5) do
        if v and v:IsA("CanvasGroup") then
            v1 = TweenInfo.new(p2, Enum.EasingStyle.Linear)
            TweenService:Create(v, v1, {GroupTransparency = 1}):Play()
        end
    end
    local avatars = self.avatars
    if not avatars then
        avatars = {}
    end
    local v6 = p2
    for k, i2 in pairs(avatars) do
        readyLabel = i2.readyLabel
        if readyLabel and readyLabel.Parent then
            v2 = TweenInfo.new(v6, Enum.EasingStyle.Linear)
            TweenService:Create(readyLabel, v2, {TextTransparency = 1}):Play()
        end
        readyStroke = i2.readyStroke
        if readyStroke and readyStroke.Parent then
            v3 = TweenInfo.new(v6, Enum.EasingStyle.Linear)
            TweenService:Create(readyStroke, v3, {Transparency = 1}):Play()
        end
    end
end
function u81:_fadeHeliAudio(p2) -- Line: 1432 -- upvalues: Config (val), TweenService (val)
    local v1
    local HeliAudioFadeOut = tonumber(p2)
    if not HeliAudioFadeOut then
        HeliAudioFadeOut = Config.HeliAudioFadeOut
    end
    local heliSounds = self.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    for i, v in ipairs(heliSounds) do
        if v.Parent then
            v1 = TweenInfo.new(math.max(HeliAudioFadeOut, 0), Enum.EasingStyle.Linear)
            TweenService:Create(v, v1, {Volume = 0}):Play()
        end
    end
end
function u81:_startStoryDepartureFade() -- Line: 1441 -- upvalues: Config (val)
    local HeliAudioFadeOut
    local v1 = if self.mode ~= "Story" then self.mode == "Extraction" else true
    if not v1 or self.storyDepartureFading then
        return
    end
    self.storyDepartureFading = true
    if self.mode ~= "Extraction" then
        HeliAudioFadeOut = Config.StoryUIFadeTime
    else
        HeliAudioFadeOut = Config.HeliAudioFadeOut
    end
    self:_fadeStoryInterface(HeliAudioFadeOut)
    self:_fadeHeliAudio(HeliAudioFadeOut)
end
function u81:_prepareScene() -- Line: 1451 -- upvalues: getMarauderTemplate (val), u87 (val), findDoor (val), Workspace (val), Config (val), LocalPlayer (val), TweenService (val)
    local CFrame, CFrame_2, v1, v2, v3, v4
    local v5 = getMarauderTemplate()
    if not v5 then
        while true do
            task.wait(0.1)
            v5 = getMarauderTemplate()
            if v5 or self.destroyed or os.clock() + 8 <= os.clock() then
                break
            end
        end
    end
    if not v5 or self.destroyed then
        warn("[MarauderLoading] MarauderTemplate is unavailable; using the UI fallback")
        u87[self.mode] = true
        self:_dismissArrivalCover()
        return
    end
    local Marauder01 = v5:FindFirstChild("Marauder01")
    if not Marauder01 and v5:IsA("Model") then
        Marauder01 = v5
    end
    if not Marauder01 or not (Marauder01:IsA("Model")) then
        warn("[MarauderLoading] Marauder01 is missing from the template")
        u87[self.mode] = true
        self:_dismissArrivalCover()
        return
    end
    local v6 = Marauder01:Clone()
    v6.Name = "MarauderLoadingScene"
    local Heli = v6:FindFirstChild("Heli")
    local Body = Heli
    if Body then
        Body = Heli:FindFirstChild("Body")
    end
    if not Heli or not (Heli:IsA("Model")) or not Body or not (Body:IsA("BasePart")) then
        v6:Destroy()
        warn("[MarauderLoading] The source model has no Heli.Body")
        u87[self.mode] = true
        self:_dismissArrivalCover()
        return
    end
    local Player = v6:FindFirstChild("Player")
    if not Player then
        CFrame = nil
    elseif Player:IsA("BasePart") then
        CFrame = Player.CFrame
    elseif not (Player:IsA("Model")) then
        CFrame = nil
    else
        v3, v4 = pcall(Player.GetPivot, Player)
        if not v3 then
            CFrame = nil
        else
            CFrame = v4
        end
    end
    if not CFrame then
        v3 = nil
    else
        v3 = Body.CFrame:ToObjectSpace(CFrame)
    end
    if Player and Player:IsA("Model") then
        self.placeholderFallback = Player:Clone()
    end
    v4 = findDoor(Heli)
    if not v4 then
        CFrame_2 = nil
    elseif v4:IsA("BasePart") then
        CFrame_2 = v4.CFrame
    elseif not (v4:IsA("Model")) then
        CFrame_2 = nil
    else
        local v7
        v1, v7 = pcall(v4.GetPivot, v4)
        if not v1 then
            CFrame_2 = nil
        else
            CFrame_2 = v7
        end
    end
    if not CFrame_2 then
        v1 = nil
    else
        v1 = Body.CFrame:ToObjectSpace(CFrame_2)
    end
    local v8 = {"Player", "2nd", "3rd"}
    for i, v in ipairs(v8) do
        v2 = v6:FindFirstChild(v)
        if v2 then
            v2:Destroy()
        end
    end
    local v9 = self
    for i2, i3 in ipairs(v6:GetDescendants()) do
        if i3:IsA("LuaSourceContainer") then
            i3:Destroy()
        elseif not (i3:IsA("AnimationController")) and not (i3:IsA("Animator")) and not (i3:IsA("Sound")) and i3:IsA("BasePart") then
            i3.Anchored = true
            i3.CanCollide = false
            i3.CanTouch = false
            i3.CanQuery = false
            i3.Massless = true
        end
    end
    v6.Parent = Workspace
    v6:PivotTo(Config.SceneOrigin)
    v9.scene = v6
    v9.avatarFolder = Instance.new("Folder")
    v9.avatarFolder.Name = "Passengers"
    v9.avatarFolder.Parent = v6
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
    local v10 = Heli:FindFirstChild("Body")
    v9:_buildSeatFrames(v10, v3, v1)
    if v9.mode == "Lobby" then
        v9.baseCameraCFrame = v9.lobbyCameraCFrame
        v9.fieldOfView = Config.LobbyFieldOfView
    elseif v9.mode ~= "Extraction" then
        v9.baseCameraCFrame = v9.storyCameraCFrame
        v9.fieldOfView = Config.StoryFieldOfView
    else
        v9.baseCameraCFrame = v9.extractionWideCameraCFrame
        v9.fieldOfView = Config.ExtractionWideFieldOfView
    end
    if v9.mode ~= "Lobby" then
        local v11 = 6
        local v12 = 1
        for j = 1, v11, v12 do
            v2 = v9.pendingAvatarEntries[j]
            if v2 then
                v9:_spawnAvatar(v2.userId, v2.name, j, v2.ready)
            end
        end
    else
        v9:_spawnAvatar(LocalPlayer.UserId, LocalPlayer.Name, Config.LobbySeatIndex, true)
    end
    v9:_createHeliAudio(v10)
    v9:_startStoryCameraShake()
    if v9.interfaceRoot and v9.interfaceRoot.Parent then
        v2 = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(v9.interfaceRoot, v2, {BackgroundTransparency = 0.76}):Play()
    end
    if v9.mode == "Story" then
        v9:_waitForStoryRevealReady()
        v9:_revealStoryScene()
    elseif v9.mode ~= "Extraction" then
        v9:_dismissArrivalCover()
    else
        v9:_waitForExtractionAvatarReady()
        v9:_dismissArrivalCover()
    end
    u87[v9.mode] = true
end
local function findMotor(p1, p2) -- Line: 1592
    local v1
    local v2 = p1:FindFirstChild(p2, true)
    if not v2 then
        v1 = nil
    elseif not (v2:IsA("Motor6D")) then
        v1 = nil
    else
        v1 = v2
        if not v1 then
            v1 = nil
        end
    end
    return v1
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
        idleTrack:Stop(Config.SeatedIdleFadeTime)
        idleTrack:Destroy()
    end)
    p1.idleTrack = nil
end
local function applyReadyTag(p1, p2) -- Line: 1609 -- upvalues: Config (val)
    local StoryReadyTagReadyColor, StoryReadyTagReadyText
    local readyLabel = p1
    if readyLabel then
        readyLabel = p1.readyLabel
    end
    if not readyLabel or not readyLabel.Parent then
        return
    end
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
    if #v1 == 0 then
        return false
    else
        local v2, v3, v4
        if not p2.animator then
            return false
        end
        local u13 = Random.new(((self.seatedIdleSeed or 0) + p3 * 104729) % 2147483647)
        local u19 = v1[self:_getSeatedIdleAssignment(p3, #v1)]
        local u20 = nil
        v3, v4 = pcall(function() -- Line: 1646 -- upvalues: u20 (ref), p2 (val), u19 (val)
            u20 = p2.animator:LoadAnimation(u19)
        end)
        if v3 and u20 then
            while not self.destroyed do
                v2 = self.avatarGenerations[p3]
                if v2 ~= p2.generation or not p2.model.Parent or u20.Length > 0 or os.clock() >= os.clock() + 2 then
                    break
                end
                task.wait()
            end
            if self.destroyed then
                v3 = false
                v4 = "avatar preparation was superseded"
            else
                v2 = self.avatarGenerations[p3]
                if v2 == p2.generation and p2.model.Parent and u20.Length <= 0 then
                    v3 = false
                    v4 = "animation asset did not load"
                end
            end
        end
        if not v3 then
            if u20 then
                u20:Destroy()
            end
            if v4 ~= "avatar preparation was superseded" then
                warn("[MarauderLoading] Could not load seated idle " .. u19.Name .. ": " .. tostring(v4))
            end
            return false
        elseif u20 then
            local v5
            v5, v2 = pcall(function() -- Line: 1678 -- upvalues: u20 (ref), Config (upval), u13 (val)
                u20.Priority = Enum.AnimationPriority.Action
                u20.Looped = true
                u20:Play(Config.SeatedIdleFadeTime)
                u20:AdjustSpeed(1 + u13:NextNumber(-Config.SeatedIdleSpeedJitter, Config.SeatedIdleSpeedJitter))
                u20.TimePosition = u13:NextNumber(0, u20.Length)
            end)
            if v5 then
                p2.idleTrack = u20
                return true
            end
            pcall(function() -- Line: 1686 -- upvalues: u20 (ref)
                u20:Stop(0)
                u20:Destroy()
            end)
            warn("[MarauderLoading] Could not play seated idle " .. u19.Name .. ": " .. tostring(v2))
            return false
        end
    end
end
function u81:_getSeatedIdleAssignment(p2, p3) -- Line: 1698 -- upvalues: buildSeatedIdleAssignments (val), Config (val)
    if not self.seatedIdleAssignments then
        self.seatedIdleAssignments = buildSeatedIdleAssignments(self.seatedIdleSeed or 0, p3, #Config.PassengerSlots)
        self.seatedIdleAssignmentCount = p3
    elseif self.seatedIdleAssignmentCount ~= p3 then
        self.seatedIdleAssignments = buildSeatedIdleAssignments(self.seatedIdleSeed or 0, p3, #Config.PassengerSlots)
        self.seatedIdleAssignmentCount = p3
    end
    return self.seatedIdleAssignments[p2] or 1
end
function u81:_createReadyTag(p2) -- Line: 1707 -- upvalues: Config (val)
    local StoryReadyTagReadyColor, StoryReadyTagReadyText
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
    if not Torso or not (Torso:IsA("BasePart")) then
        return
    end
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
    if not readyLabel or not readyLabel.Parent then
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
function u81:_prepareSeatedAvatar(p2, p3, p4) -- Line: 1765 -- upvalues: applyFallbackSeatedPose (val)
    local v1, v2, v3, v4, v5, v6
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then
        HumanoidRootPart = p2.PrimaryPart
    end
    if not HumanoidRootPart or not (HumanoidRootPart:IsA("BasePart")) then
        p2:Destroy()
        return nil
    end
    p2.PrimaryPart = HumanoidRootPart
    v2, v1, v4, v5 = p2, self, p3, p4
    for i, v in ipairs(p2:GetDescendants()) do
        if v:IsA("LuaSourceContainer") then
            v:Destroy()
        elseif not (v:IsA("Tool")) and not (v:IsA("Sound")) and not (v:IsA("ParticleEmitter")) and not (v:IsA("Trail")) and not (v:IsA("Beam")) and not (v:IsA("Smoke")) and not (v:IsA("Fire")) and not (v:IsA("Sparkles")) and v:IsA("BasePart") then
            v3 = v == HumanoidRootPart
            v.Anchored = v3
            v.CanCollide = false
            v.CanTouch = false
            v.CanQuery = false
            v.Massless = true
        end
    end
    local Humanoid = v2:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.AutoRotate = false
        Humanoid.PlatformStand = true
        Humanoid.Sit = true
        Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        pcall(function() -- Line: 1799 -- upvalues: Humanoid (val)
            Humanoid.EvaluateStateMachine = false
        end)
    end
    v2.Parent = v1.avatarFolder
    v2:PivotTo(v1.seatFrames[v4])
    local v7 = {model = v2}
    if not Humanoid then
        v6 = nil
    elseif Humanoid:IsA("Humanoid") then
        local Animator = Humanoid:FindFirstChildOfClass("Animator")
        if not Animator then
            Animator = Instance.new("Animator")
            Animator.Parent = Humanoid
        end
        v6 = Animator
    end
    v7.animator = v6
    local v8 = v2:FindFirstChild("Right Hip", true)
    if not v8 then
        v6 = nil
    elseif v8:IsA("Motor6D") then
        v6 = v8
    end
    v7.rightHip = v6
    v8 = v2:FindFirstChild("Left Hip", true)
    if not v8 then
        v6 = nil
    elseif v8:IsA("Motor6D") then
        v6 = v8
    end
    v7.leftHip = v6
    v8 = v2:FindFirstChild("Right Shoulder", true)
    if not v8 then
        v6 = nil
    elseif v8:IsA("Motor6D") then
        v6 = v8
    end
    v7.rightShoulder = v6
    v8 = v2:FindFirstChild("Left Shoulder", true)
    if not v8 then
        v6 = nil
    elseif v8:IsA("Motor6D") then
        v6 = v8
    end
    v7.leftShoulder = v6
    local RootJoint = v2:FindFirstChild("RootJoint", true)
    if not RootJoint then
        v6 = nil
    elseif RootJoint:IsA("Motor6D") then
        v6 = RootJoint
    end
    v7.rootJoint = v6
    local Neck = v2:FindFirstChild("Neck", true)
    if not Neck then
        v6 = nil
    elseif Neck:IsA("Motor6D") then
        v6 = Neck
    end
    v7.neck = v6
    v7.seatIndex = v4
    v7.generation = v5
    v1:_createReadyTag(v7)
    v7.animated = v1:_playSeatedIdle(v7, v4)
    if not v7.animated and not v1.destroyed and v1.avatarGenerations[v4] == v5 and v2.Parent then
        applyFallbackSeatedPose(v7)
    end
    return v7
end
function u81:_setAvatarReady(p2, p3) -- Line: 1831 -- upvalues: Config (val)
    local v1 = self.avatars[p2]
    if not v1 then
        if v1 then
            v1.ready = p3
        end
        local v2 = self.pendingAvatarEntries[p2]
        if v2 then
            v2.ready = p3
        end
        return
    elseif v1.model then
        local StoryReadyTagReadyColor, StoryReadyTagReadyText
        v1.ready = p3
        local readyLabel = v1
        if readyLabel then
            readyLabel = v1.readyLabel
        end
        if not readyLabel or not readyLabel.Parent then
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
        return
    end
end
function u81:_spawnAvatar(p2, p3, p4, p5) -- Line: 1847 -- upvalues: Config (val), AvatarProvider (val)
    local v1, v2
    if self.destroyed then
        return
    end
    local u9 = tonumber(p2) or 0
    if not self.seatFrames then
        v1 = {userId = u9, name = p3}
        v2 = p5 == true
        v1.ready = v2
        self.pendingAvatarEntries[p4] = v1
        return
    else
        local v3
        if not self.avatarFolder then
            v1 = {userId = u9, name = p3}
            v2 = p5 == true
            v1.ready = v2
            self.pendingAvatarEntries[p4] = v1
            return
        end
        self.pendingAvatarEntries[p4] = nil
        local v4 = self.avatars[p4]
        if not v4 then
            local idleTrack
            if v4 and v4.model then
                idleTrack = v4
                if idleTrack then
                    idleTrack = v4.idleTrack
                end
                if idleTrack then
                    pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
                        idleTrack:Stop(Config.SeatedIdleFadeTime)
                        idleTrack:Destroy()
                    end)
                    v4.idleTrack = nil
                end
                v4.model:Destroy()
            end
            local u52 = (self.avatarGenerations[p4] or 0) + 1
            self.avatarGenerations[p4] = u52
            local v5 = {loading = true}
            v3 = p5 == true
            v5.ready = v3
            v5.userId = u9
            self.avatars[p4] = v5
            task.spawn(function() -- Line: 1877 -- upvalues: AvatarProvider (upval), u9 (val), self (val), p4 (val), u52 (val), p3 (val), Config (upval), p5 (val)
                local v1 = AvatarProvider.GetR6Clone(u9)
                if not v1 then
                    v1 = AvatarProvider.GetFallbackR6Clone()
                end
                if not v1 and self.placeholderFallback then
                    v1 = self.placeholderFallback:Clone()
                end
                if self.destroyed then
                    if v1 then
                        v1:Destroy()
                    end
                    return
                else
                    local v2 = self.avatarGenerations[p4]
                    if v2 ~= u52 then
                        if v1 then
                            v1:Destroy()
                        end
                        return
                    end
                    if not v1 then
                        v2 = self.avatarGenerations[p4]
                        if v2 == u52 then
                            self.avatars[p4] = nil
                        end
                        return
                    end
                    local v3 = p3 or "Passenger"
                    v1.Name = v3 .. "Avatar"
                    v2 = self:_prepareSeatedAvatar(v1, p4, u52)
                    if not v2 then
                        v3 = self.avatarGenerations[p4]
                        if v3 == u52 then
                            self.avatars[p4] = nil
                        end
                        return
                    end
                    if self.destroyed then
                        local idleTrack = v2
                        if idleTrack then
                            idleTrack = v2.idleTrack
                        end
                        if idleTrack then
                            pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
                                idleTrack:Stop(Config.SeatedIdleFadeTime)
                                idleTrack:Destroy()
                            end)
                            v2.idleTrack = nil
                        end
                        v2.model:Destroy()
                        return
                    else
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
                            self:_setAvatarReady(p4, ready)
                            return
                        end
                    end
                end
            end)
            return
        elseif v4.userId == u9 then
            v3 = p5 == true
            self:_setAvatarReady(p4, v3)
            return
        end
    end
end
function u81:_updateParallaxInput(p2) -- Line: 1918 -- upvalues: Workspace (val)
    if self.mode ~= "Lobby" then
        return
    end
    if not (p2.UserInputType.Name:find("Gamepad")) then
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
            local v2 = v1.X / math.max(ViewportSize.X * 0.3, 1)
            self.touchParallax = Vector2.new(v2, v1.Y / math.max(ViewportSize.Y * 0.3, 1))
        end
        return
    elseif p2.KeyCode == Enum.KeyCode.Thumbstick2 then
        self.gamepadParallax = Vector2.new(p2.Position.X, -p2.Position.Y)
        return
    end
end
function u81:_acceptsContinueInput(p2, p3) -- Line: 1932
    local v1
    if not self.awaitingContinue or not (os.clock() >= self.continueArmedAt or (1 / 0)) then
        return false
    end
    local UserInputType = p2.UserInputType
    if UserInputType == Enum.UserInputType.Touch or UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.MouseButton2 or UserInputType == Enum.UserInputType.MouseButton3 then
        return true
    end
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
    v1 = if p2.KeyCode ~= Enum.KeyCode.Unknown then if p2.KeyCode ~= Enum.KeyCode.Thumbstick1 then p2.KeyCode ~= Enum.KeyCode.Thumbstick2 else false else false
    return v1
end
function u81:_bindInput() -- Line: 1960 -- upvalues: UserInputService (val)
    self:_connect(UserInputService.InputBegan, function(p1, p2) -- Line: 1961 -- upvalues: self (val)
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
    self:_connect(UserInputService.InputChanged, function(p1) -- Line: 1976 -- upvalues: self (val)
        self:_updateParallaxInput(p1)
    end)
    self:_connect(UserInputService.InputEnded, function(p1) -- Line: 1979 -- upvalues: self (val)
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
        v1 = math.clamp(self.touchParallax.X, -1, 1)
        return Vector2.new(v1, (math.clamp(self.touchParallax.Y, -1, 1)))
    end
    if 0.05 < self.gamepadParallax.Magnitude then
        v1 = math.clamp(self.gamepadParallax.X, -1, 1)
        return Vector2.new(v1, (math.clamp(self.gamepadParallax.Y, -1, 1)))
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
    local v3 = (MouseLocation.X - v2.X) / math.max(v2.X, 1)
    local v4 = math.clamp(v3, -1, 1)
    local v5 = (MouseLocation.Y - v2.Y) / math.max(v2.Y, 1)
    return Vector2.new(v4, (math.clamp(v5, -1, 1)))
end
function u81:_render(p2) -- Line: 2012 -- upvalues: TweenService (val), Config (val), formatIntegerWithCommas (val), Workspace (val), UserInputService (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    if self.destroyed then
        return
    end
    local v11 = os.clock()
    local v12 = v11 - self.startedAt
    local cameraMove = self.cameraMove
    if cameraMove then
        v9 = tonumber((v11 - cameraMove.startedAt) / math.max(cameraMove.duration, 0.001)) or 0
        local v13 = math.clamp(v9, 0, 1)
        local Value = TweenService:GetValue(v13, Config.ExtractionCameraMoveEasing, Config.ExtractionCameraMoveDirection)
        self.baseCameraCFrame = cameraMove.fromCFrame:Lerp(cameraMove.toCFrame, Value)
        self.fieldOfView = cameraMove.fromFieldOfView + (cameraMove.toFieldOfView - cameraMove.fromFieldOfView) * Value
        if 1 <= v13 then
            self.cameraMove = nil
        end
    end
    local countUpState = self.countUpState
    if countUpState then
        local target
        v10 = tonumber((v11 - countUpState.startedAt) / math.max(countUpState.duration, 0.001)) or 0
        v8 = math.clamp(v10, 0, 1)
        if 1 > v8 then
            target = math.floor(countUpState.target * v8)
        else
            target = countUpState.target
        end
        v2 = math.max(0, (math.round(tonumber(target) or 0)))
        v3 = formatIntegerWithCommas(v2)
        if countUpState.id ~= "DEADEYE" then
            v1 = v3
        else
            v1 = v3 .. "%"
        end
        self.commendationValue:set(v1)
    end
    if self.mode == "Lobby" and not self.lobbyReady then
        v8 = Config.LobbyProgressCap * (1 - math.exp(-v12 / Config.LobbyProgressTimeConstant))
        self.progressValue:set(v8)
    end
    v9 = self:_getParallaxTarget() - self.parallax
    self.parallaxVelocity = self.parallaxVelocity + v9 * Config.ParallaxSpring * p2
    self.parallaxVelocity = self.parallaxVelocity * math.exp(-Config.ParallaxDamping * p2)
    self.parallax = self.parallax + self.parallaxVelocity * p2
    local CurrentCamera = Workspace.CurrentCamera
    if CurrentCamera and self.baseCameraCFrame then
        local v14 = math.sin(v11 * 0.47)
        v1 = v14 * Config.CameraBobPosition.X
        v2 = math.sin(v11 * 0.82)
        v14 = v2 * Config.CameraBobPosition.Y
        v3 = math.sin(v11 * 0.36 + 1.2)
        v10 = Vector3.new(v1, v14, v3 * Config.CameraBobPosition.Z)
        v2 = math.sin(v11 * 0.61)
        v14 = v2 * Config.CameraBobRotation.X
        v3 = math.sin(v11 * 0.43 + 0.8)
        v2 = v3 * Config.CameraBobRotation.Y
        v4 = math.sin(v11 * 0.73 + 1.7)
        v1 = Vector3.new(v14, v2, v4 * Config.CameraBobRotation.Z)
        v14 = CFrame.Angles(-self.parallax.Y * Config.ParallaxPitch, -self.parallax.X * Config.ParallaxYaw, 0)
        v3 = CFrame.new(v10)
        v2 = v3 * CFrame.Angles(v1.X, v1.Y, v1.Z)
        if not self.cameraShaker then
            v3 = CFrame.new()
        else
            v3 = self.cameraShaker:Update(p2)
        end
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        CurrentCamera.CameraSubject = nil
        CurrentCamera.FieldOfView = self.fieldOfView
        CurrentCamera.CFrame = self.baseCameraCFrame * v14 * v2 * v3
    end
    for k, v in pairs(self.avatars) do
        if v.animated ~= true and v.model and v.model.Parent then
            v4 = v11 * 1.15 + k * 0.73
            if v.rootJoint then
                v7 = math.sin(v4) * 0.012
                v5 = CFrame.new(0, v7, 0)
                v7 = math.sin(v4 * 0.7) * 0.006108652381980153
                v.rootJoint.Transform = v5 * CFrame.Angles(v7, 0, 0)
            end
            if v.neck then
                v5 = math.sin(v4 * 0.55) * 0.007853981633974483
                v6 = math.sin(v4 * 0.37) * 0.005235987755982988
                v.neck.Transform = CFrame.Angles(v5, v6, 0)
            end
        end
    end
    UserInputService.MouseIconEnabled = false
end
function u81:_startTipRotation() -- Line: 2085 -- upvalues: Config (val)
    local v1, v2
    local u4 = table.clone(Config.Tips)
    local v3 = Random.new(math.floor(os.clock() * 1000) % 2147483647)
    local v4 = 2
    local v5 = -1
    for i = #u4, v4, v5 do
        v1 = v3:NextInteger(1, i)
        v2 = u4[i]
        u4[i] = u4[v1]
        u4[v1] = v2
    end
    self.shuffledTips = u4
    self.tipIndex = 1
    self.statusText:set(u4[1])
    task.spawn(function() -- Line: 2095 -- upvalues: self (val), Config (upval), u4 (val)
        while not self.destroyed do
            task.wait(Config.TipInterval)
            if self.destroyed then
                break
            end
            self.tipIndex = self.tipIndex % #u4 + 1
            if not self.lobbyStatusOverride then
                self.statusText:set(u4[self.tipIndex])
            end
        end
    end)
end
function u81:SetLobbyStatus(p2) -- Line: 2109 -- upvalues: Config (val)
    local shuffledTips
    if self.mode ~= "Lobby" or self.destroyed then
        return
    end
    self.lobbyStatusOverride = p2
    if not p2 then
        self.lobbyStatusOverride = nil
        shuffledTips = self.shuffledTips
        if not shuffledTips then
            shuffledTips = Config.Tips
        end
        self.statusText:set(shuffledTips[((self.tipIndex or 1) - 1) % #shuffledTips + 1])
        return
    end
    if p2 ~= "" then
        self.statusText:set(p2)
        return
    end
    self.lobbyStatusOverride = nil
    shuffledTips = self.shuffledTips
    if not shuffledTips then
        shuffledTips = Config.Tips
    end
    self.statusText:set(shuffledTips[((self.tipIndex or 1) - 1) % #shuffledTips + 1])
end
function u81:_trackStoryPlayer(p2, p3) -- Line: 2123 -- upvalues: Players (val)
    if self.storyFolders[p2] or self.destroyed then
        return
    end
    local v1 = math.floor(tonumber(p2:GetAttribute("RosterIndex")) or p3)
    local u20 = math.clamp(v1, 1, 6)
    local u21 = {userId = 0, identityGeneration = 0, ready = false, index = u20}
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
            v1 = not (u23.Value ~= true)
        end
        if v1 and not u21.ready then
            self:_playStorySound("playerReady")
        end
        u21.ready = v1
        self:_setAvatarReady(u20, v1)
        self:_updateStoryStatus()
    end
    local u25 = nil
    local function bindReady(p1) -- Line: 2151 -- upvalues: self (val), p2 (val), u21 (val), u25 (ref), u23 (ref), updateReady (val)
        if self.destroyed then
            return false
        end
        local v1 = self.storyFolders[p2]
        if v1 ~= u21 or not p1 or not (p1:IsA("BoolValue")) then
            return false
        end
        if u25 then
            u25:Disconnect()
            u25 = nil
        end
        u23 = p1
        self:_connect(u23.Changed, updateReady)
        updateReady()
        return true
    end
    if not (bindReady(p2:FindFirstChild("Ready"))) then
        local ChildAdded = p2.ChildAdded
    end
    updateReady()
    local function loadIdentity() -- Line: 2173 -- upvalues: u21 (val), p2 (val), Players (upval), self (val), u20 (ref), u23 (ref)
        local v1
        local v2 = u21
        v2.identityGeneration = v2.identityGeneration + 1
        local v3 = tonumber(p2:GetAttribute("UserId")) or 0
        if v3 <= 0 then
            local v4
            v1, v4 = pcall(Players.GetUserIdFromNameAsync, Players, p2.Name)
            if v1 then
                v3 = v4
            end
        end
        if self.destroyed then
            return
        end
        v1 = self.storyFolders[p2]
        if v1 ~= u21 or u21.identityGeneration ~= u21.identityGeneration then
            return
        end
        u21.userId = v3
        local v5 = u23
        if v5 then
            v5 = u23.Value == true
        end
        self:_spawnAvatar(v3, p2.Name, u20, v5)
    end
    task.spawn(loadIdentity)
    local AttributeChangedSignal = p2:GetAttributeChangedSignal("UserId")
    self:_connect(AttributeChangedSignal, function() -- Line: 2190 -- upvalues: loadIdentity (val)
        task.spawn(loadIdentity)
    end)
end
function u81:_updateStoryStatus() -- Line: 2195 -- upvalues: Config (val)
    local Ready, v1
    if self.mode ~= "Story" or self.destroyed or not self.loadingStatus then
        return
    end
    local v2 = 0
    local v3 = 0
    for k in pairs(self.storyFolders) do
        if k.Parent then
            v3 = v3 + 1
            Ready = k:FindFirstChild("Ready")
            if Ready and Ready.Value then
                v2 = v2 + 1
            end
        end
    end
    local v4 = math.max(tonumber(self.loadingStatus:GetAttribute("ExpectedPlayers")) or 0, v3, 1)
    local Attribute = self.loadingStatus:GetAttribute("Stage")
    local v5 = tonumber(self.loadingStatus:GetAttribute("Countdown")) or -1
    if Attribute == "Waiting" then
        v1 = if v4 <= v2 then v4 <= v3 else false
    else
        v1 = false
        if Attribute ~= "Countdown" then end
    end
    if v1 and not self.storyAllReady then
        self:_playStorySound("allReady")
    end
    self.storyAllReady = v1
    if Attribute ~= "Countdown" or 0 > v5 then
        if v2 < v4 then
            self.statusText:set(Config.StoryLoadingLabel)
            self.countText:set(string.format("%d / %d", v2, v4))
            self.progressValue:set((math.min(v2 / v4, Config.StoryReadyProgress)))
            return
        end
        self.statusText:set(Config.StoryReadyLabel)
        self.countText:set(string.format("%d / %d", v2, v4))
        self.progressValue:set(Config.StoryReadyProgress)
        return
    end
    self.statusText:set(Config.StoryCountdownLabel)
    self.countText:set((tostring((math.max(0, (math.floor(v5)))))))
    self.progressValue:set(1)
    if v5 ~= self.lastCountdown then
        self.lastCountdown = v5
        if v5 > 3 then
            if v5 <= 0 and self.countdownFinalBeep then
                self.countdownFinalBeep:Play()
            end
        elseif 1 <= v5 and self.countdownBeep then
            self.countdownBeep:Play()
        end
    end
    if v5 > Config.StoryUIFadeLeadCount then
        return
    end
    self:_startStoryDepartureFade()
end
function u81:_waitExtraction(p2) -- Line: 2247 -- upvalues: RunService (val)
    local v1 = tonumber(p2) or 0
    while not self.destroyed do
        if os.clock() >= os.clock() + math.max(v1, 0) then
            break
        end
        RunService.Heartbeat:Wait()
    end
    return not self.destroyed
end
function u81:_playExtractionTween(p2, p3, p4) -- Line: 2255 -- upvalues: TweenService (val)
    if self.destroyed or not p2 or not p2.Parent then
        return false
    end
    local v1 = TweenService:Create(p2, p3, p4)
    local activeExtractionTweens = self.activeExtractionTweens
    if not activeExtractionTweens then
        activeExtractionTweens = {}
    end
    self.activeExtractionTweens = activeExtractionTweens
    table.insert(self.activeExtractionTweens, v1)
    v1:Play()
    local v2 = self:_waitExtraction(p3.Time)
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
function u81:_playExtractionTweens(p2, p3) -- Line: 2275 -- upvalues: TweenService (val)
    local instance, v1, v2
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
            v1 = TweenService:Create(instance, p3, v.properties)
            table.insert(v3, v1)
            table.insert(self.activeExtractionTweens, v1)
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
    local v4 = self:_waitExtraction(p3.Time)
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
    if not commendationValueLabel or not commendationValueLabel.Parent or not commendationValueScale or not commendationValueScale.Parent then
        return not self.destroyed
    end
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
    local v5 = self:_playExtractionTweens(v1, TweenInfo.new(Config.ExtractionValueFlashInTime, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
    if v5 then
        v5 = self:_waitExtraction(Config.ExtractionValueFlashHoldTime)
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
        v5 = self:_playExtractionTweens(v2, TweenInfo.new(Config.ExtractionValueFlashOutTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut))
    end
    commendationValueScale.Scale = 1
    commendationValueLabel.TextColor3 = Theme.Menu.AccentCyan
    return v5
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
    self.cameraMove = {
        startedAt = os.clock(),
        duration = v2,
        fromCFrame = self.baseCameraCFrame,
        toCFrame = v1,
        fromFieldOfView = self.fieldOfView,
        toFieldOfView = Config.ExtractionSpotlightFieldOfView,
    }
    self:_playExtractionSound("hydraulic")
    return self:_waitExtraction(v2)
end
function u81:_playCommendation(p2, p3) -- Line: 2370 -- upvalues: resolveCommendationName (val), formatIntegerWithCommas (val), Theme (val), Config (val), TweenService (val)
    local commendationCard = self.commendationCard
    local commendationNameLabel = self.commendationNameLabel
    local commendationTitleLabel = self.commendationTitleLabel
    local commendationDescriptorLabel = self.commendationDescriptorLabel
    local commendationValueLabel = self.commendationValueLabel
    if not commendationCard then
        return false
    elseif not commendationNameLabel then
        return false
    elseif not commendationTitleLabel then
        return false
    elseif not commendationDescriptorLabel then
        return false
    else
        local v1, v2, v3, v4, v5
        if not commendationValueLabel then
            return false
        end
        local v6 = os.clock()
        self.commendationName:set((resolveCommendationName(p2)))
        self.commendationTitle:set(p2.title)
        self.commendationDescriptor:set(p2.descriptor)
        local commendationValue = self.commendationValue
        if not p2.valueIsNumeric then
            v3 = tostring(p2.value)
        else
            v4 = math.max(0, (math.round(tonumber(0) or 0)))
            local v7 = formatIntegerWithCommas(v4)
            if p2.id ~= "DEADEYE" then
                v3 = v7
            else
                v3 = v7 .. "%"
            end
        end
        commendationValue:set(v3)
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
        local v8 = TweenInfo.new(Config.ExtractionNameFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v4 = {TextTransparency = 0, Position = UDim2.new(0, 0, 0, 0)}
        if not (self:_playExtractionTween(commendationNameLabel, v8, v4)) then
            return false
        end
        self:_playExtractionSound("whoosh")
        v8 = TweenInfo.new(Config.ExtractionTitleFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v4 = {TextTransparency = 0, Position = UDim2.new(0, 0, 0, 30)}
        if not (self:_playExtractionTween(commendationTitleLabel, v8, v4)) or not (self:_waitExtraction(Config.ExtractionDescriptorDelay)) then
            return false
        end
        v8 = TweenInfo.new(Config.ExtractionDescriptorFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v4 = {TextTransparency = 0.04}
        if not (self:_playExtractionTween(commendationDescriptorLabel, v8, v4)) then
            return false
        end
        v8 = TweenInfo.new(Config.ExtractionDescriptorFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v4 = {TextTransparency = 0}
        local v9 = TweenService:Create(commendationValueLabel, v8, v4)
        table.insert(self.activeExtractionTweens, v9)
        v9:Play()
        if not p2.valueIsNumeric then
            if not (self:_waitExtraction(Config.ExtractionDescriptorFadeTime)) then
                v9:Cancel()
                v9:Destroy()
                return false
            end
            v1, v5 = self, p3
            v9:Destroy()
            v2 = table.find(v1.activeExtractionTweens, v9)
            if v2 then
                table.remove(v1.activeExtractionTweens, v2)
            end
            local ExtractionSecondsPerPlayer = tonumber(v5)
            if not ExtractionSecondsPerPlayer then
                ExtractionSecondsPerPlayer = Config.ExtractionSecondsPerPlayer
            end
            v4 = ExtractionSecondsPerPlayer - (os.clock() - v6)
            v8 = v4 - Config.ExtractionCardExitTime
            if not (v1:_waitExtraction((math.max(v8, 0)))) then
                return false
            end
            local v10 = TweenInfo.new(Config.ExtractionCardExitTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            return v1:_playExtractionTween(commendationCard, v10, {GroupTransparency = 1})
        else
            local ExtractionValueCountUpTime = tonumber(p2.countUpDuration)
            if not ExtractionValueCountUpTime then
                ExtractionValueCountUpTime = Config.ExtractionValueCountUpTime
            end
            v2 = math.max(ExtractionValueCountUpTime, Config.ExtractionValueMinimumCountUpTime)
            v3 = {id = p2.id}
            v4 = tonumber(p2.value) or 0
            v3.target = math.max(v4, 0)
            v3.startedAt = os.clock()
            v3.duration = v2
            self.countUpState = v3
            self:_playExtractionSound("count")
            if not (self:_waitExtraction(v2)) then
                self.countUpState = nil
                self:_stopExtractionSound("count")
                v9:Cancel()
                v9:Destroy()
                return false
            end
            local v11 = math.max(0, (math.round(tonumber(p2.value) or 0)))
            local v12 = formatIntegerWithCommas(v11)
            if p2.id ~= "DEADEYE" then
                v4 = v12
            else
                v4 = v12 .. "%"
            end
            self.commendationValue:set(v4)
            self.countUpState = nil
            self:_stopExtractionSound("count")
            self:_playExtractionSound("finish")
            if not (self:_flashCommendationValue()) then
                v9:Cancel()
                v9:Destroy()
                return false
            end
            v1, v5 = self, p3
        end
    end
end
function u81:_runExtraction(p2) -- Line: 2494 -- upvalues: Config (val)
    local extractionCover, v1, v2, v3
    if self.mode ~= "Extraction" or self.destroyed then
        return
    end
    if not self.baseCameraCFrame or not self.extractionWideCameraCFrame then
        self:Destroy("ExtractionSceneUnavailable")
        return
    end
    if self.extractionCover then
        extractionCover = self.extractionCover
        v1 = TweenInfo.new(Config.ExtractionCoverFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        self:_playExtractionTween(extractionCover, v1, {BackgroundTransparency = 1})
    end
    if not (self:_waitExtraction(Config.ExtractionIntroHold)) then
        return
    end
    local ExtractionSecondsPerPlayer = tonumber(p2.secondsPerPlayer)
    if not ExtractionSecondsPerPlayer then
        ExtractionSecondsPerPlayer = Config.ExtractionSecondsPerPlayer
    end
    local v4 = math.max(ExtractionSecondsPerPlayer, 1)
    local entries = p2.entries
    if not entries then
        entries = {}
    end
    for i, v in ipairs(entries) do
        if self.destroyed then
            break
        end
        v3 = tonumber(v.presentationSeconds) or v4
        v2 = math.max(v3, 1)
        v3 = math.min(Config.ExtractionCameraMoveTime, v2)
        if not (self:_focusSeat(v.seatIndex, v3)) or not (self:_playCommendation(v, (math.max(v2 - v3, 0)))) then
            break
        end
    end
    self.countUpState = nil
    self:_stopExtractionSound("count")
    if self.commendationCard then
        self.commendationCard.GroupTransparency = 1
    end
    self.cameraMove = {
        startedAt = os.clock(),
        duration = Config.ExtractionCameraMoveTime,
        fromCFrame = self.baseCameraCFrame,
        toCFrame = self.extractionWideCameraCFrame,
        fromFieldOfView = self.fieldOfView,
        toFieldOfView = Config.ExtractionWideFieldOfView,
    }
    self:_waitExtraction(Config.ExtractionCameraMoveTime)
    self:_waitExtraction(Config.ExtractionOutroHold)
    self:_startStoryDepartureFade()
    if self.extractionCover and self.extractionCover.Parent then
        local extractionCover_2 = self.extractionCover
        local v5 = TweenInfo.new(Config.ExtractionCoverFadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        self:_playExtractionTween(extractionCover_2, v5, {BackgroundTransparency = 0})
    end
    if self.destroyed then
        return
    end
    self.extractionAwaitingServerStop = true
    v1 = tonumber(Config.ExtractionServerStopWatchdog) or 0
    local v6 = math.max(v1, 0)
    task.delay(v6, function() -- Line: 2558 -- upvalues: self (val)
        if self.destroyed or not self.extractionAwaitingServerStop then
            return
        end
        warn("[MarauderLoading] Extraction server stop watchdog elapsed; restoring the presentation state")
        self:Destroy("ExtractionStopWatchdog")
    end)
end
function u81:_watchStory(p2) -- Line: 2567 -- upvalues: Workspace (val), Config (val), getEffectsSoundGroup (val), SoundService (val)
    local AttributeChangedSignal
    self.loadingStatus = p2
    task.spawn(function() -- Line: 2569 -- upvalues: Workspace (upval), self (val)
        local Values = Workspace:WaitForChild("Values", 30)
        local LoadingFinished = Values
        if LoadingFinished then
            LoadingFinished = Values:WaitForChild("LoadingFinished", 30)
        end
        if not LoadingFinished or self.destroyed then
            return
        end
        if LoadingFinished.Value then
            self:Destroy("StoryComplete")
            return
        end
        local PropertyChangedSignal = LoadingFinished:GetPropertyChangedSignal("Value")
        self:_connect(PropertyChangedSignal, function() -- Line: 2578 -- upvalues: LoadingFinished (val), self (upval)
            if LoadingFinished.Value then
                self:Destroy("StoryComplete")
            end
        end)
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
        local v2 = tonumber(p1:GetAttribute("RosterIndex")) or (1 / 0)
        local v3 = tonumber(p2:GetAttribute("RosterIndex")) or (1 / 0)
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
    self:_connect(Players.ChildAdded, function(p1) -- Line: 2615 -- upvalues: self (val), Players (val)
        self:_trackStoryPlayer(p1, #Players:GetChildren())
        self:_updateStoryStatus()
    end)
    self:_connect(Players.ChildRemoved, function(p1) -- Line: 2619 -- upvalues: self (val)
        self.storyFolders[p1] = nil
        self:_updateStoryStatus()
    end)
    local v1 = {"ExpectedPlayers", "Stage", "Countdown"}
    for i2, i3 in ipairs(v1) do
        AttributeChangedSignal = p2:GetAttributeChangedSignal(i3)
        self:_connect(AttributeChangedSignal, function() -- Line: 2624 -- upvalues: self (val)
            self:_updateStoryStatus()
        end)
    end
    self:_updateStoryStatus()
end
function u81:_startRenderLoop() -- Line: 2631 -- upvalues: RunService (val)
    self.renderStepName = "MarauderLoading_" .. self.mode
    RunService:BindToRenderStep(self.renderStepName, Enum.RenderPriority.Camera.Value + 10, function(p1) -- Line: 2633 -- upvalues: self (val)
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
    local v1
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
        v1 = TweenInfo.new(1.2, Enum.EasingStyle.Linear)
        TweenService:Create(p2, v1, {Volume = Config.MenuAmbienceVolume}):Play()
    end
    if music then
        v1 = TweenInfo.new(1.2, Enum.EasingStyle.Linear)
        TweenService:Create(music, v1, {Volume = 0}):Play()
    end
    return music
end
function u81.MarkLobbyReady(p1, p2) -- Line: 2667 -- upvalues: Config (val), UserInputService (val), LocalPlayer (val), TweenService (val), u86 (val)
    if p1.mode ~= "Lobby" or p1.destroyed or p1.lobbyReady then
        return
    end
    p1.lobbyReady = true
    task.spawn(function() -- Line: 2672 -- upvalues: Config (upval), p1 (val), UserInputService (upval), LocalPlayer (upval), TweenService (upval), p2 (val), u86 (upval)
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
        while true do
            task.wait()
            if p1.continueRequested or p1.destroyed then
                break
            end
        end
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
        local v2 = TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v3 = TweenService:Create(Frame, v2, {BackgroundTransparency = 0})
        v3:Play()
        v3.Completed:Wait()
        p1:Destroy("LobbyComplete", true)
        local u112 = p1:_crossfadeToMenu(p2)
        local v4 = TweenInfo.new(0.38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v5 = TweenService:Create(Frame, v4, {BackgroundTransparency = 1})
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
end
function u81:Destroy(p2, p3) -- Line: 2737 -- upvalues: u86 (val), RunService (val), Config (val), u83 (val), u84 (ref), u78 (val)
    local renderStepName
    if self.destroyed then
        return
    end
    self.destroyed = true
    self.extractionAwaitingServerStop = false
    if p2 ~= "LobbyComplete" then
        u86[self.mode] = true
    end
    if self.renderStepName then
        RunService:UnbindFromRenderStep(self.renderStepName)
    end
    if self.cameraShake then
        pcall(function() -- Line: 2750 -- upvalues: self (val), Config (upval)
            self.cameraShake:StartFadeOut(Config.StoryCameraShake.FadeOut)
        end)
    end
    if self.cameraShaker then
        self.cameraShaker:Stop()
    end
    self.cameraShake = nil
    self.cameraShaker = nil
    local u269 = self
    for k, v in pairs(self.avatars) do
        local idleTrack = v
        if idleTrack then
            idleTrack = v.idleTrack
        end
        if idleTrack then
            pcall(function() -- Line: 1602 -- upvalues: idleTrack (val), Config (upval)
                idleTrack:Stop(Config.SeatedIdleFadeTime)
                idleTrack:Destroy()
            end)
            v.idleTrack = nil
        end
    end
    local heliSounds = u269.heliSounds
    if not heliSounds then
        heliSounds = {}
    end
    for i, i2 in ipairs(heliSounds) do
        i2:Stop()
        i2:Destroy()
    end
    table.clear(u269.heliSounds)
    table.clear(u269.heliSoundVolumes)
    u269.countUpState = nil
    u269.cameraMove = nil
    local activeExtractionTweens = u269.activeExtractionTweens
    if not activeExtractionTweens then
        activeExtractionTweens = {}
    end
    for i3, j in ipairs(activeExtractionTweens) do
        pcall(function() -- Line: 2771 -- upvalues: j (val)
            j:Cancel()
            j:Destroy()
        end)
    end
    table.clear(u269.activeExtractionTweens)
    local extractionSounds = u269.extractionSounds
    if not extractionSounds then
        extractionSounds = {}
    end
    for k2, k3 in pairs(extractionSounds) do
        k3:Stop()
        k3:Destroy()
    end
    table.clear(u269.extractionSounds)
    local storySounds = u269.storySounds
    if not storySounds then
        storySounds = {}
    end
    for k4, n in pairs(storySounds) do
        n:Stop()
        n:Destroy()
    end
    table.clear(u269.storySounds)
    u269:_dismissArrivalCover()
    for i4, m in ipairs(u269.connections) do
        m:Disconnect()
    end
    table.clear(u269.connections)
    if u269.scope then
        u269.scope:doCleanup()
    end
    if u269.scene then
        u269.scene:Destroy()
    end
    if u269.placeholderFallback then
        u269.placeholderFallback:Destroy()
    end
    if u269.countdownBeep then
        u269.countdownBeep:Destroy()
    end
    if u269.countdownFinalBeep then
        u269.countdownFinalBeep:Destroy()
    end
    if u269.music and not v1 then
        u269.music:Destroy()
    end
    u269:_restorePresentationState(v2)
    if u83[u269.mode] == u269 then
        u83[u269.mode] = nil
        local v3 = next(u83) ~= nil
        if u84 ~= v3 then
            u84 = v3
            u78.PresentingChanged:Fire(u84)
        end
    end
end
local function newSession(p1, p2) -- Line: 2817 -- upvalues: u81 (val), u85 (val), u86 (val), u87 (val), u83 (val), u84 (ref), u78 (val)
    local v1
    local v2 = {
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
        seatedIdleSeed = math.floor(os.clock() * 1000000) % 2147483647,
        parallax = Vector2.zero,
        parallaxVelocity = Vector2.zero,
        gamepadParallax = Vector2.zero,
        touchParallax = Vector2.zero,
    }
    local u29 = setmetatable(v2, u81)
    if p1 == "Extraction" and type(p2) == "table" then
        local pendingAvatarEntries, v3, v4
        local entries = p2.entries
        if not entries then
            entries = {}
        end
        for i, v in ipairs(entries) do
            v4 = math.floor(tonumber(v.seatIndex) or 1)
            v3 = math.clamp(v4, 1, 6)
            u29.extractionAvatarSeats[v3] = true
            pendingAvatarEntries = u29.pendingAvatarEntries
            pendingAvatarEntries[v3] = {ready = true, userId = tonumber(v.userId) or 0, name = v.name}
        end
    end
    u85[p1] = false
    u86[p1] = false
    u87[p1] = false
    u83[p1] = u29
    v2 = next(u83) ~= nil
    if u84 ~= v2 then
        u84 = v2
        u78.PresentingChanged:Fire(u84)
    end
    v2, v1 = xpcall(function() -- Line: 2856 -- upvalues: u29 (val), p1 (val), p2 (val), u87 (upval)
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
                local v1, v2
                v1, v2 = xpcall(function() -- Line: 2871 -- upvalues: u29 (upval), p2 (upval)
                    u29:_watchStory(p2)
                end, debug.traceback)
                if not v1 and not u29.destroyed then
                    warn("[MarauderLoading] Story status binding failed:\n" .. tostring(v2))
                end
            end)
        end
        task.spawn(function() -- Line: 2879 -- upvalues: u29 (upval), p1 (upval), p2 (upval), u87 (upval)
            local v1, v2
            v1, v2 = xpcall(function() -- Line: 2880 -- upvalues: u29 (upval), p1 (upval), p2 (upval)
                u29:_prepareScene()
                if p1 == "Extraction" and not u29.destroyed then
                    u29:_runExtraction(p2)
                end
            end, debug.traceback)
            if not v1 then
                warn("[MarauderLoading] 3D presentation failed; keeping the UI fallback:\n" .. tostring(v2))
                u87[p1] = true
                u29:_dismissArrivalCover()
                if p1 == "Extraction" then
                    u29:Destroy("ExtractionError")
                end
            end
        end)
    end, debug.traceback)
    if not v2 then
        u29:Destroy("InitializationFailed")
        error(v1, 0)
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
    while not (u85[p1]) do
        task.wait(0.05)
        if os.clock() + (tonumber(p2) or 15) <= os.clock() then
            v1 = u85[p1] == true
            return v1
        end
    end
    return true
end
function u78.WaitUntilSceneReady(p1, p2) -- Line: 2957 -- upvalues: u87 (val)
    local v1
    while not (u87[p1]) do
        task.wait(0.05)
        if os.clock() + (tonumber(p2) or 15) <= os.clock() then
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