-- Tham chiếu logic từ: Nexus full Ai source.txt

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Hàm tạo khung ESP
local function CreateESP(player)
    local box = Instance.new("Highlight")
    box.Name = "NexusESP"
    box.FillTransparency = 0.5
    box.OutlineTransparency = 0
    box.Adornee = player.Character
    box.Parent = player.Character

    -- Logic đổi màu dựa trên trạng thái PvP
    local function UpdateColor()
        if not player.Character or not player.Character:FindFirstChild("Humanoid") then return end
        
        -- Nếu mục tiêu không thể tấn công (PvP Off hoặc trong Safe Zone)
        local pvpDisabled = player:GetAttribute("PvpDisabled")
        if pvpDisabled then
            box.FillColor = Color3.fromRGB(255, 255, 255) -- Trắng (An toàn)
        elseif player.Team == lp.Team and lp.Team.Name == "Marines" then
            box.FillColor = Color3.fromRGB(0, 255, 0) -- Xanh lá (Đồng đội)[cite: 1]
        else
            box.FillColor = Color3.fromRGB(255, 0, 0) -- Đỏ (Mục tiêu hợp lệ)[cite: 1]
        end
    end

    -- Cập nhật màu liên tục
    local conn = RunService.RenderStepped:Connect(UpdateColor)
    
    player.CharacterRemoving:Connect(function()
        conn:Disconnect()
    end)
end

-- Quét người chơi hiện tại và người chơi mới vào[cite: 1]
local function InitESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= lp and player.Character then
            CreateESP(player)
        end
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            CreateESP(player)
        end)
    end
end

-- Kích hoạt ESP
InitESP()
