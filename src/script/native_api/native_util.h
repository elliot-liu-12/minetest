#pragma once

#include "lua_api/l_base.h"
#include "log.h"
#include <json/json.h>
#include "tool.h"
#include "filesys.h"

// Alice Sun


class nativeModApiUtil
{
public:
	static LogLevel n_util_log(std::string name);
	static irr::u64 n_util_get_us_time();
	static int n_util_parse_json(const char *jsonstr, Json::Value &root);
	static std::string n_util_write_json(bool styled, Json::Value &root);
	static DigParams n_util_get_dig_params(ItemGroupList &groups, ToolCapabilities &tp);
	static HitParams n_util_get_hit_params(ItemGroupList &groups, ToolCapabilities &tp, float time_from_last_punch);
	static bool n_util_check_password_entry(std::string name, std::string entry, std::string password);
	static std::string n_util_get_password_hash(std::string name, std::string raw_password);
	static bool n_util_is_yes(std::string str);
	static std::string n_util_get_builtin_path();
	static std::string n_util_get_user_path();
	static std::string n_util_compress(const char *data, size_t size, float level);
	static std::string n_util_decompress(const char *data, size_t size);
	static bool n_util_mkdir(const char *path);
	static std::vector<fs::DirListNode> n_util_get_dir_list(const char *path);
	static bool n_util_safe_file_write(const char *path, size_t size, const char *content);
	static int n_util_request_insecure_environment(std::string mod_name);
	static std::string n_util_encode_base64(const char *data, size_t size);
	static int n_util_decode_base64(const char *d, size_t size, std::string& out);
	static bool n_util_get_version();
	static void n_util_sha1(const char *data, size_t size, std::string& data_sha1);
};