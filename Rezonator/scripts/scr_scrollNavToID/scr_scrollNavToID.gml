// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_scrollNavToID(tab, ID){
	
	show_debug_message("scr_scrollNavToID, tab: " + string(tab) + ", ID: " + string(ID));
	
	// find the instance of the nav window left pane
	var leftPaneInst = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) leftPaneInst = self.id;
	}
	if (!instance_exists(leftPaneInst)) exit;
	
	// check if the user is on the corresponding tab
	if (tab != leftPaneInst.functionChainList_currentTab) {
		show_debug_message("wrong tab, exiting..."); exit;
	}
	
	// find the idList that goes with this tab, make sure that list exists
	var idList = -1;
	if (tab == obj_panelPane.functionChainList_tabChunk) idList = global.nodeMap[? "chunkList"];
	else if (tab == obj_panelPane.functionChainList_tabRezBrush) idList = global.nodeMap[? "rezChainList"];
	else if (tab == obj_panelPane.functionChainList_tabTrackBrush) idList = global.nodeMap[? "trackChainList"];
	else if (tab == obj_panelPane.functionChainList_tabStackBrush) idList = global.nodeMap[? "stackChainList"];
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
	var headerHeight = leftPaneInst.functionTabs_tabHeight;
	var strHeight = leftPaneInst.leftPaneStrHeight;
	var idRowY = leftPaneInst.y + headerHeight + (strHeight * (IDindex - 5));
	
	var destScrollY = -idRowY;
	var minScrollPlusY = (leftPaneInst.windowHeight - headerHeight) - (idListSize * strHeight);
	var maxScrollPlusY = 16;
	destScrollY = clamp(destScrollY, minScrollPlusY, maxScrollPlusY);

	leftPaneInst.scrollPlusY = destScrollY;
	leftPaneInst.scrollPlusYDest = destScrollY;
	

	

	

}