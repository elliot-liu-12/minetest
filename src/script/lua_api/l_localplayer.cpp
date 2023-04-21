/*
Minetest
Copyright (C) 2017 Dumbeldor, Vincent Glize <vincent.glize@live.fr>

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

#include "l_localplayer.h"
#include "l_internal.h"
#include "lua_api/l_item.h"
#include "script/common/c_converter.h"
#include "client/localplayer.h"
#include "hud.h"
#include "common/c_content.h"
#include "client/content_cao.h"
#include "../native_api/native_localplayer.h"

LuaLocalPlayer::LuaLocalPlayer(LocalPlayer *m) : m_localplayer(m)
{
}

void LuaLocalPlayer::create(lua_State *L, LocalPlayer *m)
{
	lua_getglobal(L, "core");
	luaL_checktype(L, -1, LUA_TTABLE);
	int objectstable = lua_gettop(L);
	lua_getfield(L, -1, "localplayer");

	// Duplication check
	if (lua_type(L, -1) == LUA_TUSERDATA) {
		lua_pop(L, 1);
		return;
	}

	LuaLocalPlayer *o = new LuaLocalPlayer(m);
	*(void **)(lua_newuserdata(L, sizeof(void *))) = o;
	luaL_getmetatable(L, className);
	lua_setmetatable(L, -2);

	lua_pushvalue(L, lua_gettop(L));
	lua_setfield(L, objectstable, "localplayer");
}

int LuaLocalPlayer::l_get_velocity(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	push_v3f(L, player->getSpeed() / BS);
	return 1;
}

int LuaLocalPlayer::l_native_get_velocity(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	v3f vel = NativeLocalPlayer::native_get_velocity(player);

	push_v3f(L, vel / BS);
	return 1;
}


int LuaLocalPlayer::l_get_hp(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushinteger(L, player->hp);
	return 1;
}

int LuaLocalPlayer::l_native_get_hp(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	int hp = NativeLocalPlayer::native_get_hp(player);

	lua_pushinteger(L, hp);
	return 1;
}

int LuaLocalPlayer::l_get_name(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushstring(L, player->getName());
	return 1;
}

int LuaLocalPlayer::l_native_get_name(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	const char *name = NativeLocalPlayer::native_get_name(player);

	lua_pushstring(L, name);
	return 1;
}

// get_wield_index(self)
int LuaLocalPlayer::l_get_wield_index(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushinteger(L, player->getWieldIndex());
	return 1;
}

int LuaLocalPlayer::l_native_get_wield_index(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	u16 wieldIndex = NativeLocalPlayer::native_get_wield_index(player);

	lua_pushinteger(L, wieldIndex);
	return 1;
}


// get_wielded_item(self)
int LuaLocalPlayer::l_get_wielded_item(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	ItemStack selected_item;
	player->getWieldedItem(&selected_item, nullptr);
	LuaItemStack::create(L, selected_item);
	return 1;
}

int LuaLocalPlayer::l_native_get_wielded_item(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	ItemStack item = NativeLocalPlayer::native_get_wielded_item(player);
	LuaItemStack::create(L, item);
	return 1;
}

int LuaLocalPlayer::l_is_attached(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushboolean(L, player->getParent() != nullptr);
	return 1;
}

int LuaLocalPlayer::l_native_is_attached(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	bool result = NativeLocalPlayer::native_is_attached(player);

	lua_pushboolean(L, result);
	return 1;
}

int LuaLocalPlayer::l_is_touching_ground(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushboolean(L, player->touching_ground);
	return 1;
}

int LuaLocalPlayer::l_native_is_touching_ground(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	bool result = NativeLocalPlayer::native_is_touching_ground(player);
	lua_pushboolean(L, result);
	return 1;
}

int LuaLocalPlayer::l_is_in_liquid(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushboolean(L, player->in_liquid);
	return 1;
}

int LuaLocalPlayer::l_native_is_in_liquid(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	bool result = NativeLocalPlayer::native_is_in_liquid(player);

	lua_pushboolean(L, result);
	return 1;
}

int LuaLocalPlayer::l_is_in_liquid_stable(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushboolean(L, player->in_liquid_stable);
	return 1;
}

int LuaLocalPlayer::l_native_is_in_liquid_stable(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	bool result = NativeLocalPlayer::native_is_in_liquid_stable(player);
	lua_pushboolean(L, result);
	return 1;
}

int LuaLocalPlayer::l_get_liquid_viscosity(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushinteger(L, player->liquid_viscosity);
	return 1;
}
int LuaLocalPlayer::l_native_get_liquid_viscosity(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	bool result = NativeLocalPlayer::native_get_liquid_viscosity(player);
	lua_pushinteger(L, result);
	return 1;
}


int LuaLocalPlayer::l_is_climbing(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushboolean(L, player->is_climbing);
	return 1;
}

int LuaLocalPlayer::l_native_is_climbing(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	bool result = NativeLocalPlayer::native_is_climbing(player);

	lua_pushboolean(L, result);
	return 1;
}


int LuaLocalPlayer::l_swimming_vertical(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushboolean(L, player->swimming_vertical);
	return 1;
}

int LuaLocalPlayer::l_native_swimming_vertical(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	bool result = NativeLocalPlayer::native_swimming_vertical(player);
	lua_pushboolean(L, player->swimming_vertical);
	return 1;
}

// get_physics_override(self)
int LuaLocalPlayer::l_get_physics_override(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_newtable(L);
	lua_pushnumber(L, player->physics_override_speed);
	lua_setfield(L, -2, "speed");

	lua_pushnumber(L, player->physics_override_jump);
	lua_setfield(L, -2, "jump");

	lua_pushnumber(L, player->physics_override_gravity);
	lua_setfield(L, -2, "gravity");

	lua_pushboolean(L, player->physics_override_sneak);
	lua_setfield(L, -2, "sneak");

	lua_pushboolean(L, player->physics_override_sneak_glitch);
	lua_setfield(L, -2, "sneak_glitch");

	lua_pushboolean(L, player->physics_override_new_move);
	lua_setfield(L, -2, "new_move");

	return 1;
}

int LuaLocalPlayer::l_native_get_physics_override(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	std::vector<int> PO = NativeLocalPlayer::native_get_physics_override(player);

	lua_newtable(L);
	lua_pushnumber(L, PO[0]);
	lua_setfield(L, -2, "speed");

	lua_pushnumber(L, PO[1]);
	lua_setfield(L, -2, "jump");

	lua_pushnumber(L, PO[2]);
	lua_setfield(L, -2, "gravity");

	lua_pushboolean(L, PO[3]);
	lua_setfield(L, -2, "sneak");

	lua_pushboolean(L, PO[4]);
	lua_setfield(L, -2, "sneak_glitch");

	lua_pushboolean(L, PO[5]);
	lua_setfield(L, -2, "new_move");

	return 1;
}

int LuaLocalPlayer::l_get_last_pos(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	push_v3f(L, player->last_position / BS);
	return 1;
}

int LuaLocalPlayer::l_native_get_last_pos(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	v3f pos = NativeLocalPlayer::native_get_last_pos(player);
	push_v3f(L, pos / BS);
	return 1;
}

int LuaLocalPlayer::l_get_last_velocity(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	push_v3f(L, player->last_speed);
	return 1;
}

int LuaLocalPlayer::l_native_get_last_velocity(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	v3f pos = NativeLocalPlayer::native_get_last_velocity(player);
	push_v3f(L, pos);
	return 1;
}

int LuaLocalPlayer::l_get_last_look_vertical(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushnumber(L, -1.0 * player->last_pitch * core::DEGTORAD);
	return 1;
}

int LuaLocalPlayer::l_native_get_last_look_vertical(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	auto r = NativeLocalPlayer::native_get_last_look_vertical(player);
	lua_pushnumber(L, r);
	return 1;
}

int LuaLocalPlayer::l_get_last_look_horizontal(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushnumber(L, (player->last_yaw + 90.) * core::DEGTORAD);
	return 1;
}

int LuaLocalPlayer::l_native_get_last_look_horizontal(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	auto r = NativeLocalPlayer::native_get_last_look_horizontal(player);
	lua_pushnumber(L, r);
	return 1;
}

// get_control(self)
int LuaLocalPlayer::l_get_control(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	const PlayerControl &c = player->getPlayerControl();

	auto set = [L] (const char *name, bool value) {
		lua_pushboolean(L, value);
		lua_setfield(L, -2, name);
	};

	lua_createtable(L, 0, 12);
	set("up", c.up);
	set("down", c.down);
	set("left", c.left);
	set("right", c.right);
	set("jump", c.jump);
	set("aux1", c.aux1);
	set("sneak", c.sneak);
	set("zoom", c.zoom);
	set("dig", c.dig);
	set("place", c.place);

	return 1;
}

// get_control(self) RETURN
int LuaLocalPlayer::l_native_get_control(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	const PlayerControl &c = NativeLocalPlayer::native_get_control(player);

	auto set = [L](const char *name, bool value) {
		lua_pushboolean(L, value);
		lua_setfield(L, -2, name);
	};

	lua_createtable(L, 0, 12);
	set("up", c.up);
	set("down", c.down);
	set("left", c.left);
	set("right", c.right);
	set("jump", c.jump);
	set("aux1", c.aux1);
	set("sneak", c.sneak);
	set("zoom", c.zoom);
	set("dig", c.dig);
	set("place", c.place);

	return 1;
}

// get_breath(self)
int LuaLocalPlayer::l_get_breath(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_pushinteger(L, player->getBreath());
	return 1;
}

// get_breath(self)
int LuaLocalPlayer::l_native_get_breath(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	int br = NativeLocalPlayer::native_get_breath(player);

	lua_pushinteger(L, br);
	return 1;
}

// get_pos(self)
int LuaLocalPlayer::l_get_pos(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	push_v3f(L, player->getPosition() / BS);
	return 1;
}

int LuaLocalPlayer::l_native_get_pos(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	v3f pos = NativeLocalPlayer::native_get_pos(player);

	push_v3f(L, pos / BS);
	return 1;
}

// get_movement_acceleration(self)
int LuaLocalPlayer::l_get_movement_acceleration(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_newtable(L);
	lua_pushnumber(L, player->movement_acceleration_default);
	lua_setfield(L, -2, "default");

	lua_pushnumber(L, player->movement_acceleration_air);
	lua_setfield(L, -2, "air");

	lua_pushnumber(L, player->movement_acceleration_fast);
	lua_setfield(L, -2, "fast");

	return 1;
}

int LuaLocalPlayer::l_native_get_movement_acceleration(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	std::vector<float> mA = NativeLocalPlayer::native_get_movement_acceleration(player);

	lua_newtable(L);
	lua_pushnumber(L, mA[0]);
	lua_setfield(L, -2, "default");

	lua_pushnumber(L, mA[1]);
	lua_setfield(L, -2, "air");

	lua_pushnumber(L, mA[2]);
	lua_setfield(L, -2, "fast");

	return 1;
}

// get_movement_speed(self)
int LuaLocalPlayer::l_get_movement_speed(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_newtable(L);
	lua_pushnumber(L, player->movement_speed_walk);
	lua_setfield(L, -2, "walk");

	lua_pushnumber(L, player->movement_speed_crouch);
	lua_setfield(L, -2, "crouch");

	lua_pushnumber(L, player->movement_speed_fast);
	lua_setfield(L, -2, "fast");

	lua_pushnumber(L, player->movement_speed_climb);
	lua_setfield(L, -2, "climb");

	lua_pushnumber(L, player->movement_speed_jump);
	lua_setfield(L, -2, "jump");

	return 1;
}

int LuaLocalPlayer::l_native_get_movement_speed(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	std::vector<float> ms = NativeLocalPlayer::native_get_movement_speed(player);

	lua_newtable(L);
	lua_pushnumber(L, ms[0]);
	lua_setfield(L, -2, "walk");

	lua_pushnumber(L, ms[1]);
	lua_setfield(L, -2, "crouch");

	lua_pushnumber(L, ms[2]);
	lua_setfield(L, -2, "fast");

	lua_pushnumber(L, ms[3]);
	lua_setfield(L, -2, "climb");

	lua_pushnumber(L, ms[4]);
	lua_setfield(L, -2, "jump");

	return 1;
}



// get_movement(self)
int LuaLocalPlayer::l_get_movement(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	lua_newtable(L);

	lua_pushnumber(L, player->movement_liquid_fluidity);
	lua_setfield(L, -2, "liquid_fluidity");

	lua_pushnumber(L, player->movement_liquid_fluidity_smooth);
	lua_setfield(L, -2, "liquid_fluidity_smooth");

	lua_pushnumber(L, player->movement_liquid_sink);
	lua_setfield(L, -2, "liquid_sink");

	lua_pushnumber(L, player->movement_gravity);
	lua_setfield(L, -2, "gravity");

	return 1;
}

int LuaLocalPlayer::l_native_get_movement(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	std::vector<float> m = NativeLocalPlayer::native_get_movement(player);

	lua_newtable(L);

	lua_pushnumber(L, m[0]);
	lua_setfield(L, -2, "liquid_fluidity");

	lua_pushnumber(L, m[1]);
	lua_setfield(L, -2, "liquid_fluidity_smooth");

	lua_pushnumber(L, m[2]);
	lua_setfield(L, -2, "liquid_sink");

	lua_pushnumber(L, m[3]);
	lua_setfield(L, -2, "gravity");

	return 1;
}


// get_armor_groups(self)
int LuaLocalPlayer::l_get_armor_groups(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	push_groups(L, player->getCAO()->getGroups());
	return 1;
}

int LuaLocalPlayer::l_native_get_armor_groups(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	ItemGroupList ig = NativeLocalPlayer::native_get_armour_groups(player);
	push_groups(L, ig);
	return 1;
}

// hud_add(self, form)
int LuaLocalPlayer::l_hud_add(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	HudElement *elem = new HudElement;
	read_hud_element(L, elem);

	u32 id = player->addHud(elem);
	if (id == U32_MAX) {
		delete elem;
		return 0;
	}
	lua_pushnumber(L, id);
	return 1;
}

int LuaLocalPlayer::l_native_hud_add(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	HudElement *elem = new HudElement;
	read_hud_element(L, elem);

	u32 id = NativeLocalPlayer::native_hud_add(player, elem);

	if (id == U32_MAX) {
		delete elem;
		return 0;
	}
	lua_pushnumber(L, id);
	return 1;
}

// hud_remove(self, id)
int LuaLocalPlayer::l_hud_remove(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	u32 id = luaL_checkinteger(L, 2);
	HudElement *element = player->removeHud(id);
	if (!element)
		lua_pushboolean(L, false);
	else
		lua_pushboolean(L, true);
	delete element;
	return 1;
}

int LuaLocalPlayer::l_native_hud_remove(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);
	u32 id = luaL_checkinteger(L, 2);
	HudElement *element  = NativeLocalPlayer::native_hud_remove(player, id);

	if (!element)
		lua_pushboolean(L, false);
	else
		lua_pushboolean(L, true);
	delete element;
	return 1;
}

// hud_change(self, id, stat, data)
int LuaLocalPlayer::l_hud_change(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	u32 id = luaL_checkinteger(L, 2);

	HudElement *element = player->getHud(id);
	if (!element)
		return 0;

	void *unused;
	read_hud_change(L, element, &unused);

	lua_pushboolean(L, true);
	return 1;
}

int LuaLocalPlayer::l_native_hud_change(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	u32 id = luaL_checkinteger(L, 2);

	HudElement *element = NativeLocalPlayer::native_hud_change(player, id);

	if (!element)
		return 0;

	void *unused;
	read_hud_change(L, element, &unused);

	lua_pushboolean(L, true);
	return 1;
}

// hud_get(self, id)
int LuaLocalPlayer::l_hud_get(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	u32 id = luaL_checkinteger(L, -1);

	HudElement *e = player->getHud(id);
	if (!e) {
		lua_pushnil(L);
		return 1;
	}

	push_hud_element(L, e);
	return 1;
}

int LuaLocalPlayer::l_native_hud_get(lua_State *L)
{
	LocalPlayer *player = getobject(L, 1);

	u32 id = luaL_checkinteger(L, -1);

	HudElement *e = NativeLocalPlayer::native_hud_get(player,id);
	if(!e){
		lua_pushnil(L);
		return 1;
	}

	push_hud_element(L, e);
	return 1;
}

LuaLocalPlayer *LuaLocalPlayer::checkobject(lua_State *L, int narg)
{
	luaL_checktype(L, narg, LUA_TUSERDATA);

	void *ud = luaL_checkudata(L, narg, className);
	if (!ud)
		luaL_typerror(L, narg, className);

	return *(LuaLocalPlayer **)ud;
}

LocalPlayer *LuaLocalPlayer::getobject(LuaLocalPlayer *ref)
{
	return ref->m_localplayer;
}

LocalPlayer *LuaLocalPlayer::getobject(lua_State *L, int narg)
{
	LuaLocalPlayer *ref = checkobject(L, narg);
	assert(ref);
	LocalPlayer *player = getobject(ref);
	assert(player);
	return player;
}

int LuaLocalPlayer::gc_object(lua_State *L)
{
	LuaLocalPlayer *o = *(LuaLocalPlayer **)(lua_touserdata(L, 1));
	delete o;
	return 0;
}

void LuaLocalPlayer::Register(lua_State *L)
{
	lua_newtable(L);
	int methodtable = lua_gettop(L);
	luaL_newmetatable(L, className);
	int metatable = lua_gettop(L);

	lua_pushliteral(L, "__metatable");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable); // hide metatable from lua getmetatable()

	lua_pushliteral(L, "__index");
	lua_pushvalue(L, methodtable);
	lua_settable(L, metatable);

	lua_pushliteral(L, "__gc");
	lua_pushcfunction(L, gc_object);
	lua_settable(L, metatable);

	lua_pop(L, 1); // Drop metatable

	luaL_openlib(L, 0, methods, 0); // fill methodtable
	lua_pop(L, 1);			// Drop methodtable
}

const char LuaLocalPlayer::className[] = "LocalPlayer";
const luaL_Reg LuaLocalPlayer::methods[] = {
		luamethod(LuaLocalPlayer, get_velocity),
		luamethod(LuaLocalPlayer, native_get_velocity),
		luamethod(LuaLocalPlayer, get_hp), 
		luamethod(LuaLocalPlayer, native_get_hp),
		luamethod(LuaLocalPlayer, get_name), 
		luamethod(LuaLocalPlayer, native_get_name),
		luamethod(LuaLocalPlayer, get_wield_index),
		luamethod(LuaLocalPlayer, native_get_wield_index),
		luamethod(LuaLocalPlayer, get_wielded_item),
		luamethod(LuaLocalPlayer, native_get_wielded_item),
		luamethod(LuaLocalPlayer, is_attached),
		luamethod(LuaLocalPlayer, native_is_attached),
		luamethod(LuaLocalPlayer, is_touching_ground),
		luamethod(LuaLocalPlayer, native_is_touching_ground),
		luamethod(LuaLocalPlayer, is_in_liquid),
		luamethod(LuaLocalPlayer, native_is_in_liquid),
		luamethod(LuaLocalPlayer, is_in_liquid_stable),
		luamethod(LuaLocalPlayer, native_is_in_liquid_stable),
		luamethod(LuaLocalPlayer, get_liquid_viscosity),
		luamethod(LuaLocalPlayer, native_get_liquid_viscosity),
		luamethod(LuaLocalPlayer, is_climbing),
		luamethod(LuaLocalPlayer, native_is_climbing),
		luamethod(LuaLocalPlayer, swimming_vertical),
		luamethod(LuaLocalPlayer, native_swimming_vertical),
		luamethod(LuaLocalPlayer, get_physics_override),
		luamethod(LuaLocalPlayer, native_get_physics_override),
		// TODO: figure our if these are useful in any way
		luamethod(LuaLocalPlayer, get_last_pos),
		luamethod(LuaLocalPlayer, native_get_last_pos),
		luamethod(LuaLocalPlayer, get_last_velocity),
		luamethod(LuaLocalPlayer, native_get_last_velocity),
		luamethod(LuaLocalPlayer, get_last_look_horizontal),
		luamethod(LuaLocalPlayer, native_get_last_look_horizontal),
		luamethod(LuaLocalPlayer, get_last_look_vertical),
		luamethod(LuaLocalPlayer, native_get_last_look_vertical),
		//
		luamethod(LuaLocalPlayer, get_control),
		luamethod(LuaLocalPlayer, native_get_control),
		luamethod(LuaLocalPlayer, get_breath),
		luamethod(LuaLocalPlayer, native_get_breath),
		luamethod(LuaLocalPlayer, get_pos), 
		luamethod(LuaLocalPlayer, native_get_pos),
		luamethod(LuaLocalPlayer, get_movement_acceleration),
		luamethod(LuaLocalPlayer, native_get_movement_acceleration),
		luamethod(LuaLocalPlayer, get_movement_speed),
		luamethod(LuaLocalPlayer, native_get_movement_speed),
		luamethod(LuaLocalPlayer, get_movement),
		luamethod(LuaLocalPlayer, native_get_movement),
		luamethod(LuaLocalPlayer, get_armor_groups),
		luamethod(LuaLocalPlayer, native_get_armor_groups),
		luamethod(LuaLocalPlayer, hud_add), 
		luamethod(LuaLocalPlayer, native_hud_add),
		luamethod(LuaLocalPlayer, hud_remove),
		luamethod(LuaLocalPlayer, native_hud_remove),
		luamethod(LuaLocalPlayer, hud_change),
		luamethod(LuaLocalPlayer, native_hud_change),
		luamethod(LuaLocalPlayer, hud_get), 
		luamethod(LuaLocalPlayer, native_hud_get),

		{0, 0}
};
