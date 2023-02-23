if getgenv().Loaded then return end
getgenv().Loaded = true

local plr = game:GetService("Players").LocalPlayer

if (not hookfunction) then return  plr:Kick("Executor not supported") end

game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "KEY BYPASS",
  Text = "Bypassed by grimcity"
})
game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "Discord",
  Text = "dsc.gg/grimcity"
})
game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "FREE ROBUX",
  Text = "discord.gg/freerbux"
})

old = hookfunction(game.HttpGet, newcclosure(function(self, ...) 
   if (...):lower():find("pjkey") then
              print("hooking key request")
        return [[{"IP":"23.12.12.234","key":"PROJECTWD-8GvTijqj7lS2YRmeWI","Time":]]..os.time()..[[}]]
   end
   if (...):lower():find("ips") then
       print("hooking ip request")
       return [[{"IP":"23.12.12.234"}]]
    end
   return old(self, ...) 
end))
loadstring(game:HttpGet("https://raw.githubusercontent.com/Muhammad6196/Project-WD/main/Mainstring.lua"))()
