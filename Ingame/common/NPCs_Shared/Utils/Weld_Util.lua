return {
    function(p1, p2, p3, p4, p5) -- Line: 1
        local v1 = Instance.new(p3)
        v1.Name = p1.Name .. ":" .. p2.Name
        v1.Part0 = p1
        v1.Part1 = p2
        if not p5 then
            v1.C0 = (v1.Part0.CFrame:Inverse()) * v1.Part1.CFrame
        end
        v1.Parent = p4 or p1
        return v1
    end,
    function(p1, p2, p3) -- Line: 16
        local Weld
        local u102 = {}

        local function addTo(p1) -- Line: 18 -- upvalues: u102 (val), p2 (val)
            if not u102[p1] and p1 ~= p2 then
                p1.Anchored = false
                p1.CanCollide = false
                p1.CanTouch = false
                p1.CanQuery = false
                u102[p1] = true
            end
        end

        local v1 = p3
        for k, v in pairs(p1:GetChildren()) do
            if v:IsA("BasePart") and not u102[v] and v ~= p2 then
                v.Anchored = false
                v.CanCollide = false
                v.CanTouch = false
                v.CanQuery = false
                u102[v] = true
            end
            for k2, i in pairs(v:GetDescendants()) do
                if i:IsA("BasePart") and not u102[i] and not u102[i] and i ~= p2 then
                    i.Anchored = false
                    i.CanCollide = false
                    i.CanTouch = false
                    i.CanQuery = false
                    u102[i] = true
                end
            end
        end
        for k3, j in pairs(u102) do
            Weld = Instance.new("Weld")
            Weld.Name = p2.Name .. ":" .. k3.Name
            Weld.Part0 = p2
            Weld.Part1 = k3
            if not v1 then
                Weld.C0 = (Weld.Part0.CFrame:Inverse()) * Weld.Part1.CFrame
            end
            Weld.Parent = p2 or p2
        end
    end,
}