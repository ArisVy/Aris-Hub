local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

if not player then return end
local LocalPlayer = Players.LocalPlayer

local introGui = Instance.new("ScreenGui")
introGui.Name = "ArisWarningIntro"
introGui.IgnoreGuiInset = true
introGui.DisplayOrder = 99999
introGui.Parent = CoreGui

local blackScreen = Instance.new("Frame")
blackScreen.Size = UDim2.new(1, 0, 1, 0)
blackScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
blackScreen.BackgroundTransparency = 1
blackScreen.Parent = introGui

local warningText = Instance.new("TextLabel")
warningText.Size = UDim2.new(1, -40, 0.7, -40)
warningText.Position = UDim2.new(0, 20, 0, 20)
warningText.BackgroundTransparency = 1
warningText.Text = "Centudox đừng share nó\nSkidder chết tiệt\n\nCentudox don't share it\nDamn Skidder"
warningText.TextColor3 = Color3.fromRGB(255, 50, 50)
warningText.Font = Enum.Font.GothamBlack
warningText.TextScaled = true
warningText.TextTransparency = 1
warningText.Parent = blackScreen

local textConstraint = Instance.new("UITextSizeConstraint")
textConstraint.MaxTextSize = 45
textConstraint.Parent = warningText

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 260, 0, 45)
copyButton.Position = UDim2.new(0.5, -130, 0.75, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
copyButton.BackgroundTransparency = 1
copyButton.Text = "🔗 Nhấn để Copy Link Discord"
copyButton.TextColor3 = Color3.fromRGB(0, 180, 255)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.TextTransparency = 1
copyButton.Parent = blackScreen

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 8)
copyCorner.Parent = copyButton

local copyStroke = Instance.new("UIStroke")
copyStroke.Color = Color3.fromRGB(0, 180, 255)
copyStroke.Thickness = 2
copyStroke.Transparency = 1
copyStroke.Parent = copyButton

copyButton.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/phongroblox")
            copyButton.Text = "✅ Đã Copy Link!"
            copyButton.TextColor3 = Color3.fromRGB(50, 255, 50)
            copyStroke.Color = Color3.fromRGB(50, 255, 50)
            
            task.delay(1.5, function()
                if copyButton then 
                    copyButton.Text = "🔗 Nhấn để Copy Link Discord" 
                    copyButton.TextColor3 = Color3.fromRGB(0, 180, 255)
                    copyStroke.Color = Color3.fromRGB(0, 180, 255)
                end
            end)
        end
    end)
end)

TweenService:Create(blackScreen, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
TweenService:Create(warningText, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
TweenService:Create(copyButton, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0, BackgroundTransparency = 0.2}):Play()
TweenService:Create(copyStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0}):Play()

task.spawn(function()
    task.wait(7)
    local fadeOutBg = TweenService:Create(blackScreen, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
    local fadeOutText = TweenService:Create(warningText, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1})
    local fadeOutBtn = TweenService:Create(copyButton, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1, BackgroundTransparency = 1})
    local fadeOutStroke = TweenService:Create(copyStroke, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency = 1})
    
    fadeOutBg:Play()
    fadeOutText:Play()
    fadeOutBtn:Play()
    fadeOutStroke:Play()
    
    fadeOutBg.Completed:Wait()
    introGui:Destroy()
end)

local function ThongBao(noiDung)
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    if PlayerGui:FindFirstChild("ArisNotify") then
        PlayerGui.ArisNotify:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "ArisNotify"
    gui.Parent = PlayerGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 85)
    frame.Position = UDim2.new(1, 20, 0.7, 0) 
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0, 10, 0.5, -25)
    icon.BackgroundTransparency = 1
    icon.Image = "rbxassetid://125329301331069"
    icon.Parent = frame

    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 25)
    iconCorner.Parent = icon

    local title = Instance.new("TextLabel")
    title.Text = "Thông báo"
    title.Size = UDim2.new(1, -80, 0, 20)
    title.Position = UDim2.new(0, 70, 0.1, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 16
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Text = noiDung or "Discord: Aris_Vy\nFacebook: Trọng Vỹ'z"
    desc.Size = UDim2.new(1, -80, 0, 45)
    desc.Position = UDim2.new(0, 70, 0.35, 0)
    desc.TextColor3 = Color3.fromRGB(220, 220, 220)
    desc.Font = Enum.Font.SourceSans
    desc.TextSize = 14
    desc.BackgroundTransparency = 1
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = frame

    local targetPos = UDim2.new(1, -300, 0.7, 0)
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = targetPos}):Play()

    task.delay(5, function()
        if frame then
            local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0.7, 0)})
            tweenOut:Play()
            tweenOut.Completed:Connect(function() gui:Destroy() end)
        end
    end)
end

ThongBao("Đã tải script Aris Hub thành công!\nDiscord: Aris_Vy\nFacebook: Trọng Vỹ'z")

if CoreGui:FindFirstChild("ArisMenuMobile") then CoreGui.ArisMenuMobile:Destroy() end
if CoreGui:FindFirstChild("ArisToggleGui") then CoreGui.ArisToggleGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArisMenuMobile"
screenGui.Parent = CoreGui
screenGui.Enabled = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.75, 0, 0.75, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 40)

local menuStroke = Instance.new("UIStroke")
menuStroke.Thickness = 4
menuStroke.Color = Color3.new(1, 1, 1)
menuStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
menuStroke.Parent = mainFrame

local menuGradient = Instance.new("UIGradient")
menuGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
menuGradient.Parent = menuStroke

local isEnglish = false

