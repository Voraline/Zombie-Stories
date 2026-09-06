local v1
local v2 = {Effects = {}}
for i, j in script.Parent.Parent.Effects:GetChildren() do
    if j:IsA("ModuleScript") then
        v1 = require(j)
        v2.Effects[i] = v1
    end
end
return v2