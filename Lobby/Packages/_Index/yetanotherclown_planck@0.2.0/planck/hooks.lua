local v1 = {
    SystemAdd = "SystemAdd",
    SystemRemove = "SystemRemove",
    SystemReplace = "SystemReplace",
    SystemError = "SystemError",
    OuterSystemCall = "OuterSystemCall",
    InnerSystemCall = "InnerSystemCall",
    SystemCall = "SystemCall",
    PhaseAdd = "PhaseAdd",
    PhaseBegan = "PhaseBegan",
}
return {
    Hooks = v1,
    systemAdd = function(p1, p2) -- Line: 3
        local v1, v2
        local v3 = {scheduler = p1, system = p2}
        local v4 = p1._hooks[p1.Hooks.SystemAdd]
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v2, v1 = pcall(j, v3)
            if not v2 then
                warn("Unexpected error in hook:", v1)
            end
        end
    end,
    systemRemove = function(p1, p2) -- Line: 18
        local v1, v2
        local v3 = {scheduler = p1, system = p2}
        local v4 = p1._hooks[p1.Hooks.SystemRemove]
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v2, v1 = pcall(j, v3)
            if not v2 then
                warn("Unexpected error in hook:", v1)
            end
        end
    end,
    systemReplace = function(p1, p2, p3) -- Line: 33
        local v1, v2
        local v3 = {scheduler = p1, new = p3, old = p2}
        local v4 = p1._hooks[p1.Hooks.SystemReplace]
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v1, v2 = pcall(j, v3)
            if not v1 then
                warn("Unexpected error in hook:", v2)
            end
        end
    end,
    systemCall = function(p1, p2, p3, p4) -- Line: 49
        local v1
        local v2 = p1._hooks[p1.Hooks[p2]]
        if not v2 then
            v1 = p4
        else
            local v3, v4
            local v5 = v2
            local v6 = nil
            local v7 = nil
            v1 = p4
            for i, j in v5, v6, v7 do
                v4 = {system = p3, nextFn = v1}
                v1 = j(v4)
                if not v1 then
                    v3, v4 = debug.info(j, "sl")
                    warn((("%*:%*: Expected 'SystemCall' hook to return a function"):format(v3, v4)))
                end
            end
        end
        v1()
    end,
    systemError = function(p1, p2, p3) -- Line: 72
        local v1 = p1._hooks[p1.Hooks.SystemError]
        if v1 then
            local v2 = v1
            local v3 = nil
            local v4 = nil
            for i, j in v2, v3, v4 do
                j({scheduler = p1, system = p2, error = p3})
            end
        end
    end,
    phaseAdd = function(p1, p2) -- Line: 91
        local v1, v2
        local v3 = {scheduler = p1, phase = p2}
        local v4 = p1._hooks[p1.Hooks.PhaseAdd]
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v2, v1 = pcall(j, v3)
            if not v2 then
                warn("Unexpected error in hook:", v1)
            end
        end
    end,
    phaseBegan = function(p1, p2) -- Line: 106
        local v1, v2
        local v3 = {scheduler = p1, phase = p2}
        local v4 = p1._hooks[p1.Hooks.PhaseBegan]
        local v5 = nil
        local v6 = nil
        for i, j in v4, v5, v6 do
            v2, v1 = pcall(j, v3)
            if not v2 then
                warn("Unexpected error in hook:", v1)
            end
        end
    end,
}