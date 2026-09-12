local Red = require(game.ReplicatedStorage.Packages.Red)

local function isFiniteNumber(p1) -- Line: 3
    local v1 = false
    if typeof(p1) == "number" then
        v1 = false
        if p1 == p1 then
            v1 = (math.abs(p1)) < (1 / 0)
        end
    end
    return v1
end

local function boundedString(p1, p2) -- Line: 7
    if typeof(p1) == "string" and p1 ~= "" and not (p2 < #p1) then
        return p1
    end
    return nil
end

return Red.SharedEvent("LiveEvent", function(p1) -- Line: 14
    local v1, v2, v3
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if typeof(action) ~= "string" or action == "" then
        v1 = nil
    elseif not (16 < #action) then
        v1 = action
    else
        v1 = nil
    end
    if v1 ~= "PrepareFailed" and v1 ~= "RewardShown" then
        local v4, v5, v6
        if v1 == "Ready" then
            local sessionId = p1.sessionId
            if typeof(sessionId) ~= "string" or sessionId == "" then
                v2 = nil
            elseif not (64 < #sessionId) then
                v2 = sessionId
            else
                v2 = nil
            end
            if not v2 then
                v3 = nil
            else
                v3 = {}
                v3.action = v1
                v3.sessionId = v2
                if not v3 then
                    v3 = nil
                end
            end
            return v3
        end
        if v1 == "Complete" then
            local returnAt_2
            local sessionId_2 = p1.sessionId
            if typeof(sessionId_2) ~= "string" or sessionId_2 == "" then
                v2 = nil
            elseif not (64 < #sessionId_2) then
                v2 = sessionId_2
            else
                v2 = nil
            end
            if not v2 then
                return nil
            end
            if not p1.rewardText then
                v3 = nil
            else
                local rewardText = p1.rewardText
                if typeof(rewardText) ~= "string" or rewardText == "" then
                    v3 = nil
                elseif not (64 < #rewardText) then
                    v3 = rewardText
                else
                    v3 = nil
                end
                if not v3 then
                    v3 = nil
                end
            end
            local returnAt = p1.returnAt
            v5 = false
            if typeof(returnAt) == "number" then
                v5 = false
                if returnAt == returnAt then
                    v5 = (math.abs(returnAt)) < (1 / 0)
                end
            end
            if not v5 then
                returnAt_2 = nil
            else
                returnAt_2 = p1.returnAt
                if not returnAt_2 then
                    returnAt_2 = nil
                end
            end
            return {action = v1, sessionId = v2, rewardText = v3, returnAt = returnAt_2}
        end
        if v1 == "ReturnCountdown" then
            local sessionId_3 = p1.sessionId
            if typeof(sessionId_3) ~= "string" or sessionId_3 == "" then
                v2 = nil
            elseif not (64 < #sessionId_3) then
                v2 = sessionId_3
            else
                v2 = nil
            end
            if v2 then
                local returnAt_3 = p1.returnAt
                v3 = false
                if typeof(returnAt_3) == "number" then
                    v3 = false
                    if returnAt_3 == returnAt_3 then
                        v3 = (math.abs(returnAt_3)) < (1 / 0)
                    end
                end
                if v3 then
                    return {action = v1, sessionId = v2, returnAt = p1.returnAt}
                end
            end
            return nil
        end
        if v1 == "Join" then
            local showingId = p1.showingId
            if typeof(showingId) ~= "string" or showingId == "" then
                v2 = nil
            elseif not (64 < #showingId) then
                v2 = showingId
            else
                v2 = nil
            end
            if not v2 then
                v3 = nil
            else
                v3 = {}
                v3.action = v1
                v3.showingId = v2
                if not v3 then
                    v3 = nil
                end
            end
            return v3
        end
        if v1 == "JoinResult" then
            local showingId_2 = p1.showingId
            if typeof(showingId_2) ~= "string" or showingId_2 == "" then
                v2 = nil
            elseif not (64 < #showingId_2) then
                v2 = showingId_2
            else
                v2 = nil
            end
            local status = p1.status
            if status ~= "Accepted" and status ~= "Retry" and status ~= "Unavailable" and status ~= "Expired" then
                return nil
            end
            if not v2 then
                v4 = nil
            else
                v4 = {}
                v4.action = v1
                v4.showingId = v2
                v4.status = status
                if not v4 then
                    v4 = nil
                end
            end
            return v4
        end
        if v1 == "HoldCheck" then
            return {action = v1}
        end
        if v1 == "Hold" then
            local showingId_3 = p1.showingId
            if typeof(showingId_3) ~= "string" or showingId_3 == "" then
                v2 = nil
            elseif not (64 < #showingId_3) then
                v2 = showingId_3
            else
                v2 = nil
            end
            if not v2 then
                v3 = nil
            else
                v3 = {}
                v3.action = v1
                v3.showingId = v2
                if not v3 then
                    v3 = nil
                end
            end
            return v3
        end
        if v1 == "HoldRelease" then
            local reason = p1.reason
            if typeof(reason) ~= "string" or reason == "" then
                v2 = nil
            elseif not (128 < #reason) then
                v2 = reason
            else
                v2 = nil
            end
            if not v2 then
                v3 = nil
            else
                v3 = {}
                v3.action = v1
                v3.reason = v2
                if not v3 then
                    v3 = nil
                end
            end
            return v3
        end
        if v1 == "Start" then
            local sessionId_4 = p1.sessionId
            if typeof(sessionId_4) ~= "string" or sessionId_4 == "" then
                v2 = nil
            elseif not (64 < #sessionId_4) then
                v2 = sessionId_4
            else
                v2 = nil
            end
            if v2 then
                local startAt = p1.startAt
                v3 = false
                if typeof(startAt) == "number" then
                    v3 = false
                    if startAt == startAt then
                        v3 = (math.abs(startAt)) < (1 / 0)
                    end
                end
                if v3 then
                    return {action = v1, sessionId = v2, startAt = p1.startAt}
                end
            end
            return nil
        end
        if v1 == "Abort" then
            local sessionId_5 = p1.sessionId
            if typeof(sessionId_5) ~= "string" or sessionId_5 == "" then
                v2 = nil
            elseif not (64 < #sessionId_5) then
                v2 = sessionId_5
            else
                v2 = nil
            end
            local reason_2 = p1.reason
            if typeof(reason_2) ~= "string" or reason_2 == "" then
                v3 = nil
            elseif not (128 < #reason_2) then
                v3 = reason_2
            else
                v3 = nil
            end
            if not v2 or not v3 then
                v4 = nil
            else
                v4 = {}
                v4.action = v1
                v4.sessionId = v2
                v4.reason = v3
                if not v4 then
                    v4 = nil
                end
            end
            return v4
        end
        if v1 == "Invite" then
            local eventId = p1.eventId
            if typeof(eventId) ~= "string" or eventId == "" then
                v2 = nil
            elseif not (48 < #eventId) then
                v2 = eventId
            else
                v2 = nil
            end
            local showingId_4 = p1.showingId
            if typeof(showingId_4) ~= "string" or showingId_4 == "" then
                v3 = nil
            elseif not (64 < #showingId_4) then
                v3 = showingId_4
            else
                v3 = nil
            end
            local showingKind = p1.showingKind
            if typeof(showingKind) ~= "string" or showingKind == "" then
                v4 = nil
            elseif not (16 < #showingKind) then
                v4 = showingKind
            else
                v4 = nil
            end
            if v2 and v3 and v4 then
                local showAt = p1.showAt
                v5 = false
                if typeof(showAt) == "number" then
                    v5 = false
                    if showAt == showAt then
                        v5 = (math.abs(showAt)) < (1 / 0)
                    end
                end
                if v5 then
                    local entryClosesAt = p1.entryClosesAt
                    v5 = false
                    if typeof(entryClosesAt) == "number" then
                        v5 = false
                        if entryClosesAt == entryClosesAt then
                            v5 = (math.abs(entryClosesAt)) < (1 / 0)
                        end
                    end
                    if v5 then
                        v5 = {
                            action = v1,
                            eventId = v2,
                            showingId = v3,
                            showAt = p1.showAt,
                            entryClosesAt = p1.entryClosesAt,
                            showingKind = v4,
                        }
                        v6 = p1.rewatch == true
                        v5.rewatch = v6
                        return v5
                    end
                end
            end
            return nil
        end
        if v1 == "InviteCancelled" then
            return {action = v1}
        end
        if v1 ~= "State" then
            return nil
        end
        local eventId_2 = p1.eventId
        if typeof(eventId_2) ~= "string" or eventId_2 == "" then
            v2 = nil
        elseif not (48 < #eventId_2) then
            v2 = eventId_2
        else
            v2 = nil
        end
        local showingId_5 = p1.showingId
        if typeof(showingId_5) ~= "string" or showingId_5 == "" then
            v3 = nil
        elseif not (64 < #showingId_5) then
            v3 = showingId_5
        else
            v3 = nil
        end
        local sessionId_6 = p1.sessionId
        if typeof(sessionId_6) ~= "string" or sessionId_6 == "" then
            v4 = nil
        elseif not (64 < #sessionId_6) then
            v4 = sessionId_6
        else
            v4 = nil
        end
        local phase = p1.phase
        if typeof(phase) ~= "string" or phase == "" then
            v5 = nil
        elseif not (16 < #phase) then
            v5 = phase
        else
            v5 = nil
        end
        if v2 and v3 and v4 and v5 then
            local showAt_2 = p1.showAt
            v6 = false
            if typeof(showAt_2) == "number" then
                v6 = false
                if showAt_2 == showAt_2 then
                    v6 = (math.abs(showAt_2)) < (1 / 0)
                end
            end
            if v6 then
                local cutsceneLength = p1.cutsceneLength
                v6 = false
                if typeof(cutsceneLength) == "number" then
                    v6 = false
                    if cutsceneLength == cutsceneLength then
                        v6 = (math.abs(cutsceneLength)) < (1 / 0)
                    end
                end
                if v6 then
                    v6 = {
                        action = v1,
                        eventId = v2,
                        showingId = v3,
                        sessionId = v4,
                        showAt = p1.showAt,
                        phase = v5,
                    }
                    local cutsceneLength_2 = p1.cutsceneLength
                    v6.cutsceneLength = math.max(0, cutsceneLength_2)
                    return v6
                end
            end
        end
        return nil
    end
    local sessionId_7 = p1.sessionId
    if typeof(sessionId_7) ~= "string" or sessionId_7 == "" then
        v2 = nil
    elseif not (64 < #sessionId_7) then
        v2 = sessionId_7
    else
        v2 = nil
    end
    if not v2 then
        v3 = nil
    else
        v3 = {}
        v3.action = v1
        v3.sessionId = v2
        if not v3 then
            v3 = nil
        end
    end
    return v3
end)