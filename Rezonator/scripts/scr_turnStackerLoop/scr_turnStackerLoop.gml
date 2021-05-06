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
	var turnCol = -1;

	for (var turnColLoop = 0; turnColLoop < ds_list_size(global.unitImportColNameList); turnColLoop++) {

		if (string(ds_list_find_value(global.unitImportColNameList, turnColLoop)) == "turnSeq") {
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
			unitTagMap = currentUnitSubMap[?"tagMap"];
			currentTurnOrder = unitTagMap[?"turnSeq"];
			if((currentTurnOrder == previousTurnOrder)){
				ds_list_add(currentUnitList, currentUnit);
				importLoop++;
			}

			show_debug_message(currentTurnOrder);
		}
		importLoop--;

	
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
	}
	splitSave = false;
}