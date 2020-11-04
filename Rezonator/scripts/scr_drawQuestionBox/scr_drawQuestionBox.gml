function scr_drawQuestionBox() {

	/*
		scr_drawQuestionBox();
	
		Last Updated: 2019-06-25
	
		Called from: obj_control
	
		Purpose: draw custom search box for multiple options
	
		Mechanism: draws multiple rectangles and text to represent options to the user when they search,
		this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
		Author: Brady Moore
	*/
		var verticleBuffer = 125;
		var horizontalBuffer = 250;
		//var searchBarXOffset = 235;
		//var searchBarYOffset = 20;
		var buttonXOffset = 50;
		var buttonYOffset = 25;


	if (questionWindowActive) {
			obj_control.mouseoverPanelPane = true;
			obj_control.quickLinkAllowed = false;
	

		draw_set_halign(fa_left);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
		draw_set_colour(global.colorThemePaneBG);
		if (global.colorTheme ==0) {
		draw_set_colour(c_ltgray);
		}
		// draw background UI
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);
		draw_set_colour(global.colorThemeText);
	
		draw_set_font(fnt_mainBold);
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 15, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 15, string(game_display_name));
	
		draw_set_font(fnt_mainLarge1);

		// draw buttons for OK and Cancel
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 50 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 50 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, true);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 180 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 175 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 180 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 175 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, true);
		draw_set_colour(global.colorThemeText);
		draw_set_font(fnt_mainLarge1);
	
		// draw button text
		draw_text(camera_get_view_width(camera_get_active()) /2 + 30, camera_get_view_height(camera_get_active())/2 + 75, scr_get_translation("msg_yes"));
		draw_text(camera_get_view_width(camera_get_active()) /2 + 150, camera_get_view_height(camera_get_active())/2 + 75, scr_get_translation("msg_no"));
		

	
	
	
		if(clearAllStacks) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_stacks"));
		}
		if(clearAllRez) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_rez"));
		}
		if(clearAllTracks) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_track"));
		}
		if(clearAllLinks) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_chains"));
		}
		if (clearChain) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_focused_chain"));
		}
		if(layerLink) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("masg_warning_layer_link"));
		}
		if(combineChains) {
			if(obj_control.stackMerged){
				draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_merge_stacks"));
			}
			else{
				draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_merge_chains"));
			}
		}

		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 105, scr_get_translation("msg_ask_sure"));
	}






	// ok button check
	if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) /2 + 50 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 50 + buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset) && questionWindowActive){
		if (mouse_check_button_released(mb_left)) {
			obj_control.alarm[11] = 60;
		


			if(clearAllStacks){
			
				
				obj_chain.currentChainGrid = obj_chain.stackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				var stackGridHeight = ds_grid_height(obj_chain.stackChainGrid);
				for(i = 0 ; i < stackGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
			
		
			}
			if(clearAllRez){
			
				obj_chain.currentChainGrid = obj_chain.rezChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				var rezGridHeight = ds_grid_height(obj_chain.rezChainGrid);
				for(i = 0 ; i < rezGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
		
			}
			if(clearAllTracks){
			
				
				obj_chain.currentChainGrid = obj_chain.trackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				var trackGridHeight = ds_grid_height(obj_chain.trackChainGrid);
				for(i = 0 ; i < trackGridHeight; i++){
					ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
		
			}
			if(clearAllLinks){
			
			
			// loop through stacks
				obj_chain.currentChainGrid = obj_chain.stackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				var stackGridHeight = ds_grid_height(obj_chain.stackChainGrid);
				for(i = 0 ; i < stackGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
			
			// loop through rez chains
				obj_chain.currentChainGrid = obj_chain.rezChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				var rezGridHeight = ds_grid_height(obj_chain.rezChainGrid);
				for(i = 0 ; i < rezGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
			
			// loop through track chains
				obj_chain.currentChainGrid = obj_chain.trackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				var trackGridHeight = ds_grid_height(obj_chain.trackChainGrid);
				for(i = 0 ; i < trackGridHeight; i++){
					ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
		
		
			}
			if (clearChain) {
				scr_deleteChain(obj_control.selectedChainID);
			}
			if(layerLink) {
			
				// Take the saved wordID & click on it
				obj_control.layerLinkAllow = true;
				with(obj_chain) {
					alarm[8] = 2;	
				}
			}
			if(combineChains){
				scr_combineChains(obj_control.clickedWordID);
			}
			questionWindowActive = false;
			clearAllStacks = false;
			clearAllTracks = false;
			clearAllRez = false;
			clearAllLinks = false;
			clearChain = false;
			layerLink = false;
			combineChains = false;
			obj_control.stackMerged = false;
			
			instance_destroy();

		}
		
	}

	// cancel button check
	if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(camera_get_active()) /2 + 180 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 175 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset)  && questionWindowActive && mouse_check_button_released(mb_left) 
			|| keyboard_check_pressed(vk_escape)) {
				obj_control.alarm[11] = 60;
			
			questionWindowActive = false;
			clearAllStacks = false;
			clearAllTracks = false;
			clearAllRez = false;
			clearAllLinks = false;
			clearChain = false;
			layerLink = false;
			combineChains = false;
			obj_control.stackMerged = false;
			
			instance_destroy();

	
		
	}


	// enter check
	if ( keyboard_check_pressed(vk_enter) && questionWindowActive) {
		obj_control.alarm[11] = 60;
		
	
			if(clearAllStacks){
			
				
				obj_chain.currentChainGrid = obj_chain.stackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				var stackGridHeight = ds_grid_height(obj_chain.stackChainGrid);
				for(i = 0 ; i < stackGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
			
		
			}
			if(clearAllRez){
			
				obj_chain.currentChainGrid = obj_chain.rezChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				var rezGridHeight = ds_grid_height(obj_chain.rezChainGrid);
				for(i = 0 ; i < rezGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
		
			}
			if(clearAllTracks){
			
				
				obj_chain.currentChainGrid = obj_chain.trackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				var trackGridHeight = ds_grid_height(obj_chain.trackChainGrid);
				for(i = 0 ; i < trackGridHeight; i++){
					ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
		
			}
			if(clearAllLinks){
			
			
			// loop through stacks
				obj_chain.currentChainGrid = obj_chain.stackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				var stackGridHeight = ds_grid_height(obj_chain.stackChainGrid);
				for(i = 0 ; i < stackGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
			
			// loop through rez chains
				obj_chain.currentChainGrid = obj_chain.rezChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				var rezGridHeight = ds_grid_height(obj_chain.rezChainGrid);
				for(i = 0 ; i < rezGridHeight; i++){
					//var chainID = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainID, 0)
					ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					//show_message(string (currentChainRow) );
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
			
			// loop through track chains
				obj_chain.currentChainGrid = obj_chain.trackChainGrid;
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
				var trackGridHeight = ds_grid_height(obj_chain.trackChainGrid);
				for(i = 0 ; i < trackGridHeight; i++){
					ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState , 0, obj_chain.chainStateFocus);
					var currentChainRow = ds_grid_value_y(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.currentChainGrid) -1, obj_chain.chainStateFocus);
					if(currentChainRow > -1) {
						scr_deleteChain(ds_grid_get(obj_chain.currentChainGrid, obj_chain.chainGrid_colChainID, currentChainRow));
					}
				}
		
		
			}
		
			if (clearChain) {		
				scr_deleteChain(obj_control.selectedChainID);
			}
			if(layerLink) {
			
				// Take the saved wordID & click on it
				obj_control.layerLinkAllow = true;
				with(obj_chain) {
					scr_wordClicked(obj_control.layerLinkWordID, obj_control.layerLinkUnitID);	
				}
			}
			if(combineChains){
				
				scr_combineChains(obj_control.clickedWordID);
			}
			
			questionWindowActive = false;
			clearAllStacks = false;
			clearAllTracks = false;
			clearAllRez = false;
			clearAllLinks = false;
			clearChain = false;
			layerLink = false;
			combineChains = false;
			obj_control.stackMerged = false;
	

		questionWindowActive = false;
		instance_destroy();

	}



}
