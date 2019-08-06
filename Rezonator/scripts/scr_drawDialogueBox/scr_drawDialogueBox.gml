
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


if (obj_control.dialogueBoxActive) {
		obj_control.mouseoverPanelPane = true;
		obj_control.quickLinkAllowed = false;
	

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
	
	if(obj_control.caption){
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the caption you would like to add.");
	}	
	
	
	if (obj_control.rename) {
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the name for this chain.");
	}
	if (obj_control.recolor) {
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the color value for this chain.");
	}

	if (obj_control.gPressed) {
		if(obj_control.goToTime){
			draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the Time you would like to jump to.");
		}
		else{
			draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Input the line you would like to jump to.");
		}
		
			draw_set_font(fnt_main);
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 40,"Time Search");
	
			draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 35, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 45, true);
			if (obj_control.goToTime) {
				draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 35, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 45, false);	
			}
	
			// GoToTime boolean switch
		if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 230, camera_get_view_height(view_camera[0])/2 + 35, camera_get_view_width(view_camera[0]) /2 - 220, camera_get_view_height(view_camera[0])/2 + 45)){
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.goToTime = !obj_control.goToTime;
				}
		}
	
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
	
		draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 75, camera_get_view_height(view_camera[0])/2 - 55, camera_get_view_width(view_camera[0]) /2 + 85, camera_get_view_height(view_camera[0])/2 - 45, true);
		if (obj_control.regExCheck) {
			draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 75, camera_get_view_height(view_camera[0])/2 - 55, camera_get_view_width(view_camera[0]) /2 + 85, camera_get_view_height(view_camera[0])/2 - 45, false);	
		}

		//darw boolean options text
		draw_set_font(fnt_main);
		if (!obj_control.regExCheck) {
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 40,"Search Transcription");
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 70,"Case Sensistive");
			draw_text(camera_get_view_width(view_camera[0]) /2 - 210, camera_get_view_height(view_camera[0])/2 + 100,"In Focused Rez Chain");
		}
		draw_text(camera_get_view_width(view_camera[0]) /2 + 20, camera_get_view_height(view_camera[0])/2 - 48,"RegEx:      Regular Expression");
	
	

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
		if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) /2 + 75, camera_get_view_height(view_camera[0])/2 - 55, camera_get_view_width(view_camera[0]) /2 + 85, camera_get_view_height(view_camera[0])/2 - 45)){
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.regExCheck = !obj_control.regExCheck;
				}
		}
	}

   // input_text_set_enabled(instance, true);


}
else {
	// reset booleans
	obj_control.inputText = "";
	keyboard_string = "";
	obj_control.cursorPos = 1;
	obj_control.transcriptSearch = false;
	obj_control.inChainBool = false;
	obj_control.caseSensitive = false;
	obj_control.regExCheck = false;

}



// keyboard inputs


