local CustomHitModules
local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
local CustomHit = require(RedEvents.Framework.FrameworkEvents).CustomHit
local u19 = game:GetService("RunService"):IsServer()
local u27 = game:GetService("RunService"):IsStudio()
local u28 = {}
local u29 = {}
local u30 = {}
local u47 = nil
local v1 = nil

local function debugLog(p1, ...) -- Line: 21 -- upvalues: u27 (val)
    if not u27 or not p1 or p1 ~= "TurkeyTarget" then
        return
    end
    print("[CustomHitDebug]", p1 or "General", ...)
end

local function resolveHitEvent(p1) -- Line: 38 -- upvalues: u29 (val)
    local v1
    local Parent = p1
    while Parent do
        v1 = u29[Parent]
        if v1 then
            return v1
        end
        Parent = Parent.Parent
    end
end

if not u19 then
    local ZS_Framework = game:GetService("ReplicatedStorage").common.ZS_Framework
    u47 = require(ZS_Framework.Modules.Classes.Weapon)
    v1 = require(ZS_Framework.Modules.Controllers.WeaponController.WeaponControllerUtils.Melee)
end
local u56 = {}

function u56.RegisterModel(p1, p2, p3) -- Line: 59
    -- upvalues: u28 (val), debugLog (val), u19 (val), u29 (val), u30 (val), CustomHit (val)
    local Model, v1, v2
    local v3 = u28[p2]
    if not v3 then
        v2 = debugLog
        local FullName = p3
        if FullName then
            FullName = p3:GetFullName()
        end
        v2(p2, "RegisterModel:missingEventModule", FullName)
        return
    end
    if not v3.new then
        v2 = setmetatable({}, v3)
    else
        v2 = v3.new()
    end
    if not p3 then
        Model = v2.Model
    else
        Model = p3
    end
    local v4 = debugLog
    local FullName_2 = Model
    if FullName_2 then
        FullName_2 = Model:GetFullName()
    end
    local v5 = p3 ~= nil
    if not u19 then
        v1 = "client"
    else
        v1 = "server"
    end
    v4(p2, "RegisterModel", FullName_2, "override", v5, v1)
    if Model then
        v4 = u29
        v4[Model] = {Event = v2, db = {}, EventName = p2, Model = Model}
        debugLog(p2, "RegisterModel:registered", Model:GetFullName())
        return Model, v2
    end
    if u19 then
        v4 = {Type = "RegisterModel", Model = p3, HitName = p2}
        local v6 = u30
        table.insert(v6, v4)
        local v7 = debugLog
        local FullName_3 = p3
        if FullName_3 then
            FullName_3 = p3:GetFullName()
        end
        v7(p2, "RegisterModel:queuedPacket", FullName_3)
        CustomHit:FireAllClients(v4)
    end
end

function u56.GetPool(p1) -- Line: 90 -- upvalues: u29 (val)
    return u29
end

function u56.Verify(p1, p2, p3, p4, p5) -- Line: 95 -- upvalues: debugLog (val), u29 (val)
    local EventName, Name_2, Name_3, v1, v2, v3
    if not p4 then
        v1 = debugLog
        local Name = p2
        if Name then
            Name = p2.Name
        end
        v1(nil, "Verify:missingHitPart", Name)
        return
    end
    local Parent = p4
    while Parent do
        v3 = u29[Parent]
        if not v3 then
            Parent = Parent.Parent
            continue
        else
            v1 = v3
        end
        if not v1 then
            v2 = debugLog
            Name_3 = p2
            if Name_3 then
                Name_3 = p2.Name
            end
            v2(nil, "Verify:noEvent", Name_3, p4:GetFullName())
            return
        end
        v2 = debugLog
        EventName = v1.EventName
        Name_2 = p2
        if Name_2 then
            Name_2 = p2.Name
        end
        v2(EventName, "Verify:resolved", Name_2, p4:GetFullName(), p5)
        return true, (v1.Event:OnHit(p2, p3, p4, p5))
    end
    v1 = nil
    if not v1 then
        v2 = debugLog
        Name_3 = p2
        if Name_3 then
            Name_3 = p2.Name
        end
        v2(nil, "Verify:noEvent", Name_3, p4:GetFullName())
        return
    end
    v2 = debugLog
    EventName = v1.EventName
    Name_2 = p2
    if Name_2 then
        Name_2 = p2.Name
    end
    v2(EventName, "Verify:resolved", Name_2, p4:GetFullName(), p5)
    return true, (v1.Event:OnHit(p2, p3, p4, p5))
end

