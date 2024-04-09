#pragma once

#include "lua_api/l_base.h"
#include "lua_api/l_metadata.h"
#include "irrlichttypes_bloated.h"
#include "nodemetadata.h"

// Alice Sun


class nativeModApiNodemeta
{
public:
	static void n_get_inventory(NodeMetaRef *ref);
	static NodeMetadata* n_mark_as_private(NodeMetadata *meta, NodeMetaRef *ref, int flag);
};