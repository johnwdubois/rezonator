var optionSelected = argument0;

switch (optionSelected)
{
	
	case "Add Tag Category":
		

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearAllLinks = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
			
		//show_message("Coming Soon");
		break;
	case "Developer":
		show_message("Coming Soon");
	break;
	case "Shuffle":
		show_message("Coming Soon");
	break;
	case "Delete All":
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Track Chains", "Rez Chains", "Stacks", "Chains");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing*2)  , -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 26;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	break;
	default:
		break;
}