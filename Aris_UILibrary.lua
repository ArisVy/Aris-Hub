-- ==========================================================
-- ARIS UI LIBRARY - LIGHTWEIGHT & ANIMATED FRAMEWORK
-- Open Source UI Library for Roblox
-- ==========================================================

local ArisUI = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = (gethui and gethui()) or Players.LocalPlayer:WaitForChild("PlayerGui")

-- [[ LƯU TRỮ HIỆU ỨNG (Tránh lỗi bộ nhớ) ]] --
local UIGradientList = {}
local TextGradientList = {}
local BtnGradientList = {}

-- [[ BẢNG MÀU CHÍNH ]] --
local Palettes = {
    On = { Color3.fromRGB(0, 240, 255), Color3.fromRGB(130, 100, 255), Color3.fromRGB(255, 150, 255), Color3.fromRGB(0, 240, 255) },
    Off = { Color3.fromRGB(12, 12, 12), Color3.fromRGB(180, 20, 20), Color3.fromRGB(12, 12, 12) },
    Text = { Color3.fromRGB(0, 150, 255), Color3.fromRGB(255, 0, 150), Color3.fromRGB(0, 150, 255) },
    Border = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(15, 15, 15), Color3.fromRGB(255, 0, 0) }
}

-- [[ HÀM TIỆN ÍCH LÕI ]] --
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

local function MakeDraggable(f)
    local d = false; local i, s
    f.InputBegan:Connect(function(inp) 
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then 
            d = true; i = inp.Position; s = f.Position 
        end 
    end)
    f.InputChanged:Connect(function(inp) 
        if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and d then 
            local delta = inp.Position - i; 
            f.Position = UDim2.new(s.X.Scale, s.X.Offset + delta.X, s.Y.Scale, s.Y.Offset + delta.Y) 
        end 
    end)
    UserInputService.InputEnded:Connect(function(inp) 
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then d = false end 
    end)
end

local function CreateBorder(parent)
    local stroke = Instance.new("UIStroke", parent) 
    stroke.Thickness = 1.8 
    stroke.Color = Color3.new(1, 1, 1)
    local grad = Instance.new("UIGradient", stroke) 
    grad.Rotation = 90 
    table.insert(UIGradientList, grad)
end

local function CreateTextGradient(parent)
    parent.BackgroundTransparency = 1 
    parent.TextColor3 = Color3.new(1, 1, 1) 
    parent.TextStrokeTransparency = 1 
    
    local txtStroke = parent:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
    txtStroke.Thickness = 0.5 
    txtStroke.Color = Color3.new(0, 0, 0)
    txtStroke.Parent = parent
    
    local grad = parent:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
    grad.Rotation = 90 
    grad.Parent = parent
    table.insert(TextGradientList, grad)
end

local function ApplyToggleGradient(parent, isOn)
    local grad = parent:FindFirstChild("ToggleGrad")
    if not grad then
        grad = Instance.new("UIGradient", parent) 
        grad.Name = "ToggleGrad" 
        grad.Rotation = 90 
        table.insert(BtnGradientList, grad)
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

local function CreateButtonText(parent, text, font, size)
    local txt = Instance.new("TextLabel", parent) 
    txt.Size = UDim2.new(1, 0, 1, 0) 
    txt.BackgroundTransparency = 1 
    txt.Text = text 
    txt.Font = font 
    txt.TextSize = size 
    CreateTextGradient(txt) 
    return txt
end

local function ApplyButtonAnimation(btn)
    local scale = Instance.new("UIScale", btn) scale.Scale = 1
    btn.MouseEnter:Connect(function() TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
    btn.MouseLeave:Connect(function() TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1.0}):Play() end)
    btn.MouseButton1Down:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 0.9}):Play() end)
    btn.MouseButton1Up:Connect(function() TweenService:Create(scale, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1.05}):Play() end)
end

-- [[ HỆ THỐNG THÔNG BÁO ]] --
local _NotiGui = Instance.new("ScreenGui", CoreGui)
_NotiGui.Name = "ArisNotification"
local _NotiContainer = Instance.new("Frame", _NotiGui)
_NotiContainer.BackgroundTransparency = 1 _NotiContainer.AnchorPoint = Vector2.new(1, 1) 
_NotiContainer.Position = UDim2.new(1, -5, 1, -5) _NotiContainer.Size = UDim2.new(0, 350, 1, -10)
local _NotiList = Instance.new("UIListLayout", _NotiContainer)
_NotiList.SortOrder = Enum.SortOrder.LayoutOrder _NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom _NotiList.Padding = UDim.new(0, 5)

