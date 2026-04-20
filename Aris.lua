local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local UserInputService=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local LocalPlayer=Players.LocalPlayer
local Camera=workspace.CurrentCamera
local CoreGui=game:GetService("CoreGui")

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title="ARIS HUB V53 PRO",
    Text="Thuật Toán Dòng Chảy Vô Hạn Siêu Mượt - Chữ Nét Hơn!",
    Duration=8
})

_G.Config={
    ESP_Box_P=true, ESP_Name_P=true, ESP_Health_P=true, ESP_Chams_P=true, ESP_Distance_P=true,
    Hitbox_P=false, HitboxSize=150, Hitbox_WallCheck=false, Hitbox_Box=false,
    TeamCheck=true, LowHP_KS=false, WalkSpeed=90, WalkSpeedEnabled=false, Show_ToggleBtn=true,
    Hitbox_NPC=false, HitboxSize_NPC=20, Hitbox_Box_NPC=false, ESP_NPC_Name=false, ESP_NPC_Chams=false, TeamCheck_NPC=false,
    MenuOpen=false
}

if CoreGui:FindFirstChild("ArisHUB_PRO")then CoreGui.ArisHUB_PRO:Destroy()end

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="ArisHUB_PRO"
ScreenGui.ResetOnSpawn=false
ScreenGui.IgnoreGuiInset=true
ScreenGui.DisplayOrder=99999
ScreenGui.Parent=CoreGui

local UIGradientList={}
local TextGradientList={}
local BtnGradientList={}

local function GetRGB()return Color3.fromHSV(tick()%5/5,1,1)end

-- ==========================================
-- HỆ THỐNG DÒNG CHẢY MÀU VÔ HẠN (KHÔNG BAO GIỜ BỊ KHỰNG)
-- ==========================================

-- Bảng màu chuẩn (Đã thiết lập vòng lặp điểm cuối giống điểm đầu để nối đuôi mượt mà)
local Palettes = {
    On = {
        Color3.fromRGB(0, 240, 255),   -- Cyan sáng
        Color3.fromRGB(130, 100, 255), -- Tím mộng mơ
        Color3.fromRGB(255, 150, 255), -- Hồng nhạt
        Color3.fromRGB(0, 240, 255)    -- Vòng lại Cyan
    },
    Off = {
        Color3.fromRGB(12, 12, 12),    -- Đen
        Color3.fromRGB(180, 20, 20),   -- Đỏ gắt
        Color3.fromRGB(12, 12, 12)     -- Đen
    },
    Text = {
        Color3.fromRGB(0, 150, 255),   -- Xanh dương
        Color3.fromRGB(255, 0, 150),   -- Hồng đậm
        Color3.fromRGB(0, 150, 255)    -- Xanh dương
    },
    Border = {
        Color3.fromRGB(255, 0, 0),     -- Đỏ
        Color3.fromRGB(15, 15, 15),    -- Đen
        Color3.fromRGB(255, 0, 0)      -- Đỏ
    }
}

