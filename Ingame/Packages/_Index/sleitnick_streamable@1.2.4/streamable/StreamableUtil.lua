local Trove = require(script.Parent.Parent.Trove)
require(script.Parent.Streamable)
return {
    Compound = function(p1, p2) -- Line: 47 -- upvalues: Trove (val)
        local v1
        local v2 = Trove.new()
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
            v1 = v:Observe(function(p1_2, p2_2) -- Line: 71 -- upvalues: u8 (ref), p1 (val), p2 (val), u7 (val), Cleanup (val)
                local v1
                if not u8 then
                    for k, v in pairs(p1) do
                        if not v.Instance then
                            v1 = Cleanup
                            p2_2:Add(v1)
                            return
                        end
                    end
                    u8 = true
                    p2(p1, u7)
                end
                v1 = Cleanup
                p2_2:Add(v1)
            end)
            v2:Add(v1)
        end
        v2:Add(Cleanup)
        return v2
    end,
}