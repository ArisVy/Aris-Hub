#### Open source , tụi bây lấy thì cứ lấy t lười quá
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local CoreGui = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")

if CoreGui:FindFirstChild("BananaNotification") then
    CoreGui.BananaNotification:Destroy()
end
if CoreGui:FindFirstChild("ArisHUB_PRO") then
    CoreGui.ArisHUB_PRO:Destroy()
end

local _NotiGui = Instance.new("ScreenGui")
_NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_NotiGui.Name = "BananaNotification"
_NotiGui.Parent = CoreGui

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
    Noticontainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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
    TextLabelNoti.TextWrapped = true
    TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left
    TextLabelNoti.RichText = true
    TextLabelNoti.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabelNoti.Text = "<font color=\"rgb(255,80,80)\">Aris Hub x Phong Roblox</font> " .. tostring(Title)
    
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
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.SourceSans
    
    TextLabelNoti2.Parent = Noticontainer
    TextLabelNoti2.BackgroundTransparency = 1
    TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35)
    TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
    TextLabelNoti2.Font = Enum.Font.GothamBold
    TextLabelNoti2.Text = tostring(Description)
    TextLabelNoti2.TextSize = 14
    TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
    TextLabelNoti2.RichText = true
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

_G.Config = {
    MenuOpen = false,
    LightningAlert = false
}
_G.IsVietnamese = false

local UIGradientList = {}
local TextGradientList = {}
local BtnGradientList = {}
local ToggleButtons = {}
local tabBtns = {}

function GetRGB() return Color3.fromHSV(tick() % 5 / 5, 1, 1) end

local Palettes = {
    On = { Color3.fromRGB(0, 240, 255), Color3.fromRGB(130, 100, 255), Color3.fromRGB(255, 150, 255), Color3.fromRGB(0, 240, 255) },
    Off = { Color3.fromRGB(12, 12, 12), Color3.fromRGB(180, 20, 20), Color3.fromRGB(12, 12, 12) },
    Text = { Color3.fromRGB(0, 150, 255), Color3.fromRGB(255, 0, 150), Color3.fromRGB(0, 150, 255) },
    Border = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(15, 15, 15), Color3.fromRGB(255, 0, 0) }
}

function GetMovingColorSequence(palette, shift)
    local keypoints = {}
    for step = 0, 5 do
        local i = step / 5
        local t = (i - shift) % 1
        if t < 0 then t = t + 1 end
        local segments = #palette - 1
        local scaled = t * segments
        local index = math.floor(scaled) + 1
        local fraction = scaled - (index - 1)
        local color
        if index >= #palette then color = palette[#palette] else color = palette[index]:Lerp(palette[index + 1], fraction) end
        table.insert(keypoints, ColorSequenceKeypoint.new(i, color))
    end
    return ColorSequence.new(keypoints)
end

function CreateBorder(parent)
    local stroke = Instance.new("UIStroke", parent) stroke.Thickness = 1.8 stroke.Color = Color3.new(1, 1, 1)
    local grad = Instance.new("UIGradient", stroke) grad.Rotation = 90 table.insert(UIGradientList, grad)
end

function CreateTextGradient(parent)
    parent.TextColor3 = Color3.new(1, 1, 1) parent.TextStrokeTransparency = 1
    local txtStroke = Instance.new("UIStroke", parent) txtStroke.Thickness = 0.5 txtStroke.Color = Color3.new(0, 0, 0)
    local grad = Instance.new("UIGradient", parent) grad.Rotation = 90 table.insert(TextGradientList, grad)
end

function ApplyToggleGradient(parent, isOn)
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
                txtGrad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
                txtGrad:SetAttribute("CustomOnColor", true)
            end
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            if txtGrad then txtGrad.Enabled = true txtGrad:SetAttribute("CustomOnColor", false) end
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end

