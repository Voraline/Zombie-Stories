require("./types/fusion")
local function doNothing() end
return function(p1, p2) -- Line: 10 -- upvalues: doNothing (val)
    local v1 = p1:Observer(p1:Computed(function(p1, a2) -- Line: 14 -- upvalues: p2 (val)
        p2(p1, a2)
        return {}
    end))
    v1:onChange(doNothing)
end