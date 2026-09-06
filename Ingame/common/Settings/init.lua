local v1, v2, v3, v4, v5, v6, v7
if game:GetService("RunService"):IsServer() then
    return {}
end
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u251 = Fusion.scoped(Fusion)
local peek = Fusion.peek
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local v8 = require(script.SettingsGui)(u251, GameState.Data.IsLobby)
local Panel = v8.Panel
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u267 = require("@game/ReplicatedStorage/common/Icon")
local ZSLib = require(script:WaitForChild("ZSLib"))
require(script:WaitForChild("BannerNotificationModule"))
local v9 = require("@game/ReplicatedStorage/common/Signal")
local u274 = require("@self/DefaultSettings")
local u278 = require("@self/MainMenuThemes")
local SettingsEvent = require(RedEvents.General.SettingsEvent)
local SettingsFunction = require(RedEvents.General.SettingsFunction)
local u286 = nil
local u290 = nil
local u294 = nil
local u298 = nil
local u302 = nil
local u306 = nil
local u310 = {Scope = u251, SettingsChanged = v9.new(), OpenChanged = v9.new()}
local click = script:WaitForChild("click")
local v10 = require(script:WaitForChild("VisibilityController")).new(v8, function(p1) -- Line: 47 -- upvalues: click (val), u310 (val)
    click:Play()
    u310.OpenChanged:Fire(p1)
end, function() -- Line: 50 -- upvalues: u310 (val)
    if u310.SettingsIcon and u310.SettingsIcon.isSelected then
        u310.SettingsIcon:deselect()
    end
end)
local SetOpened = v10.SetOpened
u310.SetSuppressed = v10.SetSuppressed
v8.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
local MarauderLoading = require(ReplicatedStorage.common.ZS_Framework.UI.MarauderLoading)
MarauderLoading.PresentingChanged:Connect(function(p1) -- Line: 60 -- upvalues: u310 (val)
    u310.SetSuppressed("LoadingPresentation", p1)
end)
u310.SetSuppressed("LoadingPresentation", MarauderLoading.IsPresenting())
v2, v3 = SettingsFunction:Call({Type = "GetSavedSettings"}):Await()
if not v2 then
    v1 = u274
elseif v3 then
    v1 = v3
end
if not v2 then
    warn("[Settings] Could not fetch saved settings, using defaults")
end
v2 = v1
v3 = nil
local v11 = nil
for i, j in v2, v3, v11 do
    u310[i] = {}
    v4 = j
    v5 = nil
    v6 = nil
    for k, n in v4, v5, v6 do
        if typeof(n) ~= "table" then
            local u326 = u251:Value(n)
            u310[i][k] = u326
            v7 = u251:Observer(u326)
            v7:onChange(function() -- Line: 88 -- upvalues: i (val), k (val), u310 (val), peek (val), u326 (val)
                u310.SettingsChanged:Fire({i, k}, peek(u326))
            end)
        else
            u310[i][k] = n
        end
    end
end
if u310.Graphics and u310.Graphics.QualityTier then
    Players.LocalPlayer:SetAttribute("QualityTier", peek(u310.Graphics.QualityTier))
    v2 = u251:Observer(u310.Graphics.QualityTier)
    v2:onChange(function() -- Line: 101 -- upvalues: Players (val), peek (val), u310 (val)
        Players.LocalPlayer:SetAttribute("QualityTier", peek(u310.Graphics.QualityTier))
    end)
