local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title="ARIS HUB V53 PRO + DESYNC + TP",
    Text="Nạp thành công! Đã thêm bộ đếm FPS & Ping.",
    Duration=8
})

_G.Config={
    ESP_Box_P=true,
    ESP_Name_P=true,
    ESP_Health_P=true,
    ESP_Chams_P=true,
    ESP_Distance_P=true,
    Hitbox_P=false,
    HitboxSize=150,
    Hitbox_WallCheck=false,
    Hitbox_Box=false,
    TeamCheck=true,
    LowHP_KS=false,
    WalkSpeed=90,
    WalkSpeedEnabled=false,
    Show_Stats=true,
    Hitbox_NPC=false,
    HitboxSize_NPC=20,
    Hitbox_Box_NPC=false,
    ESP_NPC_Name=false,
    ESP_NPC_Box=false,
    ESP_NPC_Chams=false,
    TeamCheck_NPC=false,
    MenuOpen=false,
    Desync_HideAuto = false,
    Desync_ShowFloat = false,
    Desync_FloatX = 70,
    Desync_FloatY = 20,
    Desync_Mode = "Fix",
    TP_NPC = false,
    TP_Player = false,
    TP_Height = 15,
    TP_Speed = 500,
    BlacklistedNPCs = {}
}

local TempSkipNPC = {}
local ArisFakeBody = nil

if CoreGui:FindFirstChild("ArisHUB_PRO") then
    CoreGui.ArisHUB_PRO:Destroy()
end
if CoreGui:FindFirstChild("ArisFloatToggle") then
    CoreGui.ArisFloatToggle:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99999
ScreenGui.Parent = CoreGui

-- BẢNG FPS & PING (GÓC TRÊN TRÁI)
local StatsFrame = Instance.new("Frame", ScreenGui)
StatsFrame.Size = UDim2.new(0, 150, 0, 26)
StatsFrame.Position = UDim2.new(0, 15, 0, 15)
StatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatsFrame.BackgroundTransparency = 0.5
StatsFrame.BorderSizePixel = 0
StatsFrame.Visible = _G.Config.Show_Stats
Instance.new("UICorner", StatsFrame).CornerRadius = UDim.new(0, 6)

local StatsText = Instance.new("TextLabel", StatsFrame)
StatsText.Size = UDim2.new(1, 0, 1, 0)
StatsText.BackgroundTransparency = 1
StatsText.Text = "FPS: 0 | PING: 0ms"
StatsText.Font = Enum.Font.GothamBold
StatsText.TextSize = 13
StatsText.TextColor3 = Color3.new(1,1,1)

local StatsGrad = Instance.new("UIGradient", StatsText)
StatsGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200))
})

local FPS_Frames = 0
RunService.RenderStepped:Connect(function()
    FPS_Frames = FPS_Frames + 1
end)

task.spawn(function()
    while task.wait(1) do
        local ping = 0
        pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
        if ping == 0 then
            pcall(function()
                ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
        end
        if StatsFrame.Visible then
            StatsText.Text = string.format("FPS: %d  |  PING: %dms", FPS_Frames, ping)
        end
        FPS_Frames = 0
    end
end)

local UIGradientList = {}
local TextGradientList = {}
local BtnGradientList = {}
local ToggleButtons = {}
local AdjustLabels = {}

local function GetRGB()
    return Color3.fromHSV(tick() % 5 / 5, 1, 1)
end

local Palettes = {
    On = { Color3.fromRGB(0, 240, 255), Color3.fromRGB(130, 100, 255), Color3.fromRGB(255, 150, 255), Color3.fromRGB(0, 240, 255) },
    Off = { Color3.fromRGB(12, 12, 12), Color3.fromRGB(180, 20, 20), Color3.fromRGB(12, 12, 12) },
    Text = { Color3.fromRGB(0, 150, 255), Color3.fromRGB(255, 0, 150), Color3.fromRGB(0, 150, 255) },
    Border = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(15, 15, 15), Color3.fromRGB(255, 0, 0) }
}

local function GetMovingColorSequence(palette, shift)
    local keypoints = {}
    for step = 0, 5 do
        local i = step / 5
        local t = (i - shift) % 1
        if t < 0 then
            t = t + 1
        end
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
    parent:SetAttribute("IsOn", isOn)

    local txt = parent:FindFirstChildOfClass("TextLabel")
    if txt then
        local txtGrad = txt:FindFirstChildOfClass("UIGradient")
        if isOn then
            if txtGrad then txtGrad.Enabled = false end
            txt.TextColor3 = Color3.fromRGB(0, 0, 0) 
        else
            if txtGrad then txtGrad.Enabled = true end
            txt.TextColor3 = Color3.fromRGB(255, 255, 255) 
        end
    end
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

local function ApplyButtonAnimation(btn)
    local ts = game:GetService("TweenService")
    local scale = Instance.new("UIScale", btn) scale.Scale = 1
    btn.MouseEnter:Connect(function() ts:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
    btn.MouseLeave:Connect(function() ts:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.0}):Play() end)
    btn.MouseButton1Down:Connect(function() ts:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.9}):Play() end)
    btn.MouseButton1Up:Connect(function() ts:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
end

local desyncState = false
local replicatesignal = getgenv().replicatesignal or function(...) return ... end

local function ToggleDesync(state)
    pcall(function()
        if raknet and type(raknet.desync) == "function" then
            raknet.desync(state)
        end
    end)
end

local NumericFlags = {
    {"GameNetPVHeaderRotationalVelocityZeroCutoffExponent","-5000"},
    {"TimestepArbiterVelocityCriteriaThresholdTwoDt","2147483646"},
    {"S2PhysicsSenderRate","15000"},
    {"MaxDataPacketPerSend","2147483647"},
    {"PhysicsSenderMaxBandwidthBps","20000"},
    {"CheckPVCachedVelThresholdPercent","10"},
    {"MaxMissedWorldStepsRemembered","-2147483648"},
    {"StreamJobNOUVolumeLengthCap","2147483647"},
    {"WorldStepMax","30"},
    {"MaxAcceptableUpdateDelay","1"}
}

local AnimationLib = {}
function AnimationLib.CreateParticleEffect(position, color, duration)
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Anchored = true
    part.CanCollide = false
    part.Material = Enum.Material.Neon
    part.Color = color
    part.CFrame = CFrame.new(position)
    part.Transparency = 0.3
    part.Parent = workspace

    local light = Instance.new("PointLight") 
    light.Color = color 
    light.Range = 15 
    light.Brightness = 2 
    light.Parent = part

    local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(0.5, 0.5, 0.5), 
        Transparency = 1, 
        CFrame = CFrame.new(position) * CFrame.new(math.random(-5, 5), math.random(5, 10), math.random(-5, 5))
    })
    tween:Play() 
    tween.Completed:Connect(function() part:Destroy() end) 
    return part
