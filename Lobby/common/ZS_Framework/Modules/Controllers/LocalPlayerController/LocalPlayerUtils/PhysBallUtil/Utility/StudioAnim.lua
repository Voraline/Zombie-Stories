game:GetService("RunService")
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")
local function convert(p1) -- Line: 11 -- upvalues: KeyframeSequenceProvider (val)
    local KeyframeSequence = p1:FindFirstChildWhichIsA("KeyframeSequence")
    if KeyframeSequence then
        p1.AnimationId = KeyframeSequenceProvider:RegisterKeyframeSequence(KeyframeSequence)
    end
end
return function(p1) -- Line: 18 -- upvalues: KeyframeSequenceProvider (val)
    local Children, Children_2, KeyframeSequence
    local v1 = next
    Children, Children_2 = p1:GetChildren()
    for k, v in v1, Children, Children_2 do
        KeyframeSequence = v:FindFirstChildWhichIsA("KeyframeSequence")
        if KeyframeSequence then
            v.AnimationId = KeyframeSequenceProvider:RegisterKeyframeSequence(KeyframeSequence)
        end
    end
end