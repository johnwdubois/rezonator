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
			show_debug_message("buhbuhbuh1");
			displayUnitList = ds_list_create();
			ds_list_copy(displayUnitList, unitList);
			ds_map_delete(docSubMap, "displayUnitList");
			ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
		}
		else {
			// if this rez file has a valid displayUnitList but its empty, replace it with unitList
			if (ds_list_size(displayUnitList) < 1) {
				ds_list_copy(displayUnitList, unitList);
				ds_map_delete(docSubMap, "displayUnitList");
				ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
			}
		}
		
		

		// make sure our node map has all the data structures we need
		var rezChainList = global.nodeMap[? "resonanceList"];
		var trackChainList = global.nodeMap[? "trailList"];
		var stackChainList = global.nodeMap[? "stackList"];
		var showList = global.nodeMap[? "showList"];
		var chunkList = global.nodeMap[? "chunkList"];
		var nodeList = global.nodeMap[? "nodeList"];
		var linkFieldList = global.nodeMap[? "linkFieldList"];
		var treeList = global.nodeMap[? "treeList"];
		var stackingList = global.nodeMap[? "stackingList"];

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
	
		// if we can't find any important lists, we will create them here
		if (!scr_isNumericAndExists(rezChainList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "resonanceList", ds_list_create());
		}
		if (!scr_isNumericAndExists(trackChainList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "trailList", ds_list_create());
		}
		if (!scr_isNumericAndExists(stackChainList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "stackList", ds_list_create());
		}
		if (!scr_isNumericAndExists(showList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "showList", ds_list_create());
		}
		if (!scr_isNumericAndExists(chunkList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "chunkList", ds_list_create());
		}
		if (!scr_isNumericAndExists(nodeList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "nodeList", ds_list_create());
		}
		if (!scr_isNumericAndExists(treeList, ds_type_list)) {
			ds_map_add_list(global.nodeMap, "treeList", ds_list_create());
		}
		if (!scr_isNumericAndExists(stackingList, ds_type_list)) {
			stackingList = ds_list_create();
			ds_map_add_list(global.nodeMap, "stackingList", stackingList);
		}
		
		// make sure our stackingList has default
		if (scr_isNumericAndExists(stackingList, ds_type_list)) scr_addToListOnce(stackingList, "Default");
		
		if (scr_isNumericAndExists(linkFieldList, ds_type_list)) {
			global.linkFieldList = linkFieldList;
		}

		// no tree map found
		if (is_undefined(global.nodeMap[? "treeMap"])) {
			global.treeMap = ds_map_create();
			ds_map_add(global.treeMap, "type", "map");
			scr_addToListOnce(nodeList, "treeMap");
		}
	
		// no clique map found
		if (is_undefined(global.nodeMap[? "cliqueMap"])) {
			global.cliqueMap = ds_map_create();
			ds_map_add(global.cliqueMap, "type", "map");
			scr_addToListOnce(nodeList, "cliqueMap");
		}
	
		// no search map found
		if (is_undefined(global.nodeMap[? "searchMap"])) {
			global.searchMap = ds_map_create();
			ds_map_add(global.searchMap, "type", "map");
			scr_addToListOnce(nodeList, "searchMap");
		}
	
		// no color map found
		if (is_undefined(global.nodeMap[? "colorMap"])) {
			show_debug_message("no color map found");
			global.colorMap = ds_map_create();
			ds_map_add(global.colorMap, "type", "map");
			scr_addToListOnce(nodeList, "colorMap");
		}
		
		// no stacking map found
		if (is_undefined(global.nodeMap[? "stackingMap"])) {
			show_debug_message("no stackingMap found");
			global.stackingMap = ds_map_create();
			ds_map_add(global.stackingMap, "type", "map");
			scr_addToListOnce(nodeList, "stackingMap");
		}

		// make sure stacking map has default value
		if (scr_isNumericAndExists(global.stackingMap, ds_type_map)) {
			if (!ds_map_exists(global.stackingMap, "Default")) {
				var defaultStackingSubMap = ds_map_create();
				defaultStackingSubMap[? "name"] = "Default";
				ds_map_add_map(global.stackingMap, "Default", defaultStackingSubMap);
			}
		}
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