local texts = {
    vi = { title = "ĐỌC TÔI TRƯỚC KHI SỬ DỤNG", readMe = "READ ME", close = "X", destroy = "DESTROY", langBtn = "EN" },
    en = { title = "READ ME BEFORE USING", readMe = "READ ME", close = "X", destroy = "DESTROY", langBtn = "VI" }
}

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(0.9, 0, 0.08, 0)
menuTitle.Position = UDim2.new(0.05, 0, 0.04, 0)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = texts.vi.title
menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextScaled = true
menuTitle.Parent = mainFrame

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ArisToggleGui"
toggleGui.Parent = CoreGui

local pillButton = Instance.new("Frame")
pillButton.Size = UDim2.new(0, 120, 0, 45)
pillButton.Position = UDim2.new(0.1, 0, 0.1, 0)
pillButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
pillButton.Active = true
pillButton.Draggable = true
pillButton.Parent = toggleGui

Instance.new("UICorner", pillButton).CornerRadius = UDim.new(1, 0)

local pillStroke = Instance.new("UIStroke")
pillStroke.Thickness = 3
pillStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
pillStroke.Parent = pillButton

local pillGradient = Instance.new("UIGradient")
pillGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0))
})
pillGradient.Parent = pillStroke

local btnText = Instance.new("TextButton")
btnText.Size = UDim2.new(1,0,1,0)
btnText.BackgroundTransparency = 1
btnText.Text = texts.vi.readMe
btnText.TextColor3 = Color3.fromRGB(255,255,255)
btnText.Font = Enum.Font.GothamBold
btnText.TextSize = 16
btnText.Parent = pillButton

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.9, 0, 0.65, 0)
scrollFrame.Position = UDim2.new(0.05, 0, 0.22, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
scrollFrame.Parent = mainFrame

Instance.new("UICorner", scrollFrame).CornerRadius = UDim.new(0, 25)

local scrollStroke = Instance.new("UIStroke")
scrollStroke.Thickness = 3
scrollStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
scrollStroke.Parent = scrollFrame

local scrollGradient = Instance.new("UIGradient")
scrollGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
scrollGradient.Parent = scrollStroke

local content = Instance.new("TextLabel")
content.Size = UDim2.new(1, -30, 0, 900) 
content.Position = UDim2.new(0, 15, 0, 15)
content.BackgroundTransparency = 1
content.TextWrapped = true
content.TextXAlignment = Enum.TextXAlignment.Left
content.TextYAlignment = Enum.TextYAlignment.Top
content.Font = Enum.Font.GothamSemibold
content.TextSize = 19
content.TextColor3 = Color3.fromRGB(255, 255, 255)
content.RichText = true
content.Parent = scrollFrame

local smallPill = Instance.new("Frame")
smallPill.Size = UDim2.new(0, 90, 0, 35)
smallPill.Position = UDim2.new(0.96, 0, 0.92, 0)
smallPill.AnchorPoint = Vector2.new(1, 1)
smallPill.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
smallPill.Parent = mainFrame

Instance.new("UICorner", smallPill).CornerRadius = UDim.new(1, 0)

local smallStroke = Instance.new("UIStroke")
smallStroke.Thickness = 2.5
smallStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
smallStroke.Parent = smallPill

local smallGradient = Instance.new("UIGradient")
smallGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0))
})
smallGradient.Parent = smallStroke

local smallText = Instance.new("TextButton")
smallText.Size = UDim2.new(1,0,1,0)
smallText.BackgroundTransparency = 1
smallText.Text = texts.vi.destroy
smallText.TextColor3 = Color3.fromRGB(255,255,255)
smallText.Font = Enum.Font.GothamBold
smallText.TextSize = 13
smallText.Parent = smallPill

local langButton = Instance.new("Frame")
langButton.Size = UDim2.new(0, 60, 0, 40)
langButton.Position = UDim2.new(0.03, 0, 0.03, 0)
langButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
langButton.Parent = mainFrame
Instance.new("UICorner", langButton).CornerRadius = UDim.new(0, 20)

local langStroke = Instance.new("UIStroke")
langStroke.Thickness = 3
langStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
langStroke.Parent = langButton

local langGradient = Instance.new("UIGradient")
langGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255,0,0))
})
langGradient.Parent = langStroke

local langText = Instance.new("TextButton")
langText.Size = UDim2.new(1,0,1,0)
langText.BackgroundTransparency = 1
langText.Text = texts.vi.langBtn
langText.TextColor3 = Color3.fromRGB(255,255,255)
langText.Font = Enum.Font.GothamBold
langText.TextSize = 15
langText.Parent = langButton

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(0.97, 0, 0.03, 0)
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
closeBtn.Text = texts.vi.close
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

