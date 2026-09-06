local deepCopy
function deepCopy(p1) -- Line: 1 -- upvalues: deepCopy (val)
    local v1 = {}
    for k, v in pairs(p1) do
        if type(v) ~= "table" then
            v1[k] = v
        else
            v1[k] = deepCopy(v)
        end
    end
    return v1
end
return deepCopy