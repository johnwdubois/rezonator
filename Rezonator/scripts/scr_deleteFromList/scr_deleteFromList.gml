// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromList(list, item){

	var index = ds_list_find_index(list, item);
	while (index >= 0) {
		show_debug_message("scr_deleteFromList() ... deleting index " + string(index) + " from " + scr_getStringOfList(list));
		ds_list_delete(list, index);
		
		index = ds_list_find_index(list, item);
	}
}