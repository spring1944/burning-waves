local armorDefs = {
  planes  =  {
    --US--
    "USP47Thunderbolt",
	"USTBFAvenger",
    "USP51DMustang",
	"USL4",
  },
  
--  heavyPlanes  =  {
--  
--  },
    squadSpawners  =  {
	"us_sortie_fighter_bomber",
	"us_sortie_interceptor",
	"us_sortie_recon",
	"us_sortie_torpedo_bomber",
	"us_squadron_ptboat",
  },
  armouredships  =  {
  "USEssex",
  "RUSGangut",
  },
  unarmouredships  =  {
  "USLCVP",
  "USPT103",
  "USLCT",
  "USLCSL",
  "USTacoma",
  "USBuckley",
  "USFletcher",
  "USBalao_Surfaced",
  },
  submarines  =  {
  "USBalao",
  "USBalao_Submerged",
  },
}

-- convert to named maps  (trepan is a noob)
for categoryName, categoryTable in pairs(armorDefs) do
  local t = {}
  for _, unitName in pairs(categoryTable) do
    t[unitName] = 1
  end
  armorDefs[categoryName] = t
end

local system = VFS.Include('gamedata/system.lua')  

return system.lowerkeys(armorDefs)

--  Infantry=;
--  Guns=;
--  LightBuildings=;
--  Bunkers=;
--  Sandbags=;
--  Mines=;
--  Flags=;
--  Tanks=;
--  ArmouredVehicles=;
--  UnarmouredVehicles=; 
