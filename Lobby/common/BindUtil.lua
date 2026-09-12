local UserInputService = game:GetService("UserInputService")
local u7 = require("@game/ReplicatedStorage/common/Settings/Binding")
local u10 = require("@game/ReplicatedStorage/common/InputLabel")
local v1 = require("@game/ReplicatedStorage/common/Signal")
local u14 = {}
local u34 = "MouseKeyboard"
local v2 = {}

function v2.new(p1, p2, p3) -- Line: 44 -- upvalues: u14 (val)
    local v1 = u14
    v1[p1] = {Activate = p2, Deactivate = p3, Binds = {}}
end

function v2.bind(p1, p2, p3, p4) -- Line: 58 -- upvalues: u14 (val), u7 (val), UserInputService (val)
    local u4 = p3 or p2
    local u6 = u14[p2]
    if not u6 then
        error("NO BIND DATA FOR " .. p2)
    end
    local v1 = nil
    local v2 = nil
    if u6.Activate then
        local function onInput(p1_2, p2) -- Line: 73 -- upvalues: u7 (upval), p1 (val), u6 (val), u4 (ref)
            if not u7.IsBinding then
                local UserInputType = p1_2.UserInputType
                if p1_2.KeyCode == p1 or UserInputType == p1 then
                    u6.Activate(u4, p2, p1_2)
                end
            end
        end

        if p1 ~= Enum.UserInputType.MouseWheel then
            v1 = UserInputService.InputBegan:Connect(onInput)
        else
            v1 = UserInputService.InputChanged:Connect(onInput)
        end
    end
    if u6.Deactivate then
        local v3 = UserInputService
        v2 = v3.InputEnded:Connect(function(p1_2, p2) -- Line: 97 -- upvalues: u7 (upval), p1 (val), u6 (val), u4 (ref)
            if not u7.IsBinding then
                local UserInputType = p1_2.UserInputType
                if p1_2.KeyCode == p1 or UserInputType == p1 then
                    u6.Deactivate(u4, p2, p1_2)
                end
            end
        end)
    end
    local Binds = u6.Binds
    Binds[p1] = {ActivateConnection = v1, DeactivateConnection = v2}
end

function v2.unbindAction(p1) -- Line: 120 -- upvalues: u14 (val)
    local v1 = u14[p1]
    if v1 then
        local Binds = v1.Binds
        local v2 = nil
        local v3 = nil
        for i, j in Binds, v2, v3 do
            if j.ActivateConnection then
                j.ActivateConnection:Disconnect()
            end
            if j.DeactivateConnection then
                j.DeactivateConnection:Disconnect()
            end
        end
    end
end

function v2.unbindActionInput(p1, p2) -- Line: 135 -- upvalues: u14 (val)
    local v1 = u14[p1]
    if v1 then
        local v2 = v1.Binds[p2]
        if v2 then
            if v2.ActivateConnection then
                v2.ActivateConnection:Disconnect()
            end
            if v2.DeactivateConnection then
                v2.DeactivateConnection:Disconnect()
            end
        end
    end
end

function v2.unbindAllActions() -- Line: 151 -- upvalues: u14 (val)
    local Binds, v1, v2
    for k, v in pairs(u14) do
        Binds = v.Binds
        v1 = nil
        v2 = nil
        for i, j in Binds, v1, v2 do
            if j.ActivateConnection then
                j.ActivateConnection:Disconnect()
            end
            if j.DeactivateConnection then
                j.DeactivateConnection:Disconnect()
            end
        end
        table.clear(v.Binds)
    end
end

function v2.getActionBinds(p1) -- Line: 166 -- upvalues: u14 (val)
    if u14[p1] then
        return u14[p1].Binds
    end
    return nil
end

function v2.getInputMethod() -- Line: 174 -- upvalues: u34 (ref)
    return u34
end

local u25 = v1.new()
v2.InputMethodChanged = u25

local function updateInputMethod(p1, p2) -- Line: 182 -- upvalues: u34 (ref), u10 (val), u7 (val), u25 (val)
    local v1 = u34
    local Value = p1.Value
    if not (0 <= Value) then
        if Value == 8 then
            u34 = "MouseKeyboard"
        elseif Value == 7 then
            u34 = "Touch"
        elseif 12 <= Value and Value <= 19 then
            u34 = "Gamepad"
        end
    elseif Value <= 4 or Value == 8 then
        u34 = "MouseKeyboard"
    elseif Value == 7 then
        u34 = "Touch"
    elseif 12 <= Value and Value <= 19 then
        u34 = "Gamepad"
    end
    if u34 ~= v1 then
        u10.SetInputMethod(u34)
        u7.SetInputMethod(u34)
        local v2 = u25
        local v3 = u34
        v2:Fire(v3)
    end
end

if UserInputService.GamepadEnabled then
    u34 = "Gamepad"
elseif not UserInputService.KeyboardEnabled then
    if UserInputService.TouchEnabled then
        u34 = "Touch"
    end
elseif UserInputService.MouseEnabled then
    u34 = "MouseKeyboard"
elseif UserInputService.TouchEnabled then
    u34 = "Touch"
end
u10.SetInputMethod(u34)
u7.SetInputMethod(u34)
local v3 = u34
u25:Fire(v3)
UserInputService.LastInputTypeChanged:Connect(updateInputMethod)
return v2