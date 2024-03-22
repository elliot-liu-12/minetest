-- l_remove
minetest.register_chatcommand("lua_object_remove", {
    description = "Test Object Remove",
    func = function(name, param)
        minetest.log("lua_object_remove is running!")
        local player = minetest.get_player_by_name(name)

        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 8)

        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end

        -- Output the size of saos to minetest.log
        minetest.log("Size of saos: " .. #saos)

        for i, object in ipairs(saos) do
            if not object:is_player() then
                minetest.log("Removed: "..object:get_entity_name())
                local objectRemove = object:remove()
            end
        end
    end,
})

-- l_punch
minetest.register_chatcommand("lua_object_punch", {
    description = "Test Object Move To",
    func = function(name, param)
        minetest.log("lua_object_set_pos is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        for i, object in ipairs(saos) do
            -- Check if the object is a player
            if object:is_player() then
                for i, floorobj in ipairs(saos) do
                    if not floorobj:isplayer() then
                        -- Wear all objects on floor
                        -- punch(self, puncher, time_from_last_punch, tool_capabilities, dir)
                        -- object:punch(floorobj, 5, )
                    end
                end
            end
        end
    end,
})

-- l_right_click
-- right_click(self, clicker)
minetest.register_chatcommand("lua_object_right_click", {
    description = "Test Object Right Click",
    func = function(name, param)
        minetest.log("lua_object_right_click is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)

        -- Insert Lua code here that if saos == 2 then set plyr = saos[0] and rclk = saos[1]
        if #saos == 2 then
            local plyr = saos[1]
            local rclk = saos[2]
            plyr:right_click(rclk)
            minetest.log("Object: "..plyr:get_player_name().." right clicked on ".. rclk:get_entity_name())
        end
    end,
})

--set_hp
minetest.register_chatcommand("lua_object_set_hp", {
    description = "Set the player's current HP - 0-20",
    func = function(name, param)
        minetest.log("lua_object_et_hp is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)
        for i, object in ipairs(saos) do
            local a = object:set_hp(tonumber(param), "set_hp")
            minetest.log("The object's HP was set to " ..param)
            minetest.log("The object's HP is currently " ..dump(a))
        end
    end,
})

--get_hp
-- get_hp(self)
minetest.register_chatcommand("lua_object_get_hp", {
    description = "Get the player's current HP",
    func = function(name, param)
        minetest.log("lua_object_get_hp is running!")
        local player = minetest.get_player_by_name(name)
        
        if not player then
            minetest.log("Player not found")
            return
        end

        local pos = player:get_pos()
        local saos = minetest.get_objects_inside_radius(pos, 2)
        
        -- Check if saos is empty
        if #saos == 0 then
            minetest.log("No Active Objects near Player")
            return
        end
        
        -- Output the size of saos to minetest.log
        minetest.log("Size of Active Objects Array: " .. #saos)
        for i, object in ipairs(saos) do
            local a = object:get_hp()
            minetest.log("The object's HP is currently " ..dump(a))
        end
    end,
})

--main command for logging other lua_object commands
local function run_lua_object_commands_and_log()
	-- Open a log text file to write to, and a debug text file to read from
    local log_file = io.open(minetest.get_worldpath() .. "/lua_object_results.txt", "w")
	local debug_file = io.open(minetest.get_worldpath() .. "/debug.txt", "r")

    if not log_file then
        minetest.log("Failed to open log file for writing.")
        return
    end
	if not debug_file then
		minetest.log("Failed to open debug file for reading. Please create empty debug.txt in world folder.")
		return
	end

    local total_commands = 0
    local passed_commands = 0



	--read through all old data to discard
	debug_file:read("*all")
	
	--loop through each lua_object command in the registered_chatcommands list
    for command, command_info in pairs(minetest.registered_chatcommands) do
        if string.match(command, "^lua_object") then
            minetest.log("Running lua_object command: " .. command)
			
			--record start time
			local start_time = os.clock()
			
            --calls function(name, param)
            local success, result = pcall(command_info.func, "singleplayer", "15")
			
			--record end time and calculate execution time
			local end_time = os.clock()
			local execution_time = end_time - start_time
			
            log_file:write("Command: " .. command .. "\n")
			log_file:write("Execution Time: " .. execution_time .. " seconds\n")
            log_file:write("Result: " .. (success and "Success" or "Error") .. "\n")
			log_file:write("Output:\n")
			
			--write all new data from calling the current command
			log_file:write(debug_file:read("*all"))
			
			--write result
            if (success) then
				log_file:write("\n")
                passed_commands = passed_commands + 1
            else
                log_file:write((result or "No output") .. "\n\n")
            end

            total_commands = total_commands + 1
        end
    end
	
	
	
    log_file:write(passed_commands .. "/" .. total_commands .. " Tests Passed\n")
    log_file:close()
	debug_file:close()
    minetest.log("All lua_object commands logged to lua_object_results.txt")
end

-- Register a chat command to run and log lua_object commands
minetest.register_chatcommand("log_lua_object", {
    description = "Run and log lua_object commands",
    func = run_lua_object_commands_and_log,
})


