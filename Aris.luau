-- Tham chiếu logic từ: Nexus full Ai source.txt

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- BIẾN ĐIỀU KHIỂN
local ESP_ENABLED = false
local ESP_STORAGE = {}

-- 1. TẠO MENU MOBILE (Nút bấm Bật/Tắt)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileNexusMenu"
ScreenGui.Parent = CoreGui

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.Text = "ESP: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = ScreenGui

-- Bo góc cho nút bấm
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = ToggleButton

-- 2. LOGIC KIỂM TRA TRẠNG THÁI PVP
local function GetPvPStatus(player)
    if not player.Character or not player.Character:FindFirstChild("Humanoid") then 
        return "OFF", Color3.fromRGB(200, 200, 200) 
    end

    -- Quét thuộc tính PvpDisabled của Blox Fruits
    local pvpDisabled = player:GetAttribute("PvpDisabled")
    -- Quét trạng thái giao tranh (InCombat)[cite: 1]
    local inCombat = player.Character:GetAttribute("InCombat")
    local isSafe = (inCombat ~= "1" and inCombat ~= "0")

    if pvpDisabled or isSafe then
        return "PvP: OFF", Color3.fromRGB(255, 255, 255) -- Trắng (An toàn)[cite: 1]
    else
        return "PvP: ON", Color3.fromRGB(255, 0, 0) -- Đỏ (Săn được)[cite: 1]
    end
end

-- 3. HÀM TẠO NHÃN ESP[cite: 1]
local function CreateESP(player)
    if ESP_STORAGE[player] then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.Adornee = player.Character:WaitForChild("Head", 5)
    billboard.AlwaysOnTop = true
    billboard.ExtentsOffset = Vector3.new(0, 3, 0)
    billboard.Enabled = ESP_ENABLED
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Parent = billboard
    
    billboard.Parent = player.Character
    ESP_STORAGE[player] = billboard

    -- Cập nhật trạng thái liên tục[cite: 1]
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not ESP_ENABLED or not player.Character or not player.Character:Parent then
            if not ESP_ENABLED then billboard.Enabled = false end
            return
        end
        billboard.Enabled = true
        local status, color = GetPvPStatus(player)
        label.Text = player.DisplayName .. "\n" .. status
        label.TextColor3 = color
    end)
end

-- 4. XỬ LÝ SỰ KIỆN BẬT/TẮT[cite: 1]
ToggleButton.MouseButton1Click:Connect(function()
    ESP_ENABLED = not ESP_ENABLED
    ToggleButton.Text = ESP_ENABLED and "ESP: ON" or "ESP: OFF"
    ToggleButton.BackgroundColor3 = ESP_ENABLED and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- Quét người chơi[cite: 1]
for _, p in pairs(Players:GetPlayers()) do
    if p ~= lp then
        p.CharacterAdded:Connect(function() CreateESP(p) end)
        if p.Character then CreateESP(p) end
    end
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() CreateESP(p) end)
end)
