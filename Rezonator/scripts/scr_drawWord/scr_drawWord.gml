// Draw a singular word to the screen

var currentWordGridRow = argument0;
var currentWordID = argument1;
var currentWordX = argument2;
var currentLineY = argument3;
var currentWordString = argument4;
var hitGridHeight = argument5;

ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordGridRow, true);
    
//var textColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colTextColor, currentWordID - 1);
var textColor = global.colorThemeText;
        
// finally, draw the word to the main view
draw_set_alpha(1);
draw_set_font(global.fontMain);
draw_set_color(textColor);

if (hitGridHeight > 0) {
	var rowInHitGrid = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, hitGridHeight, currentWordID );
	if ( rowInHitGrid >= 0 ) {
	    if (scr_findInGridTwoParameters(obj_control.hitGrid, obj_control.hitGrid_colWordID, currentWordID, obj_control.hitGrid_colHitBool, 1) > -1) {
	        //draw_set_font(global.fontMainBold);
	        draw_set_color(make_color_rgb(0, 97, 255));        
	    }
	}
}

draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(floor(currentWordX), floor(currentLineY), string(currentWordString));
