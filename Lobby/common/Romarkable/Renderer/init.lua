local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Parent = require(script.Parent)
local BlockType = Parent.BlockType
local Fusion = require(ReplicatedStorage.common:FindFirstChild("Fusion", true))
local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange
local Value = Fusion.Value
local Computed = Fusion.Computed
local ForPairs = Fusion.ForPairs
local u36 = require("@self/theme")
u36.init(Value("Nord"))
local u44 = require("@self/getImageId")
local u47 = require("@self/getRichTextSize")
local u50 = require("@self/highlight")
local function setTrueImage(p1, p2, p3) -- Line: 20 -- upvalues: u44 (val)
    task.wait(math.random(0, 70) / 100)
    local v1 = u44(p3 or "rbxassetid://6266306999")
    if v1 then
        p1:set(v1)
    end
end
local u52 = {}
local v1 = {}
v1[BlockType.Paragraph] = function(p1, p2, p3) -- Line: 35 -- upvalues: New (val), Children (val), u36 (val), Computed (val)
    local Frame = New("Frame")
    local v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = p3,
    }
    local v2 = {}
    local TextLabel = New("TextLabel")
    v2[1] = TextLabel({
        RichText = true,
        BackgroundTransparency = 1,
        TextWrapped = true,
        Font = Enum.Font.SourceSans,
        TextColor3 = u36.mainText,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = Computed(function() -- Line: 55 -- upvalues: u36 (upval)
            local v1 = -u36.textSize:get()
            return UDim2.new(1, v1, 0, 0)
        end),
        Position = Computed(function() -- Line: 58 -- upvalues: u36 (upval)
            local v1 = u36.textSize:get()
            return UDim2.new(0, v1, 0, 0)
        end),
        ZIndex = p3,
        Text = p1.Text,
        TextSize = u36.textSize,
    })
    v1[Children] = v2
    return Frame(v1)
end
v1[BlockType.Heading] = function(p1, p2, p3) -- Line: 70 -- upvalues: New (val), Children (val), u36 (val), Computed (val)
    local Frame = New("Frame")
    local v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        ZIndex = p3,
    }
    local v2 = {}
    local TextLabel = New("TextLabel")
    local v3 = {RichText = true, BackgroundTransparency = 1, TextWrapped = true, Font = Enum.Font.SourceSansBold}
    local mainText = u36["h" .. p1.Level]
    if not mainText then
        mainText = u36.mainText
    end
    v3.TextColor3 = mainText
    v3.TextXAlignment = Enum.TextXAlignment.Left
    v3.TextYAlignment = Enum.TextYAlignment.Top
    v3.AutomaticSize = Enum.AutomaticSize.Y
    v3.Size = Computed(function() -- Line: 90 -- upvalues: u36 (upval)
        local v1 = -u36.textSize:get()
        return UDim2.new(1, v1, 0, 0)
    end)
    v3.Position = Computed(function() -- Line: 93 -- upvalues: u36 (upval)
        local v1 = u36.textSize:get()
        return UDim2.new(0, v1, 0, 0)
    end)
    v3.ZIndex = p3
    v3.Text = p1.Text
    v3.TextSize = Computed(function() -- Line: 99 -- upvalues: p1 (val), u36 (upval)
        local v1 = u36.headerSize:get()
        return v1 * ((5 - math.clamp(p1.Level, 1, 5)) * 0.3 + 1)
    end)
    v2[1] = TextLabel(v3)
    v1[Children] = v2
    return Frame(v1)
