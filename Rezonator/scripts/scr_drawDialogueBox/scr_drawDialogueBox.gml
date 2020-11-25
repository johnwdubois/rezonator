function scr_drawDialogueBox() {

	/*
		scr_drawDialogueBox();
	
		Last Updated: 2019-06-25
	
		Called from: obj_dialogueBox
	
		Purpose: draw custom search box for multiple options
	
		Mechanism: draws multiple rectangles and text to represent options to the user when they search,
		this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
		Author: Brady Moore
	*/
		var boxHeight = camera_get_view_height(camera_get_active())/5; 
		var boxWidth = camera_get_view_width(camera_get_active())/3;
		//replaced buffers with vars for width and height so that offsets can be calculated off that
		var searchBarXOffset = boxHeight * 0.45;
		var searchBarYOffset = 20;
		var buttonXOffset = 50;
		var buttonYOffset = 25;
		
		var cameraMidpointX = camera_get_view_width(camera_get_active())/2;
		var cameraMidpointY = camera_get_view_height(camera_get_active())/2;
		
		
		var dialogueBoxRectX1 = cameraMidpointX - boxWidth/2;
		var dialogueBoxRectY1 = cameraMidpointY - boxHeight/2;
		var dialogueBoxRectX2 = cameraMidpointX + boxWidth/2;
		var dialogueBoxRectY2 = cameraMidpointY + boxHeight/2;
		


	if (obj_control.dialogueBoxActive) {
			obj_control.mouseoverPanelPane = true;
			obj_control.quickLinkAllowed = false;
	

		draw_set_halign(fa_left);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(dialogueBoxRectX1, dialogueBoxRectY1, dialogueBoxRectX2, dialogueBoxRectY2, false);
		draw_set_colour(global.colorThemePaneBG);
		if (global.colorTheme ==0) {
		draw_set_colour(c_ltgray);
		}
		// draw background UI
		draw_rectangle(dialogueBoxRectX1, dialogueBoxRectY1 + 30, dialogueBoxRectX2, dialogueBoxRectY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(dialogueBoxRectX1, dialogueBoxRectY1 + 30, dialogueBoxRectX2, dialogueBoxRectY2, true);
		draw_rectangle(dialogueBoxRectX1, dialogueBoxRectY1, dialogueBoxRectX2, dialogueBoxRectY2, true);
		draw_set_colour(global.colorThemeText);
	
		draw_set_font(fnt_mainBold);
		draw_text(floor(dialogueBoxRectX1 + 15), floor(dialogueBoxRectY1 + 15), string(game_display_name));
	
		draw_set_font(fnt_mainLarge1);

	
		// draw search bar
		draw_set_colour(c_white);
		draw_rectangle(cameraMidpointX - searchBarXOffset, cameraMidpointY - searchBarYOffset, cameraMidpointX + searchBarXOffset, cameraMidpointY + searchBarYOffset, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(cameraMidpointX - searchBarXOffset, cameraMidpointY - searchBarYOffset, cameraMidpointX + searchBarXOffset, cameraMidpointY + searchBarYOffset, true);

		// draw buttons for OK and Cancel
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(cameraMidpointX + 40 - buttonXOffset, cameraMidpointY + 75 - buttonYOffset, cameraMidpointX + 50 + buttonXOffset,cameraMidpointY + 75 + buttonYOffset, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(cameraMidpointX + 40 - buttonXOffset, cameraMidpointY + 75 - buttonYOffset, cameraMidpointX + 50 + buttonXOffset,cameraMidpointY + 75 + buttonYOffset, true);
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(cameraMidpointX + 180 - buttonXOffset, cameraMidpointY + 75 - buttonYOffset, cameraMidpointX + 175 + buttonXOffset,cameraMidpointY + 75 + buttonYOffset, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(cameraMidpointX + 180 - buttonXOffset, cameraMidpointY + 75 - buttonYOffset, cameraMidpointX + 175 + buttonXOffset,cameraMidpointY + 75 + buttonYOffset, true);
		draw_set_colour(global.colorThemeText);
		draw_set_font(fnt_mainLarge1);
	
		// draw button text
		draw_text(floor(cameraMidpointX + 30), floor(cameraMidpointY + 75), scr_get_translation("msg_okay"));
		draw_text(floor(cameraMidpointX + 150), floor(cameraMidpointY + 75), scr_get_translation("msg_cancel"));
	
		// Set Text Position
		var dialogueBoxTextX = floor(dialogueBoxRectX1 + 25);
		var dialogueBoxTextY = floor(dialogueBoxRectY1 + 75);
		
	
		if (obj_control.changeAuthor) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_creator"));
		}
		if (obj_control.changeZero) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_new-string"));
		
		}
	
		if (obj_control.swapLine) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_line_number"));
		}
	
		if (obj_control.replace) {
			if(obj_control.splitWord){
				draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_split_words"));
			}
			else{
				draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_new-word"));
			}
		
					
			// draw boolean option check boxes
			draw_set_colour(global.colorThemeText);
			draw_set_font(fnt_main);
			draw_text(floor(cameraMidpointX - 210), floor(cameraMidpointY + 40), scr_get_translation("label_split-word"));
		
			draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, true);
			if (obj_control.splitWord) {
				draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, false);	
			}
	
			// splitWord boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50)){
				
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
					if(obj_control.splitWord){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_enabled"));
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_disabled"));
					}
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.splitWord = !obj_control.splitWord;
					}
			}
		}
	
		if (obj_control.newWordCreated) {
		
			if (obj_control.newWordPre1 == true) {
				obj_control.inputText = "<0>";
				obj_control.cursorPos += string_length(obj_control.inputText);
				obj_control.newWordPre1 = false;
			}
			if (obj_control.newWordPre2 == true) {
				obj_control.inputText = "<ZERO>";
				obj_control.cursorPos += string_length(obj_control.inputText);
				obj_control.newWordPre2 = false;
			}
			if (obj_control.newWordPre3 == true) {
				obj_control.inputText = "<PRO>";
				obj_control.cursorPos += string_length(obj_control.inputText);
				obj_control.newWordPre3 = false;
			}
		
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_add_new-word"));
	
	
				// draw boolean option check boxes
			draw_set_colour(global.colorThemeText);
			draw_set_font(fnt_main);
			draw_text(floor(cameraMidpointX - 210), floor(cameraMidpointY + 40), scr_get_translation("msg_insert_before"));
		
			draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, true);
			if (obj_control.before) {
				draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, false);	
			}
		
				// splitWord boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50)){
				
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
					if(obj_control.before){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20,mouse_y + 40)), scr_get_translation("msg_enabled"));
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20,mouse_y + 40)), scr_get_translation("msg_disabled"));
					}
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.before = !obj_control.before;
					}
			}
	
		}
	
		if(obj_control.caption){
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_caption"));
		}	
	
	
		if (obj_control.rename) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_chain-name"));
		}
		if (obj_control.recolor) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_chain-color"));
		}

		if (obj_control.gPressed) {
			if(obj_control.goToTime){
				draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_time-jump"));
			}
			else{
				draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_line-jump"));
			}
		
				draw_set_font(fnt_main);
				draw_text(floor(cameraMidpointX - 210), floor(cameraMidpointY + 40), scr_get_translation("msg_time_search"));
	
				draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, true);
				if (obj_control.goToTime) {
					draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, false);	
				}
	
				// GoToTime boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50)){
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
					if(obj_control.goToTime){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_enabled"));
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_disabled"));
					}
				
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.goToTime = !obj_control.goToTime;
					}
			}
	
		}
	
		if (obj_control.newCustomFieldToken) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_custom-field"));
		}
		if (obj_control.newCustomTagToken) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_custom-tag"));
		}
		if (obj_control.newCustomFieldUnit) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_custom-field"));
		}
		if (obj_control.newCustomTagUnit) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_custom-field"));
		}
		if (obj_control.newCustomTagStack) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_custom-field"));
		}
	

		if (obj_control.ePressed) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_beginning-line"));
		}

		if(obj_control.fPressed) {
			// draw background text
			if(obj_control.regExCheck){
				draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_input_regex"));
			}
			else{
				draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("search_dialogue_word"));
			}
	

			//search functionality
			if (!obj_control.regExCheck) {
	
				// draw boolean option check boxes
				draw_set_colour(global.colorThemeText);
				/*
				draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 90, cameraMidpointX - 215, cameraMidpointY + 110, true);
				if (obj_control.transcriptSearch) {
					draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 90, cameraMidpointX - 215, cameraMidpointY + 110, false);	
				}
				*/
				draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 60, cameraMidpointX - 215, cameraMidpointY + 80, true);
				if (obj_control.caseSensitive) {
					draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 60, cameraMidpointX - 215, cameraMidpointY + 80, false);	
				}
	
				draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, true);
				if (obj_control.inChainBool) {
					draw_rectangle(cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50, false);	
				}
	
			}
	
			draw_rectangle(cameraMidpointX + 40, cameraMidpointY - 60, cameraMidpointX + 60, cameraMidpointY - 40, true);
			if (obj_control.regExCheck) {
				draw_rectangle(cameraMidpointX + 40, cameraMidpointY - 60, cameraMidpointX + 60, cameraMidpointY - 40, false);	
			}

			//darw boolean options text
			draw_set_font(fnt_main);
			if (!obj_control.regExCheck) {
				draw_text(floor(cameraMidpointX - 210), floor(cameraMidpointY + 40), scr_get_translation("search_dialogue_current-unit"));
				draw_text(floor(cameraMidpointX - 210), floor(cameraMidpointY + 70), scr_get_translation("search_dialogue_case"));
				//draw_text(floor(cameraMidpointX - 210), floor(cameraMidpointY + 100), scr_get_translation("search_dialogue_transcript");
			}
			draw_text(floor(cameraMidpointX + 70), floor(cameraMidpointY - 48), scr_get_translation("search_dialogue_regEx"));
	
	

			if(!obj_control.regExCheck){
			/*
			// transcript search boolean switch		
			if (point_in_rectangle(mouse_x, mouse_y, cameraMidpointX - 235, cameraMidpointY + 90, cameraMidpointX - 215, cameraMidpointY + 110)){
				
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
					if(obj_control.transcriptSearch){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25,mouse_x + 25)), floor(mean(mouse_y + 20,mouse_y + 40)), "Enabled");
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25,mouse_x + 25)), floor(mean(mouse_y + 20,mouse_y + 40)), "Disabled");
					}
				
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.transcriptSearch = !obj_control.transcriptSearch;		
					}
			}
			*/
			// case sensitive boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, cameraMidpointX - 235, cameraMidpointY + 60, cameraMidpointX - 215, cameraMidpointY + 80)){
				
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
					if(obj_control.caseSensitive){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_enabled"));
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_disabled"));
					}
				
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.caseSensitive = !obj_control.caseSensitive;			
					}
			}


			// current chain boolean switch
			if (point_in_rectangle(mouse_x, mouse_y,cameraMidpointX - 235, cameraMidpointY + 30, cameraMidpointX - 215, cameraMidpointY + 50)){
				
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y+20,mouse_x+35, mouse_y + 40,true);
			
					if(obj_control.inChainBool){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_enabled"));
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y + 20, mouse_y + 40)), scr_get_translation("msg_disabled"));
					}
				
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.inChainBool = !obj_control.inChainBool;
					}
			}

			}
			// RegEx boolean switch
			if (point_in_rectangle(mouse_x, mouse_y,cameraMidpointX + 40, cameraMidpointY - 60, cameraMidpointX + 60, cameraMidpointY - 40)){
	
					draw_set_color(c_white);
					draw_rectangle(mouse_x-35, mouse_y-20,mouse_x+35, mouse_y - 40,false);
					draw_set_colour(global.colorThemeBorders);
					draw_rectangle(mouse_x-35, mouse_y-20,mouse_x+35, mouse_y - 40,true);
			
					if(obj_control.regExCheck){
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y - 20, mouse_y - 40)), scr_get_translation("msg_enabled"));
					}
					else{
						draw_set_halign(fa_center);
						draw_text(floor(mean(mouse_x - 25, mouse_x + 25)), floor(mean(mouse_y - 20, mouse_y - 40)), scr_get_translation("msg_disabled"));
					}
				
				if (mouse_check_button_pressed(mb_left)) {
						obj_control.regExCheck = !obj_control.regExCheck;
					}
			}
		}
		if (obj_control.newTagCategory) {
			draw_text(dialogueBoxTextX, dialogueBoxTextY, scr_get_translation("msg_new-category"));
		}


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
	if (keyboard_check(vk_backspace)) {
		obj_control.cursorViz = true;
		if(canDelete){
			obj_control.inputText = string_delete(obj_control.inputText, obj_control.cursorPos-1, 1);
			if (obj_control.cursorPos >=2) {
				obj_control.cursorPos--;
			}
			else {
				obj_control.cursorPos = 2;
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


	if (keyboard_string != "" && string_length(obj_control.inputText) < 100 ) {
		var t = keyboard_string;
		obj_control.inputText = string_insert(t, obj_control.inputText, obj_control.cursorPos);
		obj_control.cursorPos += string_length(t);
		keyboard_string = "";
		obj_control.cursorViz = true;
		obj_control.cursorTimer = 20;
	}

	// Cursor
	if(keyboard_check(vk_left)) {
		obj_control.cursorViz = true;
		if(canPressLeft){
			if (obj_control.cursorPos >=2) {
				obj_control.cursorPos--;
			}
			else {
				obj_control.cursorPos = 1;
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
		obj_control.cursorViz = true;
		if(canPressRight){
			if (obj_control.cursorPos <= string_length(obj_control.inputText) + 1 && obj_control.cursorPos >=1){
				obj_control.cursorPos++;
			}
			else {
				obj_control.cursorPos = string_length(obj_control.inputText) +1;
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
	
	

	clamp(obj_control.cursorPos, 1, string_length(obj_control.inputText));

	displayText = obj_control.inputText;
	if(string_width(obj_control.inputText) > maxDisplaySize){
		displayText = string_copy(obj_control.inputText, (string_length(obj_control.inputText) - maxDisplaySize), string_length(obj_control.inputText) );
	}


	if (obj_control.cursorTimer >=0){
		obj_control.cursorTimer --;
	}
	else{
		obj_control.cursorViz = !obj_control.cursorViz;
		obj_control.cursorTimer =30;
	}


	if(obj_control.cursorViz){
		displayText = string_insert("|", displayText, obj_control.cursorPos);
	}
	else{
		displayText = string_delete(displayText, obj_control.cursorPos, 0);
	}
	draw_set_colour(c_black);
	draw_set_halign(fa_left);
	draw_text(floor(cameraMidpointX - searchBarXOffset + 5), floor(cameraMidpointY), displayText);

	//draw_rectangle(cameraMidpointX - searchBarXOffset + 2 + (10 * cursorPos-1), cameraMidpointY - searchBarYOffset + 10, cameraMidpointX - searchBarXOffset + 4 + (10 * cursorPos-1), cameraMidpointY + searchBarYOffset - 10, false);

	}


			
	grid = obj_chain.rezChainGrid;

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


	// ok button & Enter Key check
	if ((point_in_rectangle(mouse_x, mouse_y, cameraMidpointX + 50 - buttonXOffset, cameraMidpointY + 75 - buttonYOffset, cameraMidpointX + 50 + buttonXOffset, cameraMidpointY + 75 + buttonYOffset) 
	and obj_control.dialogueBoxActive)
	and mouse_check_button_released(mb_left)
	or (keyboard_check_pressed(vk_enter) 
	and obj_control.dialogueBoxActive)){
		//if (mouse_check_button_released(mb_left)) {
			obj_control.alarm[11] = 60;
			
			if (obj_control.fPressed) {
				scr_searchForWord(obj_control.inputText);
			}
			if (obj_control.ePressed) {
				scr_exportClip(obj_control.inputText);
			}
			if (obj_control.gPressed) {
							
				if (obj_panelPane.discoIDSelected) {
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
				//show_message(string("BUH"));
				if(obj_control.fromDropDown){
					if (obj_control.before) {
						scr_newWord(obj_control.rightClickUnitID, max(-1,obj_control.rightClickWordSeq - 1), obj_control.inputText);
						//show_message(string(obj_control.rightClickWordSeq));
					}
					else {
						scr_newWord(obj_control.rightClickUnitID, obj_control.rightClickWordSeq, obj_control.inputText);
					}
				}
				else{
					if (obj_control.before) {
						scr_newWord(obj_control.newWordHoverUnitID, max(-1,obj_control.newWordHoverWordSeq - 1), obj_control.inputText);
											//show_message(string(obj_control.rightClickWordSeq));
					}
					else {
						scr_newWord(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq, obj_control.inputText);
					}
				}
				obj_control.lastAddedWord = obj_control.inputText;
			}
			if (obj_control.changeZero) {
				obj_control.lastAddedWord = obj_control.inputText;
			}
			
			
			if (obj_control.rename) {
				ds_grid_set(grid,  obj_chain.chainGrid_colName, obj_control.selectedChainID, obj_control.inputText);
			}
			if (obj_control.newCustomFieldToken) {
				scr_dialogueBoxNewCustomFieldToken();
			}
			if (obj_control.newCustomFieldUnit) {
				scr_dialogueBoxNewCustomFieldUnit();
			}
			if (obj_control.newCustomTagToken) {
				scr_dialogueBoxNewCustomTagToken();
			}
			if (obj_control.newCustomTagStack) {
				scr_dialogueBoxNewCustomTagStack();
			}
	
			if (obj_control.recolor) {
				//scr_dialogueBoxRecolor();
				if( string_digits(obj_control.inputText) == "" ){
					show_message( scr_get_translation("msg_numbers_only") );
				}
				else{
					if (grid != obj_chain.stackChainGrid){
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
		
			if (obj_control.replace) {
				scr_dialogueBoxReplace();
			}
		
			if (obj_control.swapLine) {
				obj_control.swapLinePos2 = real(string_digits(obj_control.inputText)); 

				scr_swapLine();
			}
		
			if (obj_control.changeAuthor) {
				global.userName = obj_control.inputText;
			}
			
			if (obj_control.newTagCategory) {
				scr_dialogueBoxNewTagCategory();
			}
		
			with (obj_panelPane) {
				obj_control.discoIDSelected = false;
			}
			
			scr_closeDialogueBoxVariables();
			instance_destroy();
		//}
		
	}

	// cancel button check
	if (point_in_rectangle(mouse_x, mouse_y, cameraMidpointX + 175 - buttonXOffset, cameraMidpointY + 75 - buttonYOffset, cameraMidpointX + 175 + buttonXOffset, cameraMidpointY + 75 + buttonYOffset) && obj_control.dialogueBoxActive && mouse_check_button_released(mb_left) 
			|| keyboard_check_pressed(vk_escape)) {
				obj_control.alarm[11] = 60;
			
				with (obj_panelPane) {
					obj_control.discoIDSelected = false;
				}
			
				scr_closeDialogueBoxVariables();
				instance_destroy();
	
		
	}
}
