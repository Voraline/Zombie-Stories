local highlight, v1
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.common:FindFirstChild("Fusion", true))
local New = Fusion.New
local u24 = {}
for k, v in pairs(script.Syntaxes:GetChildren()) do
    v1 = v.Name:lower()
    u24[v1] = require(v)
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
    local v1 = string.gsub(p1, "&", "&amp;")
    local v2 = string.gsub(v1, "<", "&lt;")
    local v3 = string.gsub(v2, ">", "&gt;")
    local v4 = string.gsub(v3, "\"", "&quot;")
    return string.gsub(v4, "'", "&apos;")
end
local function SanitizeTabs(p1) -- Line: 49
    return string.gsub(p1, "\t", "    ")
end
local function SanitizeControl(p1) -- Line: 53
    return string.gsub(p1, "[\000\001\002\003\004\005\006\007\008\011\012\r\014\015\016\017\018\019\020\021\022\023\024\025\026\027\028\029\030\031]+", "")
end
function highlight(p1, p2, p3) -- Line: 57 -- upvalues: u66 (val), New (val), u43 (val), u24 (val), SanitizeRichText (val), u44 (val), u63 (val), highlight (val)
    local u295, v1, v2, v3, v4, v5, v6, v7
    local Text = p2
    if not Text then
        Text = p1.Text
    end
    local u297 = string.gsub(string.gsub(Text, "[\000\001\002\003\004\005\006\007\008\011\012\r\014\015\016\017\018\019\020\021\022\023\024\025\026\027\028\029\030\031]+", ""), "\t", "    ")
    local Attribute = p3
    if not Attribute then
        Attribute = p1:GetAttribute("syntax")
        if not Attribute then
            Attribute = "lua"
        end
    end
    local u299 = string.lower(Attribute)
    p1:SetAttribute("syntax", u299)
    p1.RichText = false
    p1.Text = u297
    p1.TextXAlignment = Enum.TextXAlignment.Left
    p1.TextYAlignment = Enum.TextYAlignment.Top
    local TextSize = p1.TextSize
    _, v5 = string.gsub(u297, "\n", "")
    v5 = v5 + 1
    local v8 = p1.TextBounds.Y / v5
    local u301 = u66[p1]
    if u301 then
        local TextLabel_2
        v6 = math.max(v5, #u301)
        v7 = 1
        u295 = p1
        for i = 1, v6, v7 do
            v1 = u301[i]
            if not v1 then
                TextLabel_2 = New("TextLabel")
                v1 = TextLabel_2({
                    RichText = true,
                    BackgroundTransparency = 1,
                    Name = "Line_" .. i,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextColor3 = u43.scriptText,
                    Font = u295.Font,
                    Parent = u295,
                })
                u301[i] = v1
            end
            v1.Text = ""
            v1.TextSize = TextSize
            v1.Size = UDim2.new(1, 0, 0, (math.ceil(v8)))
            v1.Position = UDim2.fromScale(0, v8 * (i - 1) / u295.AbsoluteSize.Y)
        end
    else
        local TextLabel
        u301 = table.create(v5)
        v6 = v5
        v7 = 1
        for j = 1, v6, v7 do
            TextLabel = New("TextLabel")
            u301[j] = TextLabel({
                RichText = true,
                BackgroundTransparency = 1,
                Text = "",
                Name = "Line_" .. j,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
                TextColor3 = u43.scriptText,
                Font = p1.Font,
                TextSize = TextSize,
                Size = UDim2.new(1, 0, 0, (math.ceil(v8))),
                Position = UDim2.fromScale(0, v8 * (j - 1) / p1.AbsoluteSize.Y),
                Parent = p1,
            })
        end
    end
    local lua = u24[u299]
    if not lua then
        lua = u24.lua
    end
    v7 = {}
    local v9 = 0
    v1 = 1
    for k, n in lua.scan(u297) do
        v3 = SanitizeRichText(n)
        v2 = string.split(v3, "\n")
        for i2, v in ipairs(v2) do
            if 1 < i2 then
                v4 = u301[v1]
                v4.Text = table.concat(v7)
                v1 = v1 + 1
                v9 = 0
                table.clear(v7)
            end
            v9 = v9 + 1
            if u44[k] == "scriptText" then
                v7[v9] = v
            elseif string.find(v, "[%S%C]") then
                v7[v9] = string.format(u63[k], v)
            end
        end
    end
    local v10 = u301[v1]
    v10.Text = table.concat(v7)
    u66[u295] = u301
    local u197 = {}
    local function clean() -- Line: 149 -- upvalues: u301 (ref), u66 (upval), u295 (val), u197 (ref)
        for i, v in ipairs(u301) do
            v:Destroy()
        end
        table.clear(u301)
        u66[u295] = nil
        for i2, i3 in ipairs(u197) do
            i3:Disconnect()
        end
        u197 = nil
    end
    table.insert(u197, u295.AncestryChanged:Connect(function() -- Line: 162 -- upvalues: u295 (val), clean (val)
        if u295:IsDescendantOf(game) then
            return
        end
        clean()
    end))
    local PropertyChangedSignal = u295:GetPropertyChangedSignal("TextBounds")
    table.insert(u197, PropertyChangedSignal:Connect(function() -- Line: 168 -- upvalues: highlight (upval), u295 (val), u297 (ref), u299 (ref)
        highlight(u295, u297, u299)
    end))
    local PropertyChangedSignal_2 = u295:GetPropertyChangedSignal("AbsoluteSize")
    table.insert(u197, PropertyChangedSignal_2:Connect(function() -- Line: 171 -- upvalues: highlight (upval), u295 (val), u297 (ref), u299 (ref)
        highlight(u295, u297, u299)
    end))
    return clean
end
local function updateColors() -- Line: 178 -- upvalues: u44 (val), u43 (val), u63 (val), u66 (val), highlight (val)
    local v1, v2
    for k, v in pairs(u44) do
        v1 = u43[v]:get(false)
        v2 = string.format("%.2x%.2x%.2x", v1.R * 255, v1.G * 255, v1.B * 255)
        u63[k] = "<font color=\"#" .. v2 .. "\">%s</font>"
    end
    for k2 in pairs(u66) do
        highlight(k2, k2.Text, k2:GetAttribute("syntax"))
    end
end
pcall(updateColors)
for k2, i in pairs(u43) do
    if string.match(k2, "^script") then
        Fusion.Observer(i):onChange(function() -- Line: 196 -- upvalues: updateColors (val)
            task.defer(pcall, updateColors)
        end)
    end
end
return {UpdateColors = updateColors, Highlight = highlight}