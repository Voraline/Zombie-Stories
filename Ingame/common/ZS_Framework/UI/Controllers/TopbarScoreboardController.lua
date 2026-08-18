local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require("../../Data/PlayerDatabase")
local v_u_4 = require(v1.Packages.Bin)
local v_u_5 = require(v1.Packages.Fusion)
local v_u_6 = require("../Components/Gamemodes/TopBarScoreboard")
local v7 = {}
local v_u_8 = {}
local function v_u_42() -- name: setupScoreboard
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (ref) v_u_8, (copy) v_u_3, (copy) v_u_6, (copy) v_u_2
	local v_u_9 = v_u_5.scoped(v_u_5)
	local v_u_10, v11 = v_u_4()
	v_u_8.Empty = v11
	v_u_8.Add = v_u_10
	v_u_8.scope = v_u_9
	local v_u_12 = v_u_9:Value({})
	local v_u_13 = v_u_9:Value(workspace:GetAttribute("TimeLeft") or 0)
	v_u_10(workspace:GetAttributeChangedSignal("TimeLeft"):Connect(function()
		-- upvalues: (copy) v_u_13
		v_u_13:set(workspace:GetAttribute("TimeLeft") or 0)
	end))
	local v14 = v_u_9:New("ScreenGui")
	local v15 = {
		["Parent"] = v_u_3.PlayerGui,
		[v_u_9.Children] = { v_u_6({
				["PlayerList"] = v_u_12,
				["TimeLeft"] = v_u_13,
				["scope"] = v_u_9
			}) }
	}
	v14(v15)
	local function v_u_29() -- name: updateList
		-- upvalues: (copy) v_u_9, (copy) v_u_12, (ref) v_u_2
		local v16 = v_u_9.peek(v_u_12)
		local v17 = v_u_2.LocalPlayer
		local v18 = {}
		for v19, v20 in pairs(v16) do
			local v21 = {
				["userId"] = v19,
				["score"] = v_u_9.peek(v20.Score)
			}
			table.insert(v18, v21)
		end
		table.sort(v18, function(p22, p23)
			return p22.score > p23.score
		end)
		local v24 = #v18
		local v25 = {}
		for v26 = 1, math.min(5, v24) do
			v25[v18[v26].userId] = true
		end
		if v16[v17.UserId] and not v25[v17.UserId] then
			v25[v17.UserId] = true
		end
		for v27, v28 in pairs(v16) do
			v28.Visible:set(v25[v27] == true)
		end
	end
	local function v_u_37(p_u_30) -- name: setupPlayer
		-- upvalues: (copy) v_u_9, (copy) v_u_12, (ref) v_u_2, (copy) v_u_29, (copy) v_u_10
		local v31 = v_u_9.peek(v_u_12)
		local v_u_32 = v_u_9:Value("")
		local v_u_33 = v_u_9:Value(0)
		local v34 = v_u_9:Value(false)
		v31[p_u_30.UserId] = {
			["Score"] = v_u_33,
			["Headshot"] = v_u_32,
			["Name"] = v_u_9:Value(string.upper(p_u_30.Name)),
			["Visible"] = v34,
			["userId"] = p_u_30.UserId
		}
		v_u_12:set(v31)
		task.spawn(function()
			-- upvalues: (ref) v_u_2, (copy) p_u_30, (copy) v_u_32
			local v35 = v_u_2:GetUserThumbnailAsync(p_u_30.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size352x352)
			if v35 then
				v_u_32:set(v35)
			end
		end)
		local function v36() -- name: updatePlayerInfo
			-- upvalues: (copy) p_u_30, (copy) v_u_33, (ref) v_u_29
			v_u_33:set(p_u_30:GetAttribute("Score") or 0)
			v_u_29()
		end
		v_u_10(p_u_30:GetAttributeChangedSignal("Score"):Connect(v36))
		v_u_33:set(p_u_30:GetAttribute("Score") or 0)
		v_u_29()
	end
	for _, v38 in v_u_2:GetPlayers() do
		v_u_37(v38)
	end
	v_u_10(v_u_2.PlayerAdded:Connect(function(p39)
		-- upvalues: (copy) v_u_37
		v_u_37(p39)
	end))
	v_u_10(v_u_2.PlayerRemoving:Connect(function(p40)
		-- upvalues: (copy) v_u_9, (copy) v_u_12, (copy) v_u_29
		local v41 = v_u_9.peek(v_u_12)
		v41[p40.UserId] = nil
		v_u_12:set(v41)
		v_u_29()
	end))
end
if workspace:GetAttribute("TopbarScoreboard") then
	v_u_42()
end
workspace:GetAttributeChangedSignal("TopbarScoreboard"):Connect(function()
	-- upvalues: (copy) v_u_42, (ref) v_u_8
	if workspace:GetAttribute("TopbarScoreboard") then
		v_u_42()
		return
	elseif v_u_8.Empty then
		v_u_8.Empty()
		v_u_8.scope:doCleanup()
		v_u_8 = {}
	end
end)
return v7