local v1, v2, v3
local v4 = {}
for i, j in script:GetChildren() do
    v1 = require(j)
    v2 = nil
    v3 = nil
    for k, n in v1, v2, v3 do
        v4[k] = n
    end
end
for k2, v in pairs(v4) do
    v4[k2].Name = k2
end
return v4