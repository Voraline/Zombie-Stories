local AttributeChangedSignal
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local u12 = require("../../Data/PlayerDatabase")
local Bin = require(ReplicatedStorage.Packages.Bin)
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local u23 = require("../Components/Gamemodes/TopBarScoreboard")
local v1 = {}
local u25 = {}
local function setupScoreboard() -- Line: 17 -- upvalues: Fusion (val), Bin (val), u25 (ref), u12 (val), u23 (val), Players (val)
    local u5, v1
    local u3 = Fusion.scoped(Fusion)
    u5, v1 = Bin()
    u25.Empty = v1
    u25.Add = u5
    u25.scope = u3
    local u13 = u3:Value({})
    local u22 = u3:Value(workspace:GetAttribute("TimeLeft") or 0)
    local AttributeChangedSignal = workspace:GetAttributeChangedSignal("TimeLeft")
    u5(AttributeChangedSignal:Connect(function() -- Line: 28 -- upvalues: u22 (val)
        u22:set(workspace:GetAttribute("TimeLeft") or 0)
    end))
    local v2 = u3:New("ScreenGui")
    local v3 = {Parent = u12.PlayerGui}
    v3[u3.Children] = {u23({PlayerList = u13, TimeLeft = u22, scope = u3})}
    v2(v3)
    local function updateList() -- Line: 43 -- upvalues: u3 (val), u13 (val), Players (upval)
        local v1
        local v2 = u3.peek(u13)
        local LocalPlayer = Players.LocalPlayer
        local v3 = {}
        for k, v in pairs(v2) do
            table.insert(v3, {userId = k, score = u3.peek(v.Score)})
        end
        table.sort(v3, function(p1, p2) -- Line: 55
            local v1 = p2.score < p1.score
            return v1
        end)
        local v4 = {}
        local v5 = math.min(5, #v3)
        local v6 = 1
        for i = 1, v5, v6 do
            v4[v3[i].userId] = true
        end
        if v2[LocalPlayer.UserId] and not (v4[LocalPlayer.UserId]) then
            v4[LocalPlayer.UserId] = true
        end
        for k2, j in pairs(v2) do
            v1 = v4[k2] == true
            j.Visible:set(v1)
        end
    end
    local function setupPlayer(p1) -- Line: 74 -- upvalues: u3 (val), u13 (val), Players (upval), updateList (val), u5 (val)
        local v1 = u3.peek(u13)
        local u9 = u3:Value("")
        local u14 = u3:Value(0)
        local v2 = u3:Value(false)
        v1[p1.UserId] = {
            Score = u14,
            Headshot = u9,
            Name = u3:Value(string.upper(p1.Name)),
            Visible = v2,
            userId = p1.UserId,
        }
        u13:set(v1)
        task.spawn(function() -- Line: 91 -- upvalues: Players (upval), p1 (val), u9 (val)
            local UserThumbnailAsync = Players:GetUserThumbnailAsync(p1.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size352x352)
            if UserThumbnailAsync then
                u9:set(UserThumbnailAsync)
            end
        end)
        local AttributeChangedSignal = p1:GetAttributeChangedSignal("Score")
        u5(AttributeChangedSignal:Connect(function() -- Line: 100 -- upvalues: p1 (val), u14 (val), updateList (upval)
            local Attribute = p1:GetAttribute("Score")
            u14:set(Attribute or 0)
            updateList()
        end))
        u14:set(p1:GetAttribute("Score") or 0)
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
    u5(Players.PlayerAdded:Connect(function(p1) -- Line: 121 -- upvalues: setupPlayer (val)
        setupPlayer(p1)
    end))
    u5(Players.PlayerRemoving:Connect(function(p1) -- Line: 124 -- upvalues: u3 (val), u13 (val), updateList (val)
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
AttributeChangedSignal = workspace:GetAttributeChangedSignal("TopbarScoreboard")
AttributeChangedSignal:Connect(function() -- Line: 141 -- upvalues: setupScoreboard (val), u25 (ref)
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
return v1