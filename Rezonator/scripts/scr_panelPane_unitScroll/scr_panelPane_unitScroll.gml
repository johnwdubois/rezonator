

function scr_panelPane_unitScroll(focusedElementY, strHeight) {
	
	var displayUnitListSize = ds_list_size(obj_control.displayUnitList);
	var headerHeight = functionTabs_tabHeight;
	
	var leftNavInst = -1;
	var rightNavInst = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) leftNavInst = self.id;
		else if (currentFunction == functionChainContents) rightNavInst = self.id;
	}
	
	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	var instToScroll = (chainViewOneToMany) ? leftNavInst : rightNavInst;
	
	if (clickedIn && obj_control.mouseoverPanelPane) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
			if (functionChainList_focusedUnitIndex > 0 and functionChainList_focusedUnitIndex < displayUnitListSize) {

				//Allow for arrow keys to shift focus down the list of lines
				with (obj_panelPane) functionChainList_focusedUnitIndex--;
				scr_clearNavWindowTagging(true);
			
				if (focusedElementY <= y + headerHeight + strHeight) {
					with (instToScroll) {
						scrollPlusYDest += max(abs(focusedElementY - (y + headerHeight + strHeight)) + strHeight, strHeight);
					}
				}
			}
			else {
				with (instToScroll) {
					scrollPlusYDest += 4;
				}
			}
		}
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
			if (functionChainList_focusedUnitIndex < displayUnitListSize - 1 and functionChainList_focusedUnitIndex >= 0) {

				//Allow for arrow keys to shift focus down the list of lines
				with (obj_panelPane) functionChainList_focusedUnitIndex++;
				scr_clearNavWindowTagging(true);

				if (focusedElementY >= y + windowHeight - strHeight) {
					with (instToScroll) {
						scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
					}
				}
			}
			else {
				with (instToScroll) {
					scrollPlusYDest -= 4;
				}
			}
		}
	
		// CTRL+UP and CTRL+DOWN
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			with (instToScroll) {
				scrollPlusYDest = 100;
			}
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
			with (instToScroll) {
				scrollPlusYDest = -999999999999;
			}
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			with (instToScroll) {
				scrollPlusYDest += (windowHeight);
			}
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			with (instToScroll) {
				scrollPlusYDest -= (windowHeight);
			}
		}
	}

}