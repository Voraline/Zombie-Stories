local Parent = script.Parent.Parent
require(Parent.PubTypes)
local logWarn = require(Parent.Logging.logWarn)
local Observer = require(Parent.State.Observer)
local xtypeof = require(Parent.Utility.xtypeof)
return {
    type = "SpecialKey",
    kind = "Children",
    stage = "descendants",
    apply = function(p1, p2, p3, p4) -- Line: 24 -- upvalues: xtypeof (val), Observer (val), logWarn (val)
        local u4 = {}
        local u5 = {}
        local u6 = {}
        local u7 = {}
        local u8 = false
        local u9 = nil
        local function updateChildren() -- Line: 38 -- upvalues: u8 (ref), u5 (ref), u4 (ref), u7 (ref), u6 (ref), xtypeof (upval), p3 (val), Observer (upval), u9 (ref), logWarn (upval), p2 (ref)
            local processChild
            if not u8 then
                return
            end
            u8 = false
            u5 = u4
            u4 = u5
            u7 = u6
            u6 = u7
            table.clear(u4)
            table.clear(u6)
            function processChild(p1, p2) -- Line: 49 -- upvalues: xtypeof (upval), u4 (upval), u5 (upval), p3 (upval), processChild (val), u7 (upval), Observer (upval), u9 (upval), u6 (upval), logWarn (upval)
                local v1, v2
                local v3 = xtypeof(p1)
                if v3 == "Instance" then
                    u4[p1] = true
                    if u5[p1] == nil then
                        p1.Parent = p3
                        return
                    end
                    u5[p1] = nil
                    return
                end
                if v3 == "State" then
                    local v4 = p1:get(false)
                    if v4 ~= nil then
                        processChild(v4, p2)
                    end
                    local v5 = u7[p1]
                    if v5 ~= nil then
                        u7[p1] = nil
                    else
                        v5 = Observer(p1):onChange(u9)
                    end
                    u6[p1] = v5
                    return
                end
                if v3 ~= "table" then
                    logWarn("unrecognisedChildType", v3)
                    return
                end
                local v6 = p2
                for k, v in pairs(p1) do
                    v1 = typeof(k)
                    v2 = nil
                    if v1 == "string" then
                        v2 = k
                    elseif v1 == "number" and v6 ~= nil then
                        v2 = v6 .. "_" .. k
                    end
                    processChild(v, v2)
                end
            end
            if p2 ~= nil then
                processChild(p2)
            end
            for k in pairs(u5) do
                k.Parent = nil
            end
            for k2, v in pairs(u7) do
                v()
            end
        end
        function u9() -- Line: 130 -- upvalues: u8 (ref), updateChildren (val)
            if not u8 then
                u8 = true
                task.defer(updateChildren)
            end
        end
        table.insert(p4, function() -- Line: 137 -- upvalues: p2 (ref), u8 (ref), updateChildren (val)
            p2 = nil
            u8 = true
            updateChildren()
        end)
        updateChildren()
    end,
}