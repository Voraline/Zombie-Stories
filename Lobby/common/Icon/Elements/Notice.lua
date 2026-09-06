return function(p1, p2) -- Line: 1
    local Frame = Instance.new("Frame")
    Frame.Name = "Notice"
    Frame.ZIndex = 25
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundTransparency = 0.1
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.Visible = false
    Frame.Parent = p1.widget
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    Instance.new("UIStroke").Parent = Frame
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Name = "NoticeLabel"
    TextLabel.ZIndex = 26
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.5, 0, 0.515, 0)
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.FontSize = Enum.FontSize.Size14
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.Text = "1"
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.Font = Enum.Font.Arial
    TextLabel.Parent = Frame
    local Parent = script.Parent.Parent
    local Packages = Parent.Packages
    local Janitor = require(Packages.Janitor)
    local GoodSignal = require(Packages.GoodSignal)
    local Utility = require(Parent.Utility)
    p1.noticeChanged:Connect(function(a1) -- Line: 43 -- upvalues: TextLabel (val), p2 (val), p1 (val), Utility (val), Frame (val)
        local v1
        if not a1 then
            return
        end
        local v2 = 99 < a1
        if not v2 then
            v1 = a1
        else
            v1 = "99+"
        end
        TextLabel.Text = v1
        if v2 then
            TextLabel.TextSize = 11
        end
        local v3 = not (a1 < 1)
        local v4 = p2.getIconByUID(p1.parentIconUID)
        local v5 = true
        local v6 = #p1.dropdownIcons
        if 0 >= v6 then
            v6 = #p1.menuIcons
            v5 = 0 < v6
        end
        if not p1.isSelected then
            if v4 and not v4.isSelected then
                v3 = false
            end
        elseif v5 then
            v3 = false
        elseif v4 and not v4.isSelected then
            v3 = false
        end
        Utility.setVisible(Frame, v3, "NoticeHandler")
    end)
    p1.noticeStarted:Connect(function(a1, a2) -- Line: 71 -- upvalues: p1 (val), p2 (val), Janitor (val), GoodSignal (val), Utility (val)
        local deselected
        if a1 then
            deselected = a1
        else
            deselected = p1.deselected
        end
        local v1 = p2.getIconByUID(p1.parentIconUID)
        if v1 then
            v1:notify(deselected)
        end
        local u21 = p1.janitor:add(Janitor.new())
        local u27 = u21:add(GoodSignal.new())
        u21:add(p1.endNotices:Connect(function() -- Line: 83 -- upvalues: u27 (val)
            u27:Fire()
        end))
        u21:add(deselected:Connect(function() -- Line: 86 -- upvalues: u27 (val)
            u27:Fire()
        end))
        local v2 = a2
        if not v2 then
            v2 = Utility.generateUID()
        end
        local u52 = v2
        p1.notices[u52] = {completeSignal = u27, clearNoticeEvent = deselected}
        p1:getInstance("NoticeLabel")
        local function updateNotice() -- Line: 95 -- upvalues: p1 (upval)
            p1.noticeChanged:Fire(p1.totalNotices)
        end
        p1.notified:Fire(u52)
        local v3 = p1
        v3.totalNotices = v3.totalNotices + 1
        p1.noticeChanged:Fire(p1.totalNotices)
        u27:Once(function() -- Line: 101 -- upvalues: u21 (val), p1 (upval), u52 (ref)
            u21:destroy()
            local v1 = p1
            v1.totalNotices = v1.totalNotices - 1
            p1.notices[u52] = nil
            p1.noticeChanged:Fire(p1.totalNotices)
        end)
    end)
    Frame:SetAttribute("ClipToJoinedParent", true)
    p1:clipOutside(Frame)
    return Frame
end