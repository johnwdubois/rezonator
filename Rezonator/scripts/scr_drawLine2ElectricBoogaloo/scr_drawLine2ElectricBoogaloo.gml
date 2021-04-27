// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawLine2ElectricBoogaloo(){
	
	// temp, please take out soon
	if (keyboard_check(vk_alt) && keyboard_check_pressed(ord("P"))) {
		show_message("filter time!");
		scr_renderFilter2(global.nodeMap[? "stackChainList"]);
	}
	
	
	
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
	mouseoverSpeakerLabel = false;
	
	// clear lists that are meant to be refreshed each frame
	ds_list_clear(obj_chain.chainShowList);
	ds_list_clear(obj_chain.chunkShowList)
	ds_list_clear(inRectWordIDList);
	ds_list_clear(chainVoidCheckList);
	ds_list_clear(inRectTokenIDList);
	ds_list_clear(inRectUnitIDList);
	
	
	// loop through units
	var unitPlusY = wordTopMargin + (gridSpaceVertical * 0.5);
	for (var i = 0; i < displayUnitListSize; i++) {
		
		// if unit is outside of draw range, do not draw its entries/tokens
		if (i < drawRangeStart || i > drawRangeEnd) {
			
			if (i > drawRangeEnd && i < drawRangeEnd + (drawRange * 0.5)) {
				var currentUnit = displayUnitList[| i];
				var currentUnitSubMap = global.nodeMap[? currentUnit];
				if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) continue;
				var currentPixelY = floor(unitPlusY + scrollPlusY);
				currentUnitSubMap[? "pixelY"] = currentPixelY;
			}
			
			unitPlusY += gridSpaceVertical;
			continue;
		}
		
		// get current unit's submap and make sure it exists
		var currentUnit = displayUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) continue;
		var currentPixelY = floor(unitPlusY + scrollPlusY);
		currentUnitSubMap[? "pixelY"] = currentPixelY;

		// draw this unit's stack if its has one
		scr_drawStack(currentUnitSubMap, camWidth, currentPixelY);
		
		// get current unit's entryList and make sure it exists
		var currentEntryList = currentUnitSubMap[? "entryList"];
		if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) continue;
		scr_drawLineEntryList(currentUnit, currentUnitSubMap, currentEntryList, currentPixelY);
		
		// draw speaker label for this unit
		scr_drawSpeakerLabel(currentUnit, currentUnitSubMap, currentPixelY);
		
		unitPlusY += gridSpaceVertical;
	}
	
	if(!obj_control.mouseoverSpeakerLabel and obj_control.hoverTokenID == "" and obj_control.hoverChunkID == "" and !obj_control.mouseoverPanelPane){
		if(device_mouse_check_button_released(0, mb_left)){
			if (global.delayInput <= 0) {
			scr_chainDeselect();
			}
		}
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