// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_preImportFileTypeWindow(){
	
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	
	
	
	
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var strHeight = string_height("A");
	var radioButtonRad = strHeight * 0.5;
	
	///////////// FILE TYPE WINDOW ////////////////
	
	x = floor(camWidth * 0.1);
	y = floor(camHeight * 0.25);
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;
	var fileTypeWindowX1 = windowX;
	var fileTypeWindowY1 = windowY;
	var fileTypeWindowX2 = floor(camWidth * 0.488);
	var fileTypeWindowY2 = floor(camHeight * 0.8);
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, fileTypeWindowX1, fileTypeWindowY1, fileTypeWindowX2, fileTypeWindowY2);
	
	// draw window border
	//var rezonatorPink = make_color_rgb(193, 30, 93);
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	
	draw_roundrect(fileTypeWindowX1, fileTypeWindowY1, fileTypeWindowX2, fileTypeWindowY2, false);
	
	
	// clipping stuff
	
	windowWidth = max(fileTypeWindowX2 - fileTypeWindowX1, 48);
	windowHeight = max(fileTypeWindowY2 - fileTypeWindowY1, 48);
	clipWidth = windowWidth;
	clipHeight = windowHeight;
	/*

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}

	scr_windowCameraAdjust();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);
	*/
	
	
	

	
	var colWidthRatioList = ds_list_create();
	ds_list_add(colWidthRatioList, 3, 32, 20, 7, 15, 12, 6);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	
	var preImportInfoGrid = obj_openingScreen.preImportInfoGrid;
	var preImportInfoGridWidth = ds_grid_width(preImportInfoGrid);
	var preImportInfoGridHeight = ds_grid_height(preImportInfoGrid);
	var strHeight = string_height("A") * 1.1;
	var tableX1 = fileTypeWindowX1 + (windowWidth * 0.05);
	var tableY1 = fileTypeWindowY1 + strHeight;
	var tableX2 = fileTypeWindowX2;
	var tableWidth = tableX2 - tableX1;
	var mouseOverAnyCell = false;
	for (var i = 0; i < preImportInfoGridHeight; i++) {
		
		var plusX = 0;
		var currentImportType = ds_grid_get(preImportInfoGrid, obj_openingScreen.preImportInfoGrid_colDataType, i);
		var currentImportTypeSelected = (global.importType == currentImportType);
		
		for (var j = 0; j < preImportInfoGridWidth; j++) {
			
			// draw header for each column
			var headerText = "";
			if (j == 1) headerText = "Data type";
			else if (j == 2) headerText = "Per line";
			else if (j == 3) headerText = "Tab";
			else if (j == 4) headerText = "Whitespace";
			else if (j == 5) headerText = "Hyphen";
			else if (j == 6) headerText = "File";
			var headerStrWidth = string_width(headerText);
			if (i == 0) {
				var headerX = floor(tableX1 + plusX);
				var headerY = floor(tableY1);
				draw_set_color(global.colorThemeBG);
				draw_rectangle(headerX, headerY - (strHeight / 2), headerX + headerStrWidth, headerY + (strHeight / 2), false);
				draw_set_color(global.colorThemeText);
				draw_set_alpha(1);
				draw_text(headerX, headerY, headerText);
			}
			
			// text position & string
			var drawCheckmark = false;
			var drawRadioButton = (j == obj_openingScreen.preImportInfoGrid_colChoose);
			var textX = floor(tableX1 + plusX);
			var textY = floor(tableY1 + (strHeight * (i + 1)));
			var text = string(ds_grid_get(preImportInfoGrid, j, i));
			if (text == "0") {
				text = "";
			}
			else if (text == "1" && j != obj_openingScreen.preImportInfoGrid_colChoose) {
				drawCheckmark = true;
			}
			var colWidth = tableWidth * (ds_list_find_value(colWidthRatioList, j) / 100);
			plusX += colWidth;
			
			// mouse interaction
			var cellRectX1 = textX;
			var cellRectY1 = textY - (strHeight / 2);
			var cellRectX2 = textX + colWidth;
			var cellRectY2 = textY + (strHeight / 2);
			if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
				importTypeMouseover = i;
				mouseOverAnyCell = true;
			}
			
			// draw rect, text, radio buttons, & checkmarks
			draw_set_color(global.colorThemeBG);
			draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
			if (importTypeMouseover == i || currentImportTypeSelected) {
				draw_set_color(global.colorThemeSelected1);
				draw_set_alpha(0.5);
				draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
				draw_set_alpha(1);
				// mouse click
				if (mouse_check_button_released(mb_left)) {
					global.importType = currentImportType;
				}
			}
			if (drawRadioButton) {
				draw_set_color(global.colorThemeBorders);
				draw_circle(mean(cellRectX1, cellRectX2), mean(cellRectY1, cellRectY2), (cellRectX2 - cellRectX1) / 2.8, true);
				if (currentImportTypeSelected) {
					draw_circle(mean(cellRectX1, cellRectX2), mean(cellRectY1, cellRectY2), (cellRectX2 - cellRectX1) / 3.2, false);
				}
			}
			else if (drawCheckmark) {
				draw_sprite_ext(spr_checkmark, 0, mean(cellRectX1, cellRectX1 + headerStrWidth), mean(cellRectY1, cellRectY2), 1, 1, 0, c_white, 1);
			}
			else {
				draw_set_color(global.colorThemeText);
				draw_set_alpha(1);
				draw_text(textX, textY, text);
			}
		}
		
		// set choose column value
		ds_grid_set(preImportInfoGrid, obj_openingScreen.preImportInfoGrid_colChoose, i, currentImportTypeSelected);
	}
	ds_list_destroy(colWidthRatioList);
	
	// header line divider
	draw_set_color(global.colorThemeBorders);
	draw_line(tableX1, tableY1 + (strHeight / 2), fileTypeWindowX2 - (windowWidth * 0.05), tableY1 + (strHeight / 2));
	
	// don't draw mouseover effect if mouse isn't on any cell
	if (!mouseOverAnyCell) {
		importTypeMouseover = -1;
	}
	
	// set currentPreImportMap
	currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType);
	
	
	
	draw_set_valign(fa_top);
	

	
	//scr_surfaceEnd();
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(fileTypeWindowX1, floor(fileTypeWindowY1 - (strHeight)), "Choose a file type to import");
	


	
}