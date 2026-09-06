local u0 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer
function u0.createStagger(p1, p2, p3) -- Line: 13
    local staggeredCallback, u5
    local u3 = false
    local u4 = false
    if not p1 then
        u5 = 0.01
    elseif p1 ~= 0 then
        u5 = p1
    else
        u5 = 0.01
    end
    function staggeredCallback(...) -- Line: 29 -- upvalues: u3 (ref), u4 (ref), p3 (val), u5 (ref), p2 (val), staggeredCallback (val)
        local u4
        if u3 then
            u4 = true
            return
        end
        u4 = table.pack(...)
        u3 = true
        u4 = false
        task.spawn(function() -- Line: 37 -- upvalues: p3 (upval), u5 (upval), p2 (upval), u4 (val)
            if p3 then
                task.wait(u5)
            end
            p2(table.unpack(u4))
        end)
        task.delay(u5, function() -- Line: 43 -- upvalues: u3 (upval), u4 (upval), staggeredCallback (upval), u4 (val)
            u3 = false
            if u4 then
                staggeredCallback(table.unpack(u4))
            end
        end)
    end
    return staggeredCallback
end
function u0.round(p1) -- Line: 55
    return (math.floor(p1 + 0.5))
end
function u0.reverseTable(p1) -- Line: 60
    local v1, v2
    local v3 = math.floor(#p1 / 2)
    local v4 = 1
    for i = 1, v3, v4 do
        v1 = #p1 - i + 1
        v2 = p1[i]
        p1[i] = p1[v1]
        p1[v1] = v2
    end
end
function u0.copyTable(p1) -- Line: 67 -- upvalues: u0 (val)
    local v1 = type(p1) == "table"
    assert(v1, "First argument must be a table")
    local v2 = table.create(#p1)
    for k, v in pairs(p1) do
        if type(v) ~= "table" then
            v2[k] = v
        else
            v2[k] = u0.copyTable(v)
        end
    end
    return v2
end
local u11 = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "<",
    ">",
    "?",
    "@",
    "{",
    "}",
    "[",
    "]",
    "!",
    "(",
    ")",
    "=",
    "+",
    "~",
    "#",
}
function u0.generateUID(p1) -- Line: 82 -- upvalues: u11 (val)
    local v1
    local v2 = ""
    local v3 = u11
    local v4 = p1 or 8
    local v5 = 1
    for i = 1, v4, v5 do
        v1 = v3[math.random(1, #v3)]
        v2 = v2 .. v1
    end
    return v2
end
local u90 = {}
function u0.setVisible(p1, p2, p3) -- Line: 95 -- upvalues: u90 (val)
    local v1 = u90[p1]
    if not v1 then
        u90[p1] = {}
        p1.Destroying:Once(function() -- Line: 104 -- upvalues: u90 (upval), p1 (val)
            u90[p1] = nil
        end)
    end
    if p2 then
        v1[p3] = nil
    else
        v1[p3] = true
    end
    local v2 = p2
    if p2 then
        for k, v in pairs(v1) do
            v2 = false
            break
        end
    end
    p1.Visible = v2
end
function u0.formatStateName(p1) -- Line: 123
    local v1 = string.upper((string.sub(p1, 1, 1)))
    return v1 .. string.lower((string.sub(p1, 2)))
end
function u0.localPlayerRespawned(p1) -- Line: 127 -- upvalues: LocalPlayer (val)
    LocalPlayer.CharacterRemoving:Connect(p1)
end
function u0.getClippedContainer(p1) -- Line: 137
    local ClippedContainer = p1:FindFirstChild("ClippedContainer")
    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder")
        ClippedContainer.Name = "ClippedContainer"
        ClippedContainer.Parent = p1
    end
    return ClippedContainer
end
local u97 = require("./Packages/Janitor")
local GuiService = game:GetService("GuiService")
function u0.clipOutside(p1, p2) -- Line: 151 -- upvalues: u97 (val), u0 (val), GuiService (val)
    local PropertyChangedSignal_2, Visible, checkIfOutsideParentXBounds, u97
    local u8 = p1.janitor:add(u97.new())
    p2.Destroying:Once(function() -- Line: 153 -- upvalues: u8 (val)
        u8:Destroy()
    end)
    p1.janitor:add(p2)
    local Parent = p2.Parent
    local u25 = u8:add(Instance.new("Frame"))
    u25:SetAttribute("IsAClippedClone", true)
    u25.Name = p2.Name
    u25.AnchorPoint = p2.AnchorPoint
    u25.Size = p2.Size
    u25.Position = p2.Position
    u25.BackgroundTransparency = 1
    u25.LayoutOrder = p2.LayoutOrder
    u25.Parent = Parent
    local ObjectValue = Instance.new("ObjectValue")
    ObjectValue.Name = "OriginalInstance"
    ObjectValue.Value = p2
    ObjectValue.Parent = u25
    local v1 = ObjectValue:Clone()
    p2:SetAttribute("HasAClippedClone", true)
    v1.Name = "ClippedClone"
    v1.Value = u25
    v1.Parent = p2
    local u50 = nil
    local function updateScreenGui() -- Line: 181 -- upvalues: Parent (val), u50 (ref), p2 (val), u0 (upval)
        local v1
        local v2 = Parent:FindFirstAncestorWhichIsA("ScreenGui")
        if not (string.match(v2.Name, "Clipped")) then
            v1 = v2.Parent[v2.Name .. "Clipped"]
        else
            v1 = v2
        end
        u50 = v1
        p2.AnchorPoint = Vector2.new(0, 0)
        p2.Parent = u0.getClippedContainer(u50)
    end
    u8:add(p1.alignmentChanged:Connect(updateScreenGui))
    updateScreenGui()
    for k, v in pairs(p2:GetChildren()) do
        if v:IsA("UIAspectRatioConstraint") then
            v:Clone().Parent = u25
        end
    end
    local widget = p1.widget
    local u78 = false
    local Attribute = p2:GetAttribute("IgnoreVisibilityUpdater")
    local PropertyChangedSignal = widget:GetPropertyChangedSignal("Visible")
    u8:add(PropertyChangedSignal:Connect(function() -- Line: 203 -- upvalues: Attribute (val), widget (val), u78 (ref), u0 (upval), p2 (val)
        local Visible
        if Attribute then
            return
        end
        Visible = if u78 then false else widget.Visible
        u0.setVisible(p2, Visible, "ClipHandler")
    end))
    u97 = nil
    local iconModule = require(p1.iconModule)
    function checkIfOutsideParentXBounds() -- Line: 218 -- upvalues: p1 (val), p2 (val), iconModule (val), u78 (ref), Attribute (val), widget (val), u0 (upval), u97 (ref), checkIfOutsideParentXBounds (val), u8 (val)
        task.defer(function() -- Line: 220 -- upvalues: p1 (upval), p2 (upval), iconModule (upval), u78 (upval), Attribute (upval), widget (upval), u0 (upval), u97 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
            local Visible
            local v1 = nil
            local UID = p1.UID
            local parentIconUID = UID
            if p2:GetAttribute("ClipToJoinedParent") then
                local joinedFrame, v2
                local v3 = 10
                local v4 = 1
                for i = 1, v3, v4 do
                    v2 = iconModule.getIconByUID(parentIconUID)
                    if not v2 then
                        break
                    end
                    joinedFrame = v2.joinedFrame
                    parentIconUID = v2.parentIconUID
                    if not joinedFrame then
                        break
                    end
                    v1 = joinedFrame
                end
            end
            if not v1 then
                u78 = false
                if Attribute then
                    return
                end
                Visible = if u78 then false else widget.Visible
                u0.setVisible(p2, Visible, "ClipHandler")
                return
            end
            local AbsolutePosition = v1.AbsolutePosition
            local AbsoluteSize = v1.AbsoluteSize
            local v5 = p2.AbsolutePosition + p2.AbsoluteSize / 2
            local v6 = v5.X < AbsolutePosition.X
            local v7 = AbsolutePosition.X + AbsoluteSize.X < v5.X
            local v8 = v5.Y < AbsolutePosition.Y
            local v9 = AbsolutePosition.Y + AbsoluteSize.Y < v5.Y
            local v10 = v6
            if not v10 then
                v10 = v7
                if not v10 then
                    v10 = v8
                    if not v10 then
                        v10 = v9
                    end
                end
            end
            if v10 ~= u78 then
                u78 = v10
                if not Attribute then
                    local Visible_2 = if u78 then false else widget.Visible
                    u0.setVisible(p2, Visible_2, "ClipHandler")
                end
            end
            if v1:IsA("ScrollingFrame") and u97 ~= v1 then
                u97 = v1
                local PropertyChangedSignal = v1:GetPropertyChangedSignal("AbsoluteWindowSize")
                local v11 = PropertyChangedSignal:Connect(function() -- Line: 262 -- upvalues: checkIfOutsideParentXBounds (upval)
                    checkIfOutsideParentXBounds()
                end)
                u8:add(v11, "Disconnect", "TrackUtilityScroller-" .. UID)
            end
        end)
    end
    local CurrentCamera = workspace.CurrentCamera
    local u108 = p2:GetAttribute("AdditionalOffsetX") or 0
    local function trackProperty(a1) -- Line: 272 -- upvalues: u25 (val), CurrentCamera (val), p2 (val), GuiService (upval), u50 (ref), p1 (val), u108 (val), iconModule (val), u78 (ref), Attribute (val), widget (val), u0 (upval), u97 (ref), checkIfOutsideParentXBounds (val), u8 (val)
        local PropertyChangedSignal, v1
        local u3 = "Absolute" .. a1
        local function updateProperty() -- Line: 274 -- upvalues: u25 (upval), u3 (val), a1 (val), CurrentCamera (upval), p2 (upval), GuiService (upval), u50 (upval), p1 (upval), u108 (upval), iconModule (upval), u78 (upval), Attribute (upval), widget (upval), u0 (upval), u97 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
            local v1 = u25[u3]
            local v2 = UDim2.fromOffset(v1.X, v1.Y)
            if a1 == "Position" then
                local v3
                local v4 = CurrentCamera.ViewportSize.X - p2.AbsoluteSize.X - 4
                local Offset = v2.X.Offset
                if Offset < 4 then
                    Offset = 4
                elseif v4 < Offset then
                    Offset = v4
                end
                local TopbarInset = GuiService.TopbarInset
                local X = u50.AbsolutePosition.X
                if not p1.isOldTopbar then
                    v3 = workspace.CurrentCamera.ViewportSize.X - u50.AbsoluteSize.X - 0
                else
                    v3 = X
                end
                v3 = v3 - u108
                v2 = UDim2.fromOffset(Offset, v2.Y.Offset) + UDim2.fromOffset(-v3, TopbarInset.Height)
                task.defer(function() -- Line: 220 -- upvalues: p1 (upval), p2 (upval), iconModule (upval), u78 (upval), Attribute (upval), widget (upval), u0 (upval), u97 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
                    local Visible
                    local v1 = nil
                    local UID = p1.UID
                    local parentIconUID = UID
                    if p2:GetAttribute("ClipToJoinedParent") then
                        local joinedFrame, v2
                        local v3 = 10
                        local v4 = 1
                        for i = 1, v3, v4 do
                            v2 = iconModule.getIconByUID(parentIconUID)
                            if not v2 then
                                break
                            end
                            joinedFrame = v2.joinedFrame
                            parentIconUID = v2.parentIconUID
                            if not joinedFrame then
                                break
                            end
                            v1 = joinedFrame
                        end
                    end
                    if not v1 then
                        u78 = false
                        if Attribute then
                            return
                        end
                        Visible = if u78 then false else widget.Visible
                        u0.setVisible(p2, Visible, "ClipHandler")
                        return
                    end
                    local AbsolutePosition = v1.AbsolutePosition
                    local AbsoluteSize = v1.AbsoluteSize
                    local v5 = p2.AbsolutePosition + p2.AbsoluteSize / 2
                    local v6 = v5.X < AbsolutePosition.X
                    local v7 = AbsolutePosition.X + AbsoluteSize.X < v5.X
                    local v8 = v5.Y < AbsolutePosition.Y
                    local v9 = AbsolutePosition.Y + AbsoluteSize.Y < v5.Y
                    local v10 = v6
                    if not v10 then
                        v10 = v7
                        if not v10 then
                            v10 = v8
                            if not v10 then
                                v10 = v9
                            end
                        end
                    end
                    if v10 ~= u78 then
                        u78 = v10
                        if not Attribute then
                            local Visible_2 = if u78 then false else widget.Visible
                            u0.setVisible(p2, Visible_2, "ClipHandler")
                        end
                    end
                    if v1:IsA("ScrollingFrame") and u97 ~= v1 then
                        u97 = v1
                        local PropertyChangedSignal = v1:GetPropertyChangedSignal("AbsoluteWindowSize")
                        local v11 = PropertyChangedSignal:Connect(function() -- Line: 262 -- upvalues: checkIfOutsideParentXBounds (upval)
                            checkIfOutsideParentXBounds()
                        end)
                        u8:add(v11, "Disconnect", "TrackUtilityScroller-" .. UID)
                    end
                end)
            end
            p2[a1] = v2
        end
        local v2 = u0.createStagger(0.01, updateProperty)
        PropertyChangedSignal = u25:GetPropertyChangedSignal(u3)
        u8:add(PropertyChangedSignal:Connect(v2))
        v1 = u0.createStagger(0.5, updateProperty, true)
        local PropertyChangedSignal_2 = u25:GetPropertyChangedSignal(u3)
        u8:add(PropertyChangedSignal_2:Connect(v1))
    end
    task.delay(0.1, checkIfOutsideParentXBounds)
    task.defer(function() -- Line: 220 -- upvalues: p1 (val), p2 (val), iconModule (val), u78 (ref), Attribute (val), widget (val), u0 (upval), u97 (ref), checkIfOutsideParentXBounds (val), u8 (val)
        local Visible
        local v1 = nil
        local UID = p1.UID
        local parentIconUID = UID
        if p2:GetAttribute("ClipToJoinedParent") then
            local joinedFrame, v2
            local v3 = 10
            local v4 = 1
            for i = 1, v3, v4 do
                v2 = iconModule.getIconByUID(parentIconUID)
                if not v2 then
                    break
                end
                joinedFrame = v2.joinedFrame
                parentIconUID = v2.parentIconUID
                if not joinedFrame then
                    break
                end
                v1 = joinedFrame
            end
        end
        if not v1 then
            u78 = false
            if Attribute then
                return
            end
            Visible = if u78 then false else widget.Visible
            u0.setVisible(p2, Visible, "ClipHandler")
            return
        end
        local AbsolutePosition = v1.AbsolutePosition
        local AbsoluteSize = v1.AbsoluteSize
        local v5 = p2.AbsolutePosition + p2.AbsoluteSize / 2
        local v6 = v5.X < AbsolutePosition.X
        local v7 = AbsolutePosition.X + AbsoluteSize.X < v5.X
        local v8 = v5.Y < AbsolutePosition.Y
        local v9 = AbsolutePosition.Y + AbsoluteSize.Y < v5.Y
        local v10 = v6
        if not v10 then
            v10 = v7
            if not v10 then
                v10 = v8
                if not v10 then
                    v10 = v9
                end
            end
        end
        if v10 ~= u78 then
            u78 = v10
            if not Attribute then
                local Visible_2 = if u78 then false else widget.Visible
                u0.setVisible(p2, Visible_2, "ClipHandler")
            end
        end
        if v1:IsA("ScrollingFrame") and u97 ~= v1 then
            u97 = v1
            local PropertyChangedSignal = v1:GetPropertyChangedSignal("AbsoluteWindowSize")
            local v11 = PropertyChangedSignal:Connect(function() -- Line: 262 -- upvalues: checkIfOutsideParentXBounds (upval)
                checkIfOutsideParentXBounds()
            end)
            u8:add(v11, "Disconnect", "TrackUtilityScroller-" .. UID)
        end
    end)
    if not Attribute then
        Visible = if u78 then false else widget.Visible
        u0.setVisible(p2, Visible, "ClipHandler")
    end
    trackProperty("Position")
    PropertyChangedSignal_2 = p2:GetPropertyChangedSignal("Visible")
    u8:add(PropertyChangedSignal_2:Connect(function() end))
    if not (p2:GetAttribute("TrackCloneSize")) then
        local PropertyChangedSignal_3 = p2:GetPropertyChangedSignal("AbsoluteSize")
        u8:add(PropertyChangedSignal_3:Connect(function() -- Line: 343 -- upvalues: p2 (val), u25 (val)
            local AbsoluteSize = p2.AbsoluteSize
            u25.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end))
    else
        trackProperty("Size")
    end
    return u25
end
function u0.joinFeature(p1, p2, p3, p4) -- Line: 352
    local alignment
    local joinJanitor = p1.joinJanitor
    joinJanitor:clean()
    if not p4 then
        p1:leave()
        return
    end
    p1.parentIconUID = p2.UID
    p1.joinedFrame = p4
    joinJanitor:add(p2.alignmentChanged:Connect(function() -- Line: 363 -- upvalues: p2 (val), p1 (val)
        local alignment = p2.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        p1:setAlignment(alignment, true)
    end))
    alignment = p2.alignment
    if alignment == "Center" then
        alignment = "Left"
    end
    p1:setAlignment(alignment, true)
    p1:modifyTheme({"IconButton", "BackgroundTransparency", 1}, "JoinModification")
    p1:modifyTheme({"ClickRegion", "Active", false}, "JoinModification")
    if p2.childModifications then
        task.defer(function() -- Line: 378 -- upvalues: p1 (val), p2 (val)
            p1:modifyTheme(p2.childModifications, p2.childModificationsUID)
        end)
    end
    local u55 = p1:getInstance("ClickRegion")
    local function makeSelectable() -- Line: 384 -- upvalues: u55 (val), p2 (val)
        u55.Selectable = p2.isSelected
    end
    joinJanitor:add(p2.toggled:Connect(makeSelectable))
    task.defer(makeSelectable)
    joinJanitor:add(function() -- Line: 389 -- upvalues: u55 (val)
        u55.Selectable = true
    end)
    local UID = p1.UID
    table.insert(p3, UID)
    p2:autoDeselect(false)
    p2.childIconsDict[UID] = true
    if not p2.isEnabled then
        p2:setEnabled(true)
    end
    p1.joinedParent:Fire(p2)
    joinJanitor:add(function() -- Line: 407 -- upvalues: p1 (val), p3 (val), UID (val), p2 (val)
        if not p1.joinedFrame then
            return
        end
        for k, v in pairs(p3) do
            if v == UID then
                table.remove(p3, k)
                break
            end
        end
        local v1 = require(p1.iconModule).getIconByUID(p1.parentIconUID)
        if not v1 then
            return
        end
        p1:setAlignment(p1.originalAlignment)
        p1.parentIconUID = false
        p1.joinedFrame = false
        p1:setBehaviour("IconButton", "BackgroundTransparency", nil, true)
        p1:removeModification("JoinModification")
        local v2 = true
        local childIconsDict = v1.childIconsDict
        childIconsDict[UID] = nil
        for k2, i in pairs(childIconsDict) do
            v2 = false
            break
        end
        if v2 and not v1.isAnOverflow then
            v1:setEnabled(false)
        end
        local alignment = p2.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        p1:setAlignment(alignment, true)
    end)
end
return u0