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


// draw data for each field
var gridViewing = obj_importMappingTagInfo.gridViewing;
var gridViewingWidth = ds_grid_width(gridViewing);
var gridViewingHeight = ds_grid_height(gridViewing);
var colWidth = windowWidth / gridViewingWidth;

if (gridViewing == global.tagInfoGrid) {
	scr_fieldSummaryWindow(tokenCountX, markerPercentX, soloX, splitX, rowHeight, spaceWidth);
}
else {
	
	for (var i = 0; i < gridViewingHeight; i++) {
		
		var textY = floor(plusY + scrollPlusY);
	
		for (var j = 0; j < gridViewingWidth; j++) {
			
			// setup x coordinates for this cell
			var colX1 = x + (colWidth * j);
			var colX2 = colX1 + colWidth;
			var textX = floor(mean(colX1, colX2));
			
			// check whether this cell should be center aligned or not
			draw_set_halign(fa_center);
			if (gridViewing == global.importTXTLineGrid && j == global.importTXTLineGrid_colLine) {
				textX = colX1 + textXBuffer;
				draw_set_halign(fa_left);
			}
			
			// draw text for this cell
			var cellStr = string(ds_grid_get(obj_importMappingTagInfo.gridViewing, j, i));
			draw_text(textX - clipX, textY - clipY, cellStr);
		}
		
		plusY += rowHeight;
	}
	
	// draw scrollbar only if we're not looking at field summary window
	scr_scrollBar(gridViewingHeight, -1, rowHeight, rowHeight,
		global.colorThemeSelected2, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
}




scr_surfaceEnd();


// header BG
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(fieldSummaryWindowX1, fieldSummaryWindowY1, fieldSummaryWindowX2, fieldSummaryWindowY1 + rowHeight, false);

// draw headers
draw_set_color(global.colorThemeText);
var headerY = y + (rowHeight * 0.5);
if (gridViewing == global.tagInfoGrid) {
	
	// headers for field summary window
	draw_text(tokenCountX, headerY, "Token Count");
	draw_text(markerPercentX, headerY, "Mark %");
	draw_text(soloX, headerY, "Solo");
	draw_text(splitX, headerY, "Split");
}
else {
	
	// headers for other grids
	for (var i = 0; i < gridViewingWidth; i++) {
			
		var colX1 = x + (colWidth * i);
		var colX2 = colX1 + colWidth;
		var textX = floor(mean(colX1, colX2));
		
		// determine header string depending on which gridViewing we're viewing
		var headerStr = "";
		if (gridViewing == global.importTXTLineGrid) {
			if (i == global.importTXTLineGrid_colLine) {
				headerStr = "line";
			}
			else if (i == global.importTXTLineGrid_colException) {
				headerStr = "EXCEPTION";
			}
		}
		else if (gridViewing == global.blockTypeGrid) {
			if (i == global.blockTypeGrid_colDefault) {
				headerStr ="default";
			}
			else if (i == global.blockTypeGrid_colBlockCategory) {
				headerStr ="block category";
			}
			else if (i == global.blockTypeGrid_colBlockType) {
				headerStr ="block type";
			}
			else if (i == global.blockTypeGrid_colBlockCount) {
				headerStr ="block count";
			}
			else if (i == global.blockTypeGrid_colLinesPerBlock) {
				headerStr ="lines per block";
			}
			else if (i == global.blockTypeGrid_colFieldList) {
				headerStr ="field list";
			}
		}
		else if (gridViewing == global.blockGrid) {
			if (i == global.blockGrid_colBlockID) {
				headerStr ="blockID";
			}
			else if (i == global.blockGrid_colBlockType) {
				headerStr ="block type";
			}
			else if (i == global.blockGrid_colLineList) {
				headerStr ="line list";
			}
			else if (i == global.blockGrid_colTokenCountList) {
				headerStr ="token count list";
			}
		}
		else if (gridViewing == global.fieldRelationGrid) {
			if (i == global.fieldRelationGrid_colField) {
				headerStr ="field";
			}
			else if (i == global.fieldRelationGrid_colEncounteredFields) {
				headerStr ="encountered fields";
			}
			else if (i == global.fieldRelationGrid_colOneToOneFieldList) {
				headerStr ="1-to-1 field list";
			}
		}
		else if (gridViewing == global.fieldRelationHelperGrid) {
			headerStr = ds_list_find_value(global.importGridColNameList, i+2);
		}
		
		// draw header text
		draw_text(textX, headerY, headerStr);
	}
}

// draw line under header
draw_set_color(global.colorThemeSelected2);
draw_line_width(fieldSummaryWindowX1, fieldSummaryWindowY1 + rowHeight, fieldSummaryWindowX2, fieldSummaryWindowY1 + rowHeight, 2);