function setupHitModule(p1) -- Line: 112 -- upvalues: u28 (val), debugLog (val)
    u28[p1.Name] = (require(p1))
    local v1 = u28[p1.Name]
    v1.Model = p1:FindFirstChildWhichIsA("Model")
    local v2 = debugLog
    local Name = p1.Name
    local FullName = p1:GetFullName()
    local Model = v1.Model
    if Model then
        Model = v1.Model:GetFullName()
    end
    v2(Name, "setupHitModule", FullName, Model)
end

for i, j in script:GetChildren() do
    if j:IsA("ModuleScript") then
        setupHitModule(j)
    end
end

function setupCustomModulesFolder(p1) -- Line: 123
    for i, j in p1:GetChildren() do
        setupHitModule(j)
    end
end

for k, n in game.ReplicatedStorage:GetChildren() do
    if n:IsA("Folder") then
        CustomHitModules = n:FindFirstChild("CustomHitModules")
        if CustomHitModules then
            setupCustomModulesFolder(CustomHitModules)
        end
    end
end
game.ReplicatedStorage.ChildAdded:Connect(function(p1) -- Line: 140
    task.wait(1)
    if p1:IsA("Folder") then
        local CustomHitModules = p1:FindFirstChild("CustomHitModules")
        if CustomHitModules then
            setupCustomModulesFolder(CustomHitModules)
        end
    end
end)
if not u19 then
    CustomHit:SetClientListener(function(p1) -- Line: 166 -- upvalues: debugLog (val), u56 (val)
        if p1 and p1.Type == "RegisterModel" then
            local v1 = debugLog
            local HitName = p1.HitName
            local Model = p1.Model
            if Model then
                Model = p1.Model:GetFullName()
            end
            v1(nil, "ClientListener:RegisterPacket", HitName, Model)
            v1 = u56
            local HitName_2 = p1.HitName
            local Model_2 = p1.Model
            v1:RegisterModel(HitName_2, Model_2)
        end
    end)

    function onHit(p1, p2) -- Line: 174 -- upvalues: u56 (val), debugLog (val), u47 (ref), CustomHit (val)
        local v1
        local v2 = u56
        local v3 = game
        local LocalPlayer = v3.Players.LocalPlayer
        local Position = p1.Position
        local Instance = p1.Instance
        v2, v1 = v2:Verify(LocalPlayer, Position, Instance, p2)
        if v2 then
            v3 = debugLog
            local Instance_2 = p1.Instance
            if Instance_2 then
                Instance_2 = p1.Instance:GetFullName()
            end
            v3(nil, "Client:onHitValid", p2, Instance_2)
            if u47 and u47.HitEntity and v1 ~= false then
                v3 = "Flesh"
                local v4 = nil
                if typeof(v1) == "string" then
                    v3 = v1
                elseif typeof(v1) == "table" then
                    v3 = v1.hitType or v3
                    v4 = v1.data or v1
                elseif v1 then
                    v3 = tostring(v1)
                end
                u47.HitEntity:Fire(v3, v4)
            end
            v3 = CustomHit
            local v5 = {
                Type = "Hit",
                WeaponID = p2,
                HitResult = {
                    Distance = p1.Distance,
                    Instance = p1.Instance,
                    Material = p1.Material,
                    Position = p1.Position,
                    Normal = p1.Normal,
                },
            }
            v3:FireServer(v5)
        end
    end

    local Hit = u47.Hit
    local v2 = onHit
    Hit:Connect(v2)
    local Hit_2 = v1.Hit
    v2 = onHit
    Hit_2:Connect(v2)
    CustomHit:FireServer()
else
    CustomHit:SetServerListener(function(p1, p2) -- Line: 151 -- upvalues: debugLog (val), u56 (val), u30 (val), CustomHit (val)
        local v1
        if not p2 then
            local v2 = debugLog
            local Name_2 = p1
            if Name_2 then
                Name_2 = p1.Name
            end
            v2(nil, "ServerListener:syncRequest", Name_2, #u30)
            v2 = u30
            v1 = nil
            local v3 = nil
            for i, j in v2, v1, v3 do
                CustomHit:FireAllClients(j)
            end
            return
        end
        if p2.Type ~= "Hit" then
            return
        end
        local HitResult = p2.HitResult
        v1 = debugLog
        local Name = p1
        if Name then
            Name = p1.Name
        end
        local WeaponID = p2.WeaponID
        local Instance = HitResult
        if Instance then
            Instance = HitResult.Instance
            if Instance then
                Instance = HitResult.Instance:GetFullName()
            end
        end
        v1(nil, "ServerListener:HitPacket", Name, WeaponID, Instance)
        v1 = u56
        local Position = HitResult.Position
        local Instance_2 = HitResult.Instance
        local WeaponID_2 = p2.WeaponID
        v1:Verify(p1, Position, Instance_2, WeaponID_2)
    end)
end
return u56