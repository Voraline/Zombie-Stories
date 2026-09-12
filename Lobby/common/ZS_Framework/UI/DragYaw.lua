local UserInputService = game:GetService("UserInputService")
return {
    bind = function(p1) -- Line: 5 -- upvalues: UserInputService (val)
        local v1
        local v2 = type(p1) == "table"
        assert(v2, "DragYaw.bind requires a config table")
        local OnChanged_2 = p1.OnChanged
        v2 = type(OnChanged_2) == "function"
        assert(v2, "DragYaw.bind requires OnChanged")
        local Surface = p1.Surface
        if Surface ~= nil then
            local v3 = false
            if typeof(Surface) == "Instance" then
                v3 = Surface:IsA("GuiObject")
            end
            assert(v3, "Surface must be a GuiObject")
        end
        local Sensitivity = p1.Sensitivity
        local u39 = tonumber(Sensitivity) or 0.012
        local InitialYaw = p1.InitialYaw
        local u43 = tonumber(InitialYaw) or 0
        local OnChanged = p1.OnChanged
        local u45 = {}
        local u46 = false
        local u47 = nil
        local u48 = nil
        local u49 = false

        local function beginDrag(p1, p2) -- Line: 23 -- upvalues: Surface (val), u46 (ref), u47 (ref), u48 (ref)
            if not Surface and p2 then
                return
            end
            if p1.UserInputType == Enum.UserInputType.MouseButton1
                or p1.UserInputType == Enum.UserInputType.Touch then
                u46 = true
                u47 = p1
                u48 = p1.Position
            end
        end

        if not Surface then
            v1 = UserInputService.InputBegan:Connect(beginDrag)
            table.insert(u45, v1)
        else
            v1 = Surface.InputBegan:Connect(beginDrag)
            table.insert(u45, v1)
        end
        v1 = UserInputService
        v1 = v1.InputChanged:Connect(function(p1) -- Line: 45 -- upvalues: u46 (ref), u47 (ref), u48 (ref), u43 (ref), u39 (val), OnChanged (val)
            if not u46 then
                return
            end
            if p1 == u47 or p1.UserInputType == Enum.UserInputType.MouseMovement then
                local Position = p1.Position
                if u48 then
                    local v1 = u43
                    u43 = v1 + (Position.X - u48.X) * u39
                    OnChanged(u43)
                end
                u48 = Position
            end
        end)
        table.insert(u45, v1)
        v1 = UserInputService
        v1 = v1.InputEnded:Connect(function(p1) -- Line: 62 -- upvalues: u47 (ref), u46 (ref), u48 (ref)
            if p1 == u47
                or p1.UserInputType == Enum.UserInputType.MouseButton1
                or p1.UserInputType == Enum.UserInputType.Touch then
                u46 = false
                u47 = nil
                u48 = nil
            end
        end)
        table.insert(u45, v1)
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