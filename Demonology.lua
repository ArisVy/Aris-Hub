local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")

-- [ CHỐNG TRÙNG LẶP MENU ] --
if CoreGui:FindFirstChild("DemonologyHUB") then
    CoreGui.DemonologyHUB:Destroy()
end

-- [ BIẾN TOÀN CỤC ] --
_G.WalkSpeed = 10
_G.WalkSpeedEnabled = false
_G.MenuOpen = true 

local UIGradientList = {}
local TextGradientList = {}
local BtnGradientList = {}

-- [ HÀM HỖ TRỢ GIAO DIỆN ] --
local function GetMovingColorSequence(palette, shift)
    local keypoints = {}
    for step = 0, 5 do
        local i = step / 5
        local t = (i - shift) % 1
        if t < 0 then t = t + 1 end
        local segments = #palette - 1
        local scaled = t * segments
        local index = math.floor(scaled) + 1
        local fraction = scaled - (index - 1)
        local color = (index >= #palette) and palette[#palette] or palette[index]:Lerp(palette[index + 1], fraction)
        table.insert(keypoints, ColorSequenceKeypoint.new(i, color))
    end
    return ColorSequence.new(keypoints)
end

local Palettes = {
    On = { Color3.fromRGB(0, 240, 255), Color3.fromRGB(130, 100, 255), Color3.fromRGB(255, 150, 255), Color3.fromRGB(0, 240, 255) },
    Off = { Color3.fromRGB(12, 12, 12), Color3.fromRGB(180, 20, 20), Color3.fromRGB(12, 12, 12) },
    Text = { Color3.fromRGB(0, 150, 255), Color3.fromRGB(255, 0, 150), Color3.fromRGB(0, 150, 255) },
    Border = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(15, 15, 15), Color3.fromRGB(255, 0, 0) }
}

local function CreateBorder(parent)
    local stroke = Instance.new("UIStroke", parent) stroke.Thickness = 1.8 stroke.Color = Color3.new(1, 1, 1)
    local grad = Instance.new("UIGradient", stroke) grad.Rotation = 90 table.insert(UIGradientList, grad)
end

local function CreateTextGradient(parent)
    parent.TextColor3 = Color3.new(1, 1, 1) parent.TextStrokeTransparency = 1
    local txtStroke = Instance.new("UIStroke", parent) txtStroke.Thickness = 0.5 txtStroke.Color = Color3.new(0, 0, 0)
    local grad = Instance.new("UIGradient", parent) grad.Rotation = 90 table.insert(TextGradientList, grad)
end

local function ApplyToggleGradient(parent, isOn)
    local grad = parent:FindFirstChild("ToggleGrad")
    if not grad then
        grad = Instance.new("UIGradient", parent) grad.Name = "ToggleGrad" grad.Rotation = 90 table.insert(BtnGradientList, grad)
    end
    parent:SetAttribute("IsOn", isOn)
    local txt = parent:FindFirstChildOfClass("TextLabel")
    if txt then
        local txtGrad = txt:FindFirstChildOfClass("UIGradient")
        if isOn then
            if txtGrad then
                txtGrad.Enabled = true
                txtGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, 0, 0), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                txtGrad:SetAttribute("CustomOnColor", true)
            end
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            if txtGrad then txtGrad.Enabled = true txtGrad:SetAttribute("CustomOnColor", false) end
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end

local function CreateButtonText(parent, text, font, size)
    local txt = Instance.new("TextLabel", parent) txt.Size = UDim2.new(1, 0, 1, 0) txt.BackgroundTransparency = 1 txt.Text = text txt.Font = font txt.TextSize = size CreateTextGradient(txt) return txt
end

local function ApplyButtonAnimation(btn)
    local scale = Instance.new("UIScale", btn) scale.Scale = 1
    btn.MouseEnter:Connect(function() TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.0}):Play() end)
    btn.MouseButton1Down:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.9}):Play() end)
    btn.MouseButton1Up:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
end

local function MakeDraggable(f)
    local d=false;local i,s
    f.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=true; i=inp.Position; s=f.Position end end)
    f.InputChanged:Connect(function(inp) if (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) and d then local delta=inp.Position-i; f.Position=UDim2.new(s.X.Scale,s.X.Offset+delta.X,s.Y.Scale,s.Y.Offset+delta.Y) end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=false end end)
