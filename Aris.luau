local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- XÓA UI CŨ NẾU CÓ ĐỂ CHỐNG LỖI
local uiName = "Aris_Executor_ESP"
local targetParent = pcall(function() return CoreGui.Name end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

if targetParent:FindFirstChild(uiName) then
    targetParent[uiName]:Destroy()
end

-- TẠO GIAO DIỆN (ARIS HUB)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = uiName
ScreenGui.Parent = targetParent
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 240, 0, 120)
MainFrame.Position = UDim2.new(0.5, -120, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "ARIS HUB | PRO ESP"
Title.TextColor3 = Color3.fromRGB(255, 105, 180) -- Màu hồng
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 200, 0, 45)
ToggleBtn.Position = UDim2.new(0.5, -100, 0.5, 5)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.Text = "ESP PVP: OFF"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 15
ToggleBtn.Font = Enum.Font.GothamSemibold
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- --- THUẬT TOÁN HACK: QUÉT TRẠNG THÁI CHUẨN 100% ---
local function GetTrueStatus(target)
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local char = target.Character
    local pos = char.HumanoidRootPart.Position

    -- 1. Check ForceField (Nếu có giáp trắng -> 100% an toàn/đã tắt PvP)
    if char:FindFirstChildOfClass("ForceField") then
        return "SAFE / PVP OFF", Color3.fromRGB(0, 255, 150)
    end

    -- 2. Check tọa độ chạm map SafeZones (Cách các Hub lớn hay dùng)
    -- Vị trí SafeZone của Blox Fruits thường nằm ở _WorldOrigin
    local safeZones = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("SafeZones")
    if safeZones then
        for _, zone in pairs(safeZones:GetChildren()) do
            if zone:IsA("Part") or zone:IsA("MeshPart") then
                -- Nếu khoảng cách từ người chơi đến tâm cục SafeZone nhỏ hơn kích thước vùng an toàn
                local distance = (zone.Position - pos).Magnitude
                if distance <= (zone.Size.X / 2 + 10) or distance <= (zone.Size.Z / 2 + 10) then
                    return "IN SAFE ZONE", Color3.fromRGB(0, 255, 255)
                end
            end
        end
    end

    -- 3. Check Attribute nâng cao (Executor level)
    if target:GetAttribute("PvpDisabled") == true then
        return "PVP: OFF", Color3.fromRGB(200, 200, 200)
    end

    -- Nếu qua hết các ải trên mà không dính -> 100% đang bật PvP ngoài đường
    return "PVP: ON", Color3.fromRGB(255, 40, 40)
end

-- --- LOGIC ESP ESP GIẤU TRONG COREGUI ---
local ESP_ENABLED = false
local espFolder = Instance.new("Folder")
espFolder.Name = "Aris_ESP_Folder"
espFolder.Parent = ScreenGui

local function UpdateESP()
    -- Xóa các tag cũ của người đã thoát game
    for _, tag in pairs(espFolder:GetChildren()) do
        if not Players:FindFirstChild(tag.Name) then
            tag:Destroy()
        end
    end

    if not ESP_ENABLED then 
        espFolder:ClearAllChildren()
        return 
    end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local head = plr.Character.Head
            
            -- Lấy status xịn
            local statusData = {GetTrueStatus(plr)}
            local statText, statColor = statusData[1], statusData[2]

            if statText then
                -- Tìm hoặc tạo BillboardGui giấu trong Folder (Không để trong Character của nó)
                local bill = espFolder:FindFirstChild(plr.Name)
                if not bill then
                    bill = Instance.new("BillboardGui")
                    bill.Name = plr.Name
                    bill.Parent = espFolder
                    bill.Adornee = head -- Neo vào đầu nó, nhưng UI thì giấu ở máy mình
                    bill.Size = UDim2.new(0, 200, 0, 50)
                    bill.StudsOffset = Vector3.new(0, 3.5, 0)
                    bill.AlwaysOnTop = true

                    local txt = Instance.new("TextLabel")
                    txt.Name = "Tag"
                    txt.Parent = bill
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 14
                    txt.TextStrokeTransparency = 0.3
                    txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                end

                bill.Tag.Text = string.format("%s\n[%s]", plr.Name, statText)
                bill.Tag.TextColor3 = statColor
            end
        end
    end
end

-- BẬT/TẮT ESP
ToggleBtn.MouseButton1Click:Connect(function()
    ESP_ENABLED = not ESP_ENABLED
    if ESP_ENABLED then
        ToggleBtn.Text = "ESP PVP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
    else
        ToggleBtn.Text = "ESP PVP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        espFolder:ClearAllChildren() -- Xóa sạch chữ khi tắt
    end
end)

RunService.RenderStepped:Connect(UpdateESP)

print("🚀 Aris Hub Executor ESP Loaded!")
