local UserInputService = game:GetService("UserInputService")
require("./types/fusion")
local u13 = require(script.Parent.utils["lock-value"])
return function(p1, p2) -- Line: 12 -- upvalues: UserInputService (val), u13 (val)
    local peek = p1.peek
    local MouseLocation = UserInputService:GetMouseLocation()
    local u9 = p1:Value(MouseLocation)
    local v1 = UserInputService
    v1 = v1.InputBegan:Connect(function(p1) -- Line: 21 -- upvalues: u9 (val), UserInputService (upval)
        local v1 = p1.UserInputType == Enum.UserInputType.MouseMovement
        local v2 = p1.UserInputType == Enum.UserInputType.Touch
        if v1 or v2 then
            local v3 = u9
            local MouseLocation = UserInputService:GetMouseLocation()
            v3:set(MouseLocation)
        end
    end)
    table.insert(p1, v1)
    if p2 then
        (p1:Observer(u9)):onBind(function() -- Line: 31 -- upvalues: p2 (val), peek (val), u9 (val)
            p2(peek(u9))
        end)
    end
    return u13(u9)
end