end

function AnimationLib.CreateBeam(startPos, endPos, color, duration)
    local attachment1 = Instance.new("Attachment")
    attachment1.Position = Vector3.new(0, 0, 0)
    local attachment2 = Instance.new("Attachment")
    attachment2.Position = endPos - startPos

    local beam = Instance.new("Beam") 
    beam.Attachment0 = attachment1 
    beam.Attachment1 = attachment2 
    beam.Color = ColorSequence.new(color) 
    beam.Width0 = 0.5 
    beam.Width1 = 0.5 
    beam.FaceCamera = true

    local part = Instance.new("Part") 
    part.Size = Vector3.new(1, 1, 1) 
    part.Anchored = true 
    part.CanCollide = false 
    part.Transparency = 1 
    part.CFrame = CFrame.new(startPos) 
    part.Parent = workspace

    attachment1.Parent = part 
    attachment2.Parent = part 
    beam.Parent = part

    task.delay(duration, function() 
        beam:Destroy() 
        attachment1:Destroy() 
        attachment2:Destroy() 
        part:Destroy() 
    end) 
    return beam
end

function AnimationLib.DesyncTeleportEffect(position)
    for i = 1, 8 do
        task.spawn(function()
            AnimationLib.CreateParticleEffect(position + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3)), Color3.fromRGB(0, 150, 255), 0.8)
        end)
        task.wait(0.05)
    end

    local wave = Instance.new("Part") 
    wave.Size = Vector3.new(1, 1, 1) 
    wave.Anchored = true 
    wave.CanCollide = false 
    wave.Transparency = 0.7 
    wave.Color = Color3.fromRGB(0, 100, 255) 
    wave.Material = Enum.Material.Neon 
    wave.CFrame = CFrame.new(position) 
    wave.Parent = workspace

    local tween = game:GetService("TweenService"):Create(wave, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(20, 0.1, 20), 
        Transparency = 1
    })
    tween:Play() 
    tween.Completed:Connect(function() wave:Destroy() end)
end

local desyncPart
local lastSafeCF = nil
local lastTeleportCheck = nil

local function CreateDesyncMarker(pos)
    if desyncPart then
        desyncPart:Destroy()
        desyncPart = nil
    end
    desyncPart = Instance.new("Part")
    desyncPart.Name = "DesyncMarker"
    desyncPart.Anchored = true
    desyncPart.CanCollide = false
    desyncPart.Size = Vector3.new(4, 4, 4)
    desyncPart.Transparency = 0.5
    desyncPart.Color = Color3.fromRGB(0, 150, 255)
    desyncPart.Material = Enum.Material.Neon
    desyncPart.CFrame = pos
    desyncPart.Parent = workspace
    lastSafeCF = pos

    local bbGui = Instance.new("BillboardGui") 
    bbGui.Size = UDim2.new(10, 0, 4, 0) 
    bbGui.AlwaysOnTop = true 
    bbGui.Adornee = desyncPart 
    bbGui.Parent = desyncPart

    local frame = Instance.new("Frame") 
    frame.Size = UDim2.new(1, 0, 1, 0) 
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) 
    frame.BackgroundTransparency = 0.7 
    frame.Parent = bbGui 
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local txt = Instance.new("TextLabel") 
    txt.Size = UDim2.new(1, 0, 1, 0) 
    txt.BackgroundTransparency = 1 
    txt.Text = "ARIS DESYNC POINT" 
    txt.TextColor3 = Color3.fromRGB(255, 255, 255) 
    txt.TextScaled = true 
    txt.Font = Enum.Font.GothamBold 
    txt.TextStrokeTransparency = 0.8 
    txt.Parent = frame

    task.spawn(function()
        while desyncPart and desyncPart.Parent do
            local t1 = game:GetService("TweenService"):Create(desyncPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Vector3.new(4.5, 4.5, 4.5)}) 
            t1:Play() 
            t1.Completed:Wait()
            if desyncPart then 
                local t2 = game:GetService("TweenService"):Create(desyncPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Vector3.new(4, 4, 4)}) 
                t2:Play() 
                t2.Completed:Wait() 
            end
        end
    end)

    AnimationLib.DesyncTeleportEffect(pos.Position) 
    return desyncPart
end

local function UpdateDesyncMarker(pos)
    if not desyncPart then
        CreateDesyncMarker(pos)
        return
    end
    if lastTeleportCheck then
        local delta = (pos.Position - lastTeleportCheck.Position).Magnitude
        if delta > 1.5 then
            AnimationLib.DesyncTeleportEffect(desyncPart.Position)
            AnimationLib.CreateBeam(desyncPart.Position, pos.Position, Color3.fromRGB(0, 150, 255), 0.3)
            desyncPart.CFrame = pos
            lastSafeCF = pos
        end
    end
    lastTeleportCheck = pos
end

local function ForceUpdateMarker(pos)
    if not desyncPart then
        CreateDesyncMarker(pos)
        return
    end
    AnimationLib.DesyncTeleportEffect(desyncPart.Position)
    desyncPart.CFrame = pos
    lastSafeCF = pos
    lastTeleportCheck = pos
end

local function HideDesyncMarker()
    if desyncPart then
        AnimationLib.DesyncTeleportEffect(desyncPart.Position)
        desyncPart:Destroy()
        desyncPart = nil
        lastSafeCF = nil
        lastTeleportCheck = nil
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    if not hrp then return end
    task.wait(0.1)
    if desyncState then
        if desyncPart then
            AnimationLib.CreateBeam(desyncPart.Position, hrp.Position, Color3.fromRGB(0, 150, 255), 0.5)
        end
        ForceUpdateMarker(hrp.CFrame)
    end
end)

local function CreateFakeBody(char, posCF)
    char.Archivable = true
    local fake = char:Clone()
    char.Archivable = false
    if fake then
        fake.Name = "Aris_FakeBody"
        for _, v in ipairs(fake:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Anchored = true
                v.CanCollide = false
            elseif v:IsA("Script") or v:IsA("LocalScript") then
                v:Destroy()
            end
        end
        if fake:FindFirstChild("HumanoidRootPart") then
            fake:SetPrimaryPartCFrame(posCF)
        elseif fake.PrimaryPart then
            fake:SetPrimaryPartCFrame(posCF)
        else
            fake:MoveTo(posCF.Position)
        end
        fake.Parent = workspace
        return fake
    end
    return nil
end

local function FastRespawnUserLogic(plr, isHide)
    ToggleDesync(true)
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ogpos = hrp.CFrame 
    local ogpos2 = workspace.CurrentCamera.CFrame
    local hum = char:FindFirstChildWhichIsA("Humanoid") 

    if hum then 
        hum.Health = 0 
    end

    task.spawn(function()
        local newChar = plr.CharacterAdded:Wait()
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 10) 
        if not newHrp then return end
        
        if isHide then
            local vheight = math.random(5000, 9888)
            newHrp.CFrame = ogpos + Vector3.new(0, vheight, 0) 
            workspace.CurrentCamera.CFrame = ogpos2
        else
            newHrp.CFrame = ogpos 
            workspace.CurrentCamera.CFrame = ogpos2
        end
    end)
