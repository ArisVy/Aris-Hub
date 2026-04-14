local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

if not player then return end

-- Variáveis Globais (GENV)
local GENV = getgenv()
GENV.DesyncNormal = GENV.DesyncNormal or false
GENV.DesyncFast = GENV.DesyncFast or false
GENV.DesyncFix = GENV.DesyncFix or false
GENV.SelectedMode = GENV.SelectedMode or "Normal"
GENV.HideAuto = GENV.HideAuto or false
GENV.GuiVisible = GENV.GuiVisible or true

local desyncState = false

-- Verifica suporte a replicatesignal
local replicatesignal = getgenv().replicatesignal or function(...) return ... end

--===============================================================
-- FUNÇÃO AUXILIAR DE RAKNET
--===============================================================
local function ToggleDesync(state)
    pcall(function()
        if raknet and type(raknet.desync) == "function" then
            raknet.desync(state)
        end
    end)
end

--===============================================================
-- FUNÇÃO DE EFEITO AZUL (ROTACIONAL / CÍRCULO)
--===============================================================
local function AddBlueEffect(object)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 230, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 255))
    })
    gradient.Rotation = -45
    gradient.Parent = object

    task.spawn(function()
        while object and object.Parent do
            local tween = TweenService:Create(gradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 45 + 360})
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

--===============================================================
-- FUNÇÃO DE EFEITO AZUL (RETO / LINEAR)
--===============================================================
local function AddStraightEffect(object)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 230, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 255))
    })
    gradient.Rotation = 45 
    gradient.Offset = Vector2.new(-1, 0)
    gradient.Parent = object

    task.spawn(function()
        while object and object.Parent do
            gradient.Offset = Vector2.new(-1, 0)
            local tween = TweenService:Create(gradient, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)})
            tween:Play()
            tween.Completed:Wait()
            task.wait(0.5)
        end
    end)
end

--===============================================================
-- TABELA DE FFLAGS (FIX V2 - MANTIDAS APENAS AS NUMÉRICAS)
--===============================================================
local NumericFlags = {
    {"GameNetPVHeaderRotationalVelocityZeroCutoffExponent","-5000"},
    {"TimestepArbiterVelocityCriteriaThresholdTwoDt","2147483646"},
    {"S2PhysicsSenderRate","15000"},
    {"MaxDataPacketPerSend","2147483647"},
    {"PhysicsSenderMaxBandwidthBps","20000"},
    {"CheckPVCachedVelThresholdPercent","10"},
    {"MaxMissedWorldStepsRemembered","-2147483648"},
    {"CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth","1"},
    {"StreamJobNOUVolumeLengthCap","2147483647"},
    {"DebugSendDistInSteps","-2147483648"},
    {"GameNetDontSendRedundantNumTimes","1"},
    {"CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent","1"},
    {"CheckPVCachedRotVelThresholdPercent","10"},
    {"ReplicationFocusNouExtentsSizeCutoffForPauseStuds","2147483647"},
    {"CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth","1"},
    {"GameNetDontSendRedundantDeltaPositionMillionth","1"},
    {"InterpolationFrameVelocityThresholdMillionth","5"},
    {"StreamJobNOUVolumeCap","2147483647"},
    {"InterpolationFrameRotVelocityThresholdMillionth","5"},
    {"WorldStepMax","30"},
    {"TimestepArbiterHumanoidLinearVelThreshold","1"},
    {"InterpolationFramePositionThresholdMillionth","5"},
    {"TimestepArbiterHumanoidTurningVelThreshold","1"},
    {"GameNetPVHeaderLinearVelocityZeroCutoffExponent","-5000"},
    {"SimOwnedNOUCountThresholdMillionth","2147483647"},
    {"TimestepArbiterOmegaThou","1073741823"},
    {"MaxAcceptableUpdateDelay","1"}
}

