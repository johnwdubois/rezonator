// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_verifyRez(rezFileVerison){
	
	if(rezFileVerison != global.versionString){
	
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		obj_dialogueBox.alertWindowActive = true;
		obj_dialogueBox.descriptionText = scr_get_translation("msg_error-previous-version");
	
	}
	var nodeMapSize = ds_map_size(global.nodeMap);
	//if only thing in node map is node list then we need to return to opening screen
	if(!ds_map_exists(global.nodeMap, global.discourseNode)){
		show_debug_message("scr_loadREZ() ... global.nodeMap is undefined- jumping to opening screen");
		room_goto(rm_openingScreen);
	}
	else{


		//all lists from load rez
		
		// get chain lists from nodeMap, and if they aren't provided in the nodeMap then we'll make them!
		var rezChainList = global.nodeMap[? "rezChainList"];
		var trackChainList = global.nodeMap[? "trackChainList"];
		var stackChainList = global.nodeMap[? "stackChainList"];
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
			ds_map_add_list(global.nodeMap, "rezChainList", rezChainList);
		}
		if (!is_numeric(trackChainList)) {
			trackChainList = ds_list_create();
			ds_map_add_list(global.nodeMap, "trackChainList", trackChainList);
		}
		if (!is_numeric(stackChainList)) {
			stackChainList = ds_list_create();
			ds_map_add_list(global.nodeMap, "stackChainList", stackChainList);
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