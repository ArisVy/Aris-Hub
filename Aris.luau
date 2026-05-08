
-- Roblox Teleport Script V2.1
-- Cấu hình tọa độ
local targetX = -5139
local targetY = 170
local targetZ = -5800

-- Khởi tạo UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TeleportBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local ToggleBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")

-- Setup ScreenGui
ScreenGui.Name = "TeleportMenuV2"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- NÚT MENU (Vị trí 75% từ trái sang, giữa màn hình)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
-- Position: 0.75 (75% ngang), 0.5 (50% dọc)
ToggleBtn.Position = UDim2.new(0.75, 0, 0.5, 0) 
ToggleBtn.Size = UDim2.new(0, 70, 0, 35)
ToggleBtn.Text = "MENU"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14
ToggleBtn.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleBtn

-- KHUNG MENU CHÍNH
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75) -- Xuất hiện giữa màn hình
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Visible = false
MainFrame.Draggable = true

UICorner.Parent = MainFrame

-- NÚT TELEPORT
TeleportBtn.Name = "TeleportBtn"
TeleportBtn.Parent = MainFrame
TeleportBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
TeleportBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
TeleportBtn.Size = UDim2.new(0, 160, 0, 45)
TeleportBtn.Text = "TELEPORT"
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportBtn.Font = Enum.Font.SourceSansBold
TeleportBtn.TextSize = 18

UICorner2.Parent = TeleportBtn

-- NÚT ĐÓNG (X)
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0.8, 0, 0, 0)
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 20

-- XỬ LÝ LOGIC
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

TeleportBtn.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if rootPart then
        rootPart.CFrame = CFrame.new(targetX, targetY, targetZ)
    else
        warn("Không tìm thấy HumanoidRootPart!")
    end
end)
