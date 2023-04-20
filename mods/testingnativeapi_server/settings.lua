testKey = "screen_w"
testValue = "1920"
testValue2 = "1700"

testKey2 = "screen_h"
testValue3 = "914"
testValue4 = "700"

testBoolKey = "show_nametag_backgrounds"
testBoolValue = true;

testFlagsKey = "csm_restriction_flags"
testFlagsValue = 0

local npValue = {
	offset = 50,
		scale = 50,
		spread = {x = 2000, y = 2000, z = 2000},
		seed = 842,
		octaves = 3,
		persistence = 0.5,
		lacunarity = 2.0,
		flags = "defaults"
}

minetest.set_mapgen_setting_noiseparams(
	"mg_biome_np_humidity",
	{
		offset = 50,
		scale = 50,
		spread = {x = 1000, y = 1000, z = 1000},
		seed = 842,
		octaves = 3,
		persistence = 0.5,
		lacunarity = 2.0,
		flags = "defaults"
	},
	true
)

minetest.settings:native_set_np_group("mg_biome_np_humidity",npValue);

minetest.register_chatcommand("lua_settings_get", {
	description = "Invokes lua_api > l_settings.l_lua_settings_get",
	func = function(self)
        local res = minetest.settings:get(testKey);
        if res then
            return true, "Success, get() returned: "..tostring(res)
        else
            return false, "Setting does not exist in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("native_settings_get", {
	description = "Invokes lua_api > l_settings.l_native_get",
	func = function(self)
        local res = minetest.settings:native_get(testKey);
        if res then
            return true, "Success, native_get() returned: "..tostring(res)
        else
            return false, "Setting does not exist in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("test_settings_get", {
	description = "Asserts lua api and native api behaviors for l_settings.get",
	func = function(self)
		local lua = minetest.settings:get(testKey);
		local native = minetest.settings:native_get(testKey);
		if lua == native then
			return true, "(Success) [Settings] get()"
		else
			return false, "(Fail) [Settings] get()"
		end
	end
})

minetest.register_chatcommand("lua_settings_getbool", {
	description = "Invokes lua_api > l_settings.lua_settings_get_bool",
	func = function(self)
        local res = minetest.settings:get_bool(testBoolKey);
        if res then
            return true, "Success, get_bool() returned: "..tostring(res)
        else
            return false, "Key does not exist in Minetest.conf" 
        end
	end
})


minetest.register_chatcommand("native_settings_getbool", {
	description = "Invokes lua_api > l_settings.native_settings_get_bool",
	func = function(self)
        local res = minetest.settings:native_get_bool(testBoolKey);
        if res then
            return true, "Success, native_get_bool() returned: "..tostring(res)
        else
            return false, "Key does not exist in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("test_settings_getbool", {
	description = "Asserts lua api and native api behaviors for l_settings.get_bool",
	func = function(self)
		local lua = minetest.settings:get_bool(testBoolKey);
		local native = minetest.settings:native_get_bool(testBoolKey);
		if lua == native then
			return true, "(Success) [Settings] get_bool()"
		else
			return false, "(Fail) [Settings] get_bool()"
		end
	end
})

minetest.register_chatcommand("lua_settings_getnpgroup", {
	description = "Invokes lua_api > l_settings.lua_settings_get_np_group",
	func = function(self)
        local res = minetest.settings:get_np_group("mg_biome_np_humidity");
        if res then
            return true, "Success, get_np_group() returned: "..dump(res)
        else
            return false, "No NoiseParams table for this key" 
        end
	end
})

minetest.register_chatcommand("native_settings_getnpgroup", {
	description = "Invokes lua_api > l_settings.native_settings_get_np_group",
	func = function(self)
        local res = minetest.settings:native_get_np_group("mg_biome_np_humidity");
        if res then
            return true, "Success, get_np_group() returned: "..dump(res)
        else
            return false, "No NoiseParams table for this key" 
        end
	end
})

minetest.register_chatcommand("test_settings_getnpgroup", {
	description = "Asserts lua api and native api behaviors for l_settings.get_np_group",
	func = function(self)
		local lua = minetest.settings:get_np_group("mg_biome_np_humidity");
		local native = minetest.settings:native_get_np_group("mg_biome_np_humidity");
		if dump(lua) == dump(native) then
			return true, "(Success) [Settings] get_np_group()"
		else
			return false, "(Fail) [Settings] get_np_group()"
		end
	end
})



