local v1, v2, v3, v4
if game:GetService("RunService"):IsServer() then
    return {}
end
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage.common
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u251 = Fusion.scoped(Fusion)
local peek = Fusion.peek
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local v5 = require(script.SettingsGui)(u251, GameState.Data.IsLobby)
local Panel = v5.Panel
local RedEvents = game.ReplicatedStorage.common.RedEvents
local u267 = require("@game/ReplicatedStorage/common/Icon")
local ZSLib = require(script:WaitForChild("ZSLib"))
require(script:WaitForChild("BannerNotificationModule"))
local v6 = require("@game/ReplicatedStorage/common/Signal")
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
local u310 = {}
u310.Scope = u251
u310.SettingsChanged = v6.new()
u310.OpenChanged = v6.new()
local click = script:WaitForChild("click")
local v7 = require
local VisibilityController = script:WaitForChild("VisibilityController")
v7 = (v7(VisibilityController)).new(v5, function(p1) -- Line: 47 -- upvalues: click (val), u310 (val)
    click:Play()
    u310.OpenChanged:Fire(p1)
end, function() -- Line: 50 -- upvalues: u310 (val)
    if u310.SettingsIcon and u310.SettingsIcon.isSelected then
        u310.SettingsIcon:deselect()
    end
end)
local SetOpened = v7.SetOpened
u310.SetSuppressed = v7.SetSuppressed
v5.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
local MarauderLoading = require(ReplicatedStorage.common.ZS_Framework.UI.MarauderLoading)
MarauderLoading.PresentingChanged:Connect(function(p1) -- Line: 60 -- upvalues: u310 (val)
    u310.SetSuppressed("LoadingPresentation", p1)
end)
u310.SetSuppressed("LoadingPresentation", MarauderLoading.IsPresenting())
local v8, v9 = SettingsFunction:Call({Type = "GetSavedSettings"}):Await()
if not v8 or not v9 then
    v1 = u274
else
    v1 = v9
end
if not v8 then
    warn("[Settings] Could not fetch saved settings, using defaults")
end
v8 = v1
v9 = nil
local v10 = nil
for i, j in v8, v9, v10 do
    u310[i] = {}
    v2 = j
    v3 = nil
    v4 = nil
    for k, n in v2, v3, v4 do
        if typeof(n) ~= "table" then
            local u326 = u251:Value(n)
            u310[i][k] = u326
            ;(u251:Observer(u326)):onChange(function() -- Line: 88 -- upvalues: i (val), k (val), u310 (val), peek (val), u326 (val)
                local v1 = {i, k}
                local v2 = u310
                local SettingsChanged = v2.SettingsChanged
                local v3 = peek
                local v4 = u326
                v3 = v3(v4)
                SettingsChanged:Fire(v1, v3)
            end)
        else
            u310[i][k] = n
        end
    end
end
if u310.Graphics and u310.Graphics.QualityTier then
    local LocalPlayer = Players.LocalPlayer
    local QualityTier = u310.Graphics.QualityTier
    local v11 = peek(QualityTier)
    LocalPlayer:SetAttribute("QualityTier", v11)
    local QualityTier_2 = u310.Graphics.QualityTier
    ;(u251:Observer(QualityTier_2)):onChange(function() -- Line: 101 -- upvalues: Players (val), peek (val), u310 (val)
        local v1 = Players
        local LocalPlayer = v1.LocalPlayer
        local v2 = peek
        local v3 = u310
        v2 = v2(v3.Graphics.QualityTier)
        LocalPlayer:SetAttribute("QualityTier", v2)
    end)
end
Panel.Header.Exit.MouseButton1Click:Connect(function() -- Line: 107 -- upvalues: SetOpened (val)
    SetOpened(false)
end)

