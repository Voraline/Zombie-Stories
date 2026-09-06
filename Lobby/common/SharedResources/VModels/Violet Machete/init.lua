return function(p1) -- Line: 1
    for i, j in p1:GetDescendants() do
        if j:IsA("MeshPart") then
            j.TextureID = "rbxassetid://4966467607"
        end
    end
end