end
v1[BlockType.Image] = function(p1, p2, p3) -- Line: 108 -- upvalues: Value (val), setTrueImage (val), New (val), Computed (val), OnChange (val), Children (val)
    local v1 = Value("")
    local v2 = Value(Enum.ScaleType.Stretch)
    local u11 = Value(10)
    task.spawn(setTrueImage, v1, v2, p1.ID)
    local Frame = New("Frame")
    local v3 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        Size = Computed(function() -- Line: 119 -- upvalues: u11 (val), p1 (val)
            local v1 = u11:get()
            return UDim2.new(1, 0, 0, v1 * p1.Scale * 0.6)
        end),
        ZIndex = p3,
    }
    local AbsoluteSize = OnChange("AbsoluteSize")
    v3[AbsoluteSize] = function(a1) -- Line: 124 -- upvalues: u11 (val), p1 (val)
        u11:set(a1.X / p1.AspectRatio)
    end
    local v4 = {}
    local ImageLabel = New("ImageLabel")
    local v5 = {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0.6 * p1.Scale, 1),
        Position = Computed(function() -- Line: 132
            return UDim2.new(0.5, 0, 0, 0)
        end),
        AnchorPoint = Vector2.new(0.5, 0),
        Image = v1,
        ScaleType = v2,
        ZIndex = p3,
    }
    local v6 = {}
    local UICorner = New("UICorner")
    v6[1] = UICorner({Name = "UICorner", CornerRadius = UDim.new(0.05, 0)})
    v5[Children] = v6
    v4[1] = ImageLabel(v5)
    v3[Children] = v4
    return Frame(v3)
end
v1[BlockType.Code] = function(p1, p2, p3) -- Line: 151 -- upvalues: Computed (val), u47 (val), u36 (val), New (val), OnEvent (val), UserInputService (val), OnChange (val), u50 (val), Children (val)
    local SelectionStart
    p1.Code = string.gsub(p1.Code, "\t", "    ")
    local u10 = Computed(function() -- Line: 154 -- upvalues: u47 (upval), p1 (val), u36 (upval)
        local v1 = u36.textSize:get()
        return u47(p1.Code, v1, Enum.Font.Code, Vector2.new(9999, 9999))
    end)
    local u11 = nil
    local TextBox = New("TextBox")
    local v1 = {
        TextEditable = false,
        ShowNativeInput = false,
        MultiLine = true,
        ClearTextOnFocus = false,
        Font = Enum.Font.Code,
        TextColor3 = u36.scriptBackground,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = false,
        TextTransparency = 0.6,
        Size = Computed(function() -- Line: 174 -- upvalues: u36 (upval), u10 (val)
            local v1 = -u36.textSize:get()
            return UDim2.new(1, v1, 0, u10:get().Y + 2)
        end),
        Position = Computed(function() -- Line: 177 -- upvalues: u36 (upval)
            local v1 = u36.textSize:get()
            return UDim2.new(0, v1, 0, 1)
        end),
        ZIndex = p3 - 1,
    }
    local Focused = OnEvent("Focused")
    v1[Focused] = function() -- Line: 183 -- upvalues: UserInputService (upval), u11 (ref)
        if not UserInputService.KeyboardEnabled then
            task.wait()
            u11:ReleaseFocus(false)
            return
        end
        task.wait(0.15)
        if u11.SelectionStart == -1 then
            u11:ReleaseFocus(false)
        end
    end
    SelectionStart = OnChange("SelectionStart")
    v1[SelectionStart] = function(p1, p2) -- Line: 194 -- upvalues: u11 (ref)
        if u11.SelectionStart == -1 then
            u11:ReleaseFocus(false)
        end
    end
    v1.Text = p1.Code
    v1.TextSize = u36.textSize
    u11 = TextBox(v1)
    task.defer(u50.Highlight, u11, p1.Code, p1.Syntax)
    local ScrollingFrame = New("ScrollingFrame")
    v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundColor3 = u36.scriptBackground,
        Size = Computed(function() -- Line: 210 -- upvalues: u10 (val), u36 (upval)
            return UDim2.new(1, 0, 0, u10:get().Y + u36.headerSize:get())
        end),
        CanvasSize = Computed(function() -- Line: 213 -- upvalues: u10 (val)
            local v1 = u10:get().X + 40
            return UDim2.fromOffset(v1, 0)
        end),
        ScrollingDirection = Enum.ScrollingDirection.X,
        ZIndex = p3,
    }
    v1[Children] = {u11}
    return ScrollingFrame(v1)
