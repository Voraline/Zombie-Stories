if (workspace:WaitForChild("Values")):WaitForChild("IsLobby").Value then
    return nil
end
local u18 = game:GetService("RunService"):IsServer()
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = game.ReplicatedStorage.common
local RedEvents = game.ReplicatedStorage.common.RedEvents
local ProximityPromptZS = require(common.ProximityPromptZS)
local u46 = require("@game/ReplicatedStorage/common/PlayerHandler")
local u49 = require("@game/ReplicatedStorage/common/Objective")
local u52 = require("@game/ReplicatedStorage/common/Table")
local GameState = require(ReplicatedStorage.common.ZS_Shared.Data.GameState)
local MonetizationCatalog = require(ReplicatedStorage.common.ZS_Shared.Data.MonetizationCatalog)
local CurrencyFormat = require(ReplicatedStorage.common.ZS_Framework.UI.CurrencyFormat)
local PurchasePrompt = require(ReplicatedStorage.common.ZS_Shared.Util.PurchasePrompt)
local u83 = nil
if u18 then
    u83 = require(ReplicatedStorage.common.skillTree.SkillTreeData)
end
local DoReviveEvent = require(RedEvents.Framework.DoReviveEvent)
local u152 = nil
local u90 = nil
local u91 = {}
local u92 = {}
local u93 = {}
local u94 = nil
local u95 = {}
local u96 = nil
if u18 then
    Players.PlayerRemoving:Connect(function(p1) -- Line: 46 -- upvalues: u95 (val)
        u95[p1] = nil
    end)
end

local function getSelfRevives(p1) -- Line: 51
    local success, result = pcall(function() -- Line: 52 -- upvalues: p1 (val)
        local GetData = game.ServerScriptService.common.Data.Bindables.GetData
        local v1 = p1
        return GetData:Invoke(v1)
    end)
    if success and type(result) == "table" then
        local SelfRevives = result.SelfRevives
        return tonumber(SelfRevives) or 0
    end
    return 0
end

local function getReviveProductPrice() -- Line: 61
    -- upvalues: u96 (ref), MonetizationCatalog (val), MarketplaceService (val)
    if u96 then
        return u96
    end
    local v1 = 35
    local Revive1 = MonetizationCatalog.GetProduct("Revive1")
    if Revive1 then
        local success, result = pcall(function() -- Line: 69 -- upvalues: MarketplaceService (upval), Revive1 (val)
            local v1 = MarketplaceService
            local v2 = Revive1
            local Product = Enum.InfoType.Product
            return v1:GetProductInfo(v2, Product)
        end)
        if success and type(result) == "table" then
            local PriceInRobux = result.PriceInRobux
            v1 = tonumber(PriceInRobux) or v1
        end
    end
    u96 = v1
    return u96
end

local function updateDownedMarkers() -- Line: 81 -- upvalues: u52 (val), u93 (val), u94 (ref), u49 (val)
    local PrimaryPart
    local v1 = #u52.keys(u93)
    if not (0 < v1) then
        if u94 then
            u94:Destroy()
            u94 = nil
        end
        return
    end
    if not u94 then
        v1 = u49
        u94 = v1.new({
            Type = "interact",
            Text = "Revive teammates",
            ImageID = "rbxassetid://2706886795",
            IsPrimary = false,
            ProgressFormat = "",
            AccentColor = Color3.fromRGB(255, 73, 73),
        })
    end
    v1 = {}
    local v2 = u93
    local v3 = nil
    local v4 = nil
    for i in v2, v3, v4 do
        if i.Parent and i.Character and i.Character.PrimaryPart then
            PrimaryPart = i.Character.PrimaryPart
            table.insert(v1, PrimaryPart)
        end
    end
    u94.MarkerParts = v1
end

