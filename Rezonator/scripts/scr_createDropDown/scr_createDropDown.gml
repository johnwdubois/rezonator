// Create Dropdown Lists

function scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, dropDownOptionListType){

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
	
	if (room == rm_mainScreen && instance_exists(obj_control)) {
		obj_control.ableToCreateDropDown = false;
		obj_control.alarm[0] = 2;
		obj_control.menuDepth--;
	}
	
}