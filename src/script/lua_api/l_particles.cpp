/*
Minetest
Copyright (C) 2013 celeron55, Perttu Ahola <celeron55@gmail.com>

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

#include "lua_api/l_particles.h"
#include "lua_api/l_object.h"
#include "lua_api/l_internal.h"
#include "common/c_converter.h"
#include "common/c_content.h"
#include "server.h"
#include "particles.h"
#include "../native_api/native_particles.h"

// add_particle({pos=, velocity=, acceleration=, expirationtime=,
//     size=, collisiondetection=, collision_removal=, object_collision=,
//     vertical=, texture=, player=})
// pos/velocity/acceleration = {x=num, y=num, z=num}
// expirationtime = num (seconds)
// size = num
// collisiondetection = bool
// collision_removal = bool
// object_collision = bool
// vertical = bool
// texture = e.g."default_wood.png"
// animation = TileAnimation definition
// glow = num
int ModApiParticles::l_add_particle(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	// Get parameters
	struct ParticleParameters p;
	std::string playername;

	if (lua_gettop(L) > 1) // deprecated
	{
		log_deprecated(L, "Deprecated add_particle call with "
			"individual parameters instead of definition");
		p.pos = check_v3f(L, 1);
		p.vel = check_v3f(L, 2);
		p.acc = check_v3f(L, 3);
		p.expirationtime = luaL_checknumber(L, 4);
		p.size = luaL_checknumber(L, 5);
		p.collisiondetection = readParam<bool>(L, 6);
		p.texture = luaL_checkstring(L, 7);
		if (lua_gettop(L) == 8) // only spawn for a single player
			playername = luaL_checkstring(L, 8);
	}
	else if (lua_istable(L, 1))
	{
		lua_getfield(L, 1, "pos");
		if (lua_istable(L, -1))
			p.pos = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "vel");
		if (lua_istable(L, -1)) {
			p.vel = check_v3f(L, -1);
			log_deprecated(L, "The use of vel is deprecated. "
				"Use velocity instead");
		}
		lua_pop(L, 1);

		lua_getfield(L, 1, "velocity");
		if (lua_istable(L, -1))
			p.vel = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "acc");
		if (lua_istable(L, -1)) {
			p.acc = check_v3f(L, -1);
			log_deprecated(L, "The use of acc is deprecated. "
				"Use acceleration instead");
		}
		lua_pop(L, 1);

		lua_getfield(L, 1, "acceleration");
		if (lua_istable(L, -1))
			p.acc = check_v3f(L, -1);
		lua_pop(L, 1);

		p.expirationtime = getfloatfield_default(L, 1, "expirationtime",
			p.expirationtime);
		p.size = getfloatfield_default(L, 1, "size", p.size);
		p.collisiondetection = getboolfield_default(L, 1,
			"collisiondetection", p.collisiondetection);
		p.collision_removal = getboolfield_default(L, 1,
			"collision_removal", p.collision_removal);
		p.object_collision = getboolfield_default(L, 1,
			"object_collision", p.object_collision);
		p.vertical = getboolfield_default(L, 1, "vertical", p.vertical);

		lua_getfield(L, 1, "animation");
		p.animation = read_animation_definition(L, -1);
		lua_pop(L, 1);

		p.texture = getstringfield_default(L, 1, "texture", p.texture);
		p.glow = getintfield_default(L, 1, "glow", p.glow);

		lua_getfield(L, 1, "node");
		if (lua_istable(L, -1))
			p.node = readnode(L, -1, getGameDef(L)->ndef());
		lua_pop(L, 1);

		p.node_tile = getintfield_default(L, 1, "node_tile", p.node_tile);

		playername = getstringfield_default(L, 1, "playername", "");
	}

	getServer(L)->spawnParticle(playername, p);
	return 1;
}

// add_particlespawner({amount=, time=,
//				minpos=, maxpos=,
//				minvel=, maxvel=,
//				minacc=, maxacc=,
//				minexptime=, maxexptime=,
//				minsize=, maxsize=,
//				collisiondetection=,
//				collision_removal=,
//				object_collision=,
//				vertical=,
//				texture=,
//				player=})
// minpos/maxpos/minvel/maxvel/minacc/maxacc = {x=num, y=num, z=num}
// minexptime/maxexptime = num (seconds)
// minsize/maxsize = num
// collisiondetection = bool
// collision_removal = bool
// object_collision = bool
// vertical = bool
// texture = e.g."default_wood.png"
// animation = TileAnimation definition
// glow = num
int ModApiParticles::l_add_particlespawner(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	// Get parameters
	ParticleSpawnerParameters p;
	ServerActiveObject *attached = NULL;
	std::string playername;

	if (lua_gettop(L) > 1) //deprecated
	{
		log_deprecated(L, "Deprecated add_particlespawner call with "
			"individual parameters instead of definition");
		p.amount = luaL_checknumber(L, 1);
		p.time = luaL_checknumber(L, 2);
		p.minpos = check_v3f(L, 3);
		p.maxpos = check_v3f(L, 4);
		p.minvel = check_v3f(L, 5);
		p.maxvel = check_v3f(L, 6);
		p.minacc = check_v3f(L, 7);
		p.maxacc = check_v3f(L, 8);
		p.minexptime = luaL_checknumber(L, 9);
		p.maxexptime = luaL_checknumber(L, 10);
		p.minsize = luaL_checknumber(L, 11);
		p.maxsize = luaL_checknumber(L, 12);
		p.collisiondetection = readParam<bool>(L, 13);
		p.texture = luaL_checkstring(L, 14);
		if (lua_gettop(L) == 15) // only spawn for a single player
			playername = luaL_checkstring(L, 15);
	}
	else if (lua_istable(L, 1))
	{
		p.amount = getintfield_default(L, 1, "amount", p.amount);
		p.time = getfloatfield_default(L, 1, "time", p.time);

		lua_getfield(L, 1, "minpos");
		if (lua_istable(L, -1))
			p.minpos = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "maxpos");
		if (lua_istable(L, -1))
			p.maxpos = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "minvel");
		if (lua_istable(L, -1))
			p.minvel = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "maxvel");
		if (lua_istable(L, -1))
			p.maxvel = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "minacc");
		if (lua_istable(L, -1))
			p.minacc = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "maxacc");
		if (lua_istable(L, -1))
			p.maxacc = check_v3f(L, -1);
		lua_pop(L, 1);

		p.minexptime = getfloatfield_default(L, 1, "minexptime", p.minexptime);
		p.maxexptime = getfloatfield_default(L, 1, "maxexptime", p.maxexptime);
		p.minsize = getfloatfield_default(L, 1, "minsize", p.minsize);
		p.maxsize = getfloatfield_default(L, 1, "maxsize", p.maxsize);
		p.collisiondetection = getboolfield_default(L, 1,
			"collisiondetection", p.collisiondetection);
		p.collision_removal = getboolfield_default(L, 1,
			"collision_removal", p.collision_removal);
		p.object_collision = getboolfield_default(L, 1,
			"object_collision", p.object_collision);

		lua_getfield(L, 1, "animation");
		p.animation = read_animation_definition(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "attached");
		if (!lua_isnil(L, -1)) {
			ObjectRef *ref = ObjectRef::checkobject(L, -1);
			lua_pop(L, 1);
			attached = ObjectRef::getobject(ref);
		}

		p.vertical = getboolfield_default(L, 1, "vertical", p.vertical);
		p.texture = getstringfield_default(L, 1, "texture", p.texture);
		playername = getstringfield_default(L, 1, "playername", "");
		p.glow = getintfield_default(L, 1, "glow", p.glow);

		lua_getfield(L, 1, "node");
		if (lua_istable(L, -1))
			p.node = readnode(L, -1, getGameDef(L)->ndef());
		lua_pop(L, 1);

		p.node_tile = getintfield_default(L, 1, "node_tile", p.node_tile);
	}

	u32 id = getServer(L)->addParticleSpawner(p, attached, playername);
	lua_pushnumber(L, id);

	return 1;
}

// delete_particlespawner(id, player)
// player (string) is optional
int ModApiParticles::l_delete_particlespawner(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	// Get parameters
	u32 id = luaL_checknumber(L, 1);
	std::string playername;
	if (lua_gettop(L) == 2) {
		playername = luaL_checkstring(L, 2);
	}

	getServer(L)->deleteParticleSpawner(playername, id);
	return 1;
}

int ModApiParticles::l_native_add_particle(lua_State* L) {
	struct ParticleParameters p;
	std::string playername;

	if (lua_gettop(L) > 1) // deprecated
	{
		log_deprecated(L, "Deprecated add_particle call with "
				  "individual parameters instead of definition");
		p.pos = check_v3f(L, 1);
		p.vel = check_v3f(L, 2);
		p.acc = check_v3f(L, 3);
		p.expirationtime = luaL_checknumber(L, 4);
		p.size = luaL_checknumber(L, 5);
		p.collisiondetection = readParam<bool>(L, 6);
		p.texture = luaL_checkstring(L, 7);
		if (lua_gettop(L) == 8) // only spawn for a single player
			playername = luaL_checkstring(L, 8);
	} else if (lua_istable(L, 1)) {
		lua_getfield(L, 1, "pos");
		if (lua_istable(L, -1))
			p.pos = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "vel");
		if (lua_istable(L, -1)) {
			p.vel = check_v3f(L, -1);
			log_deprecated(L, "The use of vel is deprecated. "
					  "Use velocity instead");
		}
		lua_pop(L, 1);

		lua_getfield(L, 1, "velocity");
		if (lua_istable(L, -1))
			p.vel = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "acc");
		if (lua_istable(L, -1)) {
			p.acc = check_v3f(L, -1);
			log_deprecated(L, "The use of acc is deprecated. "
					  "Use acceleration instead");
		}
		lua_pop(L, 1);

		lua_getfield(L, 1, "acceleration");
		if (lua_istable(L, -1))
			p.acc = check_v3f(L, -1);
		lua_pop(L, 1);

		p.expirationtime = getfloatfield_default(
				L, 1, "expirationtime", p.expirationtime);
		p.size = getfloatfield_default(L, 1, "size", p.size);
		p.collisiondetection = getboolfield_default(
				L, 1, "collisiondetection", p.collisiondetection);
		p.collision_removal = getboolfield_default(
				L, 1, "collision_removal", p.collision_removal);
		p.object_collision = getboolfield_default(
				L, 1, "object_collision", p.object_collision);
		p.vertical = getboolfield_default(L, 1, "vertical", p.vertical);

		lua_getfield(L, 1, "animation");
		p.animation = read_animation_definition(L, -1);
		lua_pop(L, 1);

		p.texture = getstringfield_default(L, 1, "texture", p.texture);
		p.glow = getintfield_default(L, 1, "glow", p.glow);

		lua_getfield(L, 1, "node");
		if (lua_istable(L, -1))
			p.node = readnode(L, -1, getGameDef(L)->ndef());
		lua_pop(L, 1);

		p.node_tile = getintfield_default(L, 1, "node_tile", p.node_tile);

		playername = getstringfield_default(L, 1, "playername", "");
	}
	NativeApiParticles::native_add_particle(getServer(L), &p.pos, &p.vel, &p.acc,
			&p.expirationtime, &p.size, &p.collisiondetection,
			&p.collision_removal, &p.object_collision, &p.vertical,
			&p.animation, &p.texture, &playername, &p.glow, &p.node,
			&p.node_tile);
	return 1;
}

int ModApiParticles::l_native_add_particlespawner(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	// Get parameters
	ParticleSpawnerParameters p;
	ServerActiveObject *attached = NULL;
	std::string playername;

	if (lua_gettop(L) > 1) // deprecated
	{
		log_deprecated(L, "Deprecated add_particlespawner call with "
				  "individual parameters instead of definition");
		p.amount = luaL_checknumber(L, 1);
		p.time = luaL_checknumber(L, 2);
		p.minpos = check_v3f(L, 3);
		p.maxpos = check_v3f(L, 4);
		p.minvel = check_v3f(L, 5);
		p.maxvel = check_v3f(L, 6);
		p.minacc = check_v3f(L, 7);
		p.maxacc = check_v3f(L, 8);
		p.minexptime = luaL_checknumber(L, 9);
		p.maxexptime = luaL_checknumber(L, 10);
		p.minsize = luaL_checknumber(L, 11);
		p.maxsize = luaL_checknumber(L, 12);
		p.collisiondetection = readParam<bool>(L, 13);
		p.texture = luaL_checkstring(L, 14);
		if (lua_gettop(L) == 15) // only spawn for a single player
			playername = luaL_checkstring(L, 15);
	} else if (lua_istable(L, 1)) {
		p.amount = getintfield_default(L, 1, "amount", p.amount);
		p.time = getfloatfield_default(L, 1, "time", p.time);

		lua_getfield(L, 1, "minpos");
		if (lua_istable(L, -1))
			p.minpos = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "maxpos");
		if (lua_istable(L, -1))
			p.maxpos = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "minvel");
		if (lua_istable(L, -1))
			p.minvel = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "maxvel");
		if (lua_istable(L, -1))
			p.maxvel = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "minacc");
		if (lua_istable(L, -1))
			p.minacc = check_v3f(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "maxacc");
		if (lua_istable(L, -1))
			p.maxacc = check_v3f(L, -1);
		lua_pop(L, 1);

		p.minexptime = getfloatfield_default(L, 1, "minexptime", p.minexptime);
		p.maxexptime = getfloatfield_default(L, 1, "maxexptime", p.maxexptime);
		p.minsize = getfloatfield_default(L, 1, "minsize", p.minsize);
		p.maxsize = getfloatfield_default(L, 1, "maxsize", p.maxsize);
		p.collisiondetection = getboolfield_default(
				L, 1, "collisiondetection", p.collisiondetection);
		p.collision_removal = getboolfield_default(
				L, 1, "collision_removal", p.collision_removal);
		p.object_collision = getboolfield_default(
				L, 1, "object_collision", p.object_collision);

		lua_getfield(L, 1, "animation");
		p.animation = read_animation_definition(L, -1);
		lua_pop(L, 1);

		lua_getfield(L, 1, "attached");
		if (!lua_isnil(L, -1)) {
			ObjectRef *ref = ObjectRef::checkobject(L, -1);
			lua_pop(L, 1);
			attached = ObjectRef::getobject(ref);
		}

		p.vertical = getboolfield_default(L, 1, "vertical", p.vertical);
		p.texture = getstringfield_default(L, 1, "texture", p.texture);
		playername = getstringfield_default(L, 1, "playername", "");
		p.glow = getintfield_default(L, 1, "glow", p.glow);

		lua_getfield(L, 1, "node");
		if (lua_istable(L, -1))
			p.node = readnode(L, -1, getGameDef(L)->ndef());
		lua_pop(L, 1);

		p.node_tile = getintfield_default(L, 1, "node_tile", p.node_tile);
	}
	u32 id = NativeApiParticles::native_add_particlespawner(getServer(L), &p.amount, &p.minpos,
			&p.maxpos, &p.minvel, &p.maxvel, &p.minacc, &p.maxacc, &p.time,
			&p.minexptime, &p.maxexptime, &p.minsize, &p.maxsize,
			&p.collisiondetection, &p.collision_removal, &p.object_collision,
			&p.vertical, &p.animation, &p.texture, attached, &playername,
			&p.glow, &p.node, &p.node_tile);
	lua_pushnumber(L, id);
	return 1;
}

int ModApiParticles::l_native_delete_particlespawner(lua_State *L)
{
	NO_MAP_LOCK_REQUIRED;

	// Get parameters
	u32 id = luaL_checknumber(L, 1);
	std::string playername;
	if (lua_gettop(L) == 2) {
		playername = luaL_checkstring(L, 2);
	}
	NativeApiParticles::native_delete_particlespawner(id, playername, getServer(L));
	return 1;
}

void ModApiParticles::Initialize(lua_State *L, int top)
{
	API_FCT(add_particle);
	API_FCT(add_particlespawner);
	API_FCT(delete_particlespawner);
	API_FCT(native_add_particle);
	API_FCT(native_add_particlespawner);
	API_FCT(native_delete_particlespawner);
}

