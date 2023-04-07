/// @description Toggle one to many
// oggle one to many
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

with (obj_panelPane) {
	if (functionChainList_currentTab == NAVTAB_SHOW) {
		exit;		
	}
}

var optionStr = (obj_panelPane.chainViewOneToMany)? "option_one-to-one":"option_one-to-many";
scr_1to1Options(optionStr);