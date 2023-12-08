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
	static int native_contains(MetaDataRef* ref, std::string name);

	// get(self, name)
	static int native_get(MetaDataRef *ref, std::string name, std::string &str);

	// get_string(self, name)
	static int native_get_string(MetaDataRef *ref, std::string name, std::string &str);

	// set_string(self, name, var)
	static int native_set_string(std::string name, size_t len, const char *s, MetaDataRef *ref);

	// get_int(self, name)
	static std::string native_get_int(MetaDataRef *ref, std::string name, std::string &result);

	// set_int(self, name, var)
	static int native_set_int(std::string name, MetaDataRef *ref, int a);

	// get_float(self, name)
	static std::string native_get_float(std::string name, MetaDataRef *ref);

	// set_float(self, name, var)
	static int native_set_float(std::string name, MetaDataRef *ref, float a);

	// to_table(self)
	static int native_to_table(MetaDataRef *ref);

	// from_table(self, table)
	static int native_from_table(MetaDataRef *ref);

	// equals(self, other)
	static int native_equals(MetaDataRef *ref1, MetaDataRef *ref2);
};
