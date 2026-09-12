local Frame_2
local v1 = {}
local IntroText = script:WaitForChild("IntroText")
local Frame = IntroText:WaitForChild("Frame")
local TemplateLabel = Frame:WaitForChild("TemplateLabel")
local u17 = Random.new(os.time())
local Text = script.Text
local RenderStepped = game:GetService("RunService").RenderStepped
local TweenService = game:GetService("TweenService")
IntroText.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v2 = {
    {0, 591},
    {880, 1327},
    {8352, 8527},
    {8704, 8959},
}
local u51 = {
    "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
    " ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŊŋŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžſƀƁƂƃƄƅƆƇƈƉƊƋƌƍƎƏƐƑƒƓƔƕƖƗƘƙƚƛƜƝƞƟƠơƢƣƤƥƦƧƨƩƪƫƬƭƮƯưƱƲƳƴƵƶƷƸƹƺƻƼƽƾƿǀǁǂǃǄǅǆǇǈǉǊǋǌǍǎǏǐǑǒǓǔǕǖǗǘǙǚǛǜǝǞǟǠǡǢǣǤǥǦǧǨǩǪǫǬǭǮǯǰǱǲǳǴǵǶǷǸǹǺǻǼǽǾǿȀȁȂȃȄȅȆȇȈȉȊȋȌȍȎȏȐȑȒȓȔȕȖȗȘșȚțȜȝȞȟȠȡȢȣȤȥȦȧȨȩȪȫȬȭȮȯȰȱȲȳȴȵȶȷȸȹȺȻȼȽȾȿɀɁɂɃɄɅɆɇɈɉɊɋɌɍɎɏͰͱͲͳʹ͵Ͷͷ͸͹ͺͻͼͽ;Ϳ΀΁΂΃΄΅Ά·ΈΉΊ΋Ό΍ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡ΢ΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώϏϐϑϒϓϔϕϖϗϘϙϚϛϜϝϞϟϠϡϢϣϤϥϦϧϨϩϪϫϬϭϮϯϰϱϲϳϴϵ϶ϷϸϹϺϻϼϽϾϿЀЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяѐёђѓєѕіїјљњћќѝўџѠѡѢѣѤѥѦѧѨѩѪѫѬѭѮѯѰѱѲѳѴѵѶѷѸѹѺѻѼѽѾѿҀҁ҂҃҄҅҆҇҈҉ҊҋҌҍҎҏҐґҒғҔҕҖҗҘҙҚқҜҝҞҟҠҡҢңҤҥҦҧҨҩҪҫҬҭҮүҰұҲҳҴҵҶҷҸҹҺһҼҽҾҿӀӁӂӃӄӅӆӇӈӉӊӋӌӍӎӏӐӑӒӓӔӕӖӗӘәӚӛӜӝӞӟӠӡӢӣӤӥӦӧӨөӪӫӬӭӮӯӰӱӲӳӴӵӶӷӸӹӺӻӼӽӾӿԀԁԂԃԄԅԆԇԈԉԊԋԌԍԎԏԐԑԒԓԔԕԖԗԘԙԚԛԜԝԞԟԠԡԢԣԤԥԦԧԨԩԪԫԬԭԮԯ",
    "₠₡₢₣₤₥₦₧₨₩₪₫€₭₮₯₰₱₲₳₴₵₶₷₸₹₺₻₼₽₾₿℀℁ℂ℃℄℅℆ℇ℈℉ℊℋℌℍℎℏℐℑℒℓ℔ℕ№℗℘ℙℚℛℜℝ℞℟℠℡™℣ℤ℥Ω℧ℨ℩KÅℬℭ℮ℯℰℱℲℳℴℵℶℷℸ℺℻ℼℽℾℿ⅀⅁⅂⅃⅄ⅅⅆⅇⅈⅉ⅊⅋⅌⅍ⅎ⅏∀∁∂∃∄∅∆∇∈∉∊∋∌∍∎∏∐∑−∓∔∕∖∗∘∙√∛∜∝∞∟∠∡∢∣∤∥∦∧∨∩∪∫∬∭∮∯∰∱∲∳∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠⊡⊢⊣⊤⊥⊦⊧⊨⊩⊪⊫⊬⊭⊮⊯⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊺⊻⊼⊽⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿",
}

