#pragma once

#include "lua_api/l_base.h"

class NodeTimerRef;

class NativeNodeTimerRef
{
public:
	static int native_set(f32 t, f32 e, NodeTimerRef *o);
	static int native_start(f32 t, int e, NodeTimerRef *o);
	static int native_stop(NodeTimerRef *o);
	static bool native_is_started(NodeTimerRef *o);
	static f32 native_get_timeout(NodeTimerRef *o);
	static f32 native_get_elapsed(NodeTimerRef *o);
};
