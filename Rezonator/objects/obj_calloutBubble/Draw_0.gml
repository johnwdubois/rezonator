if (followWordID < 0 or followWordID >= ds_grid_height(obj_control.dynamicWordGrid)) {
	exit;
}

draw_set_font(global.fontMain);
followWordStringWidth = string_width(followWordString);



draw_set_font(global.fontChainContents);
//draw_set_font(global.fontMain);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


bubbleHeigth = string_height(string_hash_to_newline(bubbleString));
show_debug_message("bh:" + string(bubbleHeigth))



// draw arrow
var arrowX1 = x;
var arrowY1 = y;
var arrowX2 = x;
var arrowY2 = y;
var arrowX3 = x;
var arrowY3 = y;
if (currentBubbleDir == bubbleDirLeft or currentBubbleDir == bubbleDirRight) {
	arrowY1 = y - (arrowHeight / 2);
	arrowY2 = y + (arrowHeight / 2);
	if (currentBubbleDir == bubbleDirLeft) {
		arrowX3 = followWordPixelX + followWordStringWidth;
	}
	else {
		arrowX3 = followWordPixelX - followWordStringWidth;
	}
	arrowY3 = followWordPixelY;
}
else {
	arrowX1 = x - (arrowHeight / 2);
	arrowX2 = x + (arrowHeight / 2);
	arrowX3 = followWordPixelX;
	arrowY3 = followWordPixelY;
}
draw_set_color(global.colorThemeBG);
draw_triangle(arrowX1, arrowY1, arrowX2, arrowY2, arrowX3, arrowY3, false);
draw_set_color(global.colorThemeBorders);
draw_triangle(arrowX1, arrowY1, arrowX2, arrowY2, arrowX3, arrowY3, true);


// draw callout bubble
var bubbleX1 = x - (bubbleWidth / 2);
var bubbleY1 = y - (bubbleHeigth / 2);
var bubbleX2 = x + (bubbleWidth / 2);
var bubbleY2 = y + (bubbleHeigth / 2);

var bubblePlus = obj_control.wordDrawGridFocusedAnimation;

draw_set_color(global.colorThemeBG);
draw_roundrect(bubbleX1 - bubblePlus, bubbleY1 - bubblePlus, bubbleX2 + bubblePlus, bubbleY2 + bubblePlus, false);
draw_set_color(global.colorThemeBorders);
draw_roundrect(bubbleX1 - bubblePlus, bubbleY1 - bubblePlus, bubbleX2 + bubblePlus, bubbleY2 + bubblePlus, true);


// draw callout text
draw_set_color(global.colorThemeText);
draw_text(x, y, string_hash_to_newline(bubbleString));