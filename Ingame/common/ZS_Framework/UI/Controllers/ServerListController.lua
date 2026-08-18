local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Packages.Fusion)
local v_u_3 = require("../Components/ServerList/ServerList")
local v_u_4 = require(v1.common.fusion_utils)
local v_u_5 = require("@game/ReplicatedStorage/common/zap")
local v_u_6 = require("../../Data/PlayerDatabase")
local v_u_7 = {}
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
v_u_5.ServerList.On(function(p13)
	-- upvalues: (ref) v_u_8, (ref) v_u_9, (ref) v_u_10
	if v_u_8 then
		v_u_8:set(p13.Servers)
	end
	if v_u_9 then
		v_u_9:set(false)
		if v_u_10 then
			task.cancel(v_u_10)
			v_u_10 = nil
		end
		task.delay(3, function()
			-- upvalues: (ref) v_u_9
			if v_u_9 then
				v_u_9:set(false)
			end
		end)
	end
end)
v_u_5.JoinServerResponse.On(function(p14)
	-- upvalues: (copy) v_u_6, (ref) v_u_11
	v_u_6.Signals.StatusMessage:Fire(p14.Message, 0)
	if v_u_11 then
		v_u_11:set(false)
	end
end)
v_u_5.PrivateServerCreated.On(function(p15)
	-- upvalues: (ref) v_u_12
	print("Private server created with ID: " .. p15.PrivateServerId)
	v_u_12:set(p15.PrivateServerId)
end)
function v_u_7.FailedTeleport() -- name: FailedTeleport
	-- upvalues: (ref) v_u_11, (copy) v_u_6
	if not v_u_11 then
		return false
	end
	v_u_11:set(false)
	v_u_6.Signals.StatusMessage:Fire("Failed to join server", 0)
	return true
