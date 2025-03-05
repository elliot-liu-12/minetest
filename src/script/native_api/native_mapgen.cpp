#include "native_mapgen.h"

struct EnumString NativeModApiMapgen::es_MapgenObject[] = {
		{MGOBJ_VMANIP, "voxelmanip"},
		{MGOBJ_HEIGHTMAP, "heightmap"},
		{MGOBJ_BIOMEMAP, "biomemap"},
		{MGOBJ_HEATMAP, "heatmap"},
		{MGOBJ_HUMIDMAP, "humiditymap"},
		{MGOBJ_GENNOTIFY, "gennotify"},
		{0, NULL},
};

u32 NativeModApiMapgen::n_get_biome_id(const BiomeManager* bmgr, const char* biome_str)
{
	if (bmgr == nullptr || biome_str == nullptr)
		return -1;
	else
	{
		const Biome *biome = (Biome *)bmgr->getByName(biome_str);
		if (biome == nullptr || biome->index == OBJDEF_INVALID_INDEX)
		{
			return -1;
		} 
		return biome->index;
	}
}

std::string NativeModApiMapgen::n_get_biome_name(const BiomeManager* bmgr, const int biome_id)
{
	const Biome *b = (Biome *)bmgr->getRaw(biome_id);
	return b->name;
}

bool NativeModApiMapgen::can_get_heat(MapSettingsManager* settingsmgr, const BiomeManager* bmgr)
{
	NoiseParams np_heat;
	NoiseParams np_heat_blend;
	std::string seed;
	//returns true if there is a valid np heat, np heat blend, and seed and biome manager exists. Otherwise returns false.
	return (bmgr && settingsmgr->getMapSettingNoiseParams("mg_biome_np_heat", &np_heat) &&
			settingsmgr->getMapSettingNoiseParams(
					"mg_biome_np_heat_blend", &np_heat_blend) &&
			settingsmgr->getMapSetting("seed", &seed));
}

float NativeModApiMapgen::n_get_heat(MapSettingsManager *settingsmgr, const BiomeManager* bmgr, v3s16 pos)
{
	NoiseParams np_heat;
	NoiseParams np_heat_blend;
	std::string value;

	settingsmgr->getMapSettingNoiseParams("mg_biome_np_heat", &np_heat);
	settingsmgr->getMapSettingNoiseParams("mg_biome_np_heat_blend", &np_heat_blend);
	settingsmgr->getMapSetting("seed", &value);

	std::istringstream ss(value);
	u64 seed;
	ss >> seed;

	return bmgr->getHeatAtPosOriginal(pos, np_heat, np_heat_blend, seed);
}

bool NativeModApiMapgen::can_get_humidity(MapSettingsManager* settingsmgr, const BiomeManager* bmgr)
{
	NoiseParams np_humidity;
	NoiseParams np_humidity_blend;
	std::string seed;

	return (bmgr &&
			settingsmgr->getMapSettingNoiseParams(
					"mg_biome_np_humidity", &np_humidity) &&
			settingsmgr->getMapSettingNoiseParams(
					"mg_biome_np_humidity_blend",
					&np_humidity_blend) &&
			settingsmgr->getMapSetting("seed", &seed));
}

float NativeModApiMapgen::n_get_humidity(MapSettingsManager* settingsmgr, const BiomeManager* bmgr, v3s16 pos)
{
	NoiseParams np_humidity;
	NoiseParams np_humidity_blend;
	std::string value;

	settingsmgr->getMapSettingNoiseParams("mg_biome_np_humidity", &np_humidity);
	settingsmgr->getMapSettingNoiseParams("mg_biome_np_humidity_blend", &np_humidity_blend);
	settingsmgr->getMapSetting("seed", &value);

	std::istringstream ss(value);
	u64 seed;
	ss >> seed;

	return bmgr->getHumidityAtPosOriginal(pos, np_humidity, np_humidity_blend, seed);
}

