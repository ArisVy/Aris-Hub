pcall(function()
local CFG = getgenv().Team
if CFG == "Pirates" then
    pcall(function()
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")["ChooseTeam"].Container.Pirates.Frame:WaitForChild("TextButton").Visible and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main (minimal)")["ChooseTeam"].Container.Pirates.Frame:WaitForChild("TextButton").Active then
            game:GetService("GuiService").SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main (minimal)").ChooseTeam.Container.Pirates.Frame:WaitForChild("TextButton")
            task.wait(0.000000000000001)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            task.wait(0.000000000000001)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            task.wait(0.000000000000001)
            game:GetService("GuiService").SelectedObject = nil
        end
    end)
elseif CFG == "Marines" then
    pcall(function()
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")["ChooseTeam"].Container.Marines.Frame:WaitForChild("TextButton").Visible and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main (minimal)")["ChooseTeam"].Container.Marines.Frame:WaitForChild("TextButton").Active then
            game:GetService("GuiService").SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main (minimal)").ChooseTeam.Container.Marines.Frame:WaitForChild("TextButton")
            task.wait(0.000000000000001)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            task.wait(0.000000000000001)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            task.wait(0.000000000000001)
            game:GetService("GuiService").SelectedObject = nil
        end
    end)
else
    pcall(function()
        if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")["ChooseTeam"].Container.Marines.Frame:WaitForChild("TextButton").Visible and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main (minimal)")["ChooseTeam"].Container.Marines.Frame:WaitForChild("TextButton").Active then
            game:GetService("GuiService").SelectedObject = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main (minimal)").ChooseTeam.Container.Marines.Frame:WaitForChild("TextButton")
            task.wait(0.000000000000001)
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Return, false, game)
            task.wait(0.000000000000001)
            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Return, false, game)
            task.wait(0.000000000000001)
            game:GetService("GuiService").SelectedObject = nil
        end
    end)
end
end)
local _NotiGui = Instance.new("ScreenGui")
_NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_NotiGui.Name = "BananaNotification"
_NotiGui.Parent = game:GetService("CoreGui")

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
    Noticontainer.Position = UDim2.new(1, 0, 0, 0)
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
    TextLabelNoti.Text = "<font color=\"rgb(255,80,80)\">Aris Hub</font> " .. tostring(Title)
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
CloseBtn.ZIndex = 10 -- Đẩy ZIndex lên để nút X bấm được
    
    local _closed = false
    local _TS = game:GetService("TweenService")
    
    local function remove()
        if _closed then return end
        _closed = true
        _TS:Create(Noticontainer, TweenInfo.new(0.25), {Position = UDim2.new(1, 0, 0, 0)}):Play()
        task.delay(0.3, function() -- Dùng task.delay để không bị treo luồng executor
            if NotiFrame and NotiFrame.Parent then NotiFrame:Destroy() end
        end)
    end
    
    _TS:Create(Noticontainer, TweenInfo.new(0.25), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    
CloseBtn.MouseButton1Click:Connect(remove)
    task.delay(tonumber(Duration) or 3, remove)
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local Mouse = LocalPlayer:GetMouse()

AddNotify({Title="ARIS HUB V1.0 - ENGLISH",Description="UPDATE: Black/Red Float UI & Tracer Fix!",Duration=8})

_G.Config={
    ESP_Box_P=true,
    ESP_Name_P=true,
    ESP_Health_P=true,
    ESP_Chams_P=true,
    ESP_Distance_P=true,
    ESP_PVP=true,
    Hitbox_P=false,
    HitboxSize=150,
    Hitbox_WallCheck=false,
    Hitbox_Box=false,
    ESP_2D_Hitbox=false,
    TeamCheck=true,
    PVPCheck=true,
    LowHP_KS=false,
    Show_Stats=true,
    FastM1=false,
    AutoChangeVector=false,
    Hitbox_NPC=false,
    HitboxSize_NPC=20,
    Hitbox_Box_NPC=false,
    ESP_NPC_Name=false,
    ESP_NPC_Box=false,
    ESP_NPC_Chams=false,
    TeamCheck_NPC=false,
    MenuOpen=false,
    Desync_HideAuto = false,
    Desync_ShowFloat = false,
    Desync_FloatX = 10,
    Desync_FloatY = 25,
    Desync_Mode = "Fix",
    TP_NPC = false,
    TP_Player = false,
    TP_Height = 15,
    TP_Speed = 350,
    Prediction_Enabled = true,
    Prediction = 0.1,
    BlacklistedNPCs = {},
    SelectedTargetPlayer = nil,
    SelectedTargetNPC = nil,
    SafeMode = false,
    AutoDrop = false,
    InfJump = false,
    WalkOnWater = false,
    SilentAim = false,
    FOV_Radius = 1000,
    SilentAim_ShowFloat = true,
    SilentAim_FloatX = 10,
    SilentAim_FloatY = 15,
    SilentAim_Nearest = false,
    SilentAim_NPC = false
}

_G.WalkSpeed = 77
_G.BypassCF = true
_G.TPY = false
_G.PosY = 80
_G.WalkSpeedEnabled = true
_G.IsFleeing = false
_G.IsReturning = false
_G.IsForcedDropping = false

_G.DesyncNormal = false
_G.DesyncFast = false
_G.DesyncFix = false

local UIS = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local plr = Players.LocalPlayer

getgenv().TweenPaused = false
getgenv().currentMove = nil
getgenv().CurrentTween = nil
getgenv().noclipConn = nil
getgenv().originalCollisions = {}
getgenv().moving = false

local moving = false
local noclipConn = nil
local originalCollisions = {}

local moveConn = nil
local CAM_LOCK_DIST = 250
local camLocked = false
local orbitYaw = 0
local orbitPitch = 0
local lastMousePos = nil
local orbitRadius = 0

function enableAntiFall(char)
    if not char or not char:FindFirstChild("Head") then return end
    local head = char.Head
    if not head:FindFirstChild("AntiFallVelocity") then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "AntiFallVelocity"
        bv.Velocity = Vector3.zero
        bv.MaxForce = Vector3.new(9999999, 9999999, 9999999)
        bv.P = 15000
        bv.Parent = head
    end
end

function disableAntiFall(char)
    if char and char:FindFirstChild("Head") then
        local bv = char.Head:FindFirstChild("AntiFallVelocity")
        if bv then bv:Destroy() end
    end
end

function enableNoclip(char)
    originalCollisions = {}
    for _, v in ipairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            originalCollisions[v] = v.CanCollide
            v.CanCollide = false
        end
    end
    if noclipConn then noclipConn:Disconnect() end
    noclipConn = RunService.Stepped:Connect(function()
        if not moving or not char or not char.Parent then return end
        for _, v in ipairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end)
end

function disableNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    for p, s in pairs(originalCollisions) do
        if p and p.Parent then
            p.CanCollide = s
        end
    end
    originalCollisions = {}
end

function stopTween()
    moving = false
    if getgenv().CurrentTween then
        pcall(function() getgenv().CurrentTween:Cancel() end)
        getgenv().CurrentTween = nil
    end
    if getgenv().currentMove then
        getgenv().currentMove:Disconnect()
        getgenv().currentMove = nil
    end
end

function initOrbit(camPos, targetPos)
    orbitRadius = (camPos - targetPos).Magnitude
    local cf = CFrame.new(camPos, targetPos)
    local rx, ry, _ = cf:ToEulerAnglesYXZ()
    orbitPitch = rx
    orbitYaw = ry
    lastMousePos = UIS:GetMouseLocation()
end

function updateOrbit(targetPos)
    local cam = workspace.CurrentCamera
    local mousePos = UIS:GetMouseLocation()
    if lastMousePos then
        local delta = mousePos - lastMousePos
        orbitYaw = orbitYaw - math.rad(delta.X * 0.4)
        orbitPitch = math.clamp(orbitPitch - math.rad(delta.Y * 0.4), math.rad(-80), math.rad(80))
    end
    lastMousePos = mousePos
    local cf = CFrame.new(targetPos)
        * CFrame.fromEulerAnglesYXZ(0, orbitYaw, 0)
        * CFrame.fromEulerAnglesYXZ(orbitPitch, 0, 0)
        * CFrame.new(0, 0, orbitRadius)
    cam.CFrame = CFrame.new(cf.Position, targetPos)
end

function unlockCam()
    if not camLocked then return end
    camLocked = false
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    local char = plr.Character
    if char then
        workspace.CurrentCamera.CameraSubject = char:FindFirstChildOfClass("Humanoid") or char:FindFirstChild("HumanoidRootPart")
    end
end

function stopMove()
    if moveConn then
        moveConn:Disconnect()
        moveConn = nil
    end
end

function notween(cf)
    local c = plr.Character
    if c and c:FindFirstChild("HumanoidRootPart") then
        c.HumanoidRootPart.CFrame = cf
    end
end

function smartMove(_, targetCF)
    if typeof(targetCF) ~= "CFrame" then return end
    stopMove()

    local char = plr.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum or hum.Health <= 0 then return end

    hrp.Anchored = false
    hum.Sit = false
    enableNoclip(char)
    enableAntiFall(char)

    local startPos = hrp.Position
    local endPos = targetCF.Position
    local dist = (endPos - startPos).Magnitude
    if dist < 0.1 then
        disableNoclip()
        disableAntiFall(char)
        return
    end

    local speed = 350
    local traveled = 0
    camLocked = false

    moveConn = RunService.Heartbeat:Connect(function(dt)
        local c = plr.Character
        local h = c and c:FindFirstChild("HumanoidRootPart")
        local hm = c and c:FindFirstChildOfClass("Humanoid")
        if not c or not h or not hm or hm.Health <= 0 then
            stopMove()
            disableNoclip()
            disableAntiFall(c)
            unlockCam()
            return
        end

        if getgenv().TweenPaused then
            stopMove()
            disableNoclip()
            disableAntiFall(c)
            unlockCam()
            return
        end

        traveled = traveled + speed * dt

        if traveled >= dist then
            h.CFrame = targetCF
            stopMove()
            disableNoclip()
            disableAntiFall(c)
            unlockCam()
            return
        end

        local t = traveled / dist
        local pos = startPos:Lerp(endPos, t)
        h.CFrame = CFrame.new(pos, endPos)

        local remainDist = (endPos - pos).Magnitude

        if not camLocked and remainDist <= CAM_LOCK_DIST then
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            local camPos = workspace.CurrentCamera.CFrame.Position
            local camToPlayer = (camPos - pos).Magnitude
            local dirFromTarget = (camPos - endPos).Unit
            local lockedCamPos = endPos + dirFromTarget * camToPlayer
            initOrbit(lockedCamPos, endPos)
            workspace.CurrentCamera.CFrame = CFrame.new(lockedCamPos, endPos)
            camLocked = true
        end

        if camLocked then
            updateOrbit(endPos)
        end
    end)
end

function IsInSubmergedIsland()
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    return hrp.Position.Y < -1000
end

function InArea(POS)
    local pos = typeof(POS) == "CFrame" and POS.Position or POS
    for _, v in next, workspace._WorldOrigin.Locations:GetChildren() do
        if (pos - v.Position).Magnitude <= v.Mesh.Scale.X then
            return v
        end
    end
    return {Name = ""}
end

function CheckLegendaryItems()
    local items = {"God's Chalice","Fist of Darkness","Sweet Chalice","Hallow Essence","Flower1","Microchip"}
    for _, n in pairs(items) do
        for _, v in pairs(plr.Backpack:GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name, n) then return true end
        end
        for _, v in pairs(plr.Character:GetChildren()) do
            if v:IsA("Tool") and string.find(v.Name, n) then return true end
        end
    end
end

function GetSpawnPoint(x)
    for _, v in next, workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren() do
        if (v.Part.Position - x.Position).Magnitude <= 2500 then return v end
    end
end

function GetBypassCFrame(x)
    local max = math.huge
    local pos
    for _, v in next, workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren() do
        local hrp = plr.Character.HumanoidRootPart
        if (x.Position - hrp.Position).Magnitude >= 1000
        and GetSpawnPoint(v.Part) ~= GetSpawnPoint(hrp)
        and (v.Part.Position - hrp.Position).Magnitude <= 10000
        and (v.Part.Position - x.Position).Magnitude <= max then
            max = (v.Part.Position - x.Position).Magnitude
            pos = v
        end
    end
    return pos
end

function CanBypassTeleport(x)
    local area = InArea(x).Name
    if area == "" then return false end
    if not _G.BypassCF or area:find("Dimension") or area:find("Submerged")
    or area == "Sealed Cavern" or area:lower():find("under")
    or CheckLegendaryItems() then return false end
    if plr.Data.LastSpawnPoint.Value == "SubmergedIsland" then return false end
    if (x.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 3500 then return false end
    return true
end

function BypassTP(Target)
    local char = plr.Character
    if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then return false end
    if not CanBypassTeleport(Target) or not GetBypassCFrame(Target) then return false end
    local MAX_BYPASS = 6
    local attempt = 0
    while attempt < MAX_BYPASS do
        char = plr.Character
        if not char or not char:FindFirstChild("Humanoid") or char.Humanoid.Health <= 0 then break end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then break end
        local dist = (Target.Position - hrp.Position).Magnitude
        if dist <= 750 then break end
        if not CanBypassTeleport(Target) then break end
        local TargetTP = GetBypassCFrame(Target)
        if not TargetTP then break end
        char.LastSpawnPoint.Disabled = true
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", TargetTP.Name)
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
        char:PivotTo(TargetTP.Part.CFrame)
        char.Humanoid:ChangeState(15)
        repeat task.wait() until char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0
        moving = false
        task.wait(0.5)
        attempt = attempt + 1
    end
    return true
end

local World1 = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Sea1") ~= nil
local World2 = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Sea2") ~= nil
local World3 = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Sea3") ~= nil

function CheckNearestTeleporter(aI)
    local p = aI.Position
    local best, dist = nil, math.huge
    local list = {}
    if World3 then
        list = {Vector3.new(-5096.27, 314.74, -3142.80), Vector3.new(-12471.17, 375.14, -7551.68), Vector3.new(5643.49, 1014.52, -341.89), Vector3.new(-16813.439453125, 58.32271957397461, 304.87396240234375)}
    elseif World2 then
        list = {Vector3.new(2285, 15, 905), Vector3.new(923, 126, 32852), Vector3.new(-6508.55, 83.44, -132.84), Vector3.new(-286.99, 306.35, 597.79), Vector3.new(3028.59, 2281.08, -7324.82), Vector3.new(28286.36, 14896.73, 102.62)}
    elseif World1 then
        list = {Vector3.new(-4652, 873, -1754), Vector3.new(-7895, 5547, -380), Vector3.new(61164, 5, 1820), Vector3.new(3865, 5, -1926)}
    end
    for _, v in ipairs(list) do
        local d = (v - p).Magnitude
        if d < dist then dist = d; best = v end
    end
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp and best and dist <= (p - hrp.Position).Magnitude then
        return best
    end
end

function requestEntrance(pos)
    ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", pos)
    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0) end
    task.wait(0.35)
end

function TeleportWithHeightControl(hrp, targetCF, height)
    local startPos = hrp.Position
    local targetPos = targetCF.Position
    if _G.TPY and height then
        local boostHeight = math.max(startPos.Y + height, targetPos.Y + 10)
        notween(CFrame.new(startPos.X, boostHeight, startPos.Z))
        task.wait(0.1)
        smartMove(hrp, CFrame.new(targetPos.X, boostHeight, targetPos.Z))
        local currentHeight = boostHeight
        while currentHeight > targetPos.Y + 1000 do
            currentHeight = math.max(currentHeight - 1000, targetPos.Y)
            hrp.CFrame = CFrame.new(targetPos.X, currentHeight, targetPos.Z)
            task.wait()
        end
        hrp.CFrame = targetCF
    else
        smartMove(hrp, targetCF)
    end
end

tween = function(targetCFrame)
    if getgenv().TweenPaused then return end
    if typeof(targetCFrame) ~= "CFrame" then return end

    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp or hum.Health <= 0 then return end

    if not _G.SailBoats then hum.Sit = false end
    hrp.Anchored = false

    local dist = (targetCFrame.Position - hrp.Position).Magnitude
    if dist <= 0 then
        notween(targetCFrame)
        return
    end

    if not _G.SailBoat then
        if IsInSubmergedIsland() then
            local exitPos = CFrame.new(11427, -2155, 9725)
            local targetArea = InArea(targetCFrame).Name
            local targetInSub = targetArea and targetArea:find("Submerged")
            local distToTarget = (targetCFrame.Position - hrp.Position).Magnitude
            if targetInSub or distToTarget < 500 then
                smartMove(hrp, targetCFrame)
            else
                smartMove(hrp, exitPos)
                task.wait(0.5)
                game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/SubmarineTransportation"):InvokeServer("InitiateTeleport", "Tiki Outpost")
                repeat task.wait(0.2) until not IsInSubmergedIsland()
                char = plr.Character
                if not char then return end
                hum = char:FindFirstChildOfClass("Humanoid")
                hrp = char:FindFirstChild("HumanoidRootPart")
                if not hum or not hrp or hum.Health <= 0 then return end
                if _G.BypassCF and (targetCFrame.Position - hrp.Position).Magnitude > 1000 then
                    local bypassed = BypassTP(targetCFrame)
                    if bypassed then return end
                end
            end
        else
            if _G.BypassCF and (targetCFrame.Position - hrp.Position).Magnitude > 1000 then
                local bypassed = BypassTP(targetCFrame)
                if bypassed then return end
            end
            local tp = CheckNearestTeleporter(targetCFrame)
            if tp then requestEntrance(tp) end
        end
    end

    char = plr.Character
    if not char then return end
    hum = char:FindFirstChildOfClass("Humanoid")
    hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp or hum.Health <= 0 then return end

    if dist > 250 then
        local cam = workspace.CurrentCamera
        local relCamPos = cam.CFrame.Position - hrp.Position
        cam.CFrame = CFrame.new(targetCFrame.Position + relCamPos, targetCFrame.Position)
    end

    if not _G.SailBoat and _G.TPY then
        TeleportWithHeightControl(hrp, targetCFrame, _G.PosY or 80)
    else
        smartMove(hrp, targetCFrame)
    end

    repeat RunService.Heartbeat:Wait() until not moveConn
end

plr.CharacterAdded:Connect(function()
    stopTween()
    disableNoclip()
    disableAntiFall(plr.Character)
end)

local TempSkipNPC = {}
local TempSkipPlayer = {}
local CachedNPCs = {}
local MAX_NPC_RENDER_DISTANCE = 2500

local currentTween = nil
local currentTarget = nil
local noclipConnection = nil

local SilentAimTarget = nil
local FOVCircle = nil
local TracerLine = nil

pcall(function()
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Visible = false
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Thickness = 1.5
    FOVCircle.Filled = false
    FOVCircle.NumSides = 64

    TracerLine = Drawing.new("Line")
    TracerLine.Visible = false
    TracerLine.Color = Color3.fromRGB(255, 0, 0)
    TracerLine.Thickness = 2
    TracerLine.Transparency = 1
end)

if CoreGui:FindFirstChild("ArisHUB_PRO") then
    CoreGui.ArisHUB_PRO:Destroy()
end
if CoreGui:FindFirstChild("ArisFloatToggle") then
    CoreGui.ArisFloatToggle:Destroy()
end
if CoreGui:FindFirstChild("ArisSAFloatToggle") then
    CoreGui.ArisSAFloatToggle:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArisHUB_PRO"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 99999
ScreenGui.Parent = CoreGui

local StatsFrame = Instance.new("Frame", ScreenGui)
StatsFrame.Size = UDim2.new(0, 150, 0, 26)
StatsFrame.Position = UDim2.new(0, 15, 0, 60)
StatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatsFrame.BackgroundTransparency = 0.5
StatsFrame.BorderSizePixel = 0
StatsFrame.Visible = _G.Config.Show_Stats
Instance.new("UICorner", StatsFrame).CornerRadius = UDim.new(0, 6)

local StatsText = Instance.new("TextLabel", StatsFrame)
StatsText.Size = UDim2.new(1, 0, 1, 0)
StatsText.BackgroundTransparency = 1
StatsText.Text = "FPS: 0 | PING: 0ms"
StatsText.Font = Enum.Font.GothamBold
StatsText.TextSize = 13
StatsText.TextColor3 = Color3.new(1,1,1)

local StatsGrad = Instance.new("UIGradient", StatsText)
StatsGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200))
})