function CreateButtonText(parent, text, font, size)
    local txt = Instance.new("TextLabel", parent) txt.Size = UDim2.new(1, 0, 1, 0) txt.BackgroundTransparency = 1 txt.Text = text txt.Font = font txt.TextSize = size CreateTextGradient(txt) return txt
end

function ApplyButtonAnimation(btn)
    local ts = game:GetService("TweenService")
    local scale = Instance.new("UIScale", btn) scale.Scale = 1
    btn.MouseEnter:Connect(function() ts:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
    btn.MouseLeave:Connect(function() ts:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.0}):Play() end)
    btn.MouseButton1Down:Connect(function() ts:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.9}):Play() end)
    btn.MouseButton1Up:Connect(function() ts:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
end

function MakeDraggable(f)
    local d=false;local i,s
    f.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=true; i=inp.Position; s=f.Position end end)
    f.InputChanged:Connect(function(inp) if (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) and d then local delta=inp.Position-i; f.Position=UDim2.new(s.X.Scale,s.X.Offset+delta.X,s.Y.Scale,s.Y.Offset+delta.Y) end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=false end end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99999
ScreenGui.Parent = CoreGui

local PopupFrame = Instance.new("Frame", ScreenGui)
PopupFrame.Size = UDim2.new(0, 380, 0, 160)
PopupFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
PopupFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PopupFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
PopupFrame.ZIndex = 50
Instance.new("UICorner", PopupFrame).CornerRadius = UDim.new(0, 16)
CreateBorder(PopupFrame)

local PopupClose = Instance.new("TextButton", PopupFrame)
PopupClose.Size = UDim2.new(0, 30, 0, 30)
PopupClose.Position = UDim2.new(1, -35, 0, 5)
PopupClose.Text = "X"
PopupClose.Font = Enum.Font.GothamBold
PopupClose.TextSize = 16
PopupClose.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
PopupClose.TextColor3 = Color3.fromRGB(255, 50, 50)
PopupClose.ZIndex = 51
Instance.new("UICorner", PopupClose).CornerRadius = UDim.new(0, 8)
CreateBorder(PopupClose)
ApplyButtonAnimation(PopupClose)
PopupClose.MouseButton1Click:Connect(function()
    PopupFrame:Destroy()
end)

local PopupText = Instance.new("TextLabel", PopupFrame)
PopupText.Size = UDim2.new(1, -20, 1, -40)
PopupText.Position = UDim2.new(0, 10, 0, 35)
PopupText.BackgroundTransparency = 1
PopupText.Text = "SCRIPT NÀY SINH RA ĐỂ CHECK WORKSPACE CỦA SERVER , TỤI BÂY BẢO LỎ THÌ LỎ Ở CÁI SERVER TỤI BÂY CHƠI CHỨ LIÊN QUAN SCRIPT ĐÉO GÌ"
PopupText.Font = Enum.Font.GothamBold
PopupText.TextSize = 15
PopupText.TextWrapped = true
PopupText.TextYAlignment = Enum.TextYAlignment.Center
PopupText.ZIndex = 51
CreateTextGradient(PopupText)

local ToggleBtn = Instance.new("ImageButton",ScreenGui)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0,10,0.5,-25)
ToggleBtn.Image = "rbxassetid://125329301331069"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleBtn.ClipsDescendants = true
ToggleBtn.Visible = true
Instance.new("UICorner",ToggleBtn).CornerRadius = UDim.new(0,20)
CreateBorder(ToggleBtn) MakeDraggable(ToggleBtn) ApplyButtonAnimation(ToggleBtn)
local MainFrame = Instance.new("Frame",ScreenGui)
MainFrame.Size = UDim2.new(0,400,0,310)
MainFrame.Position = UDim2.new(0,70,0.2,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
MainFrame.Visible = false
Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,20)
CreateBorder(MainFrame)

local Title = Instance.new("TextLabel",MainFrame)
Title.Size = UDim2.new(1,0,0,45)
Title.Position = UDim2.new(0,0,0,0)
Title.Text = "ARIS HUB x PHONG ROBLOX"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center
CreateTextGradient(Title) MakeDraggable(MainFrame)

