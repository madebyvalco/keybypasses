--Window
local ZapLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = ZapLib:MakeWindow({Name = "ZapHub | 🍄STEEP STEPS | Cracked by grimcity", IntroText = "ZapHub", IntroIcon = "rbxassetid://12102360541", HidePremium = false, SaveConfig = false})
 
--Notifying
ZapLib:MakeNotification({
	Name = "Welcome to ZapHub!",
	Content = "Discord: dsc.gg/grimcity"
	Image = "rbxassetid://12102363922",
	Time = 10
})
 
--Tabs
local Player = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://12254420622",
	PremiumOnly = false
})

local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://12102367320",
	PremiumOnly = false
})
 
local Teleport = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://12102368940",
	PremiumOnly = false
})

local TeleportBypass = Window:MakeTab({
	Name = "Teleport Bypass",
	Icon = "rbxassetid://12102368940",
	PremiumOnly = false
})

local Fly = Window:MakeTab({
	Name = "Fly (Patched)",
	Icon = "rbxassetid://12254425065",
	PremiumOnly = false
})
 
local AutoBadge = Window:MakeTab({
	Name = "Auto Badge",
	Icon = "rbxassetid://12254427956",
	PremiumOnly = false
})

local Credits = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://12102365116",
	PremiumOnly = false
})
 
local UpdateLog = Window:MakeTab({
	Name = "Update Log",
	Icon = "rbxassetid://12102368069",
	PremiumOnly = false
})
 
--In Player Tab
repeat wait() until game:IsLoaded() 

local index = getrawmetatable(game).__index
setreadonly(getrawmetatable(game),false)
getrawmetatable(game).__index = newcclosure(function(bypassenabler,walkspeedbypass)
    if walkspeedbypass == "WalkSpeed" then
        return getrenv()._G.CurrentWS
    end
    return index(bypassenabler, walkspeedbypass)
end)

local HumanModCons = {}
local HumanModConss = {}

