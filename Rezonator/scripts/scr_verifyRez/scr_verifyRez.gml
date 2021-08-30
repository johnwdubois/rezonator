// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_verifyRez(rezFileVerison){
	
	
	if(rezFileVerison != global.versionString){
	
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
	else{

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
			displayUnitList = unitList;
			ds_map_delete(docSubMap, "displayUnitList");
			ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
		}
		else {
			// if this rez file has a valid displayUnitList but its empty, replace it with unitList
			if (ds_list_size(displayUnitList < 1)) {
				displayUnitList = unitList;
				ds_map_delete(docSubMap, "displayUnitList");
				ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
			}
		}
		
		
		
		
		


		//all lists from load rez
		
		// get chain lists from nodeMap, and if they aren't provided in the nodeMap then we'll make them!
		var rezChainList = global.nodeMap[? "resonanceList"];
		var trackChainList = global.nodeMap[? "trailList"];
		var stackChainList = global.nodeMap[? "stackList"];
		var showList = global.nodeMap[? "showList"];
		var chunkList = global.nodeMap[? "chunkList"];
		var nodeList = global.nodeMap[? "nodeList"];
		var linkFieldList = global.nodeMap[? "linkFieldList"];
		var treeList = global.nodeMap[? "treeList"];
	

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
	
		if (!is_numeric(rezChainList)) {
			rezChainList = ds_list_create();
			ds_map_add_list(global.nodeMap, "resonanceList", rezChainList);
		}
		if (!is_numeric(trackChainList)) {
			trackChainList = ds_list_create();
			ds_map_add_list(global.nodeMap, "trailList", trackChainList);
		}
		if (!is_numeric(stackChainList)) {
			stackChainList = ds_list_create();
			ds_map_add_list(global.nodeMap, "stackList", stackChainList);
		}
		if (!is_numeric(showList)) {
			ds_map_add_list(global.nodeMap, "showList", ds_list_create());
		}
		if (!is_numeric(chunkList)) {
			ds_map_add_list(global.nodeMap, "chunkList", ds_list_create());
		}
		if (!is_numeric(nodeList)) {
			ds_map_add_list(global.nodeMap, "nodeList", ds_list_create());
		}
		if (!is_numeric(treeList)) {
			ds_map_add_list(global.nodeMap, "treeList", ds_list_create());
		}
		if(is_numeric(linkFieldList)){
			global.linkFieldList = linkFieldList;
		}


		//no tree map found
		if(is_undefined(global.nodeMap[? "treeMap"])){
			global.treeMap = ds_map_create();
			ds_map_add(global.treeMap, "type", "map");
			scr_addToListOnce(nodeList,"treeMap");
		}
	
		//no clique map found
		if(is_undefined(global.nodeMap[? "cliqueMap"])){
			global.cliqueMap = ds_map_create();
			ds_map_add(global.cliqueMap, "type", "map");
			scr_addToListOnce(nodeList,"cliqueMap");
		}
	
		//no search map found
		if(is_undefined(global.nodeMap[? "searchMap"])){
			global.searchMap = ds_map_create();
			ds_map_add(global.searchMap, "type", "map");
			scr_addToListOnce(nodeList,"searchMap");
		}
	
		//no color map found
		if(is_undefined(global.nodeMap[? "colorMap"])){
			show_debug_message("no color map found");
			global.colorMap = ds_map_create();
			ds_map_add(global.colorMap, "type", "map");
			scr_addToListOnce(nodeList,"colorMap");
		}

		//now check for tag maps

	}

}