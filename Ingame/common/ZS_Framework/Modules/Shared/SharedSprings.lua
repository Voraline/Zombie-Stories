local Utils = script.Parent.Parent:WaitForChild("Utils")
local SpringUtil = require(Utils:WaitForChild("SpringUtil"))
local v1 = {YawSpring = SpringUtil.new(0)}
v1.YawSpring.Target = 0
v1.YawSpring.Speed = 12
v1.YawSpring.Damper = 0.4
v1.SprintSpring = SpringUtil.new(0)
v1.SprintSpring.Target = 0
v1.SprintSpring.Speed = 10
v1.SprintSpring.Damper = 0.7
v1.BlockSpring = SpringUtil.new(0)
v1.BlockSpring.Target = 0
v1.BlockSpring.Speed = 19
v1.BlockSpring.Damper = 0.75
v1.EquipSpring = SpringUtil.new(0)
v1.EquipSpring.Target = 0
v1.EquipSpring.Speed = 12
v1.EquipSpring.Damper = 0.8
v1.TPSpring = SpringUtil.new(0)
v1.TPSpring.Target = 0
v1.TPSpring.Speed = 12
v1.TPSpring.Damper = 0.8
return v1