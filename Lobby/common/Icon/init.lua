game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
game:GetService("RunService")
game:GetService("TextService")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local u35 = script
local Reference = require(u35.Reference)
local v1 = Reference.getObject()
local Value = v1
if Value then
    Value = v1.Value
end
if Value and Value ~= u35 then
    return require(Value)
end
if not v1 then
    Reference.addToReplicatedStorage()
end
local GoodSignal = require(u35.Packages.GoodSignal)
local Janitor = require(u35.Packages.Janitor)
local Utility = require(u35.Utility)
require(u35.Attribute)
local Themes = require(u35.Features.Themes)
local Gamepad = require(u35.Features.Gamepad)
local Overflow = require(u35.Features.Overflow)
local u82 = {}
u82.__index = u82
local LocalPlayer = Players.LocalPlayer
local Themes_2 = u35.Features.Themes
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local u93 = {}
local u95 = GoodSignal.new()
local Elements = u35.Elements
local u97 = 0
if GuiService.TopbarInset.Height == 0 then
    GuiService:GetPropertyChangedSignal("TopbarInset"):Wait()
end
u82.baseDisplayOrderChanged = GoodSignal.new()
u82.baseDisplayOrder = 10
u82.baseTheme = require(Themes_2.Default)
local v2 = GuiService.TopbarInset.Height == 36
u82.isOldTopbar = v2
u82.iconsDictionary = u93
local Container = require(Elements.Container)
u82.container = Container(u82)
u82.topbarEnabled = true
u82.iconAdded = GoodSignal.new()
u82.iconRemoved = GoodSignal.new()
u82.iconChanged = GoodSignal.new()

function u82.getIcons() -- Line: 112 -- upvalues: u82 (val)
    return u82.iconsDictionary
end

function u82.getIconByUID(p1) -- Line: 116 -- upvalues: u82 (val)
    local v1 = u82.iconsDictionary[p1]
    if v1 then
        return v1
    end
end

function u82.getIcon(p1) -- Line: 123 -- upvalues: u82 (val), u93 (val)
    local v1 = u82.getIconByUID(p1)
    if v1 then
        return v1
    end
    for k, v in pairs(u93) do
        if v.name == p1 then
            return v
        end
    end
end

function u82.setTopbarEnabled(p1, p2) -- Line: 135 -- upvalues: u82 (val)
    local topbarEnabled
    if typeof(p1) == "boolean" then
        topbarEnabled = p1
    else
        topbarEnabled = u82.topbarEnabled
    end
    if not p2 then
        u82.topbarEnabled = topbarEnabled
    end
    for k, v in pairs(u82.container) do
        v.Enabled = topbarEnabled
    end
end

function u82.modifyBaseTheme(p1) -- Line: 147 -- upvalues: Themes (val), u82 (val), u93 (val)
    local baseTheme, v1
    local v2 = Themes.getModifications(p1)
    for k, v in pairs(v2) do
        for k2, i in pairs(u82.baseTheme) do
            Themes.merge(i, v)
        end
    end
    for k3, j in pairs(u93) do
        v1 = u82
        baseTheme = v1.baseTheme
        j:setTheme(baseTheme)
    end
end

function u82.setDisplayOrder(p1) -- Line: 159 -- upvalues: u82 (val)
    u82.baseDisplayOrder = p1
    u82.baseDisplayOrderChanged:Fire(p1)
end

task.defer(Gamepad.start, u82)
task.defer(Overflow.start, u82)
for k, v in pairs(u82.container) do
    v.Parent = PlayerGui
end
if u82.isOldTopbar then
    u82.modifyBaseTheme(require(Themes_2.Classic))
end

