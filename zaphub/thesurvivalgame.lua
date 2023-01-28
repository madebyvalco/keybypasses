--Window
local ZapLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = ZapLib:MakeWindow({Name = "ZapHub | [⚔️ Bluesteel!] The Survival Game | Cracked by grimcity", IntroText = "ZapHub", IntroIcon = "rbxassetid://12102360541", HidePremium = false, SaveConfig = false})

--Locals And Function [TSG]
local entity = loadstring(game:HttpGet("https://pastebin.com/raw/EgaR3Vfs", true))()
entity.fullEntityRefresh()

local collectionService = game:GetService("CollectionService")
local guiService = game:GetService("GuiService")
local players = game:GetService("Players")
local lplr = players.LocalPlayer
local cam = workspace.CurrentCamera
local rs = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local uis = game:GetService("UserInputService")

local islclosure = islclosure or (iscclosure and function(x) return not iscclosure(x) end)
local getfunctionname = function(x) return debug.getinfo and debug.getinfo(x).name or debug.info and debug.info(x, "n") end

local zaphub = {}
local resolvePath
local hookfunc = hookfunction
function hookfunction(from, to, backup)
    local suc, res = pcall(hookfunc, from, to)
    if suc then 
        return res
    end
    return backup()
end

local funcs = {}; do 
    function funcs.getAngleFacingFromPart(selfPart, part) 
        local unit = ((part.Position - selfPart.Position) * Vector3.new(1, 0, 1)).Unit
        local partLookVec = selfPart.CFrame.LookVector * Vector3.new(1, 0, 1)
        local dot = partLookVec:Dot(unit)
        local angle = math.abs(dot - 1) * 90
        return angle
    end

    function funcs.getEntityFromPlayerName(name)
        local player = players:FindFirstChild(name)
        if not player then 
            return
        end

        local ind, ent = entity.getEntityFromPlayer(player)
        return ent
    end

    function funcs.getClosestEntity(max) 
        if not entity.isAlive then 
            return
        end

        local selfPos = entity.character.HumanoidRootPart.Position
        local dist, res = max or 9e9, nil
        for i, ent in next, entity.entityList do 
            if ent.Targetable then
                local d = (ent.HumanoidRootPart.Position - selfPos).Magnitude
                if (d < dist) then 
                    res = ent
                    dist = d
                end
            end
        end

        return res
    end
    
    function funcs.getColorFromHealthPercentage(percentage) 
        return Color3.fromHSV(percentage / 3, 1, 1) -- Makes 100% health = 0.33333 which is green.
    end

    local waitCache = {}
    function funcs.waitForChild(parent, childName, timeOut)
        local key = parent:GetDebugId(99999) .. childName
        if not waitCache[key] then
            waitCache[key] = parent:FindFirstChild(childName) or parent:WaitForChild(childName, timeOut)
        end
        return waitCache[key]
    end

    function funcs.createAngleInc(Start, DefaultInc, Goal) 
        local i = Start or 0
        return function(Inc) 
            local Inc = Inc or DefaultInc or 1
            i = math.clamp(i + Inc, Start, Goal)
            return i
        end
    end
    
    function funcs.circle(Self, Target, Radius, Delay, Speed, stopIf, onStop, YOffset)
        local AngleInc = funcs.createAngleInc(0, Speed, 360)
        for i = 1, 360 / Speed do 
            local Angle = AngleInc(Speed)
            Self.CFrame = CFrame.new(Target.CFrame.p) * CFrame.Angles(0, math.rad(Angle), 0) * CFrame.new(0, YOffset, Radius)
            task.wait(Delay)
            if stopIf and stopIf() then
                return onStop and onStop()
            end
        end
    end

    function funcs.getBestSlot(type, stat) 
        local hotbar = zaphub.ClientData.getHotbar()
        local most, best = 0, nil
        for hotbarSlot, itemId in next, hotbar do 
            if itemId < 0 then 
                continue 
            end

            local itemData = zaphub.Items.getItemData(itemId)
            if table.find(itemData.itemType, type) then 
                if itemData.itemStats[stat] > most then 
                    best = hotbarSlot
                    most = itemData.itemStats[stat]
                end
            end
        end
        
        return best, most
    end

    function funcs.getBestId(type, stat) 
        local inv = zaphub.ClientData.getInventory()
        local most, best = 0, nil
        for itemId, amount in next, inv do 
            if itemId < 0 then 
                continue 
            end

            if amount <= 0 then 
                continue
            end

            local itemData = zaphub.Items.getItemData(itemId)
            if table.find(itemData.itemType, type) then 
                if itemData.itemStats[stat] > most then 
                    best = itemId
                    most = itemData.itemStats[stat]
                end
            end
        end
        
        return best, most
    end

    -- params: type, stat, bool: inventory (check inv)
    -- return: slot/id, isInInv
    function funcs.getBestItem(type, stat, inventory) 
        local bestSlot, most1 = funcs.getBestSlot(type, stat)
        local bestId, most2 = funcs.getBestId(type, stat)

        if (most2 > most1) and inventory then 
            return bestId, true
        else
            return bestSlot, false
        end
    end

    function funcs.getBestItemAndEquipToHotbar(type, stat, inventory) 
        local bestItem, inv = funcs.getBestItem(type, stat, inventory)
        if inv then 
            local hotbar = zaphub.ClientData.getHotbar()
            local slot = 1
            for i = 1, 5 do 
                if not hotbar[i] then 
                    slot = i
                    break
                end
            end

            funcs.equipToHotbar(bestItem, slot)
            bestItem = slot
        end
        return bestItem
    end

    function funcs.equipToHotbar(id, slot) 
        pcall(function()
            zaphub.EquipHotbarRemote:InvokeServer("inventory", slot, id)
        end)
    end

    function funcs.getClosestAnimal(max) 
        if not entity.isAlive then 
            return
        end

        local selfPos = entity.character.HumanoidRootPart.Position
        local dist, res = max or 9e9, nil
        for i, animal in next, zaphub.Animals do 
            if animal.PrimaryPart and (not animal:GetAttribute("deadFrom")) then
                local d = (animal.PrimaryPart.Position - selfPos).Magnitude
                if (d < dist) then 
                    res = animal
                    dist = d
                end
            end
        end

        return res
    end

    function funcs.playAnimation(id)
        if entity.isAlive then 
            local animation = Instance.new("Animation")
            animation.AnimationId = id
            local animatior = entity.character.Humanoid.Animator
            animatior:LoadAnimation(animation):Play()
        end
    end

    function funcs.getEquippedId() 
        if not entity.isAlive then
            return -1
        end

        local hotbar = zaphub.ClientData.getHotbar()
        for i, v in next, hotbar do 
            local tool = lplr.Character:FindFirstChild(tostring(i))
            if tool and tool:IsA("Tool") then 
                return v
            end
        end

        return -1
    end

    function funcs.getEquippedSlot() 
        if not entity.isAlive then
            return
        end

        local hotbar = zaphub.ClientData.getHotbar()
        for i, v in next, hotbar do 
            local tool = lplr.Character:FindFirstChild(tostring(i))
            if tool and tool:IsA("Tool") then 
                return i
            end
        end
    end

    -- This function is just skidded from in game code lol (players.LocalPlayer.Character["1"].slotTool.Ranged_CHARGED)
    function funcs.getShootTarget() 
        if zaphub.fpsUtil.inFirstPerson() then
            local cf = cam.CFrame
            return cf.Position + (cf.LookVector * 1000)
        end

        local mousePos = uis:GetMouseLocation() - guiService:GetGuiInset()
        local ray = cam:ScreenPointToRay(mousePos.X, mousePos.Y)
        local rayParams = RaycastParams.new()
        rayParams.FilterType = Enum.RaycastFilterType.Blacklist
        rayParams.FilterDescendantsInstances = {
            lplr.Character,
            resolvePath(workspace, "snaps")
        }

        local hit = workspace:Raycast(ray.Origin, ray.Direction * 500, rayParams)
        if hit then
            return hit.Position
        end
        return ray.Origin + (ray.Direction * 1000)
    end

    function funcs.getShootCF() 
        if not entity.isAlive then
            return
        end

        if zaphub.fpsUtil.inFirstPerson() then 
            return cam.CFrame
        end

        return CFrame.new(lplr.Character:GetPivot().Position, funcs.getShootTarget())
    end

    function funcs.solveQuadratic(a, b, c) -- Solves quadratic equation, always returns the positive output.
        local d = (b ^ 2) - (a * c * 4)
        local e = (-b) + (d ^ 0.5)
        return e / (a * 2)
    end

    --[[
    function funcs.prediction(selfPart, part, speed) 
        local speed = speed.Magnitude
        local targetPosition = part.Position
        local targetVelocity = part.Velocity
        local shooterPosition = selfPart.Position
        local relative = shooterPosition - targetPosition
        local angle = math.acos(relative.Unit:Dot(targetVelocity.Unit))

        if targetVelocity == Vector3.zero then 
            return targetPosition
        end
       
        local a,b,c =
            (targetVelocity.magnitude ^ 2) - (speed ^ 2),
            -2 * relative.magnitude * math.cos(angle) * targetVelocity.magnitude,
            relative.magnitude ^ 2
       

        local t = funcs.solveQuadratic(a,b,c)
        return targetPosition + targetVelocity * t
    end
    ]]

    local FACTOR = 0.15
    local Y_OFFSET = 2
    local Y_FACTOR = 0.08
    function funcs.prediction(selfPart, part, speed) 
        local add = part.Velocity
        add = Vector3.new(add.X * FACTOR, (add.Y * Y_FACTOR) + Y_OFFSET, add.Z * FACTOR) 
        return part.Position + add
    end

    --[[
    function funcs.remoteCheck(tab) 
        if typeof(tab) == "table" then
            local method = rawget(tab, "FireServer") or rawget(tab, "InvokeServer")
            return typeof(method) == "function" and islclosure(method) and method
        end
    end
    ]]

    --local Version = resolvePath(rs, "version").Value

    function funcs.getKeyedRemotes() 
        for i, v in next, getgc(true) do 
            if typeof(v) == "table" and rawget(v, 'meleePlayer') then
                return v
            end
        end
    end

    function funcs.getKeyedRemotesRecursive(recurseAmount) 
        if recurseAmount >= 4 then 
            lplr:Kick(("[ZapHub.lua] Failure in getgc grabber."))
            return
        end

        local suc, res = pcall(funcs.getKeyedRemotes)
        if not suc then 
            lplr:Kick(("[ZapHub.lua] Error in getgc grabber."):format(res))
            return
        end
        if not res then 
            task.wait(1)
            return funcs.getKeyedRemotesRecursive(recurseAmount + 1)
        end
        return res
    end

    local boatsFolder
    function funcs.getRandomUnoccupiedBoatSeat() 
        boatsFolder = boatsFolder or resolvePath(workspace, "boats")
        for i, v in next, boatsFolder:GetChildren() do
            local seat = v:FindFirstChildWhichIsA("VehicleSeat", true)
            if seat and not seat.Occupant then 
                return seat
            end
        end
    end

    function funcs.teleportTo(cframe) 
        if not entity.isAlive then 
            return
        end

        local seat = entity.character.Humanoid.SeatPart or funcs.getRandomUnoccupiedBoatSeat()
        if not seat then 
            return
        end

        seat:Sit(entity.character.Humanoid)

        rsConnection = runService.Heartbeat:Connect(function()
            if seat.Parent and seat.Parent.PrimaryPart then
                seat.Parent.PrimaryPart.CFrame = cframe + Vector3.new(0, 10, 0)
                seat.Parent.PrimaryPart.Velocity = Vector3.zero
                seat.Parent.PrimaryPart.AssemblyAngularVelocity = Vector3.zero
                seat.Parent.PrimaryPart.AssemblyLinearVelocity = Vector3.zero
                seat.Parent.PrimaryPart.RotVelocity = Vector3.zero
            end
        end)

        repeat task.wait() until (((lplr.Character:GetAttribute("lastPos")) - seat.Position) * Vector3.new(1, 0, 1)).Magnitude <= 15

        entity.character.Humanoid.Sit = false
        task.wait(.1)
        rsConnection:Disconnect()
        entity.character.HumanoidRootPart.Velocity = Vector3.zero
        entity.character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
        entity.character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
        entity.character.HumanoidRootPart.RotVelocity = Vector3.zero
    end
