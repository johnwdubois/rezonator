///@description Wordform list & WordTip
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

// if user is holding shift key, cycle the word for list
if (keyboard_check(vk_shift)) {
	displayTokenListIndex++;
	if (displayTokenListIndex >= ds_list_size(displayTokenList)) displayTokenListIndex = 0;
	if (displayTokenListIndex < 0) displayTokenList = 0;
	global.displayTokenField = displayTokenList[| displayTokenListIndex];
}
else {
	// if user is not holding shift, toggle the WordTip
	obj_wordTip.wordTipDisplay = !obj_wordTip.wordTipDisplay;
}