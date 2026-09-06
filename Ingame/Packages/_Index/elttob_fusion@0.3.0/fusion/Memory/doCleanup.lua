local doCleanup
local Parent = script.Parent.Parent
require(Parent.Types)
local External = require(Parent.External)
local scopePool = require(Parent.Memory.scopePool)
local poisonScope = require(Parent.Memory.poisonScope)
local u17 = {}
function doCleanup(p1) -- Line: 24 -- upvalues: u17 (val), External (val), doCleanup (val), scopePool (val), poisonScope (val)
    if u17[p1] then
        return External.logError("destroyedTwice")
    end
    u17[p1] = true
    if typeof(p1) == "Instance" then
        p1:Destroy()
    elseif typeof(p1) == "RBXScriptConnection" then
        p1:Disconnect()
    elseif typeof(p1) == "function" then
        p1()
    elseif typeof(p1) == "table" then
        if typeof(p1.destroy) == "function" then
            p1:destroy()
        elseif typeof(p1.Destroy) == "function" then
            p1:Destroy()
        elseif p1[1] ~= nil then
            local v1 = 1
            local v2 = -1
            for i = #p1, v1, v2 do
                doCleanup(p1[i])
                p1[i] = nil
            end
            if not (External.isTimeCritical()) then
                poisonScope(p1, "`doCleanup()` was previously called on this scope. Ensure you are not reusing scopes after cleanup.")
            else
                scopePool.giveIfEmpty(p1)
            end
        end
    end
    u17[p1] = nil
end
return doCleanup