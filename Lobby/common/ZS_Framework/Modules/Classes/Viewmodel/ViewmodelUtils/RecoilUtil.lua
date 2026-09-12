local Utils = script.Parent.Parent.Parent.Parent.Utils
local SpringUtil = require(Utils.SpringUtil)
local u11 = require("./PointRotationUtil")
local Controllers = script.Parent.Parent.Parent.Parent.Controllers
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
local u28 = CFrame.new(0.588401794, 0.546500206, -4.0329895)

local function null(p1) -- Line: 12
    local v1 = false
    if p1 <= 0.0001 then
        v1 = -0.0001 <= p1
    end
    return v1
end

local u30 = {}
u30.__index = u30
local u31 = {}

function u30.new(p1) -- Line: 24 -- upvalues: u30 (val), SpringUtil (val), u31 (val)
    local v1 = u30
    local v2 = setmetatable({}, v1)
    v2.Weapon = p1
    v2.SpringPos = SpringUtil.new((Vector3.new()))
    v2.SpringPos.Target = Vector3.new()
    v2.SpringPos.Speed = 15
    v2.SpringPos.Damper = 0.6
    v2.SpringRot = SpringUtil.new((Vector3.new()))
    v2.SpringRot.Target = Vector3.new()
    v2.SpringRot.Speed = 7
    v2.SpringRot.Damper = 0.6
    v2.BackImpulse = CFrame.new()
    u31[p1] = v2
    return v2
end

function u30.getOrCreate(p1) -- Line: 46 -- upvalues: u31 (val), u30 (val)
    if not u31[p1] then
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
    local v3 = p2 + 0.075 * p7
    local v4 = p3 + 0.09 + math.random() * 0.01 * p8 * p7
    local v5 = p4 + 0.015 * p7
    local v6 = v1 * 0.1 * p8
    local v7 = p5 + math.rad(v6)
    local v8 = 0.01 * v1
    return v2, v3, v4, v5, v7, p6 + v8 * (p8 * 0.5)
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
    elseif not VerticalRecoil or not HorizontalRecoil then
        v1 = X + math.random(0, 1000) * 7e-05
        v2 = Y + math.random(0, 1000) * 7e-05 + 0.05
        v9 = Z + 0.12
        v10 = X + 0.025
        v4 = (math.random(-500, 500)) * 0.003
        v11 = Y + math.rad(v4)
        v12 = 0.01
        v7 = v1
        v8 = v2
    else
        v1, v2, v3, v4, v5, v6 = u30.VMImpulse(X, Y, Z, X_2, Y_2, Z_2, VerticalRecoil, HorizontalRecoil)
        v7 = v1
        v8 = v2
        v9 = v3
        v10 = v4
        v11 = v5
        v12 = v6
    end
    if LocalPlayerController.States.Crouching or LocalPlayerController.States.Sliding then
        v1 = Config.CrouchRecoilMultiplier or 0.92
    elseif not LocalPlayerController.States.Proning then
        v1 = Config.StandardRecoilMultiplier or 1
    else
        v1 = Config.ProneRecoilMultiplier or 0.85
    end
    v7 = v7 * v1
    v8 = v8 * v1
    v9 = v9 * v1
    v10 = v10 * v1
    v11 = v11 * v1
    v12 = v12 * v1
    self.SpringPos.Position = Vector3.new(v7, v8, v9)
    self.SpringRot.Position = Vector3.new(v10, v11, v12)
end

function u30:GetPitchRecoil() -- Line: 106
    return self.SpringRot.Position.X * 0.6
end

function u30:Update(p2, p3, p4) -- Line: 111 -- upvalues: u11 (val), u28 (val)
    local v1
    local X = self.SpringPos.Position.X
    local Y = self.SpringPos.Position.Y
    local Z = self.SpringPos.Position.Z
    local X_2 = self.SpringRot.Position.X
    local Y_2 = self.SpringRot.Position.Y
    local Z_2 = self.SpringRot.Position.Z
    local BackImpulse = self.BackImpulse
    local v2 = (CFrame.new(X, Y - X_2 / 1.5, 0)) * CFrame.Angles(X_2 / 3, Y_2, Z_2)
    local v3 = p2 * 10
    local v4 = math.min(1, v3)
    self.BackImpulse = BackImpulse:Lerp(v2, v4)
    local LookVector = (CFrame.new()).LookVector
    local LookVector_2 = self.BackImpulse.LookVector
    local v5 = LookVector:Dot(LookVector_2)
    local v6 = math.acos(v5)
    v5 = false
    if v6 <= 0.0001 then
        v5 = -0.0001 <= v6
    end
    if v5 then
        local Magnitude = self.BackImpulse.Position.Magnitude
        v5 = false
        if Magnitude <= 0.0001 then
            v5 = -0.0001 <= Magnitude
        end
        if v5 then
            self.BackImpulse = CFrame.new()
        end
    end
    local BackImpulse_3 = self.BackImpulse
    local new_3 = CFrame.new
    local v7 = false
    if Z <= 0.0001 then
        v7 = -0.0001 <= Z
    end
    if not v7 then
        v1 = Z
    else
        v1 = 0
    end
    v5 = BackImpulse_3 * new_3(0, 0, v1)
    v4 = CFrame.new()
    local Position_4 = p3.Position
    v5 = v5:Lerp(v4, Position_4)
    v2 = X_2 * 0.6
    local v8 = v2
    v4 = false
    if v8 <= 0.0001 then
        v4 = -0.0001 <= v8
    end
    if v4 then
        v2 = 0
    end
    local new_5 = CFrame.new
    v8 = 0
    v3 = 0
    v7 = false
    if Z <= 0.0001 then
        v7 = -0.0001 <= Z
    end
    if not v7 then
        if not self.Weapon.Aiming then
            v7 = 1
        else
            v7 = 2
        end
        v1 = Z / v7
    else
        v1 = 0
    end
    v4 = new_5(v8, v3, v1)
    v8 = CFrame.Angles(v2, 0, 0)
    v1 = v5 * CFrame.Angles(v2, 0, 0)
    local Position_5 = p4.Position
    v8 = v8:Lerp(v1, Position_5)
    v3 = u11
    local UpdateRotation = v3.UpdateRotation
    v7 = u28
    local v9 = v4 * CFrame.Angles(0, 0, Y_2)
    local Position_6 = p3.Position
    UpdateRotation("Recoil", v7, v8:Lerp(v9, Position_6))
    v7 = CFrame.new()
    local Position_7 = p4.Position
    return v5:Lerp(v7, Position_7)
end

u30.CurrentWeapon = nil
local v1 = {
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
                if u30.CurrentWeapon then
                    local v1 = u31[u30.CurrentWeapon]
                    if v1 then
                        return v1:Update(p2, p3, p4)
                    end
                end
                return CFrame.new()
            end
        end
        if p2 == "GetPitchRecoil" then
            return function() -- Line: 170 -- upvalues: u30 (upval), u31 (upval)
                if u30.CurrentWeapon then
                    local v1 = u31[u30.CurrentWeapon]
                    if v1 then
                        return v1:GetPitchRecoil()
                    end
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
return (setmetatable({}, v1))