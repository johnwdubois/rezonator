// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_preImportScreen(){
	
	scr_fontSizeControlOpeningScreen();


	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	
	// draw negative space BG
	draw_set_alpha(1);
	draw_set_color(global.colorThemeNegSpace);
	draw_rectangle(0, 0, camWidth, camHeight, false);
	
	scr_drawBackArrow();
	
	
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var strHeight = string_height("A");
	var textBufferLeft = strHeight / 2;
	var textBufferTop = strHeight / 2;
	var infoAlpha = 0.5;
	
	// get the currentPreImportMap from obj_preImportFileType
	if (!instance_exists(obj_preImportFileType)) {
		exit;
	}
	var currentPreImportMap = obj_preImportFileType.currentPreImportMap;
	
	
	
	
	
	
	
	
	///////////// EXAMPLE WINDOW ////////////////
	
	var exampleWindowX1 = floor(camWidth * 0.44);
	var exampleWindowY1 = floor(camHeight * 0.45);
	var exampleWindowX2 = floor(camWidth * 0.9);
	var exampleWindowY2 = floor(camHeight * 0.8);
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(exampleWindowX1, floor(exampleWindowY1 - (strHeight)), "Example");
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(exampleWindowX1, exampleWindowY1, exampleWindowX2, exampleWindowY2, false);
	
	// draw example content
	var exampleWindowList = ds_map_find_value(currentPreImportMap, "example");
	var exampleWindowListSize = ds_list_size(exampleWindowList);
	draw_set_font(global.fontMain);
	var currentTextX = floor(exampleWindowX1 + textBufferLeft);
	for (var i = 0; i < exampleWindowListSize; i++) {
		
		if (global.importType == global.importType_PlainText || global.importType == global.importType_IGT ||
			global.importType == global.importType_CoNLLU) {
			var currentText = ds_list_find_value(exampleWindowList, i);
			var currentTextX = floor(exampleWindowX1 + textBufferLeft);
			var currentTextY = floor(exampleWindowY1 + textBufferTop + (strHeight * i));
			if (currentTextY < exampleWindowY2 - (strHeight / 1.5)) {
				draw_set_color(global.colorThemeText);
				draw_set_alpha(infoAlpha);
				draw_text(currentTextX, currentTextY, currentText);
			}
		}
		else if (global.importType == global.importType_TabDelimited || global.importType == global.importType_CSV) {
			
			// draw column coverup rectangle
			var colCoverUpRectX1 = currentTextX;
			var colCoverUpRectY1 = exampleWindowY1 + 10;
			var colCoverUpRectX2 = exampleWindowX2 - 10;
			var colCoverUpRectY2 = exampleWindowY2 - 10;
			draw_set_color(global.colorThemeBG);
			draw_set_alpha(1);
			draw_rectangle(colCoverUpRectX1, colCoverUpRectY1, colCoverUpRectX2, colCoverUpRectY2, false);
			
			// get column width list
			var colWidthList = -1;
			if (global.importType == global.importType_TabDelimited) colWidthList = ds_map_find_value(global.preImportMap, "tabDelimWidthList");
			else if (global.importType == global.importType_CSV) colWidthList = ds_map_find_value(global.preImportMap, "csvWidthList");
			
			var currentList = ds_list_find_value(exampleWindowList, i);
			if (typeof(currentList) == "number" && ds_exists(colWidthList, ds_type_list)) {
				
				if (exampleWindowListSize == ds_list_size(colWidthList)) {
			
					// draw example text columns
					var currentListSize = ds_list_size(currentList);
					for (var j = 0; j < currentListSize; j++) {
					
						var currentColWidthRatio = ds_list_find_value(colWidthList, i);
						var currentColWidth = floor((exampleWindowX2 - exampleWindowX1) * (0.01 * currentColWidthRatio));
					
						var currentText = ds_list_find_value(currentList, j);
						var currentTextY = floor(exampleWindowY1 + textBufferTop + (strHeight * j));
						if (currentTextY < exampleWindowY2 - (strHeight / 1.5)) {
							draw_set_color(global.colorThemeText);
							draw_set_alpha(infoAlpha);
							draw_text(currentTextX, currentTextY, currentText);
						}
					}
					currentTextX += floor(currentColWidth);
				}
			}
		}
	}
	
	
	
	
	///////////// DESCRIPTION WINDOW ////////////////
	
	var descriptionWindowX1 = floor(camWidth * 0.44);
	var descriptionWindowY1 = floor(camHeight * 0.25);
	var descriptionWindowX2 = floor(camWidth * 0.9);
	var descriptionWindowY2 = floor(camHeight * 0.40);
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(descriptionWindowX1, floor(descriptionWindowY1 - (strHeight)), "Description");
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(descriptionWindowX1, descriptionWindowY1, descriptionWindowX2, descriptionWindowY2, false);
	
	// draw description content
	var descriptionWindowList = ds_map_find_value(currentPreImportMap, "description");
	var descriptionWindowListSize = ds_list_size(descriptionWindowList);
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(infoAlpha);
	for (var i = 0; i < descriptionWindowListSize; i++) {
		var currentText = ds_list_find_value(descriptionWindowList, i);
		var currentTextX = floor(descriptionWindowX1 + textBufferLeft);
		var currentTextY = floor(descriptionWindowY1 + textBufferTop + (strHeight * i));
		if (currentTextY < descriptionWindowY2 - (strHeight / 1.5)) {
			draw_text(currentTextX, currentTextY, currentText);
		}
	}
	
	
	
	
	
	
