require("./types/fusion")
local u7 = require(script.Parent["use-viewport"])
local u11 = Vector2.new(1600, 900)
return function(p1, p2, p3, p4) -- Line: 25 -- upvalues: u11 (val), u7 (val)
    local v1 = p2
    if not v1 then
        v1 = u11
    end
    local u7_2 = v1
    local u9 = p3 or 0.5
    local u11_2 = p4 or 0.5
    local u15 = u7(p1)
    local u19 = p1:Computed(function(p1) -- Line: 37 -- upvalues: u15 (val), u7_2 (ref), u11_2 (ref), u9 (ref)
        local v1 = p1(u15)
        local v2 = v1.X / u7_2.X
        local v3 = math.log(v2, 2)
        local v4 = v1.Y / u7_2.Y
        local v5 = 2 ^ (v3 + (math.log(v4, 2) - v3) * u11_2)
        local v6 = u9
        return (math.max(v5, v6))
    end)
    local v2 = {}
    local v3 = {
        __call = function(p1_2, p2) -- Line: 47 -- upvalues: p1 (val), u19 (val)
            local v1 = p1
            return v1:Computed(function(p1) -- Line: 48 -- upvalues: p2 (val), u19 (upval)
                return p2 * p1(u19)
            end)
        end,
    }
    setmetatable(v2, v3)

    function v2.even(p1_2, p2) -- Line: 54 -- upvalues: p1 (val), u19 (val)
        local v1 = p1
        return v1:Computed(function(p1) -- Line: 55 -- upvalues: p2 (val), u19 (upval)
            local v1 = p2
            local v2 = u19
            local v3 = v1 * (p1(v2)) * 0.5
            return math.round(v3) * 2
        end)
    end

    function v2.scale(p1_2, p2) -- Line: 60 -- upvalues: p1 (val), u19 (val)
        local v1 = p1
        return v1:Computed(function(p1) -- Line: 61 -- upvalues: p2 (val), u19 (upval)
            return p2 * p1(u19)
        end)
    end

    function v2.floor(p1_2, p2) -- Line: 66 -- upvalues: p1 (val), u19 (val)
        local v1 = p1
        return v1:Computed(function(p1) -- Line: 67 -- upvalues: p2 (val), u19 (upval)
            local v1 = p2
            local v2 = u19
            local v3 = v1 * (p1(v2))
            return (math.floor(v3))
        end)
    end

    function v2.ceil(p1_2, p2) -- Line: 72 -- upvalues: p1 (val), u19 (val)
        local v1 = p1
        return v1:Computed(function(p1) -- Line: 73 -- upvalues: p2 (val), u19 (upval)
            local v1 = p2
            local v2 = u19
            local v3 = v1 * (p1(v2))
            return (math.ceil(v3))
        end)
    end

    return v2
end