end

-- [ GIAO DIỆN CHÍNH ] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DemonologyHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99999
ScreenGui.Parent = CoreGui

-- Nút nổi (Float Toggle)
local ToggleBtn = Instance.new("ImageButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0,10,0.5,-25)
ToggleBtn.Image = "rbxassetid://125329301331069"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleBtn.ClipsDescendants = true
Instance.new("UICorner",ToggleBtn).CornerRadius = UDim.new(0,20)
CreateBorder(ToggleBtn) MakeDraggable(ToggleBtn) ApplyButtonAnimation(ToggleBtn)

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 280, 0.85, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Active = true
MainFrame.Visible = true 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
CreateBorder(MainFrame) MakeDraggable(MainFrame)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.MenuOpen = not _G.MenuOpen
    MainFrame.Visible = _G.MenuOpen
end)

-- Tiêu đề & Nút Reset
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,-20,0,40)
Title.Text = "✧ DEMONOLOGY ✧"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.BackgroundTransparency = 1
CreateTextGradient(Title)

local ResetBtn = Instance.new("TextButton", MainFrame)
ResetBtn.Size = UDim2.new(0,40,0,28)
ResetBtn.Position = UDim2.new(0,10,0,6)
ResetBtn.Text = ""
ResetBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner",ResetBtn).CornerRadius = UDim.new(0,14)
ApplyToggleGradient(ResetBtn, false) CreateBorder(ResetBtn) 
CreateButtonText(ResetBtn, "RST", Enum.Font.GothamBold, 12) ApplyButtonAnimation(ResetBtn)

ResetBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            while char.Humanoid.Health > 0 and char.Parent do char.Humanoid.Health = 0; task.wait(0.1) end 
        end
    end)
end)

-- [ DANH SÁCH CUỘN ] --
local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Size = UDim2.new(1, -6, 1, -50)
Content.Position = UDim2.new(0, 3, 0, 45)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 3
Content.BorderSizePixel = 0
Content.Active = true

local UIList = Instance.new("UIListLayout", Content)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 12)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Content.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 20)
end)

-- [ 1. WALKSPEED ] --
local WSContainer = Instance.new("Frame", Content)
WSContainer.Size = UDim2.new(1, -20, 0, 115)
WSContainer.BackgroundTransparency = 1
WSContainer.LayoutOrder = 1

local WSToggle = Instance.new("TextButton", WSContainer)
WSToggle.Size = UDim2.new(1, 0, 0, 36)
WSToggle.Text = "" WSToggle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSToggle).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSToggle, _G.WalkSpeedEnabled) CreateBorder(WSToggle)
local WSToggleTxt = CreateButtonText(WSToggle, "♢ WALKSPEED: " .. (_G.WalkSpeedEnabled and "ON" or "OFF"), Enum.Font.GothamBold, 13)
ApplyButtonAnimation(WSToggle)

local WSSliderBg = Instance.new("Frame", WSContainer)
WSSliderBg.Size = UDim2.new(1, 0, 0, 25)
WSSliderBg.Position = UDim2.new(0, 0, 0, 48)
WSSliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", WSSliderBg).CornerRadius = UDim.new(0, 20)

local WSSliderFill = Instance.new("Frame", WSSliderBg)
WSSliderFill.Size = UDim2.new((_G.WalkSpeed - 5) / (1000 - 5), 0, 1, 0)
WSSliderFill.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSSliderFill).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSSliderFill, true)

local WSValLabel = Instance.new("TextLabel", WSSliderBg)
WSValLabel.Size = UDim2.new(1, 0, 1, 0)
WSValLabel.BackgroundTransparency = 1
WSValLabel.Text = "Speed: " .. _G.WalkSpeed
WSValLabel.Font = Enum.Font.GothamBold
WSValLabel.TextSize = 12 CreateTextGradient(WSValLabel)

local WSBtnFrame = Instance.new("Frame", WSContainer)
WSBtnFrame.Size = UDim2.new(1, 0, 0, 32)
WSBtnFrame.Position = UDim2.new(0, 0, 0, 82)
WSBtnFrame.BackgroundTransparency = 1

