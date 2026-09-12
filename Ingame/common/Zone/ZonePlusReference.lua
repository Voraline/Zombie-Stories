local ReplicatedStorage = game:GetService("ReplicatedStorage")
return {
    addToReplicatedStorage = function() -- Line: 9 -- upvalues: ReplicatedStorage (val)
        local v1
        local v2 = ReplicatedStorage
        local Name = script.Name
        if v2:FindFirstChild(Name) then
            return false
        end
        local ObjectValue = Instance.new("ObjectValue")
        ObjectValue.Name = script.Name
        ObjectValue.Value = script.Parent
        ObjectValue.Parent = ReplicatedStorage
        local BoolValue = Instance.new("BoolValue")
        if not game:GetService("RunService"):IsClient() then
            v1 = "Server"
        else
            v1 = "Client"
        end
        BoolValue.Name = v1
        BoolValue.Value = true
        BoolValue.Parent = ObjectValue
        return ObjectValue
    end,
    getObject = function() -- Line: 25 -- upvalues: ReplicatedStorage (val)
        local v1 = ReplicatedStorage
        local Name = script.Name
        v1 = v1:FindFirstChild(Name)
        if v1 then
            return v1
        end
        return false
    end,
}