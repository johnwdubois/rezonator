// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createChunk(){
	
	// Place all captured unit and word info into the box grid
	var inRectWordIDListSize = ds_list_size(inRectWordIDList);
	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);
	if(inRectWordIDListSize <= 1){ exit;}

	if (inRectWordIDListSize > 0 and inRectUnitIDListSize <= 0 and obj_control.mouseRectWithinLine) {
		var wordID = ds_list_find_value(inRectWordIDList, 0);
		var unitID = ds_grid_get(wordGrid, wordGrid_colUnitID, wordID - 1);
		ds_list_add(inRectUnitIDList, unitID);
	}
	inRectUnitIDListSize = ds_list_size(inRectUnitIDList);
	
	
	if (inRectUnitIDListSize > 0 && inRectWordIDListSize > 0) { // Make sure the box captured something

		// Retrieve references of the lists being added to
		var currentUnitList = ds_list_create();
		var tokenIDList = ds_list_create();
		var inChainsList = ds_list_create();
		
		// copy contents of inRectWordIDList into tokenIDList
		ds_list_copy(tokenIDList, inRectWordIDList);
		show_debug_message("scr_createChunk() ... tokenIDList: " + scr_getStringOfList(tokenIDList));
		
		// create Chunk new node in node map
		var chunkID = scr_addToNodeMap("chunk");
		var chunkSubMap = global.nodeMap[? chunkID];
		ds_map_add_list(chunkSubMap, "tokenList", tokenIDList);
		ds_map_add_list(chunkSubMap, "inChainsList", inChainsList);
		
		//set to focused chunk
		obj_chain.currentFocusedChunkID = chunkID;
		
		// loop over tokenIDList and tell each word what its chunk is
		var tokenIDListSize = ds_list_size(tokenIDList);
		for (var i = 0; i < tokenIDListSize; i++) {
			var currentTokenID = tokenIDList[| i];
			var currentTokenInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentTokenID - 1);
			if (ds_list_find_index(currentTokenInBoxList, chunkID) == -1) ds_list_add(currentTokenInBoxList, chunkID);
		}
		

	}
		

	// Clear the rect word list for next use
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);


	// Reset all box grid variables
	boxHoldRectX1 = 0; 
	boxHoldRectX2 = 0; 
	boxHoldRectY1 = 0; 
	boxHoldRectX2 = 0; 
	boxRectMade = false;
	boxRectReleased = true;
	boxRectAbleToInitiate = true;
	obj_control.mouseRectWithinLine = false;
	obj_control.mouseRectWithinColumn = false;
	boxRectWithinLine = false;




}