local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TeleportBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local ToggleBtn = Instance.new("TextButton")

-- Cấu hình UI
ScreenGui.Name = "ArisMenu"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Nút Mở/Đóng Menu (Góc màn hình)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleBtn.Text = "Menu"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Draggable = true -- Có thể kéo nút này đi chỗ khác

-- Khung Menu chính
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.4, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Nút Teleport
TeleportBtn.Name = "TeleportBtn"
TeleportBtn.Parent = MainFrame
TeleportBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TeleportBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
TeleportBtn.Size = UDim2.new(0, 160, 0, 40)
TeleportBtn.Text = "Teleport to Pos"
TeleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Nút Đóng trong Menu
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.85, 0, 0, 0)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Chức năng Logic
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

TeleportBtn.MouseButton1Click:Connect(function()
    local targetPos = Vector3.new(-5139, 170, 5800)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
    end
end)
