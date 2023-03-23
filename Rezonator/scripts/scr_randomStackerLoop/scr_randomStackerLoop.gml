function scr_randomStackerLoop() {
	
	// set active stackType
	scr_createNewStacking(obj_stacker.stacker_stackingName, obj_stacker.stacker_stacksName, "Random");
	
	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	var unitListSize = ds_list_size(unitList);
	var amountOfLines = irandom(7);
	
	//Starting at the top of the unitImportGrid
	for (var importLoop = 0; importLoop < unitListSize; importLoop++) {
		var currentUnitID = unitList[|importLoop];
		var currentUnitSubMap = global.nodeMap[?currentUnitID];
		


		
		// Loop through lines until we hit a new turn order
		while ((amountOfLines > 0) and (importLoop < unitListSize)) { 	
			currentUnitID = unitList[|importLoop];
			currentUnitSubMap = global.nodeMap[?currentUnitID];

			if ((amountOfLines > 0)) {
				ds_list_add(currentUnitList, currentUnitID);
				importLoop++;
			}
			amountOfLines--;

		}
		importLoop--;
		amountOfLines = floor(random(7));

	
		// Create a Stack based on the current Set of Lines
		if (ds_list_size(currentUnitList) > 0) {
			
			var firstUnitID = ds_list_find_value(currentUnitList, 0);
			
			var prevUnitID = -1;
	
			// Loop through lines and click on them with the Stack Tool
			var inRectUnitIDListSize = ds_list_size(currentUnitList);
			for (var quickStackLoop = 0; quickStackLoop < inRectUnitIDListSize; quickStackLoop++) {
				var currentUnitID = ds_list_find_value(currentUnitList, quickStackLoop);
					if (currentUnitID != prevUnitID) {
					
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
	// Unfocus all links and chains
	scr_chainDeselect();


	//reset the ransom numbers
	splitSave = false;
}
