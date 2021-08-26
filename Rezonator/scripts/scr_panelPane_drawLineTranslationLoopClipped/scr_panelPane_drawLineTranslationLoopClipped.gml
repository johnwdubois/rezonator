function scr_panelPane_drawLineTranslationLoopClipped() {

	scr_surfaceStart();
	// Access the lineList panelPane object to get it's scrollPlusY
	//var lineListPanelPaneInst = inst_PanelPane_chainList;

	var strHeight = string_height("0") * 1.5;

	// Set text margin area
	var filterRectMargin = 8;
	var filterRectSize = (strHeight / 2) + 5;
	var textMarginLeft = filterRectMargin;

	var textMarginTop = functionTabs_tabHeight;
	var textPlusY = 0;
	//var chainNameRectMinusY = 4;

	var focusedElementY = -1;
	var focusedLineNameRectY1 = -1;
	var focusedLineNameRectY2 = -1;

	// Set opacity, font, and alignment of text chain lists
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	


	// Not doing a surface here so it can scroll along with the left Navwindow
	
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[?"unitList"];
	var unitListSize = ds_list_size(unitList);
	
	
	for (var i = 0; i < unitListSize; i++) {
	
		if (y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY < y - strHeight
		or y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			continue;
		}
	
	
		// Get grid info of current chain
		var currentUnitID = unitList[|i];
		var unitSubMap = global.nodeMap[?currentUnitID];
		if(!scr_isNumericAndExists(unitSubMap, ds_type_map)){ continue;}
			var unitTagMap = unitSubMap[?"tagMap"];
			var lineSpeaker = unitTagMap[?global.speakerField];

		var currentLineWordString = "";

		if(global.currentTranslation != undefined and global.currentTranslation != "") {
			currentLineWordString = unitTagMap[?global.currentTranslation];
		}
	
		// Get dimensions of rectangle around line name
		var lineNameRectX1 = x;
		var lineNameRectY1 = y + textMarginTop + textPlusY + inst_PanelPane_chainList.scrollPlusY - (strHeight / 2);
		var lineNameRectX2 = lineNameRectX1 + windowWidth;
		var lineNameRectY2 = lineNameRectY1 + strHeight;
	
		//Check mouse clicks to focus a line in the list
		if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, lineNameRectX1, lineNameRectY1, lineNameRectX2, lineNameRectY2)) {
			if (device_mouse_check_button_released(0, mb_left) and not instance_exists(obj_dialogueBox) and not instance_exists(obj_dropDown)) {
				with (obj_panelPane) {
					functionChainList_lineGridRowFocused = i;
				}
			}
		}
		var unitColX1 = lineNameRectX1
		
		var unitColX2 = lineNameRectX1 + (textMarginLeft) + string_width("     ");
 
		var textY =floor(y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY )

	
		// Draw text of chain names
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeNegSpace);
		draw_rectangle(unitColX1 - clipX, lineNameRectY1 - clipY, unitColX2 - clipX, lineNameRectY2 - clipY - 2, false);
		draw_set_color(global.colorThemeText);
		draw_text(floor(unitColX1 + (textMarginLeft) - clipX) , textY - clipY, string(i+1));
		
		
		var drawingSpeaker = false;
		
		if(is_string(lineSpeaker)){
		//Color codes the line lists for User
			if(string_length(lineSpeaker) > 0){
				
				var speakerColor = global.colorMap[? lineSpeaker];
				drawingSpeaker = true;
				if(is_undefined(speakerColor)){
					//error in epaker color found
					speakerColor = c_red;
				}
				draw_set_color(merge_color(speakerColor, global.colorThemeBG, 0.4)); //soften the color
				draw_rectangle(unitColX2 - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
				draw_set_color(scr_textColorDarkOrLight(speakerColor));
				lineSpeaker = scr_adaptFont(lineSpeaker, "M");
				draw_text(unitColX2 + (textMarginLeft) - clipX , textY - clipY, lineSpeaker);
			}
		}
		

		draw_set_color(global.colorThemeBG);
		draw_rectangle(windowWidth/3 - 10, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
		draw_set_color(global.colorThemeBG);
		draw_line_width(windowWidth/3 - 10, lineNameRectY1 - clipY, windowWidth/3 - 10, lineNameRectY2 - clipY - 2, 1);
		draw_set_color(global.colorThemeText);
		if(is_string(currentLineWordString)){
			scr_adaptFont(currentLineWordString, "M");
			var textXPos = (drawingSpeaker) ? lineNameRectX1 + (windowWidth/3): unitColX2 + (textMarginLeft);
			draw_set_alpha(1);
			draw_set_halign(fa_left);
			draw_text(floor(textXPos) - clipX, floor(y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY)- clipY, currentLineWordString);
		}
	
	
		// Get height of chain name
		textPlusY += strHeight;
	}





	// will create a focusedLine vriable in panelPane create, update it when changed, no gridValueY

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
	if (clickedIn) {	
		if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			inst_PanelPane_chainList.scrollPlusYDest += 4;
		}
		
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
				inst_PanelPane_chainList.scrollPlusYDest -= 4;
		}
	
		// CTRL+UP and CTRL+DOWN
		if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
			inst_PanelPane_chainList.scrollPlusYDest = 100;
		}
		if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
			inst_PanelPane_chainList.scrollPlusYDest = -999999999999;
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			inst_PanelPane_chainList.scrollPlusYDest += (windowHeight);
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			inst_PanelPane_chainList.scrollPlusYDest -= (windowHeight);
		}
	}

	if (focusedLineNameRectY1 > -1 and focusedLineNameRectY2 > -1) {
		draw_set_color(global.colorThemeBorders);
		for (var j = 0; j < 3; j++) {
			draw_rectangle(lineNameRectX1 + j - clipX, focusedLineNameRectY1 + j - clipY, x + windowWidth - j - clipX, focusedLineNameRectY2 - j - clipY, true);
		}
	}

	scr_surfaceEnd();

	//draw topbar
	var topBarX1 = x;
	var topBarX2 = topBarX1 + windowWidth;
	var topBarY1 = y;
	var topBarY2 = topBarY1 + functionTabs_tabHeight-1;
	draw_set_color(global.colorThemeBG);
	draw_rectangle(topBarX1,topBarY1,topBarX2,topBarY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(topBarX1,topBarY1,topBarX2,topBarY2, true);
	
	draw_set_color(global.colorThemeText);
	draw_text( topBarX1 + textMarginLeft , floor(mean(topBarY1,topBarY2)) , "Translation: " + string(global.currentTranslation));
	
	
	
		// draw token selection button
		var dropDownButtonSize = sprite_get_width(spr_dropDown);
		var dropDownRectX2 = topBarX2 - 16;
		var dropDownRectX1 = dropDownRectX2 - dropDownButtonSize;
		var dropDownRectY1 = topBarY1 + (dropDownButtonSize * 0.25);
		var dropDownRectY2 = topBarY2 - (dropDownButtonSize * 0.25);
		var mouseoverDropDownButton = point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2);
		
		// user interaction for token selection
		if (mouseoverDropDownButton && !instance_exists(obj_dropDown)) {
			scr_createTooltip(mean(dropDownRectX1, dropDownRectX2), dropDownRectY2, scr_get_translation("msg_change_field"), obj_tooltip.arrowFaceUp);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2, true);
			if (mouse_check_button_released(mb_left)) {
				var dropDownOptionList = ds_list_create();
				ds_list_copy(dropDownOptionList, global.translationList);
				scr_createDropDown(dropDownRectX2, dropDownRectY2, dropDownOptionList, global.optionListTypeTranslation);
			}
		}
		draw_set_color(global.colorThemeBorders);
		draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2), mean(dropDownRectY1, dropDownRectY2), 1, 1, 0, global.colorThemeText, 1);



}
