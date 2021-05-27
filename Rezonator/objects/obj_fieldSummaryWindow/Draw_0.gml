// setup coordinates for field summary window
fieldSummaryWindowX1 = obj_exampleWindow.exampleWindowX1;
fieldSummaryWindowY1 = obj_importMappingTagInfo.tagInfoWindowRectY1;
fieldSummaryWindowX2 = obj_exampleWindow.exampleWindowX2;
fieldSummaryWindowY2 = obj_importMappingTagInfo.tagInfoWindowRectY2;
x = fieldSummaryWindowX1;
y = fieldSummaryWindowY1;
windowWidth = fieldSummaryWindowX2 - fieldSummaryWindowX1;
windowHeight = fieldSummaryWindowY2 - fieldSummaryWindowY1;

// draw field summary window BG
draw_set_color(global.colorThemeBG);
draw_rectangle(fieldSummaryWindowX1, fieldSummaryWindowY1, fieldSummaryWindowX2, fieldSummaryWindowY2, false);


scr_surfaceStart();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1);
draw_set_color(global.colorThemeText);
scr_adaptFont("", "M");


// calculate x & y values for text
var rowHeight = obj_importMappingTagInfo.rowHeight;
var textXBuffer = 10;
var tokenCountX = floor(x + (windowWidth * mean(0, 0.25)));
var markerPercentX = floor(x + (windowWidth * mean(0.25, 0.5)));
var soloX = floor(x + (windowWidth * mean(0.5, 0.75)));
var splitX = floor(x + (windowWidth * mean(0.75, 1)));
var plusY = fieldSummaryWindowY1 + (rowHeight * 1.5);
var spaceWidth = string_width("   ");
scrollPlusY = obj_importMappingTagInfo.scrollPlusY;


// draw data for each field
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
	draw_text(tokenCountX - clipX, textY - clipY, string(currentTokenCount));
	draw_text(markerPercentX - clipX, textY - clipY, string(currentMarkerPercent));
	if (currentSolo) draw_text(soloX - clipX, textY - clipY, "Yes");
	draw_text(splitX - clipX, textY - clipY, (string(currentKey) != "0" || currentLevel == "token") ? "Yes" : "No");
	
	// draw line dividing each row
	if (i < tagInfoGridHeight - 1) {
		var lineY = textY + (rowHeight * 0.5);
		draw_set_color(global.colorThemeSelected1);
		draw_line(fieldSummaryWindowX1 + spaceWidth - clipX, lineY - clipY, fieldSummaryWindowX2 - spaceWidth - clipX, lineY - clipY);
	}
	
	// check for mouseover
	var mouseover = point_in_rectangle(mouse_x, mouse_y, fieldSummaryWindowX1, textY - (rowHeight * 0.5), fieldSummaryWindowX2, textY + (rowHeight * 0.5));
	if (mouseover) obj_importMapping.mouseoverRow = i;
	
	
	plusY += rowHeight;
}


scr_surfaceEnd();


// header BG
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(fieldSummaryWindowX1, fieldSummaryWindowY1, fieldSummaryWindowX2, fieldSummaryWindowY1 + rowHeight, false);

// draw headers
draw_set_color(global.colorThemeText);
var headerY = y + (rowHeight * 0.5);
draw_text(tokenCountX, headerY, "Token Count");
draw_text(markerPercentX, headerY, "Mark %");
draw_text(soloX, headerY, "Solo");
draw_text(splitX, headerY, "Split");

// draw line under header
draw_set_color(global.colorThemeSelected2);
draw_line_width(fieldSummaryWindowX1, fieldSummaryWindowY1 + rowHeight, fieldSummaryWindowX2, fieldSummaryWindowY1 + rowHeight, 2);