--// MidNight Hub
--// Credits: MidNight
--// Discord Team Name

--// Founder:            @nshwshadow      / Id → 904685000983736341
--// Dev team leader:    @pocoyo.js       / Id → 1247963459602350080
--// Developer:          @peterpines9     / Id → 1470202646722908242
--// Developer:          @draken13br      / Id → 1222501858120306718

local placeScripts = {
    [131623223084840] = { script_id = "d50d096921fc3d6157990616b5c64e97" },
    [130167267952199] = { script_id = "edc1be702d0741c0d803d9cc44720fd7" },
    [77747658251236]  = { script_id = "edc1be702d0741c0d803d9cc44720fd7" },
    [89469502395769]  = { script_id = "35aa8469a0f4dfc15c99ae8f5c85d862" },
    [126509999114328] = {
        options = {
            { label = "Main Script",      script_id = "76bd9b0ebf88aa5dab8c5e7cc075afe1" },
            { label = "Kaitun 99 Noites", script_id = "3845b4aacb2fbf85bbdc40d5625a9a17" },
        }
    },
}

local placeEntry = placeScripts[game.PlaceId]
if not placeEntry then return end

local CONFIG = {
    DiscordInvite = "https://discord.gg/Wkj77kdgHS",
    KeyLink       = "https://midnighthub-getkey.vercel.app/",

    KaitunScriptId = "3845b4aacb2fbf85bbdc40d5625a9a17",

    SaveFile = "MidNightHub_AutoScript.json",

    AutoRejoinFile = "MidNightHub_AutoRejoin.json",
}

local HttpService      = game:GetService("HttpService")
local TweenService     = game:GetService("TweenService")
local CoreGui          = game:GetService("CoreGui")
local TeleportService  = game:GetService("TeleportService")
local Players          = game:GetService("Players")
local Plr              = Players.LocalPlayer

local LOADER_URL = "https://raw.githubusercontent.com/Dev-pocoyoJS/Autoexecute/refs/heads/main/Loader_AutoExecute-1.lua"

local function SetupQueue()
    if not queue_on_teleport then return end
    pcall(function()
        queue_on_teleport('loadstring(game:HttpGet("' .. LOADER_URL .. '", true))()')
    end)
end

SetupQueue()

local function SavePref(scriptId, autoRejoin)
    if not writefile then return end
    pcall(function()
        writefile(CONFIG.SaveFile, HttpService:JSONEncode({
            script_id   = scriptId,
            auto_rejoin = autoRejoin,
        }))
    end)
end

local function LoadPref()
    if not isfile or not readfile then return nil end
    local ok, data = pcall(function()
        if isfile(CONFIG.SaveFile) then
            return HttpService:JSONDecode(readfile(CONFIG.SaveFile))
        end
    end)
    if ok and data then return data end
    return nil
end

local subtitleByLang = {
    portuguese = "Acesso Premium - Protegido por Luarmor",
    vietnamese = "Truy cập Cao cấp - Bảo vệ bởi Luarmor",
    english    = "Enter your license key",
}

local confirmTextByLang = {
    portuguese = "VOCÊ QUER EXECUTAR ESSE SCRIPT\nNA PRÓXIMA VEZ QUE ENTRAR?",
    vietnamese = "BẠN CÓ MUỐN CHẠY SCRIPT NÀY\nLẦN SAU KHI VÀO?",
    english    = "DO YOU WANT TO RUN THIS SCRIPT\nNEXT TIME YOU JOIN?",
}

local currentLang = "english"
pcall(function()
    local data = HttpService:JSONDecode(
        game:HttpGet("http://ip-api.com/json/?fields=countryCode")
    )
    if data and data.countryCode then
        if data.countryCode == "BR" or data.countryCode == "PT" then
            currentLang = "portuguese"
        elseif data.countryCode == "VN" then
            currentLang = "vietnamese"
        end
    end
end)

local subtitle = subtitleByLang[currentLang]

