local function tween(speed, path)
    local ts = game:GetService("TweenService")
    local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - path.Position).magnitude
    local info = TweenInfo.new(speed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local doTween = nil
    doTween =
        ts:Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        info,
        {
            CFrame = path.CFrame
        }
    )
    doTween:Play()
    task.wait(distance / speed)
end

local gui = Instance.new("BillboardGui")
local esp = Instance.new("TextLabel", gui)

gui.Name = "8167231986"
gui.ResetOnSpawn = false
gui.AlwaysOnTop = true
gui.LightInfluence = 0
gui.Size = UDim2.new(1.75, 0, 1.75, 0)

esp.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
esp.Text = ""
esp.Size = UDim2.new(0.0001, 0.00001, 0.0001, 0.00001)
esp.BorderSizePixel = 4
esp.BorderColor3 = Color3.new(0, 0, 0)
esp.BorderSizePixel = 0
esp.Font = "FredokaOne"
esp.TextSize = 16
esp.TextColor3 = Color3.fromRGB(255, 255, 255)

local function getMap()
    for _, v in next, game:GetService("Workspace"):GetDescendants() do
        if v.Name == "PlayerSpawn" and v.Parent.ClassName == "Model" then
            return v.Parent.Parent.Name
        end
    end
end

local Mouse = game.Players.LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local function getNearest()
    local dist, thing = math.huge
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local mag =
                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v.Name
            end
        end
    end
    return thing
end

local title = "Soggyware | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()

OrionLib:MakeNotification(
    {
        Name = "Soggyware",
        Content = "Welcome " .. game.Players.LocalPlayer.Name .. " the hub is loading now!",
        Image = "rbxassetid://7072718307",
        Time = 4
    }
)

local Window = OrionLib:MakeWindow({Name = title, HidePremium = false, SaveConfig = true, ConfigFolder = "Soggyware"})

local Tab =
    Window:MakeTab(
    {
        Name = "Blatant",
        Icon = "rbxassetid://7072706536",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "Kill Aura | Knife",
        Default = false,
        Save = true,
        Flag = "killAura",
        Callback = function(x)
            getgenv().killAuraToggle = x

            while killAuraToggle do
                if killAuraToggle == true then
                    for _, v in next, game:GetService("Players"):GetPlayers() do
                        if v.Name ~= game.Players.LocalPlayer.Name then
                            if
                                (game.Players.LocalPlayer.Character.HumanoidRootPart.Position -
                                    v.Character.HumanoidRootPart.Position).Magnitude <= 20
                             then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                    v.Character.HumanoidRootPart.CFrame +
                                    v.Character.HumanoidRootPart.CFrame.LookVector * -3.5
                                task.wait(0.3)
                                local args = {
                                    [1] = "Down"
                                }
                                game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer(unpack(args))
                                repeat
                                    wait()
                                until not game.Players.Character
                            end
                        end
                    end
                elseif killAuraToggle == false then
                    break
                end
            end
        end
    }
)

local silentAimLabel = Tab:AddLabel("Silent Aim Focusing On: ")

