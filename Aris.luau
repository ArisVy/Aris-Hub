local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function createESP(player)
    if player == LocalPlayer then return end

    local function setupCharacter(character)
        -- Đợi một chút để server kịp gắn các tag bảo vệ sau khi hồi sinh
        task.wait(1) 
        
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
                
                -- MẶC ĐỊNH LÀ BẬT
                local pvpStatusText = "<font color='rgb(255, 50, 50)'>[PVP: BẬT]</font>"
                local isSafe = false

                -- 1. Quét file Data truyền thống
                local playerData = player:FindFirstChild("Data")
                if playerData then
                    local pvpValue = playerData:FindFirstChild("Pvp") or playerData:FindFirstChild("PvP")
                    if pvpValue and (pvpValue.Value == 0 or pvpValue.Value == false) then
                        isSafe = true
                    end
                end

                -- 2. Quét Attributes (Blox Fruits bản mới thường dùng cái này để đồng bộ server)
                if player:GetAttribute("Pvp") == false or player:GetAttribute("PvpDisabled") == true then
                    isSafe = true
                end

                -- 3. Quét các Tag ẩn trong nhân vật (Bảo vệ 15 phút hoặc SafeZone)
                if character:FindFirstChild("SafeZone") or player:GetAttribute("SafeZone") then
                    isSafe = true
                end
                if character:FindFirstChild("PvpDisabled") or character:FindFirstChild("Protection") then
                    isSafe = true
                end

                -- Gắn kết quả
                if isSafe then
                    pvpStatusText = "<font color='rgb(50, 255, 50)'>[PVP: TẮT / BẢO VỆ]</font>"
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
