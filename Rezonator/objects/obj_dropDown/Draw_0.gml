/*
	Purpose: Create the visuals of any drop down menus
*/

myAlpha = min(myAlpha + 0.15, 1);

arrowKeySelection = (optionListType == global.optionListTypeTokenTagMap || optionListType == global.optionListTypeUnitTagMap
					|| optionListType == global.optionListTypeEntryTagMap || optionListType == global.optionListTypeChainTagMap
					|| optionListType == global.optionListTypeChunk1To1Tag);
var filterOptionList = arrowKeySelection && instance_exists(obj_inputBox);
if (filterOptionList) scr_filterDropDownList(originalOptionList, optionList, obj_inputBox.str);

var prevDropDownExists = (instance_exists(prevDropDown) && prevDropDown != -1);

if (prevDropDownExists) {
	x = prevDropDown.x + prevDropDown.windowWidth;
}

draw_set_alpha(myAlpha);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var firstOptionText = ds_list_find_value(optionList, 0);
var firstOptionTextStr = scr_get_translation(firstOptionText);
scr_adaptFont(scr_get_translation(firstOptionTextStr), "M");


var ableToMouseover = true;
var strHeight = string_height("0");
var arrowScale = 0.35;
optionSpacing = strHeight * 1.25;
windowHeight = ds_list_size(optionList) * optionSpacing;
textBuffer = 10;


// clamp windowHeight so dropDown is not hanging off the screen
var showScrollBar = false;
var camHeight = camera_get_view_height(camera_get_active());
var camWidth = camera_get_view_width(camera_get_active());
if (y + windowHeight > camHeight) {
	windowHeight = camHeight - y;
	showScrollBar = true;
}

// get windowWidth
var ascendWidth = sprite_get_width(spr_ascend);
var optionListSize = ds_list_size(optionList);
var maxWidth = scr_getDropDownWidth();
windowWidth = max(originalWindowWidth, maxWidth);

// force dropdown to stay on screen horizontally
if (x + windowWidth > camWidth && !global.userLangRTL) {
	var widthOffset = 0;
	if (prevDropDownExists) {
		
		var prevDDX2 = prevDropDown.x + prevDropDown.windowWidth;
		var horizontalOffset = camWidth-prevDDX2;
		widthOffset = prevDropDown.windowWidth+ horizontalOffset;
	}
	x = camWidth - windowWidth - widthOffset;
}



// check mouseover for dropdown
var mouseoverThisDropDown = false
var mouseInDropDown = false;
var dropDownInstanceNumber = instance_number(obj_dropDown);
for (var i = 0; i < dropDownInstanceNumber; i++) {
	var currentDropDown = instance_find(obj_dropDown, i);
	if (point_in_rectangle(mouse_x, mouse_y, currentDropDown.x, currentDropDown.y, currentDropDown.x + currentDropDown.windowWidth, currentDropDown.y + currentDropDown.windowHeight)) {
		mouseInDropDown = true;
		if (currentDropDown == self.id) mouseoverThisDropDown = true;
	}
}

// make sure this dropDown contains at least 1 value
if (ds_list_size(optionList) <= 0) {
	if (arrowKeySelection) {
		exit;
	}
	else {
		show_debug_message("obj_dropDown Draw ... ds_list_size(optionList) <= 0, destroying");
		instance_destroy();
	}

}
scr_dropShadow(x, y, x + windowWidth, y + windowHeight);

// surface stuff
windowX = x;
windowY = y;
scr_miniSurfaceStart(x, y);
draw_set_alpha(myAlpha);

mouseOverDropDown = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);


scrollPlusY = min(scrollPlusY, 0);

var greenOptionColor = merge_color(global.colorThemeBG, make_color_rgb(114, 230, 110), 0.5);
var redOptionColor = merge_color(global.colorThemeBG, make_color_rgb(247, 129, 148), 0.5);

