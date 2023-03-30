function scr_sentStackerLoop() {
	
	show_debug_message("scr_sentStackerLoop, global.participantField: " + string(global.participantField));

	// Set script variables
	var currentUnitList = ds_list_create();
	ds_list_clear(currentUnitList);


	// Exit script if no turnOrder column was found
	if (global.participantField == "" or is_undefined(global.participantField)) {
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.alertWindowActive = true;
		obj_control.noTurnFound = true;
		splitSave = false;

		exit;	
	}
	
	// set active stackType
	scr_createNewStacking(obj_stacker.stacker_stackingName, obj_stacker.stacker_stacksName, "Turn");
	
	//Set variables for loop
	var currentParticipant = "";
	var previousParticipant = "";
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	var unitListSize = ds_list_size(unitList);
	show_debug_message("unitListSize: " + string(unitListSize));
	
	//Starting at the top of the unitImportGrid
	for (var importLoop = 0; importLoop < unitListSize; importLoop++) {
		var currentUnit = unitList[| importLoop];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		var unitTagMap = currentUnitSubMap[? "tagMap"];
		currentParticipant = unitTagMap[? global.participantField];
		show_debug_message("scr_sentStackerLoop, currentParticipant: " + string(currentParticipant));
		previousParticipant = currentParticipant;
		
		// Loop through lines until we hit a new turn order
		while ((currentParticipant == previousParticipant) and (importLoop < unitListSize)) { 	
			currentUnit = unitList[|importLoop];

			currentUnitSubMap = global.nodeMap[? currentUnit];
			unitTagMap = currentUnitSubMap[? "tagMap"];
			currentParticipant = unitTagMap[? global.participantField];
			if ((currentParticipant == previousParticipant)) {
				ds_list_add(currentUnitList, currentUnit);
				importLoop++;
			}

			show_debug_message("scr_sentStackerLoop, WHILE currentParticipant: " + string( currentParticipant));
		}
		importLoop--;

	
		// Create a Stack based on the current Set of Lines
		show_debug_message("scr_sentStackerLoop, currentUnitListSize: " + string(ds_list_size(currentUnitList)));
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
			
			// if we are running ai stacker, apply aichat id as a tag of the new stack
			if (global.project == "import" && global.importType == IMPORTTYPE_AICHAT && is_string(obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "") {
				// first let's get the chatID from the first unit
				var chatID = "";
				var firstUnitSubMap = global.nodeMap[? firstUnitID];
				if (scr_isNumericAndExists(firstUnitSubMap, ds_type_map)) {
					var firstUnitTagMap = firstUnitSubMap[? "tagMap"];
					if (scr_isNumericAndExists(firstUnitTagMap, ds_type_map)) {
						chatID = firstUnitTagMap[? "ChatID"];
					}
				}
			
				show_debug_message("scr_sentStackerLoop, chatID: " + string(chatID));
				if (is_string(chatID) && chatID != "") {
					// create a new field for chatID if we need to
					if (ds_list_find_index(global.chainFieldList, "ChatID") == -1) {
						obj_control.inputText = "ChatID";
						scr_dialogueBoxNewCustomFieldChain();
						obj_control.inputText = "";
					}
					
					// set the tag for this field in stack
					var focusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
					if (scr_isNumericAndExists(focusedChainSubMap, ds_type_map)) {
						var focusedChainTagMap = focusedChainSubMap[? "tagMap"];
						if (scr_isNumericAndExists(focusedChainTagMap, ds_type_map)) {
							focusedChainTagMap[? "ChatID"] = chatID;
						}
					}
				}
			}
			
			// Unfocus all links and chains
			scr_chainDeselect();
		}
	
		ds_list_clear(currentUnitList);
	}
	splitSave = false;
}