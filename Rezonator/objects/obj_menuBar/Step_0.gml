/// @description Insert description here
// You can write your code in this editor
if(point_in_rectangle(mouse_x, mouse_y, 0, 0, camera_get_view_width(view_camera[0]), menuHeight)){
	obj_control.mouseoverPanelPane = true;
}

// File menu
if(point_in_rectangle(mouse_x, mouse_y, 0, 0, menuWidth, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = true;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;
		
		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Open File", "Import Audio", "Save File", "Export Portion", "Change Author",  "Exit");

		if (ds_list_size(dropDownOptionList) > 0) {
			var dropDownInst = instance_create_depth(0, menuHeight, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 4;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}
}

// Edit menu
else if(point_in_rectangle(mouse_x, mouse_y, menuWidth, 0, menuWidth*2, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = false;
		mouseOverEdit = true;
		mouseOverView = false;
		mouseOverSearch = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if( mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;
		
		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Clear All Stacks", "Clear All Rez Chains", "Clear All Track Chains", "Clear All Chains", "Toggle Filter Screen");

		if (ds_list_size(dropDownOptionList) > 0 ) {
			var dropDownInst = instance_create_depth(menuWidth, menuHeight, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 5;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}	
}

// View menu
else if(point_in_rectangle(mouse_x, mouse_y, menuWidth*2, 0, menuWidth*3, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = true;
		mouseOverSearch = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;

		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Increase Text Size", "Decrease Text Size", "Increase Column Size",  "Decrease Column Size","Increase Row Size", "Decrease Row Size", "Toggle Dark Theme", "Toggle Nav Window", "Start StackShow");

		if (ds_list_size(dropDownOptionList) > 0 ) {
			var dropDownInst = instance_create_depth(menuWidth*2, menuHeight, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 6;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}
}

// Search menu
else if(point_in_rectangle(mouse_x, mouse_y, menuWidth*3, 0, menuWidth*4.5, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = true;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;

		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Search For Words",  "Toggle Search Screen", "Clear Search Screen", "Jump To Time" , "Jump To Line");

		if (ds_list_size(dropDownOptionList) > 0 ) {
			var dropDownInst = instance_create_depth(menuWidth*3, menuHeight, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 7;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}
}


if(!menuClickedIn){
		mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
}
