// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_updateDisplayTokenList(displayTokenInsert){
	with(obj_control){
		if(ds_list_find_index(displayTokenList, displayTokenInsert) != -1)
			exit;
		if(ds_list_size(displayTokenList) < 3){
			ds_list_add(displayTokenList, displayTokenInsert);	
		}
		else{
			ds_list_delete(displayTokenList,0);
			ds_list_add(displayTokenList, displayTokenInsert);	
		}
	}
}