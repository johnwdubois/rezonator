

function scr_setWordTopMargin(){
	
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
		wordTopMargin = menuBarHeight;
	}

}