--===============================================================
-- ANIMAÇÕES (LIB)
--===============================================================
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

	local tween = TweenService:Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(0.5, 0.5, 0.5),
		Transparency = 1,
		CFrame = CFrame.new(position) * CFrame.new(math.random(-5, 5), math.random(5, 10), math.random(-5, 5))
	})
	tween:Play()
	tween.Completed:Connect(function()
		part:Destroy()
	end)
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
			AnimationLib.CreateParticleEffect(
				position + Vector3.new(math.random(-3, 3), math.random(0, 5), math.random(-3, 3)),
				Color3.fromRGB(0, 170, 255), 0.8)
		end)
	end
end

--===============================================================
-- HÀM VIỀN ĐEN-ĐỎ ĐỔI MÀU LIÊN TỤC (MỚI THÊM)
--===============================================================
local function AddAnimatedBorder(object, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 3
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Parent = object

    task.spawn(function()
        while object and object.Parent do
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(0, 0, 0)}):Play()
            task.wait(0.8)
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {Color = Color3.fromRGB(255, 0, 0)}):Play()
            task.wait(0.8)
        end
    end)
end--===============================================================
-- MAIN LOGIC & FAST RESPAWN
--===============================================================
local function FastRespawn()
    if not player.Character then return end
    
    local oldPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or Vector3.new(0,0,0)
    
    player.Character:BreakJoints()
    
    task.wait(0.1)
    
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 0
    end
    
    task.wait(0.3)
    
    player:LoadCharacter()
    
    task.spawn(function()
        local newChar = player.Character or player.CharacterAdded:Wait()
        local root = newChar:WaitForChild("HumanoidRootPart", 5)
        if root then
            root.CFrame = CFrame.new(oldPos)
            AnimationLib.DesyncTeleportEffect(oldPos)
        end
    end)
end

local function ApplyNumericFlags()
    for _, flag in ipairs(NumericFlags) do
        pcall(function()
            if setfflag then
                setfflag(flag[1], flag[2])
            elseif sethiddenproperty then
                sethiddenproperty(game, flag[1], flag[2])
            end
        end)
    end
end

--===============================================================
-- DESYNC LOOP
--===============================================================
local desyncConnection

local function StartDesync()
    if desyncConnection then return end
    
    desyncState = true
    ToggleDesync(true)
    
    desyncConnection = RunService.Heartbeat:Connect(function()
        if not desyncState then return end
        
        pcall(function()
            if GENV.DesyncFast then
                replicatesignal("Heartbeat", 0)
            elseif GENV.DesyncFix then
                if math.random(1, 8) == 1 then
                    replicatesignal("Heartbeat", 0)
                end
            end
        end)
    end)
end

local function StopDesync()
    desyncState = false
    if desyncConnection then
        desyncConnection:Disconnect()
        desyncConnection = nil
    end
    ToggleDesync(false)
end

--===============================================================
-- GUI - ARIS HUB
--===============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHubGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 460)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Viền đen-đỏ animate cho MainFrame
AddAnimatedBorder(MainFrame, 4)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "ARIS HUB"
Title.TextColor3 = Color3.fromRGB(0, 170, 255)
Title.TextSize = 26
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

AddBlueEffect(Title)

-- Nút đóng/mở kiểu iPhone (siêu tròn)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 65, 0, 65)
ToggleButton.Position = UDim2.new(0.5, -32.5, 0.85, 0)  -- vị trí mặc định dưới màn hình
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ToggleButton.Text = "☰"
ToggleButton.TextColor3 = Color3.new(1,1,1)
ToggleButton.TextSize = 32
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)  -- siêu tròn
ToggleCorner.Parent = ToggleButton

-- Viền cho nút toggle
AddAnimatedBorder(ToggleButton, 4)

local isMenuOpen = true

local function ToggleMenu()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
    ToggleButton.Text = isMenuOpen and "✕" or "☰"
end

