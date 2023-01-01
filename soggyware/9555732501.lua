function dur()
local args = {
    [1] = "dur"
}

game:GetService("ReplicatedStorage").Remotes.train:FireServer(unpack(args))
end

function str()
    local args = {
        [1] = "str"
    }
    
    game:GetService("ReplicatedStorage").Remotes.train:FireServer(unpack(args))
end

function agi()
local args = {
    [1] = "agi"
}

game:GetService("ReplicatedStorage").Remotes.train:FireServer(unpack(args))
end

function nen()
    local args = {
        [1] = "nen"
    }
    
    game:GetService("ReplicatedStorage").Remotes.train:FireServer(unpack(args))
    end

local npcs = {}
local snpc

for i,v in next, workspace:GetDescendants() do
    if v.Name == "ProximityPrompt" and v.Parent.Name ~= "TeleportCaptain" then
        table.insert(npcs, v.Parent.Name)
    end
end

function getquest(adawd)
    for i,v in next, workspace:GetDescendants() do
        if v.Name == adawd then
            fireproximityprompt(v:FindFirstChild("ProximityPrompt"))
        end
    end
end

local u1 = nil
for i, v in next, getgc() do
    if type(v) == "function" and islclosure(v) and not is_synapse_function(v) then
        if debug.getinfo(v).name == "getRankInfo" then
            u1 = debug.getupvalue(v, 1)
            break
        end
    end
end
local rankstemp = {}
for i = 1,#u1 do
    table.remove(u1[i], 2)
    table.remove(u1[i], 3)
    table.insert(rankstemp, u1[i])
end

local ranks = {}
local srank
for i = 1,#rankstemp do
    table.insert(ranks, rankstemp[i][1])
end

function fightRank(rankk)
    for i,v in next, (game:GetService("Players"):GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            if v.leaderstats.Rank.Value == rankk then
                if v.Character.Humanoid.Health > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + v.Character.HumanoidRootPart.CFrame.LookVector * -3.5
                end
            end
        end
    end
end

local gyms = {}
local sgym
for i,v in next, game:GetService("Workspace").Zones:GetChildren() do
    if v.ClassName == "Part" then
        table.insert(gyms, v.Name)
    end
end

function teleportToGym(gym)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Zones[gym].CFrame
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
        Name = "Auto Strength",
        Default = false,
        Save = true,
        Flag = "Auto Strength",
        Callback = function(val)
            getgenv().Strength = val

            while Strength do
                if Strength == true then
                    str()
                    task.wait()
                elseif Strength == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Agility",
        Default = false,
        Save = true,
        Flag = "Auto Agility",
        Callback = function(val)
            getgenv().Agility = val

            while Agility do
                if Agility == true then
                    agi()
                    task.wait()
                elseif Agility == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Durability",
        Default = false,
        Save = true,
        Flag = "Auto Durability",
        Callback = function(val)
            getgenv().Durability = val

            while Durability do
                if Durability == true then
                    dur()
                    task.wait()
                elseif Durability == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Nen",
        Default = false,
        Save = true,
        Flag = "Auto Nen",
        Callback = function(val)
            getgenv().Nen = val

            while Nen do
                if Nen == true then
                    nen()
                    task.wait()
                elseif Nen == false then
                    break
                end
            end
        end
    }
)

local nextRank = Tab:AddLabel("Rank: " .. game.Players.LocalPlayer.Character.HumanoidRootPart.TitleGui.RankFrame.RankTitle.Text .. " Next Rank: " .. game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.Main.RanksSubmenu.RankupContainer.NextRankName.Text)

task.spawn(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.TitleGui.RankFrame.RankTitle:GetPropertyChangedSignal("Text"):Connect(function()
        nextRank:Set("Rank: " .. game.Players.LocalPlayer.Character.HumanoidRootPart.TitleGui.RankFrame.RankTitle.Text .. " Next Rank: " .. game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.Main.RanksSubmenu.RankupContainer.NextRankName.Text)
    end)
end)

local Tab =
    Window:MakeTab(
    {
        Name = "Quests + Upgs",
        Icon = "rbxassetid://7072716017",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "Auto Get Quest",
        Default = false,
        Save = true,
        Flag = "Auto Get Quest",
        Callback = function(val)
            getgenv().Quest = val

            while Quest do
                if Quest == true then
                    pcall(function()
                        for i,v in next, workspace:GetDescendants() do
                            if v.Name == snpc then
                                local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                                wait(0.2)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.camView.CFrame
                                wait(0.3)
                                getquest(snpc)
                                wait(0.8)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
                            end
                        end
                        task.wait(10)
                    end)
                elseif Quest == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Quest Npc",
        Default = "",
        Save = true,
        Flag = "Select Quest Npc",
        Options = npcs,
        Callback = function(x)
            snpc = x
        end
    }
)

