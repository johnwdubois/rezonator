function scr_verifyRez() {
	
	// check version number specified in the rez file
	show_debug_message("scr_verifyRez, rezFileVersion:  "+ string(obj_control.rezFileVersion));
	obj_control.rezFileVersion = string(obj_control.rezFileVersion)
	var firstNum = string_digits(obj_control.rezFileVersion);
	if (string_length(firstNum) > 0) {
		if (string_char_at(firstNum, 1) == "0") {
			var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.alertWindowActive = true;
			obj_dialogueBox.descriptionText = scr_get_translation("msg_error-previous-version");
		}
	}
	else {
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		obj_dialogueBox.alertWindowActive = true;
		obj_dialogueBox.descriptionText = scr_get_translation("msg_error-previous-version");
	}

	
	var docSubMap = global.nodeMap[? global.discourseNode];
	
	//if only thing in node map is node list then we need to return to opening screen
	if (!scr_isNumericAndExists(docSubMap, ds_type_map)) {
		show_debug_message("scr_verifyREZ ... docSubMap is undefined- jumping to opening screen");
		return true;
	}
	else {

		// make sure this rez file at least has a unit list
		var unitList = docSubMap[? "unitList"];
		if (!scr_isNumericAndExists(unitList, ds_type_list)) {
			show_debug_message("scr_verifyREZ ... unitList is undefined- jumping to opening screen");
			return true;
		}
		
		// make sure unitList has at least 1 thing in it
		if (ds_list_size(unitList) < 1) {
			show_debug_message("scr_verifyREZ ... unitList is empty- jumping to opening screen");
			return true;
		}
		
		// if this rez file doesn't have a valid displayUnitList, replace displayUnitList with the unitList
		var displayUnitList = docSubMap[? "displayUnitList"];
		if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) {
			show_debug_message("scr_verifyRez, displayUnitList does not exist, creating copy of unitList...");
			displayUnitList = ds_list_create();
			ds_list_copy(displayUnitList, unitList);
			ds_map_delete(docSubMap, "displayUnitList");
			ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
		}
		else {
			// if this rez file has a valid displayUnitList but it's empty, replace it with unitList
			if (ds_list_size(displayUnitList) < 1) {
				ds_list_copy(displayUnitList, unitList);
				ds_map_delete(docSubMap, "displayUnitList");
				ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
			}
		}

		// make sure our node map has all the lists we need
		var resonanceList = scr_verifyRezCheckDS("resonanceList", ds_type_list);
		var trailList = scr_verifyRezCheckDS("trailList", ds_type_list);
		var stackList = scr_verifyRezCheckDS("stackList", ds_type_list);
		var resonanceNavList = scr_verifyRezCheckDS("resonanceNavList", ds_type_list);
		var trailNavList = scr_verifyRezCheckDS("trailNavList", ds_type_list);
		var stackNavList = scr_verifyRezCheckDS("stackNavList", ds_type_list);
		var nodeList = scr_verifyRezCheckDS("nodeList", ds_type_list);
		var linkFieldList = scr_verifyRezCheckDS("linkFieldList", ds_type_list);
		var stackingList = scr_verifyRezCheckDS("stackingList", ds_type_list);
		scr_verifyRezCheckDS("showList", ds_type_list);
		scr_verifyRezCheckDS("chunkList", ds_type_list)
		scr_verifyRezCheckDS("treeList", ds_type_list);

		// get chain field map, if supplied
		var chainFieldMap = global.nodeMap[? "chainTagMap"];
		if (scr_isNumericAndExists(chainFieldMap, ds_type_map)) {
			ds_map_destroy(global.chainFieldMap);
			global.chainFieldMap = chainFieldMap;
		}
		// get entry field map, if supplied
		var entryFieldMap = global.nodeMap[? "entryTagMap"];
		if (scr_isNumericAndExists(entryFieldMap, ds_type_map)) {
			ds_map_destroy(global.entryFieldMap);
			global.entryFieldMap = entryFieldMap;
		}
		// get entry field map, if supplied
		var linkFieldMap = global.nodeMap[? "linkTagMap"];
		if (scr_isNumericAndExists(linkFieldMap, ds_type_map)) {
			ds_map_destroy(global.linkFieldMap);
			global.linkFieldMap = linkFieldMap;
		}
		

		if (scr_isNumericAndExists(linkFieldList, ds_type_list)) {
			global.linkFieldList = linkFieldList;
		}

		// make sure important maps exist
		global.treeMap = scr_verifyRezCheckDS("treeMap", ds_type_map, nodeList);
		global.cliqueMap = scr_verifyRezCheckDS("cliqueMap", ds_type_map, nodeList);
		global.searchMap = scr_verifyRezCheckDS("searchMap", ds_type_map, nodeList);
		global.colorMap = scr_verifyRezCheckDS("colorMap", ds_type_map, nodeList);
		global.stackingMap = scr_verifyRezCheckDS("stackingMap", ds_type_map, nodeList);
	
		// make sure stacking map & list contain default value
		if (scr_isNumericAndExists(stackingList, ds_type_list)) scr_addToListOnce(stackingList, "Default");
		if (scr_isNumericAndExists(global.stackingMap, ds_type_map)) {
			if (!ds_map_exists(global.stackingMap, "Default")) {
				var defaultStackingSubMap = ds_map_create();
				defaultStackingSubMap[? "name"] = "Default";
				ds_map_add_map(global.stackingMap, "Default", defaultStackingSubMap);
			}
		}
		
		// if the nav lists are empty but the full lists are not, let's copy from the full lists
		if (ds_list_size(resonanceNavList) < 1 && ds_list_size(resonanceList) >= 1) ds_list_copy(resonanceNavList, resonanceList);
		if (ds_list_size(trailNavList) < 1 && ds_list_size(trailList) >= 1) ds_list_copy(trailNavList, trailList);
		if (ds_list_size(stackNavList) < 1 && ds_list_size(stackList) >= 1) ds_list_copy(stackNavList, stackList);
	}
	
	// set every unit's "active" value to be true
	var unitList = docSubMap[? "unitList"];
	if (scr_isNumericAndExists(unitList, ds_type_list)) {
		var unitListSize = ds_list_size(unitList);
		for (var i = 0; i < unitListSize; i++) {
			var currentUnit = unitList[| i];
			var currentUnitSubMap = global.nodeMap[? currentUnit];
			if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
				currentUnitSubMap[? "active"] = true;
			}
		}
	}
	
	return false;
	
}