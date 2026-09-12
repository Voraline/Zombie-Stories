local u0 = {}
local LocalPlayer = (game:GetService("Players")).LocalPlayer

function u0.createStagger(p1, p2, p3) -- Line: 13
    local staggeredCallback
    local u3 = false
    local u4 = false
    if not p1 or p1 == 0 then
        p1 = 0.01
    end

    function staggeredCallback(...) -- Line: 29
        -- upvalues: u3 (ref), u4 (ref), p3 (val), p1 (ref), p2 (val), staggeredCallback (val)
        if u3 then
            u4 = true
            return
        end
        local u4_2 = table.pack(...)
        u3 = true
        u4 = false
        task.spawn(function() -- Line: 37 -- upvalues: p3 (upval), p1 (upval), p2 (upval), u4_2 (val)
            if p3 then
                task.wait(p1)
            end
            local v1 = p2
            local v2 = u4_2
            v1(table.unpack(v2))
        end)
        local delay = task.delay
        local v1 = p1
        delay(v1, function() -- Line: 43 -- upvalues: u3 (upval), u4 (upval), staggeredCallback (upval), u4_2 (val)
            u3 = false
            if u4 then
                local v1 = staggeredCallback
                local v2 = u4_2
                v1(table.unpack(v2))
            end
        end)
    end

    return staggeredCallback
end

function u0.round(p1) -- Line: 55
    local v1 = p1 + 0.5
    return (math.floor(v1))
end

function u0.reverseTable(p1) -- Line: 60
    local v1
    local v2 = #p1
    local v3 = v2 / 2
    local v4 = math.floor(v3)
    for i = 1, v4 do
        v1 = #p1 - i + 1
        v3 = p1[v1]
        v2 = p1[i]
        p1[i] = v3
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
            v2[k] = (u0.copyTable(v))
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
    local v1 = ""
    local v2 = u11
    local v3 = #v2
    local v4 = p1 or 8
    for i = 1, v4 do
        v1 = v1 .. v2[math.random(1, v3)]
    end
    return v1
end

local u90 = {}

