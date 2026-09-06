local DependencyGraph = require(script.Parent.DependencyGraph)
local Phase = require(script.Parent.Phase)
local u10 = {}
u10.__index = u10
function u10.__tostring(p1) -- Line: 13
    return p1._name
end
function u10:insert(p2) -- Line: 23
    self.dependencyGraph:insert(p2)
    return self
end
function u10:insertAfter(p2, p3) -- Line: 35
    assert(table.find(self.dependencyGraph.nodes, p3), "Unknown Phase in Pipeline:insertAfter(_, unknown), try adding this Phase to the Pipeline.")
    self.dependencyGraph:insertAfter(p2, p3)
    return self
end
function u10:insertBefore(p2, p3) -- Line: 53
    assert(table.find(self.dependencyGraph.nodes, p3), "Unknown Phase in Pipeline:insertBefore(_, unknown), try adding this Phase to the Pipeline.")
    self.dependencyGraph:insertBefore(p2, p3)
    return self
end
function u10.new(p1) -- Line: 68 -- upvalues: DependencyGraph (val), u10 (val)
    local v1 = p1
    if not v1 then
        v1 = debug.info(2, "sl")
    end
    local v2 = {_type = "pipeline", _name = v1, dependencyGraph = DependencyGraph.new()}
    return (setmetatable(v2, u10))
end
local v1 = u10.new():insert(Phase.PreStartup)
v1 = v1:insert(Phase.Startup)
u10.Startup = v1:insert(Phase.PostStartup)
return u10