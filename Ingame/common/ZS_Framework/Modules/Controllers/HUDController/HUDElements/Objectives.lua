local ObjectivesUI = script:WaitForChild("ObjectivesUI")
local ObjectiveList = ObjectivesUI.ObjectiveList
local Template = ObjectiveList.Template
local InnerFrame = ObjectivesUI.NewObjective.InnerFrame
local InnerFrame_2 = ObjectivesUI.ObjectiveCompleted.InnerFrame
local Markers = ObjectivesUI.Markers
local Template_2 = Markers.Template
local ImageLabel = ObjectivesUI.CheckFrame.ImageLabel
local Sounds = ObjectivesUI.Sounds
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
require(game.ReplicatedStorage.common:WaitForChild("HUDService"))
local u35 = {
    kill = "rbxassetid://14066162181",
    collect = "rbxassetid://14066160240",
    find = "rbxassetid://14066161325",
    move = "rbxassetid://14066155074",
    interact = "rbxassetid://14101485038",
}
local u36 = {
    kill = Color3.fromRGB(255, 98, 98),
    collect = Color3.fromRGB(255, 175, 94),
    find = Color3.fromRGB(189, 172, 255),
    move = Color3.fromRGB(157, 247, 255),
    interact = Color3.fromRGB(138, 255, 130),
}
local u62 = {}
local u63 = {}
local u64 = {IsShowing = true}
function u64.Show(p1) -- Line: 41 -- upvalues: ObjectivesUI (val), u64 (val)
    ObjectivesUI.Enabled = true
    u64.IsShowing = true
end
function u64.Hide(p1) -- Line: 46 -- upvalues: ObjectivesUI (val), u64 (val)
    ObjectivesUI.Enabled = false
    u64.IsShowing = false
end
function u64.AddObjective(p1, p2, p3) -- Line: 53 -- upvalues: HttpService (val), Template (val), u35 (val), u36 (val), u62 (val), ObjectiveList (val)
    local AccentColor, Progress, v1
    if not p3 then
        v1 = HttpService:GenerateGUID(false)
    else
        v1 = p3
    end
    p2.Identifier = v1
    p2.IsPrimary = p2.IsPrimary or false
    if not p2.Progress then
        Progress = 0
    else
        Progress = p2.Progress
    end
    p2.Progress = Progress
    p2.ObjectiveType = p2.Type
    v1 = Template:Clone()
    v1.Name = p2.Identifier
    v1.IsPrimaryLabel.Visible = p2.IsPrimary
    v1.TextLabel.Text = p2.Text
    if not p2.ImageID then
        v1.ImageLabel.Image = u35[p2.ObjectiveType]
    else
        v1.ImageLabel.Image = p2.ImageID
    end
    if p2.AccentColor then
        AccentColor = p2.AccentColor
    elseif not p2.ImageID then
        AccentColor = u36[p2.ObjectiveType]
    else
        AccentColor = Color3.new(1, 1, 1)
    end
    v1.ImageLabel.ImageColor3 = AccentColor
    v1.ProgressLabel.TextColor3 = AccentColor
    v1.Visible = true
    p2.ListElement = v1
    p2.CreationTime = os.clock()
    u62[p2.Identifier] = p2
    evaluateLayoutOrder()
    updateListItemProgress(u62[p2.Identifier])
    showNewOrCompletedObjective(p2)
    v1.Parent = ObjectiveList
    return p2.Identifier
end
function u64.UpdateProgress(p1, p2, p3, p4) -- Line: 99 -- upvalues: u62 (val)
    local v1 = u62[p2]
    if v1 then
        if p3 then
            v1.Progress = p3
        end
        if p4 then
            v1.ProgressTotal = p4
        end
        updateListItemProgress(v1)
    end
end
function u64.SetIsPrimary(p1, p2, p3) -- Line: 114 -- upvalues: u62 (val)
    local v1 = u62[p2]
    if v1 then
        local ListElement = v1.ListElement
        v1.IsPrimary = p3
        ListElement.IsPrimaryLabel.Visible = p3
        evaluateLayoutOrder()
    end
end
function u64.RemoveObjective(p1, p2, p3) -- Line: 126 -- upvalues: u62 (val)
    local v1 = u62[p2]
    if v1 then
        v1.ListElement:Destroy()
        u62[p2] = nil
        if p3 then
            showNewOrCompletedObjective(v1, p3)
        end
    end
