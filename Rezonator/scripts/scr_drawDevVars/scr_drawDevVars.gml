

function scr_drawDevVars(){
	
	// drawing settings
	draw_set_color(global.colorThemeSelected2);
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	
	var strHeight = string_height("A");
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	
	scr_adaptFont("allSaved: ","M");
	
	// get any necessary variables here
	var focusedChainSetIDList = -1;
	var focusedChainVizSetIDList = -1;
	var focusedChainLinkIDList = -1;
	var focusedChainType = "";
	var focusedChainFocused = "";
	var chunkList = global.nodeMap[? "chunkList"];
	if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		var chainMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
		focusedChainSetIDList = ds_map_find_value(chainMap, "setIDList");
		focusedChainVizSetIDList = ds_map_find_value(chainMap, "vizSetIDList");
		focusedChainLinkIDList = ds_map_find_value(chainMap, "linkIDList");
		focusedChainType =  ds_map_find_value(chainMap, "type");
		focusedChainFocused = ds_map_find_value(chainMap, "focused");
	}
	
	
	
	
	// draw dev vars
	var devVarX = camWidth - global.toolPaneWidth - global.scrollBarWidth - 20;
	draw_text(devVarX, wordTopMargin + (strHeight * 1), "autosaveTimer: " + string(global.autosaveTimer) + ", autosaveTimerFull: " + string(global.autosaveTimerFull));
	draw_text(devVarX, wordTopMargin + (strHeight * 2), "rightClickID: " + string(rightClickID));
	draw_text(devVarX, wordTopMargin + (strHeight * 3), "mouseOverPanelPane: " + string(mouseoverPanelPane));
	draw_text(devVarX, wordTopMargin + (strHeight * 4), "wordTopMargin: " + string(wordTopMargin));
	draw_text(devVarX, wordTopMargin + (strHeight * 5), "wordLeftMargin: " + string(wordLeftMargin));
	draw_text(devVarX, wordTopMargin + (strHeight * 6), "speakerLabelColXList: " + scr_getStringOfList(speakerLabelColXList));
	draw_text(devVarX, wordTopMargin + (strHeight * 7), "hoverTokenID: " + string(hoverTokenID));
	draw_text(devVarX, wordTopMargin + (strHeight * 8), "mouseXY: (" + string(mouse_x) + ", " + string(mouse_y) + ")");
	draw_text(devVarX, wordTopMargin + (strHeight * 9), "scrollPlusX: " + string(scrollPlusX));
	draw_text(devVarX, wordTopMargin + (strHeight * 10), "panelPane focusedUnitIndex: " + string(obj_panelPane.functionChainList_focusedUnitIndex));
	draw_text(devVarX, wordTopMargin + (strHeight * 11), "currentFocusedChunkID: " + string(obj_chain.currentFocusedChunkID));
	draw_text(devVarX, wordTopMargin + (strHeight * 12), "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
	draw_text(devVarX, wordTopMargin + (strHeight * 13), "currentFocusedChainID: " + string(obj_chain.currentFocusedChainID));
	draw_text(devVarX, wordTopMargin + (strHeight * 14), "focusedChain's setIDList: " + ((ds_exists(focusedChainSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainSetIDList) : ""));
	draw_text(devVarX, wordTopMargin + (strHeight * 15), "focusedChain's vizSetIDList: " + ((ds_exists(focusedChainVizSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainVizSetIDList) : ""));
	draw_text(devVarX, wordTopMargin + (strHeight * 16), "focusedChainEntry: " + string(focusedChainFocused));
	draw_text(devVarX, wordTopMargin + (strHeight * 17), "showSpeakerName: " + string(showSpeakerName));
	draw_text(devVarX, wordTopMargin + (strHeight * 18), "shortcutsEnabled: " + string(shortcutsEnabled));
	draw_text(devVarX, wordTopMargin + (strHeight * 19), "mouseoverTagCell: " + string(mouseoverTagCell));
	draw_text(devVarX, wordTopMargin + (strHeight * 20), "displayTokenList: " + scr_getStringOfList(obj_control.displayTokenList));
	draw_text(devVarX, wordTopMargin + (strHeight * 21), "nodeMap size: " + string(ds_map_size(global.nodeMap)));
	draw_text(devVarX, wordTopMargin + (strHeight * 22), "dragStartOriginalUnit: " + string(obj_chain.dragStartOriginalUnit));
	draw_text(devVarX, wordTopMargin + (strHeight * 23), "dragStartOriginalChain: " + string(obj_chain.dragStartOriginalChain));
	draw_text(devVarX, wordTopMargin + (strHeight * 24), "mouseoverPanelPane: " + string(mouseoverPanelPane));
	draw_text(devVarX, wordTopMargin + (strHeight * 25), "inRectTokenIDList: " + scr_getStringOfList(inRectTokenIDList));
	draw_text(devVarX, wordTopMargin + (strHeight * 26), "mouseRectXY: " + string(mouseHoldRectX1) + ", " + string(mouseHoldRectY1));
	draw_text(devVarX, wordTopMargin + (strHeight * 27), "panelPane scrollPlusY_tabUnit: " + string(obj_panelPane.scrollPlusY_tabUnit));
	draw_text(devVarX, wordTopMargin + (strHeight * 28), "panelPane tokenTagSelected: " + string(obj_panelPane.functionField_tokenTagSelected));
	draw_text(devVarX, wordTopMargin + (strHeight * 29), "inRectEntryIDList: " + scr_getStringOfList(inRectEntryIDList));
	draw_text(devVarX, wordTopMargin + (strHeight * 30), "speakerLabelColXHolding: " + string(speakerLabelColXHolding));
	draw_text(devVarX, wordTopMargin + (strHeight * 31), "speakerLabelColXHoldingDiff: " + string(speakerLabelColXHoldingDiff));
	draw_text(devVarX, wordTopMargin + (strHeight * 32), "filteredStackChainList: " + scr_getStringOfList(obj_chain.filteredStackChainList));
	draw_text(devVarX, wordTopMargin + (strHeight * 33), "selectedStackChainList: " + scr_getStringOfList(selectedStackChainList));
	draw_text(devVarX, wordTopMargin + (strHeight * 34), "functionChainContents_showID: " + string(obj_panelPane.functionChainContents_showID));
	draw_text(devVarX, wordTopMargin + (strHeight * 35), "functionChainList_playShowID: " + string(obj_panelPane.functionChainList_playShowID));
	
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 1), "showNav: " + string(obj_panelPane.showNav));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 2), "showNavLeft: " + string(obj_panelPane.showNavLeft));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 3), "selectedTagList: " + scr_getStringOfList(selectedTagList));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 4), "navWindowTaggingSingleOptionSelect: " + string(navWindowTaggingSingleOptionSelect));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 5), "displayTokenField: " + string(global.displayTokenField));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 6), "participantField: " + string(global.participantField));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 7), "doubleClickTimer: " + string(doubleClickTimer));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 8), "chainShowList: " + string(scr_getStringOfList(obj_chain.chainShowList)));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 9), "rightClickID: " + string(obj_control.rightClickID));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 10), "hoverUnitID: " + string(obj_control.hoverUnitID));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 11), "currentFocusedEntryID: " + string(obj_chain.currentFocusedEntryID));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 12), "audioClosestUnit: " + string(obj_audioUI.closestUnit));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 13), "endRangeMin: " + string(obj_control.drawRangeEndMin));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 14), "quickPickedChainID: " + string(obj_control.quickPickedChainID));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 15), "mergeUnitList: " + scr_getStringOfList(mergeUnitList));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 16), "navWindowTaggingField: " + string(navWindowTaggingField));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 17), "navWindowTaggingID: " + string(navWindowTaggingID));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 18), "navWindowTaggingFocusHeavy: " + string(navWindowTaggingFocusHeavy));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 19), "mergeToken : " + string(mergeToken));

	
	// reset halign to left
	draw_set_halign(fa_left);

}