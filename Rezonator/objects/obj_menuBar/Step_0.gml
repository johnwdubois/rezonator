/// @description Insert description here
// You can write your code in this editor
if(point_in_rectangle(mouse_x, mouse_y, 0, 0, camera_get_view_width(camera_get_active()), menuHeight)){
	obj_control.mouseoverPanelPane = true;
	if(!chainDeselected){
		with(obj_chain) {
			scr_chainDeselect();
			scr_refreshVizLinkGrid();	
			chainDeselected = true;
		}
	}
	else{
		chainDeselected = false;
	}
	
}
else{

}

/*
for (var menuSelectionLoop = 0; menuSelectionLoop < menuBarGridHeight; menuSelectionLoop++){
	
	if(point_in_rectangle(mouse_x, mouse_y, menuWidth * menuSelectionLoop, 0, menuWidth * (menuSelectionLoop + 1), menuHeight)){
		obj_control.mouseoverPanelPane = true;		
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