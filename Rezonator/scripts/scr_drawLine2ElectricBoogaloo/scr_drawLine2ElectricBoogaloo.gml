// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawLine2ElectricBoogaloo(){
	
	
	var camHeight = camera_get_view_height(camera_get_active());
	var camWidth = camera_get_view_width(camera_get_active());
	
	scr_setWordTopMargin();
	
	// get displayUnitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (!scr_isNumericAndExists(discourseSubMap, ds_type_map)) exit;
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) exit;
	var displayUnitListSize = ds_list_size(displayUnitList);
	
	scr_setDrawRange(camHeight, displayUnitList, displayUnitListSize);
	
	hoverTokenID = "";
	
	// loop through units
	var unitPlusY = wordTopMargin + (gridSpaceVertical * 0.5);
	for (var i = 0; i < displayUnitListSize; i++) {
		
		if (i < drawRangeStart || i > drawRangeEnd) {
			unitPlusY += gridSpaceVertical;
			continue;
		}
		
		// get current unit's submap and make sure it exists
		var currentUnit = displayUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) continue;
		var currentPixelY = floor(unitPlusY + scrollPlusY);
		currentUnitSubMap[? "pixelY"] = currentPixelY;
		var unitsInChainsList = currentUnitSubMap[? "inChainsList"];
		
		var unitsChain = "";
		if(scr_isNumericAndExists(unitsInChainsList, ds_type_list)){
			unitsChain = unitsInChainsList[|0];
		}
		
		
		
		var sectionRectY1 = currentPixelY - (gridSpaceVertical * 0.5);
		var sectionRectY2 = sectionRectY1 + gridSpaceVertical;

		//mouse rect stuff
		var mouseRectExists = (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5);
		if(mouseRectExists) {
			obj_control.mouseoverNeutralSpace = false;		
		}
		if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouseRectMade and not mouseoverPanelPane and !instance_exists(obj_dialogueBox)) {
			inMouseHoldRect = rectangle_in_rectangle(0, sectionRectY1, wordLeftMargin, sectionRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			if (inMouseHoldRect) {
				with (obj_control) {
					if (ds_list_find_index(inRectUnitIDList, currentUnit) == -1) {
						ds_list_add(inRectUnitIDList, currentUnit);
					}
				}
			}
		}

		
	
		//draw stacks
		var drawStackRect = false;
		if (obj_chain.toggleDrawStack) {
			if (ds_map_exists(global.nodeMap, unitsChain)) {
				
				var stackChainSubMap = ds_map_find_value(global.nodeMap, unitsChain);
				if (is_numeric(stackChainSubMap)) {
					if (ds_exists(stackChainSubMap, ds_type_map)) {
						var stackColor = ds_map_find_value(stackChainSubMap, "chainColor");
						var stackVisible = ds_map_find_value(stackChainSubMap, "visible");
						draw_set_color(stackColor);
						draw_set_alpha(0.2);
						if (stackVisible) drawStackRect = true;
					}
				}
			}
			else {
				if (ds_list_size(inRectUnitIDList) > 0) {
					if (ds_list_find_index(inRectUnitIDList, currentUnit) > -1) {
						
						var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
						if (is_numeric(focusedChainSubMap)) {
							if (ds_exists(focusedChainSubMap, ds_type_map)) {
								var stackColor = ds_map_find_value(focusedChainSubMap, "chainColor");
								var stackVisible = ds_map_find_value(focusedChainSubMap, "visible");
								draw_set_color(stackColor);
								draw_set_alpha(0.2);
								if (stackVisible) drawStackRect = true;
							}
						}
						
					}
				}
			}
		}

		
		if (drawStackRect) {
			var stackRectWidth = (camWidth - wordLeftMargin);
			var stackRectX1 = wordLeftMargin;
			var stackRectY1 = sectionRectY1;
			var stackRectX2 = camWidth;
			var stackRectY2 = sectionRectY2;
						
			draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
		}

		
		
		

		
		
		
		
		
		// get current unit's entryList and make sure it exists
		var currentEntryList = currentUnitSubMap[? "entryList"];
		if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) continue;
		scr_drawLineEntryList(currentEntryList, currentPixelY);
		
		// draw speaker label for this unit
		scr_drawSpeakerLabel(currentUnit, currentUnitSubMap, currentPixelY);
		
		
		
		
		
		
		
		
		unitPlusY += gridSpaceVertical;
	}
	
	// draw vertical lines to divide sections of speaker label
	var speakerLabelColXListSize = ds_list_size(speakerLabelColXList);
	for (var i = 0; i < speakerLabelColXListSize; i++) {
		var currentSectionX2 = speakerLabelColXList[| i];
		draw_set_color(global.colorThemeBG);
		draw_line(currentSectionX2, wordTopMargin, currentSectionX2, camHeight);
	}
	
	// set wordLeftMargin
	wordLeftMargin = speakerLabelColXList[| speakerLabelColXListSize - 1];
	
	scr_setSpeakerLabelColWidth();
	
	
}