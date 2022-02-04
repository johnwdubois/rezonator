

function scr_steamInit(){
	
	show_debug_message("scr_steamInit");
	
	if (steam_initialised()) {
		show_debug_message("steam initialised!");
		var steamStatsReady = steam_stats_ready();
		var steamOverlay = steam_is_overlay_enabled();
		var steamAppID = steam_get_app_id();

		//show_message("steamStatsReady: " + string(steamStatsReady) + " \nsteamOverlay: " + string(steamOverlay) + " \nsteamAppID: " + string(steamAppID));
	
		if (steamStatsReady && steamOverlay) {
			global.steamAPI = true;
		}
	}

	//show_message("steamAPI: " + string(global.steamAPI));
	
}