local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local deadPlayersTracker = {}

local function createESP(player)
    if player == LocalPlayer then return end

    local function setupCharacter(character)
        -- Bao bọc bằng pcall: Nếu lỗi ở dòng nào, script vẫn chạy tiếp, không bị sập Hub
        pcall(function()
            local hrp = character:WaitForChild("HumanoidRootPart", 5)
            local humanoid = character:WaitForChild("Humanoid", 5)
            if not hrp or not humanoid then return end

            -- Ghi nhận lúc chết
            humanoid.Died:Connect(function()
                deadPlayersTracker[player.UserId] = tick()
            end)

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

            -- task.defer an toàn hơn task.spawn cho Mobile Executor
            task.defer(function() 
                while character and character.Parent and billboard.Parent and humanoid.Health > 0 do
                    pcall(function() -- Chống lỗi văng game trong vòng lặp
                        local distance = 0
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                        end
                        
                        local hp = math.floor(humanoid.Health)
                        local pvpStatusText = "<font color='rgb(255, 50, 50)'>[PVP: BẬT]</font>"
                        local isSafe = false

                        -- Xử lý Tracker
                        if deadPlayersTracker[player.UserId] then
                            local timePassed = tick() - deadPlayersTracker[player.UserId]
                            if timePassed < 900 then
                                local timeRemaining = math.floor((900 - timePassed) / 60)
                                pvpStatusText = string.format("<font color='rgb(50, 255, 50)'>[PVP: TẮT (%dp)]</font>", timeRemaining)
                                isSafe = true
                            else
                                deadPlayersTracker[player.UserId] = nil
                            end
                        end

                        -- Xử lý SafeZone
                        if not isSafe then
                            if character:FindFirstChild("SafeZone") or player:GetAttribute("SafeZone") then
                                pvpStatusText = "<font color='rgb(50, 255, 50)'>[SAFE ZONE]</font>"
                            end
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
                    end)
                    task.wait(0.5) 
                end
                
                if billboard then billboard:Destroy() end
            end)
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

Players.PlayerRemoving:Connect(function(player)
    if deadPlayersTracker[player.UserId] then
        deadPlayersTracker[player.UserId] = nil
    end
end)
