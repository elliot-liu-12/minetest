add_subdirectory(common)
add_subdirectory(cpp_api)
add_subdirectory(lua_api)
add_subdirectory(native_api)

# Used by server and client
set(common_SCRIPT_SRCS
	${CMAKE_CURRENT_SOURCE_DIR}/scripting_server.cpp
	${common_SCRIPT_COMMON_SRCS}
	${common_SCRIPT_CPP_API_SRCS}
	${common_SCRIPT_LUA_API_SRCS}
	${common_SCRIPT_NATIVE_API_SRCS}
	PARENT_SCOPE)

# Used by client only
set(client_SCRIPT_SRCS
	${CMAKE_CURRENT_SOURCE_DIR}/scripting_mainmenu.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/scripting_client.cpp
	${client_SCRIPT_COMMON_SRCS}
	${client_SCRIPT_CPP_API_SRCS}
	${client_SCRIPT_LUA_API_SRCS}
	${client_SCRIPT_NATIVE_API_SRCS}
	PARENT_SCOPE)

