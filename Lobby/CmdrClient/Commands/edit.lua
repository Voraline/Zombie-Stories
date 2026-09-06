local Players = game:GetService("Players")
local u5 = {
    BackgroundTransparency = 0.05,
    BorderSizePixel = 20,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextWrapped = true,
    TextSize = 18,
    TextXAlignment = "Left",
    TextYAlignment = "Top",
    AutoLocalize = false,
    PlaceholderText = "Right click to exit",
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(17, 17, 17),
    BorderColor3 = Color3.fromRGB(17, 17, 17),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0.5, 0, 0.4, 0),
    Font = Enum.Font.Code,
    TextColor3 = Color3.fromRGB(241, 241, 241),
}
local u38 = nil
local v1 = {
    Name = "edit",
    Description = "Edit text in a TextBox",
    Group = "DefaultUtil",
    Aliases = {},
    Args = {
        {Type = "string", Name = "Input text", Description = "The text you wish to edit", Default = ""},
        {Type = "string", Name = "Delimiter", Description = "The character that separates each line", Default = ","},
    },
}
function v1.ClientRun(p1, p2, p3) -- Line: 45 -- upvalues: u38 (ref), u5 (val), Players (val)
    local v1 = u38
    if not v1 then
        v1 = p1.Cmdr.Util.Mutex()
    end
    u38 = v1
    local u10 = u38()
    p1:Reply("Right-click on the text area to exit.", Color3.fromRGB(158, 158, 158))
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CmdrEditBox"
    ScreenGui.ResetOnSpawn = false
    local TextBox = Instance.new("TextBox")
    for k, v in pairs(u5) do
        TextBox[k] = v
    end
    TextBox.Text = p2:gsub(p3, "\n")
    TextBox.Parent = ScreenGui
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    local u57 = coroutine.running()
    TextBox.InputBegan:Connect(function(p1) -- Line: 69 -- upvalues: u57 (val), TextBox (val), p3 (val), ScreenGui (val), u10 (val)
        if p1.UserInputType == Enum.UserInputType.MouseButton2 then
            coroutine.resume(u57, TextBox.Text:gsub("\n", p3))
            ScreenGui:Destroy()
            u10()
        end
    end)
    return coroutine.yield()
end
return v1