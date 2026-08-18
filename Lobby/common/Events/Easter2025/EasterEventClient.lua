local v1 = game.ReplicatedStorage.common.RedEvents
local v2 = require(v1.Events.EggTouched)
local v_u_3 = game:GetService("StarterGui")
local v_u_4 = require("@game/ReplicatedStorage/common/Events/Easter2025/EggData")
local function v_u_11(p5) -- name: eggTouchRegistered
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v6 = v_u_4.EggConfigs[p5].ImageId
	local v7 = tonumber(v6:match("%d+"))
	local v8 = not v7 and "" or ("rbxthumb://type=Asset&id=%d&w=150&h=150"):format(v7)
	local v9 = p5 == "Master" and "the Master Egg" or p5
	local v_u_10 = Instance.new("Sound")
	v_u_10.Parent = game.Workspace
	v_u_10.SoundId = "rbxassetid://1211938342"
	v_u_10.Volume = 1
	v_u_10:Play()
	v_u_10.Ended:Connect(function()
		-- upvalues: (copy) v_u_10
		v_u_10:Destroy()
	end)
	print("Client: Egg touched for chapter " .. v9 .. ". Complete the chapter to claim your badge!")
	v_u_3:SetCore("SendNotification", {
		["Title"] = "Egg Collected!",
		["Text"] = nil,
		["Icon"] = nil,
		["Duration"] = 10,
		["Text"] = "Please complete the chapter to claim your badge and skin for " .. v9,
		["Icon"] = v8
	})
end
v2:SetClientListener(function(p12)
	-- upvalues: (copy) v_u_11
	v_u_11(p12)
end)
return {}