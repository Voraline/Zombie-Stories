local UserInputService = game:GetService("UserInputService")
require("./types/fusion")
local u13 = require(script.Parent.utils["lock-value"])
return function(p1, p2) -- Line: 12 -- upvalues: UserInputService (val), u13 (val)
    local peek = p1.peek
    local u9 = p1:Value(UserInputService:GetMouseLocation())
    table.insert(p1, UserInputService.InputBegan:Connect(function(p1) -- Line: 21 -- upvalues: u9 (val), UserInputService (upval)
        local v1 = p1.UserInputType == Enum.UserInputType.MouseMovement
        local v2 = p1.UserInputType == Enum.UserInputType.Touch
        if v1 then
            u9:set(UserInputService:GetMouseLocation())
        elseif v2 then
            u9:set(UserInputService:GetMouseLocation())
        end
    end))
    if p2 then
        local v1 = p1:Observer(u9)
        v1:onBind(function() -- Line: 31 -- upvalues: p2 (val), peek (val), u9 (val)
            p2(peek(u9))
        end)
    end
    return u13(u9)
end