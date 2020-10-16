// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_preImportScreen(){
	
	if (live_call()) return live_result;
	
	draw_set_font(global.fontMain);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("A");
	var radioButtonRad = strHeight * 0.5;
	
	var helpTextX = floor(camera_get_view_width(camera_get_active()) / 2);
	var helpTextY = floor(camera_get_view_height(camera_get_active()) / 2.6);
	draw_set_halign(fa_center);
	draw_text(helpTextX, helpTextY, "Choose a file type to import");
	draw_set_halign(fa_left);
	
	
	// loop through import types and draw radio buttons for each
	var importTypeListSize = ds_list_size(importTypeList);
	for (var i = 0; i < importTypeListSize; i++) {
		
		var currentImportType = ds_list_find_value(importTypeList, i);
		
		// determine whether currentImportType is selected
		var currentImportTypeSelected = false;
		if (currentImportType == "Plain text" && global.importType == global.importType_PlainText) {
			currentImportTypeSelected = true;
		}
		else if (currentImportType == "Tab delimited" && global.importType == global.importType_TabDelimited) {
			currentImportTypeSelected = true;
		}
		else if (currentImportType == "Interlinear Glossed Text" && global.importType == global.importType_IGT) {
			currentImportTypeSelected = true;
		}
		else if (currentImportType == "CSV" && global.importType == global.importType_CSV) {
			currentImportTypeSelected = true;
		}
		else if (currentImportType == "CoNLL-U" && global.importType == global.importType_CoNLLU) {
			currentImportTypeSelected = true;
		}
		
		
		// draw radio button
		var buttonX = camera_get_view_width(camera_get_active()) / 3;
		var buttonY = (camera_get_view_height(camera_get_active()) / 2.25) + (strHeight * 1.5 * i);
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
			if (currentImportType == "Plain text") {
				global.importType = global.importType_PlainText;
			}
			else if (currentImportType == "Tab delimited") {
				global.importType = global.importType_TabDelimited;
			}
			else if (currentImportType == "Interlinear Glossed Text") {
				global.importType = global.importType_IGT;
			}
			else if (currentImportType == "CSV") {
				global.importType = global.importType_CSV;
			}
			else if (currentImportType == "CoNLL-U") {
				global.importType = global.importType_CoNLLU;
			}
		}
		
		// draw text
		var textX = floor(camera_get_view_width(camera_get_active()) / 2.8);
		var textY = floor(buttonY);
		draw_set_color(global.colorThemeText);
		draw_text(textX, textY, string(currentImportType));
		
	}
	
	// continue button
	var buttonRectWidth = camera_get_view_width(camera_get_active()) / 6;
	var buttonRectHeight = camera_get_view_height(camera_get_active()) / 20;
	var buttonRectX1 = (camera_get_view_width(camera_get_active()) / 2) - (buttonRectWidth / 2);
	var buttonRectY1 = (camera_get_view_height(camera_get_active()) * 0.75);
	var buttonRectX2 = buttonRectX1 + buttonRectWidth;
	var buttonRectY2 = buttonRectY1 + buttonRectHeight;
	var mouseoverContinue = point_in_rectangle(mouse_x, mouse_y, buttonRectX1, buttonRectY1, buttonRectX2, buttonRectY2);
	
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
	
	
	
	
	
	
}