/*	
	///////////// LINKS WINDOW ////////////////
	var fileTypeWindowWidth = (floor(camWidth * 0.41) - floor(camWidth * 0.1))
	var linksWindowX1 = floor(exampleWindowX2 - fileTypeWindowWidth);
	var linksWindowY1 = floor(descriptionWindowY1);
	var linksWindowX2 = floor(exampleWindowX2);
	var linksWindowY2 = floor(descriptionWindowY2);
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(linksWindowX1, floor(linksWindowY1 - (strHeight)), "Links");
	
	// draw window border
	draw_set_color(c_black);
	draw_set_alpha(1);
	draw_rectangle(linksWindowX1, linksWindowY1, linksWindowX2, linksWindowY2, true);
	
	// draw links content
	var linksWindowList = ds_map_find_value(currentPreImportMap, "links");
	var linksWindowListSize = ds_list_size(linksWindowList);
	draw_set_font(global.fontMain);
	var linkColor = make_color_rgb(67, 96, 191);
	draw_set_color(linkColor);
	draw_set_alpha(1);
	for (var i = 0; i < linksWindowListSize; i++) {
		var currentText = ds_list_find_value(linksWindowList, i);
		var currentTextX = floor(linksWindowX1 + textBufferLeft);
		var currentTextY = floor(linksWindowY1 + textBufferTop + (strHeight * i));
		if (currentTextY < linksWindowY2 - (strHeight / 1.5)) {
			draw_text(currentTextX, currentTextY, currentText);
		}
		
		// clickable link
		var textRectX1 = currentTextX;
		var textRectY1 = currentTextY;
		var textRectX2 = textRectX1 + string_width(currentText);
		var textRectY2 = textRectY1 + (strHeight * 0.9);
		if (point_in_rectangle(mouse_x, mouse_y, textRectX1, textRectY1, textRectX2, textRectY2)) {
			draw_line_width(textRectX1, textRectY2, textRectX2, textRectY2, 2);
			if (mouse_check_button_released(mb_left)) {
				scr_openURL(currentText);
			}
		}
	}
	
	
	
	
	*/
	
	
	
	
	// cover-up rectangle
	var coverupRectX1 = floor(camWidth * 0.9) + 2;
	var coverupRectY1 = 0;
	var coverupRectX2 = camWidth;
	var coverupRectY2 = camHeight;
	draw_set_color(global.colorThemeNegSpace);
	draw_set_alpha(1);
	draw_rectangle(coverupRectX1, coverupRectY1, coverupRectX2, coverupRectY2, false);
	
	
	
	
	
	
	
	
	
	
	// continue button
	var buttonRectWidth = camera_get_view_width(camera_get_active()) / 6;
	var buttonRectHeight = camera_get_view_height(camera_get_active()) / 20;
	var buttonRectX1 = (camera_get_view_width(camera_get_active()) / 2) - (buttonRectWidth / 2);
	var buttonRectY1 = (camera_get_view_height(camera_get_active()) * 0.85);
	var buttonRectX2 = buttonRectX1 + buttonRectWidth;
	var buttonRectY2 = buttonRectY1 + buttonRectHeight;
	var mouseoverContinue = point_in_rectangle(mouse_x, mouse_y, buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2);
	
	draw_set_alpha(1);
	draw_set_color(mouseoverContinue ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_rectangle(buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2, true);
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(floor(mean(buttonRectX1, buttonRectX2)), floor(mean(buttonRectY1, buttonRectY2)), "Continue");
	
	// click on continue button
	if (mouseoverContinue && mouse_check_button_released(mb_left)) {
		
		global.currentDirString = global.previousImportDirectory;
		scr_openXML();
		
	}
	
	

	
	
	// draw logo higher than usual
	scr_drawLogo(camera_get_view_width(camera_get_active()) / 2, camera_get_view_height(camera_get_active()) / 9, false);

	
	
	
	
	
	
}