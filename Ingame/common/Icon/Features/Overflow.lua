local u0 = {}
local u1 = {}
local u2 = {}
local u3 = nil
local CurrentCamera = workspace.CurrentCamera
local u6 = {}
local u7 = {}
local u10 = require("../Utility")
local u11 = nil

function u0.start(p1) -- Line: 23 -- upvalues: u11 (ref), u3 (ref), u1 (val), u10 (val), u0 (val), CurrentCamera (val)
    u11 = p1
    u3 = u11.iconsDictionary
    local v1 = nil
    for k, v in pairs(u11.container) do
        if v1 == nil and v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
            v1 = v
        end
        for k2, i in pairs(v.Holders:GetChildren()) do
            if i:GetAttribute("IsAHolder") then
                u1[i.Name] = i
            end
        end
    end
    local u17 = false
    local v2 = u10
    local u22 = v2.createStagger(0.1, function(p1) -- Line: 41 -- upvalues: u17 (ref), u0 (upval)
        if not u17 then
            return
        end
        if not p1 then
            u0.updateAvailableIcons("Center")
        end
        u0.updateBoundary("Left")
        u0.updateBoundary("Right")
    end)
    task.delay(1, function() -- Line: 51 -- upvalues: u17 (ref), u22 (val)
        u17 = true
        u22()
    end)
    u11.iconAdded:Connect(u22)
    u11.iconRemoved:Connect(u22)
    u11.iconChanged:Connect(u22)
    ;(CurrentCamera:GetPropertyChangedSignal("ViewportSize")):Connect(function() -- Line: 61 -- upvalues: u22 (val)
        u22(true)
    end)
    ;(v1:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 64 -- upvalues: u22 (val)
        u22(true)
    end)
end

function u0.getWidth(p1, p2) -- Line: 69
    local widget = p1.widget
    local Attribute = widget:GetAttribute("TargetWidth")
    if not Attribute then
        Attribute = widget.AbsoluteSize.X
    end
    return Attribute
end

function u0.getAvailableIcons(p1) -- Line: 74 -- upvalues: u2 (val), u0 (val)
    local v1 = u2[p1]
    if not v1 then
        v1 = u0.updateAvailableIcons(p1)
    end
    return v1
end

function u0.updateAvailableIcons(p1) -- Line: 82 -- upvalues: u1 (val), u3 (ref), u7 (val), u2 (val)
    local parentIconUID, v1, v2
    local v3 = 0
    local UIListLayout = u1[p1].UIListLayout
    local v4 = {}
    local v5 = p1
    for k, v in pairs(u3) do
        parentIconUID = v.parentIconUID
        v1 = not parentIconUID
        if not v1 then
            v1 = u7[parentIconUID]
        end
        v2 = u7[v.UID]
        if v1 and v.alignment == v5 and not v2 then
            table.insert(v4, v)
            v3 = v3 + 1
        end
    end
    if v3 <= 0 then
        return {}
    end
    table.sort(v4, function(p1, p2) -- Line: 106
        local LayoutOrder = p1.widget.LayoutOrder
        local LayoutOrder_2 = p2.widget.LayoutOrder
        local parentIconUID = p1.parentIconUID
        local parentIconUID_2 = p2.parentIconUID
        if parentIconUID ~= parentIconUID_2 then
            if parentIconUID_2 then
                return false
            end
            if parentIconUID then
                return true
            end
            return
        end
        if LayoutOrder < LayoutOrder_2 then
            return true
        end
        if LayoutOrder_2 < LayoutOrder then
            return false
        end
        local v1 = p1.widget.AbsolutePosition.X < p2.widget.AbsolutePosition.X
        return v1
    end)
    u2[v5] = v4
    return v4
end

function u0.getRealXPositions(p1, p2) -- Line: 132 -- upvalues: u1 (val), u10 (val), u0 (val)
    local v1, v2, v3, v4
    local v5 = p1 == "Left"
    local v6 = u1[p1]
    local X = v6.AbsolutePosition.X
    local X_2 = v6.AbsoluteSize.X
    local Offset = v6.UIListLayout.Padding.Offset
    if not v5 then
        v4 = X + X_2
    else
        v4 = X
        if not v4 then
            v4 = X + X_2
        end
    end
    local v7 = {}
    if v5 then
        u10.reverseTable(p2)
    end
    local v8 = p2
    for i = #p2, 1, -1 do
        v1 = v8[i]
        v2 = u0.getWidth(v1)
        if not v5 then
            v4 = v4 - v2
        end
        v7[v1.UID] = v4
        if v5 then
            v4 = v4 + v2
        end
        if not v5 then
            v3 = -Offset
        else
            v3 = Offset
            if not v3 then
                v3 = -Offset
            end
        end
        v4 = v4 + v3
    end
    return v7
end

