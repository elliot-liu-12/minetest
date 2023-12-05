#include "native_metadata.h"

int NativeMetaDataRef::native_contains(Metadata* meta, std::string name)
{
	if (meta->contains(name)) {
		return 1;
	}
	return 0;
}

std::string NativeMetaDataRef::native_get(Metadata *meta, std::string name, std::string str, MetaDataRef *ref)
{
	bool condition = meta->getStringToRef(name, str);
	if (condition) {
		return str;
	}
	return "";
}

std::string  NativeMetaDataRef::native_get_string(Metadata *meta, std::string name, std::string str)
{
	str = "";
	str = meta->getString(name);
	return str;
}

int NativeMetaDataRef::native_set_string(Metadata *meta, std::string name, std::string str, MetaDataRef *ref)
{
	meta->setString(name, str);
	ref->reportMetadataChange(&name);
	return 0;
}

std::string NativeMetaDataRef::native_get_int(Metadata *meta, std::string name, MetaDataRef *ref)
{
	std::string result = "";
	meta = ref->getmeta(false);
	
	if (meta == NULL) {
		return result;
	}

	result = meta->getString(name);

	return result;
}

int NativeMetaDataRef::native_set_int(Metadata *meta, std::string name, MetaDataRef *ref, int a)
{
	meta = ref->getmeta(true);
	std::string str = itos(a);

	if (meta == NULL || str == meta->getString(name)) {
		return -1;
	}
	
	meta->setString(name, str);
	ref->reportMetadataChange(&name);

	return 0;
}

std::string NativeMetaDataRef::native_get_float(Metadata *meta, std::string name, MetaDataRef *ref)
{
	meta = ref->getmeta(false);
	if (meta == NULL) {
		return "";
	}

	const std::string &str = meta->getString(name);

	return str;
}

int NativeMetaDataRef::native_set_float(Metadata *meta, std::string name, MetaDataRef *ref, float a)
{
	meta = ref->getmeta(true);
	std::string str = ftos(a);

	if (meta == NULL || str == meta->getString(name)) {
		return 0;
	}

	meta->setString(name, str);
	ref->reportMetadataChange(&name);

	return 0;
}

int NativeMetaDataRef::native_to_table(Metadata *meta, MetaDataRef *ref)
{
	meta = ref->getmeta(true);
	
	if (meta == NULL) {
		return -1;
	}

	return 0;
}

int NativeMetaDataRef::native_from_table(Metadata *meta, MetaDataRef *ref)
{
	meta = ref->getmeta(true);
	
	if (meta == NULL) {
		return -1;
	}
	
	return 0;
}

int NativeMetaDataRef::native_equals(MetaDataRef *ref1, MetaDataRef *ref2)
{
	Metadata *data1 = ref1->getmeta(false);
	Metadata *data2 = ref2->getmeta(false);

	if (data1 == NULL || data2 == NULL) {
		return -1;
	}

	return 0;
}
