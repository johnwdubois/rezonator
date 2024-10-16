function scr_linkClickOptions(optionSelected) {
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	show_debug_message("scr_linkClickOptions, optionSelected: " + string(optionSelected));
	
	if (optionSelected == "option_create-new-field") {
		obj_control.newCustomFieldLink = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		instance_destroy();
	}
	else if (optionSelected == "help_label_delete-link") {
		scr_deleteTreeLink();
		instance_destroy();
	}
	else if (optionSelected == "Tag Link") {

		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, global.linkFieldList);
		ds_list_insert(dropDownOptionList, 0, "option_create-new-field");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeLinkFields);
	}
	else {
		scr_destroyAllDropDownsOtherThanSelf();
		
		var indexOfList = ds_list_find_index(global.linkFieldList, optionSelected);
		var linkFieldSubMap = global.linkFieldMap[? optionSelected];
		if (scr_isNumericAndExists(linkFieldSubMap, ds_type_map)) {
			obj_control.linkFieldSelected = optionSelected;
			
			var linkTagSet = linkFieldSubMap[? "tagSet"];
			if (scr_isNumericAndExists(linkTagSet, ds_type_list)) {
		
				var dropDownOptionList = ds_list_create();
				
				ds_list_copy(dropDownOptionList, linkTagSet);
				ds_list_insert(dropDownOptionList, 0, "msg_create_tag");
				
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * (indexOfList + 2)), dropDownOptionList, global.optionListTypeLinkTag);
			}
		}
	}
	
	
	
}