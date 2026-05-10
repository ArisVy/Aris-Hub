local UserInputService = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local P = Players.LocalPlayer

-- Xoá GUI cũ ở cả CoreGui lẫn PlayerGui để tránh kẹt
if CoreGui:FindFirstChild("FastV2GUI") then CoreGui.FastV2GUI:Destroy() end
if P:FindFirstChild("PlayerGui") and P.PlayerGui:FindFirstChild("FastV2GUI") then P.PlayerGui.FastV2GUI:Destroy() end

-- ==========================================
-- GIAO DIỆN (UI)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FastV2GUI"
ScreenGui.ResetOnSpawn = false

-- Đẩy vào CoreGui, nếu executor rác quá không cho thì đẩy vào PlayerGui
local success = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = P:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 200)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = " Fast V2 | Auto Melee "
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "Fast V2: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = MainFrame
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local DelayLabel = Instance.new("TextLabel")
DelayLabel.Size = UDim2.new(1, 0, 0, 20)
DelayLabel.Position = UDim2.new(0, 0, 0.45, 0)
DelayLabel.BackgroundTransparency = 1
DelayLabel.Text = "Delay: 50ms"
DelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
DelayLabel.Font = Enum.Font.Gotham
DelayLabel.TextSize = 14
DelayLabel.Parent = MainFrame

-- Slider
local SliderBG = Instance.new("Frame")
SliderBG.Size = UDim2.new(0.8, 0, 0, 10)
SliderBG.Position = UDim2.new(0.1, 0, 0.58, 0)
SliderBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SliderBG.Parent = MainFrame
Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(1, 0)

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(50/1000, 0, 1, 0) -- Khởi tạo ở 50ms trên tổng 1000ms
SliderFill.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
SliderFill.Parent = SliderBG
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

local SliderBtn = Instance.new("TextButton")
SliderBtn.Size = UDim2.new(1, 0, 1, 20)
SliderBtn.Position = UDim2.new(0, 0, 0, -5)
SliderBtn.BackgroundTransparency = 1
SliderBtn.Text = ""
SliderBtn.Parent = SliderBG

-- Quick Buttons Frame
local QuickFrame = Instance.new("Frame")
QuickFrame.Size = UDim2.new(0.8, 0, 0, 30)
QuickFrame.Position = UDim2.new(0.1, 0, 0.75, 0)
QuickFrame.BackgroundTransparency = 1
QuickFrame.Parent = MainFrame

