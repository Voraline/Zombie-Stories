local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local u15 = {}
local u16 = nil
function u15.start(p1) -- Line: 24 -- upvalues: u16 (ref), GuiService (val), UserInputService (val), u15 (val), GamepadService (val)
    u16 = p1
    u16.highlightKey = Enum.KeyCode.DPadUp
    u16.highlightIcon = false
    task.delay(1, function() -- Line: 33 -- upvalues: u16 (upval), GuiService (upval), UserInputService (upval), u15 (upval), GamepadService (upval)
        local iconsDictionary = u16.iconsDictionary
        local function getIconFromSelectedObject() -- Line: 36 -- upvalues: GuiService (upval), iconsDictionary (val)
            local SelectedObject = GuiService.SelectedObject
            local Attribute = SelectedObject
            if Attribute then
                Attribute = SelectedObject:GetAttribute("CorrespondingIconUID")
            end
            local v1 = Attribute
            if v1 then
                v1 = iconsDictionary[Attribute]
            end
            return v1
        end
        local u3 = nil
        local u4 = false
        local u5 = false
        require("../Utility")
        local u11 = require("../Elements/Selection")
        local function updateSelectedObject() -- Line: 50 -- upvalues: GuiService (upval), iconsDictionary (val), UserInputService (upval), u11 (val), u16 (upval), u3 (ref), u5 (ref), u4 (ref), u15 (upval)
            local ButtonB
            local SelectedObject = GuiService.SelectedObject
            local Attribute = SelectedObject
            if Attribute then
                Attribute = SelectedObject:GetAttribute("CorrespondingIconUID")
            end
            local v1 = Attribute
            if v1 then
                v1 = iconsDictionary[Attribute]
            end
            local v2 = v1
            local GamepadEnabled = UserInputService.GamepadEnabled
            if not v2 then
                local highlightKey
                if not GamepadEnabled then
                    highlightKey = nil
                elseif not u4 then
                    highlightKey = u16.highlightKey
                end
                if not u3 then
                    u3 = u15.getIconToHighlight()
                end
                if highlightKey == u16.highlightKey then
                    u4 = true
                end
                if u3 then
                    u3:setIndicator(highlightKey)
                end
                return
            end
            if GamepadEnabled then
                local v3 = v2:getInstance("ClickRegion")
                local selection = v2.selection
                if not selection then
                    selection = v2.janitor:add(u11(u16))
                    selection:SetAttribute("IgnoreVisibilityUpdater", true)
                    selection.Parent = v2.widget
                    v2.selection = selection
                    v2:refreshAppearance(selection)
                end
                v3.SelectionImageObject = selection.Selection
            end
            if u3 and u3 ~= v2 then
                u3:setIndicator()
            end
            if not GamepadEnabled then
                ButtonB = nil
            elseif u5 then
                ButtonB = nil
            elseif v2.parentIconUID then
                ButtonB = nil
            else
                ButtonB = Enum.KeyCode.ButtonB
            end
            u3 = v2
            u16.lastHighlightedIcon = v2
            v2:setIndicator(ButtonB)
        end
        local PropertyChangedSignal = GuiService:GetPropertyChangedSignal("SelectedObject")
        PropertyChangedSignal:Connect(updateSelectedObject)
        local PropertyChangedSignal_2 = UserInputService:GetPropertyChangedSignal("GamepadEnabled")
        PropertyChangedSignal_2:Connect(function() -- Line: 93 -- upvalues: UserInputService (upval), u4 (ref), u5 (ref), updateSelectedObject (val)
            if not UserInputService.GamepadEnabled then
                u4 = false
                u5 = false
            end
            updateSelectedObject()
        end)
        if UserInputService.GamepadEnabled then end
        updateSelectedObject()
        UserInputService.InputBegan:Connect(function(p1, p2) -- Line: 107 -- upvalues: GuiService (upval), iconsDictionary (val), u16 (upval), u15 (upval), GamepadService (upval)
            if p1.UserInputType == Enum.UserInputType.MouseButton1 then
                local SelectedObject = GuiService.SelectedObject
                local Attribute = SelectedObject
                if Attribute then
                    Attribute = SelectedObject:GetAttribute("CorrespondingIconUID")
                end
                local v1 = Attribute
                if v1 then
                    v1 = iconsDictionary[Attribute]
                end
                if v1 then
                    GuiService.SelectedObject = nil
                end
                return
            end
            if p1.KeyCode ~= u16.highlightKey then
                return
            end
            local v2 = u15.getIconToHighlight()
            if v2 then
                if GamepadService.GamepadCursorEnabled then
                    task.wait(0.2)
                    GamepadService:DisableGamepadCursor()
                end
                local v3 = v2:getInstance("ClickRegion")
                GuiService.SelectedObject = v3
            end
        end)
    end)
end
function u15.getIconToHighlight() -- Line: 134 -- upvalues: u16 (ref)
    local highlightIcon = u16.highlightIcon
    if not highlightIcon then
        highlightIcon = u16.lastHighlightedIcon
    end
    if not highlightIcon then
        local X = nil
        for k, v in pairs(u16.iconsDictionary) do
            if not v.parentIconUID then
                if not X then
                    X = v.widget.AbsolutePosition.X
                elseif v.widget.AbsolutePosition.X >= X then
                end
            end
        end
    end
    return highlightIcon
end
function u15.registerButton(p1) -- Line: 156 -- upvalues: UserInputService (val), GamepadService (val), GuiService (val)
    local u1 = false
    p1.InputBegan:Connect(function(p1) -- Line: 162 -- upvalues: u1 (ref)
        u1 = true
        task.wait()
        task.wait()
        u1 = false
    end)
    local u12 = UserInputService.InputBegan:Connect(function(a1) -- Line: 171 -- upvalues: u1 (ref), GamepadService (upval), GuiService (upval), p1 (val)
        task.wait()
        if a1.KeyCode ~= Enum.KeyCode.ButtonA then
            local v1 = GuiService.SelectedObject == p1
            local v2 = {"ButtonB", "ButtonSelect"}
            local Name = a1.KeyCode.Name
            if table.find(v2, Name) and v1 then
                if Name ~= "ButtonSelect" then
                    GuiService.SelectedObject = nil
                elseif GamepadService.GamepadCursorEnabled then
                    GuiService.SelectedObject = nil
                end
            end
            return
        elseif u1 then
            task.wait(0.2)
            GamepadService:DisableGamepadCursor()
            GuiService.SelectedObject = p1
            return
        end
    end)
    p1.Destroying:Once(function() -- Line: 192 -- upvalues: u12 (val)
        u12:Disconnect()
    end)
end
return u15