Player:AddSlider({
	Name = "Walk Speed",
	Min = 0,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(70,70,70),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(newValue)
		local Char = game.Players.LocalPlayer.Character or workspace:FindFirstChild(game.Players.LocalPlayer.Name)
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		local function WalkSpeedChange()
			if Char and Human then
				Human.WalkSpeed = newValue
			end
		end
		WalkSpeedChange()
		HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
		HumanModCons.wsCA = (HumanModCons.wsCA and HumanModCons.wsCA:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(nChar)
			Char, Human = nChar, nChar:WaitForChild("Humanoid")
			WalkSpeedChange()
			HumanModCons.wsLoop = (HumanModCons.wsLoop and HumanModCons.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal("WalkSpeed"):Connect(WalkSpeedChange)
		end)
	end    
})

Player:AddSlider({
	Name = "Jump Power",
	Min = 0,
	Max = 150,
	Default = 0,
	Color = Color3.fromRGB(70,70,70),
	Increment = 1,
	ValueName = "Power",
	Callback = function(newValue)
		local Char = game.Players.LocalPlayer.Character or workspace:FindFirstChild(game.Players.LocalPlayer.Name)
		local Human = Char and Char:FindFirstChildWhichIsA("Humanoid")
		local function JumpPowerChange()
			if Char and Human then
				Human.JumpPower = newValue
			end
		end
		JumpPowerChange()
		HumanModConss.wsLoop = (HumanModConss.wsLoop and HumanModConss.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal("JumpPower"):Connect(JumpPowerChange)
		HumanModCons.wsCA = (HumanModConss.wsCA and HumanModConss.wsCA:Disconnect() and false) or game.Players.LocalPlayer.CharacterAdded:Connect(function(nChar)
			Char, Human = nChar, nChar:WaitForChild("Humanoid")
			JumpPowerChange()
			HumanModConss.wsLoop = (HumanModConss.wsLoop and HumanModConss.wsLoop:Disconnect() and false) or Human:GetPropertyChangedSignal("JumpPower"):Connect(JumpPowerChange)
		end)
	end    
})
 
--In Misc Tab
Misc:AddButton({
	Name = "Fps Booster",
	Default = false,
	Callback = function(Value)
		_G.Settings = {
            Players = {
                ["Ignore Me"] = true, -- Ignore your Character
                ["Ignore Others"] = true-- Ignore other Characters
            },
            Meshes = {
                Destroy = false, -- Destroy Meshes
                LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
            },
            Images = {
                Invisible = true, -- Invisible Images
                LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
                Destroy = false, -- Destroy Images
            },
            ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
            ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
            ["No Explosions"] = true, -- Makes Explosion's invisible
            ["No Clothes"] = true, -- Removes Clothing from the game
            ["Low Water Graphics"] = true, -- Removes Water Quality
            ["No Shadows"] = true, -- Remove Shadows
            ["Low Rendering"] = true, -- Lower Rendering
            ["Low Quality Parts"] = true -- Lower quality parts
        }
        local Players = game:GetService("Players")
        local BadInstances = {"DataModelMesh", "FaceInstance", "ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles", "PostEffect", "Explosion", "Clothing", "BasePart"}
        local CanBeEnabled = {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles", "PostEffect"}
        local function PartOfCharacter(Instance)
            for i, v in pairs(Players:GetPlayers()) do
                if v.Character and Instance:IsDescendantOf(v.Character) then
                    return true
                end
            end
            return false
        end
        local function ReturnDescendants()
            local Descendants = {}
            WaitNumber = 5000
            if _G.Settings.Players["Ignore Others"] then
                for i, v in pairs(game:GetDescendants()) do
                    if not v:IsDescendantOf(Players) and not PartOfCharacter(v) then
                        for i2, v2 in pairs(BadInstances) do
                            if v:IsA(v2) then
                                table.insert(Descendants, v)
                            end
                        end
                    end
                    if i == WaitNumber then
                        task.wait()
                        WaitNumber = WaitNumber + 5000
                    end
                end
            elseif _G.Settings.Players["Ignore Me"] then
                for i, v in pairs(game:GetDescendants()) do
                    if not v:IsDescendantOf(Players) and not v:IsDescendantOf(ME.Character) then
                        for i2, v2 in pairs(BadInstances) do
                            if v:IsA(v2) then
                                table.insert(Descendants, v)
                            end
                        end
                    end
                    if i == WaitNumber then
                        task.wait()
                        WaitNumber = WaitNumber + 5000
                    end
                end
            end
            return Descendants
        end
        local function CheckIfBad(Instance)
            if not Instance:IsDescendantOf(Players) and not PartOfCharacter(Instance) then
                if Instance:IsA("DataModelMesh") then
                    if _G.Settings.Meshes.LowDetail then
                        sethiddenproperty(Instance, "LODX", Enum.LevelOfDetailSetting.Low)
                        sethiddenproperty(Instance, "LODY", Enum.LevelOfDetailSetting.Low)
                    elseif _G.Settings.Meshes.Destroy then
                        Instance:Destroy()
                    end
                elseif Instance:IsA("FaceInstance") then
                    if _G.Settings.Images.Invisible then
                        Instance.Transparency = 1
                    elseif _G.Settings.Images.LowDetail then
                        Instance.Shiny = 1
                    elseif _G.Settings.Images.Destroy then
                        Instance:Destroy()
                    end
                elseif table.find(CanBeEnabled, Instance.ClassName) then
                    if _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["No Particles"]) then
                        Instance.Enabled = false
                    end
                elseif Instance:IsA("Explosion") then
                    if _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) then
                        Instance.Visible = false
                    end
                elseif Instance:IsA("Clothing") then
                    if _G.Settings["No Clothes"] or (_G.Settings.Other and _G.Settings.Other["No Clothes"]) then
                        Instance:Destroy()
                    end
                elseif Instance:IsA("BasePart") then
                    if _G.Settings["Low Quality Parts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Parts"]) then
                        Instance.Material = Enum.Material.Plastic
                        Instance.Reflectance = 0
                    end
                end
            end
        end
        if _G.Settings["Low Water Graphics"] or (_G.Settings.Other and _G.Settings.Other["Low Water Graphics"]) then
            workspace:FindFirstChildOfClass("Terrain").WaterWaveSize = 0
            workspace:FindFirstChildOfClass("Terrain").WaterWaveSpeed = 0
            workspace:FindFirstChildOfClass("Terrain").WaterReflectance = 0
            workspace:FindFirstChildOfClass("Terrain").WaterTransparency = 0
        end
        if _G.Settings["No Shadows"] or (_G.Settings.Other and _G.Settings.Other["No Shadows"]) then
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").FogEnd = 9e9
        end
        if _G.Settings["Low Rendering"] or (_G.Settings.Other and _G.Settings.Other["Low Rendering"]) then
            settings().Rendering.QualityLevel = 1
        end
        ZapLib:MakeNotification({
            Name = "Loading Fps Booster",
            Content = "Discord: discord.gg/8kZ9fBVmwQ",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
        local Descendants = ReturnDescendants()
        local WaitNumber = 500
        ZapLib:MakeNotification({
            Name = "Checking " .. #Descendants .. " Instances...",
            Content = "Discord: discord.gg/8kZ9fBVmwQ",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
        for i, v in pairs(Descendants) do
            CheckIfBad(v)
            print("Loaded " .. i .. "/" .. #Descendants)
            if i == WaitNumber then
                task.wait()
                WaitNumber = WaitNumber + 500
            end
        end
        ZapLib:MakeNotification({
            Name = "Fps Booster Loaded",
            Content = "Discord: discord.gg/8kZ9fBVmwQ",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
        game.DescendantAdded:Connect(CheckIfBad)
    end
})
 
Misc:AddButton({
	Name = "Delete Fog",
	Default = false,
	Callback = function(Value)
		game.Lighting.Fog:Destroy()
	end	  
})
 
Misc:AddParagraph("Warning","To use the 'Retrive Ladder' option, first you have to uncheck the ladder box in your inventory (by tapping the 1 key or with the mouse by tapping the box to place the ladder) it is important that it is unchecked, if so tap the option and you are done.")
 
Misc:AddButton({
	Name = "Retrive Ladder",
	Default = false,
	Callback = function(Value)
		game.Players.LocalPlayer.Backpack:FindFirstChild("Ladder").Parent = game.Players.LocalPlayer.Character  
		CF = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = 				 
        game:GetService("Workspace").playerPlaced[game.Players.LocalPlayer.Name.."_ladder"]:FindFirstChildOfClass("Part").CFrame
		wait(.2)
		workspace.live[game.Players.LocalPlayer.Name].Ladder.Event:FireServer("Destroy", 		 
        game:GetService("Workspace").playerPlaced[game.Players.LocalPlayer.Name.."_ladder"])
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CF
        game.Players.LocalPlayer.Character.Humanoid:ChangeState(7)
	end	  
})
 
Misc:AddButton({
	Name = "Non Slippery Ice",
	Default = false,
	Callback = function(Value)
		for i,v in pairs(game.Workspace.Map.SpecialParts:GetChildren()) do
            if v.Name == "ice" then
            v.CustomPhysicalProperties = nil
            end
        end
	end	  
})
 
Misc:AddParagraph("Warning","Be careful when using 'Click to Teleport', the game has added invisible walls that can make you fall or return when you use it.")
 
Misc:AddButton({
	Name = "Tool: Click to Teleport",
	Default = false,
	Callback = function(Value)
		local plr = game:GetService("Players").LocalPlayer
        local mouse = plr:GetMouse()
 
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Click Teleport"
 
        tool.Activated:Connect(function()
        local root = plr.Character.HumanoidRootPart
        local pos = mouse.Hit.Position+Vector3.new(0,2.5,0)
        local offset = pos-root.Position
        root.CFrame = root.CFrame+offset
        end)
 
        tool.Parent = plr.Backpack
	end	  
})
 
--In Teleport Tab
Teleport:AddParagraph("Legit Teleport","It is the teleport that uses the campfire (you must have this stage unlocked).")
 
Teleport:AddButton({
	Name = "Teleport: Start [0]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("start")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Furia Castle [100]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: The Town [200]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("town")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Blue House [300]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("bluehouse")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Royal Castle [400]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle2")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Watch Tower [500]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("watchtower")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Village [600]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("village")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Molten Castle [700]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle700m")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Wizard Tower [800]",
	Default = false,
	Callback = function(Value)
        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("wizardtower")
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Mushroom Village [900]",
	Default = false,
	Callback = function(Value)
	game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
	end	  
}) 
 
Teleport:AddParagraph("Teleport","It is the teleport that makes you fly (can sometimes present problems and become buggy. From the stage 'Molten Castle [700]' to the stage 'Wizard Tower [800]' is impossible, due to lava. In next updates I will improve that).")
 
Teleport:AddButton({
	Name = "Teleport: Start [0]",
	Default = false,
	Callback = function(Value)
		Time = 3; target_pos = CFrame.new(-34, 1, 123) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween1 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween1:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Furia Castle [100]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-65, 377, -495) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: The Town [200]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-450, 716, -318) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween5 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween5:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Blue House [300]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-523, 1071, -125) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween7 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween7:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Royal Castle [400]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-500, 1428, -520) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween8 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween8:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Watch Tower [500]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-862, 1806, -726) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween1 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween1:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Village [600]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-722, 2147, -564) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween1 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween1:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Molten Castle [700]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-1507, 2498, -752) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
	end	  
})
 
