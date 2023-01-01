function click()
    game:GetService("ReplicatedStorage").Events.Tap:FireServer()
end

function egg(egg, amount)
    local args = {
        [1] = {},
        [2] = egg,
        [3] = amount
    }
    game:GetService("ReplicatedStorage").Events.HatchEgg:InvokeServer(unpack(args))    
end

local eggs = {}

for i,v in next, game:GetService("Workspace").Shops:GetChildren() do
    if string.match(v.Name, "Egg") and not string.match(v.Name, "Robux") then
        table.insert(eggs, v.Name)
    end
end

function gamepass()
    require(game:GetService("ReplicatedStorage").Classes.Player).ownsGamePass = function() return true end
end

local codes = {"testing", "release", "update1", "update2", "15KLIKESTHANKYOU"}

function redeemCodes()
    for i = 1,#codes do 
        local args = {
            [1] = codes[i]
        }
        game:GetService("ReplicatedStorage").Events.ClaimCode:FireServer(unpack(args))        
    end
end

local rebirths = {}
local srebirth

for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.UI.Rebirth.ScrollingContainer.ScrollingFrame:GetDescendants() do
    if v.Name == "Rebirth" then
        table.insert(rebirths, v.Text)
    end
end

function rebirth()
    local args = {
        [1] = returnRebirth()
    }

    game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(unpack(args))
end

function returnRebirth()
    for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.UI.Rebirth.ScrollingContainer.ScrollingFrame:GetDescendants() do
        if v.Name == "Rebirth" and v.Text == srebirth then
            return tonumber(string.gsub(v.Text, "%D", ""))
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
            getgenv().Rebirth = val

            while Rebirth do
                if Rebirth == true then
                    rebirth()
                    task.wait()
                elseif Rebirth == false then
                    break
                end
            end
        end
    }
)

local segg

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
                    egg(segg, 1)
                    task.wait()
                elseif Egg == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Triple Open Egg",
        Default = false,
        Save = true,
        Flag = "Triple Open Egg",
        Callback = function(val)
            getgenv().TripleEgg = val

            while TripleEgg do
                if TripleEgg == true then
                    egg(segg, 2)
                    task.wait()
                elseif TripleEgg == false then
                    break
                end
            end
        end
    }
)

Tab:AddToggle(
    {
        Name = "Quad Open Egg",
        Default = false,
        Save = true,
        Flag = "Quad Open Egg",
        Callback = function(val)
            getgenv().QuadEgg = val

            while QuadEgg do
                if QuadEgg == true then
                    egg(segg, 3)
                    task.wait()
                elseif QuadEgg == false then
                    break
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

Tab:AddButton(
    {
        Name = "Get Gamepasses",
        Callback = function()
        require(game:GetService("ReplicatedStorage").Classes.PurchaseNotification).new("All Gamepasses Thanks To Soggyware", "")
           gamepass()
        end
    }
)

Tab:AddButton(
    {
        Name = "Redeem Codes",
        Callback = function()
           redeemCodes()
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "GUIS",
        Icon = "rbxassetid://7072716095",
        PremiumOnly = false
    }
)

local uiNames =  {}

for i,v in next, game:GetService("Players").LocalPlayer.PlayerGui.UI:GetChildren() do
    if v:IsA("Frame") then
        table.insert(uiNames, v.Name)
    end
end

Tab:AddDropdown(
    {
        Name = "Open / Close UI",
        Default = "",
        Save = true,
        Flag = "Open UI",
        Options = uiNames,
        Callback = function(x)
            if not game:GetService("Players").LocalPlayer.PlayerGui.UI[x].Visible then
                game:GetService("Players").LocalPlayer.PlayerGui.UI[x].Visible = true
            else
                game:GetService("Players").LocalPlayer.PlayerGui.UI[x].Visible = false
            end
        end
    }
)

local Tab =
    Window:MakeTab(
    {
        Name = "Hatch Pets",
        Icon = "rbxassetid://7072717639",
        PremiumOnly = false
    }
)

local petsToChooseFrom = {}

for i,v in next, game:GetService("ReplicatedStorage").Assets.Pets:GetChildren() do
    table.insert(petsToChooseFrom, v.Name)
end

Tab:AddDropdown(
    {
        Name = "Hatch Pet",
        Default = "",
        Save = true,
        Flag = "Hatch Pet",
        Options = petsToChooseFrom,
        Callback = function(x)
            local pets = {}
            for i = 1,3 do
                table.insert(pets, x)
            end
            require(game:GetService("ReplicatedStorage").Classes.EggAnimation).new("Beach Egg", pets)
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
        end
    }
)

game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if not getgenv().Speed then return end
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = walkspeed
end)

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
        end
    }
)

game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
    if not getgenv().juimmpppmpm then return end
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = walkspeed
end)
game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function()
    if not getgenv().juimmpppmpm then return end
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpHeight = walkspeed
end)

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
                        args = {code = 'https://discord.gg/FwSW5tT3wD'}
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

        success, errorrr = pcall(function()
            local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request
            if req then
                req({
                    Url = 'http://127.0.0.1:6463/rpc?v=1',
                    Method = 'POST',
                    Headers = {
                        ['Content-Type'] = 'application/json',
                        Origin = 'https://discord.com'
                    },
                    Body = game.HttpService:JSONEncode({
                        cmd = 'INVITE_BROWSER',
                        nonce = game.HttpService:GenerateGUID(false),
                        args = {code = 'https://discord.gg/FwSW5tT3wD'}
                    })
                })
            end
        end)

require(game:GetService("ReplicatedStorage").Classes.Notification).new("Thank you for using Soggyware\n Please Subscribe to my new channel it is set to your clipboard", {["subcribe + join discord pls everything got terminated"] = ""})
setclipboard("youtube.com/channel/@Soggyware")