bool NativeModApiMapgen::can_get_biome_data(MapSettingsManager *settingsmgr, const BiomeManager *bmgr, v3s16 pos)
{
	if (!can_get_heat(settingsmgr, bmgr) || !can_get_humidity(settingsmgr, bmgr))
		return false;
	float heat = n_get_heat(settingsmgr, bmgr, pos);
	float humidity = n_get_humidity(settingsmgr, bmgr, pos);
	const Biome *biome = bmgr->getBiomeFromNoiseOriginal(heat, humidity, pos);
	if (biome == nullptr || biome->index == OBJDEF_INVALID_INDEX)
		return false; 
	return true;
}

NativeModApiMapgen::BiomeData NativeModApiMapgen::n_get_biome_data(MapSettingsManager *settingsmgr, const BiomeManager *bmgr, v3s16 pos)
{
	BiomeData b;
	b.heat = n_get_heat(settingsmgr, bmgr, pos);
	b.humidity = n_get_humidity(settingsmgr, bmgr, pos);
	const Biome* biome = bmgr->getBiomeFromNoiseOriginal(b.heat, b.humidity, pos);
	b.index = biome->index;
	return b;
}

enum MapgenObject NativeModApiMapgen::n_get_mapgen_object(const char* mgobjstr)
{
	int mgobjint;
	bool res = string_to_enum(es_MapgenObject, mgobjint, mgobjstr ? mgobjstr : "");
	//uses -1 as error value
	if (!res)
		return (MapgenObject)-1;
	return (MapgenObject)mgobjint;
}

int NativeModApiMapgen::n_get_spawn_level(EmergeManager* emerge, s16 x, s16 z)
{
	return emerge->getSpawnLevelAtPoint(v2s16(x, z));
}

NativeModApiMapgen::MapgenParams NativeModApiMapgen::n_get_mapgen_params(MapSettingsManager *settingsmgr)
{
	MapgenParams mp;
	settingsmgr->getMapSetting("mg_name", &mp.mg_name);
	settingsmgr->getMapSetting("seed", &mp.seed);
	settingsmgr->getMapSetting("water_level", &mp.water_level);
	settingsmgr->getMapSetting("chunksize", &mp.chunk_size);
	settingsmgr->getMapSetting("flags", &mp.flags);
	return mp;
}

void NativeModApiMapgen::n_set_mapgen_params(MapSettingsManager *settingsmgr, MapgenParams &mp)
{
	settingsmgr->setMapSetting("mg_name", mp.mg_name, true);
	settingsmgr->setMapSetting("seed", mp.seed, true);
	settingsmgr->setMapSetting("water_level", mp.water_level, true);
	settingsmgr->setMapSetting("chunksize", mp.chunk_size, true);
	settingsmgr->setMapSetting("flags", mp.flags, true);
}
//will return false if retrieval unsuccessful
bool NativeModApiMapgen::n_get_mapgen_setting(MapSettingsManager *settingsmgr, const char *name, std::string& setting)
{
	return settingsmgr->getMapSetting(name, &setting);
}
bool NativeModApiMapgen::n_get_mapgen_setting_noiseparams(MapSettingsManager *settingsmgr, const char *name, NoiseParams& np)
{
	return settingsmgr->getMapSettingNoiseParams(name, &np);
}

void NativeModApiMapgen::n_set_mapgen_setting(MapSettingsManager *settingsmgr,
		const char *name, const char *value, const bool overridemeta)
{
	bool res = settingsmgr->setMapSetting(name, value, overridemeta);
	if (!res)
	{
		errorstream << "set_mapgen_setting: cannot set '" << name
			    << "' after initialization" << std::endl;
	}
}

void NativeModApiMapgen::n_set_mapgen_setting_noiseparams(MapSettingsManager* settingsmgr,
	const char* name, const NoiseParams& np, const bool overridemeta)
{
	bool res = settingsmgr->setMapSettingNoiseParams(name, &np, overridemeta);
	if (!res)
	{
		errorstream << "set_mapgen_setting_noiseparams: cannot set '" << name
			    << "' after initialization" << std::endl;
	}
}

void NativeModApiMapgen::n_set_noiseparams(const char* name, const bool set_default, const NoiseParams& np)
{
	Settings::getLayer(set_default ? SL_DEFAULTS : SL_GLOBAL)->setNoiseParams(name, np);
}

bool NativeModApiMapgen::n_get_noiseparams(const std::string &name, NoiseParams &np)
{
	return g_settings->getNoiseParams(name, np);
}

