function scr_fieldChains1To1Options(optionSelected){
	
	var optionSpacingMulti = ds_list_find_index(optionList, optionSelected);
	var navFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) {
				navFieldList = obj_control.chain1to1ColFieldListRez;
			}
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
				navFieldList = obj_control.chain1to1ColFieldListTrack;
			}
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
				navFieldList = obj_control.chain1to1ColFieldListStack;
			}
		}
	}
	
	show_debug_message("scr_fieldChains1To1Options ... optionSelected: " + string(optionSelected));
	
	if (optionSelected == "option_select-field") {
		
		// check if this field has a finite tagSet, to adjust where the 2nd dropdown should come out
		var tagSubMap = global.chainFieldMap[? obj_control.chain1to1FieldToChange];
		var fieldHasTagSet = false;
		if (scr_isNumericAndExists(tagSubMap, ds_type_map)) {
			fieldHasTagSet = ds_map_exists(tagSubMap, "tagSet");
		}
	
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, scr_getChainFieldList(obj_panelPane.fieldChains1To1ChainType));
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeChain1To1Field);
	
	}
	else if (optionSelected == "option_create-new-field") {
		
		scr_chain1To1HeaderRightClickOptions(optionSelected);
	}
	else if (optionSelected == "option_add-to-tag-set") {
		obj_control.newCustomTagChain = true;
		obj_control.dialogueBoxActive = true;
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	}
	else if (optionSelected == "option-remove-tag-set") {
		
		// get tagSet for selected field
		var entryTagMap = global.chainFieldMap;
		var tagSubMap = entryTagMap[? obj_control.chain1to1FieldToChange];
		if (!scr_isNumericAndExists(tagSubMap, ds_type_map)) exit;
		var tagSet = tagSubMap[? "tagSet"];
		if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
		show_debug_message("scr_fieldChains1To1Options ... tagSet: " + scr_getStringOfList(tagSet));
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, tagSet);
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeRemoveFromTagSetChains1To1);
		
	}
	else if (optionSelected == "Hide column") {
		if (ds_list_size(navFieldList) > 1) {
			show_debug_message("Hiding column: " + string(obj_panelPane.chosenCol));
			ds_list_delete(navFieldList, obj_panelPane.chosenCol);
		}
		instance_destroy();
	}
	else if (optionSelected == "Insert column") {
		
		scr_insertColumnDropDown(global.chainFieldList, navFieldList, "chain");
	
	}
		
	

}