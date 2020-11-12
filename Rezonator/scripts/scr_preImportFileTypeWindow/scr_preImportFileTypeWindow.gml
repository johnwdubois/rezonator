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
	var fileTypeWindowX2 = floor(camWidth * 0.41);
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

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}

	scr_windowCameraAdjust();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);
	
	
	

	
	// loop through import types and draw radio buttons for each
	var importTypeList = displayImportTypeList;
	var importTypeListSize = ds_list_size(importTypeList);
	for (var i = 0; i < importTypeListSize; i++) {
		
		var currentImportType = ds_list_find_value(importTypeList, i);
		
		// determine whether currentImportType is selected
		var currentImportTypeSelected = false;
		if (currentImportType == global.importType_PlainText && importTypeSelected == global.importType_PlainText) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_PlainText);
		}
		else if (currentImportType == global.importType_TabDelimited && importTypeSelected == global.importType_TabDelimited) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_TabDelimited);
		}
		else if (currentImportType == global.importType_IGT && importTypeSelected == global.importType_IGT) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_IGT);
		}
		else if (currentImportType == "Interlinear Glossed Text (Scription)" && importTypeSelected == "Interlinear Glossed Text (Scription)") {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_IGT);
		}
		else if (currentImportType == global.importType_CSV && importTypeSelected == global.importType_CSV) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_CSV );
		}
		else if (currentImportType == global.importType_CoNLLU && importTypeSelected == global.importType_CoNLLU) {
			currentImportTypeSelected = true;
			currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_CoNLLU);
		}
		
		// draw radio button
		var buttonLeftBuffer = radioButtonRad + 20;
		var buttonTopBuffer = radioButtonRad + 20;
		var buttonX = fileTypeWindowX1 + buttonLeftBuffer;
		var buttonY = fileTypeWindowY1 + buttonTopBuffer + (strHeight * 1.5 * i);
		draw_set_color(global.colorThemeBorders);
		draw_circle(buttonX - clipX, buttonY - clipY, radioButtonRad, true);
		
		// draw filled-in radio button (if necessary)
		if (currentImportTypeSelected) {
			draw_circle(buttonX - clipX, buttonY - clipY, radioButtonRad * 0.85, false);
		}
		
		// mouseover button
		var mouseoverButton = point_in_circle(mouse_x, mouse_y, buttonX, buttonY, radioButtonRad);
		if (mouseoverButton && !currentImportTypeSelected) {
			draw_set_color(global.colorThemeSelected1);
			draw_circle(buttonX - clipX, buttonY - clipY, radioButtonRad * 0.85, false);
		}
		
		// click on radio button
		if (mouseoverButton && mouse_check_button_released(mb_left)) {
			importTypeSelected = currentImportType;
			if (currentImportType == "Interlinear Glossed Text (Scription)") {
				global.importType = global.importType_IGT;
			}
			else {
				global.importType = importTypeSelected;
			}
		}
		
		// draw text
		draw_set_valign(fa_middle);
		var textX = fileTypeWindowX1 + (buttonLeftBuffer * 1.5) + radioButtonRad;
		var textY = floor(buttonY);
		var textStr = (currentImportType == global.importType_IGT) ? string(global.importType_IGT + " (General)") : string(currentImportType);
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_text(textX - clipX, textY - clipY, textStr);
		
	}
	draw_set_valign(fa_top);
	
	/*
	// draw scrollbar
	scr_scrollBar(importTypeListSize, -1, strHeight * 1.5, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	*/
	
	scr_surfaceEnd();
	
	// draw window title
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_text(fileTypeWindowX1, floor(fileTypeWindowY1 - (strHeight)), "Choose a file type to import");
	


	
	/*
	// mousewheel/keyboard scroll
	if (mouseoverWindow) {
		if (mouse_wheel_up() || keyboard_check(vk_up)) {
			scrollPlusYDest += 8;
		}
		if (mouse_wheel_down() || keyboard_check(vk_down)) {
			scrollPlusYDest -= 8;
		}
	}
	*/

}