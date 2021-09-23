function scr_drawToolPane(toolSprScale) {

	var mouseoverCancel = (instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_flyout));
	var toolSprWidth = sprite_get_width(spr_toolsNew) * toolSprScale;
	var toolSprHeight = sprite_get_height(spr_toolsNew) * toolSprScale;
	var camHeight = camera_get_view_height(camera_get_active());
	
	var mouseoverRectWidth = 5;
	
	var toolButtonX = floor(x + (windowWidth / 2));
	var toolButtonRectBuffer = toolSprWidth * 0.06;
	var flyoutXBuffer = mouseoverRectWidth * 2;
	
	
	
	
	// determine whether specific flyouts exist
	var toolFlyoutExists = false;
	var contextFlyoutExists = false;
	var shapeFlyoutExists = false;
	var justifyFlyoutExists = false;
	var oneToOneFlyoutExists = false;
	if (instance_exists(obj_flyout)) {
		toolFlyoutExists = (obj_flyout.optionListType == global.optionListTypeToolButton);
		contextFlyoutExists = (obj_flyout.optionListType == global.optionListTypeContext);
		shapeFlyoutExists = (obj_flyout.optionListType == global.optionListTypeProse);
		justifyFlyoutExists = (obj_flyout.optionListType == global.optionListTypeJustifyProse);
		oneToOneFlyoutExists = (obj_flyout.optionListType == global.optionListType1to1);
	}

	
	
	// tool button
	var toolButtonY = floor(y + (toolSprHeight * ((0 * 1.3) + 1)));
	var toolButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var toolButtonRectY1 = floor(toolButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var toolButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var toolButtonRectY2 = floor(toolButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverTool = point_in_rectangle(mouse_x, mouse_y, toolButtonRectX1, toolButtonRectY1, toolButtonRectX2, toolButtonRectY2) && !mouseoverCancel;
	var toolImageIndex = 0;
	if (currentMode == modeRead) toolImageIndex = 0;
	else if (currentMode == modeTrack) toolImageIndex = 1;
	else if (currentMode == modeRez) toolImageIndex = 2;
	
	if (mouseoverTool || toolFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolButtonRectX1, toolButtonRectY1, toolButtonRectX2, toolButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverTool) {
		scr_createTooltip(toolButtonRectX1, toolButtonY, scr_get_translation("option_tool"), global.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var toolOptionList = ds_list_create();
			ds_list_add(toolOptionList, "help_label_tag", "menu_track", "menu_resonance");
			scr_createFlyout(toolButtonRectX1 - flyoutXBuffer, toolButtonY, toolOptionList, global.optionListTypeToolButton, spr_toolsNew, false);
		}
	}
	
	// draw highlight rect
	draw_set_color(global.colorThemeBG);
	draw_roundrect(toolButtonRectX1, toolButtonRectY1, toolButtonRectX2, toolButtonRectY2, false);
	
	// draw tool sprite
	draw_sprite_ext(spr_toolsNew, toolImageIndex, toolButtonX, toolButtonY, toolSprScale, toolSprScale, 0, global.colorThemeRezPink, 1);


	
	
	// filter button
	var filterButtonY = floor(y + (toolSprHeight * ((1 * 1.3) + 1)));
	var filterButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var filterButtonRectY1 = floor(filterButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var filterButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var filterButtonRectY2 = floor(filterButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverFilter = point_in_rectangle(mouse_x, mouse_y, filterButtonRectX1, filterButtonRectY1, filterButtonRectX2, filterButtonRectY2) && !mouseoverCancel;
	var filterButtonColor = (obj_control.filterGridActive|| obj_control.quickFilterGridActive) ? global.colorThemeRezPink : c_white;
	var filterList = scr_getFilterList();
	var filterListSize = ds_list_size(filterList);
	
	if (filterListSize <= 0 && obj_control.filterGridActive && obj_panelPane.functionChainList_playShowID == "") {
		scr_disableFilter();
	}
	
	// mouseover & click on filter button
	if (mouseoverFilter) {
		draw_set_color(c_white);
		scr_drawRectWidth(filterButtonRectX1, filterButtonRectY1, filterButtonRectX2, filterButtonRectY2, mouseoverRectWidth , false);
		scr_createTooltip(filterButtonRectX1, filterButtonY, scr_get_translation("menu_filter"), global.arrowFaceRight);
		
		
		if (mouse_check_button_released(mb_left)) {
			scr_toggleFilter();
		}
	}
	
	// draw highlight rectangle if filter is on
	if (obj_control.filterGridActive || obj_control.quickFilterGridActive) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(filterButtonRectX1, filterButtonRectY1, filterButtonRectX2, filterButtonRectY2, false);
	}
	
	// draw filter sprite
	draw_sprite_ext(spr_filterTool, 0, toolButtonX, filterButtonY, toolSprScale, toolSprScale, 0, filterButtonColor, 1);
	
	
	
	
	// context button
	var contextButtonY = floor(y + (toolSprHeight * ((2 * 1.3) + 1)));
	var contextButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var contextButtonRectY1 = floor(contextButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var contextButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var contextButtonRectY2 = floor(contextButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverContext = point_in_rectangle(mouse_x, mouse_y, contextButtonRectX1, contextButtonRectY1, contextButtonRectX2, contextButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverContext || contextFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(contextButtonRectX1, contextButtonRectY1, contextButtonRectX2, contextButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverContext) {
		scr_createTooltip(contextButtonRectX1, contextButtonY, scr_get_translation("menu_filter-context"), global.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var contextOptionList = ds_list_create();
			ds_list_add(contextOptionList, "menu_above", "menu_between", "menu_below");
			scr_createFlyout(contextButtonRectX1 - flyoutXBuffer, contextButtonY, contextOptionList, global.optionListTypeContext, spr_contextOptions, true);
		}
	}
	
	// draw highlight rect
	if (obj_control.filterGridActive || obj_control.quickFilterGridActive) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(contextButtonRectX1, contextButtonRectY1, contextButtonRectX2, contextButtonRectY2, false);
	}
	
	if (obj_panelPane.functionFilter_peek[0]) draw_sprite_ext(spr_contextTool, 1, toolButtonX, contextButtonY, toolSprScale, toolSprScale, 0, filterButtonColor, 1);
	if (obj_panelPane.functionFilter_peek[1]) draw_sprite_ext(spr_contextTool, 2, toolButtonX, contextButtonY, toolSprScale, toolSprScale, 0, filterButtonColor, 1);
	if (obj_panelPane.functionFilter_peek[2]) draw_sprite_ext(spr_contextTool, 3, toolButtonX, contextButtonY, toolSprScale, toolSprScale, 0, filterButtonColor, 1);
	
	// draw context sprite
	draw_sprite_ext(spr_contextTool, 0, toolButtonX, contextButtonY, toolSprScale, toolSprScale, 0, filterButtonColor, 1);

	
	
	// justify button
	var justifyButtonY = floor(y + (toolSprHeight * ((3 * 1.3) + 1)));
	var justifyButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var justifyButtonRectY1 = floor(justifyButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var justifyButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var justifyButtonRectY2 = floor(justifyButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverJustify = point_in_rectangle(mouse_x, mouse_y, justifyButtonRectX1, justifyButtonRectY1, justifyButtonRectX2, justifyButtonRectY2) && !mouseoverCancel;
	var justifyImageIndex = 0;
	if (obj_control.justify == obj_control.justifyLeft && obj_control.shape == obj_control.shapeText) justifyImageIndex = 0;
	else if (obj_control.justify == obj_control.justifyLeft && obj_control.shape == obj_control.shapeBlock) justifyImageIndex = 1;
	else if (obj_control.justify == obj_control.justifyCenter && obj_control.shape == obj_control.shapeText) justifyImageIndex = 2;
	else if (obj_control.justify == obj_control.justifyCenter && obj_control.shape == obj_control.shapeBlock) justifyImageIndex = 3;
	else if (obj_control.justify == obj_control.justifyRight && obj_control.shape == obj_control.shapeText) justifyImageIndex = 4;
	else if (obj_control.justify == obj_control.justifyRight && obj_control.shape == obj_control.shapeBlock) justifyImageIndex = 5;
	
	if (mouseoverJustify || justifyFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(justifyButtonRectX1, justifyButtonRectY1, justifyButtonRectX2, justifyButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverJustify) {
		scr_createTooltip(justifyButtonRectX1, justifyButtonY, scr_get_translation("menu_justify"), global.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var justifyOptionList = ds_list_create();
			ds_list_add(justifyOptionList, "flyout_left-prose", "flyout_left-grid", "flyout_right-prose", "flyout_right-grid");
			scr_createFlyout(justifyButtonRectX1 - flyoutXBuffer, justifyButtonY, justifyOptionList, global.optionListTypeJustifyProse, spr_justifyOptions, false);
		}
	}
	
	// draw justify sprite
	draw_sprite_ext(spr_justifyTool, justifyImageIndex, toolButtonX, justifyButtonY, toolSprScale, toolSprScale, 0, c_white, 1);
	
	
	
	// oneToOne button
	var oneToOneButtonY = floor(y + (toolSprHeight * ((4 * 1.3) + 1)));
	var oneToOneButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var oneToOneButtonRectY1 = floor(oneToOneButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var oneToOneButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var oneToOneButtonRectY2 = floor(oneToOneButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var oneToOneImageIndex = obj_panelPane.chainViewOneToMany;
	if (obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabLine) oneToOneImageIndex = obj_panelPane.chainViewOneToMany;
	
	var mouseoverOneToOne = point_in_rectangle(mouse_x, mouse_y, oneToOneButtonRectX1, oneToOneButtonRectY1, oneToOneButtonRectX2, oneToOneButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverOneToOne || oneToOneFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(oneToOneButtonRectX1, oneToOneButtonRectY1, oneToOneButtonRectX2, oneToOneButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverOneToOne) {
		scr_createTooltip(oneToOneButtonRectX1, oneToOneButtonY, !obj_panelPane.chainViewOneToMany ? scr_get_translation("option_one-to-one") : scr_get_translation("option_one-to-many"), global.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var oneToOneOptionList = ds_list_create();
			ds_list_add(oneToOneOptionList, scr_get_translation("option_one-to-one"), scr_get_translation("option_one-to-many"));
			scr_createFlyout(oneToOneButtonRectX1 - flyoutXBuffer, oneToOneButtonY, oneToOneOptionList, global.optionListType1to1, spr_oneToOneTool, false);
		}
	}
	
	// draw oneToOne sprite
	draw_sprite_ext(spr_oneToOneTool, oneToOneImageIndex, toolButtonX, oneToOneButtonY, toolSprScale, toolSprScale, 0, c_white, 1);
	
	
	
	
	
	
	
	// audio button
	var audioButtonY = floor(y + (toolSprHeight * ((5 * 1.3) + 1)));
	var audioButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var audioButtonRectY1 = floor(audioButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var audioButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var audioButtonRectY2 = floor(audioButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	
	var mouseoverAudio = point_in_rectangle(mouse_x, mouse_y, audioButtonRectX1, audioButtonRectY1, audioButtonRectX2, audioButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverAudio) {
		draw_set_color(c_white);
		scr_drawRectWidth(audioButtonRectX1, audioButtonRectY1, audioButtonRectX2, audioButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverAudio) {
		scr_createTooltip(audioButtonRectX1, audioButtonY, scr_get_translation("menu_media"), global.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			with (obj_audioUI) {
				visible = !visible;
			}
		}
	}
	
	// draw highlight rectangle if audio is on
	if (obj_audioUI.visible) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(audioButtonRectX1, audioButtonRectY1, audioButtonRectX2, audioButtonRectY2, false);
	}
	
	// draw audio sprite
	draw_sprite_ext(spr_audioTool, 0, toolButtonX, audioButtonY, toolSprScale, toolSprScale, 0, obj_audioUI.visible ? global.colorThemeRezPink : c_white, 1);
	
	
	
	
	
	
	// help button
	var helpButtonY = floor(y + (toolSprHeight * ((6 * 1.3) + 1)));
	var helpButtonRectX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var helpButtonRectY1 = floor(helpButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var helpButtonRectX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	var helpButtonRectY2 = floor(helpButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	
	var mouseoverHelp = point_in_rectangle(mouse_x, mouse_y, helpButtonRectX1, helpButtonRectY1, helpButtonRectX2, helpButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverHelp) {
		draw_set_color(c_white);
		scr_drawRectWidth(helpButtonRectX1, helpButtonRectY1, helpButtonRectX2, helpButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverHelp) {
		scr_createTooltip(helpButtonRectX1, helpButtonY, scr_get_translation("menu_help"), global.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var helpCollapsed = obj_panelPane.functionHelp_collapsed;
			with (obj_panelPane) {
				functionHelp_collapsed = !helpCollapsed;
			}
		}
	}
	
	// draw highlight rectangle if help is on
	if (!obj_panelPane.functionHelp_collapsed) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(helpButtonRectX1, helpButtonRectY1, helpButtonRectX2, helpButtonRectY2, false);
	}
	
	// draw help sprite
	draw_sprite_ext(spr_helpTool, 0, toolButtonX, helpButtonY, toolSprScale, toolSprScale, 0, obj_panelPane.functionHelp_collapsed ? c_white : global.colorThemeRezPink, 1);
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


	// Prevent typing in text from changing the tool mode
	if (!obj_control.gridView and !obj_control.dialogueBoxActive and !instance_exists(obj_dropDown) and !instance_exists(obj_dialogueBox) and obj_control.mouseoverTagShortcut == "") {
		if (keyboard_check_pressed(ord("E")) and !global.ctrlHold) {
			currentMode = modeRead;
			//obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabLine;
		}
		if (keyboard_check_pressed(ord("R")) and !global.ctrlHold) {
			currentMode = modeRez;
			//obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabRezBrush;
		}
		if (keyboard_check_pressed(ord("T"))) {
			currentMode = modeTrack;
			//obj_panelPane.functionChainList_currentTab = obj_panelPane.functionChainList_tabTrackBrush;
		}
	}

	
	// clicking on toolpane will deselect chain
	if (device_mouse_check_button_released(0, mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (not obj_control.gridView) {
			with (obj_chain) {
				scr_chainDeselect();
			}
		}
	}

	

}