-- Thuật toán tạo dòng chảy bằng cách trượt Keypoint (Chống giật)
local function GetMovingColorSequence(palette, shift)
    local keypoints = {}
    for step = 0, 5 do
        local i = step / 5 -- Chia gradient thành 6 điểm để bao phủ đều (0, 0.2, 0.4, 0.6, 0.8, 1.0)
        local t = (i - shift) % 1
        if t < 0 then t = t + 1 end
        
        local segments = #palette - 1
        local scaled = t * segments
        local index = math.floor(scaled) + 1
        local fraction = scaled - (index - 1)
        
        local color
        if index >= #palette then
            color = palette[#palette]
        else
            color = palette[index]:Lerp(palette[index + 1], fraction)
        end
        table.insert(keypoints, ColorSequenceKeypoint.new(i, color))
    end
    return ColorSequence.new(keypoints)
end

local function CreateBorder(parent)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Thickness = 1.8
    stroke.Color = Color3.new(1, 1, 1)
    local grad = Instance.new("UIGradient", stroke)
    grad.Rotation = 90
    table.insert(UIGradientList, grad)
end

local function CreateTextGradient(parent)
    parent.TextColor3 = Color3.new(1, 1, 1) 
    parent.TextStrokeTransparency = 1 
    
    -- Viền chữ mỏng (0.5) tinh tế
    local txtStroke = Instance.new("UIStroke", parent)
    txtStroke.Thickness = 0.5
    txtStroke.Color = Color3.new(0, 0, 0)

    local grad = Instance.new("UIGradient", parent)
    grad.Rotation = 90
    table.insert(TextGradientList, grad)
end

local function ApplyToggleGradient(parent, isOn)
    local grad = parent:FindFirstChild("ToggleGrad")
    if not grad then
        grad = Instance.new("UIGradient", parent)
        grad.Name = "ToggleGrad"
        grad.Rotation = 90
        table.insert(BtnGradientList, grad)
    end
    -- Gắn nhãn trạng thái để Heartbeat tự động vẽ màu
    parent:SetAttribute("IsOn", isOn)
end

local function CreateButtonText(parent, text, font, size)
    local txt = Instance.new("TextLabel", parent)
    txt.Size = UDim2.new(1, 0, 1, 0)
    txt.BackgroundTransparency = 1
    txt.Text = text
    txt.Font = font
    txt.TextSize = size
    CreateTextGradient(txt)
    return txt
end

-- ==========================================
-- GIAO DIỆN MENU
-- ==========================================

local function MakeDraggable(f)
    local d=false;local i,s
    f.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=true;i=inp.Position;s=f.Position end
    end)
    f.InputChanged:Connect(function(inp)
        if (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) and d then
            local delta=inp.Position-i; f.Position=UDim2.new(s.X.Scale,s.X.Offset+delta.X,s.Y.Scale,s.Y.Offset+delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=false end
    end)
end

-- Nút Toggle Menu
local ToggleBtn=Instance.new("ImageButton",ScreenGui)
ToggleBtn.Size=UDim2.new(0,50,0,50); ToggleBtn.Position=UDim2.new(0,10,0.5,-25)
ToggleBtn.Image="rbxassetid://125329301331069"
ToggleBtn.BackgroundColor3=Color3.fromRGB(30,30,30)
ToggleBtn.ClipsDescendants=true; ToggleBtn.Visible=_G.Config.Show_ToggleBtn
Instance.new("UICorner",ToggleBtn).CornerRadius=UDim.new(0,20)
CreateBorder(ToggleBtn)
MakeDraggable(ToggleBtn)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then _G.Config.MenuOpen = not _G.Config.MenuOpen; MainFrame.Visible = _G.Config.MenuOpen end
end)

-- Main Menu
local MainFrame=Instance.new("Frame",ScreenGui)
MainFrame.Size=UDim2.new(0,400,0,310); MainFrame.Position=UDim2.new(0,70,0.2,0)
MainFrame.BackgroundColor3=Color3.fromRGB(18,18,18); MainFrame.Visible=false
Instance.new("UICorner",MainFrame).CornerRadius=UDim.new(0,20)
CreateBorder(MainFrame)

-- Nút Reset
local ResetBtn=Instance.new("TextButton",MainFrame)
ResetBtn.Size=UDim2.new(0,36,0,32); ResetBtn.Position=UDim2.new(0,12,0,7)
ResetBtn.Text="" 
ResetBtn.BackgroundColor3=Color3.new(1,1,1)
Instance.new("UICorner",ResetBtn).CornerRadius=UDim.new(0,16)
ApplyToggleGradient(ResetBtn, false)
CreateBorder(ResetBtn)
CreateButtonText(ResetBtn, "RST", Enum.Font.GothamBold, 13)

ResetBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            while char.Humanoid.Health > 0 and char.Parent do char.Humanoid.Health = 0; task.wait(0.1) end
        end
    end)
end)

