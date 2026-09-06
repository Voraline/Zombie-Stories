local u0 = {}
local u3 = require("../Utility")
local u6 = require("@self/Default")
function u0.getThemeValue(p1, p2, p3, p4) -- Line: 16
    local v1, v2, v3
    if not p1 then
        return
    end
    for k, v in pairs(p1) do
        v3, v1, v2 = unpack(v)
        if p2 == v3 and p3 == v1 then
            return v2
        end
    end
end
function u0.getInstanceValue(p1, p2) -- Line: 27
    local v1, v2
    v1, v2 = pcall(function() -- Line: 28 -- upvalues: p1 (val), p2 (val)
        return p1[p2]
    end)
    if not v1 then
        v2 = p1:GetAttribute(p2)
    end
    return v2
end
function u0.getRealInstance(p1) -- Line: 37
    if not (p1:GetAttribute("IsAClippedClone")) then
        return
    end
    local OriginalInstance = p1:FindFirstChild("OriginalInstance")
    if not OriginalInstance then
        return
    end
    return OriginalInstance.Value
end
function u0.getClippedClone(p1) -- Line: 48
    if not (p1:GetAttribute("HasAClippedClone")) then
        return
    end
    local ClippedClone = p1:FindFirstChild("ClippedClone")
    if not ClippedClone then
        return
    end
    return ClippedClone.Value
end
function u0.refresh(p1, p2, p3) -- Line: 59 -- upvalues: u0 (val)
    local Attribute, v1, v2, v3, v4, v5, v6
    if p3 then
        v5 = p1:getStateGroup()
        v6 = u0.getThemeValue(v5, p2.Name, p3)
        if not v6 then
            v6 = u0.getInstanceValue(p2, p3)
        end
        u0.apply(p1, p2, p3, v6, true)
        return
    end
    v5 = p1:getStateGroup()
    if not v5 then
        return
    end
    v6 = {}
    v6[p2.Name] = p2
    for k, v in pairs(p2:GetDescendants()) do
        Attribute = v:GetAttribute("Collective")
        if Attribute then
            v6[Attribute] = v
        end
        v6[v.Name] = v
    end
    for k2, i in pairs(v5) do
        v1, v2, v3 = unpack(i)
        v4 = v6[v1]
        if v4 then
            u0.apply(v7, v4.Name, v2, v3, true)
        end
    end
end
function u0.apply(p1, p2, p3, p4, p5) -- Line: 92 -- upvalues: u0 (val)
    local u91, u95, v1, v2, v3, v4
    if p1.isDestroyed then
        return
    end
    local Name = p2
    if typeof(p2) ~= "Instance" then
        v4 = p1:getInstanceOrCollective(p2)
    else
        v4 = {p2}
        Name = p2.Name
    end
    local v5 = p1.customBehaviours[Name .. "-" .. p3]
    for k, v in pairs(v4) do
        v1 = u0.getClippedClone(v)
        if v1 then
            table.insert(v4, v1)
        end
    end
    u95, v3, u91 = p3, p5, p4
    for k2, i in pairs(v4) do
        if u95 ~= "Position" then
            if u95 ~= "Size" then
                if v3 then
                    if v5 then
                        v2 = v5(u91, i, u95)
                        if v2 ~= nil then
                            u91 = v2
                        end
                    end
                    if not (pcall(function() -- Line: 138 -- upvalues: i (val), u95 (val), u91 (ref)
    i[u95] = u91
    return
end)) then
                        i:SetAttribute(u95, u91)
                    end
                elseif u91 == u0.getInstanceValue(i, u95) then
                end
            elseif u0.getRealInstance(i) then
            end
        elseif not (u0.getClippedClone(i)) then
        end
    end
end
function u0.getModifications(p1) -- Line: 152
    local v1
    if typeof(p1[1]) == "table" then
        v1 = p1
    else
        v1 = {p1}
    end
    return v1
end
function u0.merge(p1, p2, p3) -- Line: 161 -- upvalues: u0 (val)
    local v1, v2, v3, v4, v5, v6, v7
    v2, v3, v4, v5 = table.unpack(p2)
    v6, v7, _, v1 = table.unpack(p1)
    if v2 ~= v6 or v3 ~= v7 or not (u0.statesMatch(v5, v1)) then
        return false
    end
    p1[3] = v4
    if p3 then
        p3(p1)
    end
    return true
