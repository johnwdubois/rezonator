function scr_loadTagJson(fileName){
	
	show_debug_message("scr_loadTagJson, fileName: " + string(fileName));
	
	if(!is_string(fileName)){
		fileName = get_open_filename_ext("Tag file|*.json", "", global.rezonatorSchemaDirString, "Open Tag JSON");
	}
	// make sure the file exists
	if (fileName == "" or not file_exists(fileName)) {
		show_debug_message("scr_loadTagJson ... ERROR: file does not exist");
		exit;
	}
	
	// load wrapper, make sure it's good
	var wrapper = scr_loadJSONBuffer(fileName);
	if (!scr_isNumericAndExists(wrapper, ds_type_map)) {
		show_message("Error loading " + fileName);
		exit;
	}
	
	// load list, make sure it's good
	var list = ds_map_find_value(wrapper, "ROOT");
	if (!scr_isNumericAndExists(list, ds_type_list)) {
		show_message("Error loading " + fileName);
		exit;
	}
	
	// the map will be the one and only item in the rootList
	var map = list[| 0];
	
	
	
	// get the tag maps that the user currently has
	var originalTokenTagMap = global.nodeMap[? "tokenTagMap"];
	var originalUnitTagMap = global.nodeMap[? "unitTagMap"];
	var originalChainFieldMap = global.nodeMap[? "chainTagMap"];
	var originalEntryFieldMap = global.nodeMap[? "entryTagMap"];
	var originalLinkFieldMap = global.nodeMap[? "linkTagMap"];
	
	
	
	// get the tag maps from the json
	var tokenTagMapJson = map[? "tokenTagMap"];
	var unitTagMapJson = map[? "unitTagMap"];
	var chainFieldMapJson = map[? "chainTagMap"];
	var entryFieldMapJson = map[? "entryTagMap"];
	var linkFieldMapJson = map[? "linkTagMap"];
	
	

	

	scr_loadTagJsonFields(originalTokenTagMap, obj_control.tokenFieldList, tokenTagMapJson, "token");
	scr_loadTagJsonFields(originalTokenTagMap, obj_control.chunkFieldList, tokenTagMapJson, "chunk");
	scr_loadTagJsonFields(originalUnitTagMap, obj_control.unitFieldList, unitTagMapJson, "unit");
	scr_loadTagJsonFields(originalChainFieldMap, global.chainFieldList, chainFieldMapJson, "chain");
	scr_loadTagJsonFields(originalEntryFieldMap, global.chainEntryFieldList, entryFieldMapJson, "entry");
	scr_loadTagJsonFields(originalLinkFieldMap, global.linkFieldList, linkFieldMapJson, "link");
	
	
	#region set nav window lists based on the lists found in tag json
	show_debug_message("map[? navTokenFieldList]: " + scr_getStringOfList(map[? "navTokenFieldList"]));
	var navTokenFieldList = map[? "navTokenFieldList"];
	var navUnitFieldList = map[? "navUnitFieldList"];
	var navChunkFieldList = map[? "navChunkFieldList"];
	var navRez1toManyFieldList = map[? "navRez1toManyFieldList"];
	var navTrack1toManyFieldList = map[? "navTrack1toManyFieldList"];
	var navStack1toManyFieldList = map[? "navStack1toManyFieldList"];
	var navRez1to1FieldList = map[? "navRez1to1FieldList"];
	var navTrack1to1FieldList = map[? "navTrack1to1FieldList"];
	var navStack1to1FieldList = map[? "navStack1to1FieldList"];	
	
	show_debug_message("scr_loadTagJson 1, navTokenFieldList: " + scr_getStringOfList(obj_control.navTokenFieldList));
	
	scr_setTagJsonFieldList(navTokenFieldList, obj_control.navTokenFieldList);
	scr_setTagJsonFieldList(navUnitFieldList, obj_control.navUnitFieldList);
	scr_setTagJsonFieldList(navChunkFieldList, obj_control.navChunkFieldList);
	scr_setTagJsonFieldList(navRez1toManyFieldList, obj_control.chain1toManyColFieldListRez);
	scr_setTagJsonFieldList(navTrack1toManyFieldList, obj_control.chain1toManyColFieldListTrack);
	scr_setTagJsonFieldList(navStack1toManyFieldList, obj_control.chain1toManyColFieldListStack);
	scr_setTagJsonFieldList(navRez1to1FieldList, obj_control.chain1to1ColFieldListRez);
	scr_setTagJsonFieldList(navTrack1to1FieldList, obj_control.chain1to1ColFieldListTrack);
	scr_setTagJsonFieldList(navStack1to1FieldList, obj_control.chain1to1ColFieldListStack);
	
	#endregion
	
	show_debug_message("scr_loadTagJson 2, navTokenFieldList: " + scr_getStringOfList(obj_control.navTokenFieldList));


	
	
	// any fields that are not in their respective nav field lists, add them!
	var tokenFieldListSize = ds_list_size(obj_control.tokenFieldList);
	for (var i = 0; i < tokenFieldListSize; i++) scr_addToListOnce(obj_control.navTokenFieldList, obj_control.tokenFieldList[| i]);
	var unitFieldListSize = ds_list_size(obj_control.unitFieldList);
	for (var i = 0; i < unitFieldListSize; i++) scr_addToListOnce(obj_control.navUnitFieldList, obj_control.unitFieldList[| i]);
	var chunkFieldListSize = ds_list_size(obj_control.chunkFieldList);
	for (var i = 0; i < chunkFieldListSize; i++) scr_addToListOnce(obj_control.navChunkFieldList, obj_control.chunkFieldList[| i]);
	
	// for chain & entry fields, we must check the chain types before adding to the lists
	var entryFieldListSize = ds_list_size(global.chainEntryFieldList);
	for (var i = 0; i < entryFieldListSize; i++) {
		var currentField = global.chainEntryFieldList[| i];
		var currentFieldSubMap = global.entryFieldMap[? currentField];
		if (!scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) continue;
		
		if (currentFieldSubMap[? "rez"]) scr_addToListOnce(obj_control.chain1toManyColFieldListRez, currentField);
		if (currentFieldSubMap[? "track"]) scr_addToListOnce(obj_control.chain1toManyColFieldListTrack, currentField);
		if (currentFieldSubMap[? "card"]) scr_addToListOnce(obj_control.chain1toManyColFieldListStack, currentField);
	}
	var chainFieldListSize = ds_list_size(global.chainFieldList);
	for (var i = 0; i < chainFieldListSize; i++) {
		var currentField = global.chainFieldList[| i];
		var currentFieldSubMap = global.chainFieldMap[? currentField];
		if (!scr_isNumericAndExists(currentFieldSubMap, ds_type_map)) continue;
		
		if (currentFieldSubMap[? "rez"]) scr_addToListOnce(obj_control.chain1to1ColFieldListRez, currentField);
		if (currentFieldSubMap[? "track"]) scr_addToListOnce(obj_control.chain1to1ColFieldListTrack, currentField);
		if (currentFieldSubMap[? "card"]) scr_addToListOnce(obj_control.chain1to1ColFieldListStack, currentField);
	}
	show_debug_message("scr_loadTagJson, chain1toManyColFieldListRez: " + scr_getStringOfList(obj_control.chain1toManyColFieldListRez));
	show_debug_message("scr_loadTagJson, chain1toManyColFieldListTrack: " + scr_getStringOfList(obj_control.chain1toManyColFieldListTrack));
	show_debug_message("scr_loadTagJson, chain1toManyColFieldListStack: " + scr_getStringOfList(obj_control.chain1toManyColFieldListStack));
	show_debug_message("scr_loadTagJson, chain1to1ColFieldListRez: " + scr_getStringOfList(obj_control.chain1to1ColFieldListRez));
	show_debug_message("scr_loadTagJson, chain1to1ColFieldListTrack: " + scr_getStringOfList(obj_control.chain1to1ColFieldListTrack));
	show_debug_message("scr_loadTagJson, chain1to1ColFieldListStack: " + scr_getStringOfList(obj_control.chain1to1ColFieldListStack));
	
	
}