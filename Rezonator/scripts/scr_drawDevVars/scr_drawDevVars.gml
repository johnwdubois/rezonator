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
	var focusedChainWordID = "";
	var focusedChainType = "";
	var focusedChainFocused = "";
	if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		var chainMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
		focusedChainSetIDList = ds_map_find_value(chainMap, "setIDList");
		focusedChainVizSetIDList = ds_map_find_value(chainMap, "vizSetIDList");
		focusedChainLinkIDList = ds_map_find_value(chainMap, "linkIDList");
		focusedChainType =  ds_map_find_value(chainMap, "type");
		focusedChainFocused = ds_map_find_value(chainMap, "focused");
		var focusedEntrySubMap = ds_map_find_value(global.nodeMap, focusedChainFocused);

		if (is_numeric(focusedEntrySubMap)) {			
			if (ds_exists(focusedEntrySubMap, ds_type_map)) {
				focusedChainWordID = ds_map_find_value(focusedEntrySubMap, (focusedChainType == "stackChain") ? "unit" : "word");
			}
		}
	}
	
	// draw dev vars
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 1), "allSaved: " + string(allSaved));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 2), "Right clicked word: " + string(rightClickWordID));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 3), "mouseOverPanelPane: " + string(mouseoverPanelPane));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 4), "wordTopMargin: " + string(wordTopMargin));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 5), "wordLeftMargin: " + string(wordLeftMargin));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 6), "speakerLabelColXList: " + scr_getStringOfList(speakerLabelColXList));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 7), "hoverWordID: " + string(hoverWordID));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 8), "mouseXY: (" + string(mouse_x) + ", " + string(mouse_y) + ")");
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 9), "obj_control.currentDisplayTokenColsList: " + scr_getStringOfList(obj_control.currentDisplayTokenColsList));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 10), "obj_control.currentDisplayUnitColsList: " + scr_getStringOfList(obj_control.currentDisplayUnitColsList));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 11), "window width: " + string(window_get_width()));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 12), "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 13), "currentFocusedChainID: " + string(obj_chain.currentFocusedChainID));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 14), "focusedChain's setIDList: " + ((ds_exists(focusedChainSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainSetIDList) : ""));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 15), "focusedChain's vizSetIDList: " + ((ds_exists(focusedChainVizSetIDList, ds_type_list)) ? scr_getStringOfList(focusedChainVizSetIDList) : ""));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 16), "focusedChain's linkIDList: " + ((ds_exists(focusedChainLinkIDList, ds_type_list)) ? scr_getStringOfList(focusedChainLinkIDList) : ""));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 17), "focusedChainEntry: " + string(focusedChainFocused));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 18), "focusedChainWordID: " + string(focusedChainWordID));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 19), "mouseLineWordID: " + string(obj_chain.mouseLineWordID));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 20), "toggleDrawRez: " + string(obj_chain.toggleDrawRez));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 21), "toggleDrawTrack: " + string(obj_chain.toggleDrawTrack));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 22), "nodeMap size: " + string(ds_map_size(global.nodeMap)));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 23), "chainShowList: " + scr_getStringOfList(obj_chain.chainShowList));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 24), "showNav: " + string(obj_panelPane.showNav));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 25), "mouseoverPanelPane: " + string(mouseoverPanelPane));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 26), "mouseoverTagShortcut: " + string(mouseoverTagShortcut));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 26), "mouseoverTagShortcut: " + string(mouseoverTagShortcut));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 26), "mouseoverTagShortcut: " + string(mouseoverTagShortcut));
	draw_text(camWidth - 100, wordTopMargin + (strHeight * 26), "mouseoverTagShortcut: " + string(mouseoverTagShortcut));

	
	// reset halign to left
	draw_set_halign(fa_left);

}