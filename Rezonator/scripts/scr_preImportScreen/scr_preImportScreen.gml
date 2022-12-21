

function scr_preImportScreen(){
	
	scr_fontSizeControlOpeningScreen();
	
	var mouseoverCancel = instance_exists(obj_dialogueBox) || instance_exists(obj_dropDown);
	
	// get camera width & height
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	
	// draw negative space BG
	draw_set_alpha(1);
	draw_set_color(global.colorThemeNegSpace);
	draw_rectangle(0, 0, camWidth, camHeight, false);
	
	var rezonatorPink = make_color_rgb(193, 30, 93);
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	scr_adaptFont("", "M");
	var strHeight = string_height("0");
	var textBufferLeft = strHeight / 2;
	var textBufferTop = strHeight / 2;
	var infoAlpha = 0.5;
	
	var tabHeight = strHeight*1.5;
	// get the currentPreImportMap from obj_preImportFileType
	if (!instance_exists(obj_preImportFileType)) {
		exit;
	}
	
	
	
	
	
	
	
	
	///////////// Background WINDOW ////////////////
	
	var backgroundWindowX1 = floor(camWidth * 0.04);
	var backgroundWindowY1 = floor(camHeight * 0.15);
	var backgroundWindowX2 = floor(camWidth * 0.96);
	var backgroundWindowY2 = floor(camHeight * 0.8);
	
	var tabTextY = backgroundWindowY1 - tabHeight/2 - (strHeight)/2;

	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_rectangle(backgroundWindowX1, backgroundWindowY1, backgroundWindowX2, backgroundWindowY2, false);
	
	// draw example content
	var exampleWindowList = ds_map_find_value(global.currentPreImportMap, "example");
	var exampleWindowListSize = ds_list_size(exampleWindowList);
	
	var backgroundWidth = backgroundWindowX2 - backgroundWindowX1;
	
	
	var dataTabX1 = backgroundWindowX1;
	var dataTabY1 = backgroundWindowY1 - tabHeight;
	var dataTabX2 = backgroundWidth* 0.315;
	var dataTabY2 = backgroundWindowY1 + tabHeight/2;
	
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(dataTabX1, dataTabY1, dataTabX2, dataTabY2, false);
	
	
	draw_set_color(global.colorThemeText);
	scr_adaptFont(scr_get_translation("import_col_data"), "L");
	draw_text(dataTabX1 + textBufferLeft, floor(tabTextY), scr_get_translation("import_col_data"));
		
	///////////// DESCRIPTION WINDOW ////////////////

	var descriptionWindowX1 = backgroundWidth* 0.33;
	var descriptionWindowY1 = backgroundWindowY1;
	var descriptionWindowX2 = backgroundWidth* 0.66;
	var descriptionWindowY2 = backgroundWindowY2;
	
	var descriptionTabX1 = descriptionWindowX1;
	var descriptionTabY1 = descriptionWindowY1 - tabHeight;
	var descriptionTabX2 = backgroundWidth* 0.645;
	var descriptionTabY2 = descriptionWindowY1 + tabHeight/2;
	
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(descriptionTabX1, descriptionTabY1, descriptionTabX2, descriptionTabY2, false);
	
	// draw window title
	draw_set_color(global.colorThemeText);
	scr_adaptFont(scr_get_translation("import_col_description"), "L");
	draw_set_alpha(1);
	draw_text(descriptionWindowX1 + textBufferLeft, floor(tabTextY), scr_get_translation("import_col_description"));
	
	
	
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(descriptionWindowX1, descriptionWindowY1, descriptionWindowX2, descriptionWindowY2, false);
	
	// draw description content
	var descriptionWindowList = ds_map_find_value(global.currentPreImportMap, "description");
	var descriptionWindowListSize = ds_list_size(descriptionWindowList);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(infoAlpha);
	for (var i = 0; i < descriptionWindowListSize; i++) {
		var currentText = ds_list_find_value(descriptionWindowList, i);
		var currentTextX = floor(descriptionWindowX1 + textBufferLeft);
		var currentTextY = floor(descriptionWindowY1 + textBufferTop + (strHeight * i));
		if (currentTextY < descriptionWindowY2 - (strHeight / 1.5)) {
			scr_adaptFont(currentText, "M");
			draw_text(currentTextX, currentTextY, currentText);
		}
	}

	
	
	
	
	
	
	
	
	
	///////////// EXAMPLE WINDOW ////////////////
	
	var exampleWindowX1 = backgroundWidth* 0.66;
	var exampleWindowY1 = backgroundWindowY1;
	var exampleWindowX2 = backgroundWindowX2;
	var exampleWindowY2 = backgroundWindowY2;
	
	
		
	var exampleTabX1 = descriptionWindowX2;
	var exampleTabY1 = descriptionWindowY1 - tabHeight;
	var exampleTabX2 = backgroundWindowX2;
	var exampleTabY2 = descriptionWindowY1 + tabHeight/2;
	
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(exampleTabX1, exampleTabY1, exampleTabX2, exampleTabY2, false);
	
	// draw window border
	draw_set_color(global.colorThemeBG);
	draw_set_alpha(1);
	draw_roundrect(exampleWindowX1, exampleWindowY1, exampleWindowX2, exampleWindowY2, false);
	
	
	
	// draw window title
	scr_adaptFont(scr_get_translation("import_col_example"), "L");
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(exampleTabX1+textBufferLeft, floor(tabTextY), scr_get_translation("import_col_example"));
	
	
	
	var currentTextX = floor(exampleWindowX1 + textBufferLeft);
	for (var i = 0; i < exampleWindowListSize; i++) {
		
		if (global.importType == global.importType_PlainText || global.importType == global.importType_Paragraph) {
			var currentText = ds_list_find_value(exampleWindowList, i);
			var currentTextX = floor(exampleWindowX1 + textBufferLeft);
			var currentTextY = floor(exampleWindowY1 + textBufferTop + (strHeight * i));
			if (currentTextY < exampleWindowY2 - (strHeight / 1.5)) {
				draw_set_color(global.colorThemeText);
				draw_set_alpha(infoAlpha);
				scr_adaptFont(currentText, "M");
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
								scr_adaptFont(string(currentText), "M");
								draw_text(currentTextX, currentTextY, string(currentText));
							}
						}
					}
					currentTextX += floor(currentColWidth);
				}
			}
		}
	}
	
	
	

	
	
	
	
	
	
	// cover-up rectangle
	var coverupRectX1 = backgroundWindowX2 + 2;
	var coverupRectY1 = 0;
	var coverupRectX2 = camWidth;
	var coverupRectY2 = camHeight;
	draw_set_color(global.colorThemeNegSpace);
	draw_set_alpha(1);
	draw_rectangle(coverupRectX1, coverupRectY1, coverupRectX2, coverupRectY2, false);
	
	
	
	
	
	
	
	
	
	
	// continue button
	var buttonRectWidth = camera_get_view_width(camera_get_active()) / 6;
	var buttonRectHeight = camera_get_view_height(camera_get_active()) / 20;
	var buttonRectX1 = (camera_get_view_width(camera_get_active()) * .8) - (buttonRectWidth / 2);
	var buttonRectY1 = (camera_get_view_height(camera_get_active()) * 0.85);
	var buttonRectX2 = buttonRectX1 + buttonRectWidth;
	var buttonRectY2 = buttonRectY1 + buttonRectHeight;
	var mouseoverContinue = point_in_rectangle(mouse_x, mouse_y, buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2) && !mouseoverCancel;
	
	draw_set_alpha(1);
	draw_set_color(mouseoverContinue ? merge_color(global.colorThemeSelected1, rezonatorPink, 50)  : rezonatorPink);
	draw_roundrect(buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2, false);
	draw_set_color(rezonatorPink);
	draw_roundrect(buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2, true);
	
	draw_set_color(global.colorThemeBG);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("msg_continue"), "M");
	draw_text(floor(mean(buttonRectX1, buttonRectX2)), floor(mean(buttonRectY1, buttonRectY2)), scr_get_translation("msg_continue"));
	
	// click on continue button
	if (mouseoverContinue && mouse_check_button_released(mb_left)) {		
		global.currentDirString = global.previousImportDirectory;
		scr_openFile();
		
	}
	
	if (global.exitOut) {
		if (!instance_exists(obj_dialogueBox)) {
			global.skipToImportScreen = true;
			show_debug_message("Going to openingScreen, scr_importTXT");
			room_goto(rm_openingScreen);
		}
	}
	
	
	// back button
	var backButtonRectWidth = camera_get_view_width(camera_get_active()) / 6;
	var backButtonRectHeight = camera_get_view_height(camera_get_active()) / 20;
	var backButtonRectX1 = (camera_get_view_width(camera_get_active()) * .2) - (backButtonRectWidth / 2);
	var backButtonRectY1 = (camera_get_view_height(camera_get_active()) * 0.85);
	var backButtonRectX2 = backButtonRectX1 + backButtonRectWidth;
	var backButtonRectY2 = backButtonRectY1 + backButtonRectHeight;
	var mouseoverBack = point_in_rectangle(mouse_x, mouse_y, backButtonRectX1, backButtonRectY1, backButtonRectX2, backButtonRectY2) && !mouseoverCancel;
	
	draw_set_alpha(1);
	draw_set_color(mouseoverBack ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_roundrect(backButtonRectX1, backButtonRectY1, backButtonRectX2, backButtonRectY2, false);
	draw_set_color(rezonatorPink);
	draw_roundrect(backButtonRectX1, backButtonRectY1, backButtonRectX2, backButtonRectY2, true);
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("msg_continue"), "M");
	draw_text(floor(mean(backButtonRectX1, backButtonRectX2)), floor(mean(backButtonRectY1, backButtonRectY2)), scr_get_translation("label_back"));
	
	// click on continue button
	if (mouseoverBack && mouse_check_button_released(mb_left)) {		
		global.newProject = false;
		global.openProject = false;
		global.neworOpen = true;
		obj_recentFilesWindow.inputDelay = 10;
	}
	
	
	
	
	
	// tag button
	var tagButtonRectWidth = camera_get_view_width(camera_get_active()) / 8;
	var tagButtonRectHeight = camera_get_view_height(camera_get_active()) / 20;
	var tagButtonRectX1 = (camera_get_view_width(camera_get_active()) * .9) - (tagButtonRectWidth / 2);
	var tagButtonRectY1 = (camera_get_view_height(camera_get_active()) * 0.05);
	var tagButtonRectX2 = tagButtonRectX1 + tagButtonRectWidth;
	var tagButtonRectY2 = tagButtonRectY1 + tagButtonRectHeight;
	var mouseoverTag = point_in_rectangle(mouse_x, mouse_y, tagButtonRectX1, tagButtonRectY1, tagButtonRectX2, tagButtonRectY2) && !mouseoverCancel;
	
	draw_set_alpha(1);
	draw_set_color(mouseoverTag ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_roundrect(tagButtonRectX1, tagButtonRectY1, tagButtonRectX2, tagButtonRectY2, false);
	draw_set_color(rezonatorPink);
	draw_roundrect(tagButtonRectX1, tagButtonRectY1, tagButtonRectX2, tagButtonRectY2, true);
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("msg_continue"), "M");
	draw_text(floor(mean(tagButtonRectX1, tagButtonRectX2)), floor(mean(tagButtonRectY1, tagButtonRectY2)), scr_get_translation("Add Tags"));

	if (mouseoverTag) scr_createTooltip(floor(tagButtonRectX1),floor(mean(tagButtonRectY1, tagButtonRectY2)),"Tag schemas imported: "+ string( ds_list_size(global.selectedTagSchemaFileList)),obj_tooltip.arrowFaceRight);

	// click on continue button
	if (mouseoverTag && mouse_check_button_released(mb_left)) {		
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, global.includedTagSchemaFileList)
		// localize
		ds_list_insert(dropDownOptionList, 0,"Custom tag schema");
		scr_createDropDown(floor(tagButtonRectX1),floor(tagButtonRectY2), dropDownOptionList, global.optionListTypeTagSchema);
		
	}

		//draw_text(camera_get_view_height(camera_get_active()) * 0.5, camera_get_view_height(camera_get_active()) * 0.92,scr_getStringOfList(global.selectedTagSchemaFileList));

}