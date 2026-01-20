--[[
    ARIS HUB X GEMINI PRO - V17 (FORCE BUNNYHOP FIX)
    - Fix Auto Jump: Dùng ChangeState ép nhân vật nhảy ngay khi chạm đất.
    - No Lag Reduce: Giữ nguyên đồ họa.
]]

-- 0. DỌN DẸP & CHUẨN BỊ
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

local OldUI = CoreGui:FindFirstChild("ArisHub_Unique")
if OldUI then OldUI:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHub_Unique"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- 1. FPS & NAME UI
local FPSLabel = Instance.new("TextLabel", ScreenGui)
FPSLabel.Size = UDim2.new(0, 80, 0, 25)
FPSLabel.Position = UDim2.new(0.5, -40, 0, 10)
FPSLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FPSLabel.BackgroundTransparency = 0.5
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
FPSLabel.Font = Enum.Font.Code
FPSLabel.TextSize = 14
FPSLabel.Text = "FPS: ..."
Instance.new("UICorner", FPSLabel)

local NameLabel = Instance.new("TextLabel", ScreenGui)
NameLabel.Size = UDim2.new(0, 150, 0, 20)
NameLabel.Position = UDim2.new(0, 10, 1, -30)
NameLabel.BackgroundTransparency = 1
NameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
NameLabel.Font = Enum.Font.SourceSans
NameLabel.TextSize = 12
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.Text = "Aris Hub x Gemini Pro V17"

-- 2. NÚT AUTO JUMP (RGB)
local AutoJumpBtn = Instance.new("TextButton", ScreenGui)
local RGBOutline = Instance.new("UIStroke", AutoJumpBtn)
local IsAutoJumping = false

AutoJumpBtn.Name = "AutoJumpBtn"
AutoJumpBtn.Position = UDim2.new(1, -115, 1, -210) 
AutoJumpBtn.Size = UDim2.new(0, 80, 0, 80)
AutoJumpBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
AutoJumpBtn.BackgroundTransparency = 0.2
AutoJumpBtn.Text = "AUTO\nJUMP: OFF"
AutoJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoJumpBtn.Font = Enum.Font.SourceSansBold
AutoJumpBtn.TextSize = 16
Instance.new("UICorner", AutoJumpBtn).CornerRadius = UDim.new(1, 0)

RGBOutline.Thickness = 4
RGBOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- RGB Loop
task.spawn(function()
    local h = 0
    while true do
        RGBOutline.Color = Color3.fromHSV(h, 1, 1)
        h = h + 0.01; if h >= 1 then h = 0 end
        task.wait(0.02)
    end
end)

-- 3. LOGIC AUTO JUMP MỚI (FORCE STATE BUNNYHOP)
-- Dùng Heartbeat để check vật lý chuẩn hơn RenderStepped
RunService.Heartbeat:Connect(function()
    if IsAutoJumping and Player.Character then
        local hum = Player.Character:FindFirstChild("Humanoid")
        -- Check nếu Humanoid tồn tại và đang chạm đất (FloorMaterial không phải Air)
        if hum and hum.FloorMaterial ~= Enum.Material.Air then
            -- Ép đổi trạng thái sang JUMPING ngay lập tức
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            hum.Jump = true -- Backup thêm lệnh này
        end
    end
end)

AutoJumpBtn.MouseButton1Click:Connect(function()
    IsAutoJumping = not IsAutoJumping
    if IsAutoJumping then
        AutoJumpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        AutoJumpBtn.Text = "AUTO\nJUMP: ON"
    else
        AutoJumpBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        AutoJumpBtn.Text = "AUTO\nJUMP: OFF"
    end
end)

-- 4. FPS Loop
local lastUpdate = tick()
local frames = 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastUpdate >= 1 then
        FPSLabel.Text = "FPS: " .. frames
        frames = 0
        lastUpdate = tick()
    end
end)
