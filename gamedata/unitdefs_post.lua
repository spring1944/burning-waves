--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local modOptions
if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

local function disableunits(unitlist)
	for name, ud in pairs(UnitDefs) do
	    if (ud.buildoptions) then
	      for _, toremovename in ipairs(unitlist) do
	        for index, unitname in pairs(ud.buildoptions) do
	          if (unitname == toremovename) then
	            table.remove(ud.buildoptions, index)
	          end
	        end
	      end
	    end
	end
end

local function tobool(val)
  local t = type(val)
  if (t == 'nil') then
    return false
  elseif (t == 'boolean') then
    return val
  elseif (t == 'number') then
    return (val ~= 0)
  elseif (t == 'string') then
    return ((val ~= '0') and (val ~= 'false'))
  end
  return false
end


	--[[	for name, ud in pairs(UnitDefs) do
			if (ud.customparams) then
				if (ud.customparams.weaponcost) then
				ud.customparams.weaponcost = (2 * ud.customparams.weaponcost)
				end
			end
		end]]--

	--[[if (modOptions and modOptions.unit_speed_mult) then
		for name, ud in pairs(UnitDefs) do
			if (ud.maxvelocity) then
			ud.maxvelocity = (modOptions.unit_speed_mult * ud.maxvelocity)
			ud.acceleration = (modOptions.unit_speed_mult * ud.acceleration)
			end
		end
	end]]--

	if (modOptions and modOptions.command_mult) then
		for name, ud in pairs(UnitDefs) do
			if (ud.extractsmetal) then
				if (modOptions.command_mult == '0') then --Very Low Command
				ud.extractsmetal = (0.25 * ud.extractsmetal)
				end
				if (modOptions.command_mult == '1') then --Low Command
				ud.extractsmetal = (0.5 * ud.extractsmetal)
				end
				if (modOptions.command_mult == '2') then --Normal Command
				ud.extractsmetal = (1 * ud.extractsmetal)
				end
				if (modOptions.command_mult == '3') then --High Command
				ud.extractsmetal = (1.5 * ud.extractsmetal)
				end
				if (modOptions.command_mult == '4') then --Very High Command
				ud.extractsmetal = (2.5 * ud.extractsmetal)
				end
			end
		end
	end

	--[[if (modOptions and modOptions.unit_metal_mult) then
		for name, ud in pairs(UnitDefs) do
			if (ud.extractsmetal) then
			ud.extractsmetal = (modOptions.unit_metal_mult * ud.extractsmetal)
			end
		end
	end]]--

	if (modOptions and modOptions.command_storage and (tonumber(modOptions.command_storage) > 0)) then
		for name, ud in pairs(UnitDefs) do
			if (ud.metalstorage) then
				ud.metalstorage = 0
			end
		end
	end



--local sensors = modOptions and modOptions.sensors == '1' --true

-- adjust descriptions
for name, ud in pairs(UnitDefs) do
	
	
	if ud.floater then
		ud.turninplace = false
		ud.turninplacespeedlimit = (tonumber(ud.maxvelocity) or 0) * 0.5
	end
	-- ammo users
	if (ud.customparams) then
		if (ud.customparams.weaponcost) and (ud.customparams.maxammo) then
			local newDescrLine = "max. ammo: "..ud.customparams.maxammo..", log. per shot: "..ud.customparams.weaponcost..", total: "..(ud.customparams.weaponcost*ud.customparams.maxammo)
			if not (ud.description) then
				ud.description = newDescrLine
			end
			ud.description = ud.description.." ("..newDescrLine..")"
			
		end
		--if ud.customparams.armor_front and (tonumber(ud.maxvelocity) or 0) > 0 then
		--	ud.usepiececollisionvolumes = true
		--end
	end
	-- Make all vehicles push resistant, except con vehicles, so they vacate build spots
	if tonumber(ud.maxvelocity or 0) > 0 and (not ud.canfly) and tonumber(ud.footprintx) > 1 and (not ud.builder) then
		--Spring.Echo(name)
		ud.pushresistant = true
		
		--local seisSig = tonumber(ud.mass) / 1000 -- 10x smaller than default
		--if seisSig < 1 then seisSig = 1 end
		ud.seismicsignature = 1 --seisSig
	end

	if (modOptions.unit_los_mult) then
		if ud.sightdistance then
			ud.sightdistance = (modOptions.unit_los_mult * ud.sightdistance)
		end
		if ud.radardistance then
			ud.radardistance = (modOptions.unit_los_mult * ud.radardistance)
		end
		if ud.seismicdistance then
			ud.seismicdistance = (modOptions.unit_los_mult * ud.seismicdistance)
		end			
	end
end

