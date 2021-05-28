// setup coordinates for field summary window
fieldSummaryWindowX1 = obj_exampleWindow.exampleWindowX1;
fieldSummaryWindowY1 = obj_importMappingTagInfo.tagInfoWindowRectY1;
fieldSummaryWindowX2 = obj_exampleWindow.exampleWindowX2;
fieldSummaryWindowY2 = obj_importMappingTagInfo.tagInfoWindowRectY2;
x = fieldSummaryWindowX1;
y = fieldSummaryWindowY1;
windowWidth = fieldSummaryWindowX2 - fieldSummaryWindowX1;
windowHeight = fieldSummaryWindowY2 - fieldSummaryWindowY1;
var textXBuffer = 10;
// draw field summary window BG
draw_set_color(global.colorThemeBG);
draw_rectangle(fieldSummaryWindowX1, fieldSummaryWindowY1, fieldSummaryWindowX2, fieldSummaryWindowY2, false);


var changeGridButtonWidth = sprite_get_width(spr_ascend)*1.75;
var changeGridButtonHeight = changeGridButtonWidth;


var changeGridButtonRectX1 = x;
var changeGridButtonRectX2 = changeGridButtonRectX1 + changeGridButtonWidth;
var changeGridButtonRectY1 = y - changeGridButtonHeight;
var changeGridButtonRectY2 = y;
var buttonBuffer = 5;

draw_set_color(global.colorThemeBG);
draw_roundrect(changeGridButtonRectX1, changeGridButtonRectY1, changeGridButtonRectX2, changeGridButtonRectY2+10, false);
	
	
draw_sprite_ext(spr_ascend,0,mean(changeGridButtonRectX1,changeGridButtonRectX2), mean(changeGridButtonRectY1,changeGridButtonRectY2),1,1,(clickedIn)? 180:0,global.colorThemeSelected1,1);

var mouseOverChangeGrid = point_in_rectangle(mouse_x, mouse_y, changeGridButtonRectX1, changeGridButtonRectY1, changeGridButtonRectX2, changeGridButtonRectY2);
if(clickedIn or mouseOverChangeGrid){
	draw_set_color(global.colorThemeSelected1);
	scr_drawRectWidth(changeGridButtonRectX1+ buttonBuffer, changeGridButtonRectY1+ buttonBuffer, changeGridButtonRectX2- buttonBuffer, changeGridButtonRectY2 - buttonBuffer,3, true);
}

if (mouseOverChangeGrid) {
	if (mouse_check_button_pressed(mb_left)) {
		clickedIn = true;
		obj_importMapping.rowToChange = -1;
		obj_importMapping.colToChange = -1;
		scr_createDropDown(changeGridButtonRectX1,changeGridButtonRectY2,obj_importMapping.gridList, global.optionListTypeImportGrid);
	}
}


draw_set_halign(fa_left);
draw_set_color(global.colorThemeText);
scr_adaptFont(string(obj_importMapping.currentGridName), "M");
draw_text(changeGridButtonRectX2 + textXBuffer, floor(mean(changeGridButtonRectY1, changeGridButtonRectY2)), string(obj_importMapping.currentGridName));




scr_surfaceStart();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1);
draw_set_color(global.colorThemeText);
scr_adaptFont("", "M");


// calculate x & y values for text
var rowHeight = obj_importMappingTagInfo.rowHeight;

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
			draw_text(textX - clipX, floor(textY - clipY), cellStr);
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