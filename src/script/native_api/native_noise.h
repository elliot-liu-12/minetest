#pragma once
#include "./../lua_api/l_noise.h"
#include "irr_v3d.h"
#include <tuple>

class NativeNoise
{
public:
	static Noise* native_get_2d_map(LuaPerlinNoiseMap *o, v2f pos);
	static std::tuple<Noise *, bool> native_get_2d_map_flat(
			LuaPerlinNoiseMap *o, v2f pos, bool buffer);
	static Noise *native_get_3d_map(LuaPerlinNoiseMap *o, v3f pos);
	static std::tuple<Noise *, bool> native_get_3d_map_flat(
			LuaPerlinNoiseMap *o, v3f pos, bool buffer);

	static void native_calc_2d_map(LuaPerlinNoiseMap *o, v2f pos);
	static void native_calc_3d_map(LuaPerlinNoiseMap *o, v3f pos);
	static std::tuple<v3u16, v3u16, v3u16, bool> native_get_map_slice(
			LuaPerlinNoiseMap *o, v3s16 slice_offset,
			v3s16 slice_size, bool buffer);
	static bool mapis3d(LuaPerlinNoiseMap *o);
 

	// Helpers
};

class pcgRandom
{
public:
	static int native_next(LuaPcgRandom *o, u32 min, u32 max);
	static int native_rand_normal_dist(LuaPcgRandom *o, u32 min, u32 max, int trials);
};

class secureRandom
{
public:
	static std::tuple<const char *, u32> native_next_bytes(
			LuaSecureRandom *o, u32 count);
};

class pseudoRandom
{
public:
	static int native_nextPS(LuaPseudoRandom *o, int min, int max);
};