end
v1[BlockType.List] = function(p1, p2, p3) -- Line: 225 -- upvalues: Value (val), u36 (val), New (val), Computed (val), Children (val), OnChange (val), ForPairs (val)
    local v1 = u36.textSize:get()
    local u12 = Value(v1 * #p1.Lines)
    local Frame = New("Frame")
    v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = Computed(function() -- Line: 233
            return UDim2.new(1, 0, 0, 0)
        end),
        ZIndex = p3,
    }
    local v2 = {}
    local UIListLayout = New("UIListLayout")
    local v3 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 3),
    }
    local AbsoluteContentSize = OnChange("AbsoluteContentSize")
    v3[AbsoluteContentSize] = function(p1) -- Line: 245 -- upvalues: u12 (val)
        u12:set(p1.Y)
    end
    local v4 = UIListLayout(v3)
    v2[1] = v4
    v2[2] = ForPairs(p1.Lines, function(p1, p2) -- Line: 249 -- upvalues: New (upval), u36 (upval), Computed (upval), p3 (val)
        local TextLabel = New("TextLabel")
        local v1 = {
            RichText = true,
            BackgroundTransparency = 1,
            TextWrapped = true,
            LayoutOrder = p1,
            Name = p1,
            Font = Enum.Font.SourceSans,
            TextColor3 = u36.mainText,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            AutomaticSize = Enum.AutomaticSize.Y,
            Size = Computed(function() -- Line: 261 -- upvalues: u36 (upval)
                local v1 = -u36.textSize:get()
                return UDim2.new(1, v1, 0, 0)
            end),
            ZIndex = p3,
        }
        local v2 = string.rep("  ", p2.Level)
        local v3 = p2.Symbol:match("%w+[%.%)]") or "•"
        v1.Text = v2 .. v3 .. " " .. p2.Text
        v1.TextSize = u36.textSize
        return p1, TextLabel(v1)
    end, function(p1) -- Line: 269
        p1:Destroy()
    end)
    v1[Children] = v2
    return Frame(v1)
end
v1[BlockType.Quote] = function(p1, p2, p3) -- Line: 277 -- upvalues: Value (val), Computed (val), u36 (val), New (val), OnChange (val), Children (val), u52 (val)
    local u5 = Value(0)
    local u8 = Value(10)
    local v1 = Computed(function() -- Line: 281 -- upvalues: u8 (val), u36 (upval)
        local v1 = u8:get()
        return v1 - u36.textSize:get()
    end)
    local Frame = New("Frame")
    local v2 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        Size = Computed(function() -- Line: 289 -- upvalues: u5 (val)
            return UDim2.new(1, 0, 0, u5:get() + 2)
        end),
        ZIndex = p3,
    }
    local AbsoluteSize = OnChange("AbsoluteSize")
    v2[AbsoluteSize] = function(p1) -- Line: 294 -- upvalues: u8 (val)
        u8:set(p1.X)
    end
    local v3 = {}
    local Frame_2 = New("Frame")
    local v4 = Frame_2({
        Name = "Line",
        BackgroundColor3 = u36.light,
        AnchorPoint = Vector2.new(1, 0.5),
        Size = Computed(function() -- Line: 303 -- upvalues: u36 (upval)
            local v1 = u36.textSize:get()
            return UDim2.new(0, v1 * 0.3, 1, v1 * -0.1)
        end),
        Position = Computed(function() -- Line: 307 -- upvalues: u36 (upval)
            local v1 = u36.textSize:get()
            return UDim2.new(0, v1, 0.5, 0)
        end),
        ZIndex = p3,
    })
    local Frame_3 = New("Frame")
    local v5 = {
        Name = "Container",
        BackgroundColor3 = u36.darkBackground,
        Position = Computed(function() -- Line: 315 -- upvalues: u36 (upval)
            local v1 = u36.textSize:get() * 1.2
            return UDim2.new(0, v1, 0, 0)
        end),
        Size = Computed(function() -- Line: 318 -- upvalues: u36 (upval)
            local v1 = u36.textSize:get() * -1.2
            return UDim2.new(1, v1, 1, 0)
        end),
        ZIndex = p3,
    }
    local v6 = {}
    local UIListLayout = New("UIListLayout")
    local v7 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 3),
    }
    local AbsoluteContentSize = OnChange("AbsoluteContentSize")
    v7[AbsoluteContentSize] = function(p1) -- Line: 329 -- upvalues: u5 (val)
        u5:set(p1.Y)
    end
    local v8 = UIListLayout(v7)
    local v9 = p1.RawText or ""
    v6[1] = v8
    v6[2] = u52.Render(v9, v1)
    v5[Children] = v6
    v3[1] = v4
    v3[2] = Frame_3(v5)
    v2[Children] = v3
    return Frame(v2)
