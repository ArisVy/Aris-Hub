local targetPos = Vector3.new(-5139, 170, 5800)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

if character and character:FindFirstChild("HumanoidRootPart") then
    -- Dịch chuyển bằng cách thay đổi CFrame
    character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
end
