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
	
	windowX = floor(camWidth * 0.1);
	windowY = floor(camHeight * 0.25);
	var fileTypeWindowX1 = windowX;
	var fileTypeWindowY1 = windowY;
	var fileTypeWindowX2 = floor(camWidth * 0.41);
	var fileTypeWindowY2 = floor(camHeight * 0.5);
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(fileTypeWindowX1, floor(fileTypeWindowY1 - (strHeight)), "Choose a file type to import");
	
	// draw window border
	var rezonatorPink = make_color_rgb(193, 30, 93);
	draw_set_color(rezonatorPink);
	draw_set_alpha(1);
	for (var i = 0; i < 5; i++) {
		draw_rectangle(fileTypeWindowX1 + i, fileTypeWindowY1 + i, fileTypeWindowX2 - i, fileTypeWindowY2 - i, true);
	}
	
	// loop through import types and draw radio buttons for each  
	var importTypeListSize = ds_list_size(global.importTypeList);
	for (var i = 0; i < importTypeListSize; i++) {
		
		var currentImportType = ds_list_find_value(global.importTypeList, i);
		
		// determine whether currentImportType is selected
		var currentImportTypeSelected = false;
		if (currentImportType == global.importType_PlainText && global.importType == global.importType_PlainText) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_PlainText);
		}
		else if (currentImportType == global.importType_TabDelimited && global.importType == global.importType_TabDelimited) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_TabDelimited);
		}
		else if (currentImportType == global.importType_IGT && global.importType == global.importType_IGT) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_IGT);
		}
		else if (currentImportType == global.importType_CSV && global.importType == global.importType_CSV) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_CSV );
		}
		else if (currentImportType == global.importType_CoNLLU && global.importType == global.importType_CoNLLU) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_CoNLLU);
		}
		
		// draw radio button
		var buttonLeftBuffer = radioButtonRad + 30;
		var buttonTopBuffer = radioButtonRad + 10;
		var buttonX = fileTypeWindowX1 + buttonLeftBuffer;
		var buttonY = fileTypeWindowY1 + radioButtonRad + buttonTopBuffer + (strHeight * 1.5 * i);
		draw_set_color(global.colorThemeBorders);
		draw_circle(buttonX, buttonY, radioButtonRad, true);
		
		// draw filled-in radio button (if necessary)
		if (currentImportTypeSelected) {
			draw_circle(buttonX, buttonY, radioButtonRad * 0.85, false);
		}
		
		// mouseover button
		var mouseoverButton = point_in_circle(mouse_x, mouse_y, buttonX, buttonY, radioButtonRad);
		if (mouseoverButton && !currentImportTypeSelected) {
			draw_set_color(global.colorThemeSelected1);
			draw_circle(buttonX, buttonY, radioButtonRad * 0.85, false);
		}
		
		// click on radio button
		if (mouseoverButton && mouse_check_button_released(mb_left)) {
			if (currentImportType == global.importType_PlainText) {
				global.importType = global.importType_PlainText;
			}
			else if (currentImportType == global.importType_TabDelimited) {
				global.importType = global.importType_TabDelimited;
			}
			else if (currentImportType == global.importType_IGT) {
				global.importType = global.importType_IGT;
			}
			else if (currentImportType == global.importType_CSV) {
				global.importType = global.importType_CSV;
			}
			else if (currentImportType == global.importType_CoNLLU) {
				global.importType = global.importType_CoNLLU;
			}
		}
		
		// draw text
		draw_set_valign(fa_middle);
		var textX = fileTypeWindowX1 + (buttonLeftBuffer * 1.5) + radioButtonRad;
		var textY = floor(buttonY);
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_text(textX, textY, string(currentImportType));
		
	}
	draw_set_valign(fa_top);

}