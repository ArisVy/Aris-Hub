-- DỊCH VỤ HỆ THỐNG
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- THÔNG BÁO
StarterGui:SetCore("SendNotification",{
    Title = "ARIS HUB V57.5 - CLEAN + WALLCHECK",
    Text = "Added WallCheck Toggle + Hitbox Default 150 + Ghost Fixed\n(ESP Box removed)",
    Duration = 6
})

-- CẤU HÌNH GỐC
_G.Config = {
    TeamCheck = true,
    WallCheck = false,
    
    -- Player Visual
    ESP_Name_P = true, 
    ESP_Health_P = true, 
    ESP_Chams_P = true, 
    ESP_Distance_P = true,
    Hitbox_P = false, 
    HitboxSize = 150,
    
    -- NPC/Sea Event Visual
    Hitbox_NPC = false, 
    HitboxSize_NPC = 150,
    ESP_NPC_Chams = false,
    
    -- Misc
    Fullbright = false, 
    MenuOpen = false
}

-- DỌN DẸP UI CŨ
if CoreGui:FindFirstChild("ArisHUB_PRO") then CoreGui.ArisHUB_PRO:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

local RainbowList = {}
local function GetRGB() return Color3.fromHSV(tick() % 5 / 5, 1, 1) end

-- ==========================================
-- WALL CHECK (Line of Sight) - Tối ưu cache
-- ==========================================
local LastCheckTime = {}
local LastCheckResult = {}

local function CanSeeTarget(targetRoot)
    if not targetRoot or not Camera or not LocalPlayer.Character then return false end
    
    local now = tick()
    local key = tostring(targetRoot)
    
    if LastCheckTime[key] and now - LastCheckTime[key] < 0.18 then
        return LastCheckResult[key] or false
    end
    
    local origin = Camera.CFrame.Position
    local direction = (targetRoot.Position - origin)
    local distance = direction.Magnitude
    direction = direction.Unit * (distance + 5)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    
    local canSee = false
    if result and result.Instance then
        if result.Instance:IsDescendantOf(targetRoot.Parent) then
            canSee = true
        end
    else
        canSee = true
    end
    
    LastCheckTime[key] = now
    LastCheckResult[key] = canSee
    return canSee
end

-- ==========================================
-- PHẦN 1: GIAO DIỆN (UI) - ĐÃ XÓA ESP BOX
-- ==========================================
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

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 450)
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
Title.Text = "ARIS HUB V57.5 - NO BOX + WALLCHECK"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.BackgroundTransparency = 1
table.insert(RainbowList, Title)

-- TABS
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
    btn.TextSize = 12
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
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

-- HELPER FUNCTIONS
local function AddToggle(tab, name, key, callback)
    local y = ContentFrames[tab].Y
    local btn = Instance.new("TextButton", ContentFrames[tab].Frame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Text = name .. ": " .. (_G.Config[key] and "ON" or "OFF")
    btn.BackgroundColor3 = _G.Config[key] and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(80, 40, 40)
    Instance.new("UICorner", btn)
    table.insert(RainbowList, btn)
    
    btn.MouseButton1Click:Connect(function()
        _G.Config[key] = not _G.Config[key]
        btn.Text = name .. ": " .. (_G.Config[key] and "ON" or "OFF")
        btn.BackgroundColor3 = _G.Config[key] and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(80, 40, 40)
        if callback then callback(_G.Config[key]) end
    end)
    ContentFrames[tab].Y = y + 40
end

local function AddAdjust(tab, name, key, step)
    local y = ContentFrames[tab].Y
    local f = Instance.new("Frame", ContentFrames[tab].Frame)
    f.Size = UDim2.new(1, -20, 0, 35)
    f.Position = UDim2.new(0, 10, 0, y)
    f.BackgroundTransparency = 1
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.6, 0, 1, 0)
    l.Position = UDim2.new(0.2, 0, 0, 0)
    l.Text = name .. ": " .. _G.Config[key]
    l.BackgroundTransparency = 1
    table.insert(RainbowList, l)
    local m = Instance.new("TextButton", f)
    m.Size = UDim2.new(0.2, -5, 1, 0)
    m.Text = "-"
    m.MouseButton1Click:Connect(function() 
        _G.Config[key] = math.max(1, _G.Config[key] - step); 
        l.Text = name..": ".._G.Config[key] 
    end)
    local p = Instance.new("TextButton", f)
    p.Size = UDim2.new(0.2, -5, 1, 0)
    p.Position = UDim2.new(0.8, 5, 0, 0)
    p.Text = "+"
    p.MouseButton1Click:Connect(function() 
        _G.Config[key] = _G.Config[key] + step; 
        l.Text = name..": ".._G.Config[key] 
    end)
    ContentFrames[tab].Y = y + 40
end

