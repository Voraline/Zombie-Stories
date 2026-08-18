local v1 = game:GetService("UserInputService")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game.Players.LocalPlayer
local v_u_4 = v_u_3.Character
local v5 = script.Parent.Parent.Parent.Parent:WaitForChild("Utils")
local v_u_6 = Vector3.new
local v_u_7 = Instance.new("BindableEvent")
local v_u_8
if v_u_4 then
	v_u_8 = v_u_4:WaitForChild("Humanoid")
else
	v_u_8 = nil
end
v_u_3.CharacterAdded:Connect(function(p9)
	-- upvalues: (ref) v_u_4, (ref) v_u_8
	v_u_4 = p9
	v_u_8 = p9:WaitForChild("Humanoid")
end)
v_u_3.CharacterRemoving:Connect(function()
	-- upvalues: (ref) v_u_4, (ref) v_u_8
	v_u_4 = nil
	v_u_8 = nil
end)
local v_u_10 = nil
local v_u_11 = false
local v_u_12 = v_u_6()
local v_u_13 = 0
local v_u_14 = false
local _ = {
	{
		["KeyCode"] = nil,
		["Direction"] = Vector3.new(-0, -0, -1),
		["KeyCode"] = Enum.KeyCode.W
	},
	{
		["KeyCode"] = nil,
		["Direction"] = Vector3.new(-1, -0, -0),
		["KeyCode"] = Enum.KeyCode.A
	},
	{
		["KeyCode"] = nil,
		["Direction"] = Vector3.new(0, 0, 1),
		["KeyCode"] = Enum.KeyCode.S
	},
	{
		["KeyCode"] = nil,
		["Direction"] = Vector3.new(1, 0, 0),
		["KeyCode"] = Enum.KeyCode.D
	}
}
local v_u_15 = require(v_u_3:WaitForChild("PlayerScripts"):WaitForChild("ControlScript"):WaitForChild("MasterControl"))
local v_u_16 = {
	["Direction"] = require(v5:WaitForChild("SpringUtil")).new((v_u_6()))
}
v_u_16.Direction.Speed = 16
v_u_16.MoveVector = Vector3.new()
v_u_16.ShuffleEvent = v_u_7.Event
v_u_16.Diving = false
function v_u_16.Init(_) -- name: Init
	-- upvalues: (ref) v_u_10, (copy) v_u_2, (copy) v_u_16
	v_u_10 = require(script.Parent.Parent)
	v_u_2:BindToRenderStep("movement", Enum.RenderPriority.Input.Value, function()
		-- upvalues: (ref) v_u_16
		v_u_16:Update()
	end)
end
function v_u_16.Update(_) -- name: Update
	-- upvalues: (copy) v_u_16, (copy) v_u_15, (ref) v_u_10, (ref) v_u_12, (copy) v_u_6, (ref) v_u_11, (copy) v_u_7, (ref) v_u_4, (copy) v_u_3
	v_u_16.Direction.Target = v_u_15:GetMoveVector() + (v_u_10.AutoRun and Vector3.new(-0, -0, -1) or Vector3.new())
	if v_u_10.humanoid.HasLanded ~= true and v_u_16.MoveVector.Magnitude <= 0 then
		v_u_12 = v_u_6()
	end
	if v_u_16.Direction.Target.Magnitude <= 0.01 and v_u_11 then
		v_u_11 = false
		v_u_7:Fire()
	elseif v_u_16.Direction.Target.Magnitude > 0.01 and not v_u_11 then
		v_u_11 = true
	end
	if v_u_4 then
		if v_u_10.MovementEnabled then
			if v_u_16.Direction.Position.Magnitude > 0.001 and not v_u_16.Diving then
				v_u_3:Move(v_u_16.Direction.Position, true)
				v_u_12 = v_u_16.Direction.Position
				v_u_16.MoveVector = v_u_12
				return
			end
			if v_u_16.Diving then
				v_u_16.MoveVector = v_u_12
				return
			end
		else
			v_u_3:Move(v_u_6(), true)
		end
	end
end
v1.InputBegan:Connect(function(p17, p18)
	-- upvalues: (ref) v_u_8, (ref) v_u_14, (ref) v_u_13
	if not p18 and (p17.UserInputType == Enum.UserInputType.Keyboard and (v_u_8 and p17.KeyCode == Enum.KeyCode.Space)) then
		v_u_14 = true
		if os.clock() - v_u_13 >= 1.4 then
			v_u_8.Jump = true
			v_u_13 = os.clock()
		end
	end
end)
v1.InputEnded:Connect(function(p19, _)
	-- upvalues: (ref) v_u_14
	if p19.UserInputType == Enum.UserInputType.Keyboard and p19.KeyCode == Enum.KeyCode.Space then
		v_u_14 = false
	end
end)
return v_u_16