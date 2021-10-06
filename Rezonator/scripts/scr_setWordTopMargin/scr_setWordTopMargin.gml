// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setWordTopMargin(){
	
	if (!instance_exists(obj_menuBar) || !instance_exists(obj_panelPane)) exit;
	var menuBarHeight = 0;
	if (instance_exists(obj_menuBar)) {
		menuBarHeight = obj_menuBar.menuHeight;
	}
	var chainListHeight = 0;
	var tabsHeight = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListHeight = windowHeight;
		}
		else if (currentFunction == functionTabs) {
			tabsHeight = windowHeight;
		}
	}
	if (obj_panelPane.showNav) {
		wordTopMargin = menuBarHeight + chainListHeight + tabsHeight;
	}
	else {
		if (!instance_exists(obj_rezzlesUI)) wordTopMargin = menuBarHeight;
	}

}