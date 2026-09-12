local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local u12 = require("../../Data/PlayerDatabase")
local Bin = require(ReplicatedStorage.Packages.Bin)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u23 = require("../Components/Gamemodes/TopBarScoreboard")
local u25 = {}

local function setupScoreboard() -- Line: 17
    -- upvalues: Fusion (val), Bin (val), u25 (ref), u12 (val), u23 (val), Players (val)
    local u3 = Fusion.scoped(Fusion)
    local u5, v1 = Bin()
    u25.Empty = v1
    u25.Add = u5
    u25.scope = u3
    local u13 = u3:Value({})
    local Attribute = workspace:GetAttribute("TimeLeft")
    local u22 = u3:Value(Attribute or 0)
    local AttributeChangedSignal = workspace:GetAttributeChangedSignal("TimeLeft")
    u5(AttributeChangedSignal:Connect(function() -- Line: 28 -- upvalues: u22 (val)
        local v1 = u22
        local Attribute = workspace:GetAttribute("TimeLeft")
        v1:set(Attribute or 0)
    end))
    local v2 = u3:New("ScreenGui")
    local v3 = {Parent = u12.PlayerGui}
    local Children = u3.Children
    local v4 = {}
    local v5 = u23
    v4[1] = v5({PlayerList = u13, TimeLeft = u22, scope = u3})
    v3[Children] = v4
    v2(v3)

    local function updateList() -- Line: 43 -- upvalues: u3 (val), u13 (val), Players (upval)
        local Visible, v1, v2
        local v3 = u3.peek(u13)
        local LocalPlayer = Players.LocalPlayer
        local v4 = {}
        for k, v in pairs(v3) do
            v1 = {userId = k, score = u3.peek(v.Score)}
            table.insert(v4, v1)
        end
        table.sort(v4, function(p1, p2) -- Line: 55
            local score = p1.score
            local v1 = p2.score < score
            return v1
        end)
        local v5 = {}
        local v6 = #v4
        local v7 = math.min(5, v6)
        for i = 1, v7 do
            v5[v4[i].userId] = true
        end
        if v3[LocalPlayer.UserId] and not v5[LocalPlayer.UserId] then
            v5[LocalPlayer.UserId] = true
        end
        for k2, j in pairs(v3) do
            Visible = j.Visible
            v2 = v5[k2] == true
            Visible:set(v2)
        end
    end

    local function setupPlayer(p1) -- Line: 74
        -- upvalues: u3 (val), u13 (val), Players (upval), updateList (val), u5 (val)
        local v1 = u3.peek(u13)
        local u9 = u3:Value("")
        local u14 = u3:Value(0)
        local v2 = u3:Value(false)
        local UserId = p1.UserId
        local v3 = {Score = u14, Headshot = u9}
        local v4 = u3
        local v5 = string.upper(p1.Name)
        v3.Name = v4:Value(v5)
        v3.Visible = v2
        v3.userId = p1.UserId
        v1[UserId] = v3
        u13:set(v1)
        task.spawn(function() -- Line: 91 -- upvalues: Players (upval), p1 (val), u9 (val)
            local v1 = Players
            local v2 = p1
            local UserId = v2.UserId
            local HeadShot = Enum.ThumbnailType.HeadShot
            local Size352x352 = Enum.ThumbnailSize.Size352x352
            local UserThumbnailAsync = v1:GetUserThumbnailAsync(UserId, HeadShot, Size352x352)
            if UserThumbnailAsync then
                u9:set(UserThumbnailAsync)
            end
        end)
        v3 = u5
        v3((p1:GetAttributeChangedSignal("Score")):Connect(function() -- Line: 100 -- upvalues: p1 (val), u14 (val), updateList (upval)
            local Attribute = p1:GetAttribute("Score")
            u14:set(Attribute or 0)
            updateList()
        end))
        local Attribute = p1:GetAttribute("Score")
        u14:set(Attribute or 0)
        updateList()
    end

    local function removePlayer(p1) -- Line: 110 -- upvalues: u3 (val), u13 (val), updateList (val)
        local v1 = u3.peek(u13)
        v1[p1.UserId] = nil
        u13:set(v1)
        updateList()
    end

    for i, j in Players:GetPlayers() do
        setupPlayer(j)
    end
    v5 = Players
    local PlayerAdded = v5.PlayerAdded
    u5(PlayerAdded:Connect(function(p1) -- Line: 121 -- upvalues: setupPlayer (val)
        setupPlayer(p1)
    end))
    v5 = Players
    local PlayerRemoving = v5.PlayerRemoving
    u5(PlayerRemoving:Connect(function(p1) -- Line: 124 -- upvalues: u3 (val), u13 (val), updateList (val)
        local v1 = u3.peek(u13)
        v1[p1.UserId] = nil
        u13:set(v1)
        updateList()
    end))
end

local function takedownScoreboard() -- Line: 129 -- upvalues: u25 (ref)
    if not u25.Empty then
        return
    end
    u25.Empty()
    u25.scope:doCleanup()
    u25 = {}
end

if workspace:GetAttribute("TopbarScoreboard") then
    setupScoreboard()
end
;(workspace:GetAttributeChangedSignal("TopbarScoreboard")):Connect(function() -- Line: 141 -- upvalues: setupScoreboard (val), u25 (ref)
    if workspace:GetAttribute("TopbarScoreboard") then
        setupScoreboard()
        return
    end
    if not u25.Empty then
        return
    end
    u25.Empty()
    u25.scope:doCleanup()
    u25 = {}
end)
return {}