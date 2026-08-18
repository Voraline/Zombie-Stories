local v1 = script.Parent.Parent:WaitForChild("Utils")
local v2 = require(v1:WaitForChild("SpringUtil"))
local v3 = {
	["YawSpring"] = v2.new(0)
}
v3.YawSpring.Target = 0
v3.YawSpring.Speed = 12
v3.YawSpring.Damper = 0.4
v3.SprintSpring = v2.new(0)
v3.SprintSpring.Target = 0
v3.SprintSpring.Speed = 10
v3.SprintSpring.Damper = 0.7
v3.BlockSpring = v2.new(0)
v3.BlockSpring.Target = 0
v3.BlockSpring.Speed = 19
v3.BlockSpring.Damper = 0.75
v3.EquipSpring = v2.new(0)
v3.EquipSpring.Target = 0
v3.EquipSpring.Speed = 12
v3.EquipSpring.Damper = 0.8
v3.TPSpring = v2.new(0)
v3.TPSpring.Target = 0
v3.TPSpring.Speed = 12
v3.TPSpring.Damper = 0.8
return v3