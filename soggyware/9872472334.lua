for i, v in pairs(getgc(true)) do -- looping thru garbage collector
	if type(v) == "table" and rawget(v, "ADS") then -- Getting table we want by checking if it contains ADS
		for i2, v2 in next, v do
			if i2 == "UnequipTime" then
                print("Got UT") -- Printing If We Got UnequpTime
				rawset(v, i2, 0.01) -- Lower = faster unequipping / rawset(t, idx, val)
			end
			if i2 == "EquipTime" then
                print("Got ET") -- Printing If We Got EquipTime
				rawset(v, i2, 0.01) -- Lower = faster equipping / rawset(t, idx, val)
			end
			if i2 == "Spread" then
				for i3, v3 in next, v2 do
                    if v3 then
	                    print("Got Spread") -- Printing If We Got Spread
                        v3 = {
                            0, -- X AXIS | Lower = less spread on bullets the shooting
                            0, -- Y AXIS | Lower = less spread on bullets the shooting
                        }
                    end
				end
			end
		end
	end
end