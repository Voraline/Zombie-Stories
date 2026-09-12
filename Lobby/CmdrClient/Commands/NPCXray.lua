local common = game.ReplicatedStorage.common
local RunService = game:GetService("RunService")
local NPCRegistry = require(common.NPCRegistry)
local u11 = false
local u12 = {}
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NPCXray"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
local Frame = Instance.new("Frame")
Frame.BackgroundTransparency = 1
local v1 = Instance.new("UIStroke", Frame)
v1.Color = Color3.new(0, 1, 0)
v1.Thickness = 1
v1.LineJoinMode = Enum.LineJoinMode.Round
local v2 = Instance.new("TextLabel", Frame)
v2.Name = "UIDLabel"
v2.Position = UDim2.new(0.5, 0, 0.5, 0)
v2.Size = UDim2.new(1, 0, 1, 0)
v2.BackgroundTransparency = 1
v2.Text = "123"
v2.TextColor3 = Color3.new(0, 1, 0)
v2.FontFace = Font.new("SourceSansPro", Enum.FontWeight.Bold)
v2.AnchorPoint = Vector2.new(0.5, 0.5)

local function setupXray(p1) -- Line: 31 -- upvalues: Frame (val), ScreenGui (val), u12 (val)
    local v1 = Frame:Clone()
    local UIDLabel = v1:WaitForChild("UIDLabel")
    UIDLabel.Text = p1.UID
    v1.Parent = ScreenGui
    local v2 = u12
    v2[p1] = {v1, UIDLabel}
end

local function updateXrays() -- Line: 39 -- upvalues: u12 (val)
    local BoundingBox, BoundingBox_2, CurrentCamera, Position, X, X_2, X_3, X_4, Y, Y_2, Y_3, Y_4, Z, v1, v2, v3, v4, v5
    local v6 = u12
    local v7 = nil
    local v8 = nil
    for i, j in v6, v7, v8 do
        if i.Model then
            v3 = j[1]
            v4 = j[2]
            BoundingBox, BoundingBox_2 = i.Model:GetBoundingBox()
            v5 = false
            X_3 = nil
            Y_3 = nil
            X_4 = nil
            Y_4 = nil
            Z = nil
            for k = -1, 1, 2 do
                for n = -1, 1, 2 do
                    for m = -1, 1, 2 do
                        v1 = BoundingBox * CFrame.new(k * 0.5 * BoundingBox_2.X, n * 0.5 * BoundingBox_2.Y, m * 0.5 * BoundingBox_2.Z)
                        CurrentCamera = workspace.CurrentCamera
                        Position = v1.Position
                        v2 = CurrentCamera:WorldToViewportPoint(Position)
                        if v2.Z < 0 then
                            v5 = true
                        end
                        if not X_3 then
                            X_3 = v2.X
                            Y_3 = v2.Y
                            X_4 = v2.X
                            Y_4 = v2.Y
                        else
                            X = v2.X
                            X_3 = math.max(X_3, X)
                            Y = v2.Y
                            Y_3 = math.max(Y_3, Y)
                            X_2 = v2.X
                            X_4 = math.min(X_4, X_2)
                            Y_2 = v2.Y
                            Y_4 = math.min(Y_4, Y_2)
                            Z = v2.Z
                        end
                    end
                end
            end
            v3.Visible = not v5
            v3.Position = UDim2.new(0, X_4, 0, Y_4)
            v3.Size = UDim2.new(0, X_3 - X_4, 0, Y_3 - Y_4)
            v4.TextSize = 700 / Z
        end
    end
end

if RunService:IsClient() then
    local UIDLabel, v3
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    for i, j in NPCRegistry:GetAllNPCs() do
        v3 = Frame:Clone()
        UIDLabel = v3:WaitForChild("UIDLabel")
        UIDLabel.Text = j.UID
        v3.Parent = ScreenGui
        u12[j] = {v3, UIDLabel}
    end
    NPCRegistry.NPCAdded:Connect(function(p1) -- Line: 91 -- upvalues: Frame (val), ScreenGui (val), u12 (val)
        local v1 = Frame:Clone()
        local UIDLabel = v1:WaitForChild("UIDLabel")
        UIDLabel.Text = p1.UID
        v1.Parent = ScreenGui
        local v2 = u12
        v2[p1] = {v1, UIDLabel}
    end)
    NPCRegistry.NPCRemoved:Connect(function(p1) -- Line: 95 -- upvalues: u12 (val)
        local v1 = u12[p1][1]
        if v1 then
            u12[p1] = nil
            v1:Destroy()
        end
    end)
end
return {
    Name = "npcxray",
    Description = "Highlights all NPCs and shows debug info.",
    Group = "Debug",
    Aliases = {"nx"},
    Args = {},
    ClientRun = function(p1) -- Line: 111 -- upvalues: u11 (ref), RunService (val), updateXrays (val), u12 (val)
        local v1, v2
        u11 = not u11
        if not u11 then
            RunService:UnbindFromRenderStep("NPCXray")
            v1 = u12
            local v3 = nil
            v2 = nil
            for i, j in v1, v3, v2 do
                j[1].Visible = false
            end
        else
            v1 = RunService
            local v4 = Enum.RenderPriority.Input.Value - 1
            local v5 = updateXrays
            v1:BindToRenderStep("NPCXray", v4, v5)
        end
        local format = string.format
        if not u11 then
            v2 = "disabled"
        else
            v2 = "enabled"
        end
        return format("NPC Xray %s", v2)
    end,
}