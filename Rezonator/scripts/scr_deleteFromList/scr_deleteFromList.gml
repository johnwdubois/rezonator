// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromList(list, item){
	
	// this script provides an easy way to make sure you are removing something from a list
	// even if it is in the list multiple times!
	
	// make sure the list exists
	if (!is_numeric(list)) {
		show_debug_message("scr_deleteFromList() ... list is non-numeric, exiting...");
		exit;
	}
	if (!ds_exists(list, ds_type_list)) {
		show_debug_message("scr_deleteFromList() ... list does not exist, exiting...");
		exit;
	}

	// as long as we are able to find the item in the list, delete it from the list
	var index = ds_list_find_index(list, item);
	while (index >= 0) {
		show_debug_message("scr_deleteFromList() ... deleting index " + string(index) + " from " + scr_getStringOfList(list));
		ds_list_delete(list, index);
		
		index = ds_list_find_index(list, item);
	}
}