end
function u64.AddMarker(p1, p2, p3, p4, p5) -- Line: 139 -- upvalues: HttpService (val), u36 (val), Template_2 (val), u35 (val), Markers (val), u63 (val)
    local AccentColor, ImageID, v1
    if not p4 then
        v1 = HttpService:GenerateGUID(false)
    else
        v1 = p4
    end
    if p2.AccentColor then
        AccentColor = p2.AccentColor
    elseif not p2.ImageID then
        AccentColor = u36[p2.ObjectiveType]
    else
        AccentColor = Color3.new(1, 1, 1)
    end
    local v2 = Template_2:Clone()
    v2.Visible = true
    ImageID = p2.ImageID
    if not ImageID then
        ImageID = u35[p2.ObjectiveType]
    end
    v2.ImageLabel.Image = ImageID
    v2.ImageLabel.ImageColor3 = AccentColor
    v2.TextLabel.TextColor3 = AccentColor
    v2.TextLabel.Text = p2.Text
    v2.Parent = Markers
    u63[v1] = {
        Identifier = v1,
        ObjectiveType = p2.ObjectiveType,
        Text = p2.Text,
        Location = p3,
        UIElement = v2,
        ObjectiveIdentifier = p5,
    }
    updateMarkerTextTransparency()
    return v1
end
function u64.RemoveMarker(p1, p2) -- Line: 178 -- upvalues: u63 (val)
    local v1 = u63[p2]
    if v1 then
        u63[p2] = nil
        updateMarkerTextTransparency()
        v1.UIElement:Destroy()
    end
end
function u64.SetMarkerText(p1, p2, p3) -- Line: 188 -- upvalues: u63 (val)
    local v1 = u63[p2]
    if v1 then
        v1.Text = p3
        v1.UIElement.TextLabel.Text = p3
    end
end
function u64.SetMarkerType(p1, p2, p3) -- Line: 197 -- upvalues: u63 (val), u35 (val), u36 (val)
    local v1 = u63[p2]
    if v1 then
        local UIElement = v1.UIElement
        UIElement.ImageLabel.Image = u35[p3]
        UIElement.ImageLabel.ImageColor3 = u36[p3]
        UIElement.TextLabel.TextColor3 = u36[p3]
    end
end
function u64.GetGuiList(p1) -- Line: 208 -- upvalues: ObjectiveList (val)
    return ObjectiveList
end
function evaluateLayoutOrder() -- Line: 215 -- upvalues: u62 (val)
    local v1 = {}
    local v2 = u62
    local v3 = nil
    local v4 = nil
    for i in v2, v3, v4 do
        table.insert(v1, i)
    end
    table.sort(v1, function(p1, p2) -- Line: 222 -- upvalues: u62 (upval)
        local IsPrimary = u62[p1].IsPrimary
        if IsPrimary == u62[p2].IsPrimary then
            local v1 = u62[p1].CreationTime < u62[p2].CreationTime
            return v1
        end
        if IsPrimary then
            return true
        end
        return false
    end)
    v2 = v1
    v3 = nil
    v4 = nil
    for j, k in v2, v3, v4 do
        u62[k].ListElement.LayoutOrder = j
    end
end
function updateListItemProgress(p1) -- Line: 240
    local ObjectiveType = p1.ObjectiveType
    if p1.ProgressFormat then
        p1.ListElement.ProgressLabel.Text = p1.ProgressFormat:format(p1.Progress, p1.ProgressTotal)
        return
    end
    if ObjectiveType == "kill" or ObjectiveType == "collect" or ObjectiveType == "find" or ObjectiveType == "interact" then
        p1.ListElement.ProgressLabel.Text = ("%d/%d"):format(p1.Progress, p1.ProgressTotal)
        return
    end
    if ObjectiveType == "move" then
        p1.ListElement.ProgressLabel.Text = ("%dm"):format(p1.Progress)
    end
