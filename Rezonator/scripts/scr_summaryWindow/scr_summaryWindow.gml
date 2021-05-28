function scr_summaryWindow() {
	

	
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
	var actualIterations = 0;
	for (var i = 0; i < 5; i++) {
		
		var currentStr = "";
		if (i == 0) {
			if (tokenCount < 1) continue;
			currentStr = "Total token count: " + string(tokenCount);
		}
		else if (i == 1) {
			if (lineCount < 1) continue;
			currentStr = scr_get_translation("label_total_line") + string(lineCount);
		}
		else if (i == 2) {
			if (blockCount < 1) continue;
			currentStr = "Block count: " + string(blockCount);
		}
		else if (i == 3) {
			if (fieldCount < 1) continue;
			currentStr = scr_get_translation("label_markers_found") + string(fieldCount);
		}
		else if (i == 4) {
			if (blockTypes < 1) continue;
			currentStr = "Block types: " + string(blockTypes);
		}
		
		var textX = floor(fileInfoWindowRectX1 + 20);
		var textY = floor(fileInfoWindowRectY1 + (stringHeight * (actualIterations + 1)));
		
		draw_text(textX - clipX, textY - clipY  + scrollPlusY, currentStr);
		actualIterations++;
	}






	scr_scrollBar(actualIterations+2, -1, stringHeight , 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scrollPlusY = min(scrollPlusY, 0);




}
