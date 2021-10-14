/*
	Purpose: Create the visuals of any drop down menus
*/
myAlpha += 0.15;
if (myAlpha > 1) myAlpha = 1;

if (instance_exists(prevDropDown) && prevDropDown != -1) {
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
	windowHeight = camHeight - y ;
	showScrollBar = true;
}


// loop through list to get windowWidth
var optionListSize = ds_list_size(optionList);
var maxStrWidth = originalWindowWidth;
for (var i = 0; i < optionListSize; i++) {
	var currentOptionStr = string(ds_list_find_value(optionList, i));
	
	// get keyboard shortcut if provided
	var shortcutStr = "";
	if(ds_map_exists(global.keyboardShortcutMap, currentOptionStr)){
		shortcutStr = ds_map_find_value(global.keyboardShortcutMap, currentOptionStr);	
	}
	
	// get width of current string
	currentOptionStr = scr_get_translation(currentOptionStr);

	var currentOptionStrWidth = string_width(currentOptionStr) + string_width(shortcutStr) + (textBuffer * 2);
	
	var isTagOption = string_count("Tag", currentOptionStr) > 0;
	var tagWidth = 0;
	if(isTagOption){
		var isTokenOption = string_count("Token", currentOptionStr) > 0;
		var isUnitOption = string_count("Unit", currentOptionStr) > 0;
		var isChainOption = string_count("Chain", currentOptionStr) > 0;
		var isEntryOption = string_count("Entry", currentOptionStr) > 0;
		var isChunkOption = string_count("Chunk", currentOptionStr) > 0;
	
		if(isTokenOption){

			var tokenTagText =  "   (" + string(obj_panelPane.functionField_tokenTagSelected) + " : " + string(obj_panelPane.functionField_tokenFieldSelected) + ")";
			tagWidth = string_width(tokenTagText); 
		}
		if(isUnitOption){
			var unitTagText =  "   (" + string(obj_panelPane.functionField_unitTagSelected) + " : " + string(obj_panelPane.functionField_unitFieldSelected) + ")";
			tagWidth = string_width(unitTagText); 
		}
		if(isChainOption){
			var chainTagText =  "   (" + string(obj_panelPane.functionField_chainTagSelected) + " : " + string(obj_panelPane.functionField_chainFieldSelected) + ")";
			tagWidth = string_width(chainTagText); 
		}
		if(isEntryOption){
			var entryTagText =  "   (" + string(obj_panelPane.functionField_entryTagSelected) + " : " + string(obj_panelPane.functionField_entryFieldSelected) + ")";
			tagWidth = string_width(entryTagText); 
		}
		if(isChunkOption){
			var entryTagText =  "   (" + string(obj_panelPane.functionField_chunkTagSelected) + " : " + string(obj_panelPane.functionField_chunkFieldSelected) + ")";
			tagWidth = string_width(entryTagText); 
		}
	
	}
	currentOptionStrWidth += tagWidth;
	
	
	// check if expandable
	var isExpandable = false;
	if (ds_exists(global.expandableDropDownMap, ds_type_map)) {
		isExpandable = ds_map_exists(global.expandableDropDownMap, currentOptionStr);
		if (currentOptionStr == "menu_stack" &&  ds_list_size(optionList) == 3) {
			isExpandable = false;
		}
		else if (currentOptionStr == "menu_search" && ds_list_size(optionList) == 4) {
			isExpandable = false;
		}
		else if (currentOptionStr == "menu_prose" && ds_list_size(optionList) == 2) {
			isExpandable = false;
		}
		else if (currentOptionStr == "menu_nav" && ds_list_size(optionList) == 5) {
			isExpandable = false;
		}
		if (optionListType == global.optionListTypeLinkFields) {
			if (ds_list_find_index(global.linkFieldList, currentOptionStr) >= 0) isExpandable = true;
		}
		if (optionListType == global.optionListTypeTokenFields || optionListType == global.optionListTypeUnitFields
		|| optionListType == global.optionListTypeEntryFields || optionListType == global.optionListTypeChainFields
		|| optionListType == global.optionListTypeChunkFields) {
			if (currentOptionStr != "option_create-new-field") isExpandable = true;
		}
	}
	
	// add some width if this is an expandable dropdown
	if (isExpandable) {
		currentOptionStrWidth += sprite_get_width(spr_linkArrow) * arrowScale;
	}
	
	// check if this is the widest string so far
	if (currentOptionStrWidth > maxStrWidth) {
		maxStrWidth = currentOptionStrWidth;
	}
}
windowWidth = maxStrWidth;

