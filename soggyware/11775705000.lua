local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function GrabItem()
    for i,v in next, game:GetService("Workspace").Items:GetDescendants() do
        if v.Name == "ClickDetector" then
            fireclickdetector(v)
            break
        end
    end
end

local function Hold(keyCode, time)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
    task.wait(time)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

local function GrabKeycard()
    local card = game:GetService("Workspace").KeyRoom.Keycard.Root
    Players.LocalPlayer.Character:PivotTo(card:GetPivot())
    task.wait(0.2)
    Hold("E", 5)
end

local function GoToEscape()
    local cam = game:GetService("Workspace").EscapeFolder.POD2.EscapePod.CAM
    Players.LocalPlayer.Character:PivotTo(cam:GetPivot())
end

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "Shopping Wars",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "EST. 2022",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "Shopping Wars"
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
	Name = "Pick Up Items",
	CurrentValue = false,
	Flag = "Auto Farm",
	Callback = function(x)
		getgenv()["Auto Farm"] = x
		while getgenv()["Auto Farm"] do
			task.wait()
			if getgenv()["Auto Farm"] == false then
				return
			end
			pcall(GrabItem)
		end
	end
})

Tab:CreateButton({
    Name = "Go To Keycard",
    Callback = GrabKeycard
})

Tab:CreateButton({
    Name = "Go To Escape",
    Callback = GoToEscape
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)