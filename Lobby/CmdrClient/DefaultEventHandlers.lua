local StarterGui = game:GetService("StarterGui")
local u7 = require("./CmdrInterface/Window")
return function(p1) -- Line: 4 -- upvalues: StarterGui (val), u7 (val)
    p1:HandleEvent("Message", function(p1) -- Line: 5 -- upvalues: StarterGui (upval)
        local v1 = StarterGui
        local v2 = {Text = ("[Announcement] %s"):format(p1), Color = Color3.fromRGB(249, 217, 56)}
        v1:SetCore("ChatMakeSystemMessage", v2)
    end)
    p1:HandleEvent("AddLine", function(...) -- Line: 12 -- upvalues: u7 (upval)
        u7:AddLine(...)
    end)
end