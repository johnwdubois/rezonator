// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_refreshCliques(){
	show_debug_message("scr_refreshCliques, START" + scr_printTime());
	scr_clearCliqueMap();
	scr_cliqueDetection();
	scr_chainOrderMap();
	show_debug_message("scr_refreshCliques, END" + scr_printTime());
}