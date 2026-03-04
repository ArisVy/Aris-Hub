.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingDash = false
    end
end)

-- Logic Dash
local function PerformDash()
    if not canDash or not _G.Config.AutoDash then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end

    canDash = false
    TweenService:Create(DashButton, TweenInfo.new(0.1), {Size = UDim2.new(0, buttonSize-10, 0, buttonSize-10)}):Play()

    local direction = Camera.CFrame.LookVector
    local attachment = Instance.new("Attachment", root)
    local lv = Instance.new("LinearVelocity", root)
    lv.MaxForce = 999999999
    lv.Attachment0 = attachment
    lv.VectorVelocity = direction * dashPower

    task.spawn(function()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part ~= root then
                TweenService:Create(part, TweenInfo.new(0.15), {LocalTransparencyModifier = 0.4}):Play()
            end
        end
    end)

    task.delay(dashDuration, function()
        lv:Destroy()
        attachment:Destroy()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.LocalTransparencyModifier = 0 end
        end
        TweenService:Create(DashButton, TweenInfo.new(0.2), {Size = UDim2.new(0, buttonSize, 0, buttonSize)}):Play()
        canDash = true
    end)
end

DashButton.MouseButton1Click:Connect(PerformDash)
DashButton.TouchTap:Connect(PerformDash)

-- ==========================================
-- LOGIC CORE (ESP + HITBOX + CHAMS + NPC) - giữ nguyên từ trước
-- ==========================================
local Player_ESP_Cache = {}
local NPC_Cache = {}

local function RemovePlayerESP(p)
    if Player_ESP_Cache[p] then
        if Player_ESP_Cache[p].Box then Player_ESP_Cache[p].Box:Destroy() end
        if Player_ESP_Cache[p].Bill then Player_ESP_Cache[p].Bill:Destroy() end
        Player_ESP_Cache[p] = nil
    end
end

Players.PlayerRemoving:Connect(function(player)
    RemovePlayerESP(player)
end)

local function onCharacterAdded(char, player)
    RemovePlayerESP(player)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(char) onCharacterAdded(char, p) end)
        if p.Character then onCharacterAdded(p.Character, p) end
    end
end

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function(char) onCharacterAdded(char, p) end)
    end
end)

task.spawn(function()
    while true do
        local tempNPC = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                if not Players:GetPlayerFromCharacter(v) and v.Humanoid.Health > 0 then
                    tempNPC[v] = true
                end
            end
        end
        NPC_Cache = tempNPC
        task.wait(3)
    end
end)

task.spawn(function()
    while true do
        task.wait(12)
        for player, _ in pairs(Player_ESP_Cache) do
            if not player.Parent or not player.Character or not player.Character.Parent then
                RemovePlayerESP(player)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local rgb = GetRGB()
    
    for _, v in pairs(RainbowList) do
        if v:IsA("UIStroke") then v.Color = rgb
        elseif v:IsA("TextLabel") or v:IsA("TextButton") then v.TextColor3 = rgb end
    end
    
    if _G.Config.Fullbright then 
        Lighting.Brightness = 2 
        Lighting.ClockTime = 14 
    end

    local playerRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        
        local char = p.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildWhichIsA("Humanoid")
        
        if not char or not char.Parent or not hrp or not hrp.Parent or not hum or hum.Health <= 0 
           or not p.Parent 
           or (_G.Config.TeamCheck and p.Team == LocalPlayer.Team) then
           
            RemovePlayerESP(p)
            if hrp and hrp.Parent and hrp.Size.X > 5 then
                hrp.Size = Vector3.new(2,2,1)
                hrp.Transparency = 1
                hrp.CanCollide = true
            end
            continue
        end

        if not Player_ESP_Cache[p] then
            local b = Instance.new("BoxHandleAdornment")
            b.Parent = ScreenGui
            b.AlwaysOnTop = true
            b.ZIndex = 10
            
            local bl = Instance.new("BillboardGui")
            bl.Parent = ScreenGui
            bl.Size = UDim2.new(0,200,0,60)
            bl.AlwaysOnTop = true
            
            local t = Instance.new("TextLabel", bl)
            t.Size = UDim2.new(1,0,1,0)
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamBold
            t.TextSize = 12
            
            Player_ESP_Cache[p] = {Box = b, Bill = bl, Text = t}
        end

        local esp = Player_ESP_Cache[p]
        esp.Box.Adornee = hrp
        esp.Box.Visible = _G.Config.ESP_Box_P
        esp.Box.Color3 = rgb
        esp.Box.Size = hrp.Size
        
        esp.Bill.Adornee = char:FindFirstChild("Head") or hrp
        esp.Bill.Enabled = true
        
        local d = math.floor((playerRoot and (playerRoot.Position - hrp.Position).Magnitude) or 0)
        esp.Text.Text = string.format("%s\n%s\n%s", 
            (_G.Config.ESP_Name_P and p.Name or ""),
            (_G.Config.ESP_Health_P and "HP: "..math.floor(hum.Health) or ""),
            (_G.Config.ESP_Distance_P and "Dist: "..d.."m" or "")
        )
        esp.Text.TextColor3 = Color3.fromHSV((hum.Health/hum.MaxHealth)*0.3, 1, 1)

        if _G.Config.Hitbox_P and playerRoot then
            loca
