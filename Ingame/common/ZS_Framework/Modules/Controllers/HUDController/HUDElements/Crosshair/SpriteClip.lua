local new = Vector2.new
local u1 = next
local u2 = newproxy
local u3 = getmetatable
local u4 = {}
local u5 = {}
local u6 = {}
local u7 = false
local u8 = 0
local u9 = 0
game:GetService("RunService").Heartbeat:Connect(function(p1) -- Line: 47 -- upvalues: u9 (ref), u8 (ref), u6 (val)
    local v1, v2, v3
    u9 = u9 + p1
    while 0.016666666666666666 <= u9 do
        u9 = u9 - 0.016666666666666666
        u8 = u8 + 1
        if u6[1] then
            v1 = #u6
            v2 = 1
            for i = 1, v1, v2 do
                v3 = u6[i]
                if v3.State and u8 % v3.FrameTime == 0 then
                    v3:Advance(1)
                end
            end
        end
    end
end)
function u5.Play(p1) -- Line: 66
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
function u5:Pause() -- Line: 79
    if self.State then
        self.State = false
    end
    return false
end
function u5:Stop() -- Line: 85
    self:Pause()
    self.CurrentFrame = 0
    return true
end
function u5:Advance(p2) -- Line: 90 -- upvalues: new (val)
    local EdgeOffsetPixel, SpriteCountX, SpriteOffsetPixel, SpriteSizePixel, v1, v2
    local v3 = self.CurrentFrame + (p2 or 1)
    if self.SpriteCount - 1 >= v3 then
        self.CurrentFrame = v3
        SpriteSizePixel = self.SpriteSizePixel
        SpriteOffsetPixel = self.SpriteOffsetPixel
        EdgeOffsetPixel = self.EdgeOffsetPixel
        SpriteCountX = self.SpriteCountX
        v1 = v3 % SpriteCountX
        v2 = (v3 - v1) / SpriteCountX
        v1 = EdgeOffsetPixel.X + v1 * (SpriteSizePixel.X + SpriteOffsetPixel.X)
        v2 = EdgeOffsetPixel.Y + v2 * (SpriteSizePixel.Y + SpriteOffsetPixel.Y)
        self.Adornee.ImageRectOffset = new(v1, v2)
        return
    end
    if not self.Looped then
        self:Stop()
        return
    end
    v3 = 0
    self.CurrentFrame = v3
    SpriteSizePixel = self.SpriteSizePixel
    SpriteOffsetPixel = self.SpriteOffsetPixel
    EdgeOffsetPixel = self.EdgeOffsetPixel
    SpriteCountX = self.SpriteCountX
    v1 = v3 % SpriteCountX
    v2 = (v3 - v1) / SpriteCountX
    v1 = EdgeOffsetPixel.X + v1 * (SpriteSizePixel.X + SpriteOffsetPixel.X)
    v2 = EdgeOffsetPixel.Y + v2 * (SpriteSizePixel.Y + SpriteOffsetPixel.Y)
    self.Adornee.ImageRectOffset = new(v1, v2)
end
function u4.new() -- Line: 116 -- upvalues: new (val), u1 (val), u5 (val), u2 (val), u3 (val), u7 (ref), u6 (val), u4 (val)
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
        SpriteSizePixel = new(100, 100),
        EdgeOffsetPixel = new(0, 0),
        SpriteOffsetPixel = new(0, 0),
    }
    local v1 = u1
    local v2 = u5
    local v3 = nil
    for k, v in v1, v2, v3 do
        u0[k] = v
    end
    v1 = u2(true)
    local u28 = u3(v1)
    u28.__index = u0
    function u28.__newindex(p1, p2, p3) -- Line: 139 -- upvalues: u0 (val)
        local Adornee
        u0[p2] = p3
        if p2 == "Adornee" then
            Adornee = u0.Adornee
            if Adornee then
                Adornee.ImageRectSize = u0.SpriteSizePixel
            end
            if p2 ~= "Adornee" then
                return
            end
            if u0.InheritSpriteSheet then
                u0.SpriteSheet = Adornee.Image
                return
            end
            Adornee.Image = u0.SpriteSheet
            return
        elseif p2 ~= "SpriteSizePixel" then
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
    end
    u28.__metatable = "The metatable is locked"
    function u0.Destroy(p1) -- Line: 164 -- upvalues: u7 (upval), u6 (upval), u0 (val), u1 (upval), u28 (val)
        local v1, v2
        p1:Pause()
        while u7 do
            wait()
        end
        u7 = true
        local v3 = #u6
        local v4 = 1
        for i = 1, v3, v4 do
            v1 = u6[i]
            if v1 == u0 then
                v2 = #u6
                u6[i] = u6[#u6]
                u6[v2] = nil
            end
        end
        u7 = false
        v3 = u1
        v4 = u28
        local v5 = nil
        for k in v3, v4, v5 do
            u28[k] = nil
        end
    end
    function u0.Clone(p1) -- Line: 180 -- upvalues: u4 (upval), u1 (upval), u0 (val)
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