local v1
local v2 = {}
local u1 = {}
v2.enums = u1

function v2.createEnum(p1, p2) -- Line: 20 -- upvalues: u1 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9
    local v10 = typeof(p1) == "string"
    assert(v10, "bad argument #1 - enums must be created using a string name!")
    v10 = typeof(p2) == "table"
    assert(v10, "bad argument #2 - enums must be created using a table!")
    v10 = not u1[p1]
    local v11 = ("enum '%s' already exists!"):format(p1)
    assert(v10, v11)
    local v12 = {}
    local u176 = {}
    local u177 = {}
    local u178 = {}
    local u169 = {}

    function u169.getName(p1) -- Line: 30 -- upvalues: u177 (val), u178 (val), p2 (val)
        local v1 = tostring(p1)
        local v2 = u177[v1]
        if not v2 then
            v2 = u178[v1]
        end
        if v2 then
            return p2[v2][1]
        end
    end

    function u169.getValue(p1) -- Line: 40 -- upvalues: u176 (val), u178 (val), p2 (val)
        local v1 = tostring(p1)
        local v2 = u176[v1]
        if not v2 then
            v2 = u178[v1]
        end
        if v2 then
            return p2[v2][2]
        end
    end

    function u169.getProperty(p1) -- Line: 50 -- upvalues: u176 (val), u177 (val), p2 (val)
        local v1 = tostring(p1)
        local v2 = u176[v1]
        if not v2 then
            v2 = u177[v1]
        end
        if v2 then
            return p2[v2][3]
        end
    end

    local v13 = p1
    for k, v in pairs(p2) do
        v2 = typeof(v) == "table"
        v3 = ("bad argument #2.%s - details must only be comprised of tables!"):format(k)
        assert(v2, v3)
        v1 = v[1]
        v3 = typeof(v1) == "string"
        v4 = ("bad argument #2.%s.1 - detail name must be a string!"):format(k)
        assert(v3, v4)
        v5 = u176[v1]
        v3 = typeof(not v5)
        v4 = ("bad argument #2.%s.1 - the detail name '%s' already exists!"):format(k, v1)
        assert(v3, v4)
        v5 = u169[v1]
        v3 = typeof(not v5)
        v4 = ("bad argument #2.%s.1 - that name is reserved."):format(k, v1)
        assert(v3, v4)
        u176[tostring(v1)] = k
        v2 = v[2]
        v3 = tostring(v2)
        v7 = u177[v3]
        v5 = typeof(not v7)
        v6 = ("bad argument #2.%s.2 - the detail value '%s' already exists!"):format(k, v3)
        assert(v5, v6)
        u177[v3] = k
        v4 = v[3]
        if v4 then
            v8 = u178[v4]
            v6 = typeof(not v8)
            v9 = tostring(v4)
            v7 = ("bad argument #2.%s.3 - the detail property '%s' already exists!"):format(k, v9)
            assert(v6, v7)
            u178[tostring(v4)] = k
        end
        v12[v1] = v2
        v7 = {
            __index = function(p1, p2) -- Line: 80 -- upvalues: u169 (val)
                return u169[p2]
            end,
        }
        setmetatable(v12, v7)
    end
    u1[v13] = v12
    return v12
end

function v2.getEnums() -- Line: 90 -- upvalues: u1 (val)
    return u1
end

local createEnum = v2.createEnum
for k, v in pairs(script:GetChildren()) do
    if v:IsA("ModuleScript") then
        v1 = require(v)
        createEnum(v.Name, v1)
    end
end
return v2