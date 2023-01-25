/// @description Insert description here
// You can write your code in this editor
if (global.steamAPI) {
//clear all achievements

show_message("clearing all achievements");
steam_clear_achievement("SA_open-file");
steam_clear_achievement("SA_chain");
steam_clear_achievement("SA_tag-token");
steam_clear_achievement("SA_trail-100");
steam_clear_achievement("SA_all-impots");
steam_clear_achievement("SA_play-audio");
steam_clear_achievement("SA_tree-10");
steam_clear_achievement("SA_quicklink");
steam_clear_achievement("SA_mw-search");
steam_clear_achievement("SA_export");
steam_clear_achievement("SA_clique");

steam_reset_all_stats();
}