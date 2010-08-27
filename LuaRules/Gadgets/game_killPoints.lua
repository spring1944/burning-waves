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
local gameLength = tonumber(modOptions.game_length)*60) or 600) * 30
local GAIA_TEAM_ID = Spring.GetGaiaTeamID()


function gadget:Initialize()
	local allTeams = Spring.GetTeamList()
	for i = 1, #allTeams do
      teamPoints[i] = 0
    end
end


function gadget:UnitDestroyed(unitID, unitDefID, teamID, attackerID)
	local attackerTeamID = Spring.GetUnitTeam(attackerID) + 1
	if attackerTeamID ~= nil then
		local ud = UnitDefs[unitDefID]
		teamPoints[attackerTeamID] = teamPoints[attackerTeamID] + ud.metalCost
	end
end

function gadget:GameFrame(n)
	if (n % (5*30) < 0.1) then
		local allTeams = Spring.GetTeamList()
		local winningTeam = 1
		local winningTeamScore = 0
		for i = 1, #allTeams-1 do
			Spring.Echo("Team "..i.." points: "..teamPoints[i])
			if teamPoints[i] > winningTeamScore then
				winningTeam = i
				winningTeamScore = teamPoints[i]
			end
		end
		Spring.Echo("Team "..winningTeam.." is winning!")
		if n >= (gameLength/30) then
			Spring.Echo("Team "..winningTeam.." has won!")
			for i = 1, #allTeams-1 do
				if i ~= winningTeam then
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