ToggleBtn.MouseButton1Click:Connect(function() 
    _G.Config.MenuOpen = not _G.Config.MenuOpen
    MainFrame.Visible = _G.Config.MenuOpen 
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then 
        _G.Config.MenuOpen = not _G.Config.MenuOpen
        MainFrame.Visible = _G.Config.MenuOpen 
    end
end)

local TabFrame = Instance.new("ScrollingFrame",MainFrame)
TabFrame.Size = UDim2.new(1,-10,0,35)
TabFrame.Position = UDim2.new(0,5,0,45)
TabFrame.BackgroundTransparency = 1
TabFrame.ScrollBarThickness = 3
TabFrame.ScrollingDirection = Enum.ScrollingDirection.X
TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
TabFrame.BorderSizePixel = 0

local Tabs = {"Main", "How it Works", "Support"}
local ContentFrames = {}

local tabListLayout = Instance.new("UIListLayout", TabFrame)
tabListLayout.FillDirection = Enum.FillDirection.Horizontal
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabListLayout.Padding = UDim.new(0, 4)
tabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabFrame.CanvasSize = UDim2.new(0, tabListLayout.AbsoluteContentSize.X + 10, 0, 0)
end)

for i,tab in ipairs(Tabs)do
    local btn = Instance.new("TextButton",TabFrame)
    btn.Size = UDim2.new(0, 110, 1, -5)
    btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner",btn).CornerRadius = UDim.new(0,16)
    ApplyToggleGradient(btn, false) CreateBorder(btn) 
    local txtBtn = CreateButtonText(btn, tab, Enum.Font.GothamBold, 11) 
    tabBtns[tab] = txtBtn
    ApplyButtonAnimation(btn)

    local content = Instance.new("ScrollingFrame",MainFrame)
    content.Size = UDim2.new(1,-10,1,-95) content.Position = UDim2.new(0,5,0,85) content.BackgroundTransparency = 1 content.ScrollBarThickness = 5 content.Visible = false content.BorderSizePixel = 0

    local list = Instance.new("UIListLayout",content) list.Padding = UDim.new(0,8) list.SortOrder = Enum.SortOrder.LayoutOrder
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15) end)
    local pad = Instance.new("UIPadding",content) pad.PaddingLeft = UDim.new(0,5) pad.PaddingTop = UDim.new(0,5)

    ContentFrames[tab] = {Frame=content}
    btn.MouseButton1Click:Connect(function() for _,f in pairs(ContentFrames)do f.Frame.Visible=false end content.Visible=true end)
end
ContentFrames["Main"].Frame.Visible=true

local transBtn = Instance.new("TextButton", TabFrame)
transBtn.Size = UDim2.new(0, 70, 1, -5)
transBtn.Text = ""
transBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", transBtn).CornerRadius = UDim.new(0,16)
ApplyToggleGradient(transBtn, false)
CreateBorder(transBtn)
local transTxt = CreateButtonText(transBtn, "🌐 ENG", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(transBtn)

function AddLabel(tab, text)
    local content = ContentFrames[tab].Frame
    local frame = Instance.new("Frame", content) 
    frame.Size = UDim2.new(1, -16, 0, 36) 
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame) 
    label.Size = UDim2.new(1, 0, 1, 0) 
    label.BackgroundTransparency = 1 
    label.Text = text 
    label.Font = Enum.Font.GothamBold 
    label.TextSize = 12 
    label.TextWrapped = true
    CreateTextGradient(label)
    return label
end

