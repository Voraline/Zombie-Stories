local v1 = {
    HumanoidControlType = {Default = 1, Locked = 2, Forced = 3, ForcedRespectCamera = 4},
    PhysBallType = {Default = 1, Dive = 2},
}
local v2 = {__index = Enum}
return (setmetatable(v1, v2))