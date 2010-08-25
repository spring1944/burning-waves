local modOptions
if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end

buildoptions = 
{

        --------------------
        -- american units --
        --------------------
  
  usboatyard =
  {
    "uspt103",
    "uslcsl",
	"ustacoma",
	"usfletcher",
  }
}
if (modOptions) then
	if (modOptions.navies) then
		local tmpNavies = tonumber(modOptions.navies)
		if tmpNavies > 0 then
			-- add Light ships
			table.insert(buildoptions.rusboatyardlarge, "ruspr161")
			table.insert(buildoptions.rusboatyardlarge, "ruspr7")
			
			table.insert(buildoptions.gerboatyardlarge, "gerflottentorpboot")
			table.insert(buildoptions.gerboatyardlarge, "gertype1934")	
			
			table.insert(buildoptions.gbrboatyardlarge, "gbrhuntii")
			table.insert(buildoptions.gbrboatyardlarge, "gbroclass")

			table.insert(buildoptions.usboatyardlarge, "ustacoma")
			table.insert(buildoptions.usboatyardlarge, "usfletcher")
		end
	end
end

return buildoptions
