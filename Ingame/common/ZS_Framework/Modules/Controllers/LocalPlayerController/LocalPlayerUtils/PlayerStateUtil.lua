local u4 = nil
local ChangeStateEvent = require(game.ReplicatedStorage.common.RedEvents.Framework.ChangeStateEvent)
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
local u24 = {
    Init = function(p1) -- Line: 40 -- upvalues: u4 (ref), u9 (val), u22 (val)
        local v1, v2
        u4 = require(game:GetService("ReplicatedStorage").common:WaitForChild("PlayerHandler"))
        local v3 = u9
        local v4 = nil
        local v5 = nil
        for i, j in v3, v4, v5 do
            v1 = u9
            if u22[i] then
                v2 = true
            else
                v2 = i
            end
            v1[i] = v2
        end
    end,
}
function u24.new() -- Line: 48 -- upvalues: u24 (val)
    local v1 = {
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
    }
    return (setmetatable(v1, u24))
end
function u24.__index(p1, p2) -- Line: 67 -- upvalues: u24 (val), u9 (val)
    if u24[p2] or u24["_" .. string.lower(p2)] then
        return u24[p2]
    end
    if u9[p2] then
        return p1["_" .. string.lower(p2)]
    end
    local v1 = ("%q is not a valid member of playerState"):format((tostring(p2)))
    error(v1, 2)
end
function u24.__newindex(p1, p2, p3) -- Line: 77 -- upvalues: u9 (val), u4 (ref), u22 (val), ChangeStateEvent (val)
    local v1 = nil
    if not (u9[p2]) then
        local v2 = ("%q is not a valid member of playerState"):format((tostring(p2)))
        error(v2, 2)
    else
        v1 = p1[p2]
        p1["_" .. string.lower(p2)] = p3
    end
    if v1 ~= nil and v1 ~= p3 then
        u4:SetState(game.Players.LocalPlayer, p2, p3)
        if not (u22[p2]) then
            ChangeStateEvent:FireServer({u9[p2], p3})
        end
    end
end
return u24