function u0.setVisible(p1, p2, p3) -- Line: 95 -- upvalues: u90 (val)
    local v1 = u90[p1]
    if not v1 then
        v1 = {}
        u90[p1] = v1
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
    return (string.upper((string.sub(p1, 1, 1)))) .. string.lower((string.sub(p1, 2)))
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
    local checkIfOutsideParentXBounds
    local janitor = p1.janitor
    local v1 = u97
    v1 = v1.new()
    local u8 = janitor:add(v1)
    p2.Destroying:Once(function() -- Line: 153 -- upvalues: u8 (val)
        u8:Destroy()
    end)
    p1.janitor:add(p2)
    local Parent = p2.Parent
    local Frame = Instance.new("Frame")
    local u25 = u8:add(Frame)
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
    local v2 = ObjectValue:Clone()
    p2:SetAttribute("HasAClippedClone", true)
    v2.Name = "ClippedClone"
    v2.Value = u25
    v2.Parent = p2
    local u50 = nil

    local function updateScreenGui() -- Line: 181 -- upvalues: Parent (val), u50 (ref), p2 (val), u0 (upval)
        local v1
        local v2 = Parent:FindFirstAncestorWhichIsA("ScreenGui")
        if not string.match(v2.Name, "Clipped") then
            v1 = v2.Parent[v2.Name .. "Clipped"]
        else
            v1 = v2
        end
        u50 = v1
        p2.AnchorPoint = Vector2.new(0, 0)
        p2.Parent = u0.getClippedContainer(u50)
    end

    local v3 = p1.alignmentChanged:Connect(updateScreenGui)
    u8:add(v3)
    updateScreenGui()
    for k, v in pairs(p2:GetChildren()) do
        if v:IsA("UIAspectRatioConstraint") then
            v:Clone().Parent = u25
        end
    end
    local widget = p1.widget
    local u78 = false
    local Attribute = p2:GetAttribute("IgnoreVisibilityUpdater")
    local v4 = (widget:GetPropertyChangedSignal("Visible")):Connect(function() -- Line: 203 -- upvalues: Attribute (val), widget (val), u78 (ref), u0 (upval), p2 (val)
        if Attribute then
            return
        end
        local Visible = widget.Visible
        if u78 then
            Visible = false
        end
        u0.setVisible(p2, Visible, "ClipHandler")
    end)
    u8:add(v4)
    local u97_2 = nil
    local iconModule = require(p1.iconModule)

    function checkIfOutsideParentXBounds() -- Line: 218
        -- upvalues: p1 (val), p2 (val), iconModule (val), u78 (ref), Attribute (val), widget (val), u0 (upval)
        -- upvalues: u97_2 (ref), checkIfOutsideParentXBounds (val), u8 (val)
        task.defer(function() -- Line: 220
            -- upvalues: p1 (upval), p2 (upval), iconModule (upval), u78 (upval), Attribute (upval), widget (upval)
            -- upvalues: u0 (upval), u97_2 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
            local v1 = nil
            local UID = p1.UID
            local parentIconUID = UID
            if p2:GetAttribute("ClipToJoinedParent") then
                local joinedFrame, v2
                for i = 1, 10 do
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
                local Visible = widget.Visible
                if u78 then
                    Visible = false
                end
                u0.setVisible(p2, Visible, "ClipHandler")
                return
            end
            local v3 = p2
            local AbsolutePosition = v3.AbsolutePosition
            local v4 = p2.AbsoluteSize / 2
            local AbsolutePosition_2 = v1.AbsolutePosition
            local AbsoluteSize = v1.AbsoluteSize
            local v5 = AbsolutePosition + v4
            local v6 = v5.X < AbsolutePosition_2.X
            local X = v5.X
            local v7 = AbsolutePosition_2.X + AbsoluteSize.X < X
            local v8 = v5.Y < AbsolutePosition_2.Y
            local Y = v5.Y
            local v9 = AbsolutePosition_2.Y + AbsoluteSize.Y < Y
            local v10 = v6 or v7 or v8 or v9
            if v10 ~= u78 then
                u78 = v10
                if not Attribute then
                    local Visible_2 = widget.Visible
                    if u78 then
                        Visible_2 = false
                    end
                    u0.setVisible(p2, Visible_2, "ClipHandler")
                end
            end
            if v1:IsA("ScrollingFrame") and u97_2 ~= v1 then
                u97_2 = v1
                local v11 = (v1:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 262 -- upvalues: checkIfOutsideParentXBounds (upval)
                    checkIfOutsideParentXBounds()
                end)
                local v12 = u8
                local v13 = "TrackUtilityScroller-" .. UID
                v12:add(v11, "Disconnect", v13)
            end
        end)
    end

    local CurrentCamera = workspace.CurrentCamera
    local u108 = p2:GetAttribute("AdditionalOffsetX") or 0

    local function trackProperty(p1_2) -- Line: 272
        -- upvalues: u25 (val), CurrentCamera (val), p2 (val), GuiService (upval), u50 (ref), p1 (val), u108 (val)
        -- upvalues: iconModule (val), u78 (ref), Attribute (val), widget (val), u0 (upval), u97_2 (ref)
        -- upvalues: checkIfOutsideParentXBounds (val), u8 (val)
        local u3 = "Absolute" .. p1_2

        local function updateProperty() -- Line: 274
            -- upvalues: u25 (upval), u3 (val), p1_2 (val), CurrentCamera (upval), p2 (upval), GuiService (upval)
            -- upvalues: u50 (upval), p1 (upval), u108 (upval), iconModule (upval), u78 (upval), Attribute (upval)
            -- upvalues: widget (upval), u0 (upval), u97_2 (upval), checkIfOutsideParentXBounds (upval), u8 (upval)
            local v1 = u25[u3]
            local v2 = UDim2.fromOffset(v1.X, v1.Y)
            if p1_2 == "Position" then
                local v3
                local v4 = CurrentCamera.ViewportSize.X - p2.AbsoluteSize.X - 4
                local Offset = v2.X.Offset
                if Offset < 4 then
                    Offset = 4
                elseif v4 < Offset then
                    Offset = v4
                end
                v2 = UDim2.fromOffset(Offset, v2.Y.Offset)
                local TopbarInset = GuiService.TopbarInset
                local X = workspace.CurrentCamera.ViewportSize.X
                local v5 = u50
                local X_2 = v5.AbsoluteSize.X
                local X_3 = u50.AbsolutePosition.X
                local v6 = X_3 - TopbarInset.Min.X
                if not p1.isOldTopbar then
                    v3 = X - X_2 - 0
                else
                    v3 = X_3
                end
                v3 = v3 - u108
                v2 = v2 + UDim2.fromOffset(-v3, TopbarInset.Height)
                task.defer(function() -- Line: 220
                    -- upvalues: p1 (upval), p2 (upval), iconModule (upval), u78 (upval), Attribute (upval)
                    -- upvalues: widget (upval), u0 (upval), u97_2 (upval), checkIfOutsideParentXBounds (upval)
                    -- upvalues: u8 (upval)
                    local v1 = nil
                    local UID = p1.UID
                    local parentIconUID = UID
                    if p2:GetAttribute("ClipToJoinedParent") then
                        local joinedFrame, v2
                        for i = 1, 10 do
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
                        local Visible = widget.Visible
                        if u78 then
                            Visible = false
                        end
                        u0.setVisible(p2, Visible, "ClipHandler")
                        return
                    end
                    local v3 = p2
                    local AbsolutePosition = v3.AbsolutePosition
                    local v4 = p2.AbsoluteSize / 2
                    local AbsolutePosition_2 = v1.AbsolutePosition
                    local AbsoluteSize = v1.AbsoluteSize
                    local v5 = AbsolutePosition + v4
                    local v6 = v5.X < AbsolutePosition_2.X
                    local X = v5.X
                    local v7 = AbsolutePosition_2.X + AbsoluteSize.X < X
                    local v8 = v5.Y < AbsolutePosition_2.Y
                    local Y = v5.Y
                    local v9 = AbsolutePosition_2.Y + AbsoluteSize.Y < Y
                    local v10 = v6 or v7 or v8 or v9
                    if v10 ~= u78 then
                        u78 = v10
                        if not Attribute then
                            local Visible_2 = widget.Visible
                            if u78 then
                                Visible_2 = false
                            end
                            u0.setVisible(p2, Visible_2, "ClipHandler")
                        end
                    end
                    if v1:IsA("ScrollingFrame") and u97_2 ~= v1 then
                        u97_2 = v1
                        local v11 = (v1:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 262 -- upvalues: checkIfOutsideParentXBounds (upval)
                            checkIfOutsideParentXBounds()
                        end)
                        local v12 = u8
                        local v13 = "TrackUtilityScroller-" .. UID
                        v12:add(v11, "Disconnect", v13)
                    end
                end)
            end
            p2[p1_2] = v2
        end

        local v1 = u0.createStagger(0.01, updateProperty)
        local v2 = u8
        local v3 = (u25:GetPropertyChangedSignal(u3)):Connect(v1)
        v2:add(v3)
        v2 = u0.createStagger(0.5, updateProperty, true)
        local v4 = u8
        local v5 = (u25:GetPropertyChangedSignal(u3)):Connect(v2)
        v4:add(v5)
    end

    task.delay(0.1, checkIfOutsideParentXBounds)
    task.defer(function() -- Line: 220
        -- upvalues: p1 (val), p2 (val), iconModule (val), u78 (ref), Attribute (val), widget (val), u0 (upval)
        -- upvalues: u97_2 (ref), checkIfOutsideParentXBounds (val), u8 (val)
        local v1 = nil
        local UID = p1.UID
        local parentIconUID = UID
        if p2:GetAttribute("ClipToJoinedParent") then
            local joinedFrame, v2
            for i = 1, 10 do
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
            local Visible = widget.Visible
            if u78 then
                Visible = false
            end
            u0.setVisible(p2, Visible, "ClipHandler")
            return
        end
        local v3 = p2
        local AbsolutePosition = v3.AbsolutePosition
        local v4 = p2.AbsoluteSize / 2
        local AbsolutePosition_2 = v1.AbsolutePosition
        local AbsoluteSize = v1.AbsoluteSize
        local v5 = AbsolutePosition + v4
        local v6 = v5.X < AbsolutePosition_2.X
        local X = v5.X
        local v7 = AbsolutePosition_2.X + AbsoluteSize.X < X
        local v8 = v5.Y < AbsolutePosition_2.Y
        local Y = v5.Y
        local v9 = AbsolutePosition_2.Y + AbsoluteSize.Y < Y
        local v10 = v6 or v7 or v8 or v9
        if v10 ~= u78 then
            u78 = v10
            if not Attribute then
                local Visible_2 = widget.Visible
                if u78 then
                    Visible_2 = false
                end
                u0.setVisible(p2, Visible_2, "ClipHandler")
            end
        end
        if v1:IsA("ScrollingFrame") and u97_2 ~= v1 then
            u97_2 = v1
            local v11 = (v1:GetPropertyChangedSignal("AbsoluteWindowSize")):Connect(function() -- Line: 262 -- upvalues: checkIfOutsideParentXBounds (upval)
                checkIfOutsideParentXBounds()
            end)
            local v12 = u8
            local v13 = "TrackUtilityScroller-" .. UID
            v12:add(v11, "Disconnect", v13)
        end
    end)
    if not Attribute then
        local Visible = widget.Visible
        if u78 then
            Visible = false
        end
        u0.setVisible(p2, Visible, "ClipHandler")
    end
    trackProperty("Position")
    local v5 = (p2:GetPropertyChangedSignal("Visible")):Connect(function() end)
    u8:add(v5)
    if not p2:GetAttribute("TrackCloneSize") then
        local v6 = (p2:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 343 -- upvalues: p2 (val), u25 (val)
            local AbsoluteSize = p2.AbsoluteSize
            u25.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end)
        u8:add(v6)
    else
        trackProperty("Size")
    end
    return u25
