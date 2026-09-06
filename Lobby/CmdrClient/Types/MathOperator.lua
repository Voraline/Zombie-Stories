return function(p1) -- Line: 1
    local v1 = {}
    local v2 = {
        Name = "+",
        Perform = function(p1, p2) -- Line: 5
            return p1 + p2
        end,
    }
    local v3 = {
        Name = "-",
        Perform = function(p1, p2) -- Line: 11
            return p1 - p2
        end,
    }
    local v4 = {
        Name = "*",
        Perform = function(p1, p2) -- Line: 17
            return p1 * p2
        end,
    }
    local v5 = {
        Name = "/",
        Perform = function(p1, p2) -- Line: 23
            return p1 / p2
        end,
    }
    local v6 = {
        Name = "**",
        Perform = function(p1, p2) -- Line: 29
            return p1 ^ p2
        end,
    }
    local v7 = {
        Name = "%",
        Perform = function(p1, p2) -- Line: 35
            return p1 % p2
        end,
    }
    v1[1] = v2
    v1[2] = v3
    v1[3] = v4
    v1[4] = v5
    v1[5] = v6
    v1[6] = v7
    p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", v1))
end