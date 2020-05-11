
var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);


// Import Screen Title
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(20 + sprite_get_width(spr_backArrow), 20, "Plain Text Import");



// File window
var fileInfoWindowRectX1 = 40;
var fileInfoWindowRectY1 = 80 + string_height("0");
var fileInfoWindowRectX2 = (camWidth / 3) - 20;
var fileInfoWindowRectY2 = (camHeight / 2) - 180;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(fileInfoWindowRectX1, fileInfoWindowRectY1, fileInfoWindowRectX2, fileInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(fileInfoWindowRectX1, fileInfoWindowRectY1 - string_height("0"), "File");

draw_set_font(fnt_main);
draw_text(fileInfoWindowRectX1 + 20, fileInfoWindowRectY1 + string_height("0"), "File name: " + filename_name(global.importFilename));








// Summary window
var summaryInfoWindowRectX1 = (camWidth / 3) + 20;
var summaryInfoWindowRectY1 = 80 + string_height("0");
var summaryInfoWindowRectX2 = camWidth - 40;
var summaryInfoWindowRectY2 = (camHeight / 2) - 180;


var parEntryWindowRectX1 = summaryInfoWindowRectX1 + 20 + string_width("Input Speaker: ");
var parEntryWindowRectY1 = summaryInfoWindowRectY1 + string_height("0")*3 - string_height("0")/2;
var parEntryWindowRectX2 = parEntryWindowRectX1 + 150;
var parEntryWindowRectY2 = parEntryWindowRectY1 + string_height("0");


draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(summaryInfoWindowRectX1, summaryInfoWindowRectY1, summaryInfoWindowRectX2, summaryInfoWindowRectY2, true);
draw_rectangle(parEntryWindowRectX1, parEntryWindowRectY1, parEntryWindowRectX2, parEntryWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(summaryInfoWindowRectX1, summaryInfoWindowRectY1 - string_height("0"), "Summary");

draw_set_font(fnt_main);
draw_text(summaryInfoWindowRectX1 + 20, summaryInfoWindowRectY1 + string_height("0"), "Total Lines found: " + string(ds_grid_height(global.importGrid)));
draw_text(summaryInfoWindowRectX1 + 20, summaryInfoWindowRectY1 + string_height("0")*3, "Input Speaker: ");
//draw_text(summaryInfoWindowRectX1 + 20, summaryInfoWindowRectY1 + (string_height("0") * 2.5), "Tags found: " + string(ds_grid_height(tagInfoGrid)));






//text box for participant entry:

	//code for keyboard input into user sign in
	// Variables
	var ctext = "";
	// Clipboard
	if(keyboard_check(vk_control) && keyboard_check(ord("V")) && clipboard_has_text()) {
		ctext = clipboard_get_text();
	}
	if(ctext!="" && (keyboard_check_pressed(ord("V")) || keyboard_check_pressed(vk_control))) { 
		obj_importMapping.inputText = string_insert(ctext, obj_importMapping.inputText, obj_importMapping.cursorPos);
		obj_importMapping.cursorPos += string_length(ctext);
	}

	// Backspace
	if (keyboard_check(vk_backspace)) {
		obj_importMapping.cursorViz = true;
		if(canDelete){
			obj_importMapping.inputText = string_delete(obj_importMapping.inputText, obj_importMapping.cursorPos-1, 1);
			if (obj_importMapping.cursorPos >=2) {
				obj_importMapping.cursorPos--;
			}
			else {
				obj_importMapping.cursorPos = 2;
			}
			canDelete = false;
		}
		canDeleteHoldingCounter++
		if(canDeleteHoldingCounter == holdingLimit){
			canDelete = true;
			loopItterations ++;
			canDeleteHoldingCounter = 0;
		}
	}
	if (keyboard_check_released(vk_backspace)) {
	loopItterations = 0;
	canDeleteHoldingCounter = 0;
	canDelete = true;
	}
	
	if (keyboard_string != "" && global.menuOpen  && keyboard_string != "-" && keyboard_string != "+" && string_length(obj_importMapping.inputText) < 30 ) {
		//show_message(keyboard_string);
		var t = keyboard_string;
		obj_importMapping.inputText = string_insert(t, obj_importMapping.inputText, obj_importMapping.cursorPos);
		obj_importMapping.cursorPos += string_length(t);
		keyboard_string = "";
		obj_importMapping.cursorViz = true;
		obj_importMapping.cursorTimer = 20;
	}

	// Cursor
	if(keyboard_check(vk_left)) {
		obj_importMapping.cursorViz = true;
		if(canPressLeft){
			if (obj_importMapping.cursorPos >=2) {
				obj_importMapping.cursorPos--;
			}
			else {
				obj_importMapping.cursorPos = 1;
			}
			canPressLeft = false;
		}
		canPressLeftHoldingCounter ++;
		if(canPressLeftHoldingCounter == holdingLimit){
			canPressLeft = true;
			loopItterations ++;
			canPressLeftHoldingCounter = 0;
		}
	}
	if (keyboard_check_released(vk_left)) {
	loopItterations = 0;
	canPressLeftHoldingCounter = 0;
	canPressLeft = true;
	}
	
	if(keyboard_check(vk_right)) {
		obj_importMapping.cursorViz = true;
		if(canPressRight){
			if (obj_importMapping.cursorPos <= string_length(obj_importMapping.inputText) + 1 && obj_importMapping.cursorPos >=1){
				//show_message("buh");
				obj_importMapping.cursorPos++;
			}
			else {
				obj_importMapping.cursorPos = string_length(obj_importMapping.inputText) +1;
			}
						
			canPressRight = false;
		}
			canPressRightHoldingCounter ++;
		if(canPressRightHoldingCounter == holdingLimit){
			canPressRight = true;
			loopItterations ++;
			canPressRightHoldingCounter = 0;
		}
	}
	if (keyboard_check_released(vk_right)) {
	loopItterations = 0;
	canPressRightHoldingCounter = 0;
	canPressRight = true;
	}
	
	

	clamp(obj_importMapping.cursorPos, 1, string_length(obj_importMapping.inputText));

	displayText = obj_importMapping.inputText;
	if(string_width(obj_importMapping.inputText) > maxDisplaySize){
		displayText = string_copy(obj_importMapping.inputText, (string_length(obj_importMapping.inputText) - maxDisplaySize), string_length(obj_importMapping.inputText) );
	}

	if (obj_importMapping.cursorTimer >=0){
		obj_importMapping.cursorTimer --;
	}
	else{
		obj_importMapping.cursorViz = !obj_importMapping.cursorViz;
		obj_importMapping.cursorTimer =30;
	}



	if(obj_importMapping.cursorViz){
		displayText = string_insert("|", displayText, obj_importMapping.cursorPos);
	}
	else{
		displayText = string_delete(displayText, obj_importMapping.cursorPos, 0);
	}

	draw_set_halign(fa_left);
	draw_text(parEntryWindowRectX1+5, mean(parEntryWindowRectY1,parEntryWindowRectY2) , displayText);
	
	global.givenSpeaker = obj_importMapping.inputText;


























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
