local Signal = require(game.ReplicatedStorage.common.Signal)
local u10 = {}
local u18 = game:GetService("RunService"):IsServer()
local HUDServiceEvent = require(game.ReplicatedStorage.common.RedEvents.Framework.HUDServiceEvent)
local u23 = {}
local u24 = {
    Elements = {},
    ElementServices = {},
    Visible = true,
    VisibilityBlacklist = {Fade = true},
}
local v1 = {}
u24.VisibilityExemptions = v1
u24.VisibilityChanged = Signal.new()
local function isVisibilityExempt(p1) -- Line: 40 -- upvalues: u24 (val)
    local v1 = true
    if u24.VisibilityBlacklist[p1] ~= true then
        local v2 = u24.VisibilityExemptions[p1]
        if not v2 then
            v2 = {}
        end
        v1 = next(v2) ~= nil
    end
    return v1
end
function u24.AddElementService(p1, p2, p3) -- Line: 46 -- upvalues: u18 (val), u24 (val)
    assert(u18, "AddElementService only available on Server")
    u24.ElementServices[p2] = p3
end
function u24.GetElementService(p1, p2) -- Line: 52 -- upvalues: u18 (val), u24 (val)
    assert(u18, "GetElementService only available on Server")
    return u24.ElementServices[p2]
end
function u24.AddElement(p1, p2, p3) -- Line: 58 -- upvalues: u18 (val), u24 (val), u10 (val)
    assert(not u18, "AddElement only available on Client")
    u24.Elements[p2] = p3
    runElementQueue(p2)
    if not u24.Visible then
        u10[p2] = p3.IsShowing
        p3:Hide()
    end
end
function u24.GetElement(p1, p2) -- Line: 69 -- upvalues: u18 (val), u24 (val)
    assert(not u18, "GetElement only available on Client")
    return u24.Elements[p2]
end
function u24.RemoveElement(p1, p2) -- Line: 75 -- upvalues: u18 (val), u24 (val)
    assert(not u18, "RemoveElement only available on Client")
    u24.Elements[p2] = nil
end
function u24.SetElementVisibilityExempt(p1, p2, p3, p4) -- Line: 81 -- upvalues: u18 (val), u24 (val), u10 (val)
    local v1 = not u18
    assert(v1, "SetElementVisibilityExempt only available on Client")
    local v2 = u24.VisibilityExemptions[p2]
    if not p4 then
        if v2 then
            v2[p3] = nil
            if next(v2) == nil then
                u24.VisibilityExemptions[p2] = nil
                v1 = u24.Elements[p2]
                if not u24.Visible and v1 then
                    u10[p2] = v1.IsShowing
                    if v1.IsShowing then
                        v1:Hide()
                    end
                end
            end
        end
        return
    end
    if v2 == nil then
        u24.VisibilityExemptions[p2] = {}
    end
    v2[p3] = true
    v1 = u24.Elements[p2]
    if u24.Visible or not v1 or not (u10[p2]) then
        return
    end
    v1:Show()
end
function u24.ShowElement(p1, p2, p3, ...) -- Line: 112 -- upvalues: u18 (val), HUDServiceEvent (val), u24 (val), u10 (val)
    local v1
    if u18 then
        v1 = {
            Type = "ShowElement",
            ElementName = p2,
            Args = {...},
        }
        if p3 then
            HUDServiceEvent:FireClient(p3, v1)
            return
        end
        HUDServiceEvent:FireAllClients(v1)
        return
    end
    v1 = u24.Elements[p2]
    if not v1 then
        return
    end
    if u24.Visible then
        v1:Show(unpack({...}))
        return
    end
    local v2 = true
    if u24.VisibilityBlacklist[p2] ~= true then
        local v3 = u24.VisibilityExemptions[p2]
        if not v3 then
            v3 = {}
        end
        v2 = next(v3) ~= nil
    end
    if v2 then
        v1:Show(unpack({...}))
        return
    end
    u10[p2] = true
end
function u24.HideElement(p1, p2, p3, ...) -- Line: 137 -- upvalues: u18 (val), HUDServiceEvent (val), u24 (val), u10 (val)
    local v1
    if u18 then
        v1 = {
            Type = "HideElement",
            ElementName = p2,
            Args = {...},
        }
        if p3 then
            HUDServiceEvent:FireClient(p3, v1)
            return
        end
        HUDServiceEvent:FireAllClients(v1)
        return
    end
    v1 = u24.Elements[p2]
    if not v1 then
        return
    end
    if u24.Visible then
        v1:Hide(unpack({...}))
        return
    end
    local v2 = true
    if u24.VisibilityBlacklist[p2] ~= true then
        local v3 = u24.VisibilityExemptions[p2]
        if not v3 then
            v3 = {}
        end
        v2 = next(v3) ~= nil
    end
    if v2 then
        v1:Hide(unpack({...}))
        return
    end
    u10[p2] = false
