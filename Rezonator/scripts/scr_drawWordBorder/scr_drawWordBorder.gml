
var drawBorder = argument0;
var drawFillRect = argument1;
var drawFocused = argument2;
var effectColor = argument3;
var wordRectX1 = argument4;
var wordRectY1 = argument5;
var wordRectX2 = argument6;
var wordRectY2 = argument7;
var borderRounded = argument8;
var fontScale = argument9;


// draw fill rectangle if needed
if (drawFillRect) {
	draw_set_color(effectColor);
	draw_set_alpha(0.25);
	draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	draw_set_alpha(1);
}
	
	
// draw border if needed
//var borderRounded = false;
if (drawBorder) {
	//borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow);
	if (effectColor == undefined){
	effectColor = 16758711;
	}
	draw_set_color(effectColor);
		
	for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
		if (borderRounded) {
			if (obj_chain.toggleDrawTrack) {
				draw_roundrect(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
		}
		else {
			if (obj_chain.toggleDrawRez) {
				draw_rectangle(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
		}
	}
}
	
if (drawFocused) {
	if ((not borderRounded and obj_chain.toggleDrawRez) or (borderRounded and obj_chain.toggleDrawTrack)) {
		draw_set_font(global.fontMain);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
	}
}