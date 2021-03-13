// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_listSwap(list, indexA, indexB){
	
	// takes a list and swaps the positions of indexA and indexB
	var valueA = ds_list_find_value(list, indexA);
	var valueB = ds_list_find_value(list, indexB);
	ds_list_set(list, indexA, valueB);
	ds_list_set(list, indexB, valueA);

}