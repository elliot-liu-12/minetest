set(common_SCRIPT_NATIVE_API_SRCS
	${CMAKE_CURRENT_SOURCE_DIR}/native_areastore.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_auth.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_inventory.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_item.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_particles.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_noise.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_settings.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_nodetimer.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_modchannels.cpp

	${CMAKE_CURRENT_SOURCE_DIR}/native_itemstackmeta.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_metadata.cpp
	
	${CMAKE_CURRENT_SOURCE_DIR}/native_nodemeta.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_util.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_server.cpp
	PARENT_SCOPE)

set(client_SCRIPT_NATIVE_API_SRCS
	${CMAKE_CURRENT_SOURCE_DIR}/native_minimap.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_camera.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_client.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_localplayer.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_particles_local.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/native_sound.cpp
	PARENT_SCOPE)
