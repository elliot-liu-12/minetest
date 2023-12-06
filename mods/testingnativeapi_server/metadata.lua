--Metadata class test mod.

minetest.log("--Metadata class tests--")

--contains()
--lua test
minetest.register_chatcommand("lua_metadata_contains", {
	description = "Test metadata class method contains() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local res1 = meta:contains("description");
		local itemstack2 = ItemStack("default:pick_IDONTEXIST");
        local meta2 = itemstack2:get_meta();
		local res2 = meta2:contains("description");
		local res = (res1 and not res2);
		if res then
			return true, "Success, contains() returned: true"
		else
			return true, "Success, contains() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_contains", {
	description = "Test metadata class method contains() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local res1 = meta:native_contains("description");
		local itemstack2 = ItemStack("default:pick_IDONTEXIST");
        local meta2 = itemstack2:get_meta();
		local res2 = meta2:native_contains("description");
		local res = (res1 and not res2);
		if res then
			return true, "Success, native_contains() returned: true"
		else
			return true, "Success, native_contains() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_contains", {
	description = "Compares output of lua and native command for metadata class method contains().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();	
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local lres = meta:contains("description");
		--native
        local itemstack2 = ItemStack("default:pick_mese");
        local meta2 = itemstack2:get_meta();
		meta2:set_string("description", "Custom description!");
		inv:set_stack("main", 2, itemstack2);
		local nres = meta2:native_contains("description");
		if lres == nres then
			return true, "Success, contains() function output matches - check console for more details"
		else
			return false, "Failure, contains() function output does not match - check console for more details"
		end
	end
})

--get()
--lua test
minetest.register_chatcommand("lua_metadata_get", {
	description = "Test metadata class method get() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get("description");
		minetest.log(desc);
		local res = (desc == "Custom description!");
		if res then
			return true, "Success, get() returned: true"
		else
			return true, "Success, get() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_get", {
	description = "Test metadata class method get() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:native_get("description");
		minetest.log(desc);
		local res = (desc == "Custom description!");
		if res then
			return true, "Success, native_get() returned: true"
		else
			return true, "Success, native_get() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_get", {
	description = "Compares output of lua and native command for metadata class method get().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get("description");
		minetest.log("Lua: ");
		minetest.log(desc);
		local lres = (desc == "Custom description!");
		--native
        local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:set_string("description", "Custom description!");
		inv:set_stack("main", 2, itemstack2);
		local desc2 = meta2:get("description");
		minetest.log("Native: ");
		minetest.log(desc2);
		local nres = (desc2 == "Custom description!");
		if lres == nres then
			return true, "Success, get() function output matches - check console for more details"
		else
			return false, "Failure, get() function output does not match - check console for more details"
		end
	end
})

--get_string()
--lua test
minetest.register_chatcommand("lua_metadata_get_string", {
	description = "Test metadata class method get_string() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get_string("description");
		minetest.log(desc);
		local res = (desc == "Custom description!");
		if res then
			return true, "Success, get_string() returned: true"
		else
			return true, "Success, get_string() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_get_string", {
	description = "Test metadata class method get_string() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:native_get_string("description");
		minetest.log(desc);
		local res = (desc == "Custom description!");
		if res then
			return true, "Success, native_get_string() returned: true"
		else
			return true, "Success, native_get_string() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_get_string", {
	description = "Compares output of lua and native command for metadata class method get_string().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get_string("description");
		minetest.log(desc);
		local lres = (desc == "Custom description!");
		--native
		local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:set_string("description", "Custom description!");
		inv:set_stack("main", 2, itemstack2);
		local desc2 = meta2:native_get_string("description");
		minetest.log(desc2);
		local nres = (desc2 == "Custom description!");
		if lres == nres then
			return true, "Success, get_string() function output matches - check console for more details"
		else
			return false, "Failure, get_string() function output does not match - check console for more details"
		end
	end
})

--set_string()
--lua test
minetest.register_chatcommand("lua_metadata_set_string", {
	description = "Test metadata class method set_string() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get("description");
		minetest.log(desc);
		local res = (desc == "Custom description!");
		if res then
			return true, "Success, set_string() returned: true"
		else
			return true, "Success, set_string() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_set_string", {
	description = "Test metadata class method set_string() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:native_set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get("description");
		minetest.log(desc);
		local res = (desc == "Custom description!");
		if res then
			return true, "Success, native_set_string() returned: true"
		else
			return true, "Success, native_set_string() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_set_string", {
	description = "Compares output of lua and native command for metadata class method set_string().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_string("description", "Custom description!");
		inv:set_stack("main", 1, itemstack);
		local desc = meta:get("description");
		minetest.log(desc);
		local lres = (desc == "Custom description!");
		--native
		local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:native_set_string("description", "Custom description!");
		inv:set_stack("main", 2, itemstack2);
		local desc2 = meta2:get("description");
		minetest.log(desc2);
		local nres = (desc2 == "Custom description!");
		if lres == nres then
			return true, "Success, set_string() function output matches - check console for more details"
		else
			return false, "Failure, set_string() function output does not match - check console for more details"
		end
	end
})

--get_int()
--lua test
minetest.register_chatcommand("lua_metadata_get_int", {
	description = "Test metadata class method get_int() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_int("hp", 100);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_int("hp");
		minetest.log(hp);
		local res = (hp == 100);
		if res then
			return true, "Success, get_int() returned: true"
		else
			return true, "Success, get_int() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_get_int", {
	description = "Test metadata class method get_int() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_int("hp", 100);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:native_get_int("hp");
		minetest.log(hp);
		local res = (hp == 100);
		if res then
			return true, "Success, native_get_int() returned: true"
		else
			return true, "Success, native_get_int() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_get_int", {
	description = "Compares output of lua and native command for metadata class method get_int().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_int("hp", 100);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_int("hp");
		minetest.log(hp);
		local lres = (hp == 100);
		--Native
		local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:set_int("hp", 100);
		inv:set_stack("main", 2, itemstack2);
		local hp2 = meta2:native_get_int("hp");
		minetest.log(hp2);
		local nres = (hp2 == 100);
		if lres == nres then
			return true, "Success, get_int() function output matches - check console for more details"
		else
			return false, "Failure, get_int() function output does not match - check console for more details"
		end
	end
})

--set_int()
--lua test
minetest.register_chatcommand("lua_metadata_set_int", {
	description = "Test metadata class method set_int() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_int("durability", 100);
		inv:set_stack("main", 1, itemstack);
		local durability = meta:get_int("durability");
		minetest.log(durability);
		local res = (durability == 100);
		if res then
			return true, "Success, set_int() returned: true"
		else
			return true, "Success, set_int() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_set_int", {
	description = "Test metadata class method set_int() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:native_set_int("durability", 100);
		inv:set_stack("main", 1, itemstack);
		local durability = meta:get_int("durability");
		minetest.log(durability);
		local res = (durability == 100);
		if res then
			return true, "Success, native_set_int() returned: true"
		else
			return true, "Success, native_set_int() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_set_int", {
	description = "Compares output of lua and native command for metadata class method set_int().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_int("durability", 100);
		inv:set_stack("main", 1, itemstack);
		local durability = meta:get_int("durability");
		minetest.log(durability);
		local lres = (durability == 100);
		--Native
		local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:native_set_int("durability", 100);
		inv:set_stack("main", 2, itemstack2);
		local durability2 = meta2:get_int("durability");
		minetest.log(durability2);
		local nres = (durability2 == 100);
		if lres == nres then
			return true, "Success, set_int() function output matches - check console for more details"
		else
			return false, "Failure, set_int() function output does not match - check console for more details"
		end
	end
})

--get_float()
--lua test
minetest.register_chatcommand("lua_metadata_get_float", {
	description = "Test metadata class method get_float() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_float("hp", 100.1);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_float("hp");
		local mult = 10^(1);
		hp = math.floor(hp * mult + 0.5) / mult;
		minetest.log(hp);
		local res = (hp == 100.1);
		if res then
			return true, "Success, get_float() returned: true"
		else
			return true, "Success, get_float() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_get_float", {
	description = "Test metadata class method get_float() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_float("hp", 100.1);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:native_get_float("hp");
		local mult = 10^(1);
		hp = math.floor(hp * mult + 0.5) / mult;
		minetest.log(hp);
		local res = (hp == 100.1);
		if res then
			return true, "Success, native_get_float() returned: true"
		else
			return true, "Success, native_get_float() returned: false"
		end
	end
})

--comparison
minetest.register_chatcommand("test_metadata_get_float", {
	description = "Compares output of lua and native command for metadata class method get_float().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_float("hp", 100.1);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_float("hp");
		local mult = 10^(1);
		hp = math.floor(hp * mult + 0.5) / mult;
		minetest.log(hp);
		local lres = (hp == 100.1);
		--native
		local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:set_float("hp", 100.1);
		inv:set_stack("main", 2, itemstack2);
		local hp2 = meta2:native_get_float("hp");
		local mult2 = 10^(1);
		hp2 = math.floor(hp2 * mult2 + 0.5) / mult2;
		minetest.log(hp2);
		local nres = (hp2 == 100.1);
		if lres == nres then
			return true, "Success, get_float() function output matches - check console for more details";
		else
			return false, "Failure, get_float() function output does not match - check console for more details";
		end
	end
})

--set_float()
--lua test
minetest.register_chatcommand("lua_metadata_set_float", {
	description = "Test metadata class method set_float() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_float("hp", 100.1);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_float("hp");
		local mult = 10^(1);
		hp = math.floor(hp * mult + 0.5) / mult;
		minetest.log(hp);
		local res = (hp == 100.1);
		if res then
			return true, "Success, set_float() returned: true"
		else
			return true, "Success, set_float() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_set_float", {
	description = "Test metadata class method set_float() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:native_set_float("hp", 100.1);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_float("hp");
		local mult = 10^(1);
		hp = math.floor(hp * mult + 0.5) / mult;
		minetest.log(hp);
		local res = (hp == 100.1);
		if res then
			return true, "Success, native_set_float() returned: true"
		else
			return true, "Success, native_set_float() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_set_float", {
	description = "Compares output of lua and native command for metadata class method set_float().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
        local itemstack = ItemStack("default:pick_steel");
        local meta = itemstack:get_meta();
		meta:set_float("hp", 100.1);
		inv:set_stack("main", 1, itemstack);
		local hp = meta:get_float("hp");
		local mult = 10^(1);
		hp = math.floor(hp * mult + 0.5) / mult;
		minetest.log(hp);
		local lres = (hp == 100.1);
		--Native
		local itemstack2 = ItemStack("default:pick_steel");
        local meta2 = itemstack2:get_meta();
		meta2:native_set_float("hp", 100.2);
		inv:set_stack("main", 2, itemstack2);
		local hp2 = meta2:get_float("hp");
		local mult2 = 10^(1);
		hp2 = math.floor(hp2 * mult2 + 0.5) / mult2;
		minetest.log(hp2);
		local nres = (hp2 == 100.2);
		if lres == nres then
			return true, "Success, set_float() function output matches - check console for more details"
		else
			return false, "Failure, set_float() function output does not match - check console for more details"
		end
	end
})

--to_table()
--lua test
minetest.register_chatcommand("lua_metadata_to_table", {
	description = "Test metadata class method to_table() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		meta:set_int("durability", 100);
		inv:set_stack("main", 1, itemstack);
		local table = "{\n\tfields = {\n\t\tdurability = \"100\"\n\t}\n}";
		local tabletext = dump(meta:to_table());
		local res = tabletext == table;
		--You can manually check table contents in console.
		print(dump(meta:native_to_table()));
		print(table);
		if res then
			return true, "Success, to_table() returned: true"
		else
			return true, "Success, to_table() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_to_table", {
	description = "Test metadata class method to_table() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		meta:set_int("durability", 100);
		inv:set_stack("main", 1, itemstack);
		local table = "{\n\tfields = {\n\t\tdurability = \"100\"\n\t}\n}";
		local tabletext = dump(meta:native_to_table());
		local res = tabletext == table;
		--You can manually check table contents in console.
		print(dump(meta:native_to_table()));
		print(table);
		if res then
			return true, "Success, to_table() returned: true"
		else
			return true, "Success, to_table() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_to_table", {
	description = "Compares output of lua and native command for metadata class method to_table().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local table = "{\n\tfields = {\n\t\tdurability = \"100\"\n\t}\n}";
		--lua
        local itemstack = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		meta:set_int("durability", 100);
		inv:set_stack("main", 1, itemstack);
		local tabletext = dump(meta:to_table());
		local lres = tabletext == table;
		--Native
		local itemstack2 = ItemStack("default:pick_steel");
		local meta2 = itemstack2:get_meta();
		meta2:set_int("durability", 100);
		inv:set_stack("main", 2, itemstack2);
		local tabletext2 = dump(meta2:native_to_table());
		local nres = tabletext2 == table;
		--You can manually check table contents in console.
		print(table);
		print(dump(meta2:native_to_table()));
		print(dump(meta:to_table()));
		if lres == nres then
			return true, "Success, to_table() function output matches - check console for more details"
		else
			return false, "Failure, to_table() function output does not match - check console for more details"
		end
	end
})

--from_table()
--lua test
minetest.register_chatcommand("lua_metadata_from_table", {
	description = "Test metadata class method from_table() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		local tableAsString = "{\n\tfields = {\n\t\tdurability = \"100\"\n\t}\n}";
		local table = {
			fields = {
				durability = 100
			}
		};
		meta:from_table(table); --sets metadata using from_table instead of setter methods
		local tabletext = dump(meta:to_table()); --gets table as text
		local res = tabletext == tableAsString;
		--You can manually compare table contents in console.
		print(tableAsString);
		print(dump(meta:to_table()));
		if res then
			return true, "Success, from_table() returned: true"
		else
			return true, "Success, from_table() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_from_table", {
	description = "Test metadata class method from_table() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		local tableAsString = "{\n\tfields = {\n\t\tdurability = \"100\"\n\t}\n}";
		local table = {
			fields = {
				durability = 100
			}
		};
		meta:native_from_table(table); --sets metadata using from_table instead of setter methods
		local tabletext = dump(meta:to_table()); --gets table as text
		local res = tabletext == tableAsString;
		--You can manually compare table contents in console.
		print(tableAsString);
		print(dump(meta:to_table()));
		if res then
			return true, "Success, native_from_table() returned: true"
		else
			return true, "Success, native_from_table() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_from_table", {
	description = "Compares output of lua and native command for metadata class method from_table().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local tableAsString = "{\n\tfields = {\n\t\tdurability = \"100\"\n\t}\n}";
		local table = {
			fields = {
				durability = 100
			}
		};
		--lua
        local itemstack = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		meta:from_table(table); --sets metadata using from_table instead of setter methods
		local tabletext = dump(meta:to_table()); --gets table as text
		local lres = tabletext == tableAsString;
		--Native
		local itemstack2 = ItemStack("default:pick_steel");
		local meta2 = itemstack2:get_meta();
		meta2:from_table(table); --sets metadata using from_table instead of setter methods
		local tabletext2 = dump(meta2:to_table()); --gets table as text
		local nres = tabletext2 == tableAsString;
		--You can manually compare table contents in console.
		print(tableAsString);
		print(dump(meta:to_table()));
		print(dump(meta2:to_table()));
		if lres == nres then
			return true, "Success, from_table() function output matches - check console for more details"
		else
			return false, "Failure, from_table() function output does not match - check console for more details"
		end
	end
})

--equals()
--lua test
minetest.register_chatcommand("lua_metadata_equals", {
	description = "Test metadata class method equals() (lua version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
		local itemstack2 = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		local res = meta:equals(itemstack2:get_meta());
		if res then
			return true, "Success, equals() returned: true"
		else
			return true, "Success, equals() returned: false"
		end
	end
})

--native test
minetest.register_chatcommand("native_metadata_equals", {
	description = "Test metadata class method equals() (native version).",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		local itemstack = ItemStack("default:pick_steel");
		local itemstack2 = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		local res = meta:native_equals(itemstack2:get_meta());
		if res then
			return true, "Success, native_equals() returned: true"
		else
			return true, "Success, native_equals() returned: false"
		end
	end
})

--comparison test
minetest.register_chatcommand("test_metadata_equals", {
	description = "Compares output of lua and native command for metadata class method equals().",
	func = function(self)
		local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
		--lua
		local itemstack = ItemStack("default:pick_steel");
		local itemstack2 = ItemStack("default:pick_steel");
		local meta = itemstack:get_meta();
		local lres = meta:equals(itemstack2:get_meta());
		--Native
		local itemstack3 = ItemStack("default:pick_steel");
		local itemstack4 = ItemStack("default:pick_steel");
		local meta = itemstack3:get_meta();
		local nres = meta:native_equals(itemstack4:get_meta());
		if lres == nres then
			return true, "Success, equals() function output matches - check console for more details"
		else
			return false, "Failure, equals() function output does not match - check console for more details"
		end
	end
})

minetest.register_chatcommand("test_metadata", {
	description = "testing all inventory methods",
	func = function()

		local methods = {
			"contains",
			"get",
			"get_string",
			"set_string",
			"get_int",
			"set_int",
			"get_float",
			"set_float",
			"to_table",
			"from_table",
			"equals"
		}

		return native_tests.test_class("metadata", methods), 
		"Metadata tests completed. See server_dump.txt for details."
	end
})
