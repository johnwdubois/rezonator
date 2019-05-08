/// @description Insert description here
// You can write your code in this editor
//show_message("in alarm");
if (ds_list_size(inRectUnitIDList) > 0) {
	ds_grid_resize(obj_chain.boxChainGrid, obj_chain.chainGridWidth + 1, ds_grid_height(obj_chain.boxChainGrid) + 1);
	
	ds_grid_set(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList, ds_grid_height(obj_chain.boxChainGrid) - 1, ds_list_create());
	ds_grid_set(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList, ds_grid_height(obj_chain.boxChainGrid) - 1, ds_list_create());
	
	var currentUnitList = ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1 );
	var currentWordList = ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1);
	
	var innerLoop = 0;
	// Loop through words found in rectangle at time of mouse release
	for(var quickLoop = 0; quickLoop < ds_list_size(inRectUnitIDList); quickLoop++) {
		
		var currentWordID = ds_list_find_value(inRectWordIDList, quickLoop);
		var currentUnitID = ds_list_find_value(inRectUnitIDList, innerLoop);
		
		if(ds_list_find_index(currentUnitList, currentUnitID) < 0) {
			ds_list_add(currentUnitList, currentUnitID);
		}
		//show_message(scr_getStringOfList(ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1 )));
		while(currentUnitID == ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID + 1)) {
			if(ds_list_find_index(currentWordList, currentWordID) < 0) {
				ds_list_add(currentWordList, currentWordID);
			}
		var currentUnitID = ds_list_find_value(inRectUnitIDList, ++innerLoop);
		}
	}
	//show_message(scr_getStringOfList(ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1 )));
	scr_unFocusAllChains();
}


if (ds_list_size(inRectUnitIDList) > 0) {
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);
}

boxHoldRectX1 = 0; 
boxHoldRectX2 = 0; 
boxHoldRectY1 = 0; 
boxHoldRectX2 = 0; 
boxRectMade = false;
boxRectReleased = true;
boxRectAbleToInitiate = true;