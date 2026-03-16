local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Workspace=game:GetService("Workspace")
local UserInputService=game:GetService("UserInputService")
local Lighting=game:GetService("Lighting")
local LocalPlayer=Players.LocalPlayer
local Camera=workspace.CurrentCamera
local CoreGui=game:GetService("CoreGui")

game:GetService("StarterGui"):SetCore("SendNotification",{Title="ARIS HUB V53 PRO",Text="Đã Fix Lỗi ESP & Tối Ưu NPC!",Duration=6})

_G.Config={
    -- ESP
    ESP_Box_P=true, ESP_Name_P=true, ESP_Health_P=true, ESP_Chams_P=true, ESP_Distance_P=true,
    -- Hitbox
    Hitbox_P=false, HitboxSize=150, Hitbox_WallCheck=false, Hitbox_Box=false,
    -- Misc
    TeamCheck=true, LowHP_KS=false,
    -- NPC
    Hitbox_NPC=false, HitboxSize_NPC=20, Hitbox_Box_NPC=false, ESP_NPC_Name=false, ESP_NPC_Chams=false, TeamCheck_NPC=false,
    MenuOpen=false
}

if CoreGui:FindFirstChild("ArisHUB_PRO")then CoreGui.ArisHUB_PRO:Destroy()end

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="ArisHUB_PRO"
ScreenGui.ResetOnSpawn=false
ScreenGui.IgnoreGuiInset=true
ScreenGui.DisplayOrder=99999
ScreenGui.Parent=CoreGui

local RainbowList={}
local function GetRGB()return Color3.fromHSV(tick()%5/5,1,1)end

local function MakeDraggable(f)
    local d=false;local i,s
    f.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 then d=true;i=inp.Position;s=f.Position end
    end)
    f.InputChanged:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseMovement and d then
            local delta=inp.Position-i
            f.Position=UDim2.new(s.X.Scale,s.X.Offset+delta.X,s.Y.Scale,s.Y.Offset+delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 then d=false end
    end)
end

local ToggleBtn=Instance.new("TextButton",ScreenGui)
ToggleBtn.Size=UDim2.new(0,50,0,50)
ToggleBtn.Position=UDim2.new(0,10,0.5,-25)
ToggleBtn.Text="UI"
ToggleBtn.Font=Enum.Font.GothamBold
ToggleBtn.TextSize=20
ToggleBtn.BackgroundColor3=Color3.fromRGB(30,30,30)
Instance.new("UICorner",ToggleBtn).CornerRadius=UDim.new(0,12)
local ts=Instance.new("UIStroke",ToggleBtn)
ts.Thickness=3
table.insert(RainbowList,ts)
MakeDraggable(ToggleBtn)

local MainFrame=Instance.new("Frame",ScreenGui)
MainFrame.Size=UDim2.new(0,420,0,420)
MainFrame.Position=UDim2.new(0,70,0.2,0)
MainFrame.BackgroundColor3=Color3.fromRGB(20,20,20)
MainFrame.Visible=false
Instance.new("UICorner",MainFrame).CornerRadius=UDim.new(0,12)
local ms=Instance.new("UIStroke",MainFrame)
ms.Thickness=3
table.insert(RainbowList,ms)

local ResetBtn=Instance.new("TextButton",MainFrame)
ResetBtn.Size=UDim2.new(0,36,0,36)
ResetBtn.Position=UDim2.new(0,10,0,7)
ResetBtn.Text="RST"
ResetBtn.Font=Enum.Font.GothamBold
ResetBtn.TextSize=12
ResetBtn.BackgroundColor3=Color3.fromRGB(40,20,20)
Instance.new("UICorner",ResetBtn).CornerRadius=UDim.new(0,8)
local rsStroke=Instance.new("UIStroke",ResetBtn)
rsStroke.Thickness=2
table.insert(RainbowList,rsStroke)

local lastClickTime = 0
ResetBtn.MouseButton1Click:Connect(function()
    if tick() - lastClickTime < 0.5 then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.Health = 0 end
    end
    lastClickTime = tick()
end)

local Title=Instance.new("TextLabel",MainFrame)
Title.Size=UDim2.new(1,-60,0,50)
Title.Position=UDim2.new(0,55,0,0)
Title.Text="ARIS HUB V53 PRO"
Title.Font=Enum.Font.GothamBlack
Title.TextSize=22
Title.BackgroundTransparency=1
Title.TextXAlignment=Enum.TextXAlignment.Left
table.insert(RainbowList,Title)
MakeDraggable(MainFrame) 