end
function u0.modify(p1, p2, p3) -- Line: 174 -- upvalues: u3 (val), u0 (val)
    task.spawn(function() -- Line: 182 -- upvalues: p3 (ref), u3 (upval), p2 (ref), u0 (upval), p1 (val)
        local nowSetIt, v1
        local v2 = p3
        if not v2 then
            v2 = u3.generateUID()
        end
        p3 = v2
        p2 = u0.getModifications(p2)
        for k, v in pairs(p2) do
            u23, u24, u25, v1 = table.unpack(v)
            if v1 == nil then
                u0.modify(p1, {u23, u24, u25, "Selected"}, p3)
                u0.modify(p1, {u23, u24, u25, "Viewing"}, p3)
            end
            local u51 = u3.formatStateName(v1 or "Deselected")
            local u56 = p1:getStateGroup(u51)
            function nowSetIt() -- Line: 194 -- upvalues: u51 (val), p1 (upval), u0 (upval), u23 (val), u24 (val), u25 (val)
                if u51 == p1.activeState then
                    u0.apply(p1, u23, u24, u25)
                end
            end
            ;(function() -- Line: 199 -- upvalues: u56 (val), u0 (upval), v (val), p3 (upval), u51 (val), p1 (upval), u23 (val), u24 (val), u25 (val)
                local v1
                for k, i in pairs(u56) do
                    if u0.merge(i, v, function(a1) -- Line: 201 -- upvalues: p3 (upval), u51 (upval), p1 (upval), u0 (upval), u23 (upval), u24 (upval), u25 (upval)
    local v1
    a1[5] = p3
    if u51 == p1.activeState then
        u0.apply(p1, u23, u24, u25)
    end
    return
end) then
                        return
                    end
                end
                table.insert(u56, {
                    u23,
                    u24,
                    u25,
                    u51,
                    p3,
                })
                if u51 == p1.activeState then
                    u0.apply(p1, u23, u24, u25)
                end
            end)()
        end
    end)
    return p3
end
function u0.remove(p1, p2) -- Line: 219 -- upvalues: u0 (val)
    local v1, v2, v3, v4
    v1, v2 = p1, p2
    for k, v in pairs(p1.appearance) do
        v3 = 1
        v4 = -1
        for i = #v, v3, v4 do
            if v[i][5] == v2 then
                table.remove(v, i)
            end
        end
    end
    u0.rebuild(v1)
end
function u0.removeWith(p1, p2, p3, p4) -- Line: 232 -- upvalues: u0 (val)
    local v1, v2, v3, v4, v5, v6, v7
    v1, v6, v2, v5 = p1, p4, p2, p3
    for k, v in pairs(p1.appearance) do
        if v6 == k then
            v7 = 1
            v3 = -1
            for i = #v, v7, v3 do
                v4 = v[i]
                if v4[1] == v2 and v4[2] == v5 then
                    table.remove(v, i)
                end
            end
        end
    end
    u0.rebuild(v1)
end
function u0.change(p1) -- Line: 248 -- upvalues: u0 (val)
    local v1, v2, v3
    local v4 = p1:getStateGroup()
    for k, v in pairs(v4) do
        v1, v2, v3 = unpack(v)
        u0.apply(p1, v1, v2, v3)
    end
end
function u0.set(p1, p2) -- Line: 258 -- upvalues: u0 (val)
    local v1
    local themesJanitor = p1.themesJanitor
    themesJanitor:clean()
    themesJanitor:add(p1.stateChanged:Connect(function() -- Line: 264 -- upvalues: u0 (upval), p1 (val)
        u0.change(p1)
    end))
    if typeof(p2) ~= "Instance" then
        v1 = p2
    elseif not (p2:IsA("ModuleScript")) then
        v1 = p2
    else
        v1 = require(p2)
    end
    p1.appliedTheme = v1
    u0.rebuild(p1)
end
function u0.statesMatch(p1, p2) -- Line: 274
    local v1 = p1
    if v1 then
        v1 = string.lower(p1)
    end
    local v2 = p2
    if v2 then
        v2 = string.lower(p2)
    end
    local v3 = true
    if v1 ~= v2 then
        v3 = not p1
        if not v3 then
            v3 = not p2
        end
    end
    return v3
end
function u0.rebuild(p1) -- Line: 281 -- upvalues: u0 (val), u3 (val), u6 (val)
    local appliedTheme = p1.appliedTheme
    local u2 = {"Deselected", "Selected", "Viewing"}
    ;(function() -- Line: 288 -- upvalues: u2 (val), u0 (upval), u3 (upval), u6 (upval), appliedTheme (val), p1 (val)
        local updateDetails, v1, v2, v3, v4
        for k, v in pairs(u2) do
            local u16 = {}
            function updateDetails(p1, p2) -- Line: 294 -- upvalues: u0 (upval), u3 (upval), u16 (val)
                local v1, v2
                if not p1 then
                    return
                end
                for k, v in pairs(p1) do
                    if u0.statesMatch(p2, v[4]) then
                        v2 = v[1] .. "-" .. v[2]
                        v1 = u3.copyTable(v)
                        v1[5] = v[5]
                        u16[v2] = v1
                    end
                end
            end
            if v == "Selected" then
                updateDetails(u6, "Deselected")
            end
            updateDetails(u6, "Empty")
            updateDetails(u6, v)
            if appliedTheme ~= u6 then
                if v == "Selected" then
                    updateDetails(appliedTheme, "Deselected")
                end
                updateDetails(u6, "Empty")
                updateDetails(appliedTheme, v)
            end
            v2 = {}
            v3 = p1.appearance[v]
            if v3 then
                for k2, i in pairs(v3) do
                    v1 = i[5]
                    if v1 ~= nil then
                        table.insert(v2, {
                            i[1],
                            i[2],
                            i[3],
                            v,
                            v1,
                        })
                    end
                end
            end
            updateDetails(v2, v)
            v4 = {}
            for k3, j in pairs(u16) do
                table.insert(v4, j)
            end
            p1.appearance[v] = v4
        end
        u0.change(p1)
    end)()
end
return u0