local Title=Instance.new("TextLabel",MainFrame)
Title.Size=UDim2.new(1,-70,0,45); Title.Position=UDim2.new(0,60,0,0)
Title.Text="ARIS HUB V53 PRO"; Title.Font=Enum.Font.GothamBlack; Title.TextSize=20
Title.BackgroundTransparency=1; Title.TextXAlignment=Enum.TextXAlignment.Left
CreateTextGradient(Title)
MakeDraggable(MainFrame) 

ToggleBtn.MouseButton1Click:Connect(function() _G.Config.MenuOpen=not _G.Config.MenuOpen; MainFrame.Visible=_G.Config.MenuOpen end)

local TabFrame=Instance.new("Frame",MainFrame)
TabFrame.Size=UDim2.new(1,-10,0,35); TabFrame.Position=UDim2.new(0,5,0,45); TabFrame.BackgroundTransparency=1
local Tabs={"ESP","Hitbox","Misc","NPC"}
local ContentFrames={}

local tabListLayout = Instance.new("UIListLayout", TabFrame)
tabListLayout.FillDirection = Enum.FillDirection.Horizontal; tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabListLayout.Padding = UDim.new(0, 6); tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

for i,tab in ipairs(Tabs)do
    local btn=Instance.new("TextButton",TabFrame)
    btn.Size=UDim2.new(0.25, -6, 1, 0); btn.Text=""
    btn.BackgroundColor3=Color3.new(1,1,1)
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,16)
    ApplyToggleGradient(btn, false)
    CreateBorder(btn)
    CreateButtonText(btn, tab, Enum.Font.GothamBold, 13)

    local content=Instance.new("ScrollingFrame",MainFrame)
    content.Size=UDim2.new(1,-10,1,-95); content.Position=UDim2.new(0,5,0,85)
    content.BackgroundTransparency=1; content.ScrollBarThickness=5; content.Visible=false; content.BorderSizePixel=0
    local list=Instance.new("UIListLayout",content)
    list.Padding=UDim.new(0,8); list.SortOrder=Enum.SortOrder.LayoutOrder
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15) end)
    local pad=Instance.new("UIPadding",content); pad.PaddingLeft=UDim.new(0,5); pad.PaddingTop=UDim.new(0,5)

    ContentFrames[tab]={Frame=content}
    btn.MouseButton1Click:Connect(function() for _,f in pairs(ContentFrames)do f.Frame.Visible=false end; content.Visible=true end)
end
ContentFrames["ESP"].Frame.Visible=true

local function AddToggle(tab,name,key,cb)
    local content=ContentFrames[tab].Frame
    local btn=Instance.new("TextButton",content)
    btn.Size=UDim2.new(1,-16,0,36); btn.Text=""
    btn.BackgroundColor3=Color3.new(1,1,1)
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,20)
    
    ApplyToggleGradient(btn, _G.Config[key])
    CreateBorder(btn)
    local btnTxt = CreateButtonText(btn, name..": "..(_G.Config[key]and"ON"or"OFF"), Enum.Font.GothamBold, 14)
    
    btn.MouseButton1Click:Connect(function()
        _G.Config[key]=not _G.Config[key]
        btnTxt.Text=name..": "..(_G.Config[key]and"ON"or"OFF")
        ApplyToggleGradient(btn, _G.Config[key])
        if cb then cb(_G.Config[key])end
    end)
end