if u18 then
    local common_2 = (game:GetService("ServerStorage")):FindFirstChild("common")
    if common_2 then
        common_2 = game:GetService("ServerStorage").common:FindFirstChild("ProgressionTracker")
    end
    if common_2 then
        u152 = require(common_2)
    end
    local Data = game.ServerScriptService.common:FindFirstChild("Data")
    if Data then
        local Bindables = Data:FindFirstChild("Bindables")
        local BoughtToken = Bindables
        if BoughtToken then
            BoughtToken = Bindables:FindFirstChild("BoughtToken")
        end
        if BoughtToken then
            BoughtToken.Event:Connect(function(p1, p2) -- Line: 162 -- upvalues: u92 (val), u91 (val)
                if p2 then
                    local v1 = u92[p1]
                    if v1 then
                        v1:RefreshSelfPrompt()
                    end
                    if u91[p1] then
                        u91[p1][p1].Triggered:Fire(p1)
                    end
                end
            end)
        end
    end
else
    DoReviveEvent:SetClientListener(function(p1) -- Line: 110
        -- upvalues: ProximityPromptZS (val), CurrencyFormat (val), u90 (ref), u93 (val), updateDownedMarkers (val)
        local v1, v2
        local v3 = p1[1]
        if v3 ~= "ChangeSelfPrompt" then
            if v3 == "BeingRevived" then
                v2 = p1[2]
                v1 = tonumber(v2)
                v2 = p1[3]
                u90._PlayersReviving[v2] = v1
                return
            end
            if v3 == "StoppedReviving" then
                v1 = p1[2]
                u90._PlayersReviving[v1] = nil
                return
            end
            if v3 == "NotDowned" then
                v1 = p1[2]
                u93[v1] = nil
                updateDownedMarkers()
            end
            return
        end
        v1 = p1[2]
        local v4 = p1[3]
        v2 = tonumber(v4)
        v4 = p1[4]
        local v5 = p1[5]
        local v6 = tonumber(v5) or 35
        if not ProximityPromptZS:GetPromptByIdentifier(v1) then
            while not ProximityPromptZS:GetPromptByIdentifier(v1) do
                task.wait()
            end
        end
        local PromptByIdentifier = ProximityPromptZS:GetPromptByIdentifier(v1)
        if not v4 then
            if v4 then
                PromptByIdentifier.ActionText = "Use AED+"
                PromptByIdentifier.ObjectText = "(+1 AED) " .. v2 .. " Tokens"
            elseif not (0 < v2) then
                PromptByIdentifier.ActionText = "Buy Revive Token"
                PromptByIdentifier.ObjectText = CurrencyFormat.Robux(v6)
            else
                PromptByIdentifier.ActionText = "Use Revive Token"
                PromptByIdentifier.ObjectText = v2 .. " Left"
            end
        elseif v2 <= 0 then
            PromptByIdentifier.ObjectText = "Self Revive"
            PromptByIdentifier.ActionText = "Use AED+"
        elseif v4 then
            PromptByIdentifier.ActionText = "Use AED+"
            PromptByIdentifier.ObjectText = "(+1 AED) " .. v2 .. " Tokens"
        elseif not (0 < v2) then
            PromptByIdentifier.ActionText = "Buy Revive Token"
            PromptByIdentifier.ObjectText = CurrencyFormat.Robux(v6)
        else
            PromptByIdentifier.ActionText = "Use Revive Token"
            PromptByIdentifier.ObjectText = v2 .. " Left"
        end
        PromptByIdentifier.HoldTime = 0.25
        PromptByIdentifier.ResetOnRelease = false
    end)
end
local u183 = {}
u183.__index = u183

