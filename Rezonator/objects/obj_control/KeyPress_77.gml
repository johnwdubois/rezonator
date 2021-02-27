/// @description Toggle one to many
// oggle one to many
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

var updateReadTab = false;
with (obj_panelPane) {
	if (functionChainList_currentTab == functionChainList_tabLine) {
		updateReadTab = true;
	}
	else {
		chainViewOneToMany = !chainViewOneToMany;
	}
}
if(updateReadTab){
	obj_control.showUnitTags = !obj_control.showUnitTags;
}