end

local function CustomRespawnFix(plr)
    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    AnimationLib.DesyncTeleportEffect(hrp.Position)
    local ogpos = hrp.CFrame 
    local ogpos2 = workspace.CurrentCamera.CFrame

    replicatesignal(plr.ConnectDiedSignalBackend) 
    task.wait(Players.RespawnTime - 0.1) 
    replicatesignal(plr.Kill)

    return plr.CharacterAdded:Wait(), ogpos, ogpos2
end

local function DoHideNormal()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local originalCF = hrp.CFrame 
    local originalCam = workspace.CurrentCamera.CFrame
    local vheight = math.random(5000, 9888) 

    hrp.CFrame = originalCF + Vector3.new(0, vheight, 0) 
    workspace.CurrentCamera.CFrame = originalCam
    task.wait(0.15) 
    ToggleDesync(true)

    hrp.CFrame = originalCF 
    workspace.CurrentCamera.CFrame = originalCam

    UpdateDesyncMarker(originalCF) 
    AnimationLib.CreateBeam(hrp.Position, originalCF.Position, Color3.fromRGB(0, 255, 150), 0.3) 
    AnimationLib.DesyncTeleportEffect(originalCF.Position)
end

local function ActivateDesyncNormal()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if _G.Config.Desync_HideAuto then 
        DoHideNormal() 
    else 
        ToggleDesync(true) 
        UpdateDesyncMarker(hrp.CFrame) 
        AnimationLib.DesyncTeleportEffect(hrp.Position) 
    end
end

local function DoFastDesync()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local savedCFrame = hrp.CFrame 
    UpdateDesyncMarker(savedCFrame) 
    FastRespawnUserLogic(LocalPlayer, _G.Config.Desync_HideAuto)

    local newChar = LocalPlayer.Character 
    if newChar then 
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 5) 
        if newHrp then 
            UpdateDesyncMarker(savedCFrame) 
        end 
    end
end

local function DoFixDesync(isHide)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if ArisFakeBody then ArisFakeBody:Destroy(); ArisFakeBody = nil end
    ArisFakeBody = CreateFakeBody(char, hrp.CFrame)

    ToggleDesync(true) 
    for _, flagData in ipairs(NumericFlags) do 
        pcall(function() setfflag(flagData[1], flagData[2]) end) 
    end
    UpdateDesyncMarker(hrp.CFrame)

    local newChar, originalCF, originalCam = CustomRespawnFix(LocalPlayer) 
    local newHrp = newChar:WaitForChild("HumanoidRootPart")

    if isHide then 
        local randomY = math.random(8000, 9000) 
        newHrp.CFrame = CFrame.new(newHrp.Position.X, randomY, newHrp.Position.Z) 
        workspace.CurrentCamera.CFrame = newHrp.CFrame 
        task.wait(0.15) 
    end
    UpdateDesyncMarker(newHrp.CFrame)
end

local function MakeDraggable(f)
    local d=false;local i,s
    f.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            d=true; i=inp.Position; s=f.Position
        end
    end)
    f.InputChanged:Connect(function(inp)
        if (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) and d then
            local delta=inp.Position-i;
            f.Position=UDim2.new(s.X.Scale,s.X.Offset+delta.X,s.Y.Scale,s.Y.Offset+delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            d=false
        end
    end)
end

local ToggleBtn = Instance.new("ImageButton",ScreenGui)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0,10,0.5,-25)
ToggleBtn.Image = "rbxassetid://125329301331069"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleBtn.ClipsDescendants = true
ToggleBtn.Visible = true 
Instance.new("UICorner",ToggleBtn).CornerRadius = UDim.new(0,20)
CreateBorder(ToggleBtn)
MakeDraggable(ToggleBtn)
ApplyButtonAnimation(ToggleBtn)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
        _G.Config.MenuOpen = not _G.Config.MenuOpen; MainFrame.Visible = _G.Config.MenuOpen
    end
end)

local MainFrame = Instance.new("Frame",ScreenGui)
MainFrame.Size = UDim2.new(0,400,0,310)
MainFrame.Position = UDim2.new(0,70,0.2,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
MainFrame.Visible = false
Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,20)
CreateBorder(MainFrame)

local ResetBtn = Instance.new("TextButton",MainFrame)
ResetBtn.Size = UDim2.new(0,36,0,32)
ResetBtn.Position = UDim2.new(0,12,0,7)
ResetBtn.Text = ""
ResetBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner",ResetBtn).CornerRadius = UDim.new(0,16)
ApplyToggleGradient(ResetBtn, false)
CreateBorder(ResetBtn)
CreateButtonText(ResetBtn, "RST", Enum.Font.GothamBold, 13)
ApplyButtonAnimation(ResetBtn)

ResetBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            while char.Humanoid.Health > 0 and char.Parent do
                char.Humanoid.Health = 0; task.wait(0.1)
            end
        end
    end)
end)

local Title = Instance.new("TextLabel",MainFrame)
Title.Size = UDim2.new(1,-70,0,45)
Title.Position = UDim2.new(0,60,0,0)
Title.Text = "ARIS HUB V53 PRO"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
CreateTextGradient(Title)
MakeDraggable(MainFrame)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.Config.MenuOpen=not _G.Config.MenuOpen; MainFrame.Visible=_G.Config.MenuOpen
end)

local TabFrame = Instance.new("Frame",MainFrame)
TabFrame.Size = UDim2.new(1,-10,0,35)
TabFrame.Position = UDim2.new(0,5,0,45)
TabFrame.BackgroundTransparency = 1

local Tabs = {"ESP","Hitbox","Misc","NPC","Desync", "TP NPC", "TP Player"}
local ContentFrames = {}

local tabListLayout = Instance.new("UIListLayout", TabFrame)
tabListLayout.FillDirection = Enum.FillDirection.Horizontal
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabListLayout.Padding = UDim.new(0, 4)
tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

