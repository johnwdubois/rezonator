/// @description Clear Steam achievements
if (global.steamAPI) {
	show_message("Clearing all Steam achievements");
	steam_reset_all_stats_achievements();
}