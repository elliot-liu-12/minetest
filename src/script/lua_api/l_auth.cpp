/*
Minetest
Copyright (C) 2018 bendeutsch, Ben Deutsch <ben@bendeutsch.de>

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

#include "lua_api/l_auth.h"
#include "lua_api/l_internal.h"
#include "common/c_converter.h"
#include "common/c_content.h"
#include "cpp_api/s_base.h"
#include "server.h"
#include "environment.h"
#include "database/database.h"
#include <algorithm>
#include "../native_api/native_auth.h"

// common start: ensure auth db
AuthDatabase *ModApiAuth::getAuthDb(lua_State *L)
{
	ServerEnvironment *server_environment =
			dynamic_cast<ServerEnvironment *>(getEnv(L));
	if (!server_environment)
		return nullptr;
	return server_environment->getAuthDatabase();
}

void ModApiAuth::pushAuthEntry(lua_State *L, const AuthEntry &authEntry)
{
	lua_newtable(L);
	int table = lua_gettop(L);
	// id
	lua_pushnumber(L, authEntry.id);
	lua_setfield(L, table, "id");
	// name
	lua_pushstring(L, authEntry.name.c_str());
	lua_setfield(L, table, "name");
	// password
	lua_pushstring(L, authEntry.password.c_str());
	lua_setfield(L, table, "password");
	// privileges
	lua_newtable(L);
	int privtable = lua_gettop(L);
	for (const std::string &privs : authEntry.privileges) {
		lua_pushboolean(L, true);
		lua_setfield(L, privtable, privs.c_str());
	}
	lua_setfield(L, table, "privileges");
	// last_login
	lua_pushnumber(L, authEntry.last_login);
	lua_setfield(L, table, "last_login");

	lua_pushvalue(L, table);
}

// auth_read(name)
int ModApiAuth::l_auth_read(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	AuthEntry authEntry;
	const char *name = luaL_checkstring(L, 1);
	bool success = auth_db->getAuth(std::string(name), authEntry);
	if (!success)
		return 0;

	pushAuthEntry(L, authEntry);
	return 1;
}

// auth_save(table)
int ModApiAuth::l_auth_save(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	luaL_checktype(L, 1, LUA_TTABLE);
	int table = 1;
	AuthEntry authEntry;
	bool success;
	success = getintfield(L, table, "id", authEntry.id);
	success = success && getstringfield(L, table, "name", authEntry.name);
	success = success && getstringfield(L, table, "password", authEntry.password);
	lua_getfield(L, table, "privileges");
	if (lua_istable(L, -1)) {
		lua_pushnil(L);
		while (lua_next(L, -2)) {
			authEntry.privileges.emplace_back(
					lua_tostring(L, -2)); // the key, not the value
			lua_pop(L, 1);
		}
	} else {
		success = false;
	}
	lua_pop(L, 1); // the table
	success = success && getintfield(L, table, "last_login", authEntry.last_login);

	if (!success) {
		lua_pushboolean(L, false);
		return 1;
	}

	lua_pushboolean(L, auth_db->saveAuth(authEntry));
	return 1;
}

// auth_create(table)
int ModApiAuth::l_auth_create(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	luaL_checktype(L, 1, LUA_TTABLE);
	int table = 1;
	AuthEntry authEntry;
	bool success;
	// no meaningful id field, we assume
	success = getstringfield(L, table, "name", authEntry.name);
	success = success && getstringfield(L, table, "password", authEntry.password);
	lua_getfield(L, table, "privileges");
	if (lua_istable(L, -1)) {
		lua_pushnil(L);
		while (lua_next(L, -2)) {
			authEntry.privileges.emplace_back(
					lua_tostring(L, -2)); // the key, not the value
			lua_pop(L, 1);
		}
	} else {
		success = false;
	}
	lua_pop(L, 1); // the table
	success = success && getintfield(L, table, "last_login", authEntry.last_login);

	if (!success)
		return 0;

	if (auth_db->createAuth(authEntry)) {
		pushAuthEntry(L, authEntry);
		return 1;
	}

	return 0;
}

// auth_delete(name)
int ModApiAuth::l_auth_delete(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	std::string name(luaL_checkstring(L, 1));
	lua_pushboolean(L, auth_db->deleteAuth(name));
	return 1;
}

// auth_list_names()
int ModApiAuth::l_auth_list_names(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	std::vector<std::string> names;
	auth_db->listNames(names);
	lua_createtable(L, names.size(), 0);
	int table = lua_gettop(L);
	int i = 1;
	for (const std::string &name : names) {
		lua_pushstring(L, name.c_str());
		lua_rawseti(L, table, i++);
	}
	return 1;
}

// auth_reload()
int ModApiAuth::l_auth_reload(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (auth_db)
		auth_db->reload();
	return 0;
}

void ModApiAuth::Initialize(lua_State *L, int top)
{

	lua_newtable(L);
	int auth_top = lua_gettop(L);

	registerFunction(L, "read", l_auth_read, auth_top);
	registerFunction(L, "save", l_auth_save, auth_top);
	registerFunction(L, "create", l_auth_create, auth_top);
	registerFunction(L, "delete", l_auth_delete, auth_top);
	registerFunction(L, "list_names", l_auth_list_names, auth_top);
	registerFunction(L, "reload", l_auth_reload, auth_top);

	registerFunction(L, "native_read", l_native_auth_read, auth_top);
	registerFunction(L, "native_save", l_native_auth_save, auth_top);
	registerFunction(L, "native_create", l_native_auth_create, auth_top);
	registerFunction(L, "native_delete", l_native_auth_delete, auth_top);
	registerFunction(L, "native_list_names", l_native_auth_list_names, auth_top);
	registerFunction(L, "native_reload", l_native_auth_reload, auth_top);

	lua_setfield(L, top, "auth");
}

// native_auth_read(name)
int ModApiAuth::l_native_auth_read(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	AuthEntry authEntry;
	const char *name = luaL_checkstring(L, 1);
	if (NativeModApiAuth::native_auth_read(authEntry, auth_db, name))
		pushAuthEntry(L, authEntry);
		return 1;
	return 0;
}

// native_auth_save(table)
int ModApiAuth::l_native_auth_save(lua_State *L)
{
	//loads auth entry from stack
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	luaL_checktype(L, 1, LUA_TTABLE);
	int table = 1;
	AuthEntry authEntry;
	bool fields[5] = {};
	fields[0] = getintfield(L, table, "id", authEntry.id);
	fields[1] = getstringfield(L, table, "name", authEntry.name);
	fields[2] = getstringfield(L, table, "password", authEntry.password);
	lua_getfield(L, table, "privileges");
	if (lua_istable(L, -1)) {
		lua_pushnil(L);
		while (lua_next(L, -2)) {
			authEntry.privileges.emplace_back(
					lua_tostring(L, -2)); // the key, not the value
			lua_pop(L, 1);
		}
	} else {
		fields[3] = false;
	}
	lua_pop(L, 1); // the table
	fields[4] = getintfield(L, table, "last_login", authEntry.last_login);

	//saves entry in db
	lua_pushboolean(L, NativeModApiAuth::native_auth_save(authEntry, auth_db, fields));
	return 1;
}

// native_auth_create(table)
int ModApiAuth::l_native_auth_create(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	luaL_checktype(L, 1, LUA_TTABLE);
	int table = 1;
	AuthEntry authEntry;
	bool fields[4] = {};
	// no meaningful id field, we assume
	fields[0] = getstringfield(L, table, "name", authEntry.name);
	fields[1] = getstringfield(L, table, "password", authEntry.password);
	lua_getfield(L, table, "privileges");
	if (lua_istable(L, -1)) {
		lua_pushnil(L);
		while (lua_next(L, -2)) {
			authEntry.privileges.emplace_back(
					lua_tostring(L, -2)); // the key, not the value
			lua_pop(L, 1);
		}
	} else {
		fields[2] = false;
	}
	lua_pop(L, 1); // the table
	fields[3] = getintfield(L, table, "last_login", authEntry.last_login);

	if (NativeModApiAuth::native_auth_create(authEntry, auth_db, fields)) {
		pushAuthEntry(L, authEntry);
		return 1;
	}
	return 0;
}

// native_auth_delete(name)
int ModApiAuth::l_native_auth_delete(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	std::string name(luaL_checkstring(L, 1));
	lua_pushboolean(L, NativeModApiAuth::native_auth_delete(auth_db, name));
	return 1;
}

// native_auth_list_names()
int ModApiAuth::l_native_auth_list_names(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	AuthDatabase *auth_db = getAuthDb(L);
	if (!auth_db)
		return 0;
	std::vector<std::string> names = NativeModApiAuth::native_auth_list_names(auth_db);
	lua_createtable(L, names.size(), 0);
	int table = lua_gettop(L);
	int i = 1;
	for (const std::string &name : names) {
		lua_pushstring(L, name.c_str());
		lua_rawseti(L, table, i++);
	}
	return 1;
}

// native_auth_reload()
int ModApiAuth::l_native_auth_reload(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;
	NativeModApiAuth::native_auth_reload(getAuthDb(L));
	return 0;
}