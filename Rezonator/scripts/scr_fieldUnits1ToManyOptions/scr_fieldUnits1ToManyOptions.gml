// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_fieldUnits1ToManyOptions(optionSelected){
	
	if (optionSelected == "Select field") {
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, obj_control.tokenFieldList);
		
		
		// check if the Unit tab or Chunk tab is selected, so we know where to draw the secondary dropDown out of
		var optionSpacingMulti = 3;
		with (obj_panelPane) {
			if (currentFunction == functionChainList) {
				if (functionChainList_currentTab == functionChainList_tabChunk) {
					var optionSpacingMulti = 2;
				}
			}
		}
		
		
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionSpacingMulti), dropDownOptionList, global.optionListTypeTokenSelection);
		
	}
	else if (optionSelected == "Create new field"
	|| optionSelected == "Add to tag set"
	|| optionSelected == "Set as Transcription") {
		scr_tokenMarkerOptions(optionSelected);
	}
	else if (optionSelected == "Remove from tag set") {
		
		// get tagSet for selected field
		var tokenTagMap = global.nodeMap[? "tokenTagMap"];
		var tagSubMap = tokenTagMap[? obj_control.tokenFieldToChange];
		if (!scr_isNumericAndExists(tagSubMap, ds_type_map)) exit;
		var tagSet = tagSubMap[? "tagSet"];
		if (!scr_isNumericAndExists(tagSet, ds_type_list)) exit;
		show_debug_message("scr_fieldUnits1ToManyOptions ... tagSet: " + scr_getStringOfList(tagSet));
		
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, tagSet);
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing), dropDownOptionList, global.optionListTypeRemoveFromTagSetUnits1ToMany);
		
	}
	else if (optionSelected == "Show in main screen") {
		global.displayTokenField = obj_control.tokenFieldToChange;
		instance_destroy();
	}
	

}