local TargetStatsFrame = Instance.new("Frame", ScreenGui)
TargetStatsFrame.Size = UDim2.new(0, 280, 0, 26)
TargetStatsFrame.Position = UDim2.new(0, 15, 0, 90)
TargetStatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TargetStatsFrame.BackgroundTransparency = 0.5
TargetStatsFrame.BorderSizePixel = 0
TargetStatsFrame.Visible = false
Instance.new("UICorner", TargetStatsFrame).CornerRadius = UDim.new(0, 6)

local TargetStatsText = Instance.new("TextLabel", TargetStatsFrame)
TargetStatsText.Size = UDim2.new(1, 0, 1, 0)
TargetStatsText.BackgroundTransparency = 1
TargetStatsText.Text = "Target: Looking..."
TargetStatsText.Font = Enum.Font.GothamBold
TargetStatsText.TextSize = 13
TargetStatsText.TextColor3 = Color3.new(1,1,1)

local TargetStatsGrad = Instance.new("UIGradient", TargetStatsText)
TargetStatsGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200))
})

local FPS_Frames = 0
RunService.RenderStepped:Connect(function()
    FPS_Frames = FPS_Frames + 1

    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = _G.WalkSpeedEnabled and _G.WalkSpeed or 16
        end
    end

    if (_G.Config.TP_Player or _G.Config.TP_NPC) then
        if currentTarget and currentTarget.Parent then
            TargetStatsFrame.Visible = true
            local char = currentTarget.Parent
            local hum = char:FindFirstChild("Humanoid")
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hum and myRoot then
                local dist = math.floor((currentTarget.Position - myRoot.Position).Magnitude)
                local hp = math.floor(hum.Health)
                local maxHp = math.floor(hum.MaxHealth)
                local name = char.Name
                local p = Players:GetPlayerFromCharacter(char)
                if p then name = p.Name end

                local icon = p and "ðŸ‘¤" or "ðŸ‘¹"
                TargetStatsText.Text = string.format("%s %s | HP: %d/%d | Dist: %dm", icon, name, hp, maxHp, dist)
            end
        else
            TargetStatsFrame.Visible = true
            TargetStatsText.Text = "Target: Looking for nearest..."
        end
    else
        TargetStatsFrame.Visible = false
    end
end)

task.spawn(function()
    while task.wait(1) do
        local ping = 0
        pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000) end)
        if ping == 0 then
            pcall(function() ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) end)
        end
        if StatsFrame.Visible then StatsText.Text = string.format("FPS: %d  |  PING: %dms", FPS_Frames, ping) end
        FPS_Frames = 0
    end
end)

local UIGradientList = {}
local TextGradientList = {}
local BtnGradientList = {}
local ToggleButtons = {}
local AdjustLabels = {}

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

function GetTrueStatus(target)
    if not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then return false end
    local char = target.Character
    local pos = char.HumanoidRootPart.Position

    if char:FindFirstChildOfClass("ForceField") then return false end

    local safeZones = workspace:FindFirstChild("_WorldOrigin") and workspace:FindFirstChild("_WorldOrigin"):FindFirstChild("SafeZones")
    if safeZones then
        for _, zone in pairs(safeZones:GetChildren()) do
            if zone:IsA("Part") or zone:IsA("MeshPart") then
                local distance = (zone.Position - pos).Magnitude
                if distance <= (zone.Size.X / 2 + 10) or distance <= (zone.Size.Z / 2 + 10) then return false end
            end
        end
    end

    if target:GetAttribute("PvpDisabled") == true then return false end

    return true
end

function GetClosestTargetForAim()
    local Closest = nil
    local ShortestDistance = math.huge
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local myRoot = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("Head"))

    function CheckTarget(targetRoot, targetPlayer)
        if not targetRoot then return end

        if _G.Config.SilentAim_Nearest and myRoot then
            local dist3D = (myRoot.Position - targetRoot.Position).Magnitude
            if dist3D < ShortestDistance then
                ShortestDistance = dist3D
                Closest = targetRoot
            end
        else
            local screenPos, onScreen = Camera:WorldToViewportPoint(targetRoot.Position)
            if onScreen then
                local distToFov = (screenCenter - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                if distToFov <= _G.Config.FOV_Radius and distToFov < ShortestDistance then
                    ShortestDistance = distToFov
                    Closest = targetRoot
                end
            end
        end
    end

    for _, Player in next, Players:GetPlayers() do
        if Player == LocalPlayer then continue end
        local Character = Player.Character
        if not Character then continue end

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Head")

        if not Humanoid or Humanoid.Health <= 0 or not RootPart then continue end
        if _G.Config.TeamCheck and Player.Team == LocalPlayer.Team then continue end
        if _G.Config.PVPCheck and not GetTrueStatus(Player) then continue end

        CheckTarget(RootPart, Player)
    end

    if _G.Config.SilentAim_NPC then
        for npc, _ in pairs(CachedNPCs) do
            if npc and npc.Parent then
                local Humanoid = npc:FindFirstChild("Humanoid")
                local RootPart = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Head")
                if Humanoid and Humanoid.Health > 0 and RootPart then
                    CheckTarget(RootPart, nil)
                end
            end
        end
    end

    return Closest
end

if not getgenv().Hook_Initialized_Aris then
    getgenv().Hook_Initialized_Aris = true
    local OldNamecall
    OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if _G.Config.SilentAim and SilentAimTarget and self == workspace and not checkcaller() then
            if method == "Raycast" or string.find(method, "Ray") then
                local raw_trace = debug.traceback()
                local trace = raw_trace and string.lower(raw_trace) or ""
                if string.find(trace, "effect") or string.find(trace, "doublejump") or string.find(trace, "skyjump") or string.find(trace, "sky jump") or string.find(trace, "airjump") or string.find(trace, "air jump") or string.find(trace, "visual") or string.find(trace, "camera") or string.find(trace, "dodge") or string.find(trace, "jump") or string.find(trace, "geppo") then
                    return OldNamecall(self, ...)
                end
                local origin
                if method == "Raycast" then
                    origin = args[1]
                elseif args[1] and typeof(args[1]) == "Ray" then
                    origin = args[1].Origin
                end
                if origin and typeof(origin) == "Vector3" then
                    -- [ PREDICTION 0.125s CHO RAYCAST ] --
                    local aimPos = SilentAimTarget.Position
                    if SilentAimTarget:IsA("BasePart") then
                        aimPos = aimPos + (SilentAimTarget.AssemblyLinearVelocity * 0.125) 
                    end

                    if method == "Raycast" then
                        args[2] = (aimPos - origin).Unit * 1000
                        return OldNamecall(self, unpack(args))
                    else
                        args[1] = Ray.new(origin, (aimPos - origin).Unit * 1000)
                        return OldNamecall(self, unpack(args))
                    end
                end
            end
        end
        return OldNamecall(self, ...)
    end))
    local OldIndex
    OldIndex = hookmetamethod(game, "__index", newcclosure(function(self, index)
        if not _G.Config.SilentAim or not SilentAimTarget or checkcaller() or self ~= Mouse then
            return OldIndex(self, index)
        end
        if index == "Hit" or index == "hit" or index == "Target" or index == "target" then
            local raw_trace = debug.traceback()
            local trace = raw_trace and string.lower(raw_trace) or ""
            if string.find(trace, "combatframework") or string.find(trace, "camera") or string.find(trace, "doublejump") or string.find(trace, "skyjump") or string.find(trace, "sky jump") or string.find(trace, "airjump") or string.find(trace, "air jump") or string.find(trace, "visual") or string.find(trace, "popper") or string.find(trace, "playermodule") or string.find(trace, "effect") or string.find(trace, "visual") or string.find(trace, "dodge") or string.find(trace, "jump") or string.find(trace, "geppo") then
                return OldIndex(self, index)
            end
            local char = LocalPlayer.Character
            local tool = char and char:FindFirstChildOfClass("Tool")
            if not tool then
                return OldIndex(self, index)
            end
            if index == "Hit" or index == "hit" then
                -- [ PREDICTION 0.125s CHO MOUSE.HIT ] --
                local aimPos = SilentAimTarget.Position
                if SilentAimTarget:IsA("BasePart") then
                    aimPos = aimPos + (SilentAimTarget.AssemblyLinearVelocity * 0.125)
                end

                if tool.Name == "Dragon Trident" then
                    aimPos = aimPos - Vector3.new(0, 3, 0)
                end
                return CFrame.new(aimPos)
            elseif index == "Target" or index == "target" then
                return SilentAimTarget
            end
        end
        return OldIndex(self, index)
    end))
end

local desyncState = false
local replicatesignal = getgenv().replicatesignal or function(...) return ... end
function ToggleDesync(state) pcall(function() if raknet and type(raknet.desync) == "function" then raknet.desync(state) end end) end

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

function SetNormal(state) _G.DesyncNormal = state if not state then ToggleDesync(false) end end
function SetFast(state) _G.DesyncFast = state if not state then ToggleDesync(false) end end
function SetFixV2_Logic(state)
    _G.DesyncFix = state
    ToggleDesync(state)
    if state then
        for _, flagData in ipairs(NumericFlags) do pcall(function() setfflag(flagData[1], flagData[2]) end) end
    else
        for _, flagData in ipairs(NumericFlags) do pcall(function() setfflag(flagData[1], "") end) end
    end
end

local AnimationLib = {}
function AnimationLib.CreateParticleEffect(position, color, duration)
    local part = Instance.new("Part") part.Size = Vector3.new(2, 2, 2) part.Anchored = true part.CanCollide = false part.Material = Enum.Material.Neon part.Color = color part.CFrame = CFrame.new(position) part.Transparency = 0.3 part.Parent = workspace
    local light = Instance.new("PointLight") light.Color = color light.Range = 15 light.Brightness = 2 light.Parent = part
    local tween = game:GetService("TweenService"):Create(part, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Vector3.new(0.5, 0.5, 0.5), Transparency = 1, CFrame = CFrame.new(position) * CFrame.new(math.random(-5, 5), math.random(5, 10), math.random(-5, 5)) })
    tween:Play() tween.Completed:Connect(function() part:Destroy() end) return part
end

function AnimationLib.CreateBeam(startPos, endPos, color, duration)
    local attachment1 = Instance.new("Attachment") attachment1.Position = Vector3.new(0, 0, 0)
    local attachment2 = Instance.new("Attachment") attachment2.Position = endPos - startPos
    local beam = Instance.new("Beam") beam.Attachment0 = attachment1 beam.Attachment1 = attachment2 beam.Color = ColorSequence.new(color) beam.Width0 = 0.5 beam.Width1 = 0.5 beam.FaceCamera = true
    local part = Instance.new("Part") part.Size = Vector3.new(1, 1, 1) part.Anchored = true part.CanCollide = false part.Transparency = 1 part.CFrame = CFrame.new(startPos) part.Parent = workspace
    attachment1.Parent = part attachment2.Parent = part beam.Parent = part
    task.delay(duration, function() beam:Destroy() attachment1:Destroy() attachment2:Destroy() part:Destroy() end) return beam
end

function AnimationLib.DesyncTeleportEffect(position)
    for i = 1, 8 do task.spawn(function() AnimationLib.CreateParticleEffect(position + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3)), Color3.fromRGB(0, 150, 255), 0.8) end) task.wait(0.05) end
    local wave = Instance.new("Part") wave.Size = Vector3.new(1, 1, 1) wave.Anchored = true wave.CanCollide = false wave.Transparency = 0.7 wave.Color = Color3.fromRGB(0, 100, 255) wave.Material = Enum.Material.Neon wave.CFrame = CFrame.new(position) wave.Parent = workspace
    local tween = game:GetService("TweenService"):Create(wave, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = Vector3.new(20, 0.1, 20), Transparency = 1})
    tween:Play() tween.Completed:Connect(function() wave:Destroy() end)
end

local desyncPart, lastSafeCF, lastTeleportCheck

function CreateDesyncMarker(pos)
    if desyncPart then desyncPart:Destroy() desyncPart = nil end
    desyncPart = Instance.new("Part") desyncPart.Name = "DesyncMarker" desyncPart.Anchored = true desyncPart.CanCollide = false desyncPart.Size = Vector3.new(4, 4, 4) desyncPart.Transparency = 0.5 desyncPart.Color = Color3.fromRGB(0, 150, 255) desyncPart.Material = Enum.Material.Neon desyncPart.CFrame = pos desyncPart.Parent = workspace
    lastSafeCF = pos
    local bbGui = Instance.new("BillboardGui") bbGui.Size = UDim2.new(10, 0, 4, 0) bbGui.AlwaysOnTop = true bbGui.Adornee = desyncPart bbGui.Parent = desyncPart
    local frame = Instance.new("Frame") frame.Size = UDim2.new(1, 0, 1, 0) frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) frame.BackgroundTransparency = 0.7 frame.Parent = bbGui Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    local txt = Instance.new("TextLabel") txt.Size = UDim2.new(1, 0, 1, 0) txt.BackgroundTransparency = 1 txt.Text = "ARIS DESYNC POINT" txt.TextColor3 = Color3.fromRGB(255, 255, 255) txt.TextScaled = true txt.Font = Enum.Font.GothamBold txt.TextStrokeTransparency = 0.8 txt.Parent = frame
    task.spawn(function()
        while desyncPart and desyncPart.Parent do
            local t1 = game:GetService("TweenService"):Create(desyncPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Vector3.new(4.5, 4.5, 4.5)}) t1:Play() t1.Completed:Wait()
            if desyncPart then local t2 = game:GetService("TweenService"):Create(desyncPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = Vector3.new(4, 4, 4)}) t2:Play() t2.Completed:Wait() end
        end
    end)
    AnimationLib.DesyncTeleportEffect(pos.Position) return desyncPart
end

function UpdateDesyncMarker(pos)
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

function ForceUpdateMarker(pos)
    if not desyncPart then CreateDesyncMarker(pos) return end
    AnimationLib.DesyncTeleportEffect(desyncPart.Position) desyncPart.CFrame = pos lastSafeCF = pos lastTeleportCheck = pos
