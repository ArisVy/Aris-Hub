--[[
    ARIS HUB | Info Panel (Standalone)
    Menu riêng lẻ - không bị script chính triệt
]]

-- ==========================================
-- 1. SERVICES & SETUP
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local UI_Container = pcall(function() return CoreGui.RobloxGui end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

-- Chỉ xoá phiên bản cũ của chính nó (không đụng script chính)
if UI_Container:FindFirstChild("ArisInfoNotification") then UI_Container.ArisInfoNotification:Destroy() end
if UI_Container:FindFirstChild("ArisInfoPanel_Standalone") then UI_Container.ArisInfoPanel_Standalone:Destroy() end

-- ==========================================
-- 2. NOTIFICATION SYSTEM (riêng)
-- ==========================================
local _NotiGui = Instance.new("ScreenGui")
_NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_NotiGui.Name = "ArisInfoNotification"
_NotiGui.Parent = UI_Container

local _NotiContainer = Instance.new("Frame")
_NotiContainer.Name = "NotiContainer"
_NotiContainer.Parent = _NotiGui
_NotiContainer.AnchorPoint = Vector2.new(1, 1)
_NotiContainer.BackgroundTransparency = 1
_NotiContainer.Position = UDim2.new(1, -5, 1, -5)
_NotiContainer.Size = UDim2.new(0, 320, 1, -10)

local _NotiList = Instance.new("UIListLayout")
_NotiList.Parent = _NotiContainer
_NotiList.SortOrder = Enum.SortOrder.LayoutOrder
_NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
_NotiList.Padding = UDim.new(0, 5)

function AddNotify(Setting)
    local Title = Setting.Title or ""
    local Description = Setting.Description or Setting.Desc or Setting.Content or ""
    local Duration = Setting.Duration or 5

    local NotiFrame = Instance.new("Frame")
    local Noticontainer = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Topnoti = Instance.new("Frame")
    local TextLabelNoti = Instance.new("TextLabel")
    local TextLabelNoti2 = Instance.new("TextLabel")
    local CloseContainer = Instance.new("Frame")
    local CloseImage = Instance.new("ImageLabel")
    local CloseBtn = Instance.new("TextButton")
    
    NotiFrame.Name = "NotiFrame"
    NotiFrame.Parent = _NotiContainer
    NotiFrame.BackgroundTransparency = 1
    NotiFrame.Size = UDim2.new(1, 0, 0, 0)
    NotiFrame.AutomaticSize = Enum.AutomaticSize.Y
    NotiFrame.ClipsDescendants = true
    
    Noticontainer.Parent = NotiFrame
    Noticontainer.Position = UDim2.new(0, 0, 0, 0)
    Noticontainer.Size = UDim2.new(1, 0, 1, 6)
    Noticontainer.AutomaticSize = Enum.AutomaticSize.Y
    Noticontainer.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    UICorner.CornerRadius = UDim.new(0, 4)
    UICorner.Parent = Noticontainer
    
    Topnoti.Parent = Noticontainer
    Topnoti.BackgroundTransparency = 1
    Topnoti.Position = UDim2.new(0, 0, 0, 5)
    Topnoti.Size = UDim2.new(1, 0, 0, 25)
    
    TextLabelNoti.Parent = Topnoti
    TextLabelNoti.BackgroundTransparency = 1
    TextLabelNoti.Position = UDim2.new(0, 8, 0, 0)
    TextLabelNoti.Size = UDim2.new(1, -35, 1, 0)
    TextLabelNoti.Font = Enum.Font.GothamBold
    TextLabelNoti.TextSize = 13
    TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
    TextLabelNoti.RichText = true
    TextLabelNoti.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabelNoti.Text = "<font color=\"rgb(255,80,80)\">Aris Hub</font> | " .. tostring(Title)
    
    CloseContainer.Parent = Topnoti
    CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
    CloseContainer.BackgroundTransparency = 1
    CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
    CloseContainer.Size = UDim2.new(0, 20, 0, 20)

    CloseImage.Parent = CloseContainer
    CloseImage.BackgroundTransparency = 1
    CloseImage.Size = UDim2.new(1, 0, 1, 0)
    CloseImage.Image = "rbxassetid://3926305904"
    CloseImage.ImageRectOffset = Vector2.new(284, 4)
    CloseImage.ImageRectSize = Vector2.new(24, 24)
    CloseImage.ImageColor3 = Color3.fromRGB(200, 200, 200)

    CloseBtn.Parent = CloseContainer
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Size = UDim2.new(1, 0, 1, 0)
    CloseBtn.Text = ""
    
    TextLabelNoti2.Parent = Noticontainer
    TextLabelNoti2.BackgroundTransparency = 1
    TextLabelNoti2.Position = UDim2.new(0, 10, 0, 32)
    TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
    TextLabelNoti2.Font = Enum.Font.GothamMedium
    TextLabelNoti2.Text = tostring(Description)
    TextLabelNoti2.TextSize = 12
    TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabelNoti2.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
    TextLabelNoti2.TextWrapped = true
    CloseBtn.ZIndex = 10 
    
    local _closed = false
    local function remove()
        if _closed then return end
        _closed = true
        if NotiFrame and NotiFrame.Parent then NotiFrame:Destroy() end
    end
    
    CloseBtn.MouseButton1Click:Connect(remove)
    task.delay(tonumber(Duration) or 3, remove)
end

-- ==========================================
-- 3. SCREENGUI RIÊNG + UTILS
-- ==========================================
_G.ArisInfoConfig = { MenuOpen = true }

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisInfoPanel_Standalone"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999
ScreenGui.Parent = UI_Container

local SoundFolder = Instance.new("Folder", ScreenGui)
SoundFolder.Name = "ArisInfoSFX"
local PressSound = Instance.new("Sound", SoundFolder) PressSound.SoundId = "rbxassetid://68950866" PressSound.Volume = 0.5 
local ReleaseSound = Instance.new("Sound", SoundFolder) ReleaseSound.SoundId = "rbxassetid://12221967" ReleaseSound.Volume = 0.6
local ToggleSound = Instance.new("Sound", SoundFolder) ToggleSound.SoundId = "rbxassetid://4612382104" ToggleSound.Volume = 0.4

local function PlaySound(soundType)
    if soundType == "Press" then PressSound:Play()
    elseif soundType == "Release" then ReleaseSound:Play()
    elseif soundType == "Toggle" then ToggleSound:Play() end
end

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
    return gradient
end

local function ApplyBounce(btn)
    local scale = Instance.new("UIScale", btn)
    scale.Scale = 1
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.9}):Play()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
        end
    end)
