function scr_gridListWindow() {
	
	//if (live_call()) return live_result;
	
	// this window should only exist if hideAll is true and exportWindowGridList exists
	if (!obj_control.gridView) {
		exit;
	}



	// GridList Window
	var gridListInfoWindowRectX1 = x;
	var gridListInfoWindowRectY1 = obj_gridViewer.windowY1;
	var gridListInfoWindowRectX2 = obj_gridViewer.windowX1-20;
	var gridListInfoWindowRectY2 = obj_gridViewer.windowY2;
	var buttonSize = string_height("0")*2;

	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(gridListInfoWindowRectX1, gridListInfoWindowRectY1, gridListInfoWindowRectX2, gridListInfoWindowRectY2, true);
	draw_set_color(global.colorThemeText);

	draw_set_halign(fa_left);

	draw_set_valign(fa_middle);
	var currentgridListString = scr_getGridNameString(currentGrid);
	scr_adaptFont(string(currentgridListString), "L");
	draw_text(gridListInfoWindowRectX1, gridListInfoWindowRectY1 - string_height("0"), "Current Grid: " + string(currentgridListString));




	// abbreviated surfaceStart()
	
	if (mouse_check_button(mb_left)) {
		if (obj_gridViewer.windowResizeYHolding) {
			window_set_cursor(cr_size_ns);
			windowHeight = clamp(mouse_y - y, 150, camera_get_view_height(camera_get_active()) * 0.75);
		}
	
		if (obj_gridViewer.windowResizeYHolding) {
			if (surface_exists(clipSurface)) {
				surface_resize(clipSurface, clipWidth, clipHeight);
			}
		}
	}

	if (windowResizeXHolding or windowResizeYHolding) {
		obj_control.mouseoverPanelPane = true;
	}
	
	
	windowWidth = clamp(gridListInfoWindowRectX2 - gridListInfoWindowRectX1, 48, 2000);
	windowHeight = clamp(gridListInfoWindowRectY2 - gridListInfoWindowRectY1, 48, 4000);
	clipWidth = windowWidth;
	clipHeight = windowHeight;

	x = gridListInfoWindowRectX1;
	y = gridListInfoWindowRectY1;
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;

	//draw_text(800,1000, "gridListInfoWindowRectY2: " + string(gridListInfoWindowRectY2) + ",   windowHeight: " + string(windowHeight));
	//draw_text(800,950, "clipHeight: " + string(clipHeight) + ",  clipWidth: " + string(clipWidth) );
	//draw_text(800,900, "clipX: " + string(clipX) + ",  clipY: " + string(clipY) );



	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}

	scr_windowCameraAdjust();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);




	var mouseOverGrid = -1;

	// draw all exception lines
	var plusY = buttonSize;

	var gridListtringListSize = ds_list_size(obj_gridViewer.gridList);
	for (var i = 0; i < gridListtringListSize; i++) {
		
		var currentGridListValue = ds_list_find_value(obj_gridViewer.gridList, i);
		var currentgridListString = scr_getGridNameString(currentGridListValue);
		
		var currentCellX1 = gridListInfoWindowRectX1;
		var currentCellX2 = gridListInfoWindowRectX2;
		var currentCellY1 = floor(gridListInfoWindowRectY1 + (plusY * i));
		var currentCellY2 = floor(gridListInfoWindowRectY1 + (plusY * (i + 1)));
		
		

		if(point_in_rectangle(mouse_x,mouse_y, currentCellX1, currentCellY1 + scrollPlusY ,currentCellX2, currentCellY2 + scrollPlusY)){
			mouseOverGrid = i;
		}
		
		
		
		if( mouseOverGrid == i ){
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(.5);
			draw_rectangle(currentCellX1 - clipX, currentCellY1 - clipY + scrollPlusY ,currentCellX2 - clipX, currentCellY2 - clipY + scrollPlusY, false );
			
			if(mouse_check_button_released(mb_left)){
				currentGrid = currentGridListValue;
				obj_gridViewer.grid = currentGrid;
			}
		}
		
		
		if(currentGrid  == currentGridListValue){
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(.5);
			draw_rectangle(currentCellX1 - clipX, currentCellY1 - clipY + scrollPlusY ,currentCellX2 - clipX, currentCellY2 - clipY + scrollPlusY, false );
		}
		
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_line(currentCellX1 - clipX , currentCellY2 + scrollPlusY - clipY , currentCellX2 - clipX, currentCellY2 - clipY + scrollPlusY);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(string(currentgridListString), "M");
		draw_text(floor(currentCellX1 + global.scrollBarWidth + 10) - clipX, floor(mean(currentCellY1,currentCellY2)) - clipY + scrollPlusY, string(currentgridListString));
	

	}



	scr_scrollBar(ds_list_size(obj_gridViewer.gridList), -1, buttonSize, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, global.scrollBarWidth, windowHeight);
	
	scrollPlusY = min(scrollPlusY, 0);

	scr_surfaceEnd();
	
	if(point_in_rectangle(mouse_x,mouse_y, gridListInfoWindowRectX1, gridListInfoWindowRectY1 ,gridListInfoWindowRectX2, gridListInfoWindowRectY2)){

		
		if (not obj_control.mouseoverHelpPane and !instance_exists(obj_dropDown)) {
			// mousewheel input
			if (mouse_wheel_up()) {
				scrollPlusYDest += 40;
			}
			if (mouse_wheel_down()) {
				scrollPlusYDest -= 40;
			}

			// keyboard input for UP and DOWN
			if (keyboard_check(vk_up)) {
				scrollPlusYDest += 20;
			}
			if (keyboard_check(vk_down)) {
				scrollPlusYDest -= 20;
			}

			// CTRL+UP and CTRL+DOWN
			if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
				scrollPlusYDest = 100;
			}
			if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
				scrollPlusYDest = -999999999999;
			}
	
			// PAGEUP and PAGEDOWN
			if (keyboard_check_pressed(vk_pageup)) {
				scrollPlusYDest += (windowHeight);
			}
			if (keyboard_check_pressed(vk_pagedown)) {
				scrollPlusYDest -= (windowHeight);
			}
		}
					
	}


}