end

function HideDesyncMarker()
    if desyncPart then AnimationLib.DesyncTeleportEffect(desyncPart.Position) desyncPart:Destroy() desyncPart = nil lastSafeCF = nil lastTeleportCheck = nil end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    local hrp = char:WaitForChild("HumanoidRootPart", 10) if not hrp then return end
    task.wait(0.1)
    if desyncState then
        if desyncPart then AnimationLib.CreateBeam(desyncPart.Position, hrp.Position, Color3.fromRGB(0, 150, 255), 0.5) end
        ForceUpdateMarker(hrp.CFrame)
    end
end)

function FastRespawnUserLogic(plr, isHide)
    ToggleDesync(true)
    local char = plr.Character if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local ogpos = hrp.CFrame local ogpos2 = workspace.CurrentCamera.CFrame
    local hum = char:FindFirstChildWhichIsA("Humanoid") if hum then hum.Health = 0 end
    task.spawn(function()
        local newChar = plr.CharacterAdded:Wait()
        local newHrp = newChar:WaitForChild("HumanoidRootPart", 10) if not newHrp then return end
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

function CustomRespawnFix(plr)
    local char = plr.Character if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    AnimationLib.DesyncTeleportEffect(hrp.Position)
    local ogpos = hrp.CFrame local ogpos2 = workspace.CurrentCamera.CFrame
    local replicatesig = getgenv().replicatesignal or function() end
    replicatesig(plr.ConnectDiedSignalBackend)
    task.wait(Players.RespawnTime - 0.1)
    replicatesig(plr.Kill)
    return plr.CharacterAdded:Wait(), ogpos, ogpos2
end

function DoHideNormal()
    local char = LocalPlayer.Character if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local originalCF = hrp.CFrame local originalCam = workspace.CurrentCamera.CFrame

    ToggleDesync(true)
    AnimationLib.DesyncTeleportEffect(hrp.Position)
    UpdateDesyncMarker(originalCF)

    local vheight = math.random(5000, 9888)
    hrp.CFrame = originalCF + Vector3.new(0, vheight, 0)
    workspace.CurrentCamera.CFrame = originalCam
    task.wait(0.5)

    _G.DesyncNormal = true
    hrp.CFrame = originalCF
    workspace.CurrentCamera.CFrame = originalCam
    AnimationLib.CreateBeam(hrp.Position, originalCF.Position, Color3.fromRGB(0, 255, 150), 0.3)
    AnimationLib.DesyncTeleportEffect(originalCF.Position)
end

function ActivateDesyncNormal()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    if _G.Config.Desync_HideAuto then DoHideNormal() else
        ToggleDesync(true)
        _G.DesyncNormal = true
        UpdateDesyncMarker(hrp.CFrame)
        AnimationLib.DesyncTeleportEffect(hrp.Position)
    end
end

function DoFastDesync()
    local char = LocalPlayer.Character if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    local savedCFrame = hrp.CFrame UpdateDesyncMarker(savedCFrame)
    FastRespawnUserLogic(LocalPlayer, _G.Config.Desync_HideAuto)
    SetFast(true)
    local newChar = LocalPlayer.Character if newChar then local newHrp = newChar:WaitForChild("HumanoidRootPart", 5) if newHrp then UpdateDesyncMarker(savedCFrame) end end
end

function DoFixDesync(isHide)
    local char = LocalPlayer.Character if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart") if not hrp then return end
    SetFixV2_Logic(true)
    UpdateDesyncMarker(hrp.CFrame)
    local newChar, originalCF, originalCam = CustomRespawnFix(LocalPlayer)
    local newHrp = newChar:WaitForChild("HumanoidRootPart")
    if isHide then local randomY = math.random(8000, 9000) newHrp.CFrame = CFrame.new(newHrp.Position.X, randomY, newHrp.Position.Z) workspace.CurrentCamera.CFrame = newHrp.CFrame task.wait(0.15) end
    SetFixV2_Logic(true)
    UpdateDesyncMarker(newHrp.CFrame)
end

local adminUserId = 4216777620
function CheckAdmin()
    for _, p in ipairs(Players:GetPlayers()) do if p.UserId == adminUserId then return true end end
    return false
end

function MakeDraggable(f)
    local d=false;local i,s
    f.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=true; i=inp.Position; s=f.Position end end)
    f.InputChanged:Connect(function(inp) if (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) and d then local delta=inp.Position-i; f.Position=UDim2.new(s.X.Scale,s.X.Offset+delta.X,s.Y.Scale,s.Y.Offset+delta.Y) end end)
    UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then d=false end end)
end

local ToggleBtn = Instance.new("ImageButton",ScreenGui)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0,10,0.5,-25)
ToggleBtn.Image = "rbxassetid://125329301331069"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
ToggleBtn.ClipsDescendants = true
ToggleBtn.Visible = true
Instance.new("UICorner",ToggleBtn).CornerRadius = UDim.new(0,20)
CreateBorder(ToggleBtn) MakeDraggable(ToggleBtn) ApplyButtonAnimation(ToggleBtn)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then _G.Config.MenuOpen = not _G.Config.MenuOpen; MainFrame.Visible = _G.Config.MenuOpen end
end)

local MainFrame = Instance.new("Frame",ScreenGui)
MainFrame.Size = UDim2.new(0,400,0,310)
MainFrame.Position = UDim2.new(0,70,0.2,0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
MainFrame.Visible = false
Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,20)
CreateBorder(MainFrame)

local ResetBtn = Instance.new("TextButton",MainFrame)
ResetBtn.Size = UDim2.new(0,36,0,32)
ResetBtn.Position = UDim2.new(0,12,0,7)
ResetBtn.Text = ""
ResetBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner",ResetBtn).CornerRadius = UDim.new(0,16)
ApplyToggleGradient(ResetBtn, false) CreateBorder(ResetBtn) CreateButtonText(ResetBtn, "RST", Enum.Font.GothamBold, 13) ApplyButtonAnimation(ResetBtn)

ResetBtn.MouseButton1Click:Connect(function()
    task.spawn(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then while char.Humanoid.Health > 0 and char.Parent do char.Humanoid.Health = 0; task.wait(0.1) end end
    end)
end)

local SafeBtn = Instance.new("TextButton",MainFrame)
SafeBtn.Size = UDim2.new(0,45,0,32)
SafeBtn.Position = UDim2.new(1,-55,0,7)
SafeBtn.Text = ""
SafeBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner",SafeBtn).CornerRadius = UDim.new(0,16)
ApplyToggleGradient(SafeBtn, _G.Config.SafeMode) CreateBorder(SafeBtn) CreateButtonText(SafeBtn, "SAFE", Enum.Font.GothamBold, 11) ApplyButtonAnimation(SafeBtn)

SafeBtn.MouseButton1Click:Connect(function()
    _G.Config.SafeMode = not _G.Config.SafeMode
    ApplyToggleGradient(SafeBtn, _G.Config.SafeMode)
    AddNotify({Title="SAFE MODE",Description=_G.Config.SafeMode and "ON: Tele 100km when HP <35%!" or "TURNED OFF!",Duration=3})
end)

local Btn75K = Instance.new("TextButton",MainFrame)
Btn75K.Size = UDim2.new(0,45,0,32)
Btn75K.Position = UDim2.new(1,-105,0,7)
Btn75K.Text = ""
Btn75K.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner",Btn75K).CornerRadius = UDim.new(0,16)
ApplyToggleGradient(Btn75K, false) CreateBorder(Btn75K) CreateButtonText(Btn75K, "75K", Enum.Font.GothamBold, 11) ApplyButtonAnimation(Btn75K)

Btn75K.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if currentTween then currentTween:Cancel() end
        hrp.CFrame = CFrame.new(hrp.Position.X, 75000, hrp.Position.Z)
        AddNotify({Title="TELEPORT",Description="Teleported straight to Y: 75,000!",Duration=3})
    end
end)

local DropBtn = Instance.new("TextButton",MainFrame)
DropBtn.Size = UDim2.new(0,45,0,32)
DropBtn.Position = UDim2.new(1,-155,0,7)
DropBtn.Text = ""
DropBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner",DropBtn).CornerRadius = UDim.new(0,16)
ApplyToggleGradient(DropBtn, _G.Config.AutoDrop) CreateBorder(DropBtn) CreateButtonText(DropBtn, "DROP", Enum.Font.GothamBold, 11) ApplyButtonAnimation(DropBtn)

DropBtn.MouseButton1Click:Connect(function()
    _G.Config.AutoDrop = not _G.Config.AutoDrop
    ApplyToggleGradient(DropBtn, _G.Config.AutoDrop)
    AddNotify({Title="DROP MODE",Description=_G.Config.AutoDrop and "ON: Force drop when stuck in sky (SAFE OFF)!" or "TURNED OFF!",Duration=3})
end)

local Title = Instance.new("TextLabel",MainFrame)
Title.Size = UDim2.new(1,-215,0,45)
Title.Position = UDim2.new(0,60,0,0)
Title.Text = "ARIS HUB V1.0"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center
CreateTextGradient(Title) MakeDraggable(MainFrame)

ToggleBtn.MouseButton1Click:Connect(function() _G.Config.MenuOpen=not _G.Config.MenuOpen; MainFrame.Visible=_G.Config.MenuOpen end)

local TabFrame = Instance.new("ScrollingFrame",MainFrame)
TabFrame.Size = UDim2.new(1,-10,0,35)
TabFrame.Position = UDim2.new(0,5,0,45)
TabFrame.BackgroundTransparency = 1
TabFrame.ScrollBarThickness = 3
TabFrame.ScrollingDirection = Enum.ScrollingDirection.X
TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
TabFrame.BorderSizePixel = 0

local Tabs = {"ESP","Hitbox","Misc","NPC","Desync", "TP NPC", "TP Player", "Combat"}
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
    btn.Size = UDim2.new(0, 80, 1, -5)
    btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner",btn).CornerRadius = UDim.new(0,16)
    ApplyToggleGradient(btn, false) CreateBorder(btn) CreateButtonText(btn, tab, Enum.Font.GothamBold, 10) ApplyButtonAnimation(btn)

    local content = Instance.new("ScrollingFrame",MainFrame)
    content.Size = UDim2.new(1,-10,1,-95) content.Position = UDim2.new(0,5,0,85) content.BackgroundTransparency = 1 content.ScrollBarThickness = 5 content.Visible = false content.BorderSizePixel = 0

    local list = Instance.new("UIListLayout",content) list.Padding = UDim.new(0,8) list.SortOrder = Enum.SortOrder.LayoutOrder
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() content.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15) end)

    local pad = Instance.new("UIPadding",content) pad.PaddingLeft = UDim.new(0,5) pad.PaddingTop = UDim.new(0,5)

    ContentFrames[tab] = {Frame=content}
    btn.MouseButton1Click:Connect(function() for _,f in pairs(ContentFrames)do f.Frame.Visible=false end content.Visible=true end)
end
ContentFrames["ESP"].Frame.Visible=true

function AddButton(tab, name, cb)
    local content = ContentFrames[tab].Frame
    local btn = Instance.new("TextButton", content) btn.Size = UDim2.new(1, -16, 0, 36) btn.Text = "" btn.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20) ApplyToggleGradient(btn, false) CreateBorder(btn) local txt = CreateButtonText(btn, name, Enum.Font.GothamBold, 13) ApplyButtonAnimation(btn)
    btn.MouseButton1Click:Connect(function() if cb then cb() end end) return btn
end

function AddAdjust(tab,name,key,step,minV,maxV,cb)
    local content = ContentFrames[tab].Frame
    local frame = Instance.new("Frame",content) frame.Size = UDim2.new(1,-16,0,36) frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel",frame) label.Size = UDim2.new(0.55,0,1,0) label.Position = UDim2.new(0.2,0,0,0) label.BackgroundTransparency = 1 label.Text = name..": ".._G.Config[key] label.Font = Enum.Font.GothamBold label.TextSize = 14 CreateTextGradient(label)
    if not AdjustLabels[key] then AdjustLabels[key] = {} end table.insert(AdjustLabels[key], {Label = label, Name = name})
    local minVal = minV or step local maxVal = maxV or 9999
    local minus = Instance.new("TextButton",frame) minus.Size = UDim2.new(0.2,-5,1,0) minus.Text = "" minus.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner",minus).CornerRadius = UDim.new(0,20) ApplyToggleGradient(minus, false) CreateBorder(minus) CreateButtonText(minus, "-", Enum.Font.GothamBold, 18) ApplyButtonAnimation(minus)
    minus.MouseButton1Click:Connect(function() _G.Config[key] = math.clamp(_G.Config[key]-step, minVal, maxVal) for _, lblData in ipairs(AdjustLabels[key]) do lblData.Label.Text = lblData.Name..": ".._G.Config[key] end if cb then cb() end end)
    local plus = Instance.new("TextButton",frame) plus.Size = UDim2.new(0.2,-5,1,0) plus.Position = UDim2.new(0.8,5,0,0) plus.Text = "" plus.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner",plus).CornerRadius = UDim.new(0,20) ApplyToggleGradient(plus, false) CreateBorder(plus) CreateButtonText(plus, "+", Enum.Font.GothamBold, 16) ApplyButtonAnimation(plus)
    plus.MouseButton1Click:Connect(function() _G.Config[key] = math.clamp(_G.Config[key]+step, minVal, maxVal) for _, lblData in ipairs(AdjustLabels[key]) do lblData.Label.Text = lblData.Name..": ".._G.Config[key] end if cb then cb() end end)
end

local espTab = ContentFrames["ESP"].Frame
local espGrid = Instance.new("Frame", espTab)
espGrid.Size = UDim2.new(1, -16, 0, 0)
espGrid.BackgroundTransparency = 1
local espLayout = Instance.new("UIGridLayout", espGrid)
espLayout.CellSize = UDim2.new(0.48, 0, 0, 36)
espLayout.CellPadding = UDim2.new(0.04, 0, 0, 8)
espLayout.SortOrder = Enum.SortOrder.LayoutOrder
espLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    espGrid.Size = UDim2.new(1, -16, 0, espLayout.AbsoluteContentSize.Y)
end)

function AddGridToggle(parent, name, key, cb)
    local btn = Instance.new("TextButton", parent)
    btn.BackgroundColor3 = Color3.new(1,1,1)
    btn.Text = ""
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,20)
    ApplyToggleGradient(btn, _G.Config[key])
    CreateBorder(btn)
    local btnTxt = CreateButtonText(btn, name..": "..(_G.Config[key] and "ON" or "OFF"), Enum.Font.GothamBold, 11)
    ApplyButtonAnimation(btn)
    ToggleButtons[key] = {Btn = btn, Txt = btnTxt, Name = name}
    btn.MouseButton1Click:Connect(function()
        _G.Config[key] = not _G.Config[key]
        btnTxt.Text = name..": "..(_G.Config[key] and "ON" or "OFF")
        ApplyToggleGradient(btn, _G.Config[key])
        if cb then cb(_G.Config[key]) end
    end)
end

AddGridToggle(espGrid, "NAME", "ESP_Name_P")
AddGridToggle(espGrid, "HEALTH", "ESP_Health_P")
AddGridToggle(espGrid, "DISTANCE", "ESP_Distance_P")
AddGridToggle(espGrid, "BOX 2D", "ESP_Box_P")
AddGridToggle(espGrid, "CHAMS", "ESP_Chams_P")
AddGridToggle(espGrid, "PVP ESP", "ESP_PVP")

function AddToggle(tab,name,key,cb)
    local content = ContentFrames[tab].Frame
    local btn = Instance.new("TextButton",content) btn.Size = UDim2.new(1,-16,0,36) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner",btn).CornerRadius = UDim.new(0,20)
    ApplyToggleGradient(btn, _G.Config[key]) CreateBorder(btn) local btnTxt = CreateButtonText(btn, name..": "..(_G.Config[key]and"ON"or"OFF"), Enum.Font.GothamBold, 14) ApplyButtonAnimation(btn)
    ToggleButtons[key] = {Btn = btn, Txt = btnTxt, Name = name}
    btn.MouseButton1Click:Connect(function() _G.Config[key] = not _G.Config[key] btnTxt.Text = name..": "..(_G.Config[key]and"ON"or"OFF") ApplyToggleGradient(btn, _G.Config[key]) if cb then cb(_G.Config[key])end end)
end

AddToggle("Hitbox","HITBOX PLAYER","Hitbox_P")
AddAdjust("Hitbox","HITBOX SIZE","HitboxSize",10)
AddToggle("Hitbox","SHOW HITBOX BOX 3D","Hitbox_Box")
AddToggle("Hitbox","ESP 2D BASED HITBOX","ESP_2D_Hitbox")
AddToggle("Hitbox","HITBOX WALL CHECK","Hitbox_WallCheck")

local MiscContent = ContentFrames["Misc"].Frame
local miscGrid = Instance.new("Frame", MiscContent)
miscGrid.Size = UDim2.new(1, -16, 0, 0)
miscGrid.BackgroundTransparency = 1
local miscLayout = Instance.new("UIGridLayout", miscGrid)
miscLayout.CellSize = UDim2.new(0.48, 0, 0, 36)
miscLayout.CellPadding = UDim2.new(0.04, 0, 0, 8)
miscLayout.SortOrder = Enum.SortOrder.LayoutOrder
miscLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    miscGrid.Size = UDim2.new(1, -16, 0, miscLayout.AbsoluteContentSize.Y)
end)

