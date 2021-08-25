// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_chunkScroll(focusedElementY, strHeight){
	
	var chunkList = global.nodeMap[? "chunkList"];
	if (!scr_isNumericAndExists(chunkList, ds_type_list)) exit;
	var chunkListSize = ds_list_size(chunkList);
	var headerHeight = functionTabs_tabHeight;
	
	if (clickedIn && obj_control.mouseoverPanelPane) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
			if (functionChainList_focusedChunkIndex > 0 and functionChainList_focusedChunkIndex < chunkListSize) {

				//Allow for arrow keys to shift focus down the list of lines
				with (obj_panelPane) functionChainList_focusedChunkIndex--;
				with (obj_panelPane) functionChainList_chunkSelected = chunkList[| functionChainList_focusedChunkIndex];
				obj_chain.currentFocusedChunkID = obj_panelPane.functionChainList_chunkSelected;
			
				if (focusedElementY <= y + headerHeight + strHeight) {
					scrollPlusYDest += max(abs(focusedElementY - (y + headerHeight + strHeight)) + strHeight, strHeight);
				}
			}
			else {
				scrollPlusYDest += 4;
			}
		}
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (holdDown < 2 || holdDown > 30)) {
			
			if (functionChainList_focusedChunkIndex < chunkListSize - 1 and functionChainList_focusedChunkIndex >= 0) {

				//Allow for arrow keys to shift focus down the list of lines
				with (obj_panelPane) functionChainList_focusedChunkIndex++;
				with (obj_panelPane) functionChainList_chunkSelected = chunkList[| functionChainList_focusedChunkIndex];
				obj_chain.currentFocusedChunkID = obj_panelPane.functionChainList_chunkSelected;

				if (focusedElementY >= y + windowHeight - strHeight) {
					scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
				}
			}
			else {
				scrollPlusYDest -= 4;
			}
		}
	
		// CTRL+UP and CTRL+DOWN
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
			scrollPlusYDest = -999999999999;
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			scrollPlusYDest += (windowHeight);
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			scrollPlusYDest -= (windowHeight);
		}
	}

}