function u183.new(p1) -- Line: 180
    -- upvalues: u183 (val), u18 (val), u90 (ref), common (val), u95 (val), MonetizationCatalog (val)
    -- upvalues: MarketplaceService (val)
    local v1 = u183
    local u4 = setmetatable({}, v1)
    if not u18 and p1.Player == game.Players.LocalPlayer then
        u90 = u4
    end
    local v2 = require
    v1 = common
    local PlayerHandler_2 = v2(v1.PlayerHandler)
    local Player = p1.Player
    u4._PlayerState = PlayerHandler_2:WaitForPlayerState(Player)
    v2 = {}
    u4._PlayersReviving = v2
    u4._Player = p1.Player
    u4._UsedAED = false
    u4._HasAED = false
    u4.JoinConnection = nil
    u4.EntitlementConnection = nil
    if u18 then
        v2 = u95[u4._Player]
        if v2 == nil then
            task.defer(function() -- Line: 198 -- upvalues: u4 (val), MonetizationCatalog (upval), MarketplaceService (upval), u95 (upval)
                local u7 = u4._Player:GetAttribute("HasRevivePlusEntitlement") == true
                pcall(function() -- Line: 200 -- upvalues: MonetizationCatalog (upval), MarketplaceService (upval), u4 (upval), u7 (ref)
                    local UserId, v1, v2
                    for i, v in ipairs(MonetizationCatalog.GetPassIds("RevivePlus")) do
                        v1 = MarketplaceService
                        v2 = u4
                        UserId = v2._Player.UserId
                        if v1:UserOwnsGamePassAsync(UserId, v) then
                            u7 = true
                            return
                        end
                    end
                end)
                u95[u4._Player] = u7
                u4._HasAED = u7
                u4:RefreshSelfPrompt()
            end)
        else
            u4._HasAED = v2
        end
        local AttributeChangedSignal = u4._Player:GetAttributeChangedSignal("HasRevivePlusEntitlement")
        u4.EntitlementConnection = AttributeChangedSignal:Connect(function() -- Line: 213 -- upvalues: u4 (val), u95 (upval)
            local v1 = u4._Player:GetAttribute("HasRevivePlusEntitlement") == true
            u95[u4._Player] = v1
            u4._HasAED = v1
            u4:RefreshSelfPrompt()
        end)
    end
    u4.ReviveProgress = 0
    u4.Inactive = true
    return u4
end

function u183.Serialize(p1) -- Line: 225
    return {p1.Duration}
end

function u183.CopyStatus(p1, p2, p3) -- Line: 231
    p1._UsedAED = p2._UsedAED
    p1._HasAED = p2._HasAED
    p1._RevivesLeft = p2._RevivesLeft
    p1.Duration = p2.Duration
    p1.ReviveProgress = p2.ReviveProgress
    p1.Inactive = p2.Inactive
    if not p1.Inactive then
        local Duration = p1.Duration
        p1:Apply(p3, Duration)
    end
end

function u183:DeletePrompts() -- Line: 243 -- upvalues: u91 (val), u92 (val)
    if self._RevivePrompts then
        local _RevivePrompts = self._RevivePrompts
        local v1 = nil
        local v2 = nil
        for i, j in _RevivePrompts, v1, v2 do
            j:Destroy()
        end
        u91[self._Player] = nil
        u92[self._Player] = nil
        self._RevivePrompts = nil
    end
    table.clear(self._PlayersReviving)
end

function u183:InitalizeRevives() -- Line: 255 -- upvalues: u18 (val), GameState (val), u83 (ref)
    if u18 then
        local v1
        local v2 = GameState.Data.Variables.PlayerDowns or 3
        if not u83 then
            v1 = 0
        else
            v1 = u83.getExtraDowns(self._Player)
            if not v1 then
                v1 = 0
            end
        end
        self._RevivesLeft = v2 + v1
    end
end

function u183.ResetRunState(p1) -- Line: 264
    p1:InitalizeRevives()
    p1._UsedAED = false
end

function u183:RefreshSelfPrompt() -- Line: 269 -- upvalues: u18 (val), DoReviveEvent (val), getReviveProductPrice (val)
    if u18 and not self.Inactive then
        local _RevivePrompts = self._RevivePrompts
        if _RevivePrompts then
            _RevivePrompts = self._RevivePrompts[self._Player]
        end
        if _RevivePrompts and _RevivePrompts.Enabled then
            local v1
            local _Player = self._Player
            local success, result = pcall(function() -- Line: 52 -- upvalues: _Player (val)
                local GetData = game.ServerScriptService.common.Data.Bindables.GetData
                local v1 = _Player
                return GetData:Invoke(v1)
            end)
            if not success or type(result) ~= "table" then
                v1 = 0
            else
                local SelfRevives = result.SelfRevives
                v1 = tonumber(SelfRevives) or 0
            end
            local _HasAED = self._HasAED
            if _HasAED then
                _HasAED = not self._UsedAED
            end
            local v2 = DoReviveEvent
            local _Player_2 = self._Player
            local v3 = {}
            local _Identifier = _RevivePrompts._Identifier
            local v4 = tostring(v1)
            local v5 = getReviveProductPrice
            v5 = v5()
            v3[1] = "ChangeSelfPrompt"
            v3[2] = _Identifier
            v3[3] = v4
            v3[4] = _HasAED or nil
            v3[5] = (tostring(v5))
            v2:FireClient(_Player_2, v3)
            return
        end
        return
    end
