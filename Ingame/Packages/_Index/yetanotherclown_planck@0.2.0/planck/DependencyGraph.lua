local u0 = {}
u0.__index = u0

function u0.__tostring(p1) -- Line: 16
    local v1, v2, v3, width
    local v4 = "\n"
    local length = p1.length
    for i = 1, length do
        if i == 1 then
            v4 = v4 .. "\n"
        end
        v3 = ""
        width = v1.width
        for j = 1, width do
            if j ~= v1.width then
                v2 = v1.matrix[i][j]
                v3 = v3 .. ("%*, "):format(v2)
            else
                v2 = v1.matrix[i][j]
                v3 = v3 .. ("%*"):format(v2)
            end
        end
        v3 = v3 .. "\n"
        v4 = v4 .. v3
    end
    return v4
end

function u0:extend() -- Line: 41
    local v1
    self.length = self.length + 1
    self.width = self.length + 1
    self.matrix[self.length] = {}
    local width = self.width
    for i = 1, width do
        v1 = self.matrix[self.length]
        v1[i] = 0
    end
    local length = self.length
    for j = 1, length do
        v1 = self.matrix[j]
        v1[self.width] = 0
    end
end

function u0:setEdge(p2, p3, p4) -- Line: 55
    self.matrix[p2][p3] = p4
end

function u0:toAdjacencyList() -- Line: 59
    local v1, width
    local v2 = {}
    local length = self.length
    local v3 = self
    for i = 1, length do
        v2[i] = {}
        width = v3.width
        for j = 1, width do
            if v3.matrix[i][j] ~= 0 then
                v1 = v2[i]
                table.insert(v1, j)
            end
        end
    end
    return v2
end

function u0:topologicalSort() -- Line: 74
    local v1, v2, v3, v4, v5, v6
    local v7 = self:toAdjacencyList()
    local v8 = {}
    local v9 = table.create(self.length, 0)
    local length = self.length
    for i = 1, length do
        v4 = v7[i]
        v5 = nil
        v6 = nil
        for j, k in v4, v5, v6 do
            v9[k] = v9[k] + 1
        end
    end
    local v10 = {}
    local length_2 = v1.length
    for n = 1, length_2 do
        if v9[n] == 0 then
            table.insert(v10, n)
        end
    end
    while #v10 ~= 0 do
        v2 = table.remove(v10, 1)
        table.insert(v8, v2)
        v3 = v7[v2]
        v4 = nil
        v5 = nil
        for m, i5 in v3, v4, v5 do
            v9[i5] = v9[i5] - 1
            if v9[i5] == 0 then
                table.insert(v10, i5)
            end
        end
    end
    if #v8 ~= v1.length then
        return nil
    end
    return v8
end

function u0.new() -- Line: 112 -- upvalues: u0 (val)
    local v1 = u0
    return (setmetatable({length = 0, width = 0, matrix = {}}, v1))
end

local u7 = {}
u7.__index = u7

function u7.getOrderedList(p1) -- Line: 144
    local v1
    local v2 = {}
    local v3 = p1.matrix:topologicalSort()
    if not v3 then
        return nil
    end
    local v4 = v3
    local v5 = nil
    local v6 = nil
    for i, j in v4, v5, v6 do
        v1 = p1.nodes[j]
        table.insert(v2, v1)
    end
    return v2
end

function u7.insertBefore(p1, p2, p3) -- Line: 159
    if not table.find(p1.nodes, p3) then
        error("Node not found in DependencyGraph:insertBefore(_, unknown)")
    end
    local v1 = table.find(p1.nodes, p2)
    if not v1 then
        local nodes = p1.nodes
        table.insert(nodes, p2)
        v1 = #p1.nodes
    end
    local v2 = table.find(p1.nodes, p3)
    p1.matrix:extend()
    p1.matrix:setEdge(v1, v2, 1)
    return p1
end

function u7.insertAfter(p1, p2, p3) -- Line: 178
    if not table.find(p1.nodes, p3) then
        error("Node not found in DependencyGraph:insertAfter(_, unknown)")
    end
    local v1 = table.find(p1.nodes, p2)
    if not v1 then
        local nodes = p1.nodes
        table.insert(nodes, p2)
        v1 = #p1.nodes
    end
    local v2 = table.find(p1.nodes, p3)
    p1.matrix:extend()
    p1.matrix:setEdge(v2, v1, 1)
    return p1
end

function u7.insert(p1, p2) -- Line: 197
    local v1 = #p1.nodes
    local nodes = p1.nodes
    table.insert(nodes, p2)
    local v2 = #p1.nodes
    p1.matrix:extend()
    if v1 ~= 0 then
        p1.matrix:setEdge(v1, v2, 1)
    end
    return p1
end

function u7.new() -- Line: 211 -- upvalues: u0 (val), u7 (val)
    local v1 = {length = 0, width = 0, nodes = {}, matrix = u0.new()}
    local v2 = u7
    return (setmetatable(v1, v2))
end

return u7