-- itemstackmeta test mod
-- test itemstackmeta class methods

minetest.log("--itemstackmeta class tests--")

--set_tool_capabilities()
--lua test
minetest.register_chatcommand("lua_itemstackmeta_set_tool_capabilities", {
    description = "test itemstackmeta class method set_tool_capabilities() (lua version)",
    func = function(self)
        
        local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_diamond");
        local meta = itemstack:get_meta();

        local tool_capabilities = {
            full_punch_interval = 1.5,
            max_drop_level = 1,
            groupcaps = {
                cracky = {
                    maxlevel = 2,
                    uses = 20,
                    times = { [1]=1.60, [2]=1.20, [3]=0.80 }
                },
            },
            damage_groups = {fleshy=2},
        }
        
        local res = meta:set_tool_capabilities(tool_capabilities);
        --spawn modded pickaxe (inv position 1)
        inv:set_stack("main", 1, itemstack);

        --spawn normal pickaxe for comparison (inv position 2)
        local itemstack2 = ItemStack("default:pick_diamond");
        inv:set_stack("main", 2, itemstack2);

        --spawn modded pickaxe with nil as toolcaps (inv position 3)
        local itemstack3 = ItemStack("default:pick_diamond");
        local meta2 = itemstack3:get_meta();
        local res2 = meta2:set_tool_capabilities(nil);
        inv:set_stack("main", 3, itemstack3);

        if res == nil then 
            return true, "Success, set_tool_capabilities() returned: nil, tool caps applied"
        end
        if res2 == nil then
            return true, "Success, set_tool_capabilities() returned: nil, tool caps cleared"
        end
    end
})

--native test
minetest.register_chatcommand("native_itemstackmeta_set_tool_capabilities", {
    description = "test itemstackmeta class method set_tool_capabilities() (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();
        local itemstack = ItemStack("default:pick_diamond");
        local meta = itemstack:get_meta();

        local tool_capabilities = {
            full_punch_interval = 1.5,
            max_drop_level = 1,
            groupcaps = {
                cracky = {
                    maxlevel = 2,
                    uses = 20,
                    times = { [1]=1.60, [2]=1.20, [3]=0.80 }
                },
            },
            damage_groups = {fleshy=2},
        }
        
        local res = meta:native_set_tool_capabilities(tool_capabilities);
        --spawn modded pickaxe (inv position 1)
        inv:set_stack("main", 1, itemstack);

        --spawn normal pickaxe for comparison (inv position 2)
        local itemstack2 = ItemStack("default:pick_diamond");
        inv:set_stack("main", 2, itemstack2);

        --spawn modded pickaxe with nil as toolcaps (inv position 3)
        local itemstack3 = ItemStack("default:pick_diamond");
        local meta2 = itemstack3:get_meta();
        local res2 = meta2:native_set_tool_capabilities(nil);
        inv:set_stack("main", 3, itemstack3);

        if res == nil then 
            return true, "Success, native_set_tool_capabilities() returned: nil, tool caps applied"
        end
        if res2 == nil then
            return true, "Success, native_set_tool_capabilities() returned: nil, tool caps cleared"
        end
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
