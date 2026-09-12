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
    p1.noticeChanged:Connect(function(p1_2) -- Line: 43 -- upvalues: TextLabel (val), p2 (val), p1 (val), Utility (val), Frame (val)
        local v1
        if not p1_2 then
            return
        end
        local v2 = 99 < p1_2
        if not v2 then
            v1 = p1_2
        else
            v1 = "99+"
        end
        TextLabel.Text = v1
        if v2 then
            TextLabel.TextSize = 11
        end
        local v3 = true
        if p1_2 < 1 then
            v3 = false
        end
        local v4 = p2.getIconByUID(p1.parentIconUID)
        local v5 = true
        if not (0 < #p1.dropdownIcons) then
            v5 = 0 < #p1.menuIcons
        end
        if not p1.isSelected then
            if v4 and not v4.isSelected then
                v3 = false
            end
        elseif v5 or v4 and not v4.isSelected then
            v3 = false
        end
        Utility.setVisible(Frame, v3, "NoticeHandler")
    end)
    p1.noticeStarted:Connect(function(p1_2, p2_2) -- Line: 71 -- upvalues: p1 (val), p2 (val), Janitor (val), GoodSignal (val), Utility (val)
        local deselected
        if p1_2 then
            deselected = p1_2
        else
            deselected = p1.deselected
        end
        local v1 = p2.getIconByUID(p1.parentIconUID)
        if v1 then
            v1:notify(deselected)
        end
        local janitor = p1.janitor
        local v2 = Janitor
        v2 = v2.new()
        local u21 = janitor:add(v2)
        local v3 = GoodSignal
        v3 = v3.new()
        local u27 = u21:add(v3)
        local v4 = p1
        v4 = v4.endNotices:Connect(function() -- Line: 83 -- upvalues: u27 (val)
            u27:Fire()
        end)
        u21:add(v4)
        v4 = deselected:Connect(function() -- Line: 86 -- upvalues: u27 (val)
            u27:Fire()
        end)
        u21:add(v4)
        v2 = p2_2
        if not v2 then
            v2 = Utility.generateUID()
        end
        local u52 = v2
        v2 = p1
        local notices = v2.notices
        notices[u52] = {completeSignal = u27, clearNoticeEvent = deselected}
        p1:getInstance("NoticeLabel")

        local function updateNotice() -- Line: 95 -- upvalues: p1 (upval)
            local v1 = p1
            local noticeChanged = v1.noticeChanged
            local v2 = p1
            local totalNotices = v2.totalNotices
            noticeChanged:Fire(totalNotices)
        end

        v4 = p1
        local notified = v4.notified
        local v5 = u52
        notified:Fire(v5)
        v4 = p1
        v4.totalNotices = v4.totalNotices + 1
        v4 = p1
        local noticeChanged = v4.noticeChanged
        v5 = p1
        local totalNotices = v5.totalNotices
        noticeChanged:Fire(totalNotices)
        u27:Once(function() -- Line: 101 -- upvalues: u21 (val), p1 (upval), u52 (ref)
            u21:destroy()
            local v1 = p1
            v1.totalNotices = v1.totalNotices - 1
            p1.notices[u52] = nil
            v1 = p1
            local noticeChanged = v1.noticeChanged
            local v2 = p1
            local totalNotices = v2.totalNotices
            noticeChanged:Fire(totalNotices)
        end)
    end)
    Frame:SetAttribute("ClipToJoinedParent", true)
    p1:clipOutside(Frame)
    return Frame
end