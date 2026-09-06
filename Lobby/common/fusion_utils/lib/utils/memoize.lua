local function getCached(p1, p2) -- Line: 7
    local children
    local v1 = p1
    local n = p2.n
    local v2 = 1
    local v3 = p2
    for i = 1, n, v2 do
        children = v1.children
        if children then
            children = v1.children[v3[i]]
        end
        v1 = children
        if not v1 then
            return nil
        end
    end
    return v1.returns
end
local function setCached(p1, p2, p3) -- Line: 18
    local children, v1, v2, v3
    local v4 = p1
    local n = p2.n
    local v5 = 1
    local v6 = p2
    for i = 1, n, v5 do
        v2 = v6[i]
        children = v4.children
        if not children then
            children = {}
        end
        v4.children = children
        v3 = v4.children[v2]
        if not v3 then
            v3 = {}
        end
        v4.children[v2] = v3
        v4 = v4.children[v2]
    end
    v4.returns = v1
end
return function(p1) -- Line: 36 -- upvalues: setCached (val)
    local u1 = {}
    return function(...) -- Line: 39 -- upvalues: u1 (val), p1 (val), setCached (upval)
        local children, returns
        local v1 = table.pack(...)
        local v2 = u1
        local n = v1.n
        local v3 = 1
        for i = 1, n, v3 do
            children = v2.children
            if children then
                children = v2.children[v1[i]]
            end
            v2 = children
            if not v2 then
                returns = nil
                if not returns then
                    returns = table.pack(p1(...))
                    setCached(u1, v1, assert(returns, "Luau"))
                end
                return table.unpack(returns)
            end
        end
        returns = v2.returns
        if not returns then
            returns = table.pack(p1(...))
            setCached(u1, v1, assert(returns, "Luau"))
        end
        return table.unpack(returns)
    end
end