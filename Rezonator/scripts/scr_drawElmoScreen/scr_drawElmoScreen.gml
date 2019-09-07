
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
var openingScreen = false;
var endingScreen = false;
	
	
if(obj_control.currentStackShowListPosition == (ds_list_size(obj_control.stackShowList))) {
	endingScreen = true;
	
	//if(string_lower(currentUser) == "player") {
		// Show the ending screen
		var scoreString = " ";
		for(var scoreLoop = 0; scoreLoop < ds_grid_height(obj_chain.goldStandardGrid); scoreLoop++) {
			scoreString += " " + string(ds_grid_get(obj_chain.goldStandardGrid, obj_chain.goldStandardGrid_colScore, scoreLoop));
			if((scoreLoop + 1) != ds_grid_height(obj_chain.goldStandardGrid)) {
				scoreString += ",";
			}
		}
		//show_message(scoreString);
	//}
}
else if(obj_control.currentStackShowListPosition == 0) {
	openingScreen = true;
}
else {
	exit;	
}


if (elmoActive) {
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
	if(openingScreen) {
		draw_text(camera_get_view_width(view_camera[0]) /2 + 30, camera_get_view_height(view_camera[0])/2 + 75, "Play");
		draw_text(camera_get_view_width(view_camera[0]) /2 + 150, camera_get_view_height(view_camera[0])/2 + 75, "Exit");
	
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Where's Elmo?\n\n Click on words to add them to the Track chain!\n Press [Enter] to submit your answer!");
	}
	else if(endingScreen) {
		draw_text(camera_get_view_width(view_camera[0]) /2 + 30, camera_get_view_height(view_camera[0])/2 + 75, "Exit");
		draw_text(camera_get_view_width(view_camera[0]) /2 + 150, camera_get_view_height(view_camera[0])/2 + 75, "Play");
	
		draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 25, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 75, "Good Job!\n Here's your score: " + scoreString);
	}
}






// ok button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 50 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && elmoActive){
	if (device_mouse_check_button_released(0, mb_left)) {
		// Exit the opening/ending screen
		
		if(endingScreen) {
			// I'll need to refactor this into scr_endStackShow();
	
			obj_control.stackShowActive = false;
			obj_toolPane.tracksOnlyStackShow = false;
			obj_toolPane.rezOnlyStackShow = false;
	
			with(obj_panelPane){
				alarm[5] = -1;
			}
			obj_panelPane.timerMins = 0;
			obj_panelPane.timerSecs = 0;
			/*var currentStackID = ds_list_find_value(obj_control.stackShowList, ds_list_size(obj_control.stackShowList) - 1);
			var currentGoldStandardRow = ds_grid_value_y(goldStandardGrid, goldStandardGrid_colStackID, 0, goldStandardGrid_colStackID, ds_grid_height(goldStandardGrid), currentStackID);
			var currentGoldStandardWordIDList = ds_grid_get(goldStandardGrid, goldStandardGrid_colWordIDList, currentGoldStandardRow);
			for(var goldStandardListLoop = 0; goldStandardListLoop < ds_list_size(currentGoldStandardWordIDList); goldStandardListLoop++) {
				var goldWord = ds_list_find_value(currentGoldStandardWordIDList, goldStandardListLoop);
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, goldWord - 1, obj_control.wordStateNormal);	
			}*/
	
			//Set currentStackShowListPosition to -1
			obj_control.currentStackShowListPosition = -1;
	
			//Clear stackShowList
			ds_list_clear(obj_control.stackShowList);
	
			// Exit the filter
			//ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
	
			// Switch to active grid
			//obj_control.stackShowWindowActive = false;
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
			obj_control.scrollPlusYDest = obj_control.prevCenterDisplayRow;
	
			// Currently disabled for Demo purposes
			// If the transcriptView was active before the stackShow, switch it back
			if(obj_control.stackShowSwitchedWordView == true) {
				obj_control.stackShowSwitchedWordView = false;
				if(obj_control.wordTranscriptView) {
			
					obj_control.wordTranscriptView = !obj_control.wordTranscriptView;

					for (var i = 0; i < ds_grid_height(obj_control.dynamicWordGrid); i++) {
						var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
						var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
						var currentReplaceWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
	
						if (string_length(currentReplaceWord) > 0) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
						}
						else {
							if (obj_control.wordTranscriptView) {
								ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordToken);
							}
							else {
								ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentWordTranscript);
							}
						}
					}
				}
			}
			if(obj_control.stackShowSwitchedTextShape) {
				obj_control.shape = obj_control.shapeBlock;
				obj_control.stackShowSwitchedTextShape = false;
			}
			
			if(global.wheresElmo) {
				// Regular finish program procedures
				audio_stop_all();
				scr_userSettingsIniFile();
	
				// Begin by saving the work of the current player in the playerSaves folder
				with (obj_fileLoader) {
					scr_saveREZ(true);
				}
			
				// Then clear the tracks and save the fresh game
				/*obj_chain.currentChainGrid = obj_chain.trackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				var trackGridHeight = ds_grid_height(obj_chain.trackChainGrid);
				for(i = 0 ; i < trackGridHeight; i++){
					ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					if(currentChainRow > -1) {
						scr_deleteEntireChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}*/
				/*with (obj_fileLoader) {
					scr_saveREZ(false);
				}*/
				
				
				// Reset back to the opening screen
				global.tutorial = false;
				keyboard_string = "";
				global.wheresElmo = false;
				room_goto(rm_openingScreen);
			}
		}
		
		obj_control.alarm[11] = 60;
		elmoActive = false;
		instance_destroy();

	}
		
}

// cancel button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 175 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && elmoActive){
	if (device_mouse_check_button_released(0, mb_left)) {
			
		// Exit the stackShow before it begins
		if(openingScreen) {
			if(global.wheresElmo) {
				global.tutorial = false;
				keyboard_string = "";
				room_goto(rm_openingScreen);	
			}
			obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList)-1;
			scr_stackShow();	
		}
		// Restart the stackShow
		else if(endingScreen) {
			obj_control.currentStackShowListPosition = -1;
			ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
			obj_panelPane.showNav = false;
			obj_toolPane.showTool = false;
			scr_stackShow();
		}
			
		obj_control.alarm[11] = 60;
		elmoActive = false;
		instance_destroy();
	}	
}


// enter check
if ( keyboard_check_pressed(vk_enter) && elmoActive) {
	obj_control.alarm[11] = 60;
	elmoActive = false;
	instance_destroy();

}
