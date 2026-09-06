local v1, v2
local SpringUtil = require(script.Parent.Parent.Parent.Parent.Utils.SpringUtil)
local u11 = require("./PointRotationUtil")
local LocalPlayerController = require(script.Parent.Parent.Parent.Parent.Controllers:WaitForChild("LocalPlayerController"))
local u28 = CFrame.new(0.588401794, 0.546500206, -4.0329895)
local function null(p1) -- Line: 12
    local v1 = if p1 <= 0.0001 then -0.0001 <= p1 else false
    return v1
end
local u30 = {}
u30.__index = u30
local u31 = {}
function u30.new(p1) -- Line: 24 -- upvalues: u30 (val), SpringUtil (val), u31 (val)
    local v1 = setmetatable({}, u30)
    v1.Weapon = p1
    v1.SpringPos = SpringUtil.new((Vector3.new()))
    v1.SpringPos.Target = Vector3.new()
    v1.SpringPos.Speed = 15
    v1.SpringPos.Damper = 0.6
    v1.SpringRot = SpringUtil.new((Vector3.new()))
    v1.SpringRot.Target = Vector3.new()
    v1.SpringRot.Speed = 7
    v1.SpringRot.Damper = 0.6
    v1.BackImpulse = CFrame.new()
    u31[p1] = v1
    return v1
end
function u30.getOrCreate(p1) -- Line: 46 -- upvalues: u31 (val), u30 (val)
    if not (u31[p1]) then
        return u30.new(p1)
    end
    return u31[p1]
end
function u30.remove(p1) -- Line: 54 -- upvalues: u31 (val)
    u31[p1] = nil
