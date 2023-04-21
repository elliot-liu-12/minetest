#include "native_localplayer.h"

v3f NativeLocalPlayer::native_get_velocity(LocalPlayer *p)
{
	return p->getSpeed();
}

int NativeLocalPlayer::native_get_hp(LocalPlayer *p)
{
	return p->hp;
}

const char* NativeLocalPlayer::native_get_name(LocalPlayer *p)
{
	return p->getName();
}

u16 NativeLocalPlayer::native_get_wield_index(LocalPlayer *p)
{
	return p->getWieldIndex();
}

ItemStack NativeLocalPlayer::native_get_wielded_item(LocalPlayer *p)
{
	ItemStack selected_item;
	return p->getWieldedItem(&selected_item, nullptr);
}

bool NativeLocalPlayer::native_is_attached(LocalPlayer *p)
{
	return (p->getParent() != nullptr);
}

bool NativeLocalPlayer::native_is_touching_ground(LocalPlayer *p)
{
	return p->touching_ground;
}

bool NativeLocalPlayer::native_is_in_liquid(LocalPlayer *p)
{
	return p->in_liquid;
}

bool NativeLocalPlayer::native_is_in_liquid_stable(LocalPlayer *p)
{
	return p->in_liquid_stable;
}

int NativeLocalPlayer::native_get_liquid_viscosity(LocalPlayer *p)
{
	return p->in_liquid_stable;
}

bool NativeLocalPlayer::native_is_climbing(LocalPlayer *p)
{
	return p->is_climbing;
}

bool NativeLocalPlayer::native_swimming_vertical(LocalPlayer *p)
{
	return p->swimming_vertical;
}

std::vector<int> NativeLocalPlayer::native_get_physics_override(LocalPlayer *p)
{
	std::vector<int> v;
	v.push_back(p->physics_override_speed);
	v.push_back(p->physics_override_jump);
	v.push_back(p->physics_override_gravity);
	v.push_back(p->physics_override_sneak);
	v.push_back(p->physics_override_sneak_glitch);
	v.push_back(p->physics_override_new_move);
	return v;
}

v3f NativeLocalPlayer::native_get_last_pos(LocalPlayer *p)
{
	return p->last_position;
}

v3f NativeLocalPlayer::native_get_last_velocity(LocalPlayer *p)
{
	return p->last_speed;
}

//RETURN to this, may be issue

double NativeLocalPlayer::native_get_last_look_vertical(LocalPlayer *p)
{
	double a = -1.0 * p->last_pitch * core::DEGTORAD;
	std::cout << a << std::endl;
	return a;
}

double NativeLocalPlayer::native_get_last_look_horizontal(LocalPlayer *p)
{
	return ((p->last_yaw + 90.) * core::DEGTORAD);
}

//Return --unsure 

const PlayerControl& NativeLocalPlayer::native_get_control(LocalPlayer *p)
{
	return p->getPlayerControl();
}

int NativeLocalPlayer::native_get_breath(LocalPlayer *p)
{
	return p->getBreath();
}

v3f NativeLocalPlayer::native_get_pos(LocalPlayer *p)
{
	return p->getPosition();
}

std::vector<float> NativeLocalPlayer::native_get_movement_acceleration(
		LocalPlayer *p)
{
	std::vector<float> movA;
	movA.push_back(p->movement_acceleration_default);
	movA.push_back(p->movement_acceleration_air);
	movA.push_back(p->movement_acceleration_fast);

	return movA;
}
std::vector<float> NativeLocalPlayer::native_get_movement_speed(LocalPlayer *p)
{
	std::vector<float> movS;
	
	movS.push_back(p->movement_speed_walk);
	movS.push_back(p->movement_speed_crouch);
	movS.push_back(p->movement_speed_fast);
	movS.push_back(p->movement_speed_climb);
	movS.push_back(p->movement_speed_jump);

	return movS;
}

std::vector<float> NativeLocalPlayer::native_get_movement(LocalPlayer *p)
{
	std::vector<float> mov;

	mov.push_back(p->movement_liquid_fluidity);
	mov.push_back(p->movement_liquid_fluidity_smooth);
	mov.push_back(p->movement_liquid_sink);
	mov.push_back(p->movement_gravity);

	return mov;
}

ItemGroupList NativeLocalPlayer::native_get_armour_groups(LocalPlayer *p)
{
	return p->getCAO()->getGroups();
}

u32 NativeLocalPlayer::native_hud_add(LocalPlayer *p, HudElement *elem)
{
	return p->addHud(elem);
}

HudElement *NativeLocalPlayer::native_hud_remove(LocalPlayer *p, u32 id)
{
	return p->removeHud(id);
}

HudElement *NativeLocalPlayer::native_hud_change(LocalPlayer *p, u32 id)
{
	HudElement *e = p->getHud(id);
	if (e) {
		return e;
	} else
		return nullptr;
}

HudElement *NativeLocalPlayer::native_hud_get(LocalPlayer *p, u32 id)
{
	HudElement *e = p->getHud(id);
	return e;
}
