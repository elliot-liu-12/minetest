#include "native_modchannels.h"
#include "modchannels.h"

int NativeModChannelRef::native_leave(ModChannelRef *ref, IGameDef *gamedefpointer)
{
	std::string result = ref->get_m_modchannel_name();
	gamedefpointer->leaveModChannel(result);
	return 0;
}

bool NativeModChannelRef::native_is_writeable(ModChannel *channel)
{
	if (channel->canWrite())
		return true;
	return false;
}

int NativeModChannelRef::native_send_all(ModChannel *channel, std::string message, IGameDef *gamedefpointer)
{
	gamedefpointer->sendModChannelMessage(channel->getName(), message);
	return 0;
}