local supg

Tab:AddDropdown(
    {
        Name = "Select Upgrade",
        Default = "",
        Save = true,
        Flag = "Select Upgrade Npc",
        Options = {
            "str",
            "dur",
            "agi",
            "nen"
        },
        Callback = function(x)
            supg = x
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Upgrade",
        Default = false,
        Save = true,
        Flag = "Auto Upgrade",
        Callback = function(val)
            getgenv().Upgrade = val

            while Upgrade do
                if Upgrade == true then
                    local args = {
                        [1] = supg
                    }

                    game:GetService("ReplicatedStorage").Remotes.multi:InvokeServer(unpack(args))
                elseif Upgrade == false then
                    break
                end
            end
        end
    }
)

function format(thit)
    return require(game:GetService("ReplicatedStorage").Modules.Rounding).abbreviateNumber(tonumber(thit))
end

function getQuessttttt()
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.Main.QuestsSubmenu:GetDescendants() do
        if v.Name == "Description" then
            local a = string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.QuestsSubmenu.MainQuest.QuestFrame.Description.Text, "%D", "")
            if v.Parent.ProgressBar.Current.Text ~= format(a) .. " / " .. format(a) then
                if string.find(v.Text, "Strength") then
                    return "str"
                elseif string.find(v.Text, "Durability") then
                    return "dur"
                elseif string.find(v.Text, "Agility") then
                    return "agi"
                elseif string.find(v.Text, "Nen") then
                    return "nen"
                end
                break
            end
        end
    end
end

Tab:AddToggle(
    {
        Name = "Auto Do Quest",
        Default = false,
        Save = true,
        Flag = "Auto Do Quest",
        Callback = function(val)
            getgenv().Do_Quest = val

            while Do_Quest do
                if Do_Quest == true then task.wait()
                    local args = {
                        [1] = getQuessttttt()
                    }
                    
                    game:GetService("ReplicatedStorage").Remotes.train:FireServer(unpack(args))
                elseif Do_Quest == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Auto Claim Daily, Weekly Quests",
        Default = false,
        Save = true,
        Flag = "Auto Do Quest",
        Callback = function(val)
            getgenv().Do_Quest = val

            while Do_Quest do
                if Do_Quest == true then task.wait()
                    for i = 1,20 do
                        local args = {
                            [1] = "DailyQuest",
                            [2] = i
                        }

                        game:GetService("ReplicatedStorage").Remotes.claim:InvokeServer(unpack(args))
                        local args = {
                            [1] = "WeeklyQuest",
                            [2] = i
                        }

                        game:GetService("ReplicatedStorage").Remotes.claim:InvokeServer(unpack(args))
                    end
                elseif Do_Quest == false then
                    break
                end
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Players + Gyms",
        Icon = "rbxassetid://7072715317",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "Teleport To Players With Rank",
        Default = false,
        Save = true,
        Flag = "With Rank",
        Callback = function(val)
            getgenv().RankFarm = val

            while RankFarm do
                if RankFarm == true then
                    fightRank(srank)
                    task.wait()
                elseif RankFarm == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Rank",
        Default = "",
        Save = true,
        Flag = "rank",
        Options = ranks,
        Callback = function(x)
            srank = x
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Teleport To Gym",
        Default = "Beginner",
        Save = true,
        Flag = "Teleport To Gym",
        Options = gyms,
        Callback = function(x)
            sgym = x
            teleportToGym(sgym)
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Local Player",
        Icon = "rbxassetid://7072724538",
        PremiumOnly = false
    }
)

local walkspeed

Tab:AddSlider({
	Name = "Walk Speed",
	Min = 0,
	Max = 1000,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Walk Speed",
	Callback = function(x)
        walkspeed = x
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
	end
})

Tab:AddToggle(
    {
        Name = "Loop Speed",
        Default = false,
        Save = true,
        Flag = "Loop Speed",
        Callback = function(val)
            getgenv().Speed = val

            while Speed do
                game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
                end)
            end
        end
    }
)

local jumppower

Tab:AddSlider({
	Name = "Jump Power",
	Min = 0,
	Max = 1000,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Jump Power",
	Callback = function(x)
        jumppower = x
		game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = jumppower
		game:GetService("Players").LocalPlayer.Character.Humanoid.JumpHeight = jumppower
	end
})

