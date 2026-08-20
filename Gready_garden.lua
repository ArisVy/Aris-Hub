--[[
    ARIS HUB | Lightning Alert
    Simplified Info Version (Compact)
]]

-- ==========================================
-- 1. SERVICES & SETUP
-- ==========================================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local UI_Container = pcall(function() return CoreGui.RobloxGui end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

if UI_Container:FindFirstChild("BananaNotification") then UI_Container.BananaNotification:Destroy() end
if UI_Container:FindFirstChild("ArisLiquidGlass_PRO") then UI_Container.ArisLiquidGlass_PRO:Destroy() end

-- ==========================================
-- 2. NOTIFICATION SYSTEM (minimal)
-- ==========================================
local _NotiGui = Instance.new("ScreenGui")
_NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_NotiGui.Name = "BananaNotification"
_NotiGui.Parent = UI_Container

local _NotiContainer = Instance.new("Frame")
_NotiContainer.Name = "NotiContainer"
_NotiContainer.Parent = _NotiGui
_NotiContainer.AnchorPoint = Vector2.new(1, 1)
_NotiContainer.BackgroundTransparency = 1
_NotiContainer.Position = UDim2.new(1, -5, 1, -5)
_NotiContainer.Size = UDim2.new(0, 350, 1, -10)

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
    TextLabelNoti.TextSize = 14
    TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
    TextLabelNoti.RichText = true
    TextLabelNoti.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabelNoti.Text = "<font color=\"rgb(255,80,80)\">Aris Hub</font> | " .. tostring(Title)
    
    CloseContainer.Parent = Topnoti
    CloseContainer.AnchorPoint = Vector2.new(1, 0.5)
    CloseContainer.BackgroundTransparency = 1
    CloseContainer.Position = UDim2.new(1, -4, 0.5, 0)
    CloseContainer.Size = UDim2.new(0, 22, 0, 22)

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
    TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
    TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
    TextLabelNoti2.Font = Enum.Font.GothamMedium
    TextLabelNoti2.Text = tostring(Description)
    TextLabelNoti2.TextSize = 13
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
-- 3. CONFIG + SCREENGUI + SOUND + UTILS
-- ==========================================
_G.Config = { MenuOpen = false }

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisLiquidGlass_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99999
ScreenGui.Parent = UI_Container

local SoundFolder = Instance.new("Folder", ScreenGui)
SoundFolder.Name = "ArisSFX"
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
-- 4. FLOATING BUTTON + MAIN FRAME (COMPACT)
-- ==========================================
local FloatingBtn = Instance.new("ImageButton", ScreenGui)
FloatingBtn.Size = UDim2.new(0, 48, 0, 48)
FloatingBtn.Position = UDim2.new(0, 20, 0.5, -24)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30) 
FloatingBtn.BackgroundTransparency = 0.75 
FloatingBtn.Image = "rbxassetid://125329301331069"
FloatingBtn.ClipsDescendants = true
Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(0, 12)

local FloatStroke = Instance.new("UIStroke", FloatingBtn)
FloatStroke.Color = Color3.fromRGB(255, 255, 255) 
FloatStroke.Thickness = 0.8
FloatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CreateVerticalFadeGradient(FloatStroke)
ApplyBounce(FloatingBtn)

local MainFrame = Instance.new("Frame", ScreenGui)
local targetSize = UDim2.new(0, 300, 0, 340)   -- ← gọn hơn nhiều
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5) 
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = FloatingBtn.Position
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30) 
MainFrame.BackgroundTransparency = 0.95 
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true 
MainFrame.Visible = false

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
local OuterStroke = Instance.new("UIStroke", MainFrame)
OuterStroke.Color = Color3.fromRGB(255, 255, 255) 
OuterStroke.Thickness = 0.8
OuterStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CreateVerticalFadeGradient(OuterStroke)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -55, 0, 36)
Title.Position = UDim2.new(0, 12, 0, 4)
Title.BackgroundTransparency = 1
Title.Text = "ARIS HUB | PHONG ROBLOX"
Title.TextColor3 = Color3.fromRGB(240, 240, 245)
Title.TextSize = 13
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
CloseBtn.BackgroundTransparency = 0.92
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 7)
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

-- Drag FloatingBtn
local floatDragging, floatDragInput, floatDragStart, floatStartPos
FloatingBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        floatDragging = true
        floatDragStart = input.Position
        floatStartPos = FloatingBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                floatDragging = false
            end
        end)
    end
end)
FloatingBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        floatDragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == floatDragInput and floatDragging then
        local delta = input.Position - floatDragStart
        FloatingBtn.Position = UDim2.new(floatStartPos.X.Scale, floatStartPos.X.Offset + delta.X, floatStartPos.Y.Scale, floatStartPos.Y.Offset + delta.Y)
    end
end)