for i,tab in ipairs(Tabs)do
    local btn = Instance.new("TextButton",TabFrame)
    btn.Size = UDim2.new(1/#Tabs, -4, 1, 0)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,16)
    ApplyToggleGradient(btn, false)
    CreateBorder(btn)
    CreateButtonText(btn, tab, Enum.Font.GothamBold, 10)
    ApplyButtonAnimation(btn)

    local content = Instance.new("ScrollingFrame",MainFrame) 
    content.Size = UDim2.new(1,-10,1,-95)
    content.Position = UDim2.new(0,5,0,85) 
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 5
    content.Visible = false
    content.BorderSizePixel = 0

    local list = Instance.new("UIListLayout",content) 
    list.Padding = UDim.new(0,8)
    list.SortOrder = Enum.SortOrder.LayoutOrder 
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() 
        content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15) 
    end)

    local pad = Instance.new("UIPadding",content)
    pad.PaddingLeft = UDim.new(0,5)
    pad.PaddingTop = UDim.new(0,5)

    ContentFrames[tab] = {Frame=content}
    btn.MouseButton1Click:Connect(function() 
        for _,f in pairs(ContentFrames)do 
            f.Frame.Visible=false 
        end
        content.Visible=true 
    end)
end
ContentFrames["ESP"].Frame.Visible=true

local function AddButton(tab, name, cb)
    local content = ContentFrames[tab].Frame
    local btn = Instance.new("TextButton", content)
    btn.Size = UDim2.new(1, -16, 0, 36)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(btn, false)
    CreateBorder(btn)
    local txt = CreateButtonText(btn, name, Enum.Font.GothamBold, 13)
    ApplyButtonAnimation(btn)
    btn.MouseButton1Click:Connect(function()
        if cb then cb() end
    end)
    return btn
end

local function AddToggle(tab,name,key,cb)
    local content = ContentFrames[tab].Frame
    local btn = Instance.new("TextButton",content)
    btn.Size = UDim2.new(1,-16,0,36)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,20)

    ApplyToggleGradient(btn, _G.Config[key]) 
    CreateBorder(btn) 
    local btnTxt = CreateButtonText(btn, name..": "..(_G.Config[key]and"ON"or"OFF"), Enum.Font.GothamBold, 14)
    ApplyButtonAnimation(btn)

    ToggleButtons[key] = {Btn = btn, Txt = btnTxt, Name = name}

    btn.MouseButton1Click:Connect(function() 
        _G.Config[key] = not _G.Config[key] 
        btnTxt.Text = name..": "..(_G.Config[key]and"ON"or"OFF") 
        ApplyToggleGradient(btn, _G.Config[key]) 
        if cb then cb(_G.Config[key])end 
    end)
end

local function AddAdjust(tab,name,key,step,minV,maxV,cb)
    local content = ContentFrames[tab].Frame
    local frame = Instance.new("Frame",content)
    frame.Size = UDim2.new(1,-16,0,36)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel",frame) 
    label.Size = UDim2.new(0.55,0,1,0)
    label.Position = UDim2.new(0.2,0,0,0) 
    label.BackgroundTransparency = 1
    label.Text = name..": ".._G.Config[key] 
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14 
    CreateTextGradient(label)

    if not AdjustLabels[key] then AdjustLabels[key] = {} end
    table.insert(AdjustLabels[key], {Label = label, Name = name})

    local minVal = minV or step
    local maxVal = maxV or 9999

    local minus = Instance.new("TextButton",frame) 
    minus.Size = UDim2.new(0.2,-5,1,0)
    minus.Text = "" 
    minus.BackgroundColor3 = Color3.new(1,1,1) 
    Instance.new("UICorner",minus).CornerRadius = UDim.new(0,20) 
    ApplyToggleGradient(minus, false) 
    CreateBorder(minus) 
    CreateButtonText(minus, "-", Enum.Font.GothamBold, 18)
    ApplyButtonAnimation(minus)

    minus.MouseButton1Click:Connect(function() 
        _G.Config[key] = math.clamp(_G.Config[key]-step, minVal, maxVal)
        for _, lblData in ipairs(AdjustLabels[key]) do
            lblData.Label.Text = lblData.Name..": ".._G.Config[key]
        end
        if cb then cb() end 
    end)

    local plus = Instance.new("TextButton",frame) 
    plus.Size = UDim2.new(0.2,-5,1,0)
    plus.Position = UDim2.new(0.8,5,0,0)
    plus.Text = "" 
    plus.BackgroundColor3 = Color3.new(1,1,1) 
    Instance.new("UICorner",plus).CornerRadius = UDim.new(0,20) 
    ApplyToggleGradient(plus, false) 
    CreateBorder(plus) 
    CreateButtonText(plus, "+", Enum.Font.GothamBold, 16)
    ApplyButtonAnimation(plus)

    plus.MouseButton1Click:Connect(function() 
        _G.Config[key] = math.clamp(_G.Config[key]+step, minVal, maxVal)
        for _, lblData in ipairs(AdjustLabels[key]) do
            lblData.Label.Text = lblData.Name..": ".._G.Config[key]
        end
        if cb then cb() end 
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

AddToggle("Misc","TEAM CHECK (ESP + HB + TP)","TeamCheck")
AddToggle("Misc","LOW HP KS (<30%)","LowHP_KS")
AddToggle("Misc","HIỆN FPS & PING","Show_Stats", function(val) StatsFrame.Visible = val end)

local MiscContent = ContentFrames["Misc"].Frame
local WSContainer = Instance.new("Frame", MiscContent)
WSContainer.Size = UDim2.new(1, 0, 0, 115)
WSContainer.BackgroundTransparency = 1

local WSToggle = Instance.new("TextButton", WSContainer)
WSToggle.Size = UDim2.new(1, -16, 0, 36)
WSToggle.Text = ""
WSToggle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSToggle).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSToggle, _G.Config.WalkSpeedEnabled)
CreateBorder(WSToggle)
local WSToggleTxt = CreateButtonText(WSToggle, "WALKSPEED: OFF", Enum.Font.GothamBold, 14)
ApplyButtonAnimation(WSToggle)

local WSSliderBg = Instance.new("Frame", WSContainer)
WSSliderBg.Size = UDim2.new(1, -16, 0, 25)
WSSliderBg.Position = UDim2.new(0, 0, 0, 48)
WSSliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", WSSliderBg).CornerRadius = UDim.new(0, 20)

local WSSliderFill = Instance.new("Frame", WSSliderBg)
WSSliderFill.Size = UDim2.new((_G.Config.WalkSpeed - 16) / (250 - 16), 0, 1, 0)
WSSliderFill.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSSliderFill).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSSliderFill, true)

local WSValLabel = Instance.new("TextLabel", WSSliderBg)
WSValLabel.Size = UDim2.new(1, 0, 1, 0)
WSValLabel.BackgroundTransparency = 1
WSValLabel.Text = "Speed: " .. _G.Config.WalkSpeed
WSValLabel.Font = Enum.Font.GothamBold
WSValLabel.TextSize = 12
CreateTextGradient(WSValLabel)

local WSBtnFrame = Instance.new("Frame", WSContainer)
WSBtnFrame.Size = UDim2.new(1, -16, 0, 32)
WSBtnFrame.Position = UDim2.new(0, 0, 0, 82)
WSBtnFrame.BackgroundTransparency = 1

