local u0 = {ActivateType = "Holding", AmtUses = 3, UseDelay = 30, DropPlayer = {}}
local v1 = {}
u0.DropPlayersUsed = v1
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local HttpService = game:GetService("HttpService")
local ProgressionEvent = require(game.ReplicatedStorage.common.RedEvents.General.ProgressionEvent)
if RunService:IsClient() then
    function u0.Init(p1, p2, p3) -- Line: 16
        return function(p1, a2) -- Line: 17 -- upvalues: p2 (val)
            p2("MEDKIT: " .. p1 .. " [" .. a2 .. "]")
        end
    end
    return u0
end
if RunService:IsServer() then
    local function InteractSystemSanity(p1, p2) -- Line: 23
        local Character = p1.Character
        if not Character then
            return false
        end
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if not HumanoidRootPart or (p2.Position - HumanoidRootPart.Position).Magnitude > p2.MinDist.Value then
            return false
        end
        if p2.Active.Value == true then
            return true
        end
        return false
    end
    local u39 = require("@game/ServerStorage/common/ProgressionTracker")
    function u0.SetupDrop(p1, p2, p3) -- Line: 40 -- upvalues: HttpService (val), CollectionService (val), u0 (val), ProgressionEvent (val), u39 (val)
        local u19
        local v1 = HttpService:GenerateGUID(false)
        CollectionService:AddTag(p1, "TacticalDrop")
        p1:SetAttribute("TacticalDropId", v1)
        if not p3 then
            u19 = {}
        else
            u19 = p3
        end
        u0.DropPlayer[p1] = p2
        u0.DropPlayersUsed[p1] = u19
        p1.Used.OnServerEvent:connect(function(a1) -- Line: 50 -- upvalues: u19 (ref), p1 (val), p2 (val), ProgressionEvent (upval), u39 (upval)
            if not (u19[a1]) then
                local v1
                local v2 = p1
                local Character = a1.Character
                if not Character then
                    v1 = false
                else
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if not HumanoidRootPart then
                        v1 = false
                    elseif (v2.Position - HumanoidRootPart.Position).Magnitude > v2.MinDist.Value then
                        v1 = false
                    else
                        v1 = not (v2.Active.Value ~= true)
                    end
                end
                if v1 and 0 < a1.Character.HP.Value then
                    u19[a1] = true
                    p1.Heal:Play()
                    a1.Character.HP.Value = a1.Character.MaxHP.Value
                    game.ReplicatedStorage.common.Remotes.Net:FireClient(a1, "UsedMedkit")
                    if p2 ~= a1 then
                        ProgressionEvent:FireClient(p2, {Type = "AddXPItem", Reason = "Healed " .. a1.Name, Color = Color3.fromRGB(137, 255, 124)})
                        u39:UpdateXpItem(p2, "Heal", false, nil, function(p1, p2) -- Line: 64
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
                            return v3, v2 + 10, v3 .. " Heals"
                        end)
                    end
                end
            end
        end)
        return v1
    end
    function u0.Activate(p1) -- Line: 82 -- upvalues: u0 (val)
        local v1
        local v2 = nil
        local Character = p1.Character
        if Character then
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart and 0 < p1.Character.HP.Value then
                local v3
                local v4 = Ray.new(HumanoidRootPart.Position, (Vector3.new(0, -1000, 0)))
                v1, v3 = workspace:FindPartOnRayWithIgnoreList(v4, {workspace.Ignore, Character, workspace.InteractSystem})
                if v1 and v3 then
                    v2 = v3
                end
            end
        end
        if v2 then
            local Resources = game:GetService("ServerStorage").SWEP_Resources.Skills.Medkit.Resources
            v2 = v2 + Vector3.new(0, 0.4000000059604645, 0)
            local v5 = Resources.Medkit:Clone()
            v5:SetPrimaryPartCFrame(CFrame.new(v2))
            v5.Parent = workspace.Ignore
            v1 = Resources.Use:Clone()
            v1.CFrame = CFrame.new(v2 + Vector3.new(0, 0.4000000059604645, 0))
            v1.Active.Value = true
            v1.Parent = workspace.InteractSystem
            v1.Drop:Play()
            u0.SetupDrop(v1, p1)
        end
    end
end
return u0