function scr_steamInit() {
	
	global.steamAPI = false;
	if (BUILDTYPE == "Web") exit;
	
	if (steam_initialised()) {
		global.steamAPI = true;
		show_debug_message("scr_steamInit, steam_get_app_id: {0}", steam_get_app_id());
		show_debug_message("scr_steamInit, steam_stats_ready: {0}", steam_stats_ready());
		show_debug_message("scr_steamInit, steam_is_user_logged_on: {0}", steam_is_user_logged_on());
	}
	
}