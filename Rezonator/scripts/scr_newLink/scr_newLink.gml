/*	
	Purpose: the user has created a link, so this script will add it to the node map
*/
function scr_newLink(ID) {
	
	
	if(obj_toolPane.currentMode == obj_toolPane.modeRead) exit;
	
	
	show_debug_message("scr_newLink() ... ID: " + string(ID));
	ds_list_clear(obj_control.chainStretchCheckList);
		
	// make sure this is a valid ID
	var idSubMap = global.nodeMap[? ID];
	if (!scr_isNumericAndExists(idSubMap, ds_type_map)) exit;
	
	
	var unitID = "";
	var tokenID = "";
	var IDsubMap = global.nodeMap[?ID];
	var type = IDsubMap[?"type"];
	if(type == "unit"){
		unitID = ID
		var entryList = IDsubMap[?"entryList"];
		if (!scr_isNumericAndExists(entryList, ds_type_list)) exit;
		if (ds_list_size(entryList) < 1) exit;
		var firstEntry = entryList[|0];
		var entrySubMap = global.nodeMap[?firstEntry];
		tokenID = entrySubMap[?"token"];
	}
	else if(type == "token"){	
		unitID = IDsubMap[?"unit"];
		tokenID = ID
	}
	
	

	var isChunk = scr_isChunk(ID);
	
	// determine whether to treat as unit (stack) or word (rez/track)
	var idSet = "";
	if (type == "unit") {
		idSet = unitID;
		if (obj_control.quickStackAbleToInitiate) {
			obj_control.moveCounter++;
		}
	}
	else {
		if(isChunk){
			idSet = ID;
		}
		else{
			idSet = tokenID;
		}
		obj_control.mostRecentlyAddedWord = tokenID;
	}
	

	// make sure there is a focused chain
	if (obj_chain.currentFocusedChainID = "") {
		show_debug_message("scr_newLink() ... ERROR: currentFocusedChainID is blank string. Exiting...");
		exit;
	}
	
	// get type of focused chain
	var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
	var focusedChainType = focusedChainSubMap[? "type"];
	
	// determine the tier/type of this link
	var nodeType = "rez";
	if (focusedChainType == "trackChain") {
		nodeType = "track";
	}
	else if (focusedChainType == "stackChain") {
		nodeType = "stack";
	}
	
	var linkSourceID = ""; 
	
	// add an entry (rez/track/stack) to the nodeMap
	// find this chain's node in the nodeMap
	var nodeID = "";
	var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
	if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
			
		// get the sourceID for the link
		linkSourceID = chainSubMap[? "focused"];
			
		// get the setIDList for this chain's node
		var idList = chainSubMap[? "setIDList"];
		if (scr_isNumericAndExists(idList, ds_type_list)) {
					
			// create a new node for this entry with type being rez, track, or stack
			nodeID = scr_addToNodeMap(nodeType);
			obj_control.newestEntry = nodeID;
					
			// set entry node values in nodeMap
			var setSubMap = ds_map_find_value(global.nodeMap, nodeID)
			if (scr_isNumericAndExists(setSubMap, ds_type_map)) {

				ds_map_add(setSubMap, "chain", obj_chain.currentFocusedChainID);
				ds_map_add(setSubMap, (focusedChainType == "stackChain") ? "unit" : "token", idSet);
				ds_map_add(setSubMap, "sourceLink", "");
				ds_map_add(setSubMap, "clickTime", scr_getCurrentSessionTime() / 1000);
				ds_map_add_list(setSubMap, "goalLinkList", ds_list_create());
				if (focusedChainType == "rezChain") {
					ds_map_add(setSubMap, "alignEntry", true);
				}
				else if (focusedChainType == "trackChain") {
					ds_map_add(setSubMap, "alignEntry", false);
				}
							
				// add tagmap to this entry's submap
				var tagMap = ds_map_create();
				ds_map_add_map(setSubMap, "tagMap", tagMap);
							
				ds_map_add(setSubMap, "stretch", false);
			}

			// check if this chain already contains this node
			// otherwise add it to the chain's idList
			if (ds_list_find_index(idList, nodeID) == -1) {
				ds_list_add(idList, nodeID);
						
				// let's also tell this chain that this new node should be focused
				ds_map_replace(chainSubMap, "focused", nodeID);
			}
					

					
			// set wordDrawGrid if this is a rez or track
			if ((nodeType == "rez" || nodeType == "track") && !isChunk) {
				var chainColor = ds_map_find_value(chainSubMap, "chainColor");
				//ds_grid_set(obj_control.wordDrawGrid, (nodeType == "rez") ? obj_control.wordDrawGrid_colBorder : obj_control.wordDrawGrid_colBorderRounded, wordID - 1, true);
				//ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, wordID - 1, chainColor);
			}
					
					
					
			// sort the displayed links
			scr_sortVizSetIDList(obj_chain.currentFocusedChainID);
					
			show_debug_message("scr_newLink() ... entry nodeID: " + string(nodeID));
		}
	}
	
	
	if (nodeID == "") {
		show_debug_message("scr_newLink() ... ERROR: nodeID is blank string. Exiting...");
		exit;
	}
		
		
	// if this is a rez or track, we will make sure we are adding to the word's inChainsList
	if (nodeType == "rez" || nodeType == "track" || nodeType == "stack") {
		var entryWordInChainsList = -1;
		if (isChunk) {
			var chunkSubMap = global.nodeMap[?ID];
			if(scr_isNumericAndExists(chunkSubMap, ds_type_map)){
				entryWordInChainsList = chunkSubMap[? "inChainsList"];
			}
		}
		else {
			var tokenSubMap = global.nodeMap[?idSet];
			if(scr_isNumericAndExists(tokenSubMap, ds_type_map)){
				entryWordInChainsList = tokenSubMap[? "inChainsList"];
			}
		}
		if(scr_isNumericAndExists(entryWordInChainsList, ds_type_list)){
			if (ds_list_find_index(entryWordInChainsList, obj_chain.currentFocusedChainID) == -1) {
				ds_list_add(entryWordInChainsList, obj_chain.currentFocusedChainID);
			}
		}
	}
	

	
	var linkGoalID = nodeID;
	if (ds_map_exists(global.nodeMap,linkSourceID) and ds_map_exists(global.nodeMap,linkGoalID)) {
		// create a node for the link (now that we know its source & goal)
		
		var linkID = scr_addToNodeMap("link");
		var linkSubMap = ds_map_find_value(global.nodeMap, linkID);
		ds_map_add(linkSubMap, "source", linkSourceID);
		ds_map_add(linkSubMap, "goal", linkGoalID);
		
		// add this link to the chain's linkIDList
		var chainLinkIDList = ds_map_find_value(chainSubMap, "linkIDList");
		ds_list_add(chainLinkIDList, linkID);
		
		// add this new link to the source's goalLinkList
		var sourceSetSubMap = ds_map_find_value(global.nodeMap, linkSourceID);
		if (scr_isNumericAndExists(sourceSetSubMap, ds_type_map)) {
			var sourceSetGoalLinkList = ds_map_find_value(sourceSetSubMap, "goalLinkList");
			if (scr_isNumericAndExists(sourceSetGoalLinkList, ds_type_list)) {
				ds_list_add(sourceSetGoalLinkList, linkID);
				show_debug_message("scr_newLink() ... adding " + string(linkID) + " to " + string(sourceSetSubMap));
			}
			
			// set clicktime for source
			if (ds_map_exists(sourceSetSubMap, "clickTime")) ds_map_add(linkSubMap, "sourceClickTime", sourceSetSubMap[? "clickTime"]);
		}
		
		// add this new link to the goal's source
		var goalSetSubMap = ds_map_find_value(global.nodeMap, linkGoalID);
		if (scr_isNumericAndExists(goalSetSubMap, ds_type_map)) {
			ds_map_replace(goalSetSubMap, "sourceLink", linkID);
			show_debug_message("scr_newLink() ... adding " + string(linkID) + " to " + string(goalSetSubMap));
			
			// set clicktime for goal
			if (ds_map_exists(goalSetSubMap, "clickTime")) ds_map_add(linkSubMap, "goalClickTime", goalSetSubMap[? "clickTime"]);
		}
	}
	
	if (focusedChainType == "rezChain") {
		scr_refreshCliques();
		scr_alignChain2ElectricBoogaloo(obj_chain.currentFocusedChainID);
	}
	
	show_debug_message("scr_newLink() ... end of script for ID: " + string(ID));

}
