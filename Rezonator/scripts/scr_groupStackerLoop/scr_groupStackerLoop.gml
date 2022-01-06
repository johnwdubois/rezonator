function scr_groupStackerLoop(){
	
	global.delayInput = 0;
	
	show_debug_message("scr_groupStackerLoop");
	
	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var importGridHeight = ds_grid_height(global.importGrid);
	var groupCol = -1;


    // Find the UnitID column and TurnID column within the UnitImportGrid
	for (var groupColLoop = 0; groupColLoop < ds_list_size(global.importGridColNameList); groupColLoop++) {

		if (ds_list_find_value(global.importGridColNameList, groupColLoop) == "Group") {
			groupCol = groupColLoop;
			show_debug_message("scr_groupStackerLoop ... groupCol: " + string(groupCol));
			break;
		}

	}


	// Exit script if no turnOrder column was found
	if (groupCol == -1) {
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.alertWindowActive = true;
		obj_control.noTurnFound = true;
		splitSave = false;
		show_debug_message("scr_groupStackerLoop, splitSave is false. Exiting...");
		exit;	
	}
	
	
	//Set variables for loop
	var currentGroupOrder = ds_grid_get(global.importGrid, groupCol, 0);
	var previousGroupOrder = ds_grid_get(global.importGrid, groupCol, 0);
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[?"unitList"];

	//Starting at the top of the unitImportGrid
	for (var importLoop = 0; importLoop < importGridHeight; importLoop++) {
	
		currentGroupOrder = ds_grid_get(global.importGrid, groupCol, importLoop);
		previousGroupOrder = currentGroupOrder;
		
		// Loop through lines until we hit a new turn order
		while ((currentGroupOrder == previousGroupOrder) and (importLoop < importGridHeight)) { 	
			var currentUnit = unitList[|importLoop];
			ds_list_add(currentUnitList, currentUnit);
			importLoop++;
			
			if (importLoop < importGridHeight && importLoop >= 0) {
				currentGroupOrder = ds_grid_get(global.importGrid, groupCol, importLoop);
			}

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
			scr_chainDeselect();

		}
	
		ds_list_clear(currentUnitList);
	}
	splitSave = false;
	
	global.delayInput = 5;
}