function u310.Init(p1) -- Line: 112
    -- upvalues: ZSLib (val), Panel (val), u310 (val), u286 (ref), peek (val), GameState (val), Players (val)
    -- upvalues: u274 (val), u290 (ref), ReplicatedStorage (val), SetOpened (val), u294 (ref), u251 (val), u298 (ref)
    -- upvalues: u302 (ref), u306 (ref), u278 (val), u267 (val), SettingsEvent (val)
    local clock, v1, v2
    local v3 = ZSLib
    local v4 = Panel
    local SettingsChanged = u310.SettingsChanged
    v3 = v3:Init(v4, SettingsChanged)
    u286 = v3:Tab("GRAPHICS")
    u286:Header("DISPLAY")
    local v5 = u286
    local v6 = peek(u310.Graphics.BaseFOV)
    v5:Number("FIELD OF VIEW", v6, function(p1) -- Line: 123 -- upvalues: u310 (upval)
        u310.Graphics.BaseFOV:set(p1)
    end, 40, 110, 0.014285714285714285)
    v4 = u286
    local v7 = peek(u310.Graphics.BulletTracers)
    local u42 = v4:Toggle("BULLET TRACERS", v7, function(p1) -- Line: 130 -- upvalues: u310 (upval)
        u310.Graphics.BulletTracers:set(p1)
    end, "Show bullet trails when shooting.")
    local v8 = u286
    local v9 = peek(u310.Graphics.BulletShells)
    local u54 = v8:Toggle("BULLET SHELLS", v9, function(p1) -- Line: 136 -- upvalues: u310 (upval)
        u310.Graphics.BulletShells:set(p1)
    end, "Show bullet shell ejection effects.")
    v6 = u286
    local v10 = peek(u310.Graphics.AnimatedTextures)
    local u65 = v6:Toggle("ANIMATED TEXTURES", v10, function(p1) -- Line: 143 -- upvalues: u310 (upval)
        u310.Graphics.AnimatedTextures:set(p1)
    end)
    v7 = u286
    local v11 = peek(u310.Graphics.BulletHoles)
    local u77 = v7:Toggle("BULLET HOLES", v11, function(p1) -- Line: 148 -- upvalues: u310 (upval)
        u310.Graphics.BulletHoles:set(p1)
    end, "Create bullet holes upon shooting.")
    u286:Header("ZOMBIES")
    local u83 = {
        {"VERY LOW", 4},
        {"LOW", 3},
        {"MEDIUM", 2},
        {"HIGH", 1},
    }
    v10 = u286
    local v12 = u83
    local v13 = u83[peek(u310.Graphics.ZombieQuality)][1]
    local u110 = v10:Dropdown("ZOMBIE QUALITY", v12, v13, function(p1, p2) -- Line: 165 -- upvalues: u310 (upval)
        u310.Graphics.ZombieQuality:set(p1)
    end, "The detail level of zombie models.")
    v11 = u286
    v13 = peek(u310.Graphics.Flinching)
    local u122 = v11:Toggle("FLINCHING", v13, function(p1) -- Line: 171 -- upvalues: u310 (upval)
        u310.Graphics.Flinching:set(p1)
    end, "Zombies will flinch when shot.")
    local v14 = u286
    local v15 = peek(u310.Graphics.Ragdolls)
    local u134 = v14:Toggle("RAGDOLLS", v15, function(p1) -- Line: 175 -- upvalues: u310 (upval)
        u310.Graphics.Ragdolls:set(p1)
    end, "Zombies will ragdoll on death.")
    v12 = u286
    local v16 = peek(u310.Graphics.RagdollTimer)
    local u148 = v12:Number("RAGDOLL TIME", v16, function(p1) -- Line: 181 -- upvalues: u310 (upval)
        u310.Graphics.RagdollTimer:set(p1)
    end, 0, 4, 0.0625)
    v13 = u286
    local v17 = peek(u310.Graphics.ArmorDestroyEffect)
    local u160 = v13:Toggle("ARMOR DESTROY EFFECT", v17, function(p1) -- Line: 188 -- upvalues: u310 (upval)
        u310.Graphics.ArmorDestroyEffect:set(p1)
    end, "Animations for armor flying off when broken.")
    v15 = u286
    local v18 = peek(u310.Graphics.HeadgearHeadshot)
    local u172 = v15:Toggle("HEADGEAR EFFECT", v18, function(p1) -- Line: 197 -- upvalues: u310 (upval)
        u310.Graphics.HeadgearHeadshot:set(p1)
    end, "Headgear flies off on headshot kill.")
    local u173 = {
        {"DISABLED", 4},
        {"LOW", 3},
        {"MEDIUM", 2},
        {"HIGH", 1},
    }
    v17 = u286
    local v19 = u173[peek(u310.Graphics.ParticleQuality)][1]
    local u200 = v17:Dropdown("PARTICLE QUALITY", u173, v19, function(p1, p2) -- Line: 214 -- upvalues: u310 (upval)
        u310.Graphics.ParticleQuality:set(p1)
    end, "Set the quality of blood and impact effects.")
    u286:Header("MISC")
    v18 = u286
    v19 = peek(u310.Graphics.HideNearbyPlayers)
    local u217 = v18:Toggle("HIDE NEARBY PLAYERS", v19, function(p1) -- Line: 225 -- upvalues: u310 (upval)
        u310.Graphics.HideNearbyPlayers:set(p1)
    end, "Nearby player characters will be made transparent.")
    local v20 = u286
    local v21 = peek(u310.Graphics.ProceduralAnimations)
    local u229 = v20:Toggle("PROCEDURAL ANIMATIONS", v21, function(p1) -- Line: 234 -- upvalues: u310 (upval)
        u310.Graphics.ProceduralAnimations:set(p1)
    end, "Use procedural IK leg animations instead of default walk.")
    local v22 = u286
    local v23 = peek(u310.Graphics.ShowMeleeHitboxes)
    local u241 = v22:Toggle("SHOW MELEE HITBOXES", v23, function(p1) -- Line: 243 -- upvalues: u310 (upval)
        u310.Graphics.ShowMeleeHitboxes:set(p1)
    end, "Show raycast hitboxes when swinging melee.")
    v19 = u286
    local v24 = peek(u310.Graphics.DisplayDamageIndicators)
    local u253 = v19:Toggle("DISPLAY DAMAGE INDICATORS", v24, function(p1) -- Line: 252 -- upvalues: u310 (upval)
        u310.Graphics.DisplayDamageIndicators:set(p1)
    end, "Show damage dealt per hit on each shot.")
    local u322 = nil
    if GameState.Data.IsLobby and workspace:GetAttribute("LobbyQualityTiers") == true then
        local v25
        u286:Header("PERFORMANCE")
        local u281 = {"Auto", "High", "Medium", "Low"}
        local v26 = {Auto = "AUTO", High = "HIGH", Medium = "MEDIUM", Low = "LOW"}
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
            if not TouchEnabled and not (60 <= v1) then
                if 35 <= v1 then
                    return "Medium"
                end
                return "High"
            end
            return "Low"
        end

        local function applyQualityTier(p1) -- Line: 297
            -- upvalues: Players (upval), u287 (val), u310 (upval), u110 (val), u83 (val), u200 (val), u173 (val)
            -- upvalues: u229 (val), u65 (val)
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
                if TouchEnabled or 60 <= v2 then
                    v1 = "Low"
                elseif not (35 <= v2) then
                    v1 = "High"
                else
                    v1 = "Medium"
                end
            end
            local v3 = u287[v1]
            if not v3 then
                return
            end
            local v4 = u310
            local ZombieQuality = v4.Graphics.ZombieQuality
            local zombie = v3.zombie
            ZombieQuality:set(zombie)
            v4 = u110
            local v5 = u83
            local v6 = v5[v3.zombie][1]
            v4:set(v6)
            v4 = u310
            local ParticleQuality = v4.Graphics.ParticleQuality
            local particle = v3.particle
            ParticleQuality:set(particle)
            v4 = u200
            v5 = u173
            v6 = v5[v3.particle][1]
            v4:set(v6)
            v4 = u310
            local ProceduralAnimations = v4.Graphics.ProceduralAnimations
            local procedural = v3.procedural
            ProceduralAnimations:set(procedural)
            u229(v3.procedural)
            v4 = u310
            local AnimatedTextures = v4.Graphics.AnimatedTextures
            local animated = v3.animated
            AnimatedTextures:set(animated)
            u65(v3.animated)
            u310.SettingsChanged:Fire()
        end

        v1 = u286
        v2 = "QUALITY TIER"
        local v27 = {
            {"AUTO", 1},
            {"HIGH", 2},
            {"MEDIUM", 3},
            {"LOW", 4},
        }
        if not u310.Graphics.QualityTier then
            v25 = "AUTO"
        else
            v25 = v26[peek(u310.Graphics.QualityTier)]
            if not v25 then
                v25 = "AUTO"
            end
        end
        u322 = v1:Dropdown(v2, v27, v25, function(p1, p2) -- Line: 319 -- upvalues: u281 (val), u310 (upval), applyQualityTier (val)
            local v1 = u281[p1] or "Auto"
            u310.Graphics.QualityTier:set(v1)
            applyQualityTier(v1)
        end, "Quickly set overall graphics quality. Auto adapts to your device; adjusting any setting below fine-tunes it.")
    end

    local function resetDefault() -- Line: 328
        -- upvalues: u310 (upval), u274 (upval), u54 (val), u77 (val), u172 (val), u160 (val), u122 (val), u134 (val)
        -- upvalues: u148 (val), u217 (val), u42 (val), u65 (val), u229 (val), u241 (val), u253 (val), u110 (val)
        -- upvalues: u83 (val), peek (upval), u200 (val), u173 (val), u322 (ref)
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
        local v1 = u310
        local AnimatedTextures = v1.Graphics.AnimatedTextures
        local v2 = u274
        local AnimatedTextures_2 = v2.Graphics.AnimatedTextures
        AnimatedTextures:set(AnimatedTextures_2)
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
        v1 = u110
        local v3 = u83
        local v4 = peek
        local v5 = u310
        v4 = v4(v5.Graphics.ZombieQuality)
        v2 = v3[v4][1]
        v1:set(v2)
        v1 = u200
        v3 = u173
        v4 = peek
        v5 = u310
        v4 = v4(v5.Graphics.ParticleQuality)
        v2 = v3[v4][1]
        v1:set(v2)
        u310.Graphics.QualityTier:set("Auto")
        if u322 then
            u322:set("AUTO")
        end
        u310.SettingsChanged:Fire()
    end

    v24 = u286
    v1 = Color3.fromRGB(255, 73, 73)
    local v28 = Color3.fromRGB(49, 49, 49)
    v2 = Color3.fromRGB(255, 73, 73)
    v24:Button("RESET TO DEFAULT", "RESET", function() -- Line: 369 -- upvalues: resetDefault (val)
        resetDefault()
    end, v1, v28, v2)
    v24 = u286.UIElements["RESET TO DEFAULT"]
    v24.LayoutOrder = 999
    u290 = v3:Tab("MOBILE")
    v5 = {
        {"HOTBAR", 1},
        {"SWAP", 2},
        {"DPAD", 3},
    }
    v4 = u290
    v9 = v5[peek(u310.Controls.MobileSelectionMode)][1]
    v4:Dropdown("WEAPON SELECTION", v5, v9, function(p1, p2) -- Line: 390 -- upvalues: u310 (upval)
        u310.Controls.MobileSelectionMode:set(p1)
    end, "How weapons are selected on mobile.")
    v4 = u290
    v7 = peek(u310.Controls.AutoShoot)
    v4:Toggle("AUTO SHOOT", v7, function(p1) -- Line: 396 -- upvalues: u310 (upval)
        u310.Controls.AutoShoot:set(p1)
    end, "Auto shoot an enemy by hovering over them.")
    v4 = u290
    v7 = peek(u310.Controls.AutoJump)
    v4:Toggle("AUTO JUMP", v7, function(p1) -- Line: 400 -- upvalues: u310 (upval)
        u310.Controls.AutoJump:set(p1)
    end, "Automatically jump over obstacles.")
    v4 = u290
    v7 = peek(u310.Controls.DynamicStaminaUI)
    v4:Toggle("DYNAMIC STAMINA UI", v7, function(p1) -- Line: 404 -- upvalues: u310 (upval)
        u310.Controls.DynamicStaminaUI:set(p1)
    end, "Move stamina ui to center when using melee.")
    v4 = u290
    v7 = peek(u310.Controls.ShowEditButton)
    v4:Toggle("SHOW EDIT BUTTON", v7, function(p1) -- Line: 408 -- upvalues: u310 (upval)
        u310.Controls.ShowEditButton:set(p1)
    end, "Show the edit button on the mobile HUD.")
    v4 = u290
    v7 = peek(u310.Controls.HotbarScale)
    v4:Number("HOTBAR SCALE", v7, function(p1) -- Line: 416 -- upvalues: u310 (upval)
        u310.Controls.HotbarScale:set(p1)
    end, 0.5, 1.5, 0.05)
    v4 = u290
    v4:Button("EDIT MOBILE CONTROLS", "EDIT", function() -- Line: 420 -- upvalues: ReplicatedStorage (upval), SetOpened (upval)
        local Element = require(ReplicatedStorage.common:WaitForChild("HUDService")):GetElement("MobileControls")
        if Element then
            SetOpened(false)
            task.defer(function() -- Line: 425 -- upvalues: Element (val)
                Element:EnterEditMode()
            end)
        end
    end)
    u294 = v3:Tab("CONTROLS")
    v5 = u294
    v6 = peek(u310.Controls.Sensitivity)
    v5:Number("SENSITIVITY", v6, function(p1) -- Line: 437 -- upvalues: u310 (upval)
        u310.Controls.Sensitivity:set(p1)
    end, 0, 10, 0.0001)
    v5 = u294
    v6 = peek(u310.Controls.AimingSensitivity)
    v5:Number("ADS SENSITIVITY", v6, function(p1) -- Line: 441 -- upvalues: u310 (upval)
        u310.Controls.AimingSensitivity:set(p1)
    end, 0, 10, 0.0001)
    v5 = {
        {"SWAP", 1},
        {"DPAD", 2},
    }
    v4 = u294
    v7 = peek(u310.Controls.ShowControlHints)
    local u553 = v4:Toggle("SHOW CONTROL HINTS", v7, function(p1) -- Line: 453 -- upvalues: u310 (upval)
        u310.Controls.ShowControlHints:set(p1)
    end, "Show contextual input hints on screen.")
    v8 = u251
    local ShowControlHints = u310.Controls.ShowControlHints
    v8 = v8:Observer(ShowControlHints)
    v8:onChange(function() -- Line: 458 -- upvalues: u553 (val), peek (upval), u310 (upval)
        u553(peek(u310.Controls.ShowControlHints))
    end)
    v8 = u294
    v10 = v5[peek(u310.Controls.GamepadSelectionMode)][1]
    v8:Dropdown("GAMEPAD WEAPON SELECTION", v5, v10, function(p1, p2) -- Line: 466 -- upvalues: u310 (upval)
        u310.Controls.GamepadSelectionMode:set(p1)
    end, "How weapons are selected on gamepad.")
    u298 = v3:Tab("CAMERA")
    v5 = u298
    v6 = peek(u310.Camera.ScrollWheelZoom)
    v5:Toggle("SCROLL WHEEL ZOOM", v6, function(p1) -- Line: 477 -- upvalues: u310 (upval)
        u310.Camera.ScrollWheelZoom:set(p1)
    end, "Use scroll wheel to zoom camera in and out.")
    v5 = {
        {"RIGHT", 1},
        {"LEFT", 2},
    }
    v4 = u298
    v9 = v5[peek(u310.Camera.ThirdPersonSide)][1]
    v4:Dropdown("THIRD PERSON SIDE", v5, v9, function(p1, p2) -- Line: 490 -- upvalues: u310 (upval)
        u310.Camera.ThirdPersonSide:set(p1)
    end, "Default shoulder side in third person.")
    v4 = u298
    v7 = peek(u310.Camera.MaxCameraDistance)
    v4:Number("MAX CAMERA DISTANCE", v7, function(p1) -- Line: 498 -- upvalues: u310 (upval)
        u310.Camera.MaxCameraDistance:set(p1)
    end, 1, 10, 0.1111111111111111)
    v4 = u298
    v7 = peek(u310.Camera.PinchToZoom)
    v4:Toggle("PINCH TO ZOOM", v7, function(p1) -- Line: 502 -- upvalues: u310 (upval)
        u310.Camera.PinchToZoom:set(p1)
    end, "Allow pinch gesture to zoom on mobile.")
    u302 = v3:Tab("MAIN MENU")
    v5 = u302
    v6 = peek(u310.MainMenu.TradeEnabled)
    v5:Toggle("TRADE ENABLED", v6, function(p1) -- Line: 511 -- upvalues: u310 (upval)
        u310.MainMenu.TradeEnabled:set(p1)
    end, "Enable sending and receiving trade requests.")
    v5 = u302
    v6 = peek(u310.MainMenu.ShowLevel)
    v5:Toggle("SHOW LEVEL", v6, function(p1) -- Line: 515 -- upvalues: u310 (upval)
        u310.MainMenu.ShowLevel:set(p1)
    end, "Show level to other players in queues.")
    v5 = u302
    v6 = peek(u310.MainMenu.ShowStats)
    v5:Toggle("SHOW STATS", v6, function(p1) -- Line: 519 -- upvalues: u310 (upval)
        u310.MainMenu.ShowStats:set(p1)
    end, "Show stats to other players in queues.")
    u306 = v3:Tab("SOUND")
    v5 = {}
    local Options = u278.Options
    v8 = nil
    v6 = nil
    for i, j in Options, v8, v6 do
        v10 = {j.Label, j.Order}
        v5[i] = v10
    end
    v4 = u306
    v7 = peek(u310.Sound.RagdollSounds)
    v4:Toggle("RAGDOLL SOUNDS", v7, function(p1) -- Line: 533 -- upvalues: u310 (upval)
        u310.Sound.RagdollSounds:set(p1)
    end, "Zombies will play sounds when ragdolling.")
    v4 = u306
    v7 = peek(u310.Sound.MusicVolume)
    v4:Number("MUSIC VOLUME", v7, function(p1) -- Line: 537 -- upvalues: u310 (upval)
        u310.Sound.MusicVolume:set(p1)
    end, 0, 10, 0.01)
    local MainMenuTheme = peek(u310.Sound.MainMenuTheme)
    if not v5[MainMenuTheme] then
        MainMenuTheme = u274.Sound.MainMenuTheme
        u310.Sound.MainMenuTheme:set(MainMenuTheme)
    end
    v8 = u306
    v10 = v5[MainMenuTheme][1]
    v8:Dropdown("MAIN MENU THEME", v5, v10, function(p1, p2) -- Line: 551 -- upvalues: u310 (upval)
        u310.Sound.MainMenuTheme:set(p1)
    end, "The music that will play in the main menu.")
    require("@self/Binding").CreateSection(v3)
    v8 = game:GetService("RunService"):IsStudio()
    local P = Enum.KeyCode.P
    if v8 then
        P = Enum.KeyCode.P
    end
    local u773 = nil
    local u774 = 0
    local u775 = nil
    ;(Players.LocalPlayer:GetAttributeChangedSignal("ZBucksPickedUp")):Connect(function() -- Line: 573 -- upvalues: u773 (ref), u267 (upval), u775 (ref), Players (upval), u774 (ref)
        local v1, v2, v3
        if not u773 then
            u773 = u267.new()
        end
        local v4 = tick()
        u775 = v4
        local Attribute = Players.LocalPlayer:GetAttribute("ZBucksPickedUp")
        local v5 = u774
        if not (u774 < Attribute) then
            v1 = -1
        else
            v1 = 1
        end
        while u775 == v4 do
            if v5 == Attribute then
                break
            end
            v5 = v5 + v1
            u774 = v5
            v2 = u773
            v3 = "Z$ " .. v5
            v2:setLabel(v3)
            task.wait(0.05)
        end
    end)
    local u817 = (((((u267.new():setImage(7059346373)):setLabel("Close", "selected")):setLabel("P", "deselected")):bindEvent("selected", function(p1) -- Line: 597 -- upvalues: SetOpened (upval)
        if not SetOpened(true) then
            task.defer(function() -- Line: 599 -- upvalues: p1 (val)
                p1:deselect()
            end)
        end
    end)):bindEvent("deselected", function(p1) -- Line: 604 -- upvalues: SetOpened (upval)
        SetOpened(false)
    end)):bindToggleKey(P)
    u310.SettingsIcon = u817
    v14 = u267.new():setLabel("FPS: 0")
    local SourceSans = Enum.Font.SourceSans
    v14 = v14:setTextFont(SourceSans)
    v14 = v14:align("Right"):lock():setOrder(1)
    local u845 = v14:bindEvent("selected", function(p1) -- Line: 617
        p1:deselect()
    end)
    local u868 = ((u267.new():setLabel("CPU: 0")):align("Right"):lock():setOrder(2)):bindEvent("selected", function(p1) -- Line: 626
        p1:deselect()
    end)
    ;(game:GetService("UserInputService")).InputBegan:Connect(function(p1) -- Line: 630 -- upvalues: u817 (val)
        if p1.UserInputType ~= Enum.UserInputType.Touch and p1.UserInputType ~= Enum.UserInputType.Gamepad1 then
            if p1.UserInputType == Enum.UserInputType.Keyboard then
                u817:setLabel("P", "deselected")
            end
            return
        end
        u817:setLabel("", "deselected")
    end)
    local u901 = ((u267.new():setLabel("0 ms")):align("Right"):lock():setOrder(3)):bindEvent("selected", function(p1) -- Line: 646
        p1:deselect()
    end)
    local RunService = game:GetService("RunService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local u913 = nil
    local u914 = nil
    local u915 = 0
    local u916 = nil
    local u917 = "FPS: 0"
    local RunService_2 = game:GetService("RunService")
    if not RunService_2:IsRunning() then
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
    local v29 = clock()
    RunService_2.Heartbeat:Connect(function() -- Line: 665 -- upvalues: u928 (ref), clock (val), u930 (val), u917 (ref), u929 (ref)
        local v1, v2, v3, v4, v5
        u928 = clock()
        for i = #u930, 1, -1 do
            v2 = u930
            v3 = i + 1
            v5 = u930[i]
            if not (u928 - 1 <= v5) then
                v4 = nil
            else
                v4 = u930[i]
                if not v4 then
                    v4 = nil
                end
            end
            v2[v3] = v4
        end
        u930[1] = u928
        if not (1 <= clock() - u929) then
            v1 = #u930 / (clock() - u929)
        else
            v1 = #u930
            if not v1 then
                v1 = #u930 / (clock() - u929)
            end
        end
        local v6 = math.floor(v1)
        u917 = tostring(v6)
    end)
    task.defer(function() -- Line: 683 -- upvalues: u868 (val), u915 (ref), u845 (val), u917 (ref), u901 (val), LocalPlayer (val)
        local Attribute, v1, v2, v3, v4, v5, v6
        while task.wait() do
            v1 = u868
            v5 = u915
            v3 = "CPU: " .. v5
            v1:setLabel(v3)
            v1 = u845
            v5 = u917
            v3 = "FPS: " .. v5
            v1:setLabel(v3)
            Attribute = workspace:GetAttribute("ServerLocation")
            if Attribute then
                v2 = u901
                v6 = (LocalPlayer:GetNetworkPing()) * 1000
                v4 = Attribute .. (math.ceil(v6)) .. " ms"
                v2:setLabel(v4)
            end
        end
    end)
    task.defer(function() -- Line: 696 -- upvalues: u913 (ref), u914 (ref), RunService (val), u915 (ref), u916 (ref), LocalPlayer (val)
        local v1, v2, v3, v4, v5
        while true do
            u913 = 60
            u914 = os.clock()
            while 0 < u913 do
                RunService.Heartbeat:Wait()
                u913 = u913 - 1
            end
            v4 = os.clock()
            v5 = u914
            v2 = (1 - 60 / (v4 - v5) / 60) * 100
            u915 = math.round(v2)
            v3 = (workspace:GetRealPhysicsFPS()) / 60
            v2 = (1 - v3) * 100
            u916 = math.round(v2)
            v1 = u915 + u916
            if not (v1 < 1) then
                v1 = u915 + u916
                if not (100 < v1) then
                    u915 = u915 + u916
                    v1 = LocalPlayer
                    v3 = u915
                    v1:SetAttribute("ClientCPULoad", v3)
                else
                    u915 = 100
                    v1 = LocalPlayer
                    v3 = u915
                    v1:SetAttribute("ClientCPULoad", v3)
                end
            else
                u915 = 0
                v1 = LocalPlayer
                v3 = u915
                v1:SetAttribute("ClientCPULoad", v3)
            end
        end
    end)
    v7 = u286
    v3:SetContainer(v7)

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

    v6 = peek(u310.Sound.MusicVolume)
    local Music = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
    Music:SetAttribute("Volume", v6)
    if not GameState.Data.Variables.DefaultMusicEnabled then
        v6 = 0
    end
    Music.Volume = v6
    v6 = GameState
    v6.Signals.Variables.DefaultMusicEnabled:Connect(function() -- Line: 739 -- upvalues: peek (upval), u310 (upval), GameState (upval)
        local v1 = peek(u310.Sound.MusicVolume)
        local Music = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
        Music:SetAttribute("Volume", v1)
        if not GameState.Data.Variables.DefaultMusicEnabled then
            v1 = 0
        end
        Music.Volume = v1
    end)
    v6 = u310
    v6.SettingsChanged:Connect(function(p1, p2) -- Line: 743 -- upvalues: SettingsEvent (upval), GameState (upval)
        local v1 = SettingsEvent
        local v2 = {Type = "SetSetting", SettingPath = p1, NewValue = p2}
        v1:FireServer(v2)
        if typeof(p1) == "table" then
            if p1[1] == "Sound" and p1[2] == "MusicVolume" then
                v1 = p2
                local Music = game.SoundService:WaitForChild("Primary"):WaitForChild("Music")
                Music:SetAttribute("Volume", v1)
                if not GameState.Data.Variables.DefaultMusicEnabled then
                    v1 = 0
                end
                Music.Volume = v1
            end
            if p1[1] == "Graphics" and p1[2] == "ShowMeleeHitboxes" then
                local v3
                v1 = workspace
                if p2 ~= true then
                    v3 = nil
                else
                    v3 = true
                end
                v1:SetAttribute("DebugMelee", v3)
            end
        end
    end)
end

return u310