local function CloseGui(sg, main)
    TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, 0, -1, 0)
    }):Play()
    TweenService:Create(main, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    task.delay(0.5, function() pcall(function() sg:Destroy() end) end)
end

local function OpenGui(main)
    TweenService:Create(main, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0
    }):Play()
end

local function MakeCard(name, height)
    if CoreGui:FindFirstChild(name) then CoreGui[name]:Destroy() end

    local sg = Instance.new("ScreenGui")
    sg.Name = name
    sg.Parent = CoreGui
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Parent = sg
    main.AnchorPoint = Vector2.new(0.5, 0.5)
    main.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    main.BorderSizePixel = 0
    main.Position = UDim2.new(0.5, 0, 0.5, 120)
    main.BackgroundTransparency = 1
    main.Size = UDim2.new(0, 400, 0, height)
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)

    local glow = Instance.new("ImageLabel")
    glow.Parent = main
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.Size = UDim2.new(1.5, 0, 1.5, 0)
    glow.Image = "rbxassetid://82454449164045"
    glow.ImageColor3 = Color3.fromRGB(180, 0, 0)
    glow.ImageTransparency = 0.72
    glow.ZIndex = 0

    local header = Instance.new("Frame")
    header.Parent = main
    header.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    header.BorderSizePixel = 0
    header.Size = UDim2.new(1, 0, 0, 62)

    local logo = Instance.new("ImageLabel")
    logo.Parent = header
    logo.BackgroundTransparency = 1
    logo.Position = UDim2.new(0, 12, 0, 11)
    logo.Size = UDim2.new(0, 38, 0, 38)
    logo.Image = "rbxassetid://128395878680071"
    Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel")
    title.Parent = header
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 58, 0, 10)
    title.Size = UDim2.new(0.8, 0, 0, 22)
    title.Font = Enum.Font.GothamBlack
    title.Text = "MidNight Hub"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Left

    local sub = Instance.new("TextLabel")
    sub.Parent = header
    sub.BackgroundTransparency = 1
    sub.Position = UDim2.new(0, 58, 0, 34)
    sub.Size = UDim2.new(0.8, 0, 0, 18)
    sub.Font = Enum.Font.Gotham
    sub.Text = "Auto Execute"
    sub.TextColor3 = Color3.fromRGB(120, 120, 120)
    sub.TextSize = 12
    sub.TextXAlignment = Enum.TextXAlignment.Left

    local div = Instance.new("Frame")
    div.Parent = main
    div.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    div.BorderSizePixel = 0
    div.Position = UDim2.new(0, 0, 0, 62)
    div.Size = UDim2.new(1, 0, 0, 1)

    return sg, main
end

local function MakeButton(parent, text, yPos, accent)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.BackgroundColor3 = accent and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(22, 22, 22)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0.04, 0, 0, yPos)
    btn.Size = UDim2.new(0.92, 0, 0, 44)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = accent and Color3.fromRGB(210, 20, 20) or Color3.fromRGB(32, 32, 32)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {
            BackgroundColor3 = accent and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(22, 22, 22)
        }):Play()
    end)

    return btn
end

