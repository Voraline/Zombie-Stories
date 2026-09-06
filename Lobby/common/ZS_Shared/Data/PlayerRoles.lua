local v1, v2
local u0 = {}
local function color(p1, p2, p3) -- Line: 5
    return Color3.fromRGB(p1, p2, p3)
end
local function gradient(p1, p2) -- Line: 10
    local v1 = {}
    local v2 = ColorSequenceKeypoint.new(0, p1)
    v1[1] = v2
    v1[2] = ColorSequenceKeypoint.new(1, p2)
    return ColorSequence.new(v1)
end
v1 = {
    Name = Color3.fromRGB(200, 205, 215),
    Background = Color3.fromRGB(6, 14, 24),
    Pattern = Color3.fromRGB(26, 42, 59),
    PanelTop = Color3.fromRGB(43, 71, 98),
    PanelBottom = Color3.fromRGB(10, 24, 40),
    Border = Color3.fromRGB(70, 96, 122),
}
v1.PanelGradient = gradient(v1.PanelTop, v1.PanelBottom)
u0.Config = table.freeze({Enabled = true, GroupId = 3532462, AlphaBadge = 2124478718})
local v3 = {}
local v4 = {
    id = "Owner",
    label = "OWNER",
    chatTagText = "[DEV]",
    minRank = 251,
    icon = "rbxassetid://11322089611",
    Chat = {Tag = Color3.fromRGB(146, 43, 255), Name = Color3.fromRGB(146, 43, 255), Body = Color3.fromRGB(102, 247, 255)},
    UI = {
        Primary = Color3.fromRGB(168, 85, 247),
        Name = Color3.fromRGB(216, 180, 254),
        Background = Color3.fromRGB(18, 8, 30),
        Pattern = Color3.fromRGB(45, 23, 73),
        PanelTop = Color3.fromRGB(76, 29, 149),
        PanelBottom = Color3.fromRGB(24, 10, 48),
        Border = Color3.fromRGB(133, 92, 205),
    },
}
local v5 = {
    id = "Admin",
    label = "ADMIN",
    chatTagText = "[MOD*]",
    minRank = 201,
    maxRank = 250,
    icon = "rbxassetid://11322093465",
    Chat = {Tag = Color3.fromRGB(140, 77, 255), Name = Color3.fromRGB(140, 77, 255), Body = Color3.fromRGB(193, 145, 255)},
    UI = {
        Primary = Color3.fromRGB(140, 77, 255),
        Name = Color3.fromRGB(140, 77, 255),
        Background = Color3.fromRGB(12, 10, 26),
        Pattern = Color3.fromRGB(35, 28, 59),
        PanelTop = Color3.fromRGB(58, 42, 110),
        PanelBottom = Color3.fromRGB(16, 12, 36),
        Border = Color3.fromRGB(105, 84, 170),
    },
}
local v6 = {
    id = "Moderator",
    label = "MODERATOR",
    chatTagText = "[MOD]",
    minRank = 200,
    maxRank = 200,
    icon = "rbxassetid://11322093465",
    Chat = {Tag = Color3.fromRGB(255, 0, 0), Name = Color3.fromRGB(255, 181, 181), Body = Color3.fromRGB(255, 181, 181)},
    UI = {
        Primary = Color3.fromRGB(255, 73, 73),
        Name = Color3.fromRGB(255, 181, 181),
        Background = Color3.fromRGB(24, 8, 10),
        Pattern = Color3.fromRGB(62, 24, 29),
        PanelTop = Color3.fromRGB(104, 32, 36),
        PanelBottom = Color3.fromRGB(34, 10, 14),
        Border = Color3.fromRGB(181, 70, 74),
    },
}
local v7 = {
    id = "Contributor",
    label = "CONTRIBUTOR",
    chatTagText = "[CONTR.]",
    minRank = 3,
    maxRank = 199,
    icon = "rbxassetid://13738539975",
    Chat = {Tag = Color3.fromRGB(255, 44, 227), Name = Color3.fromRGB(255, 73, 237), Body = Color3.fromRGB(255, 143, 229)},
    UI = {
        Primary = Color3.fromRGB(255, 44, 227),
        Name = Color3.fromRGB(255, 73, 237),
        Background = Color3.fromRGB(24, 6, 22),
        Pattern = Color3.fromRGB(61, 18, 57),
        PanelTop = Color3.fromRGB(104, 26, 94),
        PanelBottom = Color3.fromRGB(34, 8, 30),
        Border = Color3.fromRGB(192, 67, 174),
    },
}
local v8 = {
    id = "Alpha",
    label = "ALPHA TESTER",
    chatTagText = "[α]",
    icon = "rbxassetid://15522534635",
    Chat = {Tag = Color3.fromRGB(199, 252, 255)},
    UI = {
        Primary = Color3.fromRGB(199, 252, 255),
        Name = Color3.fromRGB(199, 252, 255),
        Background = Color3.fromRGB(6, 20, 24),
        Pattern = Color3.fromRGB(18, 53, 62),
        PanelTop = Color3.fromRGB(40, 84, 94),
        PanelBottom = Color3.fromRGB(10, 26, 32),
        Border = Color3.fromRGB(91, 167, 182),
    },
}
v3[1] = v4
v3[2] = v5
v3[3] = v6
v3[4] = v7
v3[5] = v8
u0.Definitions = table.freeze(v3)
u0.Secondary = table.freeze({Alpha = table.freeze({icon = "rbxassetid://15522534635", Tint = true, Primary = Color3.fromRGB(199, 252, 255)}), Verified = table.freeze({icon = "rbxassetid://134830771376709", Tint = false, Primary = Color3.fromRGB(0, 162, 255)}), Premium = table.freeze({icon = "rbxassetid://10885647358", Tint = true, Primary = Color3.fromRGB(255, 209, 71)})})
v2 = {}
v3 = {}
for i, v in ipairs(u0.Definitions) do
    v.UI.PanelGradient = gradient(v.UI.PanelTop, v.UI.PanelBottom)
    v2[v.id] = v
    v3[v.id] = i
