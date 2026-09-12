local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Parent = require(script.Parent)
local BlockType = Parent.BlockType
local Fusion = require(ReplicatedStorage.common:FindFirstChild("Fusion", true))
local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange
local Out = Fusion.Out
local Ref = Fusion.Ref
local Value = Fusion.Value
local Observer = Fusion.Observer
local Computed = Fusion.Computed
local ForPairs = Fusion.ForPairs
local Spring = Fusion.Spring
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
local Paragraph = BlockType.Paragraph

v1[Paragraph] = function(p1, p2, p3) -- Line: 35 -- upvalues: New (val), Children (val), u36 (val), Computed (val)
    local Frame = New("Frame")
    local v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        ZIndex = p3,
    }
    local v2 = Children
    local v3 = {}
    local TextLabel = New("TextLabel")
    local v4 = {
        RichText = true,
        BackgroundTransparency = 1,
        TextWrapped = true,
        Font = Enum.Font.SourceSans,
        TextColor3 = u36.mainText,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AutomaticSize = Enum.AutomaticSize.Y,
    }
    local v5 = Computed
    v4.Size = v5(function() -- Line: 55 -- upvalues: u36 (upval)
        return UDim2.new(1, -u36.textSize:get(), 0, 0)
    end)
    v5 = Computed
    v4.Position = v5(function() -- Line: 58 -- upvalues: u36 (upval)
        return UDim2.new(0, u36.textSize:get(), 0, 0)
    end)
    v4.ZIndex = p3
    v4.Text = p1.Text
    v4.TextSize = u36.textSize
    v3[1] = TextLabel(v4)
    v1[v2] = v3
    return Frame(v1)
end

local Heading = BlockType.Heading

v1[Heading] = function(p1, p2, p3) -- Line: 70 -- upvalues: New (val), Children (val), u36 (val), Computed (val)
    local Frame = New("Frame")
    local v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),
        ZIndex = p3,
    }
    local v2 = Children
    local v3 = {}
    local TextLabel = New("TextLabel")
    local v4 = {RichText = true, BackgroundTransparency = 1, TextWrapped = true, Font = Enum.Font.SourceSansBold}
    local mainText = u36["h" .. p1.Level]
    if not mainText then
        mainText = u36.mainText
    end
    v4.TextColor3 = mainText
    v4.TextXAlignment = Enum.TextXAlignment.Left
    v4.TextYAlignment = Enum.TextYAlignment.Top
    v4.AutomaticSize = Enum.AutomaticSize.Y
    local v5 = Computed
    v4.Size = v5(function() -- Line: 90 -- upvalues: u36 (upval)
        return UDim2.new(1, -u36.textSize:get(), 0, 0)
    end)
    v5 = Computed
    v4.Position = v5(function() -- Line: 93 -- upvalues: u36 (upval)
        return UDim2.new(0, u36.textSize:get(), 0, 0)
    end)
    v4.ZIndex = p3
    v4.Text = p1.Text
    v5 = Computed
    v4.TextSize = v5(function() -- Line: 99 -- upvalues: p1 (val), u36 (upval)
        local v1 = p1
        local Level = v1.Level
        local v2 = 5 - (math.clamp(Level, 1, 5))
        return (u36.headerSize:get()) * (v2 * 0.3 + 1)
    end)
    v3[1] = TextLabel(v4)
    v1[v2] = v3
    return Frame(v1)
end

local Image = BlockType.Image

