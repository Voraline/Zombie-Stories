local Red = require(game.ReplicatedStorage.Packages.Red)
local function isFiniteNumber(p1) -- Line: 3
    local v1 = false
    if typeof(p1) == "number" then
        v1 = false
        if p1 == p1 then
            local v2 = math.abs(p1)
            v1 = v2 < (1 / 0)
        end
    end
    return v1
end
local function boundedString(p1, p2) -- Line: 7
    if typeof(p1) ~= "string" or p1 == "" or p2 < #p1 then
        return nil
    end
    return p1
end
return Red.SharedEvent("LiveEvent", function(p1) -- Line: 14
    local v1, v2, v3
    if typeof(p1) ~= "table" then
        return nil
    end
    local action = p1.action
    if typeof(action) ~= "string" then
        v1 = nil
    elseif action ~= "" and 16 >= #action then
        v1 = action
    end
    if v1 == "PrepareFailed" then
        local sessionId_7 = p1.sessionId
        if typeof(sessionId_7) ~= "string" then
            v2 = nil
        elseif sessionId_7 ~= "" and 64 >= #sessionId_7 then
            v2 = sessionId_7
        end
        if not v2 then
            v3 = nil
        else
            v3 = {action = v1, sessionId = v2}
            if not v3 then
                v3 = nil
            end
        end
        return v3
    elseif v1 ~= "RewardShown" then
        local v4, v5, v6
        if v1 == "Ready" then
            local sessionId = p1.sessionId
            if typeof(sessionId) ~= "string" then
                v2 = nil
            elseif sessionId ~= "" and 64 >= #sessionId then
                v2 = sessionId
            end
            if not v2 then
                v3 = nil
            else
                v3 = {action = v1, sessionId = v2}
                if not v3 then
                    v3 = nil
                end
            end
            return v3
        end
        if v1 == "Complete" then
            local returnAt_2, rewardText
            local sessionId_2 = p1.sessionId
            if typeof(sessionId_2) ~= "string" then
                v2 = nil
            elseif sessionId_2 ~= "" and 64 >= #sessionId_2 then
                v2 = sessionId_2
            end
            if not v2 then
                return nil
            end
            if not p1.rewardText then
                v3 = nil
            else
                rewardText = p1.rewardText
                if typeof(rewardText) ~= "string" then
                    v3 = nil
                elseif rewardText ~= "" and 64 >= #rewardText then
                    v3 = rewardText
                end
            end
            local returnAt = p1.returnAt
            v5 = false
            if typeof(returnAt) == "number" then
                v5 = false
                if returnAt == returnAt then
                    v6 = math.abs(returnAt)
                    v5 = v6 < (1 / 0)
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
            if typeof(sessionId_3) ~= "string" then
                v2 = nil
            elseif sessionId_3 ~= "" and 64 >= #sessionId_3 then
                v2 = sessionId_3
            end
            if not v2 then
                return nil
            end
            local returnAt_3 = p1.returnAt
            v3 = false
            if typeof(returnAt_3) == "number" then
                v3 = false
                if returnAt_3 == returnAt_3 then
                    v5 = math.abs(returnAt_3)
                    v3 = v5 < (1 / 0)
                end
            end
            if not v3 then
                return nil
            end
            return {action = v1, sessionId = v2, returnAt = p1.returnAt}
        end
        if v1 == "Join" then
            local showingId = p1.showingId
            if typeof(showingId) ~= "string" then
                v2 = nil
            elseif showingId ~= "" and 64 >= #showingId then
                v2 = showingId
            end
            if not v2 then
                v3 = nil
            else
                v3 = {action = v1, showingId = v2}
                if not v3 then
                    v3 = nil
                end
            end
            return v3
        end
        if v1 ~= "JoinResult" then
            local v7, v8
            if v1 == "HoldCheck" then
                return {action = v1}
            end
            if v1 == "Hold" then
                local showingId_3 = p1.showingId
                if typeof(showingId_3) ~= "string" then
                    v2 = nil
                elseif showingId_3 ~= "" and 64 >= #showingId_3 then
                    v2 = showingId_3
                end
                if not v2 then
                    v3 = nil
                else
                    v3 = {action = v1, showingId = v2}
                    if not v3 then
                        v3 = nil
                    end
                end
                return v3
            end
            if v1 == "HoldRelease" then
                local reason = p1.reason
                if typeof(reason) ~= "string" then
                    v2 = nil
                elseif reason ~= "" and 128 >= #reason then
                    v2 = reason
                end
                if not v2 then
                    v3 = nil
                else
                    v3 = {action = v1, reason = v2}
                    if not v3 then
                        v3 = nil
                    end
                end
                return v3
            end
            if v1 == "Start" then
                local sessionId_4 = p1.sessionId
                if typeof(sessionId_4) ~= "string" then
                    v2 = nil
                elseif sessionId_4 ~= "" and 64 >= #sessionId_4 then
                    v2 = sessionId_4
                end
                if not v2 then
                    return nil
                end
                local startAt = p1.startAt
                v3 = false
                if typeof(startAt) == "number" then
                    v3 = false
                    if startAt == startAt then
                        v5 = math.abs(startAt)
                        v3 = v5 < (1 / 0)
                    end
                end
                if not v3 then
                    return nil
                end
                return {action = v1, sessionId = v2, startAt = p1.startAt}
            end
            if v1 == "Abort" then
                local sessionId_5 = p1.sessionId
                if typeof(sessionId_5) ~= "string" then
                    v2 = nil
                elseif sessionId_5 ~= "" and 64 >= #sessionId_5 then
                    v2 = sessionId_5
                end
                local reason_2 = p1.reason
                if typeof(reason_2) ~= "string" then
                    v3 = nil
                elseif reason_2 ~= "" and 128 >= #reason_2 then
                    v3 = reason_2
                end
                if not v2 then
                    v4 = nil
                elseif not v3 then
                    v4 = nil
                else
                    v4 = {action = v1, sessionId = v2, reason = v3}
                    if not v4 then
                        v4 = nil
                    end
                end
                return v4
            end
            if v1 == "Invite" then
                local eventId = p1.eventId
                if typeof(eventId) ~= "string" then
                    v2 = nil
                elseif eventId ~= "" and 48 >= #eventId then
                    v2 = eventId
                end
                local showingId_4 = p1.showingId
                if typeof(showingId_4) ~= "string" then
                    v3 = nil
                elseif showingId_4 ~= "" and 64 >= #showingId_4 then
                    v3 = showingId_4
                end
                local showingKind = p1.showingKind
                if typeof(showingKind) ~= "string" then
                    v4 = nil
                elseif showingKind ~= "" and 16 >= #showingKind then
                    v4 = showingKind
                end
                if not v2 or not v3 or not v4 then
                    return nil
                end
                local showAt = p1.showAt
                v5 = false
                if typeof(showAt) == "number" then
                    v5 = false
                    if showAt == showAt then
                        v6 = math.abs(showAt)
                        v5 = v6 < (1 / 0)
                    end
                end
                if not v5 then
                    return nil
                end
                local entryClosesAt = p1.entryClosesAt
                v5 = false
                if typeof(entryClosesAt) == "number" then
                    v5 = false
                    if entryClosesAt == entryClosesAt then
                        v6 = math.abs(entryClosesAt)
                        v5 = v6 < (1 / 0)
                    end
                end
                if not v5 then
                    return nil
                end
                v5 = {
                    action = v1,
                    eventId = v2,
                    showingId = v3,
                    showAt = p1.showAt,
                    entryClosesAt = p1.entryClosesAt,
                    showingKind = v4,
                }
                v7 = p1.rewatch == true
                v5.rewatch = v7
                return v5
            end
            if v1 == "InviteCancelled" then
                return {action = v1}
            end
            if v1 ~= "State" then
                return nil
            end
            local eventId_2 = p1.eventId
            if typeof(eventId_2) ~= "string" then
                v2 = nil
            elseif eventId_2 ~= "" and 48 >= #eventId_2 then
                v2 = eventId_2
            end
            local showingId_5 = p1.showingId
            if typeof(showingId_5) ~= "string" then
                v3 = nil
            elseif showingId_5 ~= "" and 64 >= #showingId_5 then
                v3 = showingId_5
            end
            local sessionId_6 = p1.sessionId
            if typeof(sessionId_6) ~= "string" then
                v4 = nil
            elseif sessionId_6 ~= "" and 64 >= #sessionId_6 then
                v4 = sessionId_6
            end
            local phase = p1.phase
            if typeof(phase) ~= "string" then
                v5 = nil
            elseif phase ~= "" and 16 >= #phase then
                v5 = phase
            end
            if not v2 or not v3 or not v4 or not v5 then
                return nil
            end
            local showAt_2 = p1.showAt
            v7 = false
            if typeof(showAt_2) == "number" then
                v7 = false
                if showAt_2 == showAt_2 then
                    v8 = math.abs(showAt_2)
                    v7 = v8 < (1 / 0)
                end
            end
            if not v7 then
                return nil
            end
            local cutsceneLength = p1.cutsceneLength
            v7 = false
            if typeof(cutsceneLength) == "number" then
                v7 = false
                if cutsceneLength == cutsceneLength then
                    v8 = math.abs(cutsceneLength)
                    v7 = v8 < (1 / 0)
                end
            end
            if not v7 then
                return nil
            end
            return {
                action = v1,
                eventId = v2,
                showingId = v3,
                sessionId = v4,
                showAt = p1.showAt,
                phase = v5,
                cutsceneLength = math.max(0, p1.cutsceneLength),
            }
        else
            local showingId_2 = p1.showingId
            if typeof(showingId_2) ~= "string" then
                v2 = nil
            elseif showingId_2 ~= "" and 64 >= #showingId_2 then
                v2 = showingId_2
            end
            local status = p1.status
            if status == "Accepted" then
                if not v2 then
                    v4 = nil
                else
                    v4 = {action = v1, showingId = v2, status = status}
                    if not v4 then
                        v4 = nil
                    end
                end
                return v4
            elseif status ~= "Retry" and status ~= "Unavailable" and status ~= "Expired" then
                return nil
            end
        end
    end
end)