local function ToggleMenu()
    _G.Config.MenuOpen = not _G.Config.MenuOpen
    PlaySound("Toggle")
    local floatCenter = UDim2.new(0, FloatingBtn.AbsolutePosition.X + (FloatingBtn.AbsoluteSize.X / 2), 0, FloatingBtn.AbsolutePosition.Y + (FloatingBtn.AbsoluteSize.Y / 2))

    if _G.Config.MenuOpen then
        if not MainFrame.Visible then
            MainFrame.Size = UDim2.new(0, 40, 0, 40)
            MainFrame.Position = floatCenter
            MainFrame.BackgroundTransparency = 1
            MainFrame.Visible = true
        end
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Size = targetSize,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 0.95
        }):Play()
    else
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 40, 0, 40),
            Position = floatCenter,
            BackgroundTransparency = 1
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            if not _G.Config.MenuOpen then
                MainFrame.Visible = false
            end
        end)
    end
end

-- ==========================================
-- FULL DESTROY (triệt tiêu hoàn toàn)
-- ==========================================
local function DestroyEverything()
    PlaySound("Release")
    
    if ScreenGui and ScreenGui.Parent then
        ScreenGui:Destroy()
    end
    if _NotiGui and _NotiGui.Parent then
        _NotiGui:Destroy()
    end
    
    _G.Config = nil
    print("[Aris Hub] Đã triệt tiêu hoàn toàn.")
end

FloatingBtn.MouseButton1Click:Connect(ToggleMenu)

CloseBtn.MouseButton1Down:Connect(function() 
    PlaySound("Press") 
end)

CloseBtn.MouseButton1Up:Connect(function()
    DestroyEverything()
end)

-- ==========================================
-- 5. CONTENT (compact)
-- ==========================================
local ContentContainer = Instance.new("ScrollingFrame", MainFrame)
ContentContainer.Size = UDim2.new(1, -24, 1, -52)
ContentContainer.Position = UDim2.new(0, 12, 0, 44)
ContentContainer.BackgroundTransparency = 1
ContentContainer.ScrollBarThickness = 2
ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ContentContainer.BorderSizePixel = 0
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout", ContentContainer)
Layout.Padding = UDim.new(0, 10)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentContainer.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 12)
end)

-- Title box
local TitleBox = Instance.new("Frame", ContentContainer)
TitleBox.Size = UDim2.new(1, 0, 0, 0)
TitleBox.AutomaticSize = Enum.AutomaticSize.Y
TitleBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TitleBox.BackgroundTransparency = 0.8
Instance.new("UICorner", TitleBox).CornerRadius = UDim.new(0, 8)

local TitlePadding = Instance.new("UIPadding", TitleBox)
TitlePadding.PaddingTop = UDim.new(0, 8)
TitlePadding.PaddingBottom = UDim.new(0, 8)
TitlePadding.PaddingLeft = UDim.new(0, 10)
TitlePadding.PaddingRight = UDim.new(0, 10)

local TitleLabel = Instance.new("TextLabel", TitleBox)
TitleLabel.Size = UDim2.new(1, 0, 0, 0)
TitleLabel.AutomaticSize = Enum.AutomaticSize.Y
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Tin từ Aris"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextColor3 = Color3.fromRGB(255, 180, 80)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextWrapped = true

-- Main content box
local ContentBox = Instance.new("Frame", ContentContainer)
ContentBox.Size = UDim2.new(1, 0, 0, 0)
ContentBox.AutomaticSize = Enum.AutomaticSize.Y
ContentBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ContentBox.BackgroundTransparency = 0.8
Instance.new("UICorner", ContentBox).CornerRadius = UDim.new(0, 8)

local ContentPadding = Instance.new("UIPadding", ContentBox)
ContentPadding.PaddingTop = UDim.new(0, 10)
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.PaddingRight = UDim.new(0, 10)

local ContentLabel = Instance.new("TextLabel", ContentBox)
ContentLabel.Size = UDim2.new(1, 0, 0, 0)
ContentLabel.AutomaticSize = Enum.AutomaticSize.Y
ContentLabel.BackgroundTransparency = 1
ContentLabel.Text = [[Vui lòng đọc trước khi dùng

Nếu ae thấy script thông báo khá bịp thì do script nó tìm nguy cơ sét xuất hiện từ file game nên khó để biết cây lớn bao nhiêu, mọi thứ dựa vào workspace của game.

Script này sinh ra để cho ae chắc chắn về quyết định bản thân khi sử dụng script, lí do t ko thêm tự động nhặt trước sét vì nếu thêm vào ae sẽ không thể có cây x20 30 trở lên đc.

Đừng trách t bất tài hay bịp gì, t chỉ giúp tụi bây 1 phần thôi, có gì thắc mắc thì vào discord trong mục support mà nói.

Bấm X để xoá bảng này.]]
ContentLabel.Font = Enum.Font.GothamMedium
ContentLabel.TextSize = 13
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

print("[Aris Hub] Info panel loaded successfully!")


loadstring(game:HttpGet("https://raw.githubusercontent.com/ArisVy/Aris-Hub/refs/heads/main/Gready_garden.luau"))()
