local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local Observer = require(Parent.Graph.Observer)
local peek = require(Parent.State.peek)
local castToState = require(Parent.State.castToState)
local doCleanup = require(Parent.Memory.doCleanup)
return {
    type = "SpecialKey",
    kind = "Children",
    stage = "descendants",
    apply = function(p1, p2, p3, p4) -- Line: 28 -- upvalues: castToState (val), peek (val), Observer (val), External (val), doCleanup (val)
        local updateChildren
        local u4 = {}
        local u5 = {}
        local u6 = {}
        local u7 = {}
        function updateChildren() -- Line: 44 -- upvalues: u5 (ref), u4 (ref), u7 (ref), u6 (ref), p4 (val), castToState (upval), peek (upval), Observer (upval), updateChildren (val), External (upval), p3 (ref), doCleanup (upval)
            local processChild
            u5 = u4
            u4 = u5
            u7 = u6
            u6 = u7
            function processChild(p1, p2) -- Line: 48 -- upvalues: u4 (upval), u5 (upval), p4 (upval), castToState (upval), peek (upval), processChild (val), u7 (upval), Observer (upval), updateChildren (upval), u6 (upval), External (upval)
                local v1, v2
                local v3 = typeof(p1)
                if v3 == "Instance" then
                    u4[p1] = true
                    if u5[p1] == nil then
                        p1.Parent = p4
                        return
                    end
                    u5[p1] = nil
                    return
                end
                if castToState(p1) then
                    local v4 = peek(p1)
                    if v4 ~= nil then
                        processChild(v4, p2)
                    end
                    local v5 = u7[p1]
                    if v5 ~= nil then
                        u7[p1] = nil
                    else
                        local v6 = Observer({}, p1)
                        v6:onChange(updateChildren)
                    end
                    u6[p1] = v5
                    return
                end
                if v3 ~= "table" then
                    External.logWarn("unrecognisedChildType", v3)
                    return
                end
                local v7 = p2
                for k, v in pairs(p1) do
                    v1 = typeof(k)
                    v2 = nil
                    if v1 == "string" then
                        v2 = k
                    elseif v1 == "number" and v7 ~= nil then
                        v2 = v7 .. "_" .. k
                    end
                    processChild(v, v2)
                end
            end
            if p3 ~= nil then
                processChild(p3)
            end
            for k in pairs(u5) do
                k.Parent = nil
            end
            table.clear(u5)
            for k2, v in pairs(u7) do
                doCleanup(v)
            end
            table.clear(u7)
        end
        table.insert(p2, function() -- Line: 140 -- upvalues: p3 (ref), updateChildren (val)
            p3 = nil
            updateChildren()
        end)
        updateChildren()
    end,
}