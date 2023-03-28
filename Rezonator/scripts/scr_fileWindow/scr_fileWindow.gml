function scr_fileWindow() {

		
	var stringHeight = string_height("0");
	var filename = filename_name(global.importFilename);
	var lineCount = ds_grid_height(global.importTXTLineGrid);
	var blockCount = ds_grid_height(global.blockGrid);
	var blockTypes = ds_grid_height(global.blockTypeGrid);
	var tokenCount = global.tokenCountTotal;
	var fieldCount = ds_grid_height(global.tagInfoGrid);
	
	if (global.importType == IMPORTTYPE_WORD) {
		lineCount = ds_grid_height(global.importCSVGrid);
		global.tokenCountTotal = lineCount;
		tokenCount = global.tokenCountTotal;
	}
	else if (global.importType == IMPORTTYPE_IGT) {
		fieldCount -= 2;
	}
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var textX = fileInfoWindowRectX1 + stringHeight;
	var fileTextY = fileInfoWindowRectY1 + stringHeight;
	var schemaTextY = fileInfoWindowRectY1 + stringHeight*2.5;
	scr_adaptFont(scr_get_translation("label_user_file_name"), "M");
	draw_text(textX - clipX, fileTextY - clipY, scr_get_translation("label_user_file_name") + string(filename));
	
	var schemaText = scr_get_translation("Schema: ") + string(global.schemaFileName);
	draw_text(textX - clipX, schemaTextY - clipY, schemaText);
	
	

	var loadSchemaButtonWidth = sprite_get_width(spr_dropDown);
	var loadSchemaButtonHeight = loadSchemaButtonWidth;
	var loadSchemaButtonRectX1 = textX +  string_width(schemaText) + loadSchemaButtonWidth;
	var loadSchemaButtonRectY1 = schemaTextY - loadSchemaButtonWidth/2;
	var loadSchemaButtonRectX2 = loadSchemaButtonRectX1 + loadSchemaButtonWidth;
	var loadSchemaButtonRectY2 = loadSchemaButtonRectY1 + loadSchemaButtonHeight;
	var mouseoverLoadSchema = point_in_rectangle(mouse_x, mouse_y, loadSchemaButtonRectX1, loadSchemaButtonRectY1, loadSchemaButtonRectX2, loadSchemaButtonRectY2);

	draw_sprite_ext(spr_dropDown, 0, floor(mean(loadSchemaButtonRectX1, loadSchemaButtonRectX2)) - clipX, floor(mean(loadSchemaButtonRectY1, loadSchemaButtonRectY2)) - clipY, 1, 1, 0, global.colorThemeText, 1);

	// Load from File
	if (mouseoverLoadSchema) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(loadSchemaButtonRectX1 - clipX, loadSchemaButtonRectY1 - clipY, loadSchemaButtonRectX2 - clipX, loadSchemaButtonRectY2 - clipY, true);
		scr_createTooltip( floor(mean(loadSchemaButtonRectX1, loadSchemaButtonRectX2)), loadSchemaButtonRectY2,scr_get_translation("msg_load-schema"), obj_tooltip.arrowFaceUp);
		if (mouse_check_button_pressed(mb_left)) {
			
			scr_loadSchema(false);
			scr_calculateTokenThreshold();
		}
	}
	


	
	// only draw the Save Schema button if there are no errors in the user's level mapping
	if (obj_importMapping.canContinueAll) {

		var saveSchemaButtonWidth = loadSchemaButtonWidth;
		var saveSchemaButtonHeight = loadSchemaButtonWidth;
		var saveSchemaButtonRectX1 = loadSchemaButtonRectX2 + loadSchemaButtonWidth;
		var saveSchemaButtonRectY1 = loadSchemaButtonRectY1;
		var saveSchemaButtonRectX2 = saveSchemaButtonRectX1 + saveSchemaButtonWidth;
		var saveSchemaButtonRectY2 = saveSchemaButtonRectY1 + saveSchemaButtonHeight;
		var mouseoverSaveSchema = point_in_rectangle(mouse_x, mouse_y, saveSchemaButtonRectX1, saveSchemaButtonRectY1, saveSchemaButtonRectX2, saveSchemaButtonRectY2);
		
		draw_sprite_ext(spr_saveIcon, 0, floor(mean(saveSchemaButtonRectX1, saveSchemaButtonRectX2)) - clipX, floor(mean(saveSchemaButtonRectY1, saveSchemaButtonRectY2)) - clipY, 1, 1, 0, global.colorThemeText, 1);

		// Save to File
		if (mouseoverSaveSchema) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(saveSchemaButtonRectX1 - clipX, saveSchemaButtonRectY1 - clipY, saveSchemaButtonRectX2 - clipX, saveSchemaButtonRectY2 - clipY, true);
			scr_createTooltip( floor(mean(saveSchemaButtonRectX1, saveSchemaButtonRectX2)), saveSchemaButtonRectY2,scr_get_translation("msg_save-schema"), obj_tooltip.arrowFaceUp);
			if (mouse_check_button_pressed(mb_left)) {
		
				//populates lists with current display
				scr_storeSchemaLists();
		
				// User will specify a name and a location for the sch file 
				scr_saveSchema();
			}
		}
	}


}
