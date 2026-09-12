require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
game:GetService("TweenService")
local DPadSelection = script:WaitForChild("DPadSelection")
local DPadSelect = DPadSelection:WaitForChild("DPadSelect")
local ImageLabel = DPadSelect:WaitForChild("ImageLabel")
local u27 = nil
local u28 = {}
local u29 = {}
local u30 = {}
local u31 = {}
local u32 = {}
local u33 = {}
local u36 = Vector2.new()
local u38 = Vector2.new()
local u40 = os.clock()
local u41 = false
local u42 = false
local u48 = UDim2.new(0.01, 0, 0.5, 0)
local u54 = UDim2.new(0.01, -500, 0.5, 0)
local u55 = {}
u55.Up = Vector2.new(0, 1)
u55.Down = Vector2.new(0, -1)
u55.Left = Vector2.new(-1, 0)
u55.Right = Vector2.new(1, 0)

local function getGlowOffsets(p1) -- Line: 29
    local v1 = 0
    local v2 = 0
    if 1 < p1.X then
        return 23, v2
    end
    if p1.X < -1 then
        return -23, v2
    end
    if 1 < p1.Y then
        return v1, 20
    end
    if p1.Y < -1 then
        v2 = -20
    end
    return v1, v2
end

DPadSelection.ResetOnSpawn = false
DPadSelection.Parent = game.Players.LocalPlayer.PlayerGui
local u78 = {IsShowing = true}

function u78.Show(p1) -- Line: 53 -- upvalues: u78 (val), DPadSelection (val)
    u78.IsShowing = true
    DPadSelection.Enabled = true
end

function u78.Hide(p1) -- Line: 59 -- upvalues: u78 (val), DPadSelection (val)
    u78.IsShowing = false
    DPadSelection.Enabled = false
end

function u78.HoldingMobile(p1) -- Line: 64 -- upvalues: u42 (ref)
    u42 = true
end

function u78.StopHoldingMobile(p1) -- Line: 68 -- upvalues: u42 (ref)
    u42 = false
end

function u78.Interact(p1, p2, p3) -- Line: 72
    -- upvalues: u55 (val), u36 (ref), u38 (ref), u31 (val), ImageLabel (val), u40 (ref)
    local v1, v2, v3, v4
    local v5 = u55[p2]
    local v6 = u36
    if not u38 then
        u36 = u36 + v5
    elseif v5.X == 0 then
        if v5.Y == 0 or u38.X == 0 then
            u36 = u36 + v5
        else
            u36 = Vector2.new(0, 0) + v5
        end
    elseif u38.Y ~= 0 then
        u36 = Vector2.new(0, 0) + v5
    elseif v5.Y == 0 or u38.X == 0 then
        u36 = u36 + v5
    else
        u36 = Vector2.new(0, 0) + v5
    end
    if u36 == Vector2.new() then
        u36 = u36 + v5
    end
    u38 = v5
    if u36 ~= Vector2.new() then
        v2 = u36
        local X = v2.X
        v1 = tostring(X)
        v4 = u36
        local Y = v4.Y
        local v7 = v1 .. "," .. tostring(Y)
        if not u31[v7] then
            u36 = v6
            v3 = u36
            local X_2 = v3.X
            v2 = tostring(X_2)
            local v8 = u36
            local Y_2 = v8.Y
            v1 = v2 .. "," .. tostring(Y_2)
            if not u31[v1] then
                u36 = Vector2.new()
            end
            return
        end
    end
    v2 = u36
    v3 = 0
    v4 = 0
    if 1 < v2.X then
        v3 = 23
    elseif v2.X < -1 then
        v3 = -23
    elseif 1 < v2.Y then
        v4 = 20
    elseif v2.Y < -1 then
        v4 = -20
    end
    v1 = v4
    v2 = ImageLabel
    local Frame = v2.Frame
    local new = UDim2.new
    local v9 = u36
    local X_3 = v9.X
    local v10 = math.clamp(X_3, -2, 2) * 80 + v3
    local v11 = u36
    local Y_3 = v11.Y
    v4 = new(0.5, v10, 0.5, math.clamp(Y_3, -2, 2) * -82 + v1)
    Frame:TweenPosition(v4, "Out", "Quad", 0.25, true)
    if u36.X <= -3 then
        v2 = ImageLabel
        local Frame_2 = v2.Long.Frame
        v4 = UDim2.new(1, 103 * ((u36.X + 2) * -1), 0.5, 0)
        Frame_2:TweenPosition(v4, "Out", "Quad", 0.25, true)
    elseif -3 < u36.X then
        v2 = ImageLabel
        local Frame_3 = v2.Long.Frame
        v4 = UDim2.new(1, 0, 0.5, 0)
        Frame_3:TweenPosition(v4, "Out", "Quad", 0.25, true)
    end
    if p3 then
        u40 = os.clock() + 0.5
    else
        u40 = os.clock() + 3
    end
    v4 = u36
    local X_4 = v4.X
    v3 = tostring(X_4)
    v10 = u36
    local Y_4 = v10.Y
    v2 = v3 .. "," .. tostring(Y_4)
    return u31[v2]
