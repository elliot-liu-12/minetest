#pragma once

#include "irrlichttypes_bloated.h"
#include "lua_api/l_base.h"
#include "./metadata.h"
#include "lua_api/l_metadata.h"

class Metadata;
class MetaDataRef;

class NativeMetaDataRef : public ModApiBase
{
	
public: //TODO supposed to be protected instead
//protected:
	// contains(self, name)
	static int native_contains(Metadata* meta, std::string name);

	// get(self, name)
	static std::string native_get(Metadata *meta, std::string name, std::string str, MetaDataRef *ref);

	// get_string(self, name)
	static std::string native_get_string(Metadata *meta, std::string name, std::string str);

	// set_string(self, name, var)
	static int native_set_string(Metadata *meta, std::string name, std::string str, MetaDataRef *ref);

	// get_int(self, name)
	static std::string native_get_int(Metadata *meta, std::string name, MetaDataRef *ref);

	// set_int(self, name, var)
	static int native_set_int(Metadata *meta, std::string name, MetaDataRef *ref, int a);

	// get_float(self, name)
	static std::string native_get_float(Metadata *meta, std::string name, MetaDataRef *ref);

	// set_float(self, name, var)
	static int native_set_float(Metadata *meta, std::string name, MetaDataRef *ref, float a);

	// to_table(self)
	static int native_to_table(Metadata *meta, MetaDataRef *ref);

	// from_table(self, table)
	static int native_from_table(Metadata *meta, MetaDataRef *ref);

	// equals(self, other)
	static int native_equals(MetaDataRef *ref1, MetaDataRef *ref2);
};
