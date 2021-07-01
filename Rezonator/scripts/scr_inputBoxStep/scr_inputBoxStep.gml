// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_inputBoxStep(){
	
	if(!instance_exists(obj_dialogueBox))instance_destroy();
	
	var controlHold = (os_type == os_macosx) ? keyboard_check(vk_lcommand) || keyboard_check(vk_rcommand) : keyboard_check(vk_control);

	if (keyboard_check(vk_alt)) {
		x = mouse_x;
		y = mouse_y;
		if (keyboard_check_released(ord("R"))) {
			game_restart();
		}
	}

	// make sure we don't get multiple keys inputting at once
	if (string_length(keyboard_string) > 1) {
		keyboard_string = string_char_at(keyboard_string, 1);
	}


	var input = "";
	if (string_length(keyboard_string) > 0) input = keyboard_string;
	var paste = controlHold && keyboard_check_pressed(ord("V"));
	if (paste) {
		if (clipboard_has_text()) input = clipboard_get_text();
	}


	// get keyboard input for typing in
	if (string_length(keyboard_string) == 1 || paste) {
	
		// delete highlighted text if there is any
		if (cursorIndex != highlightIndex) {
			var _min = min(cursorIndex, highlightIndex);
			var _max = max(cursorIndex, highlightIndex);
			var deleteLen = _max - _min;
			str = string_delete(str, _min + 1, deleteLen);
			if (cursorIndex < highlightIndex) {
				cursorIndex = clamp(cursorIndex, 0, string_length(str));
				highlightIndex = cursorIndex;
			}
			else {
				highlightIndex = clamp(highlightIndex, 0, string_length(str));
				cursorIndex = highlightIndex;
			}
		}
	
		// add keyboard input
		var backspaceOrd = ord(input) == 127;

		cursorIndex++;
		str = string_insert(input, str, cursorIndex);
		if (string_length(input) > 1) cursorIndex += string_length(input) - 1;
		highlightIndex = cursorIndex;
	
		// dealing with cursor/clipping
		strToCursor = string_copy(str, 1, cursorIndex);
		cursorX = textX + string_width(strToCursor);
		if (cursorX > x + windowWidth) xOffset -= string_width(input);
	
		// reset keyboard string
		keyboard_string = "";
	}


	// backspace
	if (keyboard_check(vk_backspace)) {
		var backspaceTimer = os_type == os_macosx ? 1 : 0
		if (backspaceHold <= backspaceTimer || backspaceHold > 30) {
		
			// highlight backspace
			var deleteLen = 0;
			var _min = min(cursorIndex, highlightIndex);
			var _max = max(cursorIndex, highlightIndex);
			deleteLen = _max - _min;
			if (os_type == os_windows) {
				str = string_delete(str, _min + 1, deleteLen);
				cursorIndex = _min;
				highlightIndex = cursorIndex;
			}
		
			// single char backspace
			if (deleteLen == 0) {
				var strToDel = string_copy(str, cursorIndex, 1);
				str = string_delete(str, cursorIndex, 1);
				cursorIndex--;
				highlightIndex = cursorIndex;
				if (xOffset < 0 && cursorX < x + (windowWidth * 0.7)) {
					xOffset += string_width(strToDel);
				}
			}
		}
		backspaceHold++;
	}
	else {
		backspaceHold = 0;
	}



	// moving cursor with arrow keys
	if (keyboard_check(vk_left)) {
		if (leftArrowHold == 0 || leftArrowHold > 30) {
			cursorIndex--;
			if (!keyboard_check(vk_shift)) highlightIndex = cursorIndex;
			if (cursorX < x + (windowWidth * 0.1)) xOffset += string_width("A");
		}
		leftArrowHold++;
	}
	else {
		leftArrowHold = 0;
	}
	if (keyboard_check(vk_right)) {
		if (rightArrowHold == 0 || rightArrowHold > 30) {
			cursorIndex++;
			if (!keyboard_check(vk_shift)) highlightIndex = cursorIndex;
			if (cursorX > x + (windowWidth * 0.9)) xOffset -= string_width("A");
		}
		rightArrowHold++;
	}
	else {
		rightArrowHold = 0;
	}

	// drag and scroll outside of text box
	if (mouse_check_button(mb_left)) {
		if (cursorIndex > highlightIndex && mouse_x > x + windowWidth * 0.95) {
			if (xOffset > -(string_width(str) - (windowWidth * 0.9))) {
				xOffset -= string_width("A");
			}
		}
		else if ((cursorIndex < highlightIndex || cursorX < 0) && mouse_x < x + windowWidth * 0.05) {
			if (xOffset < 0) {
				xOffset += string_width("A");
			}
		}
	}




	// moving cursor with home/end keys
	var controlLeft = controlHold && keyboard_check_pressed(vk_left);
	var controlRight = controlHold && keyboard_check_pressed(vk_right);

	if (keyboard_check_pressed(vk_home) || controlLeft) {
		cursorIndex = 0;
		xOffset = 0;
		if (!keyboard_check(vk_shift)) highlightIndex = cursorIndex;
	}
	if (keyboard_check_pressed(vk_end) || controlRight) {
		cursorIndex = string_length(str);
		xOffset = -(string_width(str) - (windowWidth * 0.9));
		if (!keyboard_check(vk_shift)) highlightIndex = cursorIndex;
	}

	// CTRL+A
	if (keyboard_check_pressed(ord("A")) && controlHold) {
		cursorIndex = 0;
		highlightIndex = string_length(str);
		xOffset = 0;
	}
	// CTRL+C
	if (keyboard_check_pressed(ord("C")) && controlHold && cursorIndex != highlightIndex) {
		var _min = min(cursorIndex, highlightIndex);
		var _max = max(cursorIndex, highlightIndex);
		clipboard_set_text(string_copy(str, _min + 1, _max - _min));
	}
	// CTRL+X
	if (keyboard_check_pressed(ord("X")) && controlHold && cursorIndex != highlightIndex) {
		var _min = min(cursorIndex, highlightIndex);
		var _max = max(cursorIndex, highlightIndex);
		clipboard_set_text(string_copy(str, _min + 1, _max - _min));
		deleteLen = _max - _min;
		if (os_type == os_windows) {
			str = string_delete(str, _min + 1, deleteLen);
			cursorIndex = _min;
			highlightIndex = cursorIndex;
		}
	}



	cursorIndex = clamp(cursorIndex, 0, string_length(str));
	highlightIndex = clamp(highlightIndex, 0, string_length(str));


	// get strToCursor, so we know where to draw the cursor
	strToCursor = string_copy(str, 1, cursorIndex);
	strToHighlight = string_copy(str, 1, highlightIndex);

	// release command holding keys for mac
	if (os_type == os_macosx) {
		if (keyboard_check_released(vk_rcommand) || keyboard_check_released(vk_lcommand)) {
			keyboard_key_release(vk_left);
			keyboard_key_release(vk_right);
		}
	}

	xOffset = min(xOffset, 0);
	
	
}