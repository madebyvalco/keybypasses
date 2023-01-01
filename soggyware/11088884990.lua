local Players = game:GetService("Players")
local Network = loadstring(game:HttpGet("https://soggy-ware.cf/Libs/Utility.lua"))().Network
local Player = Players.LocalPlayer
local Position = CFrame.new(-509.242157, 19.1046352, 282.699615, -1.90476896e-06, -1.21321094e-07, -1, 4.71474582e-10, 1, -1.21321094e-07, 1, -4.71705675e-10, -1.90476896e-06)

local function Farm()
    Player.Character:PivotTo(Position)
    Network:Fire("Start")
end

local function GetEggs()
    local a = {}
    for i,v in next, game:GetService("Workspace").Eggs:GetChildren() do
        table.insert(a, v.Name)
    end
    return a
end

local function Click()
    Network:Fire("Click")
end

local function Hatch()
    Network:Call("EggOpened", getgenv().egg, getgenv().amount)
end

local function Chests()
    for i,v in next, game:GetService("Workspace").Chests:GetDescendants() do
        if v.Name == "ProximityPrompt" then
            fireproximityprompt(v)
        end
    end
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Goal Clicker",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Goal Clicker"
    },
    Discord = {
        Enabled = true,
        Invite = "bBZxdAhS9J",
        RememberJoins = true
    }
})
local Tab = Window:CreateTab("Home Tab", 11600721595)

Tab:CreateSection("Information")
Tab:CreateLabel("Release")

local Tab = Window:CreateTab("Farming Tab", 11696994871)

Tab:CreateSection("Farming")

Tab:CreateToggle({
	Name = "Auto Kick",
	CurrentValue = false,
	Flag = "Auto Kick",
	Callback = function(x)
		getgenv()["Auto Kick"] = x
        while getgenv()["Auto Kick"] do
            task.wait()
            if getgenv()["Auto Kick"] == false then return end
            pcall(Farm)
        end
    end
})

Tab:CreateToggle({
	Name = "Auto Click",
	CurrentValue = false,
	Flag = "Auto Click",
	Callback = function(x)
		getgenv()["Auto Click"] = x
        while getgenv()["Auto Click"] do
            task.wait()
            if getgenv()["Auto Click"] == false then return end
            pcall(Click)
        end
    end
})

local Tab = Window:CreateTab("Pet Tab", 11600742450)

local Section = Tab:CreateSection("Eggs")

Tab:CreateToggle({
	Name = "Auto Hatch",
	CurrentValue = false,
	Flag = "Auto Hatch",
	Callback = function(x)
		getgenv()["Auto Hatch"] = x
        while getgenv()["Auto Hatch"] do
            if getgenv()["Auto Hatch"] == false then
                return
            end
            task.wait()
            pcall(Hatch)
        end
	end
})

Tab:CreateToggle({
	Name = "Triple Hatch",
	CurrentValue = false,
	Flag = "Triple Hatch",
	Callback = function(x)
        getgenv().amount = (x == true and "Triple" or x == false and "Single")
	end
})

Tab:CreateDropdown({
	Name = "Select Egg",
	Options = GetEggs(),
	CurrentOption = GetEggs()[1],
	Flag = "Select Egg",
	Callback = function(x)
		getgenv().egg = x
	end,
})

local Tab = Window:CreateTab("Misc Tab", 11600761450)

Tab:CreateSection("Chests")

Tab:CreateToggle({
	Name = "Auto Chests",
	CurrentValue = false,
	Flag = "Auto Chests",
	Callback = function(x)
		getgenv()["Auto Chests"] = x
        while getgenv()["Auto Chests"] do
            task.wait()
            if getgenv()["Auto Chests"] == false then return end
            pcall(Chests)
        end
    end
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)