Teleport:AddButton({
	Name = "Teleport: Wizard Tower [800]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-1405, 2859, -1327) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween4 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween4:Play() --plays tween tp. 
	end	  
})

Teleport:AddButton({
	Name = "Teleport: Mushroom Village [900]",
	Default = false,
	Callback = function(Value)
        Time = 3; target_pos = CFrame.new(-1118, 3216, -1545) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween4 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween4:Play() --plays tween tp. 
	end	  
})
--In Teleport Bypass Tab
TeleportBypass:AddParagraph("Teleport","Each teleport can take 5-10 seconds to complete. Please be patient and do not move or touch anything while using Teleport Bypass.")

TeleportBypass:AddButton({
	Name = "Teleport: Start [0]",
	Default = false,
	Callback = function(Value)
		for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-34, 2, 124)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 2 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_1 = "start"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_1)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Furia Castle [100]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-64, 378, -497)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 378 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_2 = "castle"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_2)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: The Town [200]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-437, 716, -332)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 716 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_3 = "town"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_3)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Blue House [300]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-512, 1071, -114)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 1071 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_4 = "bluehouse"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_4)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Royal Castle [400]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-478, 1428, -402)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 1428 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_5 = "castle2"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_5)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Watch Tower [500]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-734, 1800, -701)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 1800 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_6 = "watchtower"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_6)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Village [600]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-723, 2157, -638)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 2157 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_7 = "village"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_7)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Molten Castle [700]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1500, 2498, -800)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 2498 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_8 = "castle700m"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_8)
	end	  
})
 
