// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_loadTagJson(){
	
	var fileName = get_open_filename_ext("Tag file|*.json", "", global.rezonatorSchemaDirString, "Open Tag JSON");
	
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
	var navTokenFieldList = map[? "navTokenFieldList"];
	var navUnitFieldList = map[? "navUnitFieldList"];
	var navChunkFieldList = map[? "navChunkFieldList"];
	var navRez1toManyFieldList = map[? "navRez1toManyFieldList"];
	var navTrack1toManyFieldList = map[? "navTrack1toManyFieldList"];
	var navStack1toManyFieldList = map[? "navStack1toManyFieldList"];
	var navRez1to1FieldList = map[? "navRez1to1FieldList"];
	var navTrack1to1FieldList = map[? "navTrack1to1FieldList"];
	var navStack1to1FieldList = map[? "navStack1to1FieldList"];	
	
	if (scr_isNumericAndExists(navTokenFieldList, ds_type_list)) obj_control.navTokenFieldList = navTokenFieldList;
	if (scr_isNumericAndExists(navUnitFieldList, ds_type_list)) obj_control.navUnitFieldList = navUnitFieldList;
	if (scr_isNumericAndExists(navChunkFieldList, ds_type_list)) obj_control.navChunkFieldList = navChunkFieldList;
	if (scr_isNumericAndExists(navRez1toManyFieldList, ds_type_list)) obj_control.chain1toManyColFieldListRez = navRez1toManyFieldList;
	if (scr_isNumericAndExists(navTrack1toManyFieldList, ds_type_list)) obj_control.chain1toManyColFieldListTrack = navTrack1toManyFieldList;
	if (scr_isNumericAndExists(navStack1toManyFieldList, ds_type_list)) obj_control.chain1toManyColFieldListStack = navStack1toManyFieldList;
	if (scr_isNumericAndExists(navRez1to1FieldList, ds_type_list)) obj_control.chain1to1ColFieldListRez = navRez1to1FieldList;
	if (scr_isNumericAndExists(navTrack1to1FieldList, ds_type_list)) obj_control.chain1to1ColFieldListTrack = navTrack1to1FieldList;
	if (scr_isNumericAndExists(navStack1to1FieldList, ds_type_list)) obj_control.chain1to1ColFieldListStack = navStack1to1FieldList;
	#endregion

	
}