AddGridToggle(miscGrid, "TEAM CHECK", "TeamCheck")
AddGridToggle(miscGrid, "PVP CHECK", "PVPCheck")
AddGridToggle(miscGrid, "LOW HP KS", "LowHP_KS")
AddGridToggle(miscGrid, "SHOW FPS/PING", "Show_Stats", function(val) StatsFrame.Visible = val end)

local WSContainer = Instance.new("Frame", MiscContent)
WSContainer.Size = UDim2.new(1, 0, 0, 115)
WSContainer.BackgroundTransparency = 1
local WSToggle = Instance.new("TextButton", WSContainer)
WSToggle.Size = UDim2.new(1, -16, 0, 36)
WSToggle.Text = "" WSToggle.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", WSToggle).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(WSToggle, _G.WalkSpeedEnabled)
CreateBorder(WSToggle)
local WSToggleTxt = CreateButtonText(WSToggle, "WALKSPEED: " .. (_G.WalkSpeedEnabled and "ON" or "OFF"), Enum.Font.GothamBold, 14)
ApplyButtonAnimation(WSToggle)
local WSSliderBg = Instance.new("Frame", WSContainer)
WSSliderBg.Size = UDim2.new(1, -16, 0, 25)
WSSliderBg.Position = UDim2.new(0, 0, 0, 48)
WSSliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", WSSliderBg).CornerRadius = UDim.new(0, 20)
local WSSliderFill = Instance.new("Frame", WSSliderBg)
WSSliderFill.Size = UDim2.new((_G.WalkSpeed - 16) / (1000 - 16), 0, 1, 0)
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
WSBtnFrame.Size = UDim2.new(1, -16, 0, 32)
WSBtnFrame.Position = UDim2.new(0, 0, 0, 82)
WSBtnFrame.BackgroundTransparency = 1

local btnW = 0.22 local gap = 0.04
function createWSBtn(text, posScale)
    local btn = Instance.new("TextButton", WSBtnFrame) btn.Size = UDim2.new(btnW, 0, 1, 0) btn.Position = UDim2.new(posScale, 0, 0, 0) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20) ApplyToggleGradient(btn, false) CreateBorder(btn) CreateButtonText(btn, text, Enum.Font.GothamBold, 14) ApplyButtonAnimation(btn) return btn
end
local m10 = createWSBtn("-10", 0) local m5 = createWSBtn("-5", btnW + gap) local p5 = createWSBtn("+5", (btnW + gap) * 2) local p10 = createWSBtn("+10", (btnW + gap) * 3)

function UpdateWS(val)
    _G.WalkSpeed = math.clamp(val, 16, 1000)
    local ratio = (_G.WalkSpeed - 16) / (1000 - 16)
    WSSliderFill.Size = UDim2.new(ratio, 0, 1, 0)
    WSValLabel.Text = "Speed: " .. math.floor(_G.WalkSpeed)
end

m10.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed - 10) end)
m5.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed - 5) end)
p5.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed + 5) end)
p10.MouseButton1Click:Connect(function() UpdateWS(_G.WalkSpeed + 10) end)

WSToggle.MouseButton1Click:Connect(function()
    _G.WalkSpeedEnabled = not _G.WalkSpeedEnabled
    WSToggleTxt.Text = "WALKSPEED: " .. (_G.WalkSpeedEnabled and "ON" or "OFF")
    ApplyToggleGradient(WSToggle, _G.WalkSpeedEnabled)
end)

local draggingWS = false
WSSliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWS = true end end)
WSSliderBg.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingWS = false end end)
UserInputService.InputChanged:Connect(function(input)
    if draggingWS and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = math.clamp((input.Position.X - WSSliderBg.AbsolutePosition.X) / WSSliderBg.AbsoluteSize.X, 0, 1)
        UpdateWS(16 + relX * (1000 - 16))
    end
end)

local blackRedColors = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) })
local cyanPinkColors = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200)) })

local saFloatGui = Instance.new("ScreenGui", CoreGui)
saFloatGui.Name = "ArisSAFloatToggle"
saFloatGui.ResetOnSpawn = false
saFloatGui.DisplayOrder = 1000
saFloatGui.Enabled = _G.Config.SilentAim_ShowFloat

local saFloatBtn = Instance.new("TextButton", saFloatGui)
saFloatBtn.Size = UDim2.new(0, 98, 0, 30)
saFloatBtn.AnchorPoint = Vector2.new(0.5, 0.5)
saFloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
saFloatBtn.Text = ""
saFloatBtn.AutoButtonColor = false
saFloatBtn.Active = false
saFloatBtn.Draggable = false
Instance.new("UICorner", saFloatBtn).CornerRadius = UDim.new(1, 0)
ApplyButtonAnimation(saFloatBtn)

local saBtnGradient = Instance.new("UIGradient", saFloatBtn)
saBtnGradient.Color = cyanPinkColors
saBtnGradient.Enabled = false

local saFloatStroke = Instance.new("UIStroke", saFloatBtn)
saFloatStroke.Thickness = 2.5
saFloatStroke.Color = Color3.fromRGB(255, 255, 255)
saFloatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local saStrokeGradient = Instance.new("UIGradient", saFloatStroke)
saStrokeGradient.Color = blackRedColors

local saFloatText = Instance.new("TextLabel", saFloatBtn)
saFloatText.Size = UDim2.new(1, 0, 1, 0)
saFloatText.BackgroundTransparency = 1
saFloatText.Text = "Silent Aim : OFF"
saFloatText.TextColor3 = Color3.fromRGB(255, 255, 255)
saFloatText.TextSize = 11
saFloatText.Font = Enum.Font.GothamBold
local saTextGradient = Instance.new("UIGradient", saFloatText)
saTextGradient.Color = cyanPinkColors
saTextGradient.Enabled = true

function UpdateSAFloatPosition()
    saFloatBtn.Position = UDim2.new(_G.Config.SilentAim_FloatX / 100, 0, _G.Config.SilentAim_FloatY / 100, 0)
end
UpdateSAFloatPosition()

function RefreshSAFloatBtn()
    if _G.Config.SilentAim then
        saFloatText.Text = "Silent Aim : ON"
        saBtnGradient.Enabled = true
        saFloatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        saTextGradient.Enabled = false
        saFloatText.TextColor3 = Color3.fromRGB(0, 0, 0)
    else
        saFloatText.Text = "Silent Aim : OFF"
        saBtnGradient.Enabled = false
        saFloatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        saTextGradient.Enabled = true
        saFloatText.TextColor3 = Color3.fromRGB(255, 255, 255)
    end

    local saMainBtn = ToggleButtons["SilentAim"]
    if saMainBtn then
        saMainBtn.Txt.Text = "SILENT AIM: " .. (_G.Config.SilentAim and "ON" or "OFF")
        ApplyToggleGradient(saMainBtn.Btn, _G.Config.SilentAim)
    end
end

saFloatBtn.MouseButton1Click:Connect(function()
    _G.Config.SilentAim = not _G.Config.SilentAim
    RefreshSAFloatBtn()
    local ts = game:GetService("TweenService")
    ts:Create(saFloatBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 90, 0, 26)}):Play()
    task.wait(0.1)
    ts:Create(saFloatBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 98, 0, 30)}):Play()
end)

local NullContent = ContentFrames["Combat"].Frame

local nullGrid = Instance.new("Frame", NullContent)
nullGrid.Size = UDim2.new(1, -16, 0, 0)
nullGrid.BackgroundTransparency = 1
local nullLayout = Instance.new("UIGridLayout", nullGrid)
nullLayout.CellSize = UDim2.new(0.48, 0, 0, 36)
nullLayout.CellPadding = UDim2.new(0.04, 0, 0, 8)
nullLayout.SortOrder = Enum.SortOrder.LayoutOrder
nullLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    nullGrid.Size = UDim2.new(1, -16, 0, nullLayout.AbsoluteContentSize.Y)
end)

AddGridToggle(nullGrid, "SILENT AIM", "SilentAim", RefreshSAFloatBtn)
AddGridToggle(nullGrid, "360Â° AIMBOT", "SilentAim_Nearest")
AddGridToggle(nullGrid, "AIMBOT NPC", "SilentAim_NPC")
AddGridToggle(nullGrid, "SA FLOAT", "SilentAim_ShowFloat", function(v) saFloatGui.Enabled = v end)
AddGridToggle(nullGrid, "FAST ATTACK", "FastM1")
AddGridToggle(nullGrid, "AUTO VECTOR", "AutoChangeVector")
AddGridToggle(nullGrid, "INFINITE JUMP", "InfJump")
AddGridToggle(nullGrid, "WATER WALK", "WalkOnWater")

local FOVContainer = Instance.new("Frame", NullContent)
FOVContainer.Size = UDim2.new(1, -16, 0, 80)
FOVContainer.BackgroundTransparency = 1

local FOVSliderBg = Instance.new("Frame", FOVContainer)
FOVSliderBg.Size = UDim2.new(1, 0, 0, 25)
FOVSliderBg.Position = UDim2.new(0, 0, 0, 5)
FOVSliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", FOVSliderBg).CornerRadius = UDim.new(0, 20)

local maxFOV = 1000
local minFOV = 10

local FOVSliderFill = Instance.new("Frame", FOVSliderBg)
FOVSliderFill.Size = UDim2.new((_G.Config.FOV_Radius - minFOV) / (maxFOV - minFOV), 0, 1, 0)
FOVSliderFill.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", FOVSliderFill).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(FOVSliderFill, true)

local FOVValLabel = Instance.new("TextLabel", FOVSliderBg)
FOVValLabel.Size = UDim2.new(1, 0, 1, 0)
FOVValLabel.BackgroundTransparency = 1
FOVValLabel.Text = "FOV Radius: " .. math.floor(_G.Config.FOV_Radius)
FOVValLabel.Font = Enum.Font.GothamBold
FOVValLabel.TextSize = 12
CreateTextGradient(FOVValLabel)

local FOVBtnFrame = Instance.new("Frame", FOVContainer)
FOVBtnFrame.Size = UDim2.new(1, 0, 0, 32)
FOVBtnFrame.Position = UDim2.new(0, 0, 0, 38)
FOVBtnFrame.BackgroundTransparency = 1

local fovBtnW = 0.22
local fovGap = 0.04
function createFOVBtn(text, posScale)
    local btn = Instance.new("TextButton", FOVBtnFrame)
    btn.Size = UDim2.new(fovBtnW, 0, 1, 0)
    btn.Position = UDim2.new(posScale, 0, 0, 0)
    btn.Text = ""
    btn.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(btn, false)
    CreateBorder(btn)
    CreateButtonText(btn, text, Enum.Font.GothamBold, 14)
    ApplyButtonAnimation(btn)
    return btn
end

local fm100 = createFOVBtn("-100", 0)
local fm10 = createFOVBtn("-10", fovBtnW + fovGap)
local fp10 = createFOVBtn("+10", (fovBtnW + fovGap) * 2)
local fp100 = createFOVBtn("+100", (fovBtnW + fovGap) * 3)

function UpdateFOV(val)
    _G.Config.FOV_Radius = math.clamp(val, minFOV, maxFOV)
    local ratio = (_G.Config.FOV_Radius - minFOV) / (maxFOV - minFOV)
    FOVSliderFill.Size = UDim2.new(ratio, 0, 1, 0)
    FOVValLabel.Text = "FOV Radius: " .. math.floor(_G.Config.FOV_Radius)
end

fm100.MouseButton1Click:Connect(function() UpdateFOV(_G.Config.FOV_Radius - 100) end)
fm10.MouseButton1Click:Connect(function() UpdateFOV(_G.Config.FOV_Radius - 10) end)
fp10.MouseButton1Click:Connect(function() UpdateFOV(_G.Config.FOV_Radius + 10) end)
fp100.MouseButton1Click:Connect(function() UpdateFOV(_G.Config.FOV_Radius + 100) end)

local draggingFOV = false
FOVSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFOV = true end
end)
FOVSliderBg.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFOV = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if draggingFOV and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local relX = math.clamp((input.Position.X - FOVSliderBg.AbsolutePosition.X) / FOVSliderBg.AbsoluteSize.X, 0, 1)
        UpdateFOV(minFOV + relX * (maxFOV - minFOV))
    end
end)

AddAdjust("Combat", "FLOAT POS X (%)", "SilentAim_FloatX", 5, 0, 100, UpdateSAFloatPosition)
AddAdjust("Combat", "FLOAT POS Y (%)", "SilentAim_FloatY", 5, 0, 100, UpdateSAFloatPosition)
-- [[ UI M1 DELAY ]] --
    _G.Config.FastM1_Delay = 0 -- Mặc định là 0s (nhanh nhất)
    
    local M1DelayContainer = Instance.new("Frame", NullContent)
    M1DelayContainer.Size = UDim2.new(1, -16, 0, 80)
    M1DelayContainer.BackgroundTransparency = 1
    M1DelayContainer.LayoutOrder = 10
    
    local M1SliderBg = Instance.new("Frame", M1DelayContainer)
    M1SliderBg.Size = UDim2.new(1, 0, 0, 25)
    M1SliderBg.Position = UDim2.new(0, 0, 0, 5)
    M1SliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", M1SliderBg).CornerRadius = UDim.new(0, 20)
    
    local maxM1 = 1.0 -- Tối đa 1 giây
    local minM1 = 0.0
    
    local M1SliderFill = Instance.new("Frame", M1SliderBg)
    M1SliderFill.Size = UDim2.new((_G.Config.FastM1_Delay - minM1) / (maxM1 - minM1), 0, 1, 0)
    M1SliderFill.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", M1SliderFill).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(M1SliderFill, true)
    
    local M1ValLabel = Instance.new("TextLabel", M1SliderBg)
    M1ValLabel.Size = UDim2.new(1, 0, 1, 0)
    M1ValLabel.BackgroundTransparency = 1
    M1ValLabel.Text = "M1 Delay: " .. string.format("%.2f", _G.Config.FastM1_Delay) .. "s"
    M1ValLabel.Font = Enum.Font.GothamBold
    M1ValLabel.TextSize = 12
    CreateTextGradient(M1ValLabel)
    
    local M1BtnFrame = Instance.new("Frame", M1DelayContainer)
    M1BtnFrame.Size = UDim2.new(1, 0, 0, 32)
    M1BtnFrame.Position = UDim2.new(0, 0, 0, 38)
    M1BtnFrame.BackgroundTransparency = 1
    
    local m1BtnW = 0.22
    local m1Gap = 0.04
    function createM1Btn(text, posScale)
        local btn = Instance.new("TextButton", M1BtnFrame) btn.Size = UDim2.new(m1BtnW, 0, 1, 0) btn.Position = UDim2.new(posScale, 0, 0, 0) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20) ApplyToggleGradient(btn, false) CreateBorder(btn) CreateButtonText(btn, text, Enum.Font.GothamBold, 14) ApplyButtonAnimation(btn) return btn
    end
    
    local mm10 = createM1Btn("0s", 0) local mm01 = createM1Btn("-0.05", m1BtnW + m1Gap) local mp01 = createM1Btn("+0.05", (m1BtnW + m1Gap) * 2) local mp10 = createM1Btn("+0.1", (m1BtnW + m1Gap) * 3)
    
    function UpdateM1Delay(val)
        _G.Config.FastM1_Delay = math.clamp(val, minM1, maxM1)
        local ratio = (_G.Config.FastM1_Delay - minM1) / (maxM1 - minM1)
        M1SliderFill.Size = UDim2.new(ratio, 0, 1, 0)
        M1ValLabel.Text = "M1 Delay: " .. string.format("%.2f", _G.Config.FastM1_Delay) .. "s"
    end
    
    mm10.MouseButton1Click:Connect(function() UpdateM1Delay(0) end)
    mm01.MouseButton1Click:Connect(function() UpdateM1Delay(_G.Config.FastM1_Delay - 0.05) end)
    mp01.MouseButton1Click:Connect(function() UpdateM1Delay(_G.Config.FastM1_Delay + 0.05) end)
    mp10.MouseButton1Click:Connect(function() UpdateM1Delay(_G.Config.FastM1_Delay + 0.1) end)
    
    local draggingM1 = false
    M1SliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingM1 = true end end)
    M1SliderBg.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingM1 = false end end)
    UserInputService.InputChanged:Connect(function(input) if draggingM1 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local relX = math.clamp((input.Position.X - M1SliderBg.AbsolutePosition.X) / M1SliderBg.AbsoluteSize.X, 0, 1) UpdateM1Delay(minM1 + relX * (maxM1 - minM1)) end end)
AddToggle("NPC","HITBOX NPC","Hitbox_NPC")
AddAdjust("NPC","HITBOX SIZE NPC","HitboxSize_NPC",10)
AddToggle("NPC","SHOW HITBOX BOX 3D","Hitbox_Box_NPC")
AddToggle("NPC","ESP NPC NAME","ESP_NPC_Name")
AddToggle("NPC","ESP NPC BOX 2D","ESP_NPC_Box")
AddToggle("NPC","ESP NPC CHAMS","ESP_NPC_Chams")

