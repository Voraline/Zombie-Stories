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
    local v1 = table.find(self.dependencyGraph.nodes, p3)
    assert(v1, "Unknown Phase in Pipeline:insertAfter(_, unknown), try adding this Phase to the Pipeline.")
    self.dependencyGraph:insertAfter(p2, p3)
    return self
end

function u10:insertBefore(p2, p3) -- Line: 53
    local v1 = table.find(self.dependencyGraph.nodes, p3)
    assert(v1, "Unknown Phase in Pipeline:insertBefore(_, unknown), try adding this Phase to the Pipeline.")
    self.dependencyGraph:insertBefore(p2, p3)
    return self
end

function u10.new(p1) -- Line: 68 -- upvalues: DependencyGraph (val), u10 (val)
    local v1 = p1
    if not v1 then
        v1 = debug.info(2, "sl")
    end
    local v2 = {_type = "pipeline", _name = v1, dependencyGraph = DependencyGraph.new()}
    local v3 = u10
    return (setmetatable(v2, v3))
end

local v1 = u10.new()
local PreStartup = Phase.PreStartup
v1 = v1:insert(PreStartup)
local Startup = Phase.Startup
v1 = v1:insert(Startup)
local PostStartup = Phase.PostStartup
u10.Startup = v1:insert(PostStartup)
return u10