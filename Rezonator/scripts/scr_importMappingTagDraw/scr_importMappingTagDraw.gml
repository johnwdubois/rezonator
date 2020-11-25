function scr_importMappingTagDraw() {
	

	scr_fontSizeControlOpeningScreen();

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());


	// Import Screen Title
	draw_set_color(global.colorThemeText);
	draw_set_font(global.fontMainBold);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(20 + sprite_get_width(spr_backArrow), 20, scr_get_translation("msg_import_file_map"));



	// File window
	var xBuffer = 40;
	var yBuffer = (camHeight / 2) - 180;


	/*



	// Summary window
	var summaryInfoWindowRectX1 = (camWidth / 3) + 20;
	var summaryInfoWindowRectY1 = 80 + string_height("0");
	var summaryInfoWindowRectX2 = (camWidth * 0.666) - 20;
	var summaryInfoWindowRectY2 = (camHeight / 2) - 180;

	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(summaryInfoWindowRectX1, summaryInfoWindowRectY1, summaryInfoWindowRectX2, summaryInfoWindowRectY2, true);
	draw_set_color(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(summaryInfoWindowRectX1, summaryInfoWindowRectY1 - string_height("0"), "Summary");


	*/
	var tagGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var j = 0 ; j < 2; j++){

		for (var i = 0 ; i < tagGridHeight; i++ ){
			if( j == 0 ){	
				var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
				if(cutTest == "Display Token"){
					obj_importMapping.canContinueDisplayToken = true;
					i = tagGridHeight;
				}
				else{
					obj_importMapping.canContinueDisplayToken = false;
				}
			}
			else{
				var cutTest = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
				if(cutTest == "Speaker"){
					obj_importMapping.canContinueUnit = true;
					i = tagGridHeight;
				}
				else{
					obj_importMapping.canContinueUnit = false;
				}
			}
		}

	}
	
	if (global.importType == global.importType_IGT) {
		canContinueAll = (canContinueDisplayToken && canContinueToken1to1 && canContinueWordDelimiter && canContinueWord1to1);
	}
	else {
		canContinueAll = canContinueDisplayToken;
	}

	//if (canContinueAll or global.tabDeliniatedText) {
	if (canContinueAll) {

		var continueButtonWidth = 150;
		var continueButtonHeight = 40;
		var continueButtonRectX1 = (camWidth / 2) - (continueButtonWidth / 2);
		var continueButtonRectY1 = (camHeight - continueButtonHeight - 20) - (continueButtonHeight / 2);
		var continueButtonRectX2 = continueButtonRectX1 + continueButtonWidth;
		var continueButtonRectY2 = continueButtonRectY1 + continueButtonHeight;
	
		// Continue button
		if (point_in_rectangle(mouse_x, mouse_y, continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2)) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, false);
	
			if (mouse_check_button_released(mb_left) && !continueButtonClicked) {
			
				continueButtonClicked = true;
				var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
				instLoading.loadSprite = spr_loading;
				scr_setSpecialFieldsVariables();
				scr_storeSchemaLists();
				scr_fillFieldLevelMap();
				show_debug_message("Continue button clicked... " + scr_printTime());
			
				alarm[3] = 1;
			}
		}
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(continueButtonRectX1, continueButtonRectY1, continueButtonRectX2, continueButtonRectY2, true);

		draw_set_font(global.fontMain);
		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeText);
		draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), scr_get_translation("msg_continue"));

	}
	else {
		var continueButtonWidth = 150;
		var continueButtonHeight = 40;
		var continueButtonRectX1 = (camWidth / 2) - (continueButtonWidth / 2);
		var continueButtonRectY1 = (camHeight - continueButtonHeight - 20) - (continueButtonHeight / 2);
		var continueButtonRectX2 = continueButtonRectX1 + continueButtonWidth;
		var continueButtonRectY2 = continueButtonRectY1 + continueButtonHeight;
		
		var errorMessage = "";
		if (!obj_importMapping.canContinueDisplayToken) {
			errorMessage = "Please select a field to be the Display Token using the Special Fields section.";
		}
		else if (!obj_importMapping.canContinueToken1to1) {
			errorMessage = "Token fields do not align 1-to-1 with Display Token.";
		}
		else if (!obj_importMapping.canContinueWordDelimiter) {
			errorMessage = "Please select a field to be the Word Delimiter using the Special Fields section.";
		}
		else if (!obj_importMapping.canContinueWord1to1) {
			errorMessage = "Word fields do not align 1-to-1 with Word Delimiter.";
		}
	
		draw_set_font(global.fontMain);
		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeText);
		draw_text(mean(continueButtonRectX1, continueButtonRectX2), mean(continueButtonRectY1, continueButtonRectY2), errorMessage);
	}


	draw_set_color(global.colorThemeText);
	draw_set_font(global.fontMainBold);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(floor(xBuffer), floor(yBuffer + 50), scr_get_translation("menu_import_fields"));

	var buttonBuffer = 20;


	var loadPreviousButtonWidth = max(200, string_width(" Use Last Import Schema "));
	var loadPreviousButtonHeight = 30;
	var loadPreviousButtonRectX1 = xBuffer + string_width("ImportFields    ");
	var loadPreviousButtonRectY1 = yBuffer + 50 - (loadPreviousButtonHeight / 2);
	var loadPreviousButtonRectX2 = loadPreviousButtonRectX1 + loadPreviousButtonWidth;
	var loadPreviousButtonRectY2 = loadPreviousButtonRectY1 + loadPreviousButtonHeight;
	
	// load preivous
	if (point_in_rectangle(mouse_x, mouse_y, loadPreviousButtonRectX1, loadPreviousButtonRectY1, loadPreviousButtonRectX2, loadPreviousButtonRectY2)) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(loadPreviousButtonRectX1, loadPreviousButtonRectY1, loadPreviousButtonRectX2, loadPreviousButtonRectY2, false);
	
		if (mouse_check_button_pressed(mb_left)) {
			
			scr_updateSchemaLists();

			if (global.importType == global.importType_IGT) {
				var displayTokenRow = ds_grid_value_y(global.tagInfoGrid,global.tagInfoGrid_colSpecialFields,0,global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Display Token");
				var wordDelimRow = ds_grid_value_y(global.tagInfoGrid,global.tagInfoGrid_colSpecialFields,0,global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Word Delimiter");
			
				if(wordDelimRow != -1){
					obj_importMapping.wordDelimMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, wordDelimRow);
					var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker)-2;
					var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
					obj_importMapping.currentWordThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
				}
				if(displayTokenRow != -1){
				
					obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
					var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
					var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
					obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
				}
				obj_importMapping.updatedErrorCol = false;
			}
		}
	}
	
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(loadPreviousButtonRectX1, loadPreviousButtonRectY1, loadPreviousButtonRectX2, loadPreviousButtonRectY2, true);

	draw_set_font(global.fontMain);
	draw_set_halign(fa_center);
	draw_set_color(global.colorThemeText);
	draw_text(floor(mean(loadPreviousButtonRectX1, loadPreviousButtonRectX2)), floor(mean(loadPreviousButtonRectY1, loadPreviousButtonRectY2)), scr_get_translation("msg_last-schema"));




	var loadSchemaButtonWidth = max(200, string_width(" Load Import Schema "));
	var loadSchemaButtonHeight = 30;
	var loadSchemaButtonRectX1 = loadPreviousButtonRectX2 + buttonBuffer;
	var loadSchemaButtonRectY1 = loadPreviousButtonRectY1;
	var loadSchemaButtonRectX2 = loadSchemaButtonRectX1 + loadSchemaButtonWidth;
	var loadSchemaButtonRectY2 = loadSchemaButtonRectY1 + loadSchemaButtonHeight;


	// Load from File
	if (point_in_rectangle(mouse_x, mouse_y, loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2)) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2, false);
	
		if (mouse_check_button_pressed(mb_left)) {
			
			scr_loadSchema(false);
	
			if (global.importType == global.importType_IGT) {
				var displayTokenRow = ds_grid_value_y(global.tagInfoGrid,global.tagInfoGrid_colSpecialFields,0,global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Display Token");
				var wordDelimRow = ds_grid_value_y(global.tagInfoGrid,global.tagInfoGrid_colSpecialFields,0,global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "Word Delimiter");
			
				if (wordDelimRow != -1) {
					obj_importMapping.wordDelimMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, wordDelimRow);
					var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.wordDelimMarker)-2;
					var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
					obj_importMapping.currentWordThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
				}
				if (displayTokenRow != -1) {	
			
					obj_importMapping.displayMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
					var indexForHelper = ds_list_find_index(global.importGridColNameList, obj_importMapping.displayMarker)-2;
					var currentMarkerCount = ds_grid_get(global.fieldRelationHelperGrid,indexForHelper,indexForHelper);
					obj_importMapping.currentTokenThreshold = (currentMarkerCount * obj_importMapping.tokenRatio);
				}
			}
			obj_importMapping.updatedErrorCol = false;
		}
	}

	// if this is an importGroup, load the schema file automatically and then goto main screen
	if (global.importGroupSchemaFile != "" && !importGroupSchemaLoaded) {
		scr_loadSchema(false);
		importGroupSchemaLoaded = true;

		var instLoading = instance_create_layer(0, 0, "InstanceLoading", obj_loadingScreen);
		instLoading.loadSprite = spr_loading;
		scr_setSpecialFieldsVariables();
		scr_storeSchemaLists();
	
		alarm[2] = 3;
	}
	
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2, true);

	draw_set_font(global.fontMain);
	draw_set_halign(fa_center);
	draw_set_color(global.colorThemeText);
	draw_text(floor(mean(loadSchemaButtonRectX1, loadSchemaButtonRectX2)), floor(mean(loadSchemaButtonRectY1, loadSchemaButtonRectY2)), scr_get_translation("msg_load-schema"));
	
	
	// only draw the Save Schema button if there are no errors in the user's level mapping
	if (obj_importMapping.canContinueAll) {

		var saveSchemaButtonWidth = max(200, string_width(" Save Import Schema "));
		var saveSchemaButtonHeight = 30;
		var saveSchemaButtonRectX1 = loadSchemaButtonRectX2 + buttonBuffer;
		var saveSchemaButtonRectY1 = loadPreviousButtonRectY1;
		var saveSchemaButtonRectX2 = saveSchemaButtonRectX1 + saveSchemaButtonWidth;
		var saveSchemaButtonRectY2 = saveSchemaButtonRectY1 + saveSchemaButtonHeight;


		// Save to File
		if (point_in_rectangle(mouse_x, mouse_y, saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2)) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2, false);
	
			if (mouse_check_button_pressed(mb_left)) {
		
				//populates lists with current display
				scr_storeSchemaLists();
		
				// User will specify a name and a location for the sch file 
				scr_saveSchema();
			}
		}
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2, true);

		draw_set_font(global.fontMain);
		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeText);
		draw_text(floor(mean(saveSchemaButtonRectX1, saveSchemaButtonRectX2)), floor(mean(saveSchemaButtonRectY1, saveSchemaButtonRectY2)), scr_get_translation("msg_save-schema"));
	}
	
	// if in IGT allow user to sitch grids
	if( global.importType == global.importType_IGT){
	
		var changeGridButtonWidth = max(200, string_width(" Save Import Schema "));
		var changeGridButtonHeight = 30;
		var changeGridButtonRectX2 = (camWidth) - 50;
		var changeGridButtonRectX1 = changeGridButtonRectX2 - changeGridButtonWidth;
		var changeGridButtonRectY1 = loadPreviousButtonRectY1;
		var changeGridButtonRectY2 = changeGridButtonRectY1 + changeGridButtonHeight;


	
		if (point_in_rectangle(mouse_x, mouse_y, changeGridButtonRectX1, changeGridButtonRectY1, changeGridButtonRectX2, changeGridButtonRectY2)) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(changeGridButtonRectX1, changeGridButtonRectY1, changeGridButtonRectX2, changeGridButtonRectY2, false);
	
			if (mouse_check_button_pressed(mb_left)) {
			
				scr_createDropDown(changeGridButtonRectX1,changeGridButtonRectY2,gridList, global.optionListTypeImportGrid);
			}
		}
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(changeGridButtonRectX1, changeGridButtonRectY1, changeGridButtonRectX2, changeGridButtonRectY2, true);

		draw_set_font(global.fontMain);
		draw_set_halign(fa_center);
		draw_set_color(global.colorThemeText);
		draw_text(floor(mean(changeGridButtonRectX1, changeGridButtonRectX2)), floor(mean(changeGridButtonRectY1, changeGridButtonRectY2)), string(obj_importMapping.currentGridName));

	}

	if (tagGridHeight == 1) {
		room_goto(rm_mainScreen)
	}
	
	if (!obj_importMapping.updatedErrorCol) {
		with (obj_importMapping) {
			alarm[4] = 2;
			updatedErrorCol = true;
		}
	}

}
