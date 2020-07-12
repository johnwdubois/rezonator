var optionSelected = argument0;

switch (optionSelected)
{
	case "Create Stacks":

		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Default", "Random");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 29;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
		break;
				
	case "Show Stack":
		
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Default", "Random");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 30;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
		break;
	case "StackShow":

		
		show_message("Coming Soon");
		break;
	default:
		break;
}