function ArisUI:Notify(Setting)
    local Title = Setting.Title or "Notification"
    local Description = Setting.Description or ""
    local Duration = Setting.Duration or 5
    
    local NotiFrame = Instance.new("Frame", _NotiContainer)
    NotiFrame.BackgroundTransparency = 1 NotiFrame.Size = UDim2.new(1, 0, 0, 0) NotiFrame.AutomaticSize = Enum.AutomaticSize.Y NotiFrame.ClipsDescendants = true
    
    local Noticontainer = Instance.new("Frame", NotiFrame)
    Noticontainer.Position = UDim2.new(1, 0, 0, 0) Noticontainer.Size = UDim2.new(1, 0, 1, 6) Noticontainer.AutomaticSize = Enum.AutomaticSize.Y Noticontainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", Noticontainer).CornerRadius = UDim.new(0, 4)
    
    local Topnoti = Instance.new("Frame", Noticontainer)
    Topnoti.BackgroundTransparency = 1 Topnoti.Position = UDim2.new(0, 0, 0, 5) Topnoti.Size = UDim2.new(1, 0, 0, 25)
    
    local TextLabelNoti = Instance.new("TextLabel", Topnoti)
    TextLabelNoti.BackgroundTransparency = 1 TextLabelNoti.Position = UDim2.new(0, 8, 0, 0) TextLabelNoti.Size = UDim2.new(1, -35, 1, 0)
    TextLabelNoti.Font = Enum.Font.GothamBold TextLabelNoti.TextSize = 14 TextLabelNoti.TextWrapped = true TextLabelNoti.TextXAlignment = Enum.TextXAlignment.Left TextLabelNoti.RichText = true TextLabelNoti.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabelNoti.Text = "<font color=\"rgb(255,80,80)\">Aris Hub</font> " .. tostring(Title)
    
    local CloseContainer = Instance.new("Frame", Topnoti)
    CloseContainer.AnchorPoint = Vector2.new(1, 0.5) CloseContainer.BackgroundTransparency = 1 CloseContainer.Position = UDim2.new(1, -4, 0.5, 0) CloseContainer.Size = UDim2.new(0, 22, 0, 22)
    local CloseImage = Instance.new("ImageLabel", CloseContainer)
    CloseImage.BackgroundTransparency = 1 CloseImage.Size = UDim2.new(1, 0, 1, 0) CloseImage.Image = "rbxassetid://3926305904" CloseImage.ImageRectOffset = Vector2.new(284, 4) CloseImage.ImageRectSize = Vector2.new(24, 24) CloseImage.ImageColor3 = Color3.fromRGB(200, 200, 200)
    local CloseBtn = Instance.new("TextButton", CloseContainer) CloseBtn.BackgroundTransparency = 1 CloseBtn.Size = UDim2.new(1, 0, 1, 0) CloseBtn.Text = "" CloseBtn.ZIndex = 10
    
    local TextLabelNoti2 = Instance.new("TextLabel", Noticontainer)
    TextLabelNoti2.BackgroundTransparency = 1 TextLabelNoti2.Position = UDim2.new(0, 10, 0, 35) TextLabelNoti2.Size = UDim2.new(1, -15, 0, 0)
    TextLabelNoti2.Font = Enum.Font.GothamBold TextLabelNoti2.Text = tostring(Description) TextLabelNoti2.TextSize = 14 TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left TextLabelNoti2.RichText = true TextLabelNoti2.TextColor3 = Color3.fromRGB(200, 200, 200) TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y TextLabelNoti2.TextWrapped = true
    
    local _closed = false
    local function remove()
        if _closed then return end _closed = true
        TweenService:Create(Noticontainer, TweenInfo.new(0.25), {Position = UDim2.new(1, 0, 0, 0)}):Play()
        task.delay(0.3, function() if NotiFrame then NotiFrame:Destroy() end end)
    end
    
    TweenService:Create(Noticontainer, TweenInfo.new(0.25), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    CloseBtn.MouseButton1Click:Connect(remove)
    task.delay(tonumber(Duration) or 3, remove)
end

-- [[ KHỞI TẠO MENU CHÍNH ]] --
function ArisUI:CreateWindow(TitleText)
    local WindowData = { CurrentTab = nil, Tabs = {}, ContentFrames = {} }
    
    if CoreGui:FindFirstChild("ArisHUB_PRO") then CoreGui.ArisHUB_PRO:Destroy() end
    local ScreenGui = Instance.new("ScreenGui", CoreGui) ScreenGui.Name = "ArisHUB_PRO" ScreenGui.ResetOnSpawn = false
    
    -- Nút bật tắt Menu
    local ToggleBtn = Instance.new("ImageButton", ScreenGui) 
    ToggleBtn.Size = UDim2.new(0,50,0,50) 
    ToggleBtn.Position = UDim2.new(0,10,0.5,-25)
    ToggleBtn.Image = "rbxassetid://125329301331069" 
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) 
    ToggleBtn.ClipsDescendants = true
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0,20)
    CreateBorder(ToggleBtn) MakeDraggable(ToggleBtn) ApplyButtonAnimation(ToggleBtn)

    -- Khung Menu
    local MainFrame = Instance.new("Frame", ScreenGui) 
    MainFrame.Size = UDim2.new(0,400,0,310) 
    MainFrame.Position = UDim2.new(0,70,0.2,0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,18) 
    MainFrame.Visible = false
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,20)
    CreateBorder(MainFrame) MakeDraggable(MainFrame)

    local isMenuOpen = false
    ToggleBtn.MouseButton1Click:Connect(function() isMenuOpen = not isMenuOpen; MainFrame.Visible = isMenuOpen end)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then isMenuOpen = not isMenuOpen; MainFrame.Visible = isMenuOpen end
    end)

    -- Tiêu đề
    local Title = Instance.new("TextLabel", MainFrame) 
    Title.Size = UDim2.new(1,-215,0,45) 
    Title.Position = UDim2.new(0,60,0,0)
    Title.Text = TitleText or "ARIS HUB V1.0" 
    Title.Font = Enum.Font.GothamBlack 
    Title.TextSize = 20 
    Title.BackgroundTransparency = 1 
    Title.TextXAlignment = Enum.TextXAlignment.Center
    CreateTextGradient(Title)

    -- Khu vực Tabs
    local TabFrame = Instance.new("ScrollingFrame", MainFrame) 
    TabFrame.Size = UDim2.new(1,-10,0,35) 
    TabFrame.Position = UDim2.new(0,5,0,45)
    TabFrame.BackgroundTransparency = 1 
    TabFrame.ScrollBarThickness = 3 
    TabFrame.ScrollingDirection = Enum.ScrollingDirection.X 
    TabFrame.BorderSizePixel = 0
    local tabListLayout = Instance.new("UIListLayout", TabFrame) 
    tabListLayout.FillDirection = Enum.FillDirection.Horizontal 
    tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder 
    tabListLayout.Padding = UDim.new(0, 4)
    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() 
        TabFrame.CanvasSize = UDim2.new(0, tabListLayout.AbsoluteContentSize.X + 10, 0, 0) 
    end)

    -- [[ HỆ THỐNG CẬP NHẬT MÀU MƯỢT MÀ ]] --
    RunService.RenderStepped:Connect(function()
        local shift = tick() * 0.15
        local seqOn = GetMovingColorSequence(Palettes.On, shift)
        local seqOff = GetMovingColorSequence(Palettes.Off, shift)
        local seqText = GetMovingColorSequence(Palettes.Text, shift * 1.5)
        local seqBorder = GetMovingColorSequence(Palettes.Border, shift * 1.8)

        for i = #UIGradientList, 1, -1 do
            local grad = UIGradientList[i]
            if grad.Parent then grad.Color = seqBorder else table.remove(UIGradientList, i) end
        end

        for i = #TextGradientList, 1, -1 do
            local grad = TextGradientList[i]
            if grad.Parent then 
                if not grad:GetAttribute("CustomOnColor") then grad.Color = seqText end
            else table.remove(TextGradientList, i) end
        end

        for i = #BtnGradientList, 1, -1 do
            local grad = BtnGradientList[i]
            if grad.Parent then 
                grad.Color = grad.Parent:GetAttribute("IsOn") and seqOn or seqOff 
            else table.remove(BtnGradientList, i) end
        end
    end)

    -- [[ TẠO TAB MỚI ]] --
    function WindowData:CreateTab(TabName)
        local TabItem = {}
        
        -- Nút bấm cho Tab
        local btn = Instance.new("TextButton", TabFrame) 
        btn.Size = UDim2.new(0, 80, 1, -5) 
        btn.Text = "" 
        btn.BackgroundColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,16)
        ApplyToggleGradient(btn, false) 
        CreateBorder(btn) 
        CreateButtonText(btn, TabName, Enum.Font.GothamBold, 10) 
        ApplyButtonAnimation(btn)

        -- Khung chứa chức năng bên trong
        local content = Instance.new("ScrollingFrame", MainFrame) 
        content.Size = UDim2.new(1,-10,1,-95) 
        content.Position = UDim2.new(0,5,0,85)
        content.BackgroundTransparency = 1 
        content.ScrollBarThickness = 5 
        content.Visible = false 
        content.BorderSizePixel = 0
        local list = Instance.new("UIListLayout", content) 
        list.Padding = UDim.new(0,8) 
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() 
            content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15) 
        end)
        local pad = Instance.new("UIPadding", content) 
        pad.PaddingLeft = UDim.new(0,5) 
        pad.PaddingTop = UDim.new(0,5)

        table.insert(self.Tabs, btn) 
        table.insert(self.ContentFrames, content)

        btn.MouseButton1Click:Connect(function()
            for _, f in pairs(self.ContentFrames) do f.Visible = false end
            for _, b in pairs(self.Tabs) do ApplyToggleGradient(b, false) end
            content.Visible = true 
            ApplyToggleGradient(btn, true)
        end)
        
        if #self.Tabs == 1 then content.Visible = true; ApplyToggleGradient(btn, true) end

        -- [[ CÁC THÀNH PHẦN BÊN TRONG TAB ]] --
        
        -- Phân tần (Section / Nhóm chức năng)
        function TabItem:CreateSection(name)
            local frame = Instance.new("Frame", content)
            frame.Size = UDim2.new(1, -16, 0, 30)
            frame.BackgroundTransparency = 1

            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1, 0, 1, -5)
            label.Position = UDim2.new(0, 0, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = "  " .. name
            label.Font = Enum.Font.GothamBlack
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            CreateTextGradient(label)

            local line = Instance.new("Frame", frame)
            line.Size = UDim2.new(1, 0, 0, 2)
            line.Position = UDim2.new(0, 0, 1, -2)
            line.BackgroundColor3 = Color3.new(1, 1, 1)
            line.BorderSizePixel = 0
            
            local lineGrad = Instance.new("UIGradient", line)
            table.insert(UIGradientList, lineGrad)
        end

        -- Nhãn chữ thông thường (Label)
        function TabItem:CreateLabel(text)
            local frame = Instance.new("Frame", content) 
            frame.BackgroundTransparency = 1 
            frame.Size = UDim2.new(1, -16, 0, 25)
            
            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextColor3 = Color3.fromRGB(200, 200, 200)
            label.TextWrapped = true
            label.TextXAlignment = Enum.TextXAlignment.Center
        end

        -- Nút bấm (Button)
        function TabItem:CreateButton(name, callback)
            local tBtn = Instance.new("TextButton", content) 
            tBtn.Size = UDim2.new(1, -16, 0, 36) 
            tBtn.Text = "" 
            tBtn.BackgroundColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 20) 
            ApplyToggleGradient(tBtn, false) 
            CreateBorder(tBtn) 
            CreateButtonText(tBtn, name, Enum.Font.GothamBold, 13) 
            ApplyButtonAnimation(tBtn)
            tBtn.MouseButton1Click:Connect(function() if callback then callback() end end)
        end

        -- Công tắc bật/tắt (Toggle)
        function TabItem:CreateToggle(name, defaultState, callback)
            local state = defaultState or false
            local tBtn = Instance.new("TextButton", content) 
            tBtn.Size = UDim2.new(1, -16, 0, 36) 
            tBtn.Text = "" 
            tBtn.BackgroundColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 20) 
            ApplyToggleGradient(tBtn, state) 
            CreateBorder(tBtn) 
            local btnTxt = CreateButtonText(tBtn, name..": "..(state and "ON" or "OFF"), Enum.Font.GothamBold, 14) 
            ApplyButtonAnimation(tBtn)
            tBtn.MouseButton1Click:Connect(function() 
                state = not state 
                btnTxt.Text = name..": "..(state and "ON" or "OFF") 
                ApplyToggleGradient(tBtn, state) 
                if callback then callback(state) end 
            end)
        end

        -- Khung tùy chỉnh số (Adjust/Slider)
        function TabItem:CreateAdjust(name, step, minV, maxV, defaultValue, callback)
            local currentValue = defaultValue or minV
            local frame = Instance.new("Frame", content) 
            frame.Size = UDim2.new(1,-16,0,36) 
            frame.BackgroundTransparency = 1
            local label = Instance.new("TextLabel", frame) 
            label.Size = UDim2.new(0.55,0,1,0) 
            label.Position = UDim2.new(0.2,0,0,0) 
            label.BackgroundTransparency = 1 
            label.Text = name..": "..currentValue 
            label.Font = Enum.Font.GothamBold 
            label.TextSize = 14 
            CreateTextGradient(label)
            
            local minus = Instance.new("TextButton", frame) 
            minus.Size = UDim2.new(0.2,-5,1,0) 
            minus.Text = "" 
            minus.BackgroundColor3 = Color3.new(1,1,1) 
            Instance.new("UICorner", minus).CornerRadius = UDim.new(0,20) 
            ApplyToggleGradient(minus, false) CreateBorder(minus) 
            CreateButtonText(minus, "-", Enum.Font.GothamBold, 18) 
            ApplyButtonAnimation(minus)
            minus.MouseButton1Click:Connect(function() 
                currentValue = math.clamp(currentValue - step, minV, maxV) 
                label.Text = name..": "..currentValue 
                if callback then callback(currentValue) end 
            end)

            local plus = Instance.new("TextButton", frame) 
            plus.Size = UDim2.new(0.2,-5,1,0) 
            plus.Position = UDim2.new(0.8,5,0,0) 
            plus.Text = "" 
            plus.BackgroundColor3 = Color3.new(1,1,1) 
            Instance.new("UICorner", plus).CornerRadius = UDim.new(0,20) 
            ApplyToggleGradient(plus, false) CreateBorder(plus) 
            CreateButtonText(plus, "+", Enum.Font.GothamBold, 16) 
            ApplyButtonAnimation(plus)
            plus.MouseButton1Click:Connect(function() 
                currentValue = math.clamp(currentValue + step, minV, maxV) 
                label.Text = name..": "..currentValue 
                if callback then callback(currentValue) end 
            end)
        end

        -- Ô chọn lọc trượt xuống (Expanding Dropdown)
        function TabItem:CreateDropdown(name, options, defaultOption, callback)
            local isOpen = false
            local optionHeight = 30
            local maxDropdownHeight = math.min(#options * optionHeight, 120) 
            
            local container = Instance.new("Frame", content)
            container.Size = UDim2.new(1, -16, 0, 36)
            container.BackgroundTransparency = 1
            container.ClipsDescendants = true 
            
            local mainBtn = Instance.new("TextButton", container)
            mainBtn.Size = UDim2.new(1, 0, 0, 36)
            mainBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 8)
            CreateBorder(mainBtn)
            
            local btnTxt = CreateButtonText(mainBtn, name .. ": " .. tostring(defaultOption or options[1]), Enum.Font.GothamBold, 13)
            
            local arrow = Instance.new("TextLabel", mainBtn)
            arrow.Size = UDim2.new(0, 30, 1, 0)
            arrow.Position = UDim2.new(1, -30, 0, 0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "+"
            arrow.Font = Enum.Font.GothamBold
            arrow.TextSize = 16
            arrow.TextColor3 = Color3.new(1,1,1)
            
            local dropFrame = Instance.new("ScrollingFrame", container)
            dropFrame.Size = UDim2.new(1, 0, 0, maxDropdownHeight)
            dropFrame.Position = UDim2.new(0, 0, 0, 40)
            dropFrame.BackgroundTransparency = 1
            dropFrame.ScrollBarThickness = 2
            dropFrame.CanvasSize = UDim2.new(0, 0, 0, #options * optionHeight)
            dropFrame.BorderSizePixel = 0
            
            local dropList = Instance.new("UIListLayout", dropFrame)
            dropList.SortOrder = Enum.SortOrder.LayoutOrder
            
            for _, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton", dropFrame)
                optBtn.Size = UDim2.new(1, 0, 0, optionHeight)
                optBtn.BackgroundTransparency = 1
                optBtn.Text = "  " .. tostring(opt)
                optBtn.Font = Enum.Font.Gotham
                optBtn.TextSize = 12
                optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                optBtn.TextXAlignment = Enum.TextXAlignment.Left
                
                optBtn.MouseButton1Click:Connect(function()
                    btnTxt.Text = name .. ": " .. tostring(opt)
                    isOpen = false
                    TweenService:Create(container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -16, 0, 36)}):Play()
                    arrow.Text = "+"
                    if callback then callback(opt) end
                end)
            end
            
            mainBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    TweenService:Create(container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -16, 0, 36 + maxDropdownHeight + 5)}):Play()
                    arrow.Text = "-"
                else
                    TweenService:Create(container, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, -16, 0, 36)}):Play()
                    arrow.Text = "+"
                end
            end)
        end

        -- Khung nhập Text (Textbox)
        function TabItem:CreateTextbox(name, placeholder, callback)
            local frame = Instance.new("Frame", content) 
            frame.Size = UDim2.new(1, -16, 0, 36) 
            frame.BackgroundTransparency = 1

            local label = Instance.new("TextLabel", frame) 
            label.Size = UDim2.new(0.5, 0, 1, 0) 
            label.Position = UDim2.new(0, 5, 0, 0) 
            label.BackgroundTransparency = 1 
            label.Text = name 
            label.Font = Enum.Font.GothamBold 
            label.TextSize = 13 
            label.TextXAlignment = Enum.TextXAlignment.Left
            CreateTextGradient(label)

            local txtBox = Instance.new("TextBox", frame) 
            txtBox.Size = UDim2.new(0.5, -5, 1, -6) 
            txtBox.Position = UDim2.new(0.5, 0, 0, 3)
            txtBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            txtBox.Text = "" 
            txtBox.PlaceholderText = placeholder or "Nhập..." 
            txtBox.Font = Enum.Font.Gotham 
            txtBox.TextSize = 12 
            txtBox.TextColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", txtBox).CornerRadius = UDim.new(0, 6)
            CreateBorder(txtBox)

            txtBox.FocusLost:Connect(function(enterPressed)
                if enterPressed and callback then callback(txtBox.Text) end
            end)
        end

        -- Cài đặt Phím tắt (Keybind)
        function TabItem:CreateKeybind(name, defaultKey, callback)
            local currentKey = defaultKey or Enum.KeyCode.Unknown
            local isListening = false
            
            local frame = Instance.new("Frame", content) 
            frame.Size = UDim2.new(1, -16, 0, 36) 
            frame.BackgroundTransparency = 1

            local label = Instance.new("TextLabel", frame) 
            label.Size = UDim2.new(0.6, 0, 1, 0) 
            label.Position = UDim2.new(0, 5, 0, 0) 
            label.BackgroundTransparency = 1 
            label.Text = name 
            label.Font = Enum.Font.GothamBold 
            label.TextSize = 13 
            label.TextXAlignment = Enum.TextXAlignment.Left
            CreateTextGradient(label)

            local bindBtn = Instance.new("TextButton", frame) 
            bindBtn.Size = UDim2.new(0.4, -5, 1, -6) 
            bindBtn.Position = UDim2.new(0.6, 0, 0, 3) 
            bindBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Instance.new("UICorner", bindBtn).CornerRadius = UDim.new(0, 6)
            CreateBorder(bindBtn)
            
            local bindTxt = CreateButtonText(bindBtn, currentKey.Name, Enum.Font.GothamBold, 12)
            ApplyButtonAnimation(bindBtn)

            bindBtn.MouseButton1Click:Connect(function()
                isListening = true
                bindTxt.Text = "..."
            end)

            UserInputService.InputBegan:Connect(function(input, processed)
                if isListening and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    bindTxt.Text = currentKey.Name
                    isListening = false
                elseif not isListening and input.KeyCode == currentKey and not processed then
                    if callback then callback(currentKey) end
                end
            end)
        end

        return TabItem
    end

    return WindowData
end

return ArisUI
