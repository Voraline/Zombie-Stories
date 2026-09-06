local LocalPlayer = game:GetService("Players").LocalPlayer
return function(p1) -- Line: 6 -- upvalues: LocalPlayer (val)
    local Util = p1.Util
    local Window = require(script:WaitForChild("Window"))
    Window.Cmdr = p1
    local AutoComplete = require(script:WaitForChild("AutoComplete"))
    local u17 = AutoComplete(p1)
    Window.AutoComplete = u17
    function Window.ProcessEntry(a1) -- Line: 17 -- upvalues: Util (val), Window (val), p1 (val), LocalPlayer (upval)
        local v1 = Util.TrimString(a1)
        if #v1 == 0 then
            return
        end
        local Label = Window:GetLabel()
        Window:AddLine(Label .. " " .. v1, Color3.fromRGB(255, 223, 93))
        Window:AddLine(p1.Dispatcher:EvaluateAndRun(v1, LocalPlayer, {IsHuman = true}))
    end
    function Window.OnTextChanged(a1) -- Line: 30 -- upvalues: p1 (val), LocalPlayer (upval), Util (val), Window (val), u17 (val)
        local Args, v1, v2
        local v3 = p1.Dispatcher:Evaluate(a1, LocalPlayer, true)
        local v4 = Util.SplitString(a1)
        local v5 = table.remove(v4, 1)
        local v6 = false
        if v3 then
            v4 = Util.MashExcessArguments(v4, #v3.Object.Args)
            v6 = #v4 == #v3.Object.Args
        end
        local v7 = v5
        if v7 then
            v7 = 0 < #v4
        end
        local v8 = #a1
        local v9 = a1:sub(v8, #a1)
        if v9:match("%s") and not v6 then
            v7 = true
            v4[#v4 + 1] = ""
        end
        if not v3 then
            local Command_2
            if not v5 or #v4 ~= 0 then
                Window:SetIsValidInput(false, "Use the help command to see all available commands.")
                u17:Hide()
                return
            end
            Window:SetIsValidInput(true)
            local Command = p1.Registry:GetCommand(v5)
            v2 = nil
            if not Command then
                Window:SetIsValidInput(false, ("%q is not a valid command name. Use the help command to see all available commands."):format(v5))
            else
                v2 = {
                    Command.Name,
                    Command.Name,
                    options = {name = Command.Name, description = Command.Description},
                }
                Args = Command.Args
                if Args then
                    Args = Command.Args[1]
                end
                if type(Args) == "function" then
                    Args = Args(v3)
                end
                if Args and not Args.Optional and Args.Default == nil then
                    Window:SetIsValidInput(false, "This command has required arguments.")
                    Window:HideInvalidState()
                end
            end
            v8 = {v2}
            for k, v in pairs(p1.Registry:GetCommandNames()) do
                v1 = v5:lower()
                if v1 == v:lower():sub(1, #v5) then
                    if v2 == nil then
                        Command_2 = p1.Registry:GetCommand(v)
                        v8[#v8 + 1] = {
                            v5,
                            v,
                            options = {name = Command_2.Name, description = Command_2.Description},
                        }
                    elseif v2[1] == v5 then
                    end
                end
            end
            return u17:Show(v8)
        elseif v7 then
            local Description, Prefix, v10
            v9, v2 = v3:Validate()
            Window:SetIsValidInput(v9, ("Validation errors: %s"):format(v2 or ""))
            v8 = {}
            local Argument = v3:GetArgument(#v4)
            if not Argument then
                Window:SetIsValidInput(false, "Use the help command to see all available commands.")
                u17:Hide()
                return
            end
            local TextSegmentInProgress = Argument.TextSegmentInProgress
            local v11 = false
            if not Argument.RawSegmentsAreAutocomplete then
                local Autocomplete, Autocomplete_2
                Autocomplete, Autocomplete_2 = Argument:GetAutocomplete()
                v1 = Autocomplete_2
                if not v1 then
                    v1 = {}
                end
                v11 = v1.IsPartial or false
                for k2, i in pairs(Autocomplete) do
                    v8[k2] = {TextSegmentInProgress, i}
                end
            else
                for i2, j in ipairs(Argument.RawSegments) do
                    v8[i2] = {j, j}
                end
            end
            local v12 = true
            if 0 < #TextSegmentInProgress then
                local v13
                v13, v1 = Argument:Validate()
                v12 = v13
                v2 = v1
            end
            if not v6 and v12 then
                Window:HideInvalidState()
            end
            local v14 = {}
            local v15 = v6
            if v15 then
                local v16 = a1:sub(#a1, #a1)
                if not (v16:match("%s")) then
                    v10 = 0
                else
                    v10 = -1
                end
                v15 = #a1 - #TextSegmentInProgress + v10
            end
            v14.at = v15
            if #Argument.RawSegments ~= 1 then
                Prefix = ""
            else
                Prefix = Argument.Prefix
            end
            v14.prefix = Prefix
            v15 = false
            local v17 = #v3.Arguments
            if v17 == #v3.ArgumentDefinitions then
                v15 = 0 < #TextSegmentInProgress
            end
            v14.isLast = v15
            v14.numArgs = #v4
            v14.command = v3
            v14.arg = Argument
            if not Argument.Required then
                v10 = "?"
            else
                v10 = ""
            end
            v14.name = Argument.Name .. v10
            v14.type = Argument.Type.DisplayName
            if v12 ~= false then
                Description = Argument.Object.Description
            else
                Description = v2
                if not Description then
                    Description = Argument.Object.Description
                end
            end
            v14.description = Description
            v14.invalid = not v12
            v14.isPartial = v11
            return u17:Show(v8, v14)
        end
    end
    Window:UpdateLabel()
    Window:UpdateWindowHeight()
    return {Window = Window, AutoComplete = u17}
end