local RefreshFloatBtn = nil

local desyncTab = ContentFrames["Desync"].Frame
local ModeFrame = Instance.new("Frame", desyncTab) ModeFrame.Size = UDim2.new(1, -16, 0, 36) ModeFrame.BackgroundTransparency = 1
local modeLabel = Instance.new("TextLabel", ModeFrame) modeLabel.Size = UDim2.new(0.2, 0, 1, 0) modeLabel.BackgroundTransparency = 1 modeLabel.Text = "MODE:" modeLabel.Font = Enum.Font.GothamBold modeLabel.TextSize = 13 CreateTextGradient(modeLabel)

function createModeBtn(text, posScale, modeStr)
    local btn = Instance.new("TextButton", ModeFrame) btn.Size = UDim2.new(0.25, 0, 1, 0) btn.Position = UDim2.new(posScale, 0, 0, 0) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16) CreateBorder(btn) local txt = CreateButtonText(btn, text, Enum.Font.GothamBold, 12) ApplyButtonAnimation(btn)
    function UpdateState() ApplyToggleGradient(btn, _G.Config.Desync_Mode == modeStr) end UpdateState()
    btn.MouseButton1Click:Connect(function()
        if desyncState then AddNotify({Title="WARNING",Description="Please turn OFF Desync before changing mode!",Duration=2}) return end
        _G.Config.Desync_Mode = modeStr
        for _, child in ipairs(ModeFrame:GetChildren()) do if child:IsA("TextButton") then ApplyToggleGradient(child, child:GetAttribute("ModeStr") == _G.Config.Desync_Mode) end end
        if RefreshFloatBtn then RefreshFloatBtn() end
    end)
    btn:SetAttribute("ModeStr", modeStr) return btn
end
createModeBtn("Normal", 0.22, "Normal") createModeBtn("Fast", 0.49, "Fast") createModeBtn("Fix", 0.76, "Fix")

local floatGui = Instance.new("ScreenGui", CoreGui) floatGui.Name = "ArisFloatToggle" floatGui.ResetOnSpawn = false floatGui.DisplayOrder = 1000 floatGui.Enabled = _G.Config.Desync_ShowFloat
local floatBtn = Instance.new("TextButton", floatGui) floatBtn.Size = UDim2.new(0, 98, 0, 30)
floatBtn.AnchorPoint = Vector2.new(0.5, 0.5) floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) floatBtn.Text = "" floatBtn.AutoButtonColor = false floatBtn.Active = false floatBtn.Draggable = false Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1, 0) ApplyButtonAnimation(floatBtn)
local btnGradient = Instance.new("UIGradient", floatBtn) btnGradient.Color = cyanPinkColors btnGradient.Enabled = false
local floatStroke = Instance.new("UIStroke", floatBtn) floatStroke.Thickness = 2.5 floatStroke.Color = Color3.fromRGB(255, 255, 255) floatStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local strokeGradient = Instance.new("UIGradient", floatStroke) strokeGradient.Color = blackRedColors
local floatText = Instance.new("TextLabel", floatBtn) floatText.Size = UDim2.new(1, 0, 1, 0) floatText.BackgroundTransparency = 1 floatText.Text = "DeSync : OFF" floatText.TextColor3 = Color3.fromRGB(255, 255, 255) floatText.TextSize = 11 floatText.Font = Enum.Font.GothamBold
local textGradient = Instance.new("UIGradient", floatText) textGradient.Color = cyanPinkColors textGradient.Enabled = true

function UpdateFloatPosition() floatBtn.Position = UDim2.new(_G.Config.Desync_FloatX / 100, 0, _G.Config.Desync_FloatY / 100, 0) end UpdateFloatPosition()

local RefreshFloatBtn = function()
    if _G.Config.Desync_Mode == "Fix" and _G.Config.Desync_HideAuto then
        floatText.Text = "N/A âš ï¸" btnGradient.Enabled = false textGradient.Enabled = false strokeGradient.Enabled = false floatBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40) floatText.TextColor3 = Color3.fromRGB(200, 200, 200) floatStroke.Color = Color3.fromRGB(100, 100, 100) return
    end
    strokeGradient.Enabled = true floatStroke.Color = Color3.fromRGB(255, 255, 255)
    if desyncState then floatText.Text = "DeSync : ON" btnGradient.Enabled = true floatBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) textGradient.Enabled = false floatText.TextColor3 = Color3.fromRGB(0, 0, 0) else floatText.Text = "DeSync : OFF" btnGradient.Enabled = false floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) textGradient.Enabled = true floatText.TextColor3 = Color3.fromRGB(255, 255, 255) end
end

floatBtn.MouseButton1Click:Connect(function()
    local isAdminInServer = CheckAdmin()
    if isAdminInServer and LocalPlayer.UserId ~= adminUserId then
        AddNotify({Title="SYSTEM ALERT",Description="Desync creator is here, all desync functions are disabled.",Duration=5})
        return
    end

    if _G.Config.Desync_Mode == "Fix" and _G.Config.Desync_HideAuto then return end
    desyncState = not desyncState RefreshFloatBtn()
    local ts = game:GetService("TweenService") ts:Create(floatBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 90, 0, 26)}):Play() task.wait(0.1) ts:Create(floatBtn, TweenInfo.new(0.1), {Size = UDim2.new(0, 98, 0, 30)}):Play()
    if desyncState then
        if _G.Config.Desync_Mode == "Fix" then DoFixDesync(_G.Config.Desync_HideAuto)
        elseif _G.Config.Desync_Mode == "Fast" then DoFastDesync()
        else ActivateDesyncNormal() end
    else
        SetFast(false) SetNormal(false) SetFixV2_Logic(false) HideDesyncMarker()
    end
end)

AddToggle("Desync", "GHOST MODE (ðŸ‘»)", "Desync_HideAuto", function() if RefreshFloatBtn then RefreshFloatBtn() end end)
AddToggle("Desync", "SHOW DESYNC FLOAT BTN", "Desync_ShowFloat", function(v) floatGui.Enabled = v end)
AddAdjust("Desync", "POS X (%)", "Desync_FloatX", 5, 0, 100, UpdateFloatPosition)
AddAdjust("Desync", "POS Y (%)", "Desync_FloatY", 5, 0, 100, UpdateFloatPosition)

local ESP_Store={} local NPC_Store={}

function CheckAndCacheNPC(obj)
    if obj:IsA("Model") and obj ~= LocalPlayer.Character and not Players:GetPlayerFromCharacter(obj) then
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then CachedNPCs[obj] = true end
    end
end
for _, v in ipairs(Workspace:GetDescendants()) do CheckAndCacheNPC(v) end
Workspace.DescendantAdded:Connect(function(descendant) task.delay(1, function() if descendant.Parent then CheckAndCacheNPC(descendant) end end) end)

function CleanupHitboxAttributes(hrp)
    if hrp and hrp:GetAttribute("ArisHitboxActive") then hrp:SetAttribute("ArisHitboxActive", nil) hrp.Transparency = 1 hrp.CanCollide = true end
end

function CleanupHitboxAttributesNPC(hrp)
    if hrp and hrp:GetAttribute("ArisHitboxActiveNPC") then hrp:SetAttribute("ArisHitboxActiveNPC", nil) hrp.Transparency = 1 hrp.CanCollide = true end
end

function GetHealthColor(pct)
    if pct>0.7 then return Color3.new(0,1,0) elseif pct>0.5 then return Color3.new(1,1,0) elseif pct>0.3 then return Color3.new(1,0.5,0) else return Color3.new(1,0,0) end
end

function CleanupESP(playerName)
    if ESP_Store[playerName]then pcall(function() if ESP_Store[playerName].BoxBill then ESP_Store[playerName].BoxBill:Destroy() end; if ESP_Store[playerName].TextBill then ESP_Store[playerName].TextBill:Destroy() end end) ESP_Store[playerName]=nil end
    local p = Players:FindFirstChild(playerName)
    if p and p.Character then
        if p.Character:FindFirstChild("ArisHL") then p.Character.ArisHL:Destroy() end
        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
        if hrp then if hrp:FindFirstChild("ArisHitboxBox") then hrp.ArisHitboxBox:Destroy() end CleanupHitboxAttributes(hrp) end
    end
end

function CleanupNPC(m)
    if NPC_Store[m]then pcall(function() if NPC_Store[m].Bill then NPC_Store[m].Bill:Destroy() end if NPC_Store[m].BoxBill then NPC_Store[m].BoxBill:Destroy() end end); NPC_Store[m]=nil end
    if m then
        if m:FindFirstChild("ArisHL_NPC") then m.ArisHL_NPC:Destroy() end
        local hrp = m:FindFirstChild("HumanoidRootPart")
        if hrp then if hrp:FindFirstChild("ArisHitboxBoxNPC") then hrp.ArisHitboxBoxNPC:Destroy() end CleanupHitboxAttributesNPC(hrp) end
    end
end

Workspace.DescendantRemoving:Connect(function(descendant) if CachedNPCs[descendant] then CachedNPCs[descendant] = nil; CleanupNPC(descendant) end end)

function toggleNoclip(active)
    if active then
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, v in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then
                            v.CanCollide = false
                        end
                    end
                end
            end)
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end

local isFarming = false
local lastTargetPos = nil
local currentTargetId = nil

function doMagnetLoop()
    if isFarming then return end isFarming = true
    task.spawn(function()
        while _G.Config.TP_NPC or _G.Config.TP_Player do
            if _G.IsFleeing or _G.IsReturning or _G.IsForcedDropping then
                task.wait(0.1)
                continue
            end

            local char = LocalPlayer.Character local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            if myRoot then
                local keepCurrentTarget = false
                if currentTarget and currentTarget.Parent then
                    local hum = currentTarget.Parent:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 then
                        if _G.Config.TP_Player then
                            local p = Players:GetPlayerFromCharacter(currentTarget.Parent)
                            if p and not TempSkipPlayer[p.Name] then
                                local validToKeep = true
                                if _G.Config.PVPCheck then
                                    local isPvpOn = GetTrueStatus(p)
                                    if not isPvpOn then validToKeep = false end
                                end

                                if validToKeep then
                                    if _G.Config.SelectedTargetPlayer and _G.Config.SelectedTargetPlayer ~= "" then
                                        if p.Name == _G.Config.SelectedTargetPlayer then keepCurrentTarget = true end
                                    else
                                        keepCurrentTarget = true
                                    end
                                end
                            end
                        elseif _G.Config.TP_NPC then
                            if not TempSkipNPC[currentTarget.Parent] and not _G.Config.BlacklistedNPCs[currentTarget.Parent.Name] then
                                if _G.Config.SelectedTargetNPC and _G.Config.SelectedTargetNPC ~= "" then
                                    if currentTarget.Parent.Name == _G.Config.SelectedTargetNPC then keepCurrentTarget = true end
                                else
                                    keepCurrentTarget = true
                                end
                            end
                        end
                    end
                end

                if not keepCurrentTarget then
                    local nearest = nil local shortestDist = 5000
                    if _G.Config.TP_NPC then
                        for npc, _ in pairs(CachedNPCs) do
                            if npc and npc.Parent then
                                if _G.Config.BlacklistedNPCs[npc.Name] or TempSkipNPC[npc] then continue end
                                if _G.Config.SelectedTargetNPC and _G.Config.SelectedTargetNPC ~= "" then
                                    if npc.Name ~= _G.Config.SelectedTargetNPC then continue end
                                end
                                local hum = npc:FindFirstChild("Humanoid") local root = npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChild("Hitbox") or npc:FindFirstChild("Torso") or npc:FindFirstChild("UpperTorso")
                                if hum and root and hum.Health > 0 and hum.MaxHealth > 0 and root:IsA("BasePart") then
                                    local dist = (myRoot.Position - root.Position).Magnitude if dist < shortestDist then shortestDist = dist nearest = root end
                                end
                            end
                        end
                    elseif _G.Config.TP_Player then
                        if _G.Config.SelectedTargetPlayer and _G.Config.SelectedTargetPlayer ~= "" then
                            local p = Players:FindFirstChild(_G.Config.SelectedTargetPlayer)
                            if p and p.Character and p ~= LocalPlayer and not TempSkipPlayer[p.Name] then
                                local isSameTeam = (LocalPlayer.Team ~= nil and p.Team == LocalPlayer.Team)
                                if not (_G.Config.TeamCheck and isSameTeam) then
                                    local passPVP = true
                                    if _G.Config.PVPCheck then
                                        local isPvpOn = GetTrueStatus(p)
                                        if not isPvpOn then passPVP = false end
                                    end
                                    if passPVP then
                                        local hum = p.Character:FindFirstChild("Humanoid")
                                        local root = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso")
                                        if hum and root and hum.Health > 0 and hum.MaxHealth > 0 and root:IsA("BasePart") then
                                            nearest = root
                                        end
                                    end
                                end
                            end
                        else
                            for _, p in ipairs(Players:GetPlayers()) do
                                if p ~= LocalPlayer and p.Character and not TempSkipPlayer[p.Name] then
                                    local isSameTeam = (LocalPlayer.Team ~= nil and p.Team == LocalPlayer.Team)
                                    if not (_G.Config.TeamCheck and isSameTeam) then
                                        local passPVP = true
                                        if _G.Config.PVPCheck then
                                            local isPvpOn = GetTrueStatus(p)
                                            if not isPvpOn then passPVP = false end
                                        end
                                        if passPVP then
                                            local hum = p.Character:FindFirstChild("Humanoid") local root = p.Character:FindFirstChild("HumanoidRootPart") or p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso")
                                            if hum and root and hum.Health > 0 and hum.MaxHealth > 0 and root:IsA("BasePart") then
                                                local dist = (myRoot.Position - root.Position).Magnitude if dist < shortestDist then shortestDist = dist nearest = root end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    currentTarget = nearest
                    if currentTween then currentTween:Cancel() end
                end

                if currentTarget then
                    if not noclipConnection then toggleNoclip(true) end

                    if currentTarget ~= currentTargetId then
                        lastTargetPos = currentTarget.Position
                        currentTargetId = currentTarget
                    end

                    local targetPos = CFrame.new(currentTarget.Position + Vector3.new(0, _G.Config.TP_Height, 0))

                    if _G.Config.Prediction_Enabled and currentTarget:IsA("BasePart") then
                        local vel = currentTarget.AssemblyLinearVelocity
                        targetPos = targetPos + (Vector3.new(vel.X, 0, vel.Z) * _G.Config.Prediction)
                    end

                    local currentTargetPos = currentTarget.Position
                    local targetTeleported = lastTargetPos and (currentTargetPos - lastTargetPos).Magnitude > 80
                    local isTargetHighInSky = currentTargetPos.Y > 30000

                    if targetTeleported or isTargetHighInSky then
                        if currentTween then currentTween:Cancel() end
                        myRoot.CFrame = targetPos
                    else
                        local dist = (myRoot.Position - targetPos.Position).Magnitude
                        if dist <= 100 then
                            stopTween()
                            myRoot.CFrame = targetPos
                        else
                            stopTween()
                            task.spawn(function()
                                tween(targetPos)
                            end)
                        end
                    end
                    lastTargetPos = currentTargetPos
                else
                    lastTargetPos = nil
                    currentTargetId = nil
                    if noclipConnection then toggleNoclip(false) end
                end
            end task.wait(0.1)
        end
        if noclipConnection then toggleNoclip(false) end isFarming = false
    end)
end

local tpNPCTab = ContentFrames["TP NPC"].Frame
local dualRowNPC = Instance.new("Frame", tpNPCTab)
dualRowNPC.Size = UDim2.new(1, -16, 0, 36)
dualRowNPC.BackgroundTransparency = 1

local tpSelNPCBtn = Instance.new("TextButton", dualRowNPC)
tpSelNPCBtn.Size = UDim2.new(0.48, 0, 1, 0)
tpSelNPCBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", tpSelNPCBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(tpSelNPCBtn, _G.Config.TP_NPC)
CreateBorder(tpSelNPCBtn)
local tpSelNPCTxt = CreateButtonText(tpSelNPCBtn, "ðŸŽ¯ ENABLE TP: OFF", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(tpSelNPCBtn)
ToggleButtons["TP_NPC"] = {Btn = tpSelNPCBtn, Txt = tpSelNPCTxt, Name = "ðŸŽ¯ ENABLE TP"}

tpSelNPCBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_NPC = not _G.Config.TP_NPC
    ApplyToggleGradient(tpSelNPCBtn, _G.Config.TP_NPC)
    tpSelNPCTxt.Text = "ðŸŽ¯ ENABLE TP: " .. (_G.Config.TP_NPC and "ON" or "OFF")
    if _G.Config.TP_NPC then
        _G.Config.TP_Player = false
        local b = ToggleButtons["TP_Player"]
        if b then b.Txt.Text = "ðŸŽ¯ ENABLE TP: OFF" ApplyToggleGradient(b.Btn, false) end
        doMagnetLoop()
    else
        TempSkipNPC = {}
        if not _G.Config.TP_NPC then currentTarget = nil if currentTween then currentTween:Cancel() end end
        AddNotify({Title="RESET",Description="Cleared skipped NPC list!",Duration=3})
    end
end)

