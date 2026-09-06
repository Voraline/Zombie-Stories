require("./types/fusion")
local u8 = require(script.Parent.utils["lock-value"])
local function isSimilar(p1, p2) -- Line: 4
    local v1
    local v2 = typeof(p1)
    local v3 = v2 == "table"
    local v4 = v2 == "userdata"
    if v3 then
        if v2 ~= typeof(p2) then
            return false
        end
        if v4 or table.isfrozen(p1) then
            v1 = p1 == p2
            return v1
        end
        if getmetatable(p1) == nil then
            return false
        end
        v1 = p1 == p2
        return v1
    elseif not v4 then
        v1 = true
        if p1 == p2 then
            return v1
        end
        v1 = false
        if p1 == p1 then
            return v1
        end
        v1 = p2 ~= p2
        return v1
    end
end
return function(p1, p2, p3) -- Line: 24 -- upvalues: isSimilar (val), u8 (val)
    local peek = p1.peek
    local u7 = p1:Value(nil)
    local u9 = p3
    if not u9 then
        u9 = isSimilar
    end
    local v1 = p1:Observer(p2)
    v1:onChange(function() -- Line: 34 -- upvalues: peek (val), p2 (val), u7 (val), u9 (val)
        local v1 = peek(p2)
        local v2 = peek(u7)
        if not (u9(v2, v1)) then
            u7:set(v1)
        end
    end)
    return u8(u7)
end