end

function u78.UpdateSelected(p1, p2) -- Line: 134 -- upvalues: u31 (val), u36 (ref), u38 (ref), ImageLabel (val)
    local Frame, Frame_2, X, Y, new_2, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
    for k, v in pairs(u31) do
        if v == p2 then
            v8, v9 = string.match(k, "(%-?%d+),(%-?%d+)")
            u36 = Vector2.new(tonumber(v8), (tonumber(v9)))
            u38 = u36
            v2 = u36
            v3 = 0
            v4 = 0
            if 1 < v2.X then
                v3 = 23
            elseif v2.X < -1 then
                v3 = -23
            elseif 1 < v2.Y then
                v4 = 20
            elseif v2.Y < -1 then
                v4 = -20
            end
            v10 = v3
            v1 = v4
            v2 = ImageLabel
            Frame = v2.Frame
            new_2 = UDim2.new
            v6 = u36
            X = v6.X
            v5 = math.clamp(X, -2, 2) * 80 + v10
            v7 = u36
            Y = v7.Y
            Frame.Position = new_2(0.5, v5, 0.5, math.clamp(Y, -2, 2) * -82 + v1)
            if u36.X <= -3 then
                v2 = ImageLabel
                Frame_2 = v2.Long.Frame
                Frame_2.Position = UDim2.new(1, 103 * ((u36.X + 2) * -1), 0.5, 0)
                return
            end
            if not (-3 < u36.X) then
                break
            end
            ImageLabel.Long.Frame.Position = UDim2.new(1, 0, 0.5, 0)
            return
        end
    end
end

function u78.AddItem(p1, p2, p3) -- Line: 156
    -- upvalues: u28 (val), u31 (val), ImageLabel (val), u29 (val), u30 (val), u32 (val), u33 (val)
    local v1, v2
    if p2.Config then
        local HideFromHotbar = p2.Config.HideFromHotbar
        if type(HideFromHotbar) == "function" then
            HideFromHotbar = HideFromHotbar(p2.Config, p2)
        end
        if HideFromHotbar then
            return
        end
    end
    local v3 = p3:Clone()
    v3.Cover.BackgroundTransparency = 1
    v3.Size = UDim2.new(0, 100, 0, 100)
    v3.Visible = true
    v3.NumberLabel.Visible = false
    if p2.Config.IsAPistol then
        if not p2.Config.IsAPistol then
            v2 = u30
            table.insert(v2, true)
            v1 = u31
            v2 = "0,-" .. #u30
            v1[v2] = p2.Slot
            v3.LayoutOrder = #u30
            v3.Parent = ImageLabel.Misc.Frame
        else
            v2 = u29
            table.insert(v2, true)
            v1 = u31
            v2 = #u29 .. ",0"
            v1[v2] = p2.Slot
            v3.LayoutOrder = #u29
            v3.Parent = ImageLabel.Short.Frame
        end
    elseif not p2.Config.IsMelee then
        v2 = u28
        table.insert(v2, true)
        v1 = u31
        v2 = "-" .. #u28 .. ",0"
        v1[v2] = p2.Slot
        v3.LayoutOrder = -#u28
        v3.Parent = ImageLabel.Long.Frame
    elseif not p2.Config.IsAPistol then
        v2 = u30
        table.insert(v2, true)
        v1 = u31
        v2 = "0,-" .. #u30
        v1[v2] = p2.Slot
        v3.LayoutOrder = #u30
        v3.Parent = ImageLabel.Misc.Frame
    else
        v2 = u29
        table.insert(v2, true)
        v1 = u31
        v2 = #u29 .. ",0"
        v1[v2] = p2.Slot
        v3.LayoutOrder = #u29
        v3.Parent = ImageLabel.Short.Frame
    end
    u32[p2.Slot] = p2.HotbarSlot
    v2 = u33
    table.insert(v2, v3)
end

function u78.ResetInventory(p1) -- Line: 193
    -- upvalues: u28 (val), u29 (val), u30 (val), u31 (val), u32 (val), u33 (val), u36 (ref), u38 (ref)
    -- upvalues: ImageLabel (val)
    table.clear(u28)
    table.clear(u29)
    table.clear(u30)
    table.clear(u31)
    table.clear(u32)
    local v1 = u33
    local v2 = nil
    local v3 = nil
    for i, j in v1, v2, v3 do
        j:Destroy()
    end
    table.clear(u33)
    u36 = Vector2.new()
    u38 = Vector2.new()
    ImageLabel.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Long.Frame.Position = UDim2.new(1, 0, 0.5, 0)
end

function u78.GetHotbarSlot(p1, p2) -- Line: 209 -- upvalues: u32 (val)
    return u32[p2] or p2
end

ImageLabel.Settings.Button.MouseButton1Click:Connect(function() -- Line: 213 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Up", true)
    if v1 then
        local v2 = u27
        local v3 = u32[v1] or v1
        v2:SwapWeapon(v3, nil)
    end
end)
ImageLabel.Long.Button.MouseButton1Click:Connect(function() -- Line: 219 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Left", true)
    if v1 then
        local v2 = u27
        local v3 = u32[v1] or v1
        v2:SwapWeapon(v3, nil)
    end
end)
ImageLabel.Short.Button.MouseButton1Click:Connect(function() -- Line: 225 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Right", true)
    if v1 then
        local v2 = u27
        local v3 = u32[v1] or v1
        v2:SwapWeapon(v3, nil)
    end
end)
ImageLabel.Misc.Button.MouseButton1Click:Connect(function() -- Line: 231 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Down", true)
    if v1 then
        local v2 = u27
        local v3 = u32[v1] or v1
        v2:SwapWeapon(v3, nil)
    end
end)
task.spawn(function() -- Line: 238 -- upvalues: u27 (ref), u42 (ref), u40 (ref), u41 (ref), DPadSelect (val), u48 (val), u54 (val)
    local v1, v2
    u27 = require("../../WeaponController")
    while task.wait() do
        if u42 then
            u40 = os.clock() + 1
        end
        v1 = u40
        if not (os.clock() < v1) then
            if u41 then
                u41 = false
                v1 = DPadSelect
                v2 = u54
                v1:TweenPosition(v2, "Out", "Quad", 0.5, true)
            end
        elseif not u41 then
            u41 = true
            v1 = DPadSelect
            v2 = u48
            v1:TweenPosition(v2, "Out", "Quad", 0.5, true)
        end
    end
end)
return u78