end

function u0.joinFeature(p1, p2, p3, p4) -- Line: 352
    local joinJanitor = p1.joinJanitor
    joinJanitor:clean()
    if not p4 then
        p1:leave()
        return
    end
    p1.parentIconUID = p2.UID
    p1.joinedFrame = p4
    local v1 = p2.alignmentChanged:Connect(function() -- Line: 363 -- upvalues: p2 (val), p1 (val)
        local alignment = p2.alignment
        if alignment == "Center" then
            alignment = "Left"
        end
        p1:setAlignment(alignment, true)
    end)
    joinJanitor:add(v1)
    local alignment = p2.alignment
    if alignment == "Center" then
        alignment = "Left"
    end
    p1:setAlignment(alignment, true)
    p1:modifyTheme({"IconButton", "BackgroundTransparency", 1}, "JoinModification")
    p1:modifyTheme({"ClickRegion", "Active", false}, "JoinModification")
    if p2.childModifications then
        task.defer(function() -- Line: 378 -- upvalues: p1 (val), p2 (val)
            local v1 = p1
            local v2 = p2
            local childModifications = v2.childModifications
            local v3 = p2
            local childModificationsUID = v3.childModificationsUID
            v1:modifyTheme(childModifications, childModificationsUID)
        end)
    end
    local u55 = p1:getInstance("ClickRegion")

    local function makeSelectable() -- Line: 384 -- upvalues: u55 (val), p2 (val)
        u55.Selectable = p2.isSelected
    end

    local v2 = p2.toggled:Connect(makeSelectable)
    joinJanitor:add(v2)
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
        local v2 = p1
        local v3 = p1
        local originalAlignment = v3.originalAlignment
        v2:setAlignment(originalAlignment)
        p1.parentIconUID = false
        p1.joinedFrame = false
        p1:setBehaviour("IconButton", "BackgroundTransparency", nil, true)
        p1:removeModification("JoinModification")
        v2 = true
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