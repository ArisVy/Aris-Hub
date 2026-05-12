-- [[ SIÊU TỐI ƯU FFLAG - GIẢM LAG CỰC ĐỘ ]] --
pcall(function()
    if setfflag then
        -- 1. Tắt hoàn toàn các hệ thống báo cáo và log (Giảm Ping & CPU)
        setfflag("FFlagDebugDisableTelemetry", "True")
        setfflag("FFlagDebugDisableCloudTelemetry", "True")
        setfflag("DFFlagDebugDisablePostData", "True")
        
        -- 2. Ép hệ thống Render về mức tối giản (Tăng FPS mạnh)
        setfflag("FFlagRenderTextureCompositorLegacyPath", "False")
        setfflag("DFFlagDebugRenderForceFullRefresh", "False")
        setfflag("FFlagEnableScriptBatching", "True")
        setfflag("FFlagPhysicsSolverMultithreaded", "True") -- Xử lý đa nhân
        
        -- 3. Tối ưu hóa bộ nhớ đệm (Tránh đứng máy/Freeze)
        setfflag("FVariableRenderAllSimObjectsEveryFrame", "False")
        setfflag("FFlagEnableVariableAeroUpdateRate", "True")
        setfflag("FFlagFixInputLag", "True") -- Giảm độ trễ phím/cảm ứng
    end

    -- 4. Ép đồ họa về mức "Potato" (Cực thấp)
    local settings = settings()
    settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings.Physics.AllowSleep = true
    
    if setfpscap then setfpscap(999) end
    
    -- 5. Xóa các thực thể gây nặng máy (Sương mù, bóng đổ, hiệu ứng hạt)
    task.spawn(function()
        local lighting = game:GetService("Lighting")
        lighting.GlobalShadows = false
        lighting.FogEnd = 9e9
        lighting.Brightness = 1
        
        for _, v in ipairs(lighting:GetDescendants()) do
            if v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
    end)
end)