end
u0.Default = table.freeze(v1)
u0.ById = table.freeze(v2)
u0.ChatIndexById = table.freeze(v3)
function u0.Get(p1) -- Line: 83 -- upvalues: u0 (val)
    if not u0.Config.Enabled then
        return u0.Default
    end
    local Default = u0.ById[p1]
    if not Default then
        Default = u0.Default
    end
    return Default
end
function u0.ResolveFromRank(p1) -- Line: 90 -- upvalues: u0 (val)
    if not u0.Config.Enabled then
        return nil
    end
    for i, v in ipairs(u0.Definitions) do
        if v.minRank and v.minRank <= p1 then
            if v.maxRank and p1 > v.maxRank then
                continue
            end
            return v.id
        end
    end
    return nil
end
function u0.ResolveDisplayIcon(p1, p2, p3) -- Line: 104 -- upvalues: u0 (val)
    local v1 = u0.Get(p1)
    if not v1.id then
        if not p2 then
            if p3 then
                if u0.Secondary.Premium.icon ~= "" then
                    return {Id = "Premium", Image = u0.Secondary.Premium.icon, Color = u0.Secondary.Premium.Primary, Tint = u0.Secondary.Premium.Tint}
                end
                return nil
            end
            return nil
        end
        if u0.Secondary.Verified.icon ~= "" then
            return {Id = "Verified", Image = u0.Secondary.Verified.icon, Color = u0.Secondary.Verified.Primary, Tint = u0.Secondary.Verified.Tint}
        end
        if not p3 then
            return nil
        end
        if u0.Secondary.Premium.icon ~= "" then
            return {Id = "Premium", Image = u0.Secondary.Premium.icon, Color = u0.Secondary.Premium.Primary, Tint = u0.Secondary.Premium.Tint}
        end
        return nil
    elseif v1.icon ~= "" then
        return {Tint = true, Id = v1.id, Image = v1.icon, Color = v1.UI.Primary}
    end
end
return table.freeze(u0)