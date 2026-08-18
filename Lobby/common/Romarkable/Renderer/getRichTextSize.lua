local v1 = Instance.new("ScreenGui")
v1.Enabled = false
v1.Name = "RichText_Sizing"
local v_u_2 = Instance.new("TextLabel")
v_u_2.TextWrapped = true
v_u_2.RichText = true
v_u_2.Parent = v1
v1.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
return function(p3, p4, p5, p6)
	-- upvalues: (copy) v_u_2
	if type(p3) ~= "string" then
		return Vector2.new(0, 0)
	end
	v_u_2.Text = p3
	v_u_2.TextSize = p4
	v_u_2.Font = p5
	v_u_2.Size = UDim2.new(0, p6.X, 0, p6.Y)
	return v_u_2.TextBounds
end