local btnW = 0.22; local gap = 0.04
local function createWSBtn(text, posScale)
    local btn = Instance.new("TextButton", WSBtnFrame)
    btn.Size = UDim2.new(btnW, 0, 1, 0)
    btn.Position = UDim2.new(posScale, 0, 0, 0)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(btn, false)
    CreateBorder(btn)
    CreateButtonText(btn, text, Enum.Font.GothamBold, 14)
    ApplyButtonAnimation(btn)
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
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingWS = true
    end
end)
WSSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingWS = false
    end
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
AddToggle("NPC","ESP NPC BOX 2D","ESP_NPC_Box")
AddToggle("NPC","ESP NPC CHAMS","ESP_NPC_Chams")

local RefreshFloatBtn

local desyncTab = ContentFrames["Desync"].Frame
local ModeFrame = Instance.new("Frame", desyncTab)
ModeFrame.Size = UDim2.new(1, -16, 0, 36)
ModeFrame.BackgroundTransparency = 1

local modeLabel = Instance.new("TextLabel", ModeFrame)
modeLabel.Size = UDim2.new(0.2, 0, 1, 0)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "MODE:"
modeLabel.Font = Enum.Font.GothamBold
modeLabel.TextSize = 13
CreateTextGradient(modeLabel)

local function createModeBtn(text, posScale, modeStr)
    local btn = Instance.new("TextButton", ModeFrame)
    btn.Size = UDim2.new(0.25, 0, 1, 0)
    btn.Position = UDim2.new(posScale, 0, 0, 0)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16)
    CreateBorder(btn)
    local txt = CreateButtonText(btn, text, Enum.Font.GothamBold, 12)
    ApplyButtonAnimation(btn)

    local function UpdateState()
        local isSelected = (_G.Config.Desync_Mode == modeStr)
        ApplyToggleGradient(btn, isSelected)
    end
    UpdateState()

    btn.MouseButton1Click:Connect(function()
        if desyncState then 
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title="CẢNH BÁO",
                Text="Vui lòng TẮT Desync trước khi đổi chế độ!",
                Duration=2
            })
            return 
        end
        _G.Config.Desync_Mode = modeStr
        for _, child in ipairs(ModeFrame:GetChildren()) do
            if child:IsA("TextButton") then 
                ApplyToggleGradient(child, child:GetAttribute("ModeStr") == _G.Config.Desync_Mode) 
            end
        end
        if RefreshFloatBtn then RefreshFloatBtn() end
    end)
    btn:SetAttribute("ModeStr", modeStr)
    return btn
end

createModeBtn("Normal", 0.22, "Normal")
createModeBtn("Fast", 0.49, "Fast")
createModeBtn("Fix", 0.76, "Fix")

local floatGui = Instance.new("ScreenGui", CoreGui)
floatGui.Name = "ArisFloatToggle"
floatGui.ResetOnSpawn = false
floatGui.DisplayOrder = 1000
floatGui.Enabled = _G.Config.Desync_ShowFloat

local cyanPinkColors = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200))
})

local floatBtn = Instance.new("TextButton", floatGui)
floatBtn.Size = UDim2.new(0, 130, 0, 40)
floatBtn.AnchorPoint = Vector2.new(0.5, 0.5)
floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
floatBtn.Text = ""
floatBtn.AutoButtonColor = false
floatBtn.Active = false
floatBtn.Draggable = false
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1, 0)
ApplyButtonAnimation(floatBtn)

local btnGradient = Instance.new("UIGradient", floatBtn)
btnGradient.Color = cyanPinkColors
btnGradient.Enabled = false

local floatStroke = Instance.new("UIStroke", floatBtn)
floatStroke.Thickness = 2.5
floatStroke.Color = Color3.fromRGB(255, 255, 255)
floatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local strokeGradient = Instance.new("UIGradient", floatStroke)
strokeGradient.Color = cyanPinkColors

local floatText = Instance.new("TextLabel", floatBtn)
floatText.Size = UDim2.new(1, 0, 1, 0)
floatText.BackgroundTransparency = 1
floatText.Text = "DeSync : Off"
floatText.TextColor3 = Color3.fromRGB(255, 255, 255)
floatText.TextSize = 13
floatText.Font = Enum.Font.GothamBold

local textGradient = Instance.new("UIGradient", floatText)
textGradient.Color = cyanPinkColors
textGradient.Enabled = true

local function UpdateFloatPosition()
    floatBtn.Position = UDim2.new(_G.Config.Desync_FloatX / 100, 0, _G.Config.Desync_FloatY / 100, 0)
end
UpdateFloatPosition()

RefreshFloatBtn = function()
    if _G.Config.Desync_Mode == "Fix" and _G.Config.Desync_HideAuto then
        floatText.Text = "N/A ⚠️"
        btnGradient.Enabled = false
        textGradient.Enabled = false
        strokeGradient.Enabled = false
        floatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        floatText.TextColor3 = Color3.fromRGB(200, 200, 200)
        floatStroke.Color = Color3.fromRGB(100, 100, 100)
        return
    end

    strokeGradient.Enabled = true
    floatStroke.Color = Color3.fromRGB(255, 255, 255)

    if desyncState then
        floatText.Text = "DeSync : On" 
        btnGradient.Enabled = true
        floatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        textGradient.Enabled = false
        floatText.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        floatText.Text = "DeSync : Off"
        btnGradient.Enabled = false
        floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        textGradient.Enabled = true
        floatText.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

floatBtn.MouseButton1Click:Connect(function()
    if _G.Config.Desync_Mode == "Fix" and _G.Config.Desync_HideAuto then return end
    desyncState = not desyncState
    RefreshFloatBtn()

    local ts = game:GetService("TweenService")
    ts:Create(floatBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 120, 0, 35)}):Play()
    task.wait(0.1)
    ts:Create(floatBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 130, 0, 40)}):Play()

    if desyncState then
        if _G.Config.Desync_Mode == "Fix" then 
            DoFixDesync(_G.Config.Desync_HideAuto)
        elseif _G.Config.Desync_Mode == "Fast" then 
            DoFastDesync()
        else 
            ActivateDesyncNormal() 
        end
    else
        ToggleDesync(false)
        for _, flagData in ipairs(NumericFlags) do 
            pcall(function() setfflag(flagData[1], "") end) 
        end
        HideDesyncMarker()
        if ArisFakeBody then ArisFakeBody:Destroy(); ArisFakeBody = nil end 
    end
end)

AddToggle("Desync", "GHOST MODE (👻)", "Desync_HideAuto", function() if RefreshFloatBtn then RefreshFloatBtn() end end)
AddToggle("Desync", "HIỆN NÚT DESYNC NỔI", "Desync_ShowFloat", function(v) floatGui.Enabled = v end)
AddAdjust("Desync", "TỌA ĐỘ X (%)", "Desync_FloatX", 5, 0, 100, UpdateFloatPosition)
AddAdjust("Desync", "TỌA ĐỘ Y (%)", "Desync_FloatY", 5, 0, 100, UpdateFloatPosition)