local skipNPCBtn = Instance.new("TextButton", dualRowNPC)
skipNPCBtn.Size = UDim2.new(0.48, 0, 1, 0)
skipNPCBtn.Position = UDim2.new(0.52, 0, 0, 0)
skipNPCBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", skipNPCBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(skipNPCBtn, false)
CreateBorder(skipNPCBtn)
CreateButtonText(skipNPCBtn, "â­ï¸ SKIP NPC", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(skipNPCBtn)

skipNPCBtn.MouseButton1Click:Connect(function()
    if currentTarget and currentTarget.Parent then
        TempSkipNPC[currentTarget.Parent] = true
        currentTarget = nil
        if currentTween then currentTween:Cancel() end
        AddNotify({Title="SKIP NPC",Description="Temporarily skipped this NPC!",Duration=3})
    end
end)

AddAdjust("TP NPC", "HEIGHT (Y)", "TP_Height", 5)
AddAdjust("TP NPC", "FLY SPEED", "TP_Speed", 50)

local speed1kNPCFrame = Instance.new("Frame", tpNPCTab)
speed1kNPCFrame.Size = UDim2.new(1, -16, 0, 36)
speed1kNPCFrame.BackgroundTransparency = 1

local min1kNPCBtn = Instance.new("TextButton", speed1kNPCFrame)
min1kNPCBtn.Size = UDim2.new(0.32, 0, 1, 0)
min1kNPCBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", min1kNPCBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(min1kNPCBtn, false)
CreateBorder(min1kNPCBtn)
CreateButtonText(min1kNPCBtn, "-1000", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(min1kNPCBtn)
min1kNPCBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_Speed = math.clamp(_G.Config.TP_Speed - 1000, 50, 99999)
    for _, lblData in ipairs(AdjustLabels["TP_Speed"]) do lblData.Label.Text = lblData.Name..": ".._G.Config.TP_Speed end
end)

local set350NPCBtn = Instance.new("TextButton", speed1kNPCFrame)
set350NPCBtn.Size = UDim2.new(0.32, 0, 1, 0)
set350NPCBtn.Position = UDim2.new(0.34, 0, 0, 0)
set350NPCBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", set350NPCBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(set350NPCBtn, false)
CreateBorder(set350NPCBtn)
CreateButtonText(set350NPCBtn, "350 Speed", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(set350NPCBtn)
set350NPCBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_Speed = 350
    for _, lblData in ipairs(AdjustLabels["TP_Speed"]) do lblData.Label.Text = lblData.Name..": ".._G.Config.TP_Speed end
end)

local plus1kNPCBtn = Instance.new("TextButton", speed1kNPCFrame)
plus1kNPCBtn.Size = UDim2.new(0.32, 0, 1, 0)
plus1kNPCBtn.Position = UDim2.new(0.68, 0, 0, 0)
plus1kNPCBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", plus1kNPCBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(plus1kNPCBtn, false)
CreateBorder(plus1kNPCBtn)
CreateButtonText(plus1kNPCBtn, "+1000", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(plus1kNPCBtn)
plus1kNPCBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_Speed = math.clamp(_G.Config.TP_Speed + 1000, 50, 99999)
    for _, lblData in ipairs(AdjustLabels["TP_Speed"]) do lblData.Label.Text = lblData.Name..": ".._G.Config.TP_Speed end
end)

local SelectedNPCLabel = Instance.new("TextLabel", tpNPCTab)
SelectedNPCLabel.Size = UDim2.new(1, -16, 0, 25)
SelectedNPCLabel.BackgroundTransparency = 1
SelectedNPCLabel.Text = "Target: Auto (Nearest)"
SelectedNPCLabel.Font = Enum.Font.GothamBold
SelectedNPCLabel.TextSize = 13
CreateTextGradient(SelectedNPCLabel)

local NPCListContainer = Instance.new("Frame", tpNPCTab)
NPCListContainer.Size = UDim2.new(1, -16, 0, 0)
NPCListContainer.BackgroundTransparency = 1
local nListLayout = Instance.new("UIGridLayout", NPCListContainer)
nListLayout.CellSize = UDim2.new(0.48, 0, 0, 36)
nListLayout.CellPadding = UDim2.new(0.04, 0, 0, 8)
nListLayout.SortOrder = Enum.SortOrder.LayoutOrder
nListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    NPCListContainer.Size = UDim2.new(1, -16, 0, nListLayout.AbsoluteContentSize.Y)
end)

AddButton("TP NPC", "ðŸ”„ REFRESH NPC LIST", function()
    for _, child in ipairs(NPCListContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local count = 0
    local autoBtn = Instance.new("TextButton", NPCListContainer)
    autoBtn.Size = UDim2.new(1, 0, 0, 36)
    autoBtn.Text = ""
    autoBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(autoBtn, _G.Config.SelectedTargetNPC == nil)
    CreateBorder(autoBtn)
    local autoTxt = CreateButtonText(autoBtn, "ðŸŽ¯ Auto", Enum.Font.GothamBold, 12)
    ApplyButtonAnimation(autoBtn)

    autoBtn.MouseButton1Click:Connect(function()
        _G.Config.SelectedTargetNPC = nil
        SelectedNPCLabel.Text = "Target: Auto (Nearest)"
        for _, child in ipairs(NPCListContainer:GetChildren()) do
            if child:IsA("TextButton") then ApplyToggleGradient(child, false) end
        end
        ApplyToggleGradient(autoBtn, true)
    end)

    local uniqueNPCs = {}
    for npc, _ in pairs(CachedNPCs) do
        if npc and npc.Parent then uniqueNPCs[npc.Name] = true end
    end

    for npcName, _ in pairs(uniqueNPCs) do
        count = count + 1
        local btn = Instance.new("TextButton", NPCListContainer)
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.Text = ""
        btn.BackgroundColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)

        local isSelected = (_G.Config.SelectedTargetNPC == npcName)
        ApplyToggleGradient(btn, isSelected)
        CreateBorder(btn)

        local txt = CreateButtonText(btn, "ðŸ‘¹ " .. npcName, Enum.Font.GothamBold, 11)
        if isSelected then txt.TextColor3 = Color3.fromRGB(0,0,0) end
        ApplyButtonAnimation(btn)

        btn.MouseButton1Click:Connect(function()
            _G.Config.SelectedTargetNPC = npcName
            SelectedNPCLabel.Text = "Target: " .. npcName
            for _, child in ipairs(NPCListContainer:GetChildren()) do
                if child:IsA("TextButton") then ApplyToggleGradient(child, false) end
            end
            ApplyToggleGradient(btn, true)
            txt.TextColor3 = Color3.fromRGB(0,0,0)
        end)
    end
    AddNotify({Title="LIST REFRESHED",Description="Loaded ",Duration=3})
end)

local BlacklistContainer = Instance.new("Frame", tpNPCTab)
BlacklistContainer.Size = UDim2.new(1, -16, 0, 0)
BlacklistContainer.BackgroundTransparency = 1
local blLayout = Instance.new("UIGridLayout", BlacklistContainer)
blLayout.CellSize = UDim2.new(0.48, 0, 0, 36)
blLayout.CellPadding = UDim2.new(0.04, 0, 0, 8)
blLayout.SortOrder = Enum.SortOrder.LayoutOrder
blLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() BlacklistContainer.Size = UDim2.new(1, -16, 0, blLayout.AbsoluteContentSize.Y) end)
AddButton("TP NPC", "ðŸ”„ REFRESH BLACKLIST (1KM)", function()
    for _, child in ipairs(BlacklistContainer:GetChildren()) do if child:IsA("TextButton") then child:Destroy() end end
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if not myRoot then return end
    local foundNPCs = {} for npc, _ in pairs(CachedNPCs) do if npc and npc.Parent then local root = npc:FindFirstChild("HumanoidRootPart") if root and (root.Position - myRoot.Position).Magnitude <= 1000 then foundNPCs[npc.Name] = true end end end
    local count = 0
    for npcName, _ in pairs(foundNPCs) do
        count = count + 1 local btn = Instance.new("TextButton", BlacklistContainer) btn.Size = UDim2.new(1, 0, 0, 36) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)
        local isBlacklisted = _G.Config.BlacklistedNPCs[npcName] or false ApplyToggleGradient(btn, isBlacklisted) CreateBorder(btn)
        local txt = CreateButtonText(btn, "ðŸš« BL: " .. npcName, Enum.Font.GothamBold, 11) if isBlacklisted then txt.TextColor3 = Color3.fromRGB(0,0,0) end ApplyButtonAnimation(btn)
        btn.MouseButton1Click:Connect(function() _G.Config.BlacklistedNPCs[npcName] = not _G.Config.BlacklistedNPCs[npcName] local state = _G.Config.BlacklistedNPCs[npcName] ApplyToggleGradient(btn, state) txt.TextColor3 = state and Color3.fromRGB(0,0,0) or Color3.new(1,1,1) end)
    end
    AddNotify({Title="NPC SEARCH",Description="Found ",Duration=3})
end)

local tpPlayerTab = ContentFrames["TP Player"].Frame

local dualRow = Instance.new("Frame", tpPlayerTab)
dualRow.Size = UDim2.new(1, -16, 0, 36)
dualRow.BackgroundTransparency = 1

local tpSelBtn = Instance.new("TextButton", dualRow)
tpSelBtn.Size = UDim2.new(0.48, 0, 1, 0)
tpSelBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", tpSelBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(tpSelBtn, _G.Config.TP_Player)
CreateBorder(tpSelBtn)
local tpSelTxt = CreateButtonText(tpSelBtn, "ðŸŽ¯ ENABLE TP: OFF", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(tpSelBtn)
ToggleButtons["TP_Player"] = {Btn = tpSelBtn, Txt = tpSelTxt, Name = "ðŸŽ¯ ENABLE TP"}

tpSelBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_Player = not _G.Config.TP_Player
    ApplyToggleGradient(tpSelBtn, _G.Config.TP_Player)
    tpSelTxt.Text = "ðŸŽ¯ ENABLE TP: " .. (_G.Config.TP_Player and "ON" or "OFF")
    if _G.Config.TP_Player then
        _G.Config.TP_NPC = false
        local b = ToggleButtons["TP_NPC"]
        if b then b.Txt.Text = "ðŸŽ¯ ENABLE TP: OFF" ApplyToggleGradient(b.Btn, false) end
        doMagnetLoop()
    else
        TempSkipPlayer = {}
        if not _G.Config.TP_Player then currentTarget = nil if currentTween then currentTween:Cancel() end end
        AddNotify({Title="RESET",Description="Cleared skipped Player list!",Duration=3})
    end
end)

local skipBtn = Instance.new("TextButton", dualRow)
skipBtn.Size = UDim2.new(0.48, 0, 1, 0)
skipBtn.Position = UDim2.new(0.52, 0, 0, 0)
skipBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", skipBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(skipBtn, false)
CreateBorder(skipBtn)
CreateButtonText(skipBtn, "â­ï¸ SKIP PLAYER", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(skipBtn)

skipBtn.MouseButton1Click:Connect(function()
    if currentTarget and currentTarget.Parent then
        local p = Players:GetPlayerFromCharacter(currentTarget.Parent)
        if p then
            TempSkipPlayer[p.Name] = true
            currentTarget = nil
            if currentTween then currentTween:Cancel() end
            AddNotify({Title="SKIP PLAYER",Description="Skipped: ",Duration=3})
        end
    end
end)

AddAdjust("TP Player", "HEIGHT (Y)", "TP_Height", 5)
AddAdjust("TP Player", "FLY SPEED", "TP_Speed", 50)

local speed1kFrame = Instance.new("Frame", tpPlayerTab)
speed1kFrame.Size = UDim2.new(1, -16, 0, 36)
speed1kFrame.BackgroundTransparency = 1

local min1kBtn = Instance.new("TextButton", speed1kFrame)
min1kBtn.Size = UDim2.new(0.32, 0, 1, 0)
min1kBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", min1kBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(min1kBtn, false)
CreateBorder(min1kBtn)
CreateButtonText(min1kBtn, "-1000", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(min1kBtn)
min1kBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_Speed = math.clamp(_G.Config.TP_Speed - 1000, 50, 99999)
    for _, lblData in ipairs(AdjustLabels["TP_Speed"]) do lblData.Label.Text = lblData.Name..": ".._G.Config.TP_Speed end
end)

local set350Btn = Instance.new("TextButton", speed1kFrame)
set350Btn.Size = UDim2.new(0.32, 0, 1, 0)
set350Btn.Position = UDim2.new(0.34, 0, 0, 0)
set350Btn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", set350Btn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(set350Btn, false)
CreateBorder(set350Btn)
CreateButtonText(set350Btn, "350 Speed", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(set350Btn)
set350Btn.MouseButton1Click:Connect(function()
    _G.Config.TP_Speed = 350
    for _, lblData in ipairs(AdjustLabels["TP_Speed"]) do lblData.Label.Text = lblData.Name..": ".._G.Config.TP_Speed end
end)

local plus1kBtn = Instance.new("TextButton", speed1kFrame)
plus1kBtn.Size = UDim2.new(0.32, 0, 1, 0)
plus1kBtn.Position = UDim2.new(0.68, 0, 0, 0)
plus1kBtn.BackgroundColor3 = Color3.new(1,1,1)
Instance.new("UICorner", plus1kBtn).CornerRadius = UDim.new(0, 20)
ApplyToggleGradient(plus1kBtn, false)
CreateBorder(plus1kBtn)
CreateButtonText(plus1kBtn, "+1000", Enum.Font.GothamBold, 11)
ApplyButtonAnimation(plus1kBtn)
plus1kBtn.MouseButton1Click:Connect(function()
    _G.Config.TP_Speed = math.clamp(_G.Config.TP_Speed + 1000, 50, 99999)
    for _, lblData in ipairs(AdjustLabels["TP_Speed"]) do lblData.Label.Text = lblData.Name..": ".._G.Config.TP_Speed end
end)


local SelectedPlayerLabel = Instance.new("TextLabel", ContentFrames["TP Player"].Frame)
SelectedPlayerLabel.Size = UDim2.new(1, -16, 0, 25)
SelectedPlayerLabel.BackgroundTransparency = 1
SelectedPlayerLabel.Text = "Target: Auto (Nearest)"
SelectedPlayerLabel.Font = Enum.Font.GothamBold
SelectedPlayerLabel.TextSize = 13
CreateTextGradient(SelectedPlayerLabel)

local PlayerListContainer = Instance.new("Frame", ContentFrames["TP Player"].Frame)
PlayerListContainer.Size = UDim2.new(1, -16, 0, 0)
PlayerListContainer.BackgroundTransparency = 1
local pListLayout = Instance.new("UIGridLayout", PlayerListContainer)
pListLayout.CellSize = UDim2.new(0.48, 0, 0, 36)
pListLayout.CellPadding = UDim2.new(0.04, 0, 0, 8)
pListLayout.SortOrder = Enum.SortOrder.LayoutOrder
pListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerListContainer.Size = UDim2.new(1, -16, 0, pListLayout.AbsoluteContentSize.Y)
end)

AddButton("TP Player", "ðŸ”„ REFRESH PLAYER LIST", function()
    for _, child in ipairs(PlayerListContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local count = 0
    local autoBtn = Instance.new("TextButton", PlayerListContainer)
    autoBtn.Size = UDim2.new(1, 0, 0, 36)
    autoBtn.Text = ""
    autoBtn.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 20)
    ApplyToggleGradient(autoBtn, _G.Config.SelectedTargetPlayer == nil)
    CreateBorder(autoBtn)
    local autoTxt = CreateButtonText(autoBtn, "ðŸŽ¯ Auto", Enum.Font.GothamBold, 12)
    ApplyButtonAnimation(autoBtn)

    autoBtn.MouseButton1Click:Connect(function()
        _G.Config.SelectedTargetPlayer = nil
        SelectedPlayerLabel.Text = "Target: Auto (Nearest)"
        for _, child in ipairs(PlayerListContainer:GetChildren()) do
            if child:IsA("TextButton") then ApplyToggleGradient(child, false) end
        end
        ApplyToggleGradient(autoBtn, true)
    end)

    for _, p in ipairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        count = count + 1
        local btn = Instance.new("TextButton", PlayerListContainer)
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.Text = ""
        btn.BackgroundColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20)

        local isSelected = (_G.Config.SelectedTargetPlayer == p.Name)
        ApplyToggleGradient(btn, isSelected)
        CreateBorder(btn)

        local txt = CreateButtonText(btn, "ðŸ‘¤ " .. p.Name, Enum.Font.GothamBold, 11)
        if isSelected then txt.TextColor3 = Color3.fromRGB(0,0,0) end
        ApplyButtonAnimation(btn)

        btn.MouseButton1Click:Connect(function()
            _G.Config.SelectedTargetPlayer = p.Name
            SelectedPlayerLabel.Text = "Target: " .. p.Name
            for _, child in ipairs(PlayerListContainer:GetChildren()) do
                if child:IsA("TextButton") then ApplyToggleGradient(child, false) end
            end
            ApplyToggleGradient(btn, true)
            txt.TextColor3 = Color3.fromRGB(0,0,0)
        end)
    end
    AddNotify({Title="LIST REFRESHED",Description="Loaded ",Duration=3})
end)

