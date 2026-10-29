local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()
local lp = game.Players.LocalPlayer
local rs = game:GetService("RunService")
local esp, noclip, killAll, silentAim, god, fly, invisible, autoGun = false, false, false, false, false, false, false, false
local espC, clipC, killC, aimC, godC, invC, gunC

local Window = OrionLib:MakeWindow({Name = "HACK OD FILIPA - MM2 PL", HidePremium = false, SaveConfig = false, ConfigFolder = "MojeMM2"})

local TabAdmin = Window:MakeTab({Name = "🌍 Ogólne / Admin", Icon = "rbxassetid://4483345998"})
local TabMorderca = Window:MakeTab({Name = "🔪 Morderca", Icon = "rbxassetid://4483345998"})
local TabSzeryf = Window:MakeTab({Name = "🔫 Szeryf", Icon = "rbxassetid://4483345998"})
local TabNiewinny = Window:MakeTab({Name = "🛡️ Niewinny", Icon = "rbxassetid://4483345998"})

TabAdmin:AddToggle({Name = "ESP Rentgen ścian", Default = false, Callback = function(V)
    esp = V
    if esp then
        espC = rs.Heartbeat:Connect(function()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and not p.Character:FindFirstChild("AdminHi") then
                    local hl = Instance.new("Highlight", p.Character)
                    hl.Name = "AdminHi"
                    hl.FillColor = Color3.fromRGB(0, 255, 150)
                    hl.FillTransparency = 0.5
                    local kn = p.Character:FindFirstChildOfClass("Tool") and (p.Character:FindFirstChildOfClass("Tool").Name:lower():find("knife") or p.Character:FindFirstChildOfClass("Tool").Name == "Knife")
                    if kn then hl.FillColor = Color3.fromRGB(255, 0, 0) end
                end
            end
        end)
    else
        if espC then espC:Disconnect() end
        for _, p in pairs(game.Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("AdminHi") then p.Character.AdminHi:Destroy() end end
    end
end})

TabAdmin:AddToggle({Name = "Super Prędkość (WalkSpeed)", Default = false, Callback = function(V)
    local h = lp.Character and lp.Character:FindFirstChildOfClass("Humanoid")
    if h then h.WalkSpeed = V and 120 or 16 end
end})

TabAdmin:AddToggle({Name = "Noclip (Chodzenie przez ściany)", Default = false, Callback = function(V)
    noclip = V
    clipC = rs.Stepped:Connect(function()
        if noclip and lp.Character then
            for _, part in pairs(lp.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
        end
    end)
end})

TabMorderca:AddToggle({Name = "Zabij Wszystkich (Kill All)", Default = false, Callback = function(V)
    killAll = V
    killC = rs.Heartbeat:Connect(function()
        if killAll then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("Humanoid") then p.Character.Humanoid.Health = 0 end
            end
        end
    end)
end})

TabSzeryf:AddToggle({Name = "Auto-Strzał w Mordercę", Default = false, Callback = function(V)
    silentAim = V
    aimC = rs.Heartbeat:Connect(function()
        local pistolet = lp.Character and lp.Character:FindFirstChildOfClass("Tool")
        if silentAim and pistolet then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    pistolet:Activate()
                    p.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
                end
            end
        end
    end)
end})

TabNiewinny:AddToggle({Name = "Bypass God Mode (Nieskończone HP)", Default = false, Callback = function(V)
    god = V
    godC = rs.Heartbeat:Connect(function()
        if god and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then lp.Character:FindFirstChildOfClass("Humanoid").Health = math.huge end
    end)
end})

TabNiewinny:AddToggle({Name = "Niewidzialność dla innych", Default = false, Callback = function(V)
    invisible = V
    invC = rs.Heartbeat:Connect(function()
        if invisible and lp.Character then
            for _, o in pairs(lp.Character:GetChildren()) do if o:IsA("BasePart") and o.Name ~= "HumanoidRootPart" then o.Transparency = 1 end end
        end
    end)
end})

TabNiewinny:AddToggle({Name = "Auto Dropped Gun (Teleport broni)", Default = false, Callback = function(V)
    autoGun = V
    gunC = rs.Heartbeat:Connect(function()
        local dg = workspace:FindFirstChild("GunDrop") or workspace:FindFirstChild("DroppedGun")
        if autoGun and dg and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then lp.Character.HumanoidRootPart.CFrame = dg.CFrame end
    end)
end})

OrionLib:Init()
