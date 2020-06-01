local P = {}   -- package

if _REQUIREDNAME == nil then
  TD_model = P
else
  _G[_REQUIREDNAME] = P
end

P.activeEpisode = nil
P.activeLevel = nil

P.episodes = { { name  = "COVID-19", 
				levels = { 
					{
						name = "Level 1",
						enemies = "1111X1111"
					},
				} 
			} }

function getCurrentLevel () 
	return (P.episodes[P.activeEpisode]).levels[P.activeLevel]
end
P.getCurrentLevel = getCurrentLevel
return P