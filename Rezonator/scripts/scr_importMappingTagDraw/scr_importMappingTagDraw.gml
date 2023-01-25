function scr_importMappingTagDraw() {

	
	scr_fontSizeControlOpeningScreen();

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());


	// Import Screen Title
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("msg_import_file_map"), "L");
	draw_text(camWidth/2, camHeight*0.025 , scr_get_translation(filename_name(global.importFilename)));



	// File window
	var xBuffer = 40;
	var yBuffer = (camHeight / 2) - 180;


	var tagGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var j = 0 ; j < 2; j++) {
		for (var i = 0 ; i < tagGridHeight; i++ ) {
			if ( j == 0 ) {	
				var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colKey, i);
				if (cutTest == "option_display-token") {
					obj_importMapping.canContinueDisplayToken = true;
					i = tagGridHeight;
				}
				else{
					obj_importMapping.canContinueDisplayToken = false;
				}
			}
		}
	}
	
	// check all the errors that need to be solved, depending on import type
	if (global.importType == global.importType_IGT) {
		canContinueAll = (canContinueDisplayToken && canContinueToken1to1 && canContinueWordDelimiter && canContinueWord1to1);
	}
	else if (global.importType == global.importType_CoNLLU || global.importType == global.importType_CSV) {
		canContinueAll = (canContinueDisplayToken && canContinueUnit);
	}
	else {
		canContinueAll = canContinueDisplayToken;
	}
	
	
	// Continue button
	var continueButtonWidth = camWidth / 6;
	var continueButtonHeight = camHeight / 20;
	var continueButtonRectX1 = obj_fieldSummaryWindow.fieldSummaryWindowX2 - continueButtonWidth;
	var continueButtonRectY1 = mean(obj_importMappingTagInfo.tagInfoWindowRectY2, camHeight) - (continueButtonHeight / 2);
	var continueButtonRectX2 = continueButtonRectX1 + continueButtonWidth;
	var continueButtonRectY2 = continueButtonRectY1 + continueButtonHeight;
	var mouseOverContinue = point_in_rectangle(mouse_x, mouse_y, continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2);

	draw_set_color(global.colorThemeBG);
	draw_roundrect(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, false);
	draw_set_color(global.colorThemeSelected2);
	draw_roundrect(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);
	draw_set_halign(fa_center);
	draw_set_color(global.colorThemeText);
	scr_adaptFont(scr_get_translation("msg_continue"),"M");
	draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), scr_get_translation("msg_continue"));
	

		
		
	//if (canContinueAll or global.tabDeliniatedText) {
	if (canContinueAll) {
		
		draw_set_alpha(1);
		draw_set_color(mouseOverContinue ? merge_color(global.colorThemeSelected1, global.colorThemeRezPink, 50)  : global.colorThemeRezPink);
		draw_roundrect(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, false);
		draw_set_color(global.colorThemeRezPink);
		draw_roundrect(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);
	
		draw_set_color(global.colorThemeBG);
		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeBG);
		scr_adaptFont(scr_get_translation("msg_continue"),"M");
		draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), scr_get_translation("msg_continue"));
	
		if (mouseOverContinue) {

	
			if (mouse_check_button_released(mb_left) && !continueButtonClicked) {
				
				continueButtonClicked = true;
				var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
				instLoading.loadSprite = spr_loading;
				scr_setSpecialFieldsVariables();
				scr_storeSchemaLists();
				scr_fillFieldLevelMap();
				scr_sortElan();
				show_debug_message("Continue button clicked... " + scr_printTime());
			
				alarm[3] = 1;
			}
		}
		
	}
	else {
	
		var errorMessage = "";
		if (!obj_importMapping.canContinueDisplayToken) {
			errorMessage = "Please select a field to be the Display Token using the Key section.";
		}
		else if (!obj_importMapping.canContinueToken1to1) {
			errorMessage = "Token fields do not align 1-to-1 with Display Token.";
		}
		else if (!obj_importMapping.canContinueWordDelimiter) {
			errorMessage = "Please select a field to be the Word Delimiter using the Key section.";
		}
		else if (!obj_importMapping.canContinueWord1to1) {
			errorMessage = "Word fields do not align 1-to-1 with Word Delimiter.";
		}
		else if (!obj_importMapping.canContinueUnit) {
			errorMessage = "Please select a field to be the Unit Delimiter using the Key section.";
		}
		
		var errorTextX = floor(camWidth / 2);
		var errorTextY = floor(mean(obj_importMappingTagInfo.tagInfoWindowRectY2, camHeight));

	

		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(errorMessage,"M");
		draw_text(errorTextX, errorTextY, errorMessage);
	}


	// back button
	var backButtonWidth = continueButtonWidth;
	var backButtonHeight = continueButtonHeight;
	var backButtonRectX1 = obj_importMappingTagInfo.tagInfoWindowRectX1;
	var backButtonRectY1 = continueButtonRectY1;
	var backButtonRectX2 = backButtonRectX1 + backButtonWidth;
	var backButtonRectY2 = continueButtonRectY2;

	var mouseOverBack = point_in_rectangle(mouse_x, mouse_y, backButtonRectX1, backButtonRectY1, backButtonRectX2, backButtonRectY2);
	
	draw_set_alpha(1);
	draw_set_color(mouseOverBack ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_roundrect(backButtonRectX1, backButtonRectY1, backButtonRectX2, backButtonRectY2, false);
	draw_set_color(global.colorThemeRezPink);
	draw_roundrect(backButtonRectX1, backButtonRectY1, backButtonRectX2, backButtonRectY2, true);
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("msg_continue"), "M");
	draw_text(floor(mean(backButtonRectX1, backButtonRectX2)), floor(mean(backButtonRectY1, backButtonRectY2)), scr_get_translation("label_back"));
	
	// click on back button
	if (mouseOverBack && mouse_check_button_released(mb_left) && canGoBack) {		
		global.newProject = false;
		global.openProject = false;
		global.neworOpen = true;
		show_debug_message("Going to openingScreen, scr_importMappingTagDraw");
		room_goto(rm_openingScreen)

	}





	draw_set_color(global.colorThemeText);

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("menu_import_fields"),"L");
	draw_text(floor(xBuffer), floor(yBuffer + 50), scr_get_translation("menu_import_fields"));

	var buttonBuffer = 20;


	// if this is an importGroup, load the schema file automatically and then goto main screen
	if (global.importGroupSchemaFile != "" && !importGroupSchemaLoaded) {
		scr_loadSchema(false);
		importGroupSchemaLoaded = true;

		var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
		instLoading.loadSprite = spr_loading;
		scr_setSpecialFieldsVariables();
		scr_fillFieldLevelMap();
		scr_storeSchemaLists();
	
		alarm[2] = 3;
	}


	if (!obj_importMapping.updatedErrorCol) {
		with (obj_importMapping) {
			alarm[4] = 2;
			updatedErrorCol = true;
		}
	}

}
