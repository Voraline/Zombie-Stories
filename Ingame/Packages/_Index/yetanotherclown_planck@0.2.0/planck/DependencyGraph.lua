local u0 = {}
u0.__index = u0
function u0.__tostring(p1) -- Line: 16
    local v1, v2, v3, width
    local v4 = "\n"
    local length = p1.length
    local v5 = 1
    for i = 1, length, v5 do
        if i == 1 then
            v4 = v4 .. "\n"
        end
        v2 = ""
        width = v1.width
        v3 = 1
        for j = 1, width, v3 do
            if j ~= v1.width then
                v2 = v2 .. ("%*, "):format(v1.matrix[i][j])
            else
                v2 = v2 .. ("%*"):format(v1.matrix[i][j])
            end
        end
        v2 = v2 .. "\n"
        v4 = v4 .. v2
    end
    return v4
end
function u0:extend() -- Line: 41
    local v1
    self.length = self.length + 1
    self.width = self.length + 1
    self.matrix[self.length] = {}
    local width = self.width
    local v2 = 1
    for i = 1, width, v2 do
        v1 = self.matrix[self.length]
        v1[i] = 0
    end
    local length = self.length
    v2 = 1
    for j = 1, length, v2 do
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
    local v3 = 1
    local v4 = self
    for i = 1, length, v3 do
        v2[i] = {}
        width = v4.width
        v1 = 1
        for j = 1, width, v1 do
            if v4.matrix[i][j] ~= 0 then
                table.insert(v2[i], j)
            end
        end
    end
    return v2
end
function u0:topologicalSort() -- Line: 74
    local v1, v2, v3, v4
    local v5 = self:toAdjacencyList()
    local v6 = {}
    local v7 = table.create(self.length, 0)
    local length = self.length
    local v8 = 1
    for i = 1, length, v8 do
        v2 = v5[i]
        v3 = nil
        v4 = nil
        for j, k in v2, v3, v4 do
            v7[k] = v7[k] + 1
        end
    end
    local v9 = {}
    local length_2 = v1.length
    local v10 = 1
    for n = 1, length_2, v10 do
        if v7[n] == 0 then
            table.insert(v9, n)
        end
    end
    while #v9 ~= 0 do
        v8 = table.remove(v9, 1)
        table.insert(v6, v8)
        v10 = v5[v8]
        v2 = nil
        v3 = nil
        for m, i5 in v10, v2, v3 do
            v7[i5] = v7[i5] - 1
            if v7[i5] == 0 then
                table.insert(v9, i5)
            end
        end
    end
    if #v6 ~= v1.length then
        return nil
    end
    return v6
end
function u0.new() -- Line: 112 -- upvalues: u0 (val)
    local v1 = {length = 0, width = 0, matrix = {}}
    return (setmetatable(v1, u0))
end
local u7 = {}
u7.__index = u7
function u7.getOrderedList(p1) -- Line: 144
    local v1 = {}
    local v2 = p1.matrix:topologicalSort()
    if not v2 then
        return nil
    end
    local v3 = v2
    local v4 = nil
    local v5 = nil
    for i, j in v3, v4, v5 do
        table.insert(v1, p1.nodes[j])
    end
    return v1
end
function u7.insertBefore(p1, p2, p3) -- Line: 159
    if not (table.find(p1.nodes, p3)) then
        error("Node not found in DependencyGraph:insertBefore(_, unknown)")
    end
    local v1 = table.find(p1.nodes, p2)
    if not v1 then
        table.insert(p1.nodes, p2)
        v1 = #p1.nodes
    end
    local v2 = table.find(p1.nodes, p3)
    p1.matrix:extend()
    p1.matrix:setEdge(v1, v2, 1)
    return p1
end
function u7.insertAfter(p1, p2, p3) -- Line: 178
    if not (table.find(p1.nodes, p3)) then
        error("Node not found in DependencyGraph:insertAfter(_, unknown)")
    end
    local v1 = table.find(p1.nodes, p2)
    if not v1 then
        table.insert(p1.nodes, p2)
        v1 = #p1.nodes
    end
    local v2 = table.find(p1.nodes, p3)
    p1.matrix:extend()
    p1.matrix:setEdge(v2, v1, 1)
    return p1
end
function u7.insert(p1, p2) -- Line: 197
    local v1 = #p1.nodes
    table.insert(p1.nodes, p2)
    local v2 = #p1.nodes
    p1.matrix:extend()
    if v1 ~= 0 then
        p1.matrix:setEdge(v1, v2, 1)
    end
    return p1
end
function u7.new() -- Line: 211 -- upvalues: u0 (val), u7 (val)
    local v1 = {length = 0, width = 0, nodes = {}, matrix = u0.new()}
    return (setmetatable(v1, u7))
end
return u7