ToggleBtn.MouseButton1Click:Connect(function()
    _G.Config.MenuOpen=not _G.Config.MenuOpen
    MainFrame.Visible=_G.Config.MenuOpen
end)

local TabFrame=Instance.new("Frame",MainFrame)
TabFrame.Size=UDim2.new(1,0,0,40)
TabFrame.Position=UDim2.new(0,0,0,50)
TabFrame.BackgroundTransparency=1

local Tabs={"ESP","Hitbox","Misc","NPC"}
local ContentFrames={}

for i,tab in ipairs(Tabs)do
    local btn=Instance.new("TextButton",TabFrame)
    btn.Size=UDim2.new(1/#Tabs,0,1,0)
    btn.Position=UDim2.new((i-1)*(1/#Tabs),0,0,0)
    btn.Text=tab
    btn.Font=Enum.Font.GothamBold
    btn.TextSize=15
    btn.BackgroundColor3=Color3.fromRGB(40,40,40)
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
    table.insert(RainbowList,btn)

    local content=Instance.new("ScrollingFrame",MainFrame)
    content.Size=UDim2.new(1,-20,1,-100)
    content.Position=UDim2.new(0,10,0,95)
    content.BackgroundTransparency=1
    content.ScrollBarThickness=6
    content.Visible=false

    local list=Instance.new("UIListLayout",content)
    list.Padding=UDim.new(0,8)
    list.SortOrder=Enum.SortOrder.LayoutOrder

    local pad=Instance.new("UIPadding",content)
    pad.PaddingLeft=UDim.new(0,5)
    pad.PaddingRight=UDim.new(0,5)
    pad.PaddingTop=UDim.new(0,5)

    ContentFrames[tab]={Frame=content}

    btn.MouseButton1Click:Connect(function()
        for _,f in pairs(ContentFrames)do f.Frame.Visible=false end
        content.Visible=true
    end)
end

ContentFrames["ESP"].Frame.Visible=true

local function AddToggle(tab,name,key,cb)
    local content=ContentFrames[tab].Frame
    local btn=Instance.new("TextButton",content)
    btn.Size=UDim2.new(1,0,0,38)
    btn.Text=name..": "..(_G.Config[key]and"ON"or"OFF")
    btn.BackgroundColor3=_G.Config[key]and Color3.fromRGB(40,100,40)or Color3.fromRGB(100,40,40)
    btn.Font=Enum.Font.GothamBold
    btn.TextSize=14
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,8)
    table.insert(RainbowList,btn)
    btn.MouseButton1Click:Connect(function()
        _G.Config[key]=not _G.Config[key]
        btn.Text=name..": "..(_G.Config[key]and"ON"or"OFF")
        btn.BackgroundColor3=_G.Config[key]and Color3.fromRGB(40,100,40)or Color3.fromRGB(100,40,40)
        if cb then cb(_G.Config[key])end
    end)
end

local function AddAdjust(tab,name,key,step)
    local content=ContentFrames[tab].Frame
    local frame=Instance.new("Frame",content)
    frame.Size=UDim2.new(1,0,0,38)
    frame.BackgroundTransparency=1

    local label=Instance.new("TextLabel",frame)
    label.Size=UDim2.new(0.6,0,1,0)
    label.Position=UDim2.new(0.2,0,0,0)
    label.BackgroundTransparency=1
    label.Text=name..": ".._G.Config[key]
    label.Font=Enum.Font.GothamBold
    label.TextSize=14
    table.insert(RainbowList,label)

    local minus=Instance.new("TextButton",frame)
    minus.Size=UDim2.new(0.2,-5,1,0)
    minus.Text="-"
    minus.BackgroundColor3=Color3.fromRGB(60,60,60)
    Instance.new("UICorner",minus)
    minus.MouseButton1Click:Connect(function()
        _G.Config[key]=math.max(step,_G.Config[key]-step)
        label.Text=name..": ".._G.Config[key]
    end)

    local plus=Instance.new("TextButton",frame)
    plus.Size=UDim2.new(0.2,-5,1,0)
    plus.Position=UDim2.new(0.8,5,0,0)
    plus.Text="+"
    plus.BackgroundColor3=Color3.fromRGB(60,60,60)
    Instance.new("UICorner",plus)
    plus.MouseButton1Click:Connect(function()
        _G.Config[key]=_G.Config[key]+step
        label.Text=name..": ".._G.Config[key]
    end)
end

AddToggle("ESP","ESP NAME","ESP_Name_P")
AddToggle("ESP","ESP HEALTH","ESP_Health_P")
AddToggle("ESP","ESP DISTANCE","ESP_Distance_P")
AddToggle("ESP","ESP BOX 2D (BO GÓC)","ESP_Box_P")
AddToggle("ESP","ESP CHAMS","ESP_Chams_P")

AddToggle("Hitbox","HITBOX PLAYER","Hitbox_P")
AddAdjust("Hitbox","HITBOX SIZE","HitboxSize",10)
AddToggle("Hitbox","SHOW HITBOX BOX 3D","Hitbox_Box")
AddToggle("Hitbox","HITBOX WALL CHECK","Hitbox_WallCheck")

AddToggle("Misc","TEAM CHECK (ESP + HB)","TeamCheck")
AddToggle("Misc","LOW HP KS (<30%)","LowHP_KS")

AddToggle("NPC","HITBOX NPC","Hitbox_NPC")
AddAdjust("NPC","HITBOX SIZE NPC","HitboxSize_NPC",10)
AddToggle("NPC","SHOW HITBOX BOX 3D","Hitbox_Box_NPC")
AddToggle("NPC","ESP NPC NAME","ESP_NPC_Name")
AddToggle("NPC","ESP NPC CHAMS","ESP_NPC_Chams")
local ESP_Store={}
local NPC_Store={}
local OriginalHRP_Props = {}
setmetatable(OriginalHRP_Props, {__mode = "k"})

-- HỆ THỐNG CACHE NPC ĐỂ TỐI ƯU FPS VÀ TÌM ĐƯỢC MỌI NPC
local CachedNPCs = {}

local function CheckAndCacheNPC(obj)
    if obj:IsA("Model") and obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            CachedNPCs[obj] = true
        end
    end
end

-- Quét toàn bộ map 1 lần duy nhất lúc bật script
for _, v in ipairs(Workspace:GetDescendants()) do
    CheckAndCacheNPC(v)
end

-- Lắng nghe NPC mới sinh ra
Workspace.DescendantAdded:Connect(function(descendant)
    task.delay(1, function() -- Đợi 1 giây để Model load đầy đủ bộ phận
        if descendant.Parent then CheckAndCacheNPC(descendant) end
    end)
end)

local function RestoreHRP(hrp)
    if hrp and OriginalHRP_Props[hrp] then
        hrp.Size = OriginalHRP_Props[hrp].Size
        hrp.Transparency = OriginalHRP_Props[hrp].Transparency
        hrp.CanCollide = OriginalHRP_Props[hrp].CanCollide
        OriginalHRP_Props[hrp] = nil
    end
end

local function GetHealthColor(pct)
    if pct>0.7 then return Color3.new(0,1,0)
    elseif pct>0.5 then return Color3.new(1,1,0)
    elseif pct>0.3 then return Color3.new(1,0.5,0)
    else return Color3.new(1,0,0)end
end

local function CleanupESP(playerName)
    if ESP_Store[playerName]then
        pcall(function()
            if ESP_Store[playerName].BoxBill then ESP_Store[playerName].BoxBill:Destroy() end
            if ESP_Store[playerName].TextBill then ESP_Store[playerName].TextBill:Destroy() end
        end)
        ESP_Store[playerName]=nil
    end
    local p = Players:FindFirstChild(playerName)
    if p and p.Character then
        if p.Character:FindFirstChild("ArisHL") then p.Character.ArisHL:Destroy() end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if hrp then 
            if hrp:FindFirstChild("ArisHitboxBox") then hrp.ArisHitboxBox:Destroy() end
            RestoreHRP(hrp)
        end
    end
end

local function CleanupNPC(m)
    if NPC_Store[m]then
        pcall(function()
            if NPC_Store[m].Bill then NPC_Store[m].Bill:Destroy() end
        end)
        NPC_Store[m]=nil
    end
    if m then
        if m:FindFirstChild("ArisHL_NPC") then m.ArisHL_NPC:Destroy() end
        local hrp = m:FindFirstChild("HumanoidRootPart")
        if hrp then
            if hrp:FindFirstChild("ArisHitboxBoxNPC") then hrp.ArisHitboxBoxNPC:Destroy() end
            RestoreHRP(hrp)
        end
    end
end

Workspace.DescendantRemoving:Connect(function(descendant)
    if CachedNPCs[descendant] then
        CachedNPCs[descendant] = nil
        CleanupNPC(descendant)
    end
end)

RunService.Heartbeat:Connect(function()
    local rgb=GetRGB()
    for _,v in pairs(RainbowList)do
        if v:IsA("UIStroke")then v.Color=rgb
        elseif v:IsA("TextLabel")or v:IsA("TextButton")then v.TextColor3=rgb end
    end

    local myRoot=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    local hasLowHPEnemy = false
    if _G.Config.Hitbox_P and _G.Config.LowHP_KS and myRoot then
        for _, p in Players:GetPlayers() do
            if p == LocalPlayer then continue end
            if _G.Config.TeamCheck and p.Team == LocalPlayer.Team then continue end
            local char = p.Character
            local hum = char and char:FindFirstChild("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if char and hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - myRoot.Position).Magnitude
                if dist <= 2000 and (hum.Health / hum.MaxHealth) <= 0.3 then
                    hasLowHPEnemy = true
                    break
                end
            end
        end
    end

    -- PLAYER LOOP
    for _,p in Players:GetPlayers()do
        if p==LocalPlayer then continue end
        local char=p.Character
        local hrp=char and char:FindFirstChild("HumanoidRootPart")
        local hum=char and char:FindFirstChild("Humanoid")
        local isTeammate = (_G.Config.TeamCheck and p.Team ~= nil and p.Team == LocalPlayer.Team)

        if not char or not hrp or not hum or hum.Health<=0 or isTeammate then
            if hrp then RestoreHRP(hrp) end
            CleanupESP(p.Name)
            continue
        end

        local hp_percent = hum.Health / hum.MaxHealth
        local dist = myRoot and (hrp.Position - myRoot.Position).Magnitude or math.huge

        local enableHitbox = false
        if _G.Config.Hitbox_P then
            if _G.Config.LowHP_KS then
                if hasLowHPEnemy then
                    if hp_percent <= 0.3 then enableHitbox = true end
                else
                    if dist <= 2000 then enableHitbox = true end
                end
            else
                enableHitbox = true
            end
        end

        if enableHitbox then
            local valid = true
            if _G.Config.Hitbox_WallCheck then
                local rp = RaycastParams.new()
                rp.FilterDescendantsInstances = {LocalPlayer.Character}
                rp.FilterType = Enum.RaycastFilterType.Exclude
                local rr = Workspace:Raycast(Camera.CFrame.Position, (hrp.Position - Camera.CFrame.Position), rp)
                if rr and rr.Instance and not rr.Instance:IsDescendantOf(char) then valid = false end
            end

            if valid then
                if not OriginalHRP_Props[hrp] then
                    OriginalHRP_Props[hrp] = {Size = hrp.Size, Transparency = hrp.Transparency, CanCollide = hrp.CanCollide}
                end
                hrp.Size = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                hrp.Transparency = 0.6
                hrp.CanCollide = false
            else
                RestoreHRP(hrp)
            end
        else
            RestoreHRP(hrp)
        end

        local hl = char:FindFirstChild("ArisHL")
        if _G.Config.ESP_Chams_P then
            if not hl then hl = Instance.new("Highlight", char); hl.Name = "ArisHL" end
            hl.FillColor = rgb; hl.Enabled = true
        else if hl then hl:Destroy() end end

        local hbBox = hrp:FindFirstChild("ArisHitboxBox")
        if _G.Config.Hitbox_Box then
            if not hbBox then hbBox = Instance.new("SelectionBox", hrp); hbBox.Name = "ArisHitboxBox"; hbBox.Adornee = hrp end
            hbBox.SurfaceColor3 = rgb
        else if hbBox then hbBox:Destroy() end end

        if _G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P or _G.Config.ESP_Box_P then
            if not ESP_Store[p.Name] then
                local boxBill = Instance.new("BillboardGui", ScreenGui); boxBill.Size = UDim2.new(4,0,5.5,0); boxBill.AlwaysOnTop = true
                
                local outF = Instance.new("Frame", boxBill); outF.Size = UDim2.new(1,0,1,0); outF.BackgroundTransparency = 1
                Instance.new("UICorner", outF).CornerRadius = UDim.new(0, 6)
                local outS = Instance.new("UIStroke", outF); outS.Color = Color3.new(0,0,0); outS.Thickness = 3
                
                local inF = Instance.new("Frame", boxBill); inF.Size = UDim2.new(1,0,1,0); inF.BackgroundTransparency = 1
                Instance.new("UICorner", inF).CornerRadius = UDim.new(0, 6)
                local inS = Instance.new("UIStroke", inF); inS.Thickness = 1.2
                
                local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0,200,0,60); textB.StudsOffset = Vector3.new(0,3.5,0); textB.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                
                ESP_Store[p.Name]={BoxBill=boxBill, InStroke=inS, TextBill=textB, Text=txt, OutFrame=outF, InFrame=inF}
            end
            local s=ESP_Store[p.Name]
            
            -- ĐÃ FIX: Luôn cập nhật Adornee mới nhất đề phòng người chơi hồi sinh
            s.BoxBill.Adornee = hrp
            s.TextBill.Adornee = char:FindFirstChild("Head") or hrp
            
            s.BoxBill.Enabled=_G.Config.ESP_Box_P; s.InStroke.Color=rgb
            s.Text.Text=table.concat({_G.Config.ESP_Name_P and p.Name or "", _G.Config.ESP_Health_P and ("HP: "..math.floor(hum.Health)) or "", _G.Config.ESP_Distance_P and (dist ~= math.huge) and ("Dist: "..math.floor(dist).."m") or ""}, "\n")
            s.Text.TextColor3=GetHealthColor(hp_percent)
            s.TextBill.Enabled = (_G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P)
        else CleanupESP(p.Name) end
    end

    -- NPC LOOP BẰNG CACHE (Đã Fix Hoạt Động Trên Mọi Game)
    for obj in pairs(CachedNPCs) do
        if not obj.Parent then 
            CachedNPCs[obj] = nil
            CleanupNPC(obj)
            continue
        end

        local hum = obj:FindFirstChild("Humanoid")
        local hrp = obj:FindFirstChild("HumanoidRootPart")
        
        if hum and hrp and hum.Health > 0 then
            
            -- Hitbox NPC Logic
            if _G.Config.Hitbox_NPC then
                if not OriginalHRP_Props[hrp] then
                    OriginalHRP_Props[hrp] = {Size = hrp.Size, Transparency = hrp.Transparency, CanCollide = hrp.CanCollide}
                end
                hrp.Size = Vector3.new(_G.Config.HitboxSize_NPC, _G.Config.HitboxSize_NPC, _G.Config.HitboxSize_NPC)
                hrp.Transparency = 0.6
                hrp.CanCollide = false
                
                local hbBoxNPC = hrp:FindFirstChild("ArisHitboxBoxNPC")
                if _G.Config.Hitbox_Box_NPC then
                    if not hbBoxNPC then 
                        hbBoxNPC = Instance.new("SelectionBox", hrp)
                        hbBoxNPC.Name = "ArisHitboxBoxNPC"
                        hbBoxNPC.Adornee = hrp 
                    end
                    hbBoxNPC.SurfaceColor3 = rgb
                else
                    if hbBoxNPC then hbBoxNPC:Destroy() end
                end
            else
                RestoreHRP(hrp)
                if hrp:FindFirstChild("ArisHitboxBoxNPC") then hrp.ArisHitboxBoxNPC:Destroy() end
            end

            -- ESP Chams NPC
            local hlNPC = obj:FindFirstChild("ArisHL_NPC")
            if _G.Config.ESP_NPC_Chams then
                if not hlNPC then 
                    hlNPC = Instance.new("Highlight", obj)
                    hlNPC.Name = "ArisHL_NPC" 
                end
                hlNPC.FillColor = rgb
                hlNPC.Enabled = true
            else
                if hlNPC then hlNPC:Destroy() end
            end

            -- ESP Name NPC
            if _G.Config.ESP_NPC_Name then
                if not NPC_Store[obj] then
                    local textB = Instance.new("BillboardGui", ScreenGui)
                    textB.Size = UDim2.new(0, 200, 0, 60)
                    textB.StudsOffset = Vector3.new(0, 3.5, 0)
                    textB.AlwaysOnTop = true
                    
                    local txt = Instance.new("TextLabel", textB)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.Font = Enum.Font.GothamBold
                    txt.TextSize = 12
                    txt.TextStrokeTransparency = 0
                    txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                    
                    NPC_Store[obj] = {Bill = textB, Text = txt}
                end
                
                -- ĐÃ FIX: Luôn cập nhật Adornee cho NPC
                NPC_Store[obj].Bill.Adornee = obj:FindFirstChild("Head") or hrp
                NPC_Store[obj].Text.Text = "NPC: " .. obj.Name .. "\nHP: " .. math.floor(hum.Health)
                NPC_Store[obj].Text.TextColor3 = rgb
            else
                if NPC_Store[obj] then
                    NPC_Store[obj].Bill:Destroy()
                    NPC_Store[obj] = nil
                end
            end
        else
            CleanupNPC(obj)
        end
    end
end)

Players.PlayerRemoving:Connect(function(p) CleanupESP(p.Name) end)
