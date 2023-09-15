#pragma once

#include "lua_api/l_base.h"
#include "../lua_api/l_modchannels.h"
#include "config.h"

class ModChannel;
class ModChannelRef;

class NativeModChannelRef
{
public:
	static int native_leave(ModChannelRef *ref, IGameDef *gamedefpointer);
	static bool native_is_writeable(ModChannel *channel);
	static int native_send_all(ModChannel *channel, std::string message, IGameDef *gamedefpointer);
};