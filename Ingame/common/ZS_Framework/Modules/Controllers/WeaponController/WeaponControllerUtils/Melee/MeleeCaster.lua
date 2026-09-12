local v1 = {}

local function lerp(p1, p2, p3) -- Line: 3
    return p1 * (1 - p3) + p2 * p3
end

local CurrentCamera = workspace.CurrentCamera
local RaycastUtil = require((script.Parent.Parent.Parent.Parent.Parent:WaitForChild("Utils")):WaitForChild("RaycastUtil"))
local u22 = require("../../../LocalPlayerController")

function v1.StartCast(p1, p2, p3, p4) -- Line: 10 -- upvalues: u22 (val), CurrentCamera (val), RaycastUtil (val)
    local CFrame_2, Parent, Penetration, Position, StandardCast, num_rays_2, num_times, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14
    local v15 = p2
    local v16 = p2.raysbeforedelay or 4
    local num_rays = p2.num_rays
    if not num_rays then
        num_rays = v16 * 5
    end
    local v17 = p2.delaytime or 0
    local v18 = p2.max_dist or 9
    local v19 = p2.min_dist or 7
    local v20 = p2.direction or 1
    local v21 = (p2.yaw or 70) * v20
    local v22 = (p2.pitch or 0) * v20
    local v23 = p2.num_times or 1
    local multi_data = p2.multi_data
    local v24 = 0
    p4.TimesHitEnemy.IgnoreTable = {}
    local IgnoreTable = p4.TimesHitEnemy.IgnoreTable
    local v25 = 1
    if not p4.DoingHeavy and p4.SwingRPMScaling then
        local HeavyDelayPerShot, HeavySwingEnd, HeavySwingStart
        local Config = p4.Config
        if not p4.DoingHeavy then
            HeavySwingStart = Config.SwingStart
        else
            HeavySwingStart = Config.HeavySwingStart
            if not HeavySwingStart then
                HeavySwingStart = Config.SwingStart
            end
        end
        if not p4.DoingHeavy then
            HeavySwingEnd = Config.SwingEnd
        else
            HeavySwingEnd = Config.HeavySwingEnd
            if not HeavySwingEnd then
                HeavySwingEnd = Config.SwingEnd
            end
        end
        if not p4.DoingHeavy then
            HeavyDelayPerShot = Config.DelayPerShot
        else
            HeavyDelayPerShot = Config.HeavyDelayPerShot
            if not HeavyDelayPerShot then
                HeavyDelayPerShot = Config.DelayPerShot
            end
        end
        if HeavyDelayPerShot ~= 0 then
            v2 = HeavyDelayPerShot
        else
            v2 = 1
        end
        v25 = v2 / (HeavySwingStart + HeavySwingEnd)
    end
    local Head = game.Players.LocalPlayer.Character.Head
    local v26 = v23
    local v27, v28 = p4, p3
    for i = 1, v26 do
        if multi_data then
            v3 = multi_data[i]
            v1 = setmetatable(v3, v15)
            v16 = v1.raysbeforedelay or 4
            num_rays_2 = v1.num_rays
            if not num_rays_2 then
                num_rays_2 = v16 * 5
            end
            num_rays = num_rays_2
            v17 = v1.delaytime or 0
            v18 = v1.max_dist or 9
            v19 = v1.min_dist or 7
            v20 = v1.direction or 1
            v21 = (v1.yaw or 70) * v20
            v22 = (v1.pitch or 0) * v20
            num_times = v1.num_times
        end
        v2 = num_rays
        for j = 1, v2 do
            if not v27 or not v27.IsEquipped then
                break
            end
            v4 = j * math.rad(v21) / num_rays
            v5 = j * math.rad(v22) / num_rays
            v8 = v21 / 2
            v6 = v4 - math.rad(v8)
            v9 = v22 / 2
            v7 = v5 - math.rad(v9)
            v8 = (j - 1) / (num_rays / 2 - 1) * (num_rays - j) / (num_rays - num_rays / 2)
            v9 = v19 * (1 - v8) + v18 * v8
            if not u22.ThirdPerson then
                CFrame_2 = CurrentCamera.CFrame
            else
                CFrame_2 = Head.CFrame
            end
            Position = CFrame_2.Position
            v10 = (CFrame_2 * CFrame.Angles(v7, v6, 0)).LookVector.Unit * v9
            while true do
                StandardCast = RaycastUtil.StandardCast
                if not (0 < #IgnoreTable) then
                    v14 = nil
                else
                    v14 = IgnoreTable
                end
                v11 = StandardCast(Position, v10, v14)
                if not v11 or not string.find(v11.Instance.Name, "HITBOX_ARMOR") then
                    break
                end
                Parent = v11.Instance.Parent
                Penetration = v27.Config.Penetration
                if not ((Parent:GetAttribute("ArmorLevel") or 1) <= Penetration) then
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
                    if not v13 then
                        v13 = BrickColor.new("Really red")
                    end
                end
                v12.BrickColor = v13
                v12.Material = Enum.Material.ForceField
                v12.Size = Vector3.new(0.2, 0.2, v9)
                v12.CFrame = (CFrame.new(Position - Vector3.new(0, 1, 0), Position + v10)) * CFrame.new(0, 0, -v9 / 2)
                game.Debris:AddItem(v12, 3)
                v12.Parent = workspace.Ignore
            end
            if v11 then
                v28:Fire(Position, v11, v27, v12)
            end
            v24 = v24 + 1
            if v16 <= v24 then
                v24 = 0
                task.wait(v17 * v25)
            end
        end
        v27.TimesHitEnemy = {}
        v20 = v20 * -1
        v21 = v21 * v20
        v22 = v22 * v20
    end
end

return v1