function AddToggle(tab,name,key,cb)
    local content = ContentFrames[tab].Frame
    local btn = Instance.new("TextButton",content) btn.Size = UDim2.new(1,-16,0,36) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner",btn).CornerRadius = UDim.new(0,20)
    ApplyToggleGradient(btn, _G.Config[key]) CreateBorder(btn) local btnTxt = CreateButtonText(btn, name..": "..(_G.Config[key]and"ON"or"OFF"), Enum.Font.GothamBold, 14) ApplyButtonAnimation(btn)
    ToggleButtons[key] = {Btn = btn, Txt = btnTxt, Name = name}
    btn.MouseButton1Click:Connect(function() 
        _G.Config[key] = not _G.Config[key] 
        local stateStr = _G.Config[key] and (_G.IsVietnamese and "BẬT" or "ON") or (_G.IsVietnamese and "TẮT" or "OFF")
        btnTxt.Text = ToggleButtons[key].Name..": "..stateStr
        ApplyToggleGradient(btn, _G.Config[key]) 
        if cb then cb(_G.Config[key])end 
    end)
end

function AddButton(tab, name, cb)
    local content = ContentFrames[tab].Frame
    local btnContainer = Instance.new("Frame", content)
    btnContainer.Size = UDim2.new(1, -16, 0, 36)
    btnContainer.BackgroundTransparency = 1

    local btn = Instance.new("TextButton", btnContainer)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(btn, false)
    CreateBorder(btn)
    local btnTxt = CreateButtonText(btn, name, Enum.Font.GothamBold, 14)
    ApplyButtonAnimation(btn)

    btn.MouseButton1Click:Connect(function()
        if cb then cb() end
    end)
    return btn, btnTxt
end

function AddTextBox(tab, title, contentText)
    local content = ContentFrames[tab].Frame
    local titleLabel = Instance.new("TextLabel", content)
    titleLabel.Size = UDim2.new(1, -16, 0, 25)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 13
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    CreateTextGradient(titleLabel)
    
    local container = Instance.new("Frame", content)
    container.Size = UDim2.new(1, -16, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)
    CreateBorder(container)
    
    local padding = Instance.new("UIPadding", container)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    
    local textLabel = Instance.new("TextLabel", container)
    textLabel.Size = UDim2.new(1, 0, 0, 0)
    textLabel.AutomaticSize = Enum.AutomaticSize.Y
    textLabel.BackgroundTransparency = 1
    textLabel.Text = contentText
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextSize = 12
    textLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    return titleLabel, textLabel
end
local sweepConnection = nil
local lastAlertTime = 0

local StatusLabel = AddLabel("Main", "⏱️ Status: Inactive")

local function triggerEarlyLightningAlert(customMsg)
    local currentTime = tick()
    if currentTime - lastAlertTime < 3.5 then return end 
    lastAlertTime = currentTime
    StatusLabel.Text = _G.IsVietnamese and "⚠️ BÁO ĐỘNG SỚM: SÉT SẮP ĐÁNH TRONG 1-2S!" or "⚠️ EARLY ALERT: LIGHTNING STRIKE IN 1-2S!"
    AddNotify({
        Title = _G.IsVietnamese and "⚡ BÁO ĐỘNG ĐỎ!" or "⚡ RED ALERT!",
        Description = _G.IsVietnamese and "Thu hoạch ngay! Tín hiệu sét đã xuất hiện trước 1-2 giây!" or (customMsg or "Harvest now! Lightning signal detected 1-2 seconds ahead!"),
        Duration = 3,
    })
    task.delay(3, function()
        if _G.Config.LightningAlert then
            StatusLabel.Text = _G.IsVietnamese and "⏱️ Trạng thái: Đang canh chừng..." or "⏱️ Status: Monitoring for the next wave..."
        end
    end)
end

local function isNearPlayer(object, maxDistance)
    maxDistance = maxDistance or 85
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return true end
    local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
    local objPos = nil
    if object:IsA("BasePart") then objPos = object.Position
    elseif object:IsA("Model") then objPos = object.PrimaryPart and object.PrimaryPart.Position or object:GetPivot().Position
    elseif object:IsA("Attachment") then objPos = object.WorldPosition end
    if objPos then return (playerPos - objPos).Magnitude <= maxDistance end
    return true
