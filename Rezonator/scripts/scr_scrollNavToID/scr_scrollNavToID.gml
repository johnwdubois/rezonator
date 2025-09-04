function scr_scrollNavToID(tab, ID, leftPane) {
	
	if (!obj_panelPane.showNav) exit;
	show_debug_message("scr_scrollNavToID, tab: " + string(tab) + ", ID: " + string(ID) + ", leftPane: " + string(leftPane));
	
	if (tab == NAVTAB_UNIT) leftPane = obj_panelPane.chainViewOneToMany;
	
	// find the instance of the nav window left & right pane
	var leftPaneInst = -1;
	var rightPaneInst = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) leftPaneInst = self.id;
		else if (currentFunction == functionChainContents) rightPaneInst = self.id;
	}
	if (!instance_exists(leftPaneInst) && leftPane) exit;
	if (!instance_exists(rightPaneInst) && !leftPane) exit;
	
	var instToScroll = leftPane ? leftPaneInst : rightPaneInst;
	var _rowHeight = -1;
	
	// check if the user is on the corresponding tab
	if (tab != leftPaneInst.functionChainList_currentTab) {
		show_debug_message("wrong tab, exiting..."); exit;
	}
	
	var docSubMap = global.nodeMap[? global.discourseNode];
	
	// find the idList that goes with this tab, make sure that list exists
	var idList = -1;
	if (leftPane) {
		if (tab == NAVTAB_CHUNK) idList = global.nodeMap[? "chunkList"];
		else if (tab == NAVTAB_RESONANCE) idList = global.nodeMap[? "resonanceNavList"];
		else if (tab == NAVTAB_TRACK) idList = global.nodeMap[? "trailNavList"];
		else if (tab == NAVTAB_STACK) idList = global.nodeMap[? "stackNavList"];
		else if (tab == NAVTAB_UNIT) idList = docSubMap[? "unitList"];
		
		_rowHeight = leftPaneInst.leftPaneStrHeight;
	}
	else {
		// if we're scrolling to a chain tab on the right pane, we will look at the current focused chain's entry list
		if (tab == NAVTAB_RESONANCE || tab == NAVTAB_TRACK || tab == NAVTAB_STACK) {
			
			if (obj_panelPane.chainViewOneToMany) {
				var currentFocusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
				if (scr_isNumericAndExists(currentFocusedChainSubMap, ds_type_map)) {
					var chainListKey = (obj_control.chain1toManyCustomSortColIndex == -1) ? "vizSetIDList" : "customSetIDList";
					idList = currentFocusedChainSubMap[? chainListKey];
				}
				
				_rowHeight = rightPaneInst.rightPaneStrHeight;
			}
			else {
				
				instToScroll = rightPaneInst;
				_rowHeight = leftPaneInst.leftPaneStrHeight;
					
				// get relevant chain list
				if (tab == NAVTAB_RESONANCE) idList = global.nodeMap[? "resonanceNavList"];
				else if (tab == NAVTAB_TRACK) idList = global.nodeMap[? "trailNavList"];
				else if (tab == NAVTAB_STACK) idList = global.nodeMap[? "stackNavList"];
					
				// find chain ID that this entry is in
				var _entryID = ID;
				var _entrySubMap = global.nodeMap[? _entryID];
				if (scr_isNumericAndExists(_entrySubMap, ds_type_map)) {
					var _chainID = _entrySubMap[? "chain"];
					ID = _chainID;
					show_debug_message("_entryID: " + string(_entryID) + ", _chainID: " + string(_chainID));
				}
			}
		}
		else if (tab == NAVTAB_UNIT) {
			
			instToScroll = rightPaneInst;
			_rowHeight = leftPaneInst.leftPaneStrHeight;
			
			if (!obj_panelPane.chainViewOneToMany) {
				idList = docSubMap[? "unitList"];
			}
		}
	}
	if (!scr_isNumericAndExists(idList, ds_type_list)) {
		show_debug_message("idList does not exist, exiting..."); exit;
	}
	var idListSize = ds_list_size(idList);
	
	// find the desired ID value within idList
	var IDindex = ds_list_find_index(idList, ID);
	show_debug_message("IDindex: " + string(IDindex));
	if (IDindex == -1) {
		show_debug_message("ID is not in idList, exiting..."); exit;
	}
	
	// calculate the y position of that ID value and scroll the left pane to it
	var headerHeight = instToScroll.functionTabs_tabHeight;
	var idRowY = instToScroll.y + headerHeight + (_rowHeight * (IDindex - 5));
	var destScrollY = -idRowY;
	var minScrollPlusY = (instToScroll.windowHeight - headerHeight) - (idListSize * _rowHeight);
	var maxScrollPlusY = 16;
	destScrollY = clamp(destScrollY, minScrollPlusY, maxScrollPlusY);

	// scroll pane
	instToScroll.scrollPlusY = destScrollY;
	instToScroll.scrollPlusYDest = destScrollY;
	
	

}