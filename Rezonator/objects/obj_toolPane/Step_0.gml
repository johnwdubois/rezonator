// Check for user inputs to switch between chain tools
if (!obj_control.gridView) {
	if (keyboard_check_pressed(ord("R"))) {
		with (obj_chain) {
			scr_chainDeselect();
		}
		currentTool = toolRezBrush;
	}
	else if (keyboard_check_pressed(ord("T"))) {
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
	
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
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