local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("SoundService")
local v_u_4 = require(v1.Packages.Fusion)
local v_u_5 = require("../../Data/PlayerDatabase")
local v_u_6 = require("../Components/Arcade/GamemodeEndScoreboard")
local v7 = require("@game/ReplicatedStorage/common/zap")
local v_u_8 = nil
local function v_u_12() -- name: closeScoreboard
	-- upvalues: (ref) v_u_8
	if v_u_8 then
		local v9 = {}
		for v10, v11 in v_u_8 do
			v9[v10] = v11
		end
		v_u_8 = nil
		v9.closeFunction()
		task.wait(10)
		v9.scope:doCleanup()
	end
end
v7.OpenGamemodeEndScoreboard.On(function(p13)
	-- upvalues: (copy) v_u_12, (copy) v_u_4, (copy) v_u_2, (copy) v_u_3, (copy) v_u_5, (copy) v_u_6, (ref) v_u_8
	v_u_12()
	local v_u_14 = v_u_4.scoped(v_u_4)
	for _, v_u_15 in p13.Players do
		v_u_15.Image = v_u_14:Value(v_u_15.Image or "")
		task.spawn(function()
			-- upvalues: (copy) v_u_14, (copy) v_u_15, (ref) v_u_2
			if v_u_14.peek(v_u_15.Image) == "" then
				local v16 = v_u_15.UserId or 1583746009
				local v17 = v16 <= 0 and 1583746009 or v16
				v_u_15.Image:set(v_u_2:GetUserThumbnailAsync(v17, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100))
			end
		end)
	end
	local function v20(_) -- name: playSound
		-- upvalues: (ref) v_u_3
		local v_u_18 = Instance.new("Sound")
		v_u_18.SoundId = "rbxasset://sounds/action_jump.mp3"
		v_u_18.Volume = 0.5
		v_u_18.Parent = v_u_3
		v_u_18.Playing = true
		v_u_18.PlaybackSpeed = math.random(800, 1200) / 1000
		local v19 = Instance.new("PitchShiftSoundEffect")
		v19.Octave = math.random(700, 850) / 1000
		v19.Parent = v_u_18
		v_u_18.Ended:Connect(function()
			-- upvalues: (copy) v_u_18
			v_u_18:Destroy()
		end)
	end
	local v21 = v_u_14:New("ScreenGui")({
		["Parent"] = nil,
		["ScreenInsets"] = nil,
		["IgnoreGuiInset"] = true,
		["Parent"] = v_u_5.PlayerGui,
		["ScreenInsets"] = Enum.ScreenInsets.None
	})
	local _, v22 = v_u_6({
		["scope"] = v_u_14,
		["Players"] = p13.Players,
		["target"] = v21,
		["PlaySound"] = v20
	})
	v_u_8 = {
		["scope"] = v_u_14,
		["closeFunction"] = v22
	}
end)
v7.CloseGamemodeEndScoreboard.On(function(_)
	-- upvalues: (copy) v_u_12
	v_u_12()
end)
return {}