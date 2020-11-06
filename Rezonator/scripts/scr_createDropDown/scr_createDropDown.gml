// Create Dropdown Lists

function scr_createDropDown(dropDownX, dropDownY, dropDownOptionList, dropDownOptionListType){
	//var dropDownY = mouse_y;
	var dropDownHeight = ds_list_size(dropDownOptionList) * string_height("A")
	//show_message(string(obj_control.cameraBottomLine));
	if((dropDownY + (dropDownHeight * 4)) > obj_control.cameraBottomLine) {
		dropDownY -= dropDownHeight;	
	}
	var dropDownInst = instance_create_depth(dropDownX, dropDownY, -999, obj_dropDown);
	dropDownInst.optionList = dropDownOptionList;
	dropDownInst.optionListType = dropDownOptionListType;
					
	obj_control.ableToCreateDropDown = false;
	obj_control.alarm[0] = 2;
}