local function createWSBtn(text, posScale)
    local btn = Instance.new("TextButton", WSBtnFrame) btn.Size = UDim2.new(0.22, 0, 1, 0) btn.Position = UDim2.new(posScale, 0, 0, 0) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16) ApplyToggleGradient(btn, false) CreateBorder(btn) CreateButtonText(btn, text, Enum.Font.GothamBold, 13) ApplyButtonAnimation(btn) return btn
end
local m10 = createWSBtn("-10", 0) local m5 = createWSBtn("-5", 0.26) local p5 = createWSBtn("+5", 0.52) local p10 = createWSBtn("+10", 0.78)

local function UpdateWS(val)
    _G.WalkSpeed = math.clamp(val, 5, 1000)
    WSSliderFill.Size = UDim2.new((_G.WalkSpeed - 5) / (1000 - 5), 0, 1, 0)
    WSValLabel.Text = "Speed: " .. math.floor(_G.WalkSpeed)
end
m10.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed - 10) end)
m5.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed - 5) end)
p5.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed + 5) end)
p10.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed + 10) end)

WSToggle.MouseButton1Click:Connect(function()
    _G.WalkSpeedEnabled = not _G.WalkSpeedEnabled
    WSToggleTxt.Text = "♢ WALKSPEED: " .. (_G.WalkSpeedEnabled and "ON" or "OFF")
    ApplyToggleGradient(WSToggle, _G.WalkSpeedEnabled)
end)

local draggingWS = false
WSSliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWS = true end end)
WSSliderBg.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWS = false end end)
UserInputService.InputChanged:Connect(function(input)
    if draggingWS and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = math.clamp((input.Position.X - WSSliderBg.AbsolutePosition.X) / WSSliderBg.AbsoluteSize.X, 0, 1)
        UpdateWS(5 + relX * (1000 - 5))
    end
end)


-- [ 2. NOCLIP LOGIC TRỰC TIẾP TỪ BẠN CUNG CẤP ] --
local NoclipBtn = Instance.new("TextButton", Content)
NoclipBtn.Size = UDim2.new(1, -20, 0, 36)
NoclipBtn.Text = "" 
NoclipBtn.BackgroundColor3 = Color3.new(1,1,1)
NoclipBtn.LayoutOrder = 2
Instance.new("UICorner", NoclipBtn).CornerRadius = UDim.new(0, 20)
CreateBorder(NoclipBtn)

local noclip = false
ApplyToggleGradient(NoclipBtn, noclip) 
local NoclipTxt = CreateButtonText(NoclipBtn, "♢ NOCLIP: OFF", Enum.Font.GothamBold, 13)
ApplyButtonAnimation(NoclipBtn)

NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipTxt.Text = "♢ NOCLIP: " .. (noclip and "ON" or "OFF")
    ApplyToggleGradient(NoclipBtn, noclip)
end)

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)


-- [ 3. ẢNH DỌC (PORTRAIT) & CHỨC NĂNG ZOOM ] --
local ImageContainer = Instance.new("Frame", Content)
ImageContainer.Size = UDim2.new(1, -20, 0, 390) 
ImageContainer.BackgroundTransparency = 1
ImageContainer.LayoutOrder = 3

local ImageMask = Instance.new("Frame", ImageContainer)
ImageMask.Size = UDim2.new(0, 250, 0, 350)
ImageMask.AnchorPoint = Vector2.new(0.5, 0)
ImageMask.Position = UDim2.new(0.5, 0, 0, 0)
ImageMask.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
ImageMask.ClipsDescendants = true 
Instance.new("UICorner", ImageMask).CornerRadius = UDim.new(0, 10)
CreateBorder(ImageMask)

local ImageDeco = Instance.new("ImageLabel", ImageMask)
ImageDeco.Size = UDim2.new(1, 0, 1, 0)
ImageDeco.AnchorPoint = Vector2.new(0.5, 0.5)
ImageDeco.Position = UDim2.new(0.5, 0, 0.5, 0) 
ImageDeco.BackgroundTransparency = 1
ImageDeco.Image = "rbxassetid://93498935362683"
ImageDeco.ScaleType = Enum.ScaleType.Fit 

