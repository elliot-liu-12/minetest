-- nodetimer test mod
-- test nodetimer class methods

--FIXME can I have hardcoded values on test cases

minetest.log("--NodeTimerRef class tests--")

--set()
--setting elapsed = 0 makes it not work, use start instead.
--lua test
minetest.register_chatcommand("lua_nodetimer_set", {
    description = "test nodetimer class method set (lua version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:set(10,5); --on_timer() will happen in 10 - 5 secs
        if res == nil then 
            return true, "Success, set() returned: nil"
        else
            return true, "Success, set() returned: not nil"
        end
    end
})

--native test FIXME only one not working?
minetest.register_chatcommand("native_nodetimer_set", {
    description = "test nodetimer class method set (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:native_set(10,5);
        if res == nil then
            return true, "Success, set() returned: nil"
        else
            return true, "Success, set() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_nodetimer_set", {
    description = "compares output of lua and native command for set()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local lres = nodetimer:set(10,5);
        local nres = nodetimer:native_set(10,5);
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--start()
--lua test
minetest.register_chatcommand("lua_nodetimer_start", {
    description = "test nodetimer class method start (lua version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:start(10);
        if res == nil then
            return true, "Success, start() returned: nil"
        else
            return true, "Success, start() returned: not nil"
        end
    end
})

--native test
minetest.register_chatcommand("native_nodetimer_start", {
    description = "test nodetimer class method start (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:native_start(10);
        if res == nil then
            return true, "Success, start() returned: nil"
        else
            return true, "Success, start() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_nodetimer_start", {
    description = "compares output of lua and native command for start()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local lres = nodetimer:start(10);
        local nres = nodetimer:native_start(10);
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--stop()
--lua test
minetest.register_chatcommand("lua_nodetimer_stop", {
    description = "test nodetimer class method stop (lua version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:stop(); 
        if res == nil then
            return true, "Success, stop() returned: nil"
        else
            return true, "Success, stop() returned: not nil"
        end
    end
})

--native test
minetest.register_chatcommand("native_nodetimer_stop", {
    description = "test nodetimer class method stop (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:native_stop();
        if res == nil then
            return true, "Success, stop() returned: nil"
        else
            return true, "Success, stop() returned: not nil"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_nodetimer_stop", {
    description = "compares output of lua and native command for stop()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local lres = nodetimer:stop();
        local nres = nodetimer:native_stop();
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--is_started()
-- will return false if called after nodetimer:on_timer() gets called
--lua test
minetest.register_chatcommand("lua_nodetimer_is_started", {
    description = "test nodetimer class method is_started (lua version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:is_started();
        if res then
            return true, "Success, is_started() returned: true"
        else
            return true, "Success, is_started() returned: false"
        end
    end
})

--native test
minetest.register_chatcommand("native_nodetimer_is_started", {
    description = "test nodetimer class method is_started (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:native_is_started();
        if res then
            return true, "Success, is_started() returned: true"
        else
            return true, "Success, is_started() returned: false"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_nodetimer_is_started", {
    description = "compares output of lua and native command for is_started()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos); 
        local lres = nodetimer:is_started();
        local nres = nodetimer:native_is_started();
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_timeout()
--lua test
minetest.register_chatcommand("lua_nodetimer_get_timeout", {
    description = "test nodetimer class method get_timeout (lua version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:get_timeout();
        if res == 10 then -- set() uses timeout = 10
            return true, "Success, get_timeout() returned: 10"
        else
            return true, "Success, get_timeout() returned: not 10"
        end
    end
})

--native test
minetest.register_chatcommand("native_nodetimer_get_timeout", {
    description = "test nodetimer class method get_timeout (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:get_timeout();
        if res == 10 then
            return true, "Success, get_timeout() returned: 10"
        else
            return true, "Success, get_timeout() returned: not 10"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_nodetimer_get_timeout", {
    description = "compares output of lua and native command for get_timeout()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local lres = nodetimer:get_timeout();
        local nres = nodetimer:native_get_timeout();
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--get_elapsed()
--lua test
minetest.register_chatcommand("lua_nodetimer_get_elapsed", {
    description = "test nodetimer class method get_elapsed (lua version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:get_elapsed();
        if res == 5 then -- set() uses elapsed = 5
            return true, "Success, get_elapsed() returned: 5"
        else
            return true, "Success, get_elapsed() returned: not 5"
        end
    end
})

--native test
minetest.register_chatcommand("native_nodetimer_get_elapsed", {
    description = "test nodetimer class method get_elapsed (native version)",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local res = nodetimer:native_get_elapsed();
        if res == 5 then
            return true, "Success, get_elapsed() returned: 5"
        else
            return true, "Success, get_elapsed() returned: not 5"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_nodetimer_get_elapsed", {
    description = "compares output of lua and native command for get_elapsed()",
    func = function(self)
        local player = minetest.get_player_by_name("singleplayer");
        local pos = player:get_pos();
        local nodetimer = minetest.get_node_timer(pos);
        local lres = nodetimer:get_elapsed();
        local nres = nodetimer:native_get_elapsed();
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

minetest.register_chatcommand("test_nodetimer", {
    description = "testing all nodetimer methods",
    func = function()

        local methods = {
            "set",
            "start",
            "stop",
            "is_started",
            "get_timeout",
            "get_elapsed"
        }

        return native_tests.test_class("nodetimer", methods),
        "Nodetimer tests completed. See server_dump.txt for details."
    end
})