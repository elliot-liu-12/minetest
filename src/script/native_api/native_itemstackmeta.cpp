#include "native_itemstackmeta.h"

int NativeItemStackMetaRef::native_set_tool_capabilities(ItemStackMetaRef *metaref, int x, ToolCapabilities caps = 0)
{
	if (x == 1) {
		metaref->clearToolCapabilities();
	} else if(x == 0){
		metaref->setToolCapabilities(caps);
	}
	return 0;
}
