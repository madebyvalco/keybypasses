## Soggyware keyless loadstring

```lua
local req = game:HttpGet("https://raw.githubusercontent.com/RiseValco/keybypasses/main/soggyware/"..game.PlaceId..".lua")

if string.find(req, "404") then return end
loadstring(req)()
```
