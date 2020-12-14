/*
	scr_sentStackerLoop();
	
	Last Updated: 2020-10-26

	
	Called from: obj_stacker
	
	Purpose: Create stacks throughout the whole discourse, from sets of lines delimited by Turn Order and End Notes selected by the user
	
	Mechanism: Loop through all lines in the discourse, create sets of lines delimited by turn order and end notes, then once line sets are created generate stacks from those line sets.
	
	Author: Terry DuBois, Georgio Klironomos
*/
function scr_sentStackerLoop(){
	
	// Set oft used variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var unitImportGridHeight = ds_grid_height(global.unitImportGrid);
	var unitImportColNameListSize = ds_list_size(global.unitImportColNameList);
	var tokenImportColNameListSize = ds_list_size(global.tokenImportColNameList);
	var tokenImportGridHeight = ds_grid_height(global.tokenImportGrid);
	var unitCol = -1;
	var turnCol = -1;
	var endNoteTagsGridHeight = ds_grid_height(endNoteTagsGrid);
	var endNoteTagMatch = false;

	// Find the UnitID column and TurnID column within the UnitImportGrid
	for (var unitColLoop = 0; unitColLoop < unitImportColNameListSize; unitColLoop++) {

		if (ds_list_find_value(global.unitImportColNameList, unitColLoop) == "~UnitID") {
			unitCol = unitColLoop;
			show_debug_message("obj_stacker Alarm 4 ... unitCol: " + string(unitCol));
			continue;
		}
		
		if (string(ds_list_find_value(global.unitImportColNameList, unitColLoop)) == "turnId") {
			turnCol = unitColLoop;
			show_debug_message("obj_stacker Alarm 4 ... turnCol: " + string(turnCol));
			continue;
		}

	}

	// Exit script if no turnOrder column was found
	if (turnCol == -1) {
		show_message(scr_get_translation("msg_order-notfound"));
		splitSave = false;

		exit;	
	}
	
	if (endCol == -1) {
		show_message(scr_get_translation("msg_note-column"));
		splitSave = false;

		exit;	
	}
	

	// Set variables for loop
	var currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, 0);
	var previousTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, 0);

	//Starting at the top of the unitImportGrid
	for (var tokenImportLoop = 0; tokenImportLoop < unitImportGridHeight; tokenImportLoop++) {
	
		currentTurnOrder = ds_grid_get(global.unitImportGrid, turnCol, tokenImportLoop);
		previousTurnOrder = currentTurnOrder;
	
		// Loop through lines until we hit a new turn order, or until we hit a designated endNote
		while ((currentTurnOrder == previousTurnOrder) and (tokenImportLoop < unitImportGridHeight) and not endNoteTagMatch) { 	
			var randUnit = ds_grid_get(global.unitImportGrid, unitCol, tokenImportLoop);
			
			// Get the WordIDList
			var randWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, randUnit - 1);
			var randWordIDListSize = ds_list_size(randWordIDList);
			var loopBreak = false;
			
			//Loop through the wordID list to check for designated endNotes
			for (var wordListLoop = 0; wordListLoop < randWordIDListSize; wordListLoop++) {
				var currentWordID = ds_list_find_value(randWordIDList, wordListLoop);
				var currentEndNoteTag = ds_grid_get(global.tokenImportGrid, endCol, currentWordID - 1);
				
				// Check if the word's endNote tag is one of the user designated end notes
				for (var endTagsLoop = 0; endTagsLoop < endNoteTagsGridHeight; endTagsLoop++) {
					if(ds_grid_get(endNoteTagsGrid, endNoteTagsGrid_colChecked, endTagsLoop)) {
						if(string_lower(currentEndNoteTag) == ds_grid_get(endNoteTagsGrid, endNoteTagsGrid_colTag, endTagsLoop)) {
							endNoteTagMatch = true;
							loopBreak = true;
							break;
						//	show_debug_message("true");
							//break;
						}
					}
				}
				
				if(loopBreak) {
					break;
				}
			}
			
			// Add this unit to the Line set
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
			ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);

		}
	
		ds_list_clear(currentUnitList);
		endNoteTagMatch = false;
	}
	splitSave = false;
}