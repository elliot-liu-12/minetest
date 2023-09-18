#include "native_noise.h"
#include "../../noise.h"

Noise *NativeNoise::native_get_2d_map(LuaPerlinNoiseMap *o, v2f pos)
{
	Noise *n = o->getNoise();
	n->perlinMap2D(pos.X, pos.Y);
	return n;
}

std::tuple<Noise*, bool> NativeNoise::native_get_2d_map_flat(LuaPerlinNoiseMap *o, v2f pos, bool buffer)
{
	Noise *n = o->getNoise();
	n->perlinMap2D(pos.X, pos.Y);
	return std::make_tuple(n, buffer);
}

Noise *NativeNoise::native_get_3d_map(LuaPerlinNoiseMap *o, v3f pos)
{
	Noise *n = o->getNoise();
	n->perlinMap3D(pos.X, pos.Y, pos.Z);
	return n;
}

std::tuple<Noise *, bool> NativeNoise::native_get_3d_map_flat(
		LuaPerlinNoiseMap *o, v3f pos, bool buffer)
{
	Noise *n = o->getNoise();
	n->perlinMap3D(pos.X, pos.Y, pos.Z);
	return std::make_tuple(n, buffer);
}

void NativeNoise::native_calc_2d_map(LuaPerlinNoiseMap *o, v2f pos)
{
	Noise *n = o->getNoise();
	n->perlinMap2D(pos.X, pos.Y);
}

void NativeNoise::native_calc_3d_map(LuaPerlinNoiseMap *o, v3f pos)
{
	if (!o->getMis3d())
		return;

	Noise *n = o->getNoise();
	n->perlinMap3D(pos.X, pos.Y, pos.Z);
}

std::tuple <v3u16,v3u16,v3u16, bool> NativeNoise::native_get_map_slice(LuaPerlinNoiseMap *o,
			       v3s16 slice_offset,
		v3s16 slice_size, bool buffer)
{
	Noise *n = o->getNoise();
	auto t = std::make_tuple(v3u16(n->sx, n->sy, n->sz),
			v3u16(slice_offset.X, slice_offset.Y, slice_offset.Z),
			v3u16(slice_size.X, slice_size.Y, slice_size.Z),
		buffer);

	return t;
}

bool NativeNoise::mapis3d(LuaPerlinNoiseMap *o)
{
	if (!o->getMis3d())
		return false;

	return true;
}

int pcgRandom::native_next(LuaPcgRandom *o, u32 min, u32 max)
{
	return o->getmrnd().range(min, max);
}

int pcgRandom::native_rand_normal_dist(LuaPcgRandom *o, u32 min, u32 max, int trials)
{
	return o->getmrnd().randNormalDist(min, max, trials);
}

std::tuple<const char *,u32>secureRandom::native_next_bytes(LuaSecureRandom *o, u32 count)
{
	u32 randomIDX = o->getRandidx();
	char *randBuf = o->getRandbuf();
	const char *retVal;
	int c;

	size_t count_remaining = 2048 - o->getRandidx();
	if (count_remaining >= count) {
		retVal = randBuf + o->getRandidx();
		c = count;

		//lua_pushlstring(L, randBuf + o->getRandidx(), count);
		randomIDX += count;
	} else {
		char output_buf[2048];

		memcpy(output_buf, randBuf + randomIDX, count_remaining);

		o->fillRandBuf();
		memcpy(output_buf + count_remaining, randBuf, count - count_remaining);


		randomIDX = count - count_remaining;
		retVal = output_buf;
		c = count;
	}

	return std::make_tuple(retVal, c);
}

int pseudoRandom::native_nextPS(LuaPseudoRandom *o, int min, int max)
{
	if (max < min) {
		std::cout << "PseudoRandom.next(): max=" << max << " min=" << min
			    << std::endl;
		throw LuaError("PseudoRandom.next(): max < min");
	}
	if (max - min != 32767 && max - min > 32767 / 5)
		throw LuaError("PseudoRandom.next() max-min is not 32767"
			       " and is > 32768/5. This is disallowed due to"
			       " the bad random distribution the"
			       " implementation would otherwise make.");
	PseudoRandom &pseudo = o->getmpseudo();
	int val = pseudo.next();
	val = (val % (max - min + 1)) + min;
	return val;
}
