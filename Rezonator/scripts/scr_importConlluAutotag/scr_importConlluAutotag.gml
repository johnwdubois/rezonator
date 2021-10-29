// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importConlluAutotag(){
	
	
	//var skip = false;
	//if(skip){
	//	exit;	
	//}
	
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
		var currentMiscString = currentTokenTagMap[?" MISC"]; //Might have to use scr_isNumericAndExists later on
		var currentTokenList = ds_list_create();
		ds_list_add(currentTokenList, currentToken);

		//show_debug_message(currentMiscString);
		
		if(!is_string(currentMiscString)){ //undefined guard
			continue;
		}
		
		if(string_pos("Entity=", currentMiscString) != 0){ //verifies that there is an entity being referenced
			
			//need to clean up the coreference string to create a key
			var currentEntityKey = string_replace(currentMiscString, "Entity=", "");
			currentEntityKey = string_replace(currentEntityKey,"SpaceAfter=No","");
			
			//case of more than one entity being referenced in a token
			if(string_count("(",currentEntityKey) > 1 or string_count(")",currentEntityKey) > 1){
				//figure this out later
			}
			else{
				
				currentEntityKey = string_replace(currentEntityKey, "(", "");
				currentEntityKey = string_replace(currentEntityKey, ")", "");
				if(string_pos("(", currentMiscString) != 0 and string_pos(")", currentMiscString) == 0){
					var j = i;
					var subToken = tokenList[|j];
					var subTokenSubMap = global.nodeMap[?subToken];
					var subTokenTagMap = subTokenSubMap[?"tagMap"];
					var subMiscString = subTokenTagMap[?" MISC"];
					while(string_pos(currentEntityKey + ")", subMiscString) != 0){
						j++;
						subToken = tokenList[|j];
						subTokenSubMap = global.nodeMap[?subToken];
						subTokenTagMap = subTokenSubMap[?"tagMap"];
						subMiscString = subTokenTagMap[?" MISC"];
						ds_list_add(currentTokenList, subToken);
					}
					
				}
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
		show_debug_message(string(key));
		show_debug_message(scr_getStringOfList(currentEntityList));
		for(var j = 0; j < ds_list_size(currentEntityList); j++){ //iterate through the list of tokens in each entity
			var currentEntitySubList = currentEntityList[|j];
			var currentFirstTokenID = currentEntitySubList[|0];
			var currentFirstTokenSubMap = global.nodeMap[?currentFirstTokenID];
			var currentUnit = currentFirstTokenSubMap[?"unit"];
			if(ds_list_size(currentEntitySubList) > 1){
				//this is the condition for creating chunks, might have to put this if statement somewhere else
				var currentEntitySubListSize = ds_list_size(currentEntitySubList);
				obj_control.inRectTokenIDList = currentEntitySubList;
				var unitList = ds_list_create();
				ds_list_add(unitList, currentUnit);
				obj_control.inRectUnitIDList = unitList;
				scr_createChunk();
			}
			
			
			if (j == 0) { // have to check this qualifier
				scr_newChain(currentFirstTokenID);
			}
			
			scr_newLink(currentFirstTokenID);
		}
		scr_chainDeselect();
		key = ds_map_find_next(entityMap, key);
	}
	show_debug_message(string(entityMapSize));
}