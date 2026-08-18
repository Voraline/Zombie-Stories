local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Packages.Fusion)
local v_u_3 = v2.Children
local v_u_4 = v2.OnEvent
local v_u_5 = v2.peek
return function(p_u_6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_3
	local v7 = p_u_6.scope
	local v_u_8 = p_u_6.Disabled or v7:Value(false)
	local v_u_9 = p_u_6.isHovering or v7:Value(false)
	local v_u_10 = p_u_6.isHeldDown or v7:Value(false)
	return v7:New("TextButton")({
		["Size"] = UDim2.new(1, 0, 1, 0),
		["Position"] = UDim2.new(0.5, 0, 0.5, 0),
		["AnchorPoint"] = Vector2.new(0.5, 0.5),
		["TextTransparency"] = 1,
		["BackgroundTransparency"] = 1,
		[v_u_4("Activated")] = function()
			-- upvalues: (copy) p_u_6, (ref) v_u_5, (copy) v_u_8
			if p_u_6.OnClick ~= nil and not v_u_5(v_u_8) then
				p_u_6.OnClick()
			end
		end,
		[v_u_4("MouseButton1Down")] = function()
			-- upvalues: (copy) v_u_10
			v_u_10:set(true)
		end,
		[v_u_4("MouseButton1Up")] = function()
			-- upvalues: (copy) v_u_10
			v_u_10:set(false)
		end,
		[v_u_4("MouseEnter")] = function()
			-- upvalues: (copy) v_u_9
			v_u_9:set(true)
		end,
		[v_u_4("MouseLeave")] = function()
			-- upvalues: (copy) v_u_10, (copy) v_u_9
			v_u_10:set(false)
			v_u_9:set(false)
		end,
		[v_u_3] = {}
	})
end