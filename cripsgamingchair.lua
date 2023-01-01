--[[
                                                                                                                                                             
                                                                                                                                                             
        GGGGGGGGGGGGGRRRRRRRRRRRRRRRRR   IIIIIIIIIIMMMMMMMM               MMMMMMMM        CCCCCCCCCCCCCIIIIIIIIIITTTTTTTTTTTTTTTTTTTTTTTYYYYYYY       YYYYYYY
     GGG::::::::::::GR::::::::::::::::R  I::::::::IM:::::::M             M:::::::M     CCC::::::::::::CI::::::::IT:::::::::::::::::::::TY:::::Y       Y:::::Y
   GG:::::::::::::::GR::::::RRRRRR:::::R I::::::::IM::::::::M           M::::::::M   CC:::::::::::::::CI::::::::IT:::::::::::::::::::::TY:::::Y       Y:::::Y
  G:::::GGGGGGGG::::GRR:::::R     R:::::RII::::::IIM:::::::::M         M:::::::::M  C:::::CCCCCCCC::::CII::::::IIT:::::TT:::::::TT:::::TY::::::Y     Y::::::Y
 G:::::G       GGGGGG  R::::R     R:::::R  I::::I  M::::::::::M       M::::::::::M C:::::C       CCCCCC  I::::I  TTTTTT  T:::::T  TTTTTTYYY:::::Y   Y:::::YYY
G:::::G                R::::R     R:::::R  I::::I  M:::::::::::M     M:::::::::::MC:::::C                I::::I          T:::::T           Y:::::Y Y:::::Y   
G:::::G                R::::RRRRRR:::::R   I::::I  M:::::::M::::M   M::::M:::::::MC:::::C                I::::I          T:::::T            Y:::::Y:::::Y    
G:::::G    GGGGGGGGGG  R:::::::::::::RR    I::::I  M::::::M M::::M M::::M M::::::MC:::::C                I::::I          T:::::T             Y:::::::::Y     
G:::::G    G::::::::G  R::::RRRRRR:::::R   I::::I  M::::::M  M::::M::::M  M::::::MC:::::C                I::::I          T:::::T              Y:::::::Y      
G:::::G    GGGGG::::G  R::::R     R:::::R  I::::I  M::::::M   M:::::::M   M::::::MC:::::C                I::::I          T:::::T               Y:::::Y       
G:::::G        G::::G  R::::R     R:::::R  I::::I  M::::::M    M:::::M    M::::::MC:::::C                I::::I          T:::::T               Y:::::Y       
 G:::::G       G::::G  R::::R     R:::::R  I::::I  M::::::M     MMMMM     M::::::M C:::::C       CCCCCC  I::::I          T:::::T               Y:::::Y       
  G:::::GGGGGGGG::::GRR:::::R     R:::::RII::::::IIM::::::M               M::::::M  C:::::CCCCCCCC::::CII::::::II      TT:::::::TT             Y:::::Y       
   GG:::::::::::::::GR::::::R     R:::::RI::::::::IM::::::M               M::::::M   CC:::::::::::::::CI::::::::I      T:::::::::T          YYYY:::::YYYY    
     GGG::::::GGG:::GR::::::R     R:::::RI::::::::IM::::::M               M::::::M     CCC::::::::::::CI::::::::I      T:::::::::T          Y:::::::::::Y    
        GGGGGG   GGGGRRRRRRRR     RRRRRRRIIIIIIIIIIMMMMMMMM               MMMMMMMM        CCCCCCCCCCCCCIIIIIIIIII      TTTTTTTTTTT          YYYYYYYYYYYYY    
                                                                                                                                                             
                                                                                                                                                             
                                                                                                                                                             
                                                                                                                                                             
                                                                                                                                                             
                                                                                                                                                             
                                                                                                                                                             

]]--

getx = clonefunction(getgenv)

getx().A = {}

getx().A.httpfunctions = {
        game.HttpGet,
        game.HttpGetAsync,
        game.HttpPost,
        game.HttpPostAsync,
        game.GetObjects
}

getx().A.metamethod = clonefunction(hookmetamethod)
getx().A.hookfunction = clonefunction(hookfunction)

getx().A.namecall = getx().A.metamethod(game, "__namecall", newcclosure(function(self, k, ...)
    if string.find(getnamecallmethod():lower(), "http") then
        if string.find(k, "kelprepl.repl.co") then
           return "grimcity" 
        end
    end
    return getx().A.namecall(self, k, ...)
end))

for _,v in pairs(getx().A.httpfunctions) do
   getx().A.httpfunctions[_] = getx().A.hookfunction(v, newcclosure(function(self, ...)
       if string.find(..., "kelprepl.repl.co") then
       return "grimcity"    
       end
   return getx().A.httpfunctions[_](self, ...)
   end))
end
