local lu = require ("luaunit")
local TD_model = require ("TD_model")

TestModel = {}
	function TestModel:testEpisodes()
		lu.assertIsTable(TD_model.episodes, "Episode table not there")
		lu.assertTrue(#TD_model.episodes > 0, "No Episodes in Episode Table")
	end

os.exit( lu.LuaUnit.run() )