function scr_summaryWindow() {

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());





	
	// File window
	var fileInfoWindowRectX1 = 40;
	var fileInfoWindowRectY1 = 80 + string_height("0");
	var fileInfoWindowRectX2 = (camWidth * 0.5) - 20;
	var fileInfoWindowRectY2 = (camHeight / 2) - 180;

	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(fileInfoWindowRectX1, fileInfoWindowRectY1, fileInfoWindowRectX2, fileInfoWindowRectY2, true);
	draw_set_color(global.colorThemeText);
	draw_set_font(global.fontMainBold);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(fileInfoWindowRectX1, fileInfoWindowRectY1 - string_height("0"), scr_get_translation("menu_summary"));
	
	
	
	// abbreviated surfaceStart()
	windowWidth = clamp(fileInfoWindowRectX2 - fileInfoWindowRectX1, 48, 2000);
	windowHeight = clamp(fileInfoWindowRectY2 - fileInfoWindowRectY1, 48, 1500);
	clipWidth = windowWidth;
	clipHeight = windowHeight;

	x = fileInfoWindowRectX1;
	y = fileInfoWindowRectY1;
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}
	scr_windowCameraAdjust();
	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);
	
	

	draw_set_font(global.fontMain);
	
	var stringHeight = string_height("0");
	var filename = filename_name(global.importFilename);
	var lineCount = ds_grid_height(global.importTXTLineGrid);
	var blockCount = ds_grid_height(global.blockGrid);
	var blockTypes = ds_grid_height(global.blockTypeGrid);
	var tokenCount = global.tokenCountTotal;
	var fieldCount = ds_grid_height(global.tagInfoGrid);
	
	if (global.importType == global.importType_CSV) {
		lineCount = ds_grid_height(global.importCSVGrid);
		global.tokenCountTotal = lineCount;
		tokenCount = global.tokenCountTotal;
	}
	else if (global.importType == global.importType_IGT) {
		fieldCount -= 2;
	}
	
	draw_text(fileInfoWindowRectX1 + 20 - clipX, fileInfoWindowRectY1 + stringHeight - clipY  + scrollPlusY, scr_get_translation("label_user_file_name") + string(filename));
	var actualIterations = 0;
	for (var i = 0; i < 5; i++) {
		
		var currentStr = "";
		if (i == 0) {
			if (tokenCount < 1) continue;
			currentStr = "Total token count: " + string(tokenCount);
		}
		else if (i == 1) {
			if (lineCount < 1) continue;
			currentStr = scr_get_translation("label_total_line") + string(lineCount);
		}
		else if (i == 2) {
			if (blockCount < 1) continue;
			currentStr = "Block count: " + string(blockCount);
		}
		else if (i == 3) {
			if (fieldCount < 1) continue;
			currentStr = scr_get_translation("label_markers_found") + string(fieldCount);
		}
		else if (i == 4) {
			if (blockTypes < 1) continue;
			currentStr = "Block types: " + string(blockTypes);
		}
		
		var textX = floor(fileInfoWindowRectX1 + 20);
		var textY = floor(fileInfoWindowRectY1 + (stringHeight * (actualIterations + 2)));
		
		draw_text(textX - clipX, textY - clipY  + scrollPlusY, currentStr);
		actualIterations++;
	}






	scr_scrollBar(actualIterations+2, -1, stringHeight , 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scrollPlusY = min(scrollPlusY, 0);

	scr_surfaceEnd();


}
