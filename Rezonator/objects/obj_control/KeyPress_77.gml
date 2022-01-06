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

var optionStr = (obj_panelPane.chainViewOneToMany)? "option_one-to-one":"option_one-to-many";
scr_1to1Options(optionStr);