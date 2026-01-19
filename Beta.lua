-- DỊCH VỤ HỆ THỐNG
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")

game:GetService("StarterGui"):SetCore("SendNotification",{Title="ARIS HUB V53.2 PRO",Text="Đã cập nhật Tab Aimlock & Fix WallCheck",Duration=5})

-- CẤU HÌNH
_G.Config = {
    -- Aimlock (Danh mục riêng)
    ShowAimButton = true,
    AimTeamCheck = true,
    AimWallCheck = false,
    
    -- ESP
    TeamCheck = true, -- Team check cho ESP
    ESP_Box_P = false, ESP_Name_P = true, ESP_Health_P = true, ESP_Chams_P = true, ESP_Distance_P = true,
    
    -- Hitbox
    Hitbox_P = false, HitboxSize = 15, SmartHitbox = true,
    
    -- Misc
    JumpForce = 150, Fullbright = false, ReduceLag = false,
    MenuOpen = false
}

local AimActive = false
local LockedTarget = nil

if CoreGui:FindFirstChild("ArisHUB_PRO") then CoreGui.ArisHUB_PRO:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local RainbowList = {}
local function GetRGB() return Color3.fromHSV(tick() % 5 / 5, 1, 1) end

----------------------------------------------------------------
-- 1. NÚT MỞ MENU (UI)
----------------------------------------------------------------
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

----------------------------------------------------------------
-- 2. NÚT AIM CHÍNH (NÚT BẤM ĐỂ KHÓA MỤC TIÊU)
----------------------------------------------------------------
local MainAimBtn = Instance.new("TextButton", ScreenGui)
MainAimBtn.Size = UDim2.new(0, 140, 0, 45)
MainAimBtn.Position = UDim2.new(0.24, 0, 0.13, 0) -- Vị trí bạn thích
MainAimBtn.Text = "Aris: OFF"
MainAimBtn.Font = Enum.Font.GothamBold
MainAimBtn.TextSize = 18
MainAimBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainAimBtn.BackgroundTransparency = 0.2
MainAimBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MainAimBtn).CornerRadius = UDim.new(0, 12)
local as = Instance.new("UIStroke", MainAimBtn)
as.Thickness = 2.5
table.insert(RainbowList, as)

----------------------------------------------------------------
-- 3. KHUNG MENU CHÍNH
----------------------------------------------------------------
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
Title.Text = "ARIS HUB V53.2 PRO"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.BackgroundTransparency = 1
table.insert(RainbowList, Title)

-- QUẢN LÝ TABS
local TabFrame = Instance.new("Frame", MainFrame)
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundTransparency = 1

local Tabs = {"Aimlock", "ESP", "Hitbox", "Misc"}
local ContentFrames = {}
local CurrentTab = "Aimlock"

for i, tabName in ipairs(Tabs) do
    local btn = Instance.new("TextButton", TabFrame)
    btn.Size = UDim2.new(0.25, 0, 1, 0)
    btn.Position = UDim2.new((i-1)*0.25, 0, 0, 0)
    btn.Text = tabName
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    table.insert(RainbowList, btn)
    
    local content = Instance.new("ScrollingFrame", MainFrame)
    content.Size = UDim2.new(1, -10, 1, -90)
    content.Position = UDim2.new(0, 5, 0, 80)
    content.BackgroundTransparency = 1
    content.CanvasSize = UDim2.new(0, 0, 0, 500)
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

-- XÂY DỰNG MENU
-- Tab Aimlock
AddToggle("Aimlock", "SHOW AIM BUTTON", "ShowAimButton")
AddToggle("Aimlock", "TEAM CHECK", "AimTeamCheck")
AddToggle("Aimlock", "WALL CHECK", "AimWallCheck")

-- Tab ESP
AddToggle("ESP", "TEAM CHECK", "TeamCheck")
AddToggle("ESP", "ESP NAME", "ESP_Name_P")
AddToggle("ESP", "ESP HEALTH", "ESP_Health_P")
AddToggle("ESP", "ESP CHAMS", "ESP_Chams_P")

-- Tab Hitbox
AddToggle("Hitbox", "HITBOX PLAYER", "Hitbox_P")
AddToggle("Hitbox", "SMART HITBOX", "SmartHitbox")

