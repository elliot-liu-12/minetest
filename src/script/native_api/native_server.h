#pragma once

#include "lua_api/l_base.h"
#include "server.h"
#include <set>

// Alice Sun


class nativeModApiServer
{
public:
	static void n_server_request_shutdown(Server* server, const std::string &msg, bool reconnect, float delay);
	static std::string n_server_get_server_status(Server* server);
	static double n_server_get_server_uptime(Server* server);
	static void n_server_print(Server* server, std::string text);
	static void n_server_chat_send_all(Server* server, const char* text);
	static void n_server_chat_send_player(Server* server, const char* name, const char* text);
	static std::set<std::string> n_server_get_player_privs(Server* server, const char* name);
	static RemotePlayer* n_server_get_player_ip(Server* server, const char* name);
	static RemotePlayer* n_server_get_player_information(Server* server, const char* name);
	static std::string n_server_get_ban_list(Server* server);
	static std::string n_server_get_ban_description(Server* server, std::string ip_or_name);
	static RemotePlayer* n_server_ban_player(Server* server, const char* name);
	static void n_server_kick_player(Server* server, session_t &peerId, std::string message);
	static RemotePlayer* n_server_remove_player(ServerEnvironment* s_env, std::string name);
	static void n_server_unban_player_or_ip(Server* server, const char* ip_or_name);
	static bool n_server_show_formspec(Server* server, const char* playername, const char* formname, const char* formspec);
	static int n_server_get_current_modname();
	static const ModSpec* n_server_get_modpath(Server* server, std::string modname);
	static std::vector<std::string> n_server_get_modnames(Server* server);
	static std::string n_server_get_worldpath(Server *server);
	static s32 n_server_sound_play(Server* server, SimpleSoundSpec& spec, ServerSoundParams& params, bool ephemeral);
	static void n_server_sound_stop(Server* server, s32 handle);
	static void n_server_sound_fade(Server* server, s32 handle, float step, float gain);
	static bool n_server_dynamic_add_media_raw(Server* server, std::string& filepath, std::vector<RemotePlayer*>& sent_to);
	static bool n_server_is_singleplayer(Server* server);
	static void n_server_notify_authentication_modified(Server* server, std::string name);
	static bool n_server_get_last_run_mod(std::string current_mod);
	static int n_server_set_last_run_mod();
};