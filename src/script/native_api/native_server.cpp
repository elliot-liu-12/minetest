#include "lua_api/l_server.h"
#include "native_server.h"
#include "server.h"



void nativeModApiServer::n_server_request_shutdown(Server* server, const std::string &msg, bool reconnect, float delay)
{
	server->requestShutdown(msg, reconnect, delay);
}

std::string nativeModApiServer::n_server_get_server_status(Server* server)
{
	return server->getStatusString();
}

double nativeModApiServer::n_server_get_server_uptime(Server* server)
{
	return server->getUptime();
}

void nativeModApiServer::n_server_print(Server* server, std::string text)
{
	server->printToConsoleOnly(text);
}

void nativeModApiServer::n_server_chat_send_all(Server* server, const char* text)
{
	server->notifyPlayers(utf8_to_wide(text));
}

void nativeModApiServer::n_server_chat_send_player(Server* server, const char* name, const char* text)
{
	server->notifyPlayer(name, utf8_to_wide(text));
}

std::set<std::string> nativeModApiServer::n_server_get_player_privs(Server* server, const char* name)
{
	return server->getPlayerEffectivePrivs(name);
}

RemotePlayer* nativeModApiServer::n_server_get_player_ip(Server* server, const char* name)
{
	return server->getEnv().getPlayer(name);
}

RemotePlayer* nativeModApiServer::n_server_get_player_information(Server* server, const char* name)
{
	return server->getEnv().getPlayer(name);
}

std::string nativeModApiServer::n_server_get_ban_list(Server* server)
{
	return server->getBanDescription("");
}

std::string nativeModApiServer::n_server_get_ban_description(Server* server, std::string ip_or_name)
{
	return server->getBanDescription(std::string(ip_or_name));
}

RemotePlayer* nativeModApiServer::n_server_ban_player(Server* server, const char* name)
{
	return server->getEnv().getPlayer(name);
}

void nativeModApiServer::n_server_kick_player(Server* server, session_t &peerId, std::string message)
{
	server->DenyAccess_Legacy(peerId, utf8_to_wide(message));
}

RemotePlayer* nativeModApiServer::n_server_remove_player(ServerEnvironment* s_env, std::string name)
{
	return s_env->getPlayer(name.c_str());
}

void nativeModApiServer::n_server_unban_player_or_ip(Server* server, const char* ip_or_name)
{
	server->unsetIpBanned(ip_or_name);
}

