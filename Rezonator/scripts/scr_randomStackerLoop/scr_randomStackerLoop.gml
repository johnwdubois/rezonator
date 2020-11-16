/*
	scr_randomStackerLoop();
	
	Last Updated: 2020-10-26
	
	Called from: obj_Stacker
	
	Purpose: Loop through random set of lines to create an assortment of stacks spanning the whole discourse
	
	Mechanism: with random start and endlines set, loop through the set of lines, and call wordClicked() with the tool set to the Stack Tool
	
	Author: Terry DuBois, Georgio Klironomos, Brady Moore
*/
function scr_randomStackerLoop() {
	
	//Loop through the random lkines until we hit the end of the discourse
	while (randLine2 <= endLine && randLine1 < endLine) { 
		
		// Loop through the current random line set
		for (var randUnitLoop = randLine1; randUnitLoop < randLine2; randUnitLoop++) {
			randUnit = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, randUnitLoop - 1);
			ds_list_add(stackerRandomCurrentUnitList, randUnit);
		}
		//show_debug_message("obj_stacker Alarm1 ... stackerRandomCurrentUnitList: " + scr_getStringOfList(stackerRandomCurrentUnitList));
	
		// Collect information of the first unit in the set of lines
		var firstUnitID = ds_list_find_value(stackerRandomCurrentUnitList, 0);
		var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, firstUnitID - 1);
		var firstWordID = ds_list_find_value(currentWordIDList, 0);
	
		// Loop through the set of lines to create a stack
		var inRectUnitIDListSize = ds_list_size(stackerRandomCurrentUnitList);
		for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
		
			with (obj_toolPane) {
				currentMode = modeRez;
			}
			with (obj_panelPane) {
				functionChainList_currentTab = functionChainList_tabStackBrush;
			}
		
			var currentUnitID = ds_list_find_value(stackerRandomCurrentUnitList, quickStackLoop);
			currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
			var currentWordID = ds_list_find_value(currentWordIDList, 0);
			with (obj_chain) {
				scr_wordClicked(firstWordID, firstUnitID);
				scr_wordClicked(currentWordID, currentUnitID);
			}
		}
		// Unfocus all links and chains
		scr_unFocusAllChains();
		ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);

		// randomize the lines for the next set
		randLine1 = randLine2;
		randLine2 = randLine1 + floor(random(7) + 1);
		ds_list_clear(stackerRandomCurrentUnitList);
		//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
	}
	//reset the ransom numbers
	splitSave = false;
	randLine1 = 1;
	randLine2 = randLine1 + floor(random(7)) + 1;
}
