plr = game.Players.LocalPlayer
char = plr.Character
hrp = char.HumanoidRootPart
humanoid = char.Humanoid

local function getCoin()
    local dist, thing = math.huge
    for _,v in pairs(game:GetService("Workspace").Drops:GetDescendants()) do
        if v.Name == "Circle" and v.ClassName == "Part" then
            local mag = (hrp.Position - v.Position).magnitude
            if mag < dist then
                dist = mag
                thing = v
            end
        end
    end
    return thing.Parent.Name
end

local function gamepass()
    for _, v in next, game:GetService("ReplicatedStorage").Stats[game.Players.LocalPlayer.Name].Gamepasses:GetChildren() do
        if v.ClassName == "BoolValue" then
            v.Value = true
        end
    end
end

local worlds = {}

for _, v in next, game:GetService("Workspace").Drops:GetChildren() do
    if v.ClassName == "Folder" then
        table.insert(worlds, v.Name)
    end
end

local function click()
    game:GetService("ReplicatedStorage").Remotes.Tap:FireServer()
end

local function openEgg(name)
    local args = {
        [1] = (name),
        [2] = 1
    }

    game:GetService("ReplicatedStorage").Remotes.BuyEgg:InvokeServer(unpack(args))
end

local function tripleOpenEgg(name)
    local args = {
        [1] = (name),
        [2] = 3
    }

    game:GetService("ReplicatedStorage").Remotes.BuyEgg:InvokeServer(unpack(args))
end

local function quadOpenEgg(name)
    local args = {
        [1] = (name),
        [2] = 4
    }

    game:GetService("ReplicatedStorage").Remotes.BuyEgg:InvokeServer(unpack(args))
end

local pets = {}

for _, v in next, game:GetService("Workspace").Pets[game.Players.LocalPlayer.Name]:GetChildren() do
    if v:IsA("Model") then
        table.insert(pets, v.Name)
    end
end

local eggs = {}

for _, v in next, game:GetService("Workspace").Eggs:GetChildren() do
    if v:IsA("Folder") then
        table.insert(eggs, v.Name)
    end
end

table.sort(
    eggs,
    function(a, b)
        return a < b
    end
)

local rebirths = {}
local selectedRebirth

for _, v in next, game:GetService("Players").LocalPlayer.PlayerGui.Menus.Rebirth.Frame.List:GetDescendants() do
    if v.ClassName == "TextLabel" and v.Name == "Amount" and v.Parent.Name ~= "Max" then
        table.insert(rebirths, v.Text)
    end
end

table.sort(
    rebirths,
    function(a, b)
        return a < b
    end
)

local function rebirth()
    for _, v in next, game:GetService("Players").LocalPlayer.PlayerGui.Menus.Rebirth.Frame.List:GetDescendants() do
        if v.ClassName == "TextLabel" and v.Text == selectedRebirth then
            local args = {
                [1] = tonumber(v.Parent.Name)
            }

            game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer(unpack(args))
        end
    end
end

local function equipbest()
    game:GetService("ReplicatedStorage").Remotes.EquipBest:InvokeServer()
end

local teleportAreas = {

    ["Spawn"] = 1,
    ["Forest"] = 2,
    ["Desert"] = 3,
    ["Winter"] = 4,
    ["Lava"] = 5,
    ["Aqua"] = 6,
    ["Sakura"] = 7,
    ["Mines"] = 8,
    ["Galaxy"] = 9,
    ["Heaven"] = 10,

}

function teleport(area)
    for i,v in next, teleportAreas do
        if area == i then
            local args = {
                [1] = v
            }
            game:GetService("ReplicatedStorage").Remotes.TPArea:FireServer(unpack(args))            
        end
    end
end

local function buyClickers()
    for i = 1,20 do
        local args = {
            [1] = "Purchase",
            [2] = i
        }
        game:GetService("ReplicatedStorage").Remotes.TapSkinAction:FireServer(unpack(args))        
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

Tab:AddToggle(
    {
        Name = "Click",
        Default = false,
        Save = true,
        Flag = "click",
        Callback = function(val)
            getgenv().clickToggle = val

            while clickToggle do
                if clickToggle == true then
                    click()
                    task.wait()
                elseif clickToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Rebirth",
        Default = "nil",
        Save = true,
        Flag = "rebirth",
        Options = rebirths,
        Callback = function(x)
            selectedRebirth = x
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Rebirth",
        Default = false,
        Save = true,
        Flag = "rebirth",
        Callback = function(val)
            getgenv().rebirthToggle = val

            while rebirthToggle do
                if rebirthToggle == true then
                    rebirth()
                    task.wait()
                elseif rebirthToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Egg",
        Default = "nil",
        Save = true,
        Flag = "eggs",
        Options = eggs,
        Callback = function(x)
            selectedEgg = x
        end
    }
)

local selectedAmount
Tab:AddDropdown(
    {
        Name = "Egg Amount",
        Default = "nil",
        Save = true,
        Flag = "rebirth",
        Options = {"1", "3", "4"},
        Callback = function(x)
            selectedAmount = x
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Open Egg",
        Default = false,
        Save = true,
        Flag = "rebirth",
        Callback = function(val)
            getgenv().eggToggle = val

            while eggToggle do
                if eggToggle == true then
                    if selectedAmount == "1" then
                        openEgg(selectedEgg)
                    elseif selectedAmount == "3" then
                        tripleOpenEgg(selectedEgg)
                    elseif selectedAmount == "4" then
                        quadOpenEgg(selectedEgg)
                    end
                    task.wait()
                elseif eggToggle == false then
                    break
                end
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Farming",
        Icon = "rbxassetid://7072715317",
        PremiumOnly = false
    }
)

