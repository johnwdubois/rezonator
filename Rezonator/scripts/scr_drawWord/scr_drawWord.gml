var currentWordGridRow = argument0;
var currentWordID = argument1;
var currentWordX = argument2;
var currentLineY = argument3;
var currentWordString = argument4;

ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordGridRow, true);
	
//var textColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colTextColor, currentWordID - 1);
var textColor = global.colorThemeText;
		
// finally, draw the word to the main view
draw_set_alpha(1);
draw_set_font(global.fontMain);
draw_set_color(textColor);
var rowInHitGrid = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), currentWordID );
if ( rowInHitGrid >= 0 ) {
	if (ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, rowInHitGrid)) {
		draw_set_font(global.fontMainBold);
		draw_set_color(make_color_rgb(19,69,150));		
	}
}
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(floor(currentWordX), floor(currentLineY), currentWordString);