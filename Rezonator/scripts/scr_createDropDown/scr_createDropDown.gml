// Create Dropdown Lists

function scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, dropDownOptionListType, translateDropDown){
	//var dropDownY = mouse_y;
	draw_set_font(global.fontMain);
	var dropDownHeight = ds_list_size(dropDownOptionList) * string_height("A") * 1.25;
	//show_message(string(obj_control.cameraBottomLine));
	var camViewHeight = camera_get_view_height(view_get_camera(0));
	if((dropDownY + (dropDownHeight)) > camViewHeight) {
		var adjustedHeight = ds_list_size(dropDownOptionList) * string_height("A") * 1.25;
		dropDownY -= adjustedHeight;	
	}
	dropDownY = clamp(dropDownY, 0, camViewHeight);
	
	var dropDownInst = instance_create_depth(dropDownX, dropDownY, -999, obj_dropDown);
	dropDownInst.optionList = dropDownOptionList;
	dropDownInst.optionListType = dropDownOptionListType;
	if(argument_count > 4){
		dropDownInst.translateDropDown = translateDropDown;
	}
	else{
		dropDownInst.translateDropDown = false;
	}
					
	obj_control.ableToCreateDropDown = false;
	obj_control.alarm[0] = 2;
}