if (obj_control.dialogueBoxActive) {
// Variables
var ctext = "";
// Clipboard
if(keyboard_check(vk_control) && keyboard_check(ord("V")) && clipboard_has_text()) {
	ctext = clipboard_get_text();
}
if(ctext!="" && (keyboard_check_pressed(ord("V")) || keyboard_check_pressed(vk_control))) { 
	obj_control.inputText = string_insert(ctext, obj_control.inputText, obj_control.cursorPos);
	obj_control.cursorPos += string_length(ctext);
}

// Backspace
if (keyboard_check_pressed(vk_backspace)) {
	obj_control.inputText = string_delete(obj_control.inputText, obj_control.cursorPos-1, 1);
	if (obj_control.cursorPos >=2) {
		obj_control.cursorPos-=1;
	}
	else {
		obj_control.cursorPos = 2;
	}
}
if (keyboard_string != "") {
	var t = keyboard_string;
	obj_control.inputText = string_insert(t, obj_control.inputText, obj_control.cursorPos);
	obj_control.cursorPos += string_length(t);
	keyboard_string = "";
	obj_control.cursorViz = true;
	obj_control.cursorTimer = 20;
}

// Cursor
if(keyboard_check_pressed(vk_left)) {
	if (obj_control.cursorPos >=2) {
		obj_control.cursorPos-=1;
	}
	else {
		obj_control.cursorPos = 1;
	}
}
if(keyboard_check_pressed(vk_right)) {
	if (obj_control.cursorPos <= string_length(obj_control.inputText)){
		obj_control.cursorPos+=1;
	}
	else{
		if (string_length(obj_control.inputText) > 0) {
			obj_control.cursorPos = string_length(obj_control.inputText) +1;
		}
		else {
		 obj_control.cursorPos = 1;
		}
	}
}

var displayText = obj_control.inputText;

if (obj_control.cursorTimer >=0){
	obj_control.cursorTimer --;
}
else{
	obj_control.cursorViz = !obj_control.cursorViz;
	obj_control.cursorTimer =30;
}


if(obj_control.cursorViz){
	displayText = string_insert("|", obj_control.inputText, obj_control.cursorPos);
}
else{
	displayText = string_delete(displayText, obj_control.cursorPos, 0);
}

draw_set_halign(fa_left);
draw_text(camera_get_view_width(view_camera[0]) /2 - searchBarXOffset + 5, camera_get_view_height(view_camera[0])/2 , displayText);

//draw_rectangle(camera_get_view_width(view_camera[0]) /2 - searchBarXOffset + 2 + (10 * cursorPos-1), camera_get_view_height(view_camera[0])/2 - searchBarYOffset + 10, camera_get_view_width(view_camera[0]) /2 - searchBarXOffset + 4 + (10 * cursorPos-1), camera_get_view_height(view_camera[0])/2 + searchBarYOffset - 10, false);

}


			
var grid = obj_chain.rezChainGrid;

// Based on user selection, get the grid of the current tab
switch (obj_panelPane.functionChainList_currentTab) {
	case obj_panelPane.functionChainList_tabRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case obj_panelPane.functionChainList_tabTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case obj_panelPane.functionChainList_tabStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	case obj_panelPane.functionChainList_tabClique:
		grid = obj_chain.cliqueDisplayGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

if(ds_grid_height(grid) > 0 && obj_control.recolor){
	var listOfWordID = ds_list_create();
	ds_list_copy(listOfWordID, ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, obj_control.selectedChainID));
}


// ok button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 50 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && obj_control.dialogueBoxActive){
	if (mouse_check_button_pressed(mb_left)) {
		obj_control.alarm[11] = 60;
		//input_text_set_enabled(obj_control.instance, false);
		//inputText = input_text_get_text(instance);
			
		if (obj_control.fPressed) {
			scr_searchForWord(obj_control.inputText);
		}
		if (obj_control.ePressed) {
			scr_exportPortion(obj_control.inputText);
		}
		if (obj_control.gPressed) {
							
			if (obj_panelPane.discoIDSelected) {
				//show_message(obj_panelPane.selectedDiscoID);
				if(obj_control.goToTime){
					scr_jumpToTime(obj_control.inputText);
				}
				else{
					scr_jumpToLine(obj_panelPane.selectedDiscoID, obj_control.inputText);
				}
			}
			else {
				if(obj_control.goToTime){
					scr_jumpToTime(obj_control.inputText);
				}
				else{
					scr_jumpToLine("",obj_control.inputText);
				}
			}

		}
		
		if (obj_control.newWordCreated) {
			obj_toolPane.currentTool = obj_toolPane.toolNewWord;
			scr_newWord(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq, obj_control.inputText);
		}
			
		if (obj_control.rename) {
			ds_grid_set(grid,  obj_chain.chainGrid_colName, obj_control.selectedChainID, obj_control.inputText);
		}
	
		if (obj_control.recolor) {
			//show_message( string_digits(obj_control.inputText));
			if( string_digits(obj_control.inputText) == "" ){
				show_message( "Numbers only" );
			}
			else{
				if( grid != obj_chain.stackChainGrid){
					for(var i = 0; i < ds_list_size(listOfWordID);i++){
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(obj_control.inputText)));
					}
				}
				ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(obj_control.inputText)));
			}
		}
		
		if(obj_control.caption){
				ds_grid_set(grid,  obj_chain.chainGrid_colCaption, obj_control.selectedChainID, obj_control.inputText);
		}
		
		
		with (obj_panelPane) {
			obj_control.discoIDSelected = false;
		}
			
		//input_text_set_text(obj_control.instance, "");
		//obj_control.newWordCreated = false;
		obj_control.fPressed = false;
		obj_control.ePressed = false;
		obj_control.gPressed = false;
		obj_control.transcriptSearch = false;
		obj_control.inChainBool = false;
		obj_control.caseSensitive = false;
		obj_control.regExCheck = false;
		obj_control.goToTime =  false;
		obj_control.rename = false;
		obj_control.recolor = false;
		obj_control.caption = false;
		obj_control.cursorPos = 1;
		obj_control.inputText = "";
		instance_destroy();
		obj_control.dialogueBoxActive = false;
	}
		
}

