require("./types/fusion")

local function doNothing() end

return function(p1, p2) -- Line: 10 -- upvalues: doNothing (val)
    local v1 = p1:Computed(function(p1, p2_2) -- Line: 14 -- upvalues: p2 (val)
        p2(p1, p2_2)
        return {}
    end)
    local v2 = p1:Observer(v1)
    v1 = doNothing
    v2:onChange(v1)
end