TeleportBypass:AddButton({
	Name = "Teleport: Wizard Tower [800]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1383, 2859, -1303)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 2859 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_9 = "wizardtower"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_9)
	end	  
})

TeleportBypass:AddButton({
	Name = "Teleport: Mushroom Village [900]",
	Default = false,
	Callback = function(Value)
        for i = 1, 50 do
            wait(0.001)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1105.31, 3216.26, -1645.79)
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Interact" then
                    if v:IsA("Part") then
                        if v:FindFirstChildWhichIsA("ClickDetector") then
                            if v:FindFirstChild("talk") then
                                local Ypos = Instance.new("IntValue")
                                Ypos.Value = v.Position.Y
                                if Ypos.Value == 3215 then
                                    if fireclickdetector then
                                        fireclickdetector(v.talk)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.1)
        
        local A_10 = "mushroomvillage"
        local Event = game:GetService("ReplicatedStorage").Remotes.Teleport
        Event:FireServer(A_10)
	end	  
})

--In Fly Tab
Fly:AddParagraph("Warning","To deactivate the 'Fly' you will have to restart your character, in future updates I will make it possible to activate and deactivate it with a button.")

Fly:AddButton({
	Name = "Fly",
	Default = false,
	Callback = function(Value)
		local speaker = game:GetService("Players").LocalPlayer
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

    nowe = false
    speeds = 2
        if nowe == true then
            nowe = false

            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        else 
            nowe = true

            for i = 1, speeds do
                spawn(function()

                    local hb = game:GetService("RunService").Heartbeat	
                    tpwalking = true
                    local chr = game.Players.LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end

                end)
            end
            game.Players.LocalPlayer.Character.Animate.Disabled = true
            local Char = game.Players.LocalPlayer.Character
            local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

            for i,v in next, Hum:GetPlayingAnimationTracks() do
                v:AdjustSpeed(0)
            end
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        end

        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            local plr = game.Players.LocalPlayer
            local torso = plr.Character.Torso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
                game:GetService("RunService").RenderStepped:Wait()

                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed+.5+(speed/maxspeed)
                    if speed > maxspeed then
                        speed = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed-1
                    if speed < 0 then
                        speed = 0
                    end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end
                --	game.Players.LocalPlayer.Character.Animate.Disabled = true
                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false

        else
            local plr = game.Players.LocalPlayer
            local UpperTorso = plr.Character.UpperTorso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            local bg = Instance.new("BodyGyro", UpperTorso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = UpperTorso.CFrame
            local bv = Instance.new("BodyVelocity", UpperTorso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
                wait()

                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed+.5+(speed/maxspeed)
                    if speed > maxspeed then
                        speed = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed-1
                    if speed < 0 then
                        speed = 0
                    end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end

                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        end
	end    
})

Fly:AddButton({
	Name = "Up (Fly Required)",
	Default = false,
	Callback = function(Value)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
	end	  
})

Fly:AddButton({
	Name = "Down (Fly Required)",
	Default = false,
	Callback = function(Value)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)
	end	  
})

--In Auto Badge Tab
AutoBadge:AddButton({
	Name = "Helpful Soul [auto]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle")
        wait(3)

        Time = 3; target_pos = CFrame.new(-69.0067444, 227.999954, -333.612244, 0.989148438, 1.76672277e-08, 0.146919683, -1.4696603e-08, 1, -2.1304885e-08, -0.146919683, 1.89144735e-08, 0.989148438) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --1/3
        game:GetService("ReplicatedStorage").Remotes.Quest_LadderStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("town")
        wait(3)

        Time = 3; target_pos = CFrame.new(-396.637451, 639.005127, -413.41687, -0.411379158, -3.61785268e-08, 0.911464334, 8.0321513e-08, 1, 7.59449605e-08, -0.911464334, 1.04452369e-07, -0.411379158) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --2/3
        game:GetService("ReplicatedStorage").Remotes.Quest_LadderFound:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "2/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle")
        wait(3)

        Time = 3; target_pos = CFrame.new(-69.0067444, 227.999954, -333.612244, 0.989148438, 1.76672277e-08, 0.146919683, -1.4696603e-08, 1, -2.1304885e-08, -0.146919683, 1.89144735e-08, 0.989148438) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --3/3
        game:GetService("ReplicatedStorage").Remotes.Quest_LadderFinished:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "3/3 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddButton({
	Name = "Mailman [auto]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("town")
        wait(3)

        Time = 1; target_pos = CFrame.new(-409.868622, 717.005127, -279.178894, -0.629504561, -2.72638867e-09, -0.776996791, -3.28967231e-09, 1, -8.43664971e-10, 0.776996791, 2.02497374e-09, -0.629504561) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --1/3
        game:GetService("ReplicatedStorage").Remotes.Quest_LetterStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("bluehouse")
        wait(3)

        Time = 1; target_pos = CFrame.new(-514.687073, 1072.00464, -99.3702087, 0.388768226, -2.2544409e-08, 0.921335578, 7.49508686e-08, 1, -7.1571189e-09, -0.921335578, 7.18373627e-08, 0.388768226) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --2/3
        game:GetService("ReplicatedStorage").Remotes.Quest_LetterTalk:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "2/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("town")
        wait(3)

        Time = 1; target_pos = CFrame.new(-409.868622, 717.005127, -279.178894, -0.629504561, -2.72638867e-09, -0.776996791, -3.28967231e-09, 1, -8.43664971e-10, 0.776996791, 2.02497374e-09, -0.629504561) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --3/3
        game:GetService("ReplicatedStorage").Remotes.Quest_LetterFinish:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "3/3 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddButton({
	Name = "Frozen Rivers [auto]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle2")
        wait(3)

        Time = 1; target_pos = CFrame.new(-542.666809, 1414.49963, -498.415466, 0.287643999, 1.63242966e-08, 0.957737386, -5.50342882e-09, 1, -1.53917643e-08, -0.957737386, -8.43490999e-10, 0.287643999) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --1/3
        game:GetService("ReplicatedStorage").Remotes.Quest_FrozenStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle2")
        wait(3)

        Time = 1; target_pos = CFrame.new(-497.778168, 1428.49963, -533.291504, 0.999780357, -5.22816883e-08, 0.0209594257, 5.118115e-08, 1, 5.30446087e-08, -0.0209594257, -5.19602317e-08, 0.999780357) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --2/3
        game:GetService("ReplicatedStorage").Remotes.Quest_FrozenTalk:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "2/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle2")
        wait(3)

        Time = 1; target_pos = CFrame.new(-542.666809, 1414.49963, -498.415466, 0.287643999, 1.63242966e-08, 0.957737386, -5.50342882e-09, 1, -1.53917643e-08, -0.957737386, -8.43490999e-10, 0.287643999) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --3/3
        game:GetService("ReplicatedStorage").Remotes.Quest_FrozenUnfreeze:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "3/3 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddButton({
	Name = "The Snitch [auto]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle700m")
        wait(3)

        Time = 1; target_pos = CFrame.new(-1479.36316, 2498.47168, -820.159851, 0.801775634, -2.81144796e-08, 0.597625196, 2.24895071e-08, 1, 1.68716809e-08, -0.597625196, -8.70066658e-11, 0.801775634) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1510.02551, 2498.47168, -858.33075, 0.998065114, -5.21017611e-08, 0.0621770211, 5.44389174e-08, 1, -3.58946899e-08, -0.0621770211, 3.92100858e-08, 0.998065114) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)

        --1/3
        game:GetService("ReplicatedStorage").Remotes.Quest_WarlordStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle700m")
        wait(3)

        Time = 1; target_pos = CFrame.new(-1513.89624, 2498.47168, -735.612427, -0.745710731, -4.56102498e-08, 0.666269839, -8.40216714e-08, 1, -2.55836472e-08, -0.666269839, -7.50591056e-08, -0.745710731) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1465.60449, 2498.47168, -759.383423, 0.44672513, 5.84608557e-08, -0.894671261, -6.41975646e-08, 1, 3.32884156e-08, 0.894671261, 4.25649418e-08, 0.44672513) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1393.45093, 2498.47168, -764.579834, 0.956863403, 4.45148487e-08, 0.290538222, -3.33990648e-08, 1, -4.32180904e-08, -0.290538222, 3.16501065e-08, 0.956863403) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1394.82336, 2498.47168, -846.130981, -0.263892442, 1.6461323e-08, 0.964552104, 8.3374168e-08, 1, 5.74410475e-09, -0.964552104, 8.19345516e-08, -0.263892442) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1446.35229, 2483.47168, -862.73645, -0.090859063, -9.52534052e-09, -0.995863736, 7.79215696e-08, 1, -1.66741891e-08, 0.995863736, -7.91142725e-08, -0.090859063) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)

        --2/3
        game:GetService("ReplicatedStorage").Remotes.Quest_WarlordEncounter:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "2/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle700m")
        wait(3)

        Time = 1; target_pos = CFrame.new(-1479.36316, 2498.47168, -820.159851, 0.801775634, -2.81144796e-08, 0.597625196, 2.24895071e-08, 1, 1.68716809e-08, -0.597625196, -8.70066658e-11, 0.801775634) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1510.02551, 2498.47168, -858.33075, 0.998065114, -5.21017611e-08, 0.0621770211, 5.44389174e-08, 1, -3.58946899e-08, -0.0621770211, 3.92100858e-08, 0.998065114) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)

        --3/3
        ggame:GetService("ReplicatedStorage").Remotes.Quest_WarlordFinish:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "3/3 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddParagraph("Warning - Holiday Helper","In this Badge the elves you get can be random, so in a future update I will make it automatic. At the moment you can start and end the mission with the following two buttons.")