Tab:AddToggle(
    {
        Name = "Silent Aim | Gun | Right Mouse Button To Shoot",
        Default = false,
        Save = true,
        Flag = "silentAim",
        Callback = function(x)
            getgenv().silentAimToggle = x

            while silentAimToggle do
                if silentAimToggle == true then
                    for _, v in next, game:GetService("Players"):GetPlayers() do
                        if v.Name == getNearest() then
                            game.Players.LocalPlayer:GetMouse().Button2Down:Connect(
                                function()
                                    local args = {
                                        [1] = 1,
                                        [2] = v.Character.Head.Position,
                                        [3] = "AH"
                                    }
                                    game:GetService("Players").LocalPlayer.Character.Gun.KnifeServer.ShootGun:InvokeServer(
                                        unpack(args)
                                    )
                                end
                            )
                            silentAimLabel:Set("Silent Aim Focusing On: " .. v.Name)
                            task.wait()
                        end
                    end
                elseif killsilentAimToggleAuraToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Coin Auto Farm",
        Default = false,
        Save = true,
        Flag = "coinFarm",
        Callback = function(x)
            getgenv().coinFarmToggle = x

            while coinFarmToggle do
                if coinFarmToggle == true then
                    for _, v in next, game:GetService("Workspace")[getMap()].CoinContainer:GetChildren() do
                        if v.Name == "Coin_Server" and v.ClassName == "Part" then
                            tween(3, v)
                        end
                    end
                elseif coinFarmToggle == false then
                    break
                end
                task.wait()
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Kill All",
        Callback = function()
            for _, v in next, game:GetService("Players"):GetPlayers() do
                if v.Name ~= game.Players.LocalPlayer.Name then
                    if
                        (game.Players.LocalPlayer.Character.HumanoidRootPart.Position -
                            v.Character.HumanoidRootPart.Position).Magnitude <= 300
                     then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                                game.Players.LocalPlayer.Backpack:FindFirstChild("Knife")
                            )
                        end
                        if game.Players.LocalPlayer.Character:FindFirstChild("Knife") then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                v.Character.HumanoidRootPart.CFrame +
                                v.Character.HumanoidRootPart.CFrame.LookVector * -3.5
                            task.wait(0.1)
                            game.Players.LocalPlayer.Character.Knife:Activate()
                        end
                    elseif game.Players.LocalPlayer.Backpack.Knife == nil then
                        OrionLib:MakeNotification(
                            {
                                Name = "Soggyware | Error",
                                Content = "You are not the murderer " .. game.Players.LocalPlayer.Name,
                                Image = "rbxassetid://7072980286",
                                Time = 4
                            }
                        )
                    end
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Shoot Murderer",
        Callback = function()
            for _, v in next, game:GetService("Players"):GetPlayers() do
                if v.Name ~= game.Players.LocalPlayer.Name then
                    if
                        game.Players[v.Name].Backpack:FindFirstChild("Knife") or
                            game.Players.LocalPlayer.Character:FindFirstChild("Knife")
                     then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        task.wait(0.1)
                        local args = {
                            [1] = 1,
                            [2] = v.Character.Head.Position,
                            [3] = "AH"
                        }

                        game:GetService("Players").LocalPlayer.Character.Gun.KnifeServer.ShootGun:InvokeServer(
                            unpack(args)
                        )
                    end
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Stab Sheriff",
        Callback = function()
            for _, v in next, game:GetService("Players"):GetPlayers() do
                if v.Name ~= game.Players.LocalPlayer.Name then
                    if
                        game.Players[v.Name].Backpack:FindFirstChild("Gun") or
                            game.Players.LocalPlayer.Character:FindFirstChild("Gun")
                     then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                        wait(0.1)
                        local args = {
                            [1] = "Down"
                        }
                        game:GetService("Players").LocalPlayer.Character.Knife.Stab:FireServer(unpack(args))
                    end
                end
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Misc",
        Icon = "rbxassetid://7072715317",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "Blurt Roles | Says Roles In Chat",
        Default = false,
        Save = true,
        Flag = "blurtRole",
        Callback = function(x)
            getgenv().blurtToggle = x

            while blurtToggle do
                task.wait()
                if blurtToggle == true then
                    for _, v in next, game:GetService("Players"):GetPlayers() do
                        if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                            local args = {
                                [1] = "Murder: " .. v.Name,
                                [2] = "normalchat"
                            }
                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                unpack(args)
                            )
                        end
                        if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                            local args = {
                                [1] = "Sheriff: " .. v.Name,
                                [2] = "normalchat"
                            }
                            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                                unpack(args)
                            )
                        end
                    end
                    wait(60)
                elseif blurtToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Blurt Roles | Notification",
        Default = false,
        Save = true,
        Flag = "blurtRoleNotify",
        Callback = function(x)
            getgenv().notifyRoleToggle = x

            while notifyRoleToggle do
                task.wait()
                if notifyRoleToggle == true then
                    for _, v in next, game:GetService("Players"):GetPlayers() do
                        if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                            OrionLib:MakeNotification(
                                {
                                    Name = "Soggyware",
                                    Content = "Murderer: " .. v.Name,
                                    Image = "rbxassetid://7072978559",
                                    Time = 4
                                }
                            )
                        end
                        if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                            OrionLib:MakeNotification(
                                {
                                    Name = "Soggyware",
                                    Content = "Sheriff: " .. v.Name,
                                    Image = "rbxassetid://7072978559",
                                    Time = 4
                                }
                            )
                        end
                    end
                    task.wait(30)
                elseif notifyRoleToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Remove Barriers",
        Callback = function()
            if game:GetService("Workspace")[getMap()].GlitchProof then
                game:GetService("Workspace")[getMap()].GlitchProof:Destroy()
            else
                OrionLib:MakeNotification(
                    {
                        Name = "Soggyware | Error",
                        Content = "You have already destroyed barriers " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072980286",
                        Time = 4
                    }
                )
            end
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Play Song",
        Default = "Insert ID Here",
        TextDisappear = true,
        Callback = function(x)
            local args = {
                [1] = "https://www.roblox.com/asset/?id=" .. x
            }
            game:GetService("ReplicatedStorage").PlaySong:FireServer(unpack(args))
        end
    }
)

