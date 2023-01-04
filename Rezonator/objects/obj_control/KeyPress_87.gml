///@description Wordform list & WordTip
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

// if user is holding shift key, cycle the word for list
if (keyboard_check(vk_shift)) {
	if (ds_list_size(displayTokenList) == 1) exit;
	if (displayTokenListIndex == ds_list_size(displayTokenList) - 1) {
		global.displayTokenField = displayTokenList[| displayTokenListIndex];
		displayTokenListIndex = 0;
	}
	else {
		global.displayTokenField = displayTokenList[| displayTokenListIndex];
		displayTokenListIndex++;	
	}
}
else {
	// if user is not holding shift, toggle the WordTip
	obj_wordTip.wordTipDisplay = !obj_wordTip.wordTipDisplay;
}