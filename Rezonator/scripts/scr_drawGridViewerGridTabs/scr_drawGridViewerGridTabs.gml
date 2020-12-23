function scr_drawGridViewerGridTabs() {
	/*
		scr_drawGridViewerGridTabs(gridArrayIndex);
	
		Last Updated: 2018-09-11
	
		Called from: obj_gridViewer
	
		Purpose: draw the tabs showing all of the viewable grids for the gridViewer
	
		Mechanism: loop through a list of the viewable grids and draw tabs for each grid,
					and when the tab is clicked on, that is the grid to be shown
	
		Author: Terry DuBois
	*/

	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	var rectWidth = windowWidth / ds_list_size(gridList);
	var rectHeight = 20;
	var currentGridName = "";

	var gridListSize = ds_list_size(gridList);
	for (var i = 0; i < gridListSize; i++) {
		var currentGrid = ds_list_find_value(gridList, i);
	
		var colName = scr_getGridNameString(currentGrid);
	
		var rectX1 = windowX + (i * rectWidth);
		var rectY1 = windowY - rectHeight;
		var rectX2 = rectX1 + rectWidth;
		var rectY2 = windowY;
	
		if (grid == currentGrid) {
			draw_set_color(obj_control.c_ltblue);
			currentGridName = colName;
		}
		else {
			draw_set_color(global.colorThemeBG);
		}
	
		draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
	
		draw_set_color(global.colorThemeText);
		draw_rectangle(rectX1, rectY1, rectX2, rectY2, true);
	
	
		scr_adaptFont(colName, "S");
		draw_text(rectX1 + 5, mean(rectY1, rectY2), colName);
	
		if (point_in_rectangle(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2)) {
			if (device_mouse_check_button_released(0, mb_left)) {
				grid = currentGrid;
			}
		}
	}
	return currentGridName;


}