local ESP_Store={}
local NPC_Store={}
local CachedNPCs = {}

local function CheckAndCacheNPC(obj)
    if obj:IsA("Model") and obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            CachedNPCs[obj] = true
        end
    end
end

for _, v in ipairs(Workspace:GetDescendants()) do
    CheckAndCacheNPC(v)
end

Workspace.DescendantAdded:Connect(function(descendant)
    task.delay(1, function()
        if descendant.Parent then CheckAndCacheNPC(descendant) end
    end)
end)

local function RestoreHRP(hrp)
    if hrp and hrp:GetAttribute("ArisOrigSizeX") then
        hrp.Size = Vector3.new(hrp:GetAttribute("ArisOrigSizeX"), hrp:GetAttribute("ArisOrigSizeY"), hrp:GetAttribute("ArisOrigSizeZ"))
        hrp.Transparency = hrp:GetAttribute("ArisOrigTrans")
        hrp.CanCollide = hrp:GetAttribute("ArisOrigCollide")
        if hrp:GetAttribute("ArisOrigMassless") ~= nil then
            hrp.Massless = hrp:GetAttribute("ArisOrigMassless")
        end
    end
end

local function GetHealthColor(pct)
    if pct>0.7 then
        return Color3.new(0,1,0)
    elseif pct>0.5 then
        return Color3.new(1,1,0)
    elseif pct>0.3 then
        return Color3.new(1,0.5,0)
    else
        return Color3.new(1,0,0)
    end
end

local function CleanupESP(playerName)
    if ESP_Store[playerName]then
        pcall(function()
            if ESP_Store[playerName].BoxBill then ESP_Store[playerName].BoxBill:Destroy() end;
            if ESP_Store[playerName].TextBill then ESP_Store[playerName].TextBill:Destroy() end
        end)
        ESP_Store[playerName]=nil
    end
    local p = Players:FindFirstChild(playerName)
    if p and p.Character then
        if p.Character:FindFirstChild("ArisHL") then p.Character.ArisHL:Destroy() end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            if hrp:FindFirstChild("ArisHitboxBox") then hrp.ArisHitboxBox:Destroy() end;
            RestoreHRP(hrp)
        end
    end
end

local function CleanupNPC(m)
    if NPC_Store[m]then
        pcall(function()
            if NPC_Store[m].Bill then NPC_Store[m].Bill:Destroy() end
            if NPC_Store[m].BoxBill then NPC_Store[m].BoxBill:Destroy() end
        end);
        NPC_Store[m]=nil
    end
    if m then
        if m:FindFirstChild("ArisHL_NPC") then m.ArisHL_NPC:Destroy() end
        local hrp = m:FindFirstChild("HumanoidRootPart")
        if hrp then
            if hrp:FindFirstChild("ArisHitboxBoxNPC") then hrp.ArisHitboxBoxNPC:Destroy() end;
            RestoreHRP(hrp)
        end
    end
end

Workspace.DescendantRemoving:Connect(function(descendant)
    if CachedNPCs[descendant] then
        CachedNPCs[descendant] = nil; CleanupNPC(descendant)
    end
end)

local currentTween = nil
local currentTarget = nil
local noclipConnection = nil
local charParts = {}

local function updateCharParts()
    charParts = {}
    if LocalPlayer.Character then
        for _, v in ipairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then table.insert(charParts, v) end
        end
    end
end

local function setCollision(state)
    for _, v in ipairs(charParts) do
        if v and v.Parent then v.CanCollide = state end
    end
end

local function toggleNoclip(active)
    if active then
        updateCharParts()
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(function()
                setCollision(false)
            end)
        end
    else
        if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
        setCollision(true)
    end
end

local isFarming = false
local function doMagnetLoop()
    if isFarming then return end
    isFarming = true
    task.spawn(function()
        while _G.Config.TP_NPC or _G.Config.TP_Player do
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local nearest = nil
                local shortestDist = 5000

                if _G.Config.TP_NPC then
                    for npc, _ in pairs(CachedNPCs) do
                        if npc and npc.Parent then
                            if _G.Config.BlacklistedNPCs[npc.Name] or TempSkipNPC[npc] then continue end

                            local hum = npc:FindFirstChild("Humanoid")
                            local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Hitbox") or npc:FindFirstChild("Torso") or npc:FindFirstChild("UpperTorso")
                            if hum and root and hum.Health > 0 and hum.MaxHealth > 0 and root:IsA("BasePart") then
                                local dist = (myRoot.Position - root.Position).Magnitude
                                if dist < shortestDist then
                                    shortestDist = dist
                                    nearest = root
                                end
                            end
                        end
                    end
                elseif _G.Config.TP_Player then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            local isSameTeam = (LocalPlayer.Team ~= nil and p.Team == LocalPlayer.Team)
                            if not (_G.Config.TeamCheck and isSameTeam) then
                                local hum = p.Character:FindFirstChild("Humanoid")
                                local root = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso")
                                if hum and root and hum.Health > 0 and hum.MaxHealth > 0 and root:IsA("BasePart") then
                                    local dist = (myRoot.Position - root.Position).Magnitude
                                    if dist < shortestDist then
                                        shortestDist = dist
                                        nearest = root
                                    end
                                end
                            end
                        end
                    end
                end
                
                if nearest ~= currentTarget or (currentTarget and (not currentTarget.Parent or (currentTarget.Parent:FindFirstChild("Humanoid") and currentTarget.Parent.Humanoid.Health <= 0))) then
                    currentTarget = nearest
                    if currentTween then currentTween:Cancel() end
                end
                
                if currentTarget then
                    if not noclipConnection then toggleNoclip(true) end
                    
                    local targetPos = currentTarget.CFrame * CFrame.new(0, _G.Config.TP_Height, 0)
                    local dist = (myRoot.Position - targetPos.Position).Magnitude
                    
                    if dist <= 100 then
                        if currentTween then currentTween:Cancel() end
                        myRoot.CFrame = targetPos
                    else
                        local duration = dist / _G.Config.TP_Speed
                        if duration < 0.05 then duration = 0.05 end
                        currentTween = TweenService:Create(myRoot, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetPos})
                        currentTween:Play()
                    end
                else
                    if noclipConnection then toggleNoclip(false) end
                end
            end
            task.wait(0.1)
        end
        if noclipConnection then toggleNoclip(false) end
        isFarming = false
    end)
end