local function ShowSelectionScreen()
    local options = placeEntry.options
    local sg, main = MakeCard("MidNightSelect", 76 + (#options * 56))
    local done = false
    local result = nil

    for i, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Parent = main
        btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        btn.BorderSizePixel = 0
        btn.Position = UDim2.new(0.04, 0, 0, 72 + (i - 1) * 56)
        btn.Size = UDim2.new(0.92, 0, 0, 44)
        btn.Font = Enum.Font.GothamBold
        btn.Text = ""
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

        local accent = Instance.new("Frame")
        accent.Parent = btn
        accent.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        accent.BorderSizePixel = 0
        accent.Position = UDim2.new(0, 0, 0.18, 0)
        accent.Size = UDim2.new(0, 3, 0.64, 0)
        Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 3)

        local lbl = Instance.new("TextLabel")
        lbl.Parent = btn
        lbl.BackgroundTransparency = 1
        lbl.Position = UDim2.new(0, 16, 0, 0)
        lbl.Size = UDim2.new(0.85, 0, 1, 0)
        lbl.Font = Enum.Font.GothamSemibold
        lbl.Text = option.label
        lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        lbl.TextSize = 15
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local arrow = Instance.new("TextLabel")
        arrow.Parent = btn
        arrow.BackgroundTransparency = 1
        arrow.Position = UDim2.new(0.85, 0, 0, 0)
        arrow.Size = UDim2.new(0.12, 0, 1, 0)
        arrow.Font = Enum.Font.GothamBold
        arrow.Text = "›"
        arrow.TextColor3 = Color3.fromRGB(180, 0, 0)
        arrow.TextSize = 22

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            }):Play()
        end)

        btn.MouseButton1Click:Connect(function()
            if done then return end
            done = true
            result = option
            CloseGui(sg, main)
        end)
    end

    OpenGui(main)
    repeat task.wait(0.05) until done
    task.wait(0.55)
    return result
end

local function ShowConfirmScreen(scriptLabel, autoRejoin)
    local sg, main = MakeCard("MidNightConfirm", 260)
    local done = false
    local result = nil

    local question = Instance.new("TextLabel")
    question.Parent = main
    question.BackgroundTransparency = 1
    question.Position = UDim2.new(0.04, 0, 0, 74)
    question.Size = UDim2.new(0.92, 0, 0, 60)
    question.Font = Enum.Font.GothamBold
    question.Text = confirmTextByLang[currentLang]
    question.TextColor3 = Color3.fromRGB(230, 230, 230)
    question.TextSize = 14
    question.TextWrapped = true
    question.TextXAlignment = Enum.TextXAlignment.Center

    local scriptName = Instance.new("TextLabel")
    scriptName.Parent = main
    scriptName.BackgroundTransparency = 1
    scriptName.Position = UDim2.new(0.04, 0, 0, 134)
    scriptName.Size = UDim2.new(0.92, 0, 0, 20)
    scriptName.Font = Enum.Font.GothamBold
    scriptName.Text = "[ " .. scriptLabel .. " ]"
    scriptName.TextColor3 = Color3.fromRGB(180, 0, 0)
    scriptName.TextSize = 14
    scriptName.TextXAlignment = Enum.TextXAlignment.Center

    local countdown = Instance.new("TextLabel")
    countdown.Parent = main
    countdown.BackgroundTransparency = 1
    countdown.Position = UDim2.new(0.04, 0, 0, 155)
    countdown.Size = UDim2.new(0.92, 0, 0, 16)
    countdown.Font = Enum.Font.Gotham
    countdown.Text = "Executando em 10s..."
    countdown.TextColor3 = Color3.fromRGB(100, 100, 100)
    countdown.TextSize = 12
    countdown.TextXAlignment = Enum.TextXAlignment.Center

    local simBtn = MakeButton(main, "✓  SIM", 174, true)
    simBtn.Size = UDim2.new(0.44, 0, 0, 44)
    simBtn.Position = UDim2.new(0.04, 0, 0, 174)

    local naoBtn = MakeButton(main, "✗  NÃO", 174, false)
    naoBtn.Size = UDim2.new(0.44, 0, 0, 44)
    naoBtn.Position = UDim2.new(0.52, 0, 0, 174)

    simBtn.MouseButton1Click:Connect(function()
        if done then return end
        done = true
        result = true
        CloseGui(sg, main)
    end)

    naoBtn.MouseButton1Click:Connect(function()
        if done then return end
        done = true
        result = false
        CloseGui(sg, main)
    end)

    OpenGui(main)

    task.spawn(function()
        for i = 10, 1, -1 do
            if done then return end
            countdown.Text = "Executando em " .. i .. "s..."
            task.wait(1)
        end
        if not done then
            done = true
            result = true
            CloseGui(sg, main)
        end
    end)

    repeat task.wait(0.05) until done
    task.wait(0.55)
    return result
