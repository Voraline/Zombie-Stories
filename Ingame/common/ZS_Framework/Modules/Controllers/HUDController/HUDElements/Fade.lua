require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_1 = game:GetService("TweenService")
local v_u_2 = script:WaitForChild("Fade")
local v_u_3 = v_u_2:WaitForChild("Frame")
v_u_2.Parent = game.Players.LocalPlayer.PlayerGui
local v_u_10 = {
	["IsShowing"] = false,
	["Show"] = function(_, p4) -- name: Show
		-- upvalues: (copy) v_u_10
		v_u_10.IsShowing = true
		v_u_10:TweenTransparency(0, p4)
	end,
	["Hide"] = function(_, p5) -- name: Hide
		-- upvalues: (copy) v_u_10
		v_u_10.IsShowing = false
		v_u_10:TweenTransparency(1, p5)
	end,
	["TweenTransparency"] = function(_, p6, p7) -- name: TweenTransparency
		-- upvalues: (copy) v_u_1, (copy) v_u_3
		v_u_1:Create(v_u_3, TweenInfo.new(p7 or 1, Enum.EasingStyle.Linear), {
			["BackgroundTransparency"] = p6
		}):Play()
	end,
	["SetColor"] = function(_, p8) -- name: SetColor
		-- upvalues: (copy) v_u_3
		v_u_3.BackgroundColor3 = p8
	end,
	["SetDisplayOrder"] = function(_, p9) -- name: SetDisplayOrder
		-- upvalues: (copy) v_u_2
		v_u_2.DisplayOrder = p9
	end
}
return v_u_10