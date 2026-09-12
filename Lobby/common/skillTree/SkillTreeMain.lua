local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local Packages = ReplicatedStorage.Packages
local Fusion = require(Packages.Fusion)
local Parent = script.Parent
local SkillTreeRenderer = require(Parent.SkillTreeRenderer)
local SkillTreeCamera = require(Parent.SkillTreeCamera)
local SkillTreeController = require(Parent.SkillTreeController)
local SkillTreeBackground = require(Parent.SkillTreeBackground)
local SkillTreeScreenGui = require(Parent.ui.SkillTreeScreenGui)
local SkillTreeOverlayGui = require(Parent.ui.SkillTreeOverlayGui)
local FadeFrame = require(Parent.ui.FadeFrame)
local ConfirmationDialog = require(Parent.ui.ConfirmationDialog)
local Remotes = require(Parent.Remotes)
local SkillTreeData = require(Parent.SkillTreeData)
local EconomyConfig = require(Parent.config.EconomyConfig)
local u61 = require("@game/ReplicatedStorage/common/zap")

local function commaFormat(p1) -- Line: 35
    local v1 = math.floor(p1)
    local v2 = tostring(v1)
    v1 = #v2
    if v1 <= 3 then
        return v2
    end
    local v3 = ""
    local v4 = v1
    for i = 1, v4 do
        if 1 < i and (v1 - i + 1) % 3 == 0 then
            v3 = v3 .. ","
        end
        v3 = v3 .. v2:sub(i, i)
    end
    return v3
end

local v1 = {}
local u70 = Fusion.scoped(Fusion):Value(false)
v1.isSkillTreeOpen = u70

local function runCallback(p1, p2) -- Line: 83
    if not p2 then
        return true
    end
    local success, result = xpcall(p2, debug.traceback)
    if not success then
        warn((("SkillTreeMain %* callback failed:\n%*"):format(p1, result)))
    end
    return success
end

