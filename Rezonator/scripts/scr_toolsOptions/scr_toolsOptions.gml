//toolsOptions
var optionSelected = argument0;

switch (optionSelected)
{
	case "Sort":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Standard", "Columns");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 24;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	case "StackShow":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Create", "Run", "Tag");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 25;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	case "Play":
		show_message("Coming Soon");
		instance_destroy(obj_dropDown);
	break;
	case "Rez-Play":
		show_message("Coming Soon");
		instance_destroy(obj_dropDown);
	break;
	default:
	break;
}