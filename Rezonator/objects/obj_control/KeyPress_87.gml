///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}


if(ds_list_size(displayTokenList) == 1) exit;
if(displayTokenListIndex == ds_list_size(displayTokenList) - 1){
	global.displayTokenField = displayTokenList[| displayTokenListIndex];
	displayTokenListIndex = 0;
}
else{
	global.displayTokenField = displayTokenList[| displayTokenListIndex];
	displayTokenListIndex++;	
}