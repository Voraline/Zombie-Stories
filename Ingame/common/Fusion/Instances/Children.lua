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

        local function updateChildren() -- Line: 38
            -- upvalues: u8 (ref), u5 (ref), u4 (ref), u7 (ref), u6 (ref), xtypeof (upval), p3 (val), Observer (upval)
            -- upvalues: u9 (ref), logWarn (upval), p2 (ref)
            local processChild
            if not u8 then
                return
            end
            u8 = false
            local v1 = u4
            local v2 = u5
            u5 = v1
            u4 = v2
            v1 = u6
            v2 = u7
            u7 = v1
            u6 = v2
            table.clear(u4)
            table.clear(u6)

            function processChild(p1, p2) -- Line: 49
                -- upvalues: xtypeof (upval), u4 (upval), u5 (upval), p3 (upval), processChild (val), u7 (upval)
                -- upvalues: Observer (upval), u9 (upval), u6 (upval), logWarn (upval)
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
                        local v6 = Observer
                        v6 = v6(p1)
                        local v7 = u9
                        v5 = v6:onChange(v7)
                    end
                    u6[p1] = v5
                    return
                end
                if v3 ~= "table" then
                    logWarn("unrecognisedChildType", v3)
                    return
                end
                local v8 = p2
                for k, v in pairs(p1) do
                    v1 = typeof(k)
                    v2 = nil
                    if v1 == "string" then
                        v2 = k
                    elseif v1 == "number" and v8 ~= nil then
                        v2 = v8 .. "_" .. k
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