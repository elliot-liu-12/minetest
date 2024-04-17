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

std::set<std::string> nativeModApiServer::n_server_get_player_privs(Server *server, const char *name)
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

bool nativeModApiServer::n_server_show_formspec(Server* server, const char* playername, const char* formname, const char* formspec)
{
	return server->showFormspec(playername, formspec, formname);
}

int nativeModApiServer::n_server_get_current_modname()
{
	return 1;
}

const ModSpec* nativeModApiServer::n_server_get_modpath(Server* server, std::string modname)
{
	return server->getModSpec(modname);
}

std::vector<std::string> nativeModApiServer::n_server_get_modnames(Server* server)
{
	std::vector<std::string> modlist;
	server->getModNames(modlist);
	std::sort(modlist.begin(), modlist.end());

	return modlist;
}

std::string nativeModApiServer::n_server_get_worldpath(Server* server)
{
	return server->getWorldPath();
}

s32 nativeModApiServer::n_server_sound_play(Server* server, SimpleSoundSpec& spec, ServerSoundParams& params, bool ephemeral)
{
	if (ephemeral)
		return server->playSound(spec, params, true);
	else
		return server->playSound(spec, params);
}

void nativeModApiServer::n_server_sound_stop(Server* server, s32 handle)
{
	server->stopSound(handle);
}

void nativeModApiServer::n_server_sound_fade(Server* server, s32 handle, float step, float gain)
{
	server->fadeSound(handle, step, gain);
}

bool nativeModApiServer::n_server_dynamic_add_media_raw(Server* server, std::string& filepath, std::vector<RemotePlayer*>& sent_to)
{
	return server->dynamicAddMedia(filepath, sent_to);
}

bool nativeModApiServer::n_server_is_singleplayer(Server* server)
{
	return server->isSingleplayer();
}

void nativeModApiServer::n_server_notify_authentication_modified(Server* server, std::string name)
{
	server->reportPrivsModified(name);
}

bool nativeModApiServer::n_server_get_last_run_mod(std::string current_mod)
{
	return current_mod.empty();
}

int nativeModApiServer::n_server_set_last_run_mod()
{
	return 0;
}

