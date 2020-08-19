if (live_call()) return live_result;

scr_fontSizeControlOpeningScreen();

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var stringHeight = string_height("0");

// Import Screen Title
draw_set_color(global.colorThemeText);
draw_set_font(global.fontMainBold);
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
draw_set_font(global.fontMainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(fileInfoWindowRectX1, fileInfoWindowRectY1 - string_height("0"), "Summary");

draw_set_font(global.fontMain);
draw_text(fileInfoWindowRectX1 + 20, fileInfoWindowRectY1 + stringHeight, "File name: " + filename_name(global.importFilename));
draw_text(floor(fileInfoWindowRectX1 + 20), floor(fileInfoWindowRectY1 + stringHeight * 2.5), "Total Line Count: " + string(ds_grid_height(global.importGrid)));
draw_text(floor(fileInfoWindowRectX1 + 20), floor(fileInfoWindowRectY1 + (stringHeight) * 4), "Markers Found: " + string(ds_grid_height(global.tagInfoGrid)));




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
			var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
			if(cutTest == "Display Token"){
				obj_importMapping.canContinueToken = true;
				i = tagGridHeight;
			}
			else{
				obj_importMapping.canContinueToken = false;
			}
		}
		else{
			var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
			if(cutTest == "Speaker"){
				obj_importMapping.canContinueUnit = true;
				i = tagGridHeight;
			}
			else{
				obj_importMapping.canContinueUnit = false;
			}
		}
	}

}

if((obj_importMapping.canContinueToken) or global.tabDeliniatedText){

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
			
			scr_storeSchLists();
			//show_message(scr_getStringOfList(global.previousLevelEstimates));
			
			room_goto(rm_mainScreen);
		}
	}
	
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);

	draw_set_font(global.fontMain);
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
	
	draw_set_font(global.fontMain);
	draw_set_halign(fa_center);
	draw_set_color(global.colorThemeText);
	draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), "Please Select a Default Display Token and Display Unit.");
}

//fileInfoWindowRectX1, fileInfoWindowRectY1


draw_set_color(global.colorThemeText);
draw_set_font(global.fontMainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(floor(fileInfoWindowRectX1), floor(fileInfoWindowRectY2 + 50), "Import Fields");

var buttonBuffer = 20;


var loadPreviousButtonWidth = max(200, string_width(" Use Last Import Schema "));
var loadPreviousButtonHeight = 30;
var loadPreviousButtonRectX1 = fileInfoWindowRectX1 + string_width("ImportFields    ");
var loadPreviousButtonRectY1 = fileInfoWindowRectY2 + 50 - (loadPreviousButtonHeight / 2);
var loadPreviousButtonRectX2 = loadPreviousButtonRectX1 + loadPreviousButtonWidth;
var loadPreviousButtonRectY2 = loadPreviousButtonRectY1 + loadPreviousButtonHeight;
	
// load preivous
if (point_in_rectangle(mouse_x, mouse_y, loadPreviousButtonRectX1, loadPreviousButtonRectY1, loadPreviousButtonRectX2, loadPreviousButtonRectY2)) {
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(loadPreviousButtonRectX1, loadPreviousButtonRectY1, loadPreviousButtonRectX2, loadPreviousButtonRectY2, false);
	
	if (mouse_check_button_pressed(mb_left)) {
			
		scr_updateSchLists();

	}
}
	
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(loadPreviousButtonRectX1, loadPreviousButtonRectY1, loadPreviousButtonRectX2, loadPreviousButtonRectY2, true);

draw_set_font(global.fontMain);
draw_set_halign(fa_center);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(loadPreviousButtonRectX1, loadPreviousButtonRectX2)), floor(mean(loadPreviousButtonRectY1, loadPreviousButtonRectY2)), "Use Last Import Schema");




var loadSchemaButtonWidth = max(200, string_width(" Load Import Schema "));
var loadSchemaButtonHeight = 30;
var loadSchemaButtonRectX1 = loadPreviousButtonRectX2 + buttonBuffer;
var loadSchemaButtonRectY1 = loadPreviousButtonRectY1;
var loadSchemaButtonRectX2 = loadSchemaButtonRectX1 + loadSchemaButtonWidth;
var loadSchemaButtonRectY2 = loadSchemaButtonRectY1 + loadSchemaButtonHeight;


// Load from File
if (point_in_rectangle(mouse_x, mouse_y, loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2)) {
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2, false);
	
	if (mouse_check_button_pressed(mb_left)) {
			
		scr_loadSCH();
	
	}
}
	
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2, true);

draw_set_font(global.fontMain);
draw_set_halign(fa_center);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(loadSchemaButtonRectX1, loadSchemaButtonRectX2)), floor(mean(loadSchemaButtonRectY1, loadSchemaButtonRectY2)), "Load Import Schema");



var saveSchemaButtonWidth = max(200, string_width(" Save Import Schema "));
var saveSchemaButtonHeight = 30;
var saveSchemaButtonRectX1 = loadSchemaButtonRectX2 + buttonBuffer;
var saveSchemaButtonRectY1 = loadPreviousButtonRectY1;
var saveSchemaButtonRectX2 = saveSchemaButtonRectX1 + saveSchemaButtonWidth;
var saveSchemaButtonRectY2 = saveSchemaButtonRectY1 + saveSchemaButtonHeight;


// Save to File
if (point_in_rectangle(mouse_x, mouse_y, saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2)) {
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2, false);
	
	if (mouse_check_button_pressed(mb_left)) {
		
		//populates lists with current display
		scr_storeSchLists();
		
		// User will specify a name and a location for the sch file 
		scr_saveSCH();

	}
}
	
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2, true);

draw_set_font(global.fontMain);
draw_set_halign(fa_center);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(saveSchemaButtonRectX1, saveSchemaButtonRectX2)), floor(mean(saveSchemaButtonRectY1, saveSchemaButtonRectY2)), "Save Import Schema");




/*
var saveScehmaBuffer = 20;
var saveSchemaButtonRectX1 = loadPreviousButtonRectX2 + saveScehmaBuffer;
var saveSchemaButtonRectY1 = loadPreviousButtonRectY1;
var saveSchemaButtonRectX2 = saveSchemaButtonRectX1 + string_width("  Save Schema  ");
var saveSchemaButtonRectY2 = loadPreviousButtonRectY2;

draw_set_color(global.colorThemeBorders);
draw_rectangle(saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2, true);
draw_set_halign(fa_center);
draw_text(floor(mean(saveSchemaButtonRectX1, saveSchemaButtonRectX2)), floor(mean(saveSchemaButtonRectY1, saveSchemaButtonRectY2)), "Save Schema");

