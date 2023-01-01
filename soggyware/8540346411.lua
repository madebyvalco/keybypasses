local plr = game:GetService("Players").LocalPlayer

local eggs = {}

local rebirths = {}
local srebirth

function click()
    game:GetService("ReplicatedStorage").Events.Click3:FireServer()
end

for i, v in next, game:GetService("Players").LocalPlayer.PlayerGui.MainUI.RebirthFrame.Top.Holder:GetDescendants() do
    if v.ClassName == "TextLabel" and v.Name == "Label" and v.Parent.Name == "Main" then
        table.insert(rebirths, v.Text)
    end
end

function rebirth()
    for i, v in next, game:GetService("Players").LocalPlayer.PlayerGui.MainUI.RebirthFrame.Top.Holder:GetDescendants() do
        if v.ClassName == "TextLabel" and v.Name == "Label" and v.Parent.Name == "Main" then
            if v.Text == srebirth then
                local args = {
                    [1] = tonumber(v.Parent.Parent.Name)
                }
                game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(unpack(args))
            end
        end
    end
end

local amounts = {"Single", "Triple"}

function egg(name, amount)
    local args = {
        [1] = name,
        [2] = amount
    }

    game:GetService("ReplicatedStorage").Functions.Unbox:InvokeServer(unpack(args))
end

function gamepass()
    for i, v in next, plr.Passes:GetChildren() do
        v.Value = true
    end
end

function spin()
    game:GetService("ReplicatedStorage").Functions.Spin:InvokeServer()
end

function buyClickSkins()
    for i = 1, 12 do
        local args = {
            [1] = i
        }
        game:GetService("ReplicatedStorage").Functions.TapSkin:InvokeServer(unpack(args))
    end
end

function getCoconuts()
    for i, v in next, game:GetService("Workspace").Scripts.CoconutsFolder.Storage:GetDescendants() do
        if v.Name == "TouchInterest" and v.Parent then
            for i = 0, 1 do
                firetouchinterest(plr.Character.HumanoidRootPart, v.Parent, i)
            end
        end
    end
end

function unlockWorld()
    for i, v in next, game:GetService("Workspace").Scripts.Portals:GetDescendants() do
        if v.Name == "Unlocked" and v.Value == false then
            v.Value = true
        end
    end
end

function collectChests()
    for i, v in next, game:GetService("Workspace").Scripts.Chests:GetDescendants() do
        if v.Name == "TouchInterest" and v.Parent then
            for i = 0, 1 do
                firetouchinterest(plr.Character.HumanoidRootPart, v.Parent, i)
            end
        end
    end
end

for i, v in next, game:GetService("Workspace").Scripts.Eggs:GetChildren() do
    table.insert(eggs, v.Name)
end

local worlds = {}

function teleporToWorld(x)
    plr.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Scripts.TeleportTo[x].CFrame
end

for i, v in next, game:GetService("Workspace").Scripts.TeleportTo:GetChildren() do
    table.insert(worlds, v.Name)
end

function craftAll()
    local args = {
        [1] = "CraftAll",
        [2] = {}
    }

    game:GetService("ReplicatedStorage").Functions.Request:InvokeServer(unpack(args))
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
        Flag = "Click",
        Callback = function(val)
            getgenv().Click = val

            while Click do
                if Click == true then
                    click()
                    task.wait()
                elseif Click == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Rebirth",
        Default = false,
        Save = true,
        Flag = "Rebirth",
        Callback = function(val)
            getgenv().Rebirthhhhh = val

            while Rebirthhhhh do
                if Rebirthhhhh == true then
                    rebirth()
                    task.wait(2)
                elseif Rebirthhhhh == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Rebirth",
        Default = "",
        Save = true,
        Flag = "Select Rebirth",
        Options = rebirths,
        Callback = function(x)
            srebirth = x
        end
    }
)

local segg
local samount

Tab:AddToggle(
    {
        Name = "Open Egg",
        Default = false,
        Save = true,
        Flag = "Open Egg",
        Callback = function(val)
            getgenv().Egg = val

            while Egg do
                if Egg == true then
                    egg(segg, samount)
                    task.wait()
                elseif Egg == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Egg Amount",
        Default = "",
        Save = true,
        Flag = "Select Egg Amount",
        Options = amounts,
        Callback = function(x)
            samount = x
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Select Egg",
        Default = "",
        Save = true,
        Flag = "Select Egg",
        Options = eggs,
        Callback = function(x)
            segg = x
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Events + Misc",
        Icon = "rbxassetid://7072715317",
        PremiumOnly = false
    }
)

Tab:AddToggle(
    {
        Name = "Collect Coconuts",
        Default = false,
        Save = true,
        Flag = "Collect Coconuts",
        Callback = function(val)
            getgenv().Coconuts = val

            while Coconuts do
                if Coconuts == true then
                    getCoconuts(segg, samount)
                    task.wait()
                elseif Coconuts == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Unlock Worlds",
        Default = false,
        Save = true,
        Flag = "Unlock Worlds",
        Callback = function(val)
            getgenv().Worlds = val

            while Worlds do
                if Worlds == true then
                    unlockWorld()
                    task.wait()
                elseif Worlds == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Buy Click Skins",
        Default = false,
        Save = true,
        Flag = "Buy Click Skins",
        Callback = function(val)
            getgenv().Skins = val

            while Skins do
                if Skins == true then
                    buyClickSkins()
                    task.wait()
                elseif Skins == false then
                    break
                end
            end
        end
    }
)

Tab:AddDropdown(
    {
        Name = "Teleport To World",
        Default = "",
        Save = true,
        Flag = "Teleport To World",
        Options = worlds,
        Callback = function(x)
            teleporToWorld(x)
        end
    }
)

Tab:AddButton(
    {
        Name = "Gamepasses",
        Callback = function()
            gamepass()
        end
    }
)

Tab:AddToggle(
    {
        Name = "Craft All Pets",
        Default = false,
        Save = true,
        Flag = "Craft All Pets",
        Callback = function(val)
            getgenv().Craft = val

            while Craft do
                if Craft == true then
                    craftAll()
                    task.wait()
                elseif Craft == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Collect Chests",
        Default = false,
        Save = true,
        Flag = "Collect Chests",
        Callback = function(val)
            getgenv().Chests = val

            while Chests do
                if Chests == true then
                    collectChests()
                    task.wait()
                elseif Chests == false then
                    break
                end
            end
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