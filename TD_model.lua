local P = {}   -- package

if _REQUIREDNAME == nil then
  TD_model = P
else
  _G[_REQUIREDNAME] = P
end
setfenv(1, P)

episodes = { { name = "COVID-19", levels=3 },
			 { name = "Predators", levels=5 },
			 { name = "Aussies", levels=4 } }

return P