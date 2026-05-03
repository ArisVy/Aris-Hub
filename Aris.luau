-- Tham chiếu logic quét từ: Nexus full Ai source.txt

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Hàm kiểm tra trạng thái PvP thực tế của mục tiêu
local function GetPvPStatus(player)
    if not player.Character or not player.Character:FindFirstChild("Humanoid") then 
        return "OFFLINE", Color3.fromRGB(150, 150, 150) 
    end

    -- 1. Kiểm tra Attribute PvpDisabled của hệ thống Blox Fruits
    local pvpDisabled = player:GetAttribute("PvpDisabled")
    
    -- 2. Kiểm tra nếu mục tiêu đang trong vùng an toàn (Safe Zone)
    -- Logic Nexus: Nếu không có InCombat và ở gần SafeZone thì coi như PvP OFF
    local inCombat = player.Character:GetAttribute("InCombat")
    local isSafe = (inCombat ~= "1" and inCombat ~= "0") -- Không trong giao tranh[cite: 1]

    if pvpDisabled then
        return "PvP: OFF (Bảo vệ)", Color3.fromRGB(255, 255, 255) -- Trắng[cite: 1]
    elseif isSafe then
        return "PvP: SAFE ZONE", Color3.fromRGB(255, 255, 0) -- Vàng[cite: 1]
    else
        return "PvP: ON (Mục tiêu)", Color3.fromRGB(255, 0, 0) -- Đỏ[cite: 1]
    end
end

-- Tạo giao diện ESP hiển thị trạng thái[cite: 1]
local function ApplyESP(player)
    local folder = Instance.new("BillboardGui")
    folder.Name = "NexusStatusESP"
    folder.Size = UDim2.new(0, 100, 0, 50)
    folder.Adornee = player.Character:FindFirstChild("Head")
    folder.AlwaysOnTop = true
    folder.ExtentsOffset = Vector3.new(0, 3, 0)
    folder.Parent = player.Character

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 1, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 12
    statusLabel.Parent = folder

    -- Cập nhật trạng thái liên tục theo thời gian thực[cite: 1]
    local updateConn
    updateConn = RunService.RenderStepped:Connect(function()
        if not player.Character or not player.Character:Parent then
            updateConn:Disconnect()
            folder:Destroy()
            return
        end
        
        local statusText, statusColor = GetPvPStatus(player)
        statusLabel.Text = player.DisplayName .. "\n" .. statusText
        statusLabel.TextColor3 = statusColor
    end)
end

-- Khởi tạo quét toàn bộ Server[cite: 1]
for _, p in pairs(Players:GetPlayers()) do
    if p ~= lp then
        p.CharacterAdded:Connect(function()
            task.wait(1)
            ApplyESP(p)
        end)
        if p.Character then ApplyESP(p) end
    end
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function()
        task.wait(1)
        ApplyESP(p)
    end)
end)
