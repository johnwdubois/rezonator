

function scr_preImportFileTypeWindow() {

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	
	var mouseoverCancel = instance_exists(obj_dialogueBox) || instance_exists(obj_dropDown);
	
		
	var backgroundWindowX1 = floor(camWidth * 0.04);
	var backgroundWindowX2 = floor(camWidth * 0.96);
	var backgroundWidth = backgroundWindowX2 - backgroundWindowX1;
	

	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var strHeight = string_height("0");
	var radioButtonRad = strHeight * 0.5;
	
	///////////// FILE TYPE WINDOW ////////////////
	
	x = floor(camWidth * 0.04);
	y = floor(camHeight * 0.15);
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;
	var fileTypeWindowX1 = windowX;
	var fileTypeWindowY1 = windowY;
	var fileTypeWindowX2 = floor(backgroundWidth * 0.33);
	var fileTypeWindowY2 = floor(camHeight * 0.8);
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, fileTypeWindowX1, fileTypeWindowY1, fileTypeWindowX2, fileTypeWindowY2) && !mouseoverCancel;
	
	//draw window border
	var rezonatorPink = make_color_rgb(193, 30, 93);
	
	//draw_set_color(global.colorThemeBG);
	//draw_set_alpha(1);
	//draw_roundrect(fileTypeWindowX1, fileTypeWindowY1, fileTypeWindowX2, fileTypeWindowY2, false);
	
	
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
	
	

	
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	
	var preImportInfoGrid = global.preImportInfoGrid;
	var preImportInfoGridWidth = ds_grid_width(preImportInfoGrid);
	var preImportInfoGridHeight = ds_grid_height(preImportInfoGrid);
	var strHeight = string_height("A") * 1.1;
	var tableX1 = fileTypeWindowX1 ;
	var tableY1 = fileTypeWindowY1;
	var tableX2 = fileTypeWindowX2 - (windowWidth * 0.05)
	var tableWidth = tableX2 - tableX1;
	var mouseOverAnyCell = false;
	var textBuffer = (windowWidth * 0.05);
	var heightOfBox = windowHeight/preImportInfoGridHeight;
	var plusY = 0;
	
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(tableX1,tableY1,tableX2,tableY1+windowHeight, false);
	
	
	for (var i = 0; i < preImportInfoGridHeight; i++) {
		
		var boxY1 = tableY1 + plusY;
		var boxY2 = boxY1 + heightOfBox;
		
		var mouseOverOption = point_in_rectangle(mouse_x,mouse_y, tableX1,boxY1,tableX2,boxY2) && !mouseoverCancel;
		
		
		if (ds_grid_get(preImportInfoGrid, global.preImportInfoGrid_colChoose, i) == false) {
			draw_set_color(global.colorThemeSelected1);
			if (mouseOverOption) {
				draw_set_color(merge_color(global.colorThemeSelected1, c_white, .4));
				draw_rectangle(tableX1,boxY1,tableX2,boxY2, false);
			}
		}
		else{

			draw_set_color(global.colorThemeBG);
			draw_rectangle(tableX1,boxY1,tableX2,boxY2, false);
		}

		

		

		
		var plusX = 0;
		var currentImportType = ds_grid_get(preImportInfoGrid, global.preImportInfoGrid_colDataType, i);
		var currentImportTypeSelected = (global.importType == currentImportType);
		
		
		if (mouseOverOption) {
			if (device_mouse_check_button(0,mb_left)) {
				global.importType = currentImportType;
			}
		}
		if (currentImportTypeSelected) {
			draw_set_color(rezonatorPink);
			draw_line_width(tableX1, boxY1, tableX1, boxY2, 4);
		}
		
		draw_set_color(global.colorThemeBG)
		draw_line_width(tableX1,boxY1,tableX2,boxY1, 2);
		draw_line_width(tableX1,boxY2,tableX2,boxY2, 2);
		
		draw_set_color(global.colorThemeText);
		
		// cut off section text if its too long
		var cutoffs = 0;
		var tabName = string(scr_get_translation(currentImportType));
		var strwidth = string_width(tabName + "...   ");
		while (string_width(tabName + "...   ")  > tableWidth and cutoffs < 100) {
		
			tabName = string_delete(tabName, string_length(tabName), 1);
			cutoffs++;
		}
		if (cutoffs > 0) {
			tabName += "... ";
		}
		
		draw_text(tableX1 +textBuffer,floor(mean(boxY1,boxY2)),  tabName);
		plusY += heightOfBox;
		// set choose column value
		ds_grid_set(preImportInfoGrid, global.preImportInfoGrid_colChoose, i, currentImportTypeSelected);
	}
	

	// don't draw mouseover effect if mouse isn't on any cell
	if (!mouseOverAnyCell) {
		importTypeMouseover = -1;
	}
	
	// set currentPreImportMap
	global.currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType);
	
	
	
	draw_set_valign(fa_top);
	


	// draw window title
	draw_set_halign(fa_left);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	
	
	
	scr_adaptFont( scr_get_translation("msg_choose-data-type"), "L");
	
	draw_text(fileTypeWindowX1, floor(obj_menuBar.menuHeight + strHeight), scr_get_translation("msg_choose-data-type"));
	
	
	draw_set_color(rezonatorPink)
	draw_line_width(backgroundWindowX1,y,backgroundWindowX2,y, 1)

}