local RedEvents = game.ReplicatedStorage.common.RedEvents
local u4 = nil
local ChangeStateEvent = require(RedEvents.Framework.ChangeStateEvent)
local u9 = {
    Sprinting = true,
    Crouching = true,
    Proning = true,
    Sliding = true,
    Jogging = true,
    Diving = true,
    Aiming = true,
    Blocking = true,
    Charging = true,
    EquippedGun = true,
    QuickSwapActive = true,
    DualWieldActive = true,
}
local u22 = {EquippedGun = true}
local u24 = {}

function u24.Init(p1) -- Line: 40 -- upvalues: u4 (ref), u9 (val), u22 (val)
    local v1, v2
    u4 = require(game:GetService("ReplicatedStorage").common:WaitForChild("PlayerHandler"))
    local v3 = u9
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        v1 = u9
        v2 = not u22[i] and i or true
        v1[i] = v2
    end
end

function u24.new() -- Line: 48 -- upvalues: u24 (val)
    local v1 = u24
    return (setmetatable({
        _sprinting = false,
        _crouching = false,
        _proning = false,
        _sliding = false,
        _jogging = false,
        _diving = false,
        _aiming = false,
        _blocking = false,
        _charging = false,
        _equippedgun = false,
        _quickswapactive = false,
        _dualwieldactive = false,
    }, v1))
end

function u24.__index(p1, p2) -- Line: 67 -- upvalues: u24 (val), u9 (val)
    if not u24[p2] and not u24["_" .. string.lower(p2)] then
        if u9[p2] then
            return p1["_" .. string.lower(p2)]
        end
        local v1 = error
        local v2 = tostring(p2)
        v1(("%q is not a valid member of playerState"):format(v2), 2)
        return
    end
    return u24[p2]
end

function u24.__newindex(p1, p2, p3) -- Line: 77 -- upvalues: u9 (val), u4 (ref), u22 (val), ChangeStateEvent (val)
    local v1
    local v2 = nil
    if not u9[p2] then
        v1 = error
        local v3 = tostring(p2)
        v1(("%q is not a valid member of playerState"):format(v3), 2)
    else
        v2 = p1[p2]
        p1["_" .. string.lower(p2)] = p3
    end
    if v2 ~= nil and v2 ~= p3 then
        v1 = u4
        local v4 = game
        local LocalPlayer = v4.Players.LocalPlayer
        v1:SetState(LocalPlayer, p2, p3)
        if not u22[p2] then
            v1 = ChangeStateEvent
            v4 = {u9[p2], p3}
            v1:FireServer(v4)
        end
    end
end

return u24