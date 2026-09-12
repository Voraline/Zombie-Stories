local u0 = {
    ActivateType = "Holding",
    AmtUses = 3,
    UseDelay = 30,
    DropPlayer = {},
    DropPlayersUsed = {},
}
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local RedEvents = game.ReplicatedStorage.common.RedEvents
local ProgressionEvent = require(RedEvents.General.ProgressionEvent)
if RunService:IsClient() then
    function u0.Init(p1, p2, p3) -- Line: 16
        return function(p1, p2_2) -- Line: 17 -- upvalues: p2 (val)
            p2("AMMO: " .. p1 .. " [" .. p2_2 .. "]")
        end
    end

    return u0
end
if RunService:IsServer() then
    local function InteractSystemSanity(p1, p2) -- Line: 23
        local Character = p1.Character
        if Character then
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart then
                local Value = p2.MinDist.Value
                if (p2.Position - HumanoidRootPart.Position).Magnitude <= Value and p2.Active.Value == true then
                    return true
                end
            end
        end
        return false
    end

    local u39 = require("@game/ServerStorage/common/ProgressionTracker")
    local u42 = require("@game/ServerStorage/common/WepHandler")

    function u0.SetupDrop(p1, p2, p3) -- Line: 41
        -- upvalues: HttpService (val), CollectionService (val), u0 (val), u42 (val), ProgressionEvent (val), u39 (val)
        local v1 = HttpService:GenerateGUID(false)
        CollectionService:AddTag(p1, "TacticalDrop")
        p1:SetAttribute("TacticalDropId", v1)
        if not p3 then
            p3 = {}
        end
        u0.DropPlayer[p1] = p2
        u0.DropPlayersUsed[p1] = p3
        ;(p1:WaitForChild("Used")).OnServerEvent:connect(function(p1_2) -- Line: 50 -- upvalues: p3 (ref), p1 (val), u42 (upval), p2 (val), ProgressionEvent (upval), u39 (upval)
            if not p3[p1_2] then
                local v1
                local v2 = p1
                local Character = p1_2.Character
                if not Character then
                    v1 = false
                else
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not HumanoidRootPart then
                        v1 = false
                    else
                        local Value = v2.MinDist.Value
                        if not ((v2.Position - HumanoidRootPart.Position).Magnitude <= Value) then
                            v1 = false
                        else
                            v1 = not (v2.Active.Value ~= true)
                        end
                    end
                end
                if v1 and 0 < p1_2.Character.HP.Value then
                    p3[p1_2] = true
                    p1.Ammo:Play()
                    u42:FillAmmo(p1_2)
                    game.ReplicatedStorage.common.Remotes.Net:FireClient(p1_2, "GotAmmo")
                    if p2 ~= p1_2 then
                        v1 = ProgressionEvent
                        local v3 = p2
                        local v4 = {
                            Type = "AddXPItem",
                            Reason = "Resupplied " .. p1_2.Name,
                            Color = Color3.fromRGB(137, 255, 124),
                        }
                        v1:FireClient(v3, v4)
                        v1 = u39
                        v3 = p2
                        v1:UpdateXpItem(v3, "Resupply", false, nil, function(p1, p2) -- Line: 64
                            local v1, v2
                            if p1 then
                                v1 = p1
                            else
                                v1 = 0
                            end
                            if p2 then
                                v2 = p2
                            else
                                v2 = 0
                            end
                            local v3 = v1 + 1
                            return v3, v2 + 10, v3 .. " Resupplies"
                        end)
                    end
                end
            end
        end)
        return v1
    end

    function u0.Activate(p1) -- Line: 82 -- upvalues: u0 (val)
        local v1, v2
        local v3 = nil
        local Character = p1.Character
        if Character then
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart and 0 < p1.Character.HP.Value then
                local Position = HumanoidRootPart.Position
                local v4 = Ray.new(Position, (Vector3.new(0, -1000, 0)))
                v1 = workspace
                local v5 = {workspace.Ignore, Character, workspace.InteractSystem}
                v1, v2 = v1:FindPartOnRayWithIgnoreList(v4, v5)
                if v1 and v2 then
                    v3 = v2
                end
            end
        end
        if v3 then
            local Resources = game:GetService("ServerStorage").SWEP_Resources.Skills.Ammo.Resources
            v3 = v3 + Vector3.new(0, 0.4000000059604645, 0)
            local v6 = Resources.Ammo:Clone()
            v2 = CFrame.new(v3)
            v6:SetPrimaryPartCFrame(v2)
            v6.Parent = workspace.Ignore
            local InteractSystem = workspace.InteractSystem
            v1 = Resources.Use:Clone()
            v1.CFrame = CFrame.new(v3 + Vector3.new(0, 1.5, 0))
            v1.Use.TextLabel.Text = "Take Ammo"
            v1.Active.Value = true
            v1.Parent = InteractSystem
            v1.Drop:Play()
            u0.SetupDrop(v1, p1)
        end
    end
end
return u0