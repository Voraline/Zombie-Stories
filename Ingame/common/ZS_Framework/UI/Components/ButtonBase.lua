local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
return function(p1) -- Line: 16 -- upvalues: OnEvent (val), peek (val), Children (val)
    local scope = p1.scope
    local Disabled = p1.Disabled
    if not Disabled then
        Disabled = scope:Value(false)
    end
    local isHovering = p1.isHovering
    if not isHovering then
        isHovering = scope:Value(false)
    end
    local isHeldDown = p1.isHeldDown
    if not isHeldDown then
        isHeldDown = scope:Value(false)
    end
    local v1 = scope:New("TextButton")
    local v2 = {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        TextTransparency = 1,
        BackgroundTransparency = 1,
    }
    local Activated = OnEvent("Activated")
    v2[Activated] = function() -- Line: 31 -- upvalues: p1 (val), peek (upval), Disabled (val)
        if p1.OnClick ~= nil and not (peek(Disabled)) then
            p1.OnClick()
        end
    end
    local MouseButton1Down = OnEvent("MouseButton1Down")
    v2[MouseButton1Down] = function() -- Line: 37 -- upvalues: isHeldDown (val)
        isHeldDown:set(true)
    end
    local MouseButton1Up = OnEvent("MouseButton1Up")
    v2[MouseButton1Up] = function() -- Line: 40 -- upvalues: isHeldDown (val)
        isHeldDown:set(false)
    end
    local MouseEnter = OnEvent("MouseEnter")
    v2[MouseEnter] = function() -- Line: 44 -- upvalues: isHovering (val)
        isHovering:set(true)
    end
    local MouseLeave = OnEvent("MouseLeave")
    v2[MouseLeave] = function() -- Line: 47 -- upvalues: isHeldDown (val), isHovering (val)
        isHeldDown:set(false)
        isHovering:set(false)
    end
    v2[Children] = {}
    return v1(v2)
end