end

function resolvePath(parent, ...)
    local last = parent
    for i, v in next, {...} do 
        last = funcs.waitForChild(last, v)
    end

    return last
end

--[[
local oldNamecall; oldNamecall = hookmetamethod(game, "__namecall", function(self, ...) 
    local ncm = getnamecallmethod()
    if (not checkcaller()) and string.lower(ncm) == "kick" then 
        return
    end

    return oldNamecall(self, ...)
end)

hookfunction(lplr.Kick, function(...) end)]]

local olddebuginfo
local newdebuginfo = function(level, inf, ...)
	if level > 6 and level < 10 and inf == "s" then 
		return lplr.PlayerScripts.client.tools.Tool.Collector:GetFullName()
	end
	return olddebuginfo(level, inf, ...)
end

olddebuginfo = hookfunction(getrenv().debug.info, newdebuginfo, function() 
    local old = getrenv().debug.info
    setreadonly(debug, false)
    getrenv().debug.info = newdebuginfo
    setreadonly(debug, true)
    return old
end)

local keyedRemotes = funcs.getKeyedRemotesRecursive(1)

zaphub = {
    ClientData = require(resolvePath(rs, "modules", "player", "ClientData")),
    Sounds = require(resolvePath(rs, "modules", "misc", "Sounds")),
    Items = require(resolvePath(rs, "game", "Items")),
    Effects = require(resolvePath(rs, "game", "Effects")),
    fpsUtil  = require(resolvePath(rs, "modules", "misc", "fpsUtil")),

    MeleePlayerRemote = rawget(keyedRemotes, "meleePlayer"),
    MeleeAnimalRemote = resolvePath(rs, "remoteInterface", "interactions", "meleeAnimal"),
    EatRemote = resolvePath(rs, "remoteInterface", "interactions", "eat"),
    MineRemote = rawget(keyedRemotes, "mine"),
    ChopRemote = rawget(keyedRemotes, "chop"),
    ShotPlayerHitRemote = resolvePath(rs, "remoteInterface", "interactions", "shotHitPlayer"),
    PickupRemote = resolvePath(rs, "remoteInterface", "inventory", "pickupItem"),
    RespawnRemote = resolvePath(rs, "remoteInterface", "character", "respawn"),
    FireRemote = resolvePath(rs, "remoteInterface", "world", "onFire"),
    DropRemote = resolvePath(rs, "remoteInterface", "inventory", "drop"),
    EquipHotbarRemote = resolvePath(rs, "remoteInterface", "inventory", "equipHotbar"),
    HitStructureRemote = rawget(keyedRemotes, "hitStructure"),

    SetHungerEvent = resolvePath(rs, "remoteInterface", "playerData", "setHunger"),
}

