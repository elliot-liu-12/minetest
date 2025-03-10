-- static int l_native_rollback_get_node_actions(lua_State *L);
-- 2 functions = test original lua, test native lua, compare (3 tests each)

minetest.log("--Rollback server class tests--")

minetest.register_chatcommand("lua_rollback_get_actions", {
	-- Invokes lua_api > l_rollback:l_rollback_get_node_actions
	description = "Invokes lua_api > l_rollback:l_rollback_get_node_actions",
	-- self == this
	func = function(self)
		local pos = {x = 0, y = 32, z = 0}
		local range = 10
		--time_t seconds = (time_t)luaL_checknumber(L, 3);
		local seconds = 5
		local limit = 10
		local a = minetest.rollback_get_node_actions(pos, range, seconds, limit)
		--print (tprint(a))
		return true, "Success, l_rollback_get_node_actions() returned: "..dump(a)

	end
})

minetest.register_chatcommand("native_rollback_get_actions", {
	-- Invokes lua_api > l_rollback:l_rollback_get_node_actions
	description = "Invokes native_api > n_rollback:l_rollback_get_node_actions",
	-- self == this
	func = function(self)
		local pos = {x = 0, y = 32, z = 0}
		local range = 10
		--time_t seconds = (time_t)luaL_checknumber(L, 3);
		local seconds = 5
		local limit = 10
		local a = minetest.native_rollback_get_node_actions(pos, range, seconds, limit)
		--print (tprint(a))
		return true, "Success, n_rollback_get_node_actions() returned: "..dump(a)

	end
})


minetest.register_chatcommand("test_rollback_get_actions", {
	-- Invokes lua_api > l_rollback:l_rollback_get_node_actions
	description = "Invokes native_api > n_rollback:l_rollback_get_node_actions",
	-- self == this
	func = function(self)
		local pos = {x = 0, y = 32, z = 0}
		local range = 10
		--time_t seconds = (time_t)luaL_checknumber(L, 3);
		local seconds = 5
		local limit = 10
		local n = minetest.native_rollback_get_node_actions(pos, range, seconds, limit)
		local l = minetest.rollback_get_node_actions(pos, range, seconds, limit)
		local same = true
		if n ~= nil then
			for i = 1, #n do
				if n[i] ~= l[i] then
					same = false
					break
				end
			end
		end
		if n == nil and l == nil then
			same = true
		end
		if same then
			print("NATIVE: \n"..dump(n) .. "\n LUA: \n"..dump(l))
			return true, "Success, n_rollback_get_node_actions() and l_rollback_get_node_actions() returned the same"
		else
			return false, "Failure, n_rollback_get_node_actions() and l_rollback_get_node_actions() returned differently \n NATIVE: \n"..dump(n) .. "\n LUA: \n"..dump(l).. "\n META DATA N" ..dump(getmetatable(n)) .. "\n META DATA L \n"..dump(getmetatable(l))
		end
	end

})


-- static int l_native_rollback_revert_actions_by(lua_State *L);
--player:singleplayer
minetest.register_chatcommand("lua_rollback_revert_actions", {
	-- Invokes lua_api > l_rollback:l_rollback_get_node_actions
	description = "Invokes lua_api > l_rollback:l_rollback_revert_actions_by",
	-- self == this
	func = function(self)
		local actor = "player:singleplayer"
		local seconds = 5

		local a = minetest.rollback_revert_actions_by(actor, seconds)
		return true, "Success, l_rollback_revert_actions_by() returned: "..dump(a)

	end
})

minetest.register_chatcommand("native_rollback_revert_actions", {
	-- Invokes lua_api > l_rollback:l_rollback_get_node_actions
	description = "Invokes lua_api > n_rollback:n_rollback_revert_actions_by",
	-- self == this
	func = function(self)
		local actor = "player:singleplayer"
		local seconds = 5

		local a = minetest.native_rollback_revert_actions_by(actor, seconds)
		return true, "Success, n_rollback_revert_actions_by() returned: "..dump(a)

	end
})

minetest.register_chatcommand("test_rollback_revert_actions", {
	-- Invokes lua_api > l_rollback:l_rollback_get_node_actions
	description = "Invokes lua_api > l_rollback:l_rollback_revert_actions_by",
	-- self == this
	func = function(self)
		local actor = "player:singleplayer"
		local seconds = 5

		local n = minetest.native_rollback_revert_actions_by(actor, seconds)
		local l = minetest.rollback_revert_actions_by(actor, seconds)
		local same = n == l
		if same then
			return true, "Success, they are the same"
		else
			return false, "Failure, they are not the same \n" ..dump(n).."\n"..dump(l)
	    end	
	end
})

minetest.register_chatcommand("test_rollback", {
    description = "testing all rollback methods",
    func = function()

        local methods = {
            "revert_actions",
            "get_actions"
        }

        return native_tests.test_class("rollback", methods),
        "Rollback tests completed. See server_dump.txt for details."
    end
})
