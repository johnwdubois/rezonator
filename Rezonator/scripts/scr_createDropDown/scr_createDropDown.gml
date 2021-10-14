// Create Dropdown Lists

function scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, dropDownOptionListType){
	
	// validate dropdownoptionlist
	if (!scr_isNumericAndExists(dropDownOptionList, ds_type_list)) {
		show_debug_message("scr_createDropDown ... invalid dropDownOptionList. Exiting");
		exit;
	}
	var dropDownOptionListSize = ds_list_size(dropDownOptionList);
	if (dropDownOptionListSize < 1) {
		show_debug_message("scr_createDropDown ... dropDownOptionList is empty. Exiting");
		exit;
	}
	

	var dropDownHeight = ds_list_size(dropDownOptionList) * string_height("0") * 1.25;
	var camViewHeight = camera_get_view_height(view_get_camera(0));
	if (dropDownY + dropDownHeight > camViewHeight) {
		var adjustedHeight = ds_list_size(dropDownOptionList) * string_height("0") * 1.25;
		dropDownY -= adjustedHeight;	
	}
	dropDownY = clamp(dropDownY, 0, camViewHeight);
	
	var dropDownDepth = -1;
	if (instance_exists(obj_control)) dropDownDepth = obj_control.menuDepth;
	var dropDownInst = instance_create_depth(dropDownX, dropDownY, dropDownDepth, obj_dropDown);
	dropDownInst.optionList = dropDownOptionList;
	dropDownInst.optionListType = dropDownOptionListType;
	dropDownInst.level = instance_number(obj_dropDown);
	with(obj_dropDown){
		
		var maxStrWidth = originalWindowWidth;
		for (var i = 0; i < dropDownOptionListSize; i++) {
			var currentOptionStr = string(ds_list_find_value(optionList, i));
			var shortcutStr = "";
			if(ds_map_exists(global.keyboardShortcutMap, currentOptionStr)){
				shortcutStr = ds_map_find_value(global.keyboardShortcutMap, currentOptionStr);	
			}
	
			currentOptionStr = scr_get_translation(currentOptionStr);
	
			var currentOptionStrWidth = string_width(currentOptionStr) + string_width(shortcutStr) + (textBuffer * 2);
			if (currentOptionStrWidth > maxStrWidth) {
				maxStrWidth = currentOptionStrWidth;
			}
		}
		windowWidth = maxStrWidth;	
		
	}
	//if(global.lang_codes[| global.lang_index] == "he" and instance_number(obj_dropDown) == 1){
	//		dropDownInst.x -= dropDownInst.windowWidth;
	//	}
	//	if(global.lang_codes[| global.lang_index] == "he" and instance_number(obj_dropDown) == 2){
	//		dropDownInst.x -= 2*windowWidth;
	//	}
		
	if(global.lang_codes[| global.lang_index] == "he"){
		dropDownInst.x -= instance_number(obj_dropDown) * dropDownInst.windowWidth;
		if(instance_number(obj_dropDown) == 3){
			dropDownInst.x += dropDownInst.windowWidth;	
		}
	}
	
	//dropDownInst.alarm[2] = 2;
	
	if (room == rm_mainScreen && instance_exists(obj_control)) {
		obj_control.ableToCreateDropDown = false;
		obj_control.alarm[0] = 2;
		obj_control.menuDepth--;
	}
	
}