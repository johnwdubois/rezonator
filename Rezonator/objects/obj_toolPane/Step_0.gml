// Check for user inputs to switch between chain tools
if (!obj_control.gridView and !obj_control.dialogueBoxActive) {
	if (keyboard_check_pressed(ord("R"))) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolRezBrush;
	}
	else if (keyboard_check_pressed(ord("T")) and not keyboard_check(vk_control)) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolTrackBrush;
	}
	else if (keyboard_check_pressed(ord("K"))) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolStackBrush;
	}
	else if (keyboard_check_pressed(ord("B"))) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolBoxBrush;
	}
	else if (keyboard_check_pressed(ord("M"))) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolPointer;
	}
	else if (keyboard_check_pressed(ord("N")) and not keyboard_check(vk_control)) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolNewWord;
	}
	if (keyboard_check_pressed(ord("T")) and keyboard_check(vk_control)) {
		showTool = not showTool;	
	}
	
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab != functionChainList_tabClique) {
				if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
					functionChainList_currentTab = functionChainList_tabRezBrush;
				}
				else if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
					functionChainList_currentTab = functionChainList_tabTrackBrush;
				}
				else if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
					functionChainList_currentTab = functionChainList_tabStackBrush;
				}
			}
		}
	}
}

global.toolPaneWidth = windowWidth;

originalWindowHeight = obj_menuBar.menuHeight;