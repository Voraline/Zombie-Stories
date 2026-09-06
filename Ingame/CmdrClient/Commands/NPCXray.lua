local UIDLabel, v1
local RunService = game:GetService("RunService")
local NPCRegistry = require(game.ReplicatedStorage.common.NPCRegistry)
local u11 = false
local u12 = {}
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NPCXray"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
local Frame = Instance.new("Frame")
Frame.BackgroundTransparency = 1
local v2 = Instance.new("UIStroke", Frame)
v2.Color = Color3.new(0, 1, 0)
v2.Thickness = 1
v2.LineJoinMode = Enum.LineJoinMode.Round
local v3 = Instance.new("TextLabel", Frame)
v3.Name = "UIDLabel"
v3.Position = UDim2.new(0.5, 0, 0.5, 0)
v3.Size = UDim2.new(1, 0, 1, 0)
v3.BackgroundTransparency = 1
v3.Text = "123"
v3.TextColor3 = Color3.new(0, 1, 0)
v3.FontFace = Font.new("SourceSansPro", Enum.FontWeight.Bold)
v3.AnchorPoint = Vector2.new(0.5, 0.5)
local function setupXray(p1) -- Line: 31 -- upvalues: Frame (val), ScreenGui (val), u12 (val)
    local v1 = Frame:Clone()
    local UIDLabel = v1:WaitForChild("UIDLabel")
    UIDLabel.Text = p1.UID
    v1.Parent = ScreenGui
    u12[p1] = {v1, UIDLabel}
end
local function updateXrays() -- Line: 39 -- upvalues: u12 (val)
    local BoundingBox, BoundingBox_2, X, X_2, Y, Y_2, Z, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11
    local v12 = u12
    local v13 = nil
    local v14 = nil
    for i, j in v12, v13, v14 do
        if i.Model then
            v9 = j[1]
            v10 = j[2]
            BoundingBox, BoundingBox_2 = i.Model:GetBoundingBox()
            v11 = false
            X = nil
            Y = nil
            X_2 = nil
            Y_2 = nil
            Z = nil
            v1 = 1
            v2 = 2
            for k = -1, v1, v2 do
                v3 = 1
                v4 = 2
                for n = -1, v3, v4 do
                    v5 = 1
                    v6 = 2
                    for m = -1, v5, v6 do
                        v7 = BoundingBox * CFrame.new(k * 0.5 * BoundingBox_2.X, n * 0.5 * BoundingBox_2.Y, m * 0.5 * BoundingBox_2.Z)
                        v8 = workspace.CurrentCamera:WorldToViewportPoint(v7.Position)
                        if v8.Z < 0 then
                            v11 = true
                        end
                        if not X then
                            X = v8.X
                            Y = v8.Y
                            X_2 = v8.X
                            Y_2 = v8.Y
                        else
                            X = math.max(X, v8.X)
                            Y = math.max(Y, v8.Y)
                            X_2 = math.min(X_2, v8.X)
                            Y_2 = math.min(Y_2, v8.Y)
                            Z = v8.Z
                        end
                    end
                end
            end
            v9.Visible = not v11
            v9.Position = UDim2.new(0, X_2, 0, Y_2)
            v9.Size = UDim2.new(0, X - X_2, 0, Y - Y_2)
            v10.TextSize = 700 / Z
        end
    end
end
if RunService:IsClient() then
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
    for i, j in NPCRegistry:GetAllNPCs() do
        v1 = Frame:Clone()
        UIDLabel = v1:WaitForChild("UIDLabel")
        UIDLabel.Text = j.UID
        v1.Parent = ScreenGui
        u12[j] = {v1, UIDLabel}
    end
    NPCRegistry.NPCAdded:Connect(function(p1) -- Line: 91 -- upvalues: Frame (val), ScreenGui (val), u12 (val)
        local v1 = Frame:Clone()
        local UIDLabel = v1:WaitForChild("UIDLabel")
        UIDLabel.Text = p1.UID
        v1.Parent = ScreenGui
        u12[p1] = {v1, UIDLabel}
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
        local v1
        u11 = not u11
        if not u11 then
            RunService:UnbindFromRenderStep("NPCXray")
            local v2 = u12
            local v3 = nil
            v1 = nil
            for i, j in v2, v3, v1 do
                j[1].Visible = false
            end
        else
            RunService:BindToRenderStep("NPCXray", Enum.RenderPriority.Input.Value - 1, updateXrays)
        end
        if not u11 then
            v1 = "disabled"
        else
            v1 = "enabled"
        end
        return string.format("NPC Xray %s", v1)
    end,
}