// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_fieldChains1ToManyOptions(optionSelected){
	
	if (optionSelected == "Set Field") {
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, scr_getChainEntryFieldList(obj_panelPane.fieldChains1ToManyChainType));
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypeChain1ToManyField);
		
	}
	else if (optionSelected == "Create Field") {
		
		scr_chain1ToManyHeaderRightClickOptions(optionSelected);
	}
	else if (optionSelected == "Add new Tag") {
		obj_control.newCustomTagEntry = true;
		obj_control.dialogueBoxActive = true;
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	}
	else if (optionSelected == "Remove From Tag Set") {
		
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
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 3), dropDownOptionList, global.optionListTypeRemoveFromTagSetChains1ToMany);
		
		
	}
		
	

}