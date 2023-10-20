-- itemstackmeta test mod
-- test itemstackmeta class methods

minetest.log("--itemstackmeta class tests--")

--set_tool_capabilities()
--lua test
minetest.register_chatcommand("lua_itemstackmeta_set_tool_capabilities", {
    description = "test itemstackmeta class method set_tool_capabilities() (lua version)",
    func = function(self)
        --local istack = minetest.getmeta(true);
        --local tool = ItemStackMetaDataRef::get_meta(true);
        local player = minetest.get_player_by_name("singleplayer");
        --local inv = player:get_inventory();
        --local stack = inv:get_stack("hand", 1);
       
        minetest.log("made it here!\n\n\n\n\n\n\n\n\n\n\n");
        
        local tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	};
        local inv = player:get_inventory()
        local stack = inv:get_stack("hand", 1)
        --stack:set_tool_capabilities(tool_capabilities)
        --inv:set_stack("hand", 1, stack)

        --pmeta=player:get_meta()
        --pmeta:set_string(digmulti,1.1)
        --local tool = ItemStack("default:pick_diamond");
        --tool:set_tool_capabilities(tool_capabilities)

        --local internal_name = stack
        --local tool = ItemStack("default:pick_diamond");
        --local caps = tool::getToolCapabilities();
        --minetest.log(caps)

        local item = player:get_wielded_item();
        minetest.log("The player's wielded item is " ..dump(item:to_string()));
        --item:ItemStackMetaRef()

	    local meta = item:get_meta();
        --minetest.log(item:get_meta().uses())
        meta:set_tool_capabilities(tool_capabilities);
        inv:set_stack(item:to_string(), 1, stack)
        --minetest.log(tool:get_meta().uses)
        minetest.log("made it here too!\n\n\n\n\n\n\n\n\n\n\n");
        --inv:set_stack("hand", 1, stack);
        
        local res = nil;
        if res == nil then 
            return true, "Success, set_tool_capabilities() returned: nil"
        else
            return true, "Success, set_tool_capabilities() returned: not nil"
        end
    end
})

--native test
minetest.register_chatcommand("native_itemstackmeta_set_tool_capabilities", {
    description = "test itemstackmeta class method set_tool_capabilities() (native version)",
    func = function(self)
        
    end
})

--comparison test
minetest.register_chatcommand("test_itemstackmeta_set_tool_capabilities", {
    description = "compares output of lua and native command for set_tool_capabilities()",
    func = function(self)
        
    end
})

minetest.register_chatcommand("test_itemstackmeta", {
    description = "testing all itemstackmeta methods",
    func = function()

        local methods = {
            "set_tool_capabilities"
        }

        return native_tests.test_class("itemstackmeta", methods),
        "itemstackmeta tests completed. See server_dump.txt for details."
    end
})