end
Panel.Header.Exit.MouseButton1Click:Connect(function() -- Line: 107 -- upvalues: SetOpened (val)
    SetOpened(false)
end)
function u310.Init(p1) -- Line: 112 -- upvalues: ZSLib (val), Panel (val), u310 (val), u286 (ref), peek (val), GameState (val), Players (val), u274 (val), u290 (ref), ReplicatedStorage (val), SetOpened (val), u294 (ref), u251 (val), u298 (ref), u302 (ref), u306 (ref), u278 (val), u267 (val), SettingsEvent (val)
    local Data, P, clock, v1, v2
    local v3 = ZSLib:Init(Panel, u310.SettingsChanged)
    u286 = v3:Tab("GRAPHICS")
    u286:Header("DISPLAY")
    local v4 = peek(u310.Graphics.BaseFOV)
    u286:Number("FIELD OF VIEW", v4, function(p1) -- Line: 123 -- upvalues: u310 (upval)
        u310.Graphics.BaseFOV:set(p1)
    end, 40, 110, 0.014285714285714285)
    local v5 = peek(u310.Graphics.BulletTracers)
    local u42 = u286:Toggle("BULLET TRACERS", v5, function(p1) -- Line: 130 -- upvalues: u310 (upval)
        u310.Graphics.BulletTracers:set(p1)
    end, "Show bullet trails when shooting.")
    local v6 = peek(u310.Graphics.BulletShells)
    local u54 = u286:Toggle("BULLET SHELLS", v6, function(p1) -- Line: 136 -- upvalues: u310 (upval)
        u310.Graphics.BulletShells:set(p1)
    end, "Show bullet shell ejection effects.")
    local v7 = peek(u310.Graphics.AnimatedTextures)
    local u65 = u286:Toggle("ANIMATED TEXTURES", v7, function(p1) -- Line: 143 -- upvalues: u310 (upval)
        u310.Graphics.AnimatedTextures:set(p1)
    end)
    local v8 = peek(u310.Graphics.BulletHoles)
    local u77 = u286:Toggle("BULLET HOLES", v8, function(p1) -- Line: 148 -- upvalues: u310 (upval)
        u310.Graphics.BulletHoles:set(p1)
    end, "Create bullet holes upon shooting.")
    u286:Header("ZOMBIES")
    local u83 = {
        {"VERY LOW", 4},
        {"LOW", 3},
        {"MEDIUM", 2},
        {"HIGH", 1},
    }
    local v9 = u83[peek(u310.Graphics.ZombieQuality)][1]
    local u110 = u286:Dropdown("ZOMBIE QUALITY", u83, v9, function(p1, p2) -- Line: 165 -- upvalues: u310 (upval)
        u310.Graphics.ZombieQuality:set(p1)
    end, "The detail level of zombie models.")
    v9 = peek(u310.Graphics.Flinching)
    local u122 = u286:Toggle("FLINCHING", v9, function(p1) -- Line: 171 -- upvalues: u310 (upval)
        u310.Graphics.Flinching:set(p1)
    end, "Zombies will flinch when shot.")
    local v10 = peek(u310.Graphics.Ragdolls)
    local u134 = u286:Toggle("RAGDOLLS", v10, function(p1) -- Line: 175 -- upvalues: u310 (upval)
        u310.Graphics.Ragdolls:set(p1)
    end, "Zombies will ragdoll on death.")
    local v11 = peek(u310.Graphics.RagdollTimer)
    local u148 = u286:Number("RAGDOLL TIME", v11, function(p1) -- Line: 181 -- upvalues: u310 (upval)
        u310.Graphics.RagdollTimer:set(p1)
    end, 0, 4, 0.0625)
    local v12 = peek(u310.Graphics.ArmorDestroyEffect)
    local u160 = u286:Toggle("ARMOR DESTROY EFFECT", v12, function(p1) -- Line: 188 -- upvalues: u310 (upval)
        u310.Graphics.ArmorDestroyEffect:set(p1)
    end, "Animations for armor flying off when broken.")
    local v13 = peek(u310.Graphics.HeadgearHeadshot)
    local u172 = u286:Toggle("HEADGEAR EFFECT", v13, function(p1) -- Line: 197 -- upvalues: u310 (upval)
        u310.Graphics.HeadgearHeadshot:set(p1)
    end, "Headgear flies off on headshot kill.")
    local u173 = {
        {"DISABLED", 4},
        {"LOW", 3},
        {"MEDIUM", 2},
        {"HIGH", 1},
    }
    local v14 = u173[peek(u310.Graphics.ParticleQuality)][1]
    local u200 = u286:Dropdown("PARTICLE QUALITY", u173, v14, function(p1, p2) -- Line: 214 -- upvalues: u310 (upval)
        u310.Graphics.ParticleQuality:set(p1)
    end, "Set the quality of blood and impact effects.")
    u286:Header("MISC")
    v14 = peek(u310.Graphics.HideNearbyPlayers)
    local u217 = u286:Toggle("HIDE NEARBY PLAYERS", v14, function(p1) -- Line: 225 -- upvalues: u310 (upval)
        u310.Graphics.HideNearbyPlayers:set(p1)
    end, "Nearby player characters will be made transparent.")
    local v15 = peek(u310.Graphics.ProceduralAnimations)
    local u229 = u286:Toggle("PROCEDURAL ANIMATIONS", v15, function(p1) -- Line: 234 -- upvalues: u310 (upval)
        u310.Graphics.ProceduralAnimations:set(p1)
    end, "Use procedural IK leg animations instead of default walk.")
    local v16 = peek(u310.Graphics.ShowMeleeHitboxes)
    local u241 = u286:Toggle("SHOW MELEE HITBOXES", v16, function(p1) -- Line: 243 -- upvalues: u310 (upval)
        u310.Graphics.ShowMeleeHitboxes:set(p1)
    end, "Show raycast hitboxes when swinging melee.")
    local v17 = peek(u310.Graphics.DisplayDamageIndicators)
    local u253 = u286:Toggle("DISPLAY DAMAGE INDICATORS", v17, function(p1) -- Line: 252 -- upvalues: u310 (upval)
        u310.Graphics.DisplayDamageIndicators:set(p1)
    end, "Show damage dealt per hit on each shot.")
    local RunService_2 = nil
    if GameState.Data.IsLobby and workspace:GetAttribute("LobbyQualityTiers") == true then
        local v18
        u286:Header("PERFORMANCE")
        local u281 = {"Auto", "High", "Medium", "Low"}
        local v19 = {Auto = "AUTO", High = "HIGH", Medium = "MEDIUM", Low = "LOW"}
        local u287 = {
            High = {zombie = 4, particle = 4, procedural = true, animated = true},
            Medium = {zombie = 3, particle = 3, procedural = true, animated = true},
            Low = {zombie = 1, particle = 1, procedural = false, animated = false},
        }
        local function resolveAutoTier() -- Line: 285 -- upvalues: Players (upval)
            local UserInputService = game:GetService("UserInputService")
            local TouchEnabled = UserInputService.TouchEnabled
            if TouchEnabled then
                TouchEnabled = not UserInputService.KeyboardEnabled
            end
            local v1 = Players.LocalPlayer:GetAttribute("ClientCPULoad") or 0
            if TouchEnabled or 60 <= v1 then
                return "Low"
            end
            if 35 <= v1 then
                return "Medium"
            end
            return "High"
        end
        local function applyQualityTier(p1) -- Line: 297 -- upvalues: Players (upval), u287 (val), u310 (upval), u110 (val), u83 (val), u200 (val), u173 (val), u229 (val), u65 (val)
            local v1
            if p1 ~= "Auto" then
                v1 = p1
            else
                local UserInputService = game:GetService("UserInputService")
                local TouchEnabled = UserInputService.TouchEnabled
                if TouchEnabled then
                    TouchEnabled = not UserInputService.KeyboardEnabled
                end
                local v2 = Players.LocalPlayer:GetAttribute("ClientCPULoad") or 0
                if TouchEnabled then
                    v1 = "Low"
                elseif 60 <= v2 then
                    v1 = "Low"
                elseif 35 > v2 then
                    v1 = "High"
                else
                    v1 = "Medium"
                end
            end
            local v3 = u287[v1]
            if not v3 then
                return
            end
            u310.Graphics.ZombieQuality:set(v3.zombie)
            u110:set(u83[v3.zombie][1])
            u310.Graphics.ParticleQuality:set(v3.particle)
            u200:set(u173[v3.particle][1])
            u310.Graphics.ProceduralAnimations:set(v3.procedural)
            u229(v3.procedural)
            u310.Graphics.AnimatedTextures:set(v3.animated)
            u65(v3.animated)
            u310.SettingsChanged:Fire()
        end
        if not u310.Graphics.QualityTier then
            v18 = "AUTO"
        else
            v18 = v19[peek(u310.Graphics.QualityTier)]
        end
        RunService_2 = u286:Dropdown("QUALITY TIER", {
            {"AUTO", 1},
            {"HIGH", 2},
            {"MEDIUM", 3},
            {"LOW", 4},
        }, v18, function(p1, p2) -- Line: 319 -- upvalues: u281 (val), u310 (upval), applyQualityTier (val)
            local v1 = u281[p1] or "Auto"
            u310.Graphics.QualityTier:set(v1)
            applyQualityTier(v1)
        end, "Quickly set overall graphics quality. Auto adapts to your device; adjusting any setting below fine-tunes it.")
    end
    local function resetDefault() -- Line: 328 -- upvalues: u310 (upval), u274 (upval), u54 (val), u77 (val), u172 (val), u160 (val), u122 (val), u134 (val), u148 (val), u217 (val), u42 (val), u65 (val), u229 (val), u241 (val), u253 (val), u110 (val), u83 (val), peek (upval), u200 (val), u173 (val), RunService_2 (ref)
        u310.Graphics.Ragdolls:set(true)
        u310.Graphics.RagdollTimer:set(4)
        u310.Graphics.BulletTracers:set(true)
        u310.Sound.RagdollSounds:set(true)
        u310.Graphics.Flinching:set(true)
        u310.Graphics.HideNearbyPlayers:set(false)
        u310.Graphics.HeadgearHeadshot:set(false)
        u310.Graphics.ArmorDestroyEffect:set(true)
        u310.Graphics.BulletHoles:set(true)
        u310.Graphics.ShowMeleeHitboxes:set(false)
        u310.Graphics.ZombieQuality:set(4)
        u310.Graphics.ParticleQuality:set(4)
        u310.Graphics.AnimatedTextures:set(u274.Graphics.AnimatedTextures)
        u310.Graphics.BulletShells:set(true)
        u54(true)
        u77(true)
        u172(false)
        u160(true)
        u122(true)
        u134(true)
        u148(4)
        u217(false)
        u42(true)
        u65(u274.Graphics.AnimatedTextures)
        u229(true)
        u310.Graphics.ProceduralAnimations:set(true)
        u241(false)
        u310.Graphics.DisplayDamageIndicators:set(false)
        u253(false)
        u110:set(u83[peek(u310.Graphics.ZombieQuality)][1])
        u200:set(u173[peek(u310.Graphics.ParticleQuality)][1])
        u310.Graphics.QualityTier:set("Auto")
        if RunService_2 then
            RunService_2:set("AUTO")
        end
        u310.SettingsChanged:Fire()
    end
    local v20 = Color3.fromRGB(255, 73, 73)
    local v21 = Color3.fromRGB(49, 49, 49)
    u286:Button("RESET TO DEFAULT", "RESET", function() -- Line: 369 -- upvalues: resetDefault (val)
        resetDefault()
    end, v20, v21, Color3.fromRGB(255, 73, 73))
    v17 = u286.UIElements["RESET TO DEFAULT"]
    v17.LayoutOrder = 999
    u290 = v3:Tab("MOBILE")
    v1 = {
        {"HOTBAR", 1},
        {"SWAP", 2},
        {"DPAD", 3},
    }
    v6 = v1[peek(u310.Controls.MobileSelectionMode)][1]
    u290:Dropdown("WEAPON SELECTION", v1, v6, function(p1, p2) -- Line: 390 -- upvalues: u310 (upval)
        u310.Controls.MobileSelectionMode:set(p1)
    end, "How weapons are selected on mobile.")
    v5 = peek(u310.Controls.AutoShoot)
    u290:Toggle("AUTO SHOOT", v5, function(p1) -- Line: 396 -- upvalues: u310 (upval)
        u310.Controls.AutoShoot:set(p1)
    end, "Auto shoot an enemy by hovering over them.")
    v5 = peek(u310.Controls.AutoJump)
    u290:Toggle("AUTO JUMP", v5, function(p1) -- Line: 400 -- upvalues: u310 (upval)
        u310.Controls.AutoJump:set(p1)
    end, "Automatically jump over obstacles.")
    v5 = peek(u310.Controls.DynamicStaminaUI)
    u290:Toggle("DYNAMIC STAMINA UI", v5, function(p1) -- Line: 404 -- upvalues: u310 (upval)
        u310.Controls.DynamicStaminaUI:set(p1)
    end, "Move stamina ui to center when using melee.")
    v5 = peek(u310.Controls.ShowEditButton)
    u290:Toggle("SHOW EDIT BUTTON", v5, function(p1) -- Line: 408 -- upvalues: u310 (upval)
        u310.Controls.ShowEditButton:set(p1)
    end, "Show the edit button on the mobile HUD.")
    v5 = peek(u310.Controls.HotbarScale)
    u290:Number("HOTBAR SCALE", v5, function(p1) -- Line: 416 -- upvalues: u310 (upval)
        u310.Controls.HotbarScale:set(p1)
    end, 0.5, 1.5, 0.05)
    u290:Button("EDIT MOBILE CONTROLS", "EDIT", function() -- Line: 420 -- upvalues: ReplicatedStorage (upval), SetOpened (upval)
        local Element = require(ReplicatedStorage.common:WaitForChild("HUDService")):GetElement("MobileControls")
        if Element then
            SetOpened(false)
            task.defer(function() -- Line: 425 -- upvalues: Element (val)
                Element:EnterEditMode()
            end)
        end
    end)
    u294 = v3:Tab("CONTROLS")
    v4 = peek(u310.Controls.Sensitivity)
    u294:Number("SENSITIVITY", v4, function(p1) -- Line: 437 -- upvalues: u310 (upval)
        u310.Controls.Sensitivity:set(p1)
    end, 0, 10, 0.0001)
    v4 = peek(u310.Controls.AimingSensitivity)
    u294:Number("ADS SENSITIVITY", v4, function(p1) -- Line: 441 -- upvalues: u310 (upval)
        u310.Controls.AimingSensitivity:set(p1)
    end, 0, 10, 0.0001)
    v1 = {
        {"SWAP", 1},
        {"DPAD", 2},
    }
    v5 = peek(u310.Controls.ShowControlHints)
    local u553 = u294:Toggle("SHOW CONTROL HINTS", v5, function(p1) -- Line: 453 -- upvalues: u310 (upval)
        u310.Controls.ShowControlHints:set(p1)
    end, "Show contextual input hints on screen.")
    v2 = u251:Observer(u310.Controls.ShowControlHints)
    v2:onChange(function() -- Line: 458 -- upvalues: u553 (val), peek (upval), u310 (upval)
        u553(peek(u310.Controls.ShowControlHints))
    end)
    v7 = v1[peek(u310.Controls.GamepadSelectionMode)][1]
    u294:Dropdown("GAMEPAD WEAPON SELECTION", v1, v7, function(p1, p2) -- Line: 466 -- upvalues: u310 (upval)
        u310.Controls.GamepadSelectionMode:set(p1)
    end, "How weapons are selected on gamepad.")
    u298 = v3:Tab("CAMERA")
    v4 = peek(u310.Camera.ScrollWheelZoom)
    u298:Toggle("SCROLL WHEEL ZOOM", v4, function(p1) -- Line: 477 -- upvalues: u310 (upval)
        u310.Camera.ScrollWheelZoom:set(p1)
    end, "Use scroll wheel to zoom camera in and out.")
    v1 = {
        {"RIGHT", 1},
    }
    local v22 = {"LEFT", 2}
    v1[2] = v22
    v6 = v1[peek(u310.Camera.ThirdPersonSide)][1]
    u298:Dropdown("THIRD PERSON SIDE", v1, v6, function(p1, p2) -- Line: 490 -- upvalues: u310 (upval)
        u310.Camera.ThirdPersonSide:set(p1)
    end, "Default shoulder side in third person.")
    v5 = peek(u310.Camera.MaxCameraDistance)
    u298:Number("MAX CAMERA DISTANCE", v5, function(p1) -- Line: 498 -- upvalues: u310 (upval)
        u310.Camera.MaxCameraDistance:set(p1)
    end, 1, 10, 0.1111111111111111)
    v5 = peek(u310.Camera.PinchToZoom)
    u298:Toggle("PINCH TO ZOOM", v5, function(p1) -- Line: 502 -- upvalues: u310 (upval)
        u310.Camera.PinchToZoom:set(p1)
    end, "Allow pinch gesture to zoom on mobile.")
    u302 = v3:Tab("MAIN MENU")
    v4 = peek(u310.MainMenu.TradeEnabled)
    u302:Toggle("TRADE ENABLED", v4, function(p1) -- Line: 511 -- upvalues: u310 (upval)
        u310.MainMenu.TradeEnabled:set(p1)
    end, "Enable sending and receiving trade requests.")
    v4 = peek(u310.MainMenu.ShowLevel)
    u302:Toggle("SHOW LEVEL", v4, function(p1) -- Line: 515 -- upvalues: u310 (upval)
        u310.MainMenu.ShowLevel:set(p1)
    end, "Show level to other players in queues.")
    v4 = peek(u310.MainMenu.ShowStats)
    u302:Toggle("SHOW STATS", v4, function(p1) -- Line: 519 -- upvalues: u310 (upval)
        u310.MainMenu.ShowStats:set(p1)
    end, "Show stats to other players in queues.")
    u306 = v3:Tab("SOUND")
    v1 = {}
    local Options = u278.Options
    v2 = nil
    v4 = nil
    for i, j in Options, v2, v4 do
        v1[i] = {j.Label, j.Order}
    end
    v5 = peek(u310.Sound.RagdollSounds)
    u306:Toggle("RAGDOLL SOUNDS", v5, function(p1) -- Line: 533 -- upvalues: u310 (upval)
        u310.Sound.RagdollSounds:set(p1)
    end, "Zombies will play sounds when ragdolling.")
    v5 = peek(u310.Sound.MusicVolume)
    u306:Number("MUSIC VOLUME", v5, function(p1) -- Line: 537 -- upvalues: u310 (upval)
        u310.Sound.MusicVolume:set(p1)
    end, 0, 10, 0.01)
    local MainMenuTheme = peek(u310.Sound.MainMenuTheme)
    if not (v1[MainMenuTheme]) then
        u310.Sound.MainMenuTheme:set(u274.Sound.MainMenuTheme)
    end
    u306:Dropdown("MAIN MENU THEME", v1, v1[MainMenuTheme][1], function(p1, p2) -- Line: 551 -- upvalues: u310 (upval)
        u310.Sound.MainMenuTheme:set(p1)
    end, "The music that will play in the main menu.")
    require("@self/Binding").CreateSection(v3)
    v2 = game:GetService("RunService"):IsStudio()
    P = if v2 then Enum.KeyCode.P else Enum.KeyCode.P
    local Sound = nil
    local Music = 0
    Data = nil
    local AttributeChangedSignal = Players.LocalPlayer:GetAttributeChangedSignal("ZBucksPickedUp")
    AttributeChangedSignal:Connect(function() -- Line: 573 -- upvalues: Sound (ref), u267 (upval), Data (ref), Players (upval), Music (ref)
        local v1
        if not Sound then
            Sound = u267.new()
        end
        local v2 = tick()
        Data = v2
        local Attribute = Players.LocalPlayer:GetAttribute("ZBucksPickedUp")
        local v3 = Music
        if Music >= Attribute then
            v1 = -1
        else
            v1 = 1
        end
        while Data == v2 do
            if v3 == Attribute then
                break
            end
            v3 = v3 + v1
            Music = v3
            Sound:setLabel("Z$ " .. v3)
            task.wait(0.05)
        end
    end)
    v8 = u267.new():setImage(7059346373)
    v8 = v8:setLabel("Close", "selected")
    v8 = v8:setLabel("P", "deselected")
    v8 = v8:bindEvent("selected", function(p1) -- Line: 597 -- upvalues: SetOpened (upval)
        if not (SetOpened(true)) then
            task.defer(function() -- Line: 599 -- upvalues: p1 (val)
                p1:deselect()
            end)
        end
    end)
    v8 = v8:bindEvent("deselected", function(p1) -- Line: 604 -- upvalues: SetOpened (upval)
        SetOpened(false)
    end)
    local u817 = v8:bindToggleKey(P)
    u310.SettingsIcon = u817
    local v23 = u267.new():setLabel("FPS: 0")
    v23 = v23:setTextFont(Enum.Font.SourceSans)
    v23 = v23:align("Right"):lock():setOrder(1)
    local u845 = v23:bindEvent("selected", function(p1) -- Line: 617
        p1:deselect()
    end)
    local v24 = u267.new():setLabel("CPU: 0")
    v24 = v24:align("Right"):lock():setOrder(2)
    local u868 = v24:bindEvent("selected", function(p1) -- Line: 626
        p1:deselect()
    end)
    game:GetService("UserInputService").InputBegan:Connect(function(p1) -- Line: 630 -- upvalues: u817 (val)
        if p1.UserInputType == Enum.UserInputType.Touch or p1.UserInputType == Enum.UserInputType.Gamepad1 then
            u817:setLabel("", "deselected")
            return
        end
        if p1.UserInputType == Enum.UserInputType.Keyboard then
            u817:setLabel("P", "deselected")
        end
    end)
    v9 = u267.new():setLabel("0 ms")
    v9 = v9:align("Right"):lock():setOrder(3)
    local u901 = v9:bindEvent("selected", function(p1) -- Line: 646
        p1:deselect()
    end)
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local u913 = nil
    local u914 = nil
    local u915 = 0
    local u916 = nil
    local u917 = "FPS: 0"
    RunService_2 = game:GetService("RunService")
    if not (RunService_2:IsRunning()) then
        clock = os.clock
    else
        clock = time
        if not clock then
            clock = os.clock
        end
    end
    local u928 = nil
    local u929 = nil
    local u930 = {}
    RunService_2.Heartbeat:Connect(function() -- Line: 665 -- upvalues: u928 (ref), clock (val), u930 (val), u917 (ref), u929 (ref)
        local v1, v2, v3, v4
        u928 = clock()
        local v5 = 1
        local v6 = -1
        for i = #u930, v5, v6 do
            v2 = u930
            v4 = u930[i]
            if u928 - 1 > v4 then
                v3 = nil
            else
                v3 = u930[i]
            end
            v2[i + 1] = v3
        end
        u930[1] = u928
        v2 = clock() - u929
        if 1 > v2 then
            v1 = #u930 / (clock() - u929)
        else
            v1 = #u930
            if not v1 then
                v1 = #u930 / (clock() - u929)
            end
        end
        u917 = tostring((math.floor(v1)))
    end)
    task.defer(function() -- Line: 683 -- upvalues: u868 (val), u915 (ref), u845 (val), u917 (ref), u901 (val), LocalPlayer (val)
        local Attribute, v1
        while task.wait() do
            u868:setLabel("CPU: " .. u915)
            u845:setLabel("FPS: " .. u917)
            Attribute = workspace:GetAttribute("ServerLocation")
            if Attribute then
                v1 = math.ceil(LocalPlayer:GetNetworkPing() * 1000)
                u901:setLabel(Attribute .. v1 .. " ms")
            end
        end
    end)
    task.defer(function() -- Line: 696 -- upvalues: u913 (ref), u914 (ref), RunService (val), u915 (ref), u916 (ref), LocalPlayer (val)
        local v1
        while true do
            u913 = 60
            u914 = os.clock()
            while 0 < u913 do
                RunService.Heartbeat:Wait()
                u913 = u913 - 1
            end
            u915 = math.round((1 - 60 / (os.clock() - u914) / 60) * 100)
            u916 = math.round((1 - workspace:GetRealPhysicsFPS() / 60) * 100)
            v1 = u915 + u916
            if v1 >= 1 then
                v1 = u915 + u916
                if 100 >= v1 then
                    u915 = u915 + u916
                    LocalPlayer:SetAttribute("ClientCPULoad", u915)
                else
                    u915 = 100
                end
            else
                u915 = 0
            end
        end
    end)
    v3:SetContainer(u286)
    local function setMusicVolume(p1) -- Line: 725 -- upvalues: GameState (upval)
        local v1
        local Music = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
        Music:SetAttribute("Volume", p1)
        if GameState.Data.Variables.DefaultMusicEnabled then
            v1 = p1
        else
            v1 = 0
        end
        Music.Volume = v1
    end
    v4 = peek(u310.Sound.MusicVolume)
    Sound = game.SoundService:WaitForChild("Primary")
    Music = Sound:WaitForChild("Music")
    Music:SetAttribute("Volume", v4)
    Data = GameState.Data.Variables.DefaultMusicEnabled
    if not Data then
        v4 = 0
    end
    Music.Volume = v4
    function Music() -- Line: 739 -- upvalues: peek (upval), u310 (upval), GameState (upval)
        local v1 = peek(u310.Sound.MusicVolume)
        local Music = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
        Music:SetAttribute("Volume", v1)
        if not GameState.Data.Variables.DefaultMusicEnabled then
            v1 = 0
        end
        Music.Volume = v1
    end
    GameState.Signals.Variables.DefaultMusicEnabled:Connect(Music)
    function Music(p1, p2) -- Line: 743 -- upvalues: SettingsEvent (upval), GameState (upval)
        SettingsEvent:FireServer({Type = "SetSetting", SettingPath = p1, NewValue = p2})
        if typeof(p1) == "table" then
            if p1[1] == "Sound" and p1[2] == "MusicVolume" then
                local v1 = p2
                local Music = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
                Music:SetAttribute("Volume", v1)
                if not GameState.Data.Variables.DefaultMusicEnabled then
                    v1 = 0
                end
                Music.Volume = v1
            end
            if p1[1] == "Graphics" and p1[2] == "ShowMeleeHitboxes" then
                local v2
                if p2 ~= true then
                    v2 = nil
                else
                    v2 = true
                end
                workspace:SetAttribute("DebugMelee", v2)
            end
        end
    end
    u310.SettingsChanged:Connect(Music)
end
return u310