void NativeModApiMapgen::n_set_gen_notify(EmergeManager* emerge, const bool change_notify, const u32 flags, const u32 flagmask,
	std::vector<u32> deco_ids)
{
	if (change_notify)
	{
		emerge->gen_notify_on &= ~flagmask;
		emerge->gen_notify_on |= flags;
	}

	for (u32 deco_id : deco_ids)
	{
		emerge->gen_notify_on_deco_ids.insert(deco_id);
	}
}

std::vector<u32> NativeModApiMapgen::n_get_gen_notify(const EmergeManager* emerge)
{
	std::vector<u32> deco_ids;
	for (auto iter = emerge->gen_notify_on_deco_ids.begin();
		iter != emerge->gen_notify_on_deco_ids.end(); iter++)
	{
		deco_ids.push_back(*iter);
	}
	return deco_ids;
}

bool NativeModApiMapgen::n_get_decoration_id(const char *deco_string, const DecorationManager *dmgr, int &deco_id)
{
	//check if string or manager are null
	if (!deco_string || !dmgr)
		return false;

	Decoration *deco = (Decoration *)dmgr->getByName(deco_string);

	//check decoration itself
	if (!deco)
		return false;
	deco_id = deco->index;
	return true;
}

bool NativeModApiMapgen::n_register_biome(BiomeManager* bmgr, Biome* biome, ObjDefHandle& handle)
{
	if (biome == nullptr)
		return false;
	handle = bmgr->add(biome);
	if (handle == OBJDEF_INVALID_HANDLE)
	{
		delete biome;
		return false;
	}
	return true;
}

ObjDefHandle NativeModApiMapgen::n_register_decoration(const NodeDefManager *ndef, DecorationManager *decomgr, Decoration *deco)
{
	ndef->pendNodeResolve(deco);	
	ObjDefHandle handle = decomgr->add(deco);
	if (!handle)
	{
		delete deco;
		return OBJDEF_INVALID_HANDLE;
	}

	return handle;
}

ObjDefHandle NativeModApiMapgen::n_register_ore(const NodeDefManager* ndef, OreManager* oremgr, Ore* ore)
{
	ndef->pendNodeResolve(ore);
	ObjDefHandle handle = oremgr->add(ore);
	if (!handle)
	{
		delete ore;
		return OBJDEF_INVALID_HANDLE;
	}

	return handle;
}

ObjDefHandle NativeModApiMapgen::n_register_schematic(SchematicManager* schemmgr, Schematic* schem)
{
	ObjDefHandle handle = schemmgr->add(schem);
	if (!handle)
	{
		delete schem;
		return OBJDEF_INVALID_HANDLE;
	}
	return handle;
}

void NativeModApiMapgen::n_clear_registered_biomes(BiomeManager* bmgr)
{
	bmgr->clear();
}

void NativeModApiMapgen::n_clear_registered_decorations(DecorationManager *dmgr)
{
	dmgr->clear();
}

void NativeModApiMapgen::n_clear_registered_ores(OreManager* omgr)
{
	omgr->clear();
}

void NativeModApiMapgen::n_clear_registered_schematics(SchematicManager* smgr)
{
	smgr->clear();
}

void NativeModApiMapgen::n_generate_ores(Mapgen &mg, OreManager *oremgr,const v3s16 &pmin, const v3s16 &pmax)
{
	u32 blockseed = Mapgen::getBlockSeed(pmin, mg.seed);
	oremgr->placeAllOres(&mg, blockseed, pmin, pmax);
}

void NativeModApiMapgen::n_generate_decorations(Mapgen& mg, DecorationManager* decomgr,const v3s16& pmin,const v3s16& pmax)
{
	u32 blockseed = Mapgen::getBlockSeed(pmin, mg.seed);
	decomgr->placeAllDecos(&mg, blockseed, pmin, pmax);
}

void NativeModApiMapgen::n_create_schematic(const NodeDefManager *ndef, Schematic &schem, const std::string &filename)
{
	schem.saveSchematicToFile(filename, ndef);
	actionstream << "create_schematic: saved schematic file '" << filename << "'."
		     << std::endl;
}

