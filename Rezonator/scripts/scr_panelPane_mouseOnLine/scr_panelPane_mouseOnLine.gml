function scr_panelPane_mouseOnLine(argument0, argument1, argument2, argument3, argument4, argument5, argument6) {
	var lineNameRectX1 = argument0;
	var lineNameRectY1 = argument1;
	var lineNameRectX2 = argument2;
	var lineNameRectY2 = argument3;
	var lineGridHeight = argument4;
	var i = argument5;
	var lineColor = argument6;


	if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, lineNameRectX1, lineNameRectY1, lineNameRectX2, lineNameRectY2)) {
		//if (obj_control.showDevVars) {
			//draw_set_color(c_red);
			//draw_circle(mouse_x, mouse_y, 5, true);
		//}
		
		if (device_mouse_check_button_released(0, mb_left) and not instance_exists(obj_dialogueBox) and not instance_exists(obj_dropDown)) {
			//show_message("line");
			ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, lineGridHeight, 0);
			ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, i, 1);
			with (obj_panelPane) {
				if(functionChainList_lineGridRowFocused != i) {
					functionChainList_lineGridRowFocused = i;
					functionChainContents_BGColor = lineColor;
					functionChainContents_lineGridRowFocused = -1;
				}
			}
			if (doubleClickTimer > -1) {
				
					if (i >= 0 and i < ds_grid_height(obj_control.currentActiveLineGrid)) {
						var linePixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelYOriginal, i);
						obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(camera_get_active()) / 2) - 100;
					}
				}
				else {		
					doubleClickTimer = 0;
				}
		
		}
	}


}