end

local function isEarlyLightningSignal(object)
    local name = string.lower(object.Name)
    local keywords = {"lightning", "strike", "warning", "thunder", "spark", "cloud", "indicator", "redcircle", "danger", "target", "charge", "aura", "flash", "electric", "pre_strike", "spawn"}
    for _, word in ipairs(keywords) do if string.find(name, word) then return true end end
    if object:IsA("ParticleEmitter") or object:IsA("Beam") or object:IsA("Highlight") or object:IsA("Sound") then
        local parentName = string.lower(object.Parent and object.Parent.Name or "")
        for _, word in ipairs(keywords) do if string.find(parentName, word) then return true end end
    end
    return false
end

function startMonitoring()
    if sweepConnection then sweepConnection:Disconnect() end
    sweepConnection = Workspace.DescendantAdded:Connect(function(child)
        if not _G.Config.LightningAlert then return end
        if isEarlyLightningSignal(child) and isNearPlayer(child) then triggerEarlyLightningAlert("Lightning is about to strike near your plants! Harvest immediately!") end
    end)
end

AddToggle("Main", "LIGHTNING ALERT", "LightningAlert", function(Value)
    if Value then
        StatusLabel.Text = _G.IsVietnamese and "⏱️ Trạng thái: Đang canh chừng..." or "⏱️ Status: Monitoring for the next wave..."
        startMonitoring()
        AddNotify({Title = _G.IsVietnamese and "BẬT CẢNH BÁO" or "ALERT ENABLED", Description = _G.IsVietnamese and "Đã kích hoạt hệ thống cảnh báo sớm!" or "Early warning system activated!", Duration=2})
    else
        StatusLabel.Text = _G.IsVietnamese and "⏱️ Trạng thái: Chưa kích hoạt" or "⏱️ Status: Monitoring disabled"
        if sweepConnection then sweepConnection:Disconnect() sweepConnection = nil end
        AddNotify({Title = _G.IsVietnamese and "TẮT CẢNH BÁO" or "ALERT DISABLED", Description = _G.IsVietnamese and "Đã dừng hệ thống quét!" or "Scanning system stopped!", Duration=2})
    end
end)

local hopBtn, hopBtnTxt = AddButton("Main", "🌐 HOP 1-PLAYER SERVER", function()
    AddNotify({Title = _G.IsVietnamese and "TÌM KIẾM" or "SEARCHING", Description = _G.IsVietnamese and "Đang tìm máy chủ 1 người..." or "Finding 1-player server...", Duration = 3})
    task.spawn(function()
        local success, result = pcall(function()
            local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
            local response = game:HttpGet(url)
            local data = HttpService:JSONDecode(response)
            
            if data and data.data then
                for _, server in ipairs(data.data) do
                    if server.playing == 1 and server.id ~= game.JobId then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                        return true
                    end
                end
            end
            return false
        end)
        
        if not success or not result then
            AddNotify({Title = _G.IsVietnamese and "THẤT BẠI" or "FAILED", Description = _G.IsVietnamese and "Không tìm thấy máy chủ 1 người nào!" or "Could not find any 1-player server!", Duration = 3})
        end
    end)
end)

local hopNote = AddLabel("Main", "Note: Teleports to a server with 1 player.\n⚠️ REMEMBER: The server already has a player and others can also join!")
hopNote.Parent.Size = UDim2.new(1, -16, 0, 55)

local LangHintLabel = AddLabel("Main", "💡 Tip: Press 🌐 ENG to switch to Vietnamese")

