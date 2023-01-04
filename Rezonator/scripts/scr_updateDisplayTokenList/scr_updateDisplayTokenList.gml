function scr_updateDisplayTokenList(displayTokenInsert){
	
	
	with(obj_control){
		if (ds_list_find_index(displayTokenList, displayTokenInsert) != -1)
			exit;
		if (ds_list_size(displayTokenList) < 3){
			ds_list_add(displayTokenList, displayTokenInsert);	
		}
		else{
			ds_list_delete(displayTokenList, 0);
			if (is_string(global.tokenImportDisplayTokenColName) && global.tokenImportDisplayTokenColName != "") {
				scr_addToListOnce(displayTokenList, global.tokenImportDisplayTokenColName);
			}
			scr_addToListOnce(displayTokenList, displayTokenInsert);
		}
	}
}