local PredContainer = Instance.new("Frame", ContentFrames["TP Player"].Frame) PredContainer.Size = UDim2.new(1, 0, 0, 115) PredContainer.BackgroundTransparency = 1
local PredToggle = Instance.new("TextButton", PredContainer) PredToggle.Size = UDim2.new(1, -16, 0, 36) PredToggle.Text = "" PredToggle.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", PredToggle).CornerRadius = UDim.new(0, 20) ApplyToggleGradient(PredToggle, _G.Config.Prediction_Enabled) CreateBorder(PredToggle) local PredToggleTxt = CreateButtonText(PredToggle, "PREDICTION COUNTER: OFF", Enum.Font.GothamBold, 14) ApplyButtonAnimation(PredToggle)
local PredSliderBg = Instance.new("Frame", PredContainer) PredSliderBg.Size = UDim2.new(1, -16, 0, 25) PredSliderBg.Position = UDim2.new(0, 0, 0, 48) PredSliderBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20) Instance.new("UICorner", PredSliderBg).CornerRadius = UDim.new(0, 20)
local PredSliderFill = Instance.new("Frame", PredSliderBg) PredSliderFill.Size = UDim2.new(_G.Config.Prediction / 10, 0, 1, 0) PredSliderFill.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", PredSliderFill).CornerRadius = UDim.new(0, 20) ApplyToggleGradient(PredSliderFill, true)
local PredValLabel = Instance.new("TextLabel", PredSliderBg) PredValLabel.Size = UDim2.new(1, 0, 1, 0) PredValLabel.BackgroundTransparency = 1 PredValLabel.Text = "Predict Time: " .. string.format("%.1f", _G.Config.Prediction) .. "s" PredValLabel.Font = Enum.Font.GothamBold PredValLabel.TextSize = 12 CreateTextGradient(PredValLabel)
local PredBtnFrame = Instance.new("Frame", PredContainer) PredBtnFrame.Size = UDim2.new(1, -16, 0, 32) PredBtnFrame.Position = UDim2.new(0, 0, 0, 82) PredBtnFrame.BackgroundTransparency = 1
function createPredBtn(text, posScale) local btn = Instance.new("TextButton", PredBtnFrame) btn.Size = UDim2.new(0.22, 0, 1, 0) btn.Position = UDim2.new(posScale, 0, 0, 0) btn.Text = "" btn.BackgroundColor3 = Color3.new(1,1,1) Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 20) ApplyToggleGradient(btn, false) CreateBorder(btn) CreateButtonText(btn, text, Enum.Font.GothamBold, 14) ApplyButtonAnimation(btn) return btn end
local pm1 = createPredBtn("-1", 0) local pm01 = createPredBtn("-0.1", 0.26) local pp01 = createPredBtn("+0.1", 0.52) local pp1 = createPredBtn("+1", 0.78)
function UpdatePred(val) _G.Config.Prediction = math.clamp(val, 0, 10) local ratio = _G.Config.Prediction / 10 PredSliderFill.Size = UDim2.new(ratio, 0, 1, 0) PredValLabel.Text = "Predict Time: " .. string.format("%.1f", _G.Config.Prediction) .. "s" end
pm1.MouseButton1Click:Connect(function() UpdatePred(_G.Config.Prediction - 1) end) pm01.MouseButton1Click:Connect(function() UpdatePred(_G.Config.Prediction - 0.1) end) pp01.MouseButton1Click:Connect(function() UpdatePred(_G.Config.Prediction + 0.1) end) pp1.MouseButton1Click:Connect(function() UpdatePred(_G.Config.Prediction + 1) end)
PredToggle.MouseButton1Click:Connect(function() _G.Config.Prediction_Enabled = not _G.Config.Prediction_Enabled PredToggleTxt.Text = "PREDICTION COUNTER: " .. (_G.Config.Prediction_Enabled and "ON" or "OFF") ApplyToggleGradient(PredToggle, _G.Config.Prediction_Enabled) end)
local draggingPred = false
PredSliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingPred = true end end)
PredSliderBg.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingPred = false end end)
UserInputService.InputChanged:Connect(function(input) if draggingPred and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local relX = math.clamp((input.Position.X - PredSliderBg.AbsolutePosition.X) / PredSliderBg.AbsoluteSize.X, 0, 1) UpdatePred(relX * 10) end end)

