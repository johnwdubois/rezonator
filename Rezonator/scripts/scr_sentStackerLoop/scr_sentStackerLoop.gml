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


		if (string(ds_list_find_value(global.unitImportColNameList, unitColLoop)) == "turnSeq") {
			turnCol = unitColLoop;
			show_debug_message("scr_sentStackerLoop() ... turnCol: " + string(turnCol));
			continue;
		}

	}

	// Exit script if no turnOrder column was found
	if (turnCol == -1) {
		show_message(scr_get_translation("msg_order-notfound"));
		splitSave = false;

		exit;	
	}
	
	
	//Set variables for loop
	var currentTurnOrder = 0;
	var previousTurnOrder = 0;
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[?"unitList"];
	var unitListSize = ds_list_size(unitList);
	
	//Starting at the top of the unitImportGrid
	for (var importLoop = 0; importLoop < unitListSize; importLoop++) {
		var currentUnit = unitList[|importLoop];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var unitTagMap = currentUnitSubMap[?"tagMap"];
		currentTurnOrder = unitTagMap[?"turnSeq"];
		previousTurnOrder = currentTurnOrder;
		
		// Loop through lines until we hit a new turn order
		while ((currentTurnOrder == previousTurnOrder) and (importLoop < unitListSize)) { 
			currentUnit = unitList[|importLoop];
			currentUnitSubMap = global.nodeMap[?currentUnit];
			var entryList = currentUnitSubMap[?"entryList"];
			// Get the WordIDList
			var randWordIDList = entryList;
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
		}

	
		// Create a Stack based on the current Set of Lines
		if (ds_list_size(currentUnitList) > 0) {
			
			var firstUnitID = ds_list_find_value(currentUnitList, 0);
			
			var prevUnitID = -1;
	
			// Loop through lines and click on them with the Stack Tool
			var inRectUnitIDListSize = ds_list_size(currentUnitList);
			for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
				var currentUnitID = ds_list_find_value(currentUnitList, quickStackLoop);
					if(currentUnitID != prevUnitID) {
					
					obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
					with (obj_chain) {
						scr_unitClicked(firstUnitID);
						scr_unitClicked(currentUnitID);
					}
				}
				prevUnitID = currentUnitID;
			}
			// Unfocus all links and chains
			scr_unFocusAllChains();

		}
	
		ds_list_clear(currentUnitList);
		endNoteTagMatch = false;
	}
	splitSave = false;
}