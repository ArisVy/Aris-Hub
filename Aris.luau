local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createESP(player)
    if player == LocalPlayer then return end

    local function setupCharacter(character)
        local hrp = character:WaitForChild("HumanoidRootPart", 5)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if not hrp or not humanoid then return end

        if hrp:FindFirstChild("ESP_Mobile_Optimized") then
            hrp.ESP_Mobile_Optimized:Destroy()
        end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Mobile_Optimized"
        billboard.Adornee = hrp
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3.5, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.BackgroundTransparency = 1
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Font = Enum.Font.Code
        textLabel.TextSize = 14
        textLabel.RichText = true -- Bật RichText để đổi màu từng chữ
        textLabel.TextStrokeTransparency = 0

        billboard.Parent = hrp

        task.spawn(function()
            while character and character.Parent and billboard.Parent and humanoid.Health > 0 do
                local distance = 0
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                end
                
                local hp = math.floor(humanoid.Health)
                
                -- KIỂM TRA TRẠNG THÁI PVP BẬT/TẮT
                local pvpStatusText = "<font color='rgb(255, 50, 50)'>[PVP: BẬT]</font>" -- Mặc định là Đỏ (Bật)
                
                -- Kiểm tra khiên bảo vệ (mới hồi sinh) hoặc các tag SafeZone của Blox Fruits
                if character:FindFirstChildOfClass("ForceField") or character:FindFirstChild("SafeZone") then
                    pvpStatusText = "<font color='rgb(50, 255, 50)'>[PVP: TẮT]</font>" -- Xanh lá (Tắt/An toàn)
                end

                if distance < 5000 then
                    -- Hiển thị Tên, Máu và Trạng thái PVP
                    textLabel.Text = string.format(
                        "<font color='rgb(0, 255, 255)'>%s [%dm]</font>\nHP: %d\n%s", 
                        player.Name, distance, hp, pvpStatusText
                    )
                    billboard.Enabled = true
                else
                    billboard.Enabled = false
                end

                task.wait(0.5) -- Giữ nguyên delay để chống lag cho Delta Mobile
            end
            
            if billboard then billboard:Destroy() end
        end)
    end

    if player.Character then
        setupCharacter(player.Character)
    end
    player.CharacterAdded:Connect(setupCharacter)
end

for _, p in pairs(Players:GetPlayers()) do
    createESP(p)
end

Players.PlayerAdded:Connect(createESP)