local function updateContent()
    local instruction = isEnglish and 
        "Nhấn nút VI để chuyển sang tiếng Việt\nPress DESTROY to hide readme\n\n" 
        or 
        "Press the EN button to switch to English\nẤn DESTROY để ẩn readme\n\n"

    local ghostWarning = isEnglish and
        "⚠️ [GHOST MODE INFO]\n" ..
        "» When enabling ||Ghost [👁️] ||, your hitbox will be kept on your real body (the body you are using for PvP). It can be countered by silent aimbot scripts.\n\n" ..
        "» When enabling ||Ghost [👻] ||, your hitbox will be kept on your fake body (the blue cube area when you enable desync). Everyone can attack that fake body without needing to attack your real body, and all your skills will be cast from the fake body's location (the blue cube area).\n\n"
        or
        "⚠️ [THÔNG TIN GHOST MODE]\n" ..
        "» Khi bật ||Ghost [👁️] ||, hitbox của bạn sẽ được giữ trên cơ thể thật (cơ thể bạn đang sử dụng để pvp), nó sẽ bị khắc chế bởi script silent aimbot.\n\n" ..
        "» Khi bật ||Ghost [👻] ||, hitbox của bạn sẽ giữ trên cơ thể giả (vùng khối vuông xanh dương khi bạn bật desync), mọi người có thể tấn công vào body đó mà không cần tấn công cơ thể bạn ở vị trí thật và mọi skill của bạn sử dụng sẽ tác động ở vị trí body fake (vùng khối vuông xanh dương khi bạn bật desync).\n\n"

    local warning = isEnglish and
        "⚠️ Some games have patched Desync, so you might get \"Disconnected\", but don't worry, it cannot \"BAN\" you.\n\n"
        or
        "⚠️ 1 số game đã vá Desync nên bạn có thể sẽ bị \"Disconnect\" nhưng đừng lo, nó không thể \"BAN\" bạn đâu.\n\n"

    local desyncTitle = isEnglish and 
        "# How does Desync work?"
        or "# Desync hoạt động như thế nào?"
        
    local desyncContent = isEnglish and 
        "» On your screen: You still move normally, run, jump, attack, and use skills freely. And your attacks still have real effects (hitting others, dealing damage...).\n\n" ..
        "» On others' screens: They only see your body standing still in one place, not moving, like you are AFK (away from keyboard)."
        or 
        "» Trên màn hình của bạn: Bạn vẫn di chuyển bình thường, chạy nhảy, đánh đấm, dùng chiêu thoải mái. Và đòn đánh của bạn vẫn có tác dụng thật (trúng người khác, gây sát thương…).\n\n" ..
        "» Trên màn hình của người khác: Họ chỉ thấy body (thân xác) của bạn đứng yên một chỗ, không nhúc nhích, giống như bạn đang AFK (ngồi không)."

    content.Text = instruction .. ghostWarning .. warning .. desyncTitle .. "\n\n" .. desyncContent
end

local function updateLanguage()
    local set = isEnglish and texts.en or texts.vi
    menuTitle.Text = set.title
    btnText.Text = set.readMe
    smallText.Text = set.destroy
    langText.Text = set.langBtn
    updateContent()
end

RunService.RenderStepped:Connect(function()
    local fastRot = (tick() * 180) % 360
    pillGradient.Rotation = fastRot
    menuGradient.Rotation = fastRot
    smallGradient.Rotation = fastRot
    langGradient.Rotation = fastRot
    scrollGradient.Rotation = fastRot
end)

btnText.MouseButton1Click:Connect(function()
    if not screenGui.Enabled then
        screenGui.Enabled = true
        pillButton.Visible = false
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.75, 0, 0.75, 0)}):Play()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tw:Play()
    tw.Completed:Connect(function() screenGui.Enabled = false pillButton.Visible = true end)
end)

smallText.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tw:Play()
    tw.Completed:Connect(function() screenGui:Destroy() toggleGui:Destroy() end)
end)

langText.MouseButton1Click:Connect(function()
    isEnglish = not isEnglish
    updateLanguage()
end)

updateLanguage()

local GENV = getgenv()
GENV.DesyncNormal = GENV.DesyncNormal or false
GENV.DesyncFast = GENV.DesyncFast or false
GENV.DesyncFix = GENV.DesyncFix or false
GENV.SelectedMode = GENV.SelectedMode or "Normal"
GENV.HideAuto = GENV.HideAuto or false
GENV.GuiVisible = GENV.GuiVisible or true

local desyncState = false

local replicatesignal = getgenv().replicatesignal or function(...) return ... end

local function ToggleDesync(state)
    pcall(function()
        if raknet and type(raknet.desync) == "function" then
             raknet.desync(state)
        end
    end)
end

local function AddBlueEffect(object)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 230, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 255))
    })
    gradient.Rotation = -45
    gradient.Parent = object

    task.spawn(function()
        while object and object.Parent do
            local tween = TweenService:Create(gradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 45 + 360})
            tween:Play()
            tween.Completed:Wait()
        end
    end)
end

