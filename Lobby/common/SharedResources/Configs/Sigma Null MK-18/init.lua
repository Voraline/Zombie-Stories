local u0 = {
    ShootSingle = {SoundId = "6839481331", Volume = 0.25},
}
local v1 = {}
local v2 = {}
local v3 = {SoundId = "6828928602", Volume = 0.4}
v2[1] = v3
v1["0"] = v2
u0.LayeredSFXs = v1
v1 = {SoundId = "7043920820", Volume = 0.25}
u0.DeploySFX = v1
function u0.CustomEquip() -- Line: 30 -- upvalues: u0 (val)
    u0.FirstTime = true
end
function u0.AnimateTextureThink(p1, p2) -- Line: 34 -- upvalues: u0 (val)
    local Spinners, v1, v2, v3, v4
    if not p2.Spinners then
        p2.Spinners = {}
    end
    if p2.Spinners[p1] then
        v2, v1 = p2, p1
    else
        local v5, v6
        v1, v2 = p1, p2
        for k, v in pairs(p2.Spinners) do
            if not k.Parent then
                v5 = v
                v4 = nil
                v6 = nil
                for i, j in v5, v4, v6 do
                    j:Destroy()
                end
                v2.Spinners[k] = nil
                k:Destroy()
            end
        end
        local Weapon = v1:WaitForChild("Weapon")
        Spinners = Weapon:WaitForChild("Spinners")
        local Children = Spinners:WaitForChild("Welds"):GetChildren()
        if 7 <= #Children then
            v2.Spinners[v1] = Children
        end
    end
    local v7 = 0
    for k2, k3 in pairs(v2.Spinners[v1]) do
        if not k3.Active then
            v7 = v7 + 1
        end
        if k3.Parent and 7 > v7 then
            if k3.Name == "Hexa" then
                v4 = os.clock() * 0.15 % 1
                v3 = CFrame.Angles(0, 0, 3.141592653589793)
                k3.C1 = CFrame.new():Lerp(v3, v4 * 2)
            elseif k3.Name ~= "SpinMag" and k3.Name == "Ball" then
                if u0.FirstTime then
                    u0.FirstTime = false
                    k3.C1 = k3.C1 * CFrame.Angles(0, 0, 0.01 * math.random(-360, 360))
                end
                k3.C1 = k3.C1 * CFrame.Angles(0, 0, 0.01)
            end
            continue
        end
        v2.Spinners[v1]:Destroy()
        v2.Spinners[v1] = nil
        return
    end
end
function u0.AttachmentModelModify(p1, p2, p3) -- Line: 76
    if p3 and p3 == "+10 Bullets" then
        local Weapon = p2:WaitForChild("Weapon")
        local RearIrons = Weapon:WaitForChild("RearIrons")
        local NoTen = RearIrons:WaitForChild("NoTen")
        NoTen.Transparency = 1
        local Weapon_2 = p2:WaitForChild("Weapon")
        local RearIrons_2 = Weapon_2:WaitForChild("RearIrons")
        local PlusTen = RearIrons_2:WaitForChild("PlusTen")
        PlusTen.Transparency = 0
    end
end
local u9 = 30
local abs = math.abs
function u0.CustomRS(p1, p2, p3) -- Line: 102 -- upvalues: u0 (val), u9 (ref), abs (val)
    if not u0.Ammo then
        u0.Ammo = 30
    elseif u0.Ammo < p2.Ammo then
        u0.Ammo = p2.Ammo
    end
    local v1 = abs(p2.Ammo - u9)
    if 0.01 < v1 then
        v1 = math.min(p3 * 10, 1)
        u9 = math.clamp(u9 + (p2.Ammo - u9) * v1, 0, 30)
        local v2 = u9 / u0.Ammo
        local Mesh = p1.Weapon["Top Rail_Hide"].AmmoCounter.Mesh
        Mesh.Scale = Vector3.new(v2, 1, 1)
        Mesh.Offset = Vector3.new(p1.Weapon["Top Rail_Hide"].AmmoCounter.Size.X * (1 - v2) / 2, 0, 0)
    end
end
return u0