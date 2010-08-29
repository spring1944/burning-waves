--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


local devolution = (-1 > 0)


local morphDefs = {

  --[[armdecom = {
    into = 'acom',
    time   = 200,    -- game seconds
    metal  = 10000, -- metal cost
    energy = 60000, -- energy cost
      tech = 2,            -- tech level
      xp = 0.5,            -- required unit XP
  },

  cordecom = {
    into = 'ccom',
    time   = 200,    -- game seconds
    metal  = 10000, -- metal cost
    energy = 60000, -- energy cost
      tech = 2,            -- tech level
  },]]--

  -- Machineguns
  
  usbalao_surfaced = {
    {
      into = 'usbalao',
      tech = 0,
      time = 5,
      metal = 0,
      energy = 0,
      directional = false,
    },
  },
  
    usbalao = {
    {
      into = 'usbalao_surfaced',
      tech = 0,
      time = 5,
      metal = 0,
      energy = 0,
      directional = false,
    },
    {
      into = 'usbalao_submerged',
      tech = 0,
      time = 5,
      metal = 0,
      energy = 0,
      directional = false,
    },
  },
  
    usbalao_submerged = {
    {
      into = 'usbalao',
      tech = 0,
      time = 5,
      metal = 0,
      energy = 0,
      directional = false,
    },
  },
}
--
-- Here's an example of why active configuration
-- scripts are better then static TDF files...
--

--
-- devolution, babe  (useful for testing)
--
if (devolution) then
  local devoDefs = {}
  for src,data in pairs(morphDefs) do
    devoDefs[data.into] = { into = src, time = 10, metal = 1, energy = 1 }
  end
  for src,data in pairs(devoDefs) do
    morphDefs[src] = data
  end
end


return morphDefs

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
