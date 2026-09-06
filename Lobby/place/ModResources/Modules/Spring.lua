local v1, v2
local RunService = game:GetService("RunService")
local u5 = typeof
local u6 = unpack
local sin = math.sin
local cos = math.cos
local exp = math.exp
local floor = math.floor
local min = math.min
local u12 = {}
u12.__index = u12
function u12.new(p1, p2, p3, p4) -- Line: 21 -- upvalues: u12 (val)
    local v1 = p4.toIntermediate(p3)
    local v2 = {
        d = p1,
        f = p2,
        g = v1,
        p = v1,
        v = v1 * 0,
        typedat = p4,
    }
    return (setmetatable(v2, u12))
end
function u12:setGoal(p2) -- Line: 33
    self.g = self.typedat.toIntermediate(p2)
end
function u12:setSpringParams(p2, p3) -- Line: 37
    self.d = p2
    self.f = p3
end
function u12:canSleep() -- Line: 42
    local v1 = self.v:norm()
    local v2 = (self.p - self.g):norm()
    local v3 = if v1 < 1e-12 then v2 < 1e-10 else false
    return v3
end
function u12:step(p2) -- Line: 48 -- upvalues: exp (val), cos (val), sin (val)
    local v1, v2
    local d = self.d
    local v3 = self.f * 6.2831853071796
    local g = self.g
    local v = self.v
    local v4 = self.p - g
    local v5 = exp(-d * v3 * p2)
    if d == 1 then
        v2 = (v4 * (1 + v3 * p2) + v * p2) * v5 + g
        v1 = (v * (1 - v3 * p2) - v4 * (v3 * v3 * p2)) * v5
    else
        local v6, v7, v8
        if d >= 1 then
            v6 = (d * d - 1) ^ 0.5
            v7 = -v3 * (d - v6)
            v8 = -v3 * (d + v6)
            local v9 = (v - v4 * v7) / (2 * v3 * v6)
            local v10 = (v4 - v9) * exp(v7 * p2)
            local v11 = v9 * exp(v8 * p2)
            v2 = v10 + v11 + g
            v1 = v10 * v7 + v11 * v8
        else
            v6 = (1 - d * d) ^ 0.5
            v7 = cos(p2 * v3 * v6)
            v8 = sin(p2 * v3 * v6)
            local v12 = v8 / v6
            v2 = (v4 * (v7 + v12 * d) + v * (v8 / (v3 * v6))) * v5 + g
            v1 = (v * (v7 - v12 * d) - v4 * (v12 * v3)) * v5
        end
    end
    self.p = v2
    self.v = v1
    return self.typedat.fromIntermediate(v2)
end
local u18 = {}
u18.__index = u18
function u18.new(...) -- Line: 102 -- upvalues: u18 (val)
    local v1 = {...}
    return (setmetatable(v1, u18))
end
function u18.__add(p1, p2) -- Line: 106 -- upvalues: u6 (val), u18 (val)
    local v1 = setmetatable({u6(p1)}, u18)
    local v2 = #v1
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = v1[i] + p2[i]
    end
    return v1
end
function u18.__sub(p1, p2) -- Line: 114 -- upvalues: u6 (val), u18 (val)
    local v1 = setmetatable({u6(p1)}, u18)
    local v2 = #v1
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = v1[i] - p2[i]
    end
    return v1
end
function u18.__mul(p1, p2) -- Line: 122 -- upvalues: u6 (val), u18 (val)
    local v1 = setmetatable({u6(p1)}, u18)
    local v2 = #v1
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = v1[i] * p2
    end
    return v1
end
function u18.__div(p1, p2) -- Line: 130 -- upvalues: u6 (val), u18 (val)
    local v1 = setmetatable({u6(p1)}, u18)
    local v2 = #v1
    local v3 = 1
    for i = 1, v2, v3 do
        v1[i] = v1[i] / p2
    end
    return v1