v1[Image] = function(p1, p2, p3) -- Line: 108
    -- upvalues: Value (val), setTrueImage (val), New (val), Computed (val), OnChange (val), Children (val)
    local v1 = Value("")
    local v2 = Value(Enum.ScaleType.Stretch)
    local u11 = Value(10)
    task.spawn(setTrueImage, v1, v2, p1.ID)
    local Frame = New("Frame")
    local v3 = {Name = p2, LayoutOrder = p2, BackgroundTransparency = 1}
    local v4 = Computed
    v3.Size = v4(function() -- Line: 119 -- upvalues: u11 (val), p1 (val)
        return UDim2.new(1, 0, 0, (u11:get()) * p1.Scale * 0.6)
    end)
    v3.ZIndex = p3
    local AbsoluteSize = OnChange("AbsoluteSize")

    v3[AbsoluteSize] = function(p1_2) -- Line: 124 -- upvalues: u11 (val), p1 (val)
        local v1 = u11
        local X = p1_2.X
        local v2 = p1
        local v3 = X / v2.AspectRatio
        v1:set(v3)
    end

    v4 = Children
    local v5 = {}
    local ImageLabel = New("ImageLabel")
    local v6 = {
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
    local v7 = Children
    v6[v7] = {New("UICorner")({Name = "UICorner", CornerRadius = UDim.new(0.05, 0)})}
    v5[1] = ImageLabel(v6)
    v3[v4] = v5
    return Frame(v3)
end

local Code = BlockType.Code

v1[Code] = function(p1, p2, p3) -- Line: 151
    -- upvalues: Computed (val), u47 (val), u36 (val), New (val), OnEvent (val), UserInputService (val), OnChange (val)
    -- upvalues: u50 (val), Children (val)
    p1.Code = string.gsub(p1.Code, "\t", "    ")
    local v1 = Computed
    local u10 = v1(function() -- Line: 154 -- upvalues: u47 (upval), p1 (val), u36 (upval)
        local v1 = u47
        local v2 = p1
        return v1(v2.Code, u36.textSize:get(), Enum.Font.Code, Vector2.new(9999, 9999))
    end)
    local u11 = nil
    local TextBox = New("TextBox")
    local v2 = {
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
    }
    local v3 = Computed
    v2.Size = v3(function() -- Line: 174 -- upvalues: u36 (upval), u10 (val)
        return UDim2.new(1, -u36.textSize:get(), 0, u10:get().Y + 2)
    end)
    v3 = Computed
    v2.Position = v3(function() -- Line: 177 -- upvalues: u36 (upval)
        return UDim2.new(0, u36.textSize:get(), 0, 1)
    end)
    v2.ZIndex = p3 - 1
    local Focused = OnEvent("Focused")

    v2[Focused] = function() -- Line: 183 -- upvalues: UserInputService (upval), u11 (ref)
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

    local SelectionStart = OnChange("SelectionStart")

    v2[SelectionStart] = function(p1, p2) -- Line: 194 -- upvalues: u11 (ref)
        if u11.SelectionStart == -1 then
            u11:ReleaseFocus(false)
        end
    end

    v2.Text = p1.Code
    v2.TextSize = u36.textSize
    u11 = TextBox(v2)
    task.defer(u50.Highlight, u11, p1.Code, p1.Syntax)
    local ScrollingFrame = New("ScrollingFrame")
    v2 = {Name = p2, LayoutOrder = p2, BackgroundColor3 = u36.scriptBackground}
    v3 = Computed
    v2.Size = v3(function() -- Line: 210 -- upvalues: u10 (val), u36 (upval)
        return UDim2.new(1, 0, 0, u10:get().Y + u36.headerSize:get())
    end)
    v3 = Computed
    v2.CanvasSize = v3(function() -- Line: 213 -- upvalues: u10 (val)
        return UDim2.fromOffset(u10:get().X + 40, 0)
    end)
    v2.ScrollingDirection = Enum.ScrollingDirection.X
    v2.ZIndex = p3
    v3 = Children
    v2[v3] = {u11}
    local v4 = ScrollingFrame(v2)
    return v4
end

local List = BlockType.List

v1[List] = function(p1, p2, p3) -- Line: 225
    -- upvalues: Value (val), u36 (val), New (val), Computed (val), Children (val), OnChange (val), ForPairs (val)
    local v1 = Value
    local u12 = v1((u36.textSize:get()) * #p1.Lines)
    local Frame = New("Frame")
    local v2 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = Computed(function() -- Line: 233
            return UDim2.new(1, 0, 0, 0)
        end),
        ZIndex = p3,
    }
    local v3 = Children
    local v4 = {}
    local UIListLayout = New("UIListLayout")
    local v5 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 3),
    }
    local AbsoluteContentSize = OnChange("AbsoluteContentSize")

    v5[AbsoluteContentSize] = function(p1) -- Line: 245 -- upvalues: u12 (val)
        local v1 = u12
        local Y = p1.Y
        v1:set(Y)
    end

    local v6 = UIListLayout(v5)
    v5 = ForPairs
    local Lines = p1.Lines
    v4[1] = v6
    v4[2] = v5(Lines, function(p1, p2) -- Line: 249 -- upvalues: New (upval), u36 (upval), Computed (upval), p3 (val)
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
        }
        local v2 = Computed
        v1.Size = v2(function() -- Line: 261 -- upvalues: u36 (upval)
            return UDim2.new(1, -u36.textSize:get(), 0, 0)
        end)
        v1.ZIndex = p3
        v1.Text = (string.rep("  ", p2.Level)) .. (p2.Symbol:match("%w+[%.%)]") or "•") .. " " .. p2.Text
        v1.TextSize = u36.textSize
        return p1, TextLabel(v1)
    end, function(p1) -- Line: 269
        p1:Destroy()
    end)
    v2[v3] = v4
    return Frame(v2)
end

local Quote = BlockType.Quote