end

function u183:Apply(p2, p3) -- Line: 290
    -- upvalues: u18 (val), u152 (ref), u46 (val), DoReviveEvent (val), MonetizationCatalog (val), PurchasePrompt (val)
    -- upvalues: ProximityPromptZS (val), Players (val), u91 (val), u92 (val), u93 (val), updateDownedMarkers (val)
    self.Duration = p3 or 30
    self.Inactive = false
    self._MaxReviveTime = 5
    if u18 and not self._RevivesLeft then
        self:InitalizeRevives()
    end
    self:DeletePrompts()
    local Player = p2.Player
    local v1 = false
    if Player.Character and Player.Character.Parent then
        v1 = Player.Character.PrimaryPart ~= nil
    end
    if v1 then
        if u18 then
            local PrimaryPart = Player.Character.PrimaryPart
            if not PrimaryPart then
                return
            end
            if u152 then
                u152:AddToLeaderStat(Player, "Downs", 1)
            end
            table.clear(self._PlayersReviving)

            local function onInteractBegan(p1) -- Line: 322
                -- upvalues: u46 (upval), Player (val), self (val), u152 (upval), DoReviveEvent (upval)
                local PlayerState = u46:GetPlayerState(p1)
                if PlayerState
                    and not PlayerState.IsDowned
                    and not PlayerState.IsDead
                    and p1 ~= Player
                    and not self._PlayersReviving[p1] then
                    local v1
                    local Class = u152
                    if Class then
                        Class = u152:GetClass(p1)
                    end
                    if Class ~= "Medic" then
                        v1 = 5
                    else
                        v1 = 2.5
                    end
                    local v2 = v1 - 0.33
                    self._PlayersReviving[p1] = v2
                    v1 = DoReviveEvent
                    local v3 = Player
                    local v4 = {}
                    local v5 = tostring(v2)
                    v4[1] = "BeingRevived"
                    v4[2] = v5
                    v4[3] = p1
                    v1:FireClient(v3, v4)
                end
            end

            local function onInteractEnded(p1) -- Line: 336
                -- upvalues: u46 (upval), Player (val), self (val), DoReviveEvent (upval)
                local PlayerState = u46:GetPlayerState(p1)
                if PlayerState
                    and not PlayerState.IsDowned
                    and not PlayerState.IsDead
                    and p1 ~= Player
                    and self._PlayersReviving[p1] then
                    self._PlayersReviving[p1] = nil
                    local v1 = DoReviveEvent
                    local v2 = Player
                    local v3 = {"StoppedReviving", p1}
                    v1:FireClient(v2, v3)
                end
            end

            local function onTriggered(p1) -- Line: 347
                -- upvalues: Player (val), self (val), DoReviveEvent (upval), PrimaryPart (val)
                -- upvalues: MonetizationCatalog (upval), PurchasePrompt (upval)
                local v1
                if p1 ~= Player then
                    return
                end
                local _HasAED = self._HasAED
                if _HasAED then
                    _HasAED = not self._UsedAED
                end
                local success, result = pcall(function() -- Line: 52 -- upvalues: p1 (val)
                    local GetData = game.ServerScriptService.common.Data.Bindables.GetData
                    local v1 = p1
                    return GetData:Invoke(v1)
                end)
                if not success or type(result) ~= "table" then
                    v1 = 0
                else
                    local SelfRevives = result.SelfRevives
                    v1 = tonumber(SelfRevives) or 0
                end
                if not _HasAED and not (0 < v1) then
                    local Revive1 = MonetizationCatalog.GetProduct("Revive1")
                    if Revive1 then
                        PurchasePrompt.Product(p1, Revive1)
                    end
                    return
                end
                self._PlayersReviving[p1] = 5
                local v2 = DoReviveEvent
                local v3 = Player
                local v4 = {}
                local v5 = tostring(5)
                v4[1] = "BeingRevived"
                v4[2] = v5
                v4[3] = p1
                v2:FireClient(v3, v4)
                v2 = self._RevivePrompts[p1]
                v2.Enabled = false
                v2 = self
                v2._RevivesLeft = v2._RevivesLeft + 1
                if _HasAED then
                    self._UsedAED = true
                else
                    require("@game/ServerStorage/common/DataStore2")(
                        game.ServerScriptService.common.Data.MAIN_DATASTORE_NAME.Value,
                        Player
                    ):Update(function(p1) -- Line: 365
                        if not p1.SelfRevives then
                            p1.SelfRevives = 0
                        end
                        p1.SelfRevives = p1.SelfRevives - 1
                        return p1
                    end)
                end
                local Sound = Instance.new("Sound")
                Sound.SoundId = "rbxassetid://9057348814"
                Sound.Volume = 1
                local Sound_2 = Instance.new("Sound")
                Sound_2.SoundId = "rbxassetid://9057349072"
                Sound_2.Volume = 2
                Sound.Parent = PrimaryPart
                Sound_2.Parent = PrimaryPart
                Sound:Play()
                Sound_2:Play()
                task.delay(5, function() -- Line: 390 -- upvalues: PrimaryPart (upval), Sound (val), Sound_2 (val)
                    if not PrimaryPart.Parent then
                        return
                    end
                    Sound:Destroy()
                    Sound_2:Destroy()
                    local Sound_3 = Instance.new("Sound")
                    Sound_3.SoundId = "rbxassetid://4879269872"
                    Sound_3.Volume = 1
                    Sound_3.Parent = PrimaryPart
                    Sound_3:Play()
                    task.wait(10)
                    Sound_3:Destroy()
                end)
            end

            self._RevivePrompts = {}

            local function createPrompt(p1) -- Line: 416
                -- upvalues: u152 (upval), ProximityPromptZS (upval), Player (val), PrimaryPart (val), self (val)
                -- upvalues: onInteractBegan (val), onInteractEnded (val), onTriggered (val)
                local v1
                local Class = u152
                if Class then
                    Class = u152:GetClass(p1)
                end
                local new = ProximityPromptZS.new
                local v2 = {
                    ActionText = "REVIVE",
                    Range = 6,
                    Obstructable = false,
                    ResetOnRelease = true,
                    ObjectText = Player.Name,
                    Part = PrimaryPart,
                }
                if Class ~= "Medic" then
                    v1 = 5
                else
                    v1 = 2.5
                end
                v2.HoldTime = v1
                v2.Players = {p1}
                local v3 = new(v2)
                self._RevivePrompts[p1] = v3
                local InteractBegan = v3.InteractBegan
                local v4 = onInteractBegan
                InteractBegan:Connect(v4)
                local InteractEnded = v3.InteractEnded
                v4 = onInteractEnded
                InteractEnded:Connect(v4)
                local Triggered = v3.Triggered
                v4 = onTriggered
                Triggered:Connect(v4)
            end

            for i, j in Players:GetPlayers() do
                createPrompt(j)
            end
            self.JoinConnection = Players.PlayerAdded:Connect(createPrompt)
            u91[Player] = self._RevivePrompts
            u92[Player] = self
            self:RefreshSelfPrompt()
            return
        end
        if Player ~= game.Players.LocalPlayer then
            u93[Player] = true
            updateDownedMarkers()
        end
    end