end
v1[BlockType.Ruler] = function(p1, p2, p3) -- Line: 340 -- upvalues: New (val), Children (val), u36 (val), Computed (val)
    local Frame = New("Frame")
    local v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 5),
        ZIndex = p3,
    }
    local v2 = {}
    local Frame_2 = New("Frame")
    v2[1] = Frame_2({
        Name = "ruler",
        BackgroundColor3 = u36.light,
        Size = Computed(function() -- Line: 352 -- upvalues: u36 (upval)
            local v1 = -u36.textSize:get()
            return UDim2.new(1, v1, 0, u36.textSize:get() * 0.2)
        end),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = p3,
    })
    v1[Children] = v2
    return Frame(v1)
end
u52.BlockToGui = v1
function u52.Render(p1, p2) -- Line: 364 -- upvalues: Parent (val), u52 (val), BlockType (val)
    local v1, v2
    local v3 = {}
    local v4 = 0
    for i, j in Parent.parse(p1) do
        v4 = v4 + 1
        v1 = u52.BlockToGui[i]
        if not v1 then
            v1 = u52.BlockToGui[BlockType.Paragraph]
        end
        v2, v1 = pcall(v1, j, v4, v5)
        if not v2 then
            warn(v1)
        else
            v3[v4] = v1
        end
    end
    return v3
end
return function(p1) -- Line: 385 -- upvalues: Value (val), New (val), Children (val), Computed (val), u36 (val), OnChange (val), u52 (val)
    local u6 = Value(UDim2.fromScale(1, 0))
    local Frame = New("Frame")
    local v1 = {
        Name = p1.Name or "MarkdownContainer",
        Size = u6,
        Position = p1.Position,
        BackgroundTransparency = 1,
        LayoutOrder = p1.LayoutOrder,
        ZIndex = p1.ZIndex,
    }
    local v2 = {}
    local UIListLayout = New("UIListLayout")
    local v3 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = Computed(function() -- Line: 402 -- upvalues: u36 (upval)
            return UDim.new(0, u36.textSize:get())
        end),
    }
    local AbsoluteContentSize = OnChange("AbsoluteContentSize")
    v3[AbsoluteContentSize] = function(p1) -- Line: 405 -- upvalues: u6 (val), u36 (upval)
        u6:set(UDim2.new(1, 0, 0, p1.Y + u36.textSize:get() * 2))
    end
    local v4 = UIListLayout(v3)
    v2[1] = v4
    v2[2] = Computed(function() -- Line: 410 -- upvalues: u52 (upval), p1 (val)
        local v1 = p1.Text:get()
        return u52.Render(v1, p1.ZIndex)
    end)
    v1[Children] = v2
    return Frame(v1)
end