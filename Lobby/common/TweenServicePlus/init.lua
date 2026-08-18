local v1 = {}
local v_u_2 = require("@self/SyncedTime")
local v3 = game:GetService("RunService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("HttpService")
local v_u_6 = coroutine.wrap
local v_u_7 = script:WaitForChild("TweenCommunication")
if v3:IsServer() and not v_u_2:IsSynced() then
	repeat
		v_u_2:Sync()
		task.wait(0.5)
	until v_u_2:IsSynced()
end
local function v_u_9(p8) -- name: infoToTable
	return {
		["Time"] = p8.Time or 1,
		["EasingStyle"] = p8.EasingStyle or Enum.EasingStyle.Quad,
		["EasingDirection"] = p8.EasingDirection or Enum.EasingDirection.Out,
		["RepeatCount"] = p8.RepeatCount or 0,
		["Reverses"] = p8.Reverses or false,
		["DelayTime"] = p8.DelayTime or 0
	}
end
local function v_u_15(p10, p11, p12) -- name: assign
	if p10 and p11 then
		for v13, v14 in pairs(p11) do
			p10[v13] = v14
			if p12 then
				print("Set " .. p10.Name .. "\'s " .. v13 .. " to " .. tostring(v14) .. ".")
			end
		end
	end
end
function v1.Construct(_, p_u_16, p_u_17, p_u_18, p_u_19, p20, p21) -- name: Construct
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_6, (copy) v_u_15, (copy) v_u_7, (copy) v_u_9
	if p_u_16 then
		if p_u_17 then
			if p_u_18 then
				if p_u_19 and not type(p_u_19) == "number" then
					warn("Latency threshold must be a number!")
					return
				elseif p20 and not type(p20) == "boolean" then
					warn("The debugMode parameter must be true or false!")
				else
					if not p21 or not type(p21) ~= "boolean" then
						if p_u_17.Reverses then
							for v22, _ in pairs(p_u_18) do
								(nil)[v22] = p_u_16[v22]
							end
						end
						local v23 = p20 or false
						local v_u_24 = {
							["Cancelled"] = true,
							["Completed"] = true,
							["Paused"] = true,
							["Resumed"] = true
						}
						local v_u_25 = {
							["PlaybackState"] = Enum.PlaybackState.Begin,
							["TweenId"] = v_u_5:GenerateGUID(false),
							["IsPaused"] = false,
							["IsCancelled"] = false,
							["LastPlay"] = v_u_2:GetTime(),
							["TimeElapsed"] = 0
						}
						local v_u_26 = v23
						local v_u_27 = p21 or true
						for v28, _ in pairs(v_u_24) do
							v_u_24[v28] = Instance.new("BindableEvent")
							v_u_25[v28] = v_u_24[v28].Event
						end
						local function v_u_32(p29)
							-- upvalues: (copy) v_u_25, (ref) v_u_26
							local v30 = tick()
							local v31 = p29 or 0.0333
							while true do
								task.wait()
								if v_u_25.IsPaused == true or v_u_25.IsCancelled == true then
									break
								end
								if v31 <= tick() - v30 then
									return
								end
							end
							if v_u_26 then
								print("Tween cancelled/paused server-side.")
							end
							return true
						end
						function v_u_25.Play(_, p33, p_u_34, p35, p36) -- name: Play
							-- upvalues: (copy) p_u_16, (ref) v_u_26, (ref) v_u_6, (ref) v_u_7, (ref) v_u_9, (copy) p_u_17, (copy) p_u_18, (ref) v_u_2, (copy) v_u_25, (copy) p_u_19, (ref) v_u_27, (copy) v_u_24, (copy) v_u_32, (ref) v_u_15
							local v_u_37 = p35 or "HumanoidRootPart"
							if p36 and not (p36:IsA("BasePart") and p36:IsDescendantOf(workspace)) then
								warn("The mainObject must be a BasePart in the workspace.")
							else
								local v_u_38 = p36 or p_u_16
								if v_u_38 ~= p_u_16 and v_u_26 then
									print("Set the main object to", v_u_38.Name)
								end
								if p33 then
									local v39 = type(p33) == "table" and (p33 or { p33 }) or { p33 }
									if p_u_34 then
										for _, v_u_40 in ipairs(v39) do
											if v_u_40 and (v_u_40:IsA("Player") and v_u_40.Character) then
												v_u_6(function()
													-- upvalues: (copy) v_u_40, (ref) v_u_37, (ref) v_u_26, (ref) v_u_38, (copy) p_u_34, (ref) v_u_7, (ref) p_u_16, (ref) v_u_9, (ref) p_u_17, (ref) p_u_18, (ref) v_u_2, (ref) v_u_25, (ref) p_u_19, (ref) v_u_27
													local v41 = v_u_40.Character:FindFirstChild(v_u_37, true)
													if v41 then
														if v_u_26 then
															print("Found root part of " .. v_u_40.Name .. ":", v_u_37)
														end
														local v42 = (v_u_38.Position - v41.Position).magnitude
														if v42 <= p_u_34 then
															v_u_7:FireClient(v_u_40, p_u_16, v_u_9(p_u_17), p_u_18, v_u_2:GetTime(), v_u_25.TweenId, p_u_19, v_u_26, nil, v_u_27)
															if v_u_26 then
																print("Sent tween data to " .. v_u_40.Name .. ". Distance from object:", v42)
															end
														end
													end
												end)()
											end
										end
									else
										for _, v_u_43 in ipairs(v39) do
											if v_u_43 and (v_u_43:IsA("Player") and v_u_43.Character) then
												v_u_6(function()
													-- upvalues: (ref) v_u_7, (copy) v_u_43, (ref) p_u_16, (ref) v_u_9, (ref) p_u_17, (ref) p_u_18, (ref) v_u_2, (ref) v_u_25, (ref) p_u_19, (ref) v_u_26, (ref) v_u_27
													v_u_7:FireClient(v_u_43, p_u_16, v_u_9(p_u_17), p_u_18, v_u_2:GetTime(), v_u_25.TweenId, p_u_19, v_u_26, nil, v_u_27)
												end)()
											end
										end
									end
								elseif p_u_34 then
									for _, v_u_44 in ipairs(game.Players:GetPlayers()) do
										if v_u_44 and (v_u_44:IsA("Player") and v_u_44.Character) then
											v_u_6(function()
												-- upvalues: (copy) v_u_44, (ref) v_u_37, (ref) v_u_26, (ref) v_u_38, (copy) p_u_34, (ref) v_u_7, (ref) p_u_16, (ref) v_u_9, (ref) p_u_17, (ref) p_u_18, (ref) v_u_2, (ref) v_u_25, (ref) p_u_19, (ref) v_u_27
												local v45 = v_u_44.Character:FindFirstChild(v_u_37, true)
												if v45 then
													if v_u_26 then
														print("Found root part of " .. v_u_44.Name .. ":", v_u_37)
													end
													local v46 = (v_u_38.Position - v45.Position).magnitude
													if v46 <= p_u_34 then
														v_u_7:FireClient(v_u_44, p_u_16, v_u_9(p_u_17), p_u_18, v_u_2:GetTime(), v_u_25.TweenId, p_u_19, v_u_26, nil, v_u_27)
														if v_u_26 then
															print("Sent tween data to " .. v_u_44.Name .. ". Distance from object:", v46)
														end
													end
												end
											end)()
										end
									end
								else
									v_u_7:FireAllClients(p_u_16, v_u_9(p_u_17), p_u_18, v_u_2:GetTime(), v_u_25.TweenId, p_u_19, v_u_26, nil, v_u_27)
								end
								local v_u_47 = p_u_17.Time
								v_u_6(function()
									-- upvalues: (ref) v_u_25, (ref) v_u_47, (ref) v_u_26, (ref) v_u_24, (ref) p_u_17, (ref) v_u_2, (ref) v_u_32, (ref) v_u_15, (ref) p_u_16, (ref) p_u_18
									if v_u_25.IsPaused then
										v_u_47 = v_u_47 - v_u_25.TimeElapsed
										if v_u_26 then
											print("Tween is resuming from a pause. Length:", v_u_47)
										end
										v_u_24.Resumed:Fire()
										v_u_25.IsPaused = false
									end
									if v_u_25.IsCancelled then
										v_u_25.IsCancelled = false
									end
									if p_u_17.DelayTime > 0 then
										local v48 = Enum.PlaybackState.Delayed
										v_u_25.PlaybackState = v48
										if v_u_26 then
											print("Playback state changed. New playback state:", (tostring(v48)))
										end
										task.wait(p_u_17.DelayTime)
									end
									v_u_25.LastPlay = v_u_2:GetTime()
									local v49 = Enum.PlaybackState.Playing
									v_u_25.PlaybackState = v49
									if v_u_26 then
										print("Playback state changed. New playback state:", (tostring(v49)))
									end
									if not v_u_32(v_u_47) then
										v_u_15(p_u_16, p_u_18, v_u_26)
										if not p_u_17.Reverses then
											local v50 = Enum.PlaybackState.Completed
											v_u_25.PlaybackState = v50
											if v_u_26 then
												print("Playback state changed. New playback state:", (tostring(v50)))
											end
											v_u_24.Completed:Fire()
											return
										end
										if p_u_17.Reverses then
											task.wait(v_u_47)
											if not v_u_25.IsPaused then
												v_u_15(p_u_16, nil, v_u_26)
												local v51 = Enum.PlaybackState.Completed
												v_u_25.PlaybackState = v51
												if v_u_26 then
													print("Playback state changed. New playback state:", (tostring(v51)))
												end
												v_u_24.Completed:Fire()
											end
										end
									end
								end)()
							end
						end
						function v_u_25.Cancel(_, p52) -- name: Cancel
							-- upvalues: (ref) v_u_7, (ref) v_u_2, (copy) v_u_25, (ref) v_u_26, (copy) v_u_24
							if p52 then
								local v53 = type(p52) == "table" and p52 and p52 or { p52 }
								for _, v54 in ipairs(v53) do
									v_u_7:FireClient(v54, nil, nil, nil, v_u_2:GetTime(), v_u_25.TweenId, nil, v_u_26, "Cancel")
								end
							else
								v_u_7:FireAllClients(nil, nil, nil, v_u_2:GetTime(), v_u_25.TweenId, nil, v_u_26, "Cancel")
							end
							v_u_24.Cancelled:Fire()
							v_u_25.IsCancelled = true
							local v55 = Enum.PlaybackState.Cancelled
							v_u_25.PlaybackState = v55
							if v_u_26 then
								print("Playback state changed. New playback state:", (tostring(v55)))
							end
						end
						function v_u_25.Pause(_, p56) -- name: Pause
							-- upvalues: (ref) v_u_7, (ref) v_u_2, (copy) v_u_25, (ref) v_u_26, (copy) v_u_24
							if p56 then
								local v57 = type(p56) == "table" and p56 and p56 or { p56 }
								for _, v58 in ipairs(v57) do
									v_u_7:FireClient(v58, nil, nil, nil, v_u_2:GetTime(), v_u_25.TweenId, nil, v_u_26, "Pause")
								end
							else
								v_u_7:FireAllClients(nil, nil, nil, v_u_2:GetTime(), v_u_25.TweenId, nil, v_u_26, "Pause")
							end
							v_u_25.TimeElapsed = v_u_2:GetTime() - v_u_25.LastPlay
							v_u_25.LastPlay = v_u_2:GetTime()
							v_u_24.Paused:Fire()
							v_u_25.IsPaused = true
							local v59 = Enum.PlaybackState.Paused
							v_u_25.PlaybackState = v59
							if v_u_26 then
								print("Playback state changed. New playback state:", (tostring(v59)))
							end
						end
						return v_u_25
					end
					warn("The parameter clientSync must be true or false!")
				end
			else
				warn("Please provide some properties to tween to!")
				return
			end
		else
			warn("Please provide some TweenInfo!")
			return
		end
	else
		warn("This object doesn\'t exist.")
		return
	end
end
if v3:IsClient() then
	local v_u_60 = game.Players.LocalPlayer
	local v_u_61 = {}
	v_u_7.OnClientEvent:Connect(function(p_u_62, p63, p_u_64, p65, p_u_66, p67, p68, p69, p70)
		-- upvalues: (copy) v_u_61, (copy) v_u_2, (copy) v_u_60, (copy) v_u_6, (copy) v_u_4
		if p69 then
			local v71 = v_u_61[p_u_66]
			if not v71 then
				warn("The tween you tried to modify does not exist.")
				return
			end
			if p69 == "Cancel" then
				v71:Cancel()
				if p68 then
					local v72 = v_u_2:GetTime() - p65
					print("Cancelled a tween. Latency:", v72)
				end
				return
			end
			if p69 == "Pause" then
				v71:Pause()
				if p68 then
					local v73 = v_u_2:GetTime() - p65
					print("Paused a tween. Latency:", v73)
				end
				return
			end
		end
		local v74 = v_u_2:GetTime() - p65
		local v75 = p70 and p63.Time - v74 or p63.Time
		if p68 then
			print("Approximate latency for " .. v_u_60.Name .. ": " .. v74 .. " seconds. \n New tween time: " .. v75 .. " seconds")
		end
		if (p67 or 0) < v75 and (p_u_62 and (p_u_64 and p_u_66)) then
			local v_u_76 = TweenInfo.new(v75, p63.EasingStyle, p63.EasingDirection, p63.RepeatCount, p63.Reverses, p63.DelayTime)
			v_u_6(function()
				-- upvalues: (ref) v_u_61, (copy) p_u_66, (ref) v_u_4, (copy) p_u_62, (copy) v_u_76, (copy) p_u_64
				if not v_u_61[p_u_66] then
					v_u_61[p_u_66] = v_u_4:Create(p_u_62, v_u_76, p_u_64)
				end
				v_u_61[p_u_66]:Play()
				v_u_61[p_u_66].Completed:Wait()
				v_u_61[p_u_66] = nil
			end)()
			if p68 then
				v_u_6(function()
					-- upvalues: (copy) p_u_62, (copy) p_u_64
					print("Currently tweening properties of " .. p_u_62.Name .. ":")
					for v77, v78 in pairs(p_u_64) do
						print(v77 .. " to " .. tostring(v78))
					end
				end)()
			end
		end
	end)
end
return v1