function v1.new(p1) -- Line: 94
    -- upvalues: Fusion (val), SkillTreeRenderer (val), SkillTreeBackground (val), SkillTreeCamera (val)
    -- upvalues: SkillTreeController (val), FadeFrame (val), SkillTreeScreenGui (val), ConfirmationDialog (val)
    -- upvalues: SoundService (val), SkillTreeData (val), SkillTreeOverlayGui (val), Remotes (val), u70 (val)
    -- upvalues: Players (val), EconomyConfig (val), commaFormat (val), u61 (val)
    local v1 = p1 or {}
    local u4 = v1
    local u8 = Fusion.scoped(Fusion)
    local u9 = false
    local u10 = nil
    local u11 = nil
    local u12 = nil
    local u15 = SkillTreeRenderer.new()
    local v2 = workspace
    u15:render(v2)
    u15.container.Parent = nil
    local u24 = SkillTreeBackground.new()
    local u27 = SkillTreeCamera.new()
    local u32 = SkillTreeController.new(u15, u27)
    local v3 = FadeFrame
    local u35 = v3({scope = u8})
    local v4 = SkillTreeScreenGui
    local u49 = v4({
        scope = u32:getScope(),
        SelectedSkillId = u32:getSelectedSkillValue(),
        CurrentRank = u32:getSelectedSkillRankComputed(),
        OnBuy = function() -- Line: 131 -- upvalues: u32 (val)
            u32:handleBuy()
        end,
        OnExit = function() -- Line: 134 -- upvalues: u32 (val)
            u32:deselectSkill()
        end,
    })
    u49.Enabled = false
    local u51 = nil
    local u54 = ConfirmationDialog(u8)
    local Sound = Instance.new("Sound")
    Sound.SoundId = "rbxassetid://92245187249918"
    Sound.Parent = SoundService
    local Sound_2 = Instance.new("Sound")
    Sound_2.SoundId = "rbxassetid://85427260827797"
    Sound_2.Parent = SoundService
    local v5 = u8:Computed(function(p1) -- Line: 157 -- upvalues: SkillTreeData (upval)
        local SkillRanks = SkillTreeData.SkillRanks
        local v1 = nil
        local v2 = nil
        for i, j in SkillRanks, v1, v2 do
            if 0 < (p1(j)) then
                return true
            end
        end
        return false
    end)
    local v6 = SkillTreeOverlayGui
    local u99 = v6({
        scope = u8,
        SP = SkillTreeData.SP,
        SPSpent = SkillTreeData.SPSpent,
        SPCap = SkillTreeData.SPCap,
        XPBar = SkillTreeData.XPBar,
        DailyEarned = SkillTreeData.DailyEarned,
        DailyEarnCap = SkillTreeData.DailyEarnCap,
        PrestigeLevel = SkillTreeData.PrestigeLevel,
        ZBucks = SkillTreeData.ZBucks,
        XPBonusMult = SkillTreeData.XPBonusMult,
        AtSPCap = SkillTreeData.AtSPCap,
        AtDailyCap = SkillTreeData.AtDailyCap,
        CanPrestige = SkillTreeData.CanPrestige,
        RespecVisible = v5,
        OnExit = function() -- Line: 182 -- upvalues: u11 (ref)
            u11()
        end,
        OnRespec = function() -- Line: 185 -- upvalues: u12 (ref)
            u12()
        end,
        OnPrestige = function() -- Line: 188 -- upvalues: u51 (ref)
            u51()
        end,
        OnZBucks = function() -- Line: 191 -- upvalues: u4 (ref)
            if u4.onZBucksButtonPressed then
                u4.onZBucksButtonPressed()
            end
        end,
    })
    u32:setOnBuyCallback(function(p1) -- Line: 199 -- upvalues: Remotes (upval)
        print("Requesting purchase for skill:", p1)
        Remotes.PurchaseSkill:FireServer(p1)
    end)
    for k, v in pairs(SkillTreeData.SkillRanks) do
        (u8:Observer(v)):onBind(function() -- Line: 206 -- upvalues: Fusion (upval), v (val), u15 (val), k (val)
            local v1 = Fusion.peek(v)
            local v2 = u15
            local v3 = k
            v2:setSkillRank(v3, v1)
        end)
    end
    local u117 = {}
    u117.isOpen = u70

    local function createExitHelpers() -- Line: 216
        -- upvalues: u27 (val), SkillTreeCamera (upval), u35 (val), u9 (ref), u24 (val), u15 (val), u49 (val), u99 (val)
        -- upvalues: u70 (upval), u32 (val), u10 (ref), Players (upval), u4 (ref)
        return {
            fade = function(p1) -- Line: 219 -- upvalues: u27 (upval), SkillTreeCamera (upval), u35 (upval)
                local v1 = u27
                local v2 = SkillTreeCamera
                v2 = v2.getTransitionFOVStart()
                v1:tweenFieldOfView(v2, 0.4)
                u35:fadeIn(0.4, p1)
            end,
            fadeOut = function(p1) -- Line: 225 -- upvalues: u35 (upval), u9 (upval)
                local v1 = u35
                v1:fadeOut(0.4, function() -- Line: 226 -- upvalues: u9 (upval), p1 (val)
                    u9 = false
                    if p1 then
                        p1()
                    end
                end)
            end,
            disconnectAll = function() -- Line: 235
                -- upvalues: u27 (upval), u24 (upval), u15 (upval), u49 (upval), u99 (upval), u70 (upval), u32 (upval)
                -- upvalues: u10 (upval), Players (upval), u4 (upval)
                u27:disable()
                u24:stop()
                u15.container.Parent = nil
                u49.Enabled = false
                u99.Enabled = false
                u70:set(false)
                u32:deselectSkill()
                u15:clearHoverStates()
                if u10 ~= nil then
                    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
                    if PlayerGui then
                        local TouchGui = PlayerGui:FindFirstChild("TouchGui")
                        if TouchGui then
                            TouchGui.Enabled = u10
                        end
                    end
                    u10 = nil
                end
                local onAfterClose = u4.onAfterClose
                if not onAfterClose then
                    return
                end
                local success, result = xpcall(onAfterClose, debug.traceback)
                if not success then
                    warn((("SkillTreeMain onAfterClose callback failed:\n%*"):format(result)))
                end
            end,
        }
    end

    function u117.open(p1) -- Line: 263
        -- upvalues: u9 (ref), u4 (ref), Players (upval), u10 (ref), Remotes (upval), u70 (upval), u35 (val), u15 (val)
        -- upvalues: u24 (val), u27 (val), SkillTreeCamera (upval), u49 (val), u99 (val)
        local v1
        if u9 then
            return false
        end
        u9 = true
        local onBeforeOpen = u4.onBeforeOpen
        if onBeforeOpen then
            local success, result = xpcall(onBeforeOpen, debug.traceback)
            if not success then
                warn((("SkillTreeMain onBeforeOpen callback failed:\n%*"):format(result)))
            end
            v1 = success
        else
            v1 = true
        end
        if not v1 then
            u9 = false
            return false
        end
        local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
        if PlayerGui then
            local TouchGui = PlayerGui:FindFirstChild("TouchGui")
            if TouchGui then
                u10 = TouchGui.Enabled
                TouchGui.Enabled = false
            end
        end
        Remotes.RequestSync:FireServer()
        u70:set(true)
        u35:setTransparency(0)
        u15.container.Parent = workspace
        local v2 = u24
        local v3 = workspace
        v2:start(v3)
        v2 = u27
        v3 = SkillTreeCamera
        v3 = v3.getTransitionFOVStart()
        v2:setFieldOfView(v3)
        u27:enable("core1")
        u49.Enabled = true
        u99.Enabled = true
        v2 = u27
        v3 = SkillTreeCamera
        v3 = v3.getDefaultFOV()
        v2:tweenFieldOfView(v3, 0.5)
        v2 = u35
        v2:fadeOut(0.5, function() -- Line: 304 -- upvalues: u9 (upval), u4 (upval)
            u9 = false
            local onAfterOpen = u4.onAfterOpen
            if not onAfterOpen then
                return
            end
            local success, result = xpcall(onAfterOpen, debug.traceback)
            if not success then
                warn((("SkillTreeMain onAfterOpen callback failed:\n%*"):format(result)))
            end
        end)
        return true
    end

    function u117.close(p1) -- Line: 313
        -- upvalues: u9 (ref), u4 (ref), u70 (upval), u32 (val), u15 (val), u27 (val), SkillTreeCamera (upval)
        -- upvalues: u35 (val), u24 (val), u49 (val), u99 (val), u10 (ref), Players (upval)
        if u9 then
            return
        end
        u9 = true
        local onBeforeClose = u4.onBeforeClose
        if onBeforeClose then
            local success, result = xpcall(onBeforeClose, debug.traceback)
            if not success then
                warn((("SkillTreeMain onBeforeClose callback failed:\n%*"):format(result)))
            end
        end
        u70:set(false)
        u32:deselectSkill()
        u15:clearHoverStates()
        local v1 = u27
        local v2 = SkillTreeCamera
        v2 = v2.getTransitionFOVStart()
        v1:tweenFieldOfView(v2, 0.4)
        v1 = u35
        v1:fadeIn(0.4, function() -- Line: 329
            -- upvalues: u27 (upval), u24 (upval), u15 (upval), u49 (upval), u99 (upval), u10 (upval), Players (upval)
            -- upvalues: u35 (upval), u9 (upval), u4 (upval)
            u27:disable()
            u24:stop()
            u15.container.Parent = nil
            u49.Enabled = false
            u99.Enabled = false
            if u10 ~= nil then
                local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
                if PlayerGui then
                    local TouchGui = PlayerGui:FindFirstChild("TouchGui")
                    if TouchGui then
                        TouchGui.Enabled = u10
                    end
                end
                u10 = nil
            end
            local v1 = u35
            v1:fadeOut(0.4, function() -- Line: 350 -- upvalues: u9 (upval), u4 (upval)
                u9 = false
                local onAfterClose = u4.onAfterClose
                if not onAfterClose then
                    return
                end
                local success, result = xpcall(onAfterClose, debug.traceback)
                if not success then
                    warn((("SkillTreeMain onAfterClose callback failed:\n%*"):format(result)))
                end
            end)
        end)
    end

    function u117.forceClose(p1) -- Line: 362 -- upvalues: u9 (ref), createExitHelpers (val), u35 (val)
        u9 = false
        createExitHelpers().disconnectAll()
        u35:setTransparency(1)
    end

    function u11() -- Line: 369 -- upvalues: u9 (ref), u4 (ref), createExitHelpers (val), u117 (val)
        if u9 then
            return
        end
        if not u4.onExitButtonPressed then
            u117:close()
            return
        end
        u9 = true
        local v1 = createExitHelpers
        local u5 = v1()
        local success, result = xpcall(function() -- Line: 378 -- upvalues: u4 (upval), u5 (val)
            u4.onExitButtonPressed(u5)
        end, debug.traceback)
        if success then
            return
        end
        u9 = false
        warn((("SkillTreeMain onExitButtonPressed callback failed:\n%*"):format(result)))
    end

    function u12() -- Line: 392
        -- upvalues: Fusion (upval), SkillTreeData (upval), EconomyConfig (upval), commaFormat (upval), u54 (val)
        -- upvalues: Sound_2 (val), u4 (ref), u61 (upval)
        local v1
        local v2 = Fusion.peek(SkillTreeData.SPSpent)
        local v3 = Fusion.peek(SkillTreeData.ZBucksInvested)
        local RESPEC_ZBUCKS_COST = EconomyConfig.RESPEC_ZBUCKS_COST
        local v4 = commaFormat
        v4 = v4(v2)
        local v5 = ("Refunds: %* SP"):format(v4)
        if 0 < v3 then
            v1 = commaFormat
            v1 = v1(v3)
            v5 = v5 .. (" + %* Z$"):format(v1)
        end
        local v6 = u54
        local v7 = commaFormat
        v7 = v7(RESPEC_ZBUCKS_COST)
        v1 = ("This will reset all skills.\n%*\nCosts %* Z$."):format(v5, v7)
        v6:show("Respec Skills?", v1, function() -- Line: 405 -- upvalues: Sound_2 (upval), u4 (upval), u61 (upval)
            Sound_2:Play()
            if u4.onRespecButtonPressed then
                u4.onRespecButtonPressed()
                return
            end
            u61.RespecSkillTree.Fire()
        end)
    end

    function u51() -- Line: 417
        -- upvalues: Fusion (upval), SkillTreeData (upval), EconomyConfig (upval), commaFormat (upval), u54 (val)
        -- upvalues: Sound (val), u61 (upval)
        local v1 = Fusion.peek(SkillTreeData.PrestigeLevel)
        local v2 = EconomyConfig.getPrestigeZBucksCost(v1)
        local v3 = EconomyConfig.getPrestigeStats(v1)
        local v4 = EconomyConfig.getPrestigeStats(v1 + 1)
        local v5 = v4.spCap - v3.spCap
        local v6 = v4.dailyEarnCap - v3.dailyEarnCap
        local v7 = v1 * EconomyConfig.XP_BOOST_PER_PRESTIGE
        local v8 = EconomyConfig
        local MAX_XP_BOOST = v8.MAX_XP_BOOST
        local v9 = (math.min(v7, MAX_XP_BOOST)) * 100 + 0.5
        local v10 = math.floor(v9)
        v8 = (v1 + 1) * EconomyConfig.XP_BOOST_PER_PRESTIGE
        local v11 = EconomyConfig
        local MAX_XP_BOOST_2 = v11.MAX_XP_BOOST
        local v12 = (math.min(v8, MAX_XP_BOOST_2)) * 100 + 0.5
        v9 = math.floor(v12)
        local spCap = v3.spCap
        local spCap_2 = v4.spCap
        v12 = ("All skills will be reset.\nSP Cap: %* → %* (+%*)"):format(spCap, spCap_2, v5)
        if 0 < v6 then
            local dailyEarnCap = v3.dailyEarnCap
            local dailyEarnCap_2 = v4.dailyEarnCap
            v12 = v12 .. ("\nDaily Earn Cap: %* → %* (+%*)"):format(dailyEarnCap, dailyEarnCap_2, v6)
        end
        v12 = v12 .. (("\nSkill XP Bonus: %*%% → %*%%"):format(v10, v9))
        v11 = commaFormat
        v11 = v11(v2)
        v12 = v12 .. ("\nCosts %* Z$."):format(v11)
        local v13 = u54
        local v14 = v1 + 1
        v8 = ("Prestige to Level %*?"):format(v14)
        v13:show(v8, v12, function() -- Line: 438 -- upvalues: Sound (upval), u61 (upval)
            Sound:Play()
            u61.RequestPrestige.Fire()
        end)
    end

    function u117.destroy(p1) -- Line: 444 -- upvalues: u8 (val), u15 (val), u24 (val), u27 (val)
        u8:doCleanup()
        u15:destroy()
        u24:stop()
        u27:disable()
    end

    print("SkillTreeMain initialized")
    return u117
end

return v1