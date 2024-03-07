//Native version of vmanip class.
//Erik Companhone.

#include "native_vmanip.h"

MMVManip* NativeLuaVoxelManip::native_read_from_map(v3s16 a, v3s16 b, MMVManip *vm)
{
	//MMVManip *vm = o->vm;
	
	v3s16 bp1 = getNodeBlockPos(a);
	v3s16 bp2 = getNodeBlockPos(b);
	sortBoxVerticies(bp1, bp2);

	vm->initialEmerge(bp1, bp2);

	return vm;
}


u32 NativeLuaVoxelManip::native_get_data(LuaVoxelManip *o)
{
	MMVManip *vm = o->vm;
	u32 volume = vm->m_area.getVolume();

	return volume;
}

u32 NativeLuaVoxelManip::native_set_data(MMVManip *vm, u32 i, content_t c)
{
	if (i == NULL && c == NULL) 
	{
		u32 volume = vm->m_area.getVolume();
		return volume;
	}
	(*vm).m_data[i].setContent(c);
	return 0;
}

int NativeLuaVoxelManip::native_write_to_map(LuaVoxelManip *o, bool update_light, ServerEnvironment *env)
{
	ServerMap *map = &(env->getServerMap());
	if (o->is_mapgen_vm || !update_light) {
		o->vm->blitBackAll(&(o->modified_blocks));
	}
	else {
		voxalgo::blit_back_with_light(map, o->vm,
			&(o->modified_blocks));
	}

	MapEditEvent event;
	event.type = MEET_OTHER;
	for (const auto &modified_block : o->modified_blocks)
		event.modified_blocks.insert(modified_block.first);

	map->dispatchEvent(event);

	o->modified_blocks.clear();

	return 0;
}

MapNode NativeLuaVoxelManip::native_get_node_at(LuaVoxelManip *o, v3s16 pos)
{
	return o->vm->getNodeNoExNoEmerge(pos);
}

int NativeLuaVoxelManip::native_set_node_at(LuaVoxelManip *o, v3s16 pos, MapNode n)
{
	o->vm->setNodeNoEmerge(pos, n);
	return 0;
}

int NativeLuaVoxelManip::native_update_map()
{
	return 0;
}

int NativeLuaVoxelManip::native_update_liquids(LuaVoxelManip *o, const NodeDefManager *ndef, Map *map, Mapgen *mg)
{
	MMVManip *vm = o->vm;

	mg->vm = vm;
	mg->ndef = ndef;
	mg->updateLiquid(&map->m_transforming_liquid,
		vm->m_area.MinEdge, vm->m_area.MaxEdge);

	return 0;
}

v3s16 NativeLuaVoxelManip::native_calc_lighting(LuaVoxelManip *o, std::string x, v3s16 pmin, v3s16 pmax, Mapgen *mg, bool propagate_shadow)
{
	if (propagate_shadow == NULL) {
		if (!o->is_mapgen_vm) {
			warningstream << "VoxelManip:calc_lighting called for a non-mapgen "
				"VoxelManip object" << std::endl;
			return v3s16(0, 0, 0);
		}

		if (x == "fpmin") {
			return o->vm->m_area.MinEdge;
		}
		else if (x == "fpmax") {
			return o->vm->m_area.MaxEdge;
		}
	}
	else {
		if (mg->vm == o->vm) {
			mg->calcLighting(pmin, pmax, o->vm->m_area.MinEdge, o->vm->m_area.MaxEdge, propagate_shadow);
		}
		else {
			sortBoxVerticies(pmin, pmax);
		}
	}
		
	return v3s16(0, 0, 0);
}

int NativeLuaVoxelManip::native_set_lighting(MMVManip *vm, v3s16 pmin, v3s16 pmax, u8 light, int x, Mapgen *mg)
{
	if (x == 1) {
		sortBoxVerticies(pmin, pmax);
		if (!vm->m_area.contains(VoxelArea(pmin, pmax))) { return -1; }
	}
	if (x == 2) {
		(*mg).setLighting(light, pmin, pmax);
	}
	return 0;
}

u32 NativeLuaVoxelManip::native_get_light_data(LuaVoxelManip *o)
{
	return o->vm->m_area.getVolume();
}

u32 NativeLuaVoxelManip::native_set_light_data(LuaVoxelManip *o, u32 i, u8 light)
{
	if (i == -1) {
		return o->vm->m_area.getVolume();
	}

	o->vm->m_data[i].param1 = light;

	return 0;
}

u32 NativeLuaVoxelManip::native_get_param2_data(LuaVoxelManip *o, u32 i)
{
	if (i == -1) {
		return o->vm->m_area.getVolume();
	}
	
	return o->vm->m_data[i].param2;
}

u32 NativeLuaVoxelManip::native_set_param2_data(LuaVoxelManip *o, u32 i, u8 param2)
{
	if (i == -1) {
		return o->vm->m_area.getVolume();
	}
	
	o->vm->m_data[i].param2 = param2;
	return 0;
}

MMVManip* NativeLuaVoxelManip::native_was_modified(LuaVoxelManip *o)
{
	MMVManip *vm = o->vm;
	return vm;
}

v3s16 NativeLuaVoxelManip::native_get_emerged_area(LuaVoxelManip *o, int x)
{
	v3s16 edge;
	if (x == 0) {
		edge = o->vm->m_area.MinEdge;
	}
	else {
		edge = o->vm->m_area.MaxEdge;
	}

	return edge;
}
