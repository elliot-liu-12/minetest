--Util class test mod

minetest.log("--Util class tests--")



--##########################################--



--log()
--lua test
minetest.register_chatcommand("lua_util_log",
{
	description = "Test util class method log() (lua version)",
	func = function(self)
		if (pcall(minetest.log, "LuaLog")) then
			return true, "Success, log() (lua version) executed"
		else
			return false, "Failure, log() (lua version) did not execute properly"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_log",
{
	description = "Test util class method log() (native version)",
	func = function(self)
		if (pcall(minetest.native_log, "NativeLog")) then
			return true, "Success, log() (lua version) executed"
		else
			return false, "Failure, log() (lua version) did not execute properly"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_log",
{
	description = "Test util class method log() (lua and native comparison)",
	func = function(self)
		if(pcall(minetest.log, "LuaLog") and pcall(minetest.native_log, "NativeLog")) then
			return true, "Success, both lua and native logs execute"
		else
			return false, "Failure, either lua or native log did not execute"
		end
	end
})



--##########################################--



--get_us_time()
--lua test
minetest.register_chatcommand("lua_util_get_us_time",
{
	description = "Test util class method get_us_time() (lua version)",
	func = function(self)
		local l_time = minetest.get_us_time();
		local l_time2 = minetest.get_us_time();
		
		local res = math.abs(l_time2 - l_time);
		
		if(res <= 1) then
			return true, "Success, lua_get_us_time() is on the microsecond level"
		else
			return false, "Failure, lua_get_us_time() is not on the microsecond level"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_us_time",
{
	description = "Test util class method get_us_time() (native version)",
	func = function(self)
		local n_time = minetest.native_get_us_time();
		local n_time2 = minetest.native_get_us_time();
		
		local res = math.abs(n_time2 - n_time);
		
		if(res <= 1) then
			return true, "Success, native_get_us_time() is on the microsecond level"
		else
			return false, "Failure, native_get_us_time() is not on the microsecond level"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_us_time",
{
	description = "Test util class method get_us_time() (lua and native comparison)",
	func = function(self)
		local l_time = minetest.get_us_time();
		local l_time2 = minetest.get_us_time();
		
		local n_time = minetest.native_get_us_time();
		local n_time2 = minetest.native_get_us_time();
		
		local l_res = math.abs(l_time2 - l_time);
		local n_res = math.abs(n_time2 - n_time);
		
		if(l_res <= 1 and n_res <= 1) then
			return true, "Success, the difference between get_us_time() and native_get_us_time() is on the microsecond level"
		else
			return false, "Failure, the difference between get_us_time() and native_get_us_time() is not on the microsecond level"
		end
	end
})



--##########################################--



--parse_json()
--lua test
minetest.register_chatcommand("lua_util_parse_json",
{
	description = "Test util class method parse_json() (lua version)",
	func = function(self)
		local l_list = minetest.parse_json("[{\"a\":true}, \"b\", 3, true]");
		
		local l_res = false;
		
		if((l_list[1]["a"] == true) and (l_list[2] == "b") and (l_list[3] == 3) and (l_list[4] == true)) then
			l_res = true;
		end
		
		if(l_res) then
			return true, "Success, lua_parse_json() executed"
		else
			return false, "Failure, lua_parse_json() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_parse_json",
{
	description = "Test util class method parse_json() (native version)",
	func = function(self)
		local n_list = minetest.native_parse_json("[{\"a\":true}, \"b\", 3, true]");
		
		local n_res = false;
		
		if((n_list[1]["a"] == true) and (n_list[2] == "b") and (n_list[3] == 3) and (n_list[4] == true)) then
			n_res = true;
		end
		
		if(n_res) then
			return true, "Success, native_parse_json() executed"
		else
			return false, "Failure, native_parse_json() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_parse_json",
{
	description = "Test util class method parse_json() (lua and native comparison)",
	func = function(self)
		local l_list = minetest.parse_json("[{\"a\":true}, \"b\", 3, true]");
		local n_list = minetest.native_parse_json("[{\"a\":true}, \"b\", 3, true]");
		
		local l_res = false;
		local n_res = false;
		
		if((l_list[1]["a"] == true) and (l_list[2] == "b") and (l_list[3] == 3) and (l_list[4] == true)) then
			l_res = true;
		end
		
		if((n_list[1]["a"] == true) and (n_list[2] == "b") and (n_list[3] == 3) and (n_list[4] == true)) then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_parse_json() and native_parse_json() executed"
		else
			return false, "Failure, either lua_parse_json() or native_parse_json() did not execute"
		end
	end
})



--##########################################--



--write_json()
--lua test
minetest.register_chatcommand("lua_util_write_json",
{
	description = "Test util class method write_json() (lua version)",
	func = function(self)
		local l_json = minetest.write_json({{a = true}, "b", 3, true});
		
		local l_res = false;
		
		if(l_json == '[{"a":true},"b",3.0,true]') then
			l_res = true;
		end
		
		if(l_res) then
			return true, "Success, lua_write_json() executed"
		else
			return false, "Failure, lua_write_json() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_write_json",
{
	description = "Test util class method write_json() (native version)",
	func = function(self)
		local n_json = minetest.native_write_json({{a = true}, "b", 3, true});
		
		local n_res = false;
		
		if(n_json == '[{"a":true},"b",3.0,true]') then
			n_res = true;
		end
		
		if(n_res) then
			return true, "Success, native_write_json() executed"
		else
			return false, "Failure, native_write_json() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_write_json",
{
	description = "Test util class method write_json() (lua and native comparison)",
	func = function(self)
		
		local l_json = minetest.write_json({{a = true}, "b", 3, true});
		local n_json = minetest.native_write_json({{a = true}, "b", 3, true});
		
		local l_res = false;
		local n_res = false;
		
		if(l_json == '[{"a":true},"b",3.0,true]') then
			l_res = true;
		end
		
		if(n_json == '[{"a":true},"b",3.0,true]') then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_write_json() and native_write_json() executed"
		else
			return false, "Failure, either lua_write_json() or native_write_json() did not execute"
		end
	end
})



--##########################################--



--get_dig_params()
--lua test
minetest.register_chatcommand("lua_util_get_dig_params",
{
	description = "Test util class method get_dig_params() (lua version)",
	func = function(self)
		
		local groupVal = minetest.registered_nodes["chest:chest"].groups;
		local toolVal = {groupcaps = {crumbly = {maxlevel = 3, uses = 10, times = {[1] = 3, [2] = 2, [3] = 1}}},};
		local t = minetest.get_dig_params(groupVal, toolVal);
		
		local l_res = false;
		if((t["diggable"] == true) and (t["time"] == 0.5) and (t["wear"] == 0)) then
			l_res = true;
		end
		
		if(l_res) then
			return true, "Success, lua_get_dig_params() executed"
		else
			return false, "Failure, lua_get_dig_params() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_dig_params",
{
	description = "Test util class method get_dig_params() (native version)",
	func = function(self)
		
		local groupVal = minetest.registered_nodes["chest:chest"].groups;
		local toolVal = {groupcaps = {crumbly = {maxlevel = 3, uses = 10, times = {[1] = 3, [2] = 2, [3] = 1}}},};
		local t = minetest.native_get_dig_params(groupVal, toolVal);
		
		local n_res = false;
		if((t["diggable"] == true) and (t["time"] == 0.5) and (t["wear"] == 0)) then
			n_res = true;
		end
		
		if(n_res) then
			return true, "Success, native_get_dig_params() executed"
		else
			return false, "Failure, native_get_dig_params() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_dig_params",
{
	description = "Test util class method get_dig_params() (lua and native comparison)",
	func = function(self)
		
		local groupVal = minetest.registered_nodes["chest:chest"].groups;
		local toolVal = {groupcaps = {crumbly = {maxlevel = 3, uses = 10, times = {[1] = 3, [2] = 2, [3] = 1}}},};
		
		local l_t = minetest.get_dig_params(groupVal, toolVal);
		local n_t = minetest.native_get_dig_params(groupVal, toolVal);
		
		local l_res = false;
		local n_res = false;
		
		if((l_t["diggable"] == true) and (l_t["time"] == 0.5) and (l_t["wear"] == 0)) then
			l_res = true;
		end
		
		if((n_t["diggable"] == true) and (n_t["time"] == 0.5) and (n_t["wear"] == 0)) then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_get_dig_params() and native_get_dig_params() executed"
		else
			return false, "Failure, either lua_get_dig_params() or native_get_dig_params() did not execute"
		end
	end
})



--##########################################--



--get_hit_params()
--lua test
minetest.register_chatcommand("lua_util_get_hit_params",
{
	description = "Test util class method get_hit_params() (lua version)",
	func = function(self)
		
		local groupVal = minetest.registered_entities["testentities:armorball"].groups;
		local toolVal = {full_punch_interval = 1, groupcaps = {crumbly = {maxlevel = 3, uses = 10, times = {[1] = 3, [2] = 2, [3] = 1}}}, damage_groups = {fleshy = 6},};
		local t = minetest.get_hit_params(groupVal, toolVal);
		
		local l_res = false;
		if((t["hp"] == 0) and (t["wear"] == 0)) then
			l_res = true;
		end
		
		if(l_res) then
			return true, "Success, lua_get_hit_params() executed"
		else
			return false, "Failure, lua_get_hit_params() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_hit_params",
{
	description = "Test util class method get_hit_params() (native version)",
	func = function(self)
		
		local groupVal = minetest.registered_entities["testentities:armorball"].groups;
		local toolVal = {full_punch_interval = 1, groupcaps = {crumbly = {maxlevel = 3, uses = 10, times = {[1] = 3, [2] = 2, [3] = 1}}}, damage_groups = {fleshy = 6},};
		local t = minetest.native_get_hit_params(groupVal, toolVal);
		
		local n_res = false;
		if((t["hp"] == 0) and (t["wear"] == 0)) then
			n_res = true;
		end
		
		if(n_res) then
			return true, "Success, native_get_hit_params() executed"
		else
			return false, "Failure, native_get_hit_params() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_hit_params",
{
	description = "Test util class method get_hit_params() (lua and native comparison)",
	func = function(self)
		
		local groupVal = minetest.registered_entities["testentities:armorball"].groups;
		local toolVal = {full_punch_interval = 1, groupcaps = {crumbly = {maxlevel = 3, uses = 10, times = {[1] = 3, [2] = 2, [3] = 1}}}, damage_groups = {fleshy = 6},};
		
		local l_t = minetest.get_hit_params(groupVal, toolVal);
		local n_t = minetest.native_get_hit_params(groupVal, toolVal);
		
		local l_res = false;
		local n_res = false;
		
		if((l_t["hp"] == 0) and (l_t["wear"] == 0)) then
			l_res = true;
		end
		
		if((n_t["hp"] == 0) and (n_t["wear"] == 0)) then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_get_hit_params() and native_get_hit_params() executed"
		else
			return false, "Failure, either lua_get_hit_params() or native_get_hit_params() did not execute"
		end
	end
})



--##########################################--



--check_password_entry()
--lua test
minetest.register_chatcommand("lua_util_check_password_entry",
{
	description = "Test util class method check_password_entry() (lua version)",
	func = function(self)
		
		local auth = minetest.get_auth_handler().get_auth("singleplayer");
		local t = minetest.check_password_entry("singleplayer", auth.password, "");
		
		local l_res = false;
		if(t) then
			l_res = true;
		end;
		
		if(l_res) then
			return true, "Success, lua_check_password_entry() executed"
		else
			return false, "Failure, lua_check_password_entry() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_check_password_entry",
{
	description = "Test util class method check_password_entry() (native version)",
	func = function(self)
		
		local auth = minetest.get_auth_handler().get_auth("singleplayer");
		local t = minetest.native_check_password_entry("singleplayer", auth.password, "");
		
		local n_res = false;
		if(t) then
			n_res = true;
		end;
		
		if(n_res) then
			return true, "Success, native_check_password_entry() executed"
		else
			return false, "Failure, native_check_password_entry() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_check_password_entry",
{
	description = "Test util class method check_password_entry() (lua and native comparison)",
	func = function(self)
		
		local auth = minetest.get_auth_handler().get_auth("singleplayer");
		local l_t = minetest.check_password_entry("singleplayer", auth.password, "");
		local n_t = minetest.native_check_password_entry("singleplayer", auth.password, "");
		
		local l_res = false;
		local n_res = false;
		
		if(l_t) then
			l_res = true;
		end;
		
		if(n_t) then
			n_res = true;
		end;
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_check_password_entry() and native_check_password_entry() executed"
		else
			return false, "Failure, either lua_check_password_entry() or native_check_password_entry() did not execute"
		end
	end
})



--##########################################--



--get_password_hash()
--lua test
minetest.register_chatcommand("lua_util_get_password_hash",
{
	description = "Test util class method get_password_hash() (lua version)",
	func = function(self)
		
		local t = minetest.get_password_hash("singleplayer", "password");
		local hash = "gvHVvTz/1xKug3TKKzbQB2KjpY4";
		
		local l_res = false;
		if(t == hash) then
			l_res = true;
		end;
		
		if(l_res) then
			return true, "Success, lua_get_password_hash() executed"
		else
			return false, "Failure, lua_get_password_hash() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_password_hash",
{
	description = "Test util class method get_password_hash() (native version)",
	func = function(self)
		
		local t = minetest.native_get_password_hash("singleplayer", "password");
		local hash = "gvHVvTz/1xKug3TKKzbQB2KjpY4";
		
		local n_res = false;
		if(t == hash) then
			n_res = true;
		end;
		
		if(n_res) then
			return true, "Success, native_get_password_hash() executed"
		else
			return false, "Failure, native_get_password_hash() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_password_hash",
{
	description = "Test util class method get_password_hash() (lua and native comparison)",
	func = function(self)
		
		local l_t = minetest.get_password_hash("singleplayer", "password");
		local n_t = minetest.native_get_password_hash("singleplayer", "password");
		local hash = "gvHVvTz/1xKug3TKKzbQB2KjpY4";
		
		local l_res = false;
		local n_res = false;
		
		if(l_t == hash) then
			l_res = true;
		end;
		
		if(n_t == hash) then
			n_res = true;
		end;
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_get_password_hash() and native_get_password_hash() executed"
		else
			return false, "Failure, either lua_get_password_hash() or native_get_password_hash() did not execute"
		end
	end
})



--##########################################--



--is_yes()
--lua test
minetest.register_chatcommand("lua_util_is_yes",
{
	description = "Test util class method is_yes() (lua version)",
	func = function(self)
		
		local t = {"y", "yes", "true", 1, 100, -1, -100};
		
		local l_res = true;
		for i = 1, 7 do
			if(not minetest.is_yes(t[i])) then
				l_res = false;
				break;
			end
		end
		
		if(l_res) then
			return true, "Success, lua_is_yes() executed"
		else
			return false, "Failure, lua_is_yes() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_is_yes",
{
	description = "Test util class method is_yes() (native version)",
	func = function(self)
		
		local t = {"y", "yes", "true", 1, 100, -1, -100};
		
		local n_res = true;
		for i = 1, 7 do
			if(not minetest.native_is_yes(t[i])) then
				n_res = false;
				break;
			end
		end
		
		if(n_res) then
			return true, "Success, native_is_yes() executed"
		else
			return false, "Failure, native_is_yes() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_is_yes",
{
	description = "Test util class method is_yes() (lua and native comparison)",
	func = function(self)
		
		local t = {"y", "yes", "true", 1, 100, -1, -100};
		
		local l_res = true;
		local n_res = true;
		
		for i = 1, 7 do
			if(not minetest.is_yes(t[i])) then
				l_res = false;
			end
			
			if(not minetest.native_is_yes(t[i])) then
				n_res = false;
			end
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_is_yes() and native_is_yes() executed"
		else
			return false, "Failure, either lua_is_yes() or native_is_yes() did not execute"
		end
	end
})



--##########################################--



--get_builtin_path()
--lua test
minetest.register_chatcommand("lua_util_get_builtin_path",
{
	description = "Test util class method get_builtin_path() (lua version)",
	func = function(self)
		
		if (pcall(minetest.get_builtin_path)) then
			return true, "Success, lua_get_builtin_path() executed"
		else
			return false, "Failure, lua_get_builtin_path() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_builtin_path",
{
	description = "Test util class method get_builtin_path() (native version)",
	func = function(self)
		
		if (pcall(minetest.native_get_builtin_path)) then
			return true, "Success, native_get_builtin_path() executed"
		else
			return false, "Failure, native_get_builtin_path() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_builtin_path",
{
	description = "Test util class method get_builtin_path() (lua and native comparison)",
	func = function(self)
		
		local l_t = minetest.get_builtin_path();
		local n_t = minetest.native_get_builtin_path();
		
		if(l_t == n_t) then
			return true, "Success, both lua_get_builtin_path() and native_get_builtin_path() executed"
		else
			return false, "Failure, either lua_get_builtin_path() or native_get_builtin_path() did not execute"
		end
	end
})



--##########################################--



--get_user_path()
--lua test
minetest.register_chatcommand("lua_util_get_user_path",
{
	description = "Test util class method get_user_path() (lua version)",
	func = function(self)
		
		if (pcall(minetest.get_user_path)) then
			return true, "Success, lua_get_user_path() executed"
		else
			return false, "Failure, lua_get_user_path() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_user_path",
{
	description = "Test util class method get_user_path() (native version)",
	func = function(self)
		
		if (pcall(minetest.native_get_user_path)) then
			return true, "Success, native_get_user_path() executed"
		else
			return false, "Failure, native_get_user_path() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_user_path",
{
	description = "Test util class method get_user_path() (lua and native comparison)",
	func = function(self)
		
		local l_t = minetest.get_user_path();
		local n_t = minetest.native_get_user_path();
		
		if(l_t == n_t) then
			return true, "Success, both lua_get_user_path() and native_get_user_path() executed"
		else
			return false, "Failure, either lua_get_user_path() or native_get_user_path() did not execute"
		end
	end
})



--##########################################--



--compress()
--lua test
minetest.register_chatcommand("lua_util_compress",
{
	description = "Test util class method compress() (lua version)",
	func = function(self)
		
		local t1 = minetest.compress("SomeData", "deflate");
		local t2 = minetest.compress("OtherData", "zstd");
		
		local res = false;
		if(minetest.decompress(t1, "deflate") == "SomeData" and minetest.decompress(t2, "zstd") == "OtherData") then
			res = true;
		end
		
		if(res) then
			return true, "Success, lua_compress() executed"
		else
			return false, "Failure, lua_compress() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_compress",
{
	description = "Test util class method compress() (native version)",
	func = function(self)
		
		local t1 = minetest.native_compress("SomeData", "deflate");
		local t2 = minetest.native_compress("OtherData", "zstd");
		
		local res = false;
		if(minetest.native_decompress(t1, "deflate") == "SomeData" and minetest.native_decompress(t2, "zstd") == "OtherData") then
			res = true;
		end
		
		if(res) then
			return true, "Success, native_compress() executed"
		else
			return false, "Failure, native_compress() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_compress",
{
	description = "Test util class method compress() (lua and native comparison)",
	func = function(self)
		
		local l_t1 = minetest.compress("SomeData", "deflate");
		local l_t2 = minetest.compress("OtherData", "zstd");
		local n_t1 = minetest.native_compress("SomeData", "deflate");
		local n_t2 = minetest.native_compress("OtherData", "zstd");
		
		local l_res = false;
		if(minetest.decompress(l_t1, "deflate") == "SomeData" and minetest.decompress(l_t2, "zstd") == "OtherData") then
			l_res = true;
		end
		
		local n_res = false;
		if(minetest.native_decompress(n_t1, "deflate") == "SomeData" and minetest.native_decompress(n_t2, "zstd") == "OtherData") then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_compress() and native_compress() executed"
		else
			return false, "Failure, either lua_compress() or native_compress() did not execute"
		end
	end
})



--##########################################--



--decompress()
--lua test
minetest.register_chatcommand("lua_util_decompress",
{
	description = "Test util class method decompress() (lua version)",
	func = function(self)
		
		local t1 = minetest.compress("SomeData", "deflate");
		local t2 = minetest.compress("OtherData", "zstd");
		
		local res = false;
		if(minetest.decompress(t1, "deflate") == "SomeData" and minetest.decompress(t2, "zstd") == "OtherData") then
			res = true;
		end
		
		if(res) then
			return true, "Success, lua_decompress() executed"
		else
			return false, "Failure, lua_decompress() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_decompress",
{
	description = "Test util class method decompress() (native version)",
	func = function(self)
		
		local t1 = minetest.native_compress("SomeData", "deflate");
		local t2 = minetest.native_compress("OtherData", "zstd");
		
		local res = false;
		if(minetest.native_decompress(t1, "deflate") == "SomeData" and minetest.native_decompress(t2, "zstd") == "OtherData") then
			res = true;
		end
		
		if(res) then
			return true, "Success, native_decompress() executed"
		else
			return false, "Failure, native_decompress() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_decompress",
{
	description = "Test util class method decompress() (lua and native comparison)",
	func = function(self)
		
		local l_t1 = minetest.compress("SomeData", "deflate");
		local l_t2 = minetest.compress("OtherData", "zstd");
		local n_t1 = minetest.native_compress("SomeData", "deflate");
		local n_t2 = minetest.native_compress("OtherData", "zstd");
		
		local l_res = false;
		if(minetest.decompress(l_t1, "deflate") == "SomeData" and minetest.decompress(l_t2, "zstd") == "OtherData") then
			l_res = true;
		end
		
		local n_res = false;
		if(minetest.native_decompress(n_t1, "deflate") == "SomeData" and minetest.native_decompress(n_t2, "zstd") == "OtherData") then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_decompress() and native_decompress() executed"
		else
			return false, "Failure, either lua_decompress() or native_decompress() did not execute"
		end
	end
})



--##########################################--



--mkdir()
--lua test
minetest.register_chatcommand("lua_util_mkdir",
{
	description = "Test util class method mkdir() (lua version)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\luaTestFolder";
		local res = minetest.mkdir(path);
		
		if(res) then
			return true, "Success, lua_mkdir() executed"
		else
			return false, "Failure, lua_mkdir() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_mkdir",
{
	description = "Test util class method mkdir() (native version)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\nativeTestFolder";
		local res = minetest.native_mkdir(path);
		
		if(res) then
			return true, "Success, native_mkdir() executed"
		else
			return false, "Failure, native_mkdir() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_mkdir",
{
	description = "Test util class method mkdir() (lua and native comparison)",
	func = function(self)
		
		local l_path = minetest.get_worldpath() .. "\\luaTestFolder\\luaComparisonFolder";
		local l_res = minetest.mkdir(l_path);
		local n_path = minetest.get_worldpath() .. "\\nativeTestFolder\\nativeComparisonFolder";
		local n_res = minetest.native_mkdir(n_path);
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_mkdir() and native_mkdir() executed"
		else
			return false, "Failure, either lua_mkdir() or native_mkdir() did not execute"
		end
	end
})



--##########################################--



--get_dir_list()
--lua test
minetest.register_chatcommand("lua_util_get_dir_list",
{
	description = "Test util class method get_dir_list() (lua version)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\testFolder";
		minetest.mkdir(path);
		
		local t1 = pcall(minetest.get_dir_list, minetest.get_worldpath(), nil);
		local t2 = pcall(minetest.get_dir_list, minetest.get_worldpath(), true);
		local t3 = pcall(minetest.get_dir_list, minetest.get_worldpath(), false);
		
		
		
		if(t1 and t2 and t3) then
			return true, "Success, lua_get_dir_list() executed"
		else
			return false, "Failure, lua_get_dir_list() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_dir_list",
{
	description = "Test util class method get_dir_list() (native version)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\testFolder";
		minetest.mkdir(path);
		
		local t1 = pcall(minetest.native_get_dir_list, minetest.get_worldpath(), nil);
		local t2 = pcall(minetest.native_get_dir_list, minetest.get_worldpath(), true);
		local t3 = pcall(minetest.native_get_dir_list, minetest.get_worldpath(), false);
		
		
		
		if(t1 and t2 and t3) then
			return true, "Success, native_get_dir_list() executed"
		else
			return false, "Failure, native_get_dir_list() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_dir_list",
{
	description = "Test util class method get_dir_list() (lua and native comparison)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\testFolder";
		minetest.mkdir(path);
		
		-- testing get_dir_list(path, nil)
		local res = true;
		local l_t = minetest.get_dir_list(minetest.get_worldpath(), nil);
		local n_t = minetest.native_get_dir_list(minetest.get_worldpath(), nil);
		local l_size = 0;
		local n_size = 0;
		for k, v in pairs(l_t) do
			l_size = l_size + 1;
		end
		for k, v in pairs(n_t) do
			n_size = n_size + 1;
		end
		
		if(l_size == n_size) then
			for i = 1, l_size do
				if(l_t[i] ~= n_t[i]) then
					res = false;
					break;
				end
			end
		else
			res = false;
		end
		
		-- testing get_dir_list(path, true)
		l_t = minetest.get_dir_list(minetest.get_worldpath(), true);
		n_t = minetest.native_get_dir_list(minetest.get_worldpath(), true);
		l_size = 0;
		n_size = 0;
		for k, v in pairs(l_t) do
			l_size = l_size + 1;
		end
		for k, v in pairs(n_t) do
			n_size = n_size + 1;
		end
		
		if(l_size == n_size) then
			for i = 1, l_size do
				if(l_t[i] ~= n_t[i]) then
					res = false;
					break;
				end
			end
		else
			res = false;
		end
		
		-- testing get_dir_list(path, false)
		l_t = minetest.get_dir_list(minetest.get_worldpath(), false);
		n_t = minetest.native_get_dir_list(minetest.get_worldpath(), false);
		l_size = 0;
		n_size = 0;
		for k, v in pairs(l_t) do
			l_size = l_size + 1;
		end
		for k, v in pairs(n_t) do
			n_size = n_size + 1;
		end
		
		if(l_size == n_size) then
			for i = 1, l_size do
				if(l_t[i] ~= n_t[i]) then
					res = false;
					break;
				end
			end
		else
			res = false;
		end
		
		
		
		if(res) then
			return true, "Success, both lua_get_dir_list() and native_get_dir_list() executed"
		else
			return false, "Failure, either lua_get_dir_list() or native_get_dir_list() did not execute"
		end
	end
})



--##########################################--



--safe_file_write()
--lua test
minetest.register_chatcommand("lua_util_safe_file_write",
{
	description = "Test util class method safe_file_write() (lua version)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\testFileWrite.txt";
		local res = minetest.safe_file_write(path, "Test File Write (Lua)");
		
		if(res) then
			return true, "Success, lua_safe_file_write() executed"
		else
			return false, "Failure, lua_safe_file_write() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_safe_file_write",
{
	description = "Test util class method safe_file_write() (native version)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\testFileWrite.txt";
		local res = minetest.native_safe_file_write(path, "Test File Write (Native)");
		
		if(res) then
			return true, "Success, native_safe_file_write() executed"
		else
			return false, "Failure, native_safe_file_write() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_safe_file_write",
{
	description = "Test util class method safe_file_write() (lua and native comparison)",
	func = function(self)
		
		local path = minetest.get_worldpath() .. "\\testFileWrite.txt";
		local l_res = minetest.safe_file_write(path, "Test File Write (Lua)");
		local n_res = minetest.native_safe_file_write(path, "Test File Write (Native)");
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_safe_file_write() and native_safe_file_write() executed"
		else
			return false, "Failure, either lua_safe_file_write() or native_safe_file_write() did not execute"
		end
	end
})



--##########################################--



--request_insecure_environment()
--lua test
minetest.register_chatcommand("lua_util_request_insecure_environment",
{
	description = "Test util class method request_insecure_environment() (lua version)",
	func = function(self)
		
		if(pcall(minetest.request_insecure_environment)) then
			return true, "Success, lua_request_insecure_environment() executed"
		else
			return false, "Failure, lua_request_insecure_environment() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_request_insecure_environment",
{
	description = "Test util class method request_insecure_environment() (native version)",
	func = function(self)
		
		if(pcall(minetest.native_request_insecure_environment)) then
			return true, "Success, native_request_insecure_environment() executed"
		else
			return false, "Failure, native_request_insecure_environment() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_request_insecure_environment",
{
	description = "Test util class method request_insecure_environment() (lua and native comparison)",
	func = function(self)
		
		if(pcall(minetest.request_insecure_environment) and pcall(minetest.native_request_insecure_environment)) then
			return true, "Success, both lua_request_insecure_environment() and native_request_insecure_environment() executed"
		else
			return false, "Failure, either lua_request_insecure_environment() or native_request_insecure_environment() did not execute"
		end
	end
})



--##########################################--



--encode_base64()
--lua test
minetest.register_chatcommand("lua_util_encode_base64",
{
	description = "Test util class method encode_base64() (lua version)",
	func = function(self)
		
		local t = minetest.encode_base64("Test Encode (Lua)");
		
		local res = false;
		if(minetest.decode_base64(t) == "Test Encode (Lua)") then
			res = true;
		end
		
		if(res) then
			return true, "Success, lua_encode_base64() executed"
		else
			return false, "Failure, lua_encode_base64() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_encode_base64",
{
	description = "Test util class method encode_base64() (native version)",
	func = function(self)
		
		local t = minetest.native_encode_base64("Test Encode (Native)");
		
		local res = false;
		if(minetest.decode_base64(t) == "Test Encode (Native)") then
			res = true;
		end
		
		if(res) then
			return true, "Success, native_encode_base64() executed"
		else
			return false, "Failure, native_encode_base64() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_encode_base64",
{
	description = "Test util class method encode_base64() (lua and native comparison)",
	func = function(self)
		
		local l_t = minetest.encode_base64("Test Encode (Lua)");
		local n_t = minetest.native_encode_base64("Test Encode (Native)");
		
		local l_res = false;
		if(minetest.decode_base64(l_t) == "Test Encode (Lua)") then
			l_res = true;
		end
		
		local n_res = false;
		if(minetest.decode_base64(n_t) == "Test Encode (Native)") then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_encode_base64() and native_encode_base64() executed"
		else
			return false, "Failure, either lua_encode_base64() or native_encode_base64() did not execute"
		end
	end
})



--##########################################--



--decode_base64()
--lua test
minetest.register_chatcommand("lua_util_decode_base64",
{
	description = "Test util class method decode_base64() (lua version)",
	func = function(self)
		
		local t = minetest.encode_base64("Test Decode (Lua)");
		
		local res = false;
		if(minetest.decode_base64(t) == "Test Decode (Lua)") then
			res = true;
		end
		
		if(res) then
			return true, "Success, lua_decode_base64() executed"
		else
			return false, "Failure, lua_decode_base64() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_decode_base64",
{
	description = "Test util class method decode_base64() (native version)",
	func = function(self)
		
		local t = minetest.encode_base64("Test Decode (Native)");
		
		local res = false;
		if(minetest.native_decode_base64(t) == "Test Decode (Native)") then
			res = true;
		end
		
		if(res) then
			return true, "Success, native_decode_base64() executed"
		else
			return false, "Failure, native_decode_base64() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_decode_base64",
{
	description = "Test util class method decode_base64() (lua and native comparison)",
	func = function(self)
		
		local l_t = minetest.encode_base64("Test Decode (Lua)");
		local n_t = minetest.encode_base64("Test Decode (Native)");
		
		local l_res = false;
		if(minetest.decode_base64(l_t) == "Test Decode (Lua)") then
			l_res = true;
		end
		
		local n_res = false;
		if(minetest.native_decode_base64(n_t) == "Test Decode (Native)") then
			n_res = true;
		end
		
		if(l_res == true and n_res == true) then
			return true, "Success, both lua_decode_base64() and native_decode_base64() executed"
		else
			return false, "Failure, either lua_decode_base64() or native_decode_base64() did not execute"
		end
	end
})



--##########################################--



--get_version()
--lua test
minetest.register_chatcommand("lua_util_get_version",
{
	description = "Test util class method get_version() (lua version)",
	func = function(self)
		
		if(pcall(minetest.get_version)) then
			return true, "Success, lua_get_version() executed"
		else
			return false, "Failure, lua_get_version() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_get_version",
{
	description = "Test util class method get_version() (native version)",
	func = function(self)
		
		if(pcall(minetest.native_get_version)) then
			return true, "Success, native_get_version() executed"
		else
			return false, "Failure, native_get_version() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_get_version",
{
	description = "Test util class method get_version() (lua and native comparison)",
	func = function(self)
		
		local res = true;
		local l_t = minetest.get_version();
		local n_t = minetest.native_get_version();
		local l_size = 0;
		local n_size = 0;
		for k, v in pairs(l_t) do
			l_size = l_size + 1;
		end
		for k, v in pairs(n_t) do
			n_size = n_size + 1;
		end
		
		if(l_size == n_size) then
			for i = 1, l_size do
				if(l_t[i] ~= n_t[i]) then
					res = false;
					break;
				end
			end
		else
			res = false;
		end
		
		
		
		if(res) then
			return true, "Success, both lua_get_version() and native_get_version() executed"
		else
			return false, "Failure, either lua_get_version() or native_get_version() did not execute"
		end
	end
})



--##########################################--



--sha1()
--lua test
minetest.register_chatcommand("lua_util_sha1",
{
	description = "Test util class method sha1() (lua version)",
	func = function(self)
		
		if(pcall(minetest.sha1, "SomeData") and pcall(minetest.sha1, "OtherData", true)) then
			return true, "Success, lua_sha1() executed"
		else
			return false, "Failure, lua_sha1() did not execute"
		end
	end
})

--native test
minetest.register_chatcommand("native_util_sha1",
{
	description = "Test util class method sha1() (native version)",
	func = function(self)
		
		if(pcall(minetest.native_sha1, "SomeData") and pcall(minetest.native_sha1, "OtherData", true)) then
			return true, "Success, native_sha1() executed"
		else
			return false, "Failure, native_sha1() did not execute"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_util_sha1",
{
	description = "Test util class method sha1() (lua and native comparison)",
	func = function(self)
		
		local res = true;
		local l_t = minetest.sha1("SomeData");
		local n_t = minetest.native_sha1("SomeData");
		local l_t2 = minetest.sha1("OtherData", true);
		local n_t2 = minetest.native_sha1("OtherData", true);
		
		if((l_t ~= n_t) or (l_t2 ~= n_t2)) then
			res = false;
		end
		
		
		
		if(res) then
			return true, "Success, both lua_sha1() and native_sha1() executed"
		else
			return false, "Failure, either lua_sha1() or native_sha1() did not execute"
		end
	end
})



--##########################################--



minetest.register_chatcommand("test_util",
{
	description = "testing all util methods",
	func = function()

		local methods =
		{
			"log",
			"get_us_time",
			"parse_json",
			"write_json",
			"get_dig_params",
			"get_hit_params",
			"check_password_entry",
			"get_password_hash",
			"is_yes",
			"get_builtin_path",
			"get_user_path",
			"compress",
			"decompress",
			"mkdir",
			"get_dir_list",
			"safe_file_write",
			"request_insecure_environment",
			"encode_base64",
			"decode_base64",
			"get_version",
			"sha1"
		}

		return native_tests.test_class("util", methods), 
		"Util tests completed. See server_dump.txt for details."
	end
})