local selectedArea
local selectedType

Tab:AddToggle(
    {
        Name = "Auto Farm Selected World",
        Default = false,
        Save = true,
        Flag = "farm",
        Callback = function(val)
            getgenv().farmToggle = val

            while farmToggle do task.wait()
                if farmToggle == true then
                    if selectedType == "Teleport" then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Drops[selectedArea][getCoin()].PrimaryPart.CFrame
                        local args = {
                                [1] = tostring(getCoin())
                            }
                        game:GetService("ReplicatedStorage").Remotes.Tap:FireServer(unpack(args))
                    elseif selectedType == "Walk" then
                        game.Players.LocalPlayer.Character.Humanoid:MoveTo(game:GetService("Workspace").Drops[selectedArea][getCoin()].Circle.Position)
                        local args = {
                            [1] = tostring(getCoin())
                        }
                        game:GetService("ReplicatedStorage").Remotes.Tap:FireServer(unpack(args))
                    else
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Drops[selectedArea][getCoin()].PrimaryPart.CFrame
                        local args = {
                                [1] = tostring(getCoin())
                            }
                        game:GetService("ReplicatedStorage").Remotes.Tap:FireServer(unpack(args))
                    end
                elseif farmToggle == false then
                    break
                end
            end
        end
    }
)

local areas = {}
for _,v in next, game:GetService("Workspace").Drops:GetChildren() do
    if v then
        table.insert(areas, v.Name)
    end
end

Tab:AddDropdown(
    {
        Name = "Select World",
        Default = "Forest",
        Save = true,
        Flag = "areas",
        Options = areas,
        Callback = function(x)
            selectedArea = x
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Farming Type",
        Default = "Teleport",
        Save = true,
        Flag = "type",
        Options = {"Walk", "Teleport"},
        Callback = function(x)
            selectedType = x
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
        Name = "Get Gamepasses",
        Callback = function()
            gamepass()
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

Tab:AddToggle(
    {
        Name = "Equip Best Pets",
        Default = false,
        Save = true,
        Flag = "equipbest",
        Callback = function(val)
            getgenv().equipbestToggle = val

            while equipbestToggle do
                if equipbestToggle == true then
                    equipbest()
                    task.wait(2)
                elseif equipbestToggle == false then
                    break
                end
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Upgrades",
        Icon = "rbxassetid://7072706796",
        PremiumOnly = false
    }
)

local selectedUpgrade
local selectedUpgrade2

local upgradeTable = {"RebirthsUpgrade", "TapMultiplier", "FreeAutoClicker", "CriticalChances", "FasterWalk", "PetStorage", "AutoClickerMultiplier"}
local upgradeTable2 = {"TapDamage", "MorePetsEquipped", "GoldenChances", "MoreLuck", "FasterEggs", "RainbowChances", "MoreRubies"}

Tab:AddDropdown(
    {
        Name = "Select Ruby Upgrade",
        Default = "nil",
        Save = true,
        Flag = "upgrades",
        Options = upgradeTable,
        Callback = function(x)
            selectedUpgrade = x
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Token Upgrade",
        Default = "nil",
        Save = true,
        Flag = "upgrades",
        Options = upgradeTable2,
        Callback = function(x)
            selectedUpgrade = x
        end
    }
)

local function buyUpg(a, b)
    local args = {
        [1] = b,
        [2] = a
    }
    game:GetService("ReplicatedStorage").Remotes.Upgrade:InvokeServer(unpack(args))
end

Tab:AddToggle(
    {
        Name = "Auto Ruby Buy Upgrade",
        Default = false,
        Save = true,
        Flag = "upgs",
        Callback = function(val)
            getgenv().upgsToggle = val

            while upgsToggle do
                if upgsToggle == true then
                    buyUpg(selectedUpgrade, "Ruby")
                    task.wait()
                elseif upgsToggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Token Buy Upgrade",
        Default = false,
        Save = true,
        Flag = "upgs",
        Callback = function(val)
            getgenv().upgs2Toggle = val

            while upgs2Toggle do
                if upgs2Toggle == true then
                    buyUpg(selectedUpgrade2, "Token")
                    task.wait()
                elseif upgs2Toggle == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Buy Clickers",
        Default = false,
        Save = true,
        Flag = "clickers",
        Callback = function(val)
            getgenv().clickersToggle = val

            while clickersToggle do
                if clickersToggle == true then
                    buyClickers()
                    task.wait(1)
                elseif clickersToggle == false then
                    break
                end
            end
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

local areasTable2 = {}

for i,v in next, teleportAreas do
    table.insert(areasTable2, i)
end

local plrs = {}
local selectedPlr
local selectedArea

for _, v in next, game:GetService("Players"):GetPlayers() do
    if v.Name ~= game.Players.LocalPlayer.Name then
        table.insert(plrs, v.Name)
    end
end

Tab:AddDropdown(
    {
        Name = "Select World",
        Default = "nil",
        Save = true,
        Flag = "players",
        Options = areasTable2,
        Callback = function(x)
            selectedArea = x
        end
    }
)

Tab:AddButton(
    {
        Name = "Teleport To World",
        Callback = function()
            teleport(selectedArea)
        end
    }
)

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