-- Hàm tạo nút
local function createQuickBtn(text, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.22, 0, 1, 0) 
    btn.Position = UDim2.new(posX, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.Parent = QuickFrame
    return btn
end

local Btn5 = createQuickBtn("5ms", 0)
local Btn50 = createQuickBtn("50ms", 0.26)
local Btn100 = createQuickBtn("100ms", 0.52)
local Btn150 = createQuickBtn("150ms", 0.78)

-- ==========================================
-- LOGIC KÉO THẢ (CHUẨN MOBILE EXECUTOR)
-- ==========================================
local dragging = false
local dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ==========================================
-- LOGIC GIAO DIỆN CHỨC NĂNG
-- ==========================================
_G.FastV2 = false
_G.FastV2Delay = 0.05 -- Mặc định 50ms

ToggleBtn.Activated:Connect(function()
    _G.FastV2 = not _G.FastV2
    if _G.FastV2 then
        ToggleBtn.Text = "Fast V2: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "Fast V2: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

local function updateDelay(ms)
    ms = math.clamp(ms, 1, 1000) -- Chỉnh max lên 1000ms
    _G.FastV2Delay = ms / 1000
    DelayLabel.Text = "Delay: " .. ms .. "ms"
    SliderFill.Size = UDim2.new(ms / 1000, 0, 1, 0) -- Tỉ lệ max 1000ms
end

Btn5.Activated:Connect(function() updateDelay(5) end)
Btn50.Activated:Connect(function() updateDelay(50) end)
Btn100.Activated:Connect(function() updateDelay(100) end)
Btn150.Activated:Connect(function() updateDelay(150) end)

local sliding = false
SliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sliding = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mouseX = input.Position.X
        local sliderX = SliderBG.AbsolutePosition.X
        local sliderWidth = SliderBG.AbsoluteSize.X
        local fillPercent = math.clamp((mouseX - sliderX) / sliderWidth, 0.01, 1)
        updateDelay(math.floor(fillPercent * 1000)) -- Nhân với max 1000ms
    end
end)

-- ==========================================
-- LOGIC FAST V2
-- ==========================================
local N = require(RS.Modules.Net)
local C = require(RS.Modules.CombatUtil)
local WeaponData = require(RS.Modules.WeaponData)

local hit = N:RemoteEvent("RegisterHit", true)
local atk = RS.Modules.Net["RE/RegisterAttack"]

local humanoid, animator
local loaded = {}
local currentTrack

local function stopAnim()
    if currentTrack then
        currentTrack:Stop()
        currentTrack = nil
    end
end

local function setup(char)
    stopAnim()
    loaded = {}
    humanoid = char:WaitForChild("Humanoid")
    animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    humanoid.Died:Connect(stopAnim)
end

if P.Character then setup(P.Character) end
P.CharacterAdded:Connect(setup)

local function getTrack(id)
    if loaded[id] then return loaded[id] end
    local anim = Instance.new("Animation")
    anim.AnimationId = id
    local track = animator:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Action4
    track.Looped = true
    loaded[id] = track
    return track
end

local function getTargets(root, dist)
    local t = {}
    if workspace:FindFirstChild("Enemies") then
        for _, m in ipairs(workspace.Enemies:GetChildren()) do
            local hrp = m:FindFirstChild("HumanoidRootPart")
            local hum = m:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - root.Position).Magnitude
                if d <= dist then
                    t[#t + 1] = {m, hrp}
                end
            end
        end
    end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= P and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local d = (hrp.Position - root.Position).Magnitude
                if d <= dist then
                    t[#t + 1] = {plr.Character, hrp}
                end
            end
        end
    end
    return t
end

local function play(tool)
    if not tool or not humanoid then return end
    local weaponName = C:GetWeaponName(tool)
    local data = WeaponData[weaponName] or WeaponData[string.lower(weaponName)]
    if not data or data.Type == "Gun" then return end
    if not (data and data.Moveset and data.Moveset.Basic) then return end
    
    local moves = data.Moveset.Basic
    local index = math.clamp(3, 1, #moves)
    local animData = moves[index]
    if not animData then return end
    
    local track = getTrack(animData.AnimationId)
    if not track then return end
    
    if currentTrack ~= track then
        stopAnim()
        currentTrack = track
    end
    
    track.TimePosition = 0
    track:Play(0.25, 1, 0.02)
end

task.spawn(function()
    while true do
        task.wait(_G.FastV2Delay)
        
        if not _G.FastV2 then 
            stopAnim()
            continue
        end
        
        local char = P.Character
        if not (char and humanoid and humanoid.Health > 0) then
            stopAnim()
            continue
        end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        local tool = char:FindFirstChildOfClass("Tool")
        if not (root and tool) then
            stopAnim()
            continue
        end
        
        local weaponName = C:GetWeaponName(tool)
        local data = WeaponData[weaponName] or WeaponData[string.lower(weaponName)]
        if not data or data.Type == "Gun" or data.Type == "Blox Fruit" then
            stopAnim()
            continue
        end
        
        -- KHOẢNG CÁCH ĐÃ ĐƯỢC CHỈNH THÀNH 5000 (5km)
        local targets = getTargets(root, 5000) 
        if #targets > 0 then
            atk:FireServer()
            hit:FireServer(root, targets, nil, nil, tostring(os.clock()))
            play(tool)
        else
            stopAnim()
        end
    end
end)
