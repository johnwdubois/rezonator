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
	
	var exampleWindowX1 = floor(camWidth * 0.512);
	var exampleWindowY1 = floor(camHeight * 0.25);
	var exampleWindowX2 = floor(camWidth * 0.96);
	var exampleWindowY2 = floor(camHeight * 0.8);
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(exampleWindowX1, floor(exampleWindowY1 - (strHeight)), scr_get_translation("msg_example"));
	
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
		
		if (global.importType == global.importType_PlainText || global.importType == global.importType_Paragraph) {
			var currentText = ds_list_find_value(exampleWindowList, i);
			var currentTextX = floor(exampleWindowX1 + textBufferLeft);
			var currentTextY = floor(exampleWindowY1 + textBufferTop + (strHeight * i));
			if (currentTextY < exampleWindowY2 - (strHeight / 1.5)) {
				draw_set_color(global.colorThemeText);
				draw_set_alpha(infoAlpha);
				draw_text(currentTextX, currentTextY, currentText);
			}
		}
		else if (global.importType == global.importType_TabDelimited || global.importType == global.importType_CSV
				|| global.importType == global.importType_CoNLLU || global.importType == global.importType_IGT
				|| global.importType == global.importType_Transcription) {				
			
			// get column width list
			var colWidthList = -1;
			if (global.importType == global.importType_Transcription) colWidthList = ds_map_find_value(global.preImportMap, "transcriptionWidthList");
			else if (global.importType == global.importType_TabDelimited) colWidthList = ds_map_find_value(global.preImportMap, "tabDelimWidthList");
			else if (global.importType == global.importType_CSV) colWidthList = ds_map_find_value(global.preImportMap, "csvWidthList");
			else if (global.importType == global.importType_CoNLLU) colWidthList = ds_map_find_value(global.preImportMap, "conlluWidthList");
			else if (global.importType == global.importType_IGT) colWidthList = ds_map_find_value(global.preImportMap, "igtWidthList");
			
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
						
						// draw column coverup rectangle
						if (string_length(currentText) > 0) {
							var colCoverUpRectX1 = currentTextX;
							var colCoverUpRectY1 = clamp(currentTextY - (strHeight / 2), exampleWindowY1, exampleWindowY2);
							var colCoverUpRectX2 = colCoverUpRectX1 + currentColWidth;
							var colCoverUpRectY2 = clamp(currentTextY + (strHeight / 2), exampleWindowY1, exampleWindowY2);
							draw_set_color(global.colorThemeBG);
							draw_set_alpha(1);
							draw_rectangle(colCoverUpRectX1, colCoverUpRectY1, colCoverUpRectX2, colCoverUpRectY2, false);
						
							// draw text
							if (currentTextY < exampleWindowY2 - (strHeight / 1.5)) {
								draw_set_color(global.colorThemeText);
								draw_set_alpha(infoAlpha);
								draw_set_halign(fa_left);
								draw_set_valign(fa_middle);
								draw_text(currentTextX, currentTextY, string(currentText));
							}
						}
					}
					currentTextX += floor(currentColWidth);
				}
			}
		}
	}
	
	
	
	
	///////////// DESCRIPTION WINDOW ////////////////
	/*
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
	*/
	
	
	
	
	
	
	
	
	// cover-up rectangle
	var coverupRectX1 = exampleWindowX2 + 2;
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
	draw_text(floor(mean(buttonRectX1, buttonRectX2)), floor(mean(buttonRectY1, buttonRectY2)), scr_get_translation("msg_continue"));
	
	// click on continue button
	if (mouseoverContinue && mouse_check_button_released(mb_left)) {
		
		global.currentDirString = global.previousImportDirectory;
		scr_openXML();
		
	}
	
	
	// draw logo higher than usual
	scr_drawLogo(camera_get_view_width(camera_get_active()) / 2, camera_get_view_height(camera_get_active()) / 9, false);

	
	
	
	
	
	
}