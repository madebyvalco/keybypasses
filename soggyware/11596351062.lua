local Players      = game:GetService("Players")
local LocalPlayer  = Players.LocalPlayer
local Sprint       = LocalPlayer.Data.Sprint
local Util         = loadstring(game:HttpGet("https://soggy-ware.cf/Libs/Utility.lua"))()
local Network      = Util.Network
local Tycoon       = nil
local TweenService = game:GetService("TweenService")
local Workspace    = game:GetService("Workspace")
local noclipE      = nil
local antifall     = nil
local NPCS         = Workspace.NPCS
local Vim          = Util("VirtualInputManager")

local function noclip()
	for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if v:IsA("BasePart") and v.CanCollide == true then
			v.CanCollide = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
		end
	end
end

local function Hold(keyCode, time)
	Vim:SendKeyEvent(true, keyCode, false, game)
	task.wait(time)
	Vim:SendKeyEvent(false, keyCode, false, game)
end

local function MoveTo(obj, speed)
	if typeof(obj) == "Instance" then
		if obj:IsA("BasePart") then
			obj = obj.CFrame
		elseif obj:IsA("Model") then
			obj = obj:GetPivot()
		end
	end
	local info = TweenInfo.new(
        (LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude / speed,
        Enum.EasingStyle.Linear
    )
	local tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart, info, {
		CFrame = obj
	})
	if not LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") then
		antifall = Instance.new("BodyVelocity", LocalPlayer.Character.HumanoidRootPart)
		antifall.Velocity = Vector3.new(0, 0, 0)
		noclipE = game:GetService("RunService").Stepped:Connect(noclip)
		tween:Play()
	end
	tween.Completed:Connect(function()
		antifall:Destroy()
		noclipE:Disconnect()
	end)
end

local function GetTycoon()
	for i, v in next, Workspace.Tycoons:GetChildren() do
		if v:IsA("Folder") then
			if v.Name:find("%d+") then
				if v:FindFirstChild("TycoonOwner") then
					if v.TycoonOwner.Value == LocalPlayer.Name then
						return v
					end
				end
			end
		end
	end
end

Tycoon = GetTycoon()

local function GiveSpeed()
	Sprint.Value = 1
end

local function HasCDs()
	return LocalPlayer.Data.CDs.Value > 0
end

local function GetCD()
	local Prompt = (function()
		for i, v in next, Tycoon.StaticItems.CDCollect:GetChildren() do
			if v:FindFirstChild("ProximityPrompt") then
				return v.ProximityPrompt
			end
		end;
	end)()
	MoveTo(Prompt.Parent, 500)
	task.wait(0.1)
	Network:Fire("GenerateNumber")
	Network:Fire("CDs")
	task.wait(0.1)
	fireproximityprompt(Prompt)
end

local function SellCD()
	if HasCDs() == false then
		GetCD()
		return
	end
	for i, v in next, NPCS:GetChildren() do
		task.wait(0.05)
		if HasCDs() == false then
			GetCD()
			break
		end
		if v:IsA("Model") then
			if v:FindFirstChild("HumanoidRootPart") then
				MoveTo(v.HumanoidRootPart, 500)
				task.wait(0.1)
				fireproximityprompt(v.Torso.ProximityPrompt)
			end
		end
	end
end

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "prove mom wrong by being a famous rapper tycoon",
	LoadingTitle = "Soggyware",
	LoadingSubtitle = "- EST.2022 -",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Soggyware",
		FileName = "prove mom wrong by being a famous rapper tycoon"
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

local A = Tab:CreateLabel("Waiting For You To Get A Tycoon")

repeat task.wait() until GetTycoon()

Tycoon = GetTycoon()

A:Set("Enjoy Soggyware")

local Tab = Window:CreateTab("Farming Tab", 11767473695)

Tab:CreateSection("Farming")

Tab:CreateToggle({
	Name = "Auto Farm",
	CurrentValue = false,
	Flag = "Auto Farm",
	Callback = function(x)
		getgenv()["Auto Farm"] = x
        while getgenv()["Auto Farm"] do
            task.wait()
            if getgenv()["Auto Farm"] == false then return end
            pcall(SellCD)
        end
    end
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)

Rayfield:LoadConfiguration()