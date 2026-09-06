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
local v2 = {}
local v3 = {0, 591}
local v4 = {880, 1327}
local v5 = {8352, 8527}
local v6 = {8704, 8959}
v2[1] = v3
v2[2] = v4
v2[3] = v5
v2[4] = v6
local u51 = {"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", " ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿĀāĂăĄąĆćĈĉĊċČčĎďĐđĒēĔĕĖėĘęĚěĜĝĞğĠġĢģĤĥĦħĨĩĪīĬĭĮįİıĲĳĴĵĶķĸĹĺĻļĽľĿŀŁłŃńŅņŇňŉŊŋŌōŎŏŐőŒœŔŕŖŗŘřŚśŜŝŞşŠšŢţŤťŦŧŨũŪūŬŭŮůŰűŲųŴŵŶŷŸŹźŻżŽžſƀƁƂƃƄƅƆƇƈƉƊƋƌƍƎƏƐƑƒƓƔƕƖƗƘƙƚƛƜƝƞƟƠơƢƣƤƥƦƧƨƩƪƫƬƭƮƯưƱƲƳƴƵƶƷƸƹƺƻƼƽƾƿǀǁǂǃǄǅǆǇǈǉǊǋǌǍǎǏǐǑǒǓǔǕǖǗǘǙǚǛǜǝǞǟǠǡǢǣǤǥǦǧǨǩǪǫǬǭǮǯǰǱǲǳǴǵǶǷǸǹǺǻǼǽǾǿȀȁȂȃȄȅȆȇȈȉȊȋȌȍȎȏȐȑȒȓȔȕȖȗȘșȚțȜȝȞȟȠȡȢȣȤȥȦȧȨȩȪȫȬȭȮȯȰȱȲȳȴȵȶȷȸȹȺȻȼȽȾȿɀɁɂɃɄɅɆɇɈɉɊɋɌɍɎɏͰͱͲͳʹ͵Ͷͷ͸͹ͺͻͼͽ;Ϳ΀΁΂΃΄΅Ά·ΈΉΊ΋Ό΍ΎΏΐΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡ΢ΣΤΥΦΧΨΩΪΫάέήίΰαβγδεζηθικλμνξοπρςστυφχψωϊϋόύώϏϐϑϒϓϔϕϖϗϘϙϚϛϜϝϞϟϠϡϢϣϤϥϦϧϨϩϪϫϬϭϮϯϰϱϲϳϴϵ϶ϷϸϹϺϻϼϽϾϿЀЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяѐёђѓєѕіїјљњћќѝўџѠѡѢѣѤѥѦѧѨѩѪѫѬѭѮѯѰѱѲѳѴѵѶѷѸѹѺѻѼѽѾѿҀҁ҂҃҄҅҆҇҈҉ҊҋҌҍҎҏҐґҒғҔҕҖҗҘҙҚқҜҝҞҟҠҡҢңҤҥҦҧҨҩҪҫҬҭҮүҰұҲҳҴҵҶҷҸҹҺһҼҽҾҿӀӁӂӃӄӅӆӇӈӉӊӋӌӍӎӏӐӑӒӓӔӕӖӗӘәӚӛӜӝӞӟӠӡӢӣӤӥӦӧӨөӪӫӬӭӮӯӰӱӲӳӴӵӶӷӸӹӺӻӼӽӾӿԀԁԂԃԄԅԆԇԈԉԊԋԌԍԎԏԐԑԒԓԔԕԖԗԘԙԚԛԜԝԞԟԠԡԢԣԤԥԦԧԨԩԪԫԬԭԮԯ", "₠₡₢₣₤₥₦₧₨₩₪₫€₭₮₯₰₱₲₳₴₵₶₷₸₹₺₻₼₽₾₿℀℁ℂ℃℄℅℆ℇ℈℉ℊℋℌℍℎℏℐℑℒℓ℔ℕ№℗℘ℙℚℛℜℝ℞℟℠℡™℣ℤ℥Ω℧ℨ℩KÅℬℭ℮ℯℰℱℲℳℴℵℶℷℸ℺℻ℼℽℾℿ⅀⅁⅂⅃⅄ⅅⅆⅇⅈⅉ⅊⅋⅌⅍ⅎ⅏∀∁∂∃∄∅∆∇∈∉∊∋∌∍∎∏∐∑−∓∔∕∖∗∘∙√∛∜∝∞∟∠∡∢∣∤∥∦∧∨∩∪∫∬∭∮∯∰∱∲∳∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘⊙⊚⊛⊜⊝⊞⊟⊠⊡⊢⊣⊤⊥⊦⊧⊨⊩⊪⊫⊬⊭⊮⊯⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊺⊻⊼⊽⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⋲⋳⋴⋵⋶⋷⋸⋹⋺⋻⋼⋽⋾⋿"}
local function charAt(p1, p2) -- Line: 27
    return (string.sub(p1, p2, p2))
end
local function getSizeChar(p1, p2) -- Line: 31 -- upvalues: u51 (val)
    local v1 = u51[p1]
    return (string.sub(v1, p2, p2 + p1 - 1))
