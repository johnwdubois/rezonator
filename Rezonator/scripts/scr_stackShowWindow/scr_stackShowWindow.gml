/*
	scr_stackShowWindow();
	
	Last Updated: 2020-10-29
	
	Called from: obj_control
	
	Purpose: draw the window containing the Stack List and buttons for setting up the Stackshow
	
	Mechanism: draws multiple rectangles and text to represent options to the user when they search,
	this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
	Author: Brady Moore
*/
function scr_stackShowWindow() {
	
	// Set drawing variables
	var verticleBuffer = 230;
	var horizontalBuffer = 300;
	var stackBoxXOffset = 280;
	var stackBoxYOffset = 160;
	var buttonXOffset = 65;
	var buttonYOffset = 25;
	var captionBoxWidth = 240;
	var captionBoxHeight = 185;
	var rightCenter = 160;
	var currentStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid) , obj_chain.chainStateFocus);
	var currentStackName = "";
	var currentStackCaption = "";
	
	if(currentStackRow == -1){
		currentStackName = "NO STACK SELECTED";
		currentStackCaption = "";
	}
	else{
		currentStackName = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colName,currentStackRow);
		currentStackCaption = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colCaption,currentStackRow);
		var hashCounter = 1;
		for(i = 0; i < string_length(currentStackCaption); i++){
		
			if(i == hashCounter*24){
				currentStackCaption = string_insert("#",currentStackCaption, i);
				hashCounter ++;
			}
		}
	}

	if (obj_control.stackShowWindowActive) {
		obj_control.mouseoverPanelPane = true;


		x = camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset;
		y = camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 11;
		
		draw_set_halign(fa_left);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
		
	
		draw_set_colour(global.colorThemePaneBG);
		if (global.colorTheme == 0) {
			draw_set_colour(c_ltgray);
		}
		
		// draw background UI
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);

		
		// draw stack box
		draw_set_colour(c_white);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset - 20, camera_get_view_width(camera_get_active()) /2 + 20, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset - 20, camera_get_view_width(camera_get_active()) /2 + 21, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, true);

		
		// draw inside stack box
		draw_set_colour(c_white);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 10 , camera_get_view_width(camera_get_active()) /2 + 20, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 - stackBoxXOffset , camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 10 , camera_get_view_width(camera_get_active()) /2 + 21, camera_get_view_height(camera_get_active())/2 + stackBoxYOffset - 20, true);

		// draw stack caption box
		draw_set_colour(c_white);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40, camera_get_view_height(camera_get_active())/2 - 50, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2 - 50 + captionBoxHeight, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40 , camera_get_view_height(camera_get_active())/2  - 50, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2  - 50 + captionBoxHeight, true);
		draw_set_colour(c_white);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40, camera_get_view_height(camera_get_active())/2 - 25, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2 - 25 + captionBoxHeight - 20, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40, camera_get_view_height(camera_get_active())/2  - 25, camera_get_view_width(camera_get_active()) /2 + 40 + captionBoxWidth, camera_get_view_height(camera_get_active())/2  - 25 + captionBoxHeight - 20, true);

	
		draw_set_colour(global.colorThemeText);
		scr_adaptFont(scr_get_translation("msg_select-all"), "M");
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 - stackBoxXOffset  + 30), floor(camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset - 5), scr_get_translation("msg_select-all"));
	
		draw_set_colour(global.colorThemeText);
		scr_adaptFont(string(game_display_name), "M");
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 - horizontalBuffer + 15), floor(camera_get_view_height(camera_get_active()) / 2 - verticleBuffer + 15), string(game_display_name));
	


		// draw buttons for OK and Cancel
		var okButtonX1 = camera_get_view_width(camera_get_active()) /2 - 100 - buttonXOffset;
		var okButtonY1 = camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset;
		var okButtonX2 = camera_get_view_width(camera_get_active()) /2 - 100 + buttonXOffset;
		var okButtonY2 = camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset;
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(okButtonX1, okButtonY1, okButtonX2, okButtonY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(okButtonX1, okButtonY1, okButtonX2, okButtonY2, true);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 100 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 100 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset, true);
		draw_set_colour(global.colorThemeText);

	
		// draw button text
		scr_adaptFont(scr_get_translation("msg_show-stack"), "M");
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 - 155), floor(camera_get_view_height(camera_get_active()) / 2 + 180), scr_get_translation("msg_show-stack"));
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + 70), floor(camera_get_view_height(camera_get_active())/2 + 180), scr_get_translation("msg_cancel"));

	
	
		// Draw the Filter All button
		var filterAllButtonX1 = camera_get_view_width(camera_get_active()) / 2 - stackBoxXOffset  + 5;
		var filterAllButtonY1 = camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset - 15;
		var filterAllButtonX2 = camera_get_view_width(camera_get_active()) / 2 - stackBoxXOffset  + 25;
		var filterAllButtonY2 = camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset + 5;
		draw_sprite_ext(spr_filterIcons, selectAll, mean(filterAllButtonX1, filterAllButtonX2), mean(filterAllButtonY1, filterAllButtonY2), 1, 1, 0, c_white, 1);
		// Select all boolean switch
		if (point_in_rectangle(mouse_x, mouse_y, filterAllButtonX1, filterAllButtonY1, filterAllButtonX2, filterAllButtonY2)) {
			draw_rectangle(filterAllButtonX1, filterAllButtonY1, filterAllButtonX2, filterAllButtonY2, true);
			if (device_mouse_check_button_released(0, mb_left)) {
				selectAll = !selectAll;	
				ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), selectAll);
			}
		}
	
		//draw list of stacks for selection
		//Chain OverHaul 
		//scr_drawStackShowWindow();

		//right side of window options
	
		//option headers
		draw_set_halign(fa_center);
		draw_set_alpha(1);
		draw_set_colour(global.colorThemeText);
		
		scr_adaptFont(scr_get_translation("msg_mode"), "M");
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + rightCenter), floor(camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset - 10), scr_get_translation("msg_mode"));
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + rightCenter - (string_width("GAME")/2) - 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset, camera_get_view_width(camera_get_active()) /2 + rightCenter + (string_width("GAME")/2) + 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset, true);
	
	
		draw_text(floor(camera_get_view_width(camera_get_active()) /2 + rightCenter), floor(camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset / 2.5 - 10), scr_get_translation("msg_stack"));
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + rightCenter - (string_width("STACK")/2) - 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset/2.5, camera_get_view_width(camera_get_active()) /2 + rightCenter + (string_width("STACK")/2) + 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset/2.5, true);
	
	
		//button for game selection
		scr_adaptFont(string(currentGame), "M");
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + rightCenter), floor(camera_get_view_height(camera_get_active()) / 2 - stackBoxYOffset + 20), currentGame);
		
		// Prevent drawing of names that are too long
		var maxcharLimit = 20;
		var	stackNamedDisplayText = string(currentStackName);
		if(string_length(currentStackName) > maxcharLimit){
			stackNamedDisplayText  = string_copy(currentStackName, 0, maxcharLimit );
			stackNamedDisplayText  += "...";
		}

		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + rightCenter), floor(camera_get_view_height(camera_get_active()) / 2 - 36), string(stackNamedDisplayText));
	
		if (string_length(currentStackCaption) == 0) {
			currentStackCaption = "[No Caption]";
		
		}
	
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + rightCenter), floor(camera_get_view_height(camera_get_active()) / 2 + 40), string_hash_to_newline(currentStackCaption));

		if(gameHover == true){
			draw_rectangle(camera_get_view_width(camera_get_active()) /2 + rightCenter - (string_width(currentGame)/2) - 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 20 - (string_height(currentGame)/2) - 5, camera_get_view_width(camera_get_active()) /2 + rightCenter + (string_width(currentGame)/2) + 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 20 + (string_height(currentGame)/2) + 5, true);
		}

	
		//options text draw
		draw_set_halign(fa_left);
		draw_text(floor(camera_get_view_width(camera_get_active()) / 2 + 70), floor(camera_get_view_height(camera_get_active()) / 2 - 110), scr_get_translation("msg_tutorial"));

	
		// Tutorial toggle button
		draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 70 - 30, camera_get_view_height(camera_get_active())/2 - 110 - 10, camera_get_view_width(camera_get_active()) /2 + 70 -10, camera_get_view_height(camera_get_active())/2 - 110 + 10, true);
		if (obj_control.setTutorial) {
			draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 70 - 30, camera_get_view_height(camera_get_active())/2 - 110 - 10, camera_get_view_width(camera_get_active()) /2 + 70 -10, camera_get_view_height(camera_get_active())/2 - 110 + 10, false);	
		}

		//tutorial logic check
		if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(camera_get_active()) /2 + 70 - 30, camera_get_view_height(camera_get_active())/2 - 110 - 10, camera_get_view_width(camera_get_active()) /2 + 70 -10, camera_get_view_height(camera_get_active())/2 - 110 + 10)){

				draw_set_color(c_white);
				draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
				draw_set_colour(global.colorThemeBorders);
				draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
				if(obj_control.setTutorial){
					draw_set_halign(fa_center);
					draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("search_enabled"));
				}
				else{
					draw_set_halign(fa_center);
					draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("search_disabled"));
				}
				if (device_mouse_check_button_released(0, mb_left)) {
					obj_control.setTutorial = !obj_control.setTutorial;	
				}
		}

		// Check for leftMouseClick on the Games Options
		if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(camera_get_active()) /2 + rightCenter - (string_width(currentGame)/2) - 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 20 - (string_height(currentGame)/2) - 5, camera_get_view_width(camera_get_active()) /2 + rightCenter + (string_width(currentGame)/2) + 5, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 20 + (string_height(currentGame)/2) + 5)){
				gameHover = true;
				if (device_mouse_check_button_released(0, mb_left)) {

						obj_control.wideDropDown = true;
						var dropDownOptionList = ds_list_create();
						ds_list_add(dropDownOptionList, scr_get_translation("label_option_present"), scr_get_translation("label_option_where_elmo"), scr_get_translation("label_option_rezzles"));

						if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
							scr_createDropDown(camera_get_view_width(camera_get_active()) /2 + 134 - 52, camera_get_view_height(camera_get_active())/2 - stackBoxYOffset + 22 + (string_height(currentGame)/2) + 5, dropDownOptionList, global.optionListTypeGame);
						}
				}
		}
		else{
			gameHover = false;
		}
	}


	// ok button & enter check
	if ((point_in_rectangle(mouse_x, mouse_y, okButtonX1, okButtonY1, okButtonX2, okButtonY2) and obj_control.stackShowWindowActive)
	or ((keyboard_check_pressed(vk_enter) and obj_control.stackShowWindowActive) and !instance_exists(obj_dialogueBox) or global.games)){
			if (device_mouse_check_button_released(0, mb_left) && !instance_exists(obj_dialogueBox)) {
			
				if(currentGame == "Where's Elmo"){
					obj_toolPane.tracksOnlyStackShow = true;
				}
				if(currentGame == "Rezzles"){
					obj_toolPane.rezOnlyStackShow = true;
				}

				if(obj_control.setNavWindow){
					obj_panelPane.showNav = true;
					obj_toolPane.showTool = true;
				}
				else{
					obj_panelPane.showNav = false;
					obj_toolPane.showTool = false;
				}
			
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
			
				// Restrict tool selection for players
				if(string(global.userName) != "gold"){
					with(obj_toolPane) {
						alarm[3] = 30;	
					}
				}
			
				// Start the tracker timer
				with(obj_panelPane){
					alarm[5] = 60;
				}
				obj_control.moveCounter = 0;
			
				// Set word's to their tokens as default for stackShow
				if(!obj_control.wordTokenView and obj_toolPane.tracksOnlyStackShow) {
					//obj_control.stackShowSwitchedWordView = true;
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
				if(obj_toolPane.tracksOnlyStackShow) {
					if (obj_control.shape == obj_control.shapeBlock) {
						obj_control.stackShowSwitchedTextShape = true;
						obj_control.shape = obj_control.shapeText;	
					}
					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
				
					instance_create_layer(-500, -500, "Instances", obj_submitChain);
	
					obj_dialogueBox.elmoActive = true;
					if(string(global.userName) != "gold") {
						obj_panelPane.showNav = false;
						obj_toolPane.showTool = false;
					}
				}
				obj_menuBar.menuClickedIn = false;
			}
		
	}
	// cancel button check
	if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) /2 + 100 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 100 + buttonXOffset, camera_get_view_height(camera_get_active())/2 + 180 + buttonYOffset) && obj_control.stackShowWindowActive && mouse_check_button_released(mb_left) 
			|| keyboard_check_pressed(vk_escape)) {
			obj_menuBar.menuClickedIn = false;
			obj_control.stackShowWindowActive = false;
			instance_destroy();
	
		
	}

	// Check for mouseover of StackShow window
	if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) / 2 - horizontalBuffer, camera_get_view_height(camera_get_active()) / 2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active()) / 2 + verticleBuffer)){
		obj_control.mouseoverPanelPane = true;
	}
	else {
		obj_control.mouseoverPanelPane = false;
	}

}
