local v1 = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local Toggle = require(script.Components.Toggle)
local NumberSlider = require(script.Components.NumberSlider)
local Header = require(script.Components.Header)
local Dropdown = require(script.Components.Dropdown)
local Button = require(script.Components.Button)
local Bind = require(script.Components.Bind)
local BindsHeader = require(script.Components.BindsHeader)
local u50 = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)

function v1.Init(p1, p2, p3) -- Line: 22
    -- upvalues: Fusion (val), Children (val), u50 (val), Header (val), Toggle (val), NumberSlider (val), Button (val)
    -- upvalues: Dropdown (val), Bind (val), BindsHeader (val)
    local u6 = Fusion.scoped(Fusion)
    local u12 = u6:New("Sound")({Name = "button", SoundId = "rbxassetid://129190194679291", Parent = p2})
    local Frame = (p2:WaitForChild("Tabs")):WaitForChild("Frame")
    local Container = p2:WaitForChild("Container")
    local u25 = nil
    local u26 = {}
    local u27 = {}
    local u28 = {}

    function u27.SetContainer(p1, p2) -- Line: 38 -- upvalues: u28 (val), u25 (ref), u26 (val)
        for k, v in pairs(u28) do
            v.Visible = false
        end
        p2.ContainerUI.Visible = true
        if u25 then
            u25.Visible = false
        end
        local v1 = u26
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            j.Frame.BackgroundColor3 = Color3.new()
            j.Frame.UIStroke.Color = Color3.fromRGB(144, 144, 144)
        end
        p2.TabButton.Frame.BackgroundColor3 = Color3.fromRGB(86, 62, 28)
        p2.TabButton.Frame.UIStroke.Color = Color3.fromRGB(255, 184, 84)
        if u25 then
            u25.Visible = false
        end
    end

    function u27.Tab(p1, p2) -- Line: 57
        -- upvalues: u6 (val), Children (upval), u50 (upval), u26 (val), Container (val), u28 (val), u12 (val)
        -- upvalues: u27 (val), Frame (val), Header (upval), Toggle (upval), NumberSlider (upval), Button (upval)
        -- upvalues: Dropdown (upval), u25 (ref), Bind (upval), BindsHeader (upval)
        local v1 = u6:New("TextButton")
        local v2 = {
            Name = "Button",
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0.3),
            SizeConstraint = Enum.SizeConstraint.RelativeXX,
        }
        local v3 = Children
        local v4 = {}
        local v5 = u6:New("Frame")
        local v6 = {
            Name = "Frame",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.new(),
            BackgroundTransparency = 0.8,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.new(0.95, -8, 0.85, -8),
        }
        local v7 = Children
        local v8 = {}
        local v9 = u6:New("UICorner")({CornerRadius = UDim.new(0.2, 0)})
        local v10 = u6:New("UIStroke")({Thickness = 4, Color = Color3.fromRGB(144, 144, 144)})
        local v11 = u6:New("TextLabel")
        local v12 = {
            Name = "Label",
            BackgroundTransparency = 1,
            TextScaled = true,
            AnchorPoint = Vector2.new(0.5, 0.5),
            FontFace = u50,
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromScale(0.9, 0.85),
            Text = p2,
            TextColor3 = Color3.new(1, 1, 1),
        }
        v8[1] = v9
        v8[2] = v10
        v8[3] = v11(v12)
        v6[v7] = v8
        v4[1] = v5(v6)
        v2[v3] = v4
        v1 = v1(v2)
        v3 = u26
        table.insert(v3, v1)
        local u97 = {UIElements = {}}
        v3 = u6:New("ScrollingFrame")
        v4 = {
            Name = p2,
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundTransparency = 1,
            BottomImage = "",
            CanvasSize = UDim2.fromOffset(0, 346),
            Position = UDim2.fromScale(0.5, 0.5),
            ScrollBarImageColor3 = Color3.fromRGB(16, 16, 16),
            ScrollBarThickness = 3,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Selectable = false,
            Size = UDim2.new(1, -5, 1, -5),
            TopImage = "",
            Visible = false,
        }
        v5 = Children
        v4[v5] = {u6:New("UIListLayout")({Name = "UIListLayout", SortOrder = Enum.SortOrder.LayoutOrder})}
        local u145 = v3(v4)
        local UIListLayout = u145:FindFirstChild("UIListLayout")
        ;(UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function() -- Line: 127 -- upvalues: u145 (val), UIListLayout (val)
            u145.CanvasSize = UDim2.fromOffset(0, UIListLayout.AbsoluteContentSize.Y)
        end)
        u145.Parent = Container
        v6 = u28
        table.insert(v6, u145)
        v1.MouseButton1Click:Connect(function() -- Line: 134 -- upvalues: u12 (upval), u27 (upval), u97 (val)
            u12:Play()
            local v1 = u27
            local v2 = u97
            v1:SetContainer(v2)
        end)
        u97.ContainerUI = u145
        u97.TabButton = v1
        v1.Parent = Frame
        local u169 = 0
        local u170 = nil

        function u97.Header(p1, p2) -- Line: 146
            -- upvalues: u169 (ref), Header (upval), u6 (upval), u12 (upval), u145 (val), u170 (ref), u97 (val)
            local v1
            u169 = u169 + 1
            local v2 = Header
            v2, v1 = v2({scope = u6, Text = p2, LayoutOrder = u169, ButtonSound = u12})
            v2.Parent = u145
            u170 = v1
            u97.UIElements[p2] = v2
            return v2, v1
        end

        function u97.Toggle(p1, p2, p3, p4, p5) -- Line: 160
            -- upvalues: u169 (ref), Toggle (upval), u6 (upval), u12 (upval), u170 (ref), u145 (val), u97 (val)
            local v1
            u169 = u169 + 1
            local v2 = Toggle
            v2, v1 = v2({
                scope = u6,
                Text = p2,
                Default = p3,
                OnChanged = p4,
                Description = p5,
                LayoutOrder = u169,
                ButtonSound = u12,
                Visible = u170,
            })
            v2.Parent = u145
            u97.UIElements[p2] = v2
            return v1
        end

        function u97.Number(p1, p2, p3, p4, p5, p6, p7) -- Line: 178
            -- upvalues: u169 (ref), NumberSlider (upval), u6 (upval), u170 (ref), u145 (val), u97 (val)
            local v1
            u169 = u169 + 1
            local v2 = NumberSlider
            v2, v1 = v2({
                scope = u6,
                Text = p2,
                Default = p3,
                OnChanged = p4,
                Min = p5,
                Max = p6,
                SnapFactor = p7,
                LayoutOrder = u169,
                Visible = u170,
            })
            v2.Parent = u145
            u97.UIElements[p2] = v2
            return v1
        end

        function u97.Button(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 197
            -- upvalues: u169 (ref), Button (upval), u6 (upval), u12 (upval), u170 (ref), u145 (val), u97 (val)
            u169 = u169 + 1
            local v1 = Button
            v1 = v1({
                scope = u6,
                Text = p2,
                ButtonText = p3,
                OnClick = p4,
                OutlineColor = p5,
                FillColor = p6,
                TextColor = p7,
                Description = p8,
                LayoutOrder = u169,
                ButtonSound = u12,
                Visible = u170,
            })
            v1.Parent = u145
            u97.UIElements[p2] = v1
            return v1
        end

        function u97.Dropdown(p1, p2, p3, p4, p5, p6) -- Line: 218
            -- upvalues: u169 (ref), Dropdown (upval), u6 (upval), u12 (upval), u170 (ref), u25 (upval)
            -- upvalues: Container (upval), u145 (val), u97 (val)
            local v1, v2
            u169 = u169 + 1
            local v3 = Dropdown
            v3, v1, v2 = v3({
                scope = u6,
                Text = p2,
                Options = p3,
                Default = p4,
                OnChanged = p5,
                Description = p6,
                LayoutOrder = u169,
                ButtonSound = u12,
                Visible = u170,
                OnDropdownOpened = function(p1) -- Line: 230 -- upvalues: u25 (upval)
                    u25 = p1
                end,
            })
            v1.Parent = Container
            v3.Parent = u145
            u97.UIElements[p2] = v3
            return v2
        end

        function u97.Bind(p1, p2, p3) -- Line: 242
            -- upvalues: u169 (ref), Bind (upval), u6 (upval), u170 (ref), u145 (val), u97 (val)
            u169 = u169 + 1
            local v1 = Bind
            v1 = v1({
                scope = u6,
                Text = p2,
                Description = p3,
                LayoutOrder = u169,
                Visible = u170,
            })
            v1.Parent = u145
            u97.UIElements[p2] = v1
            return v1
        end

        function u97.BindsHeader(p1) -- Line: 257
            -- upvalues: u169 (ref), BindsHeader (upval), u6 (upval), u145 (val), u97 (val)
            u169 = u169 + 1
            local v1 = BindsHeader
            v1 = v1({scope = u6, LayoutOrder = u169})
            v1.Parent = u145
            u97.UIElements.BindsHeader = v1
        end

        return u97
    end

    return u27
end

return v1