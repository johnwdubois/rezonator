/// @description Toggle one to many
// oggle one to many
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

with(obj_panelPane){
	if (functionChainList_currentTab == functionChainList_tabShow) {
		exit;		
	}
}

scr_toggle1to1();