local function AddAdjust(tab,name,key,step)
    local content=ContentFrames[tab].Frame
    local frame=Instance.new("Frame",content)
    frame.Size=UDim2.new(1,-16,0,36); frame.BackgroundTransparency=1

    local label=Instance.new("TextLabel",frame)
    label.Size=UDim2.new(0.55,0,1,0); label.Position=UDim2.new(0.2,0,0,0)
    label.BackgroundTransparency=1; label.Text=name..": ".._G.Config[key]
    label.Font=Enum.Font.GothamBold; label.TextSize=14
    CreateTextGradient(label)

    local minus=Instance.new("TextButton",frame)
    minus.Size=UDim2.new(0.2,-5,1,0); minus.Text=""
    minus.BackgroundColor3=Color3.new(1,1,1)
    Instance.new("UICorner",minus).CornerRadius=UDim.new(0,20)
    ApplyToggleGradient(minus, false)
    CreateBorder(minus)
    local minusTxt = CreateButtonText(minus, "-", Enum.Font.GothamBold, 18)
    
    minus.MouseButton1Click:Connect(function()
        _G.Config[key]=math.max(step,_G.Config[key]-step); label.Text=name..": ".._G.Config[key]
    end)

    local plus=Instance.new("TextButton",frame)
    plus.Size=UDim2.new(0.2,-5,1,0); plus.Position=UDim2.new(0.8,5,0,0); plus.Text=""
    plus.BackgroundColor3=Color3.new(1,1,1)
    Instance.new("UICorner",plus).CornerRadius=UDim.new(0,20)
    ApplyToggleGradient(plus, false)
    CreateBorder(plus)
    local plusTxt = CreateButtonText(plus, "+", Enum.Font.GothamBold, 16)
    
    plus.MouseButton1Click:Connect(function()
        _G.Config[key]=_G.Config[key]+step; label.Text=name..": ".._G.Config[key]
    end)
end

AddToggle("ESP","ESP NAME","ESP_Name_P")
AddToggle("ESP","ESP HEALTH","ESP_Health_P")
AddToggle("ESP","ESP DISTANCE","ESP_Distance_P")
AddToggle("ESP","ESP BOX 2D","ESP_Box_P")
AddToggle("ESP","ESP CHAMS","ESP_Chams_P")

AddToggle("Hitbox","HITBOX PLAYER","Hitbox_P")
AddAdjust("Hitbox","HITBOX SIZE","HitboxSize",10)
AddToggle("Hitbox","SHOW HITBOX BOX 3D","Hitbox_Box")
AddToggle("Hitbox","HITBOX WALL CHECK","Hitbox_WallCheck")

AddToggle("Misc","HIỆN NÚT ẢNH MỞ MENU","Show_ToggleBtn", function(val) ToggleBtn.Visible = val end)
AddToggle("Misc","TEAM CHECK (ESP + HB)","TeamCheck")
AddToggle("Misc","LOW HP KS (<30%)","LowHP_KS")

-- UI WALKSPEED MỤC MISC
local MiscContent = ContentFrames["Misc"].Frame
local WSContainer = Instance.new("Frame", MiscContent)
WSContainer.Size = UDim2.new(1, 0, 0, 115); WSContainer.BackgroundTransparency = 1

local WSToggle = Instance.new("TextButton", WSContainer)
WSToggle.Size = UDim2.new(1, -16, 0, 36); WSToggle.Text = ""
WSToggle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSToggle).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSToggle, _G.Config.WalkSpeedEnabled)
CreateBorder(WSToggle)
local WSToggleTxt = CreateButtonText(WSToggle, "WALKSPEED: OFF", Enum.Font.GothamBold, 14)

local WSSliderBg = Instance.new("Frame", WSContainer)
WSSliderBg.Size = UDim2.new(1, -16, 0, 25); WSSliderBg.Position = UDim2.new(0, 0, 0, 48)
WSSliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", WSSliderBg).CornerRadius = UDim.new(0, 20)

local WSSliderFill = Instance.new("Frame", WSSliderBg)
WSSliderFill.Size = UDim2.new((_G.Config.WalkSpeed - 16) / (250 - 16), 0, 1, 0)
WSSliderFill.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSSliderFill).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSSliderFill, true)

local WSValLabel = Instance.new("TextLabel", WSSliderBg)
WSValLabel.Size = UDim2.new(1, 0, 1, 0); WSValLabel.BackgroundTransparency = 1
WSValLabel.Text = "Speed: " .. _G.Config.WalkSpeed
WSValLabel.Font = Enum.Font.GothamBold; WSValLabel.TextSize = 12
CreateTextGradient(WSValLabel)

