local v1 = {}
local v2 = {Players = game:GetService("Players"), ReplicatedStorage = game:GetService("ReplicatedStorage")}
v2.ReplicatedStorage.common:WaitForChild("SharedResources")
local ReplicationTarget = v2.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ReplicationTarget")
local u33 = require("@game/ReplicatedStorage/common/RedEvents/NPC/ChunkReceived"):Client()
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local u43 = nil
local function HandleReplication(p1) -- Line: 23 -- upvalues: u33 (val)
    local Name, ServerTimeNow_2, ThePrimaryPart, v1, v2, v3
    local NumberOfDescendants = p1:WaitForChild("NumberOfDescendants", 30)
    if not NumberOfDescendants then
        warn("[ChunkReceiver] Timed out waiting for NumberOfDescendants on: " .. p1.Name)
        p1:Destroy()
        return
    end
    local Value = NumberOfDescendants.Value
    local ServerTimeNow = workspace:GetServerTimeNow()
    while #p1:GetDescendants() < Value do
        p1.DescendantAdded:Wait()
        v2 = workspace:GetServerTimeNow() - ServerTimeNow
        if 30 < v2 then
            Name = p1.Name
            v3 = #p1:GetDescendants()
            warn("[ChunkReceiver] Timed out waiting for descendants on: " .. Name .. " (got " .. v3 .. "/" .. Value .. ")")
            p1:Destroy()
            return
        end
    end
    local function isJoint(p1) -- Line: 46
        local v1 = p1:IsA("Weld")
        if not v1 then
            v1 = p1:IsA("Motor6D")
        end
        return v1
    end
    for i, j in p1:QueryDescendants("Model") do
        ThePrimaryPart = j:WaitForChild("ThePrimaryPart", 30)
        if not ThePrimaryPart then
            warn("[ChunkReceiver] Timed out waiting for ThePrimaryPart on model: " .. j.Name)
            p1:Destroy()
            return
        end
        j.PrimaryPart = ThePrimaryPart.Value
        ThePrimaryPart:Destroy()
    end
    local v4 = p1
    for k, n in p1:QueryDescendants("Weld, Motor6D") do
        if n.Name ~= "NULL" and n.Name ~= "Grip" then
            if n.Part0 ~= nil and n.Part1 ~= nil then
                continue
            end
            ServerTimeNow_2 = workspace:GetServerTimeNow()
            while true do
                if n.Part1 == nil then
                    task.wait()
                    v1 = workspace:GetServerTimeNow() - ServerTimeNow_2
                    if 30 < v1 then
                        warn("[ChunkReceiver] Timed out waiting for joint parts on: " .. n:GetFullName())
                        v4:Destroy()
                        return
                    end
                elseif n.Part0 ~= nil then
                    break
                end
            end
        end
    end
    local v5 = v4:Clone()
    local ToParent = v5:WaitForChild("ToParent", 30)
    if not ToParent then
        warn("[ChunkReceiver] Timed out waiting for ToParent on clone: " .. v5.Name)
        v5:Destroy()
        return
    end
    local Value_2 = ToParent.Value
    ToParent:Destroy()
    v5.Parent = Value_2
    u33:Fire(v4)
end
function v1.Main() -- Line: 96 -- upvalues: u43 (ref), ReplicationTarget (val), HandleReplication (val)
    if u43 then
        return
    end
    u43 = true
    local Children = ReplicationTarget:GetChildren()
    for k, v in pairs(Children) do
        HandleReplication(v)
    end
    ReplicationTarget.ChildAdded:Connect(HandleReplication)
end
return v1