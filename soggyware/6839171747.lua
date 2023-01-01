repeat
	task.wait()
until game:IsLoaded()

local rawmetmeta = getrawmetatable(game)
local oldfthing = rawmetmeta.__index
setreadonly(rawmetmeta, false)
rawmetmeta.__index = newcclosure(function(a, b)
	if b == "WalkSpeed" then
		return 10
	end
	if b == "JumpPower" then
		return 50
	end
	return oldfthing(a, b)
end)
setreadonly(rawmetmeta, true)

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
local Window = Rayfield:CreateWindow({
    Name = "DOORS 👁️",
    LoadingTitle = "Soggyware",
    LoadingSubtitle = "- Soggyware Team",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "Soggyware",
        FileName = "DOORS"
    },
    Discord = {
        Enabled = true,
        Invite = "bBZxdAhS9J",
        RememberJoins = true
    }
})

local Tab = Window:CreateTab("Home Tab", 11600721595)

local Section = Tab:CreateSection("Information")
Tab:CreateLabel("Release | V1.0")

local lplr = game:GetService("Players").LocalPlayer;
local keyrange, leverrange, lockpickrange, bookrange, bandagerange, lighterrange, flashlightrange = 15, 15, 15, 15, 15, 15, 15
local bullshittable = {
	KeyObtain = {},
	LeverForGate = {},
	LiveHintBook = {}
}
local prompttable = {
	"KeyObtain",
	"LeverForGate",
	"LiveHintBook",
}
task.spawn(function()
	game.Workspace.ChildAdded:Connect(function(v)
		if v:IsA("Model") and NotifyMobs == true then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Monster Spawned.";
                Text = v.Name.."!";
            })
			task.wait(5)
		end
	end)
end)
local function outline(dad)
	local esp = Instance.new("Highlight")
	esp.Name = "Outline"
	esp.FillTransparency = 1
	esp.FillColor = Color3.new(0, 0.431372, 1)
	esp.OutlineColor = Color3.new(255,255,255)
	esp.OutlineTransparency = 0
	esp.Parent = dad
end
function getbullshit()
	local function getname(a)
		return bullshittable[a.Parent.Name]
	end
	local function checkifstillthere(a)
		for _, v in pairs(a) do
			if v.Parent == nil then
				table.remove(a, i)
			end
		end
	end
	while task.wait(1) do
		for _, v in pairs(game:GetService("Workspace").CurrentRooms:GetDescendants()) do
			if v:IsA("ProximityPrompt") and table.find(prompttable, v.Parent.Name) then
				table.insert(getname(v), v)
			end
		end
		for _, v in pairs(bullshittable) do
			checkifstillthere(v)
		end
	end
end
coroutine.wrap(getbullshit)()

local Tab = Window:CreateTab("Main Tab", 11600741115)

Tab:CreateSection("Key Aura")

Tab:CreateToggle({
	Name = "Key Aura",
	CurrentValue = false,
	Flag = "Key Aura",
	Callback = function(x)
		getgenv()["Key Aura"] = x
		while getgenv()["Key Aura"] do
			task.wait()
			if getgenv()["Key Aura"] == false then
				return
			end
            for _, v in pairs(bullshittable.KeyObtain) do
                pcall(function()
                    local mag = (lplr.Character.HumanoidRootPart.Position - v.Parent.Hitbox.Position).magnitude
                    if mag < keyrange then
                        fireproximityprompt(v)
                    end
                end)
            end
		end
	end
})

Tab:CreateSlider({
	Name = "Key Aura Range",
	Range = {
		1,
		50
	},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 25,
	Flag = "Key Aura Range",
	Callback = function(x)
		keyrange = x
	end
})

Tab:CreateSection("Lever Aura")

Tab:CreateToggle({
	Name = "Lever Aura",
	CurrentValue = false,
	Flag = "Lever Aura",
	Callback = function(x)
		getgenv()["Lever Aura"] = x
		while getgenv()["Lever Aura"] do
			task.wait()
			if getgenv()["Lever Aura"] == false then
				return
			end
            for _, v in pairs(bullshittable.LeverForGate) do
                pcall(function()
                    local mag = (lplr.Character.HumanoidRootPart.Position - v.Parent.Main.Position).magnitude
                    if mag < leverrange then
                        fireproximityprompt(v)
                    end
                end)
            end
		end
	end
})

