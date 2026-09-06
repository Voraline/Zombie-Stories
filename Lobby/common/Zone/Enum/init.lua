local v1
local v2 = {}
local u1 = {}
v2.enums = u1
function v2.createEnum(p1, p2) -- Line: 20 -- upvalues: u1 (val)
    local v1, v2, v3, v4, v5, v6
    local v7 = typeof(p1) == "string"
    assert(v7, "bad argument #1 - enums must be created using a string name!")
    v7 = typeof(p2) == "table"
    assert(v7, "bad argument #2 - enums must be created using a table!")
    assert(not u1[p1], ("enum '%s' already exists!"):format(p1))
    local v8 = {}
    local u176 = {}
    local u177 = {}
    local u178 = {}
    local u169 = {
        getName = function(p1) -- Line: 30 -- upvalues: u177 (val), u178 (val), p2 (val)
            local v1 = tostring(p1)
            local v2 = u177[v1]
            if not v2 then
                v2 = u178[v1]
            end
            if v2 then
                return p2[v2][1]
            end
        end,
        getValue = function(p1) -- Line: 40 -- upvalues: u176 (val), u178 (val), p2 (val)
            local v1 = tostring(p1)
            local v2 = u176[v1]
            if not v2 then
                v2 = u178[v1]
            end
            if v2 then
                return p2[v2][2]
            end
        end,
        getProperty = function(p1) -- Line: 50 -- upvalues: u176 (val), u177 (val), p2 (val)
            local v1 = tostring(p1)
            local v2 = u176[v1]
            if not v2 then
                v2 = u177[v1]
            end
            if v2 then
                return p2[v2][3]
            end
        end,
    }
    for k, v in pairs(p2) do
        v2 = typeof(v) == "table"
        assert(v2, ("bad argument #2.%s - details must only be comprised of tables!"):format(k))
        v1 = v[1]
        v3 = typeof(v1) == "string"
        assert(v3, ("bad argument #2.%s.1 - detail name must be a string!"):format(k))
        v3 = typeof(not u176[v1])
        assert(v3, ("bad argument #2.%s.1 - the detail name '%s' already exists!"):format(k, v1))
        v3 = typeof(not u169[v1])
        assert(v3, ("bad argument #2.%s.1 - that name is reserved."):format(k, v1))
        u176[tostring(v1)] = k
        v2 = v[2]
        v3 = tostring(v2)
        v5 = typeof(not u177[v3])
        assert(v5, ("bad argument #2.%s.2 - the detail value '%s' already exists!"):format(k, v3))
        u177[v3] = k
        v4 = v[3]
        if v4 then
            v6 = typeof(not u178[v4])
            assert(v6, ("bad argument #2.%s.3 - the detail property '%s' already exists!"):format(k, (tostring(v4))))
            u178[tostring(v4)] = k
        end
        v8[v1] = v2
        setmetatable(v8, {
            __index = function(p1, p2) -- Line: 80 -- upvalues: u169 (val)
                return u169[p2]
            end,
        })
    end
    u1[p1] = v8
    return v8
end
function v2.getEnums() -- Line: 90 -- upvalues: u1 (val)
    return u1
end
for k, v in pairs(script:GetChildren()) do
    if v:IsA("ModuleScript") then
        v1 = require(v)
        v2.createEnum(v.Name, v1)
    end
end
return v2