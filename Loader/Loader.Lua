--// READ BEFORE USING THIS SOURCE
--// Credits: MidNight

--// Discord Team Name
--// Founder: @nshwshadow / Id --> 904685000983736341
--// Developer: @nzxdev_ / Id --> 1468421337201770627

--// RedzLib included in main source
--// Original library by GitHub user @tlredz

--// WARNING:
--// Removing, modifying, or hiding these credits is strictly prohibited.
--// Any use, modification, or redistribution of this source must retain proper credit.
--// Unauthorized use without attribution is not permitted.

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local script_id = "d50d096921fc3d6157990616b5c64e97"
local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua", true))()
api.script_id = script_id

local function safe_write(filename, data)
    pcall(function()
        if writefile then
            writefile(filename, data)
        elseif (writefile == nil) and pcall(function() return syn and syn.write_file end) then
            syn.write_file(filename, data)
        end
    end)
end

local function safe_read(filename)
    local ok, content = pcall(function()
        if isfile and isfile(filename) then
            return readfile(filename)
        elseif pcall(function() return syn and syn.read_file end) and syn and syn.read_file(filename) then
            return syn.read_file(filename)
        end
        return nil
    end)
    if ok and content and #content > 0 then
        return content
    end
    return nil
end

local filename = "MidNightKey.txt"

if CoreGui:FindFirstChild("MidNightKey") then
    CoreGui.MidNightKey:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "MidNightKey"
sg.Parent = CoreGui
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Name = "Main"
main.Parent = sg
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 420, 0, 320)
main.ClipsDescendants = true
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = main

local glow = Instance.new("ImageLabel")
glow.Name = "Glow"
glow.Parent = main
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.BackgroundTransparency = 1
glow.Position = UDim2.new(0.5, 0, 0.5, 0)
glow.Size = UDim2.new(1.4, 0, 1.4, 0)
glow.Image = "rbxassetid://82454449164045"
glow.ImageColor3 = Color3.fromRGB(255, 60, 60)
glow.ImageTransparency = 0.65
glow.ZIndex = 0

local logo = Instance.new("ImageLabel")
logo.Parent = main
logo.BackgroundTransparency = 1
logo.Position = UDim2.new(0.04, 0, 0.06, 0)
logo.Size = UDim2.new(0, 50, 0, 50)
logo.Image = "rbxassetid://93559289273292"
local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 10)
logoCorner.Parent = logo

local title = Instance.new("TextLabel")
title.Parent = main
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.04, 50, 0.06, 0)
title.Size = UDim2.new(0.9, 0, 0, 40)
title.Font = Enum.Font.GothamBlack
title.Text = "MIDNIGHT HUB"
title.TextColor3 = Color3.fromRGB(255, 40, 40)
title.TextSize = 28
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextTransparency = 0.1

local subtitle = Instance.new("TextLabel")
subtitle.Parent = title
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.new(0, 0, 1, -8)
subtitle.Size = UDim2.new(1, 0, 0, 22)
subtitle.Font = Enum.Font.Gotham
subtitle.Text = "Premium Access - Luarmor Protected"
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.TextSize = 14
subtitle.TextXAlignment = Enum.TextXAlignment.Left

local keybox = Instance.new("TextBox")
keybox.Name = "KeyBox"
keybox.Parent = main
keybox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
keybox.BorderSizePixel = 0
keybox.Position = UDim2.new(0.05, 0, 0.32, 0)
keybox.Size = UDim2.new(0.9, 0, 0, 52)
keybox.Font = Enum.Font.GothamSemibold
keybox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keybox.PlaceholderText = "Enter your key..."
keybox.Text = ""
keybox.TextColor3 = Color3.fromRGB(240, 240, 240)
keybox.TextSize = 17
keybox.ClearTextOnFocus = false
local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 12)
keyCorner.Parent = keybox

local submit = Instance.new("TextButton")
submit.Name = "Submit"
submit.Parent = main
submit.BackgroundColor3 = Color3.fromRGB(220, 40, 40)
submit.BorderSizePixel = 0
submit.Position = UDim2.new(0.05, 0, 0.50, 0)
submit.Size = UDim2.new(0.9, 0, 0, 52)
submit.Font = Enum.Font.GothamBold
submit.Text = "VERIFY KEY"
submit.TextColor3 = Color3.fromRGB(255, 255, 255)
submit.TextSize = 18
local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 12)
submitCorner.Parent = submit

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Parent = main
getKeyBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
getKeyBtn.BorderSizePixel = 0
getKeyBtn.Position = UDim2.new(0.05, 0, 0.68, 0)
getKeyBtn.Size = UDim2.new(0.9, 0, 0, 40)
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.Text = "GET KEY"
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.TextSize = 16
local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 10)
getKeyCorner.Parent = getKeyBtn

