// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_addToListOnce(list, value){
	
	// quick function for adding to a list...
	// ...if and only if the value is not already in the list!
	
	if (ds_list_find_index(list, value) == -1) {
		ds_list_add(list, value);
	}

}