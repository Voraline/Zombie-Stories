local v1 = {}
local TweenService = game:GetService("TweenService")
local u8 = require("./Spring")
function v1.Tween(p1, p2, p3, p4, p5, p6) -- Line: 5 -- upvalues: TweenService (val)
    local v1 = TweenInfo.new(p3, Enum.EasingStyle[p4].Value, Enum.EasingDirection[p5].Value)
    local v2 = TweenService:Create(p2, v1, p6)
    v2:Play()
    v2.Completed:Wait()
    v2:Destroy()
end
function v1.TweenAsync(p1, p2, p3, p4, p5, p6) -- Line: 16 -- upvalues: TweenService (val)
    local v1 = TweenInfo.new(p3, Enum.EasingStyle[p4].Value, Enum.EasingDirection[p5].Value)
    TweenService:Create(p2, v1, p6):Play()
end
function v1.Spring(p1, p2, p3, p4, p5) -- Line: 24 -- upvalues: u8 (val)
    u8.Target(p2, p3, p4, p5)
    task.wait(p3)
    u8.Stop(p2)
end
function v1.SpringAsync(p1, p2, p3, p4, p5) -- Line: 30 -- upvalues: u8 (val)
    u8.Target(p2, p3, p4, p5)
    task.delay(p3, function() -- Line: 32 -- upvalues: u8 (upval), p2 (val)
        u8.Stop(p2)
    end)
end
return v1