local function AddStraightEffect(object)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 230, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 80, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 80, 255))
    })
    gradient.Rotation = 45 
    gradient.Offset = Vector2.new(-1, 0)
    gradient.Parent = object

    task.spawn(function()
        while object and object.Parent do
            gradient.Offset = Vector2.new(-1, 0)
            local tween = TweenService:Create(gradient, TweenInfo.new(2.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {Offset = Vector2.new(1, 0)})
            tween:Play()
            tween.Completed:Wait()
            task.wait(0.5)
        end
    end)
end

local NumericFlags = {
    {"GameNetPVHeaderRotationalVelocityZeroCutoffExponent","-5000"},
    {"TimestepArbiterVelocityCriteriaThresholdTwoDt","2147483646"},
    {"S2PhysicsSenderRate","15000"},
    {"MaxDataPacketPerSend","2147483647"},
    {"PhysicsSenderMaxBandwidthBps","20000"},
    {"CheckPVCachedVelThresholdPercent","10"},
    {"MaxMissedWorldStepsRemembered","-2147483648"},
    {"CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth","1"},
    {"StreamJobNOUVolumeLengthCap","2147483647"},
    {"DebugSendDistInSteps","-2147483648"},
    {"GameNetDontSendRedundantNumTimes","1"},
    {"CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent","1"},
    {"CheckPVCachedRotVelThresholdPercent","10"},
    {"ReplicationFocusNouExtentsSizeCutoffForPauseStuds","2147483647"},
    {"CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth","1"},
    {"GameNetDontSendRedundantDeltaPositionMillionth","1"},
    {"InterpolationFrameVelocityThresholdMillionth","5"},
    {"StreamJobNOUVolumeCap","2147483647"},
    {"InterpolationFrameRotVelocityThresholdMillionth","5"},
    {"WorldStepMax","30"},
    {"TimestepArbiterHumanoidLinearVelThreshold","1"},
    {"InterpolationFramePositionThresholdMillionth","5"},
    {"TimestepArbiterHumanoidTurningVelThreshold","1"},
    {"GameNetPVHeaderLinearVelocityZeroCutoffExponent","-5000"},
    {"SimOwnedNOUCountThresholdMillionth","2147483647"},
    {"TimestepArbiterOmegaThou","1073741823"},
    {"MaxAcceptableUpdateDelay","1"}
}

local AnimationLib = {}

function AnimationLib.CreateParticleEffect(position, color, duration)
	local part = Instance.new("Part")
	part.Size = Vector3.new(2, 2, 2)
	part.Anchored = true
	part.CanCollide = false
	part.Material = Enum.Material.Neon
	part.Color = color
	part.CFrame = CFrame.new(position)
	part.Transparency = 0.3
	part.Parent = workspace

	local light = Instance.new("PointLight")
	light.Color = color
	light.Range = 15
	light.Brightness = 2
	light.Parent = part

	local tween = TweenService:Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(0.5, 0.5, 0.5),
		Transparency = 1,
		CFrame = CFrame.new(position) * CFrame.new(math.random(-5, 5), math.random(5, 10), math.random(-5, 5))
	})
	tween:Play()
	tween.Completed:Connect(function()
		part:Destroy()
	end)
	return part
end

function AnimationLib.CreateBeam(startPos, endPos, color, duration)
	local attachment1 = Instance.new("Attachment")
	attachment1.Position = Vector3.new(0, 0, 0)
	local attachment2 = Instance.new("Attachment")
	attachment2.Position = endPos - startPos

	local beam = Instance.new("Beam")
	beam.Attachment0 = attachment1
	beam.Attachment1 = attachment2
	beam.Color = ColorSequence.new(color)
	beam.Width0 = 0.5
	beam.Width1 = 0.5
	beam.FaceCamera = true

	local part = Instance.new("Part")
	part.Size = Vector3.new(1, 1, 1)
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 1
	part.CFrame = CFrame.new(startPos)
	part.Parent = workspace

	attachment1.Parent = part
	attachment2.Parent = part
	beam.Parent = part

	task.delay(duration, function()
		beam:Destroy()
		attachment1:Destroy()
		attachment2:Destroy()
		part:Destroy()
	end)
	return beam
end

function AnimationLib.DesyncTeleportEffect(position)
	for i = 1, 8 do
		task.spawn(function()
			AnimationLib.CreateParticleEffect(
				position + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3)),
				Color3.fromRGB(0, 150, 255),
				0.8
			)
		end)
		task.wait(0.05)
	end
	
	local wave = Instance.new("Part")
	wave.Size = Vector3.new(1, 1, 1)
	wave.Anchored = true
	wave.CanCollide = false
	wave.Transparency = 0.7
	wave.Color = Color3.fromRGB(0, 100, 255)
	wave.Material = Enum.Material.Neon
	wave.CFrame = CFrame.new(position)
	wave.Parent = workspace

	local tween = TweenService:Create(wave, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = Vector3.new(20, 0.1, 20),
		Transparency = 1
	})
	tween:Play()
	tween.Completed:Connect(function()
		wave:Destroy()
	end)
end

local function FastRespawnUserLogic(plr, isHide)
    ToggleDesync(true)

    local char = plr.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local ogpos = hrp.CFrame
    local ogpos2 = workspace.CurrentCamera.CFrame
    
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    if hum then 
        hum.Health = 0 
    end

    task.spawn(function()
        local newChar = plr.CharacterAdded:Wait()
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 10)
        
        if not newHrp then return end
        
        if isHide then
            local vheight = math.random(5000, 9888)
            newHrp.CFrame = ogpos + Vector3.new(0, vheight, 0)
            workspace.CurrentCamera.CFrame = ogpos2
            task.wait(0.5) 
            newHrp.CFrame = ogpos
        else
            newHrp.CFrame = ogpos
            workspace.CurrentCamera.CFrame = ogpos2
        end
    end)
end

local function CustomRespawnFix(plr)
	local char = plr.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	AnimationLib.DesyncTeleportEffect(hrp.Position)

	local ogpos = hrp.CFrame
	local ogpos2 = workspace.CurrentCamera.CFrame

	local replicatesignal = getgenv().replicatesignal or function() end

    replicatesignal(plr.ConnectDiedSignalBackend)
    task.wait(Players.RespawnTime - 0.1)
    replicatesignal(plr.Kill)

	return plr.CharacterAdded:Wait(), ogpos, ogpos2
end

local function SetNormal(state)
	GENV.DesyncNormal = state
    if not state then ToggleDesync(false) end
end

local function SetFast(state)
	GENV.DesyncFast = state
    if not state then ToggleDesync(false) end
end

local function SetFixV2_Logic(state)
    GENV.DesyncFix = state
    ToggleDesync(state)
    
    if state then
        for _, flagData in ipairs(NumericFlags) do
            pcall(function() setfflag(flagData[1], flagData[2]) end)
        end
    end
end

local desyncPart
local lastSafeCF = nil
local lastTeleportCheck = nil

