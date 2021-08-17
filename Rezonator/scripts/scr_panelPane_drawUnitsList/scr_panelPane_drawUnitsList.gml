function scr_panelPane_drawUnitsList() {


	

	var strHeight = string_height("0") * 1.5;
	var spaceWidth = string_width(" ");
	
	with (obj_panelPane) leftPaneStrHeight = strHeight;
	
	var drawScrollbar = (chainViewOneToMany or functionChainList_currentTab == functionChainList_tabTranslations);
	var scrollBarWidth = global.scrollBarWidth;
	
	// get the instance ID for the lineContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : chainContentsPanelPaneInst.scrollPlusY;
	
	
	

	// Set text margin area
	var filterRectSize = (strHeight / 2) + 5;
	var unitSeqRectWidth = (filterRectSize * 2);
	var speakerRectWidth = (obj_control.showSpeakerName) ? (windowWidth / 3) : 0;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var textAdjustY = 0;
	var textBuffer = 8;
	var mouseoverHeaderRegion = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	var mouseoverScrollBar = false;
	if (drawScrollbar) {
		mouseoverScrollBar = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y + headerHeight, x + windowWidth, y + windowHeight);
	}
	
	// if mouse is hovered on header region, make sure there is no line highlighted
	if (mouseoverHeaderRegion || !obj_control.mouseoverPanelPane) {
		with (obj_panelPane) {
			functionChainList_highlightUnit = "";
		}
	}
	
	var focusedElementY = -1;
	var focusedRowRectY1 = -1;
	var focusedRowRectY2 = -1;


	var displayUnitList = obj_control.displayUnitList;
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) exit;
	var displayUnitListSize = ds_list_size(displayUnitList);
	

	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);

	scr_surfaceStart();
	


	var mouseInPane = obj_control.mouseoverPanelPane;
	for (var i = 0; i < displayUnitListSize; i++) {
	
		if (y + headerHeight + relativeScrollPlusY + textPlusY < y - strHeight) {
			textPlusY += strHeight;
			continue;
		}
		if (y + headerHeight + relativeScrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			break;
		}
	
		// get current unitID and its submap, and also its tagmap!
		var currentUnitID = displayUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnitID];
		if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) continue;
		var currentTagMap = currentUnitSubMap[? "tagMap"];
		if (!scr_isNumericAndExists(currentTagMap, ds_type_map)) continue;
		
		// get data from unit
		var currentUnitSeq = currentUnitSubMap[? "unitSeq"];
		var currentSpeaker = currentTagMap[? global.speakerField];
		var currentSpeakerColor = scr_strToColor(currentSpeaker);
		if (!is_numeric(currentSpeakerColor)) currentSpeakerColor = global.colorThemeSelected1;
		var currentEntryList = currentUnitSubMap[? "entryList"];
		var currentEntryListSize = 0;
		if (scr_isNumericAndExists(currentEntryList, ds_type_list)) currentEntryListSize = ds_list_size(currentEntryList);
		var currentUnitText = scr_getUnitText(currentUnitSubMap);
		
		
	
		// get coordinates of unit rect within panelpane
		var currentUnitRectX1 = x;
		var currentUnitRectY1 = y + headerHeight + textPlusY + relativeScrollPlusY - (strHeight / 2);
		var currentUnitRectX2 = x + windowWidth - scrollBarWidth;
		var currentUnitRectY2 = currentUnitRectY1 + strHeight;
		
		if (functionChainList_highlightUnit == currentUnitID) {
			draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.4));
			draw_rectangle(currentUnitRectX1 - clipX, currentUnitRectY1 - clipY, currentUnitRectX2 + scrollBarWidth - clipX, currentUnitRectY2 - clipY, false);
		}
	
		scr_panelPane_mouseOnLine(currentUnitRectX1, currentUnitRectY1, currentUnitRectX2, currentUnitRectY2, currentUnitID, i, currentSpeakerColor, mouseoverHeaderRegion, mouseoverScrollBar,currentUnitText);
		
	
	
		// get position of focused rect
		if (functionChainList_focusedUnitIndex == i) {
			focusedRowRectY1 = currentUnitRectY1;
			focusedRowRectY2 = currentUnitRectY2;
			focusedElementY = y + headerHeight + relativeScrollPlusY + textPlusY;
			with (obj_panelPane) {
				functionChainList_focusedUnit = currentUnitID;
			}
		}
	
		// get speaker rect coordinates
		var speakerRectX1 = floor(currentUnitRectX1 + unitSeqRectWidth);
		var speakerRectX2 = speakerRectX1;
		if (ds_list_size(obj_control.speakerLabelColXList) > 1) {
			speakerRectX2 = floor(speakerRectX1 + speakerRectWidth);
		}
	
		// get x position of text, and adjust for RTL if needed
		var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
		var textX = lineStateLTR ? floor(speakerRectX2 + textBuffer) : floor(x + windowWidth - scrollBarWidth);
		var textY = floor(y + headerHeight + relativeScrollPlusY + textPlusY + textAdjustY / 2);

		// draw line string
		draw_set_halign(lineStateLTR ? fa_left : fa_right);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(currentUnitText, "M");
		draw_text(textX - clipX, textY - clipY, currentUnitText);
		
		// draw speaker rect & name (if we have to)
		if (ds_list_size(obj_control.speakerLabelColXList) > 1) {
			draw_set_color(merge_color(currentSpeakerColor, global.colorThemeBG, 0.4)); //soften the color
			draw_rectangle(speakerRectX1 - clipX, currentUnitRectY1 - clipY, speakerRectX2 - clipX, currentUnitRectY2 - clipY - 2, false);
			
			currentSpeaker = scr_adaptFont(currentSpeaker, "M");
			draw_set_color(scr_textColorDarkOrLight(currentSpeakerColor));
			draw_set_halign(lineStateLTR ? fa_left : fa_right);
			var speakerTextX = lineStateLTR ? floor(speakerRectX1 + textBuffer) : floor(speakerRectX2);
			draw_text(speakerTextX - clipX, textY - clipY, currentSpeaker);
		}
		
		
		// draw unitSeq rect & text
		draw_set_color(global.colorThemeSelected1); //soften the color
		draw_rectangle(currentUnitRectX1 - clipX, currentUnitRectY1 - clipY, currentUnitRectX1 + unitSeqRectWidth - clipX, currentUnitRectY2 - clipY - 2, false);
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(floor(x + spaceWidth) - clipX, textY - clipY, string(currentUnitSeq));
		
	
		// increment plusY
		textPlusY += strHeight;
		
	}


	scr_panelPane_unitScroll(focusedElementY, strHeight);




	
	
	// draw focus outline
	if (focusedRowRectY1 > -1 and focusedRowRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		draw_line_width(x - clipX, focusedRowRectY1 - clipY, x + windowWidth - clipX, focusedRowRectY1 - clipY, 4);
		draw_line_width(x - clipX, focusedRowRectY2 - clipY, x + windowWidth - clipX, focusedRowRectY2 - clipY, 4);
	}

	// only show a scrollbar if we're in 1toMany
	if (drawScrollbar) {
		scr_scrollBar(displayUnitListSize, focusedElementY, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}



	scr_surfaceEnd();
	
	
	
	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i < 3; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = unitSeqRectWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = speakerRectWidth;
			colText = "Speaker";
		}
		else if (i == 2) {
			colWidth = windowWidth - unitSeqRectWidth - speakerRectWidth;
			colText = "Text";
		}
		
		// get header coordinates
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX, headerTextY, colText);
		
		
		headerPlusX += colWidth;
	}
	

	

	// draw short line to separate left nav from right nav
	draw_set_color(global.colorThemeBorders);
	draw_line(x + windowWidth-1 , y , x + windowWidth-1, y + headerHeight);

}
