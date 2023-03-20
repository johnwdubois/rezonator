function scr_createNewStacking(name, stackerType){
	
	// get stackingList and stackingMap
	var stackingList = global.nodeMap[? "stackingList"];
	if (!scr_isNumericAndExists(global.stackingMap, ds_type_map) || !scr_isNumericAndExists(stackingList, ds_type_list)) {
		show_debug_message("scr_createNewStacking, ERROR ... stackingMap or stackingList does not exist");
		exit;
	}
	
	// create submap for this new stacking and add that to the stackingMap
	var newStackingID = scr_generateRandomID();
	var newStackingSubMap = ds_map_create();
	ds_map_add_map(global.stackingMap, newStackingID, newStackingSubMap);
	
	// also add it to stackingList
	scr_addToListOnce(stackingList, newStackingID);
	
	// add some fields to new stacking submap
	newStackingSubMap[? "name"] = name;
	newStackingSubMap[? "stacker"] = stackerType;
	
	// switch active stacking to this new one
	scr_changeActiveStacking(newStackingID);

}