local function CreateDesyncMarker(pos)
	if desyncPart then desyncPart:Destroy() desyncPart = nil end

	desyncPart = Instance.new("Part")
	desyncPart.Name = "DesyncMarker"
	desyncPart.Anchored = true
	desyncPart.CanCollide = false
	desyncPart.Size = Vector3.new(4, 4, 4)
	desyncPart.Transparency = 0.5
	desyncPart.Color = Color3.fromRGB(0, 150, 255)
	desyncPart.Material = Enum.Material.Neon
	desyncPart.CFrame = pos
	desyncPart.Parent = workspace
	lastSafeCF = pos

	local bbGui = Instance.new("BillboardGui")
	bbGui.Size = UDim2.new(10, 0, 4, 0) 
	bbGui.AlwaysOnTop = true
	bbGui.Adornee = desyncPart
	bbGui.Parent = desyncPart

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.7
	frame.Parent = bbGui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

	local txt = Instance.new("TextLabel")
	txt.Size = UDim2.new(1, 0, 1, 0)
	txt.BackgroundTransparency = 1
	txt.Text = "ARIS DESYNC POINT"
	txt.TextColor3 = Color3.fromRGB(255, 255, 255)
	txt.TextScaled = true
	txt.Font = Enum.Font.GothamBold
	txt.TextStrokeTransparency = 0.8
	txt.Parent = frame

	task.spawn(function()
		while desyncPart and desyncPart.Parent do
			local t1 = TweenService:Create(desyncPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Vector3.new(4.5, 4.5, 4.5)})
			t1:Play() t1.Completed:Wait()
			if desyncPart then
				local t2 = TweenService:Create(desyncPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Vector3.new(4, 4, 4)})
				t2:Play() t2.Completed:Wait()
			end
		end
	end)

	AnimationLib.DesyncTeleportEffect(pos.Position)
	return desyncPart
end

local function UpdateDesyncMarker(pos)
	if not desyncPart then CreateDesyncMarker(pos) return end
	if lastTeleportCheck then
		local delta = (pos.Position - lastTeleportCheck.Position).Magnitude
        local isTeleport = delta > 1.5 
		if isTeleport then
			AnimationLib.DesyncTeleportEffect(desyncPart.Position)
			AnimationLib.CreateBeam(desyncPart.Position, pos.Position, Color3.fromRGB(0, 150, 255), 0.3)
			desyncPart.CFrame = pos 
			lastSafeCF = pos
		end
	end
	lastTeleportCheck = pos
end

local function ForceUpdateMarker(pos)
    if not desyncPart then CreateDesyncMarker(pos) return end
    AnimationLib.DesyncTeleportEffect(desyncPart.Position)
    desyncPart.CFrame = pos
    lastSafeCF = pos
    lastTeleportCheck = pos
end

local function HideDesyncMarker()
	if desyncPart then
		AnimationLib.DesyncTeleportEffect(desyncPart.Position)
		desyncPart:Destroy()
		desyncPart = nil
		lastSafeCF = nil
		lastTeleportCheck = nil
	end
end

player.CharacterAdded:Connect(function(char)
	local hrp = char:WaitForChild("HumanoidRootPart", 10)
	if not hrp then return end
    
    task.wait(0.1)
    
	if desyncState then
        if desyncPart then
		    AnimationLib.CreateBeam(desyncPart.Position, hrp.Position, Color3.fromRGB(0, 150, 255), 0.5)
        end
		ForceUpdateMarker(hrp.CFrame)
	end
end)

local function DoHideNormal()
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
    
	local originalCF = hrp.CFrame
	local originalCam = workspace.CurrentCamera.CFrame
    
    ToggleDesync(true)

	AnimationLib.DesyncTeleportEffect(hrp.Position)
    UpdateDesyncMarker(originalCF)
	
	local vheight = math.random(5000, 9888)
	hrp.CFrame = originalCF + Vector3.new(0, vheight, 0)
    workspace.CurrentCamera.CFrame = originalCam
	
	task.wait(0.5)
	GENV.DesyncNormal = true
	hrp.CFrame = originalCF
	workspace.CurrentCamera.CFrame = originalCam
    
	AnimationLib.CreateBeam(hrp.Position, originalCF.Position, Color3.fromRGB(0, 255, 150), 0.3)
	AnimationLib.DesyncTeleportEffect(originalCF.Position)
end

local function ActivateDesyncNormal()
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
    
	if GENV.HideAuto then 
        DoHideNormal() 
    else
        ToggleDesync(true)
		GENV.DesyncNormal = true
		UpdateDesyncMarker(hrp.CFrame)
		AnimationLib.DesyncTeleportEffect(hrp.Position)
	end
end

local function DoFastDesync()
	local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
    
    local savedCFrame = hrp.CFrame
    UpdateDesyncMarker(savedCFrame)
    FastRespawnUserLogic(player, GENV.HideAuto)
	SetFast(true)
    
    local newChar = player.Character
    if newChar then
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 5)
        if newHrp then
            UpdateDesyncMarker(savedCFrame)
        end
    end
end

local function DoFixDesync(isHide)
    local char = player.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	SetFixV2_Logic(true)
	UpdateDesyncMarker(hrp.CFrame)
	
	local newChar, originalCF, originalCam = CustomRespawnFix(player)
	local newHrp = newChar:WaitForChild("HumanoidRootPart")
	
	if isHide then
		local randomY = math.random(8000, 9000)
		newHrp.CFrame = CFrame.new(newHrp.Position.X, randomY, newHrp.Position.Z)
		workspace.CurrentCamera.CFrame = newHrp.CFrame
		task.wait(0.15)
	end
	
	SetFixV2_Logic(true)
	UpdateDesyncMarker(newHrp.CFrame)
end

