local Clicks = getgenv().Clicks or 9e9/100

for i,v in next, getgc() do
    if typeof(v) == "function" and not is_synapse_function(v) then
        if islclosure(v) then
            do
                local upvalues = getupvalues(v)
                local constants = getconstants(v)
                if table.find(upvalues, 1) then
                    upvalues = getupvalues(v)
                    constants = getconstants(v)
                    for i2,v2 in next, upvalues do
                        if v2 == 1 then
                            setupvalue(v, i2, Clicks)
                        end
                    end
                end
            end
        end
    end
end