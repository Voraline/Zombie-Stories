local v_u_1 = game:GetService("Players")
local v_u_2 = {
	["AnchorPoint"] = nil,
	["BackgroundColor3"] = nil,
	["BackgroundTransparency"] = 0.05,
	["BorderColor3"] = nil,
	["BorderSizePixel"] = 20,
	["ClearTextOnFocus"] = false,
	["MultiLine"] = true,
	["Position"] = nil,
	["Size"] = nil,
	["Font"] = nil,
	["TextColor3"] = nil,
	["TextWrapped"] = true,
	["TextSize"] = 18,
	["TextXAlignment"] = "Left",
	["TextYAlignment"] = "Top",
	["AutoLocalize"] = false,
	["PlaceholderText"] = "Right click to exit",
	["AnchorPoint"] = Vector2.new(0.5, 0.5),
	["BackgroundColor3"] = Color3.fromRGB(17, 17, 17),
	["BorderColor3"] = Color3.fromRGB(17, 17, 17),
	["Position"] = UDim2.new(0.5, 0, 0.5, 0),
	["Size"] = UDim2.new(0.5, 0, 0.4, 0),
	["Font"] = Enum.Font.Code,
	["TextColor3"] = Color3.fromRGB(241, 241, 241)
}
local v_u_3 = nil
return {
	["Name"] = "edit",
	["Aliases"] = nil,
	["Description"] = "Edit text in a TextBox",
	["Group"] = "DefaultUtil",
	["Args"] = nil,
	["ClientRun"] = nil,
	["Aliases"] = {},
	["Args"] = {
		{
			["Type"] = "string",
			["Name"] = "Input text",
			["Description"] = "The text you wish to edit",
			["Default"] = ""
		},
		{
			["Type"] = "string",
			["Name"] = "Delimiter",
			["Description"] = "The character that separates each line",
			["Default"] = ","
		}
	},
	["ClientRun"] = function(p4, p5, p_u_6) -- name: ClientRun
		-- upvalues: (ref) v_u_3, (copy) v_u_2, (copy) v_u_1
		v_u_3 = v_u_3 or p4.Cmdr.Util.Mutex()
		local v_u_7 = v_u_3()
		p4:Reply("Right-click on the text area to exit.", Color3.fromRGB(158, 158, 158))
		local v_u_8 = Instance.new("ScreenGui")
		v_u_8.Name = "CmdrEditBox"
		v_u_8.ResetOnSpawn = false
		local v_u_9 = Instance.new("TextBox")
		for v10, v11 in pairs(v_u_2) do
			v_u_9[v10] = v11
		end
		v_u_9.Text = p5:gsub(p_u_6, "\n")
		v_u_9.Parent = v_u_8
		v_u_8.Parent = v_u_1.LocalPlayer:WaitForChild("PlayerGui")
		local v_u_12 = coroutine.running()
		v_u_9.InputBegan:Connect(function(p13)
			-- upvalues: (copy) v_u_12, (copy) v_u_9, (copy) p_u_6, (copy) v_u_8, (copy) v_u_7
			if p13.UserInputType == Enum.UserInputType.MouseButton2 then
				coroutine.resume(v_u_12, v_u_9.Text:gsub("\n", p_u_6))
				v_u_8:Destroy()
				v_u_7()
			end
		end)
		return coroutine.yield()
	end
}