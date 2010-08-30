--[[
  format:
  
  damagetype = {
    armortype = damageMod,
    ...
  }
  
  the damage mods are relative to the default damage given in the unit files
  you can change the default damage too, but other damage mods are based off the original
  damage mods other than default given explicitly in the unit files override these
  
  default usually corresponds to armouredvehicles
]]

local damagedefs = {
  default = {},
  none = {
    default = 0,
  },
  smallarm = {
    armouredships = 0,
	unarmouredships = 1/5,
	submarines = 0,
	lightplanes = 1/5,
  },
  explosive = {
    armouredships = 2/3,
	unarmouredships = 1,
	submarines = 0,
	lightplanes = 1,
  },
  kinetic = {
	unarmouredships = 1/2,
	submarines = 0,
	lightplanes = 1,
    default = 3/4,
  },
  shapedcharge = {
	armouredships = 2,
	unarmouredships = 2,
	submarines = 0,
  },
  fire = {
	armouredships = 3/2,
    unarmouredships = 2,
  },
  depthcharge = {
	armouredships = 0,
	unarmouredships = 0,
	submarines = 1,
	lightplanes = 0,
  },
}

return damagedefs