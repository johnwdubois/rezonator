/*
	obj_panelPane: Step
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Keep panel pane running smoothly
	
	Mechanism: Ensure correct funtion is being used, keep time for double clicks and scrolling
	
	Author: Terry DuBois
*/

if (obj_control.showDevVars) {
	if (keyboard_check(vk_control) and keyboard_check(vk_alt) and keyboard_check_pressed(vk_numpad0)
	and currentFunction == functionChainList) {
		instance_destroy();
	}
	if (keyboard_check(vk_control) and keyboard_check(vk_alt) and keyboard_check_pressed(vk_numpad1)
	and currentFunction == functionChainContents) {
		instance_destroy();
	}
}

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

if (keyboard_check_pressed(ord("N")) and keyboard_check(vk_control)) {
	with(obj_panelPane){
		showNav = not showNav;

		if(showNav){
			showNavRight = true;	
			showNavLeft = true;
		}
		else{
			showNavRight = false;	
			showNavLeft = false;
		}
	}
}