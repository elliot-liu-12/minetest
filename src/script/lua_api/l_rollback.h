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

class ModApiRollback : public ModApiBase
{
private:
	// rollback_get_node_actions(pos, range, seconds) -> {{actor, pos, time, oldnode, newnode}, ...}
	static int l_rollback_get_node_actions(lua_State *L);

	static int l_native_rollback_get_node_actions(lua_State *L);

	// rollback_revert_actions_by(actor, seconds) -> bool, log messages
	static int l_rollback_revert_actions_by(lua_State *L);

	static int l_native_rollback_revert_actions_by(lua_State *L);

public:
	static void Initialize(lua_State *L, int top);
};