local ImageScale = Instance.new("UIScale", ImageDeco)
ImageScale.Scale = 1

local ZoomFrame = Instance.new("Frame", ImageContainer)
ZoomFrame.Size = UDim2.new(1, 0, 0, 32)
ZoomFrame.Position = UDim2.new(0, 0, 0, 358)
ZoomFrame.BackgroundTransparency = 1

local function createZoomBtn(text, posScale)
    local btn = Instance.new("TextButton", ZoomFrame) btn.Size = UDim2.new(0.2, 0, 1, 0) btn.Position = UDim2.new(posScale, 0, 0, 0) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10) ApplyToggleGradient(btn, false) CreateBorder(btn) CreateButtonText(btn, text, Enum.Font.GothamBold, 18) ApplyButtonAnimation(btn) return btn
end

local ZOutBtn = createZoomBtn("-", 0.1)
local ZInBtn = createZoomBtn("+", 0.7)

local ZoomTxtLabel = Instance.new("TextLabel", ZoomFrame)
ZoomTxtLabel.Size = UDim2.new(0.4, 0, 1, 0)
ZoomTxtLabel.Position = UDim2.new(0.3, 0, 0, 0)
ZoomTxtLabel.BackgroundTransparency = 1
ZoomTxtLabel.Text = "Zoom: 100%"
ZoomTxtLabel.Font = Enum.Font.GothamBold
ZoomTxtLabel.TextSize = 14
CreateTextGradient(ZoomTxtLabel)

local currentZoom = 1
local function applyZoom(val)
    currentZoom = math.clamp(val, 0.5, 4) 
    TweenService:Create(ImageScale, TweenInfo.new(0.2), {Scale = currentZoom}):Play()
    ZoomTxtLabel.Text = "Zoom: " .. math.floor(currentZoom * 100) .. "%"
    if currentZoom <= 1 then
        TweenService:Create(ImageDeco, TweenInfo.new(0.2), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
    end
end
ZOutBtn.MouseButton1Click:Connect(function() applyZoom(currentZoom - 0.25) end)
ZInBtn.MouseButton1Click:Connect(function() applyZoom(currentZoom + 0.25) end)

local draggingImg = false
local dragStart, startPos

ImageMask.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and currentZoom > 1 then
        draggingImg = true
        Content.ScrollingEnabled = false
        dragStart = input.Position
        startPos = ImageDeco.Position
    end
end)
ImageMask.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        draggingImg = false
        Content.ScrollingEnabled = true
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingImg and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ImageDeco.Position = UDim2.new(0.5, startPos.X.Offset + (delta.X / currentZoom), 0.5, startPos.Y.Offset + (delta.Y / currentZoom))
    end
end)

-- [ VÒNG LẶP HỆ THỐNG AN TOÀN ] --
local renderConn
renderConn = RunService.Heartbeat:Connect(function()
    if not ScreenGui or not ScreenGui.Parent then 
        renderConn:Disconnect()
        return 
    end
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = _G.WalkSpeedEnabled and _G.WalkSpeed or 10 end
    end
    pcall(function()
        local shift = tick() * 0.15
        local seqOn = GetMovingColorSequence(Palettes.On, shift)
        local seqOff = GetMovingColorSequence(Palettes.Off, shift)
        local seqText = GetMovingColorSequence(Palettes.Text, shift * 1.5)
        local seqBorder = GetMovingColorSequence(Palettes.Border, shift * 1.8)

        for i = #UIGradientList, 1, -1 do
            local grad = UIGradientList[i]
            if not grad or not grad.Parent then table.remove(UIGradientList, i) else grad.Color = seqBorder end
        end
        for i = #TextGradientList, 1, -1 do
            local grad = TextGradientList[i]
            if not grad or not grad.Parent then table.remove(TextGradientList, i) elseif not grad:GetAttribute("CustomOnColor") then grad.Color = seqText end
        end
        for i = #BtnGradientList, 1, -1 do
            local grad = BtnGradientList[i]
            if not grad or not grad.Parent then table.remove(BtnGradientList, i) else grad.Color = (grad.Parent:GetAttribute("IsOn") and seqOn or seqOff) end
        end
    end)
end)
