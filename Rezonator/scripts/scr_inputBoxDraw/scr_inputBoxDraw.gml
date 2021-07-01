// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_inputBoxDraw(){

	var strHeight = string_height("A");
	var textMarginX = 10;
	var textMarginY = 10;

	textX = floor(x + textMarginX + xOffset);
	textY = floor(y + textMarginY);
	windowHeight = strHeight + (textMarginY * 2);

	// moving cursor with mouse click
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
	if (mouse_check_button(mb_left)) {
		var closestCharToMouse = 0;
		var minDistToMouse = 999999999;
		var strLen = string_length(str);
		for (var i = 0; i <= strLen; i++) {
			var subStr = string_copy(str, 1, i);
			var subStrX = textX + string_width(subStr);
			var subStrY = textY;
			var distToMouse = point_distance(mouse_x, mouse_y, subStrX, subStrY);
			if (distToMouse < minDistToMouse) {
				minDistToMouse = distToMouse;
				closestCharToMouse = i;
			}
		}
		if (mouse_check_button_pressed(mb_left)) {
			validDrag = mouseoverWindow;
			if (validDrag) highlightIndex = closestCharToMouse;
		}
		if (validDrag) cursorIndex = closestCharToMouse;
	}

	if (mouse_check_button_released(mb_left)) validDrag = true;


/*

	// dev vars
	draw_set_color(c_yellow);
	draw_set_alpha(1);
	draw_text(10, 10, "keyboard_string: " + string(keyboard_string));
	draw_text(10, 40, "cursorIndex: " + string(cursorIndex));
	draw_text(10, 70, "highlightIndex: " + string(highlightIndex));
	draw_text(10, 100, "strToCursor: " + string(strToCursor));
	draw_text(10, 130, "backspaceHold: " + string(backspaceHold));
	draw_text(10, 160, "xOffset: " + string(xOffset));
	draw_text(10, 190, "validDrag: " + string(validDrag));
	draw_text(10, 220, "clipboard: " + string(clipboard_get_text()));
	draw_text(10, 260, "clipX: " + string(clipX));
	draw_text(10, 300, "clipY: " + string(clipY));
*/


	// BG rect
	draw_set_color(c_white);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

	// start clipping for text
	scr_miniSurfaceStart()


	// draw text
	draw_set_color(c_black);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	scr_adaptFont(str, "M",false);
	draw_text(textX - clipX, textY - clipY, str);


	// draw cursor
	cursorX = textX + string_width(strToCursor);
	var cursorY1 = textY;
	var cursorY2 = cursorY1 + strHeight;
	draw_set_color(global.colorThemeRezPink);
	var drawCursorReal = false;
	if (drawCursor || keyboard_check(vk_anykey)) drawCursorReal = true;
	if (drawCursorReal) draw_line_width(cursorX - clipX, cursorY1 - clipY, cursorX - clipX, cursorY2 - clipY, 2);


	// draw highlight rect if we need to
	var drawHighlightRect = (mouse_check_button(mb_left) || cursorIndex != highlightIndex);
	if (drawHighlightRect) {
		var highlightX = textX + string_width(strToHighlight);
	
		var highlightRectX1 = min(cursorX, highlightX);
		var highlightRectY1 = cursorY1;
		var highlightRectX2 = max(cursorX, highlightX);
		var highlightRectY2 = cursorY2;
	
		draw_set_color(c_blue);
		draw_set_alpha(0.4);
		draw_rectangle(highlightRectX1 - clipX, highlightRectY1 - clipY, highlightRectX2 - clipX, highlightRectY2 - clipY, false);
		draw_set_alpha(1);
	}

	// end clipping for text
	scr_surfaceEnd();


	// outline rect
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
}