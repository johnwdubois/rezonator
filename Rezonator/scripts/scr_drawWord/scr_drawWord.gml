// Draw a singular word to the screen

function scr_drawWord(currentWordGridRow, currentWordID, currentWordX, currentLineY, currentWordString, hitGridHeight) {

	ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordGridRow, true);
	var textColor = global.colorThemeText;
        
	// Set the font, color, and alpha
	draw_set_alpha(1);
	draw_set_font(global.fontMain);
	draw_set_color(textColor);

	// Highlight this word if it has been Searched
	if (hitGridHeight > 0 and not obj_control.clearSearch) {
		var rowInHitGrid = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, hitGridHeight, currentWordID );
		if ( rowInHitGrid >= 0 ) {
			var wordHitBool = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, rowInHitGrid);
		    if (wordHitBool) {
		        draw_set_color(make_color_rgb(0, 97, 255));        
		    }
		}
	}
	
	// finally, draw the word to the main view
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(floor(currentWordX), floor(currentLineY), string(currentWordString));
}
