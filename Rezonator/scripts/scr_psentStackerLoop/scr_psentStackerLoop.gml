function scr_psentStackerLoop() {

	// Set script variables
	var currentUnitList = ds_list_create();

	// Exit script if no turnOrder column was found
	if (global.psentDelimField == "" or is_undefined(global.psentDelimField)) {
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.alertWindowActive = true;
		obj_control.noPsentFound = true;
		splitSave = false;
		exit;	
	}
	
	// set active stackType
	scr_createNewStacking(obj_stacker.stackerName, "Utterance");
	
	//Set variables for loop
	var currentPsent = 0;
	var psentMap = ds_map_create();
	
	
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	var unitListSize = ds_list_size(unitList);
	var listOfKeys = ds_list_create();
	for (var i = 0; i < unitListSize; i++) {
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var unitTagMap = currentUnitSubMap[? "tagMap"];
		currentPsent = unitTagMap[?global.psentDelimField];
		if (ds_map_exists(psentMap, currentPsent)) {
			scr_addToListOnce(psentMap[?currentPsent], currentUnit);
		}
		else {
			var psentUnitList = ds_list_create();
			ds_list_add(psentUnitList,currentUnit);
			ds_map_add_list(psentMap,currentPsent,psentUnitList);
			scr_addToListOnce(listOfKeys, currentPsent);
		}
		
	}
	
	var listOfKeysSize = ds_list_size(listOfKeys);
	for (var i = 0; i < listOfKeysSize; i++) {
		var currentPsent = listOfKeys[|i];
		var unitToStackList =  psentMap[?currentPsent];
		var unitToStackListSize = ds_list_size(unitToStackList);
		for (var j = 0; j < unitToStackListSize; j++) {
			scr_unitClicked(unitToStackList[|j]);
		}

		scr_chainDeselect();
	}
	ds_list_destroy(listOfKeys);
	ds_map_destroy(psentMap);

}