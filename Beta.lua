-- DỊCH VỤ HỆ THỐNG
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

-- THÔNG BÁO
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title="ARIS HUB V57.2 PRO - DASH",
    Text="Ghosting fixed + Reduce Lag + Smart Hitbox + Auto Dash V4",
    Duration=6
})

-- CẤU HÌNH GỐC
_G.Config = {
    TeamCheck = true,
    ShowPushBtn = true,
    ESP_Box_P = false, ESP_Name_P = true, ESP_Health_P = true, ESP_Chams_P = true, ESP_Distance_P = true,
    Hitbox_P = false, HitboxSize = 15, SmartHitbox = true,
    Hitbox_NPC = false, HitboxSize_NPC = 15,
    ESP_NPC_Chams = false, ESP_NPC_Box = false,
    JumpForce = 150, Fullbright = false, ReduceLag = false, AutoDash = false, MenuOpen = false
}

-- DỌN DẸP UI CŨ
if CoreGui:FindFirstChild("ArisHUB_PRO") then CoreGui.ArisHUB_PRO:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local RainbowList = {}
local function GetRGB() return Color3.fromHSV(tick() % 5 / 5, 1, 1) end

-- ==========================================
-- PHẦN 1: XÂY DỰNG GIAO DIỆN HUB
-- ==========================================
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
ToggleBtn.Text = "UI"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 12)
local ts = Instance.new("UIStroke", ToggleBtn)
ts.Thickness = 3
table.insert(RainbowList, ts)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 450)
MainFrame.Position = UDim2.new(0, 70, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", MainFrame)
ms.Thickness = 3
table.insert(RainbowList, ms)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.Config.MenuOpen = not _G.Config.MenuOpen
    MainFrame.Visible = _G.Config.MenuOpen
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ARIS HUB V57.2 PRO"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.BackgroundTransparency = 1
table.insert(RainbowList, Title)

-- TABS
local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundTransparency = 1

local Tabs = {"ESP", "Hitbox", "Misc", "Visual"}
local ContentFrames = {}
local CurrentTab = "ESP"

for i, tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton", TabFrame)
    btn.Size = UDim2.new(0.25, 0, 1, 0)
    btn.Position = UDim2.new((i-1)*0.25, 0, 0, 0)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    table.insert(RainbowList, btn)
    
    local content = Instance.new("ScrollingFrame", MainFrame)
    content.Size = UDim2.new(1, -10, 1, -90)
    content.Position = UDim2.new(0, 5, 0, 80)
    content.BackgroundTransparency = 1
    content.CanvasSize = UDim2.new(0, 0, 0, 750)
    content.Visible = (tabName == CurrentTab)
    ContentFrames[tabName] = {Frame = content, Y = 10}
    
    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(ContentFrames) do f.Frame.Visible = false end
        content.Visible = true
        CurrentTab = tabName
    end)
end

local function AddToggle(tab, name, key)
    local y = ContentFrames[tab].Y
    local btn = Instance.new("TextButton", ContentFrames[tab].Frame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    Instance.new("UICorner", btn)
    table.insert(RainbowList, btn)
    btn.MouseButton1Click:Connect(function()
        _G.Config[key] = not _G.Config[key]
        btn.Text = name .. ": " .. (_G.Config[key] and "ON" or "OFF")
        btn.BackgroundColor3 = _G.Config[key] and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 40, 40)
        
        if key == "ReduceLag" and _G.Config[key] then
            optimizeAll()
        end
        if key == "AutoDash" then
            DashButton.Visible = _G.Config[key]
            ToggleDashMenu.Visible = _G.Config[key]
            MenuDashFrame.Visible = _G.Config[key] and MenuDashFrame.Visible or false
        end
    end)
    ContentFrames[tab].Y = y + 40
end

local function AddAdjust(tab, name, key, step)
    local y = ContentFrames[tab].Y
    local f = Instance.new("Frame", ContentFrames[tab].Frame)
    f.Size = UDim2.new(1, -20, 0, 35)
    f.Position = UDim2.new(0, 10, 0, y)
    f.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.6, 0, 1, 0)
    l.Position = UDim2.new(0.2, 0, 0, 0)
    l.Text = name .. ": " .. _G.Config[key]
    l.BackgroundTransparency = 1
    table.insert(RainbowList, l)
    local m = Instance.new("TextButton", f)
    m.Size = UDim2.new(0.2, -5, 1, 0)
    m.Text = "-"
    m.MouseButton1Click:Connect(function() 
        _G.Config[key] = math.max(1, _G.Config[key]-step); 
        l.Text = name..": ".._G.Config[key] 
    end)
    local p = Instance.new("TextButton", f)
    p.Size = UDim2.new(0.2, -5, 1, 0)
    p.Position = UDim2.new(0.8, 5, 0, 0)
    p.Text = "+"
    p.MouseButton1Click:Connect(function() 
        _G.Config[key] = _G.Config[key]+step; 
        l.Text = name..": ".._G.Config[key] 
    end)
    ContentFrames[tab].Y = y + 40
