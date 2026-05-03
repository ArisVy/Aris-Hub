local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Cấu hình hiển thị ESP
local ESP_Settings = {
    Enabled = true,
    ShowName = true,
    ShowHealth = true,
    ShowPVP = true, 
    TextColor = Color3.fromRGB(0, 255, 255) -- Màu xanh cyan dễ nhìn trên Mobile
}

local espObjects = {}

-- Tạo đối tượng Text trên màn hình
local function createESP(player)
    local text = Drawing.new("Text")
    text.Visible = false
    text.Center = true
    text.Outline = true
    text.Font = 2
    text.Size = 16
    text.Color = ESP_Settings.TextColor
    espObjects[player] = text
end

-- Cập nhật vị trí và thông tin liên tục
local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if not espObjects[player] then
                createESP(player)
            end

            local text = espObjects[player]
            if ESP_Settings.Enabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                local hrp = player.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)

                if onScreen then
                    local distance = math.floor((Camera.CFrame.Position - hrp.Position).Magnitude)
                    local health = math.floor(player.Character.Humanoid.Health)
                    local maxHealth = math.floor(player.Character.Humanoid.MaxHealth)

                    -- Kiểm tra Bounty / Trạng thái cơ bản trong Blox Fruits
                    local pvpStatus = "PVP: Đang cập nhật"
                    if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Bounty") then
                        pvpStatus = "Bounty: " .. tostring(player.leaderstats.Bounty.Value)
                    end

                    local displayText = ""
                    if ESP_Settings.ShowName then displayText = displayText .. player.Name .. " [" .. distance .. "m]\n" end
                    if ESP_Settings.ShowHealth then displayText = displayText .. "HP: " .. health .. "/" .. maxHealth .. "\n" end
                    if ESP_Settings.ShowPVP then displayText = displayText .. pvpStatus end

                    text.Position = Vector2.new(vector.X, vector.Y)
                    text.Text = displayText
                    text.Visible = true
                else
                    text.Visible = false
                end
            else
                if text then text.Visible = false end
            end
        end
    end
end

-- Vòng lặp render mượt mà
RunService.RenderStepped:Connect(updateESP)

-- Xóa ESP khi người chơi thoát server
Players.PlayerRemoving:Connect(function(player)
    if espObjects[player] then
        espObjects[player]:Remove()
        espObjects[player] = nil
    end
end)
