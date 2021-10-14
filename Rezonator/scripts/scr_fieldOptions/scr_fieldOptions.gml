function scr_fieldOptions(optionSelected, type) {
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	if (optionSelected == "option_create-new-field") {
		if(type == "Token"){
			obj_control.newCustomFieldToken = true;
		}
		if(type == "Unit"){
			obj_control.newCustomFieldUnit = true;
		}
		else if(type == "Entry"){
			obj_control.newCustomFieldEntry = true;
		}
		else if(type == "Chain"){
			obj_control.newCustomFieldChain = true;
		}
		else if(type == "Chunk"){
			obj_control.newCustomFieldChunk = true;
		}
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		instance_destroy();
	}

	else {
		scr_destroyAllDropDownsOtherThanSelf();
		var currentOptionListType = global.optionListTypeTokenTagMap;
		if(type == "Token"){
			var indexOfList = ds_list_find_index(global.tokenFieldList, optionSelected);
			var fieldMap = global.nodeMap[?"tokenTagMap"];
		}
		else if(type == "Unit"){
			var indexOfList = ds_list_find_index(obj_control.unitFieldList, optionSelected);
			var fieldMap = global.nodeMap[?"unitTagMap"];
			currentOptionListType = global.optionListTypeUnitTagMap;
		}
		else if(type == "Entry"){
			var indexOfList = ds_list_find_index(global.chainEntryFieldList, optionSelected);
			var fieldMap = global.nodeMap[?"entryTagMap"];
			currentOptionListType = global.optionListTypeEntryTagMap;
		}
		else if(type == "Chain"){
			var indexOfList = ds_list_find_index(global.chainFieldList, optionSelected);
			var fieldMap = global.nodeMap[?"chainTagMap"];
			currentOptionListType = global.optionListTypeChainTagMap;
		}
		else if(type == "Chunk"){
			var indexOfList = ds_list_find_index(obj_control.chunkFieldList, optionSelected);
			var fieldMap = global.nodeMap[?"tokenTagMap"];
		}
		var mapsize = ds_map_size(fieldMap);
		var tokenFieldSubMap = fieldMap[? optionSelected];
		mapsize = ds_map_size(tokenFieldSubMap);
		obj_control.tokenFieldToChange = optionSelected;
		obj_control.unitFieldToChange = optionSelected;
		if (scr_isNumericAndExists(tokenFieldSubMap, ds_type_map)) {			
			var tokenTagSet = tokenFieldSubMap[? "tagSet"];
			if (scr_isNumericAndExists(tokenTagSet, ds_type_list)) {
				var dropDownOptionList = ds_list_create();
				
				ds_list_copy(dropDownOptionList, tokenTagSet);
				ds_list_insert(dropDownOptionList, 0, "option_add-to-tag-set");
				
				scr_createDropDown(x + obj_dropDown.windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, currentOptionListType);
			}
		}
	}

}