end

-- ==========================================
-- 4. MAIN FRAME (chỉ hiện bảng + nút X)
-- ==========================================
local MainFrame = Instance.new("Frame", ScreenGui)
local targetSize = UDim2.new(0, 290, 0, 330)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5) 
MainFrame.Size = targetSize
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30) 
MainFrame.BackgroundTransparency = 0.95 
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true 
MainFrame.Visible = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 11)
local OuterStroke = Instance.new("UIStroke", MainFrame)
OuterStroke.Color = Color3.fromRGB(255, 255, 255) 
OuterStroke.Thickness = 0.8
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CreateVerticalFadeGradient(OuterStroke)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -50, 0, 34)
Title.Position = UDim2.new(0, 11, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "ARIS HUB | INFO"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
CloseBtn.BackgroundTransparency = 0.92
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
local CloseStroke = Instance.new("UIStroke", CloseBtn)
CloseStroke.Color = Color3.fromRGB(255, 255, 255) 
CloseStroke.Thickness = 0.6
CreateVerticalFadeGradient(CloseStroke)
ApplyBounce(CloseBtn)

-- Drag MainFrame
local draggingMenu, dragInput, dragStart, startPos
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
-- FULL DESTROY (chỉ xoá chính nó)
-- ==========================================
local function DestroyEverything()
    PlaySound("Release")
    
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
    if _NotiGui and _NotiGui.Parent then
        _NotiGui:Destroy()
    end
    
    _G.ArisInfoConfig = nil
    print("[Aris Info] Đã triệt tiêu hoàn toàn.")
end

CloseBtn.MouseButton1Down:Connect(function() 
    PlaySound("Press") 
end)

CloseBtn.MouseButton1Up:Connect(function()
    DestroyEverything()
end)

-- ==========================================
-- 5. CONTENT
-- ==========================================
local ContentContainer = Instance.new("ScrollingFrame", MainFrame)
ContentContainer.Size = UDim2.new(1, -22, 1, -48)
ContentContainer.Position = UDim2.new(0, 11, 0, 40)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ScrollBarThickness = 2
ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ContentContainer.BorderSizePixel = 0
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout", ContentContainer)
Layout.Padding = UDim.new(0, 9)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- Title box
local TitleBox = Instance.new("Frame", ContentContainer)
TitleBox.Size = UDim2.new(1, 0, 0, 0)
TitleBox.AutomaticSize = Enum.AutomaticSize.Y
TitleBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TitleBox.BackgroundTransparency = 0.8
Instance.new("UICorner", TitleBox).CornerRadius = UDim.new(0, 7)

local TitlePadding = Instance.new("UIPadding", TitleBox)
TitlePadding.PaddingTop = UDim.new(0, 7)
TitlePadding.PaddingBottom = UDim.new(0, 7)
TitlePadding.PaddingLeft = UDim.new(0, 9)
TitlePadding.PaddingRight = UDim.new(0, 9)

local TitleLabel = Instance.new("TextLabel", TitleBox)
TitleLabel.Size = UDim2.new(1, 0, 0, 0)
TitleLabel.AutomaticSize = Enum.AutomaticSize.Y
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Tin từ Aris"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 13
TitleLabel.TextColor3 = Color3.fromRGB(255, 180, 80)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextWrapped = true

-- Main content box
local ContentBox = Instance.new("Frame", ContentContainer)
ContentBox.Size = UDim2.new(1, 0, 0, 0)
ContentBox.AutomaticSize = Enum.AutomaticSize.Y
ContentBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ContentBox.BackgroundTransparency = 0.8
Instance.new("UICorner", ContentBox).CornerRadius = UDim.new(0, 7)

local ContentPadding = Instance.new("UIPadding", ContentBox)
ContentPadding.PaddingTop = UDim.new(0, 9)
ContentPadding.PaddingBottom = UDim.new(0, 9)
ContentPadding.PaddingLeft = UDim.new(0, 9)
ContentPadding.PaddingRight = UDim.new(0, 9)

local ContentLabel = Instance.new("TextLabel", ContentBox)
ContentLabel.Size = UDim2.new(1, 0, 0, 0)
ContentLabel.AutomaticSize = Enum.AutomaticSize.Y
ContentLabel.BackgroundTransparency = 1
ContentLabel.Text = [[TỪ ARIS ,
Nếu ae muốn thôi thêm nhặt cây trước khi sét thì thật sự xin lỗi ae , tốc độ phản ứng của sét rất nhanh tầm0.05s và game thì bắt ta trễ 0.1s khi nhặt nên ko thể thêm đc

Vui lòng đọc trước khi dùng

Nếu ae thấy script thông báo khá bịp thì do script nó tìm nguy cơ sét xuất hiện từ file game nên khó để biết cây lớn bao nhiêu, mọi thứ dựa vào workspace của game.

Script này sinh ra để cho ae chắc chắn về quyết định bản thân khi sử dụng script, lí do t ko thêm tự động nhặt trước sét vì nếu thêm vào ae sẽ không thể có cây x20 30 trở lên đc.

Đừng trách t bất tài hay bịp gì, t chỉ giúp tụi bây 1 phần thôi, có gì thắc mắc thì vào discord trong mục support mà nói.

Bấm X để xoá bảng này.]]
ContentLabel.Font = Enum.Font.GothamMedium
ContentLabel.TextSize = 12
ContentLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
ContentLabel.TextWrapped = true

-- Thông báo khi vừa exec
AddNotify({
    Title = "THÔNG BÁO",
    Description = "Vui lòng đọc kỹ nội dung trong menu trước khi sử dụng!",
    Duration = 4
})

print("[Aris Info] Standalone panel loaded!")
loadstring(game:HttpGet("https://raw.githubusercontent.com/ArisVy/Aris-Hub/refs/heads/main/Gready_garden.luau"))()
