/*
Minetest
Copyright (C) 2013 PilzAdam <pilzadam@minetest.net>

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

#include "lua_api/l_settings.h"
#include "lua_api/l_internal.h"
#include "cpp_api/s_security.h"
#include "util/string.h" // FlagDesc
#include "settings.h"
#include "noise.h"
#include "log.h"
#include "../native_api/native_settings.h"


#define SET_SECURITY_CHECK(L, name) \
	if (o->m_settings == g_settings && ScriptApiSecurity::isSecure(L) && \
			name.compare(0, 7, "secure.") == 0) { \
		throw LuaError("Attempt to set secure setting."); \
	}

LuaSettings::LuaSettings(Settings *settings, const std::string &filename) :
	m_settings(settings),
	m_filename(filename)
{
}

LuaSettings::LuaSettings(const std::string &filename, bool write_allowed) :
	m_filename(filename),
	m_is_own_settings(true),
	m_write_allowed(write_allowed)
{
	m_settings = new Settings();
	m_settings->readConfigFile(filename.c_str());
}

LuaSettings::~LuaSettings()
{
	if (m_is_own_settings)
		delete m_settings;
}


void LuaSettings::create(lua_State *L, Settings *settings,
		const std::string &filename)
{
	LuaSettings *o = new LuaSettings(settings, filename);
	*(void **)(lua_newuserdata(L, sizeof(void *))) = o;
	luaL_getmetatable(L, className);
	lua_setmetatable(L, -2);
}


// garbage collector
int LuaSettings::gc_object(lua_State* L)
{
	LuaSettings* o = *(LuaSettings **)(lua_touserdata(L, 1));
	delete o;
	return 0;
}


// get(self, key) -> value
int LuaSettings::l_get(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	if (o->m_settings->exists(key)) {
		std::string value = o->m_settings->get(key);
		lua_pushstring(L, value.c_str());
	} else {
		lua_pushnil(L);
	}

	return 1;
}

int LuaSettings::l_native_get(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	Settings *s = o->m_settings;

	std::string key = std::string(luaL_checkstring(L, 2));
	std::string res = NativeSettings::native_get(o, key);

	if (res == "") {
		lua_pushnil(L);
	} else {
		lua_pushstring(L, res.c_str());
	}

	return 1;
}

// get_bool(self, key) -> boolean
int LuaSettings::l_get_bool(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	if (o->m_settings->exists(key)) {
		bool value = o->m_settings->getBool(key);
		lua_pushboolean(L, value);
	} else {
		// Push default value
		if (lua_isboolean(L, 3))
			lua_pushboolean(L, readParam<bool>(L, 3));
		else
			lua_pushnil(L);
	}

	return 1;
}

int LuaSettings::l_native_get_bool(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	if (o->m_settings->exists(key)) {
		bool value = NativeSettings::native_get_bool(o, key);
		lua_pushboolean(L, value);
	} else {
		// Push default value
		if (lua_isboolean(L, 3))
			lua_pushboolean(L, readParam<bool>(L, 3));
		else
			lua_pushnil(L);
	}

	return 1;
}

// get_np_group(self, key) -> value
int LuaSettings::l_get_np_group(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	if (o->m_settings->exists(key)) {
		NoiseParams np;
		o->m_settings->getNoiseParams(key, np);
		push_noiseparams(L, &np);
	} else {
		lua_pushnil(L);
	}

	return 1;
}

int LuaSettings::l_native_get_np_group(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	if (o->m_settings->exists(key)) {
		NoiseParams np;
		NativeSettings::native_get_np_group(o, key, np);
		push_noiseparams(L, &np);
	} else {
		lua_pushnil(L);
	}

	return 1;
}

int LuaSettings::l_get_flags(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);
	std::string key = std::string(luaL_checkstring(L, 2));

	u32 flags = 0;
	auto flagdesc = o->m_settings->getFlagDescFallback(key);
	if (o->m_settings->getFlagStrNoEx(key, flags, flagdesc)) {
		lua_newtable(L);
		int table = lua_gettop(L);
		for (size_t i = 0; flagdesc[i].name; ++i) {
			lua_pushboolean(L, flags & flagdesc[i].flag);
			lua_setfield(L, table, flagdesc[i].name);
		}
		lua_pushvalue(L, table);
	} else {
		lua_pushnil(L);
	}

	return 1;
}

// set(self, key, value)
int LuaSettings::l_set(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	const char* value = luaL_checkstring(L, 3);

	SET_SECURITY_CHECK(L, key);

	if (!o->m_settings->set(key, value))
		throw LuaError("Invalid sequence found in setting parameters");

	return 0;
}

int LuaSettings::l_native_set(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	const char *value = luaL_checkstring(L, 3);

	SET_SECURITY_CHECK(L, key);

	NativeSettings::native_set(o, key, value);

	return 0;
}

// set_bool(self, key, value)
int LuaSettings::l_set_bool(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	bool value = readParam<bool>(L, 3);

	SET_SECURITY_CHECK(L, key);

	o->m_settings->setBool(key, value);

	return 1;
}

int LuaSettings::l_native_set_bool(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	bool value = readParam<bool>(L, 3);

	SET_SECURITY_CHECK(L, key);

	bool b = NativeSettings::native_set_bool(o,key,value);

	return 1;
}

// set(self, key, value)
int LuaSettings::l_set_np_group(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	NoiseParams value;
	read_noiseparams(L, 3, &value);

	SET_SECURITY_CHECK(L, key);

	o->m_settings->setNoiseParams(key, value);

	return 0;
}

int LuaSettings::l_native_set_np_group(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));
	NoiseParams value;
	read_noiseparams(L, 3, &value);

	SET_SECURITY_CHECK(L, key);

	NativeSettings::native_set_np_group(o, key, value);

	return 0;
}

// remove(self, key) -> success
int LuaSettings::l_remove(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));

	SET_SECURITY_CHECK(L, key);

	bool success = o->m_settings->remove(key);
	lua_pushboolean(L, success);

	return 1;
}

// remove(self, key) -> success
int LuaSettings::l_native_remove(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::string key = std::string(luaL_checkstring(L, 2));

	SET_SECURITY_CHECK(L, key);

	bool success = NativeSettings::native_remove(o,key);
	lua_pushboolean(L, success);

	return 1;
}


// get_names(self) -> {key1, ...}
int LuaSettings::l_get_names(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::vector<std::string> keys = o->m_settings->getNames();

	lua_newtable(L);
	for (unsigned int i=0; i < keys.size(); i++)
	{
		lua_pushstring(L, keys[i].c_str());
		lua_rawseti(L, -2, i + 1);
	}

	return 1;
}

// get_names(self) -> {key1, ...}
int LuaSettings::l_native_get_names(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::vector<std::string> keys = NativeSettings::native_get_names(o);

	lua_newtable(L);
	for (unsigned int i = 0; i < keys.size(); i++) {
		lua_pushstring(L, keys[i].c_str());
		lua_rawseti(L, -2, i + 1);
	}

	return 1;
}

// write(self) -> success
int LuaSettings::l_write(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	if (!o->m_write_allowed) {
		throw LuaError("Settings: writing " + o->m_filename +
				" not allowed with mod security on.");
	}

	bool success = o->m_settings->updateConfigFile(o->m_filename.c_str());
	lua_pushboolean(L, success);

	return 1;
}

int LuaSettings::l_native_write(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	bool success = NativeSettings::native_write(o);
	lua_pushboolean(L, success);

	return 1;
}
// to_table(self) -> {[key1]=value1,...}
int LuaSettings::l_to_table(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings* o = checkobject(L, 1);

	std::vector<std::string> keys = o->m_settings->getNames();

	lua_newtable(L);
	for (const std::string &key : keys) {
		lua_pushstring(L, o->m_settings->get(key).c_str());
		lua_setfield(L, -2, key.c_str());
	}

	return 1;
}

int LuaSettings::l_native_to_table(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	LuaSettings *o = checkobject(L, 1);

	std::vector<std::string> keys = NativeSettings::native_to_table(o);

	lua_newtable(L);
	for (const std::string &key : keys) {
		lua_pushstring(L, o->m_settings->get(key).c_str());
		lua_setfield(L, -2, key.c_str());
	}

	return 1;
}

Settings* LuaSettings::l_getSettings()
{
	return m_settings;
}

std::string LuaSettings::l_getFilename()
{
	return m_filename;
}


bool LuaSettings::l_getWriteAllowed()
{
	return m_write_allowed;
}



void LuaSettings::Register(lua_State* L)
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

	// Can be created from Lua (Settings(filename))
	lua_register(L, className, create_object);
}

// LuaSettings(filename)
// Creates a LuaSettings and leaves it on top of the stack
int LuaSettings::create_object(lua_State* L)
{
	NO_MAP_LOCK_REQUIRED;
	bool write_allowed = true;
	const char* filename = luaL_checkstring(L, 1);
	CHECK_SECURE_PATH_POSSIBLE_WRITE(L, filename, &write_allowed);
	LuaSettings* o = new LuaSettings(filename, write_allowed);
	*(void **)(lua_newuserdata(L, sizeof(void *))) = o;
	luaL_getmetatable(L, className);
	lua_setmetatable(L, -2);
	return 1;
}

LuaSettings* LuaSettings::checkobject(lua_State* L, int narg)
{
	NO_MAP_LOCK_REQUIRED;
	luaL_checktype(L, narg, LUA_TUSERDATA);
	void *ud = luaL_checkudata(L, narg, className);
	if (!ud)
		luaL_typerror(L, narg, className);
	return *(LuaSettings**) ud;  // unbox pointer
}

const char LuaSettings::className[] = "Settings";
const luaL_Reg LuaSettings::methods[] = {
	luamethod(LuaSettings, get),
	luamethod(LuaSettings, native_get),
	luamethod(LuaSettings, get_bool),
	luamethod(LuaSettings, native_get_bool),
	luamethod(LuaSettings, get_np_group),
	luamethod(LuaSettings, native_get_np_group),
	luamethod(LuaSettings, get_flags),
	luamethod(LuaSettings, set),
	luamethod(LuaSettings, native_set),
	luamethod(LuaSettings, set_bool),
	luamethod(LuaSettings, native_set_bool),
	luamethod(LuaSettings, set_np_group),
	luamethod(LuaSettings, native_set_np_group),
	luamethod(LuaSettings, remove),
	luamethod(LuaSettings, native_remove),
	luamethod(LuaSettings, get_names),
	luamethod(LuaSettings, native_get_names),
	luamethod(LuaSettings, write),
	luamethod(LuaSettings, native_write),
	luamethod(LuaSettings, to_table),
	luamethod(LuaSettings, native_to_table),
	{0,0}
};
