local v_u_1 = game:GetService("UserInputService")
local v_u_2 = require("@game/ReplicatedStorage/common/Settings/Binding")
local v_u_3 = require("@game/ReplicatedStorage/common/InputLabel")
local v4 = require("@game/ReplicatedStorage/common/Signal")
local v_u_5 = {}
local v_u_6 = "MouseKeyboard"
local v34 = {
	["new"] = function(p7, p8, p9) -- name: new
		-- upvalues: (copy) v_u_5
		v_u_5[p7] = {
			["Activate"] = p8,
			["Deactivate"] = p9,
			["Binds"] = {}
		}
	end,
	["bind"] = function(p_u_10, p11, p12, _) -- name: bind
		-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_1
		local v_u_13 = p12 or p11
		local v_u_14 = v_u_5[p11]
		if not v_u_14 then
			error("NO BIND DATA FOR " .. p11)
		end
		local v15 = nil
		local v16
		if v_u_14.Activate then
			local function v20(p17, p18) -- name: onInput
				-- upvalues: (ref) v_u_2, (copy) p_u_10, (copy) v_u_14, (ref) v_u_13
				if not v_u_2.IsBinding then
					local v19 = p17.UserInputType
					if p17.KeyCode == p_u_10 or v19 == p_u_10 then
						v_u_14.Activate(v_u_13, p18, p17)
					end
				end
			end
			if p_u_10 == Enum.UserInputType.MouseWheel then
				v16 = v_u_1.InputChanged:Connect(v20)
			else
				v16 = v_u_1.InputBegan:Connect(v20)
			end
		else
			v16 = nil
		end
		if v_u_14.Deactivate then
			v15 = v_u_1.InputEnded:Connect(function(p21, p22)
				-- upvalues: (ref) v_u_2, (copy) p_u_10, (copy) v_u_14, (ref) v_u_13
				if not v_u_2.IsBinding then
					local v23 = p21.UserInputType
					if p21.KeyCode == p_u_10 or v23 == p_u_10 then
						v_u_14.Deactivate(v_u_13, p22, p21)
					end
				end
			end)
		end
		v_u_14.Binds[p_u_10] = {
			["ActivateConnection"] = v16,
			["DeactivateConnection"] = v15
		}
	end,
	["unbindAction"] = function(p24) -- name: unbindAction
		-- upvalues: (copy) v_u_5
		local v25 = v_u_5[p24]
		if v25 then
			for _, v26 in v25.Binds do
				if v26.ActivateConnection then
					v26.ActivateConnection:Disconnect()
				end
				if v26.DeactivateConnection then
					v26.DeactivateConnection:Disconnect()
				end
			end
		end
	end,
	["unbindActionInput"] = function(p27, p28) -- name: unbindActionInput
		-- upvalues: (copy) v_u_5
		local v29 = v_u_5[p27]
		local v30 = v29 and v29.Binds[p28]
		if v30 then
			if v30.ActivateConnection then
				v30.ActivateConnection:Disconnect()
			end
			if v30.DeactivateConnection then
				v30.DeactivateConnection:Disconnect()
			end
		end
	end,
	["unbindAllActions"] = function() -- name: unbindAllActions
		-- upvalues: (copy) v_u_5
		for _, v31 in pairs(v_u_5) do
			for _, v32 in v31.Binds do
				if v32.ActivateConnection then
					v32.ActivateConnection:Disconnect()
				end
				if v32.DeactivateConnection then
					v32.DeactivateConnection:Disconnect()
				end
			end
			table.clear(v31.Binds)
		end
	end,
	["getActionBinds"] = function(p33) -- name: getActionBinds
		-- upvalues: (copy) v_u_5
		if v_u_5[p33] then
			return v_u_5[p33].Binds
		else
			return nil
		end
	end,
	["getInputMethod"] = function() -- name: getInputMethod
		-- upvalues: (ref) v_u_6
		return v_u_6
	end
}
local v_u_35 = v4.new()
v34.InputMethodChanged = v_u_35
local function v39(p36, _) -- name: updateInputMethod
	-- upvalues: (ref) v_u_6, (copy) v_u_3, (copy) v_u_2, (copy) v_u_35
	local v37 = v_u_6
	local v38 = p36.Value
	if v38 >= 0 and v38 <= 4 or v38 == 8 then
		v_u_6 = "MouseKeyboard"
	elseif v38 == 7 then
		v_u_6 = "Touch"
	elseif v38 >= 12 and v38 <= 19 then
		v_u_6 = "Gamepad"
	end
	if v_u_6 ~= v37 then
		v_u_3.SetInputMethod(v_u_6)
		v_u_2.SetInputMethod(v_u_6)
		v_u_35:Fire(v_u_6)
	end
end
if v_u_1.GamepadEnabled then
	v_u_6 = "Gamepad"
elseif v_u_1.KeyboardEnabled and v_u_1.MouseEnabled then
	v_u_6 = "MouseKeyboard"
else
	v_u_6 = v_u_1.TouchEnabled and "Touch" or v_u_6
end
v_u_3.SetInputMethod(v_u_6)
v_u_2.SetInputMethod(v_u_6)
v_u_35:Fire(v_u_6)
v_u_1.LastInputTypeChanged:Connect(v39)
return v34