--  Custom Options Definition Table format

--  NOTES:
--  - using an enumerated table lets you specify the options order

--
--  These keywords must be lowercase for LuaParser to read them.
--
--  key:      the string used in the script.txt
--  name:     the displayed name
--  desc:     the description (could be used as a tooltip)
--  type:     the option type
--  def:      the default value;
--  min:      minimum value for number options
--  max:      maximum value for number options
--  step:     quantization step, aligned to the def value
--  maxlen:   the maximum string length for string options
--  items:    array of item strings for list options
--  scope:    "all", "player", "team", "allyteam"      <<< not supported yet >>>


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local options = {

	--[[{
    key    = "maxammo_mult",
    name   = "Vehicle maxammmo multiplier",
    desc   = "Applies a multiplier to all the vehicle maxammo values",
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 10,
    step   = 0.1,
  },]]--
  
  {
	key    = '2gamemode',
	name   = 'Game Mode Settings',
	desc   = 'Point vs Traditional Victory and Naval settings',
	type   = 'section',
  },
	
 --[[ {
		key = "navies",
		name = "Naval Units",
		desc = "Enable the production of naval units",
		type = "list",
		def = 0,
		items	= {
			{
				key	= "0",
				name	= "Standard",
				desc	= "Standard Naval Unit Buildtree",
			},
			{
				key	= "1",
				name	= "Heavy Ships",
				desc	= "Includes Destroyers and other Heavy Ships",
			},
		}
	},]]--
	
 {
      key="scoremode",
      name="Victory Condition",
      desc="What leads to victory? (key = 'scoremode')",
      type="list",
      def="disabled",
	  section	= '2gamemode',
      items = {
         {
		 key = "disabled",
		 name = "Annihilation",
		 desc = "Only goal is complete and total annihilation of the enemy",
		 },
         {
		 key = "tugowar",
		 name = "Victory Points",
		 desc = "Owning more flags than the enemy causes them to lose tickets. When a team hits zero, they are eliminated." ,
		 },
         {
		 key = "multidomination",
		 name = "Multi-Domination Victory Points",
		 desc = "Hold all points for 20 seconds to score",
		 },
      },
   },
  {
      key="starttime",
      name="Start Time",
      desc="When the capturing of points can begin in Victory Point mode. (key = 'starttime')",
      type="list",
	  section	= '2gamemode',
      def="5",
      items = {
         { key = "0", name = "0", desc = "0 minutes", },
         { key = "2", name = "2", desc = "2 minutes", },
         { key = "3", name = "3", desc = "3 minutes", },
         { key = "5", name = "5", desc = "5 minutes", },
         { key = "10", name = "10", desc = "10 minutes", },
      },
   },
   {
      key="limitscore",
      name="Score Limit",
      desc="The Winning Amount for Victory Point Mode",
      type="list",
	  section	= '2gamemode',
      def="1000",
      items = {
         { key = "200", name = "200", desc = "Very Short", },
         { key = "500", name = "500", desc = "Short", },
         { key = "1000", name = "1000", desc = "Average", },
         { key = "2000", name = "2000", desc = "Long", },
         { key = "3000", name = "3000", desc = "Insane!", },
      },
   },
   
  {
	key    = '3resources',
	name   = 'Resource Settings',
	desc   = 'Sets various options related to the in-game resources, Command and Logistics',
	type   = 'section',
  },
  
   {
    key    = "game_length",
    name   = "Game Length",
    desc   = "Determines how long the game lasts before a winner is declared (in minutes). (key = 'game_length')",
    type   = "number",
    def    = 10,
    min    = 5,
    max    = 30,
	section= '3resources',
    step   = 0.5,
  },
  
   {
    key    = "command_storage",
    name   = "Fixed Command Storage",
    desc   = "Fixes the command storage of all players. (key = 'command_storage')",
    type   = "number",
    def    = 100000,
    min    = 1000,
    max    = 5000000,
	section= '3resources',
    step   = 1000,
  },
  
  {
    key    = "base_income",
    name   = "Base income level",
    desc   = "Sets the baseline income level for all teams.. (key = 'base_income')",
    type   = "number",
    def    = 750,
    min    = 100,
    max    = 1250,
	section= '3resources',
    step   = 10,
  },



	

	
	  {
	key    = '1balance',
	name   = 'Balance Settings. REMOVE BEFORE RELEASE',
	desc   = "Sets experimental balance options.",
	type   = 'section',
  },
  
   --[[  {
    key    = "weapon_apdamage_mult",
    name   = "AP damage multiplier",
    desc   = "Applies a multiplier to all the AP damage values",
    type   = "number",
    def    = 1,
    min	   = 0.01,
    max    = 2,
	section= '1balance',
    step   = 0.05,
  },]]--

	{
	key    = '4other',
	name   = 'Other Settings',
	desc   = 'Various other settings',
	type   = 'section',
  },
	
	{
		key = "gm_team_enable",
		name = "Enable Sandbox/GM tools faction",
		desc = "Allows the sandbox/game master tools faction to spawn, rather than changing to a random team (key = 'gm_team_enable')",
		type = "bool",
		section = '4other',
		def = false,
	},

	{
    key    = "weapon_range_mult",
    name   = "Range multiplier",
    desc   = 'Multiplies the range of all weapons, adjusting accuracy and weapon velocity as well. 1 is default, 8 is "realistic".',
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 8.0,
	section = '4other',
    step   = 0.1,
	},
	
	 {
    key    = "unit_los_mult",
    name   = "Unit sight (los/airLoS) multiplier",
    desc   = "Applies a multiplier to all the LoS ranges ingame",
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 10,
	section = '4other',
    step   = 0.1,
  },




  --[[ 

  {
    key    = "weapon_reload_mult",
    name   = "Weapon reload multiplier",
    desc   = "Applies a multiplier to all the weapon reloadtimes ingame",
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 10,
    step   = 0.1,
  },

  {
    key    = "unit_speed_mult",
    name   = "Unit speed multiplier",
    desc   = "Applies a multiplier to all the unit speeds and acceleration values ingame",
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 10,
    step   = 0.1,
  },
    {
    key    = "weapon_aoe_mult",
    name   = "AoE multiplier",
    desc   = "Applies a multiplier to all the weapon AoE values",
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 10,
    step   = 0.05,
  },

   {
    key    = "weapon_hedamage_mult",
    name   = "HE damage multiplier",
    desc   = "Applies a multiplier to all the HE damage values",
    type   = "number",
    def    = 1.0,
    min	   = 0.1,
    max    = 10,
    step   = 0.05,
  },
  {
    key    = "weapon_edgeeffectiveness_mult",
    name   = "Weapon edgeeffectiveness multiplier",
    desc   = "Applies a multiplier to all the weapon edgeeffectiveness ingame",
    type   = "number",
    def    = 1.0,
    min	   = 0.01,
    max    = 10,
    step   = 0.1,
  }
  {
    key    = "unit_hq_platoon",
    name   = "HQ-centric infantry game",
    desc   = "Removes rifle/assault squads from barracks, puts them in HQ",
    type   = "number",
    def    = 0,
    min	   = 0,
    max    = 1,
    step   = 1,
  }]]--

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  C.R.A.I.G. specific option(s)
--
  {
	key    = '5ai',
	name   = 'A.I. Settings',
	desc   = "Sets C.R.A.I.G's options",
	type   = 'section',
  },
	{
		key    = "craig_difficulty",
		name   = "C.R.A.I.G. difficulty level",
		desc   = "Sets the difficulty level of the C.R.A.I.G. bot. (key = 'craig_difficulty')",
		type   = "list",
		section = "5ai",
		def    = "2",
		items = {
			{
				key = "1",
				name = "Easy",
				desc = "No resource cheating."
			},
			{
				key = "2",
				name = "Medium",
				desc = "Little bit of resource cheating."
			},
			{
				key = "3",
				name = "Hard",
				desc = "Infinite resources."
			},
		}
	},
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
}
return options
