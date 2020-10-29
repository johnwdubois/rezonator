// Check mouse position and change the user's tool based on results
function scr_mouseToolCheck(stackChainGridHeight) {

	// If the user is within the Line number or speaker label column, switch to the stack tool
	if (point_in_rectangle(mouse_x, mouse_y, 0, wordTopMargin, speakerLabelMargin, camera_get_view_height(camera_get_active())) and obj_toolPane.currentMode != obj_toolPane.modeRead) {
	
		if (mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left) and not obj_control.rectNotInPanelPane) {
			if (ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus)
			or ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus)) {
				with (obj_chain) {
					scr_chainDeselect();
					scr_refreshVizLinkGrid();
				}
			}

			obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
		}
	}
	else {
		// If we are not in the line numbers or speaker labels, then unfocus any stacks
		if (mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left)) {
			if (ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, stackChainGridHeight, obj_chain.chainStateFocus)) {
				with (obj_chain) {
					scr_chainDeselect();
					scr_refreshVizLinkGrid();
				}
			}
		}
		
		// Ensure we're using the right tool based on the current mode
		if ((mouse_check_button(mb_left) or mouse_check_button_released(mb_left))) {// and not mouseoverNeutralSpace) {
		
			if (obj_toolPane.currentMode == obj_toolPane.modeRez) {
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
			}
			else if(obj_toolPane.currentMode == obj_toolPane.modeTrack) {
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
			}
			else {
				obj_toolPane.currentTool = obj_toolPane.toolPointer;
			}
			
			// If we are in empty space, deselect the current chain on mouseLeftClick
			if (mouseoverNeutralSpace) {
				with(obj_chain) {
					alarm[9] = 1;
				}
			}
		}
	}


}