function u82.new() -- Line: 179
    -- upvalues: u82 (val), Janitor (val), Utility (val), u93 (val), GoodSignal (val), u35 (val), Elements (val)
    -- upvalues: u97 (ref), UserInputService (val), u95 (val), StarterGui (val)
    local u0 = {}
    local v1 = u82
    setmetatable(u0, v1)
    local v2 = Janitor.new()
    u0.janitor = v2
    local v3 = Janitor
    v3 = v3.new()
    u0.themesJanitor = v2:add(v3)
    v3 = Janitor
    v3 = v3.new()
    u0.singleClickJanitor = v2:add(v3)
    v3 = Janitor
    v3 = v3.new()
    u0.captionJanitor = v2:add(v3)
    v3 = Janitor
    v3 = v3.new()
    u0.joinJanitor = v2:add(v3)
    v3 = Janitor
    v3 = v3.new()
    u0.menuJanitor = v2:add(v3)
    v3 = Janitor
    v3 = v3.new()
    u0.dropdownJanitor = v2:add(v3)
    local u46 = Utility.generateUID()
    u93[u46] = u0
    v2:add(function() -- Line: 196 -- upvalues: u93 (upval), u46 (val)
        u93[u46] = nil
    end)
    local v4 = GoodSignal
    v4 = v4.new()
    u0.selected = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.deselected = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.toggled = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.viewingStarted = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.viewingEnded = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.stateChanged = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.notified = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.noticeStarted = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.noticeChanged = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.endNotices = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.toggleKeyAdded = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.fakeToggleKeyChanged = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.alignmentChanged = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.updateSize = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.resizingComplete = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.joinedParent = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.menuSet = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.dropdownSet = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.updateMenu = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.startMenuUpdate = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.childThemeModified = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.indicatorSet = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.dropdownChildAdded = v2:add(v4)
    v4 = GoodSignal
    v4 = v4.new()
    u0.menuChildAdded = v2:add(v4)
    u0.iconModule = u35
    u0.UID = u46
    u0.isEnabled = true
    u0.isSelected = false
    u0.isViewing = false
    u0.joinedFrame = false
    u0.parentIconUID = false
    u0.deselectWhenOtherIconSelected = true
    u0.totalNotices = 0
    u0.activeState = "Deselected"
    u0.alignment = ""
    u0.originalAlignment = ""
    u0.appliedTheme = {}
    u0.appearance = {}
    u0.cachedInstances = {}
    u0.cachedNamesToInstances = {}
    u0.cachedCollectives = {}
    u0.bindedToggleKeys = {}
    u0.customBehaviours = {}
    u0.toggleItems = {}
    u0.bindedEvents = {}
    u0.notices = {}
    u0.menuIcons = {}
    u0.dropdownIcons = {}
    u0.childIconsDict = {}
    u0.isOldTopbar = u82.isOldTopbar
    u0.creationTime = os.clock()
    local Widget = require(Elements.Widget)
    local v5 = u82
    v4 = Widget(u0, v5)
    u0.widget = v2:add(v4)
    u0:setAlignment()
    u97 = u97 + 1
    v3 = u97
    u0:setOrder(v3)
    local baseTheme = u82.baseTheme
    u0:setTheme(baseTheme)
    v4 = u0:getInstance("ClickRegion")

    local function handleToggle() -- Line: 271 -- upvalues: u0 (val)
        local v1, v2
        if u0.locked then
            return
        end
        if u0.isSelected then
            v1 = u0
            v2 = u0
            v1:deselect("User", v2)
            return
        end
        v1 = u0
        v2 = u0
        v1:select("User", v2)
    end

    local u254 = false
    local u255 = false
    v4.MouseButton1Click:Connect(function() -- Line: 283 -- upvalues: u254 (ref), u255 (ref), u0 (val)
        local v1, v2
        if u254 then
            return
        end
        u255 = true
        task.delay(0.01, function() -- Line: 288 -- upvalues: u255 (upval)
            u255 = false
        end)
        if u0.locked then
            return
        end
        if u0.isSelected then
            v1 = u0
            v2 = u0
            v1:deselect("User", v2)
            return
        end
        v1 = u0
        v2 = u0
        v1:select("User", v2)
    end)
    v4.TouchTap:Connect(function() -- Line: 293 -- upvalues: u255 (ref), u254 (ref), u0 (val)
        local v1, v2
        if u255 then
            return
        end
        u254 = true
        task.delay(0.01, function() -- Line: 300 -- upvalues: u254 (upval)
            u254 = false
        end)
        if u0.locked then
            return
        end
        if u0.isSelected then
            v1 = u0
            v2 = u0
            v1:deselect("User", v2)
            return
        end
        v1 = u0
        v2 = u0
        v1:select("User", v2)
    end)
    local v6 = UserInputService
    v6 = v6.InputBegan:Connect(function(p1, p2) -- Line: 307 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        if u0.bindedToggleKeys[p1.KeyCode] and not p2 then
            local v1, v2
            if u0.locked then
                return
            end
            if u0.isSelected then
                v1 = u0
                v2 = u0
                v1:deselect("User", v2)
                return
            end
            v1 = u0
            v2 = u0
            v1:select("User", v2)
        end
    end)
    v2:add(v6)

    local function viewingEnded() -- Line: 329 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        u0.isViewing = false
        u0.viewingEnded:Fire(true)
        local v1 = u0
        local v2 = u0
        v1:setState(nil, "User", v2)
    end

    u0.joinedParent:Connect(function() -- Line: 337 -- upvalues: u0 (val)
        if u0.isViewing then
            if u0.locked then
                return
            end
            u0.isViewing = false
            u0.viewingEnded:Fire(true)
            local v1 = u0
            local v2 = u0
            v1:setState(nil, "User", v2)
        end
    end)
    v4.MouseEnter:Connect(function() -- Line: 342 -- upvalues: UserInputService (upval), u0 (val)
        local v1 = not UserInputService.KeyboardEnabled
        if u0.locked then
            return
        end
        u0.isViewing = true
        u0.viewingStarted:Fire(true)
        if not v1 then
            local v2 = u0
            local v3 = u0
            v2:setState("Viewing", "User", v3)
        end
    end)
    local u287 = 0
    local v7 = UserInputService.TouchEnded:Connect(viewingEnded)
    v2:add(v7)
    v4.MouseLeave:Connect(viewingEnded)
    v4.SelectionGained:Connect(function(p1) -- Line: 319 -- upvalues: u0 (val)
        if u0.locked then
            return
        end
        u0.isViewing = true
        u0.viewingStarted:Fire(true)
        if not p1 then
            local v1 = u0
            local v2 = u0
            v1:setState("Viewing", "User", v2)
        end
    end)
    v4.SelectionLost:Connect(viewingEnded)
    v4.MouseButton1Down:Connect(function() -- Line: 351 -- upvalues: u0 (val), UserInputService (upval), u287 (ref)
        if not u0.locked and UserInputService.TouchEnabled then
            u287 = u287 + 1
            local u6 = u287
            task.delay(0.2, function() -- Line: 355 -- upvalues: u6 (val), u287 (upval), u0 (upval)
                if u6 == u287 then
                    if u0.locked then
                        return
                    end
                    u0.isViewing = true
                    u0.viewingStarted:Fire(true)
                    local v1 = u0
                    local v2 = u0
                    v1:setState("Viewing", "User", v2)
                end
            end)
        end
    end)
    v4.MouseButton1Up:Connect(function() -- Line: 362 -- upvalues: u287 (ref)
        u287 = u287 + 1
    end)
    local u325 = u0:getInstance("IconOverlay")
    u0.viewingStarted:Connect(function() -- Line: 368 -- upvalues: u325 (val), u0 (val)
        u325.Visible = not u0.overlayDisabled
    end)
    u0.viewingEnded:Connect(function() -- Line: 371 -- upvalues: u325 (val)
        u325.Visible = false
    end)
    local v8 = u95
    v8 = v8:Connect(function(p1) -- Line: 376 -- upvalues: u0 (val)
        if p1 ~= u0 and u0.deselectWhenOtherIconSelected and p1.deselectWhenOtherIconSelected then
            u0:deselect("AutoDeselect", p1)
        end
    end)
    v2:add(v8)
    local v9 = debug.info(2, "s")
    v7 = string.split(v9, ".")
    v8 = game
    local v10 = nil
    for k, v in pairs(v7) do
        v8 = v8:FindFirstChild(v)
        if not v8 then
            break
        end
        if v8:IsA("ScreenGui") then
            v10 = v8
        end
    end
    if v8 and v10 and v10.ResetOnSpawn == true then
        local v11 = Utility
        v11.localPlayerRespawned(function() -- Line: 401 -- upvalues: u0 (val)
            u0:destroy()
        end)
    end
    u0:getInstance("NoticeLabel")
    u0.toggled:Connect(function(p1) -- Line: 408 -- upvalues: u0 (val), u82 (upval)
        local noticeChanged_2, totalNotices_2, v1, v2
        local v3 = u0
        local noticeChanged = v3.noticeChanged
        local v4 = u0
        local totalNotices = v4.totalNotices
        noticeChanged:Fire(totalNotices)
        local v5 = p1
        for k, v in pairs(u0.childIconsDict) do
            v2 = u82.getIconByUID(k)
            noticeChanged_2 = v2.noticeChanged
            totalNotices_2 = v2.totalNotices
            noticeChanged_2:Fire(totalNotices_2)
            if not v5 and v2.isSelected then
                for k2, i in pairs(v2.childIconsDict) do
                    v1 = u0
                    v2:deselect("HideParentFeature", v1)
                end
            end
        end
    end)
    u0.selected:Connect(function() -- Line: 431 -- upvalues: u0 (val), StarterGui (upval)
        local v1 = #u0.dropdownIcons
        local v2 = 0 < v1
        if v2 then
            if StarterGui:GetCore("ChatActive") and u0.alignment ~= "Right" then
                u0.chatWasPreviouslyActive = true
                StarterGui:SetCore("ChatActive", false)
            end
            if StarterGui:GetCoreGuiEnabled("PlayerList") and u0.alignment ~= "Left" then
                u0.playerlistWasPreviouslyActive = true
                v1 = StarterGui
                local PlayerList = Enum.CoreGuiType.PlayerList
                v1:SetCoreGuiEnabled(PlayerList, false)
            end
        end
    end)
    u0.deselected:Connect(function() -- Line: 444 -- upvalues: u0 (val), StarterGui (upval)
        if u0.chatWasPreviouslyActive then
            u0.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end
        if u0.playerlistWasPreviouslyActive then
            u0.playerlistWasPreviouslyActive = nil
            local v1 = StarterGui
            local PlayerList = Enum.CoreGuiType.PlayerList
            v1:SetCoreGuiEnabled(PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- Line: 459 -- upvalues: u0 (val)
        if u0.activeState == "Deselected" then
            u0.stateChanged:Fire("Deselected")
            u0:refresh()
        end
    end)
    u82.iconAdded:Fire(u0)
    return u0
end

function u82.setName(p1, p2) -- Line: 475
    p1.widget.Name = p2
    p1.name = p2
    return p1
end

function u82:setState(p2, p3, p4) -- Line: 481 -- upvalues: Utility (val), u95 (val)
    local v1, v2
    if p2 then
        v1 = p2
    else
        if not self.isSelected then
            v2 = "Deselected"
        else
            v2 = "Selected"
        end
        v1 = v2
    end
    v2 = Utility.formatStateName(v1)
    if self.activeState == v2 then
        return
    end
    local isSelected = self.isSelected
    self.activeState = v2
    if v2 == "Deselected" then
        self.isSelected = false
        if isSelected then
            self.toggled:Fire(false, p3, p4)
            self.deselected:Fire(p3, p4)
        end
        self:_setToggleItemsVisible(false, p3, p4)
    elseif v2 == "Selected" then
        self.isSelected = true
        if not isSelected then
            self.toggled:Fire(true, p3, p4)
            self.selected:Fire(p3, p4)
            u95:Fire(self, p3, p4)
        end
        self:_setToggleItemsVisible(true, p3, p4)
    end
    self.stateChanged:Fire(v2, p3, p4)
end

function u82:getInstance(p2) -- Line: 514 -- upvalues: Themes (val)
    local scanChildren
    local v1 = self.cachedNamesToInstances[p2]
    if v1 then
        return v1
    end

    local function cacheInstance(p1, p2) -- Line: 522 -- upvalues: self (val)
        if not self.cachedInstances[p2] then
            local Attribute = p2:GetAttribute("Collective")
            local v1 = Attribute
            if v1 then
                v1 = self.cachedCollectives[Attribute]
            end
            if v1 then
                table.insert(v1, p2)
            end
            self.cachedNamesToInstances[p1] = p2
            self.cachedInstances[p2] = true
            p2.Destroying:Once(function() -- Line: 532 -- upvalues: self (upval), p1 (val), p2 (val)
                self.cachedNamesToInstances[p1] = nil
                self.cachedInstances[p2] = nil
            end)
        end
    end

    local widget = self.widget
    cacheInstance("Widget", widget)
    if p2 == "Widget" then
        return widget
    end
    local u10 = nil

    function scanChildren(p1) -- Line: 545
        -- upvalues: self (val), Themes (upval), scanChildren (val), cacheInstance (val), p2 (val), u10 (ref)
        local Attribute, Name, v1
        for k, v in pairs(p1:GetChildren()) do
            Attribute = v:GetAttribute("WidgetUID")
            if not Attribute or Attribute == self.UID then
                v1 = Themes.getRealInstance(v)
                if v1 then
                    v = v1
                end
                scanChildren(v)
                if v:IsA("GuiBase") or v:IsA("UIBase") or v:IsA("ValueBase") then
                    Name = v.Name
                    cacheInstance(Name, v)
                    if Name == p2 then
                        u10 = v
                    end
                end
            end
        end
    end

    scanChildren(widget)
    return u10
end

function u82:getCollective(p2) -- Line: 575
    local v1 = self.cachedCollectives[p2]
    if v1 then
        return v1
    end
    v1 = {}
    for k, v in pairs(self.cachedInstances) do
        if k:GetAttribute("Collective") == p2 then
            table.insert(v1, k)
        end
    end
    self.cachedCollectives[p2] = v1
    return v1
end

function u82:getInstanceOrCollective(p2) -- Line: 596
    local v1 = {}
    local v2 = self:getInstance(p2)
    if v2 then
        table.insert(v1, v2)
    end
    if #v1 == 0 then
        v1 = self:getCollective(p2)
    end
    return v1
end

function u82.getStateGroup(p1, p2) -- Line: 610
    local activeState = p2
    if not activeState then
        activeState = p1.activeState
    end
    local v1 = p1.appearance[activeState]
    if not v1 then
        v1 = {}
        p1.appearance[activeState] = v1
    end
    return v1
end

function u82.refreshAppearance(p1, p2, p3) -- Line: 620 -- upvalues: Themes (val)
    Themes.refresh(p1, p2, p3)
    return p1
end

function u82:refresh() -- Line: 625
    local widget = self.widget
    self:refreshAppearance(widget)
    self.updateSize:Fire()
    return self
end

function u82:updateParent() -- Line: 631 -- upvalues: u82 (val)
    local v1 = u82.getIconByUID(self.parentIconUID)
    if v1 then
        v1.updateSize:Fire()
    end
end

function u82.setBehaviour(p1, p2, p3, p4, p5) -- Line: 638
    local v1 = p2 .. "-" .. p3
    p1.customBehaviours[v1] = p4
    if p5 then
        local v2 = p1:getInstanceOrCollective(p2)
        for k, v in pairs(v2) do
            p1:refreshAppearance(v, p3)
        end
    end
end

function u82.modifyTheme(p1, p2, p3) -- Line: 651 -- upvalues: Themes (val)
    local v1 = Themes.modify(p1, p2, p3)
    return p1, v1
end

function u82.modifyChildTheme(p1, p2, p3) -- Line: 656 -- upvalues: u82 (val)
    p1.childModifications = p2
    p1.childModificationsUID = p3
    for k, v in pairs(p1.childIconsDict) do
        u82.getIconByUID(k):modifyTheme(p2, p3)
    end
    p1.childThemeModified:Fire()
    return p1
end

function u82.removeModification(p1, p2) -- Line: 669 -- upvalues: Themes (val)
    Themes.remove(p1, p2)
    return p1
end

function u82.removeModificationWith(p1, p2, p3, p4) -- Line: 674 -- upvalues: Themes (val)
    Themes.removeWith(p1, p2, p3, p4)
    return p1
end

function u82.setTheme(p1, p2) -- Line: 679 -- upvalues: Themes (val)
    Themes.set(p1, p2)
    return p1
end

function u82.setEnabled(p1, p2) -- Line: 684
    p1.isEnabled = p2
    p1.widget.Visible = p2
    p1:updateParent()
    return p1
end

function u82:select(p2, p3) -- Line: 691
    self:setState("Selected", p2, p3)
    return self
end

function u82:deselect(p2, p3) -- Line: 696
    self:setState("Deselected", p2, p3)
    return self
end

function u82.notify(p1, p2, p3) -- Line: 701 -- upvalues: Elements (val), u82 (val)
    if not p1.notice then
        local Notice = require(Elements.Notice)
        p1.notice = Notice(p1, u82)
    end
    p1.noticeStarted:Fire(p2, p3)
    return p1
end

function u82:clearNotices() -- Line: 715
    self.endNotices:Fire()
    return self
end

function u82.disableOverlay(p1, p2) -- Line: 720
    p1.overlayDisabled = p2
    return p1
end

u82.disableStateOverlay = u82.disableOverlay

function u82.setImage(p1, p2, p3) -- Line: 726
    local v1 = {"IconImage", "Image", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82.setLabel(p1, p2, p3) -- Line: 731
    local v1 = {"IconLabel", "Text", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82:setOrder(p2, p3) -- Line: 736
    local v1 = {"Widget", "LayoutOrder", p2, p3}
    self:modifyTheme(v1)
    return self
end

function u82.setCornerRadius(p1, p2, p3) -- Line: 741
    local v1 = {"IconCorners", "CornerRadius", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82.align(p1, p2, p3) -- Line: 746 -- upvalues: u82 (val)
    local TopbarCentered
    local v1 = tostring(p2):lower()
    if v1 == "mid" or v1 == "centre" then
        v1 = "center"
    end
    if v1 ~= "left" and v1 ~= "center" and v1 ~= "right" then
        v1 = "left"
    end
    if v1 ~= "center" then
        TopbarCentered = u82.container.TopbarStandard
    else
        TopbarCentered = u82.container.TopbarCentered
        if not TopbarCentered then
            TopbarCentered = u82.container.TopbarStandard
        end
    end
    local Holders = TopbarCentered.Holders
    local v2 = (string.upper((string.sub(v1, 1, 1)))) .. string.sub(v1, 2)
    if not p3 then
        p1.originalAlignment = v2
    end
    local joinedFrame = p1.joinedFrame
    local v3 = Holders[v2]
    p1.screenGui = TopbarCentered
    p1.alignmentHolder = v3
    if not p1.isDestroyed then
        p1.widget.Parent = joinedFrame or v3
    end
    p1.alignment = v2
    p1.alignmentChanged:Fire(v2)
    u82.iconChanged:Fire(p1)
    return p1
end

u82.setAlignment = u82.align

function u82.setLeft(p1) -- Line: 775
    p1:setAlignment("Left")
    return p1
end

function u82.setMid(p1) -- Line: 780
    p1:setAlignment("Center")
    return p1
end

function u82.setRight(p1) -- Line: 785
    p1:setAlignment("Right")
    return p1
end

function u82.setWidth(p1, p2, p3) -- Line: 790
    local v1 = {"Widget", "Size", UDim2.fromOffset(p2, p1.widget.Size.Y.Offset), p3}
    p1:modifyTheme(v1)
    v1 = {"Widget", "DesiredWidth", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82.setImageScale(p1, p2, p3) -- Line: 800
    local v1 = {"IconImageScale", "Value", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82.setImageRatio(p1, p2, p3) -- Line: 805
    local v1 = {"IconImageRatio", "AspectRatio", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82.setTextSize(p1, p2, p3) -- Line: 810
    local v1 = {"IconLabel", "TextSize", p2, p3}
    p1:modifyTheme(v1)
    return p1
end

function u82.setTextFont(p1, p2, p3, p4, p5) -- Line: 815
    local Regular = p3 or Enum.FontWeight.Regular
    local v1 = Regular
    local Normal = p4 or Enum.FontStyle.Normal
    local v2 = Normal
    local v3 = nil
    local v4 = typeof(p2)
    if v4 == "number" then
        v3 = Font.fromId(p2, v1, v2)
    elseif v4 == "EnumItem" then
        v3 = Font.fromEnum(p2)
    elseif v4 == "string" and not p2:match("rbxasset") then
        v3 = Font.fromName(p2, v1, v2)
    end
    if not v3 then
        v3 = Font.new(p2, v1, v2)
    end
    local v5 = {"IconLabel", "FontFace", v3, p5}
    p1:modifyTheme(v5)
    return p1
end

function u82.bindToggleItem(p1, p2) -- Line: 836
    if not p2:IsA("GuiObject") and not p2:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end
    p1.toggleItems[p2] = true
    p1:_updateSelectionInstances()
    return p1
end

function u82.unbindToggleItem(p1, p2) -- Line: 845
    p1.toggleItems[p2] = nil
    p1:_updateSelectionInstances()
    return p1
end

function u82:_updateSelectionInstances() -- Line: 851
    local v1
    for k, v in pairs(self.toggleItems) do
        v1 = {}
        for i, j in k:QueryDescendants("TextButton[Active = true], ImageButton[Active = true]") do
            table.insert(v1, j)
        end
        v2.toggleItems[k] = v1
    end
end

function u82:_setToggleItemsVisible(p2, p3, p4) -- Line: 863
    local v1
    local v2, v3, v4 = p4, self, p2
    for k, v in pairs(self.toggleItems) do
        if not v2 or v2 == v3 or v2.toggleItems[k] == nil then
            v1 = "Visible"
            if k:IsA("LayerCollector") then
                v1 = "Enabled"
            end
            k[v1] = v4
        end
    end
end

function u82:bindEvent(p2, p3) -- Line: 875
    local v1 = self[p2]
    local Connect = v1
    if Connect then
        Connect = false
        if typeof(v1) == "table" then
            Connect = v1.Connect
        end
    end
    assert(Connect, "argument[1] must be a valid topbarplus icon event name!")
    local v2 = typeof(p3) == "function"
    assert(v2, "argument[2] must be a function!")
    local bindedEvents = self.bindedEvents
    bindedEvents[p2] = (v1:Connect(function(...) -- Line: 879 -- upvalues: p3 (val), self (val)
        p3(self, ...)
    end))
    return self
end

function u82.unbindEvent(p1, p2) -- Line: 885
    local v1 = p1.bindedEvents[p2]
    if v1 then
        v1:Disconnect()
        p1.bindedEvents[p2] = nil
    end
    return p1
end

function u82.bindToggleKey(p1, p2) -- Line: 894
    local v1 = typeof(p2) == "EnumItem"
    assert(v1, "argument[1] must be a KeyCode EnumItem!")
    p1.bindedToggleKeys[p2] = true
    p1.toggleKeyAdded:Fire(p2)
    p1:setCaption("_hotkey_")
    return p1
end

function u82.unbindToggleKey(p1, p2) -- Line: 902
    local v1 = typeof(p2) == "EnumItem"
    assert(v1, "argument[1] must be a KeyCode EnumItem!")
    p1.bindedToggleKeys[p2] = nil
    return p1
end

function u82.call(p1, p2, ...) -- Line: 908
    local u4 = table.pack(...)
    task.spawn(function() -- Line: 910 -- upvalues: p2 (val), p1 (val), u4 (val)
        local v1 = p2
        local v2 = p1
        local v3 = u4
        v1(v2, table.unpack(v3))
    end)
    return p1
end

function u82.addToJanitor(p1, p2) -- Line: 916
    p1.janitor:add(p2)
    return p1
end

function u82:lock() -- Line: 921
    local v1 = self:getInstance("ClickRegion")
    v1.Visible = false
    self.locked = true
    return self
end

function u82:unlock() -- Line: 929
    local v1 = self:getInstance("ClickRegion")
    v1.Visible = true
    self.locked = false
    return self
end

function u82.debounce(p1, p2) -- Line: 936
    p1:lock()
    task.wait(p2)
    p1:unlock()
    return p1
end

function u82.autoDeselect(p1, p2) -- Line: 943
    local v1
    if p2 ~= nil then
        v1 = p2
    else
        v1 = true
    end
    p1.deselectWhenOtherIconSelected = v1
    return p1
end

function u82.oneClick(p1, p2) -- Line: 953
    local v1
    local singleClickJanitor = p1.singleClickJanitor
    singleClickJanitor:clean()
    if p2 then
        v1 = p1.selected:Connect(function() -- Line: 959 -- upvalues: p1 (val)
            local v1 = p1
            local v2 = p1
            v1:deselect("OneClick", v2)
        end)
        singleClickJanitor:add(v1)
    elseif p2 == nil then
        v1 = p1.selected:Connect(function() -- Line: 959 -- upvalues: p1 (val)
            local v1 = p1
            local v2 = p1
            v1:deselect("OneClick", v2)
        end)
        singleClickJanitor:add(v1)
    end
    p1.oneClickEnabled = true
    return p1
end

function u82:setCaption(p2) -- Line: 967 -- upvalues: Elements (val)
    if p2 == "_hotkey_" and self.captionText then
        return self
    end
    local captionJanitor = self.captionJanitor
    self.captionJanitor:clean()
    if p2 and p2 ~= "" then
        local v1 = require(Elements.Caption)(self)
        local v2 = captionJanitor:add(v1)
        v2:SetAttribute("CaptionText", p2)
        self.caption = v2
        self.captionText = p2
        return self
    end
    self.caption = nil
    self.captionText = nil
    return self
end

function u82.setCaptionHint(p1, p2) -- Line: 985
    local v1 = typeof(p2) == "EnumItem"
    assert(v1, "argument[1] must be a KeyCode EnumItem!")
    p1.fakeToggleKey = p2
    p1.fakeToggleKeyChanged:Fire(p2)
    p1:setCaption("_hotkey_")
    return p1
end

function u82:leave() -- Line: 993
    self.joinJanitor:clean()
    return self
end

function u82.joinMenu(p1, p2) -- Line: 999 -- upvalues: Utility (val)
    local v1 = Utility
    local joinFeature = v1.joinFeature
    local menuIcons = p2.menuIcons
    joinFeature(p1, p2, menuIcons, p2:getInstance("Menu"))
    p2.menuChildAdded:Fire(p1)
    return p1
end

function u82:setMenu(p2) -- Line: 1005
    self.menuSet:Fire(p2)
    return self
end

function u82.setFrozenMenu(p1, p2) -- Line: 1010
    p1:freezeMenu(p2)
    p1:setMenu(p2)
end

function u82:freezeMenu() -- Line: 1015
    self:select("FrozenMenu", self)
    self:bindEvent("deselected", function(p1) -- Line: 1019 -- upvalues: self (val)
        local v1 = self
        p1:select("FrozenMenu", v1)
    end)
    self:modifyTheme({"IconSpot", "Visible", false})
end

function u82.joinDropdown(p1, p2) -- Line: 1025 -- upvalues: Utility (val)
    p2:getDropdown()
    local v1 = Utility
    local joinFeature = v1.joinFeature
    local dropdownIcons = p2.dropdownIcons
    joinFeature(p1, p2, dropdownIcons, p2:getInstance("DropdownScroller"))
    p2.dropdownChildAdded:Fire(p1)
    return p1
end

function u82:getDropdown() -- Line: 1032 -- upvalues: Elements (val)
    local dropdown = self.dropdown
    if not dropdown then
        dropdown = require(Elements.Dropdown)(self)
        self.dropdown = dropdown
        self:clipOutside(dropdown)
    end
    return dropdown
end

function u82.setDropdown(p1, p2) -- Line: 1042
    p1:getDropdown()
    p1.dropdownSet:Fire(p2)
    return p1
end

function u82:clipOutside(p2) -- Line: 1048 -- upvalues: Utility (val)
    local v1 = Utility.clipOutside(self, p2)
    self:refreshAppearance(p2)
    return self, v1
end

function u82.setIndicator(p1, p2) -- Line: 1059 -- upvalues: Elements (val), u82 (val)
    if not p1.indicator then
        local janitor = p1.janitor
        local Indicator = require(Elements.Indicator)
        local v1 = u82
        local v2 = Indicator(p1, v1)
        p1.indicator = janitor:add(v2)
    end
    p1.indicatorSet:Fire(p2)
end

function u82:destroy() -- Line: 1074 -- upvalues: u82 (val)
    if self.isDestroyed then
        return
    end
    self:clearNotices()
    if self.parentIconUID then
        self:leave()
    end
    self.isDestroyed = true
    self.janitor:clean()
    u82.iconRemoved:Fire(self)
end

u82.Destroy = u82.destroy
return u82