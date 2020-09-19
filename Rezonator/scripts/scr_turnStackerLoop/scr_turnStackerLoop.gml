// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_turnStackerLoop(){
	
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
	var unitCol = -1;
	var turnCol = -1;


	for (var unitColLoop = 0; unitColLoop < ds_list_size(global.unitImportColNameList); unitColLoop++) {

		if (ds_list_find_value(global.unitImportColNameList, unitColLoop) == "~UnitID") {
			unitCol = unitColLoop;
			show_debug_message("obj_stacker Alarm 4 ... unitCol: " + string(unitCol));
			break;
		}

	}

	for (var turnColLoop = 0; turnColLoop < ds_list_size(global.unitImportColNameList); turnColLoop++) {

		if (string(ds_list_find_value(global.unitImportColNameList, turnColLoop)) == "turnId") {
			turnCol = turnColLoop;
			show_debug_message("obj_stacker Alarm 4 ... turnCol: " + string(turnCol));
			break;
		}
	}

	if (turnCol == -1) {
		show_message("No turn order found");
		splitSave = false;

		exit;	
	}

	//var turnOrderCol = //how do i get??
	var currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, 0);
	var previousTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, 0);

	//Starting at the top of the unitImportGrid
	for (var tokenImportLoop = 0; tokenImportLoop < unitImportGridHeight; tokenImportLoop++) {
	
		currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, tokenImportLoop);
		previousTurnOrder = currentTurnOrder;
	
		while ((currentTurnOrder == previousTurnOrder) and (tokenImportLoop < unitImportGridHeight)) { 	
			var randUnit = ds_grid_get(global.unitImportGrid, unitCol, tokenImportLoop);
			ds_list_add(currentUnitList, randUnit);
			tokenImportLoop++;
			currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, tokenImportLoop);
			//show_message(currentTurnOrder);
		}
		tokenImportLoop--;
	
		show_debug_message("obj_stacker Alarm 4 ... currentUnitList: " + scr_getStringOfList(currentUnitList));
	
		if (ds_list_size(currentUnitList) > 0) {
			//show_message(scr_getStringOfList(currentUnitList));
			var firstUnitID = ds_list_find_value(currentUnitList, 0);
			var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, firstUnitID - 1);
			var firstWordID = ds_list_find_value(currentWordIDList, 0);
			var prevUnitID = -1;
	
			// Loop through words found in rectangle at time of mouse release
			var inRectUnitIDListSize = ds_list_size(currentUnitList);
			for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
				var currentUnitID = ds_list_find_value(currentUnitList, quickStackLoop);
					if(currentUnitID != prevUnitID) {
					currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
					var currentWordID = ds_list_find_value(currentWordIDList, 0);
					obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
					with (obj_chain) {
						scr_wordClicked(firstWordID, firstUnitID);
						scr_wordClicked(currentWordID, currentUnitID);
					}
				}
				prevUnitID = currentUnitID;
			}
			// Unfocus all links and chains
			scr_unFocusAllChains();
			ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);

		}
	
		if(tokenImportLoop >= unitImportGridHeight) {
		//	show_message(scr_getStringOfList(currentUnitList));	
		}
		ds_list_clear(currentUnitList);
		// switch randLines to next set of units

		//global.fileSaveName = global.fileSaveName + string(fileNameNumber++);
	}
	splitSave = false;


}