if CoreGui:FindFirstChild("ArisHubGUI") then CoreGui.ArisHubGUI:Destroy() end
if CoreGui:FindFirstChild("ArisMinimizeButton") then CoreGui.ArisMinimizeButton:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "ArisHubGUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = CoreGui

local background = Instance.new("Frame")
background.Name = "MainFrame"
background.Size = UDim2.new(0, 200, 0, 180) 
background.Position = UDim2.new(0.02, 0, 0.3, 0)
background.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
background.BackgroundTransparency = 0.1
background.ClipsDescendants = true
background.Active = true
background.Draggable = true
background.Parent = gui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = background

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(0, 150, 255)
uiStroke.Thickness = 2
uiStroke.Transparency = 0.7
uiStroke.Parent = background

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 15)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
})
gradient.Rotation = 90
gradient.Parent = background

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 28)
header.BackgroundTransparency = 1
header.Parent = background

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "ARIS HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextStrokeTransparency = 0.8
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

AddStraightEffect(title)

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -20, 0, 12)
subtitle.Position = UDim2.new(0, 10, 0, 16)
subtitle.BackgroundTransparency = 1
subtitle.Text = "v1.0 (Special Edition)"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subtitle.TextSize = 8
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"
mainContainer.Size = UDim2.new(1, -20, 1, -42)
mainContainer.Position = UDim2.new(0, 10, 0, 37)
mainContainer.BackgroundTransparency = 1
mainContainer.Parent = background

local desyncBtn, desyncText, desyncIcon, desyncStroke, RefreshMain

local modeSection = Instance.new("Frame")
modeSection.Size = UDim2.new(1, 0, 0, 28)
modeSection.BackgroundTransparency = 1
modeSection.Parent = mainContainer

local modeLabel = Instance.new("TextLabel")
modeLabel.Size = UDim2.new(0.2, 0, 1, 0)
modeLabel.BackgroundTransparency = 1
modeLabel.Text = "MODE:"
modeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
modeLabel.TextSize = 10
modeLabel.Font = Enum.Font.GothamSemibold
modeLabel.TextXAlignment = Enum.TextXAlignment.Left
modeLabel.Parent = modeSection

local modeButtons = Instance.new("Frame")
modeButtons.Size = UDim2.new(0.8, 0, 1, 0)
modeButtons.Position = UDim2.new(0.2, 0, 0, 0)
modeButtons.BackgroundTransparency = 1
modeButtons.Parent = modeSection

local function createModeButton(text, position, size, parent)
	local button = Instance.new("TextButton")
	button.Size = size
	button.Position = position
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	button.Text = text
	button.TextColor3 = Color3.fromRGB(200, 200, 200)
	button.TextSize = 9
	button.Font = Enum.Font.GothamSemibold
	button.AutoButtonColor = false
	button.Parent = parent
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 5)
	local s = Instance.new("UIStroke") s.Color = Color3.fromRGB(60,60,70) s.Thickness = 1 s.Parent = button
	return button
end

local btnWidth = 0.32
local normalBtn = createModeButton("Normal", UDim2.new(0, 0, 0, 0), UDim2.new(btnWidth, -2, 1, 0), modeButtons)
local fastBtn = createModeButton("Fast", UDim2.new(btnWidth, 1, 0, 0), UDim2.new(btnWidth, -2, 1, 0), modeButtons)
local fixBtn = createModeButton("Fix", UDim2.new(btnWidth * 2, 2, 0, 0), UDim2.new(btnWidth, 0, 1, 0), modeButtons)

local function RefreshSelect()
	local buttons = {["Normal"]=normalBtn, ["Fast"]=fastBtn, ["Fix"]=fixBtn}
	for mode, btn in pairs(buttons) do
		local tC, tT
		if GENV.SelectedMode == mode then
			tC = (mode=="Fix" and Color3.fromRGB(255, 140, 0)) or (mode=="Fast" and Color3.fromRGB(0, 100, 200)) or Color3.fromRGB(0, 150, 0)
			tT = Color3.fromRGB(255, 255, 255)
		else
			tC = Color3.fromRGB(40, 40, 50)
			tT = Color3.fromRGB(200, 200, 200)
		end
		TweenService:Create(btn, TweenInfo.new(0.3), {BackgroundColor3=tC, TextColor3=tT}):Play()
	end
end
RefreshSelect()

local function AttemptChangeMode(newMode, btnObj)
    if desyncState then
        local originalColor = btnObj.TextColor3
        TweenService:Create(btnObj, TweenInfo.new(0.1), {TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        task.wait(0.2)
        TweenService:Create(btnObj, TweenInfo.new(0.3), {TextColor3 = originalColor}):Play()
        return
    end
    GENV.SelectedMode = newMode
    RefreshSelect()
    if RefreshMain then RefreshMain() end
end

normalBtn.MouseButton1Click:Connect(function() AttemptChangeMode("Normal", normalBtn) end)
fastBtn.MouseButton1Click:Connect(function() AttemptChangeMode("Fast", fastBtn) end)
fixBtn.MouseButton1Click:Connect(function() AttemptChangeMode("Fix", fixBtn) end)

local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0.48, 0, 0, 30)
hideBtn.Position = UDim2.new(0, 0, 0, 35)
hideBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
hideBtn.Text = ""
hideBtn.AutoButtonColor = false
hideBtn.Parent = mainContainer
Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 6)

local hideIcon = Instance.new("TextLabel")
hideIcon.Size = UDim2.new(0, 20, 1, 0)
hideIcon.BackgroundTransparency = 1
hideIcon.Text = "👻"
hideIcon.TextSize = 11
hideIcon.Parent = hideBtn

