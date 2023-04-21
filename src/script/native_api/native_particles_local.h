#include "lua_api/l_base.h"
#include "tileanimation.h"
#include "irr_v3d.h"
#include "mapnode.h"

class NativeApiParticlesLocal
{
public:
	static int native_add_particle(Client *_client, v3f *_pos = nullptr,
			v3f *_vel = nullptr, v3f *_acc = nullptr,
			float *_expirationtime = nullptr, float *_size = nullptr,
			bool *_collisiondetection = nullptr, bool *_collision_removal = nullptr,
			bool *_vertical = nullptr, TileAnimationParams *_animation = nullptr,
			std::string *_texture = nullptr, u8 *_glow = nullptr,
			MapNode *_node = nullptr, irr::u8 *_nodeTile = nullptr);
	static u64 native_add_particlespawner(Client *_client, u16 *_amount = nullptr,
			v3f *_minpos = nullptr, v3f *_maxpos = nullptr,
			v3f *_minvel = nullptr, v3f *_maxvel = nullptr,
			v3f *_minacc = nullptr, v3f *_maxacc = nullptr,
			float *_time = nullptr, float *_minexptime = nullptr,
			float *_maxexptime = nullptr, float *_minsize = nullptr,
			float *_maxsize = nullptr, bool *_collisiondetection = nullptr,
			bool *_vertical = nullptr, bool *_collision_removal = nullptr,
			TileAnimationParams *_animation = nullptr,
			std::string *_texture = nullptr, u8 *_glow = nullptr,
			MapNode *_node = nullptr, irr::u8 *_nodeTile = nullptr);
	static int native_delete_particlespawner(u32 _id, Client *_client);
};
