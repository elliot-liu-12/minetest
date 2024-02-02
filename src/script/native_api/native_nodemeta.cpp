#include "lua_api/l_nodemeta.h"
#include "lua_api/l_internal.h"
#include "lua_api/l_inventory.h"
#include "common/c_content.h"
#include "serverenvironment.h"
#include "map.h"
#include "mapblock.h"
#include "server.h"
#include "native_nodemeta.h"

void nativeModApiNodemeta::n_get_inventory(NodeMetaRef* ref)
{
	//ref->NodeMetaRef::getmeta(true);
	std::cout << "This runs" << std::endl;
	
	ref->getmeta(true);
	std::cout << "After ref->getmeta(true) runs" << std::endl;
}

NodeMetadata* nativeModApiNodemeta::n_mark_as_private(NodeMetadata *meta, NodeMetaRef* ref, int flag)
{
	if (flag == 0) {
		meta = dynamic_cast<NodeMetadata *>(ref->getmeta(true));
		assert(meta);
		return meta;
	}
	
	if (flag == 1) {
		ref->reportMetadataChange();
		return meta;
	}
}