local Box1Title, Box1Desc = AddTextBox("How it Works", "1. MECHANISM", "The script constantly monitors the game's Workspace and hidden folders for early visual indicators (such as specific particles, beams, sounds, or warning circles). If a matching signal is detected near your character, it triggers a red alert notification immediately before the actual lightning strikes.")
local Box2Title, Box2Desc = AddTextBox("How it Works", "2. ⚠️ DISCLAIMER", "This detection method relies on predicting game mechanics and visual cues. It is NOT 100% accurate and might occasionally produce false alarms or miss a strike entirely depending on server lag, game updates, or hidden mechanics. The developer assumes NO responsibility for any lost crops, in-game assets, or accounts. Please use this tool at your own risk!")
local Box3Title, Box3Desc = AddTextBox("How it Works", "3. 💡 PRO TIP", "After planting, the first 1-2 alerts have a very high fake rate. The 3rd alert onwards has the highest chance of real lightning!")

local SupTitle, SupDesc = AddTextBox("Support", "SUPPORT THE CREATOR", "If you like this script, please support me by following my TikTok!\nLink: https://vt.tiktok.com/ZSVkjnEFj/")

local copyBtnContainer = Instance.new("Frame", ContentFrames["Support"].Frame)
copyBtnContainer.Size = UDim2.new(1, -16, 0, 36)
copyBtnContainer.BackgroundTransparency = 1

local copyBtn = Instance.new("TextButton", copyBtnContainer)
copyBtn.Size = UDim2.new(1, 0, 1, 0)
copyBtn.Text = ""
copyBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(copyBtn, false)
CreateBorder(copyBtn)
local copyBtnTxt = CreateButtonText(copyBtn, "📋 COPY TIKTOK LINK", Enum.Font.GothamBold, 14)
ApplyButtonAnimation(copyBtn)

copyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://vt.tiktok.com/ZSVkjnEFj/")
        AddNotify({Title = _G.IsVietnamese and "THÀNH CÔNG" or "SUCCESS", Description = _G.IsVietnamese and "Đã copy link TikTok!" or "Copied TikTok link!", Duration = 3})
    else
        AddNotify({Title = "ERROR", Description = "Your executor does not support setclipboard!", Duration = 3})
    end
end)

