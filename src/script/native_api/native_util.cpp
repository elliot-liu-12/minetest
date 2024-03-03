#include "lua_api/l_util.h"
#include "native_util.h"
#include "convert_json.h"
#include "porting.h"
#include "util/base64.h"
#include "util/auth.h"
#include "lua_api/l_settings.h"
#include "porting.h"
#include "serialization.h"
#include "settings.h"
#include "version.h"
#include "util/sha1.h"


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

HitParams nativeModApiUtil::n_util_get_hit_params(ItemGroupList& groups, ToolCapabilities& tp, float time_from_last_punch)
{
	if (!time_from_last_punch)
		return getHitParams(groups, &tp);
	else
		return getHitParams(groups, &tp, time_from_last_punch);
}

bool nativeModApiUtil::n_util_check_password_entry(std::string name, std::string entry, std::string password)
{
	if (base64_is_valid(entry)) {
		std::string hash = translate_password(name, password);
		return hash == entry;
	}

	std::string salt;
	std::string verifier;

	if (!decode_srp_verifier_and_salt(entry, &verifier, &salt)) {
		// invalid format
		warningstream << "Invalid password format for " << name << std::endl;
		return false;
	}
	std::string gen_verifier = generate_srp_verifier(name, password, salt);

	return gen_verifier == verifier;
}

std::string nativeModApiUtil::n_util_get_password_hash(std::string name, std::string raw_password)
{
	return translate_password(name, raw_password);
}

bool nativeModApiUtil::n_util_is_yes(std::string str)
{
	return is_yes(str);
}

std::string nativeModApiUtil::n_util_get_builtin_path()
{
	return porting::path_share + DIR_DELIM + "builtin" + DIR_DELIM;
}

std::string nativeModApiUtil::n_util_get_user_path()
{
	return porting::path_user;
}

std::string nativeModApiUtil::n_util_compress(const char *data, size_t size, float level)
{
	std::ostringstream os;
	compressZlib(std::string(data, size), os, level);

	return os.str();
}

std::string nativeModApiUtil::n_util_decompress(const char* data, size_t size)
{
	std::istringstream is(std::string(data, size));
	std::ostringstream os;
	decompressZlib(is, os);

	return os.str();
}

bool nativeModApiUtil::n_util_mkdir(const char* path)
{
	return fs::CreateAllDirs(path);
}

std::vector<fs::DirListNode> nativeModApiUtil::n_util_get_dir_list(const char *path)
{
	return fs::GetDirListing(path);
}

bool nativeModApiUtil::n_util_safe_file_write(const char *path, size_t size, const char *content)
{
	return fs::safeWriteToFile(path, std::string(content, size));
}

int nativeModApiUtil::n_util_request_insecure_environment(std::string mod_name)
{
	std::string trusted_mods = g_settings->get("secure.trusted_mods");
	trusted_mods.erase(std::remove_if(trusted_mods.begin(), trusted_mods.end(),
					   static_cast<int (*)(int)>(&std::isspace)),
			trusted_mods.end());
	std::vector<std::string> mod_list = str_split(trusted_mods, ',');
	if (std::find(mod_list.begin(), mod_list.end(), mod_name) == mod_list.end()) {
		return 0;
	} 

	return 1;
}

std::string nativeModApiUtil::n_util_encode_base64(const char* data, size_t size)
{
	return base64_encode((const unsigned char *)(data), size);
}

int nativeModApiUtil::n_util_decode_base64(const char* d, size_t size, std::string& out)
{
	const std::string data = std::string(d, size);

	if (!base64_is_valid(data))
		return 0;

	out = base64_decode(data);
	return 1;
}

bool nativeModApiUtil::n_util_get_version()
{
	return strcmp(g_version_string, g_version_hash) != 0;
}

void nativeModApiUtil::n_util_sha1(const char *data, size_t size, std::string data_sha1)
{
	{
		SHA1 ctx;
		ctx.addBytes(data, size);
		unsigned char *data_tmpdigest = ctx.getDigest();
		data_sha1.assign((char *)data_tmpdigest, 20);
		free(data_tmpdigest);
	}
}