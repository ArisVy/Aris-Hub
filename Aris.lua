-- DỊCH VỤ HỆ THỐNG
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

game:GetService("StarterGui"):SetCore("SendNotification",{Title="ARIS HUB V53.1 PRO",Text="Đã tải - Không có Aimbot",Duration=5})

-- CẤU HÌNH (Loại bỏ DraggableMode)
_G.Config = {
    TeamCheck = true, 
    WallCheck = false,
    ShowPushBtn = true,
    ESP_Box_P = false, ESP_Name_P = true, ESP_Health_P = true, ESP_Chams_P = true, ESP_Distance_P = true,
    Hitbox_P = false, HitboxSize = 15, SmartHitbox = true,
    JumpForce = 150, Fullbright = false, ReduceLag = false,
    MenuOpen = false
}

if CoreGui:FindFirstChild("ArisHUB_PRO") then CoreGui.ArisHUB_PRO:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99999
ScreenGui.Parent = CoreGui

local RainbowList = {}
local function GetRGB() return Color3.fromHSV(tick() % 5 / 5, 1, 1) end

-- NÚT MỞ MENU (không draggable)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
ToggleBtn.Text = "UI"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 12)
local ts = Instance.new("UIStroke", ToggleBtn)
ts.Thickness = 3
table.insert(RainbowList, ts)

-- KHUNG MENU CHÍNH (không draggable)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.Position = UDim2.new(0, 70, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", MainFrame)
ms.Thickness = 3
table.insert(RainbowList, ms)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.Config.MenuOpen = not _G.Config.MenuOpen
    MainFrame.Visible = _G.Config.MenuOpen
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ARIS HUB V53.1 PRO"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.BackgroundTransparency = 1
table.insert(RainbowList, Title)

-- QUẢN LÝ TABS
local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundTransparency = 1

local Tabs = {"ESP", "Hitbox", "Misc", "Visual"}
local ContentFrames = {}
local CurrentTab = "ESP"

for i, tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton", TabFrame)
    btn.Size = UDim2.new(0.25, 0, 1, 0)
    btn.Position = UDim2.new((i-1)*0.25, 0, 0, 0)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    table.insert(RainbowList, btn)
    
    local content = Instance.new("ScrollingFrame", MainFrame)
    content.Size = UDim2.new(1, -10, 1, -90)
    content.Position = UDim2.new(0, 5, 0, 80)
    content.BackgroundTransparency = 1
    content.CanvasSize = UDim2.new(0, 0, 0, 600)
    content.Visible = (tabName == CurrentTab)
    ContentFrames[tabName] = {Frame = content, Y = 10}
    
    btn.MouseButton1Click:Connect(function()
        for _, f in pairs(ContentFrames) do f.Frame.Visible = false end
        content.Visible = true
        CurrentTab = tabName
    end)
end

-- HÀM THÊM NÚT BẬT TẮT
local function AddToggle(tab, name, key, cb)
    local y = ContentFrames[tab].Y
    local btn = Instance.new("TextButton", ContentFrames[tab].Frame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    table.insert(RainbowList, btn)
    btn.MouseButton1Click:Connect(function()
        _G.Config[key] = not _G.Config[key]
        btn.Text = name .. ": " .. (_G.Config[key] and "ON" or "OFF")
        btn.BackgroundColor3 = _G.Config[key] and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 40, 40)
        if cb then cb() end
    end)
    if _G.Config[key] then 
        btn.Text = name .. ": ON"
        btn.BackgroundColor3 = Color3.fromRGB(40, 100, 40) 
    end
    ContentFrames[tab].Y = y + 45
end

-- HÀM THÊM THANH CHỈNH SỐ
local function AddAdjust(tab, name, key, step)
    local y = ContentFrames[tab].Y
    local frame = Instance.new("Frame", ContentFrames[tab].Frame)
    frame.Size = UDim2.new(1, -20, 0, 35)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0.2, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. _G.Config[key]
    label.Font = Enum.Font.GothamBold
    table.insert(RainbowList, label)
    local minus = Instance.new("TextButton", frame)
    minus.Size = UDim2.new(0.2, -5, 1, 0)
    minus.Text = "-"
    minus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", minus)
    minus.MouseButton1Click:Connect(function()
        _G.Config[key] = math.max(5, _G.Config[key] - step)
        label.Text = name .. ": " .. _G.Config[key]
    end)
    local plus = Instance.new("TextButton", frame)
    plus.Size = UDim2.new(0.2, -5, 1, 0)
    plus.Position = UDim2.new(0.8, 5, 0, 0)
    plus.Text = "+"
    plus.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", plus)
    plus.MouseButton1Click:Connect(function()
        _G.Config[key] = _G.Config[key] + step
        label.Text = name .. ": " .. _G.Config[key]
    end)
    ContentFrames[tab].Y = y + 45
end

-- XÂY DỰNG MENU
AddToggle("ESP", "ESP NAME", "ESP_Name_P")
AddToggle("ESP", "ESP HEALTH", "ESP_Health_P")
AddToggle("ESP", "ESP DISTANCE", "ESP_Distance_P")
AddToggle("ESP", "ESP BOX", "ESP_Box_P")
AddToggle("ESP", "ESP CHAMS", "ESP_Chams_P")

AddToggle("Hitbox", "HITBOX PLAYER", "Hitbox_P")
AddToggle("Hitbox", "SMART HITBOX", "SmartHitbox")
AddAdjust("Hitbox", "HITBOX SIZE", "HitboxSize", 5)

AddToggle("Misc", "TEAM CHECK", "TeamCheck")
AddToggle("Misc", "FULLBRIGHT", "Fullbright")
AddToggle("Misc", "REDUCE LAG", "ReduceLag", function()
    if _G.Config.ReduceLag then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then 
                v.Enabled = false 
            end
        end
        Lighting.GlobalShadows = false
    end
end)
AddAdjust("Misc", "PUSH FORCE", "JumpForce", 50)

AddToggle("Visual", "SHOW PUSH BTN", "ShowPushBtn")

-- NÚT PUSH (không draggable)
local PushBtn = Instance.new("TextButton", ScreenGui)
PushBtn.Size = UDim2.new(0, 70, 0, 70)
PushBtn.Position = UDim2.new(0.85, 0, 0.6, 0)
PushBtn.Text = "PUSH"
PushBtn.Font = Enum.Font.GothamBlack
Instance.new("UICorner", PushBtn).CornerRadius = UDim.new(1, 0)
local ps = Instance.new("UIStroke", PushBtn)
ps.Thickness = 4
table.insert(RainbowList, ps)
PushBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp:ApplyImpulse(Vector3.new(0, hrp.AssemblyMass * _G.Config.JumpForce, 0))
    end
end)

