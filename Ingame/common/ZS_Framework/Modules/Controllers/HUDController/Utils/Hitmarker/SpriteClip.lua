local new = Vector2.new
local u1 = next
local u2 = newproxy
local u3 = getmetatable
local u4 = {}
local u5 = {}
local u6 = {}
local u7 = false
local u8 = 0
;(game:GetService("RunService")).Heartbeat:Connect(function() -- Line: 46 -- upvalues: u8 (ref), u6 (val)
    u8 = u8 + 1
    if u6[1] then
        local FrameTime, v1
        local v2 = #u6
        for i = 1, v2 do
            v1 = u6[i]
            if v1.State then
                FrameTime = v1.FrameTime
                if u8 % FrameTime == 0 then
                    v1:Advance(1)
                end
            end
        end
    end
end)

function u5.Play(p1) -- Line: 62
    if p1.State then
        p1.CurrentFrame = 0
        return false
    end
    if not p1.Adornee then
        error("SpriteClip: No Instance assigned to this SpriteClip.")
        return false
    end
    p1.CurrentFrame = 0
    p1.State = true
    return true
end

function u5:Pause() -- Line: 75
    if self.State then
        self.State = false
    end
    return false
end

function u5:Stop() -- Line: 81
    self:Pause()
    self.CurrentFrame = 0
    return true
end

function u5:Advance(p2) -- Line: 86 -- upvalues: new (val)
    local v1 = self.CurrentFrame + (p2 or 1)
    if self.SpriteCount - 1 < v1 then
        if not self.Looped then
            self:Stop()
            return
        else
            v1 = 0
        end
    end
    self.CurrentFrame = v1
    local SpriteSizePixel = self.SpriteSizePixel
    local X_2 = SpriteSizePixel.X
    local Y = SpriteSizePixel.Y
    local SpriteOffsetPixel = self.SpriteOffsetPixel
    local X = SpriteOffsetPixel.X
    local Y_2 = SpriteOffsetPixel.Y
    local EdgeOffsetPixel = self.EdgeOffsetPixel
    local SpriteCountX = self.SpriteCountX
    local SpriteCount = self.SpriteCount
    local v2 = v1 % SpriteCountX
    local v3 = (v1 - v2) / SpriteCountX
    v2 = EdgeOffsetPixel.X + v2 * (X_2 + X)
    v3 = EdgeOffsetPixel.Y + v3 * (Y + Y_2)
    self.Adornee.ImageRectOffset = new(v2, v3)
end

function u4.new() -- Line: 112
    -- upvalues: new (val), u1 (val), u5 (val), u2 (val), u3 (val), u7 (ref), u6 (val), u4 (val)
    local u0 = {
        InheritSpriteSheet = true,
        CurrentFrame = 0,
        SpriteCount = 25,
        SpriteCountX = 5,
        FrameRate = 15,
        FrameTime = 4,
        Looped = true,
        State = false,
        Sorted = true,
    }
    u0.SpriteSizePixel = new(100, 100)
    u0.EdgeOffsetPixel = new(0, 0)
    u0.SpriteOffsetPixel = new(0, 0)
    local v1 = u1
    local v2 = u5
    local v3 = nil
    for k, v in v1, v2, v3 do
        u0[k] = v
    end
    v1 = u2(true)
    local u28 = u3(v1)
    u28.__index = u0

    function u28.__newindex(p1, p2, p3) -- Line: 135 -- upvalues: u0 (val)
        u0[p2] = p3
        if p2 ~= "Adornee" and p2 ~= "SpriteSizePixel" then
            if p2 ~= "SpriteSheet" then
                if p2 == "FrameRate" then
                    u0.FrameTime = 60 / p3
                end
                return
            end
            if not u0.Adornee then
                return
            end
            u0.Adornee.Image = p3
            return
        end
        local Adornee = u0.Adornee
        local v1 = u0
        local SpriteSizePixel = v1.SpriteSizePixel
        if Adornee then
            Adornee.ImageRectSize = SpriteSizePixel
        end
        if p2 ~= "Adornee" then
            return
        end
        if u0.InheritSpriteSheet then
            u0.SpriteSheet = Adornee.Image
            return
        end
        Adornee.Image = u0.SpriteSheet
    end

    u28.__metatable = "The metatable is locked"

    function u0.Destroy(p1) -- Line: 160 -- upvalues: u7 (upval), u6 (upval), u0 (val), u1 (upval), u28 (val)
        local v1, v2, v3, v4
        p1:Pause()
        while u7 do
            wait()
        end
        u7 = true
        local v5 = #u6
        for i = 1, v5 do
            v1 = u6[i]
            if v1 == u0 then
                v1 = u6
                v2 = u6
                v3 = #u6
                v4 = u6[#u6]
                v1[i] = v4
                v2[v3] = nil
            end
        end
        u7 = false
        v5 = u1
        local v6 = u28
        local v7 = nil
        for k in v5, v6, v7 do
            u28[k] = nil
        end
    end

    function u0.Clone(p1) -- Line: 174 -- upvalues: u4 (upval), u1 (upval), u0 (val)
        local v1 = u4.new()
        local v2 = u1
        local v3 = u0
        local v4 = nil
        for k, v in v2, v3, v4 do
            if v ~= "Adornee" then
                v1[k] = v
            end
        end
        return v1
    end

    u6[#u6 + 1] = u0
    return v1
end

return u4