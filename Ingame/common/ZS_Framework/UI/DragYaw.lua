local UserInputService = game:GetService("UserInputService")
return {
    bind = function(p1) -- Line: 5 -- upvalues: UserInputService (val)
        local OnChanged
        local v1 = type(p1) == "table"
        assert(v1, "DragYaw.bind requires a config table")
        v1 = type(p1.OnChanged) == "function"
        assert(v1, "DragYaw.bind requires OnChanged")
        local Surface = p1.Surface
        if Surface ~= nil then
            local v2 = if typeof(Surface) == "Instance" then Surface:IsA("GuiObject") else false
            assert(v2, "Surface must be a GuiObject")
        end
        local u39 = tonumber(p1.Sensitivity) or 0.012
        local u43 = tonumber(p1.InitialYaw) or 0
        OnChanged = p1.OnChanged
        local u45 = {}
        local u46 = false
        local u47 = nil
        local u48 = nil
        local u49 = false
        local function beginDrag(p1, p2) -- Line: 23 -- upvalues: Surface (val), u46 (ref), u47 (ref), u48 (ref)
            if Surface then
                if p1.UserInputType == Enum.UserInputType.MouseButton1 then
                    u46 = true
                    u47 = p1
                    u48 = p1.Position
                elseif p1.UserInputType == Enum.UserInputType.Touch then
                    u46 = true
                    u47 = p1
                    u48 = p1.Position
                end
                return
            elseif p2 then
                return
            end
        end
        if not Surface then
            table.insert(u45, UserInputService.InputBegan:Connect(beginDrag))
        else
            table.insert(u45, Surface.InputBegan:Connect(beginDrag))
        end
        table.insert(u45, UserInputService.InputChanged:Connect(function(p1) -- Line: 45 -- upvalues: u46 (ref), u47 (ref), u48 (ref), u43 (ref), u39 (val), OnChanged (val)
            if not u46 then
                return
            end
            if p1 == u47 then
                local Position = p1.Position
                if u48 then
                    u43 = u43 + (Position.X - u48.X) * u39
                    OnChanged(u43)
                end
                u48 = Position
            elseif p1.UserInputType ~= Enum.UserInputType.MouseMovement then
            end
        end))
        table.insert(u45, UserInputService.InputEnded:Connect(function(p1) -- Line: 62 -- upvalues: u47 (ref), u46 (ref), u48 (ref)
            if p1 == u47 then
                u46 = false
                u47 = nil
                u48 = nil
            elseif p1.UserInputType == Enum.UserInputType.MouseButton1 then
                u46 = false
                u47 = nil
                u48 = nil
            elseif p1.UserInputType == Enum.UserInputType.Touch then
                u46 = false
                u47 = nil
                u48 = nil
            end
        end))
        return {
            GetYaw = function(p1) -- Line: 77 -- upvalues: u43 (ref)
                return u43
            end,
            SetYaw = function(p1, p2) -- Line: 81 -- upvalues: u43 (ref), u49 (ref), OnChanged (val)
                u43 = tonumber(p2) or 0
                if not u49 then
                    OnChanged(u43)
                end
            end,
            Destroy = function(p1) -- Line: 88 -- upvalues: u49 (ref), u45 (val), u46 (ref), u47 (ref), u48 (ref)
                if u49 then
                    return
                end
                u49 = true
                for i, v in ipairs(u45) do
                    v:Disconnect()
                end
                table.clear(u45)
                u46 = false
                u47 = nil
                u48 = nil
            end,
        }
    end,
}