if (not hookmetamethod) then return game:GetService("Players").LocalPlayer:Kick("Your executor dont support hookmetamethod") end


old = hookmetamethod(game, "__namecall", newcclosure(function(self, k, ...)
    if string.find(getnamecallmethod():lower(), "http") then
        print(k)
       if string.find(k, "/raw") then
        return "grimcity"
        end
    end
   return old(self, k, ...) 
end))

game.CoreGui.ChildAdded:Connect(function(v)
    if v.Name == "Key" then
       local Main = v:WaitForChild("Main")
       Main.KeyNote.Text = 'Key = "grimcity"'
    end
end)

getgenv().SecureMode = true -- Extra safe mode, blocks remotes
--[[
This script is licensed with alssec.
Key will update in the future, make sure to join the Discord! .gg/WdBXf7hS3N
]]

loadstring(game:HttpGet("https://github.com/VanillaDeveloper/ZoDestroyer/blob/main/ZoWareV3.lua?raw=true"))():Init();