getgenv().zaphub = zaphub -- testing purposes
getgenv().library = library -- testing purposes

local animalContainer = resolvePath(workspace, "animals"); do 
    local function addAnimal(v) 
        table.insert(zaphub.Animals, v)
    end

    zaphub.Animals = zaphub.Animals or {}
    animalContainer.ChildAdded:Connect(addAnimal)
    for i, v in next, animalContainer:GetChildren() do 
        addAnimal(v)
    end 
end

--Visual GetGen
getgenv().cham = false
getgenv().nameESP = false
getgenv().boxESP = false
getgenv().esp_loaded = false
getgenv().Visibility = false

--Notifying
ZapLib:MakeNotification({
	Name = "Welcome to ZapHub!",
	Content = "Discord: discord.gg/8kZ9fBVmwQ",
	Image = "rbxassetid://12102363922",
	Time = 10
})
 
--Tabs
local Player = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://12102367320",
	PremiumOnly = false
})

local Visual = Window:MakeTab({
	Name = "Visual",
	Icon = "rbxassetid://12102368940",
	PremiumOnly = false
})
 
local Combat = Window:MakeTab({
	Name = "Combat",
	Icon = "rbxassetid://12102367320",
	PremiumOnly = false
})

local Misc = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://12102367320",
	PremiumOnly = false
})