minetest.register_chatcommand("lua_settings_getflags", {
	description = "Invokes lua_api > l_settings.lua_settings_get_flags",
	func = function(self)
        local res = minetest.settings:get_flags(testFlagsKey);
        if res then
            return true, "Success, get_flags() returned: "..tostring(res)
        else
            return false, "No flags found for this key" 
        end
	end
})

minetest.register_chatcommand("lua_settings_set", {
	description = "Invokes lua_api > l_settings.lua_settings_set",
	func = function(self)
        local res = minetest.settings:set("water_wave_height",1.0);
        if not res then
            return true, "Success, set() returned: "..tostring(res)
        else
            return false, "Cannot set key,value in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("native_settings_set", {
	description = "Invokes lua_api > l_settings.native_settings_set",
	func = function(self)
        local res = minetest.settings:native_set("water_wave_height",2.0);
        if not res then
            return true, "Success, native_set() returned: "..tostring(res)
        else
            return false, "Cannot set key,value in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("test_settings_set", {
	description = "Asserts lua api and native api behaviors for l_settings.set",
	func = function(self)
		local lua = minetest.settings:set("water_wave_height",3.0);
		local native = minetest.settings:native_set("water_wave_height",2.0);
		if not lua ==  not native then
			return true, "(Success) [Settings] set()"
		else
			return false, "(Fail) [Settings] set()"
		end
	end
})

--RETURN, unsure about how to call
minetest.register_chatcommand("lua_settings_setbool", {
	description = "Invokes lua_api > l_settings.lua_settings_set_bool",
	func = function(self)
        local res = minetest.settings:set_bool(testBoolKey,testBoolValue);
        if res then
            return true, "Success, set_bool() returned: "..tostring(res)
        else
            return false, "Cannot set key,value in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("native_settings_setbool", {
	description = "Invokes lua_api > l_settings.native_settings_set_bool",
	func = function(self)
        local res = minetest.settings:native_set_bool(testBoolKey,testBoolValue);
        if res then
            return true, "Success, native_set_bool() returned: "..tostring(res)
        else
            return false, "Cannot set key,value in Minetest.conf" 
        end
	end
})

minetest.register_chatcommand("test_settings_setbool", {
	description = "Asserts lua api and native api behaviors for l_settings.set_bool",
	func = function(self)
		local lua = minetest.settings:set_bool(testBoolKey,testBoolValue);
		local native = minetest.settings:native_set_bool(testBoolKey,testBoolValue);
		if lua == native then
			return true, "(Success) [Settings] set_bool()"
		else
			return false, "(Fail) [Settings] set_bool()"
		end
	end
})

--Nothing is pushed to th lua stack, need to check output dump to confirm
minetest.register_chatcommand("lua_settings_setnpgroup", {
	description = "Invokes lua_api > l_settings.lua_settings_set_np_group",
	func = function(self)
        local res = minetest.settings:set_np_group("mg_biome_np_humidity",npValue);
        return true, "Success, set_np_group() returned: "..dump(res)
       
	end
})

