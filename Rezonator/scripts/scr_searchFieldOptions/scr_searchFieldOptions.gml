// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_searchFieldOptions(optionSelected){
	show_debug_message("scr_searchFieldOptions, setting searchField to " + string(optionSelected));
	obj_control.searchField = string(optionSelected);
}