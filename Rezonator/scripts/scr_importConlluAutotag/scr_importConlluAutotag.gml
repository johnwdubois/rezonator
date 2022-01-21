// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importConlluAutotag(){
	
	
	//var skip = false;
	//if(skip){
	//	exit;	
	//}
	var trackField = global.conlluAutotagColName;
	
	global.delayInput = 0;
	
	show_debug_message("scr_importConlluAutotag... ");
	var docSubMap = global.nodeMap[?global.discourseNode];
	var tokenList = docSubMap[?"tokenList"];
	var entityMap = ds_map_create();
	ds_list_add(global.nodeMap[? "nodeList"], "entityMap");
	ds_map_add_map(global.nodeMap, "entityMap", entityMap);
	for(var i = 0; i < ds_list_size(tokenList); i++){ //Map of entities in coreference
		var currentToken = tokenList[|i];
		var currentTokenSubMap = global.nodeMap[?currentToken];
		var currentTokenTagMap = currentTokenSubMap[?"tagMap"];
		var currentMiscString = currentTokenTagMap[?trackField]; //Might have to use scr_isNumericAndExists later on
		var currentTokenList = ds_list_create();
		ds_list_add(currentTokenList, currentToken);

		//show_debug_message(currentMiscString);
		
		if(!is_string(currentMiscString)){ //undefined guard
			continue;
		}
		
		if(string_pos("Entity=", currentMiscString) != 0){ //verifies that there is an entity being referenced
			
			//need to clean up the coreference string to create a key
			
			var currentEntityKey = string_replace(currentMiscString, "Entity=", "");
			if(string_pos("Discourse=", currentMiscString) != 0){
				currentEntityKey = string_delete(currentEntityKey,1,string_pos("|", currentEntityKey));
			}
			if(string_pos("XML=", currentMiscString) != 0){
				var xmlIndex = string_pos("XML=", currentEntityKey);
				currentEntityKey = string_delete(currentEntityKey, xmlIndex, string_length(currentEntityKey) - xmlIndex);
			}
			currentEntityKey = string_replace(currentEntityKey,"SpaceAfter=No","");
			currentEntityKey = string_replace_all(currentEntityKey, "\n", "");
			currentEntityKey = string_replace_all(currentEntityKey, "\r", "");
			currentEntityKey = string_replace_all(currentEntityKey, "|", "");
			currentEntityKey = string_replace_all(currentEntityKey, ">", "");
			currentEntityKey = string_replace_all(currentEntityKey, "<", "");
			
			var keyList = ds_list_create();
			//case of more than one entity being referenced in a token
			if(string_count("(",currentEntityKey) > 1 or string_count(")",currentEntityKey) > 1){
				//string split or character iteration over misc string
				scr_splitStringConlluTag(currentEntityKey, keyList);
			}
			else{
				ds_list_add(keyList, currentEntityKey);		
			}
			show_debug_message("keylist: "+ scr_getStringOfList(keyList));
			var keyListSize = ds_list_size(keyList);
			for(var j = 0; j < keyListSize; j++){
				currentEntityKey = keyList[|j];
				if(string_pos(")", currentEntityKey) != 0 and string_pos("(", currentEntityKey) == 0) continue;
				if(string_pos("(", currentEntityKey) != 0 and string_pos(")", currentEntityKey) == 0){ // checking for an open parentheses without a close
					currentEntityKey = string_replace_all(currentEntityKey, "(", "");
					currentEntityKey = string_replace_all(currentEntityKey, ")", "");
					ds_list_clear(currentTokenList);
					ds_list_add(currentTokenList, currentToken);
					var nextTokenIndex = i+1;
					var subToken = tokenList[|nextTokenIndex];
					var subTokenSubMap = global.nodeMap[?subToken];
					var subTokenTagMap = subTokenSubMap[?"tagMap"];
					var subMiscString = subTokenTagMap[?trackField];
					var endString = currentEntityKey + ")";
					//show_debug_message("endString = " + endString);
					ds_list_add(currentTokenList, subToken);
					while(string_pos(endString, subMiscString) == 0){
						subToken = tokenList[|nextTokenIndex];
						//show_debug_message("subToken = " + string(subToken));
						if(is_undefined(subToken)){
							break;	
						}
						subTokenSubMap = global.nodeMap[?subToken];
						subTokenTagMap = subTokenSubMap[?"tagMap"];
						subMiscString = subTokenTagMap[?trackField];
						ds_list_add(currentTokenList, subToken);
						nextTokenIndex++;
					}
				}
				currentEntityKey = string_replace_all(currentEntityKey, "(", "");
				currentEntityKey = string_replace_all(currentEntityKey, ")", "");
				if(ds_map_exists(entityMap, currentEntityKey)){
					ds_list_add(entityMap[?currentEntityKey], currentTokenList);
					ds_list_mark_as_list(entityMap[?currentEntityKey],ds_list_size(entityMap[?currentEntityKey]) - 1)
				}
				else{
					var newEntryList = ds_list_create();
					ds_list_add(newEntryList, currentTokenList);
					ds_list_mark_as_list(newEntryList, 0);
					ds_map_add_list(entityMap, currentEntityKey, newEntryList);
				}
			}
		}
	}
	//iterate through map
	var entityMapSize = ds_map_size(entityMap);
	var key = ds_map_find_first(entityMap);
	for(var i = 0; i < entityMapSize; i++){
		var currentEntityList = entityMap[?key];
		
		//show_debug_message(string(key));
		//show_debug_message(scr_getStringOfList(currentEntityList));
		
		for(var j = 0; j < ds_list_size(currentEntityList); j++){ //iterate through the list of tokens in each entity
			var currentEntitySubList = currentEntityList[|j];
			var currentFirstTokenID = currentEntitySubList[|0];
			var currentFirstTokenSubMap = global.nodeMap[?currentFirstTokenID];
			var currentUnit = currentFirstTokenSubMap[?"unit"];
			if (j == 0) { // have to check this qualifier
				scr_newChain(currentFirstTokenID);
				
				// NAMING FUNCTIONALITY GOES HERE
				// get obj_chain.currentFocusedChainID for naming
				var newChainSubMap = global.nodeMap[?obj_chain.currentFocusedChainID];
				newChainSubMap[?"name"] = key;
			}
			if(ds_list_size(currentEntitySubList) > 1){
				//this is the condition for creating chunks, might have to put this if statement somewhere else
				var currentEntitySubListSize = ds_list_size(currentEntitySubList);
				ds_list_copy(obj_control.inRectTokenIDList, currentEntitySubList);
				var unitList = ds_list_create();
				ds_list_add(unitList, currentUnit);
				ds_list_copy(obj_control.inRectUnitIDList, unitList);
				global.delayInput = 0;
				scr_createChunk();
			}
			else{
				scr_newLink(currentFirstTokenID);
			}
			
		}
		scr_chainDeselect();
		key = ds_map_find_next(entityMap, key);
	}
	show_debug_message(string(entityMapSize));
	
	//destroy map because you don't need it anymore
	var entityMapSize = ds_map_size(entityMap);
	var key = ds_map_find_first(entityMap);
	for(var i = 0; i < entityMapSize; i++){
		currentEntityList = entityMap[?key];
		for(var j = 0; j < ds_list_size(currentEntityList); j++){
			//show_debug_message("sublist before destroy: " + string(ds_exists(currentEntityList[|j], ds_type_list)));
			
			ds_list_destroy(currentEntityList[|j]);
			
			//show_debug_message("sublist after destroy: " + string(ds_exists(currentEntityList[|j], ds_type_list)));
		}
		//show_debug_message("list before destroy: " + string(ds_exists(currentEntityList, ds_type_list)));
		
		ds_list_destroy(currentEntityList);
		
		//show_debug_message("list after destroy: " + string(ds_exists(currentEntityList, ds_type_list)));

		key = ds_map_find_next(entityMap,key);
	}
	
	ds_map_destroy(entityMap);
	
	global.delayInput = 8;
}