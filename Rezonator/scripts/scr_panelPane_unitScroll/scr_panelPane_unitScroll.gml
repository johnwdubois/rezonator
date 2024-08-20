function scr_panelPane_unitScroll(focusedElementY, strHeight) {
	
	if (live_call(focusedElementY, strHeight)) return live_result;
	
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
	
	var arrowKeyUp = keyboard_check(vk_up);
	var arrowKeyDown = keyboard_check(vk_down);
	if (!obj_panelPane.chainViewOneToMany && obj_control.navWindowTaggingID != "") {
		arrowKeyUp = false;
		arrowKeyDown = false;
	}
	
	if (clickedIn && obj_control.mouseoverPanelPane) {	
		if ((mouse_wheel_up() or arrowKeyUp) and (holdUp < 2 or holdUp > 30)) {
			
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
		
		if ((mouse_wheel_down() || arrowKeyDown) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
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
			scr_clearNavWindowTagging(true);
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
			with (instToScroll) {
				scrollPlusYDest = -999999999999;
			}
			scr_clearNavWindowTagging(true);
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			with (instToScroll) {
				scrollPlusYDest += (windowHeight);
			}
			scr_clearNavWindowTagging(true);
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			with (instToScroll) {
				scrollPlusYDest -= (windowHeight);
			}
			scr_clearNavWindowTagging(true);
		}
	}

}