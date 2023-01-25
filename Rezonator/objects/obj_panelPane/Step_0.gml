originalWindowHeight = obj_menuBar.menuHeight;

switch (currentFunction) {
	case functionChainList:
		with (obj_panelPane) {
			functionChainList_currentTab = other.functionChainList_currentTab;
		}
		break;
	case functionChainContents:
		// as long as a focused chain exists, update the chainContents chainID
		if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID) && obj_chain.currentFocusedChainID != "") {
			functionChainContents_chainID = obj_chain.currentFocusedChainID;
		}
		break;
	default:
		break;
}



if (keyboard_check(vk_down)) {
	holdDown++;	
}
else {
	holdDown = 0;
}

if (keyboard_check(vk_up)) {
	holdUp++;	
}
else {
	holdUp = 0;
}

if (keyboard_check_pressed(ord("N")) and global.ctrlHold) {
	with(obj_panelPane) {
		showNav = not showNav;

		if (showNav) {
			showNavRight = true;	
			showNavLeft = true;
		}
		else{
			showNavRight = false;	
			showNavLeft = false;
		}
	}
}

unit1toMColAmount = min(6,ds_list_size(obj_control.tokenFieldList));
unit1to1ColAmount = min(6,ds_list_size(obj_control.unitFieldList));
chunk1to1ColAmount = min(6,ds_list_size(obj_control.chunkFieldList));;