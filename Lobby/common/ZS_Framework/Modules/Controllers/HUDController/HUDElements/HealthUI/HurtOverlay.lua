local v_u_1 = game.Players.LocalPlayer
local v_u_2 = v_u_1:WaitForChild("PlayerGui")
local v_u_3 = {}
local v_u_4 = script.Parent:WaitForChild("Overlay")
v_u_4.Parent = v_u_2
game:GetService("ReplicatedStorage")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = require("@game/ReplicatedStorage/common/PlayerHandler")
v_u_3.MaxHP = 100
local function v_u_10(p_u_7) -- name: OverlayHandler
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_1
	local v8 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	if p_u_7 <= 99 then
		v_u_5:Create(v_u_4.HurtOverlay, v8, {
			["ImageTransparency"] = p_u_7 / v_u_3.MaxHP
		}):Play()
	else
		v_u_5:Create(v_u_4.HurtOverlay, v8, {
			["ImageTransparency"] = 1
		}):Play()
	end
	task.delay(8, function()
		-- upvalues: (ref) v_u_6, (ref) v_u_1, (copy) p_u_7, (ref) v_u_5, (ref) v_u_4
		local v9 = v_u_6:GetHealth(v_u_1) or 0
		if v9 <= p_u_7 or (v9 == 100 or v9 == 0) then
			v_u_5:Create(v_u_4.HurtOverlay, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				["ImageTransparency"] = 1
			}):Play()
		end
	end)
end
function v_u_3.Healed(p11) -- name: Healed
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_2, (copy) v_u_5
	v_u_10(p11)
	local v12 = v_u_4:Clone()
	v12.HealOverlay.ImageTransparency = 0
	v12.HealOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
	v12.HurtOverlay:Destroy()
	v12.Parent = v_u_2
	v12.HealOverlay:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.75, true)
	local v13 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	v_u_5:Create(v12.HealOverlay, v13, {
		["ImageTransparency"] = 1
	}):Play()
	task.wait(1.1)
	v12:Destroy()
end
function v_u_3.DamageTaken(p14, p15) -- name: DamageTaken
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_2, (copy) v_u_5
	v_u_10(p14)
	if p15 ~= "Bleed" then
		local v16 = v_u_4:Clone()
		v16.HurtOverlay.ImageTransparency = 0
		v16.HurtOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
		v_u_4.HurtOverlay.Size = UDim2.new(1.2, 0, 1.2, 0)
		v16.HealOverlay:Destroy()
		v16.Parent = v_u_2
		v16.HurtOverlay:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.75, true)
		v_u_4.HurtOverlay:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", 0.75, true)
		local v17 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		v_u_5:Create(v16.HurtOverlay, v17, {
			["ImageTransparency"] = 1
		}):Play()
		local v18 = v16.sfx:GetChildren()
		v18[math.random(1, #v18)]:Play()
		task.wait(1.1)
		v16:Destroy()
	end
end
return v_u_3