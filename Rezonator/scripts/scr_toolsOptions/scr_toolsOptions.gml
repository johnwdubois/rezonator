function scr_toolsOptions(argument0) {
	//toolsOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Search":
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Keyword", "Clear");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 7;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		break;
		case "Stack":
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "StackShow", "Stacker");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 28;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		break;
		default:
		break;
	}


}
