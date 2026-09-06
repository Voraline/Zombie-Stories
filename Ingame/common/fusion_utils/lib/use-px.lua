require("./types/fusion")
local u7 = require(script.Parent["use-viewport"])
local u11 = Vector2.new(1600, 900)
return function(p1, p2, p3, p4) -- Line: 25 -- upvalues: u11 (val), u7 (val)
    local u11, v1
    local v2 = p2
    if not v2 then
        v2 = u11
    end
    local u7 = v2
    local u9 = p3 or 0.5
    u11 = p4 or 0.5
    local u15 = u7(p1)
    local u19 = p1:Computed(function(p1) -- Line: 37 -- upvalues: u15 (val), u7 (ref), u11 (ref), u9 (ref)
        local v1 = p1(u15)
        local v2 = math.log(v1.X / u7.X, 2)
        local v3 = 2 ^ (v2 + (math.log(v1.Y / u7.Y, 2) - v2) * u11)
        return (math.max(v3, u9))
    end)
    v1 = {}
    setmetatable(v1, {
        __call = function(a1, p2) -- Line: 47 -- upvalues: p1 (val), u19 (val)
            return p1:Computed(function(p1) -- Line: 48 -- upvalues: p2 (val), u19 (upval)
                return p2 * p1(u19)
            end)
        end,
    })
    function v1.even(a1, p2) -- Line: 54 -- upvalues: p1 (val), u19 (val)
        return p1:Computed(function(p1) -- Line: 55 -- upvalues: p2 (val), u19 (upval)
            return math.round(p2 * p1(u19) * 0.5) * 2
        end)
    end
    function v1.scale(a1, p2) -- Line: 60 -- upvalues: p1 (val), u19 (val)
        return p1:Computed(function(p1) -- Line: 61 -- upvalues: p2 (val), u19 (upval)
            return p2 * p1(u19)
        end)
    end
    function v1.floor(a1, p2) -- Line: 66 -- upvalues: p1 (val), u19 (val)
        return p1:Computed(function(p1) -- Line: 67 -- upvalues: p2 (val), u19 (upval)
            return (math.floor(p2 * p1(u19)))
        end)
    end
    function v1.ceil(a1, p2) -- Line: 72 -- upvalues: p1 (val), u19 (val)
        return p1:Computed(function(p1) -- Line: 73 -- upvalues: p2 (val), u19 (upval)
            return (math.ceil(p2 * p1(u19)))
        end)
    end
    return v1
end