/*
	scr_turnStackerLoop();
	
	Last Updated: 2020-10-26
	
	Called from: obj_stacker
	
	Purpose: Create stacks throughout the whole discourse, from sets of lines delimited by Turn Order
	
	Mechanism: Loop through all lines in the discourse, create sets of lines delimited by turn order, then once line sets are created generate stacks from those line sets.
	
	Author: Terry DuBois, Georgio Klironomos
*/
function scr_groupStackerLoop(){
	
	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var importGridHeight = ds_grid_height(global.importGrid);
	var groupCol = -1;


    // Find the UnitID column and TurnID column within the UnitImportGrid
	for (var groupColLoop = 0; groupColLoop < ds_list_size(global.importGridColNameList); groupColLoop++) {

		if (ds_list_find_value(global.importGridColNameList, groupColLoop) == "Group") {
			groupCol = groupColLoop;
			show_debug_message("scr_groupStackerLoop() ... groupCol: " + string(groupCol));
			break;
		}

	}


	// Exit script if no turnOrder column was found
	if (groupCol == -1) {
		show_message(scr_get_translation("msg_order-notfound"));
		splitSave = false;

		exit;	
	}
	
	//show_message("Import grid height: "  + string(importGridHeight)+ "groupCol: " + string(groupCol) );

	//Set variables for loop
	var currentGroupOrder = ds_grid_get(global.importGrid, groupCol, 0);
	var previousGroupOrder = ds_grid_get(global.importGrid, groupCol, 0);

	//Starting at the top of the unitImportGrid
	for (var importLoop = 0; importLoop < importGridHeight; importLoop++) {
	
		currentGroupOrder = ds_grid_get(global.importGrid, groupCol, importLoop);
		previousGroupOrder = currentGroupOrder;
		
		// Loop through lines until we hit a new turn order
		while ((currentGroupOrder == previousGroupOrder) and (importLoop < importGridHeight)) { 	
			var randUnit = importLoop+1;
			ds_list_add(currentUnitList, randUnit);
			importLoop++;
			currentGroupOrder = ds_grid_get(global.importGrid, groupCol, importLoop);
			//show_message(currentGroupOrder);
		}
		importLoop--;
	
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