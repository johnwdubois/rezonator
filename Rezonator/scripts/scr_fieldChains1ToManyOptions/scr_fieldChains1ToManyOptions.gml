

function scr_fieldChains1ToManyOptions(optionSelected){
	
	var optionSpacingMulti = ds_list_find_index(optionList, optionSelected);
	
	if (optionSelected == "option_select-field") {
		
		// check if this field has a finite tagSet, to adjust where the 2nd dropdown should come out
		var tagSubMap = global.entryFieldMap[? obj_control.chain1toManyFieldToChange];
		var fieldHasTagSet = false;
		if (scr_isNumericAndExists(tagSubMap, ds_type_map)) {
			fieldHasTagSet = ds_map_exists(tagSubMap, "tagSet");
		}
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, scr_getChainEntryFieldList(obj_panelPane.fieldChains1ToManyChainType));
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeChain1ToManyField);
		
	}
	else if (optionSelected == "option_create-new-field") {
		
		scr_chain1ToManyHeaderRightClickOptions(optionSelected);
	}
	else if (optionSelected == "option_add-to-tag-set") {
		obj_control.newCustomTagEntry = true;
		obj_control.dialogueBoxActive = true;
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	}
	else if (optionSelected == "option-remove-tag-set") {
		
		// get tagSet for selected field
		var entryTagMap = global.entryFieldMap;
		var tagSubMap = entryTagMap[? obj_control.chain1toManyFieldToChange];
		if (!scr_isNumericAndExists(tagSubMap, ds_type_map)) exit;
		var tagSet = tagSubMap[? "tagSet"];
		if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
		show_debug_message("scr_fieldChains1ToManyOptions ... tagSet: " + scr_getStringOfList(tagSet));
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, tagSet);
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeRemoveFromTagSetChains1ToMany);
		
		
	}
		
	

}