

function scr_fieldUnits1To1Options(optionSelected){
	
	var optionSpacingMulti = ds_list_find_index(optionList, optionSelected);
	
	if (optionSelected == "option_select-field") {
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, obj_control.unitFieldList);
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeUnitSelection);
		
	}
	else if (optionSelected == "option_create-new-field"
	|| optionSelected == "option_add-to-tag-set"
	|| optionSelected == "Show in translation tab") {
		scr_unitMarkerOptions(optionSelected);
	}
	else if (optionSelected == "option-remove-tag-set") {
		
		// get tagSet for selected field
		var unitTagMap = global.nodeMap[? "unitTagMap"];
		var tagSubMap = unitTagMap[? obj_control.unitFieldToChange];
		if (!scr_isNumericAndExists(tagSubMap, ds_type_map)) exit;
		var tagSet = tagSubMap[? "tagSet"];
		if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
		show_debug_message("scr_fieldUnits1To1Options ... tagSet: " + scr_getStringOfList(tagSet));
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, tagSet);
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeRemoveFromTagSetUnits1To1);
		
	}
	else if (optionSelected == "Show in main screen") {
		global.participantField = obj_control.unitFieldToChange;
		instance_destroy();
	}
	

}