local Teleport = Window:MakeTab({
	Name = "Teleport",
	Icon = "rbxassetid://12102367320",
	PremiumOnly = false
})

local Fly = Window:MakeTab({
	Name = "Fly (Patched)",
	Icon = "rbxassetid://12102368940",
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
Player:AddSlider({
	Name = "Speed (Not completed)",
	Min = 0,
	Max = 29,
	Default = 29,
	Color = Color3.fromRGB(70,70,70),
	Increment = 1,
	ValueName = "Walk Speed",
	Callback = function(value)
    
	end    
})

Player:AddSlider({
	Name = "Power (Bannable)",
	Min = 0,
	Max = 500,
	Default = 50,
	Color = Color3.fromRGB(70,70,70),
	Increment = 1,
	ValueName = "Jump Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = (Value)
	end    
})

Player:AddToggle({
	Name = "Infinite Stamina (Not completed)",
	Default = false,
	Callback = function(Value)

	end	  
})

Player:AddToggle({
	Name = "Infinite Jump (Not completed)",
	Default = false,
	Callback = function(Value)

	end	  
})

Player:AddToggle({
    Name = "No Clip (Not completed)",
    Default = false,
    Callback = function(Value)

    end	  
})

Player:AddToggle({
	Name = "Jesus (Not completed)",
	Default = false,
	Callback = function(Value)

	end	  
})

--In Visual Tab
Visual:AddToggle({
	Name = "Visual On-Off",
	Default = getgenv().Visibility,
	Callback = function(Value)
        if getgenv().esp_loaded == false and Value == true then
            getgenv().esp_loaded = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
        end
        getgenv().Visibility = Value
	end	  
})

Visual:AddToggle({
	Name = "Name Esp",
	Default = getgenv().Visibility,
	Callback = function(Value)
        if getgenv().esp_loaded == false and Value == true then
            getgenv().esp_loaded = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
        end
        getgenv().nameESP = Value
	end	  
})

Visual:AddToggle({
	Name = "Box Esp",
	Default = getgenv().Visibility,
	Callback = function(Value)
        if getgenv().esp_loaded == false and Value == true then
            getgenv().esp_loaded = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
        end
        getgenv().boxESP = Value
	end	  
})

Visual:AddToggle({
	Name = "Chams Esp",
	Default = getgenv().Visibility,
	Callback = function(Value)
        if getgenv().esp_loaded == false and Value == true then
            getgenv().esp_loaded = true
            loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
        end
        getgenv().cham = Value
	end	  
})

Visual:AddToggle({
	Name = "Team Color",
	Default = getgenv().Visibility,
	Callback = function(Value)
        getgenv().useTeamColor = Value
	end	  
})

--In Combat Tab
Combat:AddToggle({
	Name = "Kill Aura (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

Combat:AddToggle({
	Name = "Bow Aimbot (Not completed)",
	Default = false,
	Callback = function(Value)
        
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

Misc:AddToggle({
	Name = "Auto Mine (Not completed)",
	Default = false,
	Callback = function(Value)
       
	end	  
})

Misc:AddToggle({
	Name = "Fast Pickup (Not completed)",
	Default = false,
	Callback = function(Value)

	end	  
})

--In Teleport Tab
Teleport:AddButton({
	Name = "Toleport Ore: Stone (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

Teleport:AddButton({
	Name = "Toleport Ore: Coal (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

Teleport:AddButton({
	Name = "Toleport Ore: Copper (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

Teleport:AddButton({
	Name = "Toleport Ore: Iron (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

Teleport:AddButton({
	Name = "Toleport Ore: Bluesteel (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

Teleport:AddTextbox({
	Name = "Player Name",
	Default = "",
	TextDisappear = false,
	Callback = function(Value)
		print(Value)
	end	  
})

Teleport:AddButton({
	Name = "Toleport to Player (Not completed)",
	Default = false,
	Callback = function(Value)
        
	end	  
})

--In Fly Tab
Fly:AddParagraph("Warning","To deactivate the 'Fly' you will have to restart your character, in future updates I will make it possible to activate and deactivate it with a button.")

Fly:AddParagraph("Warning","Fly, Up and Down are patched.")

Fly:AddButton({
	Name = "Fly",
	Default = false,
	Callback = function(Value)
		local speaker = game:GetService("Players").LocalPlayer
    local chr = game.Players.LocalPlayer.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

    nowe = false
    speeds = 1
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

--In Credits Tab
Credits:AddParagraph("Credits","The creator of ZapHub is (!! Zap#0759).")
 
Credits:AddParagraph("Version","The current version of ZapHub is Beta 1.0.0.")
 
Credits:AddParagraph("Discord","ZapHub's discord server is (discord.gg/8kZ9fBVmwQ).")
 
--In Update Log Tab
UpdateLog:AddParagraph("Version: Beta 1.0.0","•Added Esp, Fly, Jump Power and more")

ZapLib:Init()
