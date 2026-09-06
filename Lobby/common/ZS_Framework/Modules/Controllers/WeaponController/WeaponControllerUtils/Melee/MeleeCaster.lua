local v1 = {}
local function lerp(p1, p2, p3) -- Line: 3
    return p1 * (1 - p3) + p2 * p3
end
local CurrentCamera = workspace.CurrentCamera
local Utils = script.Parent.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local RaycastUtil = require(Utils:WaitForChild("RaycastUtil"))
local u22 = require("../../../LocalPlayerController")
function v1.StartCast(p1, p2, p3, p4) -- Line: 10 -- upvalues: u22 (val), CurrentCamera (val), RaycastUtil (val)
    local CFrame, Config, Parent, Position, num_rays_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15
    local v16 = p2
    local v17 = p2.raysbeforedelay or 4
    local num_rays = p2.num_rays
    if not num_rays then
        num_rays = v17 * 5
    end
    local v18 = p2.delaytime or 0
    local v19 = p2.max_dist or 9
    local v20 = p2.min_dist or 7
    local v21 = p2.direction or 1
    local v22 = (p2.yaw or 70) * v21
    local v23 = (p2.pitch or 0) * v21
    local v24 = p2.num_times or 1
    local multi_data = p2.multi_data
    local v25 = 0
    p4.TimesHitEnemy.IgnoreTable = {}
    local IgnoreTable = p4.TimesHitEnemy.IgnoreTable
    local v26 = {}
    local v27 = 1
    if not p4.DoingHeavy and p4.SwingRPMScaling then
        local HeavyDelayPerShot, HeavySwingEnd, HeavySwingStart
        Config = p4.Config
        if not p4.DoingHeavy then
            HeavySwingStart = Config.SwingStart
        else
            HeavySwingStart = Config.HeavySwingStart
        end
        if not p4.DoingHeavy then
            HeavySwingEnd = Config.SwingEnd
        else
            HeavySwingEnd = Config.HeavySwingEnd
        end
        if not p4.DoingHeavy then
            HeavyDelayPerShot = Config.DelayPerShot
        else
            HeavyDelayPerShot = Config.HeavyDelayPerShot
        end
        if HeavyDelayPerShot ~= 0 then
            v3 = HeavyDelayPerShot
        else
            v3 = 1
        end
        v27 = v3 / (HeavySwingStart + HeavySwingEnd)
    end
    local Head = game.Players.LocalPlayer.Character.Head
    local v28 = v24
    local v29 = 1
    v7, v2 = p4, p3
    for i = 1, v28, v29 do
        if multi_data then
            v1 = setmetatable(multi_data[i], v16)
            v17 = v1.raysbeforedelay or 4
            num_rays_2 = v1.num_rays
            if not num_rays_2 then
                num_rays_2 = v17 * 5
            end
            num_rays = num_rays_2
            v18 = v1.delaytime or 0
            v19 = v1.max_dist or 9
            v20 = v1.min_dist or 7
            v21 = v1.direction or 1
            v22 = (v1.yaw or 70) * v21
            v23 = (v1.pitch or 0) * v21
            v24 = v1.num_times or 1
        end
        v3 = num_rays
        v4 = 1
        for j = 1, v3, v4 do
            if not v7 or not v7.IsEquipped then
                break
            end
            v5 = j * math.rad(v22) / num_rays
            v6 = j * math.rad(v23) / num_rays
            v8 = (j - 1) / (num_rays / 2 - 1) * (num_rays - j) / (num_rays - num_rays / 2)
            v9 = v20 * (1 - v8) + v19 * v8
            if not u22.ThirdPerson then
                CFrame = CurrentCamera.CFrame
            else
                CFrame = Head.CFrame
            end
            Position = CFrame.Position
            v10 = (CFrame * CFrame.Angles(v6 - math.rad(v23 / 2), v5 - math.rad(v22 / 2), 0)).LookVector.Unit * v9
            while true do
                if 0 >= #IgnoreTable then
                    v15 = nil
                else
                    v15 = IgnoreTable
                end
                v11 = RaycastUtil.StandardCast(Position, v10, v15)
                if not v11 or not (string.find(v11.Instance.Name, "HITBOX_ARMOR")) then
                    break
                end
                Parent = v11.Instance.Parent
                if Parent:GetAttribute("ArmorLevel") or 1 > v7.Config.Penetration then
                    break
                end
                table.insert(IgnoreTable, Parent)
            end
            v12 = nil
            if workspace:GetAttribute("DebugMelee") then
                v12 = Instance.new("Part")
                v12.Anchored = true
                v12.CanCollide = false
                v12.CanQuery = false
                v12.CastShadow = false
                if v11 then
                    v13 = BrickColor.new("Really red")
                else
                    v13 = BrickColor.new("New Yeller")
                end
                v12.BrickColor = v13
                v12.Material = Enum.Material.ForceField
                v12.Size = Vector3.new(0.2, 0.2, v9)
                v15 = Position - Vector3.new(0, 1, 0)
                v14 = CFrame.new(v15, Position + v10)
                v12.CFrame = v14 * CFrame.new(0, 0, -v9 / 2)
                game.Debris:AddItem(v12, 3)
                v12.Parent = workspace.Ignore
            end
            if v11 then
                v2:Fire(Position, v11, v7, v12)
            end
            v25 = v25 + 1
            if v17 <= v25 then
                v25 = 0
                task.wait(v18 * v27)
            end
        end
        v7.TimesHitEnemy = {}
        v21 = v21 * -1
        v22 = v22 * v21
        v23 = v23 * v21
    end
end
return v1