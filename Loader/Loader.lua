--// MidNight Hub
--// Credits: MidNight
--// Discord Team Name

--// Founder:            @nshwshadow      / Id → 904685000983736341
--// Dev team leader:    @pocoyo.js       / Id → 1247963459602350080
--// Developer:          @peterpines9     / Id → 1470202646722908242
--// Developer:          @draken13br      / Id → 1222501858120306718

local placeScripts = {
    [131623223084840] = { script_id = "d50d096921fc3d6157990616b5c64e97" },
    [130167267952199] = { script_id = "edc1be702d0741c0d803d9cc44720fd7"},
    [77747658251236]  = { script_id = "edc1be702d0741c0d803d9cc44720fd7" },
    [89469502395769]  = { script_id = "35aa8469a0f4dfc15c99ae8f5c85d862" },
    [126509999114328]  = {
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
}

local HttpService  = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local CoreGui      = game:GetService("CoreGui")

local subtitleByLang = {
    portuguese = "Acesso Premium - Protegido por Luarmor",
    vietnamese = "Truy cập Cao cấp - Bảo vệ bởi Luarmor",
    english    = "Enter your license key",
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

local chosenScriptId = placeEntry.script_id

if placeEntry.options and not chosenScriptId then
    if CoreGui:FindFirstChild("MidNightSelect") then
        CoreGui.MidNightSelect:Destroy()
    end

    local selDone = false

    local selSg = Instance.new("ScreenGui")
    selSg.Name = "MidNightSelect"
    selSg.Parent = CoreGui
    selSg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    selSg.ResetOnSpawn = false

    local selMain = Instance.new("Frame")
    selMain.Name = "SelectMain"
    selMain.Parent = selSg
    selMain.AnchorPoint = Vector2.new(0.5, 0.5)
    selMain.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
    selMain.BorderSizePixel = 0
    selMain.Position = UDim2.new(0.5, 0, 0.5, 120)
    selMain.BackgroundTransparency = 1
    selMain.Size = UDim2.new(0, 400, 0, 76 + (#placeEntry.options * 56))
    selMain.ClipsDescendants = true
    Instance.new("UICorner", selMain).CornerRadius = UDim.new(0, 14)

    local selGlow = Instance.new("ImageLabel")
    selGlow.Parent = selMain
    selGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    selGlow.BackgroundTransparency = 1
    selGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    selGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    selGlow.Image = "rbxassetid://82454449164045"
    selGlow.ImageColor3 = Color3.fromRGB(180, 0, 0)
    selGlow.ImageTransparency = 0.72
    selGlow.ZIndex = 0

    local selHeader = Instance.new("Frame")
    selHeader.Parent = selMain
    selHeader.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    selHeader.BorderSizePixel = 0
    selHeader.Position = UDim2.new(0, 0, 0, 0)
    selHeader.Size = UDim2.new(1, 0, 0, 62)
    Instance.new("UICorner", selHeader).CornerRadius = UDim.new(0, 14)

    local selLogo = Instance.new("ImageLabel")
    selLogo.Parent = selHeader
    selLogo.BackgroundTransparency = 1
    selLogo.Position = UDim2.new(0, 12, 0, 11)
    selLogo.Size = UDim2.new(0, 38, 0, 38)
    selLogo.Image = "rbxassetid://128395878680071"
    Instance.new("UICorner", selLogo).CornerRadius = UDim.new(0, 8)

    local selTitle = Instance.new("TextLabel")
    selTitle.Parent = selHeader
    selTitle.BackgroundTransparency = 1
    selTitle.Position = UDim2.new(0, 58, 0, 10)
    selTitle.Size = UDim2.new(0.8, 0, 0, 22)
    selTitle.Font = Enum.Font.GothamBlack
    selTitle.Text = "MidNight Hub"
    selTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    selTitle.TextSize = 20
    selTitle.TextXAlignment = Enum.TextXAlignment.Left

    local selSub = Instance.new("TextLabel")
    selSub.Parent = selHeader
    selSub.BackgroundTransparency = 1
    selSub.Position = UDim2.new(0, 58, 0, 34)
    selSub.Size = UDim2.new(0.8, 0, 0, 18)
    selSub.Font = Enum.Font.Gotham
    selSub.Text = "Selecione o script para continuar"
    selSub.TextColor3 = Color3.fromRGB(120, 120, 120)
    selSub.TextSize = 12
    selSub.TextXAlignment = Enum.TextXAlignment.Left

    local div = Instance.new("Frame")
    div.Parent = selMain
    div.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    div.BorderSizePixel = 0
    div.Position = UDim2.new(0.04, 0, 0, 63)
    div.Size = UDim2.new(0.92, 0, 0, 1)

    for i, option in ipairs(placeEntry.options) do
        local btn = Instance.new("TextButton")
        btn.Parent = selMain
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

        local btnLabel = Instance.new("TextLabel")
        btnLabel.Parent = btn
        btnLabel.BackgroundTransparency = 1
        btnLabel.Position = UDim2.new(0, 16, 0, 0)
        btnLabel.Size = UDim2.new(0.85, 0, 1, 0)
        btnLabel.Font = Enum.Font.GothamSemibold
        btnLabel.Text = option.label
        btnLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        btnLabel.TextSize = 15
        btnLabel.TextXAlignment = Enum.TextXAlignment.Left

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
            if selDone then return end
            selDone = true
            chosenScriptId = option.script_id
            TweenService:Create(selMain, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -1, 0)
            }):Play()
            TweenService:Create(selMain, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
            task.delay(0.5, function() selSg:Destroy() end)
        end)
    end

    TweenService:Create(selMain, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    TweenService:Create(selMain, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {
        BackgroundTransparency = 0
    }):Play()

    repeat task.wait(0.05) until selDone
    task.wait(0.55)
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
    pcall(function()
        luarmor.load_script()
    end)
end

Arqel.Callbacks.OnFail = function(err)
    warn("[MidNight Hub] Key failed: " .. tostring(err))
end

Arqel.Callbacks.OnClose = function()
    getgenv().script_key = nil
end

Arqel:Launch()