AddToggle("TP NPC", "BẬT TWEEN/TP NPC", "TP_NPC", function(val)
    if val then
        _G.Config.TP_Player = false
        local b = ToggleButtons["TP_Player"]
        if b then
            b.Txt.Text = b.Name..": OFF"
            ApplyToggleGradient(b.Btn, false)
        end
        doMagnetLoop()
    else
        if not _G.Config.TP_Player then
            currentTarget = nil
            if currentTween then currentTween:Cancel() end
        end
    end
end)
AddAdjust("TP NPC", "ĐỘ CAO (Y)", "TP_Height", 5)
AddAdjust("TP NPC", "TỐC ĐỘ BAY", "TP_Speed", 50)

AddButton("TP NPC", "⏭️ BỎ QUA NPC HIỆN TẠI (SKIP)", function()
    if currentTarget and currentTarget.Parent then
        TempSkipNPC[currentTarget.Parent] = true
        currentTarget = nil
        if currentTween then currentTween:Cancel() end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title="SKIP NPC", Text="Đã tạm thời bỏ qua NPC này!", Duration=3
        })
    end
end)

local BlacklistContainer = Instance.new("Frame", ContentFrames["TP NPC"].Frame)
BlacklistContainer.Size = UDim2.new(1, -16, 0, 0)
BlacklistContainer.BackgroundTransparency = 1
local blLayout = Instance.new("UIListLayout", BlacklistContainer)
blLayout.Padding = UDim.new(0, 8)
blLayout.SortOrder = Enum.SortOrder.LayoutOrder
blLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    BlacklistContainer.Size = UDim2.new(1, -16, 0, blLayout.AbsoluteContentSize.Y)
end)

AddButton("TP NPC", "🔄 LÀM MỚI BLACKLIST (1KM)", function()
    for _, child in ipairs(BlacklistContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    
    local foundNPCs = {}
    for npc, _ in pairs(CachedNPCs) do
        if npc and npc.Parent then
            local root = npc:FindFirstChild("HumanoidRootPart")
            if root and (root.Position - myRoot.Position).Magnitude <= 1000 then
                foundNPCs[npc.Name] = true
            end
        end
    end
    
    local count = 0
    for npcName, _ in pairs(foundNPCs) do
        count = count + 1
        local btn = Instance.new("TextButton", BlacklistContainer)
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.Text = ""
        btn.BackgroundColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
        
        local isBlacklisted = _G.Config.BlacklistedNPCs[npcName] or false
        ApplyToggleGradient(btn, isBlacklisted)
        CreateBorder(btn)
        local txt = CreateButtonText(btn, "🚫 BL: " .. npcName, Enum.Font.GothamBold, 12)
        if isBlacklisted then txt.TextColor3 = Color3.fromRGB(0,0,0) end
        ApplyButtonAnimation(btn)
        
        btn.MouseButton1Click:Connect(function()
            _G.Config.BlacklistedNPCs[npcName] = not _G.Config.BlacklistedNPCs[npcName]
            local state = _G.Config.BlacklistedNPCs[npcName]
            ApplyToggleGradient(btn, state)
            txt.TextColor3 = state and Color3.fromRGB(0,0,0) or Color3.new(1,1,1)
        end)
    end
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title="TÌM KIẾM NPC", Text="Phát hiện " .. count .. " loại NPC trong 1km!", Duration=3
    })
end)

AddToggle("TP Player", "BẬT TWEEN/TP PLAYER", "TP_Player", function(val)
    if val then
        _G.Config.TP_NPC = false
        local b = ToggleButtons["TP_NPC"]
        if b then
            b.Txt.Text = b.Name..": OFF"
            ApplyToggleGradient(b.Btn, false)
        end
        doMagnetLoop()
    else
        if not _G.Config.TP_NPC then
            currentTarget = nil
            if currentTween then currentTween:Cancel() end
        end
    end
end)
AddAdjust("TP Player", "ĐỘ CAO (Y)", "TP_Height", 5)
AddAdjust("TP Player", "TỐC ĐỘ BAY", "TP_Speed", 50)

RunService.RenderStepped:Connect(function()
    if _G.Config.WalkSpeedEnabled and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = _G.Config.WalkSpeed end
    end
end)

