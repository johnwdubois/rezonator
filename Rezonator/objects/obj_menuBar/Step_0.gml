/// @description Insert description here
// You can write your code in this editor
if(point_in_rectangle(mouse_x, mouse_y, 0, 0, camera_get_view_width(view_camera[0]), menuHeight)){
	obj_control.mouseoverPanelPane = true;
	with(obj_chain) {
		scr_chainDeselect();
		scr_refreshVizLinkGrid();		
	}
	
}

for (var menuSelectionLoop = 0; menuSelectionLoop < menuBarGridHeight; menuSelectionLoop++){
	
	if(point_in_rectangle(mouse_x, mouse_y, menuWidth * menuSelectionLoop, 0, menuWidth * (menuSelectionLoop + 1), menuHeight)){
		obj_control.mouseoverPanelPane = true;
		with(obj_chain) {
			scr_chainDeselect();
			scr_refreshVizLinkGrid();		
		}
		instance_destroy(obj_dropDown);
		ds_grid_set_region(menuBarGrid, menuBarGrid_colMouseOver, 0, menuBarGrid_colMouseOver, menuBarGridHeight, false);
		ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuSelectionLoop, true);
		if(mouse_check_button_released(mb_left) and menuClickedIn){
			menuClickedIn = false;
		}
		else if(mouse_check_button_released(mb_left) or menuClickedIn){
			menuClickedIn = true;
			
			var dropDownOptionList = ds_grid_get(menuBarGrid, menuBarGrid_colOptionList, menuSelectionLoop);
			//show_message(scr_getStringOfList(dropDownOptionList));
			//show_message(menuSelectionLoop);
			//show_message(scr_getStringOfList(ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuSelectionLoop)));
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(menuWidth * menuSelectionLoop, menuHeight, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuSelectionLoop);
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		}
	}
}

// File menu
/*if(point_in_rectangle(mouse_x, mouse_y, 0, 0, menuWidth, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = true;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
		mouseOverOptions = false;
		mouseOverStackShow = false;
		mouseOverSortPane = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;
		
		var dropDownOptionList = ds_list_create();

		// gotta start here
		//ds_list_add(dropDownOptionList, "Import Audio", "Save Rez File", "Export CSV", "Export Clip", "Change Author",  "Exit");
		ds_list_add(dropDownOptionList, "Open", "Save", "Import", "Export", "Clip", "Media",  "Exit");
		
		
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
		mouseOverOptions = false;
		mouseOverStackShow = false;
		mouseOverSortPane = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if( mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;
		
		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Delete All Stacks", "Delete All Rez Chains", "Delete All Track Chains", "Delete All Chains");

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
		mouseOverOptions = false;
		mouseOverStackShow = false;
		mouseOverSortPane = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;

		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Toggle Dark Theme", "Toggle Grid View",  "Toggle Nav Window", "Toggle Filter Screen",  "Toggle Search Screen", "Toggle Transcript View");

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
		mouseOverOptions = false;
		mouseOverStackShow = false;
		mouseOverSortPane = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;

		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList, "Search For Words", "Clear Search Screen", "Go To Time" , "Go To Line");

		if (ds_list_size(dropDownOptionList) > 0 ) {
			var dropDownInst = instance_create_depth(menuWidth*3, menuHeight, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 7;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}
}
// Options menu
else if(point_in_rectangle(mouse_x, mouse_y, menuWidth*4.5, 0, menuWidth*6, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
		mouseOverOptions = true;
		mouseOverStackShow = false;
		mouseOverSortPane = false;
	if(mouse_check_button_released(mb_left) and menuClickedIn){
		menuClickedIn = false;
	}
	else if(mouse_check_button_released(mb_left) or menuClickedIn){
		menuClickedIn = true;

		var dropDownOptionList = ds_list_create();

		ds_list_add(dropDownOptionList,"Increase Text Size", "Decrease Text Size", "Increase Column Width",  "Decrease Column Width","Increase Row Height", "Decrease Row Height","Increase All", "Decrease All");

		if (ds_list_size(dropDownOptionList) > 0 ) {
			var dropDownInst = instance_create_depth(menuWidth*4.5, menuHeight, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 6;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}
}
// Stack Show menu
else if(point_in_rectangle(mouse_x, mouse_y, menuWidth*6, 0, menuWidth*8, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
		mouseOverOptions = false;
		mouseOverStackShow = true;
		mouseOverSortPane = false;
	 if(mouse_check_button_released(mb_left)){
		if(!menuClickedIn){
			menuClickedIn = true;
		}
		else{
			mouseOverStackShow = false;
			menuClickedIn = false;
		}
			if(obj_control.currentStackShowListPosition == -1) {
				obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
				// Instantiate the screen for users to select which stacks go in the stackShow

				if (!instance_exists(obj_stackShow)) {
					instance_create_layer(x, y, "InstancesAudio", obj_stackShow);
				}
					obj_control.stackShowWindowActive = true;
			}
	}
}


// Sort Pane menu
else if(point_in_rectangle(mouse_x, mouse_y, menuWidth*8, 0, menuWidth*10, menuHeight)){
		instance_destroy(obj_dropDown);
		mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
		mouseOverOptions = false;
		mouseOverStackShow = false;
		mouseOverSortPane = true;
	 if(mouse_check_button_released(mb_left)){
		if(!menuClickedIn){
			menuClickedIn = true;
		}
		else{
			mouseOverStackShow = false;
			menuClickedIn = false;
		}
			
			sortPane = instance_create_layer(x, y, "InstancesAudio", obj_panelPane);
			sortPane.windowWidth = 200;
			sortPane.windowHeight = 212;

			sortPane.currentFunction = 3;
			sortPane.scrollRange = 9;
			

			sortPaneOpen = true;
			//obj_panelPane.currentFunction = obj_panelPane.functionSort;
				
			
	}
}


if(sortClosing == true){
	if(instance_exists(sortPane)){
		with (sortPane) {
			instance_destroy();			
		}
		sortClosing = false;
	}
}


		*/	


if(!menuClickedIn || !obj_control.mouseoverPanelPane){
	
		/*mouseOverFile = false;
		mouseOverEdit = false;
		mouseOverView = false;
		mouseOverSearch = false;
		mouseOverOptions = false;
		mouseOverStackShow = false;
		mouseOverSortPane = false;*/
		ds_grid_set_region(menuBarGrid, menuBarGrid_colMouseOver, 0, menuBarGrid_colMouseOver, menuBarGridHeight, false);
}

with(obj_panelPane){
	if(currentFunction == functionChainList || currentFunction == functionChainContents || currentFunction == functionFilter || currentFunction == functionSort){
	y =  obj_menuBar.y + obj_menuBar.menuHeight;
	}
}
with(obj_toolPane){
	y =  obj_menuBar.y + obj_menuBar.menuHeight;
}