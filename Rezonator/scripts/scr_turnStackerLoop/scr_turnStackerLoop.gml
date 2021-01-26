/*
	scr_turnStackerLoop();
	
	Last Updated: 2020-10-26
	
	Called from: obj_stacker
	
	Purpose: Create stacks throughout the whole discourse, from sets of lines delimited by Turn Order
	
	Mechanism: Loop through all lines in the discourse, create sets of lines delimited by turn order, then once line sets are created generate stacks from those line sets.
	
	Author: Terry DuBois, Georgio Klironomos
*/
function scr_turnStackerLoop(){
	
	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
	var unitCol = -1;
	var turnCol = -1;

    // Find the UnitID column and TurnID column within the UnitImportGrid
	for (var unitColLoop = 0; unitColLoop < ds_list_size(global.unitImportColNameList); unitColLoop++) {

		if (ds_list_find_value(global.unitImportColNameList, unitColLoop) == "~UnitID") {
			unitCol = unitColLoop;
			show_debug_message("scr_turnStackerLoop() ... unitCol: " + string(unitCol));
			break;
		}

	}

	for (var turnColLoop = 0; turnColLoop < ds_list_size(global.unitImportColNameList); turnColLoop++) {

		if (string(ds_list_find_value(global.unitImportColNameList, turnColLoop)) == "turnId") {
			turnCol = turnColLoop;
			show_debug_message("scr_turnStackerLoop() ... turnCol: " + string(turnCol));
			break;
		}
	}

	// Exit script if no turnOrder column was found
	if (turnCol == -1) {
		show_message(scr_get_translation("msg_order-notfound"));
		splitSave = false;

		exit;	
	}

	//Set variables for loop
	var currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, 0);
	var previousTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, 0);

	//Starting at the top of the unitImportGrid
	for (var tokenImportLoop = 0; tokenImportLoop < unitImportGridHeight; tokenImportLoop++) {
	
		currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, tokenImportLoop);
		previousTurnOrder = currentTurnOrder;
		
		// Loop through lines until we hit a new turn order
		while ((currentTurnOrder == previousTurnOrder) and (tokenImportLoop < unitImportGridHeight)) { 	
			var randUnit = ds_grid_get(global.unitImportGrid, unitCol, tokenImportLoop);
			ds_list_add(currentUnitList, randUnit);
			tokenImportLoop++;
			currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, tokenImportLoop);
			//show_message(currentTurnOrder);
		}
		tokenImportLoop--;
	
		// Create a Stack based on the current Set of Lines
		if (ds_list_size(currentUnitList) > 0) {
			
			var firstUnitID = ds_list_find_value(currentUnitList, 0);
			var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, firstUnitID - 1);
			var firstWordID = ds_list_find_value(currentWordIDList, 0);
			var prevUnitID = -1;
	
			// Loop through lines and click on them with the Stack Tool
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


		}
	
		ds_list_clear(currentUnitList);
	}
	splitSave = false;
}