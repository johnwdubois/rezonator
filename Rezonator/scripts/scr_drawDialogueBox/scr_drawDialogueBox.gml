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
		var boxHeight = max(270, camera_get_view_height(camera_get_active())/4); 
		var boxWidth = max(640, camera_get_view_width(camera_get_active())/3);
		//replaced buffers with vars for width and height so that offsets can be calculated off that
		var searchBarXOffset = boxWidth * 0.45;
		var searchBarYOffset = 20;
		var buttonXOffset = 50;
		var buttonYOffset = 25;
		
		var cameraMidpointX = camera_get_view_width(camera_get_active())/2;
		var cameraMidpointY = camera_get_view_height(camera_get_active())/2;
		
		//Setting input prompt
		if (obj_control.changeAuthor) {
			dialogueBoxText = scr_get_translation("msg_input_creator");
		}
		if (obj_control.changeZero) {
			dialogueBoxText = scr_get_translation("msg_input_new-string");
		}
		if (obj_control.swapLine) {
			dialogueBoxText = scr_get_translation("msg_input_line_number");
		}
		if (obj_control.replace) {
			if(obj_control.splitWord){
				dialogueBoxText = scr_get_translation("msg_input_split_words");
			}
			else{
				dialogueBoxText = scr_get_translation("msg_input_new-word");
			}
		}
		if (obj_control.newWordCreated) {
			dialogueBoxText = scr_get_translation("msg_input_add_new-word");
		}
		
		if(obj_control.caption){
			dialogueBoxText = scr_get_translation("msg_input_caption");
		}	
		if (obj_control.rename) {
			dialogueBoxText = scr_get_translation("msg_input_chain-name");
		}
		if (obj_control.recolor) {
			dialogueBoxText = scr_get_translation("msg_input_chain-color");
		}
		
		if (obj_control.gPressed) {
			if(obj_control.goToTime){
				dialogueBoxText = scr_get_translation("msg_input_time-jump");
			}
			else{
				dialogueBoxText = scr_get_translation("msg_input_line-jump");
			}
		}
		
		var drawNewFieldText = (obj_control.newCustomFieldToken || obj_control.newCustomFieldUnit || obj_control.newCustomFieldEntry || obj_control.newCustomFieldChain);
		var drawNewTagText = (obj_control.newCustomTagToken || obj_control.newCustomTagUnit || obj_control.newCustomTagEntry || obj_control.newCustomTagChain);
		
		if (drawNewFieldText) {
			dialogueBoxText = scr_get_translation("search_custom-field");
		}
		else if (drawNewTagText) {
			dialogueBoxText = scr_get_translation("search_custom-tag");
		}
		if (obj_control.ePressed) {
			dialogueBoxText = scr_get_translation("search_beginning-line");
		}
		
		if(obj_control.fPressed) {
			// draw background text
			if(obj_control.regExCheck){
				dialogueBoxText = scr_get_translation("msg_input_regex");
			}
			else{
				dialogueBoxText = scr_get_translation("search_dialogue_word");
			}
		}
		
		if (obj_control.newTagCategory) {
			dialogueBoxTest = scr_get_translation("msg_new-category");
		}
		
		var dialogueBoxRectX1 = cameraMidpointX - boxWidth/2;
		var dialogueBoxRectY1 = cameraMidpointY - boxHeight/2;
		var dialogueBoxRectX2 = cameraMidpointX + boxWidth/2;
		var dialogueBoxRectY2 = cameraMidpointY + boxHeight/2;
		


	if (obj_control.dialogueBoxActive) {
			obj_control.mouseoverPanelPane = true;
			obj_control.quickLinkAllowed = false;
	
		var overlapFlag = false;
		//this loop checks for any overlaps and breaks after adjusting parameters
		while(overlapFlag){
			
	
			//OK box parameters
			var okBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.5);
			var okBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
			var okBoxRectX2 = dialogueBoxRectX1 + (boxWidth*0.7);
			var okBoxRectY2 = dialogueBoxRectY1 + (boxHeight*0.95);
			
			//readjust dialogue box parameters for next pass through
			dialogueBoxRectX1 = cameraMidpointX - boxWidth/2;
			dialogueBoxRectY1 = cameraMidpointY - boxHeight/2;
			dialogueBoxRectX2 = cameraMidpointX + boxWidth/2;
			dialogueBoxRectY2 = cameraMidpointY + boxHeight/2;
		}

		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_colour(merge_color(global.colorThemeBG,global.colorThemeText,0.1));
		
		draw_rectangle(dialogueBoxRectX1, dialogueBoxRectY1, dialogueBoxRectX2, dialogueBoxRectY2, false);
		draw_set_colour(global.colorThemePaneBG);
		if (global.colorTheme ==0) {
			draw_set_colour(c_ltgray);
		}
		var headerRectX1 = dialogueBoxRectX1;
		var headerRectY1 = dialogueBoxRectY1;
		var headerRectX2 = dialogueBoxRectX2;
		var headerRectY2 = dialogueBoxRectY1+ (boxHeight*0.1);
		
		// draw background UI
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		draw_rectangle(dialogueBoxRectX1, dialogueBoxRectY1, dialogueBoxRectX2, dialogueBoxRectY2, true);
		draw_set_colour(global.colorThemeText);
	
		var headerTextX = floor(headerRectX1 + (boxWidth*0.025));
		var headerTextY = floor(mean(headerRectY1,headerRectY2));
	
	
	
		scr_adaptFont(string(game_display_name),"M");
		draw_text(headerTextX , headerTextY, string(game_display_name));
	

		var searchBarX1 = dialogueBoxRectX1 + (boxWidth*0.05);
		var searchBarY1 = dialogueBoxRectY1 + (boxHeight*0.4);
		var searchBarX2 = dialogueBoxRectX1 + (boxWidth*0.95);
		var searchBarY2 = dialogueBoxRectY1 + (boxHeight*0.6);

	
		// draw search bar
		draw_set_colour(c_white);
		draw_rectangle(searchBarX1, searchBarY1, searchBarX2, searchBarY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(searchBarX1, searchBarY1, searchBarX2, searchBarY2, true);



		var okBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.5);
		var okBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
		var okBoxRectX2 = dialogueBoxRectX1 + (boxWidth*0.7);
		var okBoxRectY2 = dialogueBoxRectY1 + (boxHeight*0.95);
		
		// draw buttons for OK and Cancel
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(okBoxRectX1, okBoxRectY1, okBoxRectX2,okBoxRectY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(okBoxRectX1, okBoxRectY1, okBoxRectX2,okBoxRectY2, true);
		
		
		var cancelBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.75);
		var cancelBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
		var cancelBoxRectX2 = dialogueBoxRectX1 + (boxWidth*0.95);
		var cancelBoxRectY2 = dialogueBoxRectY1 + (boxHeight*0.95);
		
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(cancelBoxRectX1,cancelBoxRectY1, cancelBoxRectX2,cancelBoxRectY2, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(cancelBoxRectX1,cancelBoxRectY1, cancelBoxRectX2,cancelBoxRectY2, true);
		
		
		
		draw_set_colour(global.colorThemeText);
		// draw ok button text
		scr_adaptFont(scr_get_translation("msg_okay"), "M");
		draw_set_halign(fa_center);
		var okTextX = floor(mean(okBoxRectX1,okBoxRectX2));
		var okTextY = floor(mean(okBoxRectY1,okBoxRectY2));
		draw_text(okTextX, okTextY, scr_get_translation("msg_okay"));
		
		// draw cancel button text
		var cancelTextX = floor(mean(cancelBoxRectX1,cancelBoxRectX2));
		var cancelTextY = floor(mean(cancelBoxRectY1,cancelBoxRectY2));
		scr_adaptFont(scr_get_translation("msg_cancel"), "M");
		draw_text(cancelTextX, cancelTextY, scr_get_translation("msg_cancel"));
		
		draw_set_halign(fa_left);
		// Set instruction text Position
		var dialogueBoxTextX = floor(dialogueBoxRectX1 + (boxWidth*0.05));
		var dialogueBoxTextY = floor(dialogueBoxRectY1 + (boxHeight*0.25));
		var booleanBoxWidth = (boxWidth*0.04);
	
		
		// WHERE THE DIALOGUE BOX TEXT IS DRAWN
		draw_text(dialogueBoxTextX, dialogueBoxTextY, obj_dialogueBox.dialogueBoxText);
		
	
		
	
		if (obj_control.replace) {
			var splitWordBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.05);
			var splitWordBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
			var splitWordBoxRectX2 = splitWordBoxRectX1 + booleanBoxWidth;
			var splitWordBoxRectY2 = splitWordBoxRectY1 + booleanBoxWidth;
			
			// draw boolean option check boxes
			draw_set_colour(global.colorThemeText);
			scr_adaptFont(scr_get_translation("label_split-word"), "S");
			var splitWordBoleanTextX = splitWordBoxRectX2 + (boxWidth*0.025);
			var splitWordBoleanTextY = floor(mean(splitWordBoxRectY1,splitWordBoxRectY2));
			draw_text(splitWordBoleanTextX, splitWordBoleanTextY, scr_get_translation("label_split-word"));
		
			draw_rectangle(splitWordBoxRectX1, splitWordBoxRectY1, splitWordBoxRectX2,splitWordBoxRectY2, true);
			if (obj_control.splitWord) {
				draw_rectangle(splitWordBoxRectX1, splitWordBoxRectY1, splitWordBoxRectX2, splitWordBoxRectY2, false);	
			}
	
			// splitWord boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, splitWordBoxRectX1, splitWordBoxRectY1, splitWordBoxRectX2, splitWordBoxRectY2)){
					
					scr_drawBoolHover(obj_control.splitWord);
					
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
			
	
			var insertBeforeBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.05);
			var insertBeforeBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
			var insertBeforeBoxRectX2 = insertBeforeBoxRectX1 + booleanBoxWidth;
			var insertBeforeBoxRectY2 = insertBeforeBoxRectY1 + booleanBoxWidth;
	
			var insertBeforeBoleanTextX = insertBeforeBoxRectX2 + (boxWidth*0.025);
			var insertBeforeBoleanTextY = floor(mean(insertBeforeBoxRectY1,insertBeforeBoxRectY2));
	
				// draw boolean option check boxes
			draw_set_colour(global.colorThemeText);
			scr_adaptFont(scr_get_translation("msg_insert_before"), "S");
			draw_text(insertBeforeBoleanTextX, insertBeforeBoleanTextY , scr_get_translation("msg_insert_before"));
		
			draw_rectangle(insertBeforeBoxRectX1, insertBeforeBoxRectY1, insertBeforeBoxRectX2, insertBeforeBoxRectY2, true);
			if (obj_control.before) {
				draw_rectangle(insertBeforeBoxRectX1, insertBeforeBoxRectY1, insertBeforeBoxRectX2, insertBeforeBoxRectY2, false);	
			}
		
				// insert before boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, insertBeforeBoxRectX1, insertBeforeBoxRectY1, insertBeforeBoxRectX2, insertBeforeBoxRectY2)){
				
					scr_drawBoolHover(obj_control.before);
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.before = !obj_control.before;
					}
			}
	
		}


		if (obj_control.gPressed) {
			
			
			var timeSearchBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.05);
			var timeSearchBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
			var timeSearchBoxRectX2 = timeSearchBoxRectX1 + booleanBoxWidth;
			var timeSearchBoxRectY2 = timeSearchBoxRectY1 + booleanBoxWidth;
	
			var timeSearchBoleanTextX = timeSearchBoxRectX2 + (boxWidth*0.025);
			var timeSearchBoleanTextY = floor(mean(timeSearchBoxRectY1,timeSearchBoxRectY2));
			
		
			scr_adaptFont(scr_get_translation("msg_time_search"), "S");
			draw_text(timeSearchBoleanTextX, timeSearchBoleanTextY, scr_get_translation("msg_time_search"));
	
			draw_rectangle(timeSearchBoxRectX1, timeSearchBoxRectY1,timeSearchBoxRectX2, timeSearchBoxRectY2, true);
			if (obj_control.goToTime) {
				draw_rectangle(timeSearchBoxRectX1, timeSearchBoxRectY1,timeSearchBoxRectX2, timeSearchBoxRectY2, false);	
			}
	
				// GoToTime boolean switch
			if (point_in_rectangle(mouse_x, mouse_y, timeSearchBoxRectX1, timeSearchBoxRectY1,timeSearchBoxRectX2, timeSearchBoxRectY2)){
				
				scr_drawBoolHover(obj_control.goToTime);
				
				if (mouse_check_button_pressed(mb_left)) {
					obj_control.goToTime = !obj_control.goToTime;
				}
			}
	
		}

	

		

		if(obj_control.fPressed) {
	
			
			var caseSensitiveBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.05);
			var caseSensitiveBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.7);
			var caseSensitiveBoxRectX2 = caseSensitiveBoxRectX1 + booleanBoxWidth;
			var caseSensitiveBoxRectY2 = caseSensitiveBoxRectY1 + booleanBoxWidth;
	
			var caseSensitiveBoleanTextX = caseSensitiveBoxRectX2 + (boxWidth*0.025);
			var caseSensitiveBoleanTextY = floor(mean(caseSensitiveBoxRectY1,caseSensitiveBoxRectY2));
			
			var inChainBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.05);
			var inChainBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.85);
			var inChainBoxRectX2 = inChainBoxRectX1 + booleanBoxWidth;
			var inChainBoxRectY2 = inChainBoxRectY1 + booleanBoxWidth;
	
			var inChainBoleanTextX = inChainBoxRectX2 + (boxWidth*0.025);
			var inChainBoleanTextY = floor(mean(inChainBoxRectY1,inChainBoxRectY2));
			
			var RegExBoxRectX1 = dialogueBoxRectX1 + (boxWidth*0.6);
			var RegExBoxRectY1 = dialogueBoxRectY1 + (boxHeight*0.2);
			var RegExBoxRectX2 = RegExBoxRectX1 + booleanBoxWidth;
			var RegExBoxRectY2 = RegExBoxRectY1 + booleanBoxWidth;
	
			var RegExBoleanTextX = RegExBoxRectX2 + (boxWidth*0.025);
			var RegExBoleanTextY = floor(mean(RegExBoxRectY1,RegExBoxRectY2));
			
			//search functionality
			if (!obj_control.regExCheck) {
	
				// draw boolean option check boxes
				draw_set_colour(global.colorThemeText);
				draw_rectangle(caseSensitiveBoxRectX1, caseSensitiveBoxRectY1, caseSensitiveBoxRectX2, caseSensitiveBoxRectY2, true);
				if (obj_control.caseSensitive) {
					draw_rectangle(caseSensitiveBoxRectX1, caseSensitiveBoxRectY1, caseSensitiveBoxRectX2, caseSensitiveBoxRectY2, false);	
				}
	
				draw_rectangle(inChainBoxRectX1,inChainBoxRectY1, inChainBoxRectX2, inChainBoxRectY2, true);
				if (obj_control.inChainBool) {
					draw_rectangle(inChainBoxRectX1,inChainBoxRectY1, inChainBoxRectX2, inChainBoxRectY2, false);	
				}
	
			}
	
			draw_rectangle(RegExBoxRectX1, RegExBoxRectY1,RegExBoxRectX2, RegExBoxRectY2, true);
			if (obj_control.regExCheck) {
				draw_rectangle(RegExBoxRectX1, RegExBoxRectY1,RegExBoxRectX2, RegExBoxRectY2, false);	
			}

			//draw boolean options text
			scr_adaptFont(scr_get_translation("search_dialogue_regEx"), "S");
			if (!obj_control.regExCheck) {
				draw_text(caseSensitiveBoleanTextX, caseSensitiveBoleanTextY, scr_get_translation("search_dialogue_case"));
				draw_text(inChainBoleanTextX, inChainBoleanTextY, scr_get_translation("search_dialogue_current-unit"));
			}
			draw_text(RegExBoleanTextX, RegExBoleanTextY, scr_get_translation("search_dialogue_regEx"));
	
	

			if(!obj_control.regExCheck){

				// case sensitive boolean switch
				if (point_in_rectangle(mouse_x, mouse_y, caseSensitiveBoxRectX1, caseSensitiveBoxRectY1, caseSensitiveBoxRectX2, caseSensitiveBoxRectY2)){
				
					scr_drawBoolHover(obj_control.caseSensitive);
				
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.caseSensitive = !obj_control.caseSensitive;			
					}
				}


				// current chain boolean switch
				if (point_in_rectangle(mouse_x, mouse_y,inChainBoxRectX1,inChainBoxRectY1, inChainBoxRectX2, inChainBoxRectY2)){
				
					scr_drawBoolHover(obj_control.inChainBool);
				
					if (mouse_check_button_pressed(mb_left)) {
						obj_control.inChainBool = !obj_control.inChainBool;
					}
				}

			}
			// RegEx boolean switch
			if (point_in_rectangle(mouse_x, mouse_y,RegExBoxRectX1, RegExBoxRectY1,RegExBoxRectX2, RegExBoxRectY2)){
	
					scr_drawBoolHover(obj_control.regExCheck);
				
				if (mouse_check_button_pressed(mb_left)) {
						obj_control.regExCheck = !obj_control.regExCheck;
					}
			}
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


		if(obj_control.cursorViz) {
			displayText = string_insert("|", displayText, obj_control.cursorPos);
		}
		else {
			displayText = string_delete(displayText, obj_control.cursorPos, 0);
		}
		draw_set_colour(c_black);
		draw_set_halign(fa_left);
		scr_adaptFont(displayText, "M");
		draw_text(floor(cameraMidpointX - searchBarXOffset + 5), floor(cameraMidpointY), displayText);

		//draw_rectangle(cameraMidpointX - searchBarXOffset + 2 + (10 * cursorPos-1), cameraMidpointY - searchBarYOffset + 10, cameraMidpointX - searchBarXOffset + 4 + (10 * cursorPos-1), cameraMidpointY + searchBarYOffset - 10, false);

	}



	var chainSubMap = undefined;
	var chainType = "";
	if (ds_map_exists(global.nodeMap, obj_control.selectedChainID)) {
		chainSubMap = ds_map_find_value(global.nodeMap, obj_control.selectedChainID);
		if (is_numeric(chainSubMap)) {
			if (ds_exists(chainSubMap, ds_type_map)) {
				chainType = ds_map_find_value(chainSubMap, chainType);
			}
		}
	}
	

	var listOfWordID = ds_list_create();
	if (obj_control.recolor) {	
		var chainSubMap = ds_map_find_value(global.nodeMap, obj_control.selectedChainID);
		if (is_numeric(chainSubMap)) {
			if (ds_exists(chainSubMap, ds_type_map)) {
				var setIDList = ds_map_find_value(chainSubMap, "setIDList");
				var setIDListSize = ds_list_size(setIDList);
				for (var i = 0; i < setIDListSize; i++) {
					var currentEntry = ds_list_find_value(setIDList, i);
					var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
					var currentWordID = ds_map_find_value(currentEntrySubMap, "token");
					ds_list_add(listOfWordID, currentWordID);
				}
			}
		}
	}


	// ok button & Enter Key check
	var okButtonClicked = (point_in_rectangle(mouse_x, mouse_y, okBoxRectX1, okBoxRectY1, okBoxRectX2, okBoxRectY2) && mouse_check_button_released(mb_left));
	var enterKeyPressed = keyboard_check_pressed(vk_enter);
	if (obj_control.dialogueBoxActive && (okButtonClicked || enterKeyPressed)) {
			
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
				
			if(obj_control.fromDropDown){
				if (obj_control.before) {
					scr_newWord(obj_control.rightClickUnitID, max(-1,obj_control.rightClickWordSeq - 1), obj_control.inputText, obj_control.rightClickWordID);
				}
				else {
					scr_newWord(obj_control.rightClickUnitID, obj_control.rightClickWordSeq, obj_control.inputText, obj_control.rightClickWordID);
				}
			}
			else{
				if (obj_control.before) {
					scr_newWord(obj_control.newWordHoverUnitID, max(-1,obj_control.newWordHoverWordSeq - 1), obj_control.inputText, obj_control.rightClickWordID);
				}
				else {
					scr_newWord(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq, obj_control.inputText, obj_control.rightClickWordID);
				}
			}
			obj_control.lastAddedWord = obj_control.inputText;
		}
		if (obj_control.changeZero) {
			obj_control.lastAddedWord = obj_control.inputText;
		}
			
			
		if (obj_control.rename) {
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					ds_map_replace(chainSubMap, "name", obj_control.inputText);
				}
			}
		}
		if (obj_control.newCustomFieldToken) {
			scr_dialogueBoxNewCustomFieldToken();
		}
		if (obj_control.newCustomFieldUnit) {
			scr_dialogueBoxNewCustomFieldUnit();
		}
		if (obj_control.newCustomTagUnit) {
			scr_dialogueBoxNewCustomTagUnit();
		}
		if (obj_control.newCustomTagToken) {
			scr_dialogueBoxNewCustomTagToken();
		}
		if (obj_control.newCustomTagEntry) {
			scr_dialogueBoxNewCustomTagEntry();
		}
		if (obj_control.newCustomFieldEntry) {
			scr_dialogueBoxNewCustomFieldEntry();
		}
		if (obj_control.newCustomTagChain) {
			scr_dialogueBoxNewCustomTagChain();
		}
		if (obj_control.newCustomFieldChain) {
			scr_dialogueBoxNewCustomFieldChain();
		}
		

		if (obj_control.recolor) {

			if (string_digits(obj_control.inputText) == "") {
				show_message(scr_get_translation("msg_numbers_only"));
			}
			else {
				if (chainType == "rezChain" || chainType == "trackChain") {
					var listOfWordIDSize = ds_list_size(listOfWordID);
					for (var i = 0; i < listOfWordIDSize; i++) {
						var currentWordID = ds_list_find_value(listOfWordID, i);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentWordID - 1, real(string_digits(obj_control.inputText)));
					}
				}
					
				if (is_numeric(chainSubMap)) {
					if (ds_exists(chainSubMap, ds_type_map)) {
						ds_map_replace(chainSubMap, "chainColor", real(string_digits(obj_control.inputText)));
					}
				}
					
			}
		}
		
		if (obj_control.caption){
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					ds_map_replace(chainSubMap, "caption", obj_control.inputText);
				}
			}
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

		
	}

	// cancel button check
	if (point_in_rectangle(mouse_x, mouse_y, cancelBoxRectX1,cancelBoxRectY1, cancelBoxRectX2,cancelBoxRectY2) && obj_control.dialogueBoxActive && mouse_check_button_released(mb_left) 
			|| keyboard_check_pressed(vk_escape)) {
				obj_control.alarm[11] = 60;
			
				with (obj_panelPane) {
					obj_control.discoIDSelected = false;
				}
			
				scr_closeDialogueBoxVariables();
				instance_destroy();
	
	}
	
	ds_list_destroy(listOfWordID);
}
