/// @description Insert description here
// You can write your code in this editor



draw_set_alpha(1);
draw_set_font(global.fontMainBold);
menuHeight = string_height("A") * 1.35;
menuWidth = string_width("Advanced");

// draw menu bar
draw_set_colour(global.colorThemeBG);
draw_rectangle(0, 0, camera_get_view_width(camera_get_active()), menuHeight, false);
draw_set_colour(global.colorThemeBorders);
draw_rectangle(-1, -1, camera_get_view_width(camera_get_active()) + 1, menuHeight, true);
	
// draw selection box and outline for file
/*if(mouseOverFile){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(-1, -1, menuWidth, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(-1, -1, menuWidth, menuHeight, true);
	
	
// draw selection box and outline for Edit
if(mouseOverEdit){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth, -1, menuWidth*2, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(menuWidth, -1, menuWidth*2, menuHeight, true);
	
	
// draw selection box and outline for View
if(mouseOverView){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*2, -1, menuWidth*3, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(menuWidth*2, -1, menuWidth*3, menuHeight, true);
		
// draw selection box and outline for Search
if(mouseOverSearch){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*3, -1, menuWidth*4.5, menuHeight, false);
}
// draw selection box and outline for Search
if(mouseOverOptions){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*4.5, -1, menuWidth*6, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(menuWidth*3, -1, menuWidth*4.5, menuHeight, true);
if(mouseOverStackShow){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*6, -1, menuWidth*8, menuHeight, false);
}	
if(mouseOverSortPane){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*8, -1, menuWidth*10, menuHeight, false);
}	*/
	
	
//draw text fore boxes
draw_set_colour(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);






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


for (var menuHeaderLoop = 0; menuHeaderLoop < menuBarGridHeight; menuHeaderLoop++) {
	
	var menuHeaderRectX1 = menuWidth * menuHeaderLoop;
	var menuHeaderRectY1 = 0;
	var menuHeaderRectX2 = menuWidth * (menuHeaderLoop + 1);
	var menuHeaderRectY2 = menuHeight;
	
	if (point_in_rectangle(mouse_x, mouse_y, menuHeaderRectX1, menuHeaderRectY1, menuHeaderRectX2, menuHeaderRectY2)) {
		
		// draw hover rectangle
		var roundedRectBuffer = 4;
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(1);
		draw_roundrect(menuHeaderRectX1 + roundedRectBuffer, menuHeaderRectY1 + roundedRectBuffer/2, menuHeaderRectX2 - roundedRectBuffer, menuHeaderRectY2 - roundedRectBuffer, false);
		
		obj_control.mouseoverPanelPane = true;		
		instance_destroy(obj_dropDown);
		
		if(mouse_check_button_released(mb_left) and menuClickedIn){
			menuClickedIn = false;
		}
		else if(mouse_check_button_released(mb_left) or menuClickedIn){
			menuClickedIn = true;
			
			ds_grid_set_region(menuBarGrid, menuBarGrid_colMouseOver, 0, menuBarGrid_colMouseOver, menuBarGridHeight, false);
			ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop, true);
			
			var dropDownOptionList = ds_grid_get(menuBarGrid, menuBarGrid_colOptionList, menuHeaderLoop);
			if (ds_list_size(dropDownOptionList) > 0) {
				/*var dropDownInst = instance_create_depth(menuWidth * menuHeaderLoop, menuHeight, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuHeaderLoop);
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;*/
				scr_createDropDown(menuWidth * menuHeaderLoop, menuHeight, dropDownOptionList, ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuHeaderLoop), true);
			}
		}
	}
	
	
	if (ds_grid_get(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop)) {
		draw_set_colour(global.colorThemeOutOfBounds);
		//draw_rectangle((menuWidth * menuHeaderLoop) - 1, -1, menuWidth * (menuHeaderLoop + 1), menuHeight, false);
		draw_rectangle(menuHeaderRectX1, menuHeaderRectY1, menuHeaderRectX2, menuHeaderRectY2, false);
		draw_set_colour(global.colorThemeText);
	}
	var headerString = ds_grid_get(menuBarGrid, menuBarGrid_colString, menuHeaderLoop);
	//draw_text(floor(mean(menuWidth * (menuHeaderLoop), menuWidth * (menuHeaderLoop + 1))), floor(mean(y, y + menuHeight)), headerString);
	draw_set_colour(global.colorThemeText);
	draw_text(floor(mean(menuHeaderRectX1, menuHeaderRectX2)), floor(mean(menuHeaderRectY1, menuHeaderRectY2)), scr_get_translation(headerString));
}

	
	
	
	
	
if (obj_control.showFPS) {
	var fpsTextX = camera_get_view_width(camera_get_active()) - string_width("000");
	var fpsTextY = menuHeight / 2;
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text(fpsTextX, fpsTextY, "FPS: " + string(fps));
}