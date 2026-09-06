local cleanupOne
function cleanupOne(p1) -- Line: 14 -- upvalues: cleanupOne (val)
    local v1 = typeof(p1)
    if v1 == "Instance" then
        p1:Destroy()
        return
    end
    if v1 == "RBXScriptConnection" then
        p1:Disconnect()
        return
    end
    if v1 == "function" then
        p1()
        return
    end
    if v1 ~= "table" then
        return
    end
    if typeof(p1.destroy) == "function" then
        p1:destroy()
        return
    end
    if typeof(p1.Destroy) == "function" then
        p1:Destroy()
        return
    end
    if p1[1] ~= nil then
        for i, v in ipairs(p1) do
            cleanupOne(v)
        end
    end
end
return function(...) -- Line: 47 -- upvalues: cleanupOne (val)
    local v1 = select("#", ...)
    local v2 = 1
    for i = 1, v1, v2 do
        cleanupOne(select(i, ...))
    end
end