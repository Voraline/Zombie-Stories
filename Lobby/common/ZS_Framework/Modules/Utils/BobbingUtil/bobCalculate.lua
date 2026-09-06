local Controllers = script.Parent.Parent.Parent:WaitForChild("Controllers")
local LocalPlayerController = require(Controllers:WaitForChild("LocalPlayerController"))
return function(p1) -- Line: 3 -- upvalues: LocalPlayerController (val)
    local v1, v2, v3
    local v4 = LocalPlayerController.PlayerVelocity / 3.0001 * 0.1
    if not p1.BobCycle then
        v1 = Vector3.new()
    else
        v1 = p1.BobCycle(LocalPlayerController.PlayerVelocityDT, v4)
    end
    if not p1.BobCycle2 then
        v2 = CFrame.new()
    else
        v2 = p1.BobCycle2(LocalPlayerController.PlayerVelocityDT, v4)
    end
    if 0.0001 >= v1.magnitude then
        v3 = CFrame.new()
    else
        v3 = CFrame.fromAxisAngle(v1, v1.magnitude / 15)
    end
    v3 = v3 * v2
    if v4 == nil then
        v4 = 0
    elseif tonumber(v4) == v4 then
        v4 = math.min(1, (math.max(v4, 0)))
    else
        v4 = 0
    end
    if v4 <= 0.0001 then
        v3 = CFrame.new()
    end
    return v3
end