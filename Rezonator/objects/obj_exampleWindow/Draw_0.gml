// setup coordinates for example window
var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
x = (camWidth * 0.52);
y = obj_summaryWindow.fileInfoWindowRectY1;
exampleWindowX1 = x;
exampleWindowY1 = y;
exampleWindowX2 = camWidth * 0.98;
exampleWindowY2 = obj_summaryWindow.fileInfoWindowRectY2;
windowWidth = (exampleWindowX2 - x);
windowHeight = (exampleWindowY2 - y);
var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, exampleWindowX2, exampleWindowY2);





// setup string drawing stuff
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_alpha(1);

scr_adaptFont("0", "M");
var strHeight = string_height("0");
var strHeightAdjust = strHeight * 2;
var tabHeight = strHeight * 1.5;

// get the field to display examples for
var fieldSelected = string(obj_importMappingTagInfo.fieldSelected);
var fieldColSelected = ds_list_find_index(global.importGridColNameList, fieldSelected);
var exampleCount = min(50, ds_grid_height(global.importGrid));



// tab at the top of the window
var spaceWidth = string_width("  ");
var tabStr = scr_get_translation("import_col_example") +": " + fieldSelected;
var tabX1 = x;
var tabY1 = y - tabHeight;
var tabX2 = tabX1 + string_width(tabStr) + (spaceWidth * 2);
var tabY2 = y + 5;
draw_set_color(global.colorThemeBG);
draw_roundrect(tabX1, tabY1, tabX2, tabY2, false);
draw_set_color(global.colorThemeRezPurple);
var tabTextY = floor(mean(tabY1, tabY2));
tabStr = scr_adaptFont(tabStr, "M");
draw_text(tabX1 + spaceWidth, tabTextY, tabStr);
draw_line_width(tabX1 + spaceWidth, tabTextY + (strHeight * 0.6), tabX2 - spaceWidth, tabTextY + (strHeight * 0.6), 3);


draw_set_color(global.colorThemeBG);
draw_set_alpha(1);
draw_rectangle(x, y, exampleWindowX2, exampleWindowY2, false);


if (fieldColSelected < 0) {
	exit;
}

scr_surfaceStart();

// draw the little speaker label rectangle for the line numbers
var exampleTextBuffer = string_width("       ");
draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
draw_rectangle(x - clipX, y - clipY, x + exampleTextBuffer - clipX, exampleWindowY2 - clipY, false);

// loop through the example field and display its contents from importGrid
for (var i = 0; i < exampleCount; i++) {
	var currentExample = string(ds_grid_get(global.importGrid, fieldColSelected, i));
	var textX = floor(x + 10 + exampleTextBuffer);
	var textY = floor(y + 10 + (i * strHeightAdjust) + scrollPlusY);
	
	draw_set_color(global.colorThemeText);
	draw_text(textX - exampleTextBuffer - clipX, textY - clipY, string(i + 1));
	currentExample = scr_adaptFont(currentExample, "M");
	draw_text(textX - clipX, textY - clipY, currentExample);
	
	draw_set_color(global.colorThemeBG);
	draw_line_width(x - clipX, textY + (strHeightAdjust * 0.5) - clipY, x + exampleTextBuffer - clipX, textY + (strHeightAdjust * 0.5) - clipY, 3);
}



scr_scrollBar(exampleCount, 0, strHeightAdjust, 0,
	global.colorThemeSelected2, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);


if (mouseoverWindow) {
	if (mouse_wheel_down()) {
		scrollPlusYDest -= 16;
	}
	if (mouse_wheel_up()) {
		scrollPlusYDest += 16;
	}
}
	
scr_surfaceEnd();