end
function v_u_7.new(p_u_16, p_u_17, p_u_18) -- name: new
	-- upvalues: (copy) v_u_4, (ref) v_u_9, (ref) v_u_11, (ref) v_u_8, (ref) v_u_12, (copy) v_u_5, (ref) v_u_10, (copy) v_u_3
	local v_u_19 = p_u_16.scope:innerScope(v_u_4)
	local v_u_20 = v_u_19:Value({})
	v_u_9 = v_u_19:Value(false)
	v_u_11 = v_u_19:Value(false)
	v_u_8 = v_u_20
	v_u_12 = v_u_19:Value("")
	local v_u_21 = v_u_19:New("Sound")({
		["Parent"] = nil,
		["SoundId"] = "rbxassetid://265275704",
		["Volume"] = 0.5,
		["Parent"] = p_u_16.target
	})
	local function v_u_23(p22) -- name: onRefresh
		-- upvalues: (ref) v_u_5, (ref) v_u_9, (ref) v_u_10
		p22:set({})
		v_u_5.RefreshServers.Fire({
			["ServerType"] = "Arcade"
		})
		if v_u_9 then
			v_u_9:set(true)
			v_u_10 = task.delay(10, function()
				-- upvalues: (ref) v_u_9
				if v_u_9 then
					v_u_9:set(false)
				end
			end)
		end
	end
	local function v_u_27(p24) -- name: onJoin
		-- upvalues: (copy) v_u_19, (copy) v_u_20, (ref) v_u_11, (ref) v_u_5
		print("Joining server", p24)
		local v25 = false
		for _, _ in v_u_19.peek(v_u_20) do
			v25 = true
			break
		end
		local v26 = not v25 and "" or p24
		if v_u_11 then
			v_u_11:set(true)
		end
		v_u_5.JoinServer.Fire({
			["ServerID"] = nil,
			["ServerType"] = "Arcade",
			["ServerID"] = v26
		})
	end
	local function v_u_28() -- name: onJoinPrivateServer
		-- upvalues: (ref) v_u_11, (ref) v_u_5, (copy) v_u_19, (ref) v_u_12
		if v_u_11 then
			v_u_11:set(true)
		end
		v_u_5.JoinPrivateServer.Fire({
			["ServerType"] = "Arcade",
			["PrivateServerId"] = nil,
			["PrivateServerId"] = v_u_19.peek(v_u_12)
		})
	end
	v_u_23(v_u_20)
	return v_u_3({
		["OnRefresh"] = function() -- name: OnRefresh
			-- upvalues: (copy) v_u_21, (copy) p_u_16, (copy) v_u_23, (copy) v_u_20
			local v_u_29 = v_u_21:Clone()
			v_u_29.Parent = p_u_16.target
			v_u_29.Ended:Connect(function()
				-- upvalues: (copy) v_u_29
				v_u_29:Destroy()
			end)
			v_u_29.Playing = true
			v_u_23(v_u_20)
		end,
		["OnJoin"] = function(p30) -- name: OnJoin
			-- upvalues: (copy) v_u_21, (copy) p_u_16, (copy) v_u_27
			local v_u_31 = v_u_21:Clone()
			v_u_31.Parent = p_u_16.target
			v_u_31.Ended:Connect(function()
				-- upvalues: (copy) v_u_31
				v_u_31:Destroy()
			end)
			v_u_31.Playing = true
			v_u_27(p30)
		end,
		["OnExit"] = function() -- name: OnExit
			-- upvalues: (copy) v_u_21, (copy) p_u_16, (copy) v_u_19, (copy) p_u_17, (copy) p_u_18
			local v_u_32 = v_u_21:Clone()
			v_u_32.Parent = p_u_16.target
			v_u_32.Ended:Connect(function()
				-- upvalues: (copy) v_u_32
				v_u_32:Destroy()
			end)
			v_u_32.Playing = true
			v_u_19:doCleanup()
			local v33 = p_u_18
			if p_u_17 then
				v33()
			end
		end,
		["OnJoinPrivateServer"] = function() -- name: OnJoinPrivateServer
			-- upvalues: (copy) v_u_21, (copy) p_u_16, (copy) v_u_28
			local v_u_34 = v_u_21:Clone()
			v_u_34.Parent = p_u_16.target
			v_u_34.Ended:Connect(function()
				-- upvalues: (copy) v_u_34
				v_u_34:Destroy()
			end)
			v_u_34.Playing = true
			v_u_28()
		end,
		["OnStartPrivateServer"] = function() -- name: OnStartPrivateServer
			-- upvalues: (copy) v_u_21, (copy) p_u_16, (ref) v_u_5
			local v_u_35 = v_u_21:Clone()
			v_u_35.Parent = p_u_16.target
			v_u_35.Ended:Connect(function()
				-- upvalues: (copy) v_u_35
				v_u_35:Destroy()
			end)
			v_u_35.Playing = true
			print("Starting private server")
			v_u_5.StartPrivateServer.Fire({
				["ServerType"] = "Arcade"
			})
		end,
		["PrivateServerId"] = v_u_12,
		["PlayClickSound"] = function() -- name: playClickSound
			-- upvalues: (copy) v_u_21, (copy) p_u_16
			local v_u_36 = v_u_21:Clone()
			v_u_36.Parent = p_u_16.target
			v_u_36.Ended:Connect(function()
				-- upvalues: (copy) v_u_36
				v_u_36:Destroy()
			end)
			v_u_36.Playing = true
		end,
		["Joining"] = v_u_11,
		["Refreshing"] = v_u_9,
		["ServerData"] = v_u_20,
		["scope"] = v_u_19,
		["target"] = p_u_16.target
	})
end
function v_u_7.test() -- name: test
	-- upvalues: (copy) v_u_2, (copy) v_u_7
	local v37 = v_u_2.scoped(v_u_2)
	local v38 = {
		["target"] = v37:New("ScreenGui")({
			["Parent"] = nil,
			["Name"] = "ServerListController",
			["ZIndexBehavior"] = nil,
			["Parent"] = game.Players.LocalPlayer:WaitForChild("PlayerGui"),
			["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
		}),
		["scope"] = v37
	}
	v_u_7.new(v38)
end
return v_u_7