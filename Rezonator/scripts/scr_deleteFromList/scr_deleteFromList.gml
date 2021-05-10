// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromList(list, item){
	
	// this script provides an easy way to make sure you are removing something from a list
	// even if it is in the list multiple times!
	
	// make sure the list exists
	if (!scr_isNumericAndExists(list, ds_type_list)) {
		show_debug_message("scr_deleteFromList() ... list is invalid. Exiting...")
		exit;
	}

	// as long as we are able to find the item in the list, delete it from the list
	var index = ds_list_find_index(list, item);
	while (index >= 0) {
		show_debug_message("scr_deleteFromList() ... deleting index " + string(index) + " from list " + string(list));
		ds_list_delete(list, index);
		
		index = ds_list_find_index(list, item);
	}
}