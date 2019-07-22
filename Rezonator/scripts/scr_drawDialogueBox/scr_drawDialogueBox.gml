
/*
	scr_drawSearchBox();
	
	Last Updated: 2019-06-25
	
	Called from: obj_control
	
	Purpose: draw custom search box for multiple options
	
	Mechanism: draws multiple rectangles and text to represent options to the user when they search,
	this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
	Author: Brady Moore
*/
	var verticleBuffer = 125;
	var horizontalBuffer = 250;
	var searchBarXOffset = 235;
	var searchBarYOffset = 20;
	var buttonXOffset = 50;
	var buttonYOffset = 25;


if (obj_control.dialougeBoxActive) {

		quickLinkAllowed = false;
	

	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemePaneBG);
	if (global.colorTheme ==0) {
	draw_set_colour(c_ltgray);
	}
	// draw background UI
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	draw_set_colour(global.colorThemeText);
	
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 15, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 15, string(game_display_name));
	
	draw_set_font(fnt_mainLarge1);

	
	// draw search bar
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - searchBarXOffset, camera_get_view_height(view_camera[0])/2 - searchBarYOffset, camera_get_view_width(view_camera[0]) /2 + searchBarXOffset, camera_get_view_height(view_camera[0])/2 + searchBarYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - searchBarXOffset, camera_get_view_height(view_camera[0])/2 - searchBarYOffset, camera_get_view_width(view_camera[0]) /2 + searchBarXOffset, camera_get_view_height(view_camera[0])/2 + searchBarYOffset, true);

	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 40 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 40 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, true);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 180 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 180 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, true);
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainLarge1);
	
	// draw button text
	draw_text(camera_get_view_width(view_camera[0]) /2 + 30, camera_get_view_height(view_camera[0])/2 + 75, "OK");
	draw_text(camera_get_view_width(view_camera[0]) /2 + 150, camera_get_view_height(view_camera[0])/2 + 75, "Cancel");
	
	if (obj_control.newWordCreated) {
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the new word you would like to add.");
	}

	if (obj_control.gPressed) {
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the line you would like to jump to.");
	}

	if (obj_control.ePressed) {
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input begining line number , ending line number");
	}

	if(obj_control.fPressed) {
		// draw background text
		if(obj_control.regExCheck){
			draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input Regular expression.");
		}
		else{
			draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input string to search for.");
		}
	

		//search functionality
		if (!obj_control.regExCheck) {
	
			// draw boolean option check boxes
			draw_set_colour(global.colorThemeText);
			draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 95, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 105, true);
			if (obj_control.inChainBool) {
				draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 95, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 105, false);	
			}
	
			draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 65, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 75, true);
			if (obj_control.caseSensitive) {
				draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 65, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 75, false);	
			}
	
			draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 35, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 45, true);
			if (obj_control.transcriptSearch) {
				draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 35, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 45, false);	
			}
	
		}
	
		draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 50, camera_get_view_height(view_camera[0])/2 - 55, camera_get_view_width(view_camera[0]) /2 + 60, camera_get_view_height(view_camera[0])/2 - 45, true);
		if (obj_control.regExCheck) {
			draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 50, camera_get_view_height(view_camera[0])/2 - 55, camera_get_view_width(view_camera[0]) /2 + 60, camera_get_view_height(view_camera[0])/2 - 45, false);	
		}

		//darw boolean options text
		draw_set_font(fnt_main);
		if (!obj_control.regExCheck) {
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 40,"Transcript Search");
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 70,"Case Sensistive");
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 100,"In Rez Chain");
		}
		draw_text(camera_get_view_width(view_camera[0]) /2 + 65, camera_get_view_height(view_camera[0])/2 - 48,"RegEx Search");
	
	

		if(!obj_control.regExCheck){

		// current chain boolean switch
		if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 95, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 105)){
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.inChainBool = !obj_control.inChainBool;		
				}
		}

		// case sensitive boolean switch
		if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 65, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 75)){
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.caseSensitive = !obj_control.caseSensitive;			
				}
		}

		// transcript search boolean switch
		if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 35, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 45)){
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.transcriptSearch = !obj_control.transcriptSearch;
				}
		}

		}
		// RegEx boolean switch
		if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) /2 + 50, camera_get_view_height(view_camera[0])/2 - 55, camera_get_view_width(view_camera[0]) /2 + 60, camera_get_view_height(view_camera[0])/2 - 45)){
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.regExCheck = !obj_control.regExCheck;
				}
		}
	}

   // input_text_set_enabled(instance, true);


}
else {
	// reset booleans
	inputText = "";
	keyboard_string = "";
	cursorPos = 1;
	obj_control.transcriptSearch = false;
	obj_control.inChainBool = false;
	obj_control.caseSensitive = false;
	obj_control.regExCheck = false;

}



// keyboard inputs


