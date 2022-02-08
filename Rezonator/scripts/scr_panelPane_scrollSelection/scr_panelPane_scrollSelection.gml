function scr_panelPane_scrollSelection(focusedElementY, strHeight){
	
	var leftPaneInst = -1;
	var rightPaneInst = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) leftPaneInst = self.id;
		else if (currentFunction == functionChainContents) rightPaneInst = self.id;
	}
	if (!instance_exists(leftPaneInst) || !instance_exists(rightPaneInst)) exit;
	var mouseoverLeftPane = point_in_rectangle(mouse_x, mouse_y, leftPaneInst.x, leftPaneInst.y, leftPaneInst.x + leftPaneInst.windowWidth, leftPaneInst.y + leftPaneInst.windowHeight);
	var mouseoverRightPane = point_in_rectangle(mouse_x, mouse_y, rightPaneInst.x, rightPaneInst.y, rightPaneInst.x + rightPaneInst.windowWidth, rightPaneInst.y + rightPaneInst.windowHeight);
	
	// get list of thing to scroll based on tab, make sure that list exists
	var onChunkTab = obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabChunk;
	var onTreeTab = obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTree;
	var onTagTabLeft = obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabField && mouseoverLeftPane;
	var onTagTabRight = obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabField && mouseoverRightPane;
	var listKey = "";
	if (onChunkTab) listKey = "chunkList";
	else if (onTreeTab) listKey = "treeList";
	var list = -1;
	if (onTagTabLeft) list = obj_panelPane.functionTag_fieldList;
	else if (onTagTabRight) list = obj_panelPane.functionTag_tagList;
	else {
		list = global.nodeMap[? listKey];
	}
	if (!scr_isNumericAndExists(list, ds_type_list)) exit;
	
	var listSize = ds_list_size(list);
	var headerHeight = functionTabs_tabHeight;
	
	if (clickedIn && obj_control.mouseoverPanelPane) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
			if (functionChainList_focusedIndex > 0 and functionChainList_focusedIndex < listSize) {

				//Allow for arrow keys to shift focus down the list of lines
				with (obj_panelPane) functionChainList_focusedIndex--;
				if (onChunkTab) {
					with (obj_panelPane) functionChainList_chunkSelected = list[| functionChainList_focusedIndex];
					obj_chain.currentFocusedChunkID = obj_panelPane.functionChainList_chunkSelected;
				}
				else if (onTreeTab) {
					with (obj_panelPane) functionTree_treeSelected = list[| functionChainList_focusedIndex];
				}
				else if (onTagTabLeft) {
					ds_list_clear(obj_control.selectedTagList);
					if (fieldPaneSwitchButton == fieldPaneTokenMode) with (obj_panelPane) functionField_tokenFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneEntryMode) with (obj_panelPane) functionField_entryFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneUnitMode) with (obj_panelPane) functionField_unitFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChainMode) with (obj_panelPane) functionField_chainFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChunkMode) with (obj_panelPane) functionField_chunkFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneLinkMode) with (obj_panelPane) functionField_linkFieldSelected = list[| functionChainList_focusedIndex];

				}
				else if (onTagTabRight) {
					if (fieldPaneSwitchButton == fieldPaneTokenMode) with (obj_panelPane) functionField_tokenTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneEntryMode) with (obj_panelPane) functionField_entryTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneUnitMode) with (obj_panelPane) functionField_unitTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChainMode) with (obj_panelPane) functionField_chainTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChunkMode) with (obj_panelPane) functionField_chunkTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneLinkMode) with (obj_panelPane) functionField_linkTagSelected = list[| functionChainList_focusedIndex];
				}
			
				if (focusedElementY <= y + headerHeight + strHeight) {
					scrollPlusYDest += max(abs(focusedElementY - (y + headerHeight + strHeight)) + strHeight, strHeight);
				}
			}
			else {
				scrollPlusYDest += 4;
			}
		}
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (holdDown < 2 || holdDown > 30)) {
			
			if (functionChainList_focusedIndex < listSize - 1 and functionChainList_focusedIndex >= 0) {

				//Allow for arrow keys to shift focus down the list of lines
				with (obj_panelPane) functionChainList_focusedIndex++;
				if (onChunkTab) {
					with (obj_panelPane) functionChainList_chunkSelected = list[| functionChainList_focusedIndex];
					obj_chain.currentFocusedChunkID = obj_panelPane.functionChainList_chunkSelected;
				}
				else if (onTreeTab) {
					with (obj_panelPane) functionTree_treeSelected = list[| functionChainList_focusedIndex];
				}
				else if (onTagTabLeft) {

					if (fieldPaneSwitchButton == fieldPaneTokenMode) with (obj_panelPane) functionField_tokenFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneEntryMode) with (obj_panelPane) functionField_entryFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneUnitMode) with (obj_panelPane) functionField_unitFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChainMode) with (obj_panelPane) functionField_chainFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChunkMode) with (obj_panelPane) functionField_chunkFieldSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneLinkMode) with (obj_panelPane) functionField_linkFieldSelected = list[| functionChainList_focusedIndex];
					
				}
				else if (onTagTabRight) {

					if (fieldPaneSwitchButton == fieldPaneTokenMode) with (obj_panelPane) functionField_tokenTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneEntryMode) with (obj_panelPane) functionField_entryTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneUnitMode) with (obj_panelPane) functionField_unitTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChainMode) with (obj_panelPane) functionField_chainTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneChunkMode) with (obj_panelPane) functionField_chunkTagSelected = list[| functionChainList_focusedIndex];
					else if (fieldPaneSwitchButton == fieldPaneLinkMode) with (obj_panelPane) functionField_linkTagSelected = list[| functionChainList_focusedIndex];

				}
				
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