end
local u79 = {}
local u80 = false
function showNewOrCompletedObjective(p1, p2) -- Line: 257 -- upvalues: u36 (val), u79 (val), u35 (val), u80 (ref), InnerFrame_2 (val), Sounds (val), ImageLabel (val), InnerFrame (val)
    local AccentColor, ImageID
    if p1.AccentColor then
        AccentColor = p1.AccentColor
    elseif not p1.ImageID then
        AccentColor = u36[p1.ObjectiveType]
    else
        AccentColor = Color3.new(1, 1, 1)
    end
    local v1 = {Text = p1.Text}
    ImageID = p1.ImageID
    if not ImageID then
        ImageID = u35[p1.ObjectiveType]
    end
    v1.ImageID = ImageID
    v1.AccentColor = AccentColor
    v1.IsCompleted = p2 or false
    v1.NewSoundId = p1.NewSoundId
    v1.CompleteSoundId = p1.CompleteSoundId
    table.insert(u79, v1)
    if not u80 then
        u80 = true
        task.defer(function() -- Line: 281 -- upvalues: u79 (upval), InnerFrame_2 (upval), Sounds (upval), ImageLabel (upval), InnerFrame (upval), u80 (upval)
            local v1, v2
            while true do
                v1 = u79[1]
                if not v1.IsCompleted then
                    if not v1.NewSoundId then
                        Sounds.NewObjective:Play()
                    else
                        local u95 = Instance.new("Sound", InnerFrame)
                        u95.SoundId = v1.NewSoundId
                        u95.Volume = 1
                        u95:Play()
                        u95.Ended:Connect(function() -- Line: 311 -- upvalues: u95 (val)
                            u95:Destroy()
                        end)
                    end
                    InnerFrame.ObjectiveLabel.Text = v1.Text
                    InnerFrame.ImageLabel.Image = v1.ImageID
                    InnerFrame.ImageLabel.ImageColor3 = v1.AccentColor
                    v2 = UDim2.fromScale(0, 0)
                    InnerFrame:TweenPosition(v2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    task.wait(3)
                    v2 = UDim2.fromScale(0, -1)
                    InnerFrame:TweenPosition(v2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    task.wait(0.25)
                    table.remove(u79, 1)
                else
                    if not v1.CompleteSoundId then
                        Sounds.ObjectiveCompleted:Play()
                    else
                        local u7 = Instance.new("Sound", InnerFrame_2)
                        u7.SoundId = v1.CompleteSoundId
                        u7.Volume = 1
                        u7:Play()
                        u7.Ended:Connect(function() -- Line: 291 -- upvalues: u7 (val)
                            u7:Destroy()
                        end)
                    end
                    InnerFrame_2.ObjectiveLabel.Text = v1.Text
                    InnerFrame_2.ImageLabel.Image = v1.ImageID
                    InnerFrame_2.ImageLabel.ImageColor3 = v1.AccentColor
                    v2 = UDim2.fromScale(0, 0)
                    InnerFrame_2:TweenPosition(v2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    v2 = UDim2.fromScale(0, 0)
                    ImageLabel:TweenPosition(v2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    task.wait(3)
                    v2 = UDim2.fromScale(0, -1)
                    InnerFrame_2:TweenPosition(v2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    v2 = UDim2.fromScale(0, -1)
                    ImageLabel:TweenPosition(v2, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
                    task.wait(0.25)
                    table.remove(u79, 1)
                end
                if #u79 == 0 then
                    break
                end
            end
            u80 = false
        end)
    end
end
function updateMarkerFormat(p1, p2) -- Line: 331
    local v1, v2, v3
    p1.ArrowLabel.Visible = not p2
    if not p2 then
        v2 = Vector2.new(0.5, 0.5)
    else
        v2 = Vector2.new(0.5, 1)
    end
    p1.ImageLabel.AnchorPoint = v2
    if not p2 then
        v3 = 0.5
    else
        v3 = -0.5
    end
    p1.ImageLabel.Position = UDim2.new(0.5, 0, v3, 0)
    if not p2 then
        v1 = 1
    else
        v1 = 0
    end
    p1.ImageTransparency = v1
    p1.TextLabel.Visible = p2
end
function updateMarkerArrow(p1, p2) -- Line: 339 -- upvalues: ObjectivesUI (val)
    local v1 = p2 - Vector2.new(ObjectivesUI.AbsoluteSize.X * 0.5, ObjectivesUI.AbsoluteSize.Y * 0.5)
    local v2 = math.atan2(v1.Y, v1.X)
    p1.ArrowLabel.Rotation = math.deg(v2)
end
function clampScreenPosition(p1, p2) -- Line: 346 -- upvalues: ObjectivesUI (val)
    local v1, v2
    local v3 = ObjectivesUI.AbsoluteSize.X - p2 * 2
    local v4 = ObjectivesUI.AbsoluteSize.Y - p2 * 2
    local v5 = p1 - Vector2.new(ObjectivesUI.AbsoluteSize.X * 0.5, ObjectivesUI.AbsoluteSize.Y * 0.5)
    local X = p1.X
    local Y = p1.Y
    if X < p2 then
        local v6 = v3 * 0.5 * (v3 * 0.5)
        v1 = math.sqrt(v6 + v4 * 0.5 * (v4 * 0.5))
        v2 = math.atan2(v5.Y, v5.X)
        local v7 = math.cos(v2) * v1
        local v8 = math.sin(v2) * v1
        if v3 * 0.5 < v7 then
            v6 = v3 * 0.5 / v7
            v7 = v7 * v6
            v8 = v8 * v6
        elseif v7 < -v3 * 0.5 then
            v6 = -v3 * 0.5 / v7
            v7 = v7 * v6
            v8 = v8 * v6
        end
        if v4 * 0.5 < v8 then
            v6 = v4 * 0.5 / v8
            v7 = v7 * v6
            v8 = v8 * v6
        elseif v8 < -v4 * 0.5 then
            v6 = -v4 * 0.5 / v8
            v7 = v7 * v6
            v8 = v8 * v6
        end
        X = v7 + (v3 + p2 * 2) * 0.5
        Y = v8 + (v4 + p2 * 2) * 0.5
    elseif Y >= p2 and v3 + p2 >= X and v4 + p2 >= Y then
    end
    v1 = Vector2.new(X, Y)
    v2 = if X == p1.X then Y ~= p1.Y else true
    return v1, v2
end
function updateMarkerTextTransparency() -- Line: 390 -- upvalues: u63 (val)
    local v1, v2, v3, v4, v5, v6, v7, v8
    local v9 = {}
    local v10 = u63
    local v11 = nil
    local v12 = nil
    for i, j in v10, v11, v12 do
        if not (v9[j.ObjectiveType]) then
            v9[j.ObjectiveType] = {}
        end
        table.insert(v9[j.ObjectiveType], j)
    end
    v10 = v9
    v11 = nil
    v12 = nil
    for k, n in v10, v11, v12 do
        v5 = {}
        v6 = n
        v7 = nil
        v8 = nil
        for m, i5 in v6, v7, v8 do
            v1 = i5.ObjectiveIdentifier or ""
            if not (v5[v1]) then
                v5[v1] = {}
            end
            table.insert(v5[v1], i5)
        end
        v6 = v5
        v7 = nil
        v8 = nil
        for i6, i7 in v6, v7, v8 do
            v1 = i7
            v2 = nil
            v3 = nil
            for i8, i9 in v1, v2, v3 do
                if 1 >= #v5 then
                    v4 = 1
                else
                    v4 = 0
                end
                i9.UIElement.TextLabel.TextTransparency = v4
            end
        end
    end
end
ObjectivesUI.Parent = game.Players.LocalPlayer.PlayerGui
task.defer(function() -- Line: 425 -- upvalues: RunService (val), u63 (val), ObjectivesUI (val)
    RunService.RenderStepped:Connect(function() -- Line: 426 -- upvalues: u63 (upval), ObjectivesUI (upval)
        local Position, Z, v1, v2, v3, v4, v5, v6, v7, v8
        local v9 = u63
        local v10 = nil
        local v11 = nil
        for i, j in v9, v10, v11 do
            Position = nil
            if typeof(j.Location) == "Instance" then
                Position = j.Location.Position
            elseif typeof(j.Location) == "Vector3" then
                Position = j.Location
            end
            if Position then
                v7 = workspace.CurrentCamera:WorldToScreenPoint(Position)
                v8 = Vector2.new(v7.X, v7.Y)
                Z = v7.Z
                v1 = Vector2.new(ObjectivesUI.AbsoluteSize.X * 0.5, ObjectivesUI.AbsoluteSize.Y * 0.5)
                v2 = v8 - v1
                if 0 >= Z then
                    v5, v6 = clampScreenPosition(v1 - v2 * 1000, j.UIElement.AbsoluteSize.X * 5)
                    v4 = v6
                    v2 = v5 - v1
                else
                    v5, v6 = clampScreenPosition(v8, j.UIElement.AbsoluteSize.X * 5)
                    v3 = v5
                    v4 = v6
                end
                updateMarkerFormat(j.UIElement, not v4)
                j.UIElement.Position = UDim2.new(0, v3.X, 0, v3.Y)
                if v4 then
                    v5 = math.atan2(v2.Y, v2.X)
                    j.UIElement.ArrowLabel.Rotation = math.deg(v5)
                end
            end
        end
    end)
end)
return u64