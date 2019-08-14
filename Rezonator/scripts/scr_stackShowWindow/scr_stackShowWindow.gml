
/*
	scr_stackShowWindow();
	
	Last Updated: 2019-06-25
	
	Called from: obj_control
	
	Purpose: draw custom search box for multiple options
	
	Mechanism: draws multiple rectangles and text to represent options to the user when they search,
	this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
	Author: Brady Moore
*/


	var verticleBuffer = 230;
	var horizontalBuffer = 200;
	var stackBoxXOffset = 180;
	var stackBoxYOffset = 160;
	var buttonXOffset = 65;
	var buttonYOffset = 25;


if (stackShowWindowActive) {
	obj_control.mouseoverPanelPane = true;

	

	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	x = camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset;
	y = camera_get_view_height(view_camera[0])/2 - stackBoxYOffset + 1;
	
	draw_set_colour(global.colorThemePaneBG);
	if (global.colorTheme ==0) {
	draw_set_colour(c_ltgray);
	}
	// draw background UI
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);

		
	// draw stack box
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 20, camera_get_view_width(view_camera[0]) /2 + stackBoxXOffset, camera_get_view_height(view_camera[0])/2 + stackBoxYOffset - 20, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 20, camera_get_view_width(view_camera[0]) /2 + stackBoxXOffset, camera_get_view_height(view_camera[0])/2 + stackBoxYOffset - 20, true);

		
	// draw inside stack box
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset, camera_get_view_width(view_camera[0]) /2 + stackBoxXOffset, camera_get_view_height(view_camera[0])/2 + stackBoxYOffset - 20, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset, camera_get_view_width(view_camera[0]) /2 + stackBoxXOffset, camera_get_view_height(view_camera[0])/2 + stackBoxYOffset - 20, true);

	
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 30, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 9, "Select All");
	
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 15, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 15, string(game_display_name));
	
	draw_set_font(fnt_mainLarge1);

	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 - 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 - 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, true);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, true);
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainLarge1);
	
	// draw button text
	draw_text(camera_get_view_width(view_camera[0]) /2 - 155, camera_get_view_height(view_camera[0])/2 + 180, "Show Stacks");
	draw_text(camera_get_view_width(view_camera[0]) /2 + 70, camera_get_view_height(view_camera[0])/2 + 180, "Cancel");
	
	

	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 10, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 20, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5, true);
	if (obj_dialogueBox.selectAll) {
		draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 10, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 20, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5, false);	
	}

	// current chain boolean switch
	if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 10, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 20, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5)){
			if (mouse_check_button_pressed(mb_left)) {
				obj_dialogueBox.selectAll = !obj_dialogueBox.selectAll;	
				ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), obj_dialogueBox.selectAll);
			}
	}
	
	
	// Tracks Only toggle button
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 120, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 130, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5, true);
	if (obj_toolPane.tracksOnlyStackShow) {
		draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 120, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 130, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5, false);	
	}

	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 135, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 10, "Tracks Only");
	// current chain boolean switch
	if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 120, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 130, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5)){
			if (mouse_check_button_pressed(mb_left)) {
				obj_toolPane.tracksOnlyStackShow = !obj_toolPane.tracksOnlyStackShow;	
				obj_toolPane.rezOnlyStackShow = false;
				//ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), obj_dialogueBox.selectAll);
			}
	}
	
	// Rez Only toggle button
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 240, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 250, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5, true);
	if (obj_toolPane.rezOnlyStackShow) {
		draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 240, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 250, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5, false);	
	}

	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 255, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 10, "Rez Only");
	// current chain boolean switch
	if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 240, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 15, camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset + 250, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 5)){
			if (mouse_check_button_pressed(mb_left)) {
				obj_toolPane.rezOnlyStackShow = !obj_toolPane.rezOnlyStackShow;	
				obj_toolPane.tracksOnlyStackShow = false;
				//ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), obj_dialogueBox.selectAll);
			}
	}
	draw_set_font(fnt_mainLarge1);

}




// ok button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 - 100 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset) && stackShowWindowActive){
		if (mouse_check_button_pressed(mb_left)) {
			// In here is where the stackShow initiation code will go
			//obj_control.currentStackShowListPosition = 0;
			for(var stackShowListLoop = 0; stackShowListLoop < ds_grid_height(obj_chain.stackChainGrid); stackShowListLoop++) {
				// Currently adds Stacks into the list if they are within the filter
				if(ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, stackShowListLoop)) {
					var currentStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, stackShowListLoop);
					ds_list_add(obj_control.stackShowList, currentStackID);	
				}
			}
			
			
			
			// Clear the Filter of all chains
			ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.rezChainGrid), false);
			ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.trackChainGrid), false);
			ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
			instance_destroy();
			// Begin the show
			scr_stackShow();
			
			with(obj_toolPane) {
				alarm[3] = 30;	
			}
			
			with(obj_panelPane){
				alarm[5] = 60;
			}
			obj_control.moveCounter = 0;
			
			// Set word's to their tokens as default for stackShow
			if(!obj_control.wordTranscriptView) {
				obj_control.stackShowSwitchedWordView = true;
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
		
}

// cancel button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 100 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset) && stackShowWindowActive){
	if (mouse_check_button_pressed(mb_left)) {
		obj_dialogueBox.stackShowWindowActive = false;
		instance_destroy();
	}
		
}


// enter check
if ( keyboard_check_pressed(vk_enter) && stackShowWindowActive) {

	// In here is where the stackShow initiation code will go
	//obj_control.currentStackShowListPosition = 0;
	for(var stackShowListLoop = 0; stackShowListLoop < ds_grid_height(obj_chain.stackChainGrid); stackShowListLoop++) {
		// Currently adds Stacks into the list if they are within the filter
		if(ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, stackShowListLoop)) {
			var currentStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, stackShowListLoop);
			ds_list_add(obj_control.stackShowList, currentStackID);	
		}
	}
	
	// Clear the Filter of all chains
	ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.rezChainGrid), false);
	ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.trackChainGrid), false);
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
	instance_destroy();
	// Begin the show
	scr_stackShow();
	
	with(obj_toolPane) {
		alarm[3] = 30;	
	}
	with(obj_panelPane){
		alarm[5] = 60;
	}
	obj_control.moveCounter = 0
	
	// Set word's to their tokens as default for stackShow
	if(!obj_control.wordTranscriptView) {
		obj_control.stackShowSwitchedWordView = true;
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

scr_drawStackShowWindow();
