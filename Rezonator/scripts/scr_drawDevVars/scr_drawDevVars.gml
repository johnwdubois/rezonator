// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
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
	draw_text(devVarX, wordTopMargin + (strHeight * 1), "allSaved: " + string(allSaved));
	draw_text(devVarX, wordTopMargin + (strHeight * 2), "rightClickID: " + string(rightClickID));
	draw_text(devVarX, wordTopMargin + (strHeight * 3), "mouseOverPanelPane: " + string(mouseoverPanelPane));
	draw_text(devVarX, wordTopMargin + (strHeight * 4), "wordTopMargin: " + string(wordTopMargin));
	draw_text(devVarX, wordTopMargin + (strHeight * 5), "wordLeftMargin: " + string(wordLeftMargin));
	draw_text(devVarX, wordTopMargin + (strHeight * 6), "speakerLabelColXList: " + scr_getStringOfList(speakerLabelColXList));
	draw_text(devVarX, wordTopMargin + (strHeight * 7), "hoverTokenID: " + string(hoverTokenID));
	draw_text(devVarX, wordTopMargin + (strHeight * 8), "mouseXY: (" + string(mouse_x) + ", " + string(mouse_y) + ")");
	draw_text(devVarX, wordTopMargin + (strHeight * 9), "currentDisplayTokenColsList: " + scr_getStringOfList(currentDisplayTokenColsList));
	draw_text(devVarX, wordTopMargin + (strHeight * 10), "currentDisplayUnitColsList: " + scr_getStringOfList(currentDisplayUnitColsList));
	draw_text(devVarX, wordTopMargin + (strHeight * 11), "window width: " + string(window_get_width()));
	draw_text(devVarX, wordTopMargin + (strHeight * 12), "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
	draw_text(devVarX, wordTopMargin + (strHeight * 13), "currentFocusedChainID: " + string(obj_chain.currentFocusedChainID));
	draw_text(devVarX, wordTopMargin + (strHeight * 14), "focusedChain's setIDList: " + ((ds_exists(focusedChainSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainSetIDList) : ""));
	draw_text(devVarX, wordTopMargin + (strHeight * 15), "focusedChain's vizSetIDList: " + ((ds_exists(focusedChainVizSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainVizSetIDList) : ""));
	draw_text(devVarX, wordTopMargin + (strHeight * 16), "focusedChainEntry: " + string(focusedChainFocused));
	draw_text(devVarX, wordTopMargin + (strHeight * 17), "global.autosaveTimer: " + string(global.autosaveTimer));
	draw_text(devVarX, wordTopMargin + (strHeight * 18), "tokenFieldList: " + scr_getStringOfList(tokenFieldList));
	draw_text(devVarX, wordTopMargin + (strHeight * 19), "navTokenFieldList: " + scr_getStringOfList(navTokenFieldList));
	draw_text(devVarX, wordTopMargin + (strHeight * 20), "navUnitFieldList: " + scr_getStringOfList(navUnitFieldList));
	draw_text(devVarX, wordTopMargin + (strHeight * 21), "nodeMap size: " + string(ds_map_size(global.nodeMap)));
	draw_text(devVarX, wordTopMargin + (strHeight * 22), "rezChainList: " + scr_getStringOfList(global.nodeMap[? "rezChainList"]));
	draw_text(devVarX, wordTopMargin + (strHeight * 23), "showNav: " + string(obj_panelPane.showNav));
	draw_text(devVarX, wordTopMargin + (strHeight * 24), "mouseoverPanelPane: " + string(mouseoverPanelPane));
	draw_text(devVarX, wordTopMargin + (strHeight * 25), "inRectTokenIDList: " + scr_getStringOfList(inRectTokenIDList));
	draw_text(devVarX, wordTopMargin + (strHeight * 26), "mouseRectXY: " + string(mouseHoldRectX1) + ", " + string(mouseHoldRectY1));
	draw_text(devVarX, wordTopMargin + (strHeight * 27), "mouseoverNeutralSpace: " + string(mouseoverNeutralSpace));
	draw_text(devVarX, wordTopMargin + (strHeight * 28), "mouseoverSpeakerLabel: " + string(mouseoverSpeakerLabel));
	draw_text(devVarX, wordTopMargin + (strHeight * 29), "inRectUnitIDList: " + scr_getStringOfList(inRectUnitIDList));
	draw_text(devVarX, wordTopMargin + (strHeight * 30), "speakerLabelColXHolding: " + string(speakerLabelColXHolding));
	draw_text(devVarX, wordTopMargin + (strHeight * 31), "speakerLabelColXHoldingDiff: " + string(speakerLabelColXHoldingDiff));
	draw_text(devVarX, wordTopMargin + (strHeight * 32), "searchGridActive: " + string(searchGridActive));
	draw_text(devVarX, wordTopMargin + (strHeight * 33), "listOfWords: " + scr_getStringOfList(listOfWords));
	draw_text(devVarX, wordTopMargin + (strHeight * 34), "functionChainContents_showID: " + string(obj_panelPane.functionChainContents_showID));
	draw_text(devVarX, wordTopMargin + (strHeight * 35), "functionChainList_playShowID: " + string(obj_panelPane.functionChainList_playShowID));
	
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 1), "showNav: " + string(obj_panelPane.showNav));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 2), "showNavLeft: " + string(obj_panelPane.showNavLeft));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 3), "showNavRight: " + string(obj_panelPane.showNavRight));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 4), "showTool: " + string(obj_toolPane.showTool));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 5), "displayTokenField: " + string(global.displayTokenField));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 6), "speakerField: " + string(global.speakerField));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 7), "currentTool: " + string(obj_toolPane.currentTool));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 8), "chainShowList: " + string(scr_getStringOfList(obj_chain.chainShowList)));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 9), "rightClickID: " + string(obj_control.rightClickID));
	draw_text(devVarX - 580, wordTopMargin + (strHeight * 10), "hoverUnitID: " + string(obj_control.hoverUnitID));

	
	// reset halign to left
	draw_set_halign(fa_left);

}