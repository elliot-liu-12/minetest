#pragma once

#include "log.h"
#include <json/json.h>
#include "tool.h"

// Alice Sun


class nativeModApiUtil
{
public:
	static LogLevel n_util_log(std::string name);
	static irr::u64 n_util_get_us_time();
	static int n_util_parse_json(const char *jsonstr, Json::Value &root);
	static std::string n_util_write_json(bool styled, Json::Value &root);
	static DigParams n_util_get_dig_params(ItemGroupList &groups, ToolCapabilities &tp);
};