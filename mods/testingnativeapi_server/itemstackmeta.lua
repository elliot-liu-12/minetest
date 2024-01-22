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
        local res2 = meta2:set_tool_capabilities(tool_capabilities);
        res2 = meta2:set_tool_capabilities(nil);
        inv:set_stack("main", 3, itemstack3);

        --final comparisons
        local eq1 = (itemstack:get_meta() ~= itemstack2:get_meta());
        local eq2 = (itemstack3:get_meta() == itemstack2:get_meta());
        local finalres = (eq1 == eq2);

        if finalres == true then 
            return true, "Success, set_tool_capabilities() returned: nil, \nfirst pickaxe: set_tool_capabilities aplied to be slower.\nsecond pickaxe: normal pickaxe.\nthird pickaxe: set_tool_capabilities applied to clear caps back to normal."
        else
            return false, "Failure, set_tool_capabilities() returned: nil, tool caps not applied correctly."
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
        local res2 = meta2:native_set_tool_capabilities(tool_capabilities);
        res2 = meta2:native_set_tool_capabilities(nil);
        inv:set_stack("main", 3, itemstack3);

        --final comparisons
        local eq1 = (itemstack:get_meta() ~= itemstack2:get_meta());
        local eq2 = (itemstack3:get_meta() == itemstack2:get_meta());
        local finalres = (eq1 == eq2);

        if finalres == true then 
            return true, "Success, native_set_tool_capabilities() returned: nil, \nfirst pickaxe: set_tool_capabilities aplied to be slower.\nsecond pickaxe: normal pickaxe.\nthird pickaxe: set_tool_capabilities applied to clear caps back to normal."
        else
            return false, "Failure, native_set_tool_capabilities() returned: nil, tool caps not applied correctly."
        end
    end
})

--comparison test
minetest.register_chatcommand("test_itemstackmeta_set_tool_capabilities", {
    description = "compares output of lua and native command for set_tool_capabilities()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local inv = player:get_inventory();

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

        --create item stacks
        local itemstack11 = ItemStack("default:pick_diamond");
        local itemstack12 = ItemStack("default:pick_diamond");
        local itemstack21 = ItemStack("default:pick_diamond");
        local itemstack22 = ItemStack("default:pick_diamond");

        --comparison applying tool caps
        local meta11 = itemstack11:get_meta();
        local meta12 = itemstack12:get_meta();
        local res11 = meta11:set_tool_capabilities(tool_capabilities);
        local res12 = meta12:native_set_tool_capabilities(tool_capabilities);
        local eq1 = (itemstack11:get_meta() == itemstack12:get_meta());

        --comparison applying nil tool caps
        local meta21 = itemstack21:get_meta();
        local meta22 = itemstack22:get_meta();
        local res21 = meta21:set_tool_capabilities(nil);
        local res22 = meta22:native_set_tool_capabilities(nil);
        local eq2 = (itemstack21:get_meta() == itemstack22:get_meta());

        local res = (eq1 == eq2);

        --minetest.log(tostring(eq1));
        --minetest.log(tostring(eq2));
        --minetest.log(tostring(res));

        if res == true then 
            return true, "Success, set_tool_capabilities() and native_set_tool_capabilities() create same itemstack metadata."
        else
            return false, "Failure, set_tool_capabilities() and native_set_tool_capabilities() create different itemstack metadata."
        end
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
