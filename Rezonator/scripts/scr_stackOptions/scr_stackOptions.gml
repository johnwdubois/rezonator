function scr_stackOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Create Stacks":

			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Default", "Random", "Turn");
						
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
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 30;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
			break;
		case "StackShow":
		/*
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create", "Run");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 25;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		*/
	
				if(obj_control.currentStackShowListPosition == -1) {
					obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
					// Instantiate the screen for users to select which stacks go in the stackShow

					if (!instance_exists(obj_stackShow)) {
						instance_create_layer(x, y, "InstancesAudio", obj_stackShow);
					}
						obj_control.stackShowWindowActive = true;
				}
			break;
		default:
			break;
	}


}