end

-- THÊM NÚT VÀO MENU
AddToggle("ESP", "ESP BOX (P)", "ESP_Box_P")
AddToggle("ESP", "ESP NAME (P)", "ESP_Name_P")
AddToggle("ESP", "ESP HEALTH (P)", "ESP_Health_P")
AddToggle("ESP", "ESP DISTANCE (P)", "ESP_Distance_P")
AddToggle("ESP", "ESP CHAMS (P)", "ESP_Chams_P")

AddToggle("Hitbox", "HITBOX PLAYER", "Hitbox_P")
AddAdjust("Hitbox", "SIZE PLAYER", "HitboxSize", 5)
AddToggle("Hitbox", "SMART HITBOX", "SmartHitbox")
AddToggle("Hitbox", "HITBOX NPC", "Hitbox_NPC")
AddAdjust("Hitbox", "SIZE NPC", "HitboxSize_NPC", 5)

AddToggle("Visual", "ESP CHAMS NPC", "ESP_NPC_Chams")
AddToggle("Visual", "ESP BOX NPC", "ESP_NPC_Box")
AddToggle("Visual", "SHOW PUSH BTN", "ShowPushBtn")

AddToggle("Misc", "TEAM CHECK", "TeamCheck")
AddToggle("Misc", "FULLBRIGHT", "Fullbright")
AddToggle("Misc", "REDUCE LAG", "ReduceLag")
AddToggle("Misc", "AUTO DASH", "AutoDash")  -- Nút mới cho Dash

-- ==========================================
-- REDUCE LAG (giữ nguyên)
-- ==========================================
local CONCRETE_COLOR = Color3.fromRGB(170,170,170)

local function optimize(obj)
    if not obj then return end
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then obj.Enabled = false end
    if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then obj.Brightness = obj.Brightness * 0.4; obj.Range = obj.Range * 0.6 end
    if obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 end
    if obj:IsA("SurfaceAppearance") then obj:Destroy() end
    if obj:IsA("SpecialMesh") then obj.TextureId = "" end
    if obj:IsA("MeshPart") then pcall(function() obj.TextureID = "" end) end
    if obj:IsA("BasePart") then pcall(function() obj.Material = Enum.Material.Plastic obj.Color = CONCRETE_COLOR obj.Reflectance = 0.05 obj.CastShadow = true end) end
end

local optimizeConnection
local function optimizeAll()
    for _, v in ipairs(game:GetDescendants()) do optimize(v) end
    if not optimizeConnection then optimizeConnection = game.DescendantAdded:Connect(optimize) end
end

task.spawn(function()
    while true do
        task.wait(8)
        if _G.Config.ReduceLag then optimizeAll() end
    end
end)

-- ==========================================
-- AUTO DASH V4 (tích hợp)
-- ==========================================
local dashPower = 300
local dashDuration = 0.25
local buttonSize = 75
local canDash = true

local DashButton = Instance.new("ImageButton", ScreenGui)
DashButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DashButton.Size = UDim2.new(0, buttonSize, 0, buttonSize)
DashButton.Position = UDim2.new(0.85, 0, 0.65, 0)
DashButton.AnchorPoint = Vector2.new(0.5, 0.5)
DashButton.ZIndex = 100
DashButton.Visible = _G.Config.AutoDash
Instance.new("UICorner", DashButton).CornerRadius = UDim.new(1, 0)
local DashStroke = Instance.new("UIStroke", DashButton)
DashStroke.Thickness = 4
DashStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
table.insert(RainbowList, DashStroke)  -- Đồng bộ rainbow với hub

local BtnText = Instance.new("TextLabel", DashButton)
BtnText.Size = UDim2.new(1, 0, 1, 0)
BtnText.BackgroundTransparency = 1
BtnText.Text = "DASH"
BtnText.TextColor3 = Color3.new(1, 1, 1)
BtnText.Font = Enum.Font.GothamBlack
BtnText.TextSize = 16