transBtn.MouseButton1Click:Connect(function()
    _G.IsVietnamese = not _G.IsVietnamese
    transTxt.Text = _G.IsVietnamese and "🌐 VIE" or "🌐 ENG"
    
    tabBtns["Main"].Text = _G.IsVietnamese and "Trang Chủ" or "Main"
    tabBtns["How it Works"].Text = _G.IsVietnamese and "Cách Hoạt Động" or "How it Works"
    tabBtns["Support"].Text = _G.IsVietnamese and "Hỗ Trợ" or "Support"
    
    LangHintLabel.Text = _G.IsVietnamese and "💡 Mẹo: Ấn 🌐 VIE để chuyển sang tiếng Anh" or "💡 Tip: Press 🌐 ENG to switch to Vietnamese"
    hopBtnTxt.Text = _G.IsVietnamese and "🌐 VÀO SERVER 1 NGƯỜI" or "🌐 HOP 1-PLAYER SERVER"
    hopNote.Text = _G.IsVietnamese 
        and "Lưu ý: Dịch chuyển tới máy chủ có sẵn 1 người.\n⚠️ HÃY NHỚ: SERVER CÓ SẴN NGƯỜI VÀ NGƯỜI KHÁC CŨNG CÓ THỂ THAM GIA" 
        or "Note: Teleports to a server with 1 player.\n⚠️ REMEMBER: The server already has a player and others can also join!"
    
    if _G.Config.LightningAlert then
        StatusLabel.Text = _G.IsVietnamese and "⏱️ Trạng thái: Đang canh chừng..." or "⏱️ Status: Monitoring for the next wave..."
    else
        StatusLabel.Text = _G.IsVietnamese and "⏱️ Trạng thái: Chưa kích hoạt" or "⏱️ Status: Inactive"
    end
    
    local tBtn = ToggleButtons["LightningAlert"]
    tBtn.Name = _G.IsVietnamese and "CẢNH BÁO SÉT" or "LIGHTNING ALERT"
    local stateStr = _G.Config.LightningAlert and (_G.IsVietnamese and "BẬT" or "ON") or (_G.IsVietnamese and "TẮT" or "OFF")
    tBtn.Txt.Text = tBtn.Name .. ": " .. stateStr

    Box1Title.Text = _G.IsVietnamese and "1. CƠ CHẾ HOẠT ĐỘNG" or "1. MECHANISM"
    Box1Desc.Text = _G.IsVietnamese and "Script liên tục kiểm tra Workspace và các thư mục ẩn để tìm dấu hiệu báo trước (như particle, tia sáng, âm thanh, vòng cảnh báo). Nếu có tín hiệu khớp ở gần bạn, hệ thống sẽ lập tức báo động đỏ ngay trước khi sét đánh thật." or "The script constantly monitors the game's Workspace and hidden folders for early visual indicators (such as specific particles, beams, sounds, or warning circles). If a matching signal is detected near your character, it triggers a red alert notification immediately before the actual lightning strikes."
    
    Box2Title.Text = _G.IsVietnamese and "2. ⚠️ TỪ CHỐI TRÁCH NHIỆM" or "2. ⚠️ DISCLAIMER"
    Box2Desc.Text = _G.IsVietnamese and "Phương pháp này hoàn toàn dựa vào việc đoán trước cơ chế game nên chắc chắn sẽ KHÔNG đúng 100%. Có thể báo động giả hoặc bị sót do lag server, cập nhật game hoặc cơ chế ẩn. Tác giả hoàn toàn không chịu trách nhiệm cho bất kỳ thiệt hại nào về cây trồng, tài sản hay tài khoản. Vui lòng tự chịu rủi ro khi dùng!" or "This detection method relies on predicting game mechanics and visual cues. It is NOT 100% accurate and might occasionally produce false alarms or miss a strike entirely depending on server lag, game updates, or hidden mechanics. The developer assumes NO responsibility for any lost crops, in-game assets, or accounts. Please use this tool at your own risk!"

    Box3Title.Text = _G.IsVietnamese and "3. 💡 MẸO NHỎ" or "3. 💡 PRO TIP"
    Box3Desc.Text = _G.IsVietnamese and "Sau khi trồng, 1-2 thông báo đầu tiên tỉ lệ fake rất cao. Từ lần thứ 3 trở đi mới có tỉ lệ sét thật cao nhất!" or "After planting, the first 1-2 alerts have a very high fake rate. The 3rd alert onwards has the highest chance of real lightning!"

    SupTitle.Text = _G.IsVietnamese and "ỦNG HỘ TÁC GIẢ" or "SUPPORT THE CREATOR"
    SupDesc.Text = _G.IsVietnamese and "Nếu bạn thấy script này hữu ích, hãy ủng hộ mình bằng cách follow TikTok nhé!\nLink: https://vt.tiktok.com/ZSVkjnEFj/" or "If you like this script, please support me by following my TikTok!\nLink: https://vt.tiktok.com/ZSVkjnEFj/"
    copyBtnTxt.Text = _G.IsVietnamese and "📋 COPY LINK TIKTOK" or "📋 COPY TIKTOK LINK"
end)

RunService.Heartbeat:Connect(function(dt)
    local shift = tick() * 0.15
    local seqOn = GetMovingColorSequence(Palettes.On, shift)
    local seqOff = GetMovingColorSequence(Palettes.Off, shift)
    local seqText = GetMovingColorSequence(Palettes.Text, shift * 1.5)
    local seqBorder = GetMovingColorSequence(Palettes.Border, shift * 1.8)

    for _, grad in ipairs(UIGradientList) do grad.Color = seqBorder end
    for _, grad in ipairs(TextGradientList) do if not grad:GetAttribute("CustomOnColor") then grad.Color = seqText end end
    for _, grad in ipairs(BtnGradientList) do if grad.Parent and grad.Parent:GetAttribute("IsOn") then grad.Color = seqOn else grad.Color = seqOff end end
end)
