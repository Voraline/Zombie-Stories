local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("SoundService")
local v4 = v2.Packages
local v_u_5 = require(v4.Fusion)
local v6 = script.Parent
local v_u_7 = require(v6.SkillTreeRenderer)
local v_u_8 = require(v6.SkillTreeCamera)
local v_u_9 = require(v6.SkillTreeController)
local v_u_10 = require(v6.SkillTreeBackground)
local v_u_11 = require(v6.ui.SkillTreeScreenGui)
local v_u_12 = require(v6.ui.SkillTreeOverlayGui)
local v_u_13 = require(v6.ui.FadeFrame)
local v_u_14 = require(v6.ui.ConfirmationDialog)
local v_u_15 = require(v6.Remotes)
local v_u_16 = require(v6.SkillTreeData)
local v_u_17 = require(v6.config.EconomyConfig)
local v_u_18 = require("@game/ReplicatedStorage/common/zap")
local function v_u_25(p19) -- name: commaFormat
	local v20 = math.floor(p19)
	local v21 = tostring(v20)
	local v22 = #v21
	if v22 <= 3 then
		return v21
	end
	local v23 = ""
	for v24 = 1, v22 do
		if v24 > 1 and (v22 - v24 + 1) % 3 == 0 then
			v23 = v23 .. ","
		end
		v23 = v23 .. v21:sub(v24, v24)
	end
	return v23
