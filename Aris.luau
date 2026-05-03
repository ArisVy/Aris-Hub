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
        textLabel.RichText = true
        textLabel.TextStrokeTransparency = 0

        billboard.Parent = hrp

        task.spawn(function()
            while character and character.Parent and billboard.Parent and humanoid.Health > 0 do
                local distance = 0
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                end
                
                local hp = math.floor(humanoid.Health)
                
                -- KIỂM TRA TRẠNG THÁI PVP TỪ FILE DATA CỦA BLOX FRUITS
                local pvpStatusText = "<font color='rgb(255, 50, 50)'>[PVP: BẬT]</font>"
                
                local playerData = player:FindFirstChild("Data")
                if playerData then
                    -- Quét file Pvp trong thư mục Data của người chơi
                    local pvpValue = playerData:FindFirstChild("Pvp") or playerData:FindFirstChild("PvP")
                    
                    if pvpValue then
                        -- Trong Blox Fruits, value này thường là số (0 là tắt) hoặc bool (false là tắt)
                        if pvpValue.Value == 0 or pvpValue.Value == false then
                            pvpStatusText = "<font color='rgb(50, 255, 50)'>[PVP: TẮT]</font>"
                        end
                    end
                end

                -- Bổ sung: Báo thêm nếu họ đang đứng trong Safe Zone (vì lúc này PVP bật cũng vô dụng)
                if player:GetAttribute("SafeZone") or (character:FindFirstChild("SafeZone")) then
                    pvpStatusText = "<font color='rgb(50, 255, 50)'>[SAFE ZONE]</font>"
                end

                if distance < 5000 then
                    textLabel.Text = string.format(
                        "<font color='rgb(0, 255, 255)'>%s [%dm]</font>\nHP: %d\n%s", 
                        player.Name, distance, hp, pvpStatusText
                    )
                    billboard.Enabled = true
                else
                    billboard.Enabled = false
                end

                task.wait(0.5) 
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
