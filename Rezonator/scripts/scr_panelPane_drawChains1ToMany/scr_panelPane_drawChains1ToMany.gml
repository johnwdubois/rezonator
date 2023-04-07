function scr_panelPane_drawChains1ToMany() {
	/*
		Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	*/
	
	
	
	
	var chain1toManyColFieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == NAVTAB_RESONANCE) chain1toManyColFieldList = obj_control.chain1toManyColFieldListRez;
			else if (functionChainList_currentTab == NAVTAB_TRACK) chain1toManyColFieldList = obj_control.chain1toManyColFieldListTrack;
			else if (functionChainList_currentTab == NAVTAB_STACK) chain1toManyColFieldList = obj_control.chain1toManyColFieldListStack;
		}
	}

	// INcrease the size of the utterance column!!!
	var chainListPaneWidth = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			chainListPaneWidth = windowWidth;
		}
	}

	//Set this pane to the right of the chainListPane
	x = chainListPaneWidth;

	// Set opacity, alignment, and font of contents list
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var strHeight = string_height("0");
	with (obj_panelPane) rightPaneStrHeight = strHeight;
	var tabHeight = functionTabs_tabHeight;
	var scrollBarListHeight = 0;
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + tabHeight);
	var mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + tabHeight, x + windowWidth, y + windowHeight);
	
	if (!instance_exists(obj_dropDown)) {
		obj_control.mouseoverTagShortcut = "";
	}



	if (BUILDTYPE != "Web") scr_surfaceStart();
	
	
	if (!scr_isNumericAndExists(chain1toManyColFieldList, ds_type_list)) {
		if (BUILDTYPE != "Web") scr_surfaceEnd();
		exit;
	}


	// Set text margins
	var textPlusY = 0;
	var ableToBeMouseOver = true;
	var textMarginTop = tabHeight;
	var alignRectSize = strHeight;
	var focusedElementY = -1;
	var strHeight = string_height("0");

	// Check for focused chain and make sure grid is not empty, gather information from grids
	// Collect beginning of chain info
	var chainID = functionChainContents_chainID;
	var chainSubMap = global.nodeMap[? chainID];
	
	// make sure chain exists and that its submap exists
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) {
		if (BUILDTYPE != "Web") scr_surfaceEnd();
		
		if (functionChainList_currentTab == NAVTAB_RESONANCE) {
			if (is_string(obj_chain.resonancePrevFocused) && obj_chain.resonancePrevFocused != "") {
				with (obj_panelPane) functionChainContents_chainID = obj_chain.resonancePrevFocused;
			}
		}
		else if (functionChainList_currentTab == NAVTAB_TRACK) {
			if (is_string(obj_chain.trailPrevFocused) && obj_chain.trailPrevFocused != "") {
				with (obj_panelPane) functionChainContents_chainID = obj_chain.trailPrevFocused;
			}
		}
		else if (functionChainList_currentTab == NAVTAB_STACK) {
			if (is_string(obj_chain.stackPrevFocused) && obj_chain.stackPrevFocused != "") {
				with (obj_panelPane) functionChainContents_chainID = obj_chain.stackPrevFocused;
			}
		}
		exit;
	}
	
	if (functionChainContents_chainIDPrev != chainID) {
		show_debug_message("functionChainContents_chainIDPrev changed");
		if (obj_control.chain1toManyCustomSortColIndex != -1) obj_control.refreshCustomSort = true;
	}
	with (obj_panelPane) functionChainContents_chainIDPrev = chainID;
	
	// get some cool variables from the chain
	var chainType = chainSubMap[? "type"];
	var chainAligned = chainSubMap[? "alignChain"];
	var chainFocusedEntry = chainSubMap[? "focused"];
	
	// make sure that we have a valid chain type
	if (chainType != "resonance" && chainType != "trail" && chainType != "stack") {
		with (obj_panelPane) functionChainContents_chainID = "";
		if (BUILDTYPE != "Web") scr_surfaceEnd();
		exit;
	}
	
	// make sure that the chain type that we are trying to view matches the tab we are on
	if ((chainType == "resonance" && functionChainList_currentTab != NAVTAB_RESONANCE)
	|| (chainType == "trail" && functionChainList_currentTab != NAVTAB_TRACK)
	|| (chainType == "stack" && functionChainList_currentTab != NAVTAB_STACK)) {
		with (obj_panelPane) functionChainContents_chainID = "";
		if (BUILDTYPE != "Web") scr_surfaceEnd();
		exit;
	}
	
	// whether or not we need to do a custom sort on this chain
	if (obj_control.chain1toManyCustomSortColIndex >= 0 && obj_control.refreshCustomSort) {
		obj_control.refreshCustomSort = false;
		scr_sortCustom(chainID);
	}
	
	// Get vizSetIDList list for the focused chain
	var chainListKey = (obj_control.chain1toManyCustomSortColIndex == -1) ? "vizSetIDList" : "customSetIDList";
	with (obj_panelPane) {
		functionChainContents_IDList = chainSubMap[? chainListKey];
		if (functionChainContents_IDList != undefined) {
			// Select top of the content list
			if (functionChainContents_hop > -1) {
				functionChainContents_hop = -1;
			}
		}
	}
	
	with (obj_chain) {
		if (chainType == "resonance") resonancePrevFocused = chainID;
		else if (chainType == "trail") trailPrevFocused = chainID;
		else if (chainType == "stack") stackPrevFocused = chainID;
	}
	

		
	// loop over the vizSetIDList and draw the data in each of the chain entries
	if (scr_isNumericAndExists(functionChainContents_IDList, ds_type_list)) {
			
		var entryIDListSize = ds_list_size(functionChainContents_IDList);
		scrollBarListHeight = entryIDListSize;
	
		for (var i = 0; i < entryIDListSize; i++) {
			
			if (y + textMarginTop + scrollPlusY + textPlusY < y - strHeight
			or y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
				textPlusY += strHeight;
				continue;
			}
			else if (y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
				textPlusY += strHeight;
				break;
			}
						
			// Get map of current entry
			var currentEntry = functionChainContents_IDList[| i];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
				
			// make sure the current entry's map exists
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
				
			// get the tokenID (or unitID is this is a stackChain)
			var currentID = currentEntrySubMap[? (chainType == "stack") ? "unit" : "token"];
			if (!is_string(currentID)) continue;
			var IDSubMap = global.nodeMap[?currentID];
			
			// make sure IDSubMap exists
			if (!scr_isNumericAndExists(IDSubMap, ds_type_map)) continue;
			
			var unitID = (chainType == "stack") ? currentID : IDSubMap[? "unit"];
			if (chainType != "stack") {
				if (scr_isChunk(currentID)) {
					var chunkFirstToken = scr_getFirstWordOfChunk(currentID);
					var chunkFirstTokenSubMap = global.nodeMap[? chunkFirstToken];
					if (scr_isNumericAndExists(chunkFirstTokenSubMap, ds_type_map)) {
						unitID = chunkFirstTokenSubMap[? "unit"];
					}
				}
			}
			var unitIDSubMap = global.nodeMap[? unitID];
		
			// Set size of rectangle around word
			var rectX1 = x;
			var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
			var rectX2 = x + windowWidth - global.scrollBarWidth;
			var rectY2 = rectY1 + strHeight;
			var mouseover = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader;
			var highlightEntryRect = false;
			
			// Sets the link focused in the panelPane to the link focused in the main screen
			if (chainFocusedEntry == currentEntry) {
				highlightEntryRect = true;
			}
			else if (mouseover and ableToBeMouseOver) {
				ableToBeMouseOver = false;
				highlightEntryRect = true;
			
				// if the user clicks on the currentEntry in the chainContents, let's focus the chain and its currentEntry
				if (device_mouse_check_button_released(0, mb_left) and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush) {
					obj_chain.currentFocusedChainID = chainID;
					ds_map_replace(chainSubMap, "focused", currentEntry);
				}
			}
			draw_set_alpha(1);
	
			// Check for double click
			if (mouseover) {
				if (device_mouse_check_button_released(0, mb_left)) {
					scr_jumpToUnitDoubleClick(unitID);
				}	
			}
				
			// loop across to draw all of the column values for this entry
			var currentTagMap = currentEntrySubMap[? "tagMap"];
			scr_panelPane_drawChains1ToManyInnerLoop(chain1toManyColFieldList, chainID, currentEntry, currentID, currentTagMap, textPlusY, rectY1, rectY2, highlightEntryRect, mouseoverHeader, mouseoverScrollBar);
			textPlusY += strHeight;
		}
	}
	
	
	scr_navWindowTaggingSelection(chain1toManyColFieldList, functionChainContents_IDList,"entry");

	var scrollBarListSize = 0;
	if (scr_isNumericAndExists(functionChainContents_IDList, ds_type_list)) {
		scrollBarListSize = ds_list_size(functionChainContents_IDList);
	}

	var scrollBarBackColor = global.colorThemeSelected1;
	if (scrollBarListSize > 1000) {
		scrollBarBackColor = global.colorThemeSelected2;
	}

	var colWidth = windowWidth / chain1toMColAmount;
	scr_scrollBarHorizontal(ds_list_size(chain1toManyColFieldList) + 4, colWidth, global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	scr_scrollBar(scrollBarListSize, focusedElementY, strHeight, tabHeight,
		scrollBarBackColor, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);



	scr_scrollMouseControls(strHeight);

	if (BUILDTYPE != "Web") scr_surfaceEnd();

}
