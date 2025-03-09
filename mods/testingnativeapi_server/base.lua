minetest.register_chatcommand("lua_base_deprecated_function", {
    description="Test base class method deprecated_function in lua",
    func = function()
        local player = minetest.get_player_by_name("singleplayer")
        --call deprecated API function
        local res_dep = player:add_player_velocity({x=1.1, y=1.1, z=1.1})
        --set player velocity back to zero
        player:set_velocity({x=0.0, y=0.0, z=0.0})
        -- call normal API function
        local res = player:add_velocity({x=1.1, y=1.1, z=1.1})
        --set player velocity back to zero
        player:set_velocity({x=0.0, y=0.0, z=0.0})
        --results should be the same
        if (res == res_dep) then
        return true, "Outputs are the same and didn't crash"
        end
        return false, "Outputs are not the same"
    end
})

minetest.register_chatcommand("native_base_deprecated_function", {
    description="Test native deprecated function in lua",
    func = function()
        local player = minetest.get_player_by_name("singleplayer")
        local res = minetest.base.deprecated_function(player:add_player_velocity{x=1.1, y=1.1, z=1.1})
        if (res == 1) then 
        return true, "Returned OG deprecated function argument index"
        end
        return false, "Did not return expected value"
    end

})
minetest.register_chatcommand("test_base_deprecated_function")