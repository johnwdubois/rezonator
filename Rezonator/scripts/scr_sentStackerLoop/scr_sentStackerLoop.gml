function scr_sentStackerLoop(){

	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);


	// Exit script if no turnOrder column was found
	if (global.speakerField == "" or is_undefined(global.speakerField)) {
		show_message(scr_get_translation("msg_order-notfound"));
		splitSave = false;

		exit;	
	}
	show_debug_message(global.speakerField)
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
		currentTurnOrder = unitTagMap[?global.speakerField];
		show_debug_message(currentTurnOrder);
		previousTurnOrder = currentTurnOrder;
		
		// Loop through lines until we hit a new turn order
		while ((currentTurnOrder == previousTurnOrder) and (importLoop < unitListSize)) { 	
			currentUnit = unitList[|importLoop];

			currentUnitSubMap = global.nodeMap[?currentUnit];
			unitTagMap = currentUnitSubMap[?"tagMap"];
			currentTurnOrder = unitTagMap[?global.speakerField];
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
			scr_chainDeselect();


		}
	
		ds_list_clear(currentUnitList);
	}
	splitSave = false;
}