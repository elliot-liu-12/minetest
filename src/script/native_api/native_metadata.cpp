#include "native_metadata.h"

int NativeMetaDataRef::native_contains(MetaDataRef *ref, std::string name)
{
	Metadata *meta = ref->getmeta(false);
	if (meta == NULL)
		return -1;
	return (int)meta->contains(name);
}

int NativeMetaDataRef::native_get(MetaDataRef *ref, std::string name, std::string &str)
{
	Metadata *meta = ref->getmeta(false);
	if (meta == NULL) {
		return -1;
	}
	bool condition = meta->getStringToRef(name, str);
	if (condition) {
		return 1;
	}
	return 0;
}

int NativeMetaDataRef::native_get_string(MetaDataRef *ref, std::string name, std::string &str)
{
	Metadata *meta = ref->getmeta(false);
	if (meta == NULL) {
		return -1;
	}
	str = meta->getString(name);
	return 0;
}

int NativeMetaDataRef::native_set_string(std::string name, size_t len, const char *s, MetaDataRef *ref)
{
	std::string str(s, len);
	Metadata *meta = ref->getmeta(!str.empty());
	if (meta == NULL || str == meta->getString(name)) {
		return -1;
	} else {
		meta->setString(name, str);
		ref->reportMetadataChange(&name);
		return 0;
	}
}

std::string NativeMetaDataRef::native_get_int(MetaDataRef *ref, std::string name, std::string &result)
{	
	Metadata *meta = ref->getmeta(false);
	result = "";
	if (meta == NULL) {
		return result;
	}
	result = meta->getString(name);
	return result;
}

int NativeMetaDataRef::native_set_int(std::string name, MetaDataRef *ref, int a)
{
	std::string str = itos(a);
	Metadata *meta = ref->getmeta(true);
	if (meta == NULL || str == meta->getString(name)) {
		return -1;
	}
	meta->setString(name, str);
	ref->reportMetadataChange(&name);
	return 0;
}

std::string NativeMetaDataRef::native_get_float(std::string name, MetaDataRef *ref)
{
	Metadata *meta = ref->getmeta(false); 
	if (meta == NULL) {
		return "";
	}
	const std::string &str = meta->getString(name);
	return str;
}

int NativeMetaDataRef::native_set_float(std::string name, MetaDataRef *ref, float a)
{
	std::string str = ftos(a);
	Metadata *meta = ref->getmeta(true);
	if (meta == NULL || str == meta->getString(name)) {
		return 0;
	}
	meta->setString(name, str);
	ref->reportMetadataChange(&name);
	return 0;
}

int NativeMetaDataRef::native_to_table(MetaDataRef *ref)
{
	Metadata *meta = ref->getmeta(true);
	if (meta == NULL) {
		return -1;
	}
	return 0;
}

int NativeMetaDataRef::native_from_table(MetaDataRef *ref)
{
	Metadata *meta = ref->getmeta(true);
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
