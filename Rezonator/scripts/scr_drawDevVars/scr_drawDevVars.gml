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
	draw_text(devVarX, wordTopMargin + (strHeight * 2), "Right clicked word: " + string(rightClickWordID));
	draw_text(devVarX, wordTopMargin + (strHeight * 3), "mouseOverPanelPane: " + string(mouseoverPanelPane));
	draw_text(devVarX, wordTopMargin + (strHeight * 4), "wordTopMargin: " + string(wordTopMargin));
	draw_text(devVarX, wordTopMargin + (strHeight * 5), "wordLeftMargin: " + string(wordLeftMargin));
	draw_text(devVarX, wordTopMargin + (strHeight * 6), "speakerLabelColXList: " + scr_getStringOfList(speakerLabelColXList));
	draw_text(devVarX, wordTopMargin + (strHeight * 7), "hoverWordID: " + string(hoverWordID));
	draw_text(devVarX, wordTopMargin + (strHeight * 8), "mouseXY: (" + string(mouse_x) + ", " + string(mouse_y) + ")");
	draw_text(devVarX, wordTopMargin + (strHeight * 9), "obj_control.currentDisplayTokenColsList: " + scr_getStringOfList(obj_control.currentDisplayTokenColsList));
	draw_text(devVarX, wordTopMargin + (strHeight * 10), "obj_control.currentDisplayUnitColsList: " + scr_getStringOfList(obj_control.currentDisplayUnitColsList));
	draw_text(devVarX, wordTopMargin + (strHeight * 11), "window width: " + string(window_get_width()));
	draw_text(devVarX, wordTopMargin + (strHeight * 12), "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
	draw_text(devVarX, wordTopMargin + (strHeight * 13), "currentFocusedChainID: " + string(obj_chain.currentFocusedChainID));
	draw_text(devVarX, wordTopMargin + (strHeight * 14), "focusedChain's setIDList: " + ((ds_exists(focusedChainSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainSetIDList) : ""));
	draw_text(devVarX, wordTopMargin + (strHeight * 15), "focusedChain's vizSetIDList: " + ((ds_exists(focusedChainVizSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainVizSetIDList) : ""));
	draw_text(devVarX, wordTopMargin + (strHeight * 16), "focusedChainEntry: " + string(focusedChainFocused));
	draw_text(devVarX, wordTopMargin + (strHeight * 17), "focusedChainWordID: " + string(obj_chain.focusedChainWordID));
	draw_text(devVarX, wordTopMargin + (strHeight * 18), "mouseLineWordID: " + string(obj_chain.mouseLineWordID));
	draw_text(devVarX, wordTopMargin + (strHeight * 19), "toggleDrawRez: " + string(obj_chain.toggleDrawRez));
	draw_text(devVarX, wordTopMargin + (strHeight * 20), "toggleDrawTrack: " + string(obj_chain.toggleDrawTrack));
	draw_text(devVarX, wordTopMargin + (strHeight * 21), "nodeMap size: " + string(ds_map_size(global.nodeMap)));
	draw_text(devVarX, wordTopMargin + (strHeight * 22), "rezChainList: " + scr_getStringOfList(global.nodeMap[? "rezChainList"]));
	draw_text(devVarX, wordTopMargin + (strHeight * 23), "showNav: " + string(obj_panelPane.showNav));
	draw_text(devVarX, wordTopMargin + (strHeight * 24), "mouseoverPanelPane: " + string(mouseoverPanelPane));
	draw_text(devVarX, wordTopMargin + (strHeight * 25), "mouseoverTagShortcut: " + string(mouseoverTagShortcut));
	draw_text(devVarX, wordTopMargin + (strHeight * 26), "scrollBarWidth: " + string(global.scrollBarWidth));
	draw_text(devVarX, wordTopMargin + (strHeight * 27), "filteredRezChainList: " + scr_getStringOfList(obj_chain.filteredRezChainList));
	draw_text(devVarX, wordTopMargin + (strHeight * 28), "filteredTrackChainList: " + scr_getStringOfList(obj_chain.filteredTrackChainList));
	draw_text(devVarX, wordTopMargin + (strHeight * 29), "filteredStackChainList: " + scr_getStringOfList(obj_chain.filteredStackChainList));
	draw_text(devVarX, wordTopMargin + (strHeight * 30), "filterActiveRez: " + string(filterActiveRez));
	draw_text(devVarX, wordTopMargin + (strHeight * 31), "filterActiveTrack: " + string(filterActiveTrack));
	draw_text(devVarX, wordTopMargin + (strHeight * 32), "filterActiveStack: " + string(filterActiveStack));
	draw_text(devVarX, wordTopMargin + (strHeight * 33), "filterGridActive: " + string(filterGridActive));
	draw_text(devVarX, wordTopMargin + (strHeight * 34), "setModeSearch: " + string(obj_toolPane.setModeSearch));
	draw_text(devVarX, wordTopMargin + (strHeight * 35), "chunkShowList: " + scr_getStringOfList(obj_chain.chunkShowList));
	draw_text(devVarX, wordTopMargin + (strHeight * 36), "focusedChainWrongTool: " + string(obj_chain.focusedChainWrongTool));
	
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 1), "showNav: " + string(obj_panelPane.showNav));
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 2), "showNavLeft: " + string(obj_panelPane.showNavLeft));
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 3), "showNavRight: " + string(obj_panelPane.showNavRight));
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 4), "showTool: " + string(obj_toolPane.showTool));
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 5), "tokenImportDisplayTokenColName: " + string(global.tokenImportDisplayTokenColName));
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 6), "tokenImportTranscriptColName: " + string(global.tokenImportTranscriptColName));
	draw_text(devVarX - 550, wordTopMargin + (strHeight * 7), "wordView: " + string(wordView));

	
	// reset halign to left
	draw_set_halign(fa_left);

}