#pragma once

#include "lua_api/l_base.h"
#include "lua_api/l_metadata.h"
#include "lua_api/l_itemstackmeta.h"
#include "irrlichttypes_bloated.h"
#include "inventory.h"
#include "../../itemstackmetadata.h"
#include "../../tool.h"
#include <tuple>

struct ToolCapabilities;

class NativeItemStackMetaRef : public MetaDataRef
{
public:
	static int native_set_tool_capabilities(ItemStackMetaRef *metaref, int x, ToolCapabilities caps);
};
