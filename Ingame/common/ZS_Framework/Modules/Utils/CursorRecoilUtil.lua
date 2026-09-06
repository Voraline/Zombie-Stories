local v1 = {crosshairRecoil = Vector3.new(0, 0, 0), crosshairRecoilGoal = Vector3.new(0, 0, 0)}
local u3 = 0
function v1.OnShoot(p1, p2) -- Line: 15 -- upvalues: u3 (ref)
    if not p2.Aiming then
        return
    end
    local v1 = p1.crosshairRecoilGoal.X + (math.random() - 0.5) * (p2.Config.CursorHorizontalRecoil or 0.03)
    local v2 = p1.crosshairRecoilGoal.Y + math.random() * (p2.Config.CursorVerticalRecoil or 0.03)
    p1.crosshairRecoilGoal = Vector3.new(v1, v2, 0)
    u3 = workspace:GetServerTimeNow()
end
function v1.Update(p1, p2, p3) -- Line: 29 -- upvalues: u3 (ref)
    local ServerTimeNow = workspace:GetServerTimeNow()
    local v1 = ServerTimeNow - u3
    local v2 = v1 < 0.15
    if not v2 then
        p1.crosshairRecoilGoal = p1.crosshairRecoilGoal:Lerp(Vector3.new(0, 0, 0), (math.clamp(p2 * 30, 0, 1)))
    elseif not p3 then
        p1.crosshairRecoilGoal = p1.crosshairRecoilGoal:Lerp(Vector3.new(0, 0, 0), (math.clamp(p2 * 30, 0, 1)))
    end
    local v3 = math.clamp(p1.crosshairRecoilGoal.X, -0, 0)
    local v4 = math.clamp(p1.crosshairRecoilGoal.Y, 0, 0)
    p1.crosshairRecoilGoal = Vector3.new(v3, v4, 0)
    p1.crosshairRecoil = p1.crosshairRecoil:Lerp(p1.crosshairRecoilGoal, (math.clamp(p2 * 30, 0, 1)))
end
function v1.Reset(p1) -- Line: 48
    p1.crosshairRecoil = Vector3.new(0, 0, 0)
    p1.crosshairRecoilGoal = Vector3.new(0, 0, 0)
end
return v1