end
local v_u_82 = {
	["new"] = function(p26) -- name: new
		-- upvalues: (copy) v_u_5, (copy) v_u_82, (copy) v_u_7, (copy) v_u_10, (copy) v_u_8, (copy) v_u_9, (copy) v_u_13, (copy) v_u_11, (copy) v_u_14, (copy) v_u_3, (copy) v_u_16, (copy) v_u_12, (copy) v_u_15, (copy) v_u_1, (copy) v_u_17, (copy) v_u_25, (copy) v_u_18
		local v_u_27 = p26 or {}
		local v_u_28 = v_u_5.scoped(v_u_5)
		local v_u_29 = v_u_28:Value(false)
		v_u_82.isSkillTreeOpen = v_u_29
		local v_u_30 = false
		local v_u_31 = nil
		local v_u_32 = nil
		local v_u_33 = nil
		local v_u_34 = v_u_7.new()
		v_u_34:render(workspace)
		v_u_34.container.Parent = nil
		local v_u_35 = v_u_10.new()
		local v_u_36 = v_u_8.new()
		local v_u_37 = v_u_9.new(v_u_34, v_u_36)
		local v_u_38 = v_u_13({
			["scope"] = v_u_28
		})
		local v_u_39 = v_u_11({
			["scope"] = v_u_37:getScope(),
			["SelectedSkillId"] = v_u_37:getSelectedSkillValue(),
			["CurrentRank"] = v_u_37:getSelectedSkillRankComputed(),
			["OnBuy"] = function() -- name: OnBuy
				-- upvalues: (copy) v_u_37
				v_u_37:handleBuy()
			end,
			["OnExit"] = function() -- name: OnExit
				-- upvalues: (copy) v_u_37
				v_u_37:deselectSkill()
			end
		})
		v_u_39.Enabled = false
		local v_u_40 = nil
		local v_u_41 = v_u_14(v_u_28)
		local v_u_42 = Instance.new("Sound")
		v_u_42.SoundId = "rbxassetid://92245187249918"
		v_u_42.Parent = v_u_3
		local v_u_43 = Instance.new("Sound")
		v_u_43.SoundId = "rbxassetid://85427260827797"
		v_u_43.Parent = v_u_3
		local v46 = v_u_28:Computed(function(p44)
			-- upvalues: (ref) v_u_16
			for _, v45 in v_u_16.SkillRanks do
				if p44(v45) > 0 then
					return true
				end
			end
			return false
		end)
		local v_u_47 = v_u_12({
			["scope"] = v_u_28,
			["SP"] = v_u_16.SP,
			["SPSpent"] = v_u_16.SPSpent,
			["SPCap"] = v_u_16.SPCap,
			["XPBar"] = v_u_16.XPBar,
			["DailyEarned"] = v_u_16.DailyEarned,
			["DailyEarnCap"] = v_u_16.DailyEarnCap,
			["PrestigeLevel"] = v_u_16.PrestigeLevel,
			["ZBucks"] = v_u_16.ZBucks,
			["XPBonusMult"] = v_u_16.XPBonusMult,
			["AtSPCap"] = v_u_16.AtSPCap,
			["AtDailyCap"] = v_u_16.AtDailyCap,
			["CanPrestige"] = v_u_16.CanPrestige,
			["RespecVisible"] = v46,
			["OnExit"] = function() -- name: OnExit
				-- upvalues: (ref) v_u_32
				v_u_32()
			end,
			["OnRespec"] = function() -- name: OnRespec
				-- upvalues: (ref) v_u_33
				v_u_33()
			end,
			["OnPrestige"] = function() -- name: OnPrestige
				-- upvalues: (ref) v_u_40
				v_u_40()
			end
		})
		v_u_37:setOnBuyCallback(function(p48)
			-- upvalues: (ref) v_u_15
			print("Requesting purchase for skill:", p48)
			v_u_15.PurchaseSkill:FireServer(p48)
		end)
		for v_u_49, v_u_50 in pairs(v_u_16.SkillRanks) do
			v_u_28:Observer(v_u_50):onBind(function()
				-- upvalues: (ref) v_u_5, (copy) v_u_50, (copy) v_u_34, (copy) v_u_49
				v_u_34:setSkillRank(v_u_49, (v_u_5.peek(v_u_50)))
			end)
		end
		local v_u_51 = {
			["isOpen"] = v_u_29
		}
		local function v_u_56() -- name: createExitHelpers
			-- upvalues: (copy) v_u_36, (ref) v_u_8, (copy) v_u_38, (ref) v_u_30, (copy) v_u_35, (copy) v_u_34, (copy) v_u_39, (copy) v_u_47, (copy) v_u_29, (copy) v_u_37, (ref) v_u_31, (ref) v_u_1, (ref) v_u_27
			return {
				["fade"] = function(p52) -- name: fade
					-- upvalues: (ref) v_u_36, (ref) v_u_8, (ref) v_u_38
					v_u_36:tweenFieldOfView(v_u_8.getTransitionFOVStart(), 0.4)
					v_u_38:fadeIn(0.4, p52)
				end,
				["fadeOut"] = function(p_u_53) -- name: fadeOut
					-- upvalues: (ref) v_u_38, (ref) v_u_30
					v_u_38:fadeOut(0.4, function()
						-- upvalues: (ref) v_u_30, (copy) p_u_53
						v_u_30 = false
						if p_u_53 then
							p_u_53()
						end
					end)
				end,
				["disconnectAll"] = function() -- name: disconnectAll
					-- upvalues: (ref) v_u_36, (ref) v_u_35, (ref) v_u_34, (ref) v_u_39, (ref) v_u_47, (ref) v_u_29, (ref) v_u_37, (ref) v_u_31, (ref) v_u_1, (ref) v_u_27
					v_u_36:disable()
					v_u_35:stop()
					v_u_34.container.Parent = nil
					v_u_39.Enabled = false
					v_u_47.Enabled = false
					v_u_29:set(false)
					v_u_37:deselectSkill()
					if v_u_31 ~= nil then
						local v54 = v_u_1.LocalPlayer:FindFirstChild("PlayerGui")
						local v55 = v54 and v54:FindFirstChild("TouchGui")
						if v55 then
							v55.Enabled = v_u_31
						end
						v_u_31 = nil
					end
					if v_u_27.onAfterClose then
						v_u_27.onAfterClose()
					end
				end
			}
		end
		function v_u_51.open(_) -- name: open
			-- upvalues: (ref) v_u_30, (ref) v_u_27, (ref) v_u_1, (ref) v_u_31, (ref) v_u_15, (copy) v_u_29, (copy) v_u_38, (copy) v_u_34, (copy) v_u_35, (copy) v_u_36, (ref) v_u_8, (copy) v_u_39, (copy) v_u_47
			if not v_u_30 then
				v_u_30 = true
				if v_u_27.onBeforeOpen then
					v_u_27.onBeforeOpen()
				end
				local v57 = v_u_1.LocalPlayer:FindFirstChild("PlayerGui")
				local v58 = v57 and v57:FindFirstChild("TouchGui")
				if v58 then
					v_u_31 = v58.Enabled
					v58.Enabled = false
				end
				v_u_15.RequestSync:FireServer()
				v_u_29:set(true)
				v_u_38:setTransparency(0)
				v_u_34.container.Parent = workspace
				v_u_35:start(workspace)
				v_u_36:setFieldOfView(v_u_8.getTransitionFOVStart())
				v_u_36:enable("core1")
				v_u_39.Enabled = true
				v_u_47.Enabled = true
				v_u_36:tweenFieldOfView(v_u_8.getDefaultFOV(), 0.5)
				v_u_38:fadeOut(0.5, function()
					-- upvalues: (ref) v_u_30, (ref) v_u_27
					v_u_30 = false
					if v_u_27.onAfterOpen then
						v_u_27.onAfterOpen()
					end
				end)
			end
		end
		function v_u_51.close(_) -- name: close
			-- upvalues: (ref) v_u_30, (ref) v_u_27, (copy) v_u_29, (copy) v_u_37, (copy) v_u_36, (ref) v_u_8, (copy) v_u_38, (copy) v_u_35, (copy) v_u_34, (copy) v_u_39, (copy) v_u_47, (ref) v_u_31, (ref) v_u_1
			if not v_u_30 then
				v_u_30 = true
				if v_u_27.onBeforeClose then
					v_u_27.onBeforeClose()
				end
				v_u_29:set(false)
				v_u_37:deselectSkill()
				v_u_36:tweenFieldOfView(v_u_8.getTransitionFOVStart(), 0.4)
				v_u_38:fadeIn(0.4, function()
					-- upvalues: (ref) v_u_36, (ref) v_u_35, (ref) v_u_34, (ref) v_u_39, (ref) v_u_47, (ref) v_u_31, (ref) v_u_1, (ref) v_u_38, (ref) v_u_30, (ref) v_u_27
					v_u_36:disable()
					v_u_35:stop()
					v_u_34.container.Parent = nil
					v_u_39.Enabled = false
					v_u_47.Enabled = false
					if v_u_31 ~= nil then
						local v59 = v_u_1.LocalPlayer:FindFirstChild("PlayerGui")
						local v60 = v59 and v59:FindFirstChild("TouchGui")
						if v60 then
							v60.Enabled = v_u_31
						end
						v_u_31 = nil
					end
					v_u_38:fadeOut(0.4, function()
						-- upvalues: (ref) v_u_30, (ref) v_u_27
						v_u_30 = false
						if v_u_27.onAfterClose then
							v_u_27.onAfterClose()
						end
					end)
				end)
			end
		end
		v_u_32 = function()
			-- upvalues: (ref) v_u_30, (ref) v_u_27, (copy) v_u_56, (copy) v_u_51
			if v_u_30 then
				return
			elseif v_u_27.onExitButtonPressed then
				v_u_30 = true
				local v61 = v_u_56()
				v_u_27.onExitButtonPressed(v61)
			else
				v_u_51:close()
			end
		end
		v_u_33 = function()
			-- upvalues: (ref) v_u_5, (ref) v_u_16, (ref) v_u_17, (ref) v_u_25, (copy) v_u_41, (copy) v_u_43, (ref) v_u_27, (ref) v_u_18
			local v62 = v_u_5.peek(v_u_16.SPSpent)
			local v63 = v_u_5.peek(v_u_16.ZBucksInvested)
			local v64 = v_u_17.RESPEC_ZBUCKS_COST
			local v65 = ("Refunds: %* SP"):format((v_u_25(v62)))
			if v63 > 0 then
				v65 = v65 .. (" + %* Z$"):format((v_u_25(v63)))
			end
			v_u_41:show("Respec Skills?", ("This will reset all skills.\n%*\nCosts %* Z$."):format(v65, (v_u_25(v64))), function()
				-- upvalues: (ref) v_u_43, (ref) v_u_27, (ref) v_u_18
				v_u_43:Play()
				if v_u_27.onRespecButtonPressed then
					v_u_27.onRespecButtonPressed()
				else
					v_u_18.RespecSkillTree.Fire()
				end
			end)
		end
		v_u_40 = function()
			-- upvalues: (ref) v_u_5, (ref) v_u_16, (ref) v_u_17, (ref) v_u_25, (copy) v_u_41, (copy) v_u_42, (ref) v_u_18
			local v66 = v_u_5.peek(v_u_16.PrestigeLevel)
			local v67 = v_u_17.getPrestigeZBucksCost(v66)
			local v68 = v_u_17.getPrestigeStats(v66)
			local v69 = v_u_17.getPrestigeStats(v66 + 1)
			local v70 = v69.spCap - v68.spCap
			local v71 = v69.dailyEarnCap - v68.dailyEarnCap
			local v72 = v66 * v_u_17.XP_BOOST_PER_PRESTIGE
			local v73 = v_u_17.MAX_XP_BOOST
			local v74 = math.min(v72, v73) * 100 + 0.5
			local v75 = math.floor(v74)
			local v76 = (v66 + 1) * v_u_17.XP_BOOST_PER_PRESTIGE
			local v77 = v_u_17.MAX_XP_BOOST
			local v78 = math.min(v76, v77) * 100 + 0.5
			local v79 = math.floor(v78)
			local v80 = ("All skills will be reset.\nSP Cap: %* \226\134\146 %* (+%*)"):format(v68.spCap, v69.spCap, v70)
			if v71 > 0 then
				v80 = v80 .. ("\nDaily Earn Cap: %* \226\134\146 %* (+%*)"):format(v68.dailyEarnCap, v69.dailyEarnCap, v71)
			end
			local v81 = (v80 .. ("\nSkill XP Bonus: %*%% \226\134\146 %*%%"):format(v75, v79)) .. ("\nCosts %* Z$."):format((v_u_25(v67)))
			v_u_41:show(("Prestige to Level %*?"):format(v66 + 1), v81, function()
				-- upvalues: (ref) v_u_42, (ref) v_u_18
				v_u_42:Play()
				v_u_18.RequestPrestige.Fire()
			end)
		end
		function v_u_51.destroy(_) -- name: destroy
			-- upvalues: (copy) v_u_28, (copy) v_u_34, (copy) v_u_35, (copy) v_u_36
			v_u_28:doCleanup()
			v_u_34:destroy()
			v_u_35:stop()
			v_u_36:disable()
		end
		print("SkillTreeMain initialized")
		return v_u_51
	end
}
return v_u_82