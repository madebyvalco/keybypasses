local function press(a)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, tostring(a), false, game)
end

local function cleanWindows()
    for _, v in next, game:GetService("Workspace").Windows:GetChildren() do
        if v.ClassName == "Part" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            task.wait(0.1)
            press("E")
            task.wait(2)
        end
    end
end

local function autoScan()
    for _, v in next, game:GetService("Workspace").Checkouts:GetDescendants() do
        if v.ClassName == "Model" and v.Parent.Name == "Items" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
            task.wait(0.1)
            press("E")
            task.wait(2)
        end
    end
end

local function refuel()
    for _, v in next, game:GetService("Workspace"):GetChildren() do
        if string.match(v.Name, "Car") and v.ClassName == "Model" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
            if v.Lid.Refuel then
                press("E")
                task.wait(2)
            elseif v.Lid.Finish then
                press("E")
                task.wait(2)
            end
        end
    end
end

local function cleanFloor()
    for _, v in next, game:GetService("Workspace"):GetDescendants() do
        if v.Name == "Clean" and v.Parent.Name == "Spot" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Parent.CFrame
            task.wait(0.1)
            press("E")
            task.wait(2)
        end
    end
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
        Name = "Main",
        Icon = "rbxassetid://7072717697",
        PremiumOnly = false
    }
)

local labelMoney = Tab:AddLabel("Money: 0 | Bank Money: 0 | Bills: 0")

task.spawn(
    function()
        while true do
            local plrMoneyGUI = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stats.Money.Money.Text
            local bankGUI = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stats.Bank.Bank.Text
            local billsGUI = game:GetService("Players").LocalPlayer.PlayerGui.GameUI.Stats.Bills.Bills.Text
            labelMoney:Set(
                tostring("Money: " .. plrMoneyGUI .. " | Bank Money: " .. bankGUI .. " | Bills: " .. billsGUI)
            )
            task.wait(0.5)
        end
    end
)

Tab:AddToggle(
    {
        Name = "Clean Windows",
        Default = false,
        Save = true,
        Flag = "cleanWindows",
        Callback = function(val)
            getgenv().windowsToggle = val

            while windowsToggle do
                if windowsToggle == true then
                    cleanWindows()
                    task.wait(2)
                elseif windowsToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Clean Floor",
        Default = false,
        Save = true,
        Flag = "cleanFloor",
        Callback = function(val)
            getgenv().floorToggle = val

            while floorToggle do
                task.wait()
                if floorToggle == true then
                    cleanFloor()
                elseif floorToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Scan Checkout Items",
        Default = false,
        Save = true,
        Flag = "scanItems",
        Callback = function(val)
            getgenv().scanToggle = val

            while scanToggle do
                task.wait()
                if scanToggle == true then
                    autoScan()
                elseif scanToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Refuel Cars",
        Default = false,
        Save = true,
        Flag = "refuelCars",
        Callback = function(val)
            getgenv().refuelToggle = val

            while refuelToggle do
                task.wait()
                if refuelToggle == true then
                    refuel()
                elseif refuelToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddButton(
    {
        Name = "Become Manager",
        Callback = function()
        end
    }
)

Tab:AddButton(
    {
        Name = "Fix Character",
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
        end
    }
)


local Tab =
    Window:MakeTab(
    {
        Name = "Items",
        Icon = "rbxassetid://7072715646",
        PremiumOnly = false
    }
)

local items = {
    "Water", "Canned Soda", "Milk", "Generic Soda", "Bubble Gum", "Candy Bar", "Generic Cookies",
    "Chips", "Bread Bun", "Hotdog", "Instant Noodles", "Cheese", "Whole Bread", "Hamburger", "Instant Meal",
}

local selectedFood

local types = {
    "Station",
    "Client"
}

local selectedType

Tab:AddDropdown(
    {
        Name = "Select Money Type",
        Default = "nil",
        Save = true,
        Flag = "type",
        Options = types,
        Callback = function(x)
            selectedType = x
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Food",
        Default = "nil",
        Save = true,
        Flag = "food",
        Options = items,
        Callback = function(x)
            selectedFood = x
        end
    }
)

Tab:AddButton(
    {
        Name = "Buy Food",
        Callback = function()
            local args = {
                [1] = "BuyItem",
                [2] = "Generic Foods",
                [3] = selectedFood,
                [4] = selectedType
            }
            game:GetService("ReplicatedStorage").Remote:FireServer(unpack(args))            
        end
    }
)

Tab:AddButton(
    {
        Name = "Grab a Blox Bull",
        Callback = function()
            local args = {
                [1] = "BuyBloxBull",
                [2] = workspace.Vendor_BloxBull_1
            }
            game:GetService("ReplicatedStorage").Remote:FireServer(unpack(args))            
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Misc",
        Icon = "rbxassetid://7072716017",
        PremiumOnly = false
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
        Icon = "rbxassetid://7072718266",
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