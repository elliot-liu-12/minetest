//Native version of vmanip class.
//Erik Companhone.

#pragma once

#include <map>
#include "irr_v3d.h"
#include "lua_api/l_base.h"

//class ModApiBase;

class NativeLuaVoxelManip : public ModApiBase
{
private:
	//Native versions
	static int native_read_from_map();
	static int native_get_data();
	static int native_set_data();
	static int native_write_to_map();

	static int native_get_node_at();
	static int native_set_node_at();

	static int native_update_map();
	static int native_update_liquids();

	static int native_calc_lighting();
	static int native_set_lighting();
	static int native_get_light_data();
	static int native_set_light_data();

	static int native_get_param2_data();
	static int native_set_param2_data();

	static int native_was_modified();
	static int native_get_emerged_area();

	friend class LuaVoxelManip;
};