RunService.Heartbeat:Connect(function()
    local rgb = GetRGB()
    local shift = tick() * 0.15

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
                if dist <= 2000 and (hum.Health / hum.MaxHealth) <= 0.3 then 
                    hasLowHPEnemy = true; break 
                end
            end
        end
    end

    for _,p in Players:GetPlayers()do
        if p==LocalPlayer then continue end
        local char=p.Character 
        local hrp=char and char:FindFirstChild("HumanoidRootPart") 
        local hum=char and char:FindFirstChild("Humanoid")
        local isTeammate = (_G.Config.TeamCheck and p.Team ~= nil and p.Team == LocalPlayer.Team)

        if not char or not hrp or not hum or hum.Health<=0 or isTeammate then
            if hrp then RestoreHRP(hrp) end;
            CleanupESP(p.Name); continue
        end

        local hp_percent = hum.Health / hum.MaxHealth
        local dist = myRoot and (hrp.Position - myRoot.Position).Magnitude or math.huge
        local enableHitbox = false
        
        if _G.Config.Hitbox_P then
            if _G.Config.LowHP_KS then
                if hasLowHPEnemy then 
                    if hp_percent <= 0.3 then enableHitbox = true end
                else 
                    if dist <= 2000 then enableHitbox = true end 
                end
            else 
                enableHitbox = true 
            end
        end

        if enableHitbox then
            local valid = true
            if _G.Config.Hitbox_WallCheck then
                local rp = RaycastParams.new(); rp.FilterDescendantsInstances = {LocalPlayer.Character}; 
                rp.FilterType = Enum.RaycastFilterType.Exclude
                local rr = Workspace:Raycast(Camera.CFrame.Position, (hrp.Position - Camera.CFrame.Position), rp)
                if rr and rr.Instance and not rr.Instance:IsDescendantOf(char) then 
                    valid = false 
                end
            end

            if valid then
                if not hrp:GetAttribute("ArisOrigSizeX") then
                    hrp:SetAttribute("ArisOrigSizeX", hrp.Size.X); hrp:SetAttribute("ArisOrigSizeY", hrp.Size.Y); hrp:SetAttribute("ArisOrigSizeZ", hrp.Size.Z)
                    hrp:SetAttribute("ArisOrigTrans", hrp.Transparency); hrp:SetAttribute("ArisOrigCollide", hrp.CanCollide); hrp:SetAttribute("ArisOrigMassless", hrp.Massless)
                end
                hrp.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                hrp.Transparency = 0.6; hrp.CanCollide = false; hrp.Massless = true 
            else 
                RestoreHRP(hrp) 
            end
        else 
            RestoreHRP(hrp) 
        end

        local hl = char:FindFirstChild("ArisHL")
        if _G.Config.ESP_Chams_P then
            if not hl then 
                hl = Instance.new("Highlight", char); hl.Name = "ArisHL" 
            end
            hl.FillColor = rgb; hl.Enabled = true
        else 
            if hl then hl:Destroy() end 
        end

        local hbBox = hrp:FindFirstChild("ArisHitboxBox")
        if enableHitbox and _G.Config.Hitbox_Box then
            if not hbBox then 
                hbBox = Instance.new("SelectionBox", hrp); hbBox.Name = "ArisHitboxBox"; hbBox.Adornee = hrp 
            end
            hbBox.SurfaceColor3 = rgb
        else 
            if hbBox then hbBox:Destroy() end 
        end

        if _G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P or _G.Config.ESP_Box_P then
            if not ESP_Store[p.Name] then
                local boxBill = Instance.new("BillboardGui", ScreenGui); boxBill.Size = UDim2.new(4.2,0,5.8,0); boxBill.AlwaysOnTop = true
                
                local outF = Instance.new("Frame", boxBill); outF.Size = UDim2.new(1,0,1,0); outF.BackgroundTransparency = 1
                local outS = Instance.new("UIStroke", outF); outS.Thickness = 1.8; outS.Color = Color3.new(1,1,1)
                
                local grad = Instance.new("UIGradient", outS)
                grad.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200))
                })
                
                local cDot = Instance.new("Frame", boxBill); cDot.Size = UDim2.new(0,4,0,4); cDot.Position = UDim2.new(0.5,-2,0.5,-2); cDot.BackgroundColor3 = Color3.fromRGB(0,230,255); cDot.BorderSizePixel=0; Instance.new("UICorner", cDot).CornerRadius = UDim.new(1,0)
                local hLine = Instance.new("Frame", boxBill); hLine.Size = UDim2.new(0.5,0,0,1); hLine.Position = UDim2.new(0.25,0,0.5,0); hLine.BackgroundColor3 = Color3.new(1,1,1); hLine.BackgroundTransparency = 0.5; hLine.BorderSizePixel=0
                local vLine = Instance.new("Frame", boxBill); vLine.Size = UDim2.new(0,1,0.5,0); vLine.Position = UDim2.new(0.5,0,0.25,0); vLine.BackgroundColor3 = Color3.new(1,1,1); vLine.BackgroundTransparency = 0.5; vLine.BorderSizePixel=0
                
                local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0,200,0,60); textB.StudsOffset = Vector3.new(0,3.5,0); textB.AlwaysOnTop = true
                
                local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                
                ESP_Store[p.Name]={BoxBill=boxBill, Grad=grad, TextBill=textB, Text=txt}
            end
            local s=ESP_Store[p.Name]
            s.BoxBill.Adornee = hrp; s.TextBill.Adornee = char:FindFirstChild("Head") or hrp
            s.BoxBill.Enabled=_G.Config.ESP_Box_P; 
            if s.Grad then s.Grad.Rotation = (tick() * 150) % 360 end
            
            s.Text.Text=table.concat({_G.Config.ESP_Name_P and p.Name or "", _G.Config.ESP_Health_P and ("HP: "..math.floor(hum.Health)) or "", _G.Config.ESP_Distance_P and (dist ~= math.huge) and ("Dist: "..math.floor(dist).."m") or ""}, "\n")
            s.Text.TextColor3=GetHealthColor(hp_percent)
            s.TextBill.Enabled = (_G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P)
        else 
            CleanupESP(p.Name) 
        end
    end

    for obj in pairs(CachedNPCs) do
        if not obj.Parent then 
            CachedNPCs[obj] = nil; CleanupNPC(obj); continue 
        end
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
            else 
                RestoreHRP(hrp) 
            end

            local hbBoxNPC = hrp:FindFirstChild("ArisHitboxBoxNPC")
            if _G.Config.Hitbox_NPC and _G.Config.Hitbox_Box_NPC then
                if not hbBoxNPC then 
                    hbBoxNPC = Instance.new("SelectionBox", hrp); hbBoxNPC.Name = "ArisHitboxBoxNPC"; hbBoxNPC.Adornee = hrp 
                end
                hbBoxNPC.SurfaceColor3 = rgb
            else 
                if hbBoxNPC then hbBoxNPC:Destroy() end 
            end

            local hlNPC = obj:FindFirstChild("ArisHL_NPC")
            if _G.Config.ESP_NPC_Chams then
                if not hlNPC then 
                    hlNPC = Instance.new("Highlight", obj); hlNPC.Name = "ArisHL_NPC" 
                end
                hlNPC.FillColor = rgb; hlNPC.Enabled = true
            else 
                if hlNPC then hlNPC:Destroy() end 
            end

            if _G.Config.ESP_NPC_Name or _G.Config.ESP_NPC_Box then
                if not NPC_Store[obj] then
                    local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0, 200, 0, 60); textB.StudsOffset = Vector3.new(0, 3.5, 0); textB.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                    txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                    
                    local boxBill = Instance.new("BillboardGui", ScreenGui); boxBill.Size = UDim2.new(4,0,5.5,0); boxBill.AlwaysOnTop = true
                    local outF = Instance.new("Frame", boxBill); outF.Size = UDim2.new(1,0,1,0); outF.BackgroundTransparency = 1
                    Instance.new("UICorner", outF).CornerRadius = UDim.new(0, 6)
                    local inS = Instance.new("UIStroke", outF); inS.Thickness = 1.5; inS.Color = Color3.new(1,1,1)
                    
                    NPC_Store[obj] = {Bill = textB, Text = txt, BoxBill = boxBill, InStroke = inS}
                end
                local ns = NPC_Store[obj]
                
                ns.Bill.Adornee = obj:FindFirstChild("Head") or hrp
                ns.Text.Text = "NPC: " .. obj.Name .. "\nHP: " .. math.floor(hum.Health)
                ns.Text.TextColor3 = rgb
                ns.Bill.Enabled = _G.Config.ESP_NPC_Name
                
                ns.BoxBill.Adornee = hrp
                ns.InStroke.Color = rgb
                ns.BoxBill.Enabled = _G.Config.ESP_NPC_Box
            else
                if NPC_Store[obj] then 
                    if NPC_Store[obj].Bill then NPC_Store[obj].Bill:Destroy() end
                    if NPC_Store[obj].BoxBill then NPC_Store[obj].BoxBill:Destroy() end
                    NPC_Store[obj] = nil 
                end
            end
        else 
            CleanupNPC(obj) 
        end
    end
end)

Players.PlayerRemoving:Connect(function(p) CleanupESP(p.Name) end)

task.spawn(function()
    task.wait(1)
    if _G.Config.Desync_Mode == "Fix" and not desyncState then
        desyncState = true
        if RefreshFloatBtn then RefreshFloatBtn() end
        DoFixDesync(_G.Config.Desync_HideAuto)
    end
end)