local WSBtnFrame = Instance.new("Frame", WSContainer)
WSBtnFrame.Size = UDim2.new(1, -16, 0, 32); WSBtnFrame.Position = UDim2.new(0, 0, 0, 82)
WSBtnFrame.BackgroundTransparency = 1

local btnW = 0.22; local gap = 0.04
local function createWSBtn(text, posScale)
    local btn = Instance.new("TextButton", WSBtnFrame)
    btn.Size = UDim2.new(btnW, 0, 1, 0); btn.Position = UDim2.new(posScale, 0, 0, 0)
    btn.Text = ""; btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(btn, false); CreateBorder(btn)
    CreateButtonText(btn, text, Enum.Font.GothamBold, 14)
    return btn
end

local m10 = createWSBtn("-10", 0)
local m5 = createWSBtn("-5", btnW + gap)
local p5 = createWSBtn("+5", (btnW + gap) * 2)
local p10 = createWSBtn("+10", (btnW + gap) * 3)

local function UpdateWS(val)
    _G.Config.WalkSpeed = math.clamp(val, 16, 250)
    local ratio = (_G.Config.WalkSpeed - 16) / (250 - 16)
    WSSliderFill.Size = UDim2.new(ratio, 0, 1, 0)
    WSValLabel.Text = "Speed: " .. math.floor(_G.Config.WalkSpeed)
end

m10.MouseButton1Click:Connect(function() UpdateWS(_G.Config.WalkSpeed - 10) end)
m5.MouseButton1Click:Connect(function() UpdateWS(_G.Config.WalkSpeed - 5) end)
p5.MouseButton1Click:Connect(function() UpdateWS(_G.Config.WalkSpeed + 5) end)
p10.MouseButton1Click:Connect(function() UpdateWS(_G.Config.WalkSpeed + 10) end)

WSToggle.MouseButton1Click:Connect(function()
    _G.Config.WalkSpeedEnabled = not _G.Config.WalkSpeedEnabled
    WSToggleTxt.Text = "WALKSPEED: " .. (_G.Config.WalkSpeedEnabled and "ON" or "OFF")
    ApplyToggleGradient(WSToggle, _G.Config.WalkSpeedEnabled)
end)

local draggingWS = false
WSSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWS = true end
end)
WSSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWS = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingWS and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = math.clamp((input.Position.X - WSSliderBg.AbsolutePosition.X) / WSSliderBg.AbsoluteSize.X, 0, 1)
        UpdateWS(16 + relX * (250 - 16))
    end
end)

AddToggle("NPC","HITBOX NPC","Hitbox_NPC")
AddAdjust("NPC","HITBOX SIZE NPC","HitboxSize_NPC",10)
AddToggle("NPC","SHOW HITBOX BOX 3D","Hitbox_Box_NPC")
AddToggle("NPC","ESP NPC NAME","ESP_NPC_Name")
AddToggle("NPC","ESP NPC CHAMS","ESP_NPC_Chams")

local ESP_Store={}
local NPC_Store={}
local CachedNPCs = {}

local function CheckAndCacheNPC(obj)
    if obj:IsA("Model") and obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then CachedNPCs[obj] = true end
    end
end

for _, v in ipairs(Workspace:GetDescendants()) do CheckAndCacheNPC(v) end
Workspace.DescendantAdded:Connect(function(descendant)
    task.delay(1, function() if descendant.Parent then CheckAndCacheNPC(descendant) end end)
end)

local function RestoreHRP(hrp)
    if hrp and hrp:GetAttribute("ArisOrigSizeX") then
        hrp.Size = Vector3.new(hrp:GetAttribute("ArisOrigSizeX"), hrp:GetAttribute("ArisOrigSizeY"), hrp:GetAttribute("ArisOrigSizeZ"))
        hrp.Transparency = hrp:GetAttribute("ArisOrigTrans")
        hrp.CanCollide = hrp:GetAttribute("ArisOrigCollide")
        if hrp:GetAttribute("ArisOrigMassless") ~= nil then hrp.Massless = hrp:GetAttribute("ArisOrigMassless") end
    end
