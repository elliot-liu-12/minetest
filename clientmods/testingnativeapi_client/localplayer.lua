sampleHUD = {
     hud_elem_type = "text",
     position      = {x = 0.5, y = 0.5},
     offset        = {x = 0,   y = 0},
     text          = "Hello world!",
     alignment     = {x = 0, y = 0},  
     scale         = {x = 200, y = 200},
	 number    = 0xFF0000,
}

--get_velocity()
minetest.register_chatcommand("lua_localplayer_getvelocity", {
	description = "Invokes lua_api > l_localplayer.l_get_velocity",
	func = function(self)
		local res = minetest.localplayer:get_velocity()
		return true, "Success, get_velocity() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getvelocity", {
	description = "Invokes lua_api > l_localplayer.l_native_get_velocity",
	func = function(self)
		local res = minetest.localplayer:native_get_velocity()
		return true, "Success, native_get_velocity() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getvelocity", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_velocity",
	func = function(self)
		local lua = minetest.localplayer:get_velocity()
		local native = minetest.localplayer:native_get_velocity()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_velocity()"
		else
			return false, "(Fail) [LocalPlayer] get_velocity()"
		end
	end
})

--get_hp()
minetest.register_chatcommand("lua_localplayer_gethp", {
	description = "Invokes lua_api > l_localplayer.l_get_hp",
	func = function(self)
		local res = minetest.localplayer:get_hp()
		return true, "Success, get_hp() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_gethp", {
	description = "Invokes lua_api > l_localplayer.l_native_get_hp",
	func = function(self)
		local res = minetest.localplayer:native_get_hp()
		return true, "Success, native_get_hp() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_gethp", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_hp",
	func = function(self)
		local lua = minetest.localplayer:get_hp()
		local native = minetest.localplayer:native_get_hp()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_hp()"
		else
			return false, "(Fail) [LocalPlayer] get_hp()"
		end
	end
})

--get_name()
minetest.register_chatcommand("lua_localplayer_getname", {
	description = "Invokes lua_api > l_localplayer.l_get_name",
	func = function(self)
		local res = minetest.localplayer:get_name()
		return true, "Success, get_name() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getname", {
	description = "Invokes lua_api > l_localplayer.l_native_get_name",
	func = function(self)
		local res = minetest.localplayer:native_get_name()
		return true, "Success, native_get_name() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getname", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_name",
	func = function(self)
		local lua = minetest.localplayer:get_name()
		local native = minetest.localplayer:native_get_name()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_name()"
		else
			return false, "(Fail) [LocalPlayer] get_name()"
		end
	end
})

--get_wield_index()

minetest.register_chatcommand("lua_localplayer_getwieldindex", {
	description = "Invokes lua_api > l_localplayer.l_get_wield_index",
	func = function(self)
		local res = minetest.localplayer:get_wield_index()
		return true, "Success, get_wield_index() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getwieldindex", {
	description = "Invokes lua_api > l_localplayer.l_native_get_wield_index",
	func = function(self)
		local res = minetest.localplayer:native_get_wield_index()
		return true, "Success, native_get_wield_index() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getwieldindex", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_wield_index",
	func = function(self)
		local lua = minetest.localplayer:get_wield_index()
		local native = minetest.localplayer:native_get_wield_index()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_wield_index()"
		else
			return false, "(Fail) [LocalPlayer] get_wield_index()"
		end
	end
})
--get_wielded_item()
minetest.register_chatcommand("lua_localplayer_getwieldeditem", {
	description = "Invokes lua_api > l_localplayer.l_get_wielded_item",
	func = function(self)
		local res = minetest.localplayer:get_wielded_item()
		return true, "Success, get_wielded_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("native_localplayer_getwieldeditem", {
	description = "Invokes lua_api > l_localplayer.l_native_get_wielded_item",
	func = function(self)
		local res = minetest.localplayer:native_get_wielded_item()
		return true, "Success, native_get_wielded_item() returned: "..tostring(res)
	end
})

minetest.register_chatcommand("test_localplayer_getwieldeditem", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_wielded_item",
	func = function(self)
		local lua = minetest.localplayer:get_wielded_item()
		local native = minetest.localplayer:native_get_wielded_item()
		if tostring(lua) == tostring(native) then
			return true, "(Success) [LocalPlayer] get_wielded_item()"
		else
			return false, "(Fail) [LocalPlayer] get_wielded_item()"
		end
	end
})

--is_attached()
minetest.register_chatcommand("lua_localplayer_isattached", {
	description = "Invokes lua_api > l_localplayer.l_get_is_attached",
	func = function(self)
		local res = minetest.localplayer:is_attached()
		return true, "Success, is_attached() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_isattached", {
	description = "Invokes lua_api > l_localplayer.l_native_is_attached",
	func = function(self)
		local res = minetest.localplayer:native_is_attached()
		return true, "Success, native_is_attached() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_isattached", {
	description = "Asserts lua api and native api behaviors for l_localplayer.is_attached",
	func = function(self)
		local lua = minetest.localplayer:is_attached()
		local native = minetest.localplayer:native_is_attached()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] is_attached()"
		else
			return false, "(Fail) [LocalPlayer] is_attached()"
		end
	end
})

--is_touching_ground()
minetest.register_chatcommand("lua_localplayer_istouchingground", {
	description = "Invokes lua_api > l_localplayer.l_get_is_touching_ground",
	func = function(self)
		local res = minetest.localplayer:is_touching_ground()
		return true, "Success, is_touching_ground() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_istouchingground", {
	description = "Invokes lua_api > l_localplayer.l_native_is_touching_ground",
	func = function(self)
		local res = minetest.localplayer:native_is_touching_ground()
		return true, "Success, native_is_touching_ground() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_istouchingground", {
	description = "Asserts lua api and native api behaviors for l_localplayer.is_touching_ground",
	func = function(self)
		local lua = minetest.localplayer:is_touching_ground()
		local native = minetest.localplayer:native_is_touching_ground()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] is_touching_ground()"
		else
			return false, "(Fail) [LocalPlayer] is_touching_ground()"
		end
	end
})

minetest.register_chatcommand("lua_localplayer_isinliquid", {
	description = "Invokes lua_api > l_localplayer.l_get_is_in_liquid",
	func = function(self)
		local res = minetest.localplayer:is_in_liquid()
		return true, "Success, is_in_liquid() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_isinliquid", {
	description = "Invokes lua_api > l_localplayer.l_native_is_in_liquid",
	func = function(self)
		local res = minetest.localplayer:native_is_in_liquid()
		return true, "Success, native_is_in_liquid() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_isinliquid", {
	description = "Asserts lua api and native api behaviors for l_localplayer.is_in_liquid",
	func = function(self)
		local lua = minetest.localplayer:is_in_liquid()
		local native = minetest.localplayer:native_is_in_liquid()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] is_in_liquid()"
		else
			return false, "(Fail) [LocalPlayer] is_in_liquid()"
		end
	end
})

minetest.register_chatcommand("lua_localplayer_isinliquidstable", {
	description = "Invokes lua_api > l_localplayer.l_get_is_in_liquid_stable",
	func = function(self)
		local res = minetest.localplayer:is_in_liquid_stable()
		return true, "Success, is_in_liquid_stable() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_isinliquidstable", {
	description = "Invokes lua_api > l_localplayer.l_native_is_in_liquid_stable",
	func = function(self)
		local res = minetest.localplayer:native_is_in_liquid_stable()
		return true, "Success, native_is_in_liquid_stable() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_isinliquidstable", {
	description = "Asserts lua api and native api behaviors for l_localplayer.is_in_liquid_stable",
	func = function(self)
		local lua = minetest.localplayer:is_in_liquid_stable()
		local native = minetest.localplayer:native_is_in_liquid_stable()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] is_in_liquid_stable()"
		else
			return false, "(Fail) [LocalPlayer] is_in_liquid_stable()"
		end
	end
})

minetest.register_chatcommand("lua_localplayer_getliquidviscosity", {
	description = "Invokes lua_api > l_localplayer.l_get_get_liquid_viscosity",
	func = function(self)
		local res = minetest.localplayer:get_liquid_viscosity()
		return true, "Success, get_liquid_viscosity() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getliquidviscosity", {
	description = "Invokes lua_api > l_localplayer.l_native_get_liquid_viscosity",
	func = function(self)
		local res = minetest.localplayer:native_get_liquid_viscosity()
		return true, "Success, native_get_liquid_viscosity() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getliquidviscosity", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_liquid_viscosity",
	func = function(self)
		local lua = minetest.localplayer:get_liquid_viscosity()
		local native = minetest.localplayer:native_get_liquid_viscosity()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_liquid_viscosity()"
		else
			return false, "(Fail) [LocalPlayer] get_liquid_viscosity()"
		end
	end
})
--is_climbing()
minetest.register_chatcommand("lua_localplayer_isclimbing", {
	description = "Invokes lua_api > l_localplayer.l_get_is_climbing",
	func = function(self)
		local res = minetest.localplayer:is_climbing()
		return true, "Success, is_climbing() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_isclimbing", {
	description = "Invokes lua_api > l_localplayer.l_native_is_climbing",
	func = function(self)
		local res = minetest.localplayer:native_is_climbing()
		return true, "Success, native_is_climbing() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_isclimbing", {
	description = "Asserts lua api and native api behaviors for l_localplayer.is_climbing",
	func = function(self)
		local lua = minetest.localplayer:is_climbing()
		local native = minetest.localplayer:native_is_climbing()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] is_climbing()"
		else
			return false, "(Fail) [LocalPlayer] is_climbing()"
		end
	end
})
--swimming_vertical()
minetest.register_chatcommand("lua_localplayer_swimmingvertical", {
	description = "Invokes lua_api > l_localplayer.l_get_swimming_vertical",
	func = function(self)
		local res = minetest.localplayer:swimming_vertical()
		return true, "Success, swimming_vertical() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_swimmingvertical", {
	description = "Invokes lua_api > l_localplayer.l_native_swimming_vertical",
	func = function(self)
		local res = minetest.localplayer:native_swimming_vertical()
		return true, "Success, native_swimming_vertical() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_swimmingvertical", {
	description = "Asserts lua api and native api behaviors for l_localplayer.swimming_vertical",
	func = function(self)
		local lua = minetest.localplayer:swimming_vertical()
		local native = minetest.localplayer:native_swimming_vertical()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] swimming_vertical()"
		else
			return false, "(Fail) [LocalPlayer] swimming_vertical()"
		end
	end
})
--get_physics_override()
minetest.register_chatcommand("lua_localplayer_getphysicsoverride", {
	description = "Invokes lua_api > l_localplayer.l_get_get_physics_override",
	func = function(self)
		local res = minetest.localplayer:get_physics_override()
		return true, "Success, get_physics_override() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getphysicsoverride", {
	description = "Invokes lua_api > l_localplayer.l_native_get_physics_override",
	func = function(self)
		local res = minetest.localplayer:native_get_physics_override()
		return true, "Success, native_get_physics_override() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getphysicsoverride", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_physics_override",
	func = function(self)
		local lua = minetest.localplayer:get_physics_override()
		local native = minetest.localplayer:native_get_physics_override()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_physics_override()"
		else
			return false, "(Fail) [LocalPlayer] get_physics_override()"
		end
	end
})
--get_last_pos()
minetest.register_chatcommand("lua_localplayer_getlastpos", {
	description = "Invokes lua_api > l_localplayer.l_get_get_last_pos",
	func = function(self)
		local res = minetest.localplayer:get_last_pos()
		return true, "Success, get_last_pos() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getlastpos", {
	description = "Invokes lua_api > l_localplayer.l_native_get_last_pos",
	func = function(self)
		local res = minetest.localplayer:native_get_last_pos()
		return true, "Success, native_get_last_pos() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getlastpos", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_last_pos",
	func = function(self)
		local lua = minetest.localplayer:get_last_pos()
		local native = minetest.localplayer:native_get_last_pos()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_last_pos()"
		else
			return false, "(Fail) [LocalPlayer] get_last_pos()"
		end
	end
})
--get_last_velocity()
minetest.register_chatcommand("lua_localplayer_getlastvelocity", {
	description = "Invokes lua_api > l_localplayer.l_get_get_last_velocity",
	func = function(self)
		local res = minetest.localplayer:get_last_velocity()
		return true, "Success, get_last_velocity() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getlastvelocity", {
	description = "Invokes lua_api > l_localplayer.l_native_get_last_velocity",
	func = function(self)
		local res = minetest.localplayer:native_get_last_velocity()
		return true, "Success, native_get_last_velocity() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getlastvelocity", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_last_velocity",
	func = function(self)
		local lua = minetest.localplayer:get_last_velocity()
		local native = minetest.localplayer:native_get_last_velocity()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_last_velocity()"
		else
			return false, "(Fail) [LocalPlayer] get_last_velocity()"
		end
	end
})
--get_last_look_vertical()
minetest.register_chatcommand("lua_localplayer_getlastlookvertical", {
	description = "Invokes lua_api > l_localplayer.l_get_get_last_look_vertical",
	func = function(self)
		local res = minetest.localplayer:get_last_look_vertical()
		return true, "Success, get_last_look_vertical() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getlastlookvertical", {
	description = "Invokes lua_api > l_localplayer.l_native_get_last_look_vertical",
	func = function(self)
		local res = minetest.localplayer:native_get_last_look_vertical()
		return true, "Success, native_get_last_look_vertical() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getlastlookvertical", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_last_look_vertical",
	func = function(self)
		local lua = minetest.localplayer:get_last_look_vertical()
		local native = minetest.localplayer:native_get_last_look_vertical()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_last_look_vertical()"
		else
			return false, "(Fail) [LocalPlayer] get_last_look_vertical()"
		end
	end
})
--get_last_look_horizontal()
minetest.register_chatcommand("lua_localplayer_getlastlookhorizontal", {
	description = "Invokes lua_api > l_localplayer.l_get_get_last_look_horizontal",
	func = function(self)
		local res = minetest.localplayer:get_last_look_horizontal()
		return true, "Success, get_last_look_horizontal() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getlastlookhorizontal", {
	description = "Invokes lua_api > l_localplayer.l_native_get_last_look_horizontal",
	func = function(self)
		local res = minetest.localplayer:native_get_last_look_horizontal()
		return true, "Success, native_get_last_look_horizontal() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getlastlookhorizontal", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_last_look_horizontal",
	func = function(self)
		local lua = minetest.localplayer:get_last_look_horizontal()
		local native = minetest.localplayer:native_get_last_look_horizontal()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_last_look_horizontal()"
		else
			return false, "(Fail) [LocalPlayer] get_last_look_horizontal()"
		end
	end
})
--get_control()
minetest.register_chatcommand("lua_localplayer_getcontrol", {
	description = "Invokes lua_api > l_localplayer.l_get_get_control",
	func = function(self)
		local res = minetest.localplayer:get_control()
		return true, "Success, get_control() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getcontrol", {
	description = "Invokes lua_api > l_localplayer.l_native_get_control",
	func = function(self)
		local res = minetest.localplayer:native_get_control()
		return true, "Success, native_get_control() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getcontrol", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_control",
	func = function(self)
		local lua = minetest.localplayer:get_control()
		local native = minetest.localplayer:native_get_control()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_control()"
		else
			return false, "(Fail) [LocalPlayer] get_control()"
		end
	end
})
--get_breath()
minetest.register_chatcommand("lua_localplayer_getbreath", {
	description = "Invokes lua_api > l_localplayer.l_get_get_breath",
	func = function(self)
		local res = minetest.localplayer:get_breath()
		return true, "Success, get_breath() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getbreath", {
	description = "Invokes lua_api > l_localplayer.l_native_get_breath",
	func = function(self)
		local res = minetest.localplayer:native_get_breath()
		return true, "Success, native_get_breath() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getbreath", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_breath",
	func = function(self)
		local lua = minetest.localplayer:get_breath()
		local native = minetest.localplayer:native_get_breath()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_breath()"
		else
			return false, "(Fail) [LocalPlayer] get_breath()"
		end
	end
})
--get_pos()
minetest.register_chatcommand("lua_localplayer_getpos", {
	description = "Invokes lua_api > l_localplayer.l_get_get_pos",
	func = function(self)
		local res = minetest.localplayer:get_pos()
		return true, "Success, get_pos() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getpos", {
	description = "Invokes lua_api > l_localplayer.l_native_get_pos",
	func = function(self)
		local res = minetest.localplayer:native_get_pos()
		return true, "Success, native_get_pos() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getpos", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_pos",
	func = function(self)
		local lua = minetest.localplayer:get_pos()
		local native = minetest.localplayer:native_get_pos()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_pos()"
		else
			return false, "(Fail) [LocalPlayer] get_pos()"
		end
	end
})
--get_movement_acceleration()
minetest.register_chatcommand("lua_localplayer_getmovementacceleration", {
	description = "Invokes lua_api > l_localplayer.l_get_get_movement_acceleration",
	func = function(self)
		local res = minetest.localplayer:get_movement_acceleration()
		return true, "Success, get_movement_acceleration() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getmovementacceleration", {
	description = "Invokes lua_api > l_localplayer.l_native_get_movement_acceleration",
	func = function(self)
		local res = minetest.localplayer:native_get_movement_acceleration()
		return true, "Success, native_get_movement_acceleration() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getmovementacceleration", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_movement_acceleration",
	func = function(self)
		local lua = minetest.localplayer:get_movement_acceleration()
		local native = minetest.localplayer:native_get_movement_acceleration()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_movement_acceleration()"
		else
			return false, "(Fail) [LocalPlayer] get_movement_acceleration()"
		end
	end
})
--get_movement_speed()
minetest.register_chatcommand("lua_localplayer_getmovementspeed", {
	description = "Invokes lua_api > l_localplayer.l_get_get_movement_speed",
	func = function(self)
		local res = minetest.localplayer:get_movement_speed()
		return true, "Success, get_movement_speed() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getmovementspeed", {
	description = "Invokes lua_api > l_localplayer.l_native_get_movement_speed",
	func = function(self)
		local res = minetest.localplayer:native_get_movement_speed()
		return true, "Success, native_get_movement_speed() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getmovementspeed", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_movement_speed",
	func = function(self)
		local lua = minetest.localplayer:get_movement_speed()
		local native = minetest.localplayer:native_get_movement_speed()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_movement_speed()"
		else
			return false, "(Fail) [LocalPlayer] get_movement_speed()"
		end
	end
})
--get_movement()
minetest.register_chatcommand("lua_localplayer_getmovement", {
	description = "Invokes lua_api > l_localplayer.l_get_get_movement",
	func = function(self)
		local res = minetest.localplayer:get_movement()
		return true, "Success, get_movement() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getmovement", {
	description = "Invokes lua_api > l_localplayer.l_native_get_movement",
	func = function(self)
		local res = minetest.localplayer:native_get_movement()
		return true, "Success, native_get_movement() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getmovement", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_movement",
	func = function(self)
		local lua = minetest.localplayer:get_movement()
		local native = minetest.localplayer:native_get_movement()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_movement()"
		else
			return false, "(Fail) [LocalPlayer] get_movement()"
		end
	end
})
--get_armour_groups()
minetest.register_chatcommand("lua_localplayer_getarmourgroups", {
	description = "Invokes lua_api > l_localplayer.l_get_get_armour_groups",
	func = function(self)
		local res = minetest.localplayer:get_armor_groups()
		return true, "Success, get_armour_groups() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_getarmourgroups", {
	description = "Invokes lua_api > l_localplayer.l_native_get_armour_groups",
	func = function(self)
		local res = minetest.localplayer:native_get_armor_groups()
		return true, "Success, native_get_armour_groups() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_getarmourgroups", {
	description = "Asserts lua api and native api behaviors for l_localplayer.get_armour_groups",
	func = function(self)
		local lua = minetest.localplayer:get_armor_groups()
		local native = minetest.localplayer:native_get_armor_groups()
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] get_armour_groups()"
		else
			return false, "(Fail) [LocalPlayer] get_armour_groups()"
		end
	end
})

--hud_add()
minetest.register_chatcommand("lua_localplayer_hudadd", {
	description = "Invokes lua_api > l_localplayer.l_get_hud_add",
	func = function(self)
		local res = minetest.localplayer:hud_add(sampleHUD)
		return true, "Success, hud_add() returned: "..res
	end
})

minetest.register_chatcommand("native_localplayer_hudadd", {
	description = "Invokes lua_api > l_localplayer.l_native_hud_add",
	func = function(self)
		local res = minetest.localplayer:native_hud_add(sampleHUD)
		return true, "Success, native_hud_add() returned: "..res
	end
})

minetest.register_chatcommand("test_localplayer_hudadd", {
	description = "Asserts lua api and native api behaviors for l_localplayer.hud_add",
	func = function(self)
		local lua = minetest.localplayer:hud_add(sampleHUD)
		local native = minetest.localplayer:native_hud_add(sampleHUD)
		if lua+1 == native then
			return true, "(Success) [LocalPlayer] hud_add()"
		else
			return false, "(Fail) [LocalPlayer] hud_add()"
		end
	end
})
--hud_remove()
minetest.register_chatcommand("lua_localplayer_hudremove", {
	description = "Invokes lua_api > l_localplayer.l_get_hud_remove",
	func = function(self)
		local res = minetest.localplayer:hud_remove(1)
		return true, "Success, hud_remove() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_hudremove", {
	description = "Invokes lua_api > l_localplayer.l_native_hud_remove",
	func = function(self)
		minetest.localplayer:hud_add(sampleHUD)
		local res = minetest.localplayer:native_hud_remove(1)
		return true, "Success, native_hud_remove() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_hudremove", {
	description = "Asserts lua api and native api behaviors for l_localplayer.hud_remove",
	func = function(self)
		minetest.localplayer:hud_add(sampleHUD)
		local lua = minetest.localplayer:hud_remove(1)
		minetest.localplayer:hud_add(sampleHUD)
		local native = minetest.localplayer:native_hud_remove(1)
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] hud_remove()"
		else
			return false, "(Fail) [LocalPlayer] hud_remove()"
		end
	end
})


--hud_change()
minetest.register_chatcommand("lua_localplayer_hudchange", {
	description = "Invokes lua_api > l_localplayer.l_get_hud_change",
	func = function(self)
		--minetest.localplayer:native_hud_add(sampleHUD)
		local res = minetest.localplayer:hud_change(1, "number","0x91fdff",0)
		return true, "Success, hud_change() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_hudchange", {
	description = "Invokes lua_api > l_localplayer.l_native_hud_change",
	func = function(self)
		local res = minetest.localplayer:native_hud_change(1, "number","0xab5cff",0)
		return true, "Success, native_hud_change() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_hudchange", {
	description = "Asserts lua api and native api behaviors for l_localplayer.hud_change",
	func = function(self)
		local lua = minetest.localplayer:hud_change(1, "text","Hello World but cooler 1X",3)
		local native = minetest.localplayer:native_hud_change(1, "text","Hello World but cooler 2X",4)
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] hud_change()"
		else
			return false, "(Fail) [LocalPlayer] hud_change()"
		end
	end
})

minetest.register_chatcommand("lua_localplayer_hudget", {
	description = "Invokes lua_api > l_localplayer.l_get_hud_get",
	func = function(self)
		local res = minetest.localplayer:hud_get(1)
		return true, "Success, hud_get() returned: "..dump(res)
	end
})

minetest.register_chatcommand("native_localplayer_hudget", {
	description = "Invokes lua_api > l_localplayer.l_native_hud_get",
	func = function(self)
		local res = minetest.localplayer:native_hud_get(1)
		return true, "Success, native_hud_get() returned: "..dump(res)
	end
})

minetest.register_chatcommand("test_localplayer_hudget", {
	description = "Asserts lua api and native api behaviors for l_localplayer.hud_get",
	func = function(self)
		local lua = minetest.localplayer:hud_get(1)
		local native = minetest.localplayer:native_hud_get(1)
		if dump(lua) == dump(native) then
			return true, "(Success) [LocalPlayer] hud_get()"
		else
			return false, "(Fail) [LocalPlayer] hud_get()"
		end
	end
})

--command to test entire class
minetest.register_chatcommand("test_localplayer", {
	description = "testing all localplayer methods",
	func = function()

		local methods = {
			"getvelocity",
			"gethp",
			"getname",
			"getwieldindex",
			"getwieldeditem",
			"isattached",
			"istouchingground",
			"isinliquid",
			"isinliquidstable",
			"getliquidviscosity",
			"isclimbing",
			"swimmingvertical",
			"getphysicsoverride",
			"getlastpos",
			"getlastvelocity",
			"getlastlookvertical",
			"getlastlookhorizontal",
			"getcontrol",
			"getbreath",
			"getpos",
			"getmovementacceleration",
			"getmovementspeed",
			"getmovement",
			"getarmourgroups",
			"hudadd",
			"hudremove",
			"hudchange",
			"hudget"
		}

		return native_tests.test_class("localplayer", methods), 
		"LocalPlayer tests completed. See console for details."
	end
})