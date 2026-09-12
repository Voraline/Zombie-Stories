local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u11 = require("../Components/ServerList/ServerList")
local fusion_utils = require(ReplicatedStorage.common.fusion_utils)
local u18 = require("@game/ReplicatedStorage/common/zap")
local u21 = require("../../Data/PlayerDatabase")
local u22 = {}
local u23 = nil
local u24 = nil
local u25 = nil
local u26 = nil
local u27 = nil
local u28 = nil

local function getTeleportPresenter() -- Line: 25
    local ZSTeleport = (game:GetService("ReplicatedFirst")):FindFirstChild("ZSTeleport")
    local TeleportPresenter = ZSTeleport
    if TeleportPresenter then
        TeleportPresenter = ZSTeleport:FindFirstChild("TeleportPresenter")
    end
    if TeleportPresenter and TeleportPresenter:IsA("ModuleScript") then
        local success, result = pcall(require, TeleportPresenter)
        local v1 = success and result or nil
        return v1
    end
    return nil
end

local function armArcade() -- Line: 33 -- upvalues: getTeleportPresenter (val)
    local v1 = getTeleportPresenter()
    if v1 then
        v1.Arm("Arcade", {destMode = "Arcade"})
        v1.Present()
    end
end

u18.ServerList.On(function(p1) -- Line: 41 -- upvalues: u23 (ref), u24 (ref), u25 (ref)
    if u23 then
        local v1 = u23
        local Servers = p1.Servers
        v1:set(Servers)
    end
    if u24 then
        u24:set(false)
        if u25 then
            task.cancel(u25)
            u25 = nil
        end
        task.delay(3, function() -- Line: 53 -- upvalues: u24 (upval)
            if u24 then
                u24:set(false)
            end
        end)
    end
end)
u18.JoinServerResponse.On(function(p1) -- Line: 61 -- upvalues: u21 (val), getTeleportPresenter (val), u26 (ref)
    local v1 = u21
    local StatusMessage = v1.Signals.StatusMessage
    local Message = p1.Message
    StatusMessage:Fire(Message, 0)
    v1 = getTeleportPresenter()
    if v1 then
        v1.Dismiss("ServerJoinRejected")
    end
    if u26 then
        u26:set(false)
    end
end)
u18.PrivateServerCreated.On(function(p1) -- Line: 73 -- upvalues: u27 (ref)
    print("Private server created with ID: " .. p1.PrivateServerId)
    local v1 = u27
    local PrivateServerId = p1.PrivateServerId
    v1:set(PrivateServerId)
end)

function u22.FailedTeleport() -- Line: 79 -- upvalues: getTeleportPresenter (val), u26 (ref), u21 (val)
    local v1 = getTeleportPresenter()
    if v1 then
        v1.Dismiss("ServerBrowserFailed")
    end
    if not u26 then
        return false
    end
    u26:set(false)
    u21.Signals.StatusMessage:Fire("Failed to join server", 0)
    return true
end

function u22.Close() -- Line: 93 -- upvalues: u28 (ref)
    if u28 then
        u28()
    end
end

function u22.new(p1, p2, p3) -- Line: 100
    -- upvalues: fusion_utils (val), u24 (ref), u26 (ref), u23 (ref), u27 (ref), u18 (val), u25 (ref)
    -- upvalues: getTeleportPresenter (val), u28 (ref), u11 (val)
    local u28_2
    local scope = p1.scope
    local v1 = fusion_utils
    local u7 = scope:innerScope(v1)
    local u11_2 = u7:Value({})
    u24 = u7:Value(false)
    u26 = u7:Value(false)
    u23 = u11_2
    u27 = u7:Value("")

    local function onRefresh(p1) -- Line: 109 -- upvalues: u18 (upval), u24 (upval), u25 (upval)
        p1:set({})
        u18.RefreshServers.Fire({ServerType = "Arcade"})
        if u24 then
            u24:set(true)
            u25 = task.delay(10, function() -- Line: 120 -- upvalues: u24 (upval)
                if u24 then
                    u24:set(false)
                end
            end)
        end
    end

    local function onExit(p1, p2) -- Line: 152
        if p1 then
            p2()
        end
    end

    function u28_2() -- Line: 159 -- upvalues: u28 (upval), u28_2 (ref), u7 (val), p2 (val), p3 (val)
        if u28 == u28_2 then
            u28 = nil
        end
        u7:doCleanup()
        local v1 = p2
        local v2 = p3
        if v1 then
            v2()
        end
    end

    u28 = u28_2
    onRefresh(u11_2)
    local v2 = u11
    v2 = v2({
        OnRefresh = function() -- Line: 191 -- upvalues: onRefresh (val), u11_2 (val)
            onRefresh(u11_2)
        end,
        OnJoin = function(p1) -- Line: 128 -- upvalues: getTeleportPresenter (upval), u7 (val), u11_2 (val), u26 (upval), u18 (upval)
            local v1
            print("Joining server", p1)
            local v2 = getTeleportPresenter()
            if v2 then
                v2.Arm("Arcade", {destMode = "Arcade"})
                v2.Present()
            end
            v2 = false
            for i, j in u7.peek(u11_2) do
                v2 = true
                break
            end
            if v2 then
                v1 = p1
            else
                v1 = ""
            end
            if u26 then
                u26:set(true)
            end
            local v3 = u18
            v3.JoinServer.Fire({ServerType = "Arcade", ServerID = v1})
        end,
        OnExit = u28_2,
        OnJoinPrivateServer = function() -- Line: 176 -- upvalues: getTeleportPresenter (upval), u26 (upval), u18 (upval), u7 (val), u27 (upval)
            local v1 = getTeleportPresenter()
            if v1 then
                v1.Arm("Arcade", {destMode = "Arcade"})
                v1.Present()
            end
            if u26 then
                u26:set(true)
            end
            v1 = u18
            v1.JoinPrivateServer.Fire({ServerType = "Arcade", PrivateServerId = u7.peek(u27)})
        end,
        OnStartPrivateServer = function() -- Line: 168 -- upvalues: u18 (upval)
            print("Starting private server")
            u18.StartPrivateServer.Fire({ServerType = "Arcade"})
        end,
        PrivateServerId = u27,
        Joining = u26,
        Refreshing = u24,
        ServerData = u11_2,
        scope = u7,
        target = p1.target,
    })
    return v2
end

function u22.test() -- Line: 215 -- upvalues: Fusion (val), u22 (val)
    local v1 = Fusion.scoped(Fusion)
    local v2 = v1:New("ScreenGui")({
        Name = "ServerListController",
        Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    })
    local v3 = u22
    v3.new({target = v2, scope = v1})
end

return u22