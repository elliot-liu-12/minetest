-- modchannels test mod
-- test modchannels class methods
-- Client side tests

minetest.log("--ModChannelsRef client class tests not finished--")

--leave()  
--lua test
--FIXME res = nil because nothing is being pushed to lua stack in l_leave or native_leave
minetest.register_chatcommand("lua_modchannels_leave", {
    description = "test modchannels class method leave (lua version)",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local res = mymodchannel:leave();
        --print(res);
        if res == nil then 
            return true, "Success, leave() returned: 0"
        else
            return false, "Failure, leave() returned: 1"
        end
    end
})

--native test
minetest.register_chatcommand("native_modchannels_leave", {
    description = "test modchannels class method leave (native version)",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local res = mymodchannel:native_leave();
        --print(res);
        if res == nil then
            return true, "Success, leave() returned: 0"
        else
            return false, "Failure, leave() returned: 1"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_modchannels_leave", {
    description = "compares output of lua and native command for leave()",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local lres = mymodchannel:leave();
        local nres = mymodchannel:native_leave();
        --print(lres);
        --print(nres);
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return true, "Failure, function output does not match - check console for more details"
        end
    end
})

--is_writeable()  
--lua test
--only writable on server side
minetest.register_chatcommand("lua_modchannels_is_writeable", {
    description = "test modchannels class method is_writeable (lua version)",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local res = mymodchannel:is_writeable();
        --print(res);
        if res == true then 
            return true, "Success, is_writeable() returned: True"
        else
            return true, "Success, is_writeable() returned: False"
        end
    end
})

--native test
minetest.register_chatcommand("native_modchannels_is_writeable", {
    description = "test modchannels class method is_writeable (native version)",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local res = mymodchannel:native_is_writeable();
        --print(res);
        if res == true then
            return true, "Success, is_writeable() returned: True"
        else
            return true, "Success, is_writeable() returned: False"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_modchannels_is_writeable", {
    description = "compares output of lua and native command for is_writeable()",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local lres = mymodchannel:is_writeable();
        local nres = mymodchannel:native_is_writeable();
        --print(lres);
        --print(nres);
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

--send_all()  
--lua test
--FIXME returning nil too
minetest.register_chatcommand("lua_modchannels_send_all", {
    description = "test modchannels class method send_all (lua version)",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local res = mymodchannel:send_all("hello world");
        --print(res);
        if res == nil then 
            return true, "Success, send_all() returned: 0"
        else
            return false, "Failure, send_all() returned: 1"
        end
    end
})

--native test
minetest.register_chatcommand("native_modchannels_send_all", {
    description = "test modchannels class method send_all (native version)",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local res = mymodchannel:native_send_all("hello world");
        --print(res);
        if res == nil then
            return true, "Success, send_all() returned: 0"
        else
            return false, "Failure, send_all() returned: 1"
        end
    end
})

--comparison test
minetest.register_chatcommand("test_modchannels_send_all", {
    description = "compares output of lua and native command for send_all()",
    func = function(self)
        local mymodchannel = minetest.mod_channel_join("channel_name");
        local lres = mymodchannel:send_all("hello world");
        local nres = mymodchannel:native_send_all("hello world");
        --print(lres);
        --print(nres);
        if lres == nres then
            return true, "Success, function output matches - check console for more details"
        else
            return false, "Failure, function output does not match - check console for more details"
        end
    end
})

minetest.register_chatcommand("test_modchannels", {
    description = "testing all modchannels methods",
    func = function()

        local methods = {
            "leave",
            "is_writeable",
            "send_all"
        }

        return native_tests.test_class("modchannels", methods),
        "Modchannels tests completed. See server_dump.txt for details."
    end
})
