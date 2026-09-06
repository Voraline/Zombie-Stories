return function(p1, p2) -- Line: 1
    local v1 = {}
    v1["-"] = true
    v1["'"] = true
    v1["2"] = true
    v1["."] = true
    v1["7"] = true
    local v2 = p2
    for i, j in p1.Weapon:GetDescendants() do
        if not (j:GetAttribute("uid")) then
            v2:ApplyTexture("rbxassetid://6955212502", {j}, {StudsPerTileU = 0.5, StudsPerTileV = 1})
        elseif v1[j:GetAttribute("uid")] then
            v2:ApplyTexture("rbxassetid://6966685953", {j}, {StudsPerTileU = 0.5, StudsPerTileV = 1})
        end
    end
end