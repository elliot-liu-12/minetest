minetest.log("info", "[testing] modname="..dump(minetest.get_current_modname()))
minetest.log("info", "[testing] modpath="..dump(minetest.get_modpath("testingnativeapi_client")))

minetest.register_on_mods_loaded(function()
	minetest.log("action", "[testing] on_mods_loaded()")
end)

local modpath = minetest.get_modpath("testingnativeapi_client")

-- Load test suite
native_tests = dofile(modpath .. "/native_tests.lua")

-- Load files
dofile(modpath .. "/camera.lua")
dofile(modpath .. "/minimap.lua")
dofile(modpath .. "/item.lua")
dofile(modpath .. "/other.lua")
dofile(modpath .. "/client.lua")
dofile(modpath .. "/localplayer.lua")
dofile(modpath .. "/client_test.lua")
dofile(modpath .. "/particles_local.lua")
dofile(modpath .. "/localplayer.lua")
dofile(modpath .. "/modchannels.lua")