end

local function GetHealthColor(pct)
    if pct>0.7 then return Color3.new(0,1,0) elseif pct>0.5 then return Color3.new(1,1,0) elseif pct>0.3 then return Color3.new(1,0.5,0) else return Color3.new(1,0,0)end
end

local function CleanupESP(playerName)
    if ESP_Store[playerName]then
        pcall(function() if ESP_Store[playerName].BoxBill then ESP_Store[playerName].BoxBill:Destroy() end; if ESP_Store[playerName].TextBill then ESP_Store[playerName].TextBill:Destroy() end end)
        ESP_Store[playerName]=nil
    end
    local p = Players:FindFirstChild(playerName)
    if p and p.Character then
        if p.Character:FindFirstChild("ArisHL") then p.Character.ArisHL:Destroy() end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if hrp then if hrp:FindFirstChild("ArisHitboxBox") then hrp.ArisHitboxBox:Destroy() end; RestoreHRP(hrp) end
    end
end

local function CleanupNPC(m)
    if NPC_Store[m]then
        pcall(function() if NPC_Store[m].Bill then NPC_Store[m].Bill:Destroy() end end); NPC_Store[m]=nil
    end
    if m then
        if m:FindFirstChild("ArisHL_NPC") then m.ArisHL_NPC:Destroy() end
        local hrp = m:FindFirstChild("HumanoidRootPart")
        if hrp then if hrp:FindFirstChild("ArisHitboxBoxNPC") then hrp.ArisHitboxBoxNPC:Destroy() end; RestoreHRP(hrp) end
    end
end

Workspace.DescendantRemoving:Connect(function(descendant)
    if CachedNPCs[descendant] then CachedNPCs[descendant] = nil; CleanupNPC(descendant) end
end)

RunService.RenderStepped:Connect(function()
    if _G.Config.WalkSpeedEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = _G.Config.WalkSpeed end
    end
end)

