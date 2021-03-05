// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_toggle1to1(){

	var updateReadTab = false;
	with (obj_panelPane) {
		if (functionChainList_currentTab == functionChainList_tabLine) {
			updateReadTab = true;
		}
		else {
			chainViewOneToMany = !chainViewOneToMany;
		}
	}
	if (updateReadTab) {
		obj_control.showUnitTags = !obj_control.showUnitTags;
	}

}