if( x + windowWidth > camWidth and !(global.lang_codes[| global.lang_index] == "he") ){
	x = camWidth - windowWidth;
}

scr_dropShadow(x, y, x + windowWidth, y + windowHeight);

// surface stuff
windowX = x;
windowY = y;
clipX = x;
clipY = y;
clipWidth = windowWidth;
clipHeight = windowHeight;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}
if (surface_exists(clipSurface)) {
	surface_resize(clipSurface, clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);

draw_set_alpha(myAlpha);

if (ds_list_size(optionList) <= 0) {
	show_debug_message("obj_dropDown Draw ... ds_list_size(optionList) <= 0");
	instance_destroy();
}

mouseOverDropDown = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);

scrollPlusY = min(scrollPlusY, 0);

var optionListSize = ds_list_size(optionList);
for (var i = 0; i < optionListSize; i++) {
	
	// get option text
	var optionText = ds_list_find_value(optionList, i);
	
	// optionRect coordinates
	//var optionRectX1 = (global.lang_codes[| global.lang_index] == "he") ? x - windowWidth : x;
	var optionRectX1 = x;
	var optionRectY1 = y + (optionSpacing * i) + scrollPlusY;
	var optionRectX2 = optionRectX1 + windowWidth;
	var optionRectY2 = optionRectY1 + optionSpacing;
	var mouseoverRectX2 = (showScrollBar) ? optionRectX2 - global.scrollBarWidth : optionRectX2;
	
	
	
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
	
	// handle expandable timer
	if (mouseoverCurrentOption) {
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
	if (optionText == "option-remove-tag-set") {
		optionBGColor = merge_color(global.colorThemeBG, make_color_rgb(247, 129, 148), 0.5);
	}
	if (mouseoverCurrentOption or (optionCurrent == i && !mouseOverDropDown)) {
		optionBGColor = c_ltblue;
	}
	if (mouseoverCurrentOption) optionMouseover = optionText;
	draw_set_color(optionBGColor);
	draw_rectangle(optionRectX1 - clipX, optionRectY1 - clipY, optionRectX2 - clipX, optionRectY2 - clipY, false);
	
	
	var isOpeningScreenOption = ds_map_exists(global.openingScreenDropDownMap,optionText);
	
	
	// check whether this option is expandable
	var isExpandable = false;
	if (ds_exists(global.expandableDropDownMap, ds_type_map)) {
		isExpandable = ds_map_exists(global.expandableDropDownMap, optionText);
		if (optionText == "menu_stack" &&  ds_list_size(optionList) == 3) {
			isExpandable = false;
		}
		else if (optionText == "menu_search" && ds_list_size(optionList) == 4) {
			isExpandable = false;
		}
		else if (optionText == "menu_prose" && ds_list_size(optionList) == 2) {
			isExpandable = false;
		}
		else if (optionText == "menu_nav" && ds_list_size(optionList) == 5) {
			isExpandable = false;
		}
		if (optionListType == global.optionListTypeLinkFields) {
			if (ds_list_find_index(global.linkFieldList, optionText) >= 0) isExpandable = true;
		}
		if (optionListType == global.optionListTypeTokenFields || optionListType == global.optionListTypeUnitFields
		|| optionListType == global.optionListTypeEntryFields || optionListType == global.optionListTypeChainFields
		|| optionListType == global.optionListTypeChunkFields) {
			if (optionText != "option_create-new-field") isExpandable = true;
		}
	}
	
	var unClickable = (room == rm_openingScreen and !isOpeningScreenOption);
	// gray out option if it begins with ~
	draw_set_color(global.colorThemeText);
	if (room == rm_mainScreen) {
		if (string_length(optionText) >= 1) {
			if (string_char_at(optionText, 1) == "~") {
				draw_set_color(global.colorThemeSelected2);
			}
		}
	}
	if(unClickable){
		draw_set_color(global.colorThemeSelected2);
	}
	
	// draw option text
	var optionTextStr = scr_get_translation(optionText);
	
	// for special cases, draw chain name instead of hex-string
	if (optionListType == global.optionListTypeAddToShow) {
		var subMap = ds_map_find_value(global.nodeMap, optionText);
		if (is_numeric(subMap)) {
			if (ds_exists(subMap, ds_type_map)) {
				optionTextStr = ds_map_find_value(subMap, "name");
			}
		}
	}
	
	
	//optionTextStr = optionText;
	//uncomment this line to see the raw strings instead of display strings in dropdown
	
	var shortcutStr = "";
	if(ds_map_exists(global.keyboardShortcutMap, optionText)){
		shortcutStr = ds_map_find_value(global.keyboardShortcutMap, optionText);	
	}

	if(optionText == "menu_grid" and  optionListType != global.optionListTypePane){
		shortcutStr = "";
	}
	if(optionText == "menu_search" and optionListType != global.optionListTypePane){
		shortcutStr = "";
	}
	if((optionText == "menu_resonance" or optionText == "menu_track") and optionListType != global.optionListTypeTools){
		shortcutStr = "";	
	}
	if(optionText == "menu_prose" and optionListType != global.optionListTypeView){
		shortcutStr = "";	
	}
	
	var optionTextX = (global.lang_codes[| global.lang_index] == "he") ? floor(optionRectX2 - textBuffer) : floor(optionRectX1 + textBuffer);
	var optionTextY = floor(mean(optionRectY1, optionRectY2));
	var shortcutTextX = (global.lang_codes[| global.lang_index] == "he") ? floor(optionRectX1 + textBuffer) : floor(optionRectX2 - textBuffer);
	scr_adaptFont(scr_get_translation(optionTextStr), "M");
	if(global.lang_codes[| global.lang_index] == "he"){
		draw_set_halign(fa_right);	
	}
	


	draw_text(optionTextX - clipX, floor(optionTextY - clipY), optionTextStr);
	
	

	if(global.lang_codes[| global.lang_index] == "he"){
		draw_set_halign(fa_left);	
	}
	else{
		draw_set_halign(fa_right);
	}
	if(shortcutStr != ""){
		scr_adaptFont(scr_get_translation(shortcutStr), "S");
		if(isExpandable){
			if(global.lang_codes[| global.lang_index] == "he"){
				draw_text(shortcutTextX - clipX + sprite_get_width(spr_ascend), optionTextY - clipY, shortcutStr);
			}
			else{	
				draw_text(shortcutTextX - clipX - sprite_get_width(spr_ascend), optionTextY - clipY, shortcutStr);
			}
		}
		else{
			draw_text(shortcutTextX - clipX, optionTextY - clipY, shortcutStr);
		}
	}
	
	var hasCheck = false;
	if(ds_map_exists(global.checkDropdownMap, optionText)){
		scr_updateCheckMap(optionText);
		hasCheck = ds_map_find_value(global.checkDropdownMap, optionText);
		if (optionListType == global.optionListTypeNav) hasCheck = false;

		var checkX = (global.lang_codes[| global.lang_index] == "he") ? 
				floor(optionRectX1 + (sprite_get_width(spr_checkmark) / 2)) : floor(optionRectX2 - (sprite_get_width(spr_checkmark) / 2));
		var checkY = floor(mean(optionRectY1, optionRectY2));
	}
	
	//some checks for duplicate optionText that shouldnt have checkmarks
	if(optionListType == global.optionListTypeTools and optionText == "menu_stack") hasCheck = false;
	if(optionListType == global.optionListTypeView and optionText == "menu_prose") hasCheck = false;
	
	
	if(hasCheck){
		if(shortcutStr != ""){
			if(global.lang_codes[| global.lang_index] == "he"){
				draw_sprite_ext(spr_checkmark, 0, checkX - clipX + string_width(shortcutStr) + textBuffer, checkY - clipY, 0.8, 0.8, 0, c_black, 1);
			}
			else{
				draw_sprite_ext(spr_checkmark, 0, checkX - clipX - string_width(shortcutStr) - textBuffer, checkY - clipY, 0.8, 0.8, 0, c_black, 1);
			}
		}
		else{
			draw_sprite_ext(spr_checkmark, 0, checkX - clipX, checkY - clipY, 0.8, 0.8, 0, c_black, 1);
		}
	}
	//add tag info to option
	var isTagOption = string_count("Tag", optionTextStr) > 0;
	var tagWidth = 0;
	var tagText = "";
	if(isTagOption){
		var isTokenOption = string_count("Token", optionTextStr) > 0;
		var isUnitOption = string_count("Unit", optionTextStr) > 0;
		var isChainOption = string_count("Chain", optionTextStr) > 0;
		var isEntryOption = string_count("Entry", optionTextStr) > 0;
		var isChunkOption = string_count("Chunk", optionTextStr) > 0;
	
		if(isTokenOption){
			tagText =  "   (" + string(obj_panelPane.functionField_tokenFieldSelected) + " :  " + string(obj_panelPane.functionField_tokenTagSelected) + ")";
		}
		if(isUnitOption){
			tagText =  "   (" + string(obj_panelPane.functionField_unitFieldSelected) + " : " + string(obj_panelPane.functionField_unitTagSelected) + ")";
		}
		if(isChainOption){
			tagText =  "   (" + string(obj_panelPane.functionField_chainFieldSelected) + " : " + string(obj_panelPane.functionField_chainTagSelected) + ")";
		}
		if(isEntryOption){
			tagText =  "   (" + string(obj_panelPane.functionField_entryFieldSelected) + " : " + string(obj_panelPane.functionField_entryTagSelected) + ")";
		}
		if(isChunkOption){
			tagText =  "   (" + string(obj_panelPane.functionField_chunkFieldSelected) + " : " + string(obj_panelPane.functionField_chunkTagSelected) + ")";
		}

	draw_set_color(merge_color(global.colorThemeText, global.colorThemeBG, 0.3));

	draw_text(shortcutTextX - clipX, optionTextY - clipY, tagText);	
	
	}

	draw_set_halign(fa_left);

	
	// click on option
	var clickCurrentOption = (mouseoverCurrentOption && ableToClick && mouse_check_button_released(mb_left));
	if (isExpandable && expandableTimer >= expandableTimerFull && ableToClick && mouseoverCurrentOption && !expandableTimerClicked) {
		expandableTimerClicked = true;
		clickCurrentOption = true;
	}
	
	if (clickCurrentOption) {
		if(!unClickable){
			optionCurrent = i;
			var optionSelected = optionList[| i];
			scr_dropDownSelect(optionSelected);
		}
	}
	
	// draw arrow if expandable
	if (isExpandable) {
		var expandArrowX = (global.lang_codes[| global.lang_index] == "he") ? floor(optionRectX1 + (sprite_get_width(spr_ascend) / 2)) : floor(optionRectX2 - (sprite_get_width(spr_ascend) / 2));
		var expandArrowY = floor(mean(optionRectY1, optionRectY2));
		var arrowColor = (unClickable)? global.colorThemeSelected1 : global.colorThemeText;
		if(global.lang_codes[| global.lang_index] == "he"){
			draw_sprite_ext(spr_linkArrow, 0, expandArrowX - clipX, expandArrowY - clipY, arrowScale, arrowScale, 180, arrowColor, 1);
		}
		else{
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



var mouseInDropDown = false;
var dropDownInstanceNumber = instance_number(obj_dropDown);
for (var i = 0; i < dropDownInstanceNumber; i++) {
	var currentDropDown = instance_find(obj_dropDown, i);
	if (point_in_rectangle(mouse_x, mouse_y, currentDropDown.x, currentDropDown.y, currentDropDown.x + currentDropDown.windowWidth, currentDropDown.y + currentDropDown.windowHeight)) {
		mouseInDropDown = true;
	}
}

if (ableToMouseover and ableToClick and mouse_check_button_released(mb_left) 
and !mouseInDropDown and !scrollBarHoldingDelay) {
	if (room == rm_mainScreen) {
		obj_menuBar.menuClickedIn = false;
	}
	else if (room == rm_importScreen) {
		obj_fieldSummaryWindow.clickedIn = false;
	}
	show_debug_message("obj_dropDown Draw ... destroying dropdowns");
	with (obj_dropDown) {
		instance_destroy();
	}
}
scrollBarHoldingDelay = scrollBarHolding;


draw_set_color(c_ltgray);
draw_rectangle(x, y, x + windowWidth - 1, y + windowHeight, true);
draw_set_alpha(1);