-- Tab Misc
AddToggle("Misc", "FULLBRIGHT", "Fullbright")
AddToggle("Misc", "REDUCE LAG", "ReduceLag")

----------------------------------------------------------------
-- 4. LOGIC AIMLOCK (TỪ V10)
----------------------------------------------------------------
local function IsVisible(targetChar)
    if not _G.Config.AimWallCheck then return true end
    local hrp = targetChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    local result = Workspace:Raycast(Camera.CFrame.Position, hrp.Position - Camera.CFrame.Position, rayParams)
    return not result or result.Instance:IsDescendantOf(targetChar)
end

local function GetClosestToMouse()
    local target, dist = nil, math.huge
    local mouseLoc = UserInputService:GetMouseLocation()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health <= 0 then continue end
            if _G.Config.AimTeamCheck and p.Team == LocalPlayer.Team then continue end
            local screenPos, onScreen = Camera:WorldToViewportPoint(p.Character.HumanoidRootPart.Position)
            if onScreen and IsVisible(p.Character) then
                local mDist = (Vector2.new(screenPos.X, screenPos.Y) - mouseLoc).Magnitude
                if mDist < dist then dist = mDist target = p end
            end
        end
    end
    return target
end

MainAimBtn.MouseButton1Click:Connect(function()
    AimActive = not AimActive
    if AimActive then
        LockedTarget = GetClosestToMouse()
        if LockedTarget then
            MainAimBtn.Text = "LOCKED"
            MainAimBtn.TextColor3 = Color3.new(0, 1, 0)
        else
            AimActive = false
            MainAimBtn.Text = "NO TARGET"
            task.delay(0.5, function() MainAimBtn.Text = "Aris: OFF" MainAimBtn.TextColor3 = Color3.new(1,1,1) end)
        end
    else
        LockedTarget = nil
        MainAimBtn.Text = "Aris: OFF"
        MainAimBtn.TextColor3 = Color3.new(1,1,1)
    end
end)

----------------------------------------------------------------
-- 5. VÒNG LẶP CHÍNH (RENDER)
----------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    local rgb = GetRGB()
    for _, v in pairs(RainbowList) do
        if v:IsA("UIStroke") then v.Color = rgb
        elseif v:IsA("TextLabel") or v:IsA("TextButton") then v.TextColor3 = rgb end
    end

    -- Ẩn hiện Aim Button theo Menu
    MainAimBtn.Visible = _G.Config.ShowAimButton
    
    -- Xử lý khóa Camera
    if AimActive and LockedTarget and LockedTarget.Character and LockedTarget.Character:FindFirstChild("HumanoidRootPart") then
        if LockedTarget.Character.Humanoid.Health > 0 then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, LockedTarget.Character.HumanoidRootPart.Position)
        else
            AimActive = false
            LockedTarget = nil
            MainAimBtn.Text = "Aris: OFF"
            MainAimBtn.TextColor3 = Color3.new(1,1,1)
        end
    end
end)

-- (Các logic ESP và Hitbox giữ nguyên từ bản V53.1 nhưng dùng _G.Config mới)
RunService.Heartbeat:Connect(function()
    if _G.Config.Fullbright then Lighting.Brightness = 2 Lighting.ClockTime = 14 end
    for _, p in Players:GetPlayers() do
        if p == LocalPlayer then continue end
        local char = p.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then continue end
        
        -- ESP Team Check
        local isFriendly = (_G.Config.TeamCheck and p.Team == LocalPlayer.Team)
        
        -- Chams
        if _G.Config.ESP_Chams_P and not isFriendly and char.Humanoid.Health > 0 then
            local hl = char:FindFirstChild("ArisHL") or Instance.new("Highlight", char)
            hl.Name = "ArisHL" hl.FillColor = GetRGB() hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        elseif char:FindFirstChild("ArisHL") then char.ArisHL:Destroy() end
        
        -- Hitbox
        if _G.Config.Hitbox_P and not isFriendly and char.Humanoid.Health > 0 then
            char.HumanoidRootPart.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
            char.HumanoidRootPart.Transparency = 0.6
            char.HumanoidRootPart.CanCollide = false
        elseif char.HumanoidRootPart.Size.X > 5 then
            char.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
            char.HumanoidRootPart.Transparency = 1
            char.HumanoidRootPart.CanCollide = true
        end
    end
end)