Tab:AddToggle(
    {
        Name = "Loop Jump Power",
        Default = false,
        Save = true,
        Flag = "Loop Jump Power",
        Callback = function(val)
            getgenv().juimmpppmpm = val

            while juimmpppmpm do
                game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = walkspeed
                end)
                game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function()
                    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpHeight = walkspeed
                end)
            end
        end
    }
)

local Player = game:GetService'Players'.LocalPlayer;
local UIS = game:GetService'UserInputService';

UIS.InputBegan:Connect(function(UserInput)
    if infiniteJump == true then
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
            Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            Humanoid:ChangeState("Jumping")
            wait(0.1)
            Humanoid:ChangeState("Seated")
        end
    end
end)

Tab:AddToggle(
    {
        Name = "Infinite Jump",
        Default = false,
        Save = true,
        Flag = "Loop Jump Power",
        Callback = function(val)
            getgenv().infiniteJump = val
        end
    }
)

Tab:AddToggle(
    {
        Name = "Fly | E",
        Default = false,
        Save = true,
        Flag = "Loop Jump Power",
        Callback = function(val)
            getgenv().flyToggle = val
        end
    }
)

local Speed = 50


loadstring(game:HttpGet("https://raw.githubusercontent.com/LegitH3x0R/Roblox-Scripts/main/AEBypassing/RootAnchor.lua"))()
local UIS = game:GetService("UserInputService")
local OnRender = game:GetService("RunService").RenderStepped

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Camera = workspace.CurrentCamera
local Root = Character:WaitForChild("HumanoidRootPart")

local C1, C2, C3;
local Nav = {Flying = false, Forward = false, Backward = false, Left = false, Right = false}
C1 = UIS.InputBegan:Connect(function(Input)
    if flyToggle == true then

    if Input.UserInputType == Enum.UserInputType.Keyboard then
        if Input.KeyCode == Enum.KeyCode.E then
            Nav.Flying = not Nav.Flying
            Root.Anchored = Nav.Flying
        elseif Input.KeyCode == Enum.KeyCode.W then
            Nav.Forward = true
        elseif Input.KeyCode == Enum.KeyCode.S then
            Nav.Backward = true
        elseif Input.KeyCode == Enum.KeyCode.A then
            Nav.Left = true
        elseif Input.KeyCode == Enum.KeyCode.D then
            Nav.Right = true
        end
    end
    end
end)

C2 = UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        if Input.KeyCode == Enum.KeyCode.W then
            Nav.Forward = false
        elseif Input.KeyCode == Enum.KeyCode.S then
            Nav.Backward = false
        elseif Input.KeyCode == Enum.KeyCode.A then
            Nav.Left = false
        elseif Input.KeyCode == Enum.KeyCode.D then
            Nav.Right = false
        end
    end
end)

C3 = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
    if Nav.Flying then
        Root.CFrame = CFrame.new(Root.CFrame.Position, Root.CFrame.Position + Camera.CFrame.LookVector)
    end
end)

spawn(function()
    while true do
        local Delta = OnRender:Wait()
        if Nav.Flying and flyToggle == true then
            if Nav.Forward then
                Root.CFrame = Root.CFrame + (Camera.CFrame.LookVector * (Delta * Speed))
            end
            if Nav.Backward then
                Root.CFrame = Root.CFrame + (-Camera.CFrame.LookVector * (Delta * Speed))
            end
            if Nav.Left then
                Root.CFrame = Root.CFrame + (-Camera.CFrame.RightVector * (Delta * Speed))
            end
            if Nav.Right then
                Root.CFrame = Root.CFrame + (Camera.CFrame.RightVector * (Delta * Speed))
            end
        end
    end
end)

local Tab =
    Window:MakeTab(
    {
        Name = "Settings",
        Icon = "rbxassetid://7072721682",
        PremiumOnly = false
    }
)

Tab:AddButton({
	Name = "Join Discord",
	Callback = function()
        success, errorrr = pcall(function()
            local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
            if req then
                req({
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                        Origin = 'https://discord.com'
                    },
                    Body = rhttp:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = rhttp:GenerateGUID(false),
                        args = {code = 'soggy'}
                    })
                })
            end
        end)
        if success then
            OrionLib:MakeNotification({
                Name = "Soggyware",
                Content = "Joining Discord",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "Soggyware",
                Content = "Your Executor Doesn't Support This Function",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
        end
  	end
})