local ToggleDashMenu = Instance.new("TextButton", ScreenGui)
ToggleDashMenu.Size = UDim2.new(0, 40, 0, 40)
ToggleDashMenu.Position = UDim2.new(0.05, 0, 0.5, -20)
ToggleDashMenu.Text = "⚙"
ToggleDashMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleDashMenu.TextColor3 = Color3.new(1,1,1)
ToggleDashMenu.Font = Enum.Font.GothamBold
ToggleDashMenu.TextSize = 24
ToggleDashMenu.Visible = _G.Config.AutoDash
Instance.new("UICorner", ToggleDashMenu).CornerRadius = UDim.new(0, 12)

local MenuDashFrame = Instance.new("Frame", ScreenGui)
MenuDashFrame.Size = UDim2.new(0, 240, 0, 280)
MenuDashFrame.Position = UDim2.new(0.5, -120, 0.5, -140)
MenuDashFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MenuDashFrame.Visible = false
Instance.new("UICorner", MenuDashFrame).CornerRadius = UDim.new(0, 12)

local DashTitle = Instance.new("TextLabel", MenuDashFrame)
DashTitle.Size = UDim2.new(1, 0, 0, 40)
DashTitle.BackgroundTransparency = 1
DashTitle.Text = "DASH SETTINGS"
DashTitle.TextColor3 = Color3.fromRGB(255, 100, 150)
DashTitle.Font = Enum.Font.GothamBlack
DashTitle.TextSize = 20

local function CreateDashSlider(name, min, max, default, yPos, callback)
    local Label = Instance.new("TextLabel", MenuDashFrame)
    Label.Size = UDim2.new(1, -20, 0, 25)
    Label.Position = UDim2.new(0, 10, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name .. ": " .. default
    Label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Back = Instance.new("Frame", MenuDashFrame)
    Back.Size = UDim2.new(0.9, 0, 0, 8)
    Back.Position = UDim2.new(0.05, 0, 0, yPos + 28)
    Back.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", Back).CornerRadius = UDim.new(1,0)

    local Fill = Instance.new("Frame", Back)
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 80, 120)
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1,0)

    local dragging = false

    local function update(input)
        local relX = math.clamp((input.Position.X - Back.AbsolutePosition.X) / Back.AbsoluteSize.X, 0, 1)
        Fill.Size = UDim2.new(relX, 0, 1, 0)
        local value = min + (max - min) * relX
        value = (max <= 1 and math.floor(value * 100)/100) or math.floor(value)
        Label.Text = name .. ": " .. value
        callback(value)
    end

    Back.InputBegan:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            dragging = true 
            update(i) 
        end 
    end)
    UserInputService.InputChanged:Connect(function(i) 
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
            update(i) 
        end 
    end)
    UserInputService.InputEnded:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
            dragging = false 
        end 
    end)
end

CreateDashSlider("Sức mạnh lướt", 100, 800, dashPower, 50, function(v) dashPower = v end)
CreateDashSlider("Vị trí nút X", 0, 1, 0.85, 120, function(v) DashButton.Position = UDim2.new(v, 0, DashButton.Position.Y.Scale, 0) end)
CreateDashSlider("Vị trí nút Y", 0, 1, 0.65, 190, function(v) DashButton.Position = UDim2.new(DashButton.Position.X.Scale, 0, v, 0) end)

ToggleDashMenu.MouseButton1Click:Connect(function()
    MenuDashFrame.Visible = not MenuDashFrame.Visible
end)

-- Kéo thả ToggleDashMenu
local draggingDash, dragStartDash, startPosDash
ToggleDashMenu.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingDash = true
        dragStartDash = input.Position
        startPosDash = ToggleDashMenu.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingDash and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartDash
        ToggleDashMenu.Position = UDim2.new(startPosDash.X.Scale, startPosDash.X.Offset + delta.X, startPosDash.Y.Scale, startPosDash.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingDash = false
    end
end)

-- Logic Dash
local function PerformDash()
    if not canDash or not _G.Config.AutoDash then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end

    canDash = false
    TweenService:Create(DashButton, TweenInfo.new(0.1), {Size = UDim2.new(0, buttonSize-10, 0, buttonSize-10)}):Play()

    local direction = Camera.CFrame.LookVector
    local attachment = Instance.new("Attachment", root)
    local lv = Instance.new("LinearVelocity", root)
    lv.MaxForce = 999999999
    lv.Attachment0 = attachment
    lv.VectorVelocity = direction * dashPower

    task.spawn(function()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part ~= root then
                TweenService:Create(part, TweenInfo.new(0.15), {LocalTransparencyModifier = 0.4}):Play()
            end
        end
    end)

    task.delay(dashDuration, function()
        lv:Destroy()
        attachment:Destroy()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.LocalTransparencyModifier = 0 end
        end
        TweenService:Create(DashButton, TweenInfo.new(0.2), {Size = UDim2.new(0, buttonSize, 0, buttonSize)}):Play()
        canDash = true
    end)
