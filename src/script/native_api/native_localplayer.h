#pragma once
#include "client/localplayer.h"
#include "../lua_api/l_item.h"
#include "../../../src/player.h"
#include "../../../src/irrlicht_changes/irrUString.h"
#include "../../irr_v3d.h"
#include "../../../src/client/content_cao.h"
#include <vector>


class NativeLocalPlayer
{
public:
	static v3f native_get_velocity(LocalPlayer *p);
	static int native_get_hp(LocalPlayer *p);
	static const char* native_get_name(LocalPlayer *p);
	static u16 native_get_wield_index(LocalPlayer *p);
	static ItemStack native_get_wielded_item(LocalPlayer *p);

	static bool native_is_attached(LocalPlayer *p);
	static bool native_is_touching_ground(LocalPlayer *p);
	static bool native_is_in_liquid(LocalPlayer *p);
	static bool native_is_in_liquid_stable(LocalPlayer *p);
	static int native_get_liquid_viscosity(LocalPlayer *p);

	static bool native_is_climbing(LocalPlayer *p);
	static bool native_swimming_vertical(LocalPlayer *p);
	static std::vector<int> native_get_physics_override(LocalPlayer *p);
	static v3f native_get_last_pos(LocalPlayer *p);
	static v3f native_get_last_velocity(LocalPlayer *p);

	static double native_get_last_look_vertical(LocalPlayer *p);
	static double native_get_last_look_horizontal(LocalPlayer *p);
	static const PlayerControl& native_get_control(LocalPlayer *p);
	static int native_get_breath(LocalPlayer *p);
	static v3f native_get_pos(LocalPlayer *p);

	static std::vector<float> native_get_movement_acceleration(LocalPlayer *p);
	static std::vector<float> native_get_movement_speed(LocalPlayer *p);
	static std::vector<float> native_get_movement(LocalPlayer *p);
	static ItemGroupList native_get_armour_groups(LocalPlayer *p);
	static u32 native_hud_add(LocalPlayer *p, HudElement *elem);

	static HudElement *native_hud_remove(LocalPlayer *p, u32 id);
	static HudElement *native_hud_change(LocalPlayer *p, u32 id);
	static HudElement *native_hud_get(LocalPlayer *p, u32 id);
};
