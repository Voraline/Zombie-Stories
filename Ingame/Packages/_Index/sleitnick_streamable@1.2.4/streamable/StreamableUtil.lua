local Trove = require(script.Parent.Parent.Trove)
require(script.Parent.Streamable)
local v1 = {}
function v1.Compound(p1, p2) -- Line: 47 -- upvalues: Trove (val)
    local v1 = Trove.new()
    local u7 = Trove.new()
    local u8 = false
    local function Check() -- Line: 51 -- upvalues: u8 (ref), p1 (val), p2 (val), u7 (val)
        if u8 then
            return
        end
        for k, v in pairs(p1) do
            if not v.Instance then
                return
            end
        end
        u8 = true
        p2(p1, u7)
    end
    local function Cleanup() -- Line: 63 -- upvalues: u8 (ref), u7 (val)
        if not u8 then
            return
        end
        u8 = false
        u7:Clean()
    end
    for k, v in pairs(p1) do
        v1:Add(v:Observe(function(a1, a2) -- Line: 71 -- upvalues: u8 (ref), p1 (val), p2 (val), u7 (val), Cleanup (val)
            if not u8 then
                for k, v in pairs(p1) do
                    if not v.Instance then
                        a2:Add(Cleanup)
                        return
                    end
                end
                u8 = true
                p2(p1, u7)
            end
            a2:Add(Cleanup)
        end))
    end
    v1:Add(Cleanup)
    return v1
end
return v1