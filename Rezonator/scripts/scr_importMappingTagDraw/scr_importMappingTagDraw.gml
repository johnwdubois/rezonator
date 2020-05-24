if (live_call()) return live_result;

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var stringHeight = string_height("0");

// Import Screen Title
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(20 + sprite_get_width(spr_backArrow), 20, "Import File Mapping");



// File window
var fileInfoWindowRectX1 = 40;
var fileInfoWindowRectY1 = 80 + string_height("0");
var fileInfoWindowRectX2 = (camWidth * 0.5) - 20;
var fileInfoWindowRectY2 = (camHeight / 2) - 180;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(fileInfoWindowRectX1, fileInfoWindowRectY1, fileInfoWindowRectX2, fileInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(fileInfoWindowRectX1, fileInfoWindowRectY1 - string_height("0"), "Summary");

draw_set_font(fnt_main);
draw_text(fileInfoWindowRectX1 + 20, fileInfoWindowRectY1 + stringHeight, "File name: " + filename_name(global.importFilename));
draw_text(floor(fileInfoWindowRectX1 + 20), floor(fileInfoWindowRectY1 + stringHeight*2), "Total Line Count: " + string(ds_grid_height(global.importGrid)));
draw_text(floor(fileInfoWindowRectX1 + 20), floor(fileInfoWindowRectY1 + (stringHeight)*3), "Markers Found: " + string(ds_grid_height(global.tagInfoGrid)));




/*



// Summary window
var summaryInfoWindowRectX1 = (camWidth / 3) + 20;
var summaryInfoWindowRectY1 = 80 + string_height("0");
var summaryInfoWindowRectX2 = (camWidth * 0.666) - 20;
var summaryInfoWindowRectY2 = (camHeight / 2) - 180;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(summaryInfoWindowRectX1, summaryInfoWindowRectY1, summaryInfoWindowRectX2, summaryInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(summaryInfoWindowRectX1, summaryInfoWindowRectY1 - string_height("0"), "Summary");


*/
var tagGridHeight = ds_grid_height(global.tagInfoGrid);
for (var j = 0 ; j < 2; j++){

	for (var i = 0 ; i < tagGridHeight; i++ ){
		if( j == 0 ){	
			var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken, i);
			if(cutTest){
				obj_importMapping.canContinueToken = true;
				i = tagGridHeight;
			}
			else{
				obj_importMapping.canContinueToken = false;
			}
		}
		else{
			var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit, i);
			if(cutTest){
				obj_importMapping.canContinueUnit = true;
				i = tagGridHeight;
			}
			else{
				obj_importMapping.canContinueUnit = false;
			}
		}
	}

}

if(obj_importMapping.canContinueToken and obj_importMapping.canContinueUnit){

	var continueButtonWidth = 150;
	var continueButtonHeight = 40;
	var continueButtonRectX1 = (camWidth / 2) - (continueButtonWidth / 2);
	var continueButtonRectY1 = (camHeight - continueButtonHeight - 20) - (continueButtonHeight / 2);
	var continueButtonRectX2 = continueButtonRectX1 + continueButtonWidth;
	var continueButtonRectY2 = continueButtonRectY1 + continueButtonHeight;
	
	// Continue button
	if (point_in_rectangle(mouse_x, mouse_y, continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2)) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, false);
	
		if (mouse_check_button_pressed(mb_left)) {	
			room_goto(rm_mainScreen);
		}
	}
	
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);

	draw_set_font(fnt_main);
	draw_set_halign(fa_center);
	draw_set_color(global.colorThemeText);
	draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), "Continue");

}
else {
	var continueButtonWidth = 150;
	var continueButtonHeight = 40;
	var continueButtonRectX1 = (camWidth / 2) - (continueButtonWidth / 2);
	var continueButtonRectY1 = (camHeight - continueButtonHeight - 20) - (continueButtonHeight / 2);
	var continueButtonRectX2 = continueButtonRectX1 + continueButtonWidth;
	var continueButtonRectY2 = continueButtonRectY1 + continueButtonHeight;
	
	draw_set_font(fnt_main);
	draw_set_halign(fa_center);
	draw_set_color(global.colorThemeText);
	draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), "Please Select a Default Display Token and Display Unit.");
}