end

local function ShowAutoRejoinScreen(currentState)
    local sg, main = MakeCard("MidNightRejoin", 220)
    local done = false
    local result = currentState

    local question = Instance.new("TextLabel")
    question.Parent = main
    question.BackgroundTransparency = 1
    question.Position = UDim2.new(0.04, 0, 0, 74)
    question.Size = UDim2.new(0.92, 0, 0, 50)
    question.Font = Enum.Font.GothamBold
    question.Text = "ATIVAR AUTO REJOIN?\n(Reconecta automaticamente se a internet cair)"
    question.TextColor3 = Color3.fromRGB(230, 230, 230)
    question.TextSize = 13
    question.TextWrapped = true
    question.TextXAlignment = Enum.TextXAlignment.Center

    local status = Instance.new("TextLabel")
    status.Parent = main
    status.BackgroundTransparency = 1
    status.Position = UDim2.new(0.04, 0, 0, 126)
    status.Size = UDim2.new(0.92, 0, 0, 18)
    status.Font = Enum.Font.GothamBold
    status.Text = currentState and "Status: ATIVADO ✓" or "Status: DESATIVADO ✗"
    status.TextColor3 = currentState and Color3.fromRGB(50, 205, 110) or Color3.fromRGB(180, 180, 180)
    status.TextSize = 13
    status.TextXAlignment = Enum.TextXAlignment.Center

    local ativarBtn = MakeButton(main, "✓  ATIVAR", 150, true)
    ativarBtn.Size = UDim2.new(0.44, 0, 0, 44)
    ativarBtn.Position = UDim2.new(0.04, 0, 0, 150)

    local desativarBtn = MakeButton(main, "✗  DESATIVAR", 150, false)
    desativarBtn.Size = UDim2.new(0.44, 0, 0, 44)
    desativarBtn.Position = UDim2.new(0.52, 0, 0, 150)

    ativarBtn.MouseButton1Click:Connect(function()
        if done then return end
        done = true
        result = true
        CloseGui(sg, main)
    end)

    desativarBtn.MouseButton1Click:Connect(function()
        if done then return end
        done = true
        result = false
        CloseGui(sg, main)
    end)

    OpenGui(main)
    repeat task.wait(0.05) until done
    task.wait(0.55)
    return result
end

local function StartAutoRejoin()
    task.spawn(function()
        while true do
            task.wait(5)

            pcall(function()
                if not Plr.Character and not game:IsLoaded() then
                    task.wait(3)
                    TeleportService:Teleport(game.PlaceId, Plr)
                end
            end)
        end
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        if player == Plr then
            task.wait(2)
            pcall(function()
                TeleportService:Teleport(game.PlaceId, Plr)
            end)
        end
    end)
end

local chosenScriptId = placeEntry.script_id
local autoRejoinEnabled = false

if placeEntry.options and not chosenScriptId then

    local pref = LoadPref()

    if pref and pref.script_id then

        local isKaitun = (pref.script_id == CONFIG.KaitunScriptId)
        autoRejoinEnabled = pref.auto_rejoin or false

        if isKaitun then

            local label = "Kaitun 99 Noites"
            for _, opt in ipairs(placeEntry.options) do
                if opt.script_id == pref.script_id then
                    label = opt.label
                    break
                end
            end

            local confirmed = ShowConfirmScreen(label, autoRejoinEnabled)

            if confirmed then

                chosenScriptId = pref.script_id
                SavePref(chosenScriptId, autoRejoinEnabled)
            else

                local selected = ShowSelectionScreen()
                chosenScriptId = selected.script_id

                if chosenScriptId == CONFIG.KaitunScriptId then
                    autoRejoinEnabled = ShowAutoRejoinScreen(autoRejoinEnabled)
                else
                    autoRejoinEnabled = false
                end

                SavePref(chosenScriptId, autoRejoinEnabled)
            end
        else

            chosenScriptId = pref.script_id
        end
    else

        local selected = ShowSelectionScreen()
        chosenScriptId = selected.script_id

        if chosenScriptId == CONFIG.KaitunScriptId then
            autoRejoinEnabled = ShowAutoRejoinScreen(false)
        end

        SavePref(chosenScriptId, autoRejoinEnabled)
    end
