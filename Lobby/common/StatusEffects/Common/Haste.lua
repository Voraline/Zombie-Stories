local u7 = game:GetService("RunService"):IsServer()
local Players = game:GetService("Players")
local common = game:GetService("ReplicatedStorage").common
local u19 = nil
local u20 = nil
local u21 = {}
u21.__index = u21
local function UpdatePlayer(p1) -- Line: 24 -- upvalues: u7 (val), u20 (ref), Players (val)
    if u7 or not p1._Player or not p1._Player.Parent or not p1._PlayerState or p1._PlayerState.IsDead then
        return
    end
    if not u20 then
        u20 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
    end
    if not p1.Count then
        p1.MeleeSpeedMult = nil
        p1.SpeedMult = nil
    elseif 0 >= p1.Count then
        p1.MeleeSpeedMult = nil
        p1.SpeedMult = nil
    else
        p1.MeleeSpeedMult = p1.Count * 0.05
        p1.SpeedMult = p1.Count * 0.05
    end
    u20:UpdateCurrentWeapon()
end
function u21.new(p1) -- Line: 46 -- upvalues: u19 (ref), common (val), u21 (val), u7 (val), u20 (ref)
    if not u19 then
        u19 = require(common.PlayerHandler)
    end
    local v1 = setmetatable({}, u21)
    if not u7 and p1.Player == game.Players.LocalPlayer then
        PersonalEffect = v1
        u20 = require(game:GetService("ReplicatedStorage").common.ZS_Framework.Modules.Controllers.LocalPlayerController)
    end
    v1._TemporaryTimers = {}
    v1._PlayerState = u19:WaitForPlayerState(p1.Player)
    v1._Player = p1.Player
    v1.Count = 1
    return v1
end
function u21.Serialize(p1) -- Line: 65
    return {p1.Duration}
end
function u21.CopyStatus(p1, p2, p3) end
function u21:RemoveStack(p2) -- Line: 75 -- upvalues: UpdatePlayer (val)
    if p2 then
        self.Count = math.max(0, p2)
    else
        self:Destroy()
    end
    print("Removed", p2, "Current Haste:", self.Count)
    UpdatePlayer(self)
end
function u21.Apply(p1, p2, p3, p4) -- Line: 91 -- upvalues: UpdatePlayer (val)
    p1.Inactive = false
    p1.Count = p1.Count + (p3 or 1)
    if p4 then
        table.insert(p1._TemporaryTimers, {p4, p3 or -1})
    end
    UpdatePlayer(p1)
end
function u21.Update(p1, p2) -- Line: 103 -- upvalues: u7 (val), UpdatePlayer (val)
    if p1.Inactive then
        return
    end
    local v1 = nil
    local _TemporaryTimers = p1._TemporaryTimers
    local v2 = nil
    local v3 = nil
    for i, j in _TemporaryTimers, v2, v3 do
        j[1] = j[1] - p2
        if j[1] < 0 then
            p1:RemoveStack(j[2])
            v1 = true
        end
    end
    if not u7 and v1 then
        UpdatePlayer(p1)
    end
end
function u21:Destroy() -- Line: 123 -- upvalues: UpdatePlayer (val)
    self.Count = 0
    UpdatePlayer(self)
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end
return u21