function scr_inputBoxStep(){
	
	if(!instance_exists(obj_dialogueBox) && room != rm_openingScreen && !navWindowTagging) instance_destroy();
	if (room == rm_mainScreen) with (obj_control) shortcutsEnabled = false;
	var fontSize = navWindowTagging ? "S" : "M";
	
	// check important keys
	var ctrlCheck = global.ctrlHold;
	if (!windowFocused) ctrlCheck = false;
	var keyShift = keyboard_check(vk_shift) && windowFocused;
	var keyBackspace = keyboard_check(vk_backspace) && windowFocused;
	var keyHomePressed = keyboard_check_pressed(vk_home) && windowFocused;
	var keyEndPressed = keyboard_check_pressed(vk_end) && windowFocused;
	var keyLeft = keyboard_check(vk_left) && windowFocused;
	var keyRight = keyboard_check(vk_right) && windowFocused;
	var keyLeftPressed = keyboard_check_pressed(vk_left) && windowFocused;
	var keyRightPressed = keyboard_check_pressed(vk_right) && windowFocused;
	var keyEnterPressed = keyboard_check_pressed(vk_enter) && windowFocused;
	var keyEscapePressed = keyboard_check_pressed(vk_escape) && windowFocused;
	if(dragging && !mouse_check_button(mb_left)){
		with(obj_control){
			alarm[1] = 1;
		}
	}
	
	// cancel horizontal movement if in dropdown
	if (instance_exists(obj_dropDown)) {
		if (obj_dropDown.optionCurrent >= 0) {
			keyLeft = false;
			keyRight = false;
		}
	}
	
	// check shortcuts
	var shortcutPaste = ctrlCheck && keyboard_check_pressed(ord("V"));
	var shortcutCopy = ctrlCheck && keyboard_check_pressed(ord("C"));
	var shortcutCut = ctrlCheck && keyboard_check_pressed(ord("X"));
	var shortcutSelectAll = ctrlCheck && keyboard_check_pressed(ord("A"));
	var shortcutJumpRight = ctrlCheck && keyRightPressed;
	var shortcutJumpLeft = ctrlCheck && keyLeftPressed;
	
	// set font here so that string width/height checks are accurate
	scr_adaptFont(str, fontSize);

	// get keyboard input
	var input = "";
	if (string_length(keyboard_string) > 0 && windowFocused) {
		input = keyboard_string;
		with (obj_dropDown) {
			if (!keyboard_check(vk_enter) && !keyboard_check_pressed(vk_enter) && !keyboard_check_released(vk_enter)) {
				optionCurrent = -1;
			}
		}
	}
	
	
	// CTRL+V (paste)
	var paste = false;
	if (shortcutPaste) {
		if (clipboard_has_text()) {
			paste = true;
			input = clipboard_get_text();
		}
	}

	// get keyboard input for typing in
	if (string_length(keyboard_string) >= 1 || shortcutPaste) {
	
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
	
		// move cursor forward with new character
		cursorIndex++;
		str = string_insert(input, str, cursorIndex);
		if (string_length(input) > 1) cursorIndex += string_length(input) - 1;
		highlightIndex = cursorIndex;
	
		// dealing with cursor/clipping
		strToCursor = string_copy(str, 1, cursorIndex);
		cursorX = textX + string_width(strToCursor);
		if (cursorX > textBoxX + windowWidth) xOffset -= string_width(input);
	
		// reset keyboard string
		if (windowFocused) keyboard_string = "";
	}


	// backspace
	if (keyBackspace) {
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
				if (xOffset < 0 && cursorX < textBoxX + (windowWidth * 0.7)) {
					xOffset += string_width(strToDel);
				}
			}
		}
		backspaceHold++;
	}
	else {
		backspaceHold = 0;
	}



	// LEFT ARROW (move cursor to previous character)
	if (keyLeft && !shortcutJumpLeft && !ctrlCheck) {
		if (leftArrowHold == 0 || leftArrowHold > 30) {
			cursorIndex--;
			if (!keyShift) highlightIndex = cursorIndex;
			if (cursorX < textBoxX + (windowWidth * 0.1)) xOffset += string_width("A");
		}
		leftArrowHold++;
	}
	else {
		leftArrowHold = 0;
	}
	// RIGHT ARROW (move cursor to previous character)
	if (keyRight && !shortcutJumpRight && !ctrlCheck) {
		if (rightArrowHold == 0 || rightArrowHold > 30) {
			cursorIndex++;
			if (!keyShift) highlightIndex = cursorIndex;
			if (cursorX > textBoxX + (windowWidth * 0.9)) xOffset -= string_width("A");
		}
		rightArrowHold++;
	}
	else {
		rightArrowHold = 0;
	}

	// drag and scroll outside of text box
	if (mouse_check_button(mb_left)) {
		dragging = true;
		if (cursorIndex > highlightIndex && mouse_x > textBoxX + windowWidth * 0.95) {
			if (xOffset > -(string_width(str) - (windowWidth * 0.9))) {
				xOffset -= string_width("A");
			}
		}
		else if ((cursorIndex < highlightIndex || cursorX < 0) && mouse_x < textBoxX + windowWidth * 0.05) {
			if (xOffset < 0) {
				xOffset += string_width("A");
			}
		}
	}




	// HOME (move cursor to begining of text)
	if (keyHomePressed) {
		cursorIndex = 0;
		xOffset = 0;
		if (!keyShift) highlightIndex = cursorIndex;
	}
	// END (move cursor to end of text)
	if (keyEndPressed) {
		cursorIndex = string_length(str);
		xOffset = -(string_width(str) - (windowWidth * 0.9));
		if (!keyShift) highlightIndex = cursorIndex;
	}
	// CTRL+A (select all)
	if (shortcutSelectAll) {
		cursorIndex = 0;
		highlightIndex = string_length(str);
		xOffset = 0;
	}
	// CTRL+C (copy)
	if (shortcutCopy && cursorIndex != highlightIndex) {
		var _min = min(cursorIndex, highlightIndex);
		var _max = max(cursorIndex, highlightIndex);
		clipboard_set_text(string_copy(str, _min + 1, _max - _min));
	}
	// CTRL+textBoxX (cut)
	if (shortcutCut && cursorIndex != highlightIndex) {
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
	// CTRL+RIGHT ARROW (jump cursor to next letter character)
	if (shortcutJumpRight) {
		if (cursorIndex < string_length(str)) cursorIndex++;
		while (scr_isCharLetter(string_char_at(str, cursorIndex)) && cursorIndex < string_length(str)) cursorIndex++;
		if (cursorIndex + 1 < string_length(str)) {
			while (!scr_isCharLetter(string_char_at(str, cursorIndex + 1)) && cursorIndex < string_length(str)) cursorIndex++;
		}
		if (!keyShift) highlightIndex = cursorIndex;
	}
	// CTRL+LEFT ARROW (jump cursor to previous letter character)
	if (shortcutJumpLeft) {
		if (cursorIndex > 0) cursorIndex--;
		while (scr_isCharLetter(string_char_at(str, cursorIndex)) && cursorIndex > 0) cursorIndex--;
		if (cursorIndex - 1 > 0) {
			while (!scr_isCharLetter(string_char_at(str, cursorIndex)) && cursorIndex  > 0) cursorIndex--;
		}
		if (!keyShift) highlightIndex = cursorIndex;
	}

	// clamp cursor & highlight indexes so they're within string
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
	
	// make sure xOffset is at least 0
	xOffset = min(xOffset, 0);
	
	// decrease doubleClickTimer
	doubleClickTimer = max(doubleClickTimer - 1, 0);
	
	
	if (navWindowTagging && instance_exists(obj_control)) {
		
		if (keyEnterPressed) {
			if (instance_exists(obj_alarm2)) {
				with (obj_control) {
					navWindowTaggingDisableSpawn = true;
					navWindowTaggingNextRow = true;
				}
				with (obj_alarm2) alarm[11] = 1;
			}
			show_debug_message("DESTROYING INPUT BOX FROM ENTER PRESSED");
			instance_destroy();
		}
		else if (keyEscapePressed) {
			// set old tag back
			if (obj_control.navWindowTaggingID != "" && obj_control.navWindowTaggingField != "") {
				
				obj_control.navWindowTaggingEscape = true;
				instance_destroy();
			}
		}
	}
	
}