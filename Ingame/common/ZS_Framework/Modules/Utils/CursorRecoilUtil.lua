local v1 = {crosshairRecoil = Vector3.new(0, 0, 0), crosshairRecoilGoal = Vector3.new(0, 0, 0)}
local u3 = 0

function v1.OnShoot(p1, p2) -- Line: 15 -- upvalues: u3 (ref)
    if not p2.Aiming then
        return
    end
    local v1 = p2.Config.CursorHorizontalRecoil or 0.03
    local CursorVerticalRecoil = p2.Config.CursorVerticalRecoil
    local v2 = p1.crosshairRecoilGoal.X + (math.random() - 0.5) * v1
    local v3 = p1.crosshairRecoilGoal.Y + math.random() * (CursorVerticalRecoil or 0.03)
    p1.crosshairRecoilGoal = Vector3.new(v2, v3, 0)
    u3 = workspace:GetServerTimeNow()
end

function v1.Update(p1, p2, p3) -- Line: 29 -- upvalues: u3 (ref)
    local v1, v2
    local v3 = (workspace:GetServerTimeNow()) - u3 < 0.15
    if not v3 or not p3 then
        local crosshairRecoilGoal = p1.crosshairRecoilGoal
        v2 = p2 * 30
        v1 = math.clamp(v2, 0, 1)
        p1.crosshairRecoilGoal = crosshairRecoilGoal:Lerp(Vector3.new(0, 0, 0), v1)
    end
    local X = p1.crosshairRecoilGoal.X
    local v4 = math.clamp(X, -0, 0)
    local Y = p1.crosshairRecoilGoal.Y
    local v5 = math.clamp(Y, 0, 0)
    p1.crosshairRecoilGoal = Vector3.new(v4, v5, 0)
    local crosshairRecoil = p1.crosshairRecoil
    local crosshairRecoilGoal_4 = p1.crosshairRecoilGoal
    v2 = p2 * 30
    v1 = math.clamp(v2, 0, 1)
    p1.crosshairRecoil = crosshairRecoil:Lerp(crosshairRecoilGoal_4, v1)
end

function v1.Reset(p1) -- Line: 48
    p1.crosshairRecoil = Vector3.new(0, 0, 0)
    p1.crosshairRecoilGoal = Vector3.new(0, 0, 0)
end

return v1