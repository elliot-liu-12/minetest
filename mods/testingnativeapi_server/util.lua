--Util class test mod

minetest.log("--Util class tests--")

--log()
--lua test
minetest.register_chatcommand("lua_nodemeta_get_inventory",
{
	description = "Test nodemeta class method get_inventory() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
		
		local itemstack = ItemStack("default:dirt");
		local inv = player:get_inventory();
		inv:set_stack("main", 1, itemstack);
		
		local res = inv:contains_item("main", itemstack);
		if(res == true) then
			return true, "Success, get_inventory() returns the right InvRef"
		else
			return false, "Failure, get_inventory() returns the right InvRef"
		end
	end
})

--native test
minetest.register_chatcommand("native_nodemeta_get_inventory",
{
	description = "Test nodemeta class method get_inventory() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
		
		local itemstack = ItemStack("default:dirt");
		local inv = player:native_get_inventory();
		inv:set_stack("main", 1, itemstack);
		
		local res = inv:contains_item("main", itemstack);
		if(res == true) then
			return true, "Success, native_get_inventory() returns the right InvRef"
		else
			return false, "Failure, native_get_inventory() returns the right InvRef"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_nodemeta_get_inventory",
{
	description = "Compares outputs of lua and native versions of nodemeta class's method, get_inventory()",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
		local l_inv = player:get_inventory();
		local n_inv = player:native_get_inventory();
		local itemstack = ItemStack("default:dirt");
		
		l_inv:set_stack("main", 1, itemstack);
		n_inv:set_stack("main", 1, itemstack);
		local l_res = l_inv:contains_item("main", itemstack);
		local n_res = n_inv:contains_item("main", itemstack);
		
		if(l_res == n_res) then
			return true, "Success, get_inventory() and native_get_inventory() return the same InvRef"
		else
			return false, "Failure, get_inventory() and native_get_inventory() return different InvRef"
		end
	end
})

--get_us_time()
--comparison test
minetest.register_chatcommand("test_nodemeta_get_inventory",
{
	description = "Compares outputs of lua and native versions of util class's method, get_us_time()",
	func = function(self)
		local l_time = minetest.get_us_time();
		local n_time = minetest.native_get_us_time();
		
		local res = math.abs(l_time - n_time);
		
		if(res < 0.000001) then
			return true, "Success, the difference between get_us_time() and native_get_us_time() is on the microsecond level."
		else
			return false, "Failure, the difference between get_us_time() and native_get_us_time() is not on the microsecond level."
		end
	end
})




minetest.register_chatcommand("test_util",
{
	description = "testing all util methods",
	func = function()

		local methods =
		{
			"log",
			"get_us_time"
		}

		return native_tests.test_class("util", methods), 
		"Util tests completed. See server_dump.txt for details."
	end
})