Tab:AddButton(
    {
        Name = "Better FPS",
        Callback = function()
            for _, v in next, workspace:GetChildren() do
                if v.Name == "ThrowingKnife" and v.ClassName == "Model" then
                    v:Destroy()
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Remove Textures",
        Callback = function()
            for _, v in next, workspace:GetDescendants() do
                if v.ClassName == "Decal" then
                    v:Destroy()
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Send Trades To Everyone",
        Callback = function()
            for _, v in next, game:GetService("Players"):GetPlayers() do
                if v.Name ~= game.Players.LocalPlayer.Name then
                    local args = {
                        [1] = game:GetService("Players")[v.Name]
                    }
                    game:GetService("ReplicatedStorage").Trade.SendRequest:InvokeServer(unpack(args))
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Headless",
        Callback = function()
            game.Players.LocalPlayer.Character.Head.Transparency = 1
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Teleport",
        Icon = "rbxassetid://7072719750",
        PremiumOnly = false
    }
)

local plrs = {}
local selectedPlr

for _, v in next, game:GetService("Players"):GetPlayers() do
    if v.Name ~= game.Players.LocalPlayer.Name then
        table.insert(plrs, v.Name)
    end
end

Tab:AddDropdown(
    {
        Name = "Select Player",
        Default = "nil",
        Save = true,
        Flag = "players",
        Options = plrs,
        Callback = function(x)
            selectedPlr = x
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To Player",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.Players[selectedPlr].Character.HumanoidRootPart.CFrame
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To Murderer",
        Callback = function()
            for _, v in next, game:GetService("Players"):GetPlayers() do
                if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To Sheriff",
        Callback = function()
            for _, v in next, game:GetService("Players"):GetPlayers() do
                if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To Lobby",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(
                -107.869209,
                138.349884,
                9.21811581,
                0.977966487,
                -4.15972963e-08,
                -0.20876193,
                3.73103788e-08,
                1,
                -2.44728273e-08,
                0.20876193,
                1.61446181e-08,
                0.977966487
            )
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To Map",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game:GetService("Workspace")[getMap()].CoinAreas.CoinArea + Vector3.new(0, 15, 0)
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Visuals",
        Icon = "rbxassetid://7072720870",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "X-RAY",
        Default = false,
        Save = true,
        Flag = "xRay",
        Callback = function(x)
            getgenv().xRayToggle = x

            while xRayToggle do
                task.wait()
                if xRayToggle == true then
                    if game:GetService("Workspace")[getMap()].Map.Parts then
                        for _, v in next, game:GetService("Workspace")[getMap()]:GetDescendants() do
                            if v:IsA("BasePart") then
                                v.Transparency = 0.5
                            end
                        end
                    end
                elseif xRayToggle == false then
                    for _, v in next, game:GetService("Workspace")[getMap()]:GetDescendants() do
                        if v:IsA("BasePart") then
                            v.Transparency = 0
                        end
                    end
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Murderer ESP",
        Default = false,
        Save = true,
        Flag = "murderEsp",
        Callback = function(x)
            getgenv().espToggle = x

            while espToggle do
                task.wait()
                if espToggle == true then
                    game:GetService("RunService").RenderStepped:Connect(
                        function()
                            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                                if
                                    v ~= game:GetService("Players").LocalPlayer and
                                        v.Character.Head:FindFirstChild("8167231986") == nil
                                 then
                                    if v.Backpack:FindFirstChild("Knife") or v.Character:FindFirstChild("Knife") then
                                        esp.TextColor3 = Color3.fromRGB(255, 0, 0)
                                        esp.Text = "Murderer"
                                        gui:Clone().Parent = v.Character.Head
                                    end
                                end
                            end
                        end
                    )
                elseif espToggle == false then
                    for _, v in next, game:GetDescendants() do
                        if v.Name == "8167231986" then
                            v:Destroy()
                        end
                    end
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Sheriff ESP",
        Default = false,
        Save = true,
        Flag = "sheriffEsp",
        Callback = function(x)
            getgenv().espToggle = x

            while espToggle do
                task.wait()
                if espToggle == true then
                    game:GetService("RunService").RenderStepped:Connect(
                        function()
                            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                                if
                                    v ~= game:GetService("Players").LocalPlayer and
                                        v.Character.Head:FindFirstChild("8167231986") == nil
                                 then
                                    if v.Backpack:FindFirstChild("Gun") or v.Character:FindFirstChild("Gun") then
                                        esp.TextColor3 = Color3.fromRGB(8, 125, 215)
                                        esp.Text = "Sheriff"
                                        gui:Clone().Parent = v.Character.Head
                                    end
                                end
                            end
                        end
                    )
                elseif espToggle == false then
                    for _, v in next, game:GetDescendants() do
                        if v.Name == "8167231986" then
                            v:Destroy()
                        end
                    end
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Innocent ESP",
        Default = false,
        Save = true,
        Flag = "innocentEsp",
        Callback = function(x)
            getgenv().espToggle = x

            while espToggle do
                task.wait()
                if espToggle == true then
                    game:GetService("RunService").RenderStepped:Connect(
                        function()
                            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                                if
                                    v ~= game:GetService("Players").LocalPlayer and
                                        v.Character.Head:FindFirstChild("8167231986") == nil
                                 then
                                    if
                                        v.Backpack:FindFirstChild("Gun") == nil and
                                            v.Backpack:FindFirstChild("Knife") == nil
                                     then
                                        esp.TextColor3 = Color3.fromRGB(1, 181, 31)
                                        esp.Text = "Innocent"
                                        gui:Clone().Parent = v.Character.Head
                                    end
                                end
                            end
                        end
                    )
                elseif espToggle == false then
                    for _, v in next, game:GetDescendants() do
                        if v.Name == "8167231986" then
                            v:Destroy()
                        end
                    end
                    break
                end
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Player",
        Icon = "rbxassetid://7072724538",
        PremiumOnly = false
    }
)