UserInputService.JumpRequest:Connect(function()
    if _G.Config.InfJump then
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

_G.M1BF = true
if _G.M1BF then
    local p=game.Players.LocalPlayer
    local lastAttack1 = 0
    task.spawn(function()
        while _G.M1BF and task.wait() do
            if not _G.Config.FastM1 then continue end
            if tick() - lastAttack1 < (_G.Config.FastM1_Delay or 0) then continue end -- Add timer
            
            local c=p.Character
            if c then
                local t=c:FindFirstChildOfClass("Tool")
                local r=c:FindFirstChild("HumanoidRootPart")
                if t and t:FindFirstChild("LeftClickRemote") and r then
                    local attacked = false
                    for _,f in ipairs({workspace.Enemies,workspace.Characters}) do
                        for _,e in f:GetChildren() do
                            local h=e:FindFirstChild("HumanoidRootPart")
                            local m=e:FindFirstChild("Humanoid")
                            if e~=c and h and m and m.Health>0 then
                                local d=(h.Position-r.Position).Magnitude
                                if d<=5000 then
                                    t.LeftClickRemote:FireServer((h.Position-r.Position).Unit,1)
                                    attacked = true
                                    break
                                end
                            end
                        end
                        if attacked then break end
                    end
                    if attacked then lastAttack1 = tick() end
                end
            end
        end
    end)
end
_G.FastV2 = true
local RS = game:GetService("ReplicatedStorage")
local P = Players.LocalPlayer

local N = require(RS.Modules.Net)
local C = require(RS.Modules.CombatUtil)
local WeaponData = require(RS.Modules.WeaponData)

local hit = N:RemoteEvent("RegisterHit", true)
local atk = RS.Modules.Net["RE/RegisterAttack"]

local humanoid, animator
local loaded = {}
local currentTrack = nil

function stopAnim()
	if currentTrack then
		currentTrack:Stop()
		currentTrack=nil
	end
end

function setup(char)
	stopAnim()
	loaded={}
	humanoid=char:WaitForChild("Humanoid")
	animator=humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator",humanoid)
	humanoid.Died:Connect(stopAnim)
end

if P.Character then setup(P.Character) end
P.CharacterAdded:Connect(setup)

function getTrack(id)
	if loaded[id] then return loaded[id] end
	local anim=Instance.new("Animation")
	anim.AnimationId=id
	local track=animator:LoadAnimation(anim)
	track.Priority=Enum.AnimationPriority.Action4
	track.Looped=true
	loaded[id]=track
	return track
end

function getTargets(root,dist)
	local t={}
	for _,m in ipairs(workspace.Enemies:GetChildren()) do
		local hrp=m:FindFirstChild("HumanoidRootPart")
		local hum=m:FindFirstChild("Humanoid")
		if hrp and hum and hum.Health>0 then
			local d=(hrp.Position-root.Position).Magnitude
			if d<=dist then
				t[#t+1]={m,hrp}
			end
		end
	end
	for _,plr in ipairs(Players:GetPlayers()) do
		if plr~=P and plr.Character then
			local hrp=plr.Character:FindFirstChild("HumanoidRootPart")
			local hum=plr.Character:FindFirstChild("Humanoid")
			if hrp and hum and hum.Health>0 then
				local d=(hrp.Position-root.Position).Magnitude
				if d<=dist then
					t[#t+1]={plr.Character,hrp}
				end
			end
		end
	end
	return t
end

function play(tool)
	if not tool or not humanoid then return end
	local weaponName=C:GetWeaponName(tool)
	local data=WeaponData[weaponName] or WeaponData[string.lower(weaponName)]
	if not data or data.Type=="Gun" then return end
	if not (data and data.Moveset and data.Moveset.Basic) then return end

	local moves=data.Moveset.Basic
	local index=math.clamp(3,1,#moves)
	local animData=moves[index]
	if not animData then return end

	local track=getTrack(animData.AnimationId)
	if not track then return end

	if currentTrack~=track then
		stopAnim()
		currentTrack=track
	end

	track.TimePosition=0
	track:Play(0.25,1,0.02)
end

local lastAttack2 = 0
task.spawn(function()
    while task.wait() do
        if not _G.FastV2 or not _G.Config.FastM1 then
            stopAnim()
            continue
        end
        if tick() - lastAttack2 < (_G.Config.FastM1_Delay or 0) then continue end -- Add timer

        local char=P.Character
        if not (char and humanoid and humanoid.Health>0) then
            stopAnim()
            continue
        end

        local root=char:FindFirstChild("HumanoidRootPart")
        local tool=char:FindFirstChildOfClass("Tool")
        if not (root and tool) then
            stopAnim()
            continue
        end

        local weaponName=C:GetWeaponName(tool)
        local data=WeaponData[weaponName] or WeaponData[string.lower(weaponName)]
        if not data or data.Type=="Gun" or data.Type=="Blox Fruit" then
            stopAnim()
            continue
        end

        local targets=getTargets(root,80)
        if #targets>0 then
            atk:FireServer()
            hit:FireServer(root,targets,nil,nil,tostring(os.clock()))
            play(tool)
            lastAttack2 = tick()
        else
            stopAnim()
        end
    end
end)
_G.Aura = true

local enemies = workspace:FindFirstChild("Enemies")
local characters = workspace:FindFirstChild("Characters")

if enemies and characters then

local tool = nil
local lastAttack = 0

function getTool()
    local char = plr.Character
    if char then
        for _,v in pairs(char:GetChildren()) do
            if v:IsA("Tool") and v:FindFirstChild("LeftClickRemote") then
                return v
            end
        end
    end
    for _,v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("LeftClickRemote") then
            return v
        end
    end
end

RunService.Heartbeat:Connect(function()
    if not _G.Aura then return end

    local char = plr.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    if not tool or not tool.Parent then
        tool = getTool()
    end
    if not tool then return end

    local remote = tool.LeftClickRemote
    local rootPos = root.Position
    local currentTime = tick()

    if currentTime - lastAttack < 0.05 then return end
    lastAttack = currentTime

    for _,target in pairs(enemies:GetChildren()) do
        local hrp = target:FindFirstChild("HumanoidRootPart")
        if hrp and target:FindFirstChild("Humanoid") then
            remote:FireServer((hrp.Position - rootPos).Unit, 1)
        end
    end

    for _,target in pairs(characters:GetChildren()) do
        if target ~= char then
            local hrp = target:FindFirstChild("HumanoidRootPart")
            if hrp and target:FindFirstChild("Humanoid") then
                remote:FireServer((hrp.Position - rootPos).Unit, 1)
            end
        end
    end
end)

end

_G.Shoot = true
local Player = Players.LocalPlayer
local VirtualInputManager = game:GetService("VirtualInputManager")

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local Modules = ReplicatedStorage:WaitForChild("Modules")
local Net = Modules:WaitForChild("Net")

local RE_ShootGunEvent = Net:WaitForChild("RE/ShootGunEvent")
local GunValidator = Remotes:WaitForChild("Validator2")

local SUCCESS_SHOOT, SHOOT_FUNCTION = pcall(function()
    return getupvalue(require(ReplicatedStorage.Controllers.CombatController).Attack, 9)
end)

local FastAttack = {
    ShootDebounce = 0,
    ShootsPerTarget = {
        ["Dual Flintlock"] = 2
    },
    SpecialShoots = {
        ["Skull Guitar"] = "TAP",
        ["Bazooka"] = "Position",
        ["Cannon"] = "Position",
        ["Dragonstorm"] = "Overheat"
    },
    Overheat = {
        ["Dragonstorm"] = {
            MaxOverheat = 3,
            Cooldown = 0,
            TotalOverheat = 0,
            Distance = 350,
            Shooting = false
        }
    }
}

function FastAttack:GetValidator2()
    if not SHOOT_FUNCTION then return 0,0 end

    local v1 = getupvalue(SHOOT_FUNCTION,15)
    local v2 = getupvalue(SHOOT_FUNCTION,13)
    local v3 = getupvalue(SHOOT_FUNCTION,16)
    local v4 = getupvalue(SHOOT_FUNCTION,17)
    local v5 = getupvalue(SHOOT_FUNCTION,14)
    local v6 = getupvalue(SHOOT_FUNCTION,12)
    local v7 = getupvalue(SHOOT_FUNCTION,18)

    local v8 = v6 * v2
    local v9 = (v5 * v2 + v6 * v1) % v3

    v9 = (v9 * v3 + v8) % v4
    v5 = math.floor(v9 / v3)
    v6 = v9 - v5 * v3
    v7 = v7 + 1

    setupvalue(SHOOT_FUNCTION,15,v1)
    setupvalue(SHOOT_FUNCTION,13,v2)
    setupvalue(SHOOT_FUNCTION,16,v3)
    setupvalue(SHOOT_FUNCTION,17,v4)
    setupvalue(SHOOT_FUNCTION,14,v5)
    setupvalue(SHOOT_FUNCTION,12,v6)
    setupvalue(SHOOT_FUNCTION,18,v7)

    return math.floor(v9 / v4 * 16777215), v7
end

function IsAlive(char)
    local hum = char and char:FindFirstChild("Humanoid")
    return hum and hum.Health > 0
end

function GetClosestEnemy(range)
    local char = Player.Character
    if not char then return end

    local pos = char:GetPivot().Position
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return end

    local closest, dist = nil, range
    local closestPart = nil

    for _,v in pairs(enemies:GetChildren()) do
        if IsAlive(v) then
            local root = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
            if root then
                local mag = (root.Position - pos).Magnitude
                if mag < dist then
                    dist = mag
                    closest = v
                    closestPart = root
                end
            end
        end
    end

    return closest, closestPart
end
function GetEnemiesInRange(range)
    local char = Player.Character
    if not char then return {} end

    local pos = char:GetPivot().Position
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return {} end

    local hits = {}

    for _, enemy in pairs(enemies:GetChildren()) do
        if IsAlive(enemy) then
            local root = enemy:FindFirstChild("HumanoidRootPart") or enemy.PrimaryPart
            if root and (root.Position - pos).Magnitude <= range then
                table.insert(hits, root)
            end
        end
    end

    return hits
end

function HandleOverheat(equipped, gunName)
    local data = FastAttack.Overheat[gunName]
    if not data or data.Shooting then return end

    local target, targetPart = GetClosestEnemy(data.Distance or 100)
    if not target then return end

    data.Shooting = true
    while equipped and equipped.Parent == Player.Character and data.TotalOverheat < data.MaxOverheat do
        target, targetPart = GetClosestEnemy(data.Distance or 100)
        if target and targetPart and IsAlive(target) then
            equipped:SetAttribute("LocalTotalShots", (equipped:GetAttribute("LocalTotalShots") or 0) + 1)
            GunValidator:FireServer(FastAttack:GetValidator2())
            RE_ShootGunEvent:FireServer(targetPart.Position, {targetPart})
            data.TotalOverheat = data.TotalOverheat + 1
            task.wait(data.Cooldown)
        else
            break
        end
    end
    while data.TotalOverheat > 0 do
        data.TotalOverheat = math.clamp(data.TotalOverheat - task.wait(), 0, data.MaxOverheat)
    end

    data.Shooting = false
end

function HandleNormalShoot(equipped)
    local hits = GetEnemiesInRange(120)
    if #hits == 0 then return end

    local targetPos = hits[1].Position

    equipped:SetAttribute("LocalTotalShots", (equipped:GetAttribute("LocalTotalShots") or 0) + 1)
    GunValidator:FireServer(FastAttack:GetValidator2())
    local shots = FastAttack.ShootsPerTarget[equipped.Name] or 1
    for i = 1, shots do
        RE_ShootGunEvent:FireServer(targetPos, hits)
        if i < shots then task.wait(0.05) end
    end
end

function HandlePositionShoot(equipped, shootType)
    local target, targetPart = GetClosestEnemy(200)
    if not target then return end

    equipped:SetAttribute("LocalTotalShots", (equipped:GetAttribute("LocalTotalShots") or 0) + 1)
    GunValidator:FireServer(FastAttack:GetValidator2())

    if shootType == "TAP" and equipped:FindFirstChild("RemoteEvent") then
        equipped.RemoteEvent:FireServer("TAP", targetPart.Position)
    else
        RE_ShootGunEvent:FireServer(targetPart.Position)
    end
end

function HandleGunShoot(equipped)
    if not equipped.Enabled then return end

    local shootType = FastAttack.SpecialShoots[equipped.Name] or "Normal"

    if shootType == "Overheat" then
        HandleOverheat(equipped, equipped.Name)
    elseif shootType == "Normal" then
        HandleNormalShoot(equipped)
    elseif shootType == "Position" or (shootType == "TAP" and equipped:FindFirstChild("RemoteEvent")) then
        HandlePositionShoot(equipped, shootType)
    end
end

RunService.Heartbeat:Connect(function()
    if not _G.Shoot then return end

    local char = Player.Character
    if not IsAlive(char) then return end

    local tool = char:FindFirstChildOfClass("Tool")
    if not tool or tool.ToolTip ~= "Gun" then return end
    local cooldownValue = tool:FindFirstChild("Cooldown")
    if not cooldownValue then return end

    local currentCooldown = cooldownValue.Value
    if tick() - FastAttack.ShootDebounce < currentCooldown then return end

    if SUCCESS_SHOOT and SHOOT_FUNCTION then
        HandleGunShoot(tool)
        FastAttack.ShootDebounce = tick()
    else

        local target, targetPart = GetClosestEnemy(1000)
        if target and targetPart then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
            FastAttack.ShootDebounce = tick()
        end
    end
end)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if _G.Config.WalkOnWater then
        pcall(function()
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
        end)
    else
        pcall(function()
            game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
        end)
    end

    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if _G.Config.SilentAim then
        if FOVCircle then
            FOVCircle.Position = screenCenter
            FOVCircle.Radius = _G.Config.FOV_Radius
            FOVCircle.Visible = not _G.Config.SilentAim_Nearest
        end

        SilentAimTarget = GetClosestTargetForAim()

        if SilentAimTarget then
            local rgb = GetRGB()
            if FOVCircle then FOVCircle.Color = rgb end
            if TracerLine then
                local targetPos, targetOnScreen = Camera:WorldToViewportPoint(SilentAimTarget.Position)

                if targetOnScreen then
                    local startX, startY
                    if hrp then
                        local myPos, myOnScreen = Camera:WorldToViewportPoint(hrp.Position)
                        startX = myOnScreen and myPos.X or screenCenter.X
                        startY = myOnScreen and myPos.Y or Camera.ViewportSize.Y
                    else
                        startX = screenCenter.X; startY = Camera.ViewportSize.Y
                    end
                    TracerLine.From = Vector2.new(startX, startY)
                    TracerLine.To = Vector2.new(targetPos.X, targetPos.Y)
                    TracerLine.Color = rgb
                    TracerLine.Visible = true
                else
                    TracerLine.Visible = false
                end
            end
        else
            if FOVCircle then FOVCircle.Color = Color3.fromRGB(255, 255, 255) end
            if TracerLine then TracerLine.Visible = false end
        end
    else
        SilentAimTarget = nil
        if FOVCircle then FOVCircle.Visible = false end
        if TracerLine then TracerLine.Visible = false end
    end
end)

RunService.Heartbeat:Connect(function(dt)
    if _G.Config.SafeMode and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hum and hrp and hum.Health > 0 then
            local hpPct = hum.Health / hum.MaxHealth

            if hpPct <= 0.35 and not _G.IsFleeing and not _G.IsReturning then
                _G.IsFleeing = true
                hrp.CFrame = CFrame.new(hrp.Position.X, 100000, hrp.Position.Z)
                if currentTween then currentTween:Cancel() end
                if not noclipConnection then toggleNoclip(true) end
            end

            if _G.IsFleeing then
                if currentTween then currentTween:Cancel() end
                if not noclipConnection then toggleNoclip(true) end

                hrp.CFrame = CFrame.new(hrp.Position.X, 100000, hrp.Position.Z)

                if hpPct > 0.65 then
                    _G.IsFleeing = false
                    _G.IsReturning = true
                end
            elseif _G.IsReturning then
                if currentTween then currentTween:Cancel() end
                if not noclipConnection then toggleNoclip(true) end

                hrp.CFrame = hrp.CFrame - Vector3.new(0, 30000 * dt, 0)

                if hrp.Position.Y <= 150 then
                    hrp.CFrame = CFrame.new(hrp.Position.X, 150, hrp.Position.Z)
                    _G.IsReturning = false
                    if noclipConnection and not isFarming then toggleNoclip(false) end
                end
            end
        end
    else
        _G.IsFleeing = false
        _G.IsReturning = false
    end

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if myRoot then
        if _G.Config.AutoDrop and not _G.Config.SafeMode then
            if myRoot.Position.Y > 40000 and not _G.IsFleeing and not _G.IsReturning then
                _G.IsForcedDropping = true
            end
        end

        if _G.IsForcedDropping then
            if currentTween then currentTween:Cancel() end
            if not noclipConnection then toggleNoclip(true) end

            myRoot.CFrame = myRoot.CFrame - Vector3.new(0, 50000 * dt, 0)
            if myRoot.Position.Y <= 150 then
                myRoot.CFrame = CFrame.new(myRoot.Position.X, 150, myRoot.Position.Z)
                _G.IsForcedDropping = false
                if noclipConnection and not isFarming then toggleNoclip(false) end
            end
        end
    end

    local rgb = GetRGB()
    local shift = tick() * 0.15

    local seqOn = GetMovingColorSequence(Palettes.On, shift)
    local seqOff = GetMovingColorSequence(Palettes.Off, shift)
    local seqText = GetMovingColorSequence(Palettes.Text, shift * 1.5)
    local seqBorder = GetMovingColorSequence(Palettes.Border, shift * 1.8)

    for _, grad in ipairs(UIGradientList) do grad.Color = seqBorder end
    for _, grad in ipairs(TextGradientList) do if not grad:GetAttribute("CustomOnColor") then grad.Color = seqText end end
    for _, grad in ipairs(BtnGradientList) do if grad.Parent and grad.Parent:GetAttribute("IsOn") then grad.Color = seqOn else grad.Color = seqOff end end

    local hasLowHPEnemy = false
    if _G.Config.Hitbox_P and _G.Config.LowHP_KS and myRoot then
        for _, p in Players:GetPlayers() do
            if p == LocalPlayer then continue end
            if _G.Config.TeamCheck and p.Team == LocalPlayer.Team then continue end
            local char = p.Character local hum = char and char:FindFirstChild("Humanoid") local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if char and hum and hrp and hum.Health > 0 then
                local dist = (hrp.Position - myRoot.Position).Magnitude
                if dist <= 2000 and (hum.Health / hum.MaxHealth) <= 0.3 then hasLowHPEnemy = true; break end
            end
        end
    end

    for _,p in Players:GetPlayers()do
        if p==LocalPlayer then continue end
        local char=p.Character local hrp=char and char:FindFirstChild("HumanoidRootPart") local hum=char and char:FindFirstChild("Humanoid")
        local isTeammate = (_G.Config.TeamCheck and p.Team ~= nil and p.Team == LocalPlayer.Team)

        if not char or not hrp or not hum or hum.Health<=0 or isTeammate then
            CleanupHitboxAttributes(hrp); CleanupESP(p.Name); continue
        end

        local hp_percent = hum.Health / hum.MaxHealth
        local dist = myRoot and (hrp.Position - myRoot.Position).Magnitude or math.huge
        local hitboxShouldEnable = false

        if _G.Config.Hitbox_P then
            if _G.Config.LowHP_KS then
                if hasLowHPEnemy then if hp_percent <= 0.3 then hitboxShouldEnable = true end else if dist <= 2000 then hitboxShouldEnable = true end end
            else hitboxShouldEnable = true end
        end

        if hitboxShouldEnable then
            local valid = true
            if _G.Config.Hitbox_WallCheck then
                local rp = RaycastParams.new(); rp.FilterDescendantsInstances = {LocalPlayer.Character}; rp.FilterType = Enum.RaycastFilterType.Exclude
                local rr = Workspace:Raycast(Camera.CFrame.Position, (hrp.Position - Camera.CFrame.Position), rp)
                if rr and rr.Instance and not rr.Instance:IsDescendantOf(char) then valid = false end
            end

            if valid then
                local targetSize = Vector3.new(_G.Config.HitboxSize, _G.Config.HitboxSize, _G.Config.HitboxSize)
                if hrp.Size ~= targetSize then hrp.Size = targetSize end
                if hrp.Transparency ~= 0.6 then hrp.Transparency = 0.6 end
                if hrp.CanCollide ~= false then hrp.CanCollide = false end
                hrp:SetAttribute("ArisHitboxActive", true)
            else CleanupHitboxAttributes(hrp) end
        else CleanupHitboxAttributes(hrp) end

        local hl = char:FindFirstChild("ArisHL")
        if _G.Config.ESP_Chams_P then
            if not hl then hl = Instance.new("Highlight", char); hl.Name = "ArisHL" end hl.FillColor = rgb; hl.Enabled = true
        else if hl then hl:Destroy() end end

        local hbBox = hrp:FindFirstChild("ArisHitboxBox")
        if hrp:GetAttribute("ArisHitboxActive") and _G.Config.Hitbox_Box then
            if not hbBox then hbBox = Instance.new("SelectionBox", hrp); hbBox.Name = "ArisHitboxBox"; hbBox.Adornee = hrp end hbBox.SurfaceColor3 = rgb
        else if hbBox then hbBox:Destroy() end end

        if _G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P or _G.Config.ESP_Box_P or _G.Config.ESP_PVP then
            if not ESP_Store[p.Name] then
                local boxBill = Instance.new("BillboardGui", ScreenGui); boxBill.Size = UDim2.new(4.2,0,5.8,0); boxBill.AlwaysOnTop = true
                local outF = Instance.new("Frame", boxBill); outF.Size = UDim2.new(1,0,1,0); outF.BackgroundTransparency = 1
                Instance.new("UICorner", outF).CornerRadius = UDim.new(0, 16)
                local outS = Instance.new("UIStroke", outF); outS.Thickness = 2.5; outS.Color = Color3.new(1,1,1)
                local grad = Instance.new("UIGradient", outS)
                grad.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 230, 255)), ColorSequenceKeypoint.new(0.35, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.65, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 200)) })
                local cDot = Instance.new("Frame", boxBill); cDot.Size = UDim2.new(0,4,0,4); cDot.Position = UDim2.new(0.5,-2,0.5,-2); cDot.BackgroundColor3 = Color3.fromRGB(0,230,255); cDot.BorderSizePixel=0; Instance.new("UICorner", cDot).CornerRadius = UDim.new(1,0)
                local hLine = Instance.new("Frame", boxBill); hLine.Size = UDim2.new(0.5,0,0,1); hLine.Position = UDim2.new(0.25,0,0.5,0); hLine.BackgroundColor3 = Color3.new(1,1,1); hLine.BackgroundTransparency = 0.5; hLine.BorderSizePixel=0
                local vLine = Instance.new("Frame", boxBill); vLine.Size = UDim2.new(0,1,0.5,0); vLine.Position = UDim2.new(0.5,0,0.25,0); vLine.BackgroundColor3 = Color3.new(1,1,1); vLine.BackgroundTransparency = 0.5; vLine.BorderSizePixel=0

                local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0,200,0,60); textB.StudsOffset = Vector3.new(0,3.5,0); textB.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1,0,1,0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12
                txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                txt.RichText = true
                ESP_Store[p.Name]={BoxBill=boxBill, Grad=grad, TextBill=textB, Text=txt}
            end
            local s=ESP_Store[p.Name]
            s.BoxBill.Adornee = hrp; s.TextBill.Adornee = char:FindFirstChild("Head") or hrp
            local isHitboxActive = hrp:GetAttribute("ArisHitboxActive") == true
            s.BoxBill.Enabled = _G.Config.ESP_Box_P or (isHitboxActive and _G.Config.ESP_2D_Hitbox)
            if s.Grad then s.Grad.Rotation = (tick() * 150) % 360 end
            if isHitboxActive and _G.Config.ESP_2D_Hitbox then s.BoxBill.Size = UDim2.new(_G.Config.HitboxSize, 0, _G.Config.HitboxSize, 0) else s.BoxBill.Size = UDim2.new(4.2, 0, 5.8, 0) end

            local espLines = {}
            if _G.Config.ESP_Name_P then table.insert(espLines, p.Name) end
            if _G.Config.ESP_Health_P then table.insert(espLines, "HP: "..math.floor(hum.Health)) end
            if _G.Config.ESP_Distance_P and (dist ~= math.huge) then table.insert(espLines, "Dist: "..math.floor(dist).."m") end
            if _G.Config.ESP_PVP then
                if GetTrueStatus(p) then
                    table.insert(espLines, "Status: <font color='#00A2FF'>PVP ON</font>")
                else
                    table.insert(espLines, "Status: <font color='#A0A0A0'>PVP OFF</font>")
                end
            end
            s.Text.Text = table.concat(espLines, "\n")
            s.Text.TextColor3 = GetHealthColor(hp_percent)
            s.TextBill.Enabled = (_G.Config.ESP_Name_P or _G.Config.ESP_Health_P or _G.Config.ESP_Distance_P or _G.Config.ESP_PVP)
        else CleanupESP(p.Name) end
    end

    for obj in pairs(CachedNPCs) do
        if not obj.Parent then CachedNPCs[obj] = nil; CleanupNPC(obj); continue end
        local hum = obj:FindFirstChild("Humanoid") local hrp = obj:FindFirstChild("HumanoidRootPart")
        if hum and hrp and hum.Health > 0 then
            local distToNPC = myRoot and (hrp.Position - myRoot.Position).Magnitude or math.huge
            if distToNPC > MAX_NPC_RENDER_DISTANCE then
                CleanupNPC(obj)
                continue
            end

            if _G.Config.Hitbox_NPC then
                local targetSizeNPC = Vector3.new(_G.Config.HitboxSize_NPC, _G.Config.HitboxSize_NPC, _G.Config.HitboxSize_NPC)
                if hrp.Size ~= targetSizeNPC then hrp.Size = targetSizeNPC end
                if hrp.Transparency ~= 0.6 then hrp.Transparency = 0.6 end
                if hrp.CanCollide ~= false then hrp.CanCollide = false end
                hrp:SetAttribute("ArisHitboxActiveNPC", true)
            else CleanupHitboxAttributesNPC(hrp) end

            local hbBoxNPC = hrp:FindFirstChild("ArisHitboxBoxNPC")
            if hrp:GetAttribute("ArisHitboxActiveNPC") and _G.Config.Hitbox_Box_NPC then
                if not hbBoxNPC then hbBoxNPC = Instance.new("SelectionBox", hrp); hbBoxNPC.Name = "ArisHitboxBoxNPC"; hbBoxNPC.Adornee = hrp end hbBoxNPC.SurfaceColor3 = rgb
            else if hbBoxNPC then hbBoxNPC:Destroy() end end

            local hlNPC = obj:FindFirstChild("ArisHL_NPC")
            if _G.Config.ESP_NPC_Chams then
                if not hlNPC then hlNPC = Instance.new("Highlight", obj); hlNPC.Name = "ArisHL_NPC" end hlNPC.FillColor = rgb; hlNPC.Enabled = true
            else if hlNPC then hlNPC:Destroy() end end

            if _G.Config.ESP_NPC_Name or _G.Config.ESP_NPC_Box then
                if not NPC_Store[obj] then
                    local textB = Instance.new("BillboardGui", ScreenGui); textB.Size = UDim2.new(0, 200, 0, 60); textB.StudsOffset = Vector3.new(0, 3.5, 0); textB.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", textB); txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Font = Enum.Font.GothamBold; txt.TextSize = 12 txt.TextStrokeTransparency = 0; txt.TextStrokeColor3 = Color3.new(0, 0, 0)
                    local boxBill = Instance.new("BillboardGui", ScreenGui); boxBill.Size = UDim2.new(4,0,5.5,0); boxBill.AlwaysOnTop = true
                    local outF = Instance.new("Frame", boxBill); outF.Size = UDim2.new(1,0,1,0); outF.BackgroundTransparency = 1 Instance.new("UICorner", outF).CornerRadius = UDim.new(0, 6)
                    local inS = Instance.new("UIStroke", outF); inS.Thickness = 1.5; inS.Color = Color3.new(1,1,1)
                    NPC_Store[obj] = {Bill = textB, Text = txt, BoxBill = boxBill, InStroke = inS}
                end
                local ns = NPC_Store[obj]
                ns.Bill.Adornee = obj:FindFirstChild("Head") or hrp
                ns.Text.Text = "NPC: " .. obj.Name .. "\nHP: " .. math.floor(hum.Health)
                ns.Text.TextColor3 = rgb
                ns.Bill.Enabled = _G.Config.ESP_NPC_Name

                local isHitboxActiveNPC = hrp:GetAttribute("ArisHitboxActiveNPC") == true
                ns.BoxBill.Adornee = hrp
                ns.InStroke.Color = rgb
                ns.BoxBill.Enabled = _G.Config.ESP_NPC_Box or (isHitboxActiveNPC and _G.Config.ESP_2D_Hitbox)

                if isHitboxActiveNPC and _G.Config.ESP_2D_Hitbox then ns.BoxBill.Size = UDim2.new(_G.Config.HitboxSize_NPC, 0, _G.Config.HitboxSize_NPC, 0) else ns.BoxBill.Size = UDim2.new(4, 0, 5.5, 0) end
            else
                if NPC_Store[obj] then if NPC_Store[obj].Bill then NPC_Store[obj].Bill:Destroy() end if NPC_Store[obj].BoxBill then NPC_Store[obj].BoxBill:Destroy() end NPC_Store[obj] = nil end
            end
        else CleanupNPC(obj) end
    end
end)

Players.PlayerRemoving:Connect(function(p) CleanupESP(p.Name) end)