local hideLabel = Instance.new("TextLabel")
hideLabel.Size = UDim2.new(1, -20, 1, 0)
hideLabel.Position = UDim2.new(0, 18, 0, 0)
hideLabel.BackgroundTransparency = 1
hideLabel.Text = "GHOST"
hideLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
hideLabel.TextSize = 9
hideLabel.Font = Enum.Font.GothamSemibold
hideLabel.TextXAlignment = Enum.TextXAlignment.Left
hideLabel.Parent = hideBtn

local hideStatus = Instance.new("Frame")
hideStatus.Size = UDim2.new(0, 5, 0, 5)
hideStatus.Position = UDim2.new(1, -8, 0.5, -2.5)
hideStatus.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
hideStatus.Parent = hideBtn
Instance.new("UICorner", hideStatus).CornerRadius = UDim.new(1, 0)

local updateBtn = Instance.new("TextButton")
updateBtn.Size = UDim2.new(0.48, 0, 0, 30)
updateBtn.Position = UDim2.new(0.52, 0, 0, 35)
updateBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
updateBtn.Text = ""
updateBtn.AutoButtonColor = false
updateBtn.Parent = mainContainer
Instance.new("UICorner", updateBtn).CornerRadius = UDim.new(0, 6)

local updateIcon = Instance.new("TextLabel")
updateIcon.Size = UDim2.new(0, 20, 1, 0)
updateIcon.BackgroundTransparency = 1
updateIcon.Text = "🔄"
updateIcon.TextSize = 11
updateIcon.Parent = updateBtn

local updateLabel = Instance.new("TextLabel")
updateLabel.Size = UDim2.new(1, -20, 1, 0)
updateLabel.Position = UDim2.new(0, 18, 0, 0)
updateLabel.BackgroundTransparency = 1
updateLabel.Text = "UPDATE"
updateLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
updateLabel.TextSize = 9
updateLabel.Font = Enum.Font.GothamSemibold
updateLabel.TextXAlignment = Enum.TextXAlignment.Left
updateLabel.Parent = updateBtn

local isUpdating = false
updateBtn.MouseButton1Click:Connect(function()
    if not desyncState then
        StarterGui:SetCore("SendNotification", {
            Title = "ARIS HUB",
            Text = "Activate Desync button first!",
            Icon = "rbxassetid://137547539076614", 
            Duration = 3,
        })
        
        local originalColor = Color3.fromRGB(200, 200, 200)
        TweenService:Create(updateLabel, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        task.wait(3) 
        TweenService:Create(updateLabel, TweenInfo.new(0.5), {TextColor3 = originalColor}):Play()
        return
    end

    if isUpdating then return end
    isUpdating = true

    local originalText = "UPDATE"
    local originalIcon = "🔄"
    
    updateLabel.Text = "WAIT..."
    updateIcon.Text = "⏳"
    TweenService:Create(updateBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
    
    ToggleDesync(false)
    task.wait(1) 
    ToggleDesync(true)

    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        ForceUpdateMarker(char.HumanoidRootPart.CFrame)
    end

    task.wait(0.6)
    
    updateLabel.Text = originalText
    updateIcon.Text = originalIcon
    TweenService:Create(updateBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
    isUpdating = false
end)

local function RefreshHide()
	if GENV.HideAuto then
		TweenService:Create(hideStatus, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 100)}):Play()
		TweenService:Create(hideBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 60, 50)}):Play()
		hideIcon.Text = "👻"
	else
		TweenService:Create(hideStatus, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
		TweenService:Create(hideBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(40, 40, 50)}):Play()
		hideIcon.Text = "👁️"
	end
end
RefreshHide()

hideBtn.MouseButton1Click:Connect(function()
	GENV.HideAuto = not GENV.HideAuto
	RefreshHide()
	if RefreshMain then RefreshMain() end
end)

desyncBtn = Instance.new("TextButton")
desyncBtn.Size = UDim2.new(1, 0, 0, 40)
desyncBtn.Position = UDim2.new(0, 0, 0, 75)
desyncBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
desyncBtn.Text = ""
desyncBtn.AutoButtonColor = false
desyncBtn.Parent = mainContainer
Instance.new("UICorner", desyncBtn).CornerRadius = UDim.new(0, 8)
desyncStroke = Instance.new("UIStroke") desyncStroke.Parent = desyncBtn desyncStroke.Thickness = 2

desyncIcon = Instance.new("TextLabel")
desyncIcon.Size = UDim2.new(0, 22, 1, 0)
desyncIcon.BackgroundTransparency = 1
desyncIcon.Text = "⭕"
desyncIcon.TextSize = 14
desyncIcon.Parent = desyncBtn

desyncText = Instance.new("TextLabel")
desyncText.Size = UDim2.new(1, -25, 1, 0)
desyncText.Position = UDim2.new(0, 25, 0, 0)
desyncText.BackgroundTransparency = 1
desyncText.Text = "DESYNC: OFF"
desyncText.TextColor3 = Color3.fromRGB(255, 255, 255)
desyncText.TextSize = 12
desyncText.Font = Enum.Font.GothamBold
desyncText.TextXAlignment = Enum.TextXAlignment.Left
desyncText.Parent = desyncBtn

local creditsLabel = Instance.new("TextLabel")
creditsLabel.Name = "CreditsLabel"
creditsLabel.Size = UDim2.new(1, 0, 0, 20)
creditsLabel.Position = UDim2.new(0, 0, 0, 120)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "Developed by Aris"
creditsLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
creditsLabel.TextSize = 10
creditsLabel.Font = Enum.Font.GothamSemibold
creditsLabel.Parent = mainContainer