var optionListSize = ds_list_size(optionList);
for (var i = 0; i < optionListSize; i++) {
	
	// get current option & everything about it
	var currentOptionRaw = optionList[| i];
	var currentOptionTranslated = scr_getDropDownOptionStr(currentOptionRaw);
	var currentOptionShortcut = scr_getDropDownShortcutStr(currentOptionRaw);
	var currentOptionTag = scr_getDropDownTagStr(currentOptionRaw);
	var isExpandable = scr_checkExpandable(currentOptionRaw, optionListType);
	var hasCheck = scr_dropDownHasCheckmark(currentOptionRaw);
	var isOpeningScreenOption = ds_map_exists(global.openingScreenDropDownMap, currentOptionRaw)
	|| optionListType == global.optionListTypeTagSchema || optionListType == global.optionListTypeHTML5REZFile;
	var isHTML5Restricted = ds_map_exists(global.html5RestrictedMap, currentOptionRaw);
	var unClickable = (room == rm_openingScreen && !isOpeningScreenOption) || (global.html5 && isHTML5Restricted);
	var fadedTextColor = merge_color(global.colorThemeText, global.colorThemeBG, unClickable ? 0.6 : 0.3);
	
	// optionRect coordinates
	var optionRectX1 = x;
	var optionRectY1 = y + (optionSpacing * i) + scrollPlusY;
	var optionRectX2 = optionRectX1 + windowWidth;
	var optionRectY2 = optionRectY1 + optionSpacing;
	var mouseoverRectX2 = (showScrollBar) ? optionRectX2 - global.scrollBarWidth : optionRectX2;
	
	// check update scroll
	if (updateScroll && optionCurrent == i) {
		show_debug_message("obj_dropDown, updateScroll!");
		updateScroll = false;
		if (optionRectY1 < y) {		
			scrollPlusYDest += abs(optionRectY1 - y);
		}
		else if (optionRectY2 > y + windowHeight) {
			scrollPlusYDest -= abs(optionRectY2 - (y + windowHeight));
		}
	}
	
	// check mouseover
	var mouseoverCurrentOption = false;
	if (instance_exists(obj_panelPane)) {
		if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, mouseoverRectX2, optionRectY2) and ableToMouseover
		and not obj_panelPane.scrollBarClickLock) {
			mouseoverCurrentOption = true;
			ableToMouseover = false;
			if (room == rm_mainScreen) {
				obj_control.mouseoverPanelPane = true;
			}
		}
	}
	else {
		if (point_in_rectangle(mouse_x, mouse_y, optionRectX1, optionRectY1, mouseoverRectX2, optionRectY2) and ableToMouseover) {
			mouseoverCurrentOption = true;
			ableToMouseover = false;
			if (room == rm_mainScreen) {
				obj_control.mouseoverPanelPane = true;
			}
		}
	}
	if (multiDropDownCancel) mouseoverCurrentOption = false;
	if (!mouseMoved) mouseoverCurrentOption = false;
	
	if (mouseoverCurrentOption) {
		if (optionCurrent != i) {
			var dropDownsWithGreaterLevelExists = false;
			var myLevel = level;
			with (obj_dropDown) {
				if (level > myLevel) dropDownsWithGreaterLevelExists = true;
			}
			if (dropDownsWithGreaterLevelExists) {				
				// check if prevoption is expandable
				var isPrevOptionExpandale = scr_checkExpandable(optionList[| prevOptionClicked], optionListType);
				if (!isPrevOptionExpandale) prevOptionClicked = i;
			}
			
			scr_destroyAllDropDownsOtherThanSelf();
		}
		optionCurrent = i;
		with (obj_control) {
			mouseoverDropDownOption = currentOptionRaw;
		}
	}
	
	
	// handle expandable timer
	if (mouseoverCurrentOption or optionCurrent == i) {
		currentMouseoverOption = i;
		if (expandableTimer < expandableTimerFull) expandableTimer++;
		if (prevMouseoverOption != currentMouseoverOption) {
			expandableTimer = 0;
			prevMouseoverOption = currentMouseoverOption;
			expandableTimerClicked = false;
		}
	}
	
	
	// draw BG rectangle for each option
	var optionBGColor = global.colorThemeBG;
	if (currentOptionRaw == "option-remove-tag-set" || currentOptionRaw == "menu_clear" && optionListType != global.optionListTypeFilter) {
		optionBGColor = redOptionColor;
	}
	else if (currentOptionRaw == "option_add-to-tag-set" || currentOptionRaw == "option_create-new-field") {
		optionBGColor = greenOptionColor;
	}
	if (mouseoverCurrentOption or (optionCurrent == i)) {
		optionBGColor = c_ltblue;
	}
	if (mouseoverCurrentOption) optionMouseover = currentOptionRaw;
	draw_set_color(optionBGColor);
	draw_rectangle(optionRectX1 - clipX, optionRectY1 - clipY, optionRectX2 - clipX, optionRectY2 - clipY, false);
	
	
	// gray out option if it begins with ~
	draw_set_color(global.colorThemeText);
	if (room == rm_mainScreen) {
		if (string_length(currentOptionRaw) >= 1) {
			if (string_char_at(currentOptionRaw, 1) == "~") {
				draw_set_color(global.colorThemeSelected2);
			}
		}
	}
	if (unClickable) {
		draw_set_color(global.colorThemeSelected2);
	}
	
	

	// get XY for text positioning
	var optionTextX = (global.userLangRTL) ? floor(optionRectX2 - textBuffer) : floor(optionRectX1 + textBuffer);
	var optionTextY = floor(mean(optionRectY1, optionRectY2));
	var shortcutTextX = (global.userLangRTL) ? floor(optionRectX1 + textBuffer) : floor(optionRectX2 - textBuffer);
	scr_adaptFont(scr_get_translation(currentOptionTranslated), "M");
	if (global.userLangRTL) draw_set_halign(fa_right);

	// draw text for current option
	draw_text(optionTextX - clipX, floor(optionTextY - clipY), currentOptionTranslated);
	
	// draw shortcut text
	draw_set_halign( (global.userLangRTL) ? fa_left : fa_right);
	if (currentOptionShortcut != "") {
		draw_set_color(fadedTextColor);
		scr_adaptFont(scr_get_translation(currentOptionShortcut), "S");
		if (isExpandable) {
			if (global.userLangRTL) {
				
				shortcutTextX += ascendWidth;
				
			}
			else {
				shortcutTextX -= ascendWidth;
				
			}
			
			draw_text(shortcutTextX - clipX, optionTextY - clipY, currentOptionShortcut);
		}
		else {
			draw_text(shortcutTextX - clipX, optionTextY - clipY, currentOptionShortcut);
		}
	}
	
	
	// draw checkmark
	var checkX = (global.userLangRTL) ? 
				floor(optionRectX1 + (sprite_get_width(spr_checkmark) / 2)) : floor(optionRectX2 - (sprite_get_width(spr_checkmark) / 2));
	var checkY = floor(mean(optionRectY1, optionRectY2));
	if (hasCheck) {
		if (currentOptionShortcut != "") {
			if (global.userLangRTL) {
				draw_sprite_ext(spr_checkmark, 0, checkX - clipX + string_width(currentOptionShortcut) + textBuffer, checkY - clipY, 0.8, 0.8, 0, c_black, 1);
			}
			else {
				draw_sprite_ext(spr_checkmark, 0, checkX - clipX - string_width(currentOptionShortcut) - textBuffer, checkY - clipY, 0.8, 0.8, 0, c_black, 1);
			}
		}
		else {
			draw_sprite_ext(spr_checkmark, 0, checkX - clipX, checkY - clipY, 0.8, 0.8, 0, c_black, 1);
		}
	}
	
	
	//add tag info to option
	if (currentOptionTag != "") {
			if (global.userLangRTL) {
				
				shortcutTextX += ascendWidth/2;
				
			}
			else {
				shortcutTextX -= ascendWidth/2;
				
			}
		draw_set_color(fadedTextColor);
		draw_text(shortcutTextX - clipX, optionTextY - clipY, currentOptionTag);	
	}

	draw_set_halign(fa_left);

	
	// click on option
	var prevOptionExpandable = (prevOptionClicked == i && isExpandable);
	var click = (mouse_check_button_released(mb_left) && mouseoverThisDropDown && !multiDropDownCancel && !prevOptionExpandable) || keyboard_check_pressed(vk_enter);
	if (scrollBarHolding) click = false;
	var clickCurrentOption = (i == optionCurrent && ableToClick && click);
	if (arrowKeySelection && click && i == optionCurrent) {
		prevOptionClicked = -1;
		clickCurrentOption = true;
		isExpandable = false;
	}


	if (isExpandable && expandableTimer >= expandableTimerFull && ableToClick && i == optionCurrent && !expandableTimerClicked) {
		expandableTimerClicked = true;
		clickCurrentOption = true;
	}
	
	if (arrowKeySingleOptionSelect && ds_list_size(optionList) == 1) {
		arrowKeySingleOptionSelect = false;
		
		clickCurrentOption = true;
		with (obj_control) {
			navWindowTaggingNextRow = true;
			navWindowTaggingSingleOptionSelect = true;
		}
	}
	
	if (clickCurrentOption) {
		prevOptionClicked = i;
		
		if (!unClickable) {
			optionCurrent = i;
			var optionSelected = optionList[| i];
			scr_dropDownSelect(optionSelected);
		}
		
		if (!arrowKeySingleOptionSelect) {
			with (obj_control) navWindowTaggingSingleOptionSelect = false;
		}
	}

	
	
	// draw arrow if expandable
	if (isExpandable) {
		var expandArrowX = (global.userLangRTL) ? floor(optionRectX1 + (sprite_get_width(spr_ascend) / 2)) : floor(optionRectX2 - (sprite_get_width(spr_ascend) / 2));
		var expandArrowY = floor(mean(optionRectY1, optionRectY2));
		var arrowColor = (unClickable)? global.colorThemeSelected1 : global.colorThemeText;
		if (global.userLangRTL) {
			draw_sprite_ext(spr_linkArrow, 0, expandArrowX - clipX, expandArrowY - clipY, arrowScale, arrowScale, 180, arrowColor, 1);
		}
		else {
			draw_sprite_ext(spr_linkArrow, 0, expandArrowX - clipX, expandArrowY - clipY, arrowScale, arrowScale, 0, arrowColor, 1);
		}
	}
}



	

