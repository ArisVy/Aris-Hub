-- ==========================================================
-- ARIS UI LIBRARY V2 - COMPREHENSIVE FRAMEWORK
-- ==========================================================
local ArisUI = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local CoreGui = (gethui and gethui()) or Players.LocalPlayer:WaitForChild("PlayerGui")

local UIGradientList, TextGradientList, BtnGradientList = {}, {}, {}

local Themes = {
    Default = {
        On = { Color3.fromRGB(0, 240, 255), Color3.fromRGB(130, 100, 255), Color3.fromRGB(255, 150, 255), Color3.fromRGB(0, 240, 255) },
        Off = { Color3.fromRGB(12, 12, 12), Color3.fromRGB(180, 20, 20), Color3.fromRGB(12, 12, 12) },
        Text = { Color3.fromRGB(0, 150, 255), Color3.fromRGB(255, 0, 150), Color3.fromRGB(0, 150, 255) },
        Border = { Color3.fromRGB(255, 0, 0), Color3.fromRGB(15, 15, 15), Color3.fromRGB(255, 0, 0) }
    }
}
local CurrentTheme = Themes.Default

-- [[ UTILITIES ]]
local function GetMovingColorSequence(palette, shift)
    local keypoints = {}
    for step = 0, 5 do
        local i, t = step / 5, (step / 5 - shift) % 1
        if t < 0 then t = t + 1 end
        local index = math.floor(t * (#palette - 1)) + 1
        local fraction = (t * (#palette - 1)) - (index - 1)
        local color = (index >= #palette) and palette[#palette] or palette[index]:Lerp(palette[index + 1], fraction)
        table.insert(keypoints, ColorSequenceKeypoint.new(i, color))
    end
    return ColorSequence.new(keypoints)
end

local function MakeDraggable(f)
    local d = false; local i, s
    f.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then d = true; i = inp.Position; s = f.Position end end)
    f.InputChanged:Connect(function(inp) if (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) and d then f.Position = UDim2.new(s.X.Scale, s.X.Offset + (inp.Position - i).X, s.Y.Scale, s.Y.Offset + (inp.Position - i).Y) end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then d = false end end)
end

local function ApplyFX(obj, fxType)
    if fxType == "Border" then
        local stroke = Instance.new("UIStroke", obj) stroke.Thickness = 1.8 stroke.Color = Color3.new(1,1,1)
        local grad = Instance.new("UIGradient", stroke) grad.Rotation = 90 table.insert(UIGradientList, grad)
    elseif fxType == "Text" then
        obj.BackgroundTransparency = 1 obj.TextColor3 = Color3.new(1,1,1) obj.TextStrokeTransparency = 1
        local str = Instance.new("UIStroke", obj) str.Thickness = 0.5 str.Color = Color3.new(0,0,0)
        local grad = Instance.new("UIGradient", obj) grad.Rotation = 90 table.insert(TextGradientList, grad)
    elseif fxType == "Toggle" then
        local grad = Instance.new("UIGradient", obj) grad.Name = "ToggleGrad" grad.Rotation = 90 table.insert(BtnGradientList, grad)
    end
end

-- [[ CORE WINDOW ]]
function ArisUI:CreateWindow(Config)
    local TitleText = Config.Title or "ARIS HUB V2"
    local SaveFileName = Config.SaveName or "ArisConfig.json"
    
    local WindowData = { Tabs = {}, ContentFrames = {}, Flags = {} }
    
    if CoreGui:FindFirstChild("ArisHUB_PRO") then CoreGui.ArisHUB_PRO:Destroy() end
    local ScreenGui = Instance.new("ScreenGui", CoreGui) ScreenGui.Name = "ArisHUB_PRO" ScreenGui.ResetOnSpawn = false

    -- LOADING SCREEN
    local LoadFrame = Instance.new("Frame", ScreenGui)
    LoadFrame.Size = UDim2.new(0, 300, 0, 100) LoadFrame.Position = UDim2.new(0.5, -150, 0.5, -50) LoadFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 10) ApplyFX(LoadFrame, "Border")
    local LoadTxt = Instance.new("TextLabel", LoadFrame) LoadTxt.Size = UDim2.new(1,0,1,-20) LoadTxt.Text = "Đang tải " .. TitleText .. "..." LoadTxt.Font = Enum.Font.GothamBold LoadTxt.TextSize = 16 ApplyFX(LoadTxt, "Text")
    local LoadBarBg = Instance.new("Frame", LoadFrame) LoadBarBg.Size = UDim2.new(0.9, 0, 0, 10) LoadBarBg.Position = UDim2.new(0.05, 0, 0.7, 0) LoadBarBg.BackgroundColor3 = Color3.fromRGB(10,10,10)
    local LoadBar = Instance.new("Frame", LoadBarBg) LoadBar.Size = UDim2.new(0, 0, 1, 0) LoadBar.BackgroundColor3 = Color3.new(1,1,1) ApplyFX(LoadBar, "Toggle") LoadBar:SetAttribute("IsOn", true)
    
    TweenService:Create(LoadBar, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(1.5)
    LoadFrame:Destroy()

    -- MAIN MENU
    local ToggleBtn = Instance.new("ImageButton", ScreenGui) 
    ToggleBtn.Size = UDim2.new(0,50,0,50) ToggleBtn.Position = UDim2.new(0,10,0.5,-25)
    ToggleBtn.Image = "rbxassetid://125329301331069" ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30) ToggleBtn.ClipsDescendants = true
    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0,20) ApplyFX(ToggleBtn, "Border") MakeDraggable(ToggleBtn)

    local MainFrame = Instance.new("Frame", ScreenGui) 
    MainFrame.Size = UDim2.new(0,450,0,350) MainFrame.Position = UDim2.new(0.5,-225,0.5,-175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,18) MainFrame.Visible = false
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,12) ApplyFX(MainFrame, "Border") MakeDraggable(MainFrame)

    -- CHỈ DÙNG ICON ĐÓNG MỞ NHƯ YÊU CẦU (Không dùng InputBegan phím tắt)
    local isMenuOpen = false
    ToggleBtn.MouseButton1Click:Connect(function() 
        isMenuOpen = not isMenuOpen 
        MainFrame.Visible = isMenuOpen 
        -- Animation mở mượt mà
        if isMenuOpen then
            MainFrame.Size = UDim2.new(0, 400, 0, 300)
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 450, 0, 350)}):Play()
        end
    end)

    local Title = Instance.new("TextLabel", MainFrame) 
    Title.Size = UDim2.new(1,0,0,45) Title.Text = TitleText Title.Font = Enum.Font.GothamBlack Title.TextSize = 18 Title.TextXAlignment = Enum.TextXAlignment.Center ApplyFX(Title, "Text")

    local TabFrame = Instance.new("ScrollingFrame", MainFrame) 
    TabFrame.Size = UDim2.new(1,-20,0,35) TabFrame.Position = UDim2.new(0,10,0,45) TabFrame.BackgroundTransparency = 1 TabFrame.ScrollBarThickness = 0
    local tabListLayout = Instance.new("UIListLayout", TabFrame) tabListLayout.FillDirection = Enum.FillDirection.Horizontal tabListLayout.Padding = UDim.new(0, 5)
    tabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() TabFrame.CanvasSize = UDim2.new(0, tabListLayout.AbsoluteContentSize.X, 0, 0) end)

    -- RGB LOOP
    RunService.RenderStepped:Connect(function()
        local shift = tick() * 0.15
        local seqOn, seqOff, seqText, seqBorder = GetMovingColorSequence(CurrentTheme.On, shift), GetMovingColorSequence(CurrentTheme.Off, shift), GetMovingColorSequence(CurrentTheme.Text, shift * 1.5), GetMovingColorSequence(CurrentTheme.Border, shift * 1.8)
        for i = #UIGradientList, 1, -1 do local g = UIGradientList[i]; if g.Parent then g.Color = seqBorder else table.remove(UIGradientList, i) end end
        for i = #TextGradientList, 1, -1 do local g = TextGradientList[i]; if g.Parent then if not g:GetAttribute("CustomOnColor") then g.Color = seqText end else table.remove(TextGradientList, i) end end
        for i = #BtnGradientList, 1, -1 do local g = BtnGradientList[i]; if g.Parent then g.Color = g.Parent:GetAttribute("IsOn") and seqOn or seqOff else table.remove(BtnGradientList, i) end end
    end)

    -- [[ HỆ THỐNG CONFIG & SYSTEM ]]
    function WindowData:SaveConfig()
        if writefile then
            writefile(SaveFileName, HttpService:JSONEncode(self.Flags))
        end
    end

    function WindowData:Destroy()
        ScreenGui:Destroy()
    end

    -- TẠO TAB
    function WindowData:CreateTab(TabName, IconId)
        local TabItem = {}
        local btn = Instance.new("TextButton", TabFrame) btn.Size = UDim2.new(0, 100, 1, -5) btn.Text = TabName btn.Font = Enum.Font.GothamBold btn.TextSize = 12 btn.BackgroundColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6) ApplyFX(btn, "Toggle") ApplyFX(btn, "Border")
        
        local content = Instance.new("ScrollingFrame", MainFrame) content.Size = UDim2.new(1,-20,1,-95) content.Position = UDim2.new(0,10,0,85) content.BackgroundTransparency = 1 content.ScrollBarThickness = 3 content.Visible = false
        local list = Instance.new("UIListLayout", content) list.Padding = UDim.new(0,6) list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10) end)

        table.insert(self.Tabs, btn) table.insert(self.ContentFrames, content)

        btn.MouseButton1Click:Connect(function()
            for _, f in pairs(self.ContentFrames) do f.Visible = false end
            for _, b in pairs(self.Tabs) do b:SetAttribute("IsOn", false) b.TextColor3 = Color3.fromRGB(150,150,150) end
            content.Visible = true btn:SetAttribute("IsOn", true) btn.TextColor3 = Color3.new(1,1,1)
        end)
        if #self.Tabs == 1 then content.Visible = true btn:SetAttribute("IsOn", true) btn.TextColor3 = Color3.new(1,1,1) else btn.TextColor3 = Color3.fromRGB(150,150,150) end

        -- [[ TẠO ELEMENT CƠ BẢN ]]
        local function CreateBase(height)
            local f = Instance.new("Frame", content) f.Size = UDim2.new(1, 0, 0, height) f.BackgroundTransparency = 1
            return f
        end

        function TabItem:CreateParagraph(title, desc)
            local f = CreateBase(45)
            local t = Instance.new("TextLabel", f) t.Size = UDim2.new(1,0,0,20) t.Text = title t.Font = Enum.Font.GothamBold t.TextSize = 14 t.TextXAlignment = Enum.TextXAlignment.Left ApplyFX(t, "Text")
            local d = Instance.new("TextLabel", f) d.Size = UDim2.new(1,0,0,25) d.Position = UDim2.new(0,0,0,20) d.Text = desc d.Font = Enum.Font.Gotham d.TextSize = 11 d.TextColor3 = Color3.fromRGB(180,180,180) d.TextXAlignment = Enum.TextXAlignment.Left d.TextWrapped = true d.BackgroundTransparency = 1
        end

        function TabItem:CreateDivider()
            local f = CreateBase(10)
            local l = Instance.new("Frame", f) l.Size = UDim2.new(1,0,0,2) l.Position = UDim2.new(0,0,0.5,0) l.BackgroundColor3 = Color3.new(1,1,1) l.BorderSizePixel = 0
            local g = Instance.new("UIGradient", l) table.insert(UIGradientList, g)
        end

        -- TRUE SLIDER
        function TabItem:CreateSlider(name, flag, minV, maxV, default, desc, callback)
            local val = default or minV WindowData.Flags[flag] = val
            local f = CreateBase(desc and 55 or 45)
            local lbl = Instance.new("TextLabel", f) lbl.Size = UDim2.new(1,0,0,20) lbl.Text = name .. ": " .. val lbl.Font = Enum.Font.GothamBold lbl.TextSize = 13 lbl.TextXAlignment = Enum.TextXAlignment.Left ApplyFX(lbl, "Text")
            
            if desc then local dLbl = Instance.new("TextLabel", f) dLbl.Size = UDim2.new(1,0,0,12) dLbl.Position = UDim2.new(0,0,0,18) dLbl.Text = desc dLbl.Font = Enum.Font.Gotham dLbl.TextSize = 10 dLbl.TextColor3 = Color3.fromRGB(150,150,150) dLbl.TextXAlignment = Enum.TextXAlignment.Left dLbl.BackgroundTransparency = 1 end
            
            local bg = Instance.new("Frame", f) bg.Size = UDim2.new(1,0,0,12) bg.Position = UDim2.new(0,0,1,-15) bg.BackgroundColor3 = Color3.fromRGB(30,30,30) Instance.new("UICorner", bg).CornerRadius = UDim.new(0,6) ApplyFX(bg, "Border")
            local fill = Instance.new("Frame", bg) fill.Size = UDim2.new((val-minV)/(maxV-minV),0,1,0) fill.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", fill).CornerRadius = UDim.new(0,6) ApplyFX(fill, "Toggle") fill:SetAttribute("IsOn", true)
            
            local function update(inp)
                local pct = math.clamp((inp.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
                val = math.floor(minV + (maxV - minV) * pct)
                lbl.Text = name .. ": " .. val WindowData.Flags[flag] = val
                TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(pct,0,1,0)}):Play()
                if callback then callback(val) end
            end
            
            local drag = false
            bg.InputBegan:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drag = true update(inp) end end)
            bg.InputEnded:Connect(function(inp) if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then drag = false WindowData:SaveConfig() end end)
            UserInputService.InputChanged:Connect(function(inp) if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then update(inp) end end)

            return { Set = function(v) val = math.clamp(v, minV, maxV); lbl.Text = name..": "..val; fill.Size = UDim2.new((val-minV)/(maxV-minV),0,1,0); WindowData.Flags[flag] = val; if callback then callback(val) end end }
        end

        -- MULTI DROPDOWN
        function TabItem:CreateMultiDropdown(name, flag, options, defaultOpts, callback)
            local selected = {} for _, v in ipairs(defaultOpts or {}) do selected[v] = true end
            WindowData.Flags[flag] = selected

            local f = CreateBase(35) f.ClipsDescendants = true
            local mainBtn = Instance.new("TextButton", f) mainBtn.Size = UDim2.new(1,0,0,35) mainBtn.BackgroundColor3 = Color3.fromRGB(20,20,20) Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0,6) ApplyFX(mainBtn, "Border")
            local lbl = Instance.new("TextLabel", mainBtn) lbl.Size = UDim2.new(1,-30,1,0) lbl.Position = UDim2.new(0,10,0,0) lbl.Text = name .. " (Chọn nhiều)" lbl.Font = Enum.Font.GothamBold lbl.TextSize = 12 lbl.TextXAlignment = Enum.TextXAlignment.Left ApplyFX(lbl, "Text")
            local icon = Instance.new("TextLabel", mainBtn) icon.Size = UDim2.new(0,30,1,0) icon.Position = UDim2.new(1,-30,0,0) icon.Text = "+" icon.Font = Enum.Font.GothamBold icon.TextSize = 16 icon.BackgroundTransparency = 1 icon.TextColor3 = Color3.new(1,1,1)
            
            local dropList = Instance.new("ScrollingFrame", f) dropList.Size = UDim2.new(1,0,0,120) dropList.Position = UDim2.new(0,0,0,40) dropList.BackgroundTransparency = 1 dropList.ScrollBarThickness = 2 dropList.CanvasSize = UDim2.new(0,0,0,#options * 30) dropList.BorderSizePixel = 0
            local l = Instance.new("UIListLayout", dropList)

            local function updateText()
                local str = "" for k, v in pairs(selected) do if v then str = str .. k .. ", " end end
                lbl.Text = str == "" and name or string.sub(str, 1, -3)
                WindowData.Flags[flag] = selected WindowData:SaveConfig()
                if callback then callback(selected) end
            end

            for _, opt in ipairs(options) do
                local optBtn = Instance.new("TextButton", dropList) optBtn.Size = UDim2.new(1,0,0,30) optBtn.Text = "  " .. opt optBtn.Font = Enum.Font.Gotham optBtn.TextSize = 12 optBtn.TextXAlignment = Enum.TextXAlignment.Left optBtn.BackgroundTransparency = 1 optBtn.TextColor3 = selected[opt] and Color3.new(0,1,0) or Color3.fromRGB(200,200,200)
                optBtn.MouseButton1Click:Connect(function() selected[opt] = not selected[opt]; optBtn.TextColor3 = selected[opt] and Color3.new(0,1,0) or Color3.fromRGB(200,200,200); updateText() end)
            end
            updateText()

            local open = false
            mainBtn.MouseButton1Click:Connect(function() open = not open; TweenService:Create(f, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,open and 165 or 35)}):Play(); icon.Text = open and "-" or "+" end)
        end

        -- PROGRESS BAR
        function TabItem:CreateProgress(name, maxVal, currentVal)
            local f = CreateBase(40)
            local lbl = Instance.new("TextLabel", f) lbl.Size = UDim2.new(1,0,0,20) lbl.Text = name .. ": " .. currentVal .. "/" .. maxVal lbl.Font = Enum.Font.GothamBold lbl.TextSize = 12 lbl.TextXAlignment = Enum.TextXAlignment.Left ApplyFX(lbl, "Text")
            local bg = Instance.new("Frame", f) bg.Size = UDim2.new(1,0,0,15) bg.Position = UDim2.new(0,0,0,25) bg.BackgroundColor3 = Color3.fromRGB(30,30,30) Instance.new("UICorner", bg).CornerRadius = UDim.new(0,6) ApplyFX(bg, "Border")
            local fill = Instance.new("Frame", bg) fill.Size = UDim2.new(currentVal/maxVal,0,1,0) fill.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", fill).CornerRadius = UDim.new(0,6) ApplyFX(fill, "Toggle") fill:SetAttribute("IsOn", true)
            return { Set = function(val) lbl.Text = name..": "..val.."/"..maxVal; TweenService:Create(fill, TweenInfo.new(0.2), {Size = UDim2.new(val/maxVal,0,1,0)}):Play() end }
        end

        -- TOGGLE (CẬP NHẬT FLAG & DESC)
        function TabItem:CreateToggle(name, flag, default, desc, callback)
            local state = default or false WindowData.Flags[flag] = state
            local f = CreateBase(desc and 50 or 35)
            local btn = Instance.new("TextButton", f) btn.Size = UDim2.new(1,0,1,0) btn.BackgroundColor3 = Color3.fromRGB(20,20,20) Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6) ApplyFX(btn, "Toggle") ApplyFX(btn, "Border") btn:SetAttribute("IsOn", state)
            local lbl = Instance.new("TextLabel", btn) lbl.Size = UDim2.new(1,-10,0,20) lbl.Position = UDim2.new(0,10,0,8) lbl.Text = name .. ": " .. (state and "ON" or "OFF") lbl.Font = Enum.Font.GothamBold lbl.TextSize = 13 lbl.TextXAlignment = Enum.TextXAlignment.Left ApplyFX(lbl, "Text")
            if desc then local dLbl = Instance.new("TextLabel", btn) dLbl.Size = UDim2.new(1,-10,0,12) dLbl.Position = UDim2.new(0,10,0,28) dLbl.Text = desc dLbl.Font = Enum.Font.Gotham dLbl.TextSize = 10 dLbl.TextColor3 = Color3.fromRGB(150,150,150) dLbl.TextXAlignment = Enum.TextXAlignment.Left dLbl.BackgroundTransparency = 1 end
            
            btn.MouseButton1Click:Connect(function() state = not state btn:SetAttribute("IsOn", state) lbl.Text = name .. ": " .. (state and "ON" or "OFF") WindowData.Flags[flag] = state WindowData:SaveConfig() if callback then callback(state) end end)
            return { Set = function(s) state = s; btn:SetAttribute("IsOn", state); lbl.Text = name..": "..(state and "ON" or "OFF"); WindowData.Flags[flag]=state; if callback then callback(state) end end }
        end

        -- COLOR PICKER (RGB SLIDERS ĐƠN GIẢN ĐỂ TỐI ƯU DUNG LƯỢNG)
        function TabItem:CreateColorPicker(name, flag, defaultColor, callback)
            local c = defaultColor or Color3.new(1,1,1) WindowData.Flags[flag] = {c.R, c.G, c.B}
            local f = CreateBase(35) f.ClipsDescendants = true
            local mainBtn = Instance.new("TextButton", f) mainBtn.Size = UDim2.new(1,0,0,35) mainBtn.BackgroundColor3 = Color3.fromRGB(20,20,20) Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0,6) ApplyFX(mainBtn, "Border")
            local lbl = Instance.new("TextLabel", mainBtn) lbl.Size = UDim2.new(1,-40,1,0) lbl.Position = UDim2.new(0,10,0,0) lbl.Text = name lbl.Font = Enum.Font.GothamBold lbl.TextSize = 13 lbl.TextXAlignment = Enum.TextXAlignment.Left ApplyFX(lbl, "Text")
            local colorShow = Instance.new("Frame", mainBtn) colorShow.Size = UDim2.new(0,25,0,25) colorShow.Position = UDim2.new(1,-30,0.5,-12.5) colorShow.BackgroundColor3 = c Instance.new("UICorner", colorShow).CornerRadius = UDim.new(0,4)
            
            local drop = Instance.new("Frame", f) drop.Size = UDim2.new(1,0,0,90) drop.Position = UDim2.new(0,0,0,40) drop.BackgroundTransparency = 1
            local function makeMiniSlider(y, colorType, initVal)
                local bg = Instance.new("Frame", drop) bg.Size = UDim2.new(1,-10,0,15) bg.Position = UDim2.new(0,5,0,y) bg.BackgroundColor3 = Color3.fromRGB(30,30,30)
                local fill = Instance.new("Frame", bg) fill.Size = UDim2.new(initVal,0,1,0) fill.BackgroundColor3 = colorType == "R" and Color3.new(1,0,0) or (colorType == "G" and Color3.new(0,1,0) or Color3.new(0,0,1))
                local drag = false
                bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true end end)
                bg.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
                UserInputService.InputChanged:Connect(function(i) 
                    if drag and i.UserInputType == Enum.UserInputType.MouseMovement then 
                        local pct = math.clamp((i.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1) fill.Size = UDim2.new(pct,0,1,0)
                        if colorType == "R" then c = Color3.new(pct, c.G, c.B) elseif colorType == "G" then c = Color3.new(c.R, pct, c.B) else c = Color3.new(c.R, c.G, pct) end
                        colorShow.BackgroundColor3 = c WindowData.Flags[flag] = {c.R, c.G, c.B} if callback then callback(c) end
                    end 
                end)
            end
            makeMiniSlider(5, "R", c.R) makeMiniSlider(35, "G", c.G) makeMiniSlider(65, "B", c.B)

            local open = false
            mainBtn.MouseButton1Click:Connect(function() open = not open; TweenService:Create(f, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0,open and 135 or 35)}):Play() end)
        end

        return TabItem
    end

    return WindowData
end

return ArisUI
