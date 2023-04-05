function scr_drawToolPane() {

	var mouseoverCancel = (instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || instance_exists(obj_flyout)) || instance_exists(obj_sizeWindow) || obj_control.gridView;
	var toolSprWidth = sprite_get_width(spr_toolsNew) * toolSpriteScale;
	var toolSprHeight = sprite_get_height(spr_toolsNew) * toolSpriteScale;
	var camHeight = camera_get_view_height(camera_get_active());
	
	var mouseoverRectWidth = 5;
	
	var toolButtonX = floor(x + (windowWidth / 2));
	var toolButtonRectBuffer = toolSprWidth * 0.06;
	var toolButtonRectBuffer = toolSprWidth * 0.06;
	var flyoutXBuffer = mouseoverRectWidth * 2;
	
	
	
	
	// determine whether specific flyouts exist
	var toolFlyoutExists = false;
	var contextFlyoutExists = false;
	var shapeFlyoutExists = false;
	var justifyFlyoutExists = false;
	if (instance_exists(obj_flyout)) {
		toolFlyoutExists = (obj_flyout.optionListType == global.optionListTypeToolButton);
		contextFlyoutExists = (obj_flyout.optionListType == global.optionListTypeContext);
		shapeFlyoutExists = (obj_flyout.optionListType == global.optionListTypeProse);
		justifyFlyoutExists = (obj_flyout.optionListType == global.optionListTypeJustifyProse);
	}

	
	var toolbarButtonX1 = floor(toolButtonX - (toolSprWidth / 2) - toolButtonRectBuffer);
	var toolbarButtonX2 = floor(toolButtonX + (toolSprWidth / 2) + toolButtonRectBuffer);
	
	
	// tool button
	var toolButtonY = floor(y + (toolSprHeight * ((0 * 1.3) + 1)));
	var toolButtonRectY1 = floor(toolButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var toolButtonRectY2 = floor(toolButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverTool = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, toolButtonRectY1, toolbarButtonX2, toolButtonRectY2) && !mouseoverCancel;
	var toolImageIndex = 0;
	if (currentMode == modeRead) toolImageIndex = 0;
	else if (currentMode == modeTrack) toolImageIndex = 1;
	else if (currentMode == modeRez) toolImageIndex = 2;
	
	if (mouseoverTool || toolFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, toolButtonRectY1, toolbarButtonX2, toolButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverTool) {
		scr_createTooltip(toolbarButtonX1, toolButtonY, scr_get_translation("option_tool"), obj_tooltip.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var toolOptionList = ds_list_create();
			ds_list_add(toolOptionList, "help_label_tag", "menu_track", "menu_resonance");
			scr_createFlyout(toolbarButtonX1 - flyoutXBuffer, toolButtonY, toolOptionList, global.optionListTypeToolButton, spr_toolsNew, false);
		}
	}
	
	// draw highlight rect
	draw_set_color(global.colorThemeBG);
	draw_roundrect(toolbarButtonX1, toolButtonRectY1, toolbarButtonX2, toolButtonRectY2, false);
	
	// draw tool sprite
	draw_sprite_ext(spr_toolsNew, toolImageIndex, toolButtonX, toolButtonY, toolSpriteScale, toolSpriteScale, 0, global.colorThemeRezPink, 1);


	
	
	// filter button
	var filterButtonY = floor(y + (toolSprHeight * ((1 * 1.3) + 1)));
	var filterButtonRectY1 = floor(filterButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var filterButtonRectY2 = floor(filterButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverFilter = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, filterButtonRectY1, toolbarButtonX2, filterButtonRectY2) && !mouseoverCancel;
	var filterButtonColor = (obj_control.currentView == obj_control.filterView|| obj_control.currentView == obj_control.quickFilterView) ? global.colorThemeRezPink : c_white;
	var filterList = scr_getFilterList(true);
	var filterListSize = ds_list_size(filterList);
	
	if (filterListSize <= 0 && obj_control.currentView == obj_control.filterView && obj_panelPane.functionChainList_playShowID == "") {
		scr_disableFilter();
	}
	
	// mouseover & click on filter button
	if (mouseoverFilter) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, filterButtonRectY1, toolbarButtonX2, filterButtonRectY2, mouseoverRectWidth , false);
		scr_createTooltip(toolbarButtonX1, filterButtonY, scr_get_translation("menu_filter"), obj_tooltip.arrowFaceRight);
		
		
		if (mouse_check_button_released(mb_left)) {
			scr_toggleFilter();
		}
	}
	
	// draw highlight rectangle if filter is on
	if (obj_control.currentView == obj_control.filterView || obj_control.currentView == obj_control.quickFilterView) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(toolbarButtonX1, filterButtonRectY1, toolbarButtonX2, filterButtonRectY2, false);
	}
	
	// draw filter sprite
	draw_sprite_ext(spr_filterTool, 0, toolButtonX, filterButtonY, toolSpriteScale, toolSpriteScale, 0, filterButtonColor, 1);
	
	
	
	
	// context button
	var contextButtonY = floor(y + (toolSprHeight * ((2 * 1.3) + 1)));
	var contextButtonRectY1 = floor(contextButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var contextButtonRectY2 = floor(contextButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverContext = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, contextButtonRectY1, toolbarButtonX2, contextButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverContext || contextFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, contextButtonRectY1, toolbarButtonX2, contextButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverContext) {
		scr_createTooltip(toolbarButtonX1, contextButtonY, scr_get_translation("menu_filter-context"), obj_tooltip.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var contextOptionList = ds_list_create();
			ds_list_add(contextOptionList, "menu_above", "menu_between", "menu_below");
			scr_createFlyout(toolbarButtonX1 - flyoutXBuffer, contextButtonY, contextOptionList, global.optionListTypeContext, spr_contextOptions, true);
		}
	}
	
	// draw highlight rect
	var anyContextEnabled = obj_panelPane.functionFilter_peek[0] || obj_panelPane.functionFilter_peek[1] || obj_panelPane.functionFilter_peek[2];
	var contextButtonColor = anyContextEnabled ? filterButtonColor : c_white;
	if (anyContextEnabled && (obj_control.currentView == obj_control.filterView || obj_control.currentView == obj_control.quickFilterView)) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(toolbarButtonX1, contextButtonRectY1, toolbarButtonX2, contextButtonRectY2, false);
	}
	
	if (obj_panelPane.functionFilter_peek[0]) draw_sprite_ext(spr_contextTool, 1, toolButtonX, contextButtonY, toolSpriteScale, toolSpriteScale, 0, contextButtonColor, 1);
	if (obj_panelPane.functionFilter_peek[1]) draw_sprite_ext(spr_contextTool, 2, toolButtonX, contextButtonY, toolSpriteScale, toolSpriteScale, 0, contextButtonColor, 1);
	if (obj_panelPane.functionFilter_peek[2]) draw_sprite_ext(spr_contextTool, 3, toolButtonX, contextButtonY, toolSpriteScale, toolSpriteScale, 0, contextButtonColor, 1);
	
	// draw context sprite
	draw_sprite_ext(spr_contextTool, 0, toolButtonX, contextButtonY, toolSpriteScale, toolSpriteScale, 0, contextButtonColor, 1);

	
	
	// justify button
	var justifyButtonY = floor(y + (toolSprHeight * ((3 * 1.3) + 1)));
	var justifyButtonRectY1 = floor(justifyButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var justifyButtonRectY2 = floor(justifyButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverJustify = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, justifyButtonRectY1, toolbarButtonX2, justifyButtonRectY2) && !mouseoverCancel;
	var justifyImageIndex = 0;
	if (obj_control.justify == obj_control.justifyLeft && obj_control.shape == obj_control.shapeText) justifyImageIndex = 0;
	else if (obj_control.justify == obj_control.justifyLeft && obj_control.shape == obj_control.shapeBlock) justifyImageIndex = 1;
	else if (obj_control.justify == obj_control.justifyCenter && obj_control.shape == obj_control.shapeText) justifyImageIndex = 2;
	else if (obj_control.justify == obj_control.justifyCenter && obj_control.shape == obj_control.shapeBlock) justifyImageIndex = 3;
	else if (obj_control.justify == obj_control.justifyRight && obj_control.shape == obj_control.shapeText) justifyImageIndex = 4;
	else if (obj_control.justify == obj_control.justifyRight && obj_control.shape == obj_control.shapeBlock) justifyImageIndex = 5;
	
	if (mouseoverJustify || justifyFlyoutExists) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, justifyButtonRectY1, toolbarButtonX2, justifyButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverJustify) {
		scr_createTooltip(toolbarButtonX1, justifyButtonY, scr_get_translation("menu_justify"), obj_tooltip.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var justifyOptionList = ds_list_create();
			ds_list_add(justifyOptionList, "flyout_left-prose", "flyout_left-grid", "flyout_right-prose", "flyout_right-grid");
			scr_createFlyout(toolbarButtonX1 - flyoutXBuffer, justifyButtonY, justifyOptionList, global.optionListTypeJustifyProse, spr_justifyOptions, false);
		}
	}
	
	// draw justify sprite
	draw_sprite_ext(spr_justifyTool, justifyImageIndex, toolButtonX, justifyButtonY, toolSpriteScale, toolSpriteScale, 0, c_white, 1);
	
	
	
	// oneToOne button
	var oneToOneButtonY = floor(y + (toolSprHeight * ((4 * 1.3) + 1)));
	var oneToOneButtonRectY1 = floor(oneToOneButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var oneToOneButtonRectY2 = floor(oneToOneButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var oneToOneImageIndex = obj_panelPane.chainViewOneToMany;
	if (obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabLine) oneToOneImageIndex = obj_panelPane.chainViewOneToMany;
	var mouseoverOneToOne = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, oneToOneButtonRectY1, toolbarButtonX2, oneToOneButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverOneToOne) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, oneToOneButtonRectY1, toolbarButtonX2, oneToOneButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverOneToOne) {
		scr_createTooltip(toolbarButtonX1, oneToOneButtonY, !obj_panelPane.chainViewOneToMany ? scr_get_translation("option_one-to-one") : scr_get_translation("option_one-to-many"), obj_tooltip.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			var current1ToMany = obj_panelPane.chainViewOneToMany;
			with (obj_panelPane) chainViewOneToMany = !current1ToMany;
		}
	}
	
	// draw oneToOne sprite
	draw_sprite_ext(spr_oneToOneTool, oneToOneImageIndex, toolButtonX, oneToOneButtonY, toolSpriteScale, toolSpriteScale, 0, c_white, 1);
	
	
	
	
	
	
	
	// audio button
	var audioButtonY = floor(y + (toolSprHeight * ((5 * 1.3) + 1)));
	var audioButtonRectY1 = floor(audioButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var audioButtonRectY2 = floor(audioButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverAudio = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, audioButtonRectY1, toolbarButtonX2, audioButtonRectY2) && BUILDTYPE != "Web" && !mouseoverCancel;
	
	if (mouseoverAudio) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, audioButtonRectY1, toolbarButtonX2, audioButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverAudio) {
		scr_createTooltip(toolbarButtonX1, audioButtonY, scr_get_translation("menu_media"), obj_tooltip.arrowFaceRight);
		
		if (mouse_check_button_released(mb_left)) {
			with (obj_audioUI) {
				visible = !visible;
			}
		}
	}
	
	// draw highlight rectangle if audio is on
	if (obj_audioUI.visible) {
		draw_set_color(global.colorThemeBG);
		draw_roundrect(toolbarButtonX1, audioButtonRectY1, toolbarButtonX2, audioButtonRectY2, false);
	}
	
	// draw audio sprite
	draw_sprite_ext(spr_audioTool, 0, toolButtonX, audioButtonY, toolSpriteScale, toolSpriteScale, 0, obj_audioUI.visible ? global.colorThemeRezPink : c_white, BUILDTYPE == "Web" ? 0.5 : 1);
	
	
	
	
	
	
	// help button
	var helpButtonY = floor(y + (toolSprHeight * ((6 * 1.3) + 1)));
	var helpButtonRectY1 = floor(helpButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var helpButtonRectY2 = floor(helpButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverHelp = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, helpButtonRectY1, toolbarButtonX2, helpButtonRectY2) && !mouseoverCancel;
	
	if (mouseoverHelp) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, helpButtonRectY1, toolbarButtonX2, helpButtonRectY2, mouseoverRectWidth , false);
	}
	
	if (mouseoverHelp) {
		scr_createTooltip(toolbarButtonX1, helpButtonY, scr_get_translation("menu_help"), obj_tooltip.arrowFaceRight);
		
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
		draw_roundrect(toolbarButtonX1, helpButtonRectY1, toolbarButtonX2, helpButtonRectY2, false);
	}
	
	// draw help sprite
	draw_sprite_ext(spr_helpTool, 0, toolButtonX, helpButtonY, toolSpriteScale, toolSpriteScale, 0, obj_panelPane.functionHelp_collapsed ? c_white : global.colorThemeRezPink, 1);
	
	
	
	
	
	
	
	
	
	

	
	
	
	
	
	
	


	// Prevent typing in text from changing the tool mode
	if (!obj_control.gridView and !obj_control.dialogueBoxActive and !instance_exists(obj_dropDown) and !instance_exists(obj_dialogueBox) and obj_control.mouseoverTagShortcut == "") {
		if (keyboard_check_pressed(ord("E")) and !global.ctrlHold && obj_control.shortcutsEnabled) {
			currentMode = modeRead;
		}
		if (keyboard_check_pressed(ord("R")) and !global.ctrlHold && obj_control.shortcutsEnabled) {
			currentMode = modeRez;
		}
		if (keyboard_check_pressed(ord("T")) && obj_control.shortcutsEnabled) {
			currentMode = modeTrack;
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



	// home button
	var homeButtonY = floor(camHeight - (toolSprHeight * 1.75));
	var homeButtonRectY1 = floor(homeButtonY - (toolSprHeight / 2) - toolButtonRectBuffer);
	var homeButtonRectY2 = floor(homeButtonY + (toolSprHeight / 2) + toolButtonRectBuffer);
	var mouseoverHome = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, homeButtonRectY1, toolbarButtonX2, homeButtonRectY2) && !mouseoverCancel;
	var inHomeView = obj_control.currentView == obj_control.mainView;
	draw_sprite_ext(spr_home, toolImageIndex, toolButtonX, homeButtonY, toolSpriteScale, toolSpriteScale, 0, c_white, inHomeView ? 0.5 : 1);
	if (mouseoverHome && !inHomeView) {
		draw_set_color(c_white);
		scr_drawRectWidth(toolbarButtonX1, homeButtonRectY1, toolbarButtonX2, homeButtonRectY2, mouseoverRectWidth , false);
	}
	if (mouseoverHome) {
		scr_createTooltip(toolbarButtonX1, homeButtonY, scr_get_translation("menu_home"), obj_tooltip.arrowFaceRight);
		if (mouse_check_button_released(mb_left) && !inHomeView) {
			if (obj_control.currentView != obj_control.mainView) {
				obj_control.currentView = obj_control.mainView;
				scr_disableFilter();
			}
		}
	}
	
	
	// draw text for which view you are in
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	var strHeight = string_height("0");
	var viewTextY = floor(mean(camHeight, homeButtonRectY2));
	var mouseoverViewText = point_in_rectangle(mouse_x, mouse_y, toolbarButtonX1, viewTextY - (strHeight * 0.75), toolbarButtonX2, viewTextY + (strHeight * 0.75));
	if (mouseoverViewText) scr_createTooltip(toolbarButtonX1, viewTextY, scr_get_translation("help_label_view-select"), obj_tooltip.arrowFaceRight);
	draw_text(floor(mean(toolbarButtonX1, toolbarButtonX2)), viewTextY, scr_get_translation(obj_control.currentView));
	
}
