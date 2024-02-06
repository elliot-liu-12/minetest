//Native version of vmanip class.
//Erik Companhone.

#include "lua_api/l_vmanip.h"
#include "lua_api/l_internal.h"
#include "common/c_content.h"
#include "common/c_converter.h"
#include "emerge.h"
#include "environment.h"
#include "map.h"
#include "mapblock.h"
#include "server.h"
#include "mapgen/mapgen.h"
#include "voxelalgorithms.h"
#include "native_vmanip.h"

int NativeLuaVoxelManip::native_read_from_map()
{
	return 0;
}

int NativeLuaVoxelManip::native_get_data()
{
	return 0;
}

int NativeLuaVoxelManip::native_set_data()
{
	return 0;
}

int NativeLuaVoxelManip::native_write_to_map()
{
	return 0;
}

int NativeLuaVoxelManip::native_get_node_at()
{
	return 0;
}

int NativeLuaVoxelManip::native_set_node_at()
{
	return 0;
}

int NativeLuaVoxelManip::native_update_map()
{
	return 0;
}

int NativeLuaVoxelManip::native_update_liquids()
{
	return 0;
}

int NativeLuaVoxelManip::native_calc_lighting()
{
	return 0;
}

int NativeLuaVoxelManip::native_set_lighting()
{
	return 0;
}

int NativeLuaVoxelManip::native_get_light_data()
{
	return 0;
}

int NativeLuaVoxelManip::native_set_light_data()
{
	return 0;
}

int NativeLuaVoxelManip::native_get_param2_data()
{
	return 0;
}

int NativeLuaVoxelManip::native_set_param2_data()
{
	return 0;
}

int NativeLuaVoxelManip::native_was_modified()
{
	return 0;
}

int NativeLuaVoxelManip::native_get_emerged_area()
{
	return 0;
}