function u0.updateBoundary(p1) -- Line: 162 -- upvalues: u1 (val), u0 (val), u6 (val), u11 (ref), u7 (val), u10 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
    local v13 = u1[p1]
    local UIListLayout = v13.UIListLayout
    local X = v13.AbsolutePosition.X
    local X_2 = v13.AbsoluteSize.X
    local Offset = UIListLayout.Padding.Offset
    local Offset_2 = UIListLayout.Padding.Offset
    local v14 = u0.updateAvailableIcons(p1)
    local v15 = 0
    local v16 = 0
    for k, v in pairs(v14) do
        v15 = v15 + (u0.getWidth(v) + Offset_2)
        v16 = v16 + 1
    end
    if v16 <= 0 then
        return
    end
    local v17 = p1 == "Central"
    local v18 = p1 == "Left"
    local v19 = not v18
    local v20 = u6[p1]
    if not v20 and not v17 and 0 < #v14 then
        if not v18 then
            v1 = 9999999
        else
            v1 = -9999999
        end
        v20 = u11.new()
        v20:setImage(6069276526, "Deselected")
        v3 = "Overflow" .. p1
        v20:setName(v3)
        v20:setOrder(v1)
        v20:setAlignment(p1)
        v20:autoDeselect(false)
        v20.isAnOverflow = true
        v20:select("OverflowStart", v20)
        v20:setEnabled(false)
        u6[p1] = v20
        u7[v20.UID] = true
    end
    if p1 ~= "Left" then
        v1 = "Left"
    else
        v1 = "Right"
    end
    local v21 = u0.updateAvailableIcons(v1)
    if not v18 then
        v2 = v19
        if v2 then
            v2 = v21[#v21]
        end
    else
        v2 = v21[1]
        if not v2 then
            v2 = v19
            if v2 then
                v2 = v21[#v21]
            end
        end
    end
    v3 = u6[v1]
    if not v18 then
        v4 = X
    else
        v4 = X + X_2
        if not v4 then
            v4 = X
        end
    end
    if v2 then
        local widget = v2.widget
        v6 = (u0.getRealXPositions(v1, v21))[v2.UID]
        v7 = u0.getWidth(v2)
        if not v18 then
            v8 = v6 + v7 + Offset
        else
            v8 = v6 - Offset
            if not v8 then
                v8 = v6 + v7 + Offset
            end
        end
        v4 = v8
    end
    local Center = u0.getAvailableIcons("Center")
    if not v18 then
        v5 = #Center
    else
        v5 = 1
    end
    v6 = Center[v5]
    if v6 and not v6.hasRelocatedInOverflow then
        local v22
        if not v18 then
            v7 = v19
            if v7 then
                v7 = v14[1]
            end
        else
            v7 = v14[#v14]
            if not v7 then
                v7 = v19
                if v7 then
                    v7 = v14[1]
                end
            end
        end
        local X_3 = v6.widget.AbsolutePosition.X
        local X_4 = v7.widget.AbsolutePosition.X
        v9 = u0.getWidth(v7)
        if not v18 then
            v22 = X_3 + u0.getWidth(v6) + Offset
        else
            v22 = X_3 - Offset
            if not v22 then
                v22 = X_3 + u0.getWidth(v6) + Offset
            end
        end
        if not v18 then
            v10 = X_4
        else
            v10 = X_4 + v9
            if not v10 then
                v10 = X_4
            end
        end
        if not v18 then
            if v19 and v10 < v22 then
                v6:align("Right")
                v6.hasRelocatedInOverflow = true
            end
        elseif v22 < v10 then
            v6:align("Left")
            v6.hasRelocatedInOverflow = true
        end
    end
    if v20 then
        v8 = v20:getInstance("Menu")
        local v23 = X + X_2
        v9 = X_2
        if v8 and v3 then
            local v24
            local X_5 = v3.widget.AbsolutePosition.X
            v11 = u0.getWidth(v3)
            if not v18 then
                v12 = X_5 + v11 + Offset
            else
                v12 = X_5 - Offset
                if not v12 then
                    v12 = X_5 + v11 + Offset
                end
            end
            local v25 = v3:getInstance("Menu")
            local X_6 = v8.AbsoluteCanvasSize.X
            local v26 = v25.AbsoluteCanvasSize.X <= X_6
            local v27 = X + X_2 / 2
            if not v18 then
                v24 = v27 + Offset / 2
            else
                v24 = v27 - Offset / 2
                if not v24 then
                    v24 = v27 + Offset / 2
                end
            end
            v7 = v24
            if v26 then
                v7 = v12
            end
            if not v18 then
                v27 = v23 - v7
            else
                v27 = v7 - X
                if not v27 then
                    v27 = v23 - v7
                end
            end
            v9 = v27
        end
        local Attribute = v8
        if Attribute then
            Attribute = v8:GetAttribute("MaxWidth")
        end
        v9 = u10.round(v9)
        if v8 and Attribute ~= v9 then
            v8:SetAttribute("MaxWidth", v9)
        end
    end
    v7 = false
    v8 = u0.getRealXPositions(p1, v14)
    for i = #v14, 1, -1 do
        v10 = v14[i]
        v11 = u0.getWidth(v10)
        v12 = v8[v10.UID]
        if not v18 then
            if v19 and v12 <= v4 then
                v7 = true
            end
        elseif v4 <= v12 + v11 or v19 and v12 <= v4 then
            v7 = true
        end
    end
    for j = #v14, 1, -1 do
        v10 = v14[j]
        if not u7[v10.UID] then
            if not v7 then
                if not v7 and v10.parentIconUID then
                    v10:leave()
                end
            elseif not v10.parentIconUID then
                v10:joinMenu(v20)
            elseif not v7 and v10.parentIconUID then
                v10:leave()
            end
        end
    end
    if v20.isEnabled ~= v7 then
        v20:setEnabled(v7)
    end
    if v20.isEnabled and not v20.overflowAlreadyOpened then
        v20.overflowAlreadyOpened = true
        v20:select()
    end
end

return u0