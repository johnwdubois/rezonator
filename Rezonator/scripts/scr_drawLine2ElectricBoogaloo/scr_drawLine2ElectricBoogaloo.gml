// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawLine2ElectricBoogaloo(){
	
	
	var camHeight = camera_get_view_height(camera_get_active());
	
	scr_setWordTopMargin();
	
	// get displayUnitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (!scr_isNumericAndExists(discourseSubMap, ds_type_map)) exit;
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) exit;
	var displayUnitListSize = ds_list_size(displayUnitList);
	
	scr_setDrawRange(camHeight, displayUnitList, displayUnitListSize);
	
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
		
		// get current unit's entryList and make sure it exists
		var currentEntryList = currentUnitSubMap[? "entryList"];
		if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) continue;
		scr_drawLineEntryList(currentEntryList, currentPixelY);
		
		// draw speaker label for this unit
		scr_drawSpeakerLabel(currentUnitSubMap, currentPixelY);
		
		
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