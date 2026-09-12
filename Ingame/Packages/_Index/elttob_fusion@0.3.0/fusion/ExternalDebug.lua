local Parent = script.Parent
require(Parent.Types)
local u5 = nil
return {
    setDebugger = function(p1) -- Line: 26 -- upvalues: u5 (ref)
        local v1 = u5
        if v1 ~= nil then
            v1.stopDebugging()
        end
        u5 = p1
        if p1 ~= nil then
            p1.startDebugging()
        end
        return v1
    end,
    trackScope = function(p1) -- Line: 46 -- upvalues: u5 (ref)
        if u5 == nil then
            return
        end
        u5.trackScope(p1)
    end,
    untrackScope = function(p1) -- Line: 61 -- upvalues: u5 (ref)
        if u5 == nil then
            return
        end
        u5.trackScope(p1)
    end,
}