local highlight, v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
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
local u24 = {}
for k, v in pairs(script.Syntaxes:GetChildren()) do
    v1 = v.Name:lower()
    u24[v1] = (require(v))
end
local u43 = require("./theme")
local u44 = {
    background = "scriptBackground",
    iden = "scriptText",
    keyword = "scriptKeyword",
    builtin = "scriptBuiltin",
    string = "scriptString",
    number = "scriptNumber",
    comment = "scriptComment",
    operator = "scriptOperator",
    custom = "scriptCustom",
    raw = "scriptText",
    text = "scriptText",
    header = "scriptBuiltin",
    quote = "scriptString",
    list = "scriptNumber",
    ruler = "scriptComment",
    code = "scriptKeyword",
}
local u63 = table.create(7)
local u66 = table.create(3)

local function SanitizeRichText(p1) -- Line: 39
    return string.gsub(
        string.gsub(string.gsub(string.gsub(string.gsub(p1, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), "\"", "&quot;"),
        "'",
        "&apos;"
    )
end

local function SanitizeTabs(p1) -- Line: 49
    return string.gsub(p1, "\t", "    ")
end

local function SanitizeControl(p1) -- Line: 53
    return string.gsub(
        p1,
        "[\000\001\002\003\004\005\006\007\008\011\012\r\014\015\016\017\018\019\020\021\022\023\024\025\026\027\028\029\030\031]+",
        ""
    )
end

function highlight(p1, p2, p3) -- Line: 57
    -- upvalues: u66 (val), New (val), u43 (val), u24 (val), SanitizeRichText (val), u44 (val), u63 (val)
    -- upvalues: highlight (val)
    local v1, v2, v3, v4, v5
    local Text = p2
    if not Text then
        Text = p1.Text
    end
    local v6 = string.gsub(
        Text,
        "[\000\001\002\003\004\005\006\007\008\011\012\r\014\015\016\017\018\019\020\021\022\023\024\025\026\027\028\029\030\031]+",
        ""
    )
    local u297 = string.gsub(v6, "\t", "    ")
    local lower = string.lower
    local Attribute = p3
    if not Attribute then
        Attribute = p1:GetAttribute("syntax")
        if not Attribute then
            Attribute = "lua"
        end
    end
    local u299 = lower(Attribute)
    local v7 = u299
    p1:SetAttribute("syntax", v7)
    p1.RichText = false
    p1.Text = u297
    p1.TextXAlignment = Enum.TextXAlignment.Left
    p1.TextYAlignment = Enum.TextYAlignment.Top
    local TextSize = p1.TextSize
    _, v6 = string.gsub(u297, "\n", "")
    v6 = v6 + 1
    v7 = p1.TextBounds.Y / v6
    local u301 = u66[p1]
    if u301 then
        local v8 = #u301
        v5 = math.max(v6, v8)
        for i = 1, v5 do
            v1 = u301[i]
            if not v1 then
                v1 = New("TextLabel")({
                    RichText = true,
                    BackgroundTransparency = 1,
                    Name = "Line_" .. i,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextColor3 = u43.scriptText,
                    Font = p1.Font,
                    Parent = p1,
                })
                u301[i] = v1
            end
            v1.Text = ""
            v1.TextSize = TextSize
            v1.Size = UDim2.new(1, 0, 0, (math.ceil(v7)))
            v1.Position = UDim2.fromScale(0, v7 * (i - 1) / p1.AbsoluteSize.Y)
        end
    else
        local TextLabel
        u301 = table.create(v6)
        v5 = v6
        for j = 1, v5 do
            TextLabel = New("TextLabel")
            v2 = {
                RichText = true,
                BackgroundTransparency = 1,
                Text = "",
                Name = "Line_" .. j,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextColor3 = u43.scriptText,
                Font = p1.Font,
                TextSize = TextSize,
                Size = UDim2.new(1, 0, 0, (math.ceil(v7))),
                Position = UDim2.fromScale(0, v7 * (j - 1) / p1.AbsoluteSize.Y),
                Parent = p1,
            }
            u301[j] = (TextLabel(v2))
        end
    end
    local lua = u24[u299]
    if not lua then
        lua = u24.lua
    end
    local v9 = {}
    local v10 = 0
    v1 = 1
    for k, n in lua.scan(u297) do
        v3 = string.split(SanitizeRichText(n), "\n")
        for i2, v in ipairs(v3) do
            if 1 < i2 then
                v4 = u301[v1]
                v4.Text = table.concat(v9)
                v1 = v1 + 1
                v10 = 0
                table.clear(v9)
            end
            v10 = v10 + 1
            if u44[k] == "scriptText" or not string.find(v, "[%S%C]") then
                v9[v10] = v
            else
                v9[v10] = (string.format(u63[k], v))
            end
        end
    end
    v2 = u301[v1]
    v2.Text = table.concat(v9)
    u66[p1] = u301
    local u197 = {}

    local function clean() -- Line: 149 -- upvalues: u301 (ref), u66 (upval), p1 (val), u197 (ref)
        for i, v in ipairs(u301) do
            v:Destroy()
        end
        table.clear(u301)
        u66[p1] = nil
        for i2, i3 in ipairs(u197) do
            i3:Disconnect()
        end
        u197 = nil
    end

    local v11 = u197
    local v12 = p1.AncestryChanged:Connect(function() -- Line: 162 -- upvalues: p1 (val), clean (val)
        local v1 = p1
        local v2 = game
        if v1:IsDescendantOf(v2) then
            return
        end
        clean()
    end)
    table.insert(v11, v12)
    v11 = u197
    v12 = (p1:GetPropertyChangedSignal("TextBounds")):Connect(function() -- Line: 168 -- upvalues: highlight (upval), p1 (val), u297 (ref), u299 (ref)
        highlight(p1, u297, u299)
    end)
    table.insert(v11, v12)
    v11 = u197
    v12 = (p1:GetPropertyChangedSignal("AbsoluteSize")):Connect(function() -- Line: 171 -- upvalues: highlight (upval), p1 (val), u297 (ref), u299 (ref)
        highlight(p1, u297, u299)
    end)
    table.insert(v11, v12)
    return clean
end

local function updateColors() -- Line: 178 -- upvalues: u44 (val), u43 (val), u63 (val), u66 (val), highlight (val)
    local Text, v1, v2, v3
    for k, v in pairs(u44) do
        v1 = u43[v]:get(false)
        v2 = u63
        v3 = string.format("%.2x%.2x%.2x", v1.R * 255, v1.G * 255, v1.B * 255)
        v2[k] = "<font color=\"#" .. v3 .. "\">%s</font>"
    end
    for k2 in pairs(u66) do
        v1 = highlight
        Text = k2.Text
        v1(k2, Text, k2:GetAttribute("syntax"))
    end
end

pcall(updateColors)
for k2, i in pairs(u43) do
    if string.match(k2, "^script") then
        (Observer(i)):onChange(function() -- Line: 196 -- upvalues: updateColors (val)
            task.defer(pcall, updateColors)
        end)
    end
end
return {UpdateColors = updateColors, Highlight = highlight}