

function scr_drawLine2ElectricBoogaloo(){
	
	
	scr_adaptFont("0", "M");
	
	var camHeight = camera_get_view_height(camera_get_active());
	var camWidth = camera_get_view_width(camera_get_active());
	
	scr_setWordTopMargin();
	
	startJustify = scr_checkNativeJustification();


	// get displayUnitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (!scr_isNumericAndExists(discourseSubMap, ds_type_map)) exit;
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	var unitList = discourseSubMap[? "unitList"];
	
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) {
		if(scr_isNumericAndExists(unitList, ds_type_list)){
			discourseSubMap[? "displayUnitList"] = unitList;
			displayUnitList = discourseSubMap[? "displayUnitList"];
			obj_control.displayUnitList = displayUnitList;
		}
		else{
			exit;
		}
	}
	var displayUnitListSize = ds_list_size(displayUnitList);
	
	scr_setDrawRange(camHeight, displayUnitList, displayUnitListSize);
	
	hoverTokenID = "";
	hoverUnitID = "";


	mouseoverSpeakerLabel = false;
	
	
	// destroy the lists in the chainShowMap
	var chainShowListSize = ds_list_size(obj_chain.chainShowList);
	for (var i = 0; i < chainShowListSize; i++) {
		var currentChainShow = obj_chain.chainShowList[| i];
		var currentChainShowSubMap = obj_chain.chainShowMap[? currentChainShow];
		var currentChainShowList = currentChainShowSubMap[? "entryList"];
		ds_list_destroy(currentChainShowList);
		ds_map_destroy(currentChainShowSubMap);
	}
	
	// clear lists that are meant to be refreshed each frame
	if(scr_isNumericAndExists(obj_chain.chainShowMap, ds_type_map)){
		ds_map_clear(obj_chain.chainShowMap);
		ds_map_add(obj_chain.chainShowMap, "type", "map");
	}
	ds_list_clear(obj_chain.chainShowList);

	
	// destroy the lists in the chainShowMap
	var chunkShowMapSize = ds_map_size(obj_chain.chunkShowMap);
	for (var i = 0; i < chunkShowMapSize; i++) {
		var currentNest = string(i);
		var currentNestList = obj_chain.chunkShowMap[? currentNest];
		if(scr_isNumericAndExists(currentNestList, ds_type_list)){
			ds_list_destroy(currentNestList);
		}
	}
	
	// clear lists that are meant to be refreshed each frame
	ds_map_clear(obj_chain.chunkShowMap);
	//ds_map_add(obj_chain.chunkShowMap, "type", "map");
	ds_list_clear(obj_chain.chunkShowList);
	
	
	
	
	
	ds_list_clear(inRectWordIDList);
	ds_list_clear(chainVoidCheckList);
	ds_list_clear(inRectTokenIDList);
	ds_list_clear(inRectUnitIDList);
	
	
	var oobRectX1 = (justify == justifyLeft) ? 0 : camWidth;
	var oobRectY1 = 0;
	var oobRectX2 = 0;			
	if(justify == justifyLeft){
		if((drawLineState == lineState_rtl && shape == shapeBlock)){
			oobRectX2 = wordLeftMargin - scrollPlusX - gridSpaceHorizontal;
		}
		else{
			oobRectX2 = wordLeftMargin + scrollPlusX;
		}
	}
	else{
		oobRectX2 = (drawLineState == lineState_rtl && shape == shapeBlock) ? camWidth - global.toolPaneWidth - scrollPlusX : camWidth - global.toolPaneWidth + scrollPlusX;
	}
	
	var oobRectY2 = camHeight;

	draw_set_alpha(1);
	draw_set_color(global.colorThemeOutOfBounds);
	draw_rectangle(oobRectX1,oobRectY1,oobRectX2,oobRectY2,false);
	
	unitClosestToMouse = "";
	var minUnitDistToMouse = 999999999999;
	
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
		
		
		// speed up drawRange adjustment
		if (i == drawRangeStart && currentPixelY < 0) {
			drawRangeStart += 2;
			drawRangeEnd += 2;
		}
		
		//draw unit if selected for merge
		var inMergeUnitList = (ds_list_find_index(mergeUnitList,currentUnit)>-1);
		if(keyboard_check(vk_alt) && inMergeUnitList){
			var unitY1 = floor(currentUnitSubMap[? "pixelY"] - gridSpaceVertical/2 -1);
			var unitY2 = floor(currentUnitSubMap[? "pixelY"] + gridSpaceVertical/2 -3);
			draw_set_color(merge_color(global.colorThemeGrid_colSelected1, c_white, 0.8));
			draw_rectangle(0,unitY1,obj_toolPane.x , unitY2, false);
		}
		
		
		// check if this unit should be added to unitRectList
		if (makingRect && mouse_check_button(mb_left)) {
			var inMouseHoldRect = (min(mouse_y, mouseHoldRectY1) < currentPixelY + (gridSpaceVertical * 0.5) && max(mouse_y, mouseHoldRectY1) > currentPixelY - (gridSpaceVertical * 0.5));
			if (instance_exists(obj_dialogueBox) || instance_exists(obj_dropDown)) inMouseHoldRect = true;
			if (inMouseHoldRect) {
				scr_addToListOnce(inRectUnitIDList, currentUnit);
			}
		}
		
		// check if this is the closest unit to the mouse
		var currentUnitDistToMouse = point_distance(mouse_x, currentPixelY, mouse_x, mouse_y);
		if (currentUnitDistToMouse < minUnitDistToMouse) {
			minUnitDistToMouse = currentUnitDistToMouse;
			unitClosestToMouse = currentUnit;
		}

		// draw this unit's stack if its has one
		scr_drawStack(currentUnit, currentUnitSubMap, camWidth, currentPixelY);
		
		// get current unit's entryList and make sure it exists
		var currentEntryList = currentUnitSubMap[? "entryList"];
		if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) continue;
		scr_drawLineEntryList(currentUnit, currentUnitSubMap, currentEntryList, currentPixelY, true);
		
		// draw speaker label for this unit
		scr_drawSpeakerLabel(currentUnit, currentUnitSubMap, currentPixelY);
		
		unitPlusY += gridSpaceVertical;
	}
	
	if(!obj_control.mouseoverSpeakerLabel and obj_control.hoverTokenID == "" and obj_control.hoverChunkID == "" and !obj_control.mouseoverPanelPane and !(instance_exists(obj_dropDown) and obj_control.rightClicked) and !instance_exists(obj_dialogueBox)){
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
		if( i == 0 ){
			currentSectionX2 -= 1;
		}
		draw_set_color(global.colorThemeBG);
		draw_line(currentSectionX2, wordTopMargin, currentSectionX2, camHeight);
	}
	var hoverLine = false;
	if (instance_exists(obj_audioUI)) {
		if (obj_audioUI.audioJumpOnWordClick && unitClosestToMouse != "" && !obj_control.mouseoverPanelPane && !obj_toolPane.mouseOverToolPane && !obj_audioUI.mouseOverAudioUI && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
			hoverLine = true;
			obj_control.hoverUnitID = unitClosestToMouse;
			
			if(mouse_check_button_released(mb_left) && obj_audioUI.audioSound != -1 && file_exists(obj_audioUI.audioFile) ){
				
				scr_audioJumpToUnit(unitClosestToMouse);
				obj_audioUI.audioPaused = false;
			}
		}
	}
	
	
	//draw the hover lines for each unit
	if(hoverLine or (is_string(obj_control.hoverUnitID) && obj_control.hoverUnitID != "" && !mouse_check_button(mb_left)
		&& obj_toolPane.currentMode != obj_toolPane.modeRead && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox))){
		var currentUnitSubMap = global.nodeMap[? obj_control.hoverUnitID];
		var unitY1 = floor(currentUnitSubMap[? "pixelY"] - gridSpaceVertical/2 -1);
		var unitY2 = floor(currentUnitSubMap[? "pixelY"] + gridSpaceVertical/2 -3);
		draw_set_color(merge_color(global.colorThemeGrid_colSelected1, c_white, 0.5));
		draw_rectangle(0,unitY1,obj_toolPane.x , unitY2, true);
	}


	
	// set wordLeftMargin
	wordLeftMargin = speakerLabelColXList[| speakerLabelColXListSize - 1];
	
	scr_setSpeakerLabelColWidth();
	
	
	if (scrollBarHolding) {
		global.delayInput = 5;
	}
	
	
	updateChainShowMap = false;
	
	
	
	// merge units list (temp?)
	if (keyboard_check(vk_alt) && keyboard_check_released(ord("U")) && obj_control.shortcutsEnabled) {
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							
			obj_dialogueBox.questionWindowActive = true;
			obj_dialogueBox.mergeUnit = true;
		}
		//scr_mergeUnit();
	}
	if (mouse_check_button_released(mb_left)) {
		scr_addToListOnce(mergeUnitList, unitClosestToMouse, true);
		if (ds_list_size(mergeUnitList) > 2) {
			ds_list_delete(mergeUnitList, 2);
		}
	}
	
}