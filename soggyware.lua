local old
old = hookfunction(getgc, function(...)
    print(...)
   return {function() end} 
end)

local key = game:HttpGet("https://soggyware-bypass.vercel.app/api")

local hooks = {
    rconsoleprint = "dsc.gg/grimcity"
}

hooks.rconsoleprint = hookfunction(rconsoleprint, function(...)
    return print(...)
end)

loadstring(game:HttpGet("https://soggy-ware.cf/"))()

for _,v in pairs(game:GetService("CoreGui"):GetChildren()) do
    if v:FindFirstChild("KeyUI") then
    v.KeyUI:GetPropertyChangedSignal("Visible"):Connect(function()
        wait(1)
        v.KeyUI.TextBox.Text = key
    end)
    end
end
