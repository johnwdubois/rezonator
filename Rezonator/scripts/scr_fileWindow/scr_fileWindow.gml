function scr_fileWindow() {
	
	var stringHeight = string_height("0");
	var filename = filename_name(global.importFilename);
	var lineCount = ds_grid_height(global.importTXTLineGrid);
	var blockCount = ds_grid_height(global.blockGrid);
	var blockTypes = ds_grid_height(global.blockTypeGrid);
	var tokenCount = global.tokenCountTotal;
	var fieldCount = ds_grid_height(global.tagInfoGrid);
	
	if (global.importType == global.importType_CSV) {
		lineCount = ds_grid_height(global.importCSVGrid);
		global.tokenCountTotal = lineCount;
		tokenCount = global.tokenCountTotal;
	}
	else if (global.importType == global.importType_IGT) {
		fieldCount -= 2;
	}
	draw_set_color(global.colorThemeText)
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	scr_adaptFont(scr_get_translation("label_user_file_name"), "M");
	draw_text(fileInfoWindowRectX1 + 20 - clipX, fileInfoWindowRectY1 + stringHeight - clipY  + scrollPlusY, scr_get_translation("label_user_file_name") + string(filename));
	
	scrollPlusY = min(scrollPlusY, 0);

}
