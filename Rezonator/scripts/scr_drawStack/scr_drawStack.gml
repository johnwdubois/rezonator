// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawStack(unitID, unitSubMap, camWidth, pixelY){
	
	// get chainID
	var unitsInChainsList = unitSubMap[? "inChainsList"];	
	var chainID = "";
	if (scr_isNumericAndExists(unitsInChainsList, ds_type_list)) {
		if (ds_list_size(unitsInChainsList) > 0) {
			chainID = unitsInChainsList[|0];
		}
	}
	
	// if this stack cannot be found in the nodeMap, it should be taken out of the unit's inChainsList
	if (!ds_map_exists(global.nodeMap, chainID)) {
		scr_deleteFromList(unitsInChainsList, chainID);
	}
	
	// determine if this unit is in unitInRectList
	var unitInRect = false;
	if (ds_list_size(inRectUnitIDList) > 0 && mouse_x < wordLeftMargin) {
		var unitInRectIndex = ds_list_find_index(inRectUnitIDList, unitID);
		if (unitInRectIndex >= 0) {
			unitInRect = true;
		}
	}
	

	//draw stacks
	var drawStackRect = false;
	if (obj_chain.toggleDrawStack) {
		if (chainID != "") {
				
			// if this unit is in a stack, get that stack's color and check if its visible
			var stackChainSubMap = global.nodeMap[? chainID];
			if (scr_isNumericAndExists(stackChainSubMap, ds_type_map)) {
				var stackVisible = stackChainSubMap[? "visible"];
				if (stackVisible) {
					var stackColor = stackChainSubMap[? "chainColor"];
					draw_set_color(stackColor);
					draw_set_alpha(0.2);
					drawStackRect = true;
				}
			}
		}
		else if (unitInRect) {
			draw_set_color(c_blue);
			draw_set_alpha(0.15);
			drawStackRect = true;
		}
	}


	// draw the rectangle for this stack, if necessary
	if (drawStackRect) {
		var stackRectY1 = pixelY - (gridSpaceVertical * 0.5);
		var stackRectX1 = wordLeftMargin;
		var stackRectX2 = camWidth;				
		var stackRectY2 = stackRectY1 + gridSpaceVertical;
		draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
	}


}