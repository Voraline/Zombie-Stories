local v1 = game.ReplicatedStorage.common
game:GetService("RunService")
local v_u_2 = workspace.CurrentCamera
local v_u_3 = game.Players.LocalPlayer:GetMouse()
local v_u_4 = script.WeaponModding.WeaponCenter
local v_u_5 = game:GetService("UserInputService")
local v6 = game.ReplicatedStorage.common:WaitForChild("SharedResources")
local v7 = game.ReplicatedStorage:FindFirstChild("place")
if v7 then
	v7 = v7:FindFirstChild("RedEvents")
end
local v8 = require(script:WaitForChild("MiscFunctions"))
local v_u_9 = require(script:WaitForChild("ModdingGui"))
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local v_u_10 = require(v6.Attachments.AttachmentSystem.AttachmentsRoot)
local v_u_11 = require(v1.WepConfig)
local v_u_12 = require(v1.ItemData)
local v_u_13 = v7 and v7:FindFirstChild("ModificationEvent")
if v_u_13 then
	v_u_13 = require(v7.ModificationEvent)
end
local v_u_14 = false
local v_u_15 = 0.3
local v_u_16 = CFrame.new()
local v_u_17 = 0
local v_u_18 = 0
local v_u_19 = false
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23, v_u_24, v_u_25 = v8.moddingFuncs()
script.WeaponModding.Parent = workspace
local v_u_60 = {
	["ExitPressed"] = v_u_9.ExitPressed,
	["OptionGroupChanged"] = v_u_9.OptionGroupChanged,
	["getAttached"] = function() -- name: getAttached
		-- upvalues: (copy) v_u_9
		return v_u_9.getAttached()
	end,
	["saveMods"] = function() -- name: saveMods
		-- upvalues: (copy) v_u_13, (copy) v_u_60
		if v_u_13 then
			local v26, v27 = v_u_60.getAttached()
			v_u_13:FireServer({
				["Type"] = "SetMods",
				["ID"] = nil,
				["SerializedMods"] = nil,
				["ID"] = v27,
				["SerializedMods"] = v26
			})
		end
	end,
	["exitMod"] = function() -- name: exitMod
		-- upvalues: (copy) v_u_9, (ref) v_u_20, (copy) v_u_2
		v_u_9.exitMod()
		if v_u_20 then
			v_u_20:Destroy()
		end
		v_u_20 = nil
		game:GetService("TweenService"):Create(v_u_2, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			["FieldOfView"] = 70
		}):Play()
	end,
	["enterMod"] = function(p28, p29, p30, p31, p32, p33) -- name: enterMod
		-- upvalues: (copy) v_u_12, (ref) v_u_20, (copy) v_u_60, (copy) v_u_11, (copy) v_u_10, (copy) v_u_23, (copy) v_u_4, (copy) v_u_9, (copy) v_u_2, (ref) v_u_15, (copy) v_u_25, (ref) v_u_22, (ref) v_u_14, (copy) v_u_3, (ref) v_u_19, (copy) v_u_24, (copy) v_u_16
		local v34 = v_u_12.List[p28].Name
		if v_u_20 then
			v_u_60.exitMod()
		end
		local v35 = nil
		if p29 then
			local v36 = v_u_11:GetWeaponConfig(p28)
			if v36 then
				v35 = v_u_10.new(v36, p29)
			end
		end
		if p32 then
			v_u_20 = p32
		else
			v_u_20 = v_u_23(v34):Clone()
		end
		v_u_20.PrimaryPart.Anchored = true
		v_u_20:PivotTo(v_u_4.CFrame)
		v_u_20.Parent = workspace
		v_u_9.loadGui(v34, v_u_20, v35, p30, p31, p33)
		local _, v37 = v_u_20:WaitForChild("Weapon"):GetBoundingBox()
		local v38 = CFrame.Angles(0, 0, 0):VectorToObjectSpace(v37)
		local v39 = v38.X
		local v40 = math.abs(v39)
		local v41 = v38.Y
		local v42 = math.abs(v41) * 0.35
		local v43 = v38.Z
		local v44 = math.abs(v43) * 0.35
		local v45 = v_u_2.ViewportSize.X * 0.85
		local v46 = v_u_2.FieldOfView / 2
		local v47 = math.rad(v46)
		local v48 = v42 / (math.tan(v47) * 2) + v44 / 2
		if v42 >= v40 or not v45 then
			local _ = v45 * (v40 / v42)
		end
		v_u_2.CameraType = Enum.CameraType.Scriptable
		v_u_15 = 0.3
		v_u_25(v_u_15)
		v_u_2.CFrame = CFrame.new(v_u_4.Position + Vector3.new(0, 0, -5), v_u_4.Position) * CFrame.new(0, 0, v48)
		local v_u_49 = 0
		local v_u_50 = 0
		local v_u_51 = nil
		local v_u_52 = nil
		if v_u_22 then
			v_u_22:Disconnect()
			v_u_22 = nil
		end
		v_u_22 = game:GetService("RunService").RenderStepped:connect(function()
			-- upvalues: (ref) v_u_14, (ref) v_u_20, (ref) v_u_3, (ref) v_u_49, (ref) v_u_50, (ref) v_u_19, (ref) v_u_51, (ref) v_u_52, (ref) v_u_24, (ref) v_u_16, (ref) v_u_4
			if v_u_14 and v_u_20 then
				local v53 = Vector2.new(v_u_3.X - v_u_49, v_u_3.Y - v_u_50)
				local v54 = v_u_3.X
				local v55 = v_u_3.Y
				v_u_49 = v54
				v_u_50 = v55
				if v_u_19 then
					v53 = Vector2.new()
					v_u_19 = false
				end
				local v56, v57 = v_u_24(v53)
				v_u_51 = v56
				v_u_52 = v57
			end
			if v_u_20 and (v_u_51 and v_u_52) then
				local v58 = v_u_20:GetPivot()
				v_u_20:PivotTo(CFrame.fromAxisAngle(v_u_51, v_u_52 * 0.1) * v58.Rotation + v58.Position)
				v_u_52 = v_u_52 * 0.9
			end
			local v59 = (os.clock() - 0) / 0.4
			if v_u_20 and (v_u_16 and v59 <= 1) then
				v_u_20:PivotTo((v_u_16:lerp(v_u_4.CFrame, v59)))
			end
		end)
	end
}
function init() -- name: init
	-- upvalues: (copy) v_u_3, (ref) v_u_20, (ref) v_u_15, (copy) v_u_25, (copy) v_u_5, (ref) v_u_19, (ref) v_u_17, (ref) v_u_18, (ref) v_u_14, (ref) v_u_21, (copy) v_u_9
	v_u_3.WheelForward:connect(function()
		-- upvalues: (ref) v_u_20, (ref) v_u_15, (ref) v_u_25
		if v_u_20 then
			local v61 = v_u_15 - 0.1
			v_u_15 = math.max(0, v61)
			v_u_25(v_u_15)
		end
	end)
	v_u_3.WheelBackward:connect(function()
		-- upvalues: (ref) v_u_20, (ref) v_u_15, (ref) v_u_25
		if v_u_20 then
			local v62 = v_u_15 + 0.1
			v_u_15 = math.min(1, v62)
			v_u_25(v_u_15)
		end
	end)
	v_u_5.InputBegan:Connect(function(p63, p64)
		-- upvalues: (ref) v_u_19, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_14, (ref) v_u_21
		if not p64 then
			if p63.UserInputType == Enum.UserInputType.MouseButton2 or (p63.UserInputType == Enum.UserInputType.MouseButton1 or p63.UserInputType == Enum.UserInputType.Touch) then
				v_u_19 = true
				if p63.UserInputType == Enum.UserInputType.Touch then
					local v65 = p63.Position.X
					local v66 = p63.Position.Y
					v_u_17 = v65
					v_u_18 = v66
				end
				if v_u_20 then
					v_u_14 = true
					local v67 = os.clock() * 100
					v_u_21 = math.floor(v67)
				end
			end
		end
	end)
	v_u_5.InputEnded:Connect(function(p68, _)
		-- upvalues: (ref) v_u_14, (ref) v_u_21
		if (p68.UserInputType == Enum.UserInputType.MouseButton2 or (p68.UserInputType == Enum.UserInputType.MouseButton1 or p68.UserInputType == Enum.UserInputType.Touch)) and v_u_14 then
			v_u_14 = false
		end
	end)
	v_u_9.init()
end
init()
return v_u_60