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

#pragma once

#include "lua_api/l_base.h"
#include "../script/native_api/native_inventory.h"
#include "inventory.h"
#include "inventorymanager.h"

class RemotePlayer;

/*
	InvRef
*/

class InvRef : public ModApiBase {
private:
	InventoryLocation m_loc;

	static const char className[];
	static const luaL_Reg methods[];

	static InvRef *checkobject(lua_State *L, int narg);

	static Inventory* getinv(lua_State *L, InvRef *ref);

	static InventoryList* getlist(lua_State *L, InvRef *ref,
			const char *listname);

	static void reportInventoryChange(lua_State *L, InvRef *ref);

	// Exported functions

	// garbage collector
	static int gc_object(lua_State *L);

	// is_empty(self, listname) -> true/false
	static int l_is_empty(lua_State *L);

	static int l_native_is_empty(lua_State *L);

	// get_size(self, listname)
	static int l_get_size(lua_State *L);

	static int l_native_get_size(lua_State *L);

	// get_width(self, listname)
	static int l_get_width(lua_State *L);

	static int l_native_get_width(lua_State *L);

	// set_size(self, listname, size)
	static int l_set_size(lua_State *L);

	static int l_native_set_size(lua_State *L);

	// set_width(self, listname, size)
	static int l_set_width(lua_State *L);

	static int l_native_set_width(lua_State *L);

	// get_stack(self, listname, i) -> itemstack
	static int l_get_stack(lua_State *L);

	static int l_native_get_stack(lua_State *L);

	// set_stack(self, listname, i, stack) -> true/false
	static int l_set_stack(lua_State *L);
	static int l_native_set_stack(lua_State *L);

	// get_list(self, listname) -> list or nil
	static int l_get_list(lua_State *L);
	//SKIP native for now, function not written yet

	// set_list(self, listname, list)
	static int l_set_list(lua_State *L);
	static int l_native_set_list(lua_State *L);
	// SKIP native for now, function not written yet

	// get_lists(self) -> list of InventoryLists
	static int l_get_lists(lua_State *L);
	static int l_native_get_lists(lua_State *L);
	//static int l_native_get_lists(lua_State *L); 
	//Function above paused for now: native_get_lists appears incomplete

	// set_lists(self, lists)
	static int l_set_lists(lua_State *L);
	static int l_native_set_lists(lua_State *L);
	// SKIP native for now, function not written yet

	// add_item(self, listname, itemstack or itemstring or table or nil) -> itemstack
	// Returns the leftover stack
	static int l_add_item(lua_State *L);
	// SKIP native for now, function not written yet

	// room_for_item(self, listname, itemstack or itemstring or table or nil) -> true/false
	// Returns true if the item completely fits into the list
	static int l_room_for_item(lua_State *L);
	static int l_native_room_for_item(lua_State *L);

	// contains_item(self, listname, itemstack or itemstring or table or nil, [match_meta]) -> true/false
	// Returns true if the list contains the given count of the given item name
	static int l_contains_item(lua_State *L);
	static int l_native_contains_item(lua_State *L);

	// remove_item(self, listname, itemstack or itemstring or table or nil) -> itemstack
	// Returns the items that were actually removed
	static int l_remove_item(lua_State *L);
	static int l_native_remove_item(lua_State *L);

	// get_location() -> location (like get_inventory(location))
	static int l_get_location(lua_State *L);
	//do we need this?

	static std::vector<ItemStack> prepare_itemStack(lua_State *L);

public:
	InvRef(const InventoryLocation &loc);

	~InvRef() = default;

	// Creates an InvRef and leaves it on top of stack
	// Not callable from Lua; all references are created on the C side.
	static void create(lua_State *L, const InventoryLocation &loc);
	static void createPlayer(lua_State *L, RemotePlayer *player);
	static void createNodeMeta(lua_State *L, v3s16 p);
	static void Register(lua_State *L);
};

class ModApiInventory : public ModApiBase {
private:
	static int l_create_detached_inventory_raw(lua_State *L);

	static int l_remove_detached_inventory_raw(lua_State *L);

	static int l_get_inventory(lua_State *L);

public:
	static void Initialize(lua_State *L, int top);
};

std::vector<ItemStack> read_inventory_list_helper(lua_State *L, int tableindex,
		const char *name, Inventory *inv, Server *srv);