-- MENU ITEMS
AddToggle("ESP", "ESP NAME (P)", "ESP_Name_P")
AddToggle("ESP", "ESP HEALTH (P)", "ESP_Health_P")
AddToggle("ESP", "ESP DISTANCE (P)", "ESP_Distance_P")
AddToggle("ESP", "ESP CHAMS (P)", "ESP_Chams_P")

AddToggle("Hitbox", "HITBOX PLAYER", "Hitbox_P")
AddAdjust("Hitbox", "SIZE PLAYER", "HitboxSize", 10)

AddToggle("Hitbox", "HITBOX NPC/SEA", "Hitbox_NPC")
AddAdjust("Hitbox", "SIZE NPC/SEA", "HitboxSize_NPC", 10)

AddToggle("Visual", "ESP CHAMS NPC", "ESP_NPC_Chams")

AddToggle("Misc", "TEAM CHECK", "TeamCheck")
AddToggle("Misc", "WALL CHECK", "WallCheck")
AddToggle("Misc", "FULLBRIGHT", "Fullbright")

-- ==========================================
-- PHẦN 2: LOGIC XỬ LÝ (CORE)
-- ==========================================
local Player_ESP_Cache = {}
local NPC_Cache = {}

local function ClearPlayerESP(player)
    if Player_ESP_Cache[player] then
        if Player_ESP_Cache[player].Bill then Player_ESP_Cache[player].Bill:Destroy() end
        Player_ESP_Cache[player] = nil
    end
    if player.Character and player.Character:FindFirstChild("Aris_HL") then
        player.Character.Aris_HL:Destroy()
    end
end

local function ClearNPCVisual(npc)
    if npc:FindFirstChild("ArisNPC_HL") then npc.ArisNPC_HL:Destroy() end
    
    for _, part in ipairs(npc:GetDescendants()) do
        if part:IsA("BasePart") and part:GetAttribute("ArisOriginalSize") then
            part.Size = part:GetAttribute("ArisOriginalSize")
            part.Transparency = part:GetAttribute("ArisOriginalTrans") or 0
            part.CanCollide = true
            part:SetAttribute("ArisOriginalSize", nil)
            part:SetAttribute("ArisOriginalTrans", nil)
        end
    end
end

-- Quét NPC & Sea Events
task.spawn(function()
    while true do
        local temp = {}
        local targets = {}
        
        if workspace:FindFirstChild("Enemies") then
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                table.insert(targets, v)
            end
        end
        
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Model") and (v.Name:find("Sea") or v.Name:find("Terror") or v.Name:find("Leviathan") or v:FindFirstChild("Humanoid")) then
                table.insert(targets, v)
            end
        end

        for _, model in ipairs(targets) do
            if model:IsA("Model") and model:FindFirstChild("Humanoid") and model.Humanoid.Health > 0 then
                if not Players:GetPlayerFromCharacter(model) then
                    temp[model] = true
                end
            end
        end
        
        for old_npc in pairs(NPC_Cache) do
            if not temp[old_npc] then
                ClearNPCVisual(old_npc)
            end
        end
        
        NPC_Cache = temp
        task.wait(1.8)
    end
end)

