

function scr_fieldSummaryWindow(tokenCountX, markerPercentX, soloX, splitX, rowHeight, spaceWidth) {
	
	scrollPlusY = obj_importMappingTagInfo.scrollPlusY;
	var plusY = fieldSummaryWindowY1 + (rowHeight * 1.5);
	
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	for (var i = 0; i < tagInfoGridHeight; i++) {
	
		// check if this is the blockSeq or blockID, if so
		// don't show the row for this field
		var currentMarker = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, i);
		if (currentMarker == "~blockID" || currentMarker == "~blockSeq") {
			continue;
		}
		var currentTokenCount = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colTokenCount, i);
		var currentMarkerPercent = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarkerPercent, i);
		var currentSolo = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSingleTokenMarker, i);
		var currentKey = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colKey, i);
		var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
	
		// draw text for this field
		var textY = floor(plusY + scrollPlusY);
		draw_set_color(global.colorThemeText);
		draw_text(tokenCountX - clipX, floor(textY - clipY), string(currentTokenCount));
		draw_text(markerPercentX - clipX, floor(textY - clipY), string(currentMarkerPercent) + "%");
		if (currentSolo) draw_text(soloX - clipX, floor(textY - clipY), scr_get_translation("msg_yes"));
		draw_text(splitX - clipX, floor(textY - clipY), (string(currentKey) != "0" || currentLevel == "token") ? scr_get_translation("msg_yes") : scr_get_translation("msg_no"));
	
		// draw line dividing each row
		if (i < tagInfoGridHeight - 1) {
			var lineY = textY + (rowHeight * 0.5);
			draw_set_color(global.colorThemeSelected1);
			draw_line(fieldSummaryWindowX1 + spaceWidth - clipX, lineY - clipY, fieldSummaryWindowX2 - spaceWidth - clipX, lineY - clipY);
		}
	
		// check for mouseover
		var mouseover = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, fieldSummaryWindowX1, floor(textY - (rowHeight * 0.5)), fieldSummaryWindowX2, floor(textY + (rowHeight * 0.5))) && !instance_exists(obj_dropDown);
		if (mouseover) obj_importMapping.mouseoverRow = i;
	
	
		plusY += rowHeight;
	}

}