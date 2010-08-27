function gadget:GetInfo()
  return {
    name      = "Kill points",
    desc      = "Scores players based on number of kills, ending the game after a certain amount of time.",
    author    = "Nemo (B. Tyler",
    date      = "August 26th, 2010",
    license   = "LGPL v2.0",
    layer     = 0,
    enabled   = true  --  loaded by default?
  }
end

if (Spring.GetModOptions) then
  modOptions = Spring.GetModOptions()
end
if (gadgetHandler:IsSyncedCode()) then

local teamPoints = {}
local gameLength = ((tonumber(modOptions.game_length) or 2) * 60) * 30 --minutes, times seconds, times frames
local GAIA_TEAM_ID = Spring.GetGaiaTeamID()


function gadget:Initialize()
	local allTeams = Spring.GetAllyTeamList()
	Spring.Echo(allTeams)
	for i = 0, #allTeams-2 do
      teamPoints[i] = 0
    end
end


function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
	local killedUnitAllyTeam = Spring.GetUnitAllyTeam(unitID)
	if attackerID ~= nil then
		local attackerAllyTeam = Spring.GetUnitAllyTeam(attackerID)
		--Spring.Echo(attackerTeamID)
		if attackerAllyTeam ~= nil then
			local ud = UnitDefs[unitDefID]
			if attackerTeamID ~= teamID then
				teamPoints[attackerAllyTeam] = teamPoints[attackerAllyTeam] + ud.metalCost
			end
		end
	end
end

function gadget:GameFrame(n)
	if (n % (15*30) < 0.1) then
		local allAllyTeams = Spring.GetAllyTeamList()
		local allTeams = Spring.GetTeamList()
		local winningTeam = 0
		local winningTeamScore = 0
		for i = 0, #allAllyTeams-2 do
			Spring.Echo("Team "..i.." points: "..teamPoints[i])
			if teamPoints[i] > winningTeamScore then
				winningTeam = i
				winningTeamScore = teamPoints[i]
			end
		end
		Spring.Echo("Team "..winningTeam.." is winning!")
		if n >= (gameLength) then
			Spring.Echo("Team "..winningTeam.." has won!")
			for i = 0, #allTeams-1 do
				local _, _, _, _, _, teamAllyTeam = Spring.GetTeamInfo(i)
				if teamAllyTeam ~= winningTeam then
					for _,u in ipairs(Spring.GetTeamUnits(i)) do
						Spring.TransferUnit(u, GAIA_TEAM_ID, false)
						Spring.SetUnitNeutral(u, true)
					end							
				end
			end
		end
	end
end

else

end