// cancel button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 175 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && obj_control.dialogueBoxActive){
		if (mouse_check_button_pressed(mb_left)) {
			obj_control.alarm[11] = 60;
			//input_text_set_text(instance, "");
			//input_text_set_enabled(instance, false);
			
			with (obj_panelPane) {
				obj_control.discoIDSelected = false;
			}
			
			obj_control.newWordCreated = false;
			obj_control.fPressed = false;
			obj_control.ePressed = false;
			obj_control.gPressed = false;
			obj_control.transcriptSearch = false;
			obj_control.inChainBool = false;
			obj_control.caseSensitive = false;
			obj_control.regExCheck = false;
			obj_control.goToTime =  false;
			obj_control.rename = false;
			obj_control.recolor = false;
			obj_control.caption = false;
			obj_control.inputText = "";
			obj_control.cursorPos = 1;
			instance_destroy();
			obj_control.dialogueBoxActive = false;
	}
		
}


// enter check
if ( keyboard_check_pressed(vk_enter) && obj_control.dialogueBoxActive) {
	obj_control.alarm[11] = 60;
	//input_text_set_enabled(instance, false);
	//inputText = input_text_get_text(instance);
	
	if (obj_control.fPressed) {
		scr_searchForWord(obj_control.inputText);
	}
	if (obj_control.ePressed) {
		scr_exportPortion(obj_control.inputText);
	}
	if (obj_control.gPressed) {
			
		if (obj_panelPane.discoIDSelected) {
			//show_message(obj_panelPane.selectedDiscoID);
			if(obj_control.goToTime){
				scr_jumpToTime(obj_control.inputText);
			}
			else{
				scr_jumpToLine(obj_panelPane.selectedDiscoID, obj_control.inputText);
			}
		}
		else {
			if(obj_control.goToTime){
				scr_jumpToTime(obj_control.inputText);
			}
			else{
				scr_jumpToLine("",obj_control.inputText);
			}
		}

	}
	
	if (obj_control.newWordCreated) {
		obj_toolPane.currentTool = obj_toolPane.toolNewWord;
		scr_newWord(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq, obj_control.inputText);
	}
	
	if (obj_control.rename) {
			ds_grid_set(grid,  obj_chain.chainGrid_colName, obj_control.selectedChainID, obj_control.inputText);
	}
	
	if (obj_control.recolor) {
			if( string_digits(obj_control.inputText) == "" ){
				show_message( "Numbers only" );
			}
			else{
				if( grid != obj_chain.stackChainGrid){
					for(var i = 0; i < ds_list_size(listOfWordID);i++){
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor,ds_list_find_value(listOfWordID, i) - 1, real(string_digits(obj_control.inputText)));
					}
				}
				ds_grid_set(grid,  obj_chain.chainGrid_colColor, obj_control.selectedChainID, real(string_digits(obj_control.inputText)));
			}
	}
		
	if(obj_control.caption){
		ds_grid_set(grid,  obj_chain.chainGrid_colCaption, obj_control.selectedChainID, obj_control.inputText);
	}	
	
	//input_text_set_text(instance, "");
	with (obj_panelPane) {
		obj_control.discoIDSelected = false;
	}
	
	obj_control.newWordCreated =false
	obj_control.fPressed = false;
	obj_control.gPressed = false;
	obj_control.ePressed = false;
	obj_control.transcriptSearch = false;
	obj_control.inChainBool = false;
	obj_control.caseSensitive = false;
	obj_control.regExCheck = false;
	obj_control.goToTime =  false;
	obj_control.rename = false;
	obj_control.recolor = false;
	obj_control.caption = false;
	obj_control.inputText = "";
	obj_control.cursorPos = 1;
	instance_destroy();
	obj_control.dialogueBoxActive = false;
}