end
function u18.norm(p1) -- Line: 138
    local v1 = 0
    local v2 = next
    local v3 = p1
    local v4 = nil
    for k, v in v2, v3, v4 do
        v1 = v1 + v * v
    end
    return v1
end
local u25 = {
    number = {
        springType = u12,
        toIntermediate = function(p1) -- Line: 150 -- upvalues: u18 (val)
            return u18.new(p1)
        end,
        fromIntermediate = function(p1) -- Line: 153
            return p1[1]
        end,
    },
    NumberRange = {
        springType = u12,
        toIntermediate = function(p1) -- Line: 170 -- upvalues: u18 (val)
            return u18.new(p1.Min, p1.Max)
        end,
        fromIntermediate = function(p1) -- Line: 173
            return NumberRange.new(p1[1], p1[2])
        end,
    },
    UDim = {
        springType = u12,
        toIntermediate = function(p1) -- Line: 180 -- upvalues: u18 (val)
            return u18.new(p1.Scale, p1.Offset)
        end,
        fromIntermediate = function(p1) -- Line: 183
            return UDim.new(p1[1], p1[2])
        end,
    },
    UDim2 = {
        springType = u12,
        toIntermediate = function(p1) -- Line: 190 -- upvalues: u18 (val)
            local X = p1.X
            local Y = p1.Y
            return u18.new(X.Scale, X.Offset, Y.Scale, Y.Offset)
        end,
        fromIntermediate = function(p1) -- Line: 195 -- upvalues: floor (val)
            local v1 = floor(p1[2] + 0.5)
            return UDim2.new(p1[1], v1, p1[3], (floor(p1[4] + 0.5)))
        end,
    },
    Vector2 = {
        springType = u12,
        toIntermediate = function(p1) -- Line: 202 -- upvalues: u18 (val)
            return u18.new(p1.X, p1.Y)
        end,
        fromIntermediate = function(p1) -- Line: 205
            return Vector2.new(p1[1], p1[2])
        end,
    },
    Vector3 = {
        springType = u12,
        toIntermediate = function(p1) -- Line: 212 -- upvalues: u18 (val)
            return u18.new(p1.X, p1.Y, p1.Z)
        end,
        fromIntermediate = function(p1) -- Line: 215
            return (Vector3.new(p1[1], p1[2], p1[3]))
        end,
    },
}
v1 = {
    springType = u12,
    toIntermediate = function(p1) -- Line: 222 -- upvalues: u18 (val)
        local v1, v2
        local r = p1.r
        local g = p1.g
        local b = p1.b
        if r >= 0.0404482362771076 then
            v1 = 0.87941546140213 * (r + 0.055) ^ 2.4
        else
            v1 = r / 12.92
        end
        local v3 = v1
        if g >= 0.0404482362771076 then
            v1 = 0.87941546140213 * (g + 0.055) ^ 2.4
        else
            v1 = g / 12.92
        end
        local v4 = v1
        if b >= 0.0404482362771076 then
            v1 = 0.87941546140213 * (b + 0.055) ^ 2.4
        else
            v1 = b / 12.92
        end
        local v5 = v1
        v1 = 0.9257063972951867 * v3 - 0.8333736323779866 * v4 - 0.09209820666085898 * v5
        local v6 = 0.2125862307855956 * v3 + 0.7151703037034108 * v4 + 0.0722004986433362 * v5
        local v7 = 3.6590806972265884 * v3
        local v8 = v7 + 11.442689580057424 * v4
        local v9 = v8 + 4.114991502426484 * v5
        if 0.008856451679035631 >= v6 then
            v8 = 903.296296296296 * v6
        else
            v8 = 116 * v6 ^ 0.3333333333333333 - 16
            if not v8 then
                v8 = 903.296296296296 * v6
            end
        end
        if 1e-15 >= v9 then
            v7 = -0.19783 * v8
            v2 = -0.46832 * v8
        else
            v7 = v8 * v1 / v9
            v2 = v8 * (9 * v6 / v9 - 0.46832)
        end
        return u18.new(v8, v7, v2)
    end,
}
function v1.fromIntermediate(p1) -- Line: 245 -- upvalues: min (val)
    local v1, v2, v3, v4
    local v5 = p1[1]
    if v5 < 0.0197955 then
        return Color3.new()
    end
    local v6 = p1[2] / v5 + 0.19783
    local v7 = p1[3] / v5 + 0.46832
    local v8 = (v5 + 16) / 116
    if 0.20689655172413793 >= v8 then
        v4 = 0.12841854934601665 * v8 - 0.01771290335807126
    else
        v4 = v8 * v8 * v8
    end
    v8 = v4
    v4 = v8 * v6 / v7
    local v9 = v8 * ((3 - 0.75 * v6) / v7 - 5)
    local v10 = 7.2914074 * v4 - 1.537208 * v8 - 0.4986286 * v9
    local v11 = -2.180094 * v4 + 1.8757561 * v8 + 0.0415175 * v9
    local v12 = 0.1253477 * v4 - 0.2040211 * v8 + 1.0569959 * v9
    if v10 >= 0 then
        if v11 >= 0 then
            if v12 < 0 then
                v10 = v10 - v12
                v11 = v11 - v12
                v12 = 0
            end
        elseif v11 < v12 then
            v10 = v10 - v11
            v12 = v12 - v11
            v11 = 0
        end
    elseif v10 < v11 and v10 < v12 then
        v11 = v11 - v10
        v12 = v12 - v10
        v10 = 0
    end
    local new = Color3.new
    if v10 >= 0.0031306684425 then
        v1 = 1.055 * v10 ^ 0.4166666666666667 - 0.055
    else
        v1 = 12.92 * v10
    end
    local v13 = min(v1, 1)
    if v11 >= 0.0031306684425 then
        v2 = 1.055 * v11 ^ 0.4166666666666667 - 0.055
    else
        v2 = 12.92 * v11
    end
    v1 = min(v2, 1)
    if v12 >= 0.0031306684425 then
        v3 = 1.055 * v12 ^ 0.4166666666666667 - 0.055
    else
        v3 = 12.92 * v12
        if not v3 then
            v3 = 1.055 * v12 ^ 0.4166666666666667 - 0.055
        end
    end
    return new(v13, v1, (min(v3, 1)))