local discordBtn = Instance.new("TextButton")
discordBtn.Parent = main
discordBtn.BackgroundTransparency = 1
discordBtn.Position = UDim2.new(0.05, 0, 0.80, 0)
discordBtn.Size = UDim2.new(0.9, 0, 0, 30)
discordBtn.Font = Enum.Font.Gotham
discordBtn.Text = "Join Discord → discord.gg/Wkj77kdgHS"
discordBtn.TextColor3 = Color3.fromRGB(180, 180, 255)
discordBtn.TextSize = 14
discordBtn.TextXAlignment = Enum.TextXAlignment.Left
local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 8)
discordCorner.Parent = discordBtn

local status = Instance.new("TextLabel")
status.Parent = main
status.BackgroundTransparency = 1
status.Position = UDim2.new(0.05, 0, 0.86, 0)
status.Size = UDim2.new(0.9, 0, 0, 30)
status.Font = Enum.Font.GothamSemibold
status.Text = ""
status.TextColor3 = Color3.fromRGB(255, 100, 100)
status.TextSize = 15
status.TextTransparency = 1

local welcome = Instance.new("TextLabel")
welcome.Parent = main
welcome.BackgroundTransparency = 1
welcome.Position = UDim2.new(0.05, 0, 0.92, 0)
welcome.Size = UDim2.new(0.9, 0, 0, 30)
welcome.Font = Enum.Font.GothamBold
welcome.Text = ""
welcome.TextColor3 = Color3.fromRGB(80, 255, 120)
welcome.TextSize = 16
welcome.TextTransparency = 1

local function hoverEffect(btn, normal, hover)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = hover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = normal}):Play()
    end)
end

hoverEffect(submit, Color3.fromRGB(220, 40, 40), Color3.fromRGB(240, 60, 60))
local function hoverEffectGetKey(btn, normal, hover)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = hover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = normal}):Play()
    end)
end
hoverEffectGetKey(getKeyBtn, Color3.fromRGB(25, 25, 30), Color3.fromRGB(40, 40, 45))

main.Position = UDim2.new(0.5, 0, 0.5, 100)
main.BackgroundTransparency = 1
TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
TweenService:Create(main, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()

local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    main.Position = newPos
end

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

local function verifyKey()
    local key = keybox.Text or ""
    key = key:gsub("%s+", "")

    if key == "" then
        status.Text = "Enter a key!"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        TweenService:Create(status, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        task.delay(2.5, function() TweenService:Create(status, TweenInfo.new(0.5), {TextTransparency = 1}):Play() end)
        return
    end

    submit.Text = "CHECKING..."
    submit.BackgroundColor3 = Color3.fromRGB(180, 30, 30)

    getgenv().script_key = key
    safe_write(filename, key)

    task.delay(0.5, function()
        status.Text = "Access Granted"
        status.TextColor3 = Color3.fromRGB(80, 255, 120)
        TweenService:Create(status, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

        welcome.Text = "Welcome back, " .. Players.LocalPlayer.DisplayName .. "!"
        TweenService:Create(welcome, TweenInfo.new(0.45, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

        submit.Text = "SUCCESS"
        submit.BackgroundColor3 = Color3.fromRGB(40, 180, 40)

        task.delay(1.1, function()
            TweenService:Create(main, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -1, 0)
            }):Play()
            TweenService:Create(main, TweenInfo.new(0.65), {BackgroundTransparency = 1}):Play()
            TweenService:Create(status, TweenInfo.new(0.45), {TextTransparency = 1}):Play()
            TweenService:Create(welcome, TweenInfo.new(0.45), {TextTransparency = 1}):Play()

            task.delay(0.8, function()
                if sg then sg:Destroy() end
                task.spawn(function()
                    pcall(function()
                        api.load_script()
                    end)
                end)
            end)
        end)
    end)
end

submit.MouseButton1Click:Connect(verifyKey)
keybox.FocusLost:Connect(function(enterPressed)
    if enterPressed then verifyKey() end
end)

getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://ads.luarmor.net/get_key?for=MidNight_Hub__Key_System-dLnyEopHPYsm")
    getKeyBtn.Text = "Copied!"
    TweenService:Create(getKeyBtn, TweenInfo.new(0.3), {TextTransparency = 0.2}):Play()
    task.delay(1.8, function()
        TweenService:Create(getKeyBtn, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        getKeyBtn.Text = "GET KEY"
    end)
end)

discordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/Wkj77kdgHS")
    discordBtn.Text = "Copied!"
    TweenService:Create(discordBtn, TweenInfo.new(0.3), {TextTransparency = 0.2}):Play()
    task.delay(1.8, function()
        TweenService:Create(discordBtn, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        discordBtn.Text = "Join Discord → discord.gg/Wkj77kdgHS"
    end)
end)

local saved = safe_read(filename)
if saved then
    keybox.Text = saved
    getgenv().script_key = saved
    verifyKey()
end