end

if autoRejoinEnabled then
    StartAutoRejoin()
end

local luarmor = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua", true))()
luarmor.script_id = chosenScriptId

local Arqel = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Cobruhehe/expert-octo-doodle/refs/heads/main/ArqelUi.luau"
))()

Arqel.Appearance.Title    = "MidNight Hub"
Arqel.Appearance.Subtitle = subtitle
Arqel.Appearance.Icon     = "rbxassetid://128395878680071"
Arqel.Appearance.IconSize = UDim2.new(0, 35, 0, 35)

Arqel.Links.GetKey  = CONFIG.KeyLink
Arqel.Links.Discord = CONFIG.DiscordInvite

Arqel.Theme.Accent        = Color3.fromRGB(180, 0, 0)
Arqel.Theme.AccentHover   = Color3.fromRGB(210, 20, 20)
Arqel.Theme.Background    = Color3.fromRGB(8, 8, 8)
Arqel.Theme.Header        = Color3.fromRGB(12, 12, 12)
Arqel.Theme.Input         = Color3.fromRGB(18, 18, 18)
Arqel.Theme.Divider       = Color3.fromRGB(60, 0, 0)
Arqel.Theme.StatusIdle    = Color3.fromRGB(140, 0, 0)
Arqel.Theme.Pending       = Color3.fromRGB(30, 30, 30)
Arqel.Theme.Discord       = Color3.fromRGB(88, 101, 242)
Arqel.Theme.DiscordHover  = Color3.fromRGB(114, 137, 218)
Arqel.Theme.Success       = Color3.fromRGB(50, 205, 110)
Arqel.Theme.Error         = Color3.fromRGB(245, 70, 90)
Arqel.Theme.Warning       = Color3.fromRGB(255, 180, 50)
Arqel.Theme.Text          = Color3.fromRGB(255, 255, 255)
Arqel.Theme.TextDim       = Color3.fromRGB(120, 120, 120)

Arqel.Storage.FileName = "MidNightHub_Key"
Arqel.Storage.Remember = true
Arqel.Storage.AutoLoad = true

Arqel.Options.Blur      = true
Arqel.Options.Draggable = true

Arqel.Shop.Enabled    = true
Arqel.Shop.Icon       = "rbxassetid://128395878680071"
Arqel.Shop.Title      = "Get MidNight Key"
Arqel.Shop.Subtitle   = "Instant delivery • 24/7 support"
Arqel.Shop.ButtonText = "Purchase"
Arqel.Shop.Link       = CONFIG.DiscordInvite

Arqel.Changelog = {
    {Version = "v1.0.0", Date = "Março 9, 2026", Changes = {"NEW UI"}}
}

Arqel.Callbacks.OnVerify = function(key)
    local result = luarmor.check_key(key)
    if result and result.code == "KEY_VALID" then
        getgenv().script_key = key
        return true
    elseif result and result.code == "KEY_HWID_LOCKED" then
        return { valid = false, error = "HWID_MISMATCH", message = "Chave vinculada a outro HWID! 🔒" }
    elseif result and result.code == "KEY_INCORRECT" then
        return { valid = false, error = "KEY_INVALID", message = "Chave inválida! ❌" }
    else
        return { valid = false, error = "ERROR", message = (result and result.message) or "Erro desconhecido" }
    end
end

Arqel.Callbacks.OnSuccess = function()
    pcall(function() luarmor.load_script() end)
end

Arqel.Callbacks.OnFail = function(err)
    warn("[MidNight Hub] Key failed: " .. tostring(err))
end

Arqel.Callbacks.OnClose = function()
    getgenv().script_key = nil
end

Arqel:Launch()
