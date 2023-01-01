if not syn then return game:GetService("Players").LocalPlayer:Kick("Unsupported executor join dsc.gg/grimcity and use cmd !soggyware") end

game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "SOGGYWARE BYPASS",
  Text = "Loadding functions..."
})

getgenv1 = clonefunction(getgenv)

getgenv1().A = {}


getgenv1().A.http = clonefunction(game.HttpGet)
getgenv1().A.hook = clonefunction(hookmetamethod)
getgenv1().A.hf = clonefunction(hookfunction)
getgenv1().A.key = getgenv1().A.http(game, "https://soggyware-bypass.vercel.app/08934289034890342980324980")

getgenv1().A.gg = nil
getgenv1().A.gg = getgenv1().A.hf(getgenv, newcclosure(function(...)
    return getgenv1().A.gg(...)
end))

getgenv1().A.hk = nil
getgenv1().A.hk = getgenv1().A.hf(hookfunction, newcclosure(function(...)
    return ...
end))


function toJson(string)
    local jsonData = nil
    local s, err = pcall(function() 
        local jsonTry = game:GetService("HttpService"):JSONDecode(string)  
        jsonData = jsonTry
    end)   
    return jsonData or false
end
getgenv1().A.key = toJson(getgenv1().A.key).key

game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "SOGGYWARE BYPASS",
  Text = "Waiting...",
  Duration = 5,
})


loadstring(game:HttpGet("https://www.soggy-ware.cf"))()

game:GetService("StarterGui"):SetCore("SendNotification", {
  Title = "SOGGYWARE BYPASS",
  Text = "Soggyware loaded..."
})


for _,v in pairs(game.CoreGui:GetChildren()) do
     if v:FindFirstChild("KeyUI") then
       v.Enabled = false
       v.KeyUI:GetPropertyChangedSignal("Visible"):Connect(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
          Title = "SOGGYWARE BYPASS",
          Text = "Injected! Please Wait."
        })
           wait(1)
           v.KeyUI.TextBox.Text = getgenv1().A.key
        end)
    end  
end