if (showScrollBar) {
	scr_scrollBar(optionListSize, -1, optionSpacing, 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		
	// scroll mouse wheel
	if (mouse_wheel_up()) {
		scrollPlusYDest += strHeight;
	}
	if (mouse_wheel_down()) {
		scrollPlusYDest -= strHeight;
	}
}



scr_surfaceEnd();

if (scrollBarHolding) {
	scrollBarHoldingDelay = true;
}



with (obj_control) {
	mouseoverDropDown = mouseInDropDown;
}

if (ableToMouseover and ableToClick and mouse_check_button_pressed(mb_left) 
and !mouseInDropDown and !scrollBarHoldingDelay) {
	var destroyDropDown = true;
	if (room == rm_mainScreen) {
		obj_menuBar.menuClickedIn = false;
	} 
	else if (room == rm_importScreen) {
		obj_fieldSummaryWindow.clickedIn = false;
	}
	else if (room == rm_importScreen) {
		obj_fieldSummaryWindow.clickedIn = false;
	}
	
	with (obj_control) {
		if (mouseoverInputBox) {	
			destroyDropDown = false;
			show_debug_message("obj_dropDown Draw ... destroying dropdowns");

		}
	}
	if (destroyDropDown) {
		with (obj_dropDown) {
			instance_destroy();
		}
	}
}
scrollBarHoldingDelay = scrollBarHolding;

// press escape to destroy
if (keyboard_check_released(vk_escape)) {
	instance_destroy();
}

if (arrowKeySelection) {
	if (keyboard_check(vk_up) && canPressUp) {
		canPressUp = false;
		alarm[5] = 7;
		updateScroll = true;
		if (optionCurrent > 0) optionCurrent--;
		else optionCurrent = ds_list_size(optionList) - 1;
	}
	else if (keyboard_check(vk_down) && canPressDown) {
		canPressDown = false;
		updateScroll = true;
		alarm[4] = 7;
		if (optionCurrent < ds_list_size(optionList) - 1) optionCurrent++;
		else optionCurrent = 0;
		
		if (ds_list_size(optionList) == 1) {
			arrowKeySingleOptionSelect = true;
		}
	}
}


draw_set_color(c_ltgray);
draw_rectangle(x, y, x + windowWidth - 1, y + windowHeight, true);
draw_set_alpha(1);