end
local u58 = {}
local v7 = 9
local v8 = 1
for i = 0, v7, v8 do
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
game:GetService("RunService").Heartbeat:connect(function() -- Line: 52 -- upvalues: u58 (ref), u87 (val), u90 (val)
    local v1
    for k, v in pairs(u58) do
        v1 = (tick() - u87) * 0.05
        v.Position = UDim2.new(0, 0, (v1 + u90 * k) % 1.1 - 0.05, 0)
    end
end)
function v1.Create(p1, p2, p3, p4, p5, p6, p7) -- Line: 59 -- upvalues: Frame (val), TemplateLabel (val), TweenService (val), u58 (ref), u17 (val), u51 (val), Text (val), RenderStepped (val)
    local u200, u203, u206, v1, v2, v3
    local u209 = {}
    local BindableEvent = Instance.new("BindableEvent")
    local v4 = p4
    if not v4 then
        v4 = Color3.fromRGB(105, 203, 255)
    end
    local u199 = math.min(p2, 100)
    if not (p5 or false) then
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
    TemplateLabel.TextColor3 = v4
    TemplateLabel.TextSize = u199
    local u198 = nil
    u200, u203, u206 = p3, p6, p7
    for i, v in ipairs(p3) do
        v2 = TemplateLabel:Clone()
        v2.Name = i
        v2.Size = UDim2.new(1, 0, 1 / #u200, 0)
        v2.Position = UDim2.new(0, 0, 0, (i - 1) * u199)
        v2.Parent = Frame
        table.insert(u209, v2)
        if not u198 then
            u198 = v
        elseif #u198 >= #v then
        end
    end
    local TextService = game:GetService("TextService")
    Frame.Size = UDim2.new(0, TextService:GetTextSize(u198, u199, Enum.Font.Code, Vector2.new(10000, 0)).X, 0, #u200 * u199)
    local v5 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local v6 = {Transparency = 0.3}
    TweenService:Create(Frame.Back, v5, v6):Play()
    for k, i2 in pairs(u58) do
        v3 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(i2, v3, {Transparency = 0.85}):Play()
    end
    local u139 = {}
    v1 = coroutine.create(function() -- Line: 104 -- upvalues: u200 (val), u209 (val), u139 (val), u17 (upval), u51 (upval), Text (upval), RenderStepped (upval), u203 (val), u206 (val), Frame (upval), u198 (ref), u199 (ref), TweenService (upval), u58 (upval), BindableEvent (val)
        local v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12
        for i, v in ipairs(u200) do
            v8 = u209[i]
            v9 = #v
            v10 = v9
            v11 = 1
            for i2 = 0, v10, v11 do
                if i2 ~= 0 and string.sub(v, i2, i2) ~= " " then
                    table.insert(u139, {i, i2})
                end
                v1 = u17:NextInteger(1, 3)
                v3 = string.sub(v, 0, i2)
                if i2 >= v9 then
                    v4 = ""
                else
                    v5 = u17:NextInteger(1, #u51[v1] / v1)
                    v4 = string.sub(u51[v1], v5, v5 + v1 - 1)
                end
                v8.Text = v3 .. v4
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
        local v13 = #u139
        task.wait(v13 * 0.012)
        task.wait(u203 or 0)
        local v14 = u206
        if not v14 then
            v14 = #u139 / 3 * 0.02
        end
        local TextService = game:GetService("TextService")
        v11 = #u200
        Frame.Size = UDim2.new(0, TextService:GetTextSize(u198, u199, Enum.Font.Code, Vector2.new(10000, 0)).X, 0, v11 * u199)
        v8 = TweenInfo.new(v14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        v9 = {Transparency = 1}
        TweenService:Create(Frame.Back, v8, v9):Play()
        for k, j in pairs(u58) do
            v2 = TweenInfo.new(v14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(j, v2, {Transparency = 1}):Play()
        end
        local v15 = nil
        local v16 = nil
        while true do
            v8 = #u139
            if 0 >= v8 then
                break
            end
            v8 = 3
            v9 = 1
            for k2 = 1, v8, v9 do
                v11 = u17:NextInteger(1, #u139)
                v12 = u139[v11][1]
                v1 = u139[v11][2]
                table.remove(u139, v11)
                v3 = u17:NextInteger(1, #u51[1])
                v6 = string.sub(u200[v12], 0, v1 - 1)
                v7 = string.sub(u51[1], v3, v3)
                u200[v12] = v6 .. v7 .. string.sub(u200[v12], v1 + 1, #u200[v12])
                if v15 then
                    v6 = string.sub(u200[v15], 0, v16 - 1)
                    u200[v15] = v6 .. " " .. string.sub(u200[v15], v16 + 1, #u200[v15])
                    v4 = u209[v15]
                    v4.Text = u200[v15]
                end
                u209[v12].Text = u200[v12]
                v15 = v12
                v16 = v1
                if #u139 == 0 then
                    break
                end
            end
            v8 = #u200
            v9 = 1
            for n = 1, v8, v9 do
                v11 = u209[n]
                v11.TextTransparency = 1 - #u139 / v13
            end
            v8 = Text:Clone()
            v8.Parent = script
            v8:Play()
            game.Debris:AddItem(v8, 0.5)
            v9 = 0
            while v9 < 0.016666666666666666 do
                v9 = v9 + RenderStepped:Wait()
            end
        end
        if v15 then
            v10 = string.sub(u200[v15], 0, v16 - 1)
            u200[v15] = v10 .. " " .. string.sub(u200[v15], v16 + 1, #u200[v15])
            v8 = u209[v15]
            v8.Text = u200[v15]
        end
        for k3, m in pairs(u209) do
            m:Destroy()
        end
        BindableEvent:Fire()
    end)
    coroutine.resume(v1)
    return BindableEvent
end
return v1