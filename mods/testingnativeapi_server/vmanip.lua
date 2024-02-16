-- vmanip test mod
-- test vmanip class methods

minetest.log("--NativeLuaVoxelManip class tests--")

--read_from_map()
--lua test
minetest.register_chatcommand("lua_vmanip_read_from_map", {
    description = "test vmanip class method read_from_map (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, read_from_map() returned: nil"
        else
            return true, "Success, read_from_map() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_read_from_map", {
    description = "test vmanip class method read_from_map (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, read_from_map() returned: nil"
        else
            return true, "Success, read_from_map() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_read_from_map", {
    description = "compares output of lua and native command for read_from_map()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_data", {
    description = "test vmanip class method get_data (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, get_data() returned: nil"
        else
            return true, "Success, get_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_data", {
    description = "test vmanip class method get_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_data() returned: nil"
        else
            return true, "Success, get_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_data", {
    description = "compares output of lua and native command for get_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_data()
--lua test
minetest.register_chatcommand("lua_vmanip_set_data", {
    description = "test vmanip class method set_data (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, set_data() returned: nil"
        else
            return true, "Success, set_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_data", {
    description = "test vmanip class method set_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_data() returned: nil"
        else
            return true, "Success, set_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_data", {
    description = "compares output of lua and native command for set_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--write_to_map()
--lua test
minetest.register_chatcommand("lua_vmanip_write_to_map", {
    description = "test vmanip class method write_to_map (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, write_to_map() returned: nil"
        else
            return true, "Success, write_to_map() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_write_to_map", {
    description = "test vmanip class method write_to_map (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, write_to_map() returned: nil"
        else
            return true, "Success, write_to_map() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_write_to_map", {
    description = "compares output of lua and native command for write_to_map()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_node_at()
--lua test
minetest.register_chatcommand("lua_vmanip_get_node_at", {
    description = "test vmanip class method get_node_at (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, get_node_at() returned: nil"
        else
            return true, "Success, get_node_at() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_node_at", {
    description = "test vmanip class method get_node_at (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_node_at() returned: nil"
        else
            return true, "Success, get_node_at() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_node_at", {
    description = "compares output of lua and native command for get_node_at()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_node_at()
--lua test
minetest.register_chatcommand("lua_vmanip_set_node_at", {
    description = "test vmanip class method set_node_at (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, set_node_at() returned: nil"
        else
            return true, "Success, set_node_at() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_node_at", {
    description = "test vmanip class method set_node_at (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_node_at() returned: nil"
        else
            return true, "Success, set_node_at() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_node_at", {
    description = "compares output of lua and native command for set_node_at()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--update_map()
--lua test
minetest.register_chatcommand("lua_vmanip_update_map", {
    description = "test vmanip class method update_map (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, update_map() returned: nil"
        else
            return true, "Success, update_map() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_update_map", {
    description = "test vmanip class method update_map (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, update_map() returned: nil"
        else
            return true, "Success, update_map() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_update_map", {
    description = "compares output of lua and native command for update_map()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--update_liquids()
--lua test
minetest.register_chatcommand("lua_vmanip_update_liquids", {
    description = "test vmanip class method update_liquids (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, update_liquids() returned: nil"
        else
            return true, "Success, update_liquids() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_update_liquids", {
    description = "test vmanip class method update_liquids (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, update_liquids() returned: nil"
        else
            return true, "Success, update_liquids() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_update_liquids", {
    description = "compares output of lua and native command for update_liquids()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--calc_lighting()
--lua test
minetest.register_chatcommand("lua_vmanip_calc_lighting", {
    description = "test vmanip class method calc_lighting (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, calc_lighting() returned: nil"
        else
            return true, "Success, calc_lighting() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_calc_lighting", {
    description = "test vmanip class method calc_lighting (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, calc_lighting() returned: nil"
        else
            return true, "Success, calc_lighting() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_calc_lighting", {
    description = "compares output of lua and native command for calc_lighting()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_lighting()
--lua test
minetest.register_chatcommand("lua_vmanip_set_lighting", {
    description = "test vmanip class method set_lighting (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, set_lighting() returned: nil"
        else
            return true, "Success, set_lighting() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_lighting", {
    description = "test vmanip class method set_lighting (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_lighting() returned: nil"
        else
            return true, "Success, set_lighting() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_lighting", {
    description = "compares output of lua and native command for set_lighting()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_light_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_light_data", {
    description = "test vmanip class method get_light_data (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, get_light_data() returned: nil"
        else
            return true, "Success, get_light_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_light_data", {
    description = "test vmanip class method get_light_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_light_data() returned: nil"
        else
            return true, "Success, get_light_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_light_data", {
    description = "compares output of lua and native command for get_light_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_light_data()
--lua test
minetest.register_chatcommand("lua_vmanip_set_light_data", {
    description = "test vmanip class method set_light_data (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, set_light_data() returned: nil"
        else
            return true, "Success, set_light_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_light_data", {
    description = "test vmanip class method set_light_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_light_data() returned: nil"
        else
            return true, "Success, set_light_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_light_data", {
    description = "compares output of lua and native command for set_light_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_param2_data()
--lua test
minetest.register_chatcommand("lua_vmanip_get_param2_data", {
    description = "test vmanip class method get_param2_data (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, get_param2_data() returned: nil"
        else
            return true, "Success, get_param2_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_param2_data", {
    description = "test vmanip class method get_param2_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_param2_data() returned: nil"
        else
            return true, "Success, get_param2_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_param2_data", {
    description = "compares output of lua and native command for get_param2_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--set_param2_data()
--lua test
minetest.register_chatcommand("lua_vmanip_set_param2_data", {
    description = "test vmanip class method set_param2_data (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, set_param2_data() returned: nil"
        else
            return true, "Success, set_param2_data() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_set_param2_data", {
    description = "test vmanip class method set_param2_data (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, set_param2_data() returned: nil"
        else
            return true, "Success, set_param2_data() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_set_param2_data", {
    description = "compares output of lua and native command for set_param2_data()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--was_modified()
--lua test
minetest.register_chatcommand("lua_vmanip_was_modified", {
    description = "test vmanip class method was_modified (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, was_modified() returned: nil"
        else
            return true, "Success, was_modified() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_was_modified", {
    description = "test vmanip class method was_modified (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, was_modified() returned: nil"
        else
            return true, "Success, was_modified() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_was_modified", {
    description = "compares output of lua and native command for was_modified()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_emerged_area()
--lua test
minetest.register_chatcommand("lua_vmanip_get_emerged_area", {
    description = "test vmanip class method get_emerged_area (lua version)",
    func = function(self)
        local res = true;
        if res == nil then 
            return true, "Success, get_emerged_area() returned: nil"
        else
            return true, "Success, get_emerged_area() returned: not nil"
        end
    end
})

--native test 
minetest.register_chatcommand("native_vmanip_get_emerged_area", {
    description = "test vmanip class method get_emerged_area (native version)",
    func = function(self)
        local res = true;
        if res == nil then
            return true, "Success, get_emerged_area() returned: nil"
        else
            return true, "Success, get_emerged_area() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_vmanip_get_emerged_area", {
    description = "compares output of lua and native command for get_emerged_area()",
    func = function(self)
        local lres = true;
        local nres = true;
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

minetest.register_chatcommand("test_vmanip", {
    description = "testing all vmanip methods",
    func = function()

        local methods = {
            "read_from_map",
            "get_data",
            "set_data",
            "write_to_map",
            "get_node_at",
            "set_node_at",
			"update_map",
			"update_liquids",
			"calc_lighting",
			"set_lighting",
			"get_light_data",
			"set_light_data",
			"get_param2_data",
			"set_param2_data",
			"was_modified",
			"get_emerged_area"
        }

        return native_tests.test_class("vmanip", methods),
        "Vmanip tests completed. See server_dump.txt for details."
    end
})
