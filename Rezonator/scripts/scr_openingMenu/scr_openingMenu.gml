function scr_openingMenu() {

	scr_fontSizeControlOpeningScreen();
	

	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);


	var middleBuffer = 115;
	var verticalYSpacing = 20;

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	draw_set_color(merge_color(global.colorThemeSelected1, c_white, .4));
	draw_rectangle(0, 0, camWidth, camHeight, false);

	var buttonWidth = (camWidth*.8) /3;
	var buttonHeight = (camHeight*.2);
	var spriteScale = 0.8;
	
	var mouseoverCancel = instance_exists(obj_dialogueBox) or instance_exists(obj_dropDown) or instance_exists(obj_loadingBar) || instance_exists(obj_sizeWindow);
	
	
	
	// open rez selection
	var openProjectButtonX1 = (camWidth * 0.10); 
	var openProjectButtonY1 = camHeight * 0.4;
	var openProjectButtonX2 = openProjectButtonX1 + buttonWidth;
	var openProjectButtonY2 = openProjectButtonY1 + buttonHeight;
	var mouseOverOpen = point_in_rectangle(mouse_x, mouse_y, openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2) && !mouseoverCancel;
	var _selectOpenButton = false;
	if (mouseOverOpen) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, false);
	
		if (device_mouse_check_button_released(0, mb_left)) {
			_selectOpenButton = true;
		}
	}
	
	// altnerately users can select the Open option from the menu bar
	if (selectOpenButton) {
		selectOpenButton = false;
		_selectOpenButton = true;
	}
	
	// if opening an html5 rez file, we just need the filename string
	if (BUILDTYPE == "Web" && is_string(global.html5RezFile) && global.html5RezFile != "") {
		_selectOpenButton = true;
	}
	
	// if the user clicks the open button (or has used the Open option from the menu bar)
	if (_selectOpenButton) {
		if (BUILDTYPE == "Web" && (!is_string(global.html5RezFile) || global.html5RezFile == "")) {
			scr_createDropDown(mouse_x, mouse_y, scr_getSBClist(), global.optionListTypeHTML5REZFile);
		}
		else {
			global.project = "open";
			global.userName = obj_openingScreen.inputText == "" ? "Unknown" : obj_openingScreen.inputText;
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
	draw_sprite_ext(spr_openingMenuOpen, min(global.fontSize, sprite_get_number(spr_openingMenuOpen) - 1), mean(openProjectButtonX1,openProjectButtonX2), openProjectButtonY1 + (openProjectButtonY2 - openProjectButtonY1) * 0.38, spriteScale, spriteScale, 0, merge_color(global.colorThemeRezPurple, global.colorThemeBG, hoverColorMergeOpen), 1);
	scr_adaptFont(scr_get_translation("menu_import"), "L", true);
	draw_text(floor(mean(openProjectButtonX1, openProjectButtonX2)), openProjectButtonY1 + (openProjectButtonY2 - openProjectButtonY1)*.8, scr_get_translation("help_label_open"));
	






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
			if (BUILDTYPE == "Web") {
				show_message("Import is currently not available for browser use.")
			}
			else {
				global.project = "import";
				global.userName = obj_openingScreen.inputText == "" ? "Unknown" : obj_openingScreen.inputText;
			}
		}
	}
	
	// draw import button
	draw_set_color(merge_color(global.colorThemeBG, global.colorThemeRezPurple, hoverColorMergeImport));
	draw_roundrect(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, false);
	draw_set_color(global.colorThemeRezPurple);
	draw_roundrect(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, true);
	
	// import button sprite & text
	draw_set_color(mouseOverImport ? global.colorThemeBG : global.colorThemeText);
	draw_sprite_ext(spr_openingMenuImport, min(global.fontSize, sprite_get_number(spr_openingMenuImport) - 1), mean(newProjectButtonX1,newProjectButtonX2), newProjectButtonY1 + (newProjectButtonY2 - newProjectButtonY1) * 0.38, spriteScale, spriteScale, 0, merge_color(global.colorThemeRezPurple, global.colorThemeBG, hoverColorMergeImport), 1);
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
	draw_sprite_ext(spr_openingMenuDoc, min(global.fontSize, sprite_get_number(spr_openingMenuDoc) - 1), mean(documentationButtonX1, documentationButtonX2), documentationButtonY1 + (documentationButtonY2 - documentationButtonY1) * 0.38, spriteScale, spriteScale, 0, merge_color(global.colorThemeRezPurple, global.colorThemeBG, hoverColorMergeHelp), 1);
	scr_adaptFont(scr_get_translation("menu_import"),"L", true);
	draw_text(floor(mean(documentationButtonX1, documentationButtonX2)), documentationButtonY1 + (documentationButtonY2 - documentationButtonY1)*.8, documentationStr);

	if (mouseoverDocumenation && documentationButtonActive) {
		if (mouse_check_button_released(mb_left)) {
			scr_URLOpenReliable("https://johnwdubois.github.io/rezonator/");
		}
	}



	var spaceWidth = string_width(" ");
	var stringBuffer = spaceWidth * 3;
	var signInXBuffer = 20;
	var signInYBuffer = 25;
	var signInText = scr_get_translation("msg_signin")
	scr_adaptFont(signInText,"M");
	var stringWidth = string_width(signInText);
	var stringHeight = string_height(signInText);
	var userSignInBoxX2 = camWidth * 0.95 ;	
	var userSignInBoxY1 = camHeight * 0.85;
	var userSignInBoxX1 = userSignInBoxX2 - stringWidth - stringBuffer*2 ;
	var userSignInBoxY2 = userSignInBoxY1 + stringHeight * 1.5;


	



	if (string_length(obj_openingScreen.inputText) > 0) {
		obj_openingScreen.clickedIn = true;
	}


	
	var rememberMeButtonWidth = stringHeight;
	var rememberMeBoxX1 = userSignInBoxX1;
	var rememberMeBoxY1 = userSignInBoxY2 + (stringHeight * 0.75);
	var rememberMeBoxX2 = rememberMeBoxX1 + rememberMeButtonWidth;
	var rememberMeBoxY2 = rememberMeBoxY1 + rememberMeButtonWidth;
	var mouseoverRememberMeBox = point_in_rectangle(mouse_x, mouse_y,rememberMeBoxX1, rememberMeBoxY1, rememberMeBoxX2, rememberMeBoxY2) && BUILDTYPE != "Web";
	
	if (BUILDTYPE != "Web") {
		draw_set_color(global.colorThemeText);
		draw_rectangle(rememberMeBoxX1, rememberMeBoxY1, rememberMeBoxX2, rememberMeBoxY2, true);
	
		draw_set_halign(fa_left);
		draw_text(rememberMeBoxX2 + spaceWidth, floor(mean(rememberMeBoxY1, rememberMeBoxY2)), scr_get_translation("menu_remember"));
		
		if (global.rememberMe) {
			var checkScale = 0.6;
			if (camWidth > 2000) checkScale = 1;
			draw_sprite_ext(spr_checkmark, 0, floor(mean(rememberMeBoxX1, rememberMeBoxX2)), floor(mean(rememberMeBoxY1, rememberMeBoxY2)), checkScale, checkScale, 0, global.colorThemeBorders, 1);
		}
	}

	


	if (point_in_rectangle(mouse_x, mouse_y, userSignInBoxX1, userSignInBoxY1, userSignInBoxX2, userSignInBoxY2)) {
		if (device_mouse_check_button_released(0, mb_left)) {
			obj_openingScreen.clickedIn = true;
		}
	}
	else if (mouseoverRememberMeBox) {
		if (device_mouse_check_button_released(0, mb_left)) {
			global.rememberMe = !global.rememberMe;	
		}
	}
	else {
		if (device_mouse_check_button_released(0, mb_left)) {
			obj_openingScreen.clickedIn = false;
		}
	}
	




	if (instance_exists(obj_inputBox)) {
		obj_inputBox.textBoxX = userSignInBoxX1;
		obj_inputBox.textBoxY = userSignInBoxY1;
		obj_inputBox.windowWidth = userSignInBoxX2 - userSignInBoxX1;
		obj_inputBox.windowHeight = userSignInBoxY2 - userSignInBoxY1;
		obj_openingScreen.inputText = obj_inputBox.str;
	}
	else {
		var instUserSignIn = instance_create_layer(0, 0, "InstancesInput", obj_inputBox);
		with (instUserSignIn) {
			inputPrompt = "msg_signin";
		}
	}

	
	
	
	
	
	// draw "get started" text
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("menu_import"),"L", true);
	draw_set_color(global.colorThemeText);
	draw_text(openProjectButtonX1, openProjectButtonY1 - string_height("0"),  scr_get_translation("option_get-started"));
	
	
	
	// make button colors fade on mouseover
	var mergeColorRate = 0.1;
	hoverColorMergeOpen += (mouseOverOpen) ? mergeColorRate : -mergeColorRate;
	hoverColorMergeImport += (mouseOverImport) ? mergeColorRate : -mergeColorRate;
	hoverColorMergeHelp += (mouseoverDocumenation) ? mergeColorRate : -mergeColorRate;
	hoverColorMergeOpen = clamp(hoverColorMergeOpen, 0, 1);
	hoverColorMergeImport = clamp(hoverColorMergeImport, 0, 1);
	hoverColorMergeHelp = clamp(hoverColorMergeHelp, 0, 1);

}
