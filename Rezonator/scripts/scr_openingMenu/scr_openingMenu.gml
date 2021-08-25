function scr_openingMenu() {


	scr_fontSizeControlOpeningScreen();
	


	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);


	var middleBuffer = 115;
	var verticalYSpacing = 20;

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	draw_set_alpha(1);
	draw_set_color(merge_color(global.colorThemeSelected1, c_white, .4));
	draw_rectangle(0, 0, camWidth, camHeight, false);

	var buttonWidth = (camWidth*.8) /3;
	var buttonHeight = (camHeight*.3);
	
	var mouseoverCancel = instance_exists(obj_dialogueBox);
	
	
	
	// open rez selection
	var openProjectButtonX1 = (camWidth * 0.10); 
	var openProjectButtonY1 = camHeight * 0.4;
	var openProjectButtonX2 = openProjectButtonX1 + buttonWidth;
	var openProjectButtonY2 = openProjectButtonY1 + buttonHeight;
	var mouseOverOpen = point_in_rectangle(mouse_x, mouse_y, openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2) && !mouseoverCancel;
	if (mouseOverOpen) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, false);
	
		if (device_mouse_check_button_released(0, mb_left)) {
			global.newProject = false;
			global.openProject = true;
		}
	}
	
	// draw open button
	draw_set_color(merge_color(global.colorThemeBG, global.colorThemeRezPurple, hoverColorMergeOpen));
	draw_roundrect(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, false);
	draw_set_color(global.colorThemeRezPurple);
	draw_roundrect(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, true);

	// open button sprite & text
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(mouseOverOpen ? global.colorThemeBG : global.colorThemeText);
	draw_sprite_ext(spr_openingMenuOpen, global.fontSize, mean(openProjectButtonX1,openProjectButtonX2), openProjectButtonY1 + (openProjectButtonY2 - openProjectButtonY1) * 0.38, 1, 1, 0, merge_color(global.colorThemeRezPurple, global.colorThemeBG, hoverColorMergeOpen), 1);
	scr_adaptFont(scr_get_translation("menu_import"),"L", true);
	draw_text(floor(mean(openProjectButtonX1, openProjectButtonX2)), openProjectButtonY1 + (openProjectButtonY2 - openProjectButtonY1)*.8,  scr_get_translation("help_label_open"));
	






	// import new file selection
	var newProjectButtonX1 = openProjectButtonX2 + verticalYSpacing;
	var newProjectButtonY1 = openProjectButtonY1;
	var newProjectButtonX2 = newProjectButtonX1 + buttonWidth;
	var newProjectButtonY2 = newProjectButtonY1 + buttonHeight;
	var mouseOverImport = point_in_rectangle(mouse_x, mouse_y, newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2) && !mouseoverCancel;
	if (mouseOverImport) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, false);
	
		if (device_mouse_check_button_released(0, mb_left)) {
			global.newProject = true;
			global.openProject = false;
		}
	}
	
	// draw import button
	draw_set_color(merge_color(global.colorThemeBG, global.colorThemeRezPurple, hoverColorMergeImport));
	draw_roundrect(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, false);
	draw_set_color(global.colorThemeRezPurple);
	draw_roundrect(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, true);
	
	// import button sprite & text
	draw_set_color(mouseOverImport ? global.colorThemeBG : global.colorThemeText);
	draw_sprite_ext(spr_openingMenuImport, global.fontSize, mean(newProjectButtonX1,newProjectButtonX2), newProjectButtonY1 + (newProjectButtonY2 - newProjectButtonY1) * 0.38, 1, 1, 0, merge_color(global.colorThemeRezPurple, global.colorThemeBG, hoverColorMergeImport), 1);
	scr_adaptFont(scr_get_translation("menu_import"),"L", true);
	draw_text(floor(mean(newProjectButtonX1, newProjectButtonX2)), newProjectButtonY1 + (newProjectButtonY2 - newProjectButtonY1)*.8,  scr_get_translation("menu_import"));
	




	// help/documentation button
	draw_set_alpha(1);
	scr_adaptFont(scr_get_translation("msg_go-to-guide"),"M");
	var documentationStr = scr_get_translation("menu_help");
	var documentationButtonX1 = newProjectButtonX2 + verticalYSpacing;
	var documentationButtonY1 = openProjectButtonY1;
	var documentationButtonX2 = documentationButtonX1 + buttonWidth;
	var documentationButtonY2 = documentationButtonY1 + buttonHeight;
	var mouseoverDocumenation = point_in_rectangle(mouse_x, mouse_y, documentationButtonX1, documentationButtonY1, documentationButtonX2, documentationButtonY2) && !mouseoverCancel;

	// draw help button
	draw_set_color(merge_color(global.colorThemeBG, global.colorThemeRezPurple, hoverColorMergeHelp));
	draw_roundrect(documentationButtonX1, documentationButtonY1, documentationButtonX2, documentationButtonY2, false);
	draw_set_color(global.colorThemeRezPurple);
	draw_roundrect(documentationButtonX1, documentationButtonY1, documentationButtonX2, documentationButtonY2, true);

	// help button sprite & text
	draw_set_color(mouseoverDocumenation ? global.colorThemeBG : global.colorThemeText);
	draw_sprite_ext(spr_openingMenuDoc, global.fontSize, mean(documentationButtonX1, documentationButtonX2), documentationButtonY1 + (documentationButtonY2 - documentationButtonY1) * 0.38, 1, 1, 0, merge_color(global.colorThemeRezPurple, global.colorThemeBG, hoverColorMergeHelp), 1);
	scr_adaptFont(scr_get_translation("menu_import"),"L", true);
	draw_text(floor(mean(documentationButtonX1, documentationButtonX2)), documentationButtonY1 + (documentationButtonY2 - documentationButtonY1)*.8, documentationStr);

	if (mouseoverDocumenation && documentationButtonActive) {
		if(mouse_check_button_released(mb_left)){
			scr_openURL("https://rezonator.com/documentation/");
		}
	}




	var stringBuffer = string_width("   ");
	var signInXBuffer = 20;
	var signInYBuffer = 25;
	var signInText = scr_get_translation("msg_signin")
	scr_adaptFont(signInText,"M");
	var stringWidth = string_width(signInText);
	var stringHeight = string_height(signInText);
	var userSignInBoxX2 = camWidth * 0.95 ;	
	var userSignInBoxY1 = camHeight * 0.85;
	var userSignInBoxX1 = userSignInBoxX2 - stringWidth - stringBuffer*2 ;
	var userSignInBoxY2 = userSignInBoxY1 + stringHeight*1.5;


	draw_set_color(global.colorThemeBG);
	draw_rectangle(userSignInBoxX1, userSignInBoxY1, userSignInBoxX2, userSignInBoxY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(userSignInBoxX1, userSignInBoxY1, userSignInBoxX2, userSignInBoxY2, true);
	draw_set_color(global.colorThemeText);



	draw_text(mean(userSignInBoxX1, userSignInBoxX2), userSignInBoxY2 + string_height(scr_get_translation("menu_remember"))/2, scr_get_translation("menu_remember"));

	draw_set_alpha(0.5);

	if(string_length(obj_openingScreen.inputText) > 0 ){
		obj_openingScreen.clickedIn = true;
	}

	if(string_length(obj_openingScreen.inputText) == 0 and obj_openingScreen.clickedIn == false){
		scr_adaptFont(scr_get_translation("msg_signin"),"M");
		draw_text(mean(userSignInBoxX1, userSignInBoxX2), mean(userSignInBoxY1, userSignInBoxY2), scr_get_translation("msg_signin"));
	}
	draw_set_alpha(1);
	var rememberMeButtonWidth = camHeight*0.02;

	var remeberMeBoxX1 = mean(userSignInBoxX1, userSignInBoxX2) - string_width(scr_get_translation("menu_remember"))/2 - stringBuffer - rememberMeButtonWidth;
	var remeberMeBoxY1 = userSignInBoxY2 + string_height(scr_get_translation("menu_remember"))/2 - rememberMeButtonWidth/2;
	var remeberMeBoxX2 = remeberMeBoxX1 + rememberMeButtonWidth;
	var remeberMeBoxY2 = remeberMeBoxY1 + rememberMeButtonWidth;


	draw_rectangle(remeberMeBoxX1, remeberMeBoxY1, remeberMeBoxX2,remeberMeBoxY2, true);
	if (global.rememberMe) {
		draw_rectangle(remeberMeBoxX1, remeberMeBoxY1, remeberMeBoxX2, remeberMeBoxY2, false);	
	}

	if (point_in_rectangle(mouse_x, mouse_y,userSignInBoxX1, userSignInBoxY1, userSignInBoxX2, userSignInBoxY2)){
			if (device_mouse_check_button_released(0, mb_left)) {
				obj_openingScreen.clickedIn = true;
			}
	}

	// current chain boolean switch
	else if (point_in_rectangle(mouse_x, mouse_y,remeberMeBoxX1, remeberMeBoxY1, remeberMeBoxX2, remeberMeBoxY2)){
			if (device_mouse_check_button_released(0, mb_left)) {
				global.rememberMe = !global.rememberMe;	
			}
	}
	else {
		if (device_mouse_check_button_released(0, mb_left)) {
			obj_openingScreen.clickedIn = false;
		}
	}
	



/*
	//localization font selection
		var changeLanguageButtonWidth = max(200, string_width(" Save Import Schema "));
		var changeLanguageButtonHeight = 30;
		var changeLanguageButtonRectX2 = (camera_get_view_width(camera_get_active()) - 25);
		var changeLanguageButtonRectX1 = changeLanguageButtonRectX2 - changeLanguageButtonWidth;
		var changeLanguageButtonRectY2 = (camera_get_view_height(camera_get_active()) - 25);
		var changeLanguageButtonRectY1 = changeLanguageButtonRectY2 - changeLanguageButtonHeight;


	
		if (point_in_rectangle(mouse_x, mouse_y, changeLanguageButtonRectX1, changeLanguageButtonRectY1, changeLanguageButtonRectX2, changeLanguageButtonRectY2)) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(changeLanguageButtonRectX1, changeLanguageButtonRectY1, changeLanguageButtonRectX2, changeLanguageButtonRectY2, false);
	
			if (mouse_check_button_pressed(mb_left)) {
			var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "menu_language-en", "menu_language-it", "menu_language-es", "menu_language-he", "menu_language-vi", "menu_language-ja", "menu_language-zh");
				scr_createDropDown(changeLanguageButtonRectX1,changeLanguageButtonRectY1, dropDownOptionList, global.optionListTypeLanguage);
			}
		}
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(changeLanguageButtonRectX1, changeLanguageButtonRectY1, changeLanguageButtonRectX2, changeLanguageButtonRectY2, true);


		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeText);
		var currentLanguageString = "menu_language-"+string(global.lang_codes[| global.lang_index]);
		scr_adaptFont(scr_get_translation(currentLanguageString),"M");
		draw_text(floor(mean(changeLanguageButtonRectX1, changeLanguageButtonRectX2)), floor(mean(changeLanguageButtonRectY1, changeLanguageButtonRectY2)), scr_get_translation(currentLanguageString));
*/

	if(global.menuOpen){
		//code for keyboard input into user sign in
		// Variables
		var ctext = "";
		// Clipboard
		if(global.ctrlHold && keyboard_check(ord("V")) && clipboard_has_text()) {
			ctext = clipboard_get_text();
		}
		if(ctext!="" && (keyboard_check_pressed(ord("V")) || global.ctrlHold)) { 
			obj_openingScreen.inputText = string_insert(ctext, obj_openingScreen.inputText, obj_openingScreen.cursorPos);
			obj_openingScreen.cursorPos += string_length(ctext);
		}

		// Backspace
		if (keyboard_check(vk_backspace)) {
			obj_openingScreen.cursorViz = true;
			if(canDelete){
				obj_openingScreen.inputText = string_delete(obj_openingScreen.inputText, obj_openingScreen.cursorPos-1, 1);
				if (obj_openingScreen.cursorPos >=2) {
					obj_openingScreen.cursorPos--;
				}
				else {
					obj_openingScreen.cursorPos = 2;
				}
				canDelete = false;
			}
			canDeleteHoldingCounter++
			if(canDeleteHoldingCounter == holdingLimit){
				canDelete = true;
				loopItterations ++;
				canDeleteHoldingCounter = 0;
			}
			if(string_length(obj_openingScreen.inputText) == 0 ){
				obj_openingScreen.clickedIn = false;
			}
		}
		if (keyboard_check_released(vk_backspace)) {
		loopItterations = 0;
		canDeleteHoldingCounter = 0;
		canDelete = true;
		}
	
		if (global.menuOpen  && keyboard_string != "-" && keyboard_string != "+" && string_length(obj_openingScreen.inputText) < 30 ) {
			//show_message(keyboard_string);
			var t = keyboard_string;
			obj_openingScreen.inputText = string_insert(t, obj_openingScreen.inputText, obj_openingScreen.cursorPos);
			obj_openingScreen.cursorPos += string_length(t);
			keyboard_string = "";
			obj_openingScreen.cursorViz = true;
			obj_openingScreen.cursorTimer = 20;
		}

		// Cursor
		if(keyboard_check(vk_left)) {
			obj_openingScreen.cursorViz = true;
			if(canPressLeft){
				if (obj_openingScreen.cursorPos >=2) {
					obj_openingScreen.cursorPos--;
				}
				else {
					obj_openingScreen.cursorPos = 1;
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
			obj_openingScreen.cursorViz = true;
			if(canPressRight){
				if (obj_openingScreen.cursorPos <= string_length(obj_openingScreen.inputText) + 1 && obj_openingScreen.cursorPos >=1){
					//show_message("buh");
					obj_openingScreen.cursorPos++;
				}
				else {
					obj_openingScreen.cursorPos = string_length(obj_openingScreen.inputText) +1;
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
	
	

		clamp(obj_openingScreen.cursorPos, 1, string_length(obj_openingScreen.inputText));

		displayText = obj_openingScreen.inputText;
		if(string_width(obj_openingScreen.inputText) > obj_openingScreen.maxDisplaySize){
			displayText = string_copy(obj_openingScreen.inputText, (string_length(obj_openingScreen.inputText) - maxDisplaySize), string_length(obj_openingScreen.inputText) );
		}

		if (obj_openingScreen.cursorTimer >=0){
			obj_openingScreen.cursorTimer --;
		}
		else{
			obj_openingScreen.cursorViz = !obj_openingScreen.cursorViz;
			obj_openingScreen.cursorTimer =30;
		}



		if(obj_openingScreen.cursorViz and obj_openingScreen.clickedIn == true){
			displayText = string_insert("|", displayText, obj_openingScreen.cursorPos);
		}
		else{
			displayText = string_delete(displayText, obj_openingScreen.cursorPos, 0);
		}

		draw_set_halign(fa_middle);
		scr_adaptFont(displayText,"M");
		draw_text(mean(userSignInBoxX1, userSignInBoxX2), mean(userSignInBoxY1,userSignInBoxY2) , displayText);
	
		global.userName = obj_openingScreen.inputText;
	}
	
	
	
	// draw "get started" text
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("menu_import"),"L", true);
	draw_set_color(global.colorThemeText);
	draw_text(openProjectButtonX1, openProjectButtonY1 - string_height("0"),  "Get Started");
	
	
	
	// make button colors fade on mouseover
	var mergeColorRate = 0.1;
	hoverColorMergeOpen += (mouseOverOpen) ? mergeColorRate : -mergeColorRate;
	hoverColorMergeImport += (mouseOverImport) ? mergeColorRate : -mergeColorRate;
	hoverColorMergeHelp += (mouseoverDocumenation) ? mergeColorRate : -mergeColorRate;
	hoverColorMergeOpen = clamp(hoverColorMergeOpen, 0, 1);
	hoverColorMergeImport = clamp(hoverColorMergeImport, 0, 1);
	hoverColorMergeHelp = clamp(hoverColorMergeHelp, 0, 1);

}