-- QUẢN LÝ ESP & HITBOX
local ESP_Store = {}
local function GetHealthColor(pct)
    if pct > 0.7 then return Color3.new(0, 1, 0)
    elseif pct > 0.3 then return Color3.new(1, 1, 0)
    else return Color3.new(1, 0, 0) end
end

-- Cleanup khi người chơi rời hoặc character mất
Players.PlayerRemoving:Connect(function(p)
    if ESP_Store[p] then
        if ESP_Store[p].Box then ESP_Store[p].Box:Destroy() end
        if ESP_Store[p].Bill then ESP_Store[p].Bill:Destroy() end
        ESP_Store[p] = nil
    end
end)

-- VÒNG LẶP CHÍNH
RunService.Heartbeat:Connect(function()
    local rgb = GetRGB()
    for _, v in pairs(RainbowList) do
        if v:IsA("UIStroke") then 
            v.Color = rgb
        elseif v:IsA("TextLabel") or v:IsA("TextButton") then 
            v.TextColor3 = rgb 
        end
    end
    
    PushBtn.Visible = _G.Config.ShowPushBtn
    if _G.Config.Fullbright then 
        Lighting.Brightness = 2
        Lighting.ClockTime = 14 
    end
    
    for _, p in Players:GetPlayers() do
        if p == LocalPlayer then continue end
        local char = p.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then
            if ESP_Store[p] then 
                ESP_Store[p].Box.Visible = false
                ESP_Store[p].Bill.Enabled = false 
            end
            continue
        end
        
        local hrp = char.HumanoidRootPart
        local head = char:FindFirstChild("Head") or hrp
        local hum = char.Humanoid
        
        -- HITBOX LOGIC (ĐÃ FIX CHẾT)
        if _G.Config.Hitbox_P and hum.Health > 0 and hum:GetState() ~= Enum.HumanoidStateType.Dead then
            
            if _G.Config.TeamCheck and p.Team == LocalPlayer.Team then
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 1
                hrp.CanCollide = true
            else
                local isVisible = true
                
                if _G.Config.SmartHitbox then
                    local rayParams = RaycastParams.new()
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude
                    rayParams.FilterDescendantsInstances = {LocalPlayer.Character or game, char}
                    
                    local ray = workspace:Raycast(Camera.CFrame.Position, hrp.Position - Camera.CFrame.Position, rayParams)
                    if ray then isVisible = false end
                end
                
                if isVisible then
                    hrp.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                    hrp.Transparency = 0.6
                    hrp.CanCollide = false
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    hrp.CanCollide = true
                end
            end
        else
            hrp.Size = Vector3.new(2, 2, 1)
            hrp.Transparency = 1
            hrp.CanCollide = true
        end

        -- CHAMS
        if _G.Config.ESP_Chams_P then
            local hl = char:FindFirstChild("ArisHL") or Instance.new("Highlight", char)
            hl.Name = "ArisHL"
            hl.FillColor = rgb
            hl.OutlineTransparency = 0
        elseif char:FindFirstChild("ArisHL") then 
            char.ArisHL:Destroy() 
        end

        -- ESP BOX + BILLBOARD
        if _G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Box_P then
            if not ESP_Store[p] then
                local box = Instance.new("BoxHandleAdornment", ScreenGui)
                box.Adornee = hrp
                box.AlwaysOnTop = true
                box.ZIndex = 10
                box.Transparency = 0.5
                
                local bill = Instance.new("BillboardGui", ScreenGui)
                bill.Adornee = head
                bill.Size = UDim2.new(0, 200, 0, 60)
                bill.AlwaysOnTop = true
                
                local txt = Instance.new("TextLabel", bill)
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.Font = Enum.Font.GothamBold
                txt.TextSize = 12
                
                ESP_Store[p] = {Box = box, Bill = bill, Text = txt}
            end
            
            local s = ESP_Store[p]
            s.Box.Visible = _G.Config.ESP_Box_P
            s.Box.Color3 = rgb
            s.Bill.Enabled = true
            
            local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
            s.Text.Text = 
                (_G.Config.ESP_Name_P and p.Name or "") .. "\n" ..
                (_G.Config.ESP_Health_P and "HP: "..math.floor(hum.Health) or "") .. "\n" ..
                (_G.Config.ESP_Distance_P and "Dist: "..dist.."m" or "")
            s.Text.TextColor3 = GetHealthColor(hum.Health / hum.MaxHealth)
        end
    end
end)
