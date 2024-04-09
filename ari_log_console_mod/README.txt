Mod Setup
-Put ari_test_log into /minetest/mods

Changing debug.txt Location
-we need access to it to log server text
-In /minetest/src/main.cpp, line 650 (or somewhere nearby)
	replace ->	std::string log_filename = porting::path_user + DIR_DELIM + DEBUGFILE;
	with	->	std::string log_filename = porting::path_user + DIR_DELIM + "worlds" + DIR_DELIM + [testWorldName] + DIR_DELIM + DEBUGFILE;
-Make sure that [testWorldName] is the name of the world folder that is being run

-In ari_test_log/init.lua, add any commands by doing minetest.register_chatcommand (if you're confused, follow the format for the other commands)
-Go into the world [testWorldName], and use the command: /log_lua_object
-The resulting logs are found in /minetest/worlds/[testWorldName]/lua_object_results.txt
