// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_editOptions(optionSelected){

	switch (optionSelected)
	{
		case "Go to Line":
			
			scr_jumpToLineCalled();			

			break;
		case "Go to Time":	
		
			scr_jumpToLineCalled();
			obj_control.goToTime = true;
			
			break;
			
		case "Delete All":
		
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Track Chains", "Rez Chains", "Stacks", "Chains");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypeDelete);
			}
		break;
		default:
			break;
	}
}