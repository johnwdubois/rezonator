function scr_drawElmoScreen() {

	/*
		scr_drawSearchBox();
	
		Last Updated: 2019-06-25
	
		Called from: obj_control
	
		Purpose: draw custom search box for multiple options
	
		Mechanism: draws multiple rectangles and text to represent options to the user when they search,
		this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
		Author: Brady Moore
	*/
	var verticleBuffer = 150;
	var horizontalBuffer = 250;
	//var searchBarXOffset = 235;
	//var searchBarYOffset = 20;
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

		draw_sprite_ext(spr_wheresElmoBG, 0, camera_get_view_width(camera_get_active())/2, camera_get_view_height(camera_get_active())/2, 1, 1, 0, c_white, 1);

		var elmoScreenRectX1 = camera_get_view_width(camera_get_active())/2 - horizontalBuffer,
		elmoScreenRectY1 = camera_get_view_height(camera_get_active())/2 - verticleBuffer - 40,
		elmoScreenRectX2 = camera_get_view_width(camera_get_active())/2 + horizontalBuffer,
		elmoScreenRectY2 = camera_get_view_height(camera_get_active())/2 + verticleBuffer - 40;
		draw_set_colour(global.colorThemeText);
		draw_roundrect(elmoScreenRectX1 - 2, elmoScreenRectY1 - 2, elmoScreenRectX2 + 10, elmoScreenRectY2 + 10, false);

		draw_set_halign(fa_left);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(elmoScreenRectX1, elmoScreenRectY1, elmoScreenRectX2, elmoScreenRectY2, false);
	
	
		draw_set_colour(c_blue);
		draw_set_alpha(0.3);
		/*if (global.colorTheme ==0) {
		draw_set_colour(c_ltgray);
		}*/
		// draw background UI
		draw_rectangle(elmoScreenRectX1, elmoScreenRectY1 + 30, elmoScreenRectX2, elmoScreenRectY2, false);
		draw_set_alpha(1);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(elmoScreenRectX1, elmoScreenRectY1 + 30, elmoScreenRectX2, elmoScreenRectY2, true);
		draw_rectangle(elmoScreenRectX1, elmoScreenRectY1, elmoScreenRectX2, elmoScreenRectY2, true);
		draw_set_colour(global.colorThemeText);
	
		scr_adaptFont(string(game_display_name), "M");
		draw_text(elmoScreenRectX1 + 15, elmoScreenRectY1 + 15, string(game_display_name));
	
	
	
		var bubblePlus = obj_control.wordDrawGridFocusedAnimation,
		bubbleX1 = elmoScreenRectX1 + 30,
		bubbleY1 = elmoScreenRectY1 + 35,
		bubbleX2 = elmoScreenRectX2 - 30,
		bubbleY2 = elmoScreenRectY2 -buttonYOffset;
	
		draw_set_color(global.colorThemeBG);
		draw_roundrect(bubbleX1 - bubblePlus, bubbleY1 - bubblePlus, bubbleX2 + bubblePlus, bubbleY2 + bubblePlus, false);
		draw_set_color(global.colorThemeBorders);
		draw_roundrect(bubbleX1 - bubblePlus, bubbleY1 - bubblePlus, bubbleX2 + bubblePlus, bubbleY2 + bubblePlus, true);
	


		var firstButtonRectX1 = camera_get_view_width(camera_get_active()) /2 - 80 - buttonXOffset,
		firstButtonRectY1 = camera_get_view_height(camera_get_active())/2 + 35 - buttonYOffset,
		firstButtonRectX2 = camera_get_view_width(camera_get_active()) /2 - 80 + buttonXOffset,
		firstButtonRectY2 = camera_get_view_height(camera_get_active())/2 + 35 + buttonYOffset;
	
		// draw buttons for OK and Cancel
		draw_set_colour(global.colorThemeBG);
		if (point_in_rectangle(mouse_x, mouse_y, firstButtonRectX1, firstButtonRectY1, firstButtonRectX2, firstButtonRectY2) && elmoActive){
			draw_set_colour(global.colorThemeSelected2);
		}
		draw_rectangle(firstButtonRectX1, firstButtonRectY1, firstButtonRectX2, firstButtonRectY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(firstButtonRectX1, firstButtonRectY1, firstButtonRectX2, firstButtonRectY2, true);
	
		var secondButtonRectX1 = camera_get_view_width(camera_get_active()) /2 + 80 - buttonXOffset,
		secondButtonRectY1 = firstButtonRectY1,
		secondButtonRectX2 = camera_get_view_width(camera_get_active()) /2 + 80 + buttonXOffset,
		secondButtonRectY2 = firstButtonRectY2;
	
		draw_set_colour(global.colorThemeBG);
		if (point_in_rectangle(mouse_x, mouse_y, secondButtonRectX1, secondButtonRectY1, secondButtonRectX2, secondButtonRectY2) && elmoActive){
			draw_set_colour(global.colorThemeSelected2);
		}
		draw_rectangle(secondButtonRectX1, secondButtonRectY1, secondButtonRectX2, secondButtonRectY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(secondButtonRectX1, secondButtonRectY1, secondButtonRectX2, secondButtonRectY2, true);
	
		draw_set_colour(global.colorThemeText);
		draw_set_halign(fa_center);
	
		// draw button text
		if(openingScreen) {
			scr_adaptFont(scr_get_translation("msg_play"), "M");
			draw_text((firstButtonRectX1 + firstButtonRectX2)/2, (firstButtonRectY1 + firstButtonRectY2)/2, scr_get_translation("msg_play"));
			draw_text((secondButtonRectX1 + secondButtonRectX2)/2, (secondButtonRectY1 + secondButtonRectY2)/2, scr_get_translation("msg_exit"));
		
			draw_text((elmoScreenRectX1 + elmoScreenRectX2)/2, elmoScreenRectY1 + 90, scr_get_translation("msg_where-is-elmo_instructions"));
		}
		else if(endingScreen) {
			scr_adaptFont(scr_get_translation("msg_play"), "M");
			draw_text((firstButtonRectX1 + firstButtonRectX2)/2, (firstButtonRectY1 + firstButtonRectY2)/2, scr_get_translation("msg_exit"));
			draw_text((secondButtonRectX1 + secondButtonRectX2)/2, (secondButtonRectY1 + secondButtonRectY2)/2, scr_get_translation("msg_play"));
	
			draw_text((elmoScreenRectX1 + elmoScreenRectX2)/2, elmoScreenRectY1 + 90, scr_get_translation("msg_elmo_score")+ scoreString);
		}
	}






	// ok button check
	if (point_in_rectangle(mouse_x, mouse_y, firstButtonRectX1, firstButtonRectY1, firstButtonRectX2, firstButtonRectY2) && elmoActive){
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
				obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
	
				// Currently disabled for Demo purposes
				// If the transcriptView was active before the stackShow, switch it back
				if(obj_control.stackShowSwitchedWordView == true) {
					obj_control.stackShowSwitchedWordView = false;
					if(obj_control.wordTokenView) {
			
						obj_control.wordTokenView = !obj_control.wordTokenView;

						for (var i = 0; i < ds_grid_height(obj_control.dynamicWordGrid); i++) {
							var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, i);
							var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, i);
							var currentReplaceWord = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colReplaceWord, i);
	
							if (string_length(currentReplaceWord) > 0) {
								ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, i, currentReplaceWord);
							}
							else {
								if (obj_control.wordTokenView) {
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
							scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
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
		
			//obj_alarm.drawBackground = true;
			obj_control.alarm[11] = 60;
			elmoActive = false;
			instance_destroy();

		}
		
	}

	// cancel button check
	if (point_in_rectangle(mouse_x, mouse_y, secondButtonRectX1, secondButtonRectY1, secondButtonRectX2, secondButtonRectY2) && elmoActive){
		if (device_mouse_check_button_released(0, mb_left)) {
			
			// Exit the stackShow before it begins
			if(openingScreen) {
				if(global.wheresElmo) {
					global.tutorial = false;
					keyboard_string = "";
					room_goto(rm_openingScreen);	
				}
				obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList) - 1;
				obj_toolPane.tracksOnlyStackShow = false;
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



}
