function scr_inputBoxDraw(){
	
	// set text positions and window height
	var fontSize = navWindowTagging ? "S" : "M";
	scr_adaptFont(str, fontSize);
	var strLen = string_length(str);
	var strHeight = string_height("A");
	var textMarginX = 10;
	var textMarginY = 10;
	if (navWindowTagging) {
		textMarginX *= 0.5;
		textMarginY = 0;
	}
	
	textX = floor(textBoxX + textMarginX + xOffset);
	textY = floor(textBoxY + textMarginY);
	windowHeight = strHeight + (textMarginY * 2);

	// click in window to focus it
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, textBoxX, textBoxY, textBoxX + windowWidth, textBoxY + windowHeight);
	if (mouse_check_button_pressed(mb_left)) {
		if (mouseoverWindow && !windowFocused) {
			windowFocused = true;
			drawCursor = true;
			alarm[0] = blinkRate;
		}
		else if (!mouseoverWindow && windowFocused) {
			if (!instance_exists(obj_openingScreen)) {
				windowFocused = false;
			}
		}
		
		if (navWindowTagging && !mouseoverWindow) instance_destroy();
	}
	
	if (instance_exists(obj_openingScreen)) {
		windowFocused = !obj_openingScreen.showPreImportScreen;
	}
	
	// moving cursor with mouse click
	if (mouse_check_button(mb_left)) {
		var closestCharToMouse = 0;
		var minDistToMouse = 999999999;
		
		// find closest character to mouse
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
		
		// check to move cursor/highlight index
		if (mouse_check_button_pressed(mb_left)) {
			validDrag = mouseoverWindow;
			if (validDrag) highlightIndex = closestCharToMouse;
		}
		if (validDrag) cursorIndex = closestCharToMouse;
		
		// check if double-clicking
		if (mouse_check_button_pressed(mb_left) && validDrag && mouseoverWindow) {
			if (doubleClickTimer > 0) doubleClick = true;
			else doubleClickTimer = doubleClickTimerFull;
		}
	}

	if (mouse_check_button_released(mb_left)) {
		validDrag = true;
		
		// double click to select word
		if (doubleClick) {
			doubleClick = false;
			while (scr_isCharLetter(string_char_at(str, cursorIndex)) && cursorIndex < strLen) cursorIndex++;
			while (scr_isCharLetter(string_char_at(str, highlightIndex)) && highlightIndex > 0) highlightIndex--;
			if (cursorIndex < strLen || !scr_isCharLetter(string_char_at(str, cursorIndex))) cursorIndex--;
		}
	}

	// draw BG rect
	draw_set_alpha(1);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(textBoxX, textBoxY, textBoxX + windowWidth, textBoxY + windowHeight, false);

	// start clipping for text
	scr_miniSurfaceStart();

	// draw text
	scr_adaptFont(str, fontSize);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(textX - clipX, textY - clipY, str);

	// draw cursor
	cursorX = textX + string_width(strToCursor);
	var cursorY1 = textY;
	var cursorY2 = cursorY1 + strHeight;
	if (windowFocused) {
		var drawCursorReal = false;
		if (drawCursor || keyboard_check(vk_anykey)) drawCursorReal = true;
		if (drawCursorReal) {
			draw_set_color(global.colorThemeRezPink);
			draw_line_width(cursorX - clipX, cursorY1 - clipY, cursorX - clipX, cursorY2 - clipY, 2);
		}
	}

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
	if (windowFocused) {
		for (var i = 0; i < 3; i++) draw_rectangle(textBoxX + i, textBoxY + i, textBoxX + windowWidth + i, textBoxY + windowHeight + i, true);
	}
	else {
		draw_rectangle(textBoxX, textBoxY, textBoxX + windowWidth, textBoxY + windowHeight, true);
	}
}