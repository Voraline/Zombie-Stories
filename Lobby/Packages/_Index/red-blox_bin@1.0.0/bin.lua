local Spawn = require(script.Parent.Spawn)
return function() -- Line: 5 -- upvalues: Spawn (val)
    local u0 = {}
    return function(p1) -- Line: 8 -- upvalues: u0 (val)
        table.insert(u0, p1)
        return p1
    end, function() -- Line: 12 -- upvalues: u0 (val), Spawn (upval)
        local v1 = u0
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            if typeof(j) == "Instance" then
                j:Destroy()
            elseif typeof(j) == "RBXScriptConnection" then
                j:Disconnect()
            elseif typeof(j) == "function" then
                Spawn(j)
            end
        end
        table.clear(u0)
    end
end