v1[Quote] = function(p1, p2, p3) -- Line: 277
    -- upvalues: Value (val), Computed (val), u36 (val), New (val), OnChange (val), Children (val), u52 (val)
    local u5 = Value(0)
    local u8 = Value(10)
    local v1 = Computed
    v1 = v1(function() -- Line: 281 -- upvalues: u8 (val), u36 (upval)
        return (u8:get()) - u36.textSize:get()
    end)
    local Frame = New("Frame")
    local v2 = {Name = p2, LayoutOrder = p2, BackgroundTransparency = 1}
    local v3 = Computed
    v2.Size = v3(function() -- Line: 289 -- upvalues: u5 (val)
        return UDim2.new(1, 0, 0, u5:get() + 2)
    end)
    v2.ZIndex = p3
    local AbsoluteSize = OnChange("AbsoluteSize")

    v2[AbsoluteSize] = function(p1) -- Line: 294 -- upvalues: u8 (val)
        local v1 = u8
        local X = p1.X
        v1:set(X)
    end

    v3 = Children
    local v4 = {}
    local Frame_2 = New("Frame")
    local v5 = {Name = "Line", BackgroundColor3 = u36.light, AnchorPoint = Vector2.new(1, 0.5)}
    local v6 = Computed
    v5.Size = v6(function() -- Line: 303 -- upvalues: u36 (upval)
        local v1 = u36.textSize:get()
        return UDim2.new(0, v1 * 0.3, 1, v1 * -0.1)
    end)
    v6 = Computed
    v5.Position = v6(function() -- Line: 307 -- upvalues: u36 (upval)
        return UDim2.new(0, u36.textSize:get(), 0.5, 0)
    end)
    v5.ZIndex = p3
    local v7 = Frame_2(v5)
    local Frame_3 = New("Frame")
    v6 = {Name = "Container", BackgroundColor3 = u36.darkBackground}
    local v8 = Computed
    v6.Position = v8(function() -- Line: 315 -- upvalues: u36 (upval)
        return UDim2.new(0, u36.textSize:get() * 1.2, 0, 0)
    end)
    v8 = Computed
    v6.Size = v8(function() -- Line: 318 -- upvalues: u36 (upval)
        return UDim2.new(1, u36.textSize:get() * -1.2, 1, 0)
    end)
    v6.ZIndex = p3
    v8 = Children
    local v9 = {}
    local UIListLayout = New("UIListLayout")
    local v10 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
        Padding = UDim.new(0, 3),
    }
    local AbsoluteContentSize = OnChange("AbsoluteContentSize")

    v10[AbsoluteContentSize] = function(p1) -- Line: 329 -- upvalues: u5 (val)
        local v1 = u5
        local Y = p1.Y
        v1:set(Y)
    end

    local v11 = UIListLayout(v10)
    v10 = u52
    local Render = v10.Render
    local v12 = p1.RawText or ""
    v9[1] = v11
    v9[2] = Render(v12, v1)
    v6[v8] = v9
    v4[1] = v7
    v4[2] = Frame_3(v6)
    v2[v3] = v4
    return Frame(v2)
end

local Ruler = BlockType.Ruler

v1[Ruler] = function(p1, p2, p3) -- Line: 340 -- upvalues: New (val), Children (val), u36 (val), Computed (val)
    local Frame = New("Frame")
    local v1 = {
        Name = p2,
        LayoutOrder = p2,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 5),
        ZIndex = p3,
    }
    local v2 = Children
    local v3 = {}
    local Frame_2 = New("Frame")
    local v4 = {Name = "ruler", BackgroundColor3 = u36.light}
    local v5 = Computed
    v4.Size = v5(function() -- Line: 352 -- upvalues: u36 (upval)
        return UDim2.new(1, -u36.textSize:get(), 0, u36.textSize:get() * 0.2)
    end)
    v4.Position = UDim2.fromScale(0.5, 0.5)
    v4.AnchorPoint = Vector2.new(0.5, 0.5)
    v4.ZIndex = p3
    v3[1] = Frame_2(v4)
    v1[v2] = v3
    return Frame(v1)
end

u52.BlockToGui = v1

function u52.Render(p1, p2) -- Line: 364 -- upvalues: Parent (val), u52 (val), BlockType (val)
    local result, success, v1, v2
    local v3 = {}
    local v4 = 0
    for i, j in Parent.parse(p1) do
        v4 = v4 + 1
        v2 = pcall
        v1 = u52.BlockToGui[i]
        if not v1 then
            v1 = u52.BlockToGui[BlockType.Paragraph]
        end
        success, result = v2(v1, j, v4, v5)
        if not success then
            warn(result)
        else
            v3[v4] = result
        end
    end
    return v3
end

return function(p1) -- Line: 385
    -- upvalues: Value (val), New (val), Children (val), Computed (val), u36 (val), OnChange (val), u52 (val)
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
    local v2 = Children
    local v3 = {}
    local UIListLayout = New("UIListLayout")
    local v4 = {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Top,
    }
    local v5 = Computed
    v4.Padding = v5(function() -- Line: 402 -- upvalues: u36 (upval)
        return UDim.new(0, u36.textSize:get())
    end)
    local AbsoluteContentSize = OnChange("AbsoluteContentSize")

    v4[AbsoluteContentSize] = function(p1) -- Line: 405 -- upvalues: u6 (val), u36 (upval)
        local v1 = u6
        local v2 = UDim2.new(1, 0, 0, p1.Y + (u36.textSize:get()) * 2)
        v1:set(v2)
    end

    local v6 = UIListLayout(v4)
    v4 = Computed
    v3[1] = v6
    v3[2] = v4(function() -- Line: 410 -- upvalues: u52 (upval), p1 (val)
        local v1 = u52
        return v1.Render(p1.Text:get(), p1.ZIndex)
    end)
    v1[v2] = v3
    return Frame(v1)
end