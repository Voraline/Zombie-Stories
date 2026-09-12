local TweenService = game:GetService("TweenService")
local u7 = TweenInfo.new(0)
local v1 = {Cache = {}}
local u10 = {"BackgroundTransparency", "ImageTransparency", "TextTransparency", "TextStrokeTransparency"}

local function CreateCache(p1, p2) -- Line: 38 -- upvalues: u10 (val)
    local v1 = {}
    local v2 = next
    local v3 = u10
    local v4 = nil
    for k, v in v2, v3, v4 do
        if pcall(function() -- Line: 42 -- upvalues: p1 (val), v (val)
            return p1[v]
        end) then
            v1[v] = p1[v]
        end
    end
    p2[p1] = v1
end

local function Set(p1, p2, p3) -- Line: 50 -- upvalues: TweenService (val), u7 (val)
    local v1, v2, v3, v4, v5
    local v6 = next
    local v7 = p1
    local v8 = nil
    for k, v in v6, v7, v8 do
        v4 = {}
        v5 = next
        v1 = v
        v2 = nil
        for k2, i in v5, v1, v2 do
            v4[k2] = i + (1 - i) * v9
        end
        v5 = TweenService
        v3 = v10
        if not v3 then
            v3 = u7
        end
        local u38 = v5:Create(k, v3, v4)
        u38:Play()
        u38.Completed:Connect(function() -- Line: 59 -- upvalues: u38 (val)
            u38:Destroy()
        end)
    end
end

function v1.Revert(p1, p2, p3) -- Line: 66 -- upvalues: Set (val)
    local v1 = p1.Cache[p2]
    if v1 then
        Set(v1, 0, p3)
    end
end

function v1.SetTransparency(p1, p2, p3, p4) -- Line: 74 -- upvalues: CreateCache (val), Set (val)
    local v1 = p1.Cache[p2]
    if not v1 then
        v1 = {}
        CreateCache(p2, v1)
        local v2 = next
        local Descendants, Descendants_2 = p2:GetDescendants()
        for k, v in v2, Descendants, Descendants_2 do
            CreateCache(v, v1)
        end
        p1.Cache[p2] = v1
    end
    Set(v1, p3, p4)
end

return v1