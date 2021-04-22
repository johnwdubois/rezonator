// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawStack(unitSubMap, camWidth, pixelY){
	
	// get chainID
	var unitsInChainsList = unitSubMap[? "inChainsList"];	
	var chainID = "";
	if (scr_isNumericAndExists(unitsInChainsList, ds_type_list)) {
		if (ds_list_size(unitsInChainsList) > 0) {
			chainID = unitsInChainsList[|0];
		}
	}
	if (chainID == "") exit;
	

	//draw stacks
	var drawStackRect = false;
	if (obj_chain.toggleDrawStack) {
		if (ds_map_exists(global.nodeMap, chainID)) {
				
			var stackChainSubMap = global.nodeMap[? chainID];
			if (scr_isNumericAndExists(stackChainSubMap, ds_type_map)) {
				var stackColor = stackChainSubMap[? "chainColor"];
				var stackVisible = stackChainSubMap[? "visible"];
				draw_set_color(stackColor);
				draw_set_alpha(0.2);
				if (stackVisible) drawStackRect = true;
			}
			
		}
		else {
			if (ds_list_size(inRectUnitIDList) > 0) {
				if (ds_list_find_index(inRectUnitIDList, currentUnit) > -1) {
						
					var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
					if (scr_isNumericAndExists(focusedChainSubMap, ds_type_map)) {
						var stackColor = focusedChainSubMap[? "chainColor"];
						var stackVisible = focusedChainSubMap[? "visible"];
						draw_set_color(stackColor);
						draw_set_alpha(0.2);
						if (stackVisible) drawStackRect = true;
					}
				}
			}
		}
	}

		
	if (drawStackRect) {
		var stackRectY1 = pixelY - (gridSpaceVertical * 0.5);
		var stackRectX1 = wordLeftMargin;
		var stackRectX2 = camWidth;				
		var stackRectY2 = stackRectY1 + gridSpaceVertical;
		draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
	}


}