AutoBadge:AddButton({
	Name = "Holiday Helper (start) [manual]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("village")
        wait(3)

        Time = 1; target_pos = CFrame.new(-866.003845, 1940.60144, -709.543335, -0.999958396, -0.000181104915, 0.0091210641, -8.50371933e-08, 0.999803126, 0.0198424477, -0.00912286155, 0.0198416207, -0.999761522) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --1/6
        game:GetService("ReplicatedStorage").Remotes.Quest_PresentsStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/1",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddButton({
	Name = "Holiday Helper (finish) [manual]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("village")
        wait(3)

        Time = 1; target_pos = CFrame.new(-866.003845, 1940.60144, -709.543335, -0.999958396, -0.000181104915, 0.0091210641, -8.50371933e-08, 0.999803126, 0.0198424477, -0.00912286155, 0.0198416207, -0.999761522) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --6/6
        game:GetService("ReplicatedStorage").Remotes.Quest_PresentsFinish:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/1 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddButton({
	Name = "Apprentice Blackmisth [semi-auto]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle700m")
        wait(3)

        Time = 1; target_pos = CFrame.new(-1506.5, 2498.47168, -752, 1, 4.12543866e-09, -1.18578758e-13, -4.12543866e-09, 1, -5.30354027e-09, 1.18556884e-13, 5.30354027e-09, 1) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1484.28101, 2498.49146, -798.333191, 0.610908628, 1.38090241e-08, -0.791701138, -2.3712122e-08, 1, -8.55014226e-10, 0.791701138, 1.92952498e-08, 0.610908628) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1407.05237, 2519.97144, -810.147217, -0.855104148, 6.68508804e-08, 0.518456221, 5.51545405e-08, 1, -3.79742886e-08, -0.518456221, -3.87675891e-09, -0.855104148) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1428.39001, 2548.63647, -803.107117, 0.0616494901, 1.13363889e-07, 0.998097837, -5.88036686e-09, 1, -1.13216721e-07, -0.998097837, 1.11057186e-09, 0.0616494901) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)

        --1/3
        game:GetService("ReplicatedStorage").Remotes.Quest_RingStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("wizardtower")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1609.94153, 2731.68652, -1261.3988, -0.579963684, -0.0673760772, -0.811851323, 8.88083136e-08, 0.996573985, -0.0827063918, 0.81464231, -0.0479667783, -0.577976704) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --2/3
        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "Touch the E (you have 10 seconds)",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
        wait(10)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "2/3",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("castle700m")
        wait(3)

        Time = 1; target_pos = CFrame.new(-1506.5, 2498.47168, -752, 1, 4.12543866e-09, -1.18578758e-13, -4.12543866e-09, 1, -5.30354027e-09, 1.18556884e-13, 5.30354027e-09, 1) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1484.28101, 2498.49146, -798.333191, 0.610908628, 1.38090241e-08, -0.791701138, -2.3712122e-08, 1, -8.55014226e-10, 0.791701138, 1.92952498e-08, 0.610908628) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1407.05237, 2519.97144, -810.147217, -0.855104148, 6.68508804e-08, 0.518456221, 5.51545405e-08, 1, -3.79742886e-08, -0.518456221, -3.87675891e-09, -0.855104148) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)
        Time = 1; target_pos = CFrame.new(-1428.39001, 2548.63647, -803.107117, 0.0616494901, 1.13363889e-07, 0.998097837, -5.88036686e-09, 1, -1.13216721e-07, -0.998097837, 1.11057186e-09, 0.0616494901) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(1)

        --3/3
        game:GetService("ReplicatedStorage").Remotes.Quest_RingEnd:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "3/3 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