end
function u30.VMImpulse(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 59
    local v1 = math.random() - 0.5
    local v2 = p1 + math.random() * 0.02 * p8
    local v3 = p3 + 0.09 + math.random() * 0.01 * p8 * p7
    local v4 = p5 + math.rad(v1 * 0.1 * p8)
    return v2, p2 + 0.075 * p7, v3, p4 + 0.015 * p7, v4, p6 + 0.01 * v1 * (p8 * 0.5)
end
function u30:Impulse() -- Line: 71 -- upvalues: LocalPlayerController (val), u30 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local Config = self.Weapon.Config
    local X = self.SpringPos.Position.X
    local Y = self.SpringPos.Position.Y
    local Z = self.SpringPos.Position.Z
    local X_2 = self.SpringRot.Position.X
    local Y_2 = self.SpringRot.Position.Y
    local Z_2 = self.SpringRot.Position.Z
    local VerticalRecoil = Config.VerticalRecoil
    local HorizontalRecoil = Config.HorizontalRecoil
    if Config.VMImpulse then
        v1, v2, v3, v4, v5, v6 = Config.VMImpulse(self.Weapon, LocalPlayerController, X, Y, Z, X_2, Y_2, Z_2, VerticalRecoil, HorizontalRecoil)
        v7 = v1
        v8 = v2
        v9 = v3
        v10 = v4
        v11 = v5
        v12 = v6
    elseif not VerticalRecoil then
        v1 = X + math.random(0, 1000) * 7e-05
        v2 = Y + math.random(0, 1000) * 7e-05 + 0.05
        v9 = Z + 0.12
        v10 = X + 0.025
        v11 = Y + math.rad(math.random(-500, 500) * 0.003)
        v12 = 0.01
        v7 = v1
        v8 = v2
    elseif HorizontalRecoil then
        v1, v2, v3, v4, v5, v6 = u30.VMImpulse(X, Y, Z, X_2, Y_2, Z_2, VerticalRecoil, HorizontalRecoil)
        v7 = v1
        v8 = v2
        v9 = v3
        v10 = v4
        v11 = v5
        v12 = v6
    end
    if LocalPlayerController.States.Crouching then
        v1 = Config.CrouchRecoilMultiplier or 0.92
    elseif LocalPlayerController.States.Sliding then
        v1 = Config.CrouchRecoilMultiplier or 0.92
    elseif not LocalPlayerController.States.Proning then
        v1 = Config.StandardRecoilMultiplier or 1
    else
        v1 = Config.ProneRecoilMultiplier or 0.85
    end
    self.SpringPos.Position = Vector3.new(v7 * v1, v8 * v1, v9 * v1)
    self.SpringRot.Position = Vector3.new(v10 * v1, v11 * v1, v12 * v1)
end
function u30:GetPitchRecoil() -- Line: 106
    return self.SpringRot.Position.X * 0.6
end
function u30:Update(p2, p3, p4) -- Line: 111 -- upvalues: u11 (val), u28 (val)
    local new, v1
    local Z = self.SpringPos.Position.Z
    local X = self.SpringRot.Position.X
    local Y = self.SpringRot.Position.Y
    local v2 = CFrame.new(self.SpringPos.Position.X, self.SpringPos.Position.Y - X / 1.5, 0)
    local v3 = v2 * CFrame.Angles(X / 3, Y, self.SpringRot.Position.Z)
    self.BackImpulse = self.BackImpulse:Lerp(v3, (math.min(1, p2 * 10)))
    local v4 = math.acos((CFrame.new().LookVector:Dot(self.BackImpulse.LookVector)))
    local v5 = if v4 <= 0.0001 then -0.0001 <= v4 else false
    if v5 then
        local Magnitude = self.BackImpulse.Position.Magnitude
        v5 = if Magnitude <= 0.0001 then -0.0001 <= Magnitude else false
        if v5 then
            self.BackImpulse = CFrame.new()
        end
    end
    local v6 = if Z <= 0.0001 then -0.0001 <= Z else false
    if not v6 then
        v1 = Z
    else
        v1 = 0
    end
    v5 = self.BackImpulse * CFrame.new(0, 0, v1)
    v5 = v5:Lerp(CFrame.new(), p3.Position)
    v3 = X * 0.6
    local v7 = v3
    v2 = if v7 <= 0.0001 then -0.0001 <= v7 else false
    if v2 then
        v3 = 0
    end
    new = CFrame.new
    v6 = if Z <= 0.0001 then -0.0001 <= Z else false
    if not v6 then
        if not self.Weapon.Aiming then
            v6 = 1
        else
            v6 = 2
        end
        v1 = Z / v6
    else
        v1 = 0
    end
    v2 = new(0, 0, v1)
    v7 = CFrame.Angles(v3, 0, 0)
    v1 = v5 * CFrame.Angles(v3, 0, 0)
    v7 = v7:Lerp(v1, p4.Position)
    local v8 = v2 * CFrame.Angles(0, 0, Y)
    u11.UpdateRotation("Recoil", u28, v7:Lerp(v8, p3.Position))
    return v5:Lerp(CFrame.new(), p4.Position)
end
u30.CurrentWeapon = nil
v1 = {}
v2 = {
    __index = function(p1, p2) -- Line: 145 -- upvalues: u30 (val), u31 (val)
        if p2 == "CurrentWeapon" then
            return u30.CurrentWeapon
        end
        if p2 == "Impulse" then
            return function() -- Line: 149 -- upvalues: u30 (upval), u31 (upval)
                if u30.CurrentWeapon then
                    local v1 = u31[u30.CurrentWeapon]
                    if v1 then
                        v1:Impulse()
                    end
                end
            end
        end
        if p2 == "VMImpulse" then
            return u30.VMImpulse
        end
        if p2 == "Update" then
            return function(p1, p2, p3, p4) -- Line: 160 -- upvalues: u30 (upval), u31 (upval)
                if not u30.CurrentWeapon then
                    return CFrame.new()
                end
                local v1 = u31[u30.CurrentWeapon]
                if v1 then
                    return v1:Update(p2, p3, p4)
                end
                return CFrame.new()
            end
        end
        if p2 == "GetPitchRecoil" then
            return function() -- Line: 170 -- upvalues: u30 (upval), u31 (upval)
                if not u30.CurrentWeapon then
                    return 0
                end
                local v1 = u31[u30.CurrentWeapon]
                if v1 then
                    return v1:GetPitchRecoil()
                end
                return 0
            end
        end
        if p2 == "new" then
            return u30.new
        end
        if p2 == "getOrCreate" then
            return u30.getOrCreate
        end
        if p2 == "remove" then
            return u30.remove
        end
        return u30[p2]
    end,
    __newindex = function(p1, p2, p3) -- Line: 188 -- upvalues: u30 (val)
        if p2 == "CurrentWeapon" then
            u30.CurrentWeapon = p3
            return
        end
        rawset(p1, p2, p3)
    end,
}
return (setmetatable(v1, v2))