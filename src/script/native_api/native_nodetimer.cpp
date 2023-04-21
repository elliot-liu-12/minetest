#include "native_nodetimer.h"
#include "lua_api/l_nodetimer.h"
#include "map.h"

int NativeNodeTimerRef::native_set(f32 t, f32 e, NodeTimerRef *o)
{
	o->get_m_map()->setNodeTimer(NodeTimer(t, e, o->get_m_p()));
	return 0;
}

int NativeNodeTimerRef::native_start(f32 t, int e, NodeTimerRef *o)
{
	o->get_m_map()->setNodeTimer(NodeTimer(t, e, o->get_m_p()));
	return 0;
}

int NativeNodeTimerRef::native_stop(NodeTimerRef *o)
{
	o->get_m_map()->removeNodeTimer(o->get_m_p());
	return 0;
}

bool NativeNodeTimerRef::native_is_started(NodeTimerRef *o)
{
	NodeTimer t = o->get_m_map()->getNodeTimer(o->get_m_p());
	bool result = (t.timeout != 0); 
	return result;
}

f32 NativeNodeTimerRef::native_get_timeout(NodeTimerRef *o)
{
	NodeTimer t = o->get_m_map()->getNodeTimer(o->get_m_p());
	f32 result = t.timeout;
	return result;
}

f32 NativeNodeTimerRef::native_get_elapsed(NodeTimerRef *o)
{
	NodeTimer t = o->get_m_map()->getNodeTimer(o->get_m_p());
	f32 result = t.elapsed;
	return result;
}
