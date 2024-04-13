#pragma once

#include "lua_api/l_base.h"

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
};