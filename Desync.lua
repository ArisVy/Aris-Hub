local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then return end

-- ==========================================
-- HỆ THỐNG THÔNG BÁO (NOTIFY)
-- ==========================================
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
    frame.Size = UDim2.new(0, 280, 0, 70)
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
    title.Position = UDim2.new(0, 70, 0.2, 0)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 16
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Text = noiDung
    desc.Size = UDim2.new(1, -80, 0, 30)
    desc.Position = UDim2.new(0, 70, 0.5, 0)
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

-- ==========================================
-- DỮ LIỆU ĐA NGÔN NGỮ
-- ==========================================
local isEnglish = false

local texts = {
    vi = { 
        title = "THÔNG BÁO TỪ ARIS", 
        close = "X", 
        destroy = "ĐÓNG VÀ HUỶ", 
        langBtn = "EN",
        copyBtn = "COPY LINK DISCORD",
        notifyCopy = "Đã copy link Discord vào máy!",
        notifyFail = "Executor của bạn không hỗ trợ copy!",
        content = "<b>Nếu có gì muốn hỏi cứ vào discord này.</b>\n\nTôi nghĩ mọi thứ nên dừng lại tại đây, cảm ơn mọi người ủng hộ script của tôi.\nVì 1 số vấn đề liên quan đến việc lộ source nên tôi sẽ tạm thời xoá bỏ nó.\nTuy khá buồn nhưng nó quá OP nên chỉ có thể làm vậy.\nDesync sẽ trở lại sau khi tôi thành công giấu source.\n\nVà tôi là <b>Aris_Vy 1 skidder</b>"
    },
    en = { 
        title = "NOTICE FROM ARIS", 
        close = "X", 
        destroy = "CLOSE & DESTROY", 
        langBtn = "VI",
        copyBtn = "COPY DISCORD LINK",
        notifyCopy = "Discord link copied to clipboard!",
        notifyFail = "Your executor doesn't support clipboard!",
        content = "<b>If you have any questions, just join this Discord.</b>\n\nI think everything should stop here, thank you everyone for supporting my script.\nDue to some issues related to the source code being leaked, I will temporarily remove it.\nIt's quite sad but it's too OP so I can only do this.\nDesync will return after I successfully hide the source.\n\nAnd I am <b>Aris_Vy a skidder</b>"
    }
}

ThongBao("Đã tải thư chia tay từ Aris_Vy!")

-- ==========================================
-- MENU READ ME (THÔNG BÁO TẠM DỪNG)
-- ==========================================

if CoreGui:FindFirstChild("ArisMenuMobile") then CoreGui.ArisMenuMobile:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ArisMenuMobile"
screenGui.Parent = CoreGui
screenGui.Enabled = true

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

local menuTitle = Instance.new("TextLabel")
menuTitle.Size = UDim2.new(0.9, 0, 0.08, 0)
menuTitle.Position = UDim2.new(0.05, 0, 0.04, 0)
menuTitle.BackgroundTransparency = 1
menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextScaled = true
menuTitle.Parent = mainFrame

-- NÚT ĐỔI NGÔN NGỮ
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
langText.TextColor3 = Color3.fromRGB(255,255,255)
langText.Font = Enum.Font.GothamBold
langText.TextSize = 15
langText.Parent = langButton

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.9, 0, 0.55, 0)
scrollFrame.Position = UDim2.new(0.05, 0, 0.18, 0)
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

-- NỘI DUNG CHÍNH
local content = Instance.new("TextLabel")
content.Size = UDim2.new(1, -30, 0, 500)
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

-- NÚT COPY LINK DISCORD
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.6, 0, 0.1, 0)
copyButton.Position = UDim2.new(0.2, 0, 0.78, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 18
copyButton.Parent = mainFrame

Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 15)

local copyStroke = Instance.new("UIStroke")
copyStroke.Thickness = 2
copyStroke.Color = Color3.fromRGB(0, 150, 255)
copyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
copyStroke.Parent = copyButton

copyButton.MouseButton1Click:Connect(function()
    local set = isEnglish and texts.en or texts.vi
    if setclipboard then
        setclipboard("https://discord.gg/phongroblox")
        ThongBao(set.notifyCopy)
    else
        ThongBao(set.notifyFail)
    end
end)

-- NÚT ĐÓNG VÀ HUỶ
local smallPill = Instance.new("Frame")
smallPill.Size = UDim2.new(0, 120, 0, 35)
smallPill.Position = UDim2.new(0.96, 0, 0.95, 0)
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
smallText.TextColor3 = Color3.fromRGB(255,255,255)
smallText.Font = Enum.Font.GothamBold
smallText.TextSize = 13
smallText.Parent = smallPill

smallText.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tw:Play()
    tw.Completed:Connect(function() screenGui:Destroy() end)
end)

-- NÚT ĐÓNG TẠM THỜI
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(0.97, 0, 0.03, 0)
closeBtn.AnchorPoint = Vector2.new(1, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tw:Play()
    tw.Completed:Connect(function() screenGui.Enabled = false end)
end)

-- CẬP NHẬT NGÔN NGỮ
local function updateLanguage()
    local set = isEnglish and texts.en or texts.vi
    menuTitle.Text = set.title
    closeBtn.Text = set.close
    smallText.Text = set.destroy
    langText.Text = set.langBtn
    copyButton.Text = set.copyBtn
    content.Text = set.content
end

langText.MouseButton1Click:Connect(function()
    isEnglish = not isEnglish
    updateLanguage()
end)

-- Khởi tạo ngôn ngữ mặc định (Tiếng Việt)
updateLanguage()

RunService.RenderStepped:Connect(function()
    local fastRot = (tick() * 180) % 360
    menuGradient.Rotation = fastRot
    langGradient.Rotation = fastRot
    smallGradient.Rotation = fastRot
    scrollGradient.Rotation = fastRot
end)