task.spawn(function()
    while creditsLabel and creditsLabel.Parent do
        local fadeOut = TweenService:Create(creditsLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Wait()
        task.wait(0.2)
        local fadeIn = TweenService:Create(creditsLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0})
        fadeIn:Play()
        fadeIn.Completed:Wait()
        task.wait(2)
    end
end)

RefreshMain = function()
    if GENV.SelectedMode == "Fix" and GENV.HideAuto then
        desyncText.Text = "UNAVAILABLE"
        desyncIcon.Text = "⚠️"
        TweenService:Create(desyncBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        TweenService:Create(desyncStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(100, 100, 100)}):Play()
        return
    end

	if desyncState then
		local dName = GENV.SelectedMode == "Fix" and "FIX V2" or GENV.SelectedMode:upper()
		desyncText.Text = "DESYNC: ON ("..dName..")"
		local c, sC
		if GENV.SelectedMode == "Fast" then c=Color3.fromRGB(0,150,255) sC=Color3.fromRGB(0,200,255)
		elseif GENV.SelectedMode == "Fix" then c=Color3.fromRGB(255,140,0) sC=Color3.fromRGB(255,180,50)
		else c=Color3.fromRGB(0,200,100) sC=Color3.fromRGB(0,255,150) end
		TweenService:Create(desyncBtn, TweenInfo.new(0.3), {BackgroundColor3 = c}):Play()
		TweenService:Create(desyncStroke, TweenInfo.new(0.3), {Color = sC}):Play()
		desyncIcon.Text = "✅"
	else
		desyncText.Text = "DESYNC: OFF"
		TweenService:Create(desyncBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
		TweenService:Create(desyncStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(255, 100, 100)}):Play()
		desyncIcon.Text = "⭕"
	end
end
RefreshMain()

desyncBtn.MouseButton1Click:Connect(function()
    if GENV.SelectedMode == "Fix" and GENV.HideAuto then return end
	desyncState = not desyncState
	RefreshMain()
	TweenService:Create(desyncBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.95,0,0,38)}):Play()
	task.wait(0.1)
	TweenService:Create(desyncBtn, TweenInfo.new(0.1), {Size = UDim2.new(1,0,0,40)}):Play()

	if desyncState then
		if GENV.SelectedMode == "Fix" then 
            DoFixDesync(GENV.HideAuto)
		elseif GENV.SelectedMode == "Fast" then 
            DoFastDesync()
		else 
            ActivateDesyncNormal() 
        end
	else
		SetFast(false) SetNormal(false) SetFixV2_Logic(false) HideDesyncMarker()
	end
end)

local minimizeGui = Instance.new("ScreenGui")
minimizeGui.Name = "ArisMinimizeButton"
minimizeGui.ResetOnSpawn = false
minimizeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
minimizeGui.DisplayOrder = 1000
minimizeGui.Parent = CoreGui

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeButton"
minimizeBtn.Size = UDim2.new(0, 50, 0, 50)
minimizeBtn.Position = UDim2.new(0.02, 0, 0.15, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
minimizeBtn.Text = ""
minimizeBtn.AutoButtonColor = false
minimizeBtn.Active = true
minimizeBtn.Draggable = true
minimizeBtn.Parent = minimizeGui

Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)

local glow = Instance.new("UIStroke") glow.Color=Color3.fromRGB(0,150,255) glow.Thickness=3 glow.Transparency=0.3 glow.Parent=minimizeBtn

local nText = Instance.new("TextLabel")
nText.Size = UDim2.new(1, 0, 1, 0)
nText.BackgroundTransparency = 1
nText.Text = "A"
nText.TextColor3 = Color3.fromRGB(255, 255, 255)
nText.TextSize = 28
nText.Font = Enum.Font.GothamBlack
nText.Parent = minimizeBtn

AddBlueEffect(nText)

local function ToggleGuiVisibility(isStartup)
	if not isStartup then GENV.GuiVisible = not GENV.GuiVisible end
	if GENV.GuiVisible then
		gui.Enabled = true
		local targetSize = UDim2.new(0, 200, 0, 180)
		local startSize = UDim2.new(0, 0, 0, 0)
		if isStartup then background.Size = startSize end
		background.Position = UDim2.new(minimizeBtn.Position.X.Scale, minimizeBtn.Position.X.Offset + 60, minimizeBtn.Position.Y.Scale, minimizeBtn.Position.Y.Offset)
		TweenService:Create(background, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = targetSize,
			Position = UDim2.new(minimizeBtn.Position.X.Scale, minimizeBtn.Position.X.Offset + 60, minimizeBtn.Position.Y.Scale, minimizeBtn.Position.Y.Offset)
		}):Play()
	else
		local closeTween = TweenService:Create(background, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			Size = UDim2.new(0, 0, 0, 0),
			Position = UDim2.new(minimizeBtn.Position.X.Scale, minimizeBtn.Position.X.Offset + 25, minimizeBtn.Position.Y.Scale, minimizeBtn.Position.Y.Offset + 25)
		})
		closeTween:Play()
		closeTween.Completed:Wait()
		gui.Enabled = false
	end
end

minimizeBtn.MouseButton1Down:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 42, 0, 42),
        BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    }):Play()
end)

minimizeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.3, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 50, 0, 50),
        BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    }):Play()
    ToggleGuiVisibility(false)
end)

minimizeBtn.MouseLeave:Connect(function()
     TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 50, 0, 50),
        BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    }):Play()
end)

if GENV.GuiVisible then
	background.Size = UDim2.new(0, 0, 0, 0)
	gui.Enabled = true
	task.delay(0.2, function() ToggleGuiVisibility(true) end)
else
	gui.Enabled = false
end