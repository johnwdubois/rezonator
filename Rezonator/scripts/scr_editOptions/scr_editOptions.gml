

function scr_editOptions(optionSelected){

	switch (optionSelected)
	{
		case "menu_go-to-line":
			
			scr_jumpToLineCalled();			

			break;
		case "menu_go-to-time":	
		
			scr_jumpToLineCalled();
			obj_control.goToTime = true;
			
			break;
			
		case "menu_delete-all":
		
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_track_chains_pl", "menu_rez_chains_pl", "menu_stacks_pl", "tab_name_chunk" ,  "menu_chains_pl");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypeDelete);
			}
		break;
		default:
			break;
	}
}