end
u25.Color3 = v1
local u47 = {}
RunService.RenderStepped:Connect(function(p1) -- Line: 281 -- upvalues: u47 (val)
    local v1, v2, v3
    local v4 = next
    local v5 = u47
    local v6 = nil
    for k, v in v4, v5, v6 do
        v1 = next
        v2 = v
        v3 = nil
        for k2, i in v1, v2, v3 do
            k[k2] = i:step(v7)
            if i:canSleep() then
                v[k2] = nil
            end
        end
        if not (next(v)) then
            u47[k] = nil
        end
    end
end)
v2 = {
    target = function(p1, p2, p3, p4) -- Line: 298 -- upvalues: u47 (val), u25 (val), u5 (val)
        local v1, v2, v3, v4, v5
        local v6 = u47[p1]
        if not v6 then
            u47[p1] = {}
        end
        local v7 = next
        local v8 = p4
        local v9 = nil
        v2, v5, v1 = p2, p3, p1
        for k, v in v7, v8, v9 do
            v3 = v6[k]
            if not v3 then
                v4 = u25[u5(v)]
                v3 = v4.springType.new(v2, v5, v1[k], v4)
                v6[k] = v3
            end
            v3:setSpringParams(v2, v5)
            v3:setGoal(v)
        end
    end,
    stop = function(p1, p2) -- Line: 319 -- upvalues: u47 (val)
        if not p2 then
            u47[p1] = nil
            return
        end
        local v1 = u47[p1]
        if not v1 then
            return
        end
        v1[p2] = nil
    end,
}
v2.Target = v2.target
v2.Stop = v2.stop
return v2