AutoBadge:AddParagraph("Warning - Shroom","This badge is a little bit wrong, but you can take advantage of it and check where all the mushrooms are.")

AutoBadge:AddButton({
	Name = "Shroom [auto]",
	Default = false,
	Callback = function(Value)

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1058.8009, 3215.96704, -1562.43579, -0.499151617, -1.55024473e-08, -0.866514683, 1.6162252e-08, 1, -2.72007643e-08, 0.866514683, -2.75821339e-08, -0.499151617) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --1/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomStart:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "1/7",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1110.91626, 3105.53076, -1835.48352, 0.41996938, -0.0310355481, -0.907007456, 8.01828861e-08, 0.9994151, -0.034197472, 0.907538295, 0.0143618183, 0.419723749) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --2/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomCollected:FireServer(workspace.NPCs.GOLDEN_SHROOM)
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "2/7",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1322.91174, 2948.52051, -1664.63782, 0.0912210718, 0.0251340177, -0.995513439, 8.0972157e-08, 0.999681413, 0.0252392553, 0.995830655, -0.00230243243, 0.0911920071) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --3/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomCollected:FireServer(workspace.NPCs.GOLDEN_SHROOM)
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "3/7",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1414.87598, 2933.52002, -1643.1698, 0.997818232, 0.00731082074, -0.065615207, 7.41625499e-08, 0.993849933, 0.110735491, 0.0660212412, -0.110493891, 0.991681576) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --4/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomCollected:FireServer(workspace.NPCs.GOLDEN_SHROOM)
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "4/7",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1366.80359, 2933.52148, -1707.20349, -0.999957979, -0.0010092149, 0.00911327545, -9.2207209e-08, 0.993925154, 0.110058323, -0.00916898623, 0.110053696, -0.993883371) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --5/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomCollected:FireServer(workspace.NPCs.GOLDEN_SHROOM)
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "5/7",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1285.96472, 2928.7312, -1822.70764, -0.676731288, 0.0285560079, -0.73567611, 8.62601865e-08, 0.999247491, 0.0387867168, 0.736230075, 0.0262481235, -0.676222086) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --6/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomCollected:FireServer(workspace.NPCs.GOLDEN_SHROOM)
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "6/7",
            Image = "rbxassetid://12102363922",
            Time = 5
        })

        game:GetService("ReplicatedStorage").Remotes.Teleport:FireServer("mushroomvillage")
        wait(3)

        Time = 3; target_pos = CFrame.new(-1058.8009, 3215.96704, -1562.43579, -0.499151617, -1.55024473e-08, -0.866514683, 1.6162252e-08, 1, -2.72007643e-08, 0.866514683, -2.75821339e-08, -0.499151617) 
        TweenI = TweenInfo.new(Time, Enum.EasingStyle.Linear) 
        local tween3 = game:GetService('TweenService'):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenI, {CFrame = target_pos}) 
        tween3:Play() --plays tween tp. 
        wait(3)

        --7/7
        game:GetService("ReplicatedStorage").Remotes.Quest_ShroomFinished:FireServer()
        wait(1)

        ZapLib:MakeNotification({
            Name = "Intruction",
            Content = "7/7 - Congrulations.",
            Image = "rbxassetid://12102363922",
            Time = 5
        })
	end	  
})

