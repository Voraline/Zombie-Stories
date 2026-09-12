return {
    Any = function(p1) -- Line: 5
        return p1
    end,
    Boolean = function(p1) -- Line: 9
        local v1 = type(p1) == "boolean"
        assert(v1)
        return p1
    end,
    Thread = function(p1) -- Line: 15
        local v1 = type(p1) == "thread"
        assert(v1)
        return p1
    end,
    Nil = function(p1) -- Line: 21
        local v1 = p1 == nil
        assert(v1)
        return p1
    end,
    Number = function(p1) -- Line: 27
        local v1 = type(p1) == "number"
        assert(v1)
        v1 = p1 == p1
        assert(v1)
        return p1
    end,
    String = function(p1) -- Line: 34
        local v1 = type(p1) == "string"
        assert(v1)
        return p1
    end,
    Optional = function(p1) -- Line: 80
        return function(p1_2) -- Line: 81 -- upvalues: p1 (val)
            if p1_2 == nil then
                return nil
            end
            return p1(p1_2)
        end
    end,
    Literal = function(p1) -- Line: 90
        return function(p1_2) -- Line: 91 -- upvalues: p1 (val)
            local v1 = p1_2 == p1
            assert(v1)
            return p1_2
        end
    end,
    Or = function(p1, p2) -- Line: 42
        return function(p1_2) -- Line: 43 -- upvalues: p1 (val), p2 (val)
            if pcall(p1, p1_2) or pcall(p2, p1_2) then
                return p1_2
            end
            error("Union check failed")
        end
    end,
    And = function(p1, p2) -- Line: 60
        return function(p1_2) -- Line: 61 -- upvalues: p1 (val), p2 (val)
            if not pcall(p1, p1_2) then
                error("Intersection check failed")
            end
            if not pcall(p2, p1_2) then
                error("Intersection check failed")
            end
            return p1_2
        end
    end,
    Map = function(p1, p2) -- Line: 98
        return function(p1_2) -- Line: 99 -- upvalues: p1 (val), p2 (val)
            local v1 = type(p1_2) == "table"
            assert(v1)
            local v2 = p1_2
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
                p1(i)
                p2(j)
            end
            return p1_2
        end
    end,
    Set = function(p1) -- Line: 111
        local u1 = true

        local function u2(p1) -- Line: 91 -- upvalues: u1 (val)
            local v1 = p1 == u1
            assert(v1)
            return p1
        end

        return function(p1_2) -- Line: 99 -- upvalues: p1 (val), u2 (val)
            local v1 = type(p1_2) == "table"
            assert(v1)
            local v2 = p1_2
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
                p1(i)
                u2(j)
            end
            return p1_2
        end
    end,
    List = function(p1) -- Line: 115
        return function(p1_2) -- Line: 116 -- upvalues: p1 (val)
            local v1 = type(p1_2) == "table"
            assert(v1)
            local v2 = table.maxn(p1_2)
            for i = 1, v2 do
                p1(p1_2[i])
            end
            return p1_2
        end
    end,
    Integer = function(p1) -- Line: 129
        local v1 = type(p1) == "number"
        assert(v1)
        v1 = p1 % 1 == 0
        assert(v1)
        return p1
    end,
    NumberMin = function(p1) -- Line: 136
        return function(p1_2) -- Line: 137 -- upvalues: p1 (val)
            local v1 = type(p1_2) == "number"
            assert(v1)
            v1 = p1 <= p1_2
            assert(v1)
            return p1_2
        end
    end,
    NumberMax = function(p1) -- Line: 145
        return function(p1_2) -- Line: 146 -- upvalues: p1 (val)
            local v1 = type(p1_2) == "number"
            assert(v1)
            v1 = p1_2 <= p1
            assert(v1)
            return p1_2
        end
    end,
    NumberMinMax = function(p1, p2) -- Line: 154
        return function(p1_2) -- Line: 155 -- upvalues: p1 (val), p2 (val)
            local v1 = type(p1_2) == "number"
            assert(v1)
            v1 = p1 < p1_2
            assert(v1)
            v1 = p1_2 < p2
            assert(v1)
            return p1_2
        end
    end,
    CFrame = function(p1) -- Line: 166
        local v1 = typeof(p1) == "CFrame"
        assert(v1)
        v1 = p1 == p1
        assert(v1)
        return p1
    end,
    Color3 = function(p1) -- Line: 173
        local v1 = typeof(p1) == "Color3"
        assert(v1)
        v1 = p1 == p1
        assert(v1)
        return p1
    end,
    DateTime = function(p1) -- Line: 180
        local v1 = typeof(p1) == "DateTime"
        assert(v1)
        return p1
    end,
    Instance = function(p1) -- Line: 186
        local v1 = typeof(p1) == "Instance"
        assert(v1)
        return p1
    end,
    Vector2 = function(p1) -- Line: 192
        local v1 = typeof(p1) == "Vector2"
        assert(v1)
        v1 = p1 == p1
        assert(v1)
        return p1
    end,
    Vector2int16 = function(p1) -- Line: 199
        local v1 = typeof(p1) == "Vector2int16"
        assert(v1)
        return p1
    end,
    Vector3 = function(p1) -- Line: 205
        local v1 = typeof(p1) == "Vector3"
        assert(v1)
        v1 = p1 == p1
        assert(v1)
        return p1
    end,
    Vector3int16 = function(p1) -- Line: 212
        local v1 = typeof(p1) == "Vector3int16"
        assert(v1)
        return p1
    end,
    Check = function(p1) -- Line: 220
        return function(p1_2) -- Line: 221 -- upvalues: p1 (val)
            return pcall(p1, p1_2)
        end
    end,
}