end
function u24.SetAllVisibility(p1, p2, p3) -- Line: 162 -- upvalues: u18 (val), HUDServiceEvent (val), u24 (val), u10 (val)
    local v1, v2, v3
    if u18 then
        local v4 = {Type = "SetAllVisibility", Visible = p2}
        if p3 then
            HUDServiceEvent:FireClient(p3, v4)
            return
        end
        HUDServiceEvent:FireAllClients(v4)
        u24.Visible = p2
        u24.VisibilityChanged:Fire(p2)
        return
    end
    if u24.Visible then
        if not u24.Visible then
            v1 = p2
        elseif p2 then
            v1 = p2
        else
            v1 = p2
            for k, v in pairs(u24.Elements) do
                v3 = true
                if u24.VisibilityBlacklist[k] ~= true then
                    v2 = u24.VisibilityExemptions[k]
                    if not v2 then
                        v2 = {}
                    end
                    v3 = next(v2) ~= nil
                end
                if not v3 then
                    u10[k] = v.IsShowing
                    if v.IsShowing then
                        v:Hide()
                    end
                end
            end
        end
    elseif p2 then
        v1 = p2
        for k2, i in pairs(u24.Elements) do
            v3 = true
            if u24.VisibilityBlacklist[k2] ~= true then
                v2 = u24.VisibilityExemptions[k2]
                if not v2 then
                    v2 = {}
                end
                v3 = next(v2) ~= nil
            end
            if not v3 then
                if not (u10[k2]) then
                    i:Hide()
                else
                    i:Show()
                end
            end
        end
    end
    u24.Visible = v1
    u24.VisibilityChanged:Fire(v1)
end
function u24.SendElementCommand(p1, p2, p3, p4, ...) -- Line: 200 -- upvalues: u18 (val), HUDServiceEvent (val)
    assert(u18, "SendElementCommand can only be used on the server. Use GetElement instead.")
    local v1 = {
        Type = "SendCommand",
        ElementName = p2,
        CommandName = p3,
        Args = {...},
    }
    if p4 then
        HUDServiceEvent:FireClient(p4, v1)
        return
    end
    HUDServiceEvent:FireAllClients(v1)
end
function runPacket(p1) -- Line: 219 -- upvalues: u24 (val)
    local Args
    local ElementName = p1.ElementName
    if p1.Type == "ShowElement" then
        Args = p1.Args
        if not Args then
            Args = {}
        end
        u24:ShowElement(ElementName, nil, unpack(Args))
        return
    end
    if p1.Type == "HideElement" then
        local Args_2 = p1.Args
        if not Args_2 then
            Args_2 = {}
        end
        u24:HideElement(ElementName, nil, unpack(Args_2))
        return
    end
    if p1.Type == "SetAllVisibility" then
        u24:SetAllVisibility(p1.Visible)
        return
    end
    if p1.Type ~= "SendCommand" then
        return
    end
    local Element = u24:GetElement(ElementName)
    if Element == nil or Element[p1.CommandName] == nil then
        return
    end
    if p1.Args then
        Element[p1.CommandName](Element, unpack(p1.Args))
        return
    end
    Element[p1.CommandName](Element)
end
function runElementQueue(p1) -- Line: 240 -- upvalues: u23 (val)
    if u23[p1] ~= nil then
        local v1 = u23[p1]
        local v2 = nil
        local v3 = nil
        for i, j in v1, v2, v3 do
            runPacket(j)
        end
    end
end
if u18 then
    local u45 = {}
    HUDServiceEvent:SetServerListener(function(p1) -- Line: 251 -- upvalues: u45 (val), u24 (val), HUDServiceEvent (val)
        if not (u45[p1]) then
            u45[p1] = true
            if not u24.Visible then
                HUDServiceEvent:FireClient(p1, {Type = "SetAllVisibility", Visible = false})
            end
        end
    end)
    return u24
end
HUDServiceEvent:SetClientListener(function(p1) -- Line: 264 -- upvalues: u24 (val), u23 (val)
    local ElementName = p1.ElementName
    if ElementName == nil or u24:GetElement(ElementName) ~= nil then
        runPacket(p1)
        return
    end
    if u23[ElementName] == nil then
        u23[ElementName] = {}
    end
    table.insert(u23[ElementName], p1)
end)
HUDServiceEvent:FireServer()
return u24