local u4 = Color3.new(1, 1, 1)
local u9 = Color3.new(0, 0, 0)
return {
    White = u4,
    Black = u9,
    LightGray = Color3.fromRGB(224, 224, 224),
    MediumGray = Color3.fromRGB(113, 117, 121),
    DarkGray = Color3.fromRGB(95, 99, 104),
    DefaultTheme = Color3.fromRGB(103, 58, 183),
    GetContrastColor = function(p1) -- Line: 4 -- upvalues: u9 (val), u4 (val)
        local v1 = p1.R * 255 * 0.299 + p1.G * 255 * 0.587 + p1.B * 255 * 0.114
        if 186 < v1 then
            return u9
        end
        return u4
    end,
}