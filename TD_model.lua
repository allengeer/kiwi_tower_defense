local P = {}   -- package

if _REQUIREDNAME == nil then
  TD_model = P
else
  _G[_REQUIREDNAME] = P
end

P.activeEpisode = nil
P.activeLevel = nil

P.episodes = { { name  = "COVID-19", 
				 prefix = "COV",
				 levels = { 
				 	{
				 		name = "Level 1",
 						enemies = "1111X1111",
 						path = { {20,322}, {956,322} },
 						placeable_area = { },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 2",
				 		enemies = "1X11X11",
 						path = { {20, 535}, {277, 535},{277, 80},{562, 80}, {562,489}, {824, 489},{824, 120},{956, 120}},
 						placeable_area = { },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 3",
 						enemies = "1111X1111",
 						path = { {20, 507}, {150, 507}, {173,104}, {542,82}, {540, 482}, {951, 516}},
 						placeable_area = { },
 						levelTime=10
				 	},
				 	{
				 		name = "Level 4",
				 		enemies = "1X11X11",
 						path = { {20,94}, {823,92}, {821, 307}, {69, 334}, {61, 586}, {947,565} },
 						placeable_area = { },
 						levelTime = 10
				 	},{
				 		name = "Level 5",
 						enemies = "1111X1111",
 						path = { {0,0}, {944, 628} },
 						placeable_area = { },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 6",
				 		enemies = "1X11X11",
 						path = {{0,635}, {420, 80}, {541,582}, {954, 88} },
 						placeable_area = { },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 7",
 						enemies = "1111X1111",
 						path = { {0, 568}, {151,228}, {493, 115}, {747, 181}, {956, 509}},
 						placeable_area = { },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 8",
				 		enemies = "1X11X11",
 						path = { {0,358}, {231, 410}, {375,356}, {531, 228}, {685,348}, {956, 637} },
 						placeable_area = {  },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 9",
 						enemies = "1111X1111",
 						path = { {0, 386}, {778, 174}, {959, 526} },
 						placeable_area = { },
 						levelTime = 10
				 	},
				 	{
				 		name = "Level 10",
				 		enemies = "1X11X11",
 						path = { {0, 350 }, {212,319}, {504, 76}, {805,334}, {957, 343}},
 						placeable_area = { },
 						levelTime = 10
				 	}
				 } 
			} }

function getCurrentLevel () 
	return (P.episodes[P.activeEpisode]).levels[P.activeLevel]
end

function getCurrentEpisode () 
	return P.episodes[P.activeEpisode]
end

P.getCurrentLevel = getCurrentLevel
P.getCurrentEpisode = getCurrentEpisode
return P