--In Credits Tab
Credits:AddParagraph("Credits","The creator of ZapHub is (!! Zap#0759).")
 
Credits:AddParagraph("Version","The current version of ZapHub is Beta 1.4.0.")
 
Credits:AddParagraph("Discord","ZapHub's discord server is (discord.gg/8kZ9fBVmwQ).")

Credits:AddParagraph("Contributor","Dante#9679 (discord.gg/SnEfyqx28j) (https://www.itots.tk/).")
 
--In Update Log Tab
UpdateLog:AddParagraph("Version: Beta 1.0.0","•The following menus were added: Misc, Teleport, Credits and Update Log. •Added the following options in Misc: Fps Booster, Delete Fog, Non Slippery Ice and Click to Teleport. •Added the following teleport points in Teleport: From stage 1 (Start [0]) to stage 8 (Wizard Tower [800]). •Added credits in Credits. •Update Logs were added in Update Log.")
 
UpdateLog:AddParagraph("Version: Beta 1.0.1","•Added the following option in Misc: Retrive Ladder. •Misc precautions have been accommodated.")

UpdateLog:AddParagraph("Version: Beta 1.1.0","•Updated for version [900m]. •Added 900m in the teleport section.")

UpdateLog:AddParagraph("Version: Beta 1.2.0","•AutoBadge added (all Badge).")

UpdateLog:AddParagraph("Version: Beta 1.3.0","Walk Speed and Jump Power added.")

UpdateLog:AddParagraph("Version: Beta 1.4.0","Added Teleport Bypass (all stage).")
 
ZapLib:Init()
