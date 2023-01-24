///@description Wordform list & WordTip
if (!shortcutsEnabled || dialogueBoxActive) exit;

// if user is holding shift key, toggle the WordTip
if (keyboard_check(vk_shift)) {
	obj_wordTip.wordTipDisplay = !obj_wordTip.wordTipDisplay;
}
else {
	// if user is not holding shift, cycle the word for list
	displayTokenListIndex++;
	if (displayTokenListIndex >= ds_list_size(displayTokenList)) displayTokenListIndex = 0;
	if (displayTokenListIndex < 0) displayTokenList = 0;
	global.displayTokenField = displayTokenList[| displayTokenListIndex];
}