-- ==========================================
-- ĐỘNG CƠ RENDER (HEARTBEAT) - TÍNH TOÁN DÒNG CHẢY
-- ==========================================
RunService.Heartbeat:Connect(function()
    local rgb=GetRGB() 
    
    -- Tốc độ dòng chảy (Chậm rãi, nhẹ nhàng, lững lờ trôi)
    local shift = tick() * 0.15 
    
    -- Sinh ra Sequence toán học cho từng Frame để loại bỏ hiện tượng giật lặp
    local seqOn = GetMovingColorSequence(Palettes.On, shift)
    local seqOff = GetMovingColorSequence(Palettes.Off, shift)
    local seqText = GetMovingColorSequence(Palettes.Text, shift * 1.5)
    local seqBorder = GetMovingColorSequence(Palettes.Border, shift * 1.8)

    for _, grad in ipairs(UIGradientList) do grad.Color = seqBorder end
    for _, grad in ipairs(TextGradientList) do grad.Color = seqText end
    for _, grad in ipairs(BtnGradientList) do 
        if grad.Parent and grad.Parent:GetAttribute("IsOn") then
            grad.Color = seqOn
        else
            grad.Color = seqOff
        end
    end

    local myRoot=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local hasLowHPEnemy = false
    if _G.Config.Hitbox_P and _G.Config.LowHP_KS and myRoot then
        for _, p in Players:GetPlayers() do
            if p == LocalPlayer then continue end
            if _G.Config.TeamCheck and p.Team == LocalPlayer.Team then continue end
            local char = p.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if char and hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - myRoot.Position).Magnitude
                if dist <= 2000 and (hum.Health / hum.MaxHealth) <= 0.3 then hasLowHPEnemy = true; break end
            end
        end
    end

    -- PLAYER LOOP
    for _,p in Players:GetPlayers()do
        if p==LocalPlayer then continue end
        local char=p.Character
        local hrp=char and char:FindFirstChild("HumanoidRootPart")
        local hum=char and char:FindFirstChild("Humanoid")
        local isTeammate = (_G.Config.TeamCheck and p.Team ~= nil and p.Team == LocalPlayer.Team)

        if not char or not hrp or not hum or hum.Health<=0 or isTeammate then
            if hrp then RestoreHRP(hrp) end; CleanupESP(p.Name); continue
        end

        local hp_percent = hum.Health / hum.MaxHealth
        local dist = myRoot and (hrp.Position - myRoot.Position).Magnitude or math.huge
        local enableHitbox = false
        
        if _G.Config.Hitbox_P then
            if _G.Config.LowHP_KS then
                if hasLowHPEnemy then if hp_percent <= 0.3 then enableHitbox = true end
                else if dist <= 2000 then enableHitbox = true end end
            else enableHitbox = true end
        end

        if enableHitbox then
            local valid = true
            if _G.Config.Hitbox_WallCheck then
                local rp = RaycastParams.new(); rp.FilterDescendantsInstances = {LocalPlayer.Character}; rp.FilterType = Enum.RaycastFilterType.Exclude
                local rr = Workspace:Raycast(Camera.CFrame.Position, (hrp.Position - Camera.CFrame.Position), rp)
                if rr and rr.Instance and not rr.Instance:IsDescendantOf(char) then valid = false end
            end

            if valid then
                if not hrp:GetAttribute("ArisOrigSizeX") then
                    hrp:SetAttribute("ArisOrigSizeX", hrp.Size.X); hrp:SetAttribute("ArisOrigSizeY", hrp.Size.Y); hrp:SetAttribute("ArisOrigSizeZ", hrp.Size.Z)
                    hrp:SetAttribute("ArisOrigTrans", hrp.Transparency); hrp:SetAttribute("ArisOrigCollide", hrp.CanCollide); hrp:SetAttribute("ArisOrigMassless", hrp.Massless)
                end
                hrp.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                hrp.Transparency = 0.6; hrp.CanCollide = false; hrp.Massless = true 
            else RestoreHRP(hrp) end
        else RestoreHRP(hrp) end

        local hl = char:FindFirstChild("ArisHL")
        if _G.Config.ESP_Chams_P then
            if not hl then hl = Instance.new("Highlight", char); hl.Name = "ArisHL" end
            hl.FillColor = rgb; hl.Enabled = true
        else if hl then hl:Destroy() end end

        local hbBox = hrp:FindFirstChild("ArisHitboxBox")
        if enableHitbox and _G.Config.Hitbox_Box then
            if not hbBox then hbBox = Instance.new("SelectionBox", hrp); hbBox.Name = "ArisHitboxBox"; hbBox.Adornee = hrp end
            hbBox.SurfaceColor3 = rgb
        else if hbBox then hbBox:Destroy() end end

        if _G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P or _G.Config.ESP_Box_P then
            if not ESP_Store[p.Name] then
                local boxBill = Instance.new("BillboardGui", ScreenGui); boxBill.Size = UDim2.new(4,0,5.5,0); boxBill.AlwaysOnTop = true
                local outF = Instance.new("Frame", boxBill); outF.Size = UDim2.new(1,0,1,0); outF.BackgroundTransparency = 1
                Instance.new("UICorner", outF).CornerRadius = UDim.new(0, 6)
                local outS = Instance.new("UIStroke", outF); outS.Color = Color3.new(0,0,0); outS.Thickness = 3
                local inF = Instance.new("Frame", boxBill); inF.Size = UDim2.new(1,0,1,0); inF.BackgroundTransparency = 1
                Instance.new("UICorner", inF).CornerRadius = UDim.new(0, 6)
                local inS = Instance.new("UIStroke", inF); inS.Thickness = 1.2
                local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0,200,0,60); textB.StudsOffset = Vector3.new(0,3.5,0); textB.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                ESP_Store[p.Name]={BoxBill=boxBill, InStroke=inS, TextBill=textB, Text=txt, OutFrame=outF, InFrame=inF}
            end
            local s=ESP_Store[p.Name]
            s.BoxBill.Adornee = hrp; s.TextBill.Adornee = char:FindFirstChild("Head") or hrp
            s.BoxBill.Enabled=_G.Config.ESP_Box_P; s.InStroke.Color=rgb
            s.Text.Text=table.concat({_G.Config.ESP_Name_P and p.Name or "", _G.Config.ESP_Health_P and ("HP: "..math.floor(hum.Health)) or "", _G.Config.ESP_Distance_P and (dist ~= math.huge) and ("Dist: "..math.floor(dist).."m") or ""}, "\n")
            s.Text.TextColor3=GetHealthColor(hp_percent)
            s.TextBill.Enabled = (_G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P)
        else CleanupESP(p.Name) end
    end

    -- NPC LOOP
    for obj in pairs(CachedNPCs) do
        if not obj.Parent then CachedNPCs[obj] = nil; CleanupNPC(obj); continue end

        local hum = obj:FindFirstChild("Humanoid")
        local hrp = obj:FindFirstChild("HumanoidRootPart")
        
        if hum and hrp and hum.Health > 0 then
            if _G.Config.Hitbox_NPC then
                if not hrp:GetAttribute("ArisOrigSizeX") then
                    hrp:SetAttribute("ArisOrigSizeX", hrp.Size.X); hrp:SetAttribute("ArisOrigSizeY", hrp.Size.Y); hrp:SetAttribute("ArisOrigSizeZ", hrp.Size.Z)
                    hrp:SetAttribute("ArisOrigTrans", hrp.Transparency); hrp:SetAttribute("ArisOrigCollide", hrp.CanCollide); hrp:SetAttribute("ArisOrigMassless", hrp.Massless)
                end
                hrp.Size = Vector3.new(_G.Config.HitboxSize_NPC, _G.Config.HitboxSize_NPC, _G.Config.HitboxSize_NPC)
                hrp.Transparency = 0.6; hrp.CanCollide = false; hrp.Massless = true
            else RestoreHRP(hrp) end

            local hbBoxNPC = hrp:FindFirstChild("ArisHitboxBoxNPC")
            if _G.Config.Hitbox_NPC and _G.Config.Hitbox_Box_NPC then
                if not hbBoxNPC then hbBoxNPC = Instance.new("SelectionBox", hrp); hbBoxNPC.Name = "ArisHitboxBoxNPC"; hbBoxNPC.Adornee = hrp end
                hbBoxNPC.SurfaceColor3 = rgb
            else if hbBoxNPC then hbBoxNPC:Destroy() end end

            local hlNPC = obj:FindFirstChild("ArisHL_NPC")
            if _G.Config.ESP_NPC_Chams then
                if not hlNPC then hlNPC = Instance.new("Highlight", obj); hlNPC.Name = "ArisHL_NPC" end
                hlNPC.FillColor = rgb; hlNPC.Enabled = true
            else if hlNPC then hlNPC:Destroy() end end

            if _G.Config.ESP_NPC_Name then
                if not NPC_Store[obj] then
                    local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0, 200, 0, 60); textB.StudsOffset = Vector3.new(0, 3.5, 0); textB.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                    txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                    NPC_Store[obj] = {Bill = textB, Text = txt}
                end
                NPC_Store[obj].Bill.Adornee = obj:FindFirstChild("Head") or hrp
                NPC_Store[obj].Text.Text = "NPC: " .. obj.Name .. "\nHP: " .. math.floor(hum.Health)
                NPC_Store[obj].Text.TextColor3 = rgb
            else
                if NPC_Store[obj] then NPC_Store[obj].Bill:Destroy(); NPC_Store[obj] = nil end
            end
        else CleanupNPC(obj) end
    end
end)

Players.PlayerRemoving:Connect(function(p) CleanupESP(p.Name) end)
