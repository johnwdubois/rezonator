// use enter key to submit prompt
if (keyboard_check_released(vk_enter) && is_string(instInputBox_Prompt.str) && instInputBox_Prompt.str != "") sendPrompt = true;

// when sending prompt, check that prompt and api key are both valid strings and then send request
if (sendPrompt) {
	if (is_string(instInputBox_Prompt.str) && instInputBox_Prompt.str != ""
	&& is_string(instInputBox_ApiKey.str) && instInputBox_ApiKey.str != "") {
		sendPrompt = false;
		global.aiChatAPIKey = instInputBox_ApiKey.str;
		scr_aiRequest(instInputBox_Prompt.str);
	}
}

// use tab to cycle between textboxes
if (keyboard_check_released(vk_tab)) {
	if (instInputBox_Prompt.windowFocused) {
		with (instInputBox_Prompt) windowFocused = false;
		with (instInputBox_ApiKey) windowFocused = true;
	}
	else {
		with (instInputBox_Prompt) windowFocused = true;
		with (instInputBox_ApiKey) windowFocused = false;
	}
}