Players.PlayerRemoving:Connect(ClearPlayerESP)

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

    -- PLAYER ESP + Hitbox + Chams (KHÔNG CÓ BOX)
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        local char = p.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if not char or not hrp or char.Parent == nil or (_G.Config.TeamCheck and p.Team == LocalPlayer.Team) then
            ClearPlayerESP(p)
            continue
        end

        -- Billboard (name/health/distance)
        if not Player_ESP_Cache[p] then
            local bill = Instance.new("BillboardGui")
            bill.Size = UDim2.new(0,200,0,60)
            bill.AlwaysOnTop = true
            bill.Parent = ScreenGui
            
            local txt = Instance.new("TextLabel", bill)
            txt.Size = UDim2.new(1,0,1,0)
            txt.BackgroundTransparency = 1
            txt.Font = Enum.Font.GothamBold
            txt.TextSize = 12
            
            Player_ESP_Cache[p] = {Bill = bill, Text = txt}
        end
        
        local esp = Player_ESP_Cache[p]
        esp.Bill.Adornee = char:FindFirstChild("Head") or hrp
        esp.Bill.Enabled = _G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P
        
        local hum = char:FindFirstChild("Humanoid")
        local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0)
        
        esp.Text.Text = string.format("%s\n%s\nDist: %dm",
            _G.Config.ESP_Name_P and p.Name or "",
            _G.Config.ESP_Health_P and ("HP: " .. math.floor(hum and hum.Health or 0)) or "",
            _G.Config.ESP_Distance_P and dist or ""
        )
        if hum then
            esp.Text.TextColor3 = Color3.fromHSV(hum.Health/hum.MaxHealth * 0.3, 1, 1)
        end

        -- HITBOX PLAYER - ĐÃ FIX: KHÔNG ÉP FIXED SIZE KHI TẮT
        if hrp then
            if _G.Config.Hitbox_P then
                local shouldExpand = not _G.Config.WallCheck or CanSeeTarget(hrp)
                
                if shouldExpand then
                    -- Lưu original nếu chưa
                    if not hrp:GetAttribute("ArisOriginalHRPSize") then
                        hrp:SetAttribute("ArisOriginalHRPSize", hrp.Size)
                        hrp:SetAttribute("ArisOriginalHRPTrans", hrp.Transparency)
                        hrp:SetAttribute("ArisOriginalHRPCanCollide", hrp.CanCollide)
                    end
                    
                    hrp.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                    hrp.Transparency = 0.7
                    hrp.CanCollide = false
                else
                    -- WallCheck chặn → khôi phục gốc
                    if hrp:GetAttribute("ArisOriginalHRPSize") then
                        hrp.Size = hrp:GetAttribute("ArisOriginalHRPSize")
                        hrp.Transparency = hrp:GetAttribute("ArisOriginalHRPTrans") or 1
                        hrp.CanCollide = hrp:GetAttribute("ArisOriginalHRPCanCollide") ~= false
                    end
                end
            else
                -- TẮT Hitbox_P → khôi phục gốc & xóa attribute
                if hrp:GetAttribute("ArisOriginalHRPSize") then
                    hrp.Size = hrp:GetAttribute("ArisOriginalHRPSize")
                    hrp.Transparency = hrp:GetAttribute("ArisOriginalHRPTrans") or 1
                    hrp.CanCollide = hrp:GetAttribute("ArisOriginalHRPCanCollide") ~= false
                    
                    hrp:SetAttribute("ArisOriginalHRPSize", nil)
                    hrp:SetAttribute("ArisOriginalHRPTrans", nil)
                    hrp:SetAttribute("ArisOriginalHRPCanCollide", nil)
                end
            end
        end

        -- Chams player
        if _G.Config.ESP_Chams_P then
            if not char:FindFirstChild("Aris_HL") then
                local hl = Instance.new("Highlight", char)
                hl.Name = "Aris_HL"
                hl.FillColor = rgb
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        elseif char:FindFirstChild("Aris_HL") then 
            char.Aris_HL:Destroy() 
        end
    end

    -- NPC VISUAL + Hitbox
    for npc in pairs(NPC_Cache) do
        if not npc.Parent or not npc:FindFirstChild("Humanoid") or npc.Humanoid.Health <= 0 then 
            ClearNPCVisual(npc)
            NPC_Cache[npc] = nil
            continue 
        end

        local hrp = npc:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        -- Hitbox NPC/Sea + WALL CHECK
        if _G.Config.Hitbox_NPC and hrp then
            local size = _G.Config.HitboxSize_NPC
            local shouldExpand = not _G.Config.WallCheck or CanSeeTarget(hrp)
            
            local function apply(part)
                if not part:GetAttribute("ArisOriginalSize") then
                    part:SetAttribute("ArisOriginalSize", part.Size)
                    part:SetAttribute("ArisOriginalTrans", part.Transparency)
                end
                
                if shouldExpand then
                    part.Size = Vector3.new(size, size, size)
                    part.Transparency = 0.7
                    part.CanCollide = false
                else
                    part.Size = part:GetAttribute("ArisOriginalSize")
                    part.Transparency = part:GetAttribute("ArisOriginalTrans") or 0
                    part.CanCollide = true
                end
            end

            if npc.Name:find("Leviathan") or npc.Name:find("Terror") or npc.Name:find("Sea") then
                for _, part in ipairs(npc:GetDescendants()) do
                    if part:IsA("BasePart") and (part.Name:find("Head") or part.Name:find("Root") or part.Name:find("Body") or part.Name:find("Segment") or part.Name:find("Torso")) then
                        apply(part)
                    end
                end
            else
                apply(hrp)
            end
        else
            -- Tắt Hitbox_NPC → khôi phục & xóa attribute
            for _, part in ipairs(npc:GetDescendants()) do
                if part:IsA("BasePart") and part:GetAttribute("ArisOriginalSize") then
                    part.Size = part:GetAttribute("ArisOriginalSize")
                    part.Transparency = part:GetAttribute("ArisOriginalTrans") or 0
                    part.CanCollide = true
                    part:SetAttribute("ArisOriginalSize", nil)
                    part:SetAttribute("ArisOriginalTrans", nil)
                end
            end
        end

        -- ESP Chams NPC
        if _G.Config.ESP_NPC_Chams then
            local hl = npc:FindFirstChild("ArisNPC_HL")
            if not hl then
                hl = Instance.new("Highlight")
                hl.Name = "ArisNPC_HL"
                hl.Parent = npc
            end
            hl.FillColor = Color3.new(1,0,0)
            hl.OutlineColor = rgb
            hl.FillTransparency = 0.4
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        else
            if npc:FindFirstChild("ArisNPC_HL") then 
                npc.ArisNPC_HL:Destroy() 
            end
        end
    end
end)