Tab:CreateSlider({
	Name = "Lever Aura Range",
	Range = {
		1,
		50
	},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 25,
	Flag = "Lever Aura Range",
	Callback = function(x)
		leverrange = x
	end
})

Tab:CreateSection("Book Aura")

Tab:CreateToggle({
	Name = "Book Aura",
	CurrentValue = false,
	Flag = "Book Aura",
	Callback = function(x)
		getgenv()["Book Aura"] = x
		while getgenv()["Book Aura"] do
			task.wait()
			if getgenv()["Book Aura"] == false then
				return
			end
            for _, v in pairs(bullshittable.LiveHintBook) do
                pcall(function()
                    local mag = (lplr.HumanoidRootPart.Position - v.Parent.Cover2.Position).magnitude
                    if mag < bookrange then
                        fireproximityprompt(v)
                    end
                end)
            end
		end
	end
})

Tab:CreateSlider({
	Name = "Book Aura Range",
	Range = {
		1,
		50
	},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 25,
	Flag = "Book Aura Range",
	Callback = function(x)
		bookrange = x
	end
})

local Tab = Window:CreateTab("Lighting Tab", 11600768979)

Tab:CreateSection("Full Bright")

loadstring(game:HttpGet("https://pastebin.com/raw/06iG6YkU"))()
Tab:CreateToggle({
	Name = "Full Bright",
	CurrentValue = false,
	Flag = "Full Bright",
	Callback = function(x)
        _G.FullBrightExecuted = x
	end
})

local Tab = Window:CreateTab("Object ESP Tab", 11600768979)

Tab:CreateSection("Key ESP")

local keyesp
Tab:CreateToggle({
	Name = "Key ESP",
	CurrentValue = false,
	Flag = "Key ESP",
	Callback = function(x)
        keyesp = val
        if keyesp then
            repeat
                task.wait(.25)
                for i, v in pairs(bullshittable.KeyObtain) do
                    pcall(function()
                        if not v.Parent:FindFirstChild("Outline") then
                            if keyesp then
                                outline(v.Parent)
                            end
                        end
                    end)
                end
            until not keyesp
        else
            for i, v in pairs(bullshittable.KeyObtain) do
                pcall(function()
                    v.Parent.Outline:Destroy()
                end)
            end
        end
	end
})

Tab:CreateSection("Lever ESP")

local leveresp
Tab:CreateToggle({
	Name = "Lever ESP",
	CurrentValue = false,
	Flag = "Lever ESP",
	Callback = function(x)
        leveresp = x
        if leveresp then
            repeat
                task.wait(.25)
                for i, v in pairs(bullshittable.LeverForGate) do
                    pcall(function()
                        if not v.Parent:FindFirstChild("Outline") then
                            if leveresp then
                                outline(v.Parent)
                            end
                        end
                    end)
                end
            until not leveresp
        else
            for i, v in pairs(bullshittable.LeverForGate) do
                pcall(function()
                    v.Parent.Outline:Destroy()
                end)
            end
        end
	end
})

Tab:CreateSection("Book ESP")

local bookesp
Tab:CreateToggle({
	Name = "Book ESP",
	CurrentValue = false,
	Flag = "Book ESP",
	Callback = function(x)
        bookesp = val
        if bookesp then
            repeat
                task.wait(.25)
                for i, v in pairs(bullshittable.LiveHintBook) do
                    pcall(function()
                        if not v.Parent:FindFirstChild("Outline") then
                            if bookesp then
                                outline(v.Parent)
                            end
                        end
                    end)
                end
            until not bookesp
        else
            for i, v in pairs(bullshittable.LiveHintBook) do
                pcall(function()
                    v.Parent.Outline:Destroy()
                end)
            end
        end
	end
})

loadstring(game:HttpGet("https://soggy-ware.cf/Libs/RayfieldTabs.lua"))()(Window)