pcall(function()
    local plr = game.Players.LocalPlayer
    local chr = plr.Character
    local pn = plr.Name
    local hrp = chr.HumanoidRootPart

    function RemoveTableDupes(tab)
        local hash = {}
        local res = {}
        for _, v in ipairs(tab) do
            if (not hash[v]) then
                res[#res + 1] = v
                hash[v] = true
            end
        end
        return res
    end

    function checkIfSell()
        if game:GetService("Players").LocalPlayer.PlayerGui.Menus.Sell.Visible == true then
            return true
        else
            return false
        end
    end

    swords = {}
    for _, v in next, game:GetService("ReplicatedStorage").Knives.KnifeDatas:GetChildren() do
        table.insert(swords, v.Name)
    end

    backpacks = {}

    for _, v in next, game:GetService("ReplicatedStorage").Backpacks.BackpackDatas:GetChildren() do
        table.insert(backpacks, v.Name)
    end

    function buySwords()
        for i = 1, #swords do
            local args = {
                [1] = (swords[i])
            }
            game:GetService("ReplicatedStorage").Remotes.Market.AttemptPurchase:InvokeServer(unpack(args))
        end
    end

    local eggs = {}

    for _, v in next, game:GetService("ReplicatedStorage").Assets.Eggs:GetChildren() do
        table.insert(eggs, v.Name)
    end

    function openEgg(egg, type, bool)
        if not bool then
            local args = {
                [1] = tostring(egg),
                [2] = tostring(type)
            }
            game:GetService("ReplicatedStorage").Remotes.Pets.Eggs.HatchEgg:FireServer(unpack(args))
        elseif bool == true then
            local args = {
                [1] = tostring(egg),
                [2] = tostring(type),
                [3] = 3
            }
            game:GetService("ReplicatedStorage").Remotes.Pets.Eggs.HatchEgg:FireServer(unpack(args))
        end
    end

    function buyBackpacks()
        for i = 1, #backpacks do
            local args = {
                [1] = (backpacks[i])
            }
            game:GetService("ReplicatedStorage").Remotes.Market.AttemptPurchase:InvokeServer(unpack(args))
        end
    end

    local worlds = {}
    local selectedWorld

    for _, v in next, game:GetService("Workspace").WORLDS:GetChildren() do
        if string.match(v.Name, "World") then
            table.insert(worlds, v.Name)
        end
    end

    function closest(world)
        local closestDistance, closestObject = math.huge, nil
        for _, object in ipairs(game:GetService("Workspace").WORLDS[world].Gameplay.SlicableObjects:GetDescendants()) do
            if object:IsA("BasePart") and object.Name == "ProximityHolder" then
                local distance = plr:DistanceFromCharacter(object.Position)
                if distance < closestDistance then
                    closestDistance = distance
                    closestObject = object
                end
            end
        end
        return closestObject
    end

    function closestSell()
        local closestDistance, closestObject = math.huge, nil
        for _, object in ipairs(game:GetService("Workspace").TriggerAreas.Sell:GetChildren()) do
            if object:IsA("BasePart") then
                local distance = plr:DistanceFromCharacter(object.Position)
                if distance < closestDistance then
                    closestDistance = distance
                    closestObject = object
                end
            end
        end
        return closestObject
    end

    function farm(world, obj)
        for _, v in next, game:GetService("Workspace").WORLDS[world].Gameplay.SlicableObjects[obj]:GetDescendants() do
            if v.Name == "AutoSlicer" and v.Parent then
                hrp.CFrame = v.Parent.CFrame
                task.wait()
                fireproximityprompt(v)
            end
        end
    end

    local Players = game:GetService("Players")
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
            Name = "Main",
            Icon = "rbxassetid://7072717697",
            PremiumOnly = false
        }
    )

    Tab:AddToggle(
        {
            Name = "Auto-Farm",
            Default = false,
            Flag = "Farm",
            Callback = function(x)
                getgenv().farmToggle = x

                while getgenv().farmToggle do
                    pcall(
                        function()
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = closest(selectedWorld).CFrame
                            fireproximityprompt(closest(selectedWorld).AutoSlicer)
                        end
                    )
                    task.wait()
                end
            end
        }
    )

    Tab:AddToggle(
        {
            Name = "Auto-Sell",
            Default = false,
            Callback = function(x)
                getgenv().sellToggle = x

                while getgenv().sellToggle do
                    hrp.CFrame = closestSell().CFrame
                    task.wait(0.3)
                end
            end
        }
    )

    Tab:AddDropdown(
        {
            Name = "Select World",
            Default = "World1",
            Options = worlds,
            Callback = function(x)
                selectedWorld = x
            end
        }
    )

    local Tab =
        Window:MakeTab(
        {
            Name = "Eggs",
            Icon = "rbxassetid://7072715646",
            PremiumOnly = false
        }
    )

    local selectedEgg
    local selectedType

    Tab:AddDropdown(
        {
            Name = "Select Egg",
            Default = "",
            Options = eggs,
            Callback = function(x)
                selectedEgg = x
            end
        }
    )

    Tab:AddDropdown(
        {
            Name = "Select Currency",
            Default = "Diamonds",
            Options = {"Diamonds", "Coins"},
            Callback = function(x)
                selectedType = x
            end
        }
    )

    Tab:AddToggle(
        {
            Name = "Auto-Egg",
            Default = false,
            Callback = function(x)
                getgenv().eggToggle = x

                while getgenv().eggToggle do
                    task.wait()
                    openEgg(selectedEgg, selectedType, false)
                end
            end
        }
    )

    Tab:AddToggle(
        {
            Name = "Triple-Auto-Egg",
            Default = false,
            Callback = function(x)
                getgenv().eggToggle = x

                while getgenv().eggToggle do
                    task.wait()
                    openEgg(selectedEgg, selectedType, true)
                end
            end
        }
    )

    local Tab =
        Window:MakeTab(
        {
            Name = "Auto Buy",
            Icon = "rbxassetid://7072721954",
            PremiumOnly = false
        }
    )

    Tab:AddToggle(
        {
            Name = "Auto-Swords",
            Default = false,
            Callback = function(x)
                getgenv().swordsToggle = x

                while getgenv().swordsToggle do
                    task.wait()
                    buySwords()
                end
            end
        }
    )

    Tab:AddToggle(
        {
            Name = "Auto-Backpacks",
            Default = false,
            Callback = function(x)
                getgenv().backpacksToggle = x

                while getgenv().backpacksToggle do
                    task.wait()
                    buyBackpacks()
                end
            end
        }
    )

    local Tab =
        Window:MakeTab(
        {
            Name = "Rebirth",
            Icon = "rbxassetid://7072719750",
            PremiumOnly = false
        }
    )

    local rebirths = {}
    local selectedRebirth

    mod = require(game:GetService("ReplicatedStorage").Modules.Rebirths.RebirthValues)

    for _, v in ipairs(mod) do
        table.insert(rebirths, v)
    end

    Tab:AddDropdown(
        {
            Name = "Select Rebirth",
            Default = "1",
            Options = rebirths,
            Callback = function(x)
                selectedRebirth = x
            end
        }
    )

    Tab:AddToggle(
        {
            Name = "Auto-Rebirth",
            Default = false,
            Callback = function(x)
                getgenv().rbToggle = x

                while getgenv().rbToggle do
                    task.wait()
                    for i, v in next, rebirths do
                        if selectedRebirth == v then
                            local args = {
                                [1] = tonumber(selectedRebirth),
                                [2] = i
                            }
                            game:GetService("ReplicatedStorage").Remotes.Other.Rebirth:FireServer(unpack(args))
                        end
                    end
                end
            end
        }
    )

    local Tab =
        Window:MakeTab(
        {
            Name = "Teleports",
            Icon = "rbxassetid://7072716155",
            PremiumOnly = false
        }
    )

    local areas = {}

    for _, v in next, game:GetService("Workspace").RegionBariers.CFrames:GetChildren() do
        table.insert(areas, v.Name)
    end

    function teleport(b)
        for _, v in next, game:GetService("Workspace").RegionBariers.CFrames:GetChildren() do
            if v.Name == b then
                hrp.CFrame = v.Value
            end
        end
    end

    Tab:AddDropdown(
        {
            Name = "Teleport To Area",
            Default = "1",
            Options = areas,
            Callback = function(x)
                teleport(x)
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

    Tab:AddBind(
        {
            Name = "Toggle Ui",
            Default = Enum.KeyCode.F,
            Hold = false,
            Callback = function()
                local UI = game:GetService("CoreGui"):FindFirstChild("Orion")

                if UI then
                    UI.Enabled = not UI.Enabled
                end
            end
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

    for _,v in next, game:GetService("Workspace").WORLDS.World2.Gameplay.SlicableObjects:GetDescendants() do
        if v.Name == "SLICEDPART" then
            v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end
end)