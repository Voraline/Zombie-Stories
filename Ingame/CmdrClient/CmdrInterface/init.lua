local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1) -- Line: 6 -- upvalues: LocalPlayer (val)
    local Util = p1.Util
    local Window = require(script:WaitForChild("Window"))
    Window.Cmdr = p1
    local u17 = require(script:WaitForChild("AutoComplete"))(p1)
    Window.AutoComplete = u17

    function Window.ProcessEntry(p1_2) -- Line: 17 -- upvalues: Util (val), Window (val), p1 (val), LocalPlayer (upval)
        local v1 = Util.TrimString(p1_2)
        if #v1 == 0 then
            return
        end
        local v2 = Window
        local v3 = (Window:GetLabel()) .. " " .. v1
        local v4 = Color3.fromRGB(255, 223, 93)
        v2:AddLine(v3, v4)
        v2 = Window
        v3 = p1
        local Dispatcher = v3.Dispatcher
        local v5 = LocalPlayer
        v3 = Dispatcher:EvaluateAndRun(v1, v5, {IsHuman = true})
        v2:AddLine(v3)
    end

    function Window.OnTextChanged(p1_2) -- Line: 30
        -- upvalues: p1 (val), LocalPlayer (upval), Util (val), Window (val), u17 (val)
        local v1, v2, v3, v4, v5
        local v6 = p1
        local Dispatcher = v6.Dispatcher
        local v7 = LocalPlayer
        v6 = Dispatcher:Evaluate(p1_2, v7, true)
        local v8 = Util.SplitString(p1_2)
        local v9 = table.remove(v8, 1)
        v7 = false
        if v6 then
            v8 = Util.MashExcessArguments(v8, #v6.Object.Args)
            v7 = #v8 == #v6.Object.Args
        end
        local v10 = v9
        if v10 then
            v10 = 0 < #v8
        end
        local v11 = #p1_2
        local v12 = #p1_2
        local v13 = p1_2:sub(v11, v12)
        if v13:match("%s") and not v7 then
            v10 = true
            v13 = #v8 + 1
            v8[v13] = ""
        end
        if v6 and v10 then
            local Description, Prefix, v14, v15
            v13, v5 = v6:Validate()
            v11 = Window
            v1 = ("Validation errors: %s"):format(v5 or "")
            v11:SetIsValidInput(v13, v1)
            v11 = {}
            v1 = #v8
            local Argument = v6:GetArgument(v1)
            if not Argument then
                Window:SetIsValidInput(false, "Use the help command to see all available commands.")
                u17:Hide()
                return
            end
            local TextSegmentInProgress = Argument.TextSegmentInProgress
            v1 = false
            if not Argument.RawSegmentsAreAutocomplete then
                local Autocomplete, Autocomplete_2 = Argument:GetAutocomplete()
                v2 = Autocomplete_2 or {}
                v1 = v2.IsPartial or false
                for k, v in pairs(Autocomplete) do
                    v11[k] = {TextSegmentInProgress, v}
                end
            else
                for i, i2 in ipairs(Argument.RawSegments) do
                    v11[i] = {i2, i2}
                end
            end
            local v16 = true
            if 0 < #TextSegmentInProgress then
                v14, v2 = Argument:Validate()
                v16 = v14
                v5 = v2
            end
            if not v7 and v16 then
                Window:HideInvalidState()
            end
            v14 = u17
            v3 = v11
            local v17 = {}
            local v18 = v7
            if v18 then
                v4 = #p1_2 - #TextSegmentInProgress
                local v19 = #p1_2
                local v20 = #p1_2
                if not (p1_2:sub(v19, v20)):match("%s") then
                    v15 = 0
                else
                    v15 = -1
                end
                v18 = v4 + v15
            end
            v17.at = v18
            if #Argument.RawSegments ~= 1 then
                Prefix = ""
            else
                Prefix = Argument.Prefix
                if not Prefix then
                    Prefix = ""
                end
            end
            v17.prefix = Prefix
            v18 = false
            if #v6.Arguments == #v6.ArgumentDefinitions then
                v18 = 0 < #TextSegmentInProgress
            end
            v17.isLast = v18
            v17.numArgs = #v8
            v17.command = v6
            v17.arg = Argument
            local Name = Argument.Name
            if not Argument.Required then
                v15 = "?"
            else
                v15 = ""
            end
            v17.name = Name .. v15
            v17.type = Argument.Type.DisplayName
            if v16 ~= false then
                Description = Argument.Object.Description
            else
                Description = v5
                if not Description then
                    Description = Argument.Object.Description
                end
            end
            v17.description = Description
            v17.invalid = not v16
            v17.isPartial = v1
            return v14:Show(v3, v17)
        end
        if v9 and #v8 == 0 then
            local Command_2
            Window:SetIsValidInput(true)
            local Command = p1.Registry:GetCommand(v9)
            v5 = nil
            if not Command then
                v11 = Window
                v1 = ("%q is not a valid command name. Use the help command to see all available commands."):format(v9)
                v11:SetIsValidInput(false, v1)
            else
                v5 = {
                    Command.Name,
                    Command.Name,
                    options = {name = Command.Name, description = Command.Description},
                }
                local Args = Command.Args
                if Args then
                    Args = Command.Args[1]
                end
                if type(Args) == "function" then
                    Args = Args(v6)
                end
                if Args and not Args.Optional and Args.Default == nil then
                    Window:SetIsValidInput(false, "This command has required arguments.")
                    Window:HideInvalidState()
                end
            end
            v11 = {}
            v11[1] = v5
            for k2, j in pairs(p1.Registry:GetCommandNames()) do
                v2 = v9:lower()
                v3 = j:lower()
                v4 = #v9
                if v2 == v3:sub(1, v4) then
                    if v5 == nil or v5[1] ~= v9 then
                        Command_2 = p1.Registry:GetCommand(j)
                        v3 = #v11 + 1
                        v11[v3] = {
                            v9,
                            j,
                            options = {name = Command_2.Name, description = Command_2.Description},
                        }
                    end
                end
            end
            return u17:Show(v11)
        end
        Window:SetIsValidInput(false, "Use the help command to see all available commands.")
        u17:Hide()
    end

    Window:UpdateLabel()
    Window:UpdateWindowHeight()
    return {Window = Window, AutoComplete = u17}
end