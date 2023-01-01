repeat wait() until game:IsLoaded()

local ncall
ncall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if not checkcaller() then
        local method = getnamecallmethod()

        if method == "InvokeServer" and args[1] == "press" then
            getgenv().ClickRemote = self.Name
        end
    end
    return ncall(self, unpack(args))
end)

local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win = lib:Window("Soggyware V1.8", Color3.fromRGB(44, 120, 224), Enum.KeyCode.PageDown)

local tab = win:Tab("Home")

tab:Label("Last Upd: Release!")
tab:Label("synapse clicks faster somehow")
tab:Label("Version: 1 | Discord: discord.gg/soggy")

local tab = win:Tab("Farming")

tab:Toggle(
    "Click Fast (Toggle on and off if it dont work)",
    false,
    function(t)
        getgenv()["Click Fast"] = t

        while getgenv()["Click Fast"] == true do
            task.wait()
            if getgenv()["Click Fast"] == true then
                pcall(function()
                    firesignal(game:GetService("Players").LocalPlayer.PlayerGui.CoreUI.MainClicker.Button.MouseButton1Click)
                    game:GetService("ReplicatedStorage").Modules.Utilities.ServiceLoader.NetworkService.Functions.Objects:FindFirstChild(getgenv().ClickRemote):InvokeServer("press")
                end)
            else
                break
            end
        end
    end
)

require(game:GetService("ReplicatedStorage").Modules.Utilities.UtilityLoader.Custom.notificationUtility).createNotification("This game was dripped on by Soggyware" , {Color3.fromRGB(3, 157, 247), Color3.fromRGB(1, 127, 201)} , true, "")