minetest.register_chatcommand("native_settings_setnpgroup", {
	description = "Invokes lua_api > l_settings.native_settings_set_np_group",
	func = function(self)
        local res = minetest.settings:native_set_np_group("mg_biome_np_humidity",npValue);
        return true, "Success, set_np_group() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_settings_setnpgroup", {
	description = "Asserts lua api and native api behaviors for l_settings.set_np_group",
	func = function(self)
		local lua = minetest.settings:native_set_np_group("mg_biome_np_humidity",npValue);
		local native = minetest.settings:native_set_np_group("mg_biome_np_humidity",npValue);
		if lua == native then
			return true, "(Success) [Settings] set()"
		else
			return false, "(Fail) [Settings] set()"
		end
	end
})


minetest.register_chatcommand("lua_settings_remove", {
	description = "Invokes lua_api > l_settings.lua_settings_remove",
	func = function(self)
        local res = minetest.settings:remove("mg_biome_np_humidity");
        if res then
            return true, "Success, remove() returned: "..tostring(res)
        else
            return false, "Cannot remove key" 
        end
	end
	
})


minetest.register_chatcommand("native_settings_remove", {
	description = "Invokes lua_api > l_settings.native_settings_remove",
	func = function(self)
		minetest.settings:native_set_np_group("mg_biome_np_humidity",npValue);
        local res = minetest.settings:native_remove("mg_biome_np_humidity");
        if res then
            return true, "Success, native_remove() returned: "..tostring(res)
        else
            return false, "Cannot remove key" 
        end
	end
})
--Tests removing keys that dont exist, should return nil
minetest.register_chatcommand("test_settings_remove", {
	description = "Asserts lua api and native api behaviors for l_settings.remove",
	func = function(self)
		local lua = minetest.settings:remove("wacky_key");
		local native = minetest.settings:native_remove("wacky_key2");
		if lua == native then
			return true, "(Success) [Settings] remove()"
		else
			return false, "(Fail) [Settings] remove()"
		end
	end
})

minetest.register_chatcommand("lua_settings_getnames", {
	description = "Invokes lua_api > l_settings.lua_settings_get_names",
	func = function(self)
        local res = minetest.settings:get_names();
        if res then
            return true, "Success, get_names() returned: "..dump(res)
        else
            return false, "Cannot get names" 
        end
	end
})

minetest.register_chatcommand("native_settings_getnames", {
	description = "Invokes lua_api > l_settings.native_settings_get_names",
	func = function(self)
        local res = minetest.settings:native_get_names();
        if res then
            return true, "Success, native_get_names() returned: "..dump(res)
        else
            return false, "Cannot get names" 
        end
	end
})

minetest.register_chatcommand("test_settings_getnames", {
	description = "Asserts lua api and native api behaviors for l_settings.remove",
	func = function(self)
		local lua = minetest.settings:get_names();
		local native = minetest.settings:native_get_names();
		if dump(lua) == dump(native) then
			return true, "(Success) [Settings] get_names()"
		else
			return false, "(Fail) [Settings] get_names()"
		end
	end
})

minetest.register_chatcommand("lua_settings_write", {
	description = "Invokes lua_api > l_settings.lua_settings_write",
	func = function(self)
        local res = minetest.settings:write();
        if res then
            return true, "Success, write() returned: "..tostring(res)
        else
            return false, "Cannot write" 
        end
	end
})

minetest.register_chatcommand("native_settings_write", {
	description = "Invokes lua_api > l_settings.native_settings_write",
	func = function(self)
        local res = minetest.settings:native_write();
        if res then
            return true, "Success, native_write() returned: "..tostring(res)
        else
            return false, "Cannot write" 
        end
	end
})

minetest.register_chatcommand("test_settings_write", {
	description = "Asserts lua api and native api behaviors for l_settings.write",
	func = function(self)
		local lua = minetest.settings:write();
		local native = minetest.settings:native_write();
		if lua == native then
			return true, "(Success) [Settings] write()"
		else
			return false, "(Fail) [Settings] write()"
		end
	end
})

minetest.register_chatcommand("lua_settings_totable", {
	description = "Invokes lua_api > l_settings.lua_settings_to_table",
	func = function(self)
        local res = minetest.settings:to_table();
        if res then
            return true, "Success, to_table() returned: "..dump(res)
        else
            return false, "to_table() failed" 
        end
	end
})

minetest.register_chatcommand("native_settings_totable", {
	description = "Invokes lua_api > l_settings.native_settings_to_table",
	func = function(self)
        local res = minetest.settings:native_to_table();
        if res then
            return true, "Success, native_to_table() returned: "..dump(res)
        else
            return false, "native_to_table() failed" 
        end
	end
})

minetest.register_chatcommand("test_settings_totable", {
	description = "Asserts lua api and native api behaviors for l_settings.to_table",
	func = function(self)
		local lua = minetest.settings:to_table();
		local native = minetest.settings:native_to_table();
		if dump(lua) == dump(native) then
			return true, "(Success) [Settings] to_table()"
		else
			return false, "(Fail) [Settings] to_table()"
		end
	end
})

--Set 1 more time to have key at start of next test
minetest.set_mapgen_setting_noiseparams(
	"mg_biome_np_humidity",
	{
		offset = 50,
		scale = 50,
		spread = {x = 1000, y = 1000, z = 1000},
		seed = 842,
		octaves = 3,
		persistence = 0.5,
		lacunarity = 2.0,
		flags = "defaults"
	},
	true
)



--command to test entire class
minetest.register_chatcommand("test_settings", {
	description = "testing all settings methods",
	func = function()

		local methods = {
			"get",
			"getbool",
			"getnpgroup",
			--"getflags",
			"set",
            "setbool",
            "setnpgroup",
            "remove",
            "getnames",
            "write",
			"totable"
		}

		return native_tests.test_class("settings", methods), 
		"Settings tests completed. See server_dump.txt for details."
	end
})