local function charAt(p1, p2) -- Line: 27
    return (string.sub(p1, p2, p2))
end

local function getSizeChar(p1, p2) -- Line: 31 -- upvalues: u51 (val)
    local v1 = u51[p1]
    local v2 = p2 + p1 - 1
    return (string.sub(v1, p2, v2))
end

local u58 = {}
for i = 0, 9 do
    Frame_2 = Instance.new("Frame")
    Frame_2.Size = UDim2.new(1, 0, 0.05, 0)
    Frame_2.BorderSizePixel = 0
    Frame_2.BackgroundTransparency = 1
    Frame_2.BackgroundColor3 = Color3.new()
    Frame_2.ZIndex = 2
    Frame_2.Parent = Frame.Back
    u58[i] = Frame_2
end
local u87 = tick()
local u90 = 1 / #u58
;(game:GetService("RunService")).Heartbeat:connect(function() -- Line: 52 -- upvalues: u58 (ref), u87 (val), u90 (val)
    local new, v1
    for k, v in pairs(u58) do
        new = UDim2.new
        v1 = ((tick() - u87) * 0.05 + u90 * k) % 1.1 - 0.05
        v.Position = new(0, 0, v1, 0)
    end
end)

function v1.Create(p1, p2, p3, p4, p5, p6, p7) -- Line: 59
    -- upvalues: Frame (val), TemplateLabel (val), TweenService (val), u58 (ref), u17 (val), u51 (val), Text (val)
    -- upvalues: RenderStepped (val)
    local v1, v2
    local u209 = {}
    local BindableEvent = Instance.new("BindableEvent")
    local v3 = p4
    if not v3 then
        v3 = Color3.fromRGB(105, 203, 255)
    end
    local v4 = p2
    local u199 = math.min(v4, 100)
    if not p5 and true then
        Frame.Position = UDim2.new(0, 50, 1, -50)
        Frame.AnchorPoint = Vector2.new(0, 1)
        local Back_2 = Frame.Back
        Back_2.Size = UDim2.new(1, 20, 1, 0)
    else
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        local Back = Frame.Back
        Back.Size = UDim2.new(10, 0, 1.2, 0)
    end
    TemplateLabel.TextColor3 = v3
    TemplateLabel.TextSize = u199
    local u198 = nil
    for i, v in ipairs(p3) do
        v1 = TemplateLabel:Clone()
        v1.Name = i
        v1.Size = UDim2.new(1, 0, 1 / #p3, 0)
        v1.Position = UDim2.new(0, 0, 0, (i - 1) * u199)
        v1.Parent = Frame
        table.insert(u209, v1)
        if not u198 or #u198 < #v then
            u198 = v
        end
    end
    v4 = Frame
    local new = UDim2.new
    local TextService = game:GetService("TextService")
    v1 = u198
    local v5 = u199
    local Code = Enum.Font.Code
    local v6 = Vector2.new(10000, 0)
    v4.Size = new(0, TextService:GetTextSize(v1, v5, Code, v6).X, 0, #p3 * u199)
    v4 = TweenService
    local v7 = Frame
    local Back_3 = v7.Back
    local v8 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    v4:Create(Back_3, v8, {Transparency = 0.3}):Play()
    for k, i2 in pairs(u58) do
        v5 = TweenService
        v2 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v5:Create(i2, v2, {Transparency = 0.85}):Play()
    end
    local u139 = {}
    v7 = coroutine.create(function() -- Line: 104
        -- upvalues: p3 (val), u209 (val), u139 (val), u17 (upval), u51 (upval), Text (upval), RenderStepped (upval)
        -- upvalues: p6 (val), p7 (val), Frame (upval), u198 (ref), u199 (ref), TweenService (upval), u58 (upval)
        -- upvalues: BindableEvent (val)
        local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16
        for i, v in ipairs(p3) do
            v13 = u209[i]
            v14 = #v
            v15 = v14
            for i2 = 0, v15 do
                if i2 ~= 0 and string.sub(v, i2, i2) ~= " " then
                    v2 = u139
                    v3 = {i, i2}
                    table.insert(v2, v3)
                end
                v1 = u17:NextInteger(1, 3)
                v3 = string.sub(v, 0, i2)
                if not (i2 < v14) then
                    v4 = ""
                else
                    v5 = u17
                    v11 = u51
                    v8 = #v11[v1] / v1
                    v5 = v5:NextInteger(1, v8)
                    v7 = u51[v1]
                    v9 = v5 + v1 - 1
                    v4 = string.sub(v7, v5, v9) or ""
                end
                v13.Text = v3 .. v4
                v2 = Text:Clone()
                v2.Parent = script
                v2:Play()
                game.Debris:AddItem(v2, 0.5)
                v3 = 0
                while v3 < 0.03333333333333333 do
                    v3 = v3 + RenderStepped:Wait()
                end
            end
            task.wait(0.5)
        end
        local v17 = #u139
        task.wait(v17 * 0.012)
        task.wait(p6 or 0)
        local v18 = p7
        if not v18 then
            v18 = #u139 / 3 * 0.02
        end
        local v19 = Frame
        local new = UDim2.new
        local TextService = game:GetService("TextService")
        v15 = u198
        local v20 = u199
        local Code = Enum.Font.Code
        v1 = Vector2.new(10000, 0)
        local X = (TextService:GetTextSize(v15, v20, Code, v1)).X
        v20 = #p3
        v19.Size = new(0, X, 0, v20 * u199)
        v19 = TweenService
        local v21 = Frame
        local Back = v21.Back
        v13 = TweenInfo.new(v18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v14 = {Transparency = 1}
        v19:Create(Back, v13, v14):Play()
        for k, j in pairs(u58) do
            v20 = TweenService
            v2 = TweenInfo.new(v18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            v20:Create(j, v2, {Transparency = 1}):Play()
        end
        local v22 = nil
        v21 = nil
        while true do
            if not (0 < #u139) then
                break
            end
            for k2 = 1, 3 do
                v20 = u17
                v3 = u139
                v2 = #v3
                v20 = v20:NextInteger(1, v2)
                v16 = u139[v20][1]
                v1 = u139[v20][2]
                v2 = u209[v16]
                table.remove(u139, v20)
                v3 = u17
                v8 = u51
                v6 = #v8[1]
                v3 = v3:NextInteger(1, v6)
                v4 = p3
                v7 = p3[v16]
                v9 = v1 - 1
                v6 = string.sub(v7, 0, v9)
                v9 = u51
                v8 = v9[1]
                v7 = string.sub(v8, v3, v3)
                v9 = p3[v16]
                v10 = v1 + 1
                v12 = p3
                v11 = #v12[v16]
                v4[v16] = v6 .. v7 .. string.sub(v9, v10, v11)
                if v22 then
                    v4 = p3
                    v7 = p3[v22]
                    v9 = v21 - 1
                    v6 = string.sub(v7, 0, v9)
                    v9 = p3[v22]
                    v10 = v21 + 1
                    v12 = p3
                    v11 = #v12[v22]
                    v4[v22] = v6 .. " " .. string.sub(v9, v10, v11)
                    v4 = u209[v22]
                    v4.Text = p3[v22]
                end
                v2.Text = p3[v16]
                v22 = v16
                v21 = v1
                if #u139 == 0 then
                    break
                end
            end
            v13 = #p3
            for n = 1, v13 do
                v20 = u209[n]
                v20.TextTransparency = 1 - #u139 / v17
            end
            v13 = Text:Clone()
            v13.Parent = script
            v13:Play()
            game.Debris:AddItem(v13, 0.5)
            v14 = 0
            while v14 < 0.016666666666666666 do
                v14 = v14 + RenderStepped:Wait()
            end
        end
        if v22 then
            v13 = p3
            v20 = p3[v22]
            v1 = v21 - 1
            v15 = string.sub(v20, 0, v1)
            v1 = p3[v22]
            v2 = v21 + 1
            v5 = p3
            v3 = #v5[v22]
            v13[v22] = v15 .. " " .. string.sub(v1, v2, v3)
            v13 = u209[v22]
            v13.Text = p3[v22]
        end
        for k3, m in pairs(u209) do
            m:Destroy()
        end
        BindableEvent:Fire()
    end)
    coroutine.resume(v7)
    return BindableEvent
end

return v1