if (obj_control.dialougeBoxActive) {
// Variables
var ctext = "";
// Clipboard
if(keyboard_check(vk_control) && keyboard_check(ord("V")) && clipboard_has_text()) {
	ctext = clipboard_get_text();
}
if(ctext!="" && (keyboard_check_pressed(ord("V")) || keyboard_check_pressed(vk_control))) { 
	inputText = string_insert(ctext, inputText, cursorPos);
	cursorPos += string_length(ctext);
}

// Backspace
if (keyboard_check_pressed(vk_backspace)) {
	inputText = string_delete(inputText, cursorPos-1, 1);
	if (cursorPos >=2) {
		cursorPos-=1;
	}
	else {
		cursorPos = 2;
	}
}
if (keyboard_string != "") {
      var t = keyboard_string;
      inputText = string_insert(t, inputText, cursorPos);
      cursorPos += string_length(t);
      keyboard_string = "";
	  cursorViz = true;
	  cursorTimer = 20;
}

// Cursor
if(keyboard_check_pressed(vk_left)) {
	if (cursorPos >=2) {
		cursorPos-=1;
	}
	else {
		cursorPos = 1;
	}
}
if(keyboard_check_pressed(vk_right)) {
	if (cursorPos <= string_length(inputText)){
		cursorPos+=1;
	}
	else{
		if (string_length(inputText) > 0) {
			cursorPos = string_length(inputText) +1;
		}
		else {
		 cursorPos = 1;
		}
	}
}

var displayText = inputText;

if (cursorTimer >=0){
	cursorTimer --;
}
else{
	cursorViz = !cursorViz;
	cursorTimer =30;
}


if(cursorViz){
	displayText = string_insert("|", inputText, cursorPos);
}
else{
	displayText = string_delete(displayText, cursorPos, 0);
}

draw_set_halign(fa_left);
draw_text(camera_get_view_width(view_camera[0]) /2 - searchBarXOffset + 5, camera_get_view_height(view_camera[0])/2 , displayText);

//draw_rectangle(camera_get_view_width(view_camera[0]) /2 - searchBarXOffset + 2 + (10 * cursorPos-1), camera_get_view_height(view_camera[0])/2 - searchBarYOffset + 10, camera_get_view_width(view_camera[0]) /2 - searchBarXOffset + 4 + (10 * cursorPos-1), camera_get_view_height(view_camera[0])/2 + searchBarYOffset - 10, false);

}




// ok button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 50 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && obj_control.dialougeBoxActive){
		if (mouse_check_button_pressed(mb_left)) {
			alarm[11] = 60;
			input_text_set_enabled(instance, false);
			//inputText = input_text_get_text(instance);
			
			if (obj_control.fPressed) {
				scr_searchForWord(inputText);
			}
			if (obj_control.ePressed) {
				scr_exportPortion(inputText);
			}
			if (obj_control.gPressed) {
							
				if (obj_panelPane.discoIDSelected) {
					show_message(obj_panelPane.selectedDiscoID);
					scr_jumpToLine(obj_panelPane.selectedDiscoID,inputText);
				}
				else {
					scr_jumpToLine("",inputText);
				}

			}
			if (obj_control.newWordCreated) {
				obj_toolPane.currentTool = obj_toolPane.toolNewWord;
				scr_newWord(newWordHoverUnitID, newWordHoverWordSeq, inputText);
			}
		
			
			input_text_set_text(instance, "");
			obj_control.newWordCreated = false;
			obj_control.fPressed = false;
			obj_control.ePressed = false;
			obj_control.gPressed = false;
			obj_control.dialougeBoxActive = false;
		}
		
}

// cancel button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 175 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && obj_control.dialougeBoxActive){
		if (mouse_check_button_pressed(mb_left)) {
			alarm[11] = 60;
			input_text_set_text(instance, "");
			input_text_set_enabled(instance, false);
			
			obj_control.newWordCreated = false;
			obj_control.fPressed = false;
			obj_control.ePressed = false;
			obj_control.gPressed = false;
			obj_control.dialougeBoxActive = false;
}
		
}


// enter check
if ( keyboard_check_pressed(vk_enter) && obj_control.dialougeBoxActive) {
	alarm[11] = 60;
	input_text_set_enabled(instance, false);
	//inputText = input_text_get_text(instance);
	
		if (obj_control.fPressed) {
			scr_searchForWord(inputText);
		}
		if (obj_control.ePressed) {
			scr_exportPortion(inputText);
		}
		if (obj_control.gPressed) {
			
			if (obj_panelPane.discoIDSelected) {
				show_message(obj_panelPane.selectedDiscoID);
				scr_jumpToLine(obj_panelPane.selectedDiscoID,inputText);
			}
			else {
				scr_jumpToLine("",inputText);
			}

		}
		if (obj_control.newWordCreated) {
			obj_toolPane.currentTool = obj_toolPane.toolNewWord;
			scr_newWord(newWordHoverUnitID, newWordHoverWordSeq, inputText);
		}
		
		
	input_text_set_text(instance, "");
	with (obj_panelPane) {
		discoIDSelected = false;
	}
	obj_control.newWordCreated =false
	obj_control.fPressed = false;
	obj_control.gPressed = false;
	obj_control.ePressed = false;
	obj_control.dialougeBoxActive = false;
}