end

function u183:Update(p2) -- Line: 454 -- upvalues: u18 (val), DoReviveEvent (val)
    if not (self.Duration <= 0) and not self.Inactive then
        local v1, v2, v3, v4
        if u18 then
            local _PlayersReviving = self._PlayersReviving
            v2 = nil
            v3 = nil
            for i, j in _PlayersReviving, v2, v3 do
                if not i.Parent then
                    self._PlayersReviving[i] = nil
                end
            end
            local _PlayerState = self._PlayerState
            v2 = next(self._PlayersReviving) ~= nil
            _PlayerState.BeingRevived = v2
        end
        if not self._PlayerState.BeingRevived then
            self.Duration = self.Duration - p2
        end
        if self.Duration <= 0 then
            self.Duration = 0
        end
        if u18 and 0 < self._PlayerState.HP then
            if self.JoinConnection then
                self.JoinConnection:Disconnect()
                self.JoinConnection = nil
            end
            self._PlayerState.IsDowned = false
            self._PlayerState.BeingRevived = false
            self.Inactive = true
            self:DeletePrompts()
            v1 = DoReviveEvent
            v3 = {"NotDowned", self._PlayerState.Player}
            v1:FireAllClients(v3)
            return
        end
        if not next(self._PlayersReviving) then
            self.ReviveProgress = 0
        else
            local _PlayersReviving_3
            local _MaxReviveTime = self._MaxReviveTime
            local _PlayersReviving_2 = self._PlayersReviving
            v3 = nil
            v4 = nil
            for k, n in _PlayersReviving_2, v3, v4 do
                if self._MaxReviveTime < n then
                    self._MaxReviveTime = n
                end
                _PlayersReviving_3 = self._PlayersReviving
                _PlayersReviving_3[k] = _PlayersReviving_3[k] - v5
                if self._PlayersReviving[k] <= 0 then
                    self._PlayersReviving[k] = 0
                end
                if self._PlayersReviving[k] <= _MaxReviveTime then
                    _MaxReviveTime = self._PlayersReviving[k]
                end
            end
            v3 = 1 - _MaxReviveTime / self._MaxReviveTime
            self.ReviveProgress = math.clamp(v3, 0, 1)
        end
        if u18 and 1 <= self.ReviveProgress then
            if game.ReplicatedStorage:FindFirstChild("place") then
                local Position
                v2 = require("@game/ServerStorage/place/StoryModule")
                local _Player = self._Player
                for m, i5 in v2:GetAllNPCs() do
                    Position = i5.HRP.Position
                    if (_Player:DistanceFromCharacter(Position)) < 10 then
                        i5:Stun(3)
                    end
                end
            end
            local GodMode = self._PlayerState.GodMode
            local _Player_2 = self._Player
            local u170 = Instance.new("ForceField", _Player_2.Character)
            if not GodMode then
                self._PlayerState.GodMode = true
                task.delay(5, function() -- Line: 552 -- upvalues: u170 (val), self (val)
                    u170:Destroy()
                    self._PlayerState.GodMode = false
                end)
            end
            self._PlayerState.HP = 100
            self._RevivesLeft = self._RevivesLeft - 1
            v4 = DoReviveEvent
            local v6 = {"NotDowned", self._PlayerState.Player}
            v4:FireAllClients(v6)
            return
        end
        if self.Duration <= 0 then
            if u18 then
                if self._PlayerState.HP <= 0 then
                    self._PlayerState.IsDead = true
                end
                self._PlayerState.IsDowned = false
                self._PlayerState.BeingRevived = false
                if self.JoinConnection then
                    self.JoinConnection:Disconnect()
                    self.JoinConnection = nil
                end
                v1 = DoReviveEvent
                v3 = {"NotDowned", self._PlayerState.Player}
                v1:FireAllClients(v3)
            end
            self.Inactive = true
            self:DeletePrompts()
            return
        end
        if u18 and self._RevivesLeft <= 0 then
            if u18 then
                if self._PlayerState.HP <= 0 then
                    self._PlayerState.IsDead = true
                end
                self._PlayerState.IsDowned = false
                self._PlayerState.BeingRevived = false
                if self.JoinConnection then
                    self.JoinConnection:Disconnect()
                    self.JoinConnection = nil
                end
                v1 = DoReviveEvent
                v3 = {"NotDowned", self._PlayerState.Player}
                v1:FireAllClients(v3)
            end
            self.Inactive = true
            self:DeletePrompts()
            return
        end
        return
    end
end

function u183:Destroy() -- Line: 593 -- upvalues: u93 (val), updateDownedMarkers (val)
    if self.JoinConnection then
        self.JoinConnection:Disconnect()
        self.JoinConnection = nil
    end
    self:DeletePrompts()
    if self.EntitlementConnection then
        self.EntitlementConnection:Disconnect()
        self.EntitlementConnection = nil
    end
    u93[self._PlayerState.Player] = nil
    updateDownedMarkers()
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

return u183