end

DashButton.MouseButton1Click:Connect(PerformDash)
DashButton.TouchTap:Connect(PerformDash)

-- ==========================================
-- LOGIC CORE (ESP + HITBOX + CHAMS + NPC) - giữ nguyên từ trước
-- ==========================================
local Player_ESP_Cache = {}
local NPC_Cache = {}

local function RemovePlayerESP(p)
    if Player_ESP_Cache[p] then
        if Player_ESP_Cache[p].Box then Player_ESP_Cache[p].Box:Destroy() end
        if Player_ESP_Cache[p].Bill then Player_ESP_Cache[p].Bill:Destroy() end
        Player_ESP_Cache[p] = nil
    end
end

Players.PlayerRemoving:Connect(function(player)
    RemovePlayerESP(player)
end)

local function onCharacterAdded(char, player)
    RemovePlayerESP(player)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(char) onCharacterAdded(char, p) end)
        if p.Character then onCharacterAdded(p.Character, p) end
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(char) onCharacterAdded(char, p) end)
    end
end)

task.spawn(function()
    while true do
        local tempNPC = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                if not Players:GetPlayerFromCharacter(v) and v.Humanoid.Health > 0 then
                    tempNPC[v] = true
                end
            end
        end
        NPC_Cache = tempNPC
        task.wait(3)
    end
end)

task.spawn(function()
    while true do
        task.wait(12)
        for player, _ in pairs(Player_ESP_Cache) do
            if not player.Parent or not player.Character or not player.Character.Parent then
                RemovePlayerESP(player)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local rgb = GetRGB()
    
    for _, v in pairs(RainbowList) do
        if v:IsA("UIStroke") then v.Color = rgb
        elseif v:IsA("TextLabel") or v:IsA("TextButton") then v.TextColor3 = rgb end
    end
    
    if _G.Config.Fullbright then 
        Lighting.Brightness = 2 
        Lighting.ClockTime = 14 
    end

    local playerRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        
        local char = p.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        
        if not char or not char.Parent or not hrp or not hrp.Parent or not hum or hum.Health <= 0 
           or not p.Parent 
           or (_G.Config.TeamCheck and p.Team == LocalPlayer.Team) then
           
            RemovePlayerESP(p)
            if hrp and hrp.Parent and hrp.Size.X > 5 then
                hrp.Size = Vector3.new(2,2,1)
                hrp.Transparency = 1
                hrp.CanCollide = true
            end
            continue
        end

        if not Player_ESP_Cache[p] then
            local b = Instance.new("BoxHandleAdornment")
            b.Parent = ScreenGui
            b.AlwaysOnTop = true
            b.ZIndex = 10
            
            local bl = Instance.new("BillboardGui")
            bl.Parent = ScreenGui
            bl.Size = UDim2.new(0,200,0,60)
            bl.AlwaysOnTop = true
            
            local t = Instance.new("TextLabel", bl)
            t.Size = UDim2.new(1,0,1,0)
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamBold
            t.TextSize = 12
            
            Player_ESP_Cache[p] = {Box = b, Bill = bl, Text = t}
        end

        local esp = Player_ESP_Cache[p]
        esp.Box.Adornee = hrp
        esp.Box.Visible = _G.Config.ESP_Box_P
        esp.Box.Color3 = rgb
        esp.Box.Size = hrp.Size
        
        esp.Bill.Adornee = char:FindFirstChild("Head") or hrp
        esp.Bill.Enabled = true
        
        local d = math.floor((playerRoot and (playerRoot.Position - hrp.Position).Magnitude) or 0)
        esp.Text.Text = string.format("%s\n%s\n%s", 
            (_G.Config.ESP_Name_P and p.Name or ""),
            (_G.Config.ESP_Health_P and "HP: "..math.floor(hum.Health) or ""),
            (_G.Config.ESP_Distance_P and "Dist: "..d.."m" or "")
        )
        esp.Text.TextColor3 = Color3.fromHSV((hum.Health/hum.MaxHealth)*0.3, 1, 1)

        if _G.Config.Hitbox_P and playerRoot then
            loca
