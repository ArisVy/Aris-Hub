-- ==========================================
-- THÔNG BÁO CỦA ARIS + LOAD SCRIPT
-- ==========================================

local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local UI_Container = pcall(function() return CoreGui.RobloxGui end) and CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")

if UI_Container:FindFirstChild("ArisRestoredGlass") then
    UI_Container.ArisRestoredGlass:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisRestoredGlass"
ScreenGui.Parent = UI_Container

-- Âm thanh
local SoundFolder = Instance.new("Folder")
SoundFolder.Name = "ArisSFX"
SoundFolder.Parent = ScreenGui

local PressSound = Instance.new("Sound")
PressSound.SoundId = "rbxassetid://68950866"
PressSound.Volume = 0.5
PressSound.Parent = SoundFolder

local ReleaseSound = Instance.new("Sound")
ReleaseSound.SoundId = "rbxassetid://12221967"
ReleaseSound.Volume = 0.6
ReleaseSound.Parent = SoundFolder

local function PlaySound(soundType)
    if soundType == "Press" then
        PressSound:Play()
    elseif soundType == "Release" then
        ReleaseSound:Play()
    end
end

-- Viền mờ
local function CreateVerticalFadeGradient(parentStroke)
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.4),
        NumberSequenceKeypoint.new(0.3, 1),
        NumberSequenceKeypoint.new(0.7, 1),
        NumberSequenceKeypoint.new(1, 0.4)
    })
    gradient.Parent = parentStroke
end

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 380, 0, 320)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BackgroundTransparency = 0.95
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local OuterStroke = Instance.new("UIStroke")
OuterStroke.Color = Color3.fromRGB(255, 255, 255)
OuterStroke.Thickness = 1.5
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
OuterStroke.Parent = MainFrame
CreateVerticalFadeGradient(OuterStroke)

-- Tiêu đề
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "Thông báo của Aris"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Nút X
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundTransparency = 0.92
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(255, 255, 255)
CloseStroke.Thickness = 1.2
CloseStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CloseStroke.Parent = CloseBtn
CreateVerticalFadeGradient(CloseStroke)

CloseBtn.MouseButton1Down:Connect(function()
    PlaySound("Press")
    TweenService:Create(CloseBtn, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundTransparency = 0.8
    }):Play()
end)

CloseBtn.MouseButton1Up:Connect(function()
    PlaySound("Release")
    TweenService:Create(CloseBtn, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundTransparency = 0.92
    }):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Nội dung
local Content = Instance.new("TextLabel")
Content.Size = UDim2.new(1, -30, 1, -60)
Content.Position = UDim2.new(0, 15, 0, 50)
Content.BackgroundTransparency = 1
Content.Text = [[Script Phục vụ cho người phản xạ nhanh và muốn chắc chắn về lựa chọn bản thân

"ĐẬU MÁ TỤI BÂY THẤY X30 100 200 J ĐÓ R BẢO SCRIPT BÁO SAI , T XIN TỤI BÂY ĐỌC " CÁCH HOẠT ĐỘNG ( HOW IT WORK ) " TỤI BÂY BẢO LỎ , 

Ừ LỎ THẬT , MUỐN CHS GAME NHÂN PHẨM THÌ CHỈ Z THÔI ĐỪNG ĐÒI HỎI SÉT ĐÁNH LÚC NÀO"]]
Content.TextColor3 = Color3.fromRGB(230, 230, 235)
Content.TextSize = 14
Content.Font = Enum.Font.Gotham
Content.TextWrapped = true
Content.TextXAlignment = Enum.TextXAlignment.Left
Content.TextYAlignment = Enum.TextYAlignment.Top
Content.Parent = MainFrame

-- Kéo thả
local draggingMenu = false
local dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMenu = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMenu = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and draggingMenu then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- LOAD SCRIPT GREADY GARDEN
-- ==========================================
loadstring(game:HttpGet("https://raw.githubusercontent.com/ArisVy/Aris-Hub/refs/heads/main/Gready_garden.luau"))()
