local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Enabled = false
ScreenGui.Name = "RichText_Sizing"
local TextLabel = Instance.new("TextLabel")
TextLabel.TextWrapped = true
TextLabel.RichText = true
TextLabel.Parent = ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
return function(p1, p2, p3, p4) -- Line: 16 -- upvalues: TextLabel (val)
    if type(p1) ~= "string" then
        return Vector2.new(0, 0)
    end
    TextLabel.Text = p1
    TextLabel.TextSize = p2
    TextLabel.Font = p3
    TextLabel.Size = UDim2.new(0, p4.X, 0, p4.Y)
    return TextLabel.TextBounds
end