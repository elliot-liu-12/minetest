#include "lua_api/l_util.h"
#include "native_util.h"
#include "convert_json.h"
#include "porting.h"

LogLevel nativeModApiUtil::n_util_log(std::string name)
{
	LogLevel level = Logger::stringToLevel(name);
	if (level == LL_MAX) {
		warningstream << "Tried to log at unknown level '" << name
			      << "'.  Defaulting to \"none\"." << std::endl;
		level = LL_NONE;
	}

	return level;
}

irr::u64 nativeModApiUtil::n_util_get_us_time()
{
	return porting::getTimeUs();
}

int nativeModApiUtil::n_util_parse_json(const char *jsonstr, Json::Value &root)
{
	std::istringstream stream(jsonstr);

	Json::CharReaderBuilder builder;
	builder.settings_["collectComments"] = false;
	std::string errs;

	if (!Json::parseFromStream(builder, stream, &root, &errs)) {
		errorstream << "Failed to parse json data " << errs << std::endl;
		size_t jlen = strlen(jsonstr);
		if (jlen > 100) {
			errorstream << "Data (" << jlen
				    << " bytes) printed to warningstream." << std::endl;
			warningstream << "data: \"" << jsonstr << "\"" << std::endl;
		} else {
			errorstream << "data: \"" << jsonstr << "\"" << std::endl;
		}
		//lua_pushnil(L);
		return 1;
	}

	return 0;
}

std::string nativeModApiUtil::n_util_write_json(bool styled, Json::Value& root)
{
	if (styled) {
		return root.toStyledString();
	} else {
		return fastWriteJson(root);
	}
}

DigParams nativeModApiUtil::n_util_get_dig_params(ItemGroupList &groups, ToolCapabilities &tp)
{
	return getDigParams(groups, &tp);
}