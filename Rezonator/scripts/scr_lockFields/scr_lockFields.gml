function scr_lockFields(){
	var fieldMap = "";
	var fieldListSize = 0;
	show_debug_message("scr_lockFields, tokenFieldList: " + scr_getStringOfList(obj_control.tokenFieldList));
	
	fieldListSize = ds_list_size(obj_control.tokenFieldList);
	fieldMap = global.nodeMap[? "tokenTagMap"];
	for(var i = 0; i < fieldListSize; i++){
		var currentField = obj_control.tokenFieldList[|i];
		var currentFieldMap = fieldMap[?currentField];
		if(!ds_map_exists(currentFieldMap, "locked")){
			currentFieldMap[?"locked"] = false;
		}
		var tagSet = currentFieldMap[?"tagSet"];
		scr_sortList(tagSet);
	}
	scr_sortList(obj_control.tokenFieldList);
	show_debug_message("scr_lockFields, unitFieldList: " + scr_getStringOfList(obj_control.unitFieldList));
	
	fieldListSize = ds_list_size(obj_control.unitFieldList);
	fieldMap = global.nodeMap[? "unitTagMap"];
	for(var i = 0; i < fieldListSize; i++){
		var currentField = obj_control.unitFieldList[|i];
		var currentFieldMap = fieldMap[?currentField];
		if(!ds_map_exists(currentFieldMap, "locked")){
			currentFieldMap[?"locked"] = false;
		}
		var tagSet = currentFieldMap[?"tagSet"];
		scr_sortList(tagSet);
	}
		scr_sortList(obj_control.unitFieldList);
	show_debug_message("scr_lockFields, entryFieldList: " + scr_getStringOfList(global.chainEntryFieldList));
	
	fieldListSize = ds_list_size(global.chainEntryFieldList);
	fieldMap = global.nodeMap[? "entryTagMap"];
	for(var i = 0; i < fieldListSize; i++){
		var currentField = global.chainEntryFieldList[|i];
		var currentFieldMap = fieldMap[?currentField];
		if(!ds_map_exists(currentFieldMap, "locked")){
			currentFieldMap[?"locked"] = false;
		}
		var tagSet = currentFieldMap[?"tagSet"];
		scr_sortList(tagSet);
	}
	scr_sortList(global.chainEntryFieldList);
	show_debug_message("scr_lockFields, chainFieldList: " + scr_getStringOfList(global.chainFieldList));
	
	fieldListSize = ds_list_size(global.chainFieldList);
	fieldMap = global.nodeMap[? "chainTagMap"];
	for(var i = 0; i < fieldListSize; i++){
		var currentField = global.chainFieldList[|i];
		var currentFieldMap = fieldMap[?currentField];
		if(!ds_map_exists(currentFieldMap, "locked")){
			currentFieldMap[?"locked"] = false;
		}
		var tagSet = currentFieldMap[?"tagSet"];
		scr_sortList(tagSet);
	}
	scr_sortList(global.chainFieldList);
	show_debug_message("scr_lockFields, chunkFieldList: " + scr_getStringOfList(obj_control.chunkFieldList));
	
	fieldListSize = ds_list_size(obj_control.chunkFieldList);
	fieldMap = global.nodeMap[? "tokenTagMap"];
	for(var i = 0; i < fieldListSize; i++){
		var currentField = obj_control.chunkFieldList[|i];
		var currentFieldMap = fieldMap[?currentField];
		if(!ds_map_exists(currentFieldMap, "locked")){
			currentFieldMap[?"locked"] = false;
		}
		var tagSet = currentFieldMap[?"tagSet"];
		scr_sortList(tagSet);
	}
	scr_sortList(obj_control.chunkFieldList);
	show_debug_message("scr_lockFields, linkFieldList: " + scr_getStringOfList(global.linkFieldList));
	
	fieldListSize = ds_list_size(global.linkFieldList);
	fieldMap = global.nodeMap[? "linkTagMap"];
	for(var i = 0; i < fieldListSize; i++){
		var currentField = global.linkFieldList[|i];
		var currentFieldMap = fieldMap[?currentField];
		if(!ds_map_exists(currentFieldMap, "locked")){
			currentFieldMap[?"locked"] = false;
		}
		var tagSet = currentFieldMap[?"tagSet"];
		scr_sortList(tagSet);
	}
	scr_sortList(global.linkFieldList);
}