ToggleButton.MouseButton1Click:Connect(ToggleMenu)

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -24, 1, -80)
ContentFrame.Position = UDim2.new(0, 12, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Mode Buttons
local modes = {"Normal", "Fast", "Fix"}
local modeButtons = {}

for i, mode in ipairs(modes) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.92, 0, 0, 52)
    btn.Position = UDim2.new(0.04, 0, 0, (i-1)*62)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    btn.Text = mode .. " Mode"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 18
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = ContentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 14)
    btnCorner.Parent = btn
    
    AddAnimatedBorder(btn, 2.5)  -- viền đen-đỏ cho nút mode
    
    btn.MouseButton1Click:Connect(function()
        GENV.SelectedMode = mode
        GENV.DesyncNormal = (mode == "Normal")
        GENV.DesyncFast = (mode == "Fast")
        GENV.DesyncFix = (mode == "Fix")
        
        for _, b in ipairs(modeButtons) do
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        
        if mode == "Fast" or mode == "Fix" then
            StartDesync()
        else
            StopDesync()
        end
    end)
    
    table.insert(modeButtons, btn)
end

-- Fast Respawn Toggle
local RespawnToggle = Instance.new("TextButton")
RespawnToggle.Size = UDim2.new(0.92, 0, 0, 52)
RespawnToggle.Position = UDim2.new(0.04, 0, 0, 200)
RespawnToggle.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
RespawnToggle.Text = "Fast Respawn: OFF"
RespawnToggle.TextColor3 = Color3.new(1,1,1)
RespawnToggle.TextSize = 18
RespawnToggle.Font = Enum.Font.GothamSemibold
RespawnToggle.Parent = ContentFrame

local RespawnCorner = Instance.new("UICorner")
RespawnCorner.CornerRadius = UDim.new(0, 14)
RespawnCorner.Parent = RespawnToggle

AddAnimatedBorder(RespawnToggle, 2.5)

local respawnEnabled = false
RespawnToggle.MouseButton1Click:Connect(function()
    respawnEnabled = not respawnEnabled
    RespawnToggle.Text = "Fast Respawn: " .. (respawnEnabled and "ON" or "OFF")
    RespawnToggle.BackgroundColor3 = respawnEnabled and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(25, 25, 40)
    
    if respawnEnabled then
        task.spawn(function()
            while respawnEnabled and player.Character do
                task.wait(0.1)
                if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health <= 0 then
                    FastRespawn()
                end
            end
        end)
    end
end)

-- Apply FFlags Button
local ApplyFlagsBtn = Instance.new("TextButton")
ApplyFlagsBtn.Size = UDim2.new(0.92, 0, 0, 52)
ApplyFlagsBtn.Position = UDim2.new(0.04, 0, 0, 265)
ApplyFlagsBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
ApplyFlagsBtn.Text = "Apply FFlags (V2)"
ApplyFlagsBtn.TextColor3 = Color3.new(1,1,1)
ApplyFlagsBtn.TextSize = 18
ApplyFlagsBtn.Font = Enum.Font.GothamSemibold
ApplyFlagsBtn.Parent = ContentFrame

local FlagsCorner = Instance.new("UICorner")
FlagsCorner.CornerRadius = UDim.new(0, 14)
FlagsCorner.Parent = ApplyFlagsBtn

AddAnimatedBorder(ApplyFlagsBtn, 2.5)

ApplyFlagsBtn.MouseButton1Click:Connect(function()
    ApplyNumericFlags()
    -- Có thể thêm thông báo nếu muốn
end)

-- Draggable cho MainFrame
local draggingMain = false
local dragStartMain, startPosMain

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingMain = true
        dragStartMain = input.Position
        startPosMain = MainFrame.Position
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingMain = false
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if draggingMain and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartMain
        MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
    end
end)

-- Draggable cho ToggleButton (nút iPhone)
local draggingToggle = false
local dragStartToggle, startPosToggle

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = true
        dragStartToggle = input.Position
        startPosToggle = ToggleButton.Position
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingToggle = false
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if draggingToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartToggle
        ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
    end
end)

-- Init
ApplyNumericFlags()
print("✅ ARIS HUB Loaded successfully!")

task.spawn(function()
    task.wait(1)
    if GENV.DesyncFast or GENV.DesyncFix then
        StartDesync()
    end
end)
