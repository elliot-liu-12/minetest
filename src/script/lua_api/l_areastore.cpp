/*
Minetest
Copyright (C) 2015 est31 <mtest31@outlook.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation; either version 2.1 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/


#include "lua_api/l_areastore.h"
#include "lua_api/l_internal.h"
#include "common/c_converter.h"
#include "cpp_api/s_security.h"
#include "irr_v3d.h"
#include "util/areastore.h"
#include "filesys.h"
#include <fstream>
#include "../native_api/native_areastore.h"

static inline void get_data_and_border_flags(lua_State *L, u8 start_i,
		bool *borders, bool *data)
{
	if (!lua_isboolean(L, start_i))
		return;
	*borders = lua_toboolean(L, start_i);
	if (!lua_isboolean(L, start_i + 1))
		return;
	*data = lua_toboolean(L, start_i + 1);
}

static void push_area(lua_State *L, const Area *a,
		bool include_borders, bool include_data)
{
	if (!include_borders && !include_data) {
		lua_pushboolean(L, true);
		return;
	}
	lua_newtable(L);
	if (include_borders) {
		push_v3s16(L, a->minedge);
		lua_setfield(L, -2, "min");
		push_v3s16(L, a->maxedge);
		lua_setfield(L, -2, "max");
	}
	if (include_data) {
		lua_pushlstring(L, a->data.c_str(), a->data.size());
		lua_setfield(L, -2, "data");
	}
}

static inline void push_areas(lua_State *L, const std::vector<Area *> &areas,
		bool borders, bool data)
{
	lua_newtable(L);
	size_t cnt = areas.size();
	for (size_t i = 0; i < cnt; i++) {
		lua_pushnumber(L, areas[i]->id);
		push_area(L, areas[i], borders, data);
		lua_settable(L, -3);
	}
}

// Deserializes value and handles errors
static int deserialization_helper(lua_State *L, AreaStore *as,
		std::istream &is)
{
	try {
		as->deserialize(is);
	} catch (const SerializationError &e) {
		lua_pushboolean(L, false);
		lua_pushstring(L, e.what());
		return 2;
	}

	lua_pushboolean(L, true);
	return 1;
}

// garbage collector
int LuaAreaStore::gc_object(lua_State *L)
{
	LuaAreaStore *o = *(LuaAreaStore **)(lua_touserdata(L, 1));
	delete o;
	return 0;
}

// get_area(id, include_borders, include_data)
int LuaAreaStore::l_get_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	u32 id = luaL_checknumber(L, 2);

	bool include_borders = true;
	bool include_data = false;
	get_data_and_border_flags(L, 3, &include_borders, &include_data);

	const Area *res;

	res = ast->getArea(id);
	if (!res)
		return 0;

	push_area(L, res, include_borders, include_data);

	return 1;
}

// get_areas_for_pos(pos, include_borders, include_data)
int LuaAreaStore::l_get_areas_for_pos(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	v3s16 pos = check_v3s16(L, 2);

	bool include_borders = true;
	bool include_data = false;
	get_data_and_border_flags(L, 3, &include_borders, &include_data);

	std::vector<Area *> res;

	ast->getAreasForPos(&res, pos);
	push_areas(L, res, include_borders, include_data);

	return 1;
}

// get_areas_in_area(edge1, edge2, accept_overlap, include_borders, include_data)
int LuaAreaStore::l_get_areas_in_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	v3s16 minedge = check_v3s16(L, 2);
	v3s16 maxedge = check_v3s16(L, 3);

	bool include_borders = true;
	bool include_data = false;
	bool accept_overlap = false;
	if (lua_isboolean(L, 4)) {
		accept_overlap = readParam<bool>(L, 4);
		get_data_and_border_flags(L, 5, &include_borders, &include_data);
	}
	std::vector<Area *> res;

	ast->getAreasInArea(&res, minedge, maxedge, accept_overlap);
	push_areas(L, res, include_borders, include_data);

	return 1;
}

// insert_area(edge1, edge2, data, id)
int LuaAreaStore::l_insert_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	Area a(check_v3s16(L, 2), check_v3s16(L, 3));

	size_t d_len;
	const char *data = luaL_checklstring(L, 4, &d_len);

	a.data = std::string(data, d_len);

	if (lua_isnumber(L, 5))
		a.id = lua_tonumber(L, 5);

	// Insert & assign a new ID if necessary
	if (!ast->insertArea(&a))
		return 0;

	lua_pushnumber(L, a.id);
	return 1;
}

// reserve(count)
int LuaAreaStore::l_reserve(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	size_t count = luaL_checknumber(L, 2);
	ast->reserve(count);
	return 0;
}

// remove_area(id)
int LuaAreaStore::l_remove_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	u32 id = luaL_checknumber(L, 2);
	bool success = ast->removeArea(id);

	lua_pushboolean(L, success);
	return 1;
}

// set_cache_params(params)
int LuaAreaStore::l_set_cache_params(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	luaL_checktype(L, 2, LUA_TTABLE);

	bool enabled = getboolfield_default(L, 2, "enabled", true);
	u8 block_radius = getintfield_default(L, 2, "block_radius", 64);
	size_t limit = getintfield_default(L, 2, "block_radius", 1000);

	ast->setCacheParams(enabled, block_radius, limit);

	return 0;
}

// to_string()
int LuaAreaStore::l_to_string(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	std::ostringstream os(std::ios_base::binary);
	o->as->serialize(os);
	std::string str = os.str();

	lua_pushlstring(L, str.c_str(), str.length());
	return 1;
}

// to_file(filename)
int LuaAreaStore::l_to_file(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	const char *filename = luaL_checkstring(L, 2);
	CHECK_SECURE_PATH(L, filename, true);

	std::ostringstream os(std::ios_base::binary);
	ast->serialize(os);

	lua_pushboolean(L, fs::safeWriteToFile(filename, os.str()));
	return 1;
}

// from_string(str)
int LuaAreaStore::l_from_string(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	size_t len;
	const char *str = luaL_checklstring(L, 2, &len);

	std::istringstream is(std::string(str, len), std::ios::binary);
	return deserialization_helper(L, o->as, is);
}

// from_file(filename)
int LuaAreaStore::l_from_file(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	const char *filename = luaL_checkstring(L, 2);
	CHECK_SECURE_PATH(L, filename, false);

	std::ifstream is(filename, std::ios::binary);
	return deserialization_helper(L, o->as, is);
}

LuaAreaStore::LuaAreaStore() : as(AreaStore::getOptimalImplementation())
{
}

LuaAreaStore::LuaAreaStore(const std::string &type)
{
#if USE_SPATIAL
	if (type == "LibSpatial") {
		as = new SpatialAreaStore();
	} else
#endif
	{
		as = new VectorAreaStore();
	}
}

LuaAreaStore::~LuaAreaStore()
{
	delete as;
}

// LuaAreaStore()
// Creates an LuaAreaStore and leaves it on top of stack
int LuaAreaStore::create_object(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = (lua_isstring(L, 1)) ?
		new LuaAreaStore(readParam<std::string>(L, 1)) :
		new LuaAreaStore();

	*(void **)(lua_newuserdata(L, sizeof(void *))) = o;
	luaL_getmetatable(L, className);
	lua_setmetatable(L, -2);
	return 1;
}

LuaAreaStore *LuaAreaStore::checkobject(lua_State *L, int narg)
{
	NO_MAP_LOCK_REQUIRED;

	luaL_checktype(L, narg, LUA_TUSERDATA);

	void *ud = luaL_checkudata(L, narg, className);
	if (!ud)
		luaL_typerror(L, narg, className);

	return *(LuaAreaStore **)ud;  // unbox pointer
}

void LuaAreaStore::Register(lua_State *L)
{
	lua_newtable(L);
	int methodtable = lua_gettop(L);
	luaL_newmetatable(L, className);
	int metatable = lua_gettop(L);

	lua_pushliteral(L, "__metatable");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);  // hide metatable from Lua getmetatable()

	lua_pushliteral(L, "__index");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);

	lua_pushliteral(L, "__gc");
	lua_pushcfunction(L, gc_object);
	lua_settable(L, metatable);

	lua_pop(L, 1);  // drop metatable

	luaL_openlib(L, 0, methods, 0);  // fill methodtable
	lua_pop(L, 1);  // drop methodtable

	// Can be created from Lua (AreaStore())
	lua_register(L, className, create_object);
}

const char LuaAreaStore::className[] = "AreaStore";
const luaL_Reg LuaAreaStore::methods[] = {
	luamethod(LuaAreaStore, get_area),
	luamethod(LuaAreaStore, get_areas_for_pos),
	luamethod(LuaAreaStore, get_areas_in_area),
	luamethod(LuaAreaStore, insert_area),
	luamethod(LuaAreaStore, reserve),
	luamethod(LuaAreaStore, remove_area),
	luamethod(LuaAreaStore, set_cache_params),
	luamethod(LuaAreaStore, to_string),
	luamethod(LuaAreaStore, to_file),
	luamethod(LuaAreaStore, from_string),
	luamethod(LuaAreaStore, from_file),

	// register testing methods
	luamethod(LuaAreaStore, native_get_area),
	luamethod(LuaAreaStore, native_get_areas_for_pos),
	luamethod(LuaAreaStore, native_get_areas_in_area),
	luamethod(LuaAreaStore, native_insert_area),
	luamethod(LuaAreaStore, native_reserve),
	luamethod(LuaAreaStore, native_remove_area),
	luamethod(LuaAreaStore, native_set_cache_params),
	luamethod(LuaAreaStore, native_to_string),
	luamethod(LuaAreaStore, native_to_file),
	luamethod(LuaAreaStore, native_from_string),
	luamethod(LuaAreaStore, native_from_file),

	{0,0}
};

static void push_area_from_native(
		lua_State *L, std::tuple<bool *, v3s16 *, v3s16 *, std::string *> input)
{
	if (std::get<0>(input)) {
		lua_pushboolean(L, true);
		return;
	}
	lua_newtable(L);
	if (std::get<1>(input) && std::get<2>(input)) {
		push_v3s16(L, *std::get<1>(input));
		lua_setfield(L, -2, "min");
		push_v3s16(L, *std::get<2>(input));
		lua_setfield(L, -2, "max");
	}
	if (std::get<3>(input)) {
		lua_pushlstring(L, (*std::get<3>(input)).c_str(),
				(*std::get<3>(input)).size());
		lua_setfield(L, -2, "data");
	}
}

static inline void push_areas_from_native(lua_State *L,
		std::map<u32, std::tuple<bool *, v3s16 *, v3s16 *, std::string *>> input)
{
	lua_newtable(L);
	for (const auto &pair : input) {
		lua_pushnumber(L, pair.first);
		push_area_from_native(L, pair.second);
		lua_settable(L, -3);
	}
}

static int deserialization_helper_from_native(lua_State *L, std::tuple<bool, const char*> input)
{
	lua_pushboolean(L, std::get<0>(input));
	if (std::get<1>(input) != nullptr) {
		lua_pushstring(L, std::get<1>(input));
		return 2;
	}
	return 1;
}

// native_get_area(id, include_borders, include_data)
int LuaAreaStore::l_native_get_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	AreaStore *ast = o->as;

	u32 id = luaL_checknumber(L, 2);

	bool include_borders = true;
	bool include_data = false;
	get_data_and_border_flags(L, 3, &include_borders, &include_data);

	const Area *res;

	res = ast->getArea(id);
	if (!res)
		return 0;

	std::tuple<bool*, v3s16*, v3s16*, std::string*> result =
			NativeAreaStore::native_get_area(res, id, include_borders, include_data);

	push_area_from_native(L, result);

	return 1;
}

// native_get_areas_for_pos(pos, include_borders, include_data)
int LuaAreaStore::l_native_get_areas_for_pos(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	v3s16 pos = check_v3s16(L, 2);

	bool include_borders = true;
	bool include_data = false;
	get_data_and_border_flags(L, 3, &include_borders, &include_data);

	std::map<u32, std::tuple<bool *, v3s16 *, v3s16 *, std::string *>> result =
		NativeAreaStore::native_get_areas_for_pos(o, pos, include_borders, include_data);

	push_areas_from_native(L, result);

	return 1;
}

// native_get_areas_in_area(edge1, edge2, accept_overlap, include_borders, include_data)
int LuaAreaStore::l_native_get_areas_in_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	v3s16 minedge = check_v3s16(L, 2);
	v3s16 maxedge = check_v3s16(L, 3);

	bool include_borders = true;
	bool include_data = false;
	bool accept_overlap = false;
	if (lua_isboolean(L, 4)) {
		accept_overlap = readParam<bool>(L, 4);
		get_data_and_border_flags(L, 5, &include_borders, &include_data);
	}

	std::map<u32, std::tuple<bool *, v3s16 *, v3s16 *, std::string *>> result =
			NativeAreaStore::native_get_areas_in_area(o, minedge, maxedge,
					include_borders, include_data, accept_overlap);

	push_areas_from_native(L, result);

	return 1;
}

// native_insert_area(edge1, edge2, data, id)
int LuaAreaStore::l_native_insert_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	size_t d_len;
	const char *data = luaL_checklstring(L, 4, &d_len);

	std::string str = std::string(data, d_len);

	int result;
	if (lua_isnumber(L, 5)) {
		int val = lua_tonumber(L, 5);
		result = NativeAreaStore::native_insert_area(
				o, check_v3s16(L, 2), check_v3s16(L, 3), str, &val);
	} else {
		result = NativeAreaStore::native_insert_area(
				o, check_v3s16(L, 2), check_v3s16(L, 3), str, nullptr);
	}


	if (result == -1)
		return 0;

	lua_pushnumber(L, result);
	return 1;
}

// native_reserve(count)
int LuaAreaStore::l_native_reserve(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	size_t count = luaL_checknumber(L, 2);

	return NativeAreaStore::native_reserve(o, count);;
}

// native_remove_area(id)
int LuaAreaStore::l_native_remove_area(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	u32 id = luaL_checknumber(L, 2);

	bool success = NativeAreaStore::native_remove_area(o, id);

	lua_pushboolean(L, success);
	return 1;
}

// native_set_cache_params(params)
int LuaAreaStore::l_native_set_cache_params(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);
	luaL_checktype(L, 2, LUA_TTABLE);

	bool enabled = getboolfield_default(L, 2, "enabled", true);
	u8 block_radius = getintfield_default(L, 2, "block_radius", 64);
	size_t limit = getintfield_default(L, 2, "block_radius", 1000);

	return NativeAreaStore::native_set_cache_params(o, &enabled, &block_radius, &limit);
}

// native_to_string()
int LuaAreaStore::l_native_to_string(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	std::string result = NativeAreaStore::native_to_string(o);

	lua_pushlstring(L, result.c_str(), result.length());
	return 1;
}

// native_to_file(filename)
int LuaAreaStore::l_native_to_file(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	const char *filename = luaL_checkstring(L, 2);
	CHECK_SECURE_PATH(L, filename, true);

	bool result = NativeAreaStore::native_to_file(o, filename);

	lua_pushboolean(L, result);
	return 1;
}

// native_from_string(str)
int LuaAreaStore::l_native_from_string(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	size_t len;
	const char *str = luaL_checklstring(L, 2, &len);

	std::tuple<bool, const char*> result = NativeAreaStore::native_from_string(o, str);

	return deserialization_helper_from_native(L, result);
}

// native_from_file(filename)
int LuaAreaStore::l_native_from_file(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	LuaAreaStore *o = checkobject(L, 1);

	const char *filename = luaL_checkstring(L, 2);
	CHECK_SECURE_PATH(L, filename, false);

	std::tuple<bool, const char *> result =
			NativeAreaStore::native_from_file(o, filename);

	return deserialization_helper_from_native(L, result);
}