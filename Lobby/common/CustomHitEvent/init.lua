local CustomHitModules
local CustomHit = require(game.ReplicatedStorage.common.RedEvents.Framework.FrameworkEvents).CustomHit
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
local u56 = {
    RegisterModel = function(p1, p2, p3) -- Line: 59 -- upvalues: u28 (val), debugLog (val), u19 (val), u29 (val), u30 (val), CustomHit (val)
        local Model, v1, v2
        local v3 = u28[p2]
        if not v3 then
            local FullName = p3
            if FullName then
                FullName = p3:GetFullName()
            end
            debugLog(p2, "RegisterModel:missingEventModule", FullName)
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
        local FullName_2 = Model
        if FullName_2 then
            FullName_2 = Model:GetFullName()
        end
        local v4 = p3 ~= nil
        if not u19 then
            v1 = "client"
        else
            v1 = "server"
        end
        debugLog(p2, "RegisterModel", FullName_2, "override", v4, v1)
        if Model then
            u29[Model] = {Event = v2, db = {}, EventName = p2, Model = Model}
            debugLog(p2, "RegisterModel:registered", Model:GetFullName())
            return Model, v2
        end
        if u19 then
            local v5 = {Type = "RegisterModel", Model = p3, HitName = p2}
            table.insert(u30, v5)
            local FullName_3 = p3
            if FullName_3 then
                FullName_3 = p3:GetFullName()
            end
            debugLog(p2, "RegisterModel:queuedPacket", FullName_3)
            CustomHit:FireAllClients(v5)
        end
    end,
    GetPool = function(p1) -- Line: 90 -- upvalues: u29 (val)
        return u29
    end,
    Verify = function(p1, p2, p3, p4, p5) -- Line: 95 -- upvalues: debugLog (val), u29 (val)
        local FullName, Name_2, Name_3, v1, v2, v3
        if not p4 then
            local Name = p2
            if Name then
                Name = p2.Name
            end
            debugLog(nil, "Verify:missingHitPart", Name)
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
                Name_3 = p2
                if Name_3 then
                    Name_3 = p2.Name
                end
                debugLog(nil, "Verify:noEvent", Name_3, p4:GetFullName())
                return
            end
            Name_2 = p2
            if Name_2 then
                Name_2 = p2.Name
            end
            FullName = p4:GetFullName()
            debugLog(v1.EventName, "Verify:resolved", Name_2, FullName, p5)
            v2 = v1.Event:OnHit(p2, p3, p4, p5)
            return true, v2
        end
        v1 = nil
        if not v1 then
            Name_3 = p2
            if Name_3 then
                Name_3 = p2.Name
            end
            debugLog(nil, "Verify:noEvent", Name_3, p4:GetFullName())
            return
        end
        Name_2 = p2
        if Name_2 then
            Name_2 = p2.Name
        end
        FullName = p4:GetFullName()
        debugLog(v1.EventName, "Verify:resolved", Name_2, FullName, p5)
        v2 = v1.Event:OnHit(p2, p3, p4, p5)
        return true, v2
    end,
}
function setupHitModule(p1) -- Line: 112 -- upvalues: u28 (val), debugLog (val)
    u28[p1.Name] = require(p1)
    local v1 = u28[p1.Name]
    v1.Model = p1:FindFirstChildWhichIsA("Model")
    local FullName = p1:GetFullName()
    local Model = v1.Model
    if Model then
        Model = v1.Model:GetFullName()
    end
    debugLog(p1.Name, "setupHitModule", FullName, Model)
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
            local Model = p1.Model
            if Model then
                Model = p1.Model:GetFullName()
            end
            debugLog(nil, "ClientListener:RegisterPacket", p1.HitName, Model)
            u56:RegisterModel(p1.HitName, p1.Model)
        end
    end)
    function onHit(p1, p2) -- Line: 174 -- upvalues: u56 (val), debugLog (val), u47 (ref), CustomHit (val)
        local v1, v2
        v1, v2 = u56:Verify(game.Players.LocalPlayer, p1.Position, p1.Instance, p2)
        if v1 then
            local Instance = p1.Instance
            if Instance then
                Instance = p1.Instance:GetFullName()
            end
            debugLog(nil, "Client:onHitValid", p2, Instance)
            if u47 and u47.HitEntity and v2 ~= false then
                local v3 = "Flesh"
                local v4 = nil
                if typeof(v2) == "string" then
                    v3 = v2
                elseif typeof(v2) == "table" then
                    v3 = v2.hitType or v3
                    v4 = v2.data or v2
                elseif v2 then
                    v3 = tostring(v2)
                end
                u47.HitEntity:Fire(v3, v4)
            end
            CustomHit:FireServer({
                Type = "Hit",
                WeaponID = p2,
                HitResult = {
                    Distance = p1.Distance,
                    Instance = p1.Instance,
                    Material = p1.Material,
                    Position = p1.Position,
                    Normal = p1.Normal,
                },
            })
        end
    end
    u47.Hit:Connect(onHit)
    v1.Hit:Connect(onHit)
    CustomHit:FireServer()
else
    CustomHit:SetServerListener(function(p1, p2) -- Line: 151 -- upvalues: debugLog (val), u56 (val), u30 (val), CustomHit (val)
        if not p2 then
            local Name_2 = p1
            if Name_2 then
                Name_2 = p1.Name
            end
            debugLog(nil, "ServerListener:syncRequest", Name_2, #u30)
            local v1 = u30
            local v2 = nil
            local v3 = nil
            for i, j in v1, v2, v3 do
                CustomHit:FireAllClients(j)
            end
            return
        end
        if p2.Type ~= "Hit" then
            return
        end
        local HitResult = p2.HitResult
        local Name = p1
        if Name then
            Name = p1.Name
        end
        local Instance = HitResult
        if Instance then
            Instance = HitResult.Instance
            if Instance then
                Instance = HitResult.Instance:GetFullName()
            end
        end
        debugLog(nil, "ServerListener:HitPacket", Name, p2.WeaponID, Instance)
        u56:Verify(p1, HitResult.Position, HitResult.Instance, p2.WeaponID)
    end)
end
return u56