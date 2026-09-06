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
local u55 = {Up = Vector2.new(0, 1), Down = Vector2.new(0, -1), Left = Vector2.new(-1, 0), Right = Vector2.new(1, 0)}
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
function u78.Interact(p1, p2, p3) -- Line: 72 -- upvalues: u55 (val), u36 (ref), u38 (ref), u31 (val), ImageLabel (val), u40 (ref)
    local v1
    local v2 = u55[p2]
    local v3 = u36
    if not u38 then
        u36 = u36 + v2
    elseif v2.X == 0 then
        if v2.Y == 0 then
            u36 = u36 + v2
        elseif u38.X ~= 0 then
            u36 = Vector2.new(0, 0) + v2
        end
    elseif u38.Y ~= 0 then
        u36 = Vector2.new(0, 0) + v2
    end
    if u36 == Vector2.new() then
        u36 = u36 + v2
    end
    u38 = v2
    if u36 == Vector2.new() then
        v1 = u36
        local v4 = 0
        local v5 = 0
        if 1 < v1.X then
            v4 = 23
        elseif v1.X < -1 then
            v4 = -23
        elseif 1 < v1.Y then
            v5 = 20
        elseif v1.Y < -1 then
            v5 = -20
        end
        local v6 = math.clamp(u36.X, -2, 2) * 80 + v4
        v5 = UDim2.new(0.5, v6, 0.5, math.clamp(u36.Y, -2, 2) * -82 + v5)
        ImageLabel.Frame:TweenPosition(v5, "Out", "Quad", 0.25, true)
        if u36.X <= -3 then
            v5 = UDim2.new(1, 103 * ((u36.X + 2) * -1), 0.5, 0)
            ImageLabel.Long.Frame:TweenPosition(v5, "Out", "Quad", 0.25, true)
        elseif -3 < u36.X then
            v5 = UDim2.new(1, 0, 0.5, 0)
            ImageLabel.Long.Frame:TweenPosition(v5, "Out", "Quad", 0.25, true)
        end
        if p3 then
            u40 = os.clock() + 0.5
        else
            u40 = os.clock() + 3
        end
        v4 = tostring(u36.X)
        v1 = v4 .. "," .. tostring(u36.Y)
        return u31[v1]
    else
        local v7 = tostring(u36.X)
        local v8 = v7 .. "," .. tostring(u36.Y)
        if not (u31[v8]) then
            u36 = v3
            v1 = tostring(u36.X)
            v7 = v1 .. "," .. tostring(u36.Y)
            if not (u31[v7]) then
                u36 = Vector2.new()
            end
            return
        end
    end
end
function u78.UpdateSelected(p1, p2) -- Line: 134 -- upvalues: u31 (val), u36 (ref), u38 (ref), ImageLabel (val)
    local v1, v2, v3, v4, v5, v6, v7
    for k, v in pairs(u31) do
        if v == p2 then
            v6, v7 = string.match(k, "(%-?%d+),(%-?%d+)")
            v1 = tonumber(v6)
            u36 = Vector2.new(v1, (tonumber(v7)))
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
            v5 = math.clamp(u36.X, -2, 2) * 80 + v3
            ImageLabel.Frame.Position = UDim2.new(0.5, v5, 0.5, math.clamp(u36.Y, -2, 2) * -82 + v4)
            if u36.X <= -3 then
                ImageLabel.Long.Frame.Position = UDim2.new(1, 103 * ((u36.X + 2) * -1), 0.5, 0)
                return
            end
            if -3 >= u36.X then
                break
            end
            ImageLabel.Long.Frame.Position = UDim2.new(1, 0, 0.5, 0)
            return
        end
    end
end
function u78.AddItem(p1, p2, p3) -- Line: 156 -- upvalues: u28 (val), u31 (val), ImageLabel (val), u29 (val), u30 (val), u32 (val), u33 (val)
    if not p2.Config then
        local v1 = p3:Clone()
        v1.Cover.BackgroundTransparency = 1
        v1.Size = UDim2.new(0, 100, 0, 100)
        v1.Visible = true
        v1.NumberLabel.Visible = false
        if p2.Config.IsAPistol then
            if not p2.Config.IsAPistol then
                table.insert(u30, true)
                u31["0,-" .. #u30] = p2.Slot
                v1.LayoutOrder = #u30
                v1.Parent = ImageLabel.Misc.Frame
            else
                table.insert(u29, true)
                u31[#u29 .. ",0"] = p2.Slot
                v1.LayoutOrder = #u29
                v1.Parent = ImageLabel.Short.Frame
            end
        elseif not p2.Config.IsMelee then
            table.insert(u28, true)
            u31["-" .. #u28 .. ",0"] = p2.Slot
            v1.LayoutOrder = -#u28
            v1.Parent = ImageLabel.Long.Frame
        elseif not p2.Config.IsAPistol then
            table.insert(u30, true)
            u31["0,-" .. #u30] = p2.Slot
            v1.LayoutOrder = #u30
            v1.Parent = ImageLabel.Misc.Frame
        else
            table.insert(u29, true)
            u31[#u29 .. ",0"] = p2.Slot
            v1.LayoutOrder = #u29
            v1.Parent = ImageLabel.Short.Frame
        end
        u32[p2.Slot] = p2.HotbarSlot
        table.insert(u33, v1)
        return
    else
        local HideFromHotbar = p2.Config.HideFromHotbar
        if type(HideFromHotbar) == "function" then
            HideFromHotbar = HideFromHotbar(p2.Config, p2)
        end
        if HideFromHotbar then
            return
        end
    end
end
function u78.ResetInventory(p1) -- Line: 193 -- upvalues: u28 (val), u29 (val), u30 (val), u31 (val), u32 (val), u33 (val), u36 (ref), u38 (ref), ImageLabel (val)
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
        u27:SwapWeapon(u32[v1] or v1, nil)
    end
end)
ImageLabel.Long.Button.MouseButton1Click:Connect(function() -- Line: 219 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Left", true)
    if v1 then
        u27:SwapWeapon(u32[v1] or v1, nil)
    end
end)
ImageLabel.Short.Button.MouseButton1Click:Connect(function() -- Line: 225 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Right", true)
    if v1 then
        u27:SwapWeapon(u32[v1] or v1, nil)
    end
end)
ImageLabel.Misc.Button.MouseButton1Click:Connect(function() -- Line: 231 -- upvalues: u78 (val), u27 (ref), u32 (val)
    local v1 = u78:Interact("Down", true)
    if v1 then
        u27:SwapWeapon(u32[v1] or v1, nil)
    end
end)
task.spawn(function() -- Line: 238 -- upvalues: u27 (ref), u42 (ref), u40 (ref), u41 (ref), DPadSelect (val), u48 (val), u54 (val)
    u27 = require("../../WeaponController")
    while task.wait() do
        if u42 then
            u40 = os.clock() + 1
        end
        if os.clock() >= u40 then
            if u41 then
                u41 = false
                DPadSelect:TweenPosition(u54, "Out", "Quad", 0.5, true)
            end
        elseif not u41 then
            u41 = true
            DPadSelect:TweenPosition(u48, "Out", "Quad", 0.5, true)
        end
    end
end)
return u78