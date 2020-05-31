local lu = require ("luaunit")
local TD_model = require ("TD_model")

TestModel = {}
	function TestModel:testEpisodes()
		lu.assertIsTable(TD_model.episodes)
		lu.assertTrue(table.getn(TD_model.episodes))
	end


os.exit( lu.LuaUnit.run() )