Tab:AddSlider(
    {
        Name = "Walkspeed",
        Min = 16,
        Max = 500,
        Default = 16,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(x)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = x
        end
    }
)

Tab:AddSlider(
    {
        Name = "Jump Power",
        Min = 50,
        Max = 500,
        Default = 50,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(x)
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = x
        end
    }
)

Tab:AddSlider(
    {
        Name = "FOV",
        Min = 70,
        Max = 120,
        Default = 70,
        Color = Color3.fromRGB(255, 255, 255),
        Increment = 1,
        ValueName = "",
        Callback = function(x)
            game:GetService("Workspace").Camera.FieldOfView = x
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Settings",
        Icon = "rbxassetid://7072721682",
        PremiumOnly = false
    }
)

Tab:AddButton(
    {
        Name = "Join Discord Server",
        Callback = function()
            local http = game:GetService("HttpService")
            if toClipboard then
                toClipboard("https://discord.gg/soggy")
            else
            end
            local req =
                syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or
                getgenv().request or
                request
            if req then
                req(
                    {
                        Url = "http://127.0.0.1:6463/rpc?v=1",
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json",
                            Origin = "https://discord.com"
                        },
                        Body = http:JSONEncode(
                            {
                                cmd = "INVITE_BROWSER",
                                nonce = http:GenerateGUID(false),
                                args = {code = "soggy"}
                            }
                        )
                    }
                )
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Anti-AFK",
        Callback = function()
            local Players = game:GetService("Players")
            local GC = getconnections or get_signal_cons
            if GC then
                for i, v in pairs(GC(Players.LocalPlayer.Idled)) do
                    if v["Disable"] then
                        v["Disable"](v)
                    elseif v["Disconnect"] then
                        v["Disconnect"](v)
                    else
                        print("")
                    end
                end
            elseif not GC then
                OrionLib:MakeNotification(
                    {
                        Name = "Soggyware | Error",
                        Content = "Your executor does not support getconnections " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072980286",
                        Time = 4
                    }
                )
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Destroy UI",
        Callback = function()
            OrionLib:Destroy()
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Load Config",
        Default = "",
        TextDisappear = true,
        Callback = function(x)
            print(x)
        end
    }
)

Tab:AddLabel("Need Support? discord.gg/soggy")
Tab:AddLabel("Made By: Sunken")

local Tab =
    Window:MakeTab(
    {
        Name = "Premium",
        Icon = "rbxassetid://7072717958",
        PremiumOnly = false
    }
)

Tab:AddButton(
    {
        Name = "Get Key",
        Callback = function()
            setclipboard("https://link-center.net/106218/keys")
            OrionLib:MakeNotification(
                {
                    Name = "Soggyware | Key System",
                    Content = "Copied Link To Clipboard " .. game.Players.LocalPlayer.Name,
                    Image = "rbxassetid://7072717958",
                    Time = 4
                }
            )
        end
    }
)

Tab:AddTextbox(
    {
        Name = "Key",
        Default = "",
        TextDisappear = true,
        Callback = function(x)
            if x == "8442e63b-974e-a691-a97b-80dca2e67210" then
                OrionLib:MakeNotification(
                    {
                        Name = "Premium | Key System",
                        Content = "Correct Key, assigning premium now " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072717958",
                        Time = 4
                    }
                )
                Premium = true
            elseif x ~= "8442e63b-974e-a691-a97b-80dca2e67210" or x == "" then
                OrionLib:MakeNotification(
                    {
                        Name = "Premium | Key System",
                        Content = "Wrong Key " .. game.Players.LocalPlayer.Name,
                        Image = "rbxassetid